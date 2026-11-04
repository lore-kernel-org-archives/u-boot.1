Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F922606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 07:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u8PpM87N;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtdqcgrQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0CB6C40640;
	Wed,  4 Nov 2026 07:18:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8CmxGnXRr14m; Wed,  4 Nov 2026 07:18:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 23BF44062F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793776699;
	b=lZ3vEb60FqNmPFLtwXKsXvOM1JayZADnMhaTm9oIrvpxAcbj+AWC9fufTInLVREkkJ/0
	 yLmpJCbAS7NKMYNJT0+/Zg9K/mh7K0OsAvfYyl5wwZDweb8z7EQJACtZsSF6XfXF8jEwy
	 fi/5igQnKzBRW6fRJ9Ew6Y8aKTRKAyA7YcdzntJ+ME7vTGZYcjrhi7pA0UKpZ/ayWcuO+
	 1o5n3pQBOUAQST6wrcget/ziC0bBMwb1+ZMtM04TwbS2atvBk4YUJJVwRBBERUqdHpi4T
	 44wJCwfXhh95y4/4gZHa1WmgDVQOnU/Ebu1uI3KYoZuZIKRrc/rnLy3eRxm3mTp6rHg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776699;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/ESRidrzIw26n9TQMjGaRT608jyQpdby1hHXp9lOl5w=;
	b=DF2Ld+7iG+gsypVvmRFUdYCKOqPezaA8lLJv/21RJ4C6XtLP55sSPuGvhgsG5YK8k1Mm
	 o5wL+rGZ+51EVhzEFsOnxO4squGVKRthrabm4SPHyzsydcZRQIgOL8DyEF4oPiTV/oGG2
	 P/K/0vIEf8P864CUH8JzRBO2FuTv/FoX8Sd00DlP6src22dm8pN//QjO5tgA6KmTRosOl
	 1XOejqIr9JbVbrv1MiQPo7qB8MVDC1FmKcDVWiFx+9aH/Vf46zj2Dp17coW8TIsDRXn66
	 LtdVZGpdZP9/gKtuaZWe6eoey3yp53m+J8mUJdk3+vh9U3oZlVTPQNVJ7BCy5yGw5tw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rtdqcgrQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793776699;
	bh=/ESRidrzIw26n9TQMjGaRT608jyQpdby1hHXp9lOl5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u8PpM87NxhGzrPm3wEeAuAjJnUaEZUq7I8L6kBh8DK/FXnZ/IGrYbrTMpCT5JrQ43
	 wn2zUvqnelznY0Ioc9VmQ5Pqob0VnVb4gLbuKLLrSFDYMSKL5mJyY3d7t2PXpGNQrg
	 saircxvM9rJDCngKBvUgWuPwnOk+rO54+r2RngMUjKfmpgBsiaIJyE+X/Nx7UMASK2
	 Cxe9b1WyHypFL6BAJqsc06CCbCRhFYzwfK6KZf2i9LyF5zpf1WLo3Me2c7hCDt1Njj
	 Z3ivKcQQ+nHIXbkrQcH3K5RNtS+VkyA/aPP2Nu5fFYWg25Ol5M9Q+XJfpW63f0rZde
	 cjk1Y84XldbMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 23BF44062F;
	Wed,  4 Nov 2026 07:18:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B4212B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2CC5B40609
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hRV46kgUsL1c for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 07:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 124E64062F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793776697;
 b=GWYUv9Zu5EFYZywMtJsQoKCpbqqamyLwExsZP8k0XdwAczEDEpARtQDOHHZFk4cYFg50
 XXkewqQg1vlljeBUEhn1rXo6p9mAmfadBDYsmTR5Gn2kTutSqWxjkLZmnAV2WAhQMaJlN
 5ckW8xoKrrXNGhmW/go+2tqr/jV2t9qENpyR/R6tc4XfTcIVCI2VdS2WWIEt5dBQGaVtr
 pdyDBdf72uJHiN//FqaL9RpdHru66AmVXp2CQVwGXCXUP8JrMCfDbBISnYV3vL5JWuJve
 HxoCZNkOhINmj3IvzqbsqS4hE9wA5zIrC2oA5RYs4V01/4JuMq6gR2R2r9XIAfUHV1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793776697;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=/ESRidrzIw26n9TQMjGaRT608jyQpdby1hHXp9lOl5w=;
 b=rwO1JqpTbVX08L8JuV7vhT1AgkdM4c6DT72c7LxFUYsZeDzKLViitskzQHa0I5Y9jRJ7
 Nnh7C5NnOqPNvKUODp+nRzIW1pXeiNB57fm7I2YY+fatEcnR4u1yrX/tz2sVB3TloD4mH
 LHcdXYMSTKkXg3j/Kvh/J/hPHO7rwzdAB7VE90gK0rPrEKPCbgxUnYzkDh6ESY+eA4S3P
 WF/vn38ydo2vy9n5VIfgqLXgHO5XI7KAiTj07cERZCBFqrTTQ3OKc+W6VPb88P3+gOfxY
 RC/Kxr/jRVgLT6gsIBBo0nJiqBRM1D2rwJGrACMIe5rhkLQvY6H3hjaOhVQyN27uuEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=rtdqcgrQ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=rtdqcgrQ
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 124E64062F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 07:18:16 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so2449885e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 23:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793776695; x=1794381495;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/ESRidrzIw26n9TQMjGaRT608jyQpdby1hHXp9lOl5w=;
 b=rtdqcgrQgT4shZuCkQ7O81nQr94oq3giQ3QHM9dvqJYY1Sl0EYLXKw2cVKN0xSMOXH
 v0a1uSDpxoHi0dwqHoJgN7oCORt5goOf/vYZMpEGoVDaxj7r7GIU1h5XKKyPTnmAGZ+H
 UOjeQhbydAvDeHEAeTw1Ot+0GGqtNUrBbHKrQsTPtDgeshMTl4JjbAuiB3ewaVmbuWG2
 JLYqr9Kjm2e26H1ZrtyQbiINGUOZCISDzKdTM2S+Sgu5SAKDcWetJctHSe04Ke2FP+Sx
 cl6efE1Tc7VLUAiGJdYRaowTnNQz8MjRJzz7uFZxra886qRur7vr7YxBYp6XfHHQN70Z
 DEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776695; x=1794381495;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/ESRidrzIw26n9TQMjGaRT608jyQpdby1hHXp9lOl5w=;
 b=Fs4hKb2Cf8609bSq6o4S5Tt6kL67cqkTjtwU3L9EEAcBAUNiFIcKALJEy6adYLEAi1
 JMopOKRWsWbyGIb3E934gi/r5zYiO7aP4xTSNVCLMjIJkIORk/1rvwp1BhCk9p1ugApm
 J+KNhP/+lmpVRClDlP80PTErjx9lZgBI4Xx/7sAUMXeF6rNaFE/z2VPlV81oiPyVHaGD
 JwBAH50Yk6K3U0O+2H5N698Xc5MHs8nTzh1rAiVKJcnFg4XBWJGv47uRbayLRCp7HrNk
 6YFQ0l4qLRxsaSUtwm+Hct/r9CU2e8vwVGA7GwnzuZ6p7Zpog0CwsViWxs0Am35iyrYo
 sR6g==
