Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB14C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 07:57:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4211E83F17;
	Fri, 11 Apr 2025 09:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="hVAspakw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5569583F1F; Fri, 11 Apr 2025 09:57:05 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347CA83EB3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 09:57:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joel.stan@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso306244766b.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 00:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1744358221; x=1744963021; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YI8uUnZHzx6CICQDMeE3m0BI1kYtVgjzfLyzwrvlSE=;
 b=hVAspakwZJZUVga4VsK9O2nl9fnZq4g55/JRBvEt1TkhVZAeAkZsyep15+1RkRilqk
 Ggucjwknkw6aQQVHQ0J48m9GjYzK1KueVFql87KzyFhxy7Ho+z0CSGX606N6d6KVL8Lm
 E71vjOKk7ubHy3BsUADWXbqueVIN0b6Hs3WjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744358221; x=1744963021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YI8uUnZHzx6CICQDMeE3m0BI1kYtVgjzfLyzwrvlSE=;
 b=aeZFvXjzyoIYTV1l2gT60pExAZUr4NT6LCHQq+W+5RzeYWifzwMOx5Mm9o88m4+HJ3
 HAlvDGlceDbTlGN6zYoatIkCIlL3vcMsouWQlUEHptpjldS7fukcc2c3hp8itfU7auv6
 8BrYba7dViL4NOK4N9VaF2ExaB+BmVasRthcsdog7hhUht8MtqnUI6oF4H9dVCewh5Za
 Y3lT3hw6WREibR6x1jhO5fVqDBA1+osGJDH3iMV3k6aCVaWrLeNwOufHjMe9tVRhqPYz
 Lo5uhpA9hVN9/ItA1pcF6FO1GVAqPTRdQJhgrZZNpHzLRq01YsTWarpJLLWcUwLdqY2K
 zyvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlvWjIxrSF167K/Ay6lFdW3u/x6pWxltSwNxg450lAAXmAVMBL/Eogv6oB5Cei64WLORtqN68=@lists.denx.de
X-Gm-Message-State: AOJu0YzKPa0AiDYTasjJj+mLsGUPDoYW+6WdZmgav54/QVlv6LS7Uy4/
 ePL50Mggdncggf2Z9lWr+0zP4lhabnbpTlubvjp5B0myumWc5UBDNY+7uG1O56NwqTeB8F0Rb0Y
 Gv0oDOOcQezfMP95rmJ3xuWQDwzM=
X-Gm-Gg: ASbGncvUCmtGzVn5dd8/Vft6bn9Wo4bFOrqM2xkhvOtnBON5y+2fkfoau6s0sFukYrb
 bf2BQO9Oe58KuazVRmuGtMPIE81f+89WY15RH5s/gefwHqeQ+Id904p+/izol8spCdorD8256TN
 gbsc5BpROWFbHlXIt4v+n0U1Y=
X-Google-Smtp-Source: AGHT+IE/mK6kAKC3bSNG2wFmyxLPBSdNUKY5I/25lnBQbv3RnqwimhmFx94JCEB7DxnIEND6zGg3tulqMNxdYwok7j0=
X-Received: by 2002:a17:907:1b03:b0:ac4:493:403 with SMTP id
 a640c23a62f3a-acad36a5b29mr130417966b.37.1744358221263; Fri, 11 Apr 2025
 00:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
 <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
 <20250410231444.GK5495@bill-the-cat>
 <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
In-Reply-To: <89f2eac8-4e76-42a6-b56e-fc62abdaffe9@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Apr 2025 17:26:49 +0930
X-Gm-Features: ATxdqUHLddT6I78y8St_maEkdnrircy3YW5uhL5YB0oACkekt0mAFZT4dtrei5Q
Message-ID: <CACPK8Xff4GD=CzJ+_fbCWniut7TVNHh744At8w3JSYrcsv=oOQ@mail.gmail.com>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Tom Rini <trini@konsulko.com>, Eugen Hristev <eugen.hristev@linaro.org>, 
 open list <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
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

On Fri, 11 Apr 2025 at 16:54, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Hi,
>
> On 4/11/25 01:14, Tom Rini wrote:
> > On Fri, Apr 11, 2025 at 08:07:15AM +0930, Joel Stanley wrote:
> >> On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.org> =
wrote:
> >>>
> >>> Hi everyone,
> >>>
> >>> I keep getting an error on running the CI loop on -next on my tree :
> >>>
> >>> https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517
> >>
> >> Thanks for the report.
> >>
> >>>
> >>> ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no oth=
er
> >>> tests will run !
> >>>
> >>> Any clue ? It's been like this for few days. It doesn't look like a
> >>> faulty patch.
> >>
> >> I can't see that link you sent me, it 403s.
> >>
> >> Do you have any other traces or information to share?
> >
> > It's been intermittent recently. I was able to put qemu + gdb together
> > and see it's one of the early initcalls that fails and hang()s but
> > didn't see why. You should be able to use commit 1f0281294d8b ("Merge
> > patch series "Annotate switch/case fallthrough cases"") as a starting
> > point of failure.
> >
>
> Do you have logs ?
>
> Things look ok from the QEMU side (latest 10.0.0-rc and 9.1) :

