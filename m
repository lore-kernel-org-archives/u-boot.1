Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E97C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A33088950;
	Thu, 29 Aug 2024 10:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mbXgnCcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F55888C1; Thu, 29 Aug 2024 10:01:53 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91D5A889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a429so353559a12.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 01:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724918511; x=1725523311; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U54JoKSwBGslVZd5lUbZM+i77nT/yJLQlPO1muIkMKU=;
 b=mbXgnCcjHHhkN6MsaguuKAY9rhSvi4yPXd187anFStWwXr78KTmY27vyt0dAkSAUDa
 8ewM19QstBESeNvCYpHIIuc3Rg/w55uhPwxf/WaPTZK03GDIj0AmFYgPOZAsY0u7Jtis
 AeOPdUq5upnZIPKAxhhzPDX72Itk0dwKpL8TdCr3+kKkmngfNE9nThl9T+aTn+8+gadw
 +xHoUm29W43Q4wl4C2qYzTAYYzFnOiCNjvwBe5WQoIrn3F3NmPd+iEqILeXFzibbD/7V
 il/qcf6iGOY6m2kkDmYlh98bTlJTP5NruXaVJphe5VHTdnerm+xk6jA2NKXFIbD5pr//
 ZI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724918511; x=1725523311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U54JoKSwBGslVZd5lUbZM+i77nT/yJLQlPO1muIkMKU=;
 b=D/MQP5hZ8jDE35+K12X0R7IpsubvO2RSFkXwN5RFRMc/MRldd6OJCY968i/9D29HFy
 VtZukjaCw4wjC1UIzrdiUCvyHepCqCe0ps7zJpphQclXzNPmN6N5ISSkaFlqfm1x/Jh9
 ITon5ASp9fBIoOIw6I77bJoVs0S1/B5KFZleZG+vlG5tWrObXt2HE3fzrRShYbWoevsw
 hjcu4GHDY3KkgibWUzL/4AJxGhabTTvjsnbvXgg8+En3MyvNtSx19nVLBfLNBdR4LoLE
 lz6CRhCpgWzz8f3zG6qwiyTlA/0wxJY0oJaAHGnraTZFQsG+82zFGZWQ8XP6ECRZf3/c
 +ZrQ==
X-Gm-Message-State: AOJu0YxvYSfx32TM9kr1vMvqFI/dgMySG0laBIRnnD67xMspVcgjpv/r
 TnuSsG3YuBilww4dhEK/3rEzEjcr/OaSIzBhiTNJ4CON+8HnDZnHyBG1I10buAkw/dB8zaL3mwk
 +CZzvcxmK6W+XNvLAegtz8frQ5AHQaJ7sYDc=
X-Google-Smtp-Source: AGHT+IE+A39GPSBWTRSCqlHLw9jgNIURCRnMX8f/89tJDV+DCN+ApJ1l4wQstj0QCn4TzvOWsZ9G6f62iXXb3UKaRzI=
X-Received: by 2002:a05:6402:3482:b0:5a1:24fc:9a47 with SMTP id
 4fb4d7f45d1cf-5c21ed85338mr1193272a12.27.1724918510218; Thu, 29 Aug 2024
 01:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <7f33e3d7-e5ab-4c1d-a69a-153a50a6b0c2@Spark>
 <7cbce75d-51fe-4c87-9c90-01e86a06f0fe@Spark>
In-Reply-To: <7cbce75d-51fe-4c87-9c90-01e86a06f0fe@Spark>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 Aug 2024 09:01:38 +0100
Message-ID: <CALeDE9PEMh14rp8paEvhN6pRebxzXonCqidvaTaByHHG2MLgZw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Grub_doesn=E2=80=99t_load_devicetree?=
To: =?UTF-8?B?VG9tYcW+IFphbWFu?= <tomaz@mono.si>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

On Thu, 29 Aug 2024 at 05:14, Toma=C5=BE Zaman <tomaz@mono.si> wrote:
>
> I=E2=80=99m working on an arm64 board with an NXP LS1046A CPU and I simpl=
y cannot get Grub to load a different device tree than the one that=E2=80=
=99s provided to it by the EFI Stub.
>
> =3D> fatload mmc 0:1 $kernel_addr_r /EFI/boot/grubaa64.efi
> =3D> fatload mmc 0:1 $fdt_addr_r /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
> =3D> bootefi $kernel_addr_r $fdt_addr_r
>
> At his point, I get a couple of errors like =E2=80=9Csmmu node not found=
=E2=80=9D.
>
> However, if I, instead of "fsl-ls1046a-rdb-sdk.dtb=E2=80=9D use "fsl-ls10=
46a-rdb.dtb=E2=80=9D, then I get to Grub without any errors.
>
> And this is where I encounter the issue. Because I would like to use a di=
fferent DTB for booting Linux than the one that=E2=80=99s provided by the E=
FI configuration table, I set
>
> devicetree /boot/dtb/fsl-ls1046a-rdb-sdk.dtb
> linux /boot/vmlinuz-6.6.3-arm64
> initrd /boot/initrd.img-6.6.3-arm64
>
> In this case, the devicetree instruction gets ignored completely, and bef=
ore I see kernel loading, the message =E2=80=9CUsing FDT from the EFI confi=
guration table"
>
> Is there a way for me to override/replace the device tree that u-boot pas=
sed to Grub? I tried passing the =E2=80=9Cdtb=3D=E2=80=9C parameter to the =
kernel boot command, but in that case, I get "EFI stub: ERROR: Failed to ha=
ndle fs_proto=E2=80=9D because kernel when booting doesn=E2=80=99t appear t=
o have access to the same filesystem that Grub does.

Why don't you load a new one into memory with u-boot and then grub
will already have the one you want to use and grun doesn't need to do
anything. Something like this on the U-Boot command line would load
the DT and grub and start to boot:

load mmc 0:1 ${kernel_addr_r} EFI/BOOT/BOOTAA64.EFI
load mmc 0:1 ${fdt_addr_r} dtb/${fdtfile}
bootefi ${kernel_addr_r} ${fdt_addr_r}

You'll need to adjust for storage, partitions, file paths etc.

> Thank you!
>
>
> (this is my first time using *any* mailing list, so apologies if this is =
the wrong address to send this question to)
>
> Toma=C5=BE Zaman, CEO
> Mono Technologies Inc.
> +386 30 651 645
>
> [cid:18EB2FEE485A4DD7A1CE716CE14FCBC7]
>
