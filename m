Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39619C48BC4
	for <u-boot@archiver.kernel.org>; Sat, 17 Feb 2024 11:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7104187C9E;
	Sat, 17 Feb 2024 12:36:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kq3HGKfP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 351AF87D7C; Sat, 17 Feb 2024 12:36:13 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F2F87C48
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 12:36:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4125894065dso3691455e9.2
 for <u-boot@lists.denx.de>; Sat, 17 Feb 2024 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708169761; x=1708774561; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v2+Aeax7Zk5/WLRTmveAF6JGNmRDkyjdaLTRq19e5u0=;
 b=kq3HGKfPAYjUwDiEla5FUdpNoyeQwtZMh7VgGnqAGikvqSikfbCX2iyHBgTzcJlBSR
 kRY6k2RYBZUtci5FxE/xzI0C4QV43GiWzjKA6lUsqrFU9l5XprW+jyJ5yB4sqvKPalY5
 UfzgD1knu1r4dcuJiEMeK4yBru8/wW3cx4wqPLfKYctX3sF6NSz+z1r4O/j04+lgAP3F
 0DWXRTVqlbC5kKTqORnCSg/Ak+Ha2Ve72JYJg6ea+AUqM/UskeokoxkE1Km45Z+dxO7V
 Ju3K9Z4C6QG/CsEYbsy4qIq1XTr7p7HgAuYwoyK7uYo1THj/tKbN44PzMpaHQLMmk1E2
 8rFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708169761; x=1708774561;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v2+Aeax7Zk5/WLRTmveAF6JGNmRDkyjdaLTRq19e5u0=;
 b=cMv3Q+6jiDMOjuPKzlUSafRDFeSENfh+907lFKDhgnVgsuI3E66BcDIIlA8dPuxlQC
 cneIZZlf0kM9VymPSJP5amvWS90XPtRIwflZZF4UZCzPcYBv+vfu+OTFRXz/8ZjYXfxo
 DrmcV4vRpgRm6nErGY9OS6Ic/swJqpDG9SWODtvFh9nqWGs4vrPqeilCuDMTPip+c4ar
 qZkTpWOBshtSnfgEim/DID6hvhSnvWuyvu2Qd7sFZ4DaHePmd3dgXijujEknTg/D9Y5a
 6s8jIuYOeZ9OepDfMitNoxLezrKXVaOptBOq8ErpnQqFlacprk7+mKHxhpO7XvJA5wxq
 qp8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/lCOFYvt8vuP1/GMedrrKnSs5bgGOyNgDIOhoMi5c2OsvDdtRhhXSBEVB1O7k6T5s20W3oz3ZUoNC3xBclOoI03eaXA==
X-Gm-Message-State: AOJu0YzeLrtXeviN5m67o3s369UNb2e9v7hczdF+4FqrAQ9TeE4WJ7DD
 RBBlAxEQvyXYiHeTrFwdMLgKn3MSg0jZdsc2UJ57IFVigv9ETba0
X-Google-Smtp-Source: AGHT+IGJFsTNkVaw6zIRLHty4TZeSuOSGvqYA+dWnwcR9PbFZyZFbY0LQ3tu2MKa2OlZg/NdQ48m3A==
X-Received: by 2002:a7b:cb8f:0:b0:40f:db48:a1f5 with SMTP id
 m15-20020a7bcb8f000000b0040fdb48a1f5mr5179114wmi.35.1708169761116; 
 Sat, 17 Feb 2024 03:36:01 -0800 (PST)
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c231700b00410b0ce91b1sm4915028wmo.25.2024.02.17.03.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Feb 2024 03:36:00 -0800 (PST)
Message-ID: <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, Neha
 Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@google.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Andreas Dannenberg <dannenberg@ti.com>,
 Romain Naour <romain.naour@smile.fr>
Date: Sat, 17 Feb 2024 12:36:05 +0100
In-Reply-To: <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
 <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
Autocrypt: addr=alexander.sverdlin@gmail.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
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

Hi Jan!

On Sat, 2024-02-17 at 09:42 +0100, Jan Kiszka wrote:
> > U-Boot 2024.01 (Feb 15 2024 - 01:43:17 +0100)
> >=20
> > SoC:=C2=A0=C2=A0 AM62X SR1.0 HS-FS
> > Model: Texas Instruments AM625 SK
> > DRAM:=C2=A0 2 GiB
> > Core:=C2=A0 56 devices, 23 uclasses, devicetree: separate
> > MMC:=C2=A0=C2=A0 mmc@fa10000: 0, mmc@fa00000: 1
> > Loading Environment from nowhere... OK
> > In:=C2=A0=C2=A0=C2=A0 serial@2800000
> > Out:=C2=A0=C2=A0 serial@2800000
> > Err:=C2=A0=C2=A0 serial@2800000
> > Net:=C2=A0=C2=A0 eth0: ethernet@8000000port@1
> > Hit any key to stop autoboot:=C2=A0 0=20
> > switch to partitions #0, OK
> > mmc1 is current device
> > SD/MMC found on device 1
> > Failed to load 'uEnv.txt'
> > Scanning for bootflows in all bootdevs
> > Seq=C2=A0 Method=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 State=C2=A0=C2=A0 =
Uclass=C2=A0=C2=A0=C2=A0 Part=C2=A0 Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Filename
> > ---=C2=A0 -----------=C2=A0 ------=C2=A0 --------=C2=A0 ----=C2=A0 ----=
--------------------=C2=A0 ----------------
> > Scanning global bootmeth 'efi_mgr':
> > No EFI system partition
> > No EFI system partition
> > Failed to persist EFI variables
> > Scanning bootdev 'mmc@fa00000.bootdev':
> > Scanning bootdev 'mmc@fa10000.bootdev':
> > Unknown uclass 'usb' in label
> > link up on port 1, speed 100, full duplex
> > BOOTP broadcast 1
> > BOOTP broadcast 2
> > BOOTP broadcast 3
> > ...
> > ---
> >=20
> > I suppose TI's BSP has older U-Boot... So it's not providing necessary
> > script for BOOTSTD, I suppose?
> >=20
>=20
> You can make the BeagleBone boot via EFI, but it requires a hybrid
> partition table (ROM loader want DOS, EFI needs GPT). A Debian
> integration with this can be found for Isar [1] in this series [2]. It's
> only using upstream sources (plus still one u-boot patch to get wifi
> working).
>=20
> If you want legacy script booting, I suspect you need to flip some extra
> switches explicitly by now.

Thanks for the hints!
I'm wondering, if this was a deliberate "let's stop booting all the
pre-existing embedded distros" decision? (buildroot, yocto/meta-ti...)

--=20
Alexander Sverdlin.

