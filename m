Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DE2C02190
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 05:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DBF80207;
	Mon,  3 Feb 2025 06:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UYgZZ9uF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5079180243; Mon,  3 Feb 2025 06:17:40 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 823AD80207
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 06:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5026676a91.0
 for <u-boot@lists.denx.de>; Sun, 02 Feb 2025 21:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738559856; x=1739164656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uofLf2haUZx6nocKHcPJo1Iwn7Uq8Z8PRGvISVSXm7Y=;
 b=UYgZZ9uFhkgyYLYULev6ltWykX9SIffyJYTT8cwi6lJ9sUCDVJuNBGVkzDSJzVTOww
 17RgwnFsI7eB4NTQXVRC+KygAE/9dzqzjnK/QSHKf4Pb9zwCNMuWDu7O+AUklOqE/xbF
 sZMJh+aDTgOrQ9ls3WwwohpFYKI90D8N7H4Xxw1xBzWmrmcmxiIYDvrD1HZKIWYgei1h
 oEU3SmajwjnSeiicf/zTcQ7a7a9+8UiNv7aBTSHacE4PW3c+XNOWGAmWfHtnB2f6djuO
 1l4hI6hm0NZq1Il8g1TOR4KyCZa74+i4mLL6lGYeopV9I/nt5irr2Um/oV3mvycZNz4o
 WmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738559856; x=1739164656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uofLf2haUZx6nocKHcPJo1Iwn7Uq8Z8PRGvISVSXm7Y=;
 b=Tdr/JuVPRi4G12zIf54Rm2fjOULl0lF4a56jlg3Lg+SjR2SIcLIgIx/+Jpyl5WaJ4D
 YNt8nKxluasLRJGTWN96Bz80DWgKtkceGkiuLqYoWB9XJzhOQzWEjwM3WXeJROduuHwU
 h1L+FKKUJ2j5+cSivaOTwxS6pjBCesXvveU0sQ7CKXv8odIIbKinQxy3OItGj0BKvBF1
 wFMIkes6zXge+Hyfs9yZfOgg9hlf/d/AzgQa55i+70qlF9Cjg9dFMSouAqB1u/8iCUjg
 hyYsftEJUKpTmU8tV48PUMJbTkojzWtxUce/ev9YghgspHUEyYixr8nKA8fBj0ykUpPB
 TzHA==
X-Gm-Message-State: AOJu0Yx03F60WZghr0KDxkZtaYpzhO8UFRVl0dMqJmu2EuYGJ+yl9oWu
 r8TKpv+X3vdW7neznEPVJx3Auom7sLiMV+5D0zFVVttrWc7GUVLCSaGRCqGD
X-Gm-Gg: ASbGncsL01FWSGjAeTAGDwAp5jqeNWlZcAmxrc/pXJ6jn9/FOLIHWeb65Dl6TNuHv2Q
 P4YjE21Z8GMKr3HHAMN6D6Y4np8UrLY0cgasPuzV2AqcEgdWuVDZZLl1IN3o3+iEVcAmuXCEz0K
 +LeKu3K7vcR8kuSabjaNt+8UmfGVJYMA1hTj11o0yQhlcXXvZzmqvnRPJvAM1lW6jKp54a/SMwa
 GG+IJZPe2qBlXggsV97x9rF/QeocgoQpchabG9E0XlunQDtmv5Z6trxyCV0JHcQwJ6TgNcIqXpa
 8k9Y7p32hAHWQyVkdp4Yx+GYBKaHe3Ml+mVoVyhJ9z8YuxfDe2uhs4AFlI7JCC3QfWXy5hZF/Jp
 94JJrPw==
X-Google-Smtp-Source: AGHT+IF0wV5jffqbxr+0uKUpVsmC8x6Iy+xXskfC88mKY7UZAI12WQyxlO86UKbExf4e5AcEH0kh2Q==
X-Received: by 2002:a05:6a00:1d88:b0:725:456e:76e with SMTP id
 d2e1a72fcca58-72fd0be3561mr26975895b3a.6.1738559855812; 
 Sun, 02 Feb 2025 21:17:35 -0800 (PST)
Received: from ISCN5CG2520RPD.infineon.com (sp49-96-228-226.msd.spmode.ne.jp.
 [49.96.228.226]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72fe6539fc4sm7508639b3a.73.2025.02.02.21.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Feb 2025 21:17:35 -0800 (PST)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 1/2] mtd: spi-nor-ids: Add support for S28HL256T
Date: Mon,  3 Feb 2025 14:17:11 +0900
Message-Id: <5f1ab4dadd59ee2a5834afed840be5ca19ff4241.1738559198.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
References: <cover.1738559198.git.Takahiro.Kuwano@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

Infineon S28HL256T is 3.0V, 256Mb Flash device with Octal interface.
It has the same functionalities with S28HS256T.

Link:https://www.infineon.com/dgdl/Infineon-S28HS256T_S28HL256T_256Mb_SEMPER_Flash_Octal_interface_1_8V_3-DataSheet-v02_00-EN.pdf?fileId=8ac78c8c8fc2dd9c018fc66787aa0657
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c9484..a500fff4775 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -414,6 +414,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO6("s25fs256t",  0x342b19, 0x0f0890, 128 * 1024, 256,
 		SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #ifdef CONFIG_SPI_FLASH_S28HX_T
+	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
-- 
2.34.1

