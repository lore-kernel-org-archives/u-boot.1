Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6BCC79FA1
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 16:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F0CE5405F4;
	Mon,  7 Sep 2026 16:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HAdhsefp2JSv; Mon,  7 Sep 2026 16:20:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DDC7040587
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788798037;
	b=FB4jhLtzUaUrIozAFQ8X1IjMSlU6zXF1P3p6sNmg21B75ifAKDYKT4sPCbM+sf7TWECA
	 JvtyLkgkv2ktvYqazKPLN1Fs6Cw3Dx+u6nJHexqK8DnL5T1qF2BXmBxPoY1SsT0ePUKGq
	 GrbHNJ9nbegopablHhZXSAQ+iy3q/hXaaRKgXOY7e5/8YeAnyr0i4BdZwn9tRo4NEkXxn
	 YUkxRD1MV92p+9wMIq59fZrlzQ1Y1TNs1ssqgz92AKsfJgsR69tfPJiHkc8DC/lAQl6PD
	 nuiIeOFqnEIXZoxBzgEvGccwLbq7AcK+igVt0VJoyKEvHcn6+I0a4mYV7+DFGSW86Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788798037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=46u81iAF8VXYSD8ZHU1f+Px1kcHzSkTHK4EAYZz3OjI=;
	b=Oq1q36he7g4OwftLzlKHMfLmJTP4HNWyA6fbQ+pv7fiWLqCjL0tLIIJ4WPNPN38DDIQK
	 /nb4/YGOXnbHmDB9FCYpnaCEdl0/0uXtI63IBB3cVDeBR688AL35FTxfG9Xeqn8Q1U2kQ
	 5gDGLl+t+0Q+WzbIwLA89tQa/Mxyv9rcFbZ2Zd8SGdweLDBsPizaQCxZSTe2YTrTXXoDp
	 PfPb0P9M4D/YnGE6n9xfufBjMni7dHz25xuMlhyVAZnBWqkTp8DUpgnM6EEr7qn2B37pK
	 CNSHr8Ld+YNXON2CQ6QwoITand/yBbHt9XfApJxjEUniOpl60hW/Zv2ba5go9CKmlBA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788798037;
	bh=46u81iAF8VXYSD8ZHU1f+Px1kcHzSkTHK4EAYZz3OjI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0K9soUfYRFkatc/loJuqUGBONJ9AJicgVTUmbgw8tP7NnrHX1zSLB+6TXi6nBIjcN
	 EaST36klueAr+mCSTsJNIT40kt24MZYE0eo4/VULk7d5WH47QliVwvzDQXDszKd7oC
	 KsoTd9xptwvtklXW2+4V6OrjExhVP9DL/SrLJEKtE9SzThltQpEilEGmhKnrsT3cT/
	 r7Pt0m+r5kSEjo6ja/oOrU+HKMaH3Tvn5vL33zPEzeUN0+wqeOav4oHlsBlhuhQEQA
	 nQKPGUDdNtTCpzVG3JTrrE/Zwi8tYckJfvKHdCx2GexNzi4eCUPoBeNuGaNbJZPZ2v
	 qmCg81t97oaBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDC7040587;
	Mon,  7 Sep 2026 16:20:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 460D89CF
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 14:54:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3801D60624
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 14:54:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0wQlYjFhg79G for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 14:54:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E09A2605B1
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788792894;
 b=OfqHK7Y6x6YPKRLaR0WLkJ/9xa49WzboT6tAyxYYx/4z52PuScYMXmuWZR6qsvSJdFe6
 tQSiIUWFPSgw+AksjcgGYegRDBP+3Nl+YL7MmpQmb18h0fpU+JDRyC94o745YSkzStCqJ
 GdY7fb6ZL9LAUABu8o3k+nPqVCO39GrsXK2G2IGHyDO/t9ReFy9anx0WJFwBRVUnwrTHE
 qstUoZ+DqWctqo1dysq/QbEZrQswfYsqhZwjJpzGF1TrSWysHr9fKj5mnt4KUAZTIXJGy
 hWNuaafa3SGsQV+lY1k20UaUeKhvyE/N8xgEaHQODmyAl9j1KR0TqNM+byYcRv+ZV6A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788792894;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=46u81iAF8VXYSD8ZHU1f+Px1kcHzSkTHK4EAYZz3OjI=;
 b=iyB8EHXvGsWCkufRbPtT0b81ZCIwKsir1c9OmUKBUdAMBEf19xpdgEJKrYWP603r/qqc
 v7aqbUw/NmXIVgW3wFKrzDwMzy9qhWQfAUOj41PBDaP66fIyP6b/mNgz9KbOHJ9PGn7Xi
 A1jI4qQLu7yf848YXEDA3LavSKKtszmBFrGSjwjxvKwGTCxL0JFIJf1XxvcEGmCXiR0Mn
 hsvCda3Br99aOHDHLIjFVN3NTsYTIbFzLn1WI+xGWA/xoS3+JEI9k7ehdlWrtn9UbQrNS
 En+KN/i7E3CRQ83K51MeRCRtOznW19OI661JfvR41frN5atW2C4NNTQCZnA028kvDnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EL8BAIkm; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::436"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::436; helo=mail-wr1-x436.google.com;
 envelope-from=andrey.lalaev@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=EL8BAIkm
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E09A2605B1
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 14:54:52 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so4095754f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 07:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788792890; x=1789397690;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=46u81iAF8VXYSD8ZHU1f+Px1kcHzSkTHK4EAYZz3OjI=;
 b=EL8BAIkm6z1eiObdZc9tt8cctbzWWYxHSi4iYiw6qmvGCYlNGus9mk6mNCPbMvgtII
 xFF+W3jTgVCIboiy3fNPH8Kt4cyXJ2E+2+GisKSOv+DwPApjUVCBeZatlTT6wW5z2KTD
 2YMZcGf7nI2uA8PQxLJd3izt3cDQvhH0nrn8JE5f+RkBZvBeLKMu2Ws/aoLBT2G27FsA
 1K3Zw8PpJBbtOFYCV3pO+cqwwcEtjJcl38vhi3dE7vsV9xjAmqQrKWdaNcVeb3Sf1MgZ
 c/zX9jYB4IzQRa/wIbuGpNrvw/4QG3sPVClpIW4iqiexlHni5hVvQdAqQQ/MukjBTQwM
 RooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788792890; x=1789397690;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=46u81iAF8VXYSD8ZHU1f+Px1kcHzSkTHK4EAYZz3OjI=;
 b=Z6ztDpnhtGHuijQj2h51OLAdnHJX9PFafSKc8fVWdMR0T/pXQ5+zV2ngtJ4rF6i4LC
 BWvVLkBMsgdryaIK035ChCBoLT1UHdpQXwca2icLlb/Lc69juvYT5arepTCENHwSb4Xw
 GozTiAjlcWE4sSIH9rBK/zLIEy/hS6FMaEiif1Xo0nnvhV6Cl/zlDB+bibyW3vcRWRd4
 ZT6VaQIxiRFiRJu5cP1+zSvjwWm+KxPSO3PqJW07sJSkmzxj4CrWNu37WURAwYRF1c4R
 AX+xEZo7UblB80nmUVHKlic6+hlY0JSwFOeo34HFJ/Wy4bXM+sd/Ak7q8gC8Kb0Lk0bG
 OP2Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxLp4sMPtohBmToCWwdizTs4xxra3fUuDzn8W3Z2eR3Hm49AGSo2lIbzilQFt/FYsRMF9fzwqA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nocQqGVFL6OwzSvbr5xBi5cpT5MDMPtYvKbHcijvGEZsrzg9w4
 R5Pj4JShvbitISWthjdMokt8b27AVz5iavUgOcQdu/pa6aw5uFDN5mBW
