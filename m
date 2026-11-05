Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222FA606D805
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bp4QLbZa;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=eXH/iznN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CDB1680A95;
	Thu,  5 Nov 2026 14:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KagI7SL0BNpF; Thu,  5 Nov 2026 14:07:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C84C6809F6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793887639;
	b=L/J6Bgp4YcnFHwpgbqaru+H2BsYuhOyY8Lw0gUKx2lDhp56o6awlcVbO1elA6+75yCmv
	 A5rF9HJkBPwuZrgjLLDf+6KQM0DQD4dS7tjeFtKVCg7FuJycSmP6BagdNivg/YPHDuIz0
	 X1JDukT1iQHV//atY/ESZLbYDPvBa1F1uzHIzcOZk+QRCag8YczrgKHxaN8VDWtNoSV6s
	 n+S/CyEtNJrrWEo1L6RRGXx4i58tPx/5/fgJdyKLfj15DM4dQLiqYdVfP2mvMEX693uvs
	 WZbEb7ZBbI1uqthf8tcLD/TQ61kjCQ5xAnkHHDAA7f5b4LuwSKNnSKc7x9sNruq5WHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793887639;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:Received:Received:DKIM-Signature:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 User-Agent:MIME-Version:X-Last-TLS-Session-Version:X-Rspamd-Fuzzy:
	 X-Virus-Scanned:X-Virus-Status:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=urJ9JxAaYgFqXKJM1emb4cB52FboPuEYE9lsxnj2Tb8=;
	b=Vz/+sfs/XEy+LQe41NUebQFEdeUFSakJVFGyeZ26EgwoYC1SKqRDB2KOkua2SQr5dePJ
	 xFJP8GtBE4WOSdHrdpQqA7rQKAO14rhjgzegAXId1rCC39nSXDxC/XWGk2aQPMN2BGKHT
	 sM3tn5asz6sNb+BJ6bt4ZqgHkTRcGkB45JlSUy52FMQG4f7G2XZUmXhdZaKPgNMcNGy8y
	 YetDS4pHFowSHFpO8gk4BXjWVKVtZWdc0+i5wvxTzs94aw5WIWKtibH/7G3UM9Xyby/40
	 GrjZoFSHl1acbHs5xKdH5wOzFlvOQ44cjOH6LW/cf+fHNHdVzx56H0ec9kWeZ/MJLFA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793887638;
	bh=urJ9JxAaYgFqXKJM1emb4cB52FboPuEYE9lsxnj2Tb8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bp4QLbZa2D/6+mEy8Vcu5klsTCX/V6b13JpBlQztC3ymYBXGiszORu7V3Ll1GBszM
	 QOSdvCmzgmA//vB/Mc3zhvzM7p3o4NimhtbHuLqeD9l1aKPj8tuubc5w1eFz7g7Cfg
	 4fHoViXGa+8NJDN3VDeOli3fx0GWyIBiAZbakEFaIsqhywPoV/R7fv7oW8S9oM5tvI
	 fvXsnd3y6B4vQis/u83HpW7AXst0Y5AMVzcbzIa+wHb0wyEM8/bRNM8vdCYdSVJCsh
	 wT0y/uIvwliPWEIRRu0dQG5GfwJvAPg9GUSK5IhCTC7Bj9PC/1sFqmVWRCoQktq6Jz
	 G/HGeDt7qKu/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C84C6809F6;
	Thu,  5 Nov 2026 14:07:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D0C337B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:07:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72C4560778
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:07:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8ubyfDeRH59c for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 14:07:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D53D6606AA
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=thomas.perrot@bootlin.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=bootlin.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=eXH/iznN
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D53D6606AA
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 14:07:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F268482A; Thu,  5 Nov 2026 15:07:11 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DCF784820
 for <u-boot@lists.denx.de>; Thu,  5 Nov 2026 15:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.perrot@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 29C904E40826;
 Thu,  5 Nov 2026 14:07:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F27E15FF85;
 Thu,  5 Nov 2026 14:07:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D332D10329258; Thu,  5 Nov 2026 15:06:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793887618; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references:autocrypt;
 bh=urJ9JxAaYgFqXKJM1emb4cB52FboPuEYE9lsxnj2Tb8=;
 b=eXH/iznNFoIqWKEItLJqRYydOsfWGCpsaqW8mCFU2xwrDMYwemJUxTRTedewtKuhGm18St
 /Nqy6vlMKm6u7VWIAsT6axQ6L8+SDqr4K1kMOamUnb/fQPEAN1fG5veb4A7VxWvvhE8lJt
 XhmINa8Rn7gvtQQi8n+PpXzsKKRme+eEMWx6qi5mmF8hZm2E9bG3fKU3gZI6VCzmkjEtgH
 DtkDri3l+Xg+xKz3TUHWaXZMZAfxuAuxgz10xLnJUf7R3y/aaA3MQw5zVSSKHZe07mEqTu
 4hqjRAoGYlT6RjoLxQLB/w2ocvC1fGbZhMaPMMKwZrjbX3f1XuATX1KWX+IVgA==
