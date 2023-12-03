Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1ECC4167B
	for <u-boot@archiver.kernel.org>; Sun,  3 Dec 2023 13:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7470A87786;
	Sun,  3 Dec 2023 14:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="bUHJxGRQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p+5X43qN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8455187717; Sun,  3 Dec 2023 14:17:16 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A559386F6F
 for <u-boot@lists.denx.de>; Sun,  3 Dec 2023 14:17:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4SjnQL1t5kz9sp8;
 Sun,  3 Dec 2023 14:17:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/8dm79kDzih/h0IdAF0mlHKA1wYs0ipM9PB4TrwUGk=;
 b=bUHJxGRQGxt2djgHPPJK5UYRW4NPp0GqArEJ74hQiy6Nqt+4N8j03vct0fWErb2Ht0cVoT
 EVBxq1LlR4YtNEvgMQbeQ9Ar1riJkhQtGTrGSJDNc+FIibEfMPUO/wCNDn8gk393Pd3cGR
 SurEyJJ14+hEk8dNj3Sl3IXYX9LoRfbhDCGb2hY3pxLdb0V0E2uzOIzElVlUvWSh/W5AMo
 rsvaUSbd6NmG+Y8Vopa279F2/CUlOqDduRFBM3csUE233h3RL5A2eA/P6zguWISu11QZ4s
 wFIfNC/AEk/5mRosiE5TydAkUm6IPYqN0/MdoBE66ftZ/G97s1PRilZpGXYR9w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1701609432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9/8dm79kDzih/h0IdAF0mlHKA1wYs0ipM9PB4TrwUGk=;
 b=p+5X43qNAFVhCf2BU1lPoSqmp3bF/B70tkVMZmh17ZQSetnYpys+msRSb5EyoVS06ufGY/
 TasiZTVsdTK3Is096OZ0LIw2C5Kb3o9+9HErZeYB1bneZBYY7pzkGMj/hkKp5+8qnpzKPj
 iF22CI+tLFWNsCAUuuKv+8a0OtEvXrNBboEmNYwDjU/XzyM3Zjvz7xdG05d2EOxsdVwqia
 DDs14X/hF6STn9iSx40VZrVvxb1GO00Lol/BRDCfz2ecCnz2PZQaTWFaUpdUikC1gEJefd
 EJAWyP9ucjFHemutoXl3Qwf5eplZ+fHWOyeYyW+KrtA8/VXyIMnsM3qtLTQgIg==
To: u-boot@lists.denx.de
Cc: aford173@gmail.com, paul.barker.ct@bp.renesas.com,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 10/12] ARM: dts: renesas: Synchronize R-Car R8A77970 V3M DTs
 with Linux 6.6.3
Date: Sun,  3 Dec 2023 14:15:22 +0100
Message-ID: <20231203131635.119191-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
References: <20231203131635.119191-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: h1pbeyc9hiyosbfwb35qpa1366a5zxt9
X-MBO-RS-ID: 576418607dbef6f69df
X-Rspamd-Queue-Id: 4SjnQL1t5kz9sp8
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

Synchronize R-Car R8A77970 V3M DTs with Linux 6.6.3,
commit bd3a9e5771a8b332f466d06f7c130a69cab0d526 .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 arch/arm/dts/r8a77970-v3msk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/r8a77970-v3msk.dts b/arch/arm/dts/r8a77970-v3msk.dts
index c2b65f8de54..e36999e91af 100644
--- a/arch/arm/dts/r8a77970-v3msk.dts
+++ b/arch/arm/dts/r8a77970-v3msk.dts
@@ -145,7 +145,7 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
-	hdmi@39{
+	hdmi@39 {
 		compatible = "adi,adv7511w";
 		#sound-dai-cells = <0>;
 		reg = <0x39>;
-- 
2.42.0