X-Gm-Message-State: APuU4Z//H+BoRCsn5cPOrNHhpuqmuNQdUSZccTCeo+lHqphLakNHMxEx
 +0coE13Y2R0Q5QjM5ORZkiE9FaG6Op9a8EGaTtjXR3LRUnyJF7+o6Ya1Lv/CgGCMf1I=
X-Gm-Gg: AYBFou31PPV7MO5WKqo1XOhzFIL3z9u5QKVjtdQICvvzLd4lcwDObhObbD89x9uchDC
 o2e1Tmkf+arTIaOWB4hXVNkHSVYy2zA1tiHiqVmzNhKoEnlIwaBUq5wvVx9zbgqYomlHF1jgToT
 O6sue7vUtYjkXwXMZbIE4ZgetMWvpik1wU+Ebdoce8LFjDL2JXdauUQMmwX+hbJNetDwKo5z4Dm
 I3R8UqsQYaboK3QMBw6jHoEdAZ29yZ581comE4vNGXZ3pzsM5cFDQYsV4ynHLjLb07Ts8xeP13m
 0NaCzzt2Jh6aF98VD+2IAQcetHl91x5Ht1rqW7tk4jQJY6T8DBsCLLHwDp6YNaFKUZ0Z8s+QNRZ
 PfNo+jngFXYEem9Noicd1ZusYFYd8yIFVF5cHdmQByNLENxILqYx6YbveQkvBaXUxhhsF8uuxpv
 v67G2p+8RnDvEtwxKF15roNd7bvRWTGh2x/ezYIGsFz/W9m7hh8VQrKO1nVGNFwRv87+FJD8c6t
 HqbRnz+QHUm9pI/IYqpdee/RW+8Lzn5XE6uPUg9Hg7sotiSX7tpnVd/cAHmg9NNtT67ufYP0qxV
 Snj9/2wr0a+iqJxGTuEgL0wS4u6r0rU=