Message-ID: <0420ee712fe50b33299a94249357c366cc2ef3ce.camel@bootlin.com>
Subject: Re: [PATCH 0/3] riscv: Add support for the BeagleBoard.org
 BeagleV-Ahead
From: Thomas Perrot <thomas.perrot@bootlin.com>
To: Yao Zi <me@ziyao.cc>, u-boot@lists.denx.de
Cc: thomas.perrot@bootlin.com, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Conor Dooley
 <conor.dooley@microchip.com>, Jamie Gibbons <jamie.gibbons@microchip.com>
Date: Thu, 05 Nov 2026 15:06:56 +0100
In-Reply-To: <auniBY7vN13FsebY@pie>
References: <20261017-dev-tprrt-beaglev-ahead-spl-v1-0-f9dfdff50f59@bootlin.com>
 <auniBY7vN13FsebY@pie>
Autocrypt: addr=thomas.perrot@bootlin.com; prefer-encrypt=mutual;
 keydata=mQGNBF+/ZOUBDAC2DghCjZvmgYcve02OG7dGZ7Iy58uEwne3LB7w7nRwdAxKw7ZaiVqwY
 O+yNGVi+GVx7oA6Wn4pv46z+QDRLQiq6OseuXhkSGCg7U/yBCUq12B/GRGO1Qt2Qi1mJJT1s+1qZ5
 Gxv6Nypz9qKVn94GM2bR1hXBga0t87vBpebThOHmX5d/0dqIcVxRCM7onNb0dDyRoVgLS5rBhQzrL
 CMrJaCy39xZUy0J1SOlH4Mgk6EhJIPYY4wlzikGX6urg+Tc9EjGd78ry0e0p5U5qgjFR5QGJDy1Gn
 U3CfwbT9sowdCASDbQDUoltlv2iWJCLa0xl97KVchCa0pr7HKbFA3J5SLKqFYUBCkFL+5WudYlz2n
 XxiUgyviMQxyK+ij66kEi6/2zFDAecd43pHV7790ptqZBC3Jc67Emj7Vo3ShX6RXPPxxbeCTOF2uk
 I45aJ9XcVFH/MFE96NjXj8uahnIsiTPyuCUoJu8tj7TSQyue874qJqVQvqlFyt2aZYJZ8ruq8AEQE
 AAbQpVGhvbWFzIFBlcnJvdCA8dGhvbWFzLnBlcnJvdEBib290bGluLmNvbT6JAc4EEwEIADgCGwMF
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSHQHfGpqMKIwOoEiGfwAsFcf4K7QUCX79mdwAKCRCfw
 AsFcf4K7fhbC/wP0kSl6id2E/K3+UdXk6CLMVRbCFLCREzQs5WFpQ6l/I0WGOamhrOgegdszheiVF
 orlUP8d37XSpFAqydhKGaN78V5Dps0Wmwm4lIlS4MtQXJtSLUHXDJLIZLW0pw8tiPLKsd1o/yDkXE
 dnpsjJTRG6SdDSHnyOB2/gh4p+yTaLytFdARk/r4/P26+L+FiH0fFl+RnBt19LPklfKgeDc7GwIif
 ja+nIWpp3W23DAUuI6xduEut25Q89yu7Ci8CliLfAiLy9bIGjBQWU2Y+1/j/7KuPj6VbBsZWLTZY0
 hUmpJSTnWAqc9SMsNxo7NSQuddgviz5e2tqucaRqxP02FGzNa8U4NAKdWaXrlHG5Dglj9XH0DK+SH
 +c96qqFewYD8VPQ6XAGxQcXbrtJmiMor1R2DfziispLRvJcfYs8xqabbCtoS3ouXB9XRi8hn7A2kh
 ME1ryS+Oh63JshXHnw6bmjCpVd/p+fGLIGU6A47pJOpviKR4jEO84pl2ejtDZ3Tc=
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-2FpSz3Z1dQQ1/qFFgagG"
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Fuzzy: 9305407a5397f019ded38fdac93561475e0906013a9f0013509c768f0ef202b4392cb5bd37b2adbee48c06d67c8001961caea3bf96e394ce9b25c335bcc33c34
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--=-2FpSz3Z1dQQ1/qFFgagG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Yao,

