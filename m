Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B135E63F38
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 08:22:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C5D8063E;
	Mon, 16 Feb 2026 09:22:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yca349UD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62E3883CF2; Mon, 16 Feb 2026 09:22:04 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C58F880325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EE52E4333C;
 Mon, 16 Feb 2026 08:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD50C19424;
 Mon, 16 Feb 2026 08:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771230119;
 bh=1pY+s1SdoGkgAXH1hXYTNN/VU3m42j5wgFb6HyvjcZ4=;
 h=Date:Cc:From:To:Subject:References:In-Reply-To:From;
 b=Yca349UDw8yMwbgfhhWJl/MmUSOSi9M378siOZOBobDuXcSIGxMOAHkdiZOoriV6C
 eLPILCT27gweSt0Azj8RDvbgGrAB+6eKIR5ouebnl369OlAFH7Gj98PdNLYkGCZZ/P
 JrmTvYgUQSojssWhhc8E6QTUwyFDadKkdY3EFKIh6dlwySwD9+cFFcvSLxGycfYuD+
 21bTV8TtNadix5rSdMnVveTd8xYn9SPHafwOLvcOnaNowGNIPGtW+Fa21kd+Gi3ojE
 JKBzpPZHMISHWs3xtLzO+iCLBCVNRWTzXA4zvnTTfwCil6l2HzG65cn+cw0nuI2Oqu
 ev/r5W9F4gdMw==
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=a2fa5d58bc283d6d4644732674d3bb3106cc2bc4e5ac5e4a60b6b08c3838;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 16 Feb 2026 09:21:55 +0100
Message-Id: <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
Cc: <u-boot@lists.denx.de>, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Miquel Raynal" <miquel.raynal@bootlin.com>, "Takahiro Kuwano"
 <Takahiro.Kuwano@infineon.com>, "Hiroyuki Saito"
 <Hiroyuki.Saito2@infineon.com>, "Venkatesh Yadav Abbarapu"
 <venkatesh.abbarapu@amd.com>, "Prasanth Babu Mantena" <p-mantena@ti.com>,
 "Vaishnav Achath" <vaishnav.a@ti.com>, "Prasad Kummari"
 <prasad.kummari@amd.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Conor Dooley" <conor@kernel.org>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [RFH] SPI and SPI-NOR patch help
X-Mailer: aerc 0.20.0
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
In-Reply-To: <20260214-sternness-cling-4259916a8f73@spud>
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

--a2fa5d58bc283d6d4644732674d3bb3106cc2bc4e5ac5e4a60b6b08c3838
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
> On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
>> Hey all,
>>=20
>> To be blunt, U-Boot needs help with reviewing and maintaining the SPI
>> and SPI-NOR subsystems. We haven't had someone with time to actively
>> work in this area for some time. I'm going through the outstanding
>> changes now, but it also seems a common problem is that with respect to
>> device IDs, most of the new ones also aren't in the upstream Linux
>> Kernel. Is there some better and generic solution we're missing so that
>> we don't have large and often growing device ID tables? I'd rather not
>> make that problem worse, so I've rejected two of those types of updates
>> today and I'm just setting aside a large number of others.
>
> Dunno if your timing was cursed on sending this, but Tudor submitted his
> resignation from spi-nor maintainership in the kernel about 10 mins
> after.
> I think Michael Walle might be responsible for what you're talking about
> here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash driver"),
> but idk jack about spi-nor stuff.

Yeah. Nowadays SPI-NOR flashes come with self describing tables,
which are already supported by u-boot, I think. The only change that
seems to be missing is the fallback to it if an id isn't found in
the flashdb. Only thing is, the SFDP doesn't describe all features,
most prominent example being locking. So if you need that, you'll
still need to have an entry per flash.

In fact, in linux I'm planning to change to make it probe SFDP first
and then amend it with the flashdb information (if there is an
entry).

-michael

--a2fa5d58bc283d6d4644732674d3bb3106cc2bc4e5ac5e4a60b6b08c3838
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCaZLTpBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/hazgF8D1FacxqKBGPse2Gi1QRMot6rISlZlc6c
H03NtiYFehprnfbNROD7pMkzI0ab12tyAYDGDKEcRatHA7kR5Uy24FdwpAyCHxGl
1bHeR1wQWxaJdr9/ArW8aYTiWdU4vC6eBm4=
=ZLOV
-----END PGP SIGNATURE-----

--a2fa5d58bc283d6d4644732674d3bb3106cc2bc4e5ac5e4a60b6b08c3838--
