Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40016F3ED50
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 18:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7304184154;
	Sat, 11 Apr 2026 20:05:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xzir2mOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA7B8416F; Sat, 11 Apr 2026 20:04:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F9EE83DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 20:04:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b79f8f7ea43so567587166b.2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 11:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775930696; cv=none;
 d=google.com; s=arc-20240605;
 b=Vnq6GM9bBufQ66yd5ojdZeJ+wXcEVOaMmOr26VsDrbxtlH8C54dXvjpqUTQc71ELSc
 60kk+iqoOKC1z+JPLSduxTxEf9xUwP483CfmQxQBnNtJR7jE8GzJWh0lK+6pw8OcMYVz
 hcyayuSoR4dwRE1dlQQkMDxupOUlXyx5NWVebJyJmXTlKGRiGw2NSCfVO43B+5lG9qk3
 N1RjT0ifGC7NJZqMba94i/DlYroXNkiYcC2rQDBHmZBHGp7D/EUVi5aDfV0qAfvNQcy1
 sMA/Fq4pIBwN+TDMpHGj8G1skbgBrbxMUm9VApahDsGjq8HPI4q+4r3NpOjA9xnG9eOo
 nwog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JdZLouB+FGhmSI4C5yFJTNXvQUrmsgAzVBENtTZWj+k=;
 fh=ETGTWfeuotSR3gJse6VaYIviMx1Dhx8UzbpAKnocnA0=;
 b=hkIayLpLU/4dEfPbOFsplkUi3XtrhR1sJ71VHrVTV54bMqjGl/12XTyolVUI/PvS4H
 /mHD3atMfrfDnnen/LOwvAn/TVAlF7l67kak4qQ+iYOgQFcPPfDtaOFXt0YNjzowwhEl
 hdfP1n7pjXw0d3OZku1VUKDFIvPN1kVVd/tT1uNbzXeDfFNhICtQpVTL4Fi/YhImQntR
 bCHa97BW7EDyZPt2iSuJkdkH//w/oJs3ckGo3be6foLlcXuA9ksVXLsGUQ9yRlg9bl23
 9xY9PEsatVDc5olCbgKqXjjq0571zbf0l+alo5gVH8aC/u/2aLSI+rATfTcu/jqVB/wj
 joTQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775930696; x=1776535496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JdZLouB+FGhmSI4C5yFJTNXvQUrmsgAzVBENtTZWj+k=;
 b=Xzir2mOvLtBBtiBPDCiwJzLUj0WR+fM83xJGBXG4b9lo19QkQpHm7WXuLYI/F3SLom
 0yZ/77QyJRtcHw6UHRfqb7LCofFOHOtC21c+Pfj/6B9xrz/kc707YQ8cfnpHk6HMRsw2
 il3E7Xu3MHjDB+gV1Uiznm6XpyJDHzACV0DDDEMRvq7qbos8ib4jWW53VSEeoohDpr69
 OY9Y9M/6XuJtCwrFiZB+S2/+vfP2Lnfk0ibu3MxI+UZdw03RUhNNFCsAXuZnu3Qg5QQW
 S4FVj2Xb8YddfSCmBgKjsQdruxMpJmTEZLE+zfJ8A6u9yZ0V/rmUj4RBPUsiP4WLFe7t
 PEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775930696; x=1776535496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JdZLouB+FGhmSI4C5yFJTNXvQUrmsgAzVBENtTZWj+k=;
 b=IYc+y7zqDkZ1vKNhRfYlmguzefFAVGF8BdD3IS+TxszU/Em/iRayMfW1t+e0B8BWUy
 JIdokxdRa2m5VP68QtvWtaXT1YuxD19jrCHkK5usGVfJC4HAce9VjpuUcXM0W0+NnVMK
 ZO+kfi7fqt1+OUd4DtefuMMOkiiWE/WNWzmrU3dHy1DfSJK7p1UCh9dR8Adgbeq7Efkn
 yeWRR0JRHcvY2yPU8j3H1CzRzFWwsyzQwBQM0c5H/DeFgp7v6Yq2nC+TXMM643wyUutQ
 VfX2UHzMXaWucMX1ZUBLV5QAQkSQX3xWgj1AgkhiXCWXONsbm5Q95pN2NmYmBSH3cPYT
 g/zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Aoqn0OEM7ynXlCLGjrc6NPRgwIPAXmFFYjrG0WS5PfHbHolyoUl4tw+RU1M6HZxE+sSNJmM=@lists.denx.de
