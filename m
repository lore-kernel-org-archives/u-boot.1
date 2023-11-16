Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BEA7C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 18:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B24BB8718B;
	Thu, 16 Nov 2023 19:45:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="h1hw16uX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91B10869F2; Thu, 16 Nov 2023 19:45:38 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F17862DA
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 19:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50949b7d7ffso1640790e87.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700160335; x=1700765135;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NclU/lKFWgAg6iAQtA9ELsWhnfrZ2qvHxbgeVjH6Aic=;
 b=h1hw16uXof5MHuEA1v3oPdBSrXpVc24HinsbsSLu0LAuflLxgBmltE23kfTLo05i0S
 XTmBomBHJtZCdTz1dMwzPY2TsZN2tWZgtybVDNgVEBSP5oFFaurjKqhUlhFfwIHuPWMZ
 qdF2y/L2jHuxlAymAP6Jsz8kfMxcyn+k9/gDtPgox/2hrYqv0Q6am8yQeVESt3rhoauD
 5Y4h9Udd7hGEBuTsBN7AYebjjb4r+VYrhNJEfb91nQ+bseDRFuJXHWwmnlOsmnuwQjBI
 KzA8/NLrZCdH5pJWGYXJfEv9B7W0brwiRgT35lIG773Rpqgq2kuUEgFfgs17J9g8oHP+
 fl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700160335; x=1700765135;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NclU/lKFWgAg6iAQtA9ELsWhnfrZ2qvHxbgeVjH6Aic=;
 b=rCCjDsiUhXhu46G6NRLE20ZiH+S33MmDWXkP7wkIGuIrc6IxKmIO6KRSTpC00WQsZW
 XawILy7XkT6oZI/gFMWjqt/xA5CwcvBg9k+EF10mS6Ag1ZxNowbzRTTqQPvcJptv1f/3
 woNfQlxNMjpR0sHoY7dwFRSjyQjyLtmham722Ltj6cSPOwMC42Mc3rg1w80AGp3eYldJ
 CYcqMjbl6riAvJqqJ4F/cQyG3VpzqdWmjptgS2lSOWvitzGjE/RpfH7uMyCyf0frP5He
 QEmovIGNeK42gG7PGF29SURuPn2N4rIrYPqwT5O4yL8LnRwyIGfSAolREQ+QyxywZUT/
 nH2A==
X-Gm-Message-State: AOJu0Yy5YqVdFXWROySJdggvZELMF/2Kl2Z9ztSTEaSgyv/P7zFQKAJd
 96UVPz4fqSF9ioEkLTMM3QsJPvs/JET/YqKdcYdf+A==
X-Google-Smtp-Source: AGHT+IEQbPfpd4FSahJDF12niv/rIUTWUnyK3IXE1gZAN1tseJiS3krCJYh72TPk9SEkJoj8TS4PZg==
X-Received: by 2002:a19:f806:0:b0:509:39e3:5268 with SMTP id
 a6-20020a19f806000000b0050939e35268mr2444723lff.59.1700160335010; 
 Thu, 16 Nov 2023 10:45:35 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com.
 [209.85.208.45]) by smtp.gmail.com with ESMTPSA id
 bx23-20020a0564020b5700b00533dad8a9c5sm8084550edb.38.2023.11.16.10.45.34
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 10:45:34 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5480edd7026so1232237a12.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 10:45:34 -0800 (PST)
X-Received: by 2002:a05:6402:268c:b0:53f:72a7:5ae with SMTP id
 w12-20020a056402268c00b0053f72a705aemr3151140edd.12.1700160334135; Thu, 16
 Nov 2023 10:45:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHc5_t2_f5u4Sqm2L2XGAPSgha3EM53RtjL7M25CDyKRnE5VOg@mail.gmail.com>
 <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
In-Reply-To: <25cd1fbe-5ed2-4444-8dc6-8378273d9897@canonical.com>
From: Shantur Rathore <i@shantur.com>
Date: Thu, 16 Nov 2023 18:45:22 +0000
X-Gmail-Original-Message-ID: <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
Message-ID: <CAHc5_t33K1J=mDteE8jTLoLpFonPSKWBgs43Ak748q1WJ4Uv8A@mail.gmail.com>
Subject: Re: bootstd: Support for distro specific EFI folders
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Thu, Nov 16, 2023 at 6:15=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 11/16/23 17:52, Shantur Rathore wrote:
> > Hi Simon,
> >
> > Currently bootstd - bootmethod_efi only looks for the default
> > bootxx64.efi in /EFI/boot folder only.
> > Generally many distros end up putting their bootloaders in
> > EFI/<distro> folders like EFI/ubuntu and EFI/debian etc.
> >
> > In x86 worlds, the NVRAM is modified and new boot entries are added to
> > support these but in the U-boot world the NVRAM variables are
> > read-only.
>
> I guess you are referring to UEFI boot options. These typically are not
> stored in non-volatile RAM but on a SPI flash device.
>

Thanks for correcting me.

> >
> > What would be the best way to implement this?
> >
> > I was thinking of having a "efi_prefixes" environment variable which
> > can be set to "ubuntu debian centos" etc and bootmethod_efi can try
> > all of them. Will bootmethod_efi be able to support multiple entries (
> > thinking of multiboot ) ?
>
> On my laptop I have:
>
> EFI/Microsoft/Boot/bootmgr.efi
> EFI/Microsoft/Boot/memtest.efi
> EFI/Boot/bootx64.efi
> EFI/Boot/fbx64.efi
> EFI/Boot/mmx64.efi
> EFI/debian/shimx64.efi
> EFI/debian/grubx64.efi
> EFI/debian/mmx64.efi
> EFI/debian/fbx64.efi
> EFI/ubuntu/grubx64.efi
> EFI/ubuntu/shimx64.efi
> EFI/ubuntu/mmx64.efi
>
> Obviously each installed operating system provides multiple EFI binaries
> and non uses the fallback file name BOOT<ARCH>.EFI. A value "ubuntu
> debian centos" would not be able to describe which file you are looking
> for.
>
> We already have the U-Boot command line eficonfig and efidebug commands
> to set up UEFI boot options which can describe which EFI binary to load
> and which command line to pass to it. These are considered by the
> existing boot flows.

So, I am building a new RockPro64 based cluster and using Canonical
MAAS to set them up automatically, booting them up using DHCP and
installing them over the network.
I configured an Armbian image using Packer to be compatible with MAAS
and it happily installs it. As part of installation process, a
grub-install is run which installs the grub efi,
this EFI ends up in EFI/debian instead of expected EFI/boot.
To be able to make it boot, I have to add commands to move it to
EFI/boot. I am trying to find a way in U-Boot that would allow me to
skip this step.
With eficonfig if I understand correctly, it would need manual
intervention to create boot entries.

>
> If you are installing the shim-signed package on Ubuntu, the EFI boot
> option for Ubuntu is set up by EFI/BOOT/BOOT<ARCH>.EFI using the content
> of EFI/ubuntu/BOOT<ARCH>.CSV. This is done before ExitBootServices() and
> therefore should work with current U-Boot.
>
> Patches are pending upstream to make EFI variables writable from Linux
> if they are stored in the RPMB partition in the eMMC. See this series:
>
> https://lore.kernel.org/linux-efi/20231107054057.1893-2-masahisa.kojima@l=
inaro.org/
>

Would it be possible to save it in SPI Flash as the U-Boot environment ?

Kind regards,
Shantur

> Best regards
>
> Heinrich
