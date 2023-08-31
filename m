Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1399C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD0138660B;
	Thu, 31 Aug 2023 14:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MjX+DwCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2EA8656A; Thu, 31 Aug 2023 06:08:00 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8800786558
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ssunkkan@gmail.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so8945539f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 21:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693454876; x=1694059676; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56RQyKIWsd8kpcaxGIljWlOIf/R2gwH1nmqcYMjfge8=;
 b=MjX+DwCXV1hiN+84+Ly/vAJ+p2SZBF5L26k6Dq29e/4aFMwu3+yr02mkjn56gcPRi/
 SFMRJWddCzNy5qnm8BMkAYUp/iJ6Tz174MZ00WAyNcJL0J3asR888lfaqWJ9GMR7qjCy
 kkb6bGXHIqRfVHEEaA+0pvYGWsPqCPakzF0M+jaBBR9SuDzUiXBMnJ2LGpQCR6SqO7EV
 XErRIsZQCU76+uiXlGcHCjB2lts+9YAgplgd2EjFkfasbZ2ChG42KvjT8OdHgmrMapaW
 hdfyE9UPSrmyln8ePSCxsq/+zuL2XC1Uy2MrekJyYMMknfOzdzsldUkCkmMNLpyDU1Mo
 hsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693454876; x=1694059676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56RQyKIWsd8kpcaxGIljWlOIf/R2gwH1nmqcYMjfge8=;
 b=ZoO1yLQdUbWgyRhJWbIjsTKcAJRaHtIeD32rBOdquR4et96IIazs84WHxZ+heMpFSA
 BUmDEavk0Xc1F78svvpgw54trJVaBc3Yl+cmeO7NOqPULpvYsF7pXXT0vKdG0XhC8+F3
 I4NwKoUpOGwBGmmamNooMtdF9rtaq1ksN7n5AjdYeZZFmPqpNW7BIkqfNHO2wZ50d7Va
 AV6PSuWv+ZKs+ZkMt2IMoKaI61egix92wE3P8IMmTmVd750o7rGB5tNcjHtP94Mps07e
 F4dLWPqfUOwt45J7n3fRj4CWLC8s3ZK7WeECOpGs2oQ34ceSLnDVDP0poM+W6e0mUYrA
 aEZg==
X-Gm-Message-State: AOJu0YwwRkm3sRGwjzlQuzizSRhhRAZXoszOrCLjmT21pYnVnZ+yW8Su
 tB+YWohxDPOP4HEqPFRMdGbCb6Ee2QweHg==
X-Google-Smtp-Source: AGHT+IEoDxer3X6lCL3kOh3R4gDqQMw2K1UhtK6xewSM3Gs0SEJ20A5TKZ0vhLt0HFBgOwNIyI+MAQ==
X-Received: by 2002:a05:6602:2e95:b0:787:8cf:fe82 with SMTP id
 m21-20020a0566022e9500b0078708cffe82mr1543801iow.8.1693454876189; 
 Wed, 30 Aug 2023 21:07:56 -0700 (PDT)
Received: from sun-virtual-machine.localdomain ([103.149.144.245])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a6b5105000000b007835a305f61sm201069iob.36.2023.08.30.21.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 21:07:55 -0700 (PDT)
From: SSunk <ssunkkan@gmail.com>
To: ssunkkan@gmail.com
Cc: chiawei_wang@aspeedtech.com, jagan@amarulasolutions.com, sjg@google.com,
 u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH] Add support for more XMC series
Date: Thu, 31 Aug 2023 12:07:44 +0800
Message-Id: <20230831040744.4520-1-ssunkkan@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABjXDjFvFp33phD2Kwog8oo8H1XsquU7UBGLVLKKaemeawrbrg@mail.gmail.com>
References: <CABjXDjFvFp33phD2Kwog8oo8H1XsquU7UBGLVLKKaemeawrbrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 31 Aug 2023 14:38:51 +0200
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

>Hi Michael,
>Since this is the first time I've submitted code to the Linux community, please forgive me for some of the missteps that I've made.
>I uploaded the incorrect patch file.
>In a previous e-mail you said：
>XMC parts seem to have SFDP tables and they should work out of the box
>without any patches with the generic spi nor driver [1]. Therefore,
>you don't need any entry at all.
>
>I think it is related to the PARSE_SFDP flag.
>The XMC flash part supports SFDP, so i don’t need to add NO_SFDP_FLAGS() macro.
> drivers/mtd/spi-nor/xmc.c | 17 +++++++++++++----
> 1 file changed, 13 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
>index 051411e86339..e78bf11792d9 100644
>--- a/drivers/mtd/spi-nor/xmc.c
>+++ b/drivers/mtd/spi-nor/xmc.c
>@@ -11,11 +11,20 @@
> static const struct flash_info xmc_nor_parts[] = {
> 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
> 	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128)
>-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>-			      SPI_NOR_QUAD_READ) },
>+		PARSE_SFDP },
> 	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256)
>-		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
>-			      SPI_NOR_QUAD_READ) },
>+		PARSE_SFDP },
>+	{ "XM25QH128C", INFO(0x204018, 0, 64 * 1024, 256)
>+		PARSE_SFDP },
>+	{ "XM25QH256C", INFO(0x204019, 0, 64 * 1024, 512)
>+		PARSE_SFDP },
>+	{ "XM25QU256C", INFO(0x204119, 0, 64 * 1024, 512)
>+		PARSE_SFDP },
>+	{ "XM25QH512C", INFO(0x204020, 0, 64 * 1024, 1024)
>+		PARSE_SFDP },
>+	{ "XM25QU512C", INFO(0x204120, 0, 64 * 1024, 1024)
>+		PARSE_SFDP },
>+
> };
> 
> const struct spi_nor_manufacturer spi_nor_xmc = {
>> Correct. If the flash is working with PARSE_SFDP, it has SFDP and
>> all the information of the flash_info table is pulled from the SFDP
>> tables, except for the part name. Therefore, you don't need any entry
>> at all. The flash should just work out of the box. Are you using the
>> latest kernel?
>> 
>> -michael
--
Hi Michael,

According to you, does this piece of my code still need to be modified?

Thanks,
Ssunk
