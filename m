Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924A1C9831A
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5699980A53;
	Thu, 24 Sep 2026 12:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9AeWFiFvpWnu; Thu, 24 Sep 2026 12:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7CB7D81A6D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253447;
	b=RsXURt/DSqK+9X6mQO/yBrFgT7AKuet6ySvgiauw/2gj3KIH6iRU4Yv3UycvIhn99AsD
	 iaOBsXz9v+xprk6XiUdceIo/y0JAqkMZpgfJWuULrBseZDwD5ByEoKdLnZ53QcOjprzn2
	 Fg2frRhYW92E1QQt+K8Swo+gdpZtm+X4EdCeO6L2FOXQmq8sNKZ3fl1cjvzEPYPDE3Cti
	 4nfvAwAm1Gye8gQgD05BEJ85B0MlzTyh3BuCCMxrO448Z9PZVrZSAjsEwNiGddf6tHWQ0
	 RFPT4bQqeeUbaGPJabZgtvKAwSLrK2dRJ3JT1YxryKeAfYz5X/5+qyQj13PQYiQiyqA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253447;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=o8Dq+yMjohqi9taZgwkqgjLVdP4i4DxaG4FAguyw7ZY=;
	b=Vf69cOsaSG0iH+DsePahGnEWAuIrG8mcP16YVmjuZh+KAzYK8aHonEkLL8WGd5MHkdV5
	 Ud7ZjEG1diuNRzasJyoBMf+yubatfo+gB+AqOkLEoNLp8R63ggONYVf9pe/Za6Hpqddwz
	 1oZSEGad1tZldFOlZFtrw6zPrgrgc3YfIyL6JPvQAIzvcJypG79LNzxl6of0AHXFJqMSV
	 tR+8agzAp8ngqTm9QAqs0v8oJvWMa5l5G4xmHiFyQadM4CGj6K4JH1T/XgKYu9kQEggtX
	 c99X/H2Bwyh3V4Q1MqyKEK1rzpWSYElqzhXl8YOMFOChh7dp8X+HOkLYivUVE9wMEYg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=uU25FREB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253447;
	bh=o8Dq+yMjohqi9taZgwkqgjLVdP4i4DxaG4FAguyw7ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vqWjEXWKTV7/yw4ZhSEp+IusDCkXyjkqXByWJA1WwfKKkGUW2LlPblO84rZQCOPgm
	 +uUQeFCLPGUk+8I+QDWFpr0Etxl/XGHAduDZwAeUfbOobBtxg4o8eZoetDE8FXlDas
	 YV8br2XrWUZ9FbP7zHjPxq50oWHjqJoC5Vx4N8qOaepwGkeBQkkQolKMSU2odFif5E
	 qkSA12s00XbvKyxYyttFrAm0/bJn3RCFx6SR/XQcMC2CuZj4fZLem0WLBIKU6LLzaA
	 ZXtqvURyJL8Q7dv2bH3PY5wDxjrUh56iPL5LL616LLuA737lYnHsgeBZB0OlefjIYm
	 G/YnLfRK8QCEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CB7D81A6D;
	Thu, 24 Sep 2026 12:37:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B7FE335A
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DC8280898
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e8h8Cf92uExM for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:37:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0D35D80D0F
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253444;
 b=DrV7z1ob8mJDqxvve835ZuEWXuMi30qioFwnSB4eZi/7ipUpLDOtTk2eiT5lZjf6NdCZ
 MVsTWdFPSLVtNUoMtehL9/E86WQcryAvWhXHKZoBQdyBnrJGRKYvzEAGk04+PzfLizHWv
 XQvzJJQ8lyu9rEt3kY0501ax0AzK5LicWhi6A6Fn0Kandii2y7y3Is/3Fqf5TqreSBIdS
 SW/LF1MB3+xpNuiSVRAfnLrfXK6CpraeZsL+U0u7KjvBq/O4nDJhJmfDLAeGpKhoPS0Q3
 hkIbj/8rmE/uNDy9OwvpUQrAFczVMI6V7io8laxHrI1M4p1Ti7LTrUbt5VBKUv5x19w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253444;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=o8Dq+yMjohqi9taZgwkqgjLVdP4i4DxaG4FAguyw7ZY=;
 b=tV4B3HDzklQ9wQrZkN0huBKI7395PrFvWtErWCBZJGF0Xg0BwMHeivUQcrSBp1zEESet
 /upJPd0RMqmf9e+cg4K0OL4DjO8pw1ABBO9M0XDTyOV3vOSDT+unWGlEATc/n48omMb2n
 flZP17/EYCWcWzwJaGnotutzbMIISZdHwhRh/iYe3oWAPcJPWnD9aWn65RMIVJ8pJ96gh
 AHFV0HybjooheVuqx7paem+6MRvVTzmW41A1s3HHZpylEh9dY3awKfZXwz9j4OEVZOTmV
 rHEnM/G0v6ihb8dvXNRaw3mwOMSHwR9B2ZXt40Y1uLtr9GBxAfbkG1HdUTtVmx0+IEA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=uU25FREB; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=uU25FREB
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0D35D80D0F
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:37:23 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 262814E41059;
 Thu, 24 Sep 2026 12:37:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EEAF260341;
 Thu, 24 Sep 2026 12:37:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7834E10329470; 
 Thu, 24 Sep 2026 14:37:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253440; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=o8Dq+yMjohqi9taZgwkqgjLVdP4i4DxaG4FAguyw7ZY=;
 b=uU25FREBT/bm9m2wbw+pAjaeJCRtrv0KFQSaw/wb3kSDPagViDedC5Q/iSBjUDrK+fX4pv
 TYG/gBKRWuTOMOfhXZJDvlB/w4ObB9xJd+asnwDqhBMKTcxkXOPtxrJO9QGxYGJ7Ea+ITJ
 rjAT2ojEYShKYFznCVYh97zrU1dFUeCzZING4+zDTfJROUwpMQPTYHKEizCSXIhPw0Yq7Z
 mYfTpkk/oirydZ5GqzfVR2xc9h9CmWZdaWkczRxdjg9k0VShMdxcMfGfMDsBsV+XMKt3on
 nhH1xbyLQMMJOCpxJ5/UADgKgld9lly96+beoDP++3JDdbS2jRUskqaxpRYRuQ==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 21/22] arm: dts: k3-j7200: Extend firewall for ATF region
 to TIFS
