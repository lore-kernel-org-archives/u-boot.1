Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A24C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFC088582;
	Thu, 27 Jun 2024 10:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eWVBaHSA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F6688579; Thu, 27 Jun 2024 10:30:00 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12B61884A7
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ed5ac077f5so21046131fa.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476998; x=1720081798; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JfQhvNgKcrCfr+fuDoJ/yQIZ0hGftxiA34nh3+CI+jY=;
 b=eWVBaHSAMqqR30Miu5lFuGKHw5kx3RrN2/K28syGlrqdUruTjN2KR62+/mwEVpJsek
 JChiU6c89haiLfNxG7ivg53URVsOltgZy67YsqIQJpm/6lOaXBs7+pFa4RCa5wjV+6cc
 RIYvBgB6trs2ollVIMnQmeieDTthOPJ0zoEvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476998; x=1720081798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JfQhvNgKcrCfr+fuDoJ/yQIZ0hGftxiA34nh3+CI+jY=;
 b=C9rDT1CuhvlI2/bIahkDgLHARM49H5yusbGpokdoXDj/zZSgfir5QS5XH8MTZaN///
 GF3SC/63YaySgS/RlPbF/iUsAHRcmdFfS5z3Vj/I83ksVGBoDnbvdJ82qY9ZGVCK1P5H
 hMi0umh+p2Kcpq6o1O7CdfcjzajA35smmua0z2PDw8gMX3BmFCxvFw/N1gkMjU3hhyHe
 00Zz7lsgd7VtrqzCaQj3U7qpnWAGWibKJoh6XZbbCexSZMqZF0stXmlSNOvws1gRo8Bs
 Q0FxP0iZpXmeFPjFY3uSGSlhlAGJwFDCqp94gGPEeW05h3zWrWgFMV0mcbssafzMPUo/
 wyvw==
X-Gm-Message-State: AOJu0YxPmX1zFqfz2f5M+qiEA5tfui8bPCimBNrsuQDHf92cp8BOe1xW
 ZWmSk3xRRgmz5YNR1UY8PYh8bZSzY0NKlNsbvKpS+7g62UtehzS7IEzqhvTXGZ2SZeIZMO9NXAn
 78w==
X-Google-Smtp-Source: AGHT+IHxX05NrfrVHEjKR4/B0yW1+GfMcEx91OOZH8usdCVhxy1i2ezzOc7kBI6OBaRwOm2CH/naBQ==
X-Received: by 2002:a19:7612:0:b0:52c:d639:dd4b with SMTP id
 2adb3069b0e04-52ce06442eamr7522871e87.23.1719476997895; 
 Thu, 27 Jun 2024 01:29:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v6 3/8] x86: Set a board-size limit for chromebook_link
Date: Thu, 27 Jun 2024 09:29:44 +0100
Message-Id: <20240627082949.357089-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

Set a size limit for this board so that we get a build error if it grows
too much.

Note that the limit is approximately, since it does not include the FDT,
microcode and fdtmap, which can change in size. However this board is
fairly stable, so overflowing this limit will likely result in the image
not fitting in the ROM space available for U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v4)

Changes in v4:
- Add new patch to set a board-size limit for chromebook_link

 configs/chromebook_link_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/chromebook_link_defconfig b/configs/chromebook_link_defconfig
index a9f91dd9b26..1a72fd178a8 100644
--- a/configs/chromebook_link_defconfig
+++ b/configs/chromebook_link_defconfig
@@ -15,6 +15,8 @@ CONFIG_DEBUG_UART=y
 CONFIG_HAVE_MRC=y
 CONFIG_SMP=y
 CONFIG_HAVE_VGA_BIOS=y
+CONFIG_HAS_BOARD_SIZE_LIMIT=y
+CONFIG_BOARD_SIZE_LIMIT=630000
 CONFIG_FIT=y
 CONFIG_BOOTSTAGE=y
 CONFIG_BOOTSTAGE_REPORT=y
-- 
2.34.1

