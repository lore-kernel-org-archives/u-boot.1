Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEFEC28B2F
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 00:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3C7819C3;
	Wed, 12 Mar 2025 01:32:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b4m18kd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF08807D7; Wed, 12 Mar 2025 01:32:10 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94F4819AA
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 01:32:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6e8f4c50a8fso47204916d6.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 17:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741739523; x=1742344323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAJ7KCFBjC4aNeP52U7QWpauIQvAoxuxQaAKurp/GSI=;
 b=b4m18kd1+95og89TSU4B/zgUmEfkQTQjkEueiRNLffYKsSjMeST5v+s5WKdcNTlfP8
 HsaANrKKDxw+h4mSdAL8nM5JReFYduQlLiWG955PI08BKLOtpXXGisyVlaeh+rTBxme9
 Xsbv9mIg0iGxWIEYXISpMNgv/vUEP7jjdseMsawPGTKqWkuVputjs2MEBVFAMqNJCrYj
 9FRMGkTWdDRadqmauanhZocFKd1k0dBl5XOt+D4fJ+70JRP37c9BSa669f3M4BhBaoAv
 ggIP5F6WeVN/VSCxnnq0dfQgDj+/4hjPaP8dIHU8t12DhPY2S+bsJH5DiXGENdpdBfdA
 Dv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741739523; x=1742344323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DAJ7KCFBjC4aNeP52U7QWpauIQvAoxuxQaAKurp/GSI=;
 b=EveBJEJO7lRo72pBJA6ooj+vDb67hTBHXFu+N5MG3bAVOs/DQo2Fx+xylfhdpY92C1
 rP/38ICABCmtjiE5gQKwpgIXWBjZAVH9TPk9pPJ+MoZvu2crH2t8XrClUrstGUzyLAkp
 xlLx4agyPSM/EDah6B3AL/HBjF04v/Amf9wf8eqrhWVyaoiFeuazhsAsA2P6ehvFywCb
 QpC/35X0X82sABkimYx1KP5ed83BNhXcOP3avD9d6u08FxbmqmzocWKsC6+n3AQ58T15
 IEJ5A38iOXX+1GzN5E5tsu6yCMB7Efnmg5uzutBngt0xUjwyxTrSO7+jbdYGlJsEu7jL
 muzA==
X-Gm-Message-State: AOJu0YzsI1mqJDyGSFlbt5gyC6EH//kzwDqBPSvvqq3CpT4E//amEFzv
 6uiK7un3pe4aesGOFv7MXqITBSBa+4s/c648CY9bdLs3J0awBRzfldE/tg==
X-Gm-Gg: ASbGncsQALpUDWe8e+EDRHpOPEKRWlpP0v4fRrf+NsMOpT9zCTImsM9hxTR13PfN0wZ
 +FZPcqzKAN/piFQ6Swdd8baUBvRUPBYiBvjIqsQmhxCbsgZPqKrVZ2XrFQeeqsaXo8zEuu/+rbn
 w9TgXenrD+w9RN8Q9kZy7K2WRdlK3Z/i8uRVVPvKu5wCDVw/6zwQZ/JKm5Z1tfEzin6StZrFQa3
 F2r78z1pRObTde6HBtJ2Uy+WBGbzqAaPR2QpBrqQzhfcqvvaDv5yOFeirj61vXBP15IUE/63GMr
 hInvU81r5zLMMhRcBEMqt+0dGSmpTLGRcIo/wtSjjW23ZrnaKi6IcUmTVWTLhslI1uzKTZqIO8F
 HGliuX1AJmTJyIiIPq7M=
X-Google-Smtp-Source: AGHT+IFLdSudVnQtI+Txilz/v8DzYlnHGuQq76TmDNDEHJT/kZFLcbcWwKq2hfwYJw4IuIaAr7VuDQ==
X-Received: by 2002:a05:6214:dcf:b0:6e4:4484:f356 with SMTP id
 6a1803df08f44-6e900670f73mr253662266d6.33.1741739522851; 
 Tue, 11 Mar 2025 17:32:02 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b798sm78025286d6.80.2025.03.11.17.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 17:32:02 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tim Harvey <tharvey@gateworks.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH V2 08/10] clk: imx: select SPL_CLK_COMPOSITE_CCF when
 SPL_CLK_IMX8MP
Date: Tue, 11 Mar 2025 19:30:28 -0500
Message-ID: <20250312003041.110023-9-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250312003041.110023-1-aford173@gmail.com>
References: <20250312003041.110023-1-aford173@gmail.com>
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

If SPL_CLK_IMX8MP is selected alone, it causes a build error.
The clock composite is required when using the clock framework, so
select it when SPL_CLK_IMX8MP is enabled.  This is already being
done outside of SPL.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 56d893e0579..d17a54fb9b3 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -60,6 +60,7 @@ config SPL_CLK_IMX8MP
 	depends on ARCH_IMX8M && SPL
 	select SPL_CLK
 	select SPL_CLK_CCF
+	select SPL_CLK_COMPOSITE_CCF
 	help
 	  This enables SPL DM/DTS support for clock driver in i.MX8MP
 
-- 
2.45.2