Date: Thu, 24 Sep 2026 14:35:32 +0200
Message-ID: <20260924123533.2599438-22-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Prasanth Babu Mantena <p-mantena@ti.com>

Extend the access to SRAM region of ATF to TIFS as well. This is
needed for TIFS for encryption and decryption of ATF as a part of
low power mode sequence. TIFS encrypts the ATF while entering into
low power mode and decrypts it back while resuming back.
So, giving permissions for TIFS to access this region.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/dts/k3-binman.dtsi | 7 ++++++-
 arch/arm/dts/k3-security.h  | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03b..1cf417ed7dcd 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -475,7 +475,12 @@
 					FWCTRL_CACHE)>;
 		permissions = <((FWPRIVID_ARMV8 << FWPRIVID_SHIFT) |
 						FWPERM_SECURE_PRIV_RWCD |
-						FWPERM_SECURE_USER_RWCD)>;
+						FWPERM_SECURE_USER_RWCD)>,
+					<((FWPRIVID_TIFS << FWPRIVID_SHIFT) |
+						FWPERM_SECURE_PRIV_RWCD |
+						FWPERM_SECURE_USER_RWCD |
+						FWPERM_NON_SECURE_PRIV_RWCD |
+						FWPERM_NON_SECURE_USER_RWCD)>;
 		start_address = <0x0 CONFIG_K3_ATF_LOAD_ADDR>;
 		end_address = <0x0 (CONFIG_K3_ATF_LOAD_ADDR + CONFIG_K3_ATF_RESERVED_SIZE - 1)>;
 	};
diff --git a/arch/arm/dts/k3-security.h b/arch/arm/dts/k3-security.h
index 33609caa8fb5..3e066bca6ad7 100644
--- a/arch/arm/dts/k3-security.h
+++ b/arch/arm/dts/k3-security.h
@@ -7,6 +7,7 @@
 #define DTS_ARM64_TI_K3_FIREWALL_H
 
 #define FWPRIVID_ALL    0xc3
+#define FWPRIVID_TIFS   0xca
 #define FWPRIVID_ARMV8  1
 #define FWPRIVID_SHIFT  16
 
-- 
2.55.0

