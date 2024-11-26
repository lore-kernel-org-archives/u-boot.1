Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E6AD3B991
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 14:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DBC89C7D;
	Tue, 26 Nov 2024 15:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GMzcqKR7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CAFB89C83; Tue, 26 Nov 2024 15:13:47 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A40889C65
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 15:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7b66d55522dso122742885a.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732630423; x=1733235223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PT71fLppe6E8r4mfpcLqPdCwcjshl7dJ7h4H4rpRXe0=;
 b=GMzcqKR7ElVm3y/eNxSBCjfEbQOjdFy6wd3pKaV/BoDlZnoU4RMbiK33uCguO9zMZc
 tXcbDTPCnyeH2U2BH7105WmK+0qF9TMbMKkec1wvDHv1csIBkamwlxWSKVe1Zut+62jk
 m9E+RL1p+hy+mYCY8D1fezkVyJ2KPRCODVfi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732630423; x=1733235223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PT71fLppe6E8r4mfpcLqPdCwcjshl7dJ7h4H4rpRXe0=;
 b=e5YdmqPQ4mJ1eKGVW5q0XgOj4xAqCtXrDhpW+uYpros4WniIdcA0Cu4j8+SpF7tk30
 NzA6CMMVXUHNQ8dGAR5moQd79ZIQPnTKEyZ6OySxbfCHpNDuMrk4wQZacgtZVq0sSgDh
 RCEZEdW8x8PTJgNoQuT3dz/JIGJdIGhr9J1PxmY9TPyTMrMnSkElvo09zFLxBxtBP0cr
 kRpSoSbegMA8reJfaoAoAVDJKwm2yc6GzO6r+U9FkHmz3VFLX+6isCO6StMGGK7ayOaX
 pLjfG+rtH0/Uvx16RMAJjezctH/GD8mTn/EbMInuwcBnyh9pXibrQ8Vidqu57ykYw8HY
 Pi/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO1sq4kq11ckN72UNnvXMcf2QALcptPWkNPTW6/8x+WgTvx7G5OcHw7i5DrXaSY3NXiy+tWeA=@lists.denx.de
X-Gm-Message-State: AOJu0Yxi+NJylRUOCbR6tohWBT4bc5L4pTijUG0Xs5RuqU6U4XXVQMrD
 I2SMAuzglqNcDvHpSre+dFLBqCCjA7+oaFomd1u1z6DTALmhvHdKw9ipSTr2TSo=
X-Gm-Gg: ASbGncufId5Vk5vNZ7h8IpYD7ctk0AQLW4X/HyOlnsmvQ3/QqHueByeWdncffMeUbhq
 YsSJZelZo790aaZmYpoeAfPDa13Izcei2YWj1XF6hbwsjhSKKPaB4QijUmiZYpeBzPqotL5XJGS
 8rJS4gSz2PlqcMu8401AWprfqY1ODHR1zdVkOHCQErXLcIFzMAkVXBJAiOt5DwiOg/OVkX3oksq
 mSnivUOnNb2a33vRhHhZV44sI82N628uTuTdkf6UGyhANrGxw==
X-Google-Smtp-Source: AGHT+IH4ksgCy3mLM3AP7cqFWneRG+zNi4lO8utQXqHiEkoFkIRogefp1r/PiZpPqRWMf+fLzTZ4yA==
X-Received: by 2002:a05:6214:5015:b0:6c3:5b9e:699d with SMTP id
 6a1803df08f44-6d450e7e22amr252692856d6.2.1732630422993; 
 Tue, 26 Nov 2024 06:13:42 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451ab843bsm55140826d6.70.2024.11.26.06.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 06:13:41 -0800 (PST)