On Tue, 2026-11-03 at 13:30 +0000, Yao Zi wrote:
> On Sat, Oct 17, 2026 at 07:41:20PM +0200, Thomas Perrot wrote:
> > This series adds support for the BeagleBoard.org BeagleV-Ahead, a
> > single
> > board computer built around the T-Head TH1520 SoC (4x Xuantie C910)
> > with
> > 4 GB of LPDDR4X and 16 GB of eMMC.
> >=20
> > Most of the work is already upstream: the TH1520 SoC support added
> > for the
> > Lichee Pi 4A (SPL, DDR controller, clock and pinctrl drivers,
> > binman FIT
> > generation) and the BeagleV-Ahead devicetree, which is available
> > through
> > OF_UPSTREAM. The board therefore only needs a small board
> > directory, a
> > U-Boot specific devicetree include and a defconfig.
> >=20
> > The one missing piece is in the DDR controller driver, which only
> > accepts
> > the dual rank firmware and fails with -EINVAL on the BeagleV-Ahead.
> > The
> > first patch makes it program the rank configuration and the address
> > map
> > from the number of ranks described by the firmware.
> >=20
> > As on the Lichee Pi 4A, u-boot-with-spl.bin contains the SPL, the
> > DDR
> > firmware, OpenSBI and U-Boot proper, and is loaded into SRAM
> > through
> > fastboot.
> >=20
> > The BeagleV-Ahead has a single rank of LPDDR4X, so the DDR firmware
> > has to
> > be generated from lpddr4x-3733-singlerank.lua, which is already
> > provided by
> > https://github.com/ziyao233/th1520-firmware, instead of the dual
> > rank
> > configuration used by the Lichee Pi 4A. This is described in the
> > documentation added by the third patch.
> >=20
> > Testing: the series builds with the Bootlin riscv64 glibc toolchain
> > (2026.08-1) together with OpenSBI v1.9, and produces a u-boot-with-
> > spl.bin
> > holding the SPL, the DDR firmware and the FIT image.
> >=20
> > The image was loaded into SRAM through the BROM fastboot interface
> > on a
> > BeagleV-Ahead. Without the first patch the SPL stops with "failed
> > to
> > initialize DDR controller: -22". With it, the DDR is initialized
> > with the
> > single rank firmware, OpenSBI and U-Boot proper start, and the
> > console
> > reports "Model: BeagleV Ahead", "DRAM:=C2=A0 4 GiB", both MMC
> > controllers and
> > the Ethernet device. The Ethernet link, the eMMC and microSD
> > accesses and
> > writing U-Boot to the eMMC were not tested. The dual rank behavior
> > is
> > unchanged by the first patch, but I could not test it on a Lichee
> > Pi 4A.
> >=20
> > Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
>=20
> lists.denx.de has been down for some time, and U-Boot has switched
> to u-boot@lists.u-boot-project.org=C2=A0for development, please update
> your
> Git tree.
>=20
> Please re-send the series to the available address, so there's a
> public
> copy available to everyone, and I'll continue to review, thanks for
> your
> patch.
>=20

Thanks, Yao. I just resent it to the new mailing list.

Kind regards,
Thomas

> Regards,
> Yao Zi

--=20
Thomas Perrot, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--=-2FpSz3Z1dQQ1/qFFgagG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEh0B3xqajCiMDqBIhn8ALBXH+Cu0FAmrsjYAACgkQn8ALBXH+
Cu2DQgwAgjIfxzlHNq13b4wvi9PXjRX4FyuYNl3gb8jIjanKvLxNMU4gGz/8WGyE
wtNdId/cwdTau7d5Ah2NSeGY6SKBa6Au2AcavFtjM5HjEXDXvREB7d5w7LuNY6OP
aU/h+iMgdgLC3c0sbF+AHTOyklxV4LOqHOTbWrZhpZfRinTSDJsYNaF56BWyBNhM
UPY6nwB2kRttwwHq1mJRSH0P9LDKROFWMk7v5pKMKG0PteOmoM0qiP/MZK94FGV/
wQEnfIK2aujFwrdMHrnXzMLyWy4DG2mm7WWc6xSCIy8wJSqn9c3KEx4gwpcZqaWE
G64eTzmEcW7opfXLw4zMqeKtInBZVV9pE+unVfZkgtmOeEsP08IF3UPqln7IMlGJ
jZcGOVYOETs/OSHDg1xnk8VDmihQOLC3W6/y1qWQKIv13VCPqXkRrpNQnCdRw/rg
hikOPJIaHRw5/pOUcMRKVUifknLfuAi6ruPsX5XrEq8W+TQJ6+6MEEwS1QdeCcM5
pv+pD5By
=epEG
-----END PGP SIGNATURE-----

--=-2FpSz3Z1dQQ1/qFFgagG--
