Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822ABE7D24C
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E95C886C52;
	Tue, 26 Sep 2023 09:51:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zdi3a1pk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7266886D41; Tue, 26 Sep 2023 09:51:33 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1314869BC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 39A83CE0F64
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44249C433C9
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695714687;
 bh=nEqeotPPJz583eY0vp1rfwo1Ova7n1D6EvnVglJ4p4c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Zdi3a1pkvTZ/WxmSfvVPnZKDek9aMre6un8tW+nb3ECG4dXj0cFUml5opHHZqcVl6
 SwsiEDc9c6Y19iV8vx+IJVthhk0r9ObNbtPs0E+OadYURN4ThybGWYIDkw4VHCIFGI
 7DKvC0g30gDsl3YyQ5cqKS4LzUKV3gGhP/v/O/eCNWCKdaZj6HDlu0A2ytSQG/8eK0
 WeFZoPvRt6umj/hbsxW5eA51ukIyM8gxeBxCiVA4l+pZoxLeFpCtKdo9o7w8LSxknJ
 6fU8cu2ho9IeNi/eiyJ+EbIpALTBBhuNZN4CtVKCDdS4aL7UjGx8552G5I5yMmTn3y
 NEFdJsXXmijZA==
Received: by mail-oi1-f179.google.com with SMTP id
 5614622812f47-3aca1543608so5145404b6e.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 00:51:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YyKhoMwheQ7tiCuFGzzaANfTUjqicOHiLxQNMgkYOBSBF+cKpGp
 rN25EDBUegAAtz5sGguuvWrHQk2RJcuVpRvan9U=
X-Google-Smtp-Source: AGHT+IGE9xbaG2HmtwpWtFJU4GqEse+TlYvo33hotDBaXNTv5L9oND03d8UKuk5lQ0uAV8uaG+zv+rt64RD78n2zc3c=
X-Received: by 2002:a05:6870:8589:b0:1d7:1533:6869 with SMTP id
 f9-20020a056870858900b001d715336869mr10196963oal.31.1695714686625; Tue, 26
 Sep 2023 00:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
 <CAK7LNAQKucgcJViKGts4GmwUxNZ2Wi-rpEqst4=ueBj66-QTeg@mail.gmail.com>
 <bbcadd96-bf67-eb2d-1100-74bb942182b5@ti.com>
In-Reply-To: <bbcadd96-bf67-eb2d-1100-74bb942182b5@ti.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 26 Sep 2023 16:50:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQje4FcJCF8TzVXFp4vBJNURsnAAs4b0up_bajgJk+rSg@mail.gmail.com>
Message-ID: <CAK7LNAQje4FcJCF8TzVXFp4vBJNURsnAAs4b0up_bajgJk+rSg@mail.gmail.com>
Subject: Re: Question about boot failure of AM64-SK
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, s-vadapalli@ti.com, n-francis@ti.com, m-chawdhry@ti.com
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

On Mon, Sep 25, 2023 at 1:28=E2=80=AFPM Vignesh Raghavendra <vigneshr@ti.co=
m> wrote:
>
> Hi,
>
> On 21/09/23 21:52, Masahiro Yamada wrote:
> > On Fri, Sep 22, 2023 at 12:03=E2=80=AFAM Masahiro Yamada <masahiroy@ker=
nel.org> wrote:
> >>
> >> Hi.
> >>
> >> I am seeing a boot failure on AM64-SK.
> >>
> >>
> >> I got the following error in SPL of the main core.
> >> Do you have any clue?
> >
> >
> >
> > As a side-topic, I downloaded a prebuilt image
> > from https://www.ti.com/tool/SK-AM64
> >
> > It failed too (but in a different way).
> >
> > I flashed tisdk-debian-bookworm-am64xx-evm.wic
> > to a SD card by using the 'dd' command, then I got this:
> >
>
>
> Prebuilt images are targeted for High Secure (HS FS) devices. Looks like
> the board has a non HS Silicon (GP). Please overwrite the tiboot3.bin in
> boot partition with that of GP
>
> cp tiboot3-am64x-gp-evm.bin tiboot3.bin

Yeah, it made progress.

But, it failed in the same way as the latest U-Boot.






U-Boot SPL 2023.04 (Jul 14 2023 - 08:10:06 +0000)
EEPROM not available at 0x50, trying to read at 0x51
Resetting on cold boot to workaround ErrataID:i2331
Please resend tiboot3.bin in case of UART/DFU boot
resetting ...

U-Boot SPL 2023.04 (Jul 14 2023 - 08:10:06 +0000)
EEPROM not available at 0x50, trying to read at 0x51
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
SPL initial stack usage: 13376 bytes
Trying to boot from MMC2
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Loading Environment from MMC... MMC Device 0 not found
*** Warning - No MMC card found, using default environment

Starting ATF on ARM64 core...

NOTICE:  BL31: v2.8(release):v2.8-226-g2fcd408bb
NOTICE:  BL31: Built : 08:09:13, Jul 14 2023
I/TC:
I/TC: OP-TEE version: 3.20.0 (gcc version 11.3.1 20220712 (Arm GNU
Toolchain 11.3.Rel1)) #1 Fri Jul 14 08:09:59 UTC 2023 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check
https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
I/TC: HUK Initialized
I/TC: Activated SA2UL device
I/TC: Fixing SA2UL firewall owner for GP device
I/TC: Enabled firewalls for SA2UL TRNG device
I/TC: SA2UL TRNG initialized
I/TC: SA2UL Drivers initialized
I/TC: Primary CPU switching to normal world boot

U-Boot SPL 2023.04 (Jul 14 2023 - 08:11:18 +0000)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
Trying to boot from MMC2
Error reading cluster
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###








--=20
Best Regards
Masahiro Yamada