Date: Tue, 26 Nov 2024 08:13:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 T Karthik Reddy <t.karthik.reddy@xilinx.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 3/6] configs: xilinx_versal_virt: disable USB_DWC3
Message-ID: <20241126141338.GQ3600562@bill-the-cat>
References: <20241123214554.305285-1-heinrich.schuchardt@canonical.com>
 <20241123214554.305285-4-heinrich.schuchardt@canonical.com>
 <8941f3cb-2993-4cbf-a24e-a7a77898d634@amd.com>
 <72bb7c7e-1103-4ffe-af26-fb70136d11fe@canonical.com>
 <e91068f5-e9b7-44ca-a09f-32fab22dc3b0@amd.com>
 <9a90a05e-1e93-49c7-a72a-523ef345e7fc@canonical.com>
 <30c3072c-8446-412d-a534-61d9c8e0b03e@amd.com>
 <CAM=mAOkbPngqXopm1cLJ97WLUnD6y4q_2ha8_982=TvQsv_6NQ@mail.gmail.com>
 <e26f73b1-6f39-4b47-bfab-a69a247cf68a@amd.com>
 <c6e5f702-d6b1-4b54-bec3-0f94418b69a0@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yan18nNGbZBzP8yz"
Content-Disposition: inline
In-Reply-To: <c6e5f702-d6b1-4b54-bec3-0f94418b69a0@canonical.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Yan18nNGbZBzP8yz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 09:05:47AM +0100, Heinrich Schuchardt wrote:
> On 11/26/24 08:56, Michal Simek wrote:
> >=20
> >=20
> > On 11/25/24 21:09, Heinrich Schuchardt wrote:
> > >=20
> > >=20
> > > Michal Simek <michal.simek@amd.com <mailto:michal.simek@amd.com>>
> > > schrieb am Mo., 25. Nov. 2024, 19:04:
> > >=20
> > >=20
> > >=20
> > > =A0=A0=A0 On 11/25/24 11:35, Heinrich Schuchardt wrote:
> > > =A0=A0=A0=A0 > On 25.11.24 11:02, Michal Simek wrote:
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >> On 11/25/24 10:21, Heinrich Schuchardt wrote:
> > > =A0=A0=A0=A0 >>> On 11/25/24 09:32, Michal Simek wrote:
> > > =A0=A0=A0=A0 >>>>
> > > =A0=A0=A0=A0 >>>>
> > > =A0=A0=A0=A0 >>>> On 11/23/24 22:45, Heinrich Schuchardt wrote:
> > > =A0=A0=A0=A0 >>>>> The CI uses the following command to launch
> > > xilinx_versal_virt_defconfig:
> > > =A0=A0=A0=A0 >>>>>
> > > =A0=A0=A0=A0 >>>>> =A0=A0=A0=A0 qemu-system-aarch64 -M xlnx-versal-vi=
rt \
> > > =A0=A0=A0=A0 >>>>> =A0=A0=A0=A0 -display none -m 4G -serial mon:stdio=
 \
