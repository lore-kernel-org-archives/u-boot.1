Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8A5C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 16:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C915887740;
	Fri, 22 Dec 2023 17:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lcWGwpDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F86877BC; Fri, 22 Dec 2023 17:03:27 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C48D876D3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 17:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f83812a32so8962836d6.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 08:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703261004; x=1703865804; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zH1pkMy8VGfb8dELkBg4egLNWavAuVuYdpEtzG73+XE=;
 b=lcWGwpDuKZ7+PXZTZDgApxON6iSim8Ij42Z6BdouBSWeC7k0O3bGtSzYthuPkwTHrw
 otzNv3g52eXvyuDpyqKZlz9HMLaBZv/JYPGDkV9qxhlQejdPB0rabeX36AUwMQkkZ5Vo
 sUSeF+BPwoZAgUiUYWo+W0/KJo98goHDxOSyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703261004; x=1703865804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zH1pkMy8VGfb8dELkBg4egLNWavAuVuYdpEtzG73+XE=;
 b=hO77lJ1K1jMS/RCciw4hnoQmujFpzTOqxriVdcoYMRXWGq65XVME4QoDVLG5jE6/Fd
 QJsRyKRNRADJp11diHgJud+YwIXD/vTm8nIYFvOFd9tAMyVnsuSvZB36QR+AXxf0SZ63
 h8WsxnzISx6jL8DT70YEavTemO4R2Vi0OweUln6BAnknB1zUY1eC30KpHIeVmn3XfRz4
 /cn4vgV0vDKg6P3dgSab3k6BlCW2OVsCJyY+x3v9VhjdUONLqINm42J4izLId+wZKvx3
 TPVV4Qoe5f40fTpCKRRszlD/c1xOXCZZSHDCF7p7WCeNwcAy00xnRGY/v0x+NbEvVybL
 B4ag==
X-Gm-Message-State: AOJu0YxNbFyooZL/TVwhQTRjT2eVFvBglyfs5Ky5dQkzCCCBZXJLMI4c
 WgeJGHnMH+IkWoT7lm6Mr7Jg64SrBsLW1g==
X-Google-Smtp-Source: AGHT+IEF0u6lBc3ki/K49YVA4CPPcHpFXAnPp7NtaVBzTb+pfJrLyvdwzd36V3C0wG2k6lM9P+JJXg==
X-Received: by 2002:a05:6214:519c:b0:67f:4ad:d9 with SMTP id
 kl28-20020a056214519c00b0067f04ad00d9mr1731237qvb.74.1703261003863; 
 Fri, 22 Dec 2023 08:03:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 j13-20020a0cf30d000000b0067f49337d45sm1455471qvl.98.2023.12.22.08.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 08:03:23 -0800 (PST)
Date: Fri, 22 Dec 2023 11:03:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org,
 b.galvani@gmail.com, xypron.glpk@gmx.de, michal.simek@amd.com,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, marex@denx.de
Subject: Re: [PATCH v2 0/8] An effort to bring DT bindings compliance within
 U-Boot
Message-ID: <20231222160320.GC2652760@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <02fdfc4b-113b-409f-8aaf-8f4a04822706@linaro.org>
 <CAFA6WYM8EVY-D_Kptggsvxq0ZrFdP0gQ3y4UEbM+vLu0F8tLjw@mail.gmail.com>
 <c6d65491-c407-4518-aee9-f53f6d4a84ed@linaro.org>
 <20231222154614.GA2652760@bill-the-cat>
 <d91437da-137c-411f-adce-8bd5d1069a41@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qSet2V/65ti8G7wh"
Content-Disposition: inline
In-Reply-To: <d91437da-137c-411f-adce-8bd5d1069a41@linaro.org>
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


--qSet2V/65ti8G7wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 04:55:54PM +0100, Krzysztof Kozlowski wrote:
> On 22/12/2023 16:46, Tom Rini wrote:
> > On Fri, Dec 22, 2023 at 04:38:01PM +0100, Krzysztof Kozlowski wrote:
> >> On 22/12/2023 14:43, Sumit Garg wrote:
> >>> On Fri, 22 Dec 2023 at 13:48, Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 22/12/2023 07:12, Sumit Garg wrote:
> >>>>> Changes in v2:
> >>>>> --------------
> >>>>> - Patch #1: excluded gitab CI config check and added commit descrip=
tion.
> >>>>> - Patch #3: s/UBOOT_DTSI_LOC/u_boot_dtsi_loc/
> >>>>> - Patch #4: s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> >>>>> - Patch #5: s/U-boot/U-Boot/
> >>>>> - Patch #6 and #7: Picked up review tags
> >>>>>
> >>>>> Prerequisite
> >>>>> ------------
> >>>>>
> >>>>> This patch series requires devicetree-rebasing git repo to be added=
 as a