X-Received: by 2002:a05:600c:3b02:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4b4a55168c2mr8037645e9.3.1793776694834; 
 Tue, 03 Nov 2026 23:18:14 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm161638055e9.13.2026.11.03.23.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 23:18:14 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Lukasz Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH 5/6] usb: gadget: f_sdp: report a closed part as the boot ROM
 does
Date: Wed, 04 Nov 2026 07:18:13 +0000
Message-ID: <76f24ab2-df43-4951-bdde-399aed2489a9@gmail.com>
In-Reply-To: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
References: <4bdba9dc-0c21-4e33-8f20-2c0a7ebba0d6@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

The SDP gadget implements the serial download protocol of the i.MX boot
ROM, but always reports SDP_SECURITY_OPEN in its HAB security report
(report 3), also on a part whose secure boot is fused closed, where the
ROM reports SDP_SECURITY_CLOSED.

Add sdp_is_closed(), a weak hook that says whether secure boot is
enforced, false by default so that other platforms are unchanged, and
implement it for i.MX:

- HAB parts (i.MX6/7/7ULP/8M): imx_hab_is_enabled(), the secure boot
  fuse minus a field return; a fuse read error counts as closed;
- ELE AHAB parts (i.MX8ULP/9): the OEM closed and OEM locked
  lifecycles, and on i.MX94/95/952 also OEM secure world closed, read
  from the same FSB register as ahab_status.

The SECO AHAB parts (i.MX8QM/QXP) keep the weak default; none of their
in-tree defconfigs enables SDP.

Use it for the security report. The next patch makes the gadget refuse
what the ROM refuses on a closed part.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 arch/arm/mach-imx/ele_ahab.c | 13 +++++++++++++
 arch/arm/mach-imx/hab.c      |  7 +++++++
 drivers/usb/gadget/f_sdp.c   |  7 ++++++-
 include/sdp.h                | 19 +++++++++++++++++++
 4 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index e1284833ac5..abbaf70682d 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -14,6 +14,7 @@
 #include <asm/arch/sys_proto.h>
 #include <console.h>
 #include <cpu_func.h>
