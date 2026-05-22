Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DFECD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 06:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C329846E2;
	Fri, 22 May 2026 08:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="HuG7fAcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52DD2846EC; Fri, 22 May 2026 08:24:44 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EB968460E
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 08:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b936331786dso890934166b.3
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 23:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779431081; cv=none;
 d=google.com; s=arc-20240605;
 b=SMWaU0LdI6Id7kCygwhpBeMzOlsdybz3CyIlPLdAoUtCURg03rb7TLVTBmVk+KtDP+
 9Ib8hCFPNLHVYg5PKj1ZOUgfO/GhGYfaww+0eN3zMmUaR7cLkzjaInzHKohwSei/QBGl
 Li4Joqh444HGlS44ICUh0CiN9XfTJ6kjEldfLpOuzCjV1CDo7O4HVT7puRX1Fep3aQjo
 FMedkrLfVM7nbn73fL9vybyQ7vbVQDmyo/etYNPj3W+sfpytVTn3V0OKwJ9CnIyO82by
 3ehP1sFFw0hxFHUB5IeM+FA5pV+dZewQGFAqrQqnPsGAlplPYh41gu1jrp68n9zcFnu2
 Tynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DVTgy4DfXHN1kJpi27WmgF6kJgPgtA3RF+g8NWqQ5oE=;
 fh=0/gvq/+QaS3VrydjSvrrwUZQBls0jUtJOwnAzRn6Od4=;
 b=DC2DC97SCjob8/EoKu2w1zeCyIyGv/PsC0iMx9Oiizz21Mv8eIR/rHsLt4lzqUvqL1
 lf9btX/8tRxu3lgl+Bg6O9jcMxmtrTyaAjS4n09LloR1KmklCb3DPSgYMP1eZN3gtkeb
 LFAxRNXa2DxhMUECpNPIICrM/bHgyQ9ZwcDv5Dlwil37RP4Flzf1B61lh/6MF/t574e4
 +ocm/gOtkFh14mSZQh7VoDx+LbT0J6GpjV/6JU1kfx5xm2U4lduhUnWBQ3qgNhnak9Qn
 1QvgIvm6e7vYhmGMeja5CCTBp/y68FR/TVDvHVrikzmC76xiH9Y8n6Q93weaMZQbw2xS
 xzNg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1779431081; x=1780035881; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DVTgy4DfXHN1kJpi27WmgF6kJgPgtA3RF+g8NWqQ5oE=;
 b=HuG7fAcLtRjILjnGeZqoM/KP+2mQ9XXhQy7cNOACjb9MXIZ0A8KZoYOa0Y13rthOfe
 2gJhrFHr/MwNNfsb+VGOJToH7SSLFgwL3DOntNYSGihdj+01yd5SwuZuWIOTPozcygwu
 tm6qDElowTScD+rWq05QMTAVFsx9fp0RXz2qSplLQKPNsBiiG+SubiyzXnkm6hxEDFT6
 GM4TcFkVSxVY4nnkF57Z5PXsbCMx7Lm3YKOaSjSrxEzyYmBviQrAD5iQwX/arMc7n4nA
 wzkO83znNRVcMXaS0y6cf/5Ckt9z8dZZOflvhQ1FN0QIvhou7K4pbuFqmPBWGi+6W98K
 EYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779431081; x=1780035881;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DVTgy4DfXHN1kJpi27WmgF6kJgPgtA3RF+g8NWqQ5oE=;
 b=S+6uiIbYOgaakFzp6xsfpb5aDPKEiPr7OpTeJZroGWBF//SZJ6e/PGuSYIprNAXcmw
 aMGqF7T+IpAGyJgLeyPLW77Xf46cTcYNE8psa6ALArALRVkQXm3KWQO1GZ0nQi8krM8A
 pYMPHoN3crvCgEfmgIM/AQpRa34M+ldbwofNOMtGM5p+WoufXATjga4n1LXLuYtQifiQ
 tdp3sPzU0qnsaMhIi8ev7NAFzveWWpxKaQToxvfZfVUG3jjxrm6MfbS0zUZpVOqKwT3q
 n6Xjl5LGN8zacWHBNjVDko8yARAYH9ln9YhpOVHJushk8XDqL7cb8kb37JR8NySz7WzH
 ZwWg==
X-Gm-Message-State: AOJu0YwccUIfFaZniAsWdUcBbDvqatLoCJ9h73+sHc7P47y+qj/MgI58
 SubhKCVjXJE2X0rLwahKGElUP9EIewVLeWQHMj+FQDDNBO5JiGb2pdy1mG7qL+ed/Ms8ycYfVcS
 WjCtmXOhBp1z4JCB21JPSakX3JuPlymPDYbzNKu3rBQ==