> >>>>> subtree to the main U-Boot repo via:
> >>>>>
> >>>>> $ git subtree add --prefix devicetree-rebasing \
> >>>>>       git://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devi=
cetree-rebasing.git \
> >>>>>       v6.6-dts --squash
> >>>>>
> >>>>> Background
> >>>>> ----------
> >>>>>
> >>>>> This effort started while I was reviewing patch series correspondin=
g to
> >>>>> Qcom platforms [1] which was about to import modified devicetree so=
urce
> >>>>> files from Linux kernel. I suppose keeping devicetree files sync wi=
th
> >>>>> Linux kernel without any DT bindings schema validation has been a p=
ain
> >>>>> for U-Boot SoC/platform maintainers. There has been past discussions
> >>>>> about a single DT repo but that hasn't come up and Linux kernel rem=
ained
> >>>>> the place where DT source files as well as bindings are placed and
> >>>>> maintained.
> >>>>
> >>>> Thanks for doing this.
> >>>>
> >>>> I really suggest to store information that kernel DTS is directly
> >>>> re-used, thus DTS backward and forward compatibility matters, also in
> >>>> Linux kernel sources. The point is that sub-arch maintainers should =
be
> >>>> aware of it. I don't think that as DT maintainers we can efficiently
> >>>> keep an eye on it. Maybe create a subsystem profile and include it to
> >>>> maintainer entries of such affected platforms?
> >>>>
> >>>
> >>> From U-Boot point of view, currently we have the config option:
> >>> "CONFIG_OF_UPSTREAM=3Dy" per platform which means directly re-use of
> >>> kernel DTS. So U-Boot sub-arch maintainers should be aware of
> >>> platforms which get converted to re-use kernel DTS.
> >>
> >> I was speaking about kernel.
> >>
> >>>
> >>> I suppose we have to relay information to kernel sub-arch maintainers
> >>> who aren't the same as maintaining U-Boot counterparts. How about
> >>> adding U-Boot ML to CC for whichever DT change gets submitted in the
> >>
> >> And every other project? Just setup lei filters.
> >>
> >>> kernel? Otherwise adding U-Boot sub-arch maintainers as reviewers for
> >>> corresponding kernel DT changes works too if that's acceptable.
> >>
> >> You just entirely ignored my proposal without addressing it... ok let =
it
> >> be. No, CC-ing U-boot maintainers changes nothing because as I said, I
> >> want kernel maintainers and contributors to be aware.
> >=20
> > Maybe an underlying question is, what kernel maintainers aren't aware,
> > but should have been already? Then we can figure out how to address
>=20
> None of them is aware.
>=20
> > that. For example, with your Samsung hat on you weren't aware that
> > exynos 4/5/7 DTS files are cared about by U-Boot, but are now aware.
>=20
> Hm, I am still not aware of this. I mean, you wrote it above, but it is
> the first time I see using directly usptream DTS for U-Boot on Samsung
> platforms.
>=20
> Did anyone test it actually? I certainly did not. I think this patchset
> did not remove U-Boot-tree Samsung DTS, did it?

With this literal patchset, only the amlogic platforms Sumit is changing
have been tested, yes. In general, the U-Boot guideline has been "resync
your DTS files from the kernel as often as possible" as well as "start
with DTS files from the kernel, not hand-crafted". And some SoCs/vendors
have been better about following these rules than others. There's a good
number of commits under arch/arm/dts/ today syncing up with various
states of v6.6. Which I guess emphasises my question, what kernel
maintainers weren't aware that U-Boot has been consuming their DTS files
as-is (as much as possible) for a number of years now?

--=20
Tom

--qSet2V/65ti8G7wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFs0UACgkQFHw5/5Y0
tyywZwwAnyHFua8NBztmJ5FM4yRIpX/hVpKb/qhtOeITW2guyCSow6h1JSYk6RFM
GRkbNGJFtTl1Em3I2pWR5darARLMglmhkQr5xpO5m/jKyFP3cRqqd9DdrSRKNGdo
wyErpXR1/iK3tV0zaqzEA9WXfDgC32nwXCAPsxUY0LAPCczSs1DBVvpEFH/pXEsN
54Tapj+6n5MVaI1z9mb3DzHj7O+SnOT8NzJZmVebCh5MqJasWiYIp9zTUipRfdqs
taeXu4UqTB9C9JGz4smHZO9o60/T+Ilq8VTLFmoEzHp/Ux6S9RVSLbQk896TqRCW
bapmD5BB0MgA7vOZHdFVAc44HtQDlnyx5RysAVb5hxWJ305K9YPFIl+hzyBEqJaH
6S2hpGVbwKXXeEMpWEw2vsSCur9wPLWMOEdAjJvw9LitnpskrLq8w830saF60dZt
YTu+nwjCPaW58AKrv9CP28sldBdzU9Wo3EM5UCJ6YAnWXEXslZbBhXut+yCU7fue
gcmAAjza
=9N1Z
-----END PGP SIGNATURE-----

--qSet2V/65ti8G7wh--
