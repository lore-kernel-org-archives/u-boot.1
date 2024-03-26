Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA690C6FD1F
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 15:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 259A087EFA;
	Tue, 26 Mar 2024 16:13:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OosWbu+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50B3987F5D; Tue, 26 Mar 2024 16:13:14 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF2C87971
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 16:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1711465991;
 bh=ti3uQeFBoc/p6EftDrVPN6Swu/xr9GqEFIVtYx8aO+k=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=OosWbu+yf+kkKmHkk7TEEvrq3fMFXrG7dUXWHmTPne9JCE36I/1nrkLp7u52jA6qY
 ChGTNYRSUCzt6LxLcrlH7hMLGiOCCjiUOnD/5ryKo5zZV25Rubx/MTtzFXugl2/6cm
 acExZyjXhdJlpc/d357qN4CSJh/S93Ml7Vwfc0gUyialhIPBwGlYx86j9Po+w+0CHj
 0noKC5UD8PlPikoF05IqhrlWTkkByJYVv6mu2hA0XQB5gyz+3YSr51sHc6iQDbzyCP
 hmc6ZSOzf6KVdrQp4ij9vc2qcBk+4izfHAvUeMCEij56k4e9m2pWqO0kff8bqJKOuu
 15ik7e8/LKtYQ==
Received: from [100.117.211.133]
 (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: martyn)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 534F6378020D;
 Tue, 26 Mar 2024 15:13:11 +0000 (UTC)
Message-ID: <c02e12d7384eae7c7bc667aab8bef564d42d3ccc.camel@collabora.com>
Subject: Re: [PATCH] am625x_evm_a53: Tweak boot command to set fdt
From: Martyn Welch <martyn.welch@collabora.com>
To: Christopher Obbard <chris.obbard@collabora.com>, Dave Gerlach
 <d-gerlach@ti.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Date: Tue, 26 Mar 2024 15:13:10 +0000
In-Reply-To: <a01a752d7ad07d64d574547599b50f516ca04433.camel@collabora.com>
References: <20240326142634.2043539-1-martyn.welch@collabora.com>
 <a01a752d7ad07d64d574547599b50f516ca04433.camel@collabora.com>
Autocrypt: addr=martyn.welch@collabora.com; prefer-encrypt=mutual;
 keydata=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
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
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

On Tue, 2024-03-26 at 14:35 +0000, Christopher Obbard wrote:
> Hi Martyn.
>=20
> On Tue, 2024-03-26 at 14:26 +0000, Martyn Welch wrote:
> > With the current config for tha SK-AM62, fdtfile isn't set in the
> > U-Boot
> > environment. When using bootflow to boot from a block device, where
> > the
> > extlinux.conf file specifies `fdtdir`, a fallback device tree is
> > being
> > constructed from the `soc` (`k3`) and `board` (`am62x`) environment
> > variables, resulting in u-Boot trying to retrieve
> > `/dtbs/6.8.1+/k3-am62x.dtb`. This file doesn't exist.
> >=20
> > The environment variables `default_device_tree` and
> > `default_device_tree_arch` are set in the config, the `findfdt`
> > script
> > can be called to construct `fdtfile` from the environment variables
> > set
> > by these config options, however this script currently isn't being
> > run.
> >=20
> > Calling this script results in the correct device tree being
> > retrieved:
> >=20
> > =C2=A0=C2=A0 Retrieving file: /dtbs/6.8.1+/ti/k3-am625-sk.dtb
> >=20
> > Many boards are calling this script as part of their boot command.
> > The
> > am62x currently isn't. Rectify this so that booting works
> > correctly.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>=20
> Would this also be appropriate to add to the defconfig for other
> AM62x boards
> (e.g beagleplay) ?
>=20

Hi Chris,

Probably, but this is the only board I have available to test.

Martyn

> Anyway, for this device:
>=20
> Reviewed-by: Christopher Obbard <chris.obbard@collabora.com>
>=20
> > ---
> > =C2=A0configs/am62x_evm_a53_defconfig | 2 +-
> > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/configs/am62x_evm_a53_defconfig
> > b/configs/am62x_evm_a53_defconfig
> > index 78287ec18a..e373e44a93 100644
> > --- a/configs/am62x_evm_a53_defconfig
> > +++ b/configs/am62x_evm_a53_defconfig
> > @@ -30,7 +30,7 @@ CONFIG_SPL_LOAD_FIT=3Dy
> > =C2=A0CONFIG_SPL_LOAD_FIT_ADDRESS=3D0x81000000
> > =C2=A0CONFIG_BOOTSTD_FULL=3Dy
> > =C2=A0CONFIG_SYS_BOOTM_LEN=3D0x800000
> > -CONFIG_BOOTCOMMAND=3D"run envboot; bootflow scan -lb"
> > +CONFIG_BOOTCOMMAND=3D"run findfdt; run envboot; bootflow scan -lb"
> > =C2=A0CONFIG_BOARD_LATE_INIT=3Dy
> > =C2=A0CONFIG_SPL_MAX_SIZE=3D0x58000
> > =C2=A0CONFIG_SPL_HAS_BSS_LINKER_SECTION=3Dy
>=20
> Thanks!
>=20
> Chris

