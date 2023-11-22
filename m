Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC5DC61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 18:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB58C875F7;
	Wed, 22 Nov 2023 19:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F00RjJ0z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C0D875E3; Wed, 22 Nov 2023 19:57:26 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E6B875FE
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 19:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dafe04717baso104233276.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700679443; x=1701284243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IB6UnubshO0U+8gLwdgfXchk/OYaEc4tCojxDiSBT1s=;
 b=F00RjJ0zXUhF7f0cyS4isCRyKOBMgVrNE7ZyeFf9sJXDH+7bIB90qDES1lJLRETZdq
 WM4qvJWAW2NBJ27kG2zgb+hbwFVynvA/Vq/Nq+8M8h0NQ5lNjMyEmra9djuFsNulg3AQ
 2uptlE16a4CBkPmkPJRVQyZHVSGgv014n01TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700679443; x=1701284243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IB6UnubshO0U+8gLwdgfXchk/OYaEc4tCojxDiSBT1s=;
 b=cUEWPkk5opqfaRa4P7QowASIPbe0BCdWUVq/qtUSVUlJ9e8uCePyW4ejvFgq0/fSdr
 v1LZLWd3ag7XZmN+nuYwfP992Jq5F+H9E1wyr/KNJ5UV3qNvhU1szQvyWCbuxIoScHFr
 HzrId/+VCNR4bF9XWma2F+BjWupxvY57NRFRSMK9YtzY115rcv34OMMz0myw/8MLqcOh
 82Sg0LmQLD0oAL6w0s7p7SyqymsCu4pf2rZTiRgZWk/6hot5H4MJUk6ew3YXHU0u51eW
 h5f+TaGTPuMFU/m5dl0A3sTBGqN3DISbOe+ZgZeKF/laStMscIaqBvqWTxG2MKFowBe+
 0oag==
X-Gm-Message-State: AOJu0YwDhx2id4eW9iiWgHd3r2WWC5dX62CTo5ocaT2MknkHMe5HQ7h/
 Bo7VRTKyrzImlGotzo4O22jRYg==
X-Google-Smtp-Source: AGHT+IH+QjpPKQrR6HPuRu9kohJ7RY0g184N7eOP+OESSeuf/jjGLbtE1ZWKtUut03DrQdsD2NaXKw==
X-Received: by 2002:a25:e7c7:0:b0:da0:833f:1245 with SMTP id
 e190-20020a25e7c7000000b00da0833f1245mr3131338ybh.8.1700679443015; 
 Wed, 22 Nov 2023 10:57:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a5b0747000000b00db40de8de5asm380995ybq.18.2023.11.22.10.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 10:57:22 -0800 (PST)
Date: Wed, 22 Nov 2023 13:57:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>, u-boot@lists.denx.de,
 mbrugger@suse.com
Subject: Re: [PATCH v2 0/3] rpi5: initial support
Message-ID: <20231122185720.GV2513409@bill-the-cat>
References: <CAKRNjQ0dsWozGo4n8g58m4cCEk3n=qx1R+L24WBgpo-iP1yo7A@mail.gmail.com>
 <20231122135209.GR2513409@bill-the-cat>
 <CALeDE9NoDskjivzwWcHV10g5-bVP-5MkY7Vcp8PrXUoQ1oj_-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E1gV1WD0Do4Cyrd2"
Content-Disposition: inline
In-Reply-To: <CALeDE9NoDskjivzwWcHV10g5-bVP-5MkY7Vcp8PrXUoQ1oj_-g@mail.gmail.com>
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


--E1gV1WD0Do4Cyrd2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 06:54:11PM +0000, Peter Robinson wrote:
> > > These patches bring initial boot support for RPI5. Without it the
> > > latest master fails with the message:
> > > > DRAM:  mbox: Timeout waiting for response
> > > > bcm2835: Could not query ARM memory size
> > >
> > > With those patches and rpi_arm64_defconfig (with disabled
> > > CONFIG_VIDEO_BCM2835) I'm able to get a working u-boot prompt (over
> > > serial). FDT comes from firmware (EEPROM).
> > >
> > > > U-Boot 2024.01-rc3-00003
> > > >
> > > > DRAM:  1016 MiB (effective 8 GiB)
> > > > mbox: Header response code invalid
> > > > bcm2835: Could not query board revision
> > > > FDT model : Raspberry Pi 5 Model B Rev 1.0
> > > > Core:  14 devices, 7 uclasses, devicetree: board
> > > > MMC:
> > > > Loading Environment from FAT... ** Bad device specification mmc 0 **
> > > > In:    serial,usbkbd
> > > > Out:   serial,vidconsole
> > > > Err:   serial,vidconsole
> > > > Net:   No ethernet found.
> > > > starting USB...
> > > > No working controllers found
> > > > Hit any key to stop autoboot:  0
> > > > No working controllers found
> > > > No ethernet found.
> > > > No ethernet found.
> > > > U-Boot>
> > >
> > > These patches are based on v2024.01-rc3 and tested with RPI5 8GB.
> > >
> > > Known issues:
> > > * CONFIG_VIDEO_BCM2835 doesn't work.
> > > * MBOX get board revision (0x10002) doesn't work (the response status
> > > is 0x8000_0001). Looks like a number of tags doesn't work anymore
> > > (board/serial/MAC) but could be fetched from FW FDT.
> >
> > Nice. I think it's the MMC controller that we should be able to support
> > with just a little more work as it's shared with rockchip, and we just
> > need to match the compatible, and mirror whatever tweak is also in the
> > rpi kernel tree for it.
>=20
> Is it? According to the RPi DT the sdio1 interface is used to drive
> the mSD card (it's SD Express capable which I think is essentially
> PCIe/NVME) which has a "brcm,bcm2712-sdhci" compatible [2] which is
> added to the sdhci-brcmstb.c driver[3]. We do have a driver for this
> but it's not the rockchip driver, I think you may be confused with the
> sdhci interface in the RP1 chip which is a designware sdhci IP called
> dwcmshc [4].

Yes, you're right I confused it with the sdhci IP.

--=20
Tom

--E1gV1WD0Do4Cyrd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeTwgACgkQFHw5/5Y0
tyySVgwApSUcbqfjbRMlvq89atsw6BW4QmPTJGhJVrNyafLZLipUeulQxwdaqai+
TDNtR5ms8gsJ2Ttq6A3FzG/eLoRLjOrfUJEPo0qd6ZXNRmwFlkQOkaAB+M7m/OFU
BjA9+VfA/MGDmUbxuMzE1v9cb6xz32LEOfZHTWmd+ldXh02IZS2OKgBCHkgy6oBp
g1dtmd79FpadsJWB+Ce4UHKGTQXWeDFmyU9uJTYBap7vfwFbf9eHFmdRmC7Eqj60
ql5qyrhcDYJ2FmN5/3vn+1M7t+9IObpfgsNa7Erz/Deb90kCtwxetldTA5E+o+11
NAkLmV1PffSUiWwcapMlLIBuW1UtFGOg7DTVOW4pY7SGX6Ozm4sy0fH7hznfzd6M
+7wgja9wzT6zWiieFfnd/7WKzG0nwBLrzWiWrw9QQ78WWn4fxbnHXUBv+yTm+MKI
VFFW37CpwF2ofyRjhOxm0KYVPYLRVf9lwJWUI53kaSgZhshvNneNAolEHqKuM6FB
PjZjARUO
=ksQG
-----END PGP SIGNATURE-----

--E1gV1WD0Do4Cyrd2--
