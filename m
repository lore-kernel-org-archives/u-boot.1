Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F85E668A2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 10:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EDE89A09;
	Mon, 25 Nov 2024 11:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Nh5ib28F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111F689A2E; Mon, 25 Nov 2024 11:51:10 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D8E899F1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 11:51:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ldevulder@suse.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3825a721ae5so2299625f8f.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 02:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1732531866; x=1733136666; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xqNxI/nVKaqMmqPh29cYJGYwfRDMT3/CznsGfstRxkA=;
 b=Nh5ib28FkMbuolBcWj066Ybgl41MoRWgUe8OodSnwVoWZZtWRwLJ6sI3VbYtLdN2do
 Bgt4kUN0uutzelYzhkb045CE+BcKGAgx3nSxBHgZCxHDY4kRisWVk1MP2spdK8GMYBvg
 woLvm8p00UIRt0WwQinozK2Vj48Fs3SS/Yl5JaTo4LO3PAEzkFQB6kOMP4sK59Pxd6hB
 UBs1KOHH4smOtCfKaYaZqPEYFsGVpJmcJy/qTcct77NpJuckAiNBGi6gEm9mzVnNHQKE
 iwjV0FIIzzRlkikTy3L08TrpHV6Iv8Cy9WyzBtf9GMm4oGVyirdPcantUrVjy6mcgaBw
 Ghjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732531866; x=1733136666;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqNxI/nVKaqMmqPh29cYJGYwfRDMT3/CznsGfstRxkA=;
 b=G+ox8/pXsahc5XT+3XxWeM977qhjgvy37KAyRHLZHQNtfYEnw41FuoElVjVe0Lf/6x
 k8ywmfpC/GNo3qGXYQN/MeoJgQAIgM3KQ+MqW/7Tua61sKzTVTGxM/2wAVzdaRygvYky
 1dSudbyQQ5TOLJYLcqduvaoLjLUz2XjkTnnvMhfwBdcacjtd3MbHhD0RA7z/IbF8rR6i
 dHxYoHuCxVlAPlUhylo3417JEaZuNEM5TU5rFGtGrcT+WQHiS7L8485EWVjSN+PO4cRu
 SF4ygvUj8BKpu/WcnLilT3VK9x1m1fmTvzREiU3yavGfwHyLZo+BMkQvh9XD4aC7dl6J
 JX6Q==
X-Gm-Message-State: AOJu0YzedjL6tiExsaMtlF62LZwg2nfE6JyG0wuPBrbPPtlMo35j344J
 z47rl6k8L0XMjzWBpFzKgiXvGCOsmfUcG2DNEYyZ87gFOUBE3u2I1NQXk5WUOVgnPfRI9BJhZNw
 i
X-Gm-Gg: ASbGncudm9KsOHNwXe9PS2z91bi7vjH48fB7hJWlC3ycN0C8tGGOXRnG7zrqO1E+kd/
 saGDNjkD/EUe4VNuLqlKbOMYYg165EuHxJXt5tT1lD0LKwPMr8GjVV9q/RQvVpHfy+pCU69vHMR
 xuux23fYiIkS91yultbomJzxFczBdj2RjnyNlrVZW3fU75gAoi46Kh52T9OpjoNE3MXqmbirC2O
 19lj1sloqjD9/rf7wavX1RYbv5MafcX8X4eYd/jjl9S38mX
X-Google-Smtp-Source: AGHT+IHdOGxFczEfg0GGq4Pw7mojrNPTcdes/3mrrnli/FF5weqqpg3/5uXcZqvsqfQOCHX7JeiboQ==
X-Received: by 2002:a5d:47ab:0:b0:37e:eee5:80dc with SMTP id
 ffacd0b85a97d-3826060db5bmr11141078f8f.28.1732531866194; 
 Mon, 25 Nov 2024 02:51:06 -0800 (PST)
Received: from [192.168.4.7] ([82.66.145.28]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825faff9cdsm10062903f8f.28.2024.11.25.02.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 02:51:05 -0800 (PST)
Message-ID: <ea069f71c6dd577eeca10279ae1ae715011f1003.camel@suse.com>
Subject: Re: [PATCH 1/1] configs: visionfive2: enable CONFIG_DISTRO_DEFAULTS
From: Loic Devulder <ldevulder@suse.com>
To: E Shattow <lucent@gmail.com>
Cc: u-boot@lists.denx.de
Date: Mon, 25 Nov 2024 11:51:05 +0100
In-Reply-To: <CANV2PTPnutTi6nZ2Nq3UvuZbPr4pedB1vo6ZWtQj4+Cif3diYw@mail.gmail.com>
References: <20241125093908.50903-1-ldevulder@suse.com>
 <20241125093908.50903-2-ldevulder@suse.com>
 <CANV2PTPnutTi6nZ2Nq3UvuZbPr4pedB1vo6ZWtQj4+Cif3diYw@mail.gmail.com>
Autocrypt: addr=ldevulder@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 
MIME-Version: 1.0
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

Hi!

Oh sorry I didn't know that it was already here before... Thanks, I will tr=
y the patches then.

Just one question: does this means that we will not be able to "easily" loa=
d a different DTB like we
can with distri_defaults? I know that we can always does this with u-boot c=
ommand line as well as
with Grub but it's not so easy. But maybe it's handled by OF_UPSTREAM, but =
I have first to read all
the patch series ;-).

