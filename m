Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD3606A32F
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k2n7ve0C;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=CowSP/wR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 27E7180F1C;
	Sun, 15 Nov 2026 19:00:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWU-NgCTdBLP; Sun, 15 Nov 2026 19:00:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D0FB80F27
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769242;
	b=GKEX9J8v5TdDBnerGMC8Rfa3qhVh6TwU0yZf+xp3cmQl8QoicHAID9DD8SVf/fz0QUA1
	 h9/08V/d7ydhnILmOVmHpBNGLbXk9OTmTF8fHn5/Av8v8TAvMmHPHGxPC/isHxpJw+3af
	 MZLeKZIaJ+4ItSJXe5f0MJk7ZsqVDBcuOZI3kGD5EX4yvvYGbFrmM3ebdJNDC6XX5Ml2M
	 clxqDxr+gAxBscvrWmeox8kQUp7SSBJ+vosOifNx9GkOiYeJfPNwa61pJo8NM39sWWujt
	 EE7tIpNfo5NYtqjAAsoCyAfz7OVTEvZSNbYqFZGocPudCoywqtnN0xhoJYd+ZKDdcYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GkecpQ8Yss3bfjrjtZlOJM03c/sKdOPll1FpeEsl9dQ=;
	b=MBEHypLUNG+fx2ei1oInnYiM2sOjNeaNSbeFlLteYcvsA6+IcmkL0YJEC3df6Ok1HPeq
	 HIRxz9RuENmH0Elqn6BxGyFgrS8nMkArrRfcrNqss27T9sJlSrboRw6SrcmRQO/pBo86G
	 bKJ2J4oghf7iFI2val2FctVSGDqWIm7nMqgocAN6Tnd+0mWf9Fk5ga7iHLwozyDo0HA/T
	 mzMuMrKwCF43dbrdr+fktpkkRX5UArwEGlGt1MT7L8SYKjlN2KvuUk3HHIpEIsIpq2fy6
	 dOJ8XlPrvPMgcJfa503B3cVSARvzOUsY1z1NW2PW2HKRo7pvdsEcYzJLGseKeZQQEEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769242;
	bh=GkecpQ8Yss3bfjrjtZlOJM03c/sKdOPll1FpeEsl9dQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=k2n7ve0CmxA+DDH2e4OGTTb0Ak/TZdC8DeMJyDSvuFyqFUCtMuoGbR1M594Y4kT8U
	 WjR/87uKWUJhoKKxt5VusvFZJH11ldTO3z+v4b+fTfboJ9g0EqKFY3CJihxAj1clTf
	 sqbrmXCPqEnvTAF9Gxf+VZenUfkVPTF6NlUVITXwXKpRuHofJ/DOEvJziBzDLxmQtt
	 ekuPAO0MIZJSeHVLtPw8djNNCxZjQHlygvmtu7cKMlFX0560g4/tuVAW4PP7nLlrs4
	 pP6+zXDs05qDMp+fp3mD6/NjJkOpEakJ4ipmFRjCMbPnzOjtKG20ML32JuHaqaSMnn
	 XPqkWfg2WFHsw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D0FB80F27;
	Sun, 15 Nov 2026 19:00:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8AB682E5
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 711BB406D4
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2905SXTquLDu for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 17:12:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9345840637
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::e32"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::e32; helo=mail-vs1-xe32.google.com;
 envelope-from=georgekola@google.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=CowSP/wR
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com
 [IPv6:2607:f8b0:4864:20::e32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9345840637
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 17:12:22 +0000 (UTC)
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-7d2d1b4a83aso661395137.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 09:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794762741; x=1795367541;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GkecpQ8Yss3bfjrjtZlOJM03c/sKdOPll1FpeEsl9dQ=;
 b=CowSP/wRu8w0Pxy8FlpQxYxOM3TDX4fnSxPPEl/VUXjvUxCvs7ywz+tJFD+9j69XoZ
 hOWlZHxjZdSjPHrqTNM+eoO+TJzAVYkZla8/6P8Q9wHOoeB4mxsaNZ1Cmq+O7UVVuh3M
 02beSXoD4zK7CpI8h3kwrPFpHuQG3tWBm4JawZ/JciIGxG8YZSAW5bJDGElfBy6Ve84W
 sx7AW2Rhsony2DiCkMGAWz/JB9vUPi4UPEo4fwwE9GIApoJqvBNKcZBddDxElELmdgUM
 PzxJjXZthGS5fFxSphOs0Iw5cAP9+e0j9NX0iUfdv6LFBiLlvJHKMFdZfDDlxdVox3JV
 9B/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794762741; x=1795367541;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GkecpQ8Yss3bfjrjtZlOJM03c/sKdOPll1FpeEsl9dQ=;
 b=Ew76b3CC6ygVJIlm63r9nhAUz2SXuvQo/NaHDlu29euqZ5OFMqYIO0L3HL+7QhADOZ
 zt2bHYR6RvVc9AbqrSDGHABHM0vf3d2lQBddRBfbxR8At3iE5zfIgZOH3e/XdDmWi388
 h9Zg2IghLlXuTsfwrAdhDEC1V3VRzl7FopN8AgnzwGTVkWupLD4zMSIYmVP/mI4pd3NL
 vaYomk7NHRQ34DIVwaX9r6NqErDoCYIR4gWoMCUlybMGs/e6dMA5qmhPK6CIcxx9og39
 r9dDMX/6p5ftuymXmTcqerdOzIA/XHVJTapxeKgWE4EVwsPiBLHdViq9UI5ef+wUDiUx
 aQ/g==
X-Gm-Message-State: APuU4Z9524k90EqF92xTmSo6yWMBeIQcdHL9477iQKUT/ayqfkilLEiK
 qcoecNLwDtYaEH+DOGRCDs2N7tKQQ4hwKz19H7sxOL5o6OHIEejyp2//a41YheffxbaaFjYO3gA
 NXOms4OCZuHheOIa5YZTvjZX9Q7pbKf1T5imisb+6Df2iXVqUt8lNhQ==
X-Gm-Gg: AYBFou1FAC8JBtZ0KxYmb8C9mtkFGOBBLMmn4Ob8yUYIS/cYrAFE5/BBC4AKLONmvx4
 22EuBRxhZWSoqBfJce0Be5XaxS76l6sZIOTHyt8c3HDijWnCZ5lyfFSL7foKPB32bpDPYYRbF3I
 qWu2ppItbwr4AACNxEKLXOCs9/xM1lYFjos4HF/669YNtGss/R1evlKXesB6a2bAk9hMEron+42
 rByFwhX14NBCecFxXwtSj8liq8sSHnernti0L5Zv2VqO9zORjVEYip4OCgVQgRCF20MJrDdC56j
 fAheLsqQVRkonSZahcbJf/tVYcVlWs/SRhHZ8c/FK7QYf7PCuIc9hQeMxwhDBjqT0z9+4p9V5Fv
 4pjJuAlT8LLgV+4ViaMl0XebVamADsYcvzSvSxifO0htHJJ6lkEdYsuj//cIocISynw==
X-Received: by 2002:a05:6102:441a:b0:7c3:873c:b3fa with SMTP id
 ada2fe7eead31-7d64d49a211mr2410350137.4.1794762740545; Sun, 15 Nov 2026
 09:12:20 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 15 Nov 2026 09:12:20 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: George Kola <georgekola@google.com>
Date: Sun, 15 Nov 2026 09:12:19 -0800
X-Gm-Features: AclHuK8tToVZKFSaQg76Y_UPqSm2Ehn5M7eFRCwk0F2RI4hBypm2TH4gprMUbts
Message-ID: <CAOTQ16+bNoyuFm9kF97-Z3-vpbj77qUGfSZvDxkAXbnhKP2FDg@mail.gmail.com>
Subject: [PATCH] net: lwip: shell: reject out-of-range connection IDs
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The lwIP contrib shell commands clos, acpt, send, recv, and usnd parse
the connection index with strtol() and only check i > NCONNS, allowing
negative indices and i == NCONNS to index conns[] out of bounds.

Add parse_conn_id() to reject empty, non-numeric, negative, and
>= NCONNS connection identifiers across all five handlers.

Fixes: f3f86fd1fe0f ("Squashed 'lib/lwip/lwip/' content from commit
0a0452b2c39b")
Signed-off-by: George Kola <georgekola@google.com>
---
Note: lib/lwip/lwip is synced from upstream lwIP via
tools/update-subtree.sh; 2-space indentation is preserved to match
the surrounding upstream lwIP file style.

 lib/lwip/lwip/contrib/apps/shell/shell.c | 54 +++++++++++++++---------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/lib/lwip/lwip/contrib/apps/shell/shell.c
b/lib/lwip/lwip/contrib/apps/shell/shell.c
index f4f668d712..356dbc9b04 100644
--- a/lib/lwip/lwip/contrib/apps/shell/shell.c
+++ b/lib/lwip/lwip/contrib/apps/shell/shell.c
@@ -185,6 +185,28 @@ sendstr(const char *str, struct netconn *conn)
 {
   netconn_write(conn, (const void *)str, strlen(str), NETCONN_NOCOPY);
 }
+
+static int
+parse_conn_id(const char *arg, struct netconn *conn)
+{
+  char *endptr;
+  long id;
+
+  if (arg == NULL || *arg < '0' || *arg > '9') {
+    sendstr("Invalid connection identifier."NEWLINE, conn);
+    return -1;
+  }
+  id = strtol(arg, &endptr, 10);
+  if (endptr == arg || *endptr != '\0' || id < 0) {
+    sendstr("Invalid connection identifier."NEWLINE, conn);
+    return -1;
+  }
+  if (id >= NCONNS) {
+    sendstr("Connection identifier too high."NEWLINE, conn);
+    return -1;
+  }
+  return (int)id;
+}
 /*-----------------------------------------------------------------------------------*/
 static s8_t
 com_open(struct command *com)
@@ -322,10 +344,8 @@ com_clos(struct command *com)
   int i;
   err_t err;

-  i = strtol(com->args[0], NULL, 10);
-
-  if (i > NCONNS) {
-    sendstr("Connection identifier too high."NEWLINE, com->conn);
+  i = parse_conn_id(com->args[0], com->conn);
+  if (i < 0) {
     return ESUCCESS;
   }
   if (conns[i] == NULL) {
@@ -365,10 +385,8 @@ com_acpt(struct command *com)
     return ESUCCESS;
   }

-  i = strtol(com->args[0], NULL, 10);
-
-  if (i > NCONNS) {
-    sendstr("Connection identifier too high."NEWLINE, com->conn);
+  i = parse_conn_id(com->args[0], com->conn);
+  if (i < 0) {
     return ESUCCESS;
   }
   if (conns[i] == NULL) {
@@ -495,10 +513,8 @@ com_send(struct command *com)
   err_t err;
   size_t len;

-  i = strtol(com->args[0], NULL, 10);
-
-  if (i > NCONNS) {
-    sendstr("Connection identifier too high."NEWLINE, com->conn);
+  i = parse_conn_id(com->args[0], com->conn);
+  if (i < 0) {
     return ESUCCESS;
   }

@@ -536,10 +552,8 @@ com_recv(struct command *com)
   struct netbuf *buf;
   u16_t len;

-  i = strtol(com->args[0], NULL, 10);
-
-  if (i > NCONNS) {
-    sendstr("Connection identifier too high."NEWLINE, com->conn);
+  i = parse_conn_id(com->args[0], com->conn);
+  if (i < 0) {
     return ESUCCESS;
   }

@@ -915,17 +929,15 @@ com_udpb(struct command *com)
 static s8_t
 com_usnd(struct command *com)
 {
-  long i;
+  int i;
   err_t err;
   struct netbuf *buf;
   char *mem;
   u16_t len;
   size_t tmp;

-  i = strtol(com->args[0], NULL, 10);
-
-  if (i > NCONNS) {
-    sendstr("Connection identifier too high."NEWLINE, com->conn);
+  i = parse_conn_id(com->args[0], com->conn);
+  if (i < 0) {
     return ESUCCESS;
   }

-- 
2.56.0.611.g1030f0b940-goog
