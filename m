Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F207ECD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 07:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C776883AA;
	Thu,  4 Apr 2024 09:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CrIWfUhu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE41883A9; Thu,  4 Apr 2024 09:38:58 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBA188380
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 09:38:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 44738CE2FAC;
 Thu,  4 Apr 2024 07:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93533C43390;
 Thu,  4 Apr 2024 07:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712216332;
 bh=X56T1J8I+mYAsoGH4GlsIvzAwNDe2t/lcN7Wzij1YAk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CrIWfUhuHieadkUhRERIF0/50SVjindPXCPk/ZDjkHWGcW9xMqcU7syBFnK1b7ZV9
 yLuyngTqaBi4aQoAe4N4wIlbaID7l5wEFceYk3QmRgFl8MdG/+78BfSBH4tQQItZ9V
 xpaamS1KX0RJHRSvPvhnFvphIYOA6vmRHinZMh8W5CxhHs/okRklZs5wVgtVOW1VVp
 4PqtFZShqfTQLA6VOIqjGSozxabEA4qSeqBLu+OgHAs2pJDRTl3GDguRsAIWD0oIpX
 kGTxz7IjEgD2xthCphQo5rYCzw/C3AzmPBrP8B8DxE/8ihZYvcEnL+rcZ5QYtccZlW
 gXcAOfOK9IEOA==
Date: Thu, 4 Apr 2024 09:38:48 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de, Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich
 Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH u-boot-mvebu v3 00/18] Turris Omnia - New board revision
 support
Message-ID: <20240404093848.60521bbe@dellmb>
In-Reply-To: <b37ad950-46e4-443d-98b9-9d34bb47bde0@denx.de>
References: <20240327162355.24584-1-kabel@kernel.org>
 <b37ad950-46e4-443d-98b9-9d34bb47bde0@denx.de>
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

On Thu, 4 Apr 2024 08:38:02 +0200
Stefan Roese <sr@denx.de> wrote:

> Hi Marek,
>=20
> On 3/27/24 17:23, Marek Beh=C3=BAn wrote:
> > Hi Stefan,
> >=20
> > this is v3 of series adding support for new board revision of Turris
> > Omnia.
> >=20
> > Changes since v2:
> > - patch 2: updated MCU command interface header
> > - patch 6: fixed bug setting \0 as end of string in src array instead
> >             of dst array after bin2hex() call
> > - patch 16: updated commit message (added the bit about ctrl+c)
> >=20
> > v1 and v2 at:
> >    https://patchwork.ozlabs.org/project/uboot/cover/20240304152148.3847=
-1-kabel@kernel.org/
> >    https://patchwork.ozlabs.org/project/uboot/cover/20240323180711.5498=
-1-kabel@kernel.org/ =20
>=20
> After pushing there changes in my current master I get these build
> errors for "turris_omnia_defconfig":
>=20
> make[1]: *** No rule to make target=20
> 'board/CZ.NIC/turris_omnia/../turris_common.o', needed by=20
> 'board/CZ.NIC/turris_omnia/built-in.o'.  Stop.
> make[1]: *** Waiting for unfinished jobs....
> board/CZ.NIC/turris_omnia/../turris_atsha_otp.c:14:10: fatal error:=20
> turris_common.h: No such file or directory
>     14 | #include "turris_common.h"
>        |          ^~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.build:257:=20
> board/CZ.NIC/turris_omnia/../turris_atsha_otp.o] Error 1
> board/CZ.NIC/turris_omnia/turris_omnia.c:36:10: fatal error:=20
> ../turris_common.h: No such file or directory
>     36 | #include "../turris_common.h"
>        |          ^~~~~~~~~~~~~~~~~~~~
> compilation terminated.
>=20
> Available here:
>=20
> https://source.denx.de/u-boot/custodians/u-boot-marvell/-/commits/master?=
ref_type=3Dheads
>=20
> Could you please have a look?

I forgot to do a git add on the new files turris_common.c and
turris_common.h in patch 05/18. Will send v4.

Marek
