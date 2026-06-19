Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CEBCD98F2
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 13:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F45849BF;
	Fri, 19 Jun 2026 15:15:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="QFnrcFrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D68801A9; Fri, 19 Jun 2026 15:15:46 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBBD3849BF
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 15:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4627adcf4d6so1406140f8f.3
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781874942; x=1782479742; darn=lists.denx.de;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bBS6Y9/ThE4y9wvJiPlblV2p0YXNAvQlVOg/NP3579U=;
 b=QFnrcFrOWZhRNflAjI55KHRo7JKLXUJvWVtFdacJP2k4FLbk64+I89tYv8b/bco6YU
 iOZcdNDP5cf1MFchIbQAFHDKV1WYMfjIo3OqYop9m5d+f/w4qBe+ePEQwstXanwViyeI
 DJMMKwMLVaD3qFog/FW8hTJ13hdil5J4Z0Od9ZAavrtgX2v0SscDL31rHl+OeBCZ3QPK
 IocJZNF1596ehLOBBWLepAmMQZYwUaoOX0N4pjmffI07R5PNlplbHZI5gyUmb+iWzeNK
 g0e0w/SZat4dWM6Qc3WujlrrAg+4xyq/GQ4SZuiDaFyJVj2PhNM78xtbQyp2Ch97Vb2/
 ECog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781874942; x=1782479742;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBS6Y9/ThE4y9wvJiPlblV2p0YXNAvQlVOg/NP3579U=;
 b=JZVXXxGdBrqHRtk5kfW8CXmBX3j/2ux4IvC6TEprFOAi6yCkp/mfzv+0Y2fK7THYSp
 5uQcqzFCBOCBPx5E1ZJugCoDWWW2eQmDHEQY37OM7zMDpke4SO910YaKiCPhmxj4n8YF
 kE4U8jhs/bCBaTEUQoMmfYMGjyk5F22EKhkF5gwywR4Pee44l93W9Vjm/9AZvwyN/a9b
 kYOPib7SagAFSZ3z8W478Dl/uzg6+st7cD40ecwV4TCKmbZCtJ1dQh7omA92GuVO2A8J
 9d/E3lznPezI+N2c2H8uLB85XR4BVehSHYgZYcltOMzhWprGstn2qz1FTjvYLdt+iK3J
 tTig==
X-Forwarded-Encrypted: i=1;
 AFNElJ9/EMopfoprsVqoBTduBcridRJOEXw6zEvDDKk6QkK0wQPrbwNhSZn62H74gVg2Y3YmIQIQmBU=@lists.denx.de
X-Gm-Message-State: AOJu0YwQl5ApGJOsRkSpe6rAKFsfmbU8gAxNCIcgvIvqE8T78exIElZK
 IzM4P+PgmRpPYkaXcbAp3QDQgI2X5homTdjhjUbfBRVzOvWVWTu39MKUT4WciAwXhy0=
X-Gm-Gg: AfdE7cnTx2bRejiDL3+mVvVEluGEVN4gNkfZw5Id1q7NrSnh+wwLlTUJZKSG/taX99/
 HiilbngiDYjWyrCQcTdMIKJ+Wakchi0p+Ht9BT+WvXEkdjaZBr75UPluYGbcSzIYHx8+c0LQ+ty
 j0XiuwHoypm6/COVfDRxU85gTgqGtzAysU19bT/nOwpYlMY6KOac5DEmRxmdBPL4/YKZUBkDicG
 EU0qqrljd71ABYrzJhO4t1tWlv0g9YwJ8g6O+p07WvIVt3T3UDtL0MaNVdtu41CHN3jL8s+vmTS
 YkwLeGHitjo6NOiwd3B3w44Cx+XD04nszl4pU1OC5fWhT6B5oYxUgB6NwqItWPyXLh+7lSHMIv/
 O8bPB92Rayogoi4eaTpStbLc93or4eMiAO9XkN78KrQOwIL3N4mOeGiBwxPH6ibBlN1Nkkg==
X-Received: by 2002:a05:6000:41e6:b0:465:7c2f:c09 with SMTP id
 ffacd0b85a97d-4657c2f0c7cmr4231670f8f.16.1781874942223; 
 Fri, 19 Jun 2026 06:15:42 -0700 (PDT)
Received: from localhost ([2001:4091:a245:857c:6881:1355:3b75:b347])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46508a04dd1sm8786286f8f.7.2026.06.19.06.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 06:15:41 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e95009888694f4829f4fd2b0e445c540bb5414aeb4dbcfaa2e9947504710;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 19 Jun 2026 15:15:32 +0200
Message-Id: <DJD1Y3G9S1SP.2GHOZ5X4RYJFA@baylibre.com>
Subject: Re: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Bryan Brattlof" <bb@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>
Cc: "Paresh Bhagat" <p-bhagat@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <praneeth@ti.com>, <vigneshr@ti.com>,
 <b-liu@ti.com>, <afd@ti.com>, <anshuld@ti.com>, "U-Boot"
 <u-boot-bounces@lists.denx.de>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <DJ57VBSU0GI1.1WEU7NE9FYE46@baylibre.com>
 <c329501b-ae4a-4fd1-8fb3-0489a7f269a4@ti.com>
 <DJ71RUV8QWDN.4QHDEL6ZHAU9@baylibre.com>
 <20260612135507.ndfsmjxs34fu6stk@bryanbrattlof.com>
In-Reply-To: <20260612135507.ndfsmjxs34fu6stk@bryanbrattlof.com>
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

--e95009888694f4829f4fd2b0e445c540bb5414aeb4dbcfaa2e9947504710
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Bryan,

