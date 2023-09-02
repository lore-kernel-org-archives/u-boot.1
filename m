Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F37C83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 22:21:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33D7F86802;
	Sun,  3 Sep 2023 00:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h5bqCV+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5794086813; Sun,  3 Sep 2023 00:21:52 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07ABE867EF
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 00:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tosainu.maple@gmail.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d7b89ae27d3so215473276.3
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693693308; x=1694298108; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpqK1fUES0JoxYccqfQkpNVs4AAOxvqtEcaTkp1wZHI=;
 b=h5bqCV+Eo0vDM1p5f698UpP+JfMltxwFwgAmiKRMuQzb9hYymmFg5/9yqVtvnpNpdR
 AsF0aKTmm3jykIdSX+Seu5UcJsBTUgoyaoDA2NoV541sIVAvd2tAqEFIlfkt4dnilSuu
 s92QJSKHeuQiabbuppZalv0cmPoPFwtSzl/RmSBvV9wnlCvpiSgYgqjX6qo2RvfAtyc2
 xPvIEEcVeRLcURWtP2kl8a3LcnoOLpDWzoLnjWUra/BuJS/BROg5jXodZKBZlNSG+m8B
 b5rnUirm/OYivI1J6MqcowjVMtBc6G+IehUbU4pGIi1bE1M205i7vUvY3Kfld2YysYqc
 yO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693693308; x=1694298108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpqK1fUES0JoxYccqfQkpNVs4AAOxvqtEcaTkp1wZHI=;
 b=lFf+C3507kR2m1MMzTAFXKfqHkrgSu+FAV7cmVz+J1v4eCHtRyJmEAVzdqhQIt+xt9
 Cmakj28ZKO44oy5m7d1lpnHixFajgyYpMyHglWWadhSxv7Ky7I5C5UQUzm2m06AWSLAv
 cQOep4f+a0HPdN4FDfnkoHllNmUAI5Ep5D5adD7rGPMn4fqr6FprNOOIEvOAwUery8Ch
 AuJiyR4oPv9WSVTmVNHVv91l2cjeXqg6venDsPeyDBWhC8wqDt4U/f6S3hdpQbQcuflT
 1CR4q3pkpbadoiHmAV7JbUo1FYxGZptznalGvCGV5Td11w+s88Fw3vO5LCPxcPqcQ8zi
 //Tw==
X-Gm-Message-State: AOJu0YyJQ3a3Mm/mjHTTB/onduQZyPkP8UdcH5YrhzKcYOJWqdHi1vpi
 nQFPyx+QY5rbxdE5l8YzjMuaQMSgTNUtKTdYkIdqWtUu22E=
X-Google-Smtp-Source: AGHT+IE8GnknmIK8TEw7oK7MuGvFCkkFUo7bNK8mrpgXYwep3CmY9GXWKo5A22lQ0Smj0qXxGRjLyx+pTIjgzrGG1zE=
X-Received: by 2002:a25:26c9:0:b0:d4b:ab7b:17ed with SMTP id
 m192-20020a2526c9000000b00d4bab7b17edmr7263166ybm.4.1693693307656; Sat, 02
 Sep 2023 15:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAF1eZtvEmjZohyJfa=Jm=Dm76bhkayKk_tzTMM8ooQUQ-OL0CA@mail.gmail.com>
 <d27f6c83-4b29-25af-9991-574f2e79b8fa@kwiboo.se>
In-Reply-To: <d27f6c83-4b29-25af-9991-574f2e79b8fa@kwiboo.se>
From: Kenta Sato <tosainu.maple@gmail.com>
Date: Sun, 3 Sep 2023 07:21:31 +0900
Message-ID: <CAF1eZtu0Fk3KEBHj3znqiR9RKxam_+eR=0K5c+VT3GFayLQESw@mail.gmail.com>
Subject: Re: Issue with mmc_power_on() and reference counter of regulator
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
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

Hi,
Thank you for the quick response.