X-Gm-Gg: AYBFou3KDLRFWd+13wW5E5OMmIqGMd1BTxheHvFtcCKeUUA34S4dZNnMSqg78vUI3UX
 myOVpzWsasPXao7uJKmWCHb+7+SuGOTLscbPkldbFfrbNWjkY1eGq19dwjpvPtwZANsH9PeHz/v
 o9cI5pyoHTNt927UfJrgYnbrRT6cyHEkwhcyorJ78jb8Ppoy1OHL6GgPT7ImUgVLsHiIs2dsytw
 jP6NuehZv+V5beX4V+RuYt2WbArbWXDtWS2MrMQ3Rh/cEnkV7x67GyGqqkqDsufoGV1WbTshCv/
 vkWIiQem2rSeHVOsiVn1HDBLtjAGO8dGuTZ/9lFVtm0NUjQPLWaRZpqcAz5j92HYu7dKkDpIok9
 4YoQic7hYDd46PMqzwXZkdt/+YruPknnrnGdEEPAV5NMcqdiSMgm7VrKLJpOTWeeSJ2dIXirJVy
 aRyRNOlR0hce2O2NhL1qtiPWDZDmo/jKIedG2xJNyszQx1Tgj6NI9inqjdpC19QrNuvUAEk3ZOW
 LjCCsF7zBXszhNc5MwCccIqcHi/EfTO85oYdMPVyRXSCH1RkdWhPEQaCo+K9nxKpIe/yizhXjeF
 NqtIR5EJXU7aujDX
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr40315119f8f.5.1788792890195; 
 Mon, 07 Sep 2026 07:54:50 -0700 (PDT)
