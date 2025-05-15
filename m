Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F69CC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 20:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51FA8091A;
	Thu, 15 May 2025 22:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="enHVvYCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAE68129F; Thu, 15 May 2025 22:45:45 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87257806D8
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 22:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-401e77e5443so1104188b6e.3
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747341942; x=1747946742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sliFPfvj5zUKSbhQLN03Gbzvqno+4xkKNqjjLBGMAZA=;
 b=enHVvYCJqg/XMkS/FbeOaDVC1qbFm6X223zoS1tNCrIvOVnwpUsglD4WZ1wf3IKhwh
 ak8bvBqP46PH7Y0nMwP/fZQ7ns9d/xOWKAVb7fWo4ta0f94cByPCPCAcTKqf1LCQlQAJ
 6kxHg+EKQh2qq6LDjl3PkEqidf+0/4CY6OIuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747341942; x=1747946742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sliFPfvj5zUKSbhQLN03Gbzvqno+4xkKNqjjLBGMAZA=;
 b=g6OiW+d4SNa2Pxovj7VBn5xNQisODHoAMP8/pkZO5EcCABlZISU/4F8k4gEph9ggzM
 ea28++T1AbdYavAPOXKNyVztq6R7Lv1N0Zb0HFK/ylakSx3aMY/TgZegSwfX8rRSGWrb
 P/jTVvCgWwBOpst8kxjOT6nPKzBGqa5bGJj1IIMxoXRc6U2D3X16QwHIMfdSkCPwBEnZ
 koVRo8I9w+XE0rdfuGVLfPwM1a7Ts2bRXQExKhaRhclLOvto01XNj9FyOy1bzE2fCioS
 fcK7H4+OD/KiTYkSxq/HQeeURYxQy8IJJQxQ+rFHUckfcsq+IbxXP+wkIAhS3kb/Py8J
 Qajg==
X-Gm-Message-State: AOJu0YyNUh67GfkyrW4OU+oa1wzDrVB5a+ckvco+er/3oqJ0guTTB8QW
 zg0Xz2QaJal2qp1KyZ+Yc8hgDEolSRkrdOdN5VmPWOnPC9cDh4CqwQoyOLxc/5Y4CTk=
X-Gm-Gg: ASbGnctHBDlnJH3cO44OlBqFdGkkbKbNoph8eSKkIkMvifsgAIL6dO//kcNyQFuij/d
 WL4Xn8vHcS9WbgZyXx9uzhQcVAdZgwc3A+vcBlLrIL7z27Qjg6dDmdgbR7Ugb51JNl4vHO7c8yR
 Al4FpfrkvNHwbYplDNRkVLSyKd3clH+SwgFKovOVRWhLPS/6VQkE7EuutLSMMNB4IBwVmylnz5r
 UZ1AXJ3CgakcP8Na1aNcKTXSEF2UOrbMGw9NFyj3xVJM6t883qwAYLgVgyS4UZKAXdTCkEF1N5e
 sT7HCJWxhxX1hKHYtxNOeDAZQ5jZzBL8z7Zyj5REBISPg759nNbl1scTSWCw16pWrIt0j4mixyN
 xp0anQtXm9flt
X-Google-Smtp-Source: AGHT+IEYJ6He2XPS2JYBpzzhcDRvheWvugkKz7kvSHSIZxl9fnyWu2F5UUXRzy7FsehYjyEvq3UaZw==
X-Received: by 2002:a05:6808:1649:b0:401:e949:6374 with SMTP id
 5614622812f47-404d86e648dmr827331b6e.16.1747341942189; 
 Thu, 15 May 2025 13:45:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-404d9805ed4sm73835b6e.24.2025.05.15.13.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 13:45:41 -0700 (PDT)
Date: Thu, 15 May 2025 14:45:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?iso-8859-1?Q?Fran=E7ois?= Ozog <francois.ozog@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: Re: [PATCH v4 17/22] passage: Add a qemu test for ARM
Message-ID: <20250515204538.GC100073@bill-the-cat>
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510134253.1581164-12-sjg@chromium.org>
 <20250514215831.GE603748@bill-the-cat>
 <CAFLszTjKuPSHovFsoKFBiWTmn_2LSENjNQ0r2bGjBSXQOxJfxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rfqKKiEZYa3CedBl"