On Sat, Sep 2, 2023 at 10:45=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi,
>
> On 2023-09-02 13:35, Kenta Sato wrote:
> > Hi,
> >
> > I am using the FriendlyElec NanoPi R4S board.
> > When I updated U-Boot to a recent version (0fe0395922), it failed to
> > boot from MMC. Here is the log:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > U-Boot TPL 2023.10-rc3 (Sep 02 2023 - 08:21:08)
> > lpddr4_set_rate: change freq to 400MHz 0, 1
> > Channel 0: LPDDR4, 400MHz
> > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Si=
ze=3D2048MB
> > Channel 1: LPDDR4, 400MHz
> > BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Si=
ze=3D2048MB
> > 256B stride
> > lpddr4_set_rate: change freq to 800MHz 1, 0
> > Trying to boot from BOOTROM
> > Returning to boot ROM...
> >
> > U-Boot SPL 2023.10-rc3 (Sep 02 2023 - 08:21:08 +0000)
> > Trying to boot from MMC1
> > spl_load_fit_image: Skip load 'atf-5': image size is 0!
> > NOTICE:  BL31: v2.9(release):
> > NOTICE:  BL31: Built : 08:19:59, Sep  2 2023
> >
> >
> > U-Boot 2023.10-rc3 (Sep 02 2023 - 08:21:08 +0000)
> >
> > SoC: Rockchip rk3399
> > Reset cause: POR
> > Model: FriendlyElec NanoPi R4S
> > DRAM:  4 GiB (effective 3.9 GiB)
> > PMIC:  RK808
> > Core:  264 devices, 23 uclasses, devicetree: separate
> > MMC:   mmc@fe320000: 1
> > Loading Environment from nowhere... OK
> > In:    serial,usbkbd
> > Out:   serial,vidconsole
> > Err:   serial,vidconsole
> > Model: FriendlyElec NanoPi R4S
> > Net:
> > Error: ethernet@fe300000 address not set.
> > No ethernet found.
> >
> > Hit any key to stop autoboot:  0
> > Error enabling VMMC supply : -114
> > Error enabling VMMC supply : -114
> > Error enabling VMMC supply : -114
> > Error enabling VMMC supply : -114
> > Error enabling VMMC supply : -114
> > Error enabling VMMC supply : -114
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Does anyone know how to fix the issue?
> >
> > I looked into commit logs and the mailing list so far, and I found the
> > below commit that adds the reference counter to the regulator. I could
> > remove the above error by reverting this change. Of course, it should
> > not be the proper way.
> > Maybe we could replace regulator_set_enable() in mmc_power_on() by
> > regulator_set_enable_if_allowed(). However, I have no confidence about
> > it as I'm not familiar with the U-Boot source code.
>
> I sent patches to fix such situation back in July, see [1]. Those
> patches was merged into next, but should probably have gone into master.
>
> Please try next, and/or apply patches at [1] and report back result.
>
> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=3D364753&stat=
e=3D*

I tried the next branch. The issue seems to be solved.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
U-Boot TPL 2023.10-rc3 (Sep 02 2023 - 22:00:13)
lpddr4_set_rate: change freq to 400MHz 0, 1
Channel 0: LPDDR4, 400MHz
BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Size=
=3D2048MB
Channel 1: LPDDR4, 400MHz
BW=3D32 Col=3D10 Bk=3D8 CS0 Row=3D15 CS1 Row=3D15 CS=3D2 Die BW=3D16 Size=
=3D2048MB
256B stride
lpddr4_set_rate: change freq to 800MHz 1, 0
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2023.10-rc3 (Sep 02 2023 - 22:00:13 +0000)
Trying to boot from MMC1
spl_load_fit_image: Skip load 'atf-5': image size is 0!
NOTICE:  BL31: v2.9(release):
NOTICE:  BL31: Built : 22:00:05, Sep  2 2023


U-Boot 2023.10-rc3 (Sep 02 2023 - 22:00:13 +0000)

SoC: Rockchip rk3399
Reset cause: POR
Model: FriendlyElec NanoPi R4S
DRAM:  4 GiB (effective 3.9 GiB)
PMIC:  RK808
Core:  264 devices, 23 uclasses, devicetree: separate
MMC:   mmc@fe320000: 1
Loading Environment from nowhere... OK
In:    serial,usbkbd
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: FriendlyElec NanoPi R4S
Net:
Error: ethernet@fe300000 address not set.
No ethernet found.

Hit any key to stop autoboot:  0
** Booting bootflow 'mmc@fe320000.bootdev.part_1' with extlinux
1: Arch Linux
Retrieving file: /vmlinuz-linux-nanopi-r4s
Retrieving file: /initramfs-linux-nanopi-r4s.img
(...)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

I hope those patches will be in the master and the next release soon.

Thank you!

Kenta

>
> Regards,
> Jonas
>
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > commit 4fcba5d556b4224ad65a249801e4c9594d1054e8
> > Author: Eugen Hristev <eugen.hristev@collabora.com>
> > Date:   Wed Apr 19 16:45:24 2023 +0300
> >
> >     regulator: implement basic reference counter
> >
> >     Some devices share a regulator supply, when the first one will requ=
est
> >     regulator disable, the second device will have it's supply cut off =
before
> >     graciously shutting down. Hence there will be timeouts and other fa=
iled
> >     operations.
> >     Implement a reference counter mechanism similar with what is done i=
n
> >     Linux, to keep track of enable and disable requests, and only disab=
le the
> >     regulator when the last of the consumers has requested shutdown.
> >
> >     Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> >     Reviewed-by: Simon Glass <sjg@chromium.org>
> >     Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Any help would be greatly appreciated.
> > Thank you!
> >
> > Kenta Sato
>