X-Gm-Gg: Acq92OGEa1mI1xUN6myIztHCtmWVbcH2Tzoahmkv0X6xBcWpWn/ab8cjlSagBjdvVzu
 r1Apzyc97tKXsOjz9drlVaBSH/f6RHoak09Q713deUB23sbqx6WBEKEA9aB3fxUond6qcsNpl2Q
 qpXQd4cuh2WbHiQnvVSDDdcUAekfmMdMLSjkNcge7BTJ8JGRwVqXXcd+HXO1SZ++sZdu7O4TbPg
 YyqPC1xV6AchwZdFxjOwPNAx/Twm/4nmG/vDkqf4fFGI1iUFaJffFoIgYxw7HCmTyAkz+ghS1qg
 s+OwbaWp
X-Received: by 2002:a17:907:2d06:b0:bd8:fc1b:5e63 with SMTP id
 a640c23a62f3a-bdd261db4b8mr146247066b.34.1779431081362; Thu, 21 May 2026
 23:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
In-Reply-To: <CAFLszThpwTPppm9AyvC75R6rpEqngEgzYgWWpy2gyJTeQUDK0Q@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 22 May 2026 10:24:27 +0400
X-Gm-Features: AVHnY4KMsziX73LGr3BOpJwMKEwRGXsIOMKwotJnJ0kv__TfZba68P2LICERZrc
Message-ID: <CAKTNdwEm-P5z7tzpT3ViFJkHCqqmdeRLXO0LRAUg0ediANFgQQ@mail.gmail.com>
Subject: Re: Friendlyelec NanoPi M5
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

On Fri, May 22, 2026 at 3:22=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi,
>
> I am trying to make Friendlyelec NanoPi M5 (RK3576) work with
> mainline. I found the note about needing a workaround so have tried
> kwiboo/rk3576 at
>
> https://github.com/Kwiboo/u-boot-rockchip.git
>
> I am building like this:
>
> $ ROCKCHIP_TPL=3D~/dev/rkbin/bin/rk35/rk3576_ddr_lp4_2112MHz_lp5_2736MHz_=
v1.09.bin
> BL31=3D~/dev/rkbin/bin/rk35/rk3576_bl31_v1.20.elf um build
> nanopi-m5-rk3576

FWIW, upstream TF-A master branch works well as BL31 on RK3576, though
it's most probably unrelated to the issue you're seeing

> Image 'simple-bin' is missing optional external blobs but is still
> functional: tee-os
>
> /binman/simple-bin/fit/images/@tee-SEQ/tee-os (tee-os):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Image 'simple-bin-spi' is missing optional external blobs but is still
> functional: tee-os
>
> /binman/simple-bin-spi/fit/images/@tee-SEQ/tee-os (tee-os):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> $ dd if=3D/tmp/b/nanopi-m5-rk3576/u-boot-rockchip.bin of=3D/dev/sda seek=
=3D64
> 18579+0 records in
> 18579+0 records out
> 9512448 bytes (9.5 MB, 9.1 MiB) copied, 1.99658 s, 4.8 MB/s
>
> I get no serial output at all booting from SD card. Is there a special
> trick I am missing? I have confirmed that the Alpine Linux image works
> OK.

Dumb question: did you flip the switch on the back side of the board
from FSPI1 to UFS/SD?

If yes, then having no serial output at all most likely means the
boost.bin trick from Jonas' WIP patch didn't apply, because the DDR
trainer unconditionally spits out some logs on the debug UART during
early init.

The SD card might also be finicky, so if you happen to have an SPI
flash equipped board then you can flash U-boot there instead via
Maskrom. Just remove all other storage, connect a USB A-A cable to the
top USB 3.0 port, and power it up while holding the maskrom button.

Then:
rockusb download-boot rk3576_loader_fspi1_v1.13.100.bin
# note the zero below, because u-boot-rockchip-spi.bin already has a
64-sector offset baked in, unlike u-boot-rockchip.bin:
rockusb write-file 0 u-boot-rockchip-spi.bin
rockusb reset-device

Loader binary can be assembled from rkbin blobs, or alternatively
taken from e.g. here:
https://dl-linux-images.flipp.dev/u-boot/u%3D1afdc52186635bb599642064ee7c23=
f539b73e3c/rk%3D495eec7a93220b1269e915e684c5667250462a3d__tfa%3Dfc3691b5022=
abd9feba6c37330005b7437cccf9f/nanopi-m5/rk3576_loader_fspi1_v1.13.100.bin

rockusb tool: cargo install rockusb --example rockusb --features=3Dnusb

Best regards,
Alexey