I brefily tried to run the steps from CI locally, but couldn't work
out how to get the flash image built. Instead I used the instructions
from 154cffa16a7b6647e180ed6cef55342b39580aff.

Testing master with Debian's qemu 9.2.2:

makearm evb-ast2600_defconfig
make u-boot-with-spl.bin
truncate -s 64M u-boot-with-spl.bin
qemu-system-arm -nographic -M ast2600-evb \
        -drive file=3Du-boot-with-spl.bin,if=3Dmtd,format=3Draw


U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 17:05:20 +0930)
Trying to boot from RAM
## Checking hash(es) for config conf-1 ... OK
## Checking hash(es) for Image firmware-1 ... crc32+ OK
## Checking hash(es) for Image fdt-1 ... crc32+ OK


U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 17:05:20 +0930)

Model: Aspeed BMC
DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64 MiB), ECC o=
ff
Core:  266 devices, 24 uclasses, devicetree: separate
WDT:   Started watchdog@1e785000 with servicing every 1000ms (60s timeout)
MMC:   sdhci@1e750100: 0
Loading Environment from SPIFlash... SF: Detected mx25u51245g with
page size 256 Bytes, erase size 64 KiB, total 64 MiB
*** Warning - bad CRC, using default environment

In:    serial@1e784000
Out:   serial@1e784000
Err:   serial@1e784000
Net:   eth0: ftgmac@1e660000, eth1: ftgmac@1e680000, eth2:
ftgmac@1e670000, eth3: ftgmac@1e690000
Hit any key to stop autoboot:  0
libfdt fdt_check_header(): FDT_ERR_BADMAGIC
Error loading kernel FIT image
=3D>

I tried to run qemu using the recipie from CI but I couldn't see where
the step to create the flash image happens.

>
>      uboot_build=3D/path/to/u-boot/
>      flashsize=3D65536
>      flash=3D./flash-ast2600-evb-uboot
>      dd of=3D$flash bs=3D1K if=3D/dev/zero count=3D$flashsize
>      dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/spl/u-boot-s=
pl.bin
>      dd of=3D$flash conv=3Dnotrunc bs=3D1K if=3D$uboot_build/u-boot.img s=
eek=3D64
>
>      $ qemu-system-arm -M ast2600-evb -net nic,netdev=3Dnet0 -netdev user=
,id=3Dnet0 -nographic -snapshot -serial mon:stdio   -drive file=3Dflash-ast=
2600-evb-uboot,format=3Draw,if=3Dmtd
>      qemu-system-arm: warning: nic ftgmac100.1 has no peer
>      qemu-system-arm: warning: nic ftgmac100.2 has no peer
>      qemu-system-arm: warning: nic ftgmac100.3 has no peer
>
>      U-Boot SPL 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200=
)
>      Trying to boot from RAM
>      ## Checking hash(es) for config conf-1 ... OK
>      ## Checking hash(es) for Image firmware-1 ... crc32+ OK
>      ## Checking hash(es) for Image fdt-1 ... crc32+ OK
>
>
>      U-Boot 2025.04-00921-gcb7555e93075 (Apr 11 2025 - 09:08:40 +0200)
>
>      Model: Aspeed BMC
>      DRAM:  already initialized, 1008 MiB (capacity:1024 MiB, VGA:64 MiB)=
, ECC off
>      Core:  266 devices, 24 uclasses, devicetree: separate
>      WDT:   Started watchdog@1e785000 with servicing every 1000ms (60s ti=
meout)
>      MMC:   sdhci@1e750100: 0
>      Loading Environment from SPIFlash... SF: Detected mx25u51245g with p=
age size 256 Bytes, erase size 64 KiB, total 64 MiB
>      *** Warning - bad CRC, using default environment
>
>      In:    serial@1e784000
>      Out:   serial@1e784000
>      Err:   serial@1e784000
>      Net:   eth0: ftgmac@1e660000, eth1: ftgmac@1e680000, eth2: ftgmac@1e=
670000, eth3: ftgmac@1e690000
>      Hit any key to stop autoboot:  0
>      libfdt fdt_check_header(): FDT_ERR_BADMAGIC
>      Error loading kernel FIT image
>      =3D>
>
>
> Thanks,
>
> C.
>
>
