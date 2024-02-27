Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52901C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 16:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD27488042;
	Tue, 27 Feb 2024 17:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mDMA/3hs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kKczPc4F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FB088028; Tue, 27 Feb 2024 17:10:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 460438800E
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 17:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TkjBJ0P29z9snc;
 Tue, 27 Feb 2024 17:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0HMV1Zm3QI7vRGR0vhF635UJd4sbG3w2lqzD6eJUQE=;
 b=mDMA/3hsjGGkh9yx+6x/GTZx88mS16uIdb/NjGXt8oi5tF69Ozcz+F9sNpfOL/Z9VuHzKE
 euoosbzS4uHqyxRco7ykwAAlsg8hxyjKiYRw9jFwtx/LvUjn6YthO7bRZJlWdbkW3jC0St
 BvdpCQN1MZKTvrv9letdkLwdXgvOYPnEDlO2bNhkreR+lhT6LzCzUfXHhcbY3Q6e3IxI/c
 F0XbNZYCokhc9X7h+c7CcCU5aZAFsmJdjTlKRXgkpCxp9v2u0HJGVdeaMIpxuWL9tn7ICc
 yajnX1bF7fAbyG3pnE7TEv2A7FjW+1cMtDB+sPAlEP0dAiv3TLMTQtDNkkVcAQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1709050214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0HMV1Zm3QI7vRGR0vhF635UJd4sbG3w2lqzD6eJUQE=;
 b=kKczPc4F3N1MtS/Ji4k9kFCG/e+zrrTlqZAsWq7xSY7OmvwVHcX0LY2LezHdIIS2iqRtXr
 9oKnzw/5OqFD9z35F/spolnW/iPkK/YCcEie3JlIiSFNvdfK0QnzRH+bxKkx9Nd5VAwLQ5
 CMz6uEIszb3FmxOMO/vx8gYuuQ+Tw76KC2/Zfjs2PJBdwegJXzaMwIP0g53hDPB41Me0Fg
 cFfbA6JbfkYDMcnXkPYNS1gUGgm2juntzefHTvEwxrABnS3Yof6GK33OomNDEGdzPZQutH
 SD1qrAaBduazygDmBtpBNkQGFq9ay4/ys9B3mFQGcPPMSZKnUyH0my0Z1j9FRA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/19] ARM: renesas: Rename rmobile_cpuinfo[] to
 renesas_cpuinfo[]
Date: Tue, 27 Feb 2024 17:05:49 +0100
Message-ID: <20240227160912.412181-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
References: <20240227160912.412181-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: r3rh5hxegshyp9tstdhs1cbqjk3uhry1
X-MBO-RS-ID: c0b869d3109bd6379f4
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

Rename rmobile_cpuinfo[] to renesas_cpuinfo[] because all
the chips are made by Renesas, while only a subset of them
is from the R-Mobile line.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-rmobile/cpu_info.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rmobile/cpu_info.c b/arch/arm/mach-rmobile/cpu_info.c
index 3790ffd0a81..66ac6b3fcfb 100644
--- a/arch/arm/mach-rmobile/cpu_info.c
+++ b/arch/arm/mach-rmobile/cpu_info.c
@@ -61,7 +61,7 @@ u32 renesas_get_cpu_rev_fraction(void)
 static const struct {
 	u16 cpu_type;
 	u8 cpu_name[10];
-} rmobile_cpuinfo[] = {
+} renesas_cpuinfo[] = {
 	{ RENESAS_CPU_TYPE_R8A7790, "R8A7790" },
 	{ RENESAS_CPU_TYPE_R8A7791, "R8A7791" },
 	{ RENESAS_CPU_TYPE_R8A7792, "R8A7792" },
@@ -86,19 +86,19 @@ static int renesas_cpuinfo_idx(void)
 	u32 cpu_type = renesas_get_cpu_type();
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(rmobile_cpuinfo) - 1; i++)
-		if (rmobile_cpuinfo[i].cpu_type == cpu_type)
+	for (i = 0; i < ARRAY_SIZE(renesas_cpuinfo) - 1; i++)
+		if (renesas_cpuinfo[i].cpu_type == cpu_type)
 			return i;
 
 	/* Unknown "CPU" entry */
-	return ARRAY_SIZE(rmobile_cpuinfo) - 1;
+	return ARRAY_SIZE(renesas_cpuinfo) - 1;
 }
 
 static const u8 *get_cpu_name(int idx)
 {
 	const  u8 *cpu_name = rzg_get_cpu_name();
 
-	return cpu_name ? cpu_name : rmobile_cpuinfo[idx].cpu_name;
+	return cpu_name ? cpu_name : renesas_cpuinfo[idx].cpu_name;
 }
 
 #ifdef CONFIG_ARCH_MISC_INIT
@@ -121,7 +121,7 @@ int print_cpuinfo(void)
 {
 	int i = renesas_cpuinfo_idx();
 
-	if (rmobile_cpuinfo[i].cpu_type == RENESAS_CPU_TYPE_R8A7796 &&
+	if (renesas_cpuinfo[i].cpu_type == RENESAS_CPU_TYPE_R8A7796 &&
 	    renesas_get_cpu_rev_integer() == 1 &&
 	    renesas_get_cpu_rev_fraction() == 1) {
 		printf("CPU:   Renesas Electronics %s rev 1.1/1.2\n", get_cpu_name(i));
-- 
2.43.0

