Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68A0C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 22:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C39C58766A;
	Tue,  7 Nov 2023 23:28:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hV7meynE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B3F87670; Tue,  7 Nov 2023 23:27:59 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B828B875EF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 23:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B360861418;
 Tue,  7 Nov 2023 22:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E0EC433C8;
 Tue,  7 Nov 2023 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699396075;
 bh=0J0+ZhGlCtDr1sF4S/j8+3bVXrsyVijXh1JgfcUDb4E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hV7meynEVaZvXqodrjmndpIBUQ08qGGTbfGLxEQMbGvFQPTMuN5XQNEzKqVNp2Zex
 mD52jbxU+BOpt/gYNd3qbi1AUOUPMxioF6scWZYzzmvVoSf22c102cbp0gmk4erxK9
 gZ0KoGHNffrK1szbg8U23T+GxwfBU9D1wM9PG5I6hTTySozJ3w5Tgx7z8dxpPvMmFN
 VuKpnxf25C5KVWs1z7hhdLD+ds/XF4+XmLgIL0utly4USYZcsZiCy7LxPGlOvB8Z6F
 tAhlMnwAB9dy6pRjTh4c4Y/EwfkJD2iN9+W7LqGwrbgHGuAXZg2LzoQV5TIhvrIQQl
 aWZyNcsPd5YJA==
Date: Tue, 7 Nov 2023 22:27:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107-flyaway-arguable-0bccc778b256@spud>
References: <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7ujj9GpTZLEoG9EX"
Content-Disposition: inline
In-Reply-To: <20231107221023.GS6601@bill-the-cat>
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


--7ujj9GpTZLEoG9EX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:


> further clarify or not
> the RISC-V ISA thing that's elsewhere in this thread (and part of the
> kernel, not a U-Boot thing).

TBH, this a bit fragmented across threads, and as someone that hasn't
been following it it's a bit difficult to tell exactly what is being
asked for. Would someone be able to ask it as a direct question?


--7ujj9GpTZLEoG9EX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUq55QAKCRB4tDGHoIJi
0nTuAP9EGYtPX/WYMWjuxsvayRACfbc+aWDa5Bbtw+eO73yhoAD/fCEmeGl8DZRG
4Xhg1JYvksW6cifZz3tC0G7VYG+CxAU=
=WXA+
-----END PGP SIGNATURE-----

--7ujj9GpTZLEoG9EX--