Content-Disposition: inline
In-Reply-To: <CAFLszTjKuPSHovFsoKFBiWTmn_2LSENjNQ0r2bGjBSXQOxJfxQ@mail.gmail.com>
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


--rfqKKiEZYa3CedBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 09:26:54PM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, May 10, 2025 at 03:42:15PM +0200, Simon Glass wrote:
> >
> > > Check that the standard passage works on ARM, by setting it up in SPL
> > > and making sure that it comes through correctly in U-Boot proper.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v3)
> > >
> > > Changes in v3:
> > > - Add conditions to avoid enaling the test on qemu_arm_sbsa
> > > - Add support for a 64-bit test also
> > >
> > > Changes in v2:
> > > - Add a devicetree for qemu-arm so that qemu_arm_spl can work
> > >
> > >  configs/qemu_arm64_spl_defconfig |  5 +++++
> > >  configs/qemu_arm_spl_defconfig   |  6 ++++++
> > >  test/py/tests/test_passage.py    | 13 +++++++++++++
> > >  3 files changed, 24 insertions(+)
> > >  create mode 100644 test/py/tests/test_passage.py
> > >
> > > diff --git a/configs/qemu_arm64_spl_defconfig b/configs/qemu_arm64_sp=
l_defconfig
> > > index a9ed47c8d3b..60651f80938 100644
> > > --- a/configs/qemu_arm64_spl_defconfig
> > > +++ b/configs/qemu_arm64_spl_defconfig
> > > @@ -33,6 +33,10 @@ CONFIG_USE_PREBOOT=3Dy
> > >  # CONFIG_DISPLAY_BOARDINFO is not set
> > >  CONFIG_PCI_INIT_R=3Dy
> > >  CONFIG_BLOBLIST=3Dy
> > > +CONFIG_BLOBLIST_PASSAGE=3Dy
> > > +CONFIG_BLOBLIST_SIZE=3D0x4000
> > > +CONFIG_SPL_BLOBLIST_ALLOC=3Dy
> > > +CONFIG_PASSAGE_IN=3Dy
> > >  CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=3Dy
> > >  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> > >  # CONFIG_SPL_SEPARATE_BSS is not set
> > > @@ -47,6 +51,7 @@ CONFIG_CMD_EFIDEBUG=3Dy
> > >  CONFIG_CMD_TPM=3Dy
> > >  CONFIG_CMD_MTDPARTS=3Dy
> > >  CONFIG_SPL_OF_CONTROL=3Dy
> > > +CONFIG_OF_PASSAGE=3Dy
> > >  CONFIG_OF_BOARD=3Dy
> > >  CONFIG_ENV_IS_IN_FLASH=3Dy
> > >  CONFIG_SPL_DM=3Dy
> > > diff --git a/configs/qemu_arm_spl_defconfig b/configs/qemu_arm_spl_de=
fconfig
> > > index 9c4408dc73c..cf8ac703577 100644
> > > --- a/configs/qemu_arm_spl_defconfig
> > > +++ b/configs/qemu_arm_spl_defconfig
> > > @@ -13,6 +13,7 @@ CONFIG_ENV_SECT_SIZE=3D0x40000
> > >  CONFIG_DEFAULT_DEVICE_TREE=3D"qemu-arm"
> > >  CONFIG_TARGET_QEMU_ARM_32BIT_SPL=3Dy
> > >  CONFIG_SPL_SERIAL=3Dy
> > > +CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x9000
> > >  CONFIG_SYS_BOOTM_LEN=3D0x4000000
> > >  CONFIG_SYS_LOAD_ADDR=3D0x40200000
> > >  CONFIG_DEBUG_UART_BASE=3D0x9000000
> > > @@ -34,6 +35,10 @@ CONFIG_USE_PREBOOT=3Dy
> > >  # CONFIG_DISPLAY_BOARDINFO is not set
> > >  CONFIG_PCI_INIT_R=3Dy
> > >  CONFIG_BLOBLIST=3Dy
> > > +CONFIG_BLOBLIST_PASSAGE=3Dy
> > > +CONFIG_BLOBLIST_SIZE=3D0x4000
> > > +CONFIG_SPL_BLOBLIST_ALLOC=3Dy
> > > +CONFIG_PASSAGE_IN=3Dy
> > >  CONFIG_SPL_FRAMEWORK_BOARD_INIT_F=3Dy
> > >  CONFIG_SPL_NO_BSS_LIMIT=3Dy
> > >  CONFIG_CMD_BOOTEFI_SELFTEST=3Dy
> > > @@ -44,6 +49,7 @@ CONFIG_CMD_PCI=3Dy
> > >  CONFIG_CMD_TPM=3Dy
> > >  CONFIG_CMD_MTDPARTS=3Dy
> > >  CONFIG_SPL_OF_CONTROL=3Dy
> > > +CONFIG_OF_PASSAGE=3Dy
> > >  CONFIG_OF_BOARD=3Dy
> > >  CONFIG_ENV_IS_IN_FLASH=3Dy
> > >  CONFIG_SPL_DM=3Dy
> > > diff --git a/test/py/tests/test_passage.py b/test/py/tests/test_passa=
ge.py
> > > new file mode 100644
> > > index 00000000000..4d95287fe55
> > > --- /dev/null
> > > +++ b/test/py/tests/test_passage.py
> > > @@ -0,0 +1,13 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright 2021 Google LLC
> > > +
> > > +import pytest
> > > +
> > > +@pytest.mark.buildconfigspec('qemu_manual_dtb')
> > > +@pytest.mark.buildconfigspec('arm')
> > > +@pytest.mark.buildconfigspec('of_passage')
> > > +def test_passage(ubman):
> > > +    """Test that the standard passage on ARM from SPL to U-Boot work=
s."""
> > > +
> > > +    response =3D ubman.run_command('bdinfo')
> > > +    assert 'devicetree  =3D passage' in response
> >
> > Why is this test QEMU specific? This would be at least as interesting to
> > run on vexpress_fvp_bloblist and then any other real platform which also
> > uses this in the future. Since the time to run this test will be
> > negligible I don't see why it should be omitted elsewhere.
> >
>=20
> Yes, I can enable it for that board.