+#include <sdp.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -414,6 +415,8 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 #if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94) || IS_ENABLED(CONFIG_IMX952)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
+/* OEM secure world closed, OEM closed, OEM locked */
+#define LC_OEM_CLOSED (0x20 | 0x40 | 0x80)
 static void display_life_cycle(u32 lc)
 {
 	printf("Lifecycle: 0x%08X, ", lc);
@@ -459,6 +462,8 @@ static void display_life_cycle(u32 lc)
 #else
 #define FSB_LC_OFFSET 0x41c
 #define LC_OEM_OPEN 0x8
+/* OEM closed, OEM locked */
+#define LC_OEM_CLOSED (0x20 | 0x100)
 static void display_life_cycle(u32 lc)
 {
 	printf("Lifecycle: 0x%08X, ", lc);
@@ -497,6 +502,14 @@ static void display_life_cycle(u32 lc)
 }
 #endif
 
+/* Secure boot is enforced: the SDP gadget then behaves as the ROM's does */
+bool sdp_is_closed(void)
+{
+	u32 lc = readl(FSB_BASE_ADDR + FSB_LC_OFFSET) & 0x3ff;
+
+	return lc & LC_OEM_CLOSED;
+}
+
 static int confirm_close(void)
 {
 	puts("Warning: Please ensure your sample is in NXP closed state, "
diff --git a/arch/arm/mach-imx/hab.c b/arch/arm/mach-imx/hab.c
index 35c497619d6..78c85081055 100644
--- a/arch/arm/mach-imx/hab.c
+++ b/arch/arm/mach-imx/hab.c
@@ -16,6 +16,7 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/hab.h>
 #include <linux/arm-smccc.h>
+#include <sdp.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -932,6 +933,12 @@ bool imx_hab_is_enabled(void)
 	return is_enabled;
 }
 
+/* Secure boot is enforced: the SDP gadget then behaves as the ROM's does */
+bool sdp_is_closed(void)
+{
+	return imx_hab_is_enabled();
+}
+
 int imx_hab_authenticate_image(uint32_t ddr_start, uint32_t image_size,
 			       uint32_t ivt_offset)
 {
diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index aff69c3a138..8bd8f239766 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -288,6 +288,11 @@ static inline void *sdp_ptr(u32 val)
 	return (void *)(uintptr_t)val;
 }
 
+__weak bool sdp_is_closed(void)
+{
+	return false;
+}
+
 static void sdp_rx_command_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	struct f_sdp *sdp = req->context;
@@ -801,7 +806,7 @@ static int sdp_handle_in_ep(struct spl_image_info *spl_image,
 		debug("Report 3: HAB security\n");
 		data[0] = 3;
 
-		status = SDP_SECURITY_OPEN;
+		status = sdp_is_closed() ? SDP_SECURITY_CLOSED : SDP_SECURITY_OPEN;
 		memcpy(&data[1], &status, 4);
 		sdp_func->in_req->length = 5;
 		usb_ep_queue(sdp_func->in_ep, sdp_func->in_req, 0);
diff --git a/include/sdp.h b/include/sdp.h
index 0a97f28073a..829f20ab4ef 100644
--- a/include/sdp.h
+++ b/include/sdp.h
@@ -9,8 +9,27 @@
 #ifndef __SDP_H_
 #define __SDP_H_
 
+#include <linux/types.h>
+
+struct udevice;
+
 int sdp_init(struct udevice *udc);
 
+/**
+ * sdp_is_closed() - Tell whether secure boot is enforced on this part
+ *
+ * The SDP gadget emulates the i.MX boot ROM's serial download mode. On a
+ * part with secure boot fused (HAB closed, AHAB OEM closed), the ROM refuses
+ * the operations that would bypass the signature chain, and SDP has to do the
+ * same, or it is a way around secure boot on an otherwise locked device.
+ *
+ * The weak default says open; i.MX code overrides it per secure boot
+ * mechanism.
+ *
+ * Return: true if the part is closed, false otherwise
+ */
+bool sdp_is_closed(void);
+
 #ifdef CONFIG_XPL_BUILD
 #include <spl.h>
 