On Fri Jun 12, 2026 at 3:55 PM CEST, Bryan Brattlof wrote:
> On June 12, 2026 thus sayeth Markus Schneider-Pargmann:
>> Hi Paresh,
>>=20
>> On Thu Jun 11, 2026 at 8:14 PM CEST, Paresh Bhagat wrote:
>> > Hi Markus,
>> >
>> > Btw Had a quick look at series
>> >
>> > https://lore.kernel.org/all/20260609-topic-am62a-ioddr-dt-v6-19-v6-0-1=
6afba97fbe0@baylibre.com/
>> >
>> > I did not know this problem was for other devices too.
>> >
>> >
>> > On 10/06/26 13:42, Markus Schneider-Pargmann wrote:
>> >> Hi Paresh,
>> >>
>> >> On Tue Jun 9, 2026 at 8:10 PM CEST, Paresh Bhagat wrote:
>> >>> This patch series addresses DM firmware reserved memory fixup for AM=
62a
>> >>> and AM62d:
>> >>>
>> >>> 1. AM62D is missing OF_SYSTEM_SETUP config, required for FDT fixups =
to
>> >>>     be applied before passing dtb to kernel.
>> >>>
>> >>> 2. DM firmware reserved memory region is insufficient to accommodate=
 the
>> >>>     binary. Analysis of the DM firmware binary using objdump reveals=
 that
>> >>>     the resource_table section and .stack section occupies memory fr=
om
>> >>>     0x9c900000 to 0x9e608000. So increase the reserved region size f=
rom
>> >>>     0xf00000 to 0x1f00000 via fdt fixup. Add new configs in Kconfig.
>> >> I am wondering why you chose 0x1f00000 and not 0x1d08000?
>> >>
>> >> Also for am62a the firmware linker file says it is shorter:
>> >>      /* DDR for DM R5F code/data [ size 27 MiB + 364 KB ] */
>> >>      DDR                         : ORIGIN =3D 0x9CAA5000 LENGTH =3D 0=
x1B5B000
>> >>
>> >>      https://github.com/TexasInstruments/mcupsdk-core-k3/blob/k3_main=
/examples/drivers/ipc/ipc_rpmsg_echo_linux/am62px-sk/wkup-r5fss0-0_freertos=
/ti-arm-clang/linker.cmd#L175
>> >>
>> >> I am wondering what is correct, the linker file or the objdump you di=
d?
>> >
>> >
>> > Yes apart from the objdump output I noticed a gap between end of=20
>> > wkup_r5fss0_core0_memory_region and start of secure_ddr. So intention =
to=20
>> > fix the bug and use all of the available space.
>> >
>> >
>> >>
>> >>> 3. The existing fdt_fixup_reserved_memory() used a delete/recreate
>> >>>     approach which corrupted phandle references to DM node, causing =
DM
>> >>>     initialization failures. Fixed it by updating nodes in-place usi=
ng
>> >>>     fdt_setprop() to preserve original phandles.
>> >> I haven't looked at the code yet, why do you use a fixup instead of
>> >> fixing the devicetree?
>> >>
>> >> Best
>> >> Markus
>> >
>> >
>> > I had a discussion with bryan regarding the device tree fix approach. =
He=20
>> > pointed out that firmware and kernel versions can be updated=20
>> > independently which can lead to unused reserved memory. So bootloaders=
=20
>> > should dynamically update the reserved memory based on firmware=20
>> > requirements before handing off to kernel.
>>=20
>> Maybe I am missing something here, but isn't the firmware distributed
>> together with u-boot? u-boot gets the devicetree merged from upstream
>> every major version. So isn't a kernel update independent of
>> u-boot/firmware/devicetree update?
>>=20
>> Also do updates to the memory regions of your firmware really happen
>> that often?
>
> This originally spawned because the reserved memory size in Linux's DT=20
> was wrong. Fortunately it was a simple math error and yeah we should fit=
=20
> it there as well. But the fix exposed another issue.=20
>
> If DM _was_ to change its memory layout we don't have a way to fix it=20
> unless we keep the U-Boot build and Linux in sync. Unfortunately most of=
=20
> the distributions do not pin them together as tightly as we need for=20
> that to work.
>
> For SoCs like the 62 you are correct. There hasn't been much of a need=20
> to change the memory layout at all however for devices like the AM67A,=20
> AM62A and AM62D we've found people are starting to use different=20
> firmware to help with whatever they are tasking the DSP to do.
>
> The fdt fixup approach also has the added benefit of allowing people to=
=20
> try out different RTOS builds without having the headache of needing to=
=20
> modify DT to get the board to boot.

Thanks for explaining. If you prefer the fixups, can you please change
the code to be able to work with both layouts as documented in the
binding documentation?

  oneOf:
    - description: Basic layout
      items:
        - description: region used for dynamic DMA allocations like vrings =
and
                       vring buffers
        - description: region reserved for firmware image sections
    - description: Detailed layout
      items:
        - description: region used for dynamic DMA allocations like vrings =
and
                       vring buffers
        - description: region reserved for IPC resources
        - description: LPM FS stub binary
        - description: LPM metadata
        - description: LPM FS context data and reserved sections
        - description: DM RM/PM trace and firmware code/data

You can use the memory-region-names to know what is what.

Best
Markus

--e95009888694f4829f4fd2b0e445c540bb5414aeb4dbcfaa2e9947504710
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCajVA9RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMY
nQD/VKg0h3lua/a5o6rpPJ2hOLiaD6N9iN8kcAeGqeBEwp8BANzCgzubEvpYGI/r
Be3JrPl6iJqwU58Igzy0x2KRy4kA
=Nc+R
-----END PGP SIGNATURE-----

--e95009888694f4829f4fd2b0e445c540bb5414aeb4dbcfaa2e9947504710--