> > > =A0=A0=A0=A0 >>>>> =A0=A0=A0=A0 -device loader,file=3Du-boot,cpu-num=
=3D0
> > > =A0=A0=A0=A0 >>>>>
> > > =A0=A0=A0=A0 >>>>> 'usb start' or invoking eth_bootdev_hunt leads to =
a crash
> > > when function
> > > =A0=A0=A0=A0 >>>>> dwc3_core_init() tries to access a register at off=
set
> > > 0xc704 (DWC3_DCTL)
> > > =A0=A0=A0=A0 >>>>> relative to the register start address 0xfe20c100.
> > > =A0=A0=A0=A0 >>>>>
> > > =A0=A0=A0=A0 >>>>> Disable CONFIG_USB_DWC3 until the driver problem i=
s fixed.
> > > =A0=A0=A0=A0 >>>>>
> > > =A0=A0=A0=A0 >>>>> Signed-off-by: Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com
> > > =A0=A0=A0 <mailto:heinrich.schuchardt@canonical.com>>
> > > =A0=A0=A0=A0 >>>>> ---
> > > =A0=A0=A0=A0 >>>>> v2:
> > > =A0=A0=A0=A0 >>>>> =A0=A0=A0=A0new patch
> > > =A0=A0=A0=A0 >>>>> ---
> > > =A0=A0=A0=A0 >>>>> =A0 configs/xilinx_versal_virt_defconfig | 2 --
> > > =A0=A0=A0=A0 >>>>> =A0 1 file changed, 2 deletions(-)
> > > =A0=A0=A0=A0 >>>>>
> > > =A0=A0=A0=A0 >>>>> diff --git a/configs/xilinx_versal_virt_defconfig =
b/configs/
> > > =A0=A0=A0=A0 >>>>> xilinx_versal_virt_defconfig
> > > =A0=A0=A0=A0 >>>>> index c8f166c1221..06a240173ba 100644
> > > =A0=A0=A0=A0 >>>>> --- a/configs/xilinx_versal_virt_defconfig
> > > =A0=A0=A0=A0 >>>>> +++ b/configs/xilinx_versal_virt_defconfig
> > > =A0=A0=A0=A0 >>>>> @@ -153,8 +153,6 @@ CONFIG_USB=3Dy
> > > =A0=A0=A0=A0 >>>>> =A0 CONFIG_DM_USB_GADGET=3Dy
> > > =A0=A0=A0=A0 >>>>> =A0 CONFIG_USB_XHCI_HCD=3Dy
> > > =A0=A0=A0=A0 >>>>> =A0 CONFIG_USB_XHCI_DWC3=3Dy
> > > =A0=A0=A0=A0 >>>>> -CONFIG_USB_DWC3=3Dy
> > > =A0=A0=A0=A0 >>>>> -CONFIG_USB_DWC3_GENERIC=3Dy
> > > =A0=A0=A0=A0 >>>>> =A0 CONFIG_USB_ULPI_VIEWPORT=3Dy
> > > =A0=A0=A0=A0 >>>>> =A0 CONFIG_USB_ULPI=3Dy
> > > =A0=A0=A0=A0 >>>>> =A0 CONFIG_USB_GADGET=3Dy
> > > =A0=A0=A0=A0 >>>>
> > > =A0=A0=A0=A0 >>>> NACK. That's not the way to go. If one test is fail=
ing in
> > > CI disable that
> > > =A0=A0=A0=A0 >>>> test not really support which is for HW too.
> > > =A0=A0=A0=A0 >>>>
> > > =A0=A0=A0=A0 >>>> Thanks,
> > > =A0=A0=A0=A0 >>>> Michal
> > > =A0=A0=A0=A0 >>>
> > > =A0=A0=A0=A0 >>> Hello Michal,
> > > =A0=A0=A0=A0 >>>
> > > =A0=A0=A0=A0 >>> It is not that a single test fails. USB is completely
> > > unusable on the
> > > =A0=A0=A0 board.
> > > =A0=A0=A0=A0 >>> 'usb start' leads to an immediate crash.
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >> I am not applying any patches on SOM with HEAD and us=
b is
> > > partially working.
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > Don't you see a crash when executing 'usb start'?
> > > =A0=A0=A0=A0 > What QEMU are you using?
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 >> I can agree that it is not super stable with upstream=
 only