It's not a per-board enablement, it's dynamic because that's what:
@pytest.mark.buildconfigspec('of_passage')
gives us.

--=20
Tom

--rfqKKiEZYa3CedBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgmUnIACgkQFHw5/5Y0
tyyIrAwAhFluXVKn7oCV6udT4h73HhPqZyNpyZcmAXyQfrEhUOkKPp47114lPpnz
3EclKoLEtl7Hh7IVuiLreJ4zyzdQ+pkghVjVUeyVW58XgJgBENSj3IrT46Z3kiaM
bTy1FHGugqfDHECN355z9QXAJ6SMJadUUJtAcF/gfEyUBO3nredKHedJYoUCeYRn
0M1JH+2rrDSy/kdhDiKKCdu2odEniVwRCbtVZWN06XfsTbLoULPoYL2+t6EKU1sK
pwS52qFxcA2tz14IESI8x74CBJE6d2iSpZ/3PPtq83brMVklJqpFbpShBipRNMu6
mKQLP4S7EENd2ODVPb51yuHGFo+ANNGJu+CuNsFDyb2d5csGFOoQEUudQFCC8iEw
kSpbHvoRhSNNxnoqEgNCDgZ7a3EBsVbIThUIhJWfp3dnuuX872XbB8VV+fYmvxbT
+X2QtiyQ8K5nzdjbulW0h78hA1n8j0Q9g2S+Y4qOKT1L+3wazKN4bqz4zdpUXwba
ZnK7A7ne
=IMf7
-----END PGP SIGNATURE-----

--rfqKKiEZYa3CedBl--