X-Gm-Message-State: AOJu0YxxOOWJQVb1hOqlq7zBcdXW57cZ5Gls3y81KwkJVo6joka5yZ/2
 gNi8pPm8hots0GPsbe57hNWAxmOGIGPtM3uDq46wQrs0jBzgQZGxdSJa0wye5a8lOBcju36euHM
 1t9CvA0/iLowWUSysM3GUDgDIaZhF7OQ=
X-Gm-Gg: AeBDievJuqmf8ZMRv+z4MA2C12qBWZB28w3cFRwoyNC+JUxhfkZYDXnaCyA9Es5JOUM
 xeKnGBXXde66b4PQBPwvKDNWIu9Ic+6u6EjlMASQ9d7kyug0T6q410Mg1iWdpyMws8y+EaKnVlk
 dvZmfckiZMWtH66mSyELPfYav64HzB1WsfxRemSXrQ0saTCFm6ljslyHpevGYZXviXN77rSCrSl
 u0Q+wQk/nevNT4uz8jTzaRIsUr3cEuKoqP6IQFW0KN00WSed9RDYyFkIzIx7SYfPMjHr2vUBQ/r
 zZ2seA==
X-Received: by 2002:a17:906:518a:10b0:b96:e11e:97c4 with SMTP id
 a640c23a62f3a-b9d72793974mr320965166b.20.1775930695392; Sat, 11 Apr 2026
 11:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-b4-amlogic-sysreset-capsules-v1-0-6f3386eb5124@postmarketos.org>
 <CANAwSgT33unjY1FXmKmC2A1draM=PE5mG1sdPy+iszdGxoLmNA@mail.gmail.com>
 <tda0gr.210fsxfirzfnv@postmarketos.org>
In-Reply-To: <tda0gr.210fsxfirzfnv@postmarketos.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 11 Apr 2026 23:34:38 +0530
X-Gm-Features: AQROBzAZkzeQUNqEc386ptCWXdygu_4FBf88ZWUMSoEKNQQIvPMmcApMyer0iGE
Message-ID: <CANAwSgRwM_GjUuQmwXzBjUKAfwyRC7FHB6gs1u57L=Mk=PMk3g@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enable EFI Capsule on Disk on Libre Computer LePotato
 & LaFrite
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Ferass,

Thanks, Sorry for the late reply.