Received: from [192.168.0.233]
 (2a02-8388-e6ca-5780-e161-768d-5c97-84d0.cable.dynamic.v6.surfer.at.
 [2a02:8388:e6ca:5780:e161:768d:5c97:84d0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4859207c28fsm22879549f8f.5.2026.09.07.07.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 07:54:49 -0700 (PDT)
From: Andrei Lalaev <andrey.lalaev@gmail.com>
Date: Mon, 07 Sep 2026 16:54:35 +0200
Subject: [PATCH] mmc: cv1800b_sdhci: configure SDHCI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-milkv-duo-sdhci-configure-v1-1-606b59eaafa0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQrCMBBA4auUWTswVjDEq4iLdDJtx59EMqYIp
 Xc36vJbvLeCSVExOHUrFFnUNKeG/a4DnkOaBDU2Q0/9kTw5fOj9tmCsGS3OrMg5jTrVIhiCd57
 YHSIN0PpnkVHfv/f58rfV4Sr8+g5h2z5dahHBfQAAAA==
X-Change-ID: 20260907-milkv-duo-sdhci-configure-aa9790c73d0b
To: Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Hiago De Franco <hfranco@baylibre.com>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792889; l=2278;
 i=andrey.lalaev@gmail.com; s=20260901; h=from:subject:message-id;
 bh=KBlAuzSObg1HhPom5Q/NWFZ+OSQE+e7aqI3whoZWIuA=;
 b=vZXaGj5xjx6+ld/0Jks0QfzfXc4ob/mpUXM+lpr+A7J5bWdRRqwFrcOtKiPpQueTZabF3aCCl
 wf28+ZKD2gYDiOCa2ROzFd42ZSq9vqpMJL2pvDKhpIeZMb6lpYPydc/
X-Developer-Key: i=andrey.lalaev@gmail.com; a=ed25519;
 pk=YHk+K3q98GV/1CigmrEAQ+Vc0o+GlFWt3j94jvrEh6o=
X-Mailman-Approved-At: Mon, 07 Sep 2026 16:20:33 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Some samples of the Milk-V Duo and Duo 256M have issues with SD card
communication. As a result, the SD card is not detected, or the correct
mode is not selected.

Configure SDHCI PHY in the same way as in downstream, to ensure
that the PHY is initialized properly.

Fixes: eb36f28ff721 ("mmc: cv1800b: Add sdhci driver support for cv1800b SoC")
Signed-off-by: Andrei Lalaev <andrey.lalaev@gmail.com>
Link: https://lore.kernel.org/u-boot/20260822091510.3253162-1-andrey.lalaev@gmail.com/
---
 drivers/mmc/cv1800b_sdhci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/cv1800b_sdhci.c b/drivers/mmc/cv1800b_sdhci.c
index b756649f90f3..5c129682daba 100644
--- a/drivers/mmc/cv1800b_sdhci.c
+++ b/drivers/mmc/cv1800b_sdhci.c
@@ -8,11 +8,17 @@
 #include <sdhci.h>
 #include <linux/delay.h>
 
+#define CV18XX_SDHCI_MSHC_CTRL  0x200
+#define CV18XX_SDHCI_PHY_CONFIG 0x24c
 #define SDHCI_PHY_TX_RX_DLY  0x240
 #define MMC_MAX_CLOCK        375000000
 #define TUNE_MAX_PHCODE      128
 
 #define PHY_TX_SRC_INVERT  BIT(8)
+#define PHY_RX_SRC_INVERT  BIT(24)
+
+#define CV18XX_LATANCY_1T BIT(1)
+#define CV18XX_PHY_TX_BPS BIT(0)
 
 struct cv1800b_sdhci_plat {
 	struct mmc_config cfg;
@@ -64,10 +70,29 @@ static int cv1800b_execute_tuning(struct mmc *mmc, u8 opcode)
 }
 #endif
 
+static int cv1800b_deferred_probe(struct sdhci_host *host)
+{
+	u32 val;
+
+	val = sdhci_readl(host, CV18XX_SDHCI_MSHC_CTRL);
+	val |= CV18XX_LATANCY_1T;
+	sdhci_writel(host, val, CV18XX_SDHCI_MSHC_CTRL);
+
+	val = sdhci_readl(host, CV18XX_SDHCI_PHY_CONFIG);
+	val |= CV18XX_PHY_TX_BPS;
+	sdhci_writel(host, val, CV18XX_SDHCI_PHY_CONFIG);
+
+	val = PHY_TX_SRC_INVERT | PHY_RX_SRC_INVERT;
+	sdhci_writel(host, val, SDHCI_PHY_TX_RX_DLY);
+
+	return 0;
+}
+
 const struct sdhci_ops cv1800b_sdhci_sd_ops = {
 #if CONFIG_IS_ENABLED(MMC_SUPPORTS_TUNING)
 	.platform_execute_tuning = cv1800b_execute_tuning,
 #endif
+	.deferred_probe = cv1800b_deferred_probe,
 };
 
 static int cv1800b_sdhci_bind(struct udevice *dev)

---
base-commit: 509312dc5386ff4c5adabf53a573abca0aac4ce5
change-id: 20260907-milkv-duo-sdhci-configure-aa9790c73d0b

Best regards,
--  
Andrei Lalaev <andrey.lalaev@gmail.com>

