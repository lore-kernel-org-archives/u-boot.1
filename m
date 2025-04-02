Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD84C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 06:27:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9229E81F69;
	Wed,  2 Apr 2025 08:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KK/bsnxw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A253D8171B; Wed,  2 Apr 2025 08:27:14 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263A780584
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 08:27:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2243803b776so58687535ad.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 23:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743575230; x=1744180030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2LfkTV2BuknoEWloggMmJ9oOfx0EnRbNR4xQWKKAwI=;
 b=KK/bsnxwiIqQEYXdchL29twQq9WzLZ7MlC7unHkvNBvjZVIRD7Pt9+nf3eaH9Brnoc
 65ZvoOT9KBh3XvSSq7ZZeR8KfBTkCy+SN3DPTEdj8dbCUjbjhz8kjMElUACUYA8/A7Eo
 o/y9ToKWWeQypUfk/6NTFI34eLdYckgrf9G5/fDvaEwpFe5OcodFCWN3/EqPXHz65isS
 tIiQjRpSXZB37PDUMGn4JzILTtr4bhwkDbmi8KcaLH3uwQg/czT6y+h8siB9QkBfhnmp
 dJxywkXz9fksazKRSys9HUkXqupSfDYAzOo683vSTLGumSnoy0PYqa0/wnlVATemRE1E
 x6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743575230; x=1744180030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L2LfkTV2BuknoEWloggMmJ9oOfx0EnRbNR4xQWKKAwI=;
 b=hQYJdDH4NpIq4Wb+2ehjWdYvXQS8pafydIJ5yeSauhjTXdgZ5DfHc1FNm9xDic0p2T
 QWnFAmzVyPCTEXyk2B9arsKKsScQTDAZ8V542h4jIzDWteV0wnZHJYjJFIJDindFnMP0
 p5M1uPipLp6h1rj3/Hj17PPY52IVq/zEjw2zMvmZaw1fBwCTo3f75ytdm0V/cLsZTV0v
 q6LjxqU6CePNlrmkcBoFmRNPqpfQReEFAxLHUQeEKZfzytTAF92gfHvdZWLHzcaH2DjW
 um2sGgr3no9Cr16ITXuRGtTHrSwv0bd+2NrGw+ctkLpglgmxSuinVZn2XqNnTWmFl0ah
 4txA==
X-Gm-Message-State: AOJu0Yy+ABYcE3bGD4gIRgbwq1Lqi5oobk/wMZEVjaSB7P/GzLOUfRHc
 BWY79zWPvdWThHnJzgdaSBoqy3LzGEdjY40/YbH1blrhE2Hqy5Aivw2ITw==
X-Gm-Gg: ASbGncuXp/GHQ049+LgV7auKriKDFdbgamEyaP5PZVdnjDHfGsY+FENwSPoojx0kqgx
 vCN9YkTVZ0+1oWDE7JRO2Riy2ljy67YlgJw7UhjqfQ3+ADfZQgdwuTGa3VChToFsbgBjbp5mwPQ
 2or8fTtABJVZifZtDgZimRJG0D0Kl91b49bM0e4vUM7k6zX19dqZ76QRVwXskeFkl9rP47V2qOn
 exfuU1lVCTEvA5hf/MyD6yTQXCKRv5/Fd5Q693jpdiv6jlqm12jhW7vnc8HvvX6ADJetYvzWQHP
 O26RMFa/xLWpKgnZGMySvvzyFEtY+Oqp2sfqM4dllfdVK3GGOrlq+Px+zOiw0NnYJhy6e72i00h
 VrvpPkgJSogleDf1YSig3DkQ/lyCqZd+2mZ6MNA==
X-Google-Smtp-Source: AGHT+IEJsUrJnv3cGlOnBCv0uOpgk93katcBlIdwQqOhnP8cd2w980IRQH5sLfNokhG7rNrAooLOEQ==
X-Received: by 2002:a05:6a00:a86:b0:730:8a5b:6e61 with SMTP id
 d2e1a72fcca58-739c784f6eamr1558483b3a.2.1743575230096; 
 Tue, 01 Apr 2025 23:27:10 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b8acdb4sm9115661a12.59.2025.04.01.23.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 23:27:09 -0700 (PDT)
From: tkuw584924@gmail.com
X-Google-Original-From: Takahiro.Kuwano@infineon.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, pratyush@kernel.org, tkuw584924@gmail.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [2nd RESEND PATCH 2/2] mtd: spi-nor-ids: Add support for S28HL02GT
Date: Wed,  2 Apr 2025 15:26:41 +0900
Message-Id: <473563987fc2580598ba166a53cae6d159424769.1743575001.git.Takahiro.Kuwano@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
References: <cover.1743575001.git.Takahiro.Kuwano@infineon.com>
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

Infineon S28HL02GT is 3.0V, 2Gb Flash device with Octal interface.
It has the same functionalities with S28HS02GT.

Link: https://www.infineon.com/dgdl/Infineon-S28HS02GT_S28HS04GT_S28HL02GT_S28HL04GT_2Gb_4Gb_SEMPER_Flash_Octal_interface_1.8V_3.0V-DataSheet-v01_00-EN.pdf?fileId=8ac78c8c7e7124d1017f0631e33714d9
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index a500fff4775..503dca28b89 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -417,6 +417,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl256t",  0x345a19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl512t",  0x345a1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
+	{ INFO("s28hl02gt",  0x345a1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | NO_CHIP_ERASE) },
 	{ INFO("s28hs256t",  0x345b19,      0, 256 * 1024, 128, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-- 
2.34.1