On Fri, 10 Apr 2026 at 17:11, Ferass El Hafidi
<funderscore@postmarketos.org> wrote:
>
> Hi Anand,
>
> On Fri, 10 Apr 2026 10:10, Anand Moon <linux.amoon@gmail.com> wrote:
> >Hi  Ferass,
> >
> >On Thu, 9 Apr 2026 at 02:00, Ferass El Hafidi via groups.io
> ><funderscore=3Dpostmarketos.org@groups.io> wrote:
> >>
> >> Mostly everything is already in place to enable EFI capsules and in pa=
rticular
> >> EFI capsule on disk.
> >>
> >> First, switch all Amlogic boards to use SYSRESET. EFI Capsule on Disk
> >> functionality expects sysreset to be present. As the current reset_cpu=
()
> >> function in board-common.c is basically only doing PSCI reset on U-Boo=
t
> >> proper, we can replace it with sysreset's PSCI support, which works ju=
st
> >> fine for that purpose provided BL31 is running (SPL stays on an
> >> SoC-specific reset_cpu() which does for(;;);, as the overhead for
> >> sysreset is too high and we don't have PSCI yet at that point).
> >>
> >> Then we can enable capsule on disk. LaFrite has Capsule updates enable=
d
> >> already, so it is simply a matter of enabling CoD. LePotato does not
> >> have Capsule updates enabled by default, however it can be easily enab=
led
> >> and setup to update u-boot on eMMC/SD.
> >>
> >> With Capsule on Disk setup, it becomes possible to update U-Boot direc=
tly
> >> from Linux, without having to worry about manually using `flashprog`
> >> (for SPI flash) or `dd` (for eMMC/SD). Instead, thanks to CoD, updates
> >> can be handled by `fwupd` and applied upon next EFI boot.
> >>
> >> To test:
> >>
> >>  * build U-Boot as usual
> >>
> >>  * in that running U-Boot, run: `efidebug capsule esrt` to get the GUI=
D
> >>    -OR-
> >>    run the following in your tree:
> >>         tools/mkeficapsule guidgen path_to_devicetree_here U_BOOT_MESO=
N_MMC
> >>                                            (or U_BOOT_MESON_SPI on LaF=
rite)
> >>
> >>  * proceed with the following guide to create a capsule file:
> >>    https://docs.u-boot.org/en/latest/develop/uefi/uefi.html#enabling-u=
efi-capsule-update-feature
> >>
> >>  * generate a .cab file suitable for fwupd using `mkcab`:
> >>    https://gitlab.postmarketos.org/tauchgang/tauchgang-ci/-/tree/main/=
mkcab
> >>         mkcab u-boot-libretech-cc.capsule GUID-GOES-HERE libretech-cc =
"LePotato" 2026.04
> >>    (as of writing, the README.md suggests this is for Qualcomm only. I=
t
> >>     actually does nothing that is Qualcomm-specific, and works on any
> >>     board that supports Capsule on Disk and fwupd)
> >>
> >>  * on the board itself, boot to Linux via EFI, install fwupd, copy the=
 resulting
> >>    .cab file, and run as root:
> >>         fwupdtool --force install u-boot-libretech-cc.cab
> >>
> >>  * reboot, make sure you boot over EFI, else the capsule update will n=
ot
> >>    start
> >>
> >> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> >Thanks for your work.
> >
> >I haven't tested the EFI portion yet, but I have a few questions regardi=
ng
> >the previous commit 17d80a3b326e ("arm: meson: spl: add support for
> >SPL DRAM init").
> >Could you please clarify how you generated the Meson DRAM timing paramet=
ers?
> >
Thanks for sharing your progress on this
>
> Reverse-engineering the BL2 blob mainly, though some ancient Amlogic
> U-Boot source drops helped a lot, especially the older ones that had
> some BL2 source code. Amlogic's U-Boot source drops are a huge treasure
> of information when Amlogic's datasheets aren't enough.
>
> I documented some of my work here if you want to know more:
>         https://scm.dersco.re/amlogic/reversing-gxbb-bl2.git/about/
>
> and this is my downstream U-Boot tree I use for experiments. The
> `wip/spl` ones are the relevant branches:
>         https://scm.dersco.re/amlogic/u-boot-kii-pro.git/
>
Thanks, I will check this out.
> Amlogic also defines a few structs in their U-Boot fork, that ends up
> being used by BL2 as acs.bin. These proved valuable for reverse-engineeri=
ng.
>
> >I=E2=80=99m curious about the boot flow since we can apparently boot U-B=
oot without
> >the Amlogic-signed BL1 firmware.
> >
>
> BL1 is the bootROM in Amlogic AArch64 BL terminology, so I suppose you
> mean BL2. (I'm not familiar with Meson8b, maybe BL1 means something
> else there)
> In theory BL2, on boards without secureboot fuses blown, is not signed at
> all, you can replace it with anything. For a long time, U-Boot depended
> on Amlogic's BL2 blob along with the SCP firmware blob (BL30) and their
> downstream Trusted Firmware-A blob (BL31). Since then, the TF-A blob got
> reverse-engineered and the work was upstreamed, leaving BL2 and BL30.
>

> My work replaces BL2 with U-Boot SPL to do DRAM init and load BL30, BL31
> and U-Boot proper. However, right now, this is only possible for Meson
> GXBB (S905) and GXL (S905X), though I'd like to make it happen for
> G12A/B and SM1 too. It is also still experimental, so for now to have a
> good experience, the BL2 blob is still recommended, though that will
> hopefully change soon with some polish.
>
You have done good work in reverse engineering.
> >I just wanted to understand how to upstream U-Boot for the Meson8b (Odro=
id C1+)
> >platform, as it=E2=80=99s currently stuck on a very old version (v2011).=
 It's
> >ARM 32-bit.
> >
>
> As I understand it, Meson8b is a completely different bootflow. I'm not
> very familiar about it but I know the bootflow got redone starting with
> S905 (which also happens to be the first AArch64 SoC produced by
> Amlogic).
>
Correct, only repository I know for mesom8b
But I could not find the configuration file to build this U-Boot.
[1] https://github.com/endlessm/u-boot-meson.git
Let me check on what I can do to gather some more input on this.

> Digging in my IRC logs (#linux-amlogic on libera.chat,
> https://libera.catirclogs.org/linux-amlogic/2023-06-28#34525179),
> apparently these boot to an ARC HS core first, compared to these GXBB
> and newer SoCs. Though I don't know the details.
>
> In any case: Good luck and I hope you succeed at it!
Thanks
>
> If you have any more questions I'm happy to answer them.
>
> Best regards,
> Ferass
Thanks
-Anand
