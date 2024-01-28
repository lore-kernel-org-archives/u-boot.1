Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E10C47DDB
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 19:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4175787B50;
	Sun, 28 Jan 2024 20:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QmsyiEYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10F7F87A0E; Sun, 28 Jan 2024 20:23:42 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E09E5879ED
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 20:23:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tekieli.lukasz@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a2d7e2e7fe0so392382366b.1
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 11:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706469818; x=1707074618; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UAnWUjtQy8qic/mu8fecbnfwxyy/gyiodz9raanAFc8=;
 b=QmsyiEYrODAjfvImm4HpsZqsJ0lVPuSozxWXFRVrv0w6GztiUkzAP/jNBDYI8N9jRk
 80kU5zqvb2An847IaBtxu6lVE/SpGxDh/tndTTSWFyd9jlKW+8xAuU5sn+vkqbZWLvpQ
 /dXhBZPpIrC/piHGsomZohblUmyLvaeLk2ncEyTYSw1/QJyyQFn2lo765l06bEYi2guO
 edmqqv2SAU7rsb6LaoUY061mMzXxNCPHUqctdZaDkyReB+lXCtj2ghYYdYOulu5AWyiL
 TSrHhcflazjQ2zViOY3lYFaWHu/AJ6G5y09d/EEqmOZSlysNtWsmJCW/MQ0UQXQwx8+S
 hvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706469818; x=1707074618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UAnWUjtQy8qic/mu8fecbnfwxyy/gyiodz9raanAFc8=;
 b=XEKS7nld349zmPUWXAUKhqnCVqxbOaEiV2DUHSqrq087PMPbIGrZVFrAs6n1zpJJo0
 o3BEmcanY85kDvobfsTqKTk9x9oXxsgR4eYcp6vnQpxkqog0+opDl/H4STJV98Y/p3y3
 oGbp4zZvfox68AiXHw73FQQVM3phXZr3uNSpBP45UFW3rCt4WRh2XoB9jNe5wXg9IAV1
 WBt5AB8jvte0KR5n4ntVYuCu+j4lirDelNVMmMgk/u1nccMot3MCb/z28AEp0XCYZFFA
 Rigftu+ijKa0FecUspNMchF3ihD1X3v5IjEdwhRDSpA+T7T7S+e0O1Q6U4ZUzWNMCRNR
 iefw==
X-Gm-Message-State: AOJu0YwWh6qbr2Li/yy/gdIlEZFr1bRm5nAYE1DDrSmBAXV1hk1bfrLZ
 sli7fFOg/m7z86yxz7zor6t8+nODwVfxiA6q13Q2oPq5YbynVRBR
X-Google-Smtp-Source: AGHT+IFHbxnTDOh8OwO/j2SUa0z9ImT3lBF7bzEIyJThkVPraRGuIB2p6BIvVraxgDL1Y4CV8DWKVw==
X-Received: by 2002:a17:907:c30e:b0:a35:b8cf:27dd with SMTP id
 tl14-20020a170907c30e00b00a35b8cf27ddmr634226ejc.5.1706469818285; 
 Sun, 28 Jan 2024 11:23:38 -0800 (PST)
Received: from yoga7.fritz.box (ip5f5bff47.dynamic.kabel-deutschland.de.
 [95.91.255.71]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1709061c5100b00a3472da6696sm3107999ejg.159.2024.01.28.11.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 11:23:38 -0800 (PST)
From: Lukasz Tekieli <tekieli.lukasz@gmail.com>
To: yanhong.wang@starfivetech.com, trini@konsulko.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com
Cc: ycliang@andestech.com, sjg@chromium.org, chanho61.park@samsung.com,
 frattaroli.nicolas@gmail.com, u-boot@lists.denx.de,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>
Subject: [PATCH 2/2] board: visionfive2: configure PHY pad drive strength
Date: Sun, 28 Jan 2024 20:22:48 +0100
Message-Id: <20240128192248.64407-3-tekieli.lukasz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240128192248.64407-1-tekieli.lukasz@gmail.com>
References: <20240128192248.64407-1-tekieli.lukasz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 20:35:18 +0100
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

Configure the pad drive strength register for both PHYs.
The values correspond to what can be found in the Linux DTS
for VisionFive2 v1.3b.

Pad drive strength configuration is required for the phy0 to work correctly
with 100Mbit links.

Signed-off-by: Lukasz Tekieli <tekieli.lukasz@gmail.com>
---
 board/starfive/visionfive2/spl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 336f0cdfc90..ba9c62f2f97 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -44,6 +44,10 @@ static const struct starfive_vf2_pro starfive_verb[] = {
 		"motorcomm,tx-clk-100-inverted", NULL},
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
 		"motorcomm,tx-clk-1000-inverted", NULL},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,rx-clk-drv-microamp", "3970"},
+	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
+		"motorcomm,rx-data-drv-microamp", "2910"},
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
 		"rx-internal-delay-ps", "1900"},
 	{"/soc/ethernet@16030000/mdio/ethernet-phy@0",
@@ -53,6 +57,10 @@ static const struct starfive_vf2_pro starfive_verb[] = {
 		"motorcomm,tx-clk-adj-enabled", NULL},
 	{ "/soc/ethernet@16040000/mdio/ethernet-phy@1",
 		"motorcomm,tx-clk-100-inverted", NULL},
+	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+		"motorcomm,rx-clk-drv-microamp", "3970"},
+	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
+		"motorcomm,rx-data-drv-microamp", "2910"},
 	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
 		"rx-internal-delay-ps", "0"},
 	{"/soc/ethernet@16040000/mdio/ethernet-phy@1",
-- 
2.39.2

