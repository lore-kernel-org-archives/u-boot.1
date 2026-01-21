Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6BDC44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:21:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE9983B27;
	Thu, 22 Jan 2026 00:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k9ArdQgS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58DD283A3B; Wed, 21 Jan 2026 23:46:28 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D787880077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 23:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-45ca0d06eddso151303b6e.2
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 14:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769035584; x=1769640384;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bFGv8+/NDxB9Ipjpc18hWNeea0bwShcrjJO64UIKBbs=;
 b=k9ArdQgST+MTLxTx5GvHM2bReGR4V4XbFbcaXS7jG0iXHNpcpScHnlEV9AXIwb2Ne8
 rphqRp2nmiS3+qvsvmWW6lG00C2qjO1f+OTBe/ME2NsR4oFLvWSvlIpHoJPk4uKcDfVh
 RhsfTCWmIh9vKJQsZxS08H/ZbZPCHfAjSuMIsmYCcKW8rlMigAASFi/GLmF5QR3hyUxd
 q8I80Hsz2e2/hQumtpKqo03xUoTRgHKmnktWBzl/xWuu2k6y/sumUed4T664oEYNX12p
 erm3tcgoTIF3KaXRBonXC3KuigpoJrK+lOACbUVlDVhyM21P+klzESZqJ2S4mVh7D4n8
 KYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769035584; x=1769640384;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFGv8+/NDxB9Ipjpc18hWNeea0bwShcrjJO64UIKBbs=;
 b=J1U2DFNwq9kjECCvRTjGTSO7f9jf45qvNWLgwsN7WMGZrr39jIjdET5+l/GlpxbBHh
 q1C3YJfEx+7CRem3wApDNP1V97KYnZCXczxlwRm7KpEI1t0iw9Du0cNtbpEt/QtD3RGV
 jR9nUFaz1OWs/njKPYzo5GitaV1Q9kkpI2tbdJW6I3AwXWTcbOA5l+jv580w0gBEaT1T
 N+vOwVrcnXnQMu3CsXeputgHq/sD8XV1L9AjUwfND4G8UzGiGx6t7OP0HAvyjFOd2leT
 6rPpmJEL//nUcbmbB0ijzWeZbMFsP19BiJpg2+pES0EtK3psIdcBPIMo588sMDCzgEk+
 5g1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIfAl6LHDxiZc6uQ8zSgqVoeaGVhx6wVO/np93RmRHmUlhCtRy3y+GFYlshPYLatqe3QFxJw4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxk+k/ESQf2UmHs+vDoth6AiAGjPDCpTWJebYAisjsuI6Yjol06
 90uKVRBMRUjDXmQZbxq/fOTtcRgcJzUXYa4ZMWx65NY1ncxM9Wd3/8byFL50+KwbDs4=
X-Gm-Gg: AZuq6aLwAVMlnYPyQIiDDr8lN1zkX9tPYGE3DX9RXQPd85n4NtvKTKd7Fod3WxIEBEE
 kdPxFTqoSlxJgO8F9dB2h2Jt38az3HHs+p6LL1jlyVsKV2SVFE969E+Y+8IYQ2bMUmNX5oUp4pB
 Yrd1mZXhsymqUJBUigY7vObOczHOHuOnQ5+Y3//vCPFVX037aOk0plytJIBXFZpEZ2UsWRspjJy
 4347McwrAyEIoQISmYGY4xzWYv/Kv4Xn2WoyIR+EWsB5t5t5xVwuuXhdUWgigTAL3ThzHlJYf/D
 PpUQKY7U5efIcXpxaNmrQbi/Ckkoad60wGXmSg3lpR22g12P8WYtlctfd7Gh8D+pbVn+BT7ki4M
 WhxwyiaN2UksdbQX15+XekloAognUW7rU7b4yuLs4Ten3+PZwxhMhF3g07ob78jWa0nBXvt7FtV
 trOkJxwQyiW0N9
X-Received: by 2002:a05:6808:6610:b0:450:3534:dcb7 with SMTP id
 5614622812f47-45e8a93b3dbmr3289957b6e.23.1769035579725; 
 Wed, 21 Jan 2026 14:46:19 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9a8b:7a9:24fa:a0a])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9df08545sm9050915b6e.8.2026.01.21.14.46.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:46:19 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 21 Jan 2026 16:46:05 -0600
Subject: [PATCH] configs: mt8365_evk: enable mmc command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-configs-mtk-mt8365-mmc-v1-1-abcbac0492aa@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MMQqAMAwAvyKZDbSVqvgVcdAYNUirtCJC8e8Wh
 xtuuEsQOQhH6IoEgW+JcvgsuiyAttGvjDJnB6NMrbTRSIdfZI3orj3TVrVF5wjV3EyWLJFmBTk
 +Ay/y/ON+eN8PTdSjsmgAAAA=
X-Change-ID: 20260121-configs-mtk-mt8365-mmc-0d7b5c5cc1e0
To: Julien Masson <jmasson@baylibre.com>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=tWOfwIVIAlbI5IYPf9E6QzdWYDpqqC3G2jfrd6WnrSw=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpcVczRaUUy0GaG/xgr1SSY0Gz1YwGvgwbqyRUA
 394UWCNrj2JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXFXMxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9AoH/RRXkDIblw5KY1KduAH6cyaBASGjyMO1bUaFFU2
 xTzauBltMpTlJ+lU40pszullvPic1hjvm4E7Wi6vG6OU55mUz9YSXKeK2dZxSSPqq7MBA/1ls//
 XVXeCLLTIMYvZXuY+gAGiFIgnNFl5Fii/8Z5md1hw/o/vzEq2K4KOWtVSG1fNHF7GLeN0TEx4P9
 VqiHxPh5AXFe71TQdvb0U2BXcju7x+uN56KJ/62DgKONzi36Lr4UPGj6JgH94JWv4Ieb4dPY+o6
 uWuiFdAakNdYjOeVMkS+amcZ9nz5l90A0zAatSD35M1xgwzrIHg1upd1xYc44Qa2oKK785yRbZb
 4HzM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 22 Jan 2026 00:20:22 +0100
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

Enable the MMC command on the MediaTek MT8365 EVK. This is useful since
the primary boot device is an eMMC.

A few partition commands are also enabled since the mmc command alone
is not enough to read all partitions on the eMMC.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 configs/mt8365_evk_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 19fb6b79b29..f1e7d7fc58a 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -12,6 +12,9 @@ CONFIG_IDENT_STRING=" mt8365-evk"
 CONFIG_DEFAULT_FDT_FILE="mt8365-evk"
 # CONFIG_BOARD_INIT is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
 CONFIG_MMC_MTK=y

---
base-commit: fd871fc6bb497c6ddd7b39622480b89add78f57b
change-id: 20260121-configs-mtk-mt8365-mmc-0d7b5c5cc1e0

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

