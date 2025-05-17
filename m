Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0D3C2D0CD
	for <u-boot@archiver.kernel.org>; Sat, 17 May 2025 21:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7A8808AF;
	Sat, 17 May 2025 23:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="RhHHdKgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48CB3808AF; Sat, 17 May 2025 22:09:41 +0200 (CEST)
Received: from 6.mo564.mail-out.ovh.net (6.mo564.mail-out.ovh.net
 [46.105.45.245])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE99F8004F
 for <u-boot@lists.denx.de>; Sat, 17 May 2025 22:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dev@benjarobin.fr
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net [51.68.80.175])
 by mo564.mail-out.ovh.net (Postfix) with ESMTPS id 4b0FR60rL4z11Sr;
 Sat, 17 May 2025 20:09:38 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net
 (director1.derp.mail-out.ovh.net. [127.0.0.1])
 by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <dev@benjarobin.fr>; Sat, 17 May 2025 20:09:37 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.96.172])
 by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4b0FR55Khmz61pS; Sat, 17 May 2025 20:09:37 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.1])
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 208F6D43EB7; 
 Sat, 17 May 2025 20:09:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0064e3e2359-ce07-445b-a9c7-8783b46705cc,
 86EF0E811C9DA5614D3A4E98D436F1C38B5C043D) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp: 86.194.82.154
From: Benjamin ROBIN <dev@benjarobin.fr>
To: u-boot@lists.denx.de
Cc: jerome.forissier@linaro.org, joe.hershberger@ni.com,
 Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH] env: Fix network support when CONFIG_NET_LWIP is set
Date: Sat, 17 May 2025 22:09:30 +0200
Message-ID: <20250517200930.78975-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 17077931265412971337
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudeiheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnjhgrmhhinhcutffquefkpfcuoeguvghvsegsvghnjhgrrhhosghinhdrfhhrqeenucggtffrrghtthgvrhhnpeehhffgjeekhfeljeetueektdetudfhheefuefhkeejgfeihfejfeeuveeigeetudenucfkphepuddvjedrtddrtddruddpkeeirdduleegrdekvddrudehgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohepgedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepjhgvrhhomhgvrdhfohhrihhsshhivghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehjohgvrdhhvghrshhhsggvrhhgvghrsehnihdrtghomhdpoffvtefjohhsthepmhhoheeigegmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=MjKC0d7UnCdwMTM5BYtvhrt6Eo5a382q+Eg4JuRwBEM=; 
 c=relaxed/relaxed; d=benjarobin.fr; h=From;
 s=ovhmo1728415-selector1; t=1747512578; v=1;
 b=RhHHdKgv3HVOrkeRZ6ymxUZkGrHSwCPOLkaHBfBv3HD5PZaRKdQh9eqFQ61Ghu/z/Boxp4ka
 X5gbWJ3TbPIhyKrYqaFampIXhIP080oJM3sQZ/wMgrlh6D3/87bSJ6GAMRlxpylWtg0sP4qauam
 fwKId4BmyizwEUMtnwLmaF0geKko+ieEw91M5DUNb0Ke9h2OC+5ZMQPuZCx1jm/3T5VwuBY7pI3
 t0qVxTCwQTYpTF8b7Sj+N5ouxFiJrTfrOeNyoQyCxKz68hgrNCxjdB0Cmncm5NGvt9j+sDAoZ8j
 8sRhbwNBBBM2HMLaSNcVBEDJpNyeu441iOj+ztpNLc1uw==
X-Mailman-Approved-At: Sat, 17 May 2025 23:22:11 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When lwIP (CONFIG_NET_LWIP) is used instead of legacy stack (CONFIG_NET),
environment flags support associated with network was not built: restore
support of "i" and "m" environment flags.

Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
---
 env/flags.c            | 10 +++++-----
 include/env_callback.h |  2 +-
 include/env_flags.h    |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/env/flags.c b/env/flags.c
index 233fd460d842..f734fda50c27 100644
--- a/env/flags.c
+++ b/env/flags.c
@@ -22,7 +22,7 @@
 #include <env_internal.h>
 #endif
 
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 #define ENV_FLAGS_NET_VARTYPE_REPS "im"
 #else
 #define ENV_FLAGS_NET_VARTYPE_REPS ""
@@ -57,7 +57,7 @@ static const char * const env_flags_vartype_names[] = {
 	"decimal",
 	"hexadecimal",
 	"boolean",
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 	"IP address",
 	"MAC address",
 #endif
@@ -211,7 +211,7 @@ static void skip_num(int hex, const char *value, const char **end,
 		*end = value;
 }
 
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 int eth_validate_ethaddr_str(const char *addr)
 {
 	const char *end;
@@ -244,7 +244,7 @@ static int _env_flags_validate_type(const char *value,
 	enum env_flags_vartype type)
 {
 	const char *end;
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 	const char *cur;
 	int i;
 #endif
@@ -273,7 +273,7 @@ static int _env_flags_validate_type(const char *value,
 		if (value[1] != '\0')
 			return -1;
 		break;
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 	case env_flags_vartype_ipaddr:
 		cur = value;
 		for (i = 0; i < 4; i++) {
diff --git a/include/env_callback.h b/include/env_callback.h
index 47a31f6cf52a..918ccb3b14f4 100644
--- a/include/env_callback.h
+++ b/include/env_callback.h
@@ -32,7 +32,7 @@
 #define DNS_CALLBACK
 #endif
 
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 #define NET_CALLBACKS \
 	"bootfile:bootfile," \
 	"ipaddr:ipaddr," \
diff --git a/include/env_flags.h b/include/env_flags.h
index 2476043b0e38..92c7ea8529a3 100644
--- a/include/env_flags.h
+++ b/include/env_flags.h
@@ -14,7 +14,7 @@ enum env_flags_vartype {
 	env_flags_vartype_decimal,
 	env_flags_vartype_hex,
 	env_flags_vartype_bool,
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 	env_flags_vartype_ipaddr,
 	env_flags_vartype_macaddr,
 #endif
@@ -41,7 +41,7 @@ enum env_flags_varaccess {
 #define CFG_ENV_FLAGS_LIST_STATIC ""
 #endif
 
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 #ifdef CONFIG_REGEX
 #define ETHADDR_WILDCARD "\\d*"
 #else
@@ -123,7 +123,7 @@ enum env_flags_varaccess env_flags_parse_varaccess(const char *flags);
  */
 enum env_flags_varaccess env_flags_parse_varaccess_from_binflags(int binflags);
 
-#ifdef CONFIG_NET
+#if CONFIG_IS_ENABLED(NET) || CONFIG_IS_ENABLED(NET_LWIP)
 /*
  * Check if a string has the format of an Ethernet MAC address
  */
-- 
2.49.0

