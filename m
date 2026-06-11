Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C91CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD3A38491C;
	Thu, 11 Jun 2026 14:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Rrf+Whv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB728839A8; Thu, 11 Jun 2026 09:14:49 +0200 (CEST)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5DFB80086
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 09:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 401F44E42E16;
 Thu, 11 Jun 2026 07:14:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F0DAD5FF03;
 Thu, 11 Jun 2026 07:14:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 12AE3106B9E11; 
 Thu, 11 Jun 2026 09:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781162085; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fwvH1w3lCcEGtOar+tfj/2dOEEahEG7W1i8XO6x9wIo=;
 b=Rrf+Whv1lcwbkl5AQa0Ecp3Oo7Q7QCRVLRMx2XETmdQC83NPpMsHxaIoz5xJP1xIZoSFkp
 J0cDdgrCBTbnqX7vvdbajN3sWggBG8OSElK9N3VBe3r0mRNVyhZ6/2XQya6M8jhUS0w8qC
 9m6mMfo0e3O2kGehFTKJVipTJ6dGO3V+lkZuxql/XwaRThTyZpdkIUvdospOLcgJK7I0cH
 lgXAoZtBsFiOvmdz23K1NVl37pFDU2aEOEu1N7QR45RuQizWeOlgmtknY1kAqVSQIwQ5ay
 GaIDteDwWyb/Am4VX+B1SwF62oPyLxu0KXE2lN0R1DVWgb6paL9X18r2oFmXqA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: <Takahiro.Kuwano@infineon.com>
Cc: <weijie.gao@mediatek.com>,  <u-boot@lists.denx.de>,
 <GSS_MTK_Uboot_upstream@mediatek.com>,  <trini@konsulko.com>,
 <vigneshr@ti.com>,  <marek.vasut+renesas@mailbox.org>,
 <tudor.ambarus@linaro.org>,  <jeyu@issi.com>,
 <christoph.reiter@evk.biz>,  <yangshiji66@outlook.com>,
 <bernhard.messerklinger@at.abb.com>,  <vaishnav.a@ti.com>,
 <prasad.kummari@amd.com>
Subject: Re: [PATCH v4 7/7] mtd: spi-nor-ids: Add support for Winbond
 W25Q256JV-M/W25Q512JV-M
In-Reply-To: <87zf118sjw.fsf@bootlin.com> (Miquel Raynal's message of "Thu, 11
 Jun 2026 09:06:27 +0200")
References: <cover.1779678003.git.weijie.gao@mediatek.com>
 <8d3e9a4b2106b82d9aa15c2abf8b93b3638c11b4.1779678003.git.weijie.gao@mediatek.com>
 <d65a58e9c28f421397933994341e52b8@infineon.com>
 <87zf118sjw.fsf@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Thu, 11 Jun 2026 09:14:40 +0200
Message-ID: <87qzmd8s67.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 11 Jun 2026 14:44:23 +0200
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

On 11/06/2026 at 09:06:27 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> Hello,
>
>>> @@ -585,6 +585,10 @@ const struct flash_info spi_nor_ids[] =3D {
>>>                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NO=
R_HAS_LOCK | SPI_NOR_HAS_TB) },
>>>         { INFO("w25q128jv-m", 0xef7018, 0, 64 * 1024, 256,
>>>                SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NO=
R_HAS_LOCK | SPI_NOR_HAS_TB) },
>>> +       { INFO("w25q256jv-m", 0xef7019, 0, 64 * 1024, 512,
>>> +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NO=
R_HAS_LOCK | SPI_NOR_HAS_TB) },
>>> +       { INFO("w25q512jv-m", 0xef7020, 0, 64 * 1024, 1024,
>>> +              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NO=
R_HAS_LOCK | SPI_NOR_HAS_TB) },
>>
>> Same as EON chip case in another patch.
>> Looks like this issue existed in the first place. We need to rework lock
>> feature to support other vendors' chips.
>
> Isn't this file completely deprecated?

I once again didn't identified that this was in U-Boot as subject
titles are identical. Please disregard my previous answer.

Thanks,
Miqu=C3=A8l
