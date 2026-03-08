Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AF6EA8543
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 19:24:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BBF28063E;
	Sun,  8 Mar 2026 20:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HPB0V6Y8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEF61838BB; Sun,  8 Mar 2026 20:23:59 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBBE380212
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 20:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=flaviu.nistor@gmail.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439c5b40f60so4011836f8f.0
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 12:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772997837; x=1773602637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LImepzwJDT633GLLSEW+g6SjO0Dh3D+PwsD5K2D+yeY=;
 b=HPB0V6Y8MNjYxMwg/8pnNdlYzSdNNvoQiuBAX0VlKLNLJmGf7Enm6f62wDkzPfTdKd
 2ziazwVSuxFLUqXPwmfZ+m1M9TIWcfq8avjDZNf08EbgxGcehpHXxtPPNiusflVSQA7i
 a99FNftyQ7wPT7MLb6zcRm7XrsI97m6EhA7P9PymoEtSVWNSO47WMhXMQetGA8/rPfju
 Z0/Zyisbvv+lX0K2R/QSIGht+jl+5x+QpY8SXx7umWzQGlloubufgtGlF41C54BgtFli
 1Z6zf+IS5Y1P9DM3Ds/ME/Gvmkms2ZgCb/JmcTWPdNIYLo1f6j+n5Bl4th/IgXZ2XFab
 BIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772997837; x=1773602637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LImepzwJDT633GLLSEW+g6SjO0Dh3D+PwsD5K2D+yeY=;
 b=tnH/5y01i2Sr3e2d9FLUMl4Dn5CDX2Xy27j2DADROQnGJZ5H0totb/veLBv6Glh19w
 SttdjCLrGLHOjUmejswrx/P6jy0Ito5RdXFu08WCF6Zk+YqIHsRx3trIv/aho59dCrHl
 JLcog4iEDIt1RUKuVA+5BsTq4ek1CaCCdI0rMSdW3LvPQg0bP7xAjgd2CDyXY07gW6bJ
 g3zR1EDsd+J+ReBMW+EfhJqDbLnqB8t6pPVrBN8EBdKT+udyJ08OuVTwwmtTACxd4eTT
 M//KlPl4tLd2LT7tLVX4IWlz4jic0C5GXGZGy4Pjs9zSjVelQB4jGuIhIgZd5udOsELx
 DJng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1Bqi9v7PJ/3vw2Fnxv8S1SCn9AM1Z0tPuVylWTALVC7iGy0pAqC6NTofKmRC6BuN1aKRgvzY=@lists.denx.de
X-Gm-Message-State: AOJu0YznUh/D7ZcGR7UWrYfBLeTpcr3jxZVpJPHBLwTFMpLmMsBi6QZR
 MYOlt+VHhCem5kaAeaiIORuhvn6QhhD3Ab1EdfEuxCbQjomJWDpnZfJR
X-Gm-Gg: ATEYQzz985cHMBp6TJHbV2P5G3ez4EIJSiFr2i1eOv+VsFTvRSFRD7MozBnGIs/vL8o
 l3bE0mQGJGixqFMfRy4cLxWJJcQg0K7eTBwBwvlHEGzOW8uTbgT7s/7vTlrbIy8RE8GJKhOnqkZ
 JDF7dkBrzhOoKmgtNjP0XNbLQZrTrNgkp3DjO3tL1KFnoZif1VppbHCZ+mhS6JBPPQzfEphR8dy
 S0wKmkP26YQ07W4ZuenF660/iqMwe4SnLUtMiWrt8TWkwDXo/fuLgBePm3efOJo38T3HIz/+iv+
 tV3+YsdzPmpOc+Rz/nEVLCaCMq/WHT/Wsq+OUIbzbXMPMyqr2xHESNmVycBmTlnBTezUBTcNs7H
 vQnRnT5yFAcq1SEJ3BPMsNukTitpo7EJHN3oYZQjpe0cICpRVqCgSgWoCXpQviyIdTjyM8bzORI
 2YoUejITCrbNhCwrYMhGltuqbVhrk1RcSm9L4YpiLTRpd7415i/LpkfiEjuyvoN9xbOVKO4cth
X-Received: by 2002:adf:f4cb:0:b0:439:df33:827f with SMTP id
 ffacd0b85a97d-439df33828emr8444325f8f.10.1772997836955; 
 Sun, 08 Mar 2026 12:23:56 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.232.50])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae3d98asm22157766f8f.30.2026.03.08.12.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 12:23:56 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	u-boot@lists.denx.de
Cc: Vignesh R <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Jeffrey Yu <jeyu@issi.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Christoph Reiter <christoph.reiter@evk.biz>,
 Shiji Yang <yangshiji66@outlook.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: RE: [PATCH] mtd: spi-nor: Add gd25lx128j chip
Date: Sun,  8 Mar 2026 21:23:49 +0200
Message-ID: <20260308192349.36802-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <44d8d5c78d914c27affafd8a32107bca@infineon.com>
References: <44d8d5c78d914c27affafd8a32107bca@infineon.com>
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

Hi Takahiro,

>Hi,
>
>> Add gd25lx128j GIGADEVICE chip to spi-nor id table.
>>=20
>> Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
>> ---
>>  drivers/mtd/spi/spi-nor-ids.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
>c
>> index 3bcb0d7b7ba..b79cbcb2858 100644
>> --- a/drivers/mtd/spi/spi-nor-ids.c
>> +++ b/drivers/mtd/spi/spi-nor-ids.c
>> @@ -202,6 +202,8 @@ const struct flash_info spi_nor_ids[] =3D {
>>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>>         {INFO("gd55lt02g", 0xc8661C, 0, 64 * 1024, 4096,        SECT_4K |
>>         SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_4B_OPCODES)},
>> +       {INFO("gd25lx128j", 0xc86818, 0, 64 * 1024, 256,        SECT_4K |
>> +       SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)},
>
>This device is 128Mb (16MB) that doesn't require 4-byte addressing.
>Is 'SPI_NOR_4B_OPCODES' really needed?
>
SPI_NOR_4B_OPCODES is supported and it works but indeed it is not mandatory.
Thanks for pointing this out. I will send a v2.
>>         {
>>                 INFO("gd25lx256e", 0xc86819, 0, 64 * 1024, 512,
>>                      SECT_4K | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES)
>> --
>> 2.43.0
>
>Thanks,
>Takahiro
