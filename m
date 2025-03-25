Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EB2C36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278BE81B4B;
	Tue, 25 Mar 2025 03:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lAunnZYj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CE3D81D27; Tue, 25 Mar 2025 03:55:18 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAFA081D3B
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-477296dce76so27015401cf.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871314; x=1743476114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMREPpYmE8Pjtt6QNGzBXe9b0L3CCVDfSinQQW3Rq4Y=;
 b=lAunnZYjsCk4+z3wbKnGMsAjDiOMGXZIIjj9RYZ5KLpKlQsZiOx6SjAnA2+r6jUdIU
 eidTGHN6XhaKJmdgv2nAetJS9BwCVlHpzHtl8s8c/nICZKcwdJy9J04hfy3HEYyjMcTj
 IuLKkhYzkB6TdB/hiso8nlqBN3yFusfMivNnUU9nGSMXZHgwsC+jeLrFft74cftoG5SC
 JsamHYR7c9s1NV+apBSgCeuUaxedoHwXlZ3KHm2uMSGEr+Wuaye1kb9W2dFzzWHQvVnG
 KVnSDMLbFD7yw4IxWsXzQ1IfjX8kV2C06mTANl+tnaZUvLfDddoYTOxU7uZUtkCaIe9T
 nYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871314; x=1743476114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMREPpYmE8Pjtt6QNGzBXe9b0L3CCVDfSinQQW3Rq4Y=;
 b=bjjbMwjwiQrgNcIBGf1chR9B+VplCyKHEFboJp2ejSBguhH4LbZR/epZ5t6Y7kfRz/
 BVj/2z4iODGq1rwZSfdZm6GnKeL6TzzNERTH5ZDigRjC0HN6otITIA0kb3JwrtC2sqAt
 KW3OFp0mbsCwjxseORT6nSIgaQ/6MOT6h09s92SxUV0UQIxCeLjity0xWp/z/4tTvCOg
 yvQi/nPLHryBZIHokH6poIeF/JCvi6HW6Wpvz3/Ln6UCNG1VPbtLsOZp7ahvslKS6epW
 Jc3+vzm2EqmxvMWZTW7WRlWtJ5Hy/jHwduCP78CAr0sHslrzVTVt1xpw2VO259VXki+n
 RFRg==
X-Gm-Message-State: AOJu0YynhnB6lmkkZwMZNVtCV+DqD6yymk4X0bzbtihaPcvcSzJ2r0g4
 0LWrvr5k/QACAb3txdbDwxlYfvxDkk6yRtC8OmCBeafDHMSjZCLpzbjYEg==
X-Gm-Gg: ASbGnctQbQseTafPjQGkPWCG/lZAVY2dxO93eHn5yVR/0DBS0a46noqUhOCUpfKeSlo
 b0sCoVex6/GNQIqUMojSaEXX1Sm1KpIojIofJdnMK9gx1OPKXd14h2Xpqee7Gn4WG9jH74vxH3+
 tB+MXjUfhOSujRB/i/uNGfESorGjaF5P/zTrd22sO1fzCXCgUnMcOrVcQwQQiFbb8JeheyE8iyA
 uY6/NpsuSlN4uQKKkIawuuB6XFSsI6XsFn4twdc6d4qu6yxxs4oeDs5h0fCgniqQlbfuMT60FCY
 sGLTjk5gZaAVa6bA6PrNJXO0FqI4C9AqhWChj5II279+GMKOlyDxp89WvSEFETwyqIyxY0ZlQuu
 5X66Rp9uSR0H29iHkpBw=
X-Google-Smtp-Source: AGHT+IHHlQ2sIHoV1aNFPB1Mn6yI5N1oFtdChd7/myc7cIQrUVuezhQNC35p1Eog26nKur/u70egdg==
X-Received: by 2002:a05:622a:1144:b0:476:9847:7c73 with SMTP id
 d75a77b69052e-4771dd9430cmr231745711cf.26.1742871313828; 
 Mon, 24 Mar 2025 19:55:13 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:13 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 4/7] cpu: imx8_cpu: Print Speed grade if IMX_TMU.
Date: Mon, 24 Mar 2025 21:54:45 -0500
Message-ID: <20250325025452.950303-5-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
References: <20250325025452.950303-1-aford173@gmail.com>
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

Much of the data that is display by imx8_cpu.c is also displayed from
arch/arm/mach-imx/cpu.c, except the temperature grade and active
temperature are only displayed when SoC is an i.MX9. Since IMX9 now
implies IMX_TMU, change this to check for IMX_TMU in the same way
it's done in mach-imx/cpu.c to enable displaying this information
for any SoC with either of this config enabled.
Since additional text may appear due to this commit, remove
the extra space in the message displaying the temperature
grade.

Before:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

After:
CPU:   NXP i.MX8MP Rev1.1 A53 at 1200 MHz
CPU:   Industrial temperature grade (-40C to 105C) at 28C
Model: Beacon EmbeddedWorks i.MX8MPlus Development kit

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/cpu/imx8_cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 39b3c194131..4e1eccaa5b0 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -215,19 +215,19 @@ static int cpu_imx_get_desc(const struct udevice *dev, char *buf, int size)
 	ret = snprintf(buf, size, "NXP i.MX%s Rev%s %s at %u MHz",
 		       plat->type, plat->rev, plat->name, plat->freq_mhz);
 
-	if (IS_ENABLED(CONFIG_IMX9)) {
+	if (IS_ENABLED(CONFIG_IMX_TMU)) {
 		switch (get_cpu_temp_grade(&minc, &maxc)) {
 		case TEMP_AUTOMOTIVE:
-			grade = "Automotive temperature grade ";
+			grade = "Automotive temperature grade";
 			break;
 		case TEMP_INDUSTRIAL:
-			grade = "Industrial temperature grade ";
+			grade = "Industrial temperature grade";
 			break;
 		case TEMP_EXTCOMMERCIAL:
-			grade = "Extended Consumer temperature grade ";
+			grade = "Extended Consumer temperature grade";
 			break;
 		default:
-			grade = "Consumer temperature grade ";
+			grade = "Consumer temperature grade";
 			break;
 		}
 
-- 
2.45.2

