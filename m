Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BB3C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B4987947;
	Sat, 23 Mar 2024 19:54:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N2f0Q5Il";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4843487947; Sat, 23 Mar 2024 19:54:21 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527428792D
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 69049CE0934;
 Sat, 23 Mar 2024 18:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B136C433C7;
 Sat, 23 Mar 2024 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711220055;
 bh=u+CA56Rieq2bEbMDnJhzvMAw6Vd1r8x7BkAFypKkyV8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=N2f0Q5IlZcLPXro7KACVAPS63A6XvpoRi1LuvQC0jAfj4VdeC6Vtr5VOtx0AQXzE9
 gtz4CMjo4ib3/rusLn2bwOFfkZ+cXVTlGX/GL1YZfrtSEp55962jaN7OPOIAvfAISE
 qY/YTVZLZBooveiLJMDrge8NrzWlNKELS6/TN4kqjjylbDA5VUjJ0PLl/uRG1j5kZx
 64Cgsdfs66W4f5mJTSEnM9+lnYmsXRr+gRu7GIPAiyVb3whE9jKstlXWZPAojvwOpr
 grNc7ip6EeuunjfuQbfC4yJKB5DY5aWU8BLsroWCZszKoJhMmjMF6fTQjuXaIZ3QqC
 Cy26rOe+yCbew==
Date: Sat, 23 Mar 2024 19:53:57 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu v2 16/18] cmd: rng: Print "Abort" on -EINTR
Message-ID: <20240323195357.35821b1b@thinkpad>
In-Reply-To: <6DA3EF0E-5083-4A27-B20A-BDE297C74687@gmx.de>
References: <20240323180711.5498-1-kabel@kernel.org>
 <20240323180711.5498-17-kabel@kernel.org>
 <6DA3EF0E-5083-4A27-B20A-BDE297C74687@gmx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 23 Mar 2024 19:30:20 +0100
Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:

> Am 23. M=C3=A4rz 2024 19:07:09 MEZ schrieb "Marek Beh=C3=BAn" <kabel@kern=
el.org>:
> >In the rng command, print
> >  Abort
> >instead of
> >  Reading RNG failed
> >if the error number is -EINTR. =20
>=20
>=20
> It is unclear what would be the user benefit.
>=20
> 'Abort' relates to a user pressing CTRL-C?
>=20

Precisely. The next patch of this series adds a rng driver that handles
ctrlc() events.

Marek