> > > patches but
> > > =A0=A0=A0 that's
> > > =A0=A0=A0=A0 >> different story.
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >>>
> > > =A0=A0=A0=A0 >>> The problem already existed in v2021.01.
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >> Any log?
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > $ git reset --hard origin/master
> > > =A0=A0=A0=A0 > $ make xilinx_versal_virt_defconfig
> > > =A0=A0=A0=A0 > $ CROSS_COMPILE=3Daarch64-linux-gnu- make -j$(nproc)
> > > =A0=A0=A0=A0 > $ qemu-system-riscv64 --version
> > > =A0=A0=A0=A0 > QEMU emulator version 9.0.2 (Debian 1:9.0.2+ds-4ubuntu=
7)
> > > =A0=A0=A0=A0 > $ qemu-system-aarch64 -M xlnx-versal-virt \
> > > =A0=A0=A0=A0 >=A0 > -display none -m 4G -serial mon:stdio \
> > > =A0=A0=A0=A0 >=A0 > -device loader,file=3Du-boot,cpu-num=3D0
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > U-Boot 2025.01-rc2-00172-g880fcc49eb40 (Nov 25 2024 -
> > > 11:18:35 +0100)
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > CPU:=A0=A0 UNKNOWN
> > > =A0=A0=A0=A0 > Model: Xilinx Versal Virtual development board
> > > =A0=A0=A0=A0 > DRAM:=A0 2 GiB (effective 4 GiB)
> > > =A0=A0=A0=A0 > EL Level:=A0=A0=A0=A0=A0=A0 EL3
> > > =A0=A0=A0=A0 > Core:=A0 32 devices, 13 uclasses, devicetree: board
> > > =A0=A0=A0=A0 > Warning: Device tree includes old 'u-boot,dm-' tags: p=
lease
> > > fix by 2023.07!
> > > =A0=A0=A0=A0 > MMC:=A0=A0 sdhci@f1040000: 0, sdhci@f1050000: 1
> > > =A0=A0=A0=A0 > Loading Environment from nowhere... OK
> > > =A0=A0=A0=A0 > In:=A0=A0=A0 uart@ff000000
> > > =A0=A0=A0=A0 > Out:=A0=A0 uart@ff000000
> > > =A0=A0=A0=A0 > Err:=A0=A0 uart@ff000000
> > > =A0=A0=A0=A0 > Bootmode: JTAG_MODE
> > > =A0=A0=A0=A0 > Net:
> > > =A0=A0=A0=A0 > ZYNQ GEM: ff0c0000, mdio bus ff0c0000, phyaddr 0, inte=
rface
> > > rgmii-id
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > Warning: ethernet@ff0c0000 (eth0) using random MAC add=
ress -
> > > =A0=A0=A0 5e:f6:37:a3:68:24
> > > =A0=A0=A0=A0 > eth0: ethernet@ff0c0000
> > > =A0=A0=A0=A0 > ZYNQ GEM: ff0d0000, mdio bus ff0d0000, phyaddr 0, inte=
rface
> > > rgmii-id
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > Warning: ethernet@ff0d0000 (eth1) using random MAC add=
ress -
> > > =A0=A0=A0 5e:8a:ec:a9:d7:e8
> > > =A0=A0=A0=A0 > , eth1: ethernet@ff0d0000
> > > =A0=A0=A0=A0 > MMC: no card present
> > > =A0=A0=A0=A0 > MMC: no card present
> > > =A0=A0=A0=A0 > Cannot persist EFI variables without system partition
> > > =A0=A0=A0=A0 > Missing TPMv2 device for EFI_TCG_PROTOCOL
> > > =A0=A0=A0=A0 > Missing RNG device for EFI_RNG_PROTOCOL
> > > =A0=A0=A0=A0 > Hit any key to stop autoboot:=A0 0
> > > =A0=A0=A0=A0 > Versal> usb start
> > > =A0=A0=A0=A0 > starting USB...
> > > =A0=A0=A0=A0 > Bus dwc3@fe200000: "Synchronous Abort" handler, esr 0x=
96000050
> > > =A0=A0=A0=A0 > elr: 0000000008068fd8 lr : 0000000008069940 (reloc)
> > > =A0=A0=A0=A0 > elr: 000000007ff17fd8 lr : 000000007ff18940
> > > =A0=A0=A0=A0 > x0 : 00000000fe20c100 x1 : 0000000040000000
> > > =A0=A0=A0=A0 > x2 : 0000000033310000 x3 : 000000000000003f
> > > =A0=A0=A0=A0 > x4 : 000000007ffa74b0 x5 : 000000007c112880
> > > =A0=A0=A0=A0 > x6 : 000000007ffa74c0 x7 : 000000007c300000
> > > =A0=A0=A0=A0 > x8 : 0000000000000684 x9 : 000000007bda668c
> > > =A0=A0=A0=A0 > x10: 0000000000000003 x11: 0000000000000188
> > > =A0=A0=A0=A0 > x12: 0000000000000000 x13: 000000007bda6be0
> > > =A0=A0=A0=A0 > x14: 0000000000000000 x15: 000000007bda6224
> > > =A0=A0=A0=A0 > x16: 000000007fee9244 x17: 0000000000000000
> > > =A0=A0=A0=A0 > x18: 000000007bea6be0 x19: 000000007c111b48
> > > =A0=A0=A0=A0 > x20: 000000007c111240 x21: 0000000047822004
> > > =A0=A0=A0=A0 > x22: 000000007ff998b2 x23: 000000007ff998e8
> > > =A0=A0=A0=A0 > x24: 000000007ffd4514 x25: 0000000000000000
> > > =A0=A0=A0=A0 > x26: 0000000000000000 x27: 000000007c111130
> > > =A0=A0=A0=A0 > x28: 000000007c1110d0 x29: 000000007bda67b0
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > Code: b9030660 f9416e60 d5033fbf 52a80001 (b9060401)
> > > =A0=A0=A0=A0 > Resetting CPU ...
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > resetting ...
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > $ cat u-boot.map
> > > =A0=A0=A0=A0 >=A0 =A0.text.dwc3_core_init
> > > =A0=A0=A0=A0 >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x000=
0000008068f24=A0=A0=A0=A0=A0 0x6a0 drivers/usb/
> > > dwc3/core.o
> > > =A0=A0=A0=A0 >=A0 =A0.text.dwc3_of_parse
> > > =A0=A0=A0=A0 >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x000=
00000080695c4=A0=A0=A0=A0=A0 0x310 drivers/usb/
> > > dwc3/core.o
> > > =A0=A0=A0=A0 >=A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x000=
00000080695c4=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dwc3_of_parse
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >>> Do you know of any QEMU/U-Boot combination where USB=
 ever
