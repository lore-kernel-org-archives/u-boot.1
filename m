Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F743C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:17:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AE34889A2;
	Tue, 13 Aug 2024 14:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kaXr3X3s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BA6889C3; Tue, 13 Aug 2024 14:17:14 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 184D388997
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6bf42a563c8so10174106d6.1
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723551431; x=1724156231; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b9ZQIz4bEDQXTiKRpoXBdjjw8S3SQDwMBiRt+b8/3UA=;
 b=kaXr3X3sKRT3UQKan2HIYadJdBukBorkze4Y4ejS6ct5BWLA3/lcw+dgNxf7jEme//
 ymHpRMYJcKqI+oHrp/B6T35mqyNe5TK3cpyMUvhIvZU9skfN4ALbvudeX5y7CsjL8ICX
 60MRrTPGMUs3YN5mmbNlO8JQKP080xe+2wEIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551431; x=1724156231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b9ZQIz4bEDQXTiKRpoXBdjjw8S3SQDwMBiRt+b8/3UA=;
 b=txDWqkbPkSTZXtwAa23QcObnbXXsan6UETo/4hDF9HFCR88SYjQlsfwRUqqiPjeVKA
 Lieq7rC7H49TgF7T/fgO2LZvQHXSXsZ/fGTuUuCEvgzJpg8MHcYUA+1f7U+yM3tbBTLO
 CKWfMD0EYvuWmHWApIdFuu24B2VgzVXSPbjuJA0/xdoZ3mX0igMrVvgSo6foBTWv6ixA
 tbwfCay14DS1opjLFV1H1Comkm2BnrIB+c7doXk3EufElyiPbqqX4fVYY5W7cmEvDhvA
 KkR/d5uW/ehN+nd4T3tTLuQH3llEwPlfUb6NhVQr8oIWyROtznlT7MiYHh5AiTuaGXAt
 4AtA==
X-Gm-Message-State: AOJu0Yyl105bytwcoA8WkBe9rnpcqG0Ogw3KGVZmyFT2Y/dGN2UwLwvA
 oE7NgvTcitWIkPTV+L81S7gwq2yfkoQZEAAXX+iUAt+d1yYTon/fzPZBXnmLXkhOAVfTLk4HJmc
 nimuj+0C8IpBMmagRXgHkYX4XCfvfpDsP6qey
X-Google-Smtp-Source: AGHT+IEARfGYVjOgtLFUQl9rHgSvIuWPDikN0IV9glM2LaHXvALkoSZuMcgvjwv0/okDLPj2ZLUcA4OfdgmS3lRbsvo=
X-Received: by 2002:a05:6214:2e4a:b0:6b2:da7e:5cb7 with SMTP id
 6a1803df08f44-6bf4f66c465mr46044136d6.5.1723551430979; Tue, 13 Aug 2024
 05:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240811122924.4035982-1-sjg@chromium.org>
 <20240811122924.4035982-2-sjg@chromium.org>
 <350b4bdb-4b78-48a1-9c21-b4d968f60500@cherry.de>
In-Reply-To: <350b4bdb-4b78-48a1-9c21-b4d968f60500@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Aug 2024 06:17:00 -0600
Message-ID: <CAFLszTia3FsQ2DQSaOC9NEmZ5RFVEQ9P1wDDjPyOnnmk7mt8cA@mail.gmail.com>
Subject: Re: [PATCH v3 01/15] configs: Resync with savedefconfig
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

On Mon, 12 Aug 2024 at 03:05, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 8/11/24 2:29 PM, Simon Glass wrote:
> > Rsync all defconfig files using moveconfig.py
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   configs/am62px_evm_a53_defconfig           | 4 ++--
> >   configs/am64x_evm_a53_defconfig            | 6 +++---
> >   configs/j721e_beagleboneai64_a72_defconfig | 4 ++--
> >   configs/j721e_evm_a72_defconfig            | 7 +++----
> >   configs/j784s4_evm_a72_defconfig           | 4 ++--
> >   configs/kmcent2_defconfig                  | 1 -
> >   configs/kmcoge5ne_defconfig                | 1 -
> >   configs/kmeter1_defconfig                  | 1 -
> >   configs/kmopti2_defconfig                  | 1 -
> >   configs/kmsupx5_defconfig                  | 1 -
> >   configs/kmtepr2_defconfig                  | 1 -
> >   configs/pg_wcom_expu1_defconfig            | 1 -
> >   configs/pg_wcom_expu1_update_defconfig     | 1 -
> >   configs/pg_wcom_seli8_defconfig            | 1 -
> >   configs/pg_wcom_seli8_update_defconfig     | 1 -
> >   configs/qemu-xtensa-dc233c_defconfig       | 1 -
> >   configs/socfpga_secu1_defconfig            | 1 -
> >   configs/tuge1_defconfig                    | 1 -
> >   configs/tuxx1_defconfig                    | 1 -
> >   19 files changed, 12 insertions(+), 27 deletions(-)
> >
> > diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
> > index 87005d03dee..30d48340249 100644
> > --- a/configs/am62px_evm_a53_defconfig
> > +++ b/configs/am62px_evm_a53_defconfig
> > @@ -180,5 +180,5 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
> >   CONFIG_SPL_DFU=y
> >   CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> >   CONFIG_EFI_SET_TIME=y
> > -
> > -#include <configs/k3_efi_capsule.config>
> > +CONFIG_EFI_CAPSULE_ON_DISK=y
> > +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
>
> Not sure this is desired?

This patch was sent by mistake and should be ignored. Sometimes I do a
resync at the start of a series so that the following patches are
correct, when they use savedefconfig.

Regards,
Simon