Loic

On Mon, 2024-11-25 at 02:40 -0800, E Shattow wrote:
> Hi Loic,
>=20
> On Mon, Nov 25, 2024 at 1:48=E2=80=AFAM Loic Devulder <ldevulder@suse.com=
> wrote:
> >=20
> > Supported boot device types are MMC, USB, SF and DHCP.
> >=20
> > Signed-off-by: Loic Devulder <ldevulder@suse.com>
> > ---
> > =C2=A0configs/starfive_visionfive2_defconfig |=C2=A0 1 +
> > =C2=A0include/configs/starfive-visionfive2.h | 29 ++++++++++++++++++++-=
-----
> > =C2=A02 files changed, 24 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_=
visionfive2_defconfig
> > index 20f89ae6796..e817e63858b 100644
> > --- a/configs/starfive_visionfive2_defconfig=C2=A0=C2=A0=C2=A0=C2=A0 "
> > +++ b/configs/starfive_visionfive2_defconfig
> > @@ -41,6 +41,7 @@ CONFIG_SD_BOOT=3Dy
> > =C2=A0CONFIG_OF_BOARD_SETUP=3Dy
> > =C2=A0CONFIG_USE_BOOTARGS=3Dy
> > =C2=A0CONFIG_BOOTARGS=3D"console=3DttyS0,115200 debug rootwait earlycon=
=3Dsbi"
> > +CONFIG_DISTRO_DEFAULTS=3Dy
> > =C2=A0CONFIG_USE_PREBOOT=3Dy
> > =C2=A0CONFIG_PREBOOT=3D"nvme scan; usb start; setenv fdt_addr ${fdtcont=
roladdr}; fdt addr
> > ${fdtcontroladdr};"
> > =C2=A0CONFIG_SYS_CBSIZE=3D256
> > diff --git a/include/configs/starfive-visionfive2.h b/include/configs/s=
tarfive-visionfive2.h
> > index 049b0a06301..7f187307ffe 100644
> > --- a/include/configs/starfive-visionfive2.h
> > +++ b/include/configs/starfive-visionfive2.h
> > @@ -15,14 +15,29 @@
> >=20
> > =C2=A0#define __io
> >=20
> > +#ifdef CONFIG_DISTRO_DEFAULTS
> > +#define BOOT_TARGET_DEVICES(func) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func(MMC, mmc, 1) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func(MMC, mmc, 0) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func(USB, usb, 0) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func(SF, sf, 0) \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func(DHCP, dhcp, na)
> > +
> > +#include <config_distro_bootcmd.h>
> > +#include <env/distro/sf.h>
> > +#else
> > +#define BOOTENV
> > +#define BOOTENV_SF
> > +#endif
> > +
> > =C2=A0#define TYPE_GUID_SPL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "2E54B353-1271-4842-806F-E436D6AF6985"
> > -#define TYPE_GUID_UBOOT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "BC1=
3C2FF-59E6-4262-A352-B275FD6F7172"
> > +#define TYPE_GUID_UBOOT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "BC13C2FF-59E6-4262-A352-B275=
FD6F7172"
> > =C2=A0#define TYPE_GUID_SYSTEM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "EBD=
0A0A2-B9E5-4433-87C0-68B6B72699C7"
> >=20
> > -#define PARTS_DEFAULT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "name=3Dspl,start=3D2M,size=3D2M,type=3D${type_guid_gpt_loa=
der1};" \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "name=3Duboot,size=3D4MB,type=3D${type_guid_gpt_loader2};"=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_sys=
tem};"
> > +#define PARTS_DEFAULT \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name=3Dspl,start=3D2M,size=3D2M,=
type=3D${type_guid_gpt_loader1};" \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name=3Duboot,size=3D4MB,type=3D$=
{type_guid_gpt_loader2};" \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name=3Dsystem,size=3D-,bootable,=
type=3D${type_guid_gpt_system};"
> >=20
> > =C2=A0#define CFG_EXTRA_ENV_SETTINGS \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "kernel_addr_r=3D0x40200000\=
0" \
> > @@ -37,6 +52,8 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "type_guid_gpt_loader2=3D" T=
YPE_GUID_UBOOT "\0" \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "type_guid_gpt_system=3D" TY=
PE_GUID_SYSTEM "\0" \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "partitions=3D" PARTS_DEFAUL=
T "\0" \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fdtfile=3D" CONFIG_DEFAULT_FDT_F=
ILE "\0"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "fdtfile=3D" CONFIG_DEFAULT_FDT_F=
ILE "\0" \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BOOTENV \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BOOTENV_SF
> >=20
> > =C2=A0#endif /* _STARFIVE_VISIONFIVE2_H */
> > --
> > 2.47.0
> >=20
>=20
> NAK.
>=20
> This was removed March 2024 already. See "board: starfive vf2: switch
> to standard boot and fix DTS"
>=20
> https://lore.kernel.org/u-boot/20240221120014.149193-1-namcao@linutronix.=
de/
>=20
> Please divert your attention to review and test Hal's patch series:
> "Support OF_UPSTREAM for StarFive JH7110"
>=20
> https://lore.kernel.org/u-boot/20241125003205.75327-1-hal.feng@starfivete=
ch.com/
>=20
> Thanks,
>=20
> -E