> > > worked on the
> > > =A0=A0=A0 board?
> > > =A0=A0=A0=A0 >>
> > > =A0=A0=A0=A0 >> Why was this visible in CI in past and why this pops =
up now?
> > > =A0=A0=A0=A0 >> What has changed? I don't think there was any change =
in QEMu
> > > regarding
> > > =A0=A0=A0 USB but
> > > =A0=A0=A0=A0 >> I can double check.
> > > =A0=A0=A0=A0 >
> > > =A0=A0=A0=A0 > We never started USB in the CI.
> > > =A0=A0=A0=A0 > With patch 6/6 of the series usb_bootdev_hunter() is i=
nvoked
> > > which starts
> > > =A0=A0=A0 USB.
> > >=20
> > > =A0=A0=A0 Did you push this to gitlab CI? Which test/py is failing th=
ere?
> > >=20
> > > =A0=A0=A0 M
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > > This is the failed job.
> > > https://source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501
> > > <https:// source.denx.de/u-boot/custodians/u-boot-efi/-/jobs/955501>
> > >=20
> > > https://source.denx.de/u-boot/custodians/u-boot-efi/-/
> > > commit/636a4f4793d4d5098afdd46b00205c7bb245570c <https://
> > > source.denx.de/u-boot/ custodians/u-boot-efi/-/
> > > commit/636a4f4793d4d5098afdd46b00205c7bb245570c>
> > >=20
> >=20
> > I can't see any issue when I apply this series on the top of rc3
> >=20
> > https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/
> > pipelines/23565
>=20
> Hello Michal,
>=20
> The link
> https://source.denx.de/u-boot/custodians/u-boot-microblaze/-/pipelines/23=
565
> is not valid for me (404 Page not found).

This should work now. The trees initially defaulted to public pipelines
being off, and I thought I had fixed everyone over the years, but,
clearly not.

--=20
Tom

--Yan18nNGbZBzP8yz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdF144ACgkQFHw5/5Y0
tyxCIwv/eMjjQLmBHf5iv/xwDNDk5GExJ5XniExLwqk2bdgoZvVbcIqtXkbmKlYf
a4/kj32T4SVi/ZpBPWX1VXizsLSNh1eslZ58V/hMZt0Ofv2SL2ZtauEW5BYc0hVb
GGa3pAhck5Vnh/eKqbx9l04N9ysHXk8gevRcgKITKU0o+/WL2gKZlYvh25iFGdwf
KG5/2YU7R9eb94/PTNjquO551AUX9ddAWbx3gA9Ae/sqWhQEQHVW0s/xKB6zOPg5
FjYmL6xCwdsXFIwDgKseeqIXSsMcoQQVw3FdSy5DSqPsKwJe2aHDJGj+QUHIWe4A
gOeJF0PV1ZkCBc4c3d5hTMDT5Ab9VWNOJIwkiWAIjsZ+fFEcSsm6SMMhq6m3nzlc
P4CxW/qb47B1HQK6Rqh7r4mN0ZpBdLFlSFRu4927ZrnZ5bSmyttUj+wNHWaAZyyj
EU5KVch9x1JDGz38TQSImMYttIgMtouCWuzeWrVG0C4zV3w9QFdXmrSMe05k9qhG
wywH6x8x
=aY+V
-----END PGP SIGNATURE-----

--Yan18nNGbZBzP8yz--
