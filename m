Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C428C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 11:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B709C882C8;
	Wed,  8 May 2024 13:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="roWj69cz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8841988393; Wed,  8 May 2024 13:40:15 +0200 (CEST)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8A6882C8
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 13:40:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1715168412; x=1715427612;
 bh=BOmsCO5MspT/LPzA57SWrmc33v3o2goSGw1DzcHYig8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=roWj69czz5SbZnP4OU7n2pRcVTJKJJOt4UkgUAVSdwnp12CqCKY25/ipePUPG9fkw
 xdnhWOHba2HVRwWW9vCSkPYsOMpmVJXP7Ihw+C5gGe9XpemnliXRpveZjM7OG4VbvD
 4Yt1cJBsQfLmoavLHzZBmBJoYUXe1w4yuNlYx4WHlJ3avwkktiFovUUoWJTS+lcHAn
 RD3tZORST071aFT+TBAmyugxC4ssFrxJoxifHx9bDdYDz4u9ZFym8PotdUID4DkCEG
 06eDgomTE8+QBOalNeEjbN2RaYqbnlrFpuePDA13KmlDAXxNF3esja9LOoIGpDrISF
 h7BEoHfvst+cA==
Date: Wed, 08 May 2024 11:40:08 +0000
To: Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
Message-ID: <PaGjHRvdULVbxVZ6A0Mw4PKFhK2AmMa171TAjH-3X9skahkwpgp9AEvt_W7tfepnpu2cTHmJt0zhnaSo-ukBYGP0K7PdFieiiYUNaMpiG1k=@samcday.com>
In-Reply-To: <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
 <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 95befe42479d6066fa6012fb680b3c0cded5b443
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Salutations Sumit,

On Wednesday, 8 May 2024 at 11:14 AM, Sumit Garg <sumit.garg@linaro.org> wr=
ote:

>=20
>=20
> Hi Sam,
>=20
> On Wed, 8 May 2024 at 00:11, Sam Day me@samcday.com wrote:
>=20
> > The newly introduced carve_out_reserved_memory causes issues when
> > U-Boot is chained from the lk2nd bootloader. lk2nd provides a
> > simple-framebuffer device and marks the framebuffer region as no-map in
> > the supplied /reserved-memory. Consequently, the simple_video driver
> > triggers a page fault when it tries to write to this region.
>=20
>=20
> How does the corresponding Linux kernel driver handle this?

Firstly: I'm something of a middle-man here. I would consider Caleb the aut=
horitative source on the carveouts stuff (since they wrote it) and Nikita T=
ravkin the authority on the simplefb handoff (since he originally wrote it =
for lk2nd to hand off to Linux simpledrm and then adapted it to work with U=
-Boot simplefb).

I consulted with Nikita on your first question here. He linked me to this s=
nippet: https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/gpu/drm/ti=
ny/simpledrm.c#L877

>  Is the
> framebuffer region required to be mapped as normal memory or device
> type or something else?

So I guess based on the link above, it's just mapped as normal uncached mem=
ory.

I tried to do something like this a few days ago in U-Boot, but a) it doesn=
't work and b) I have no idea what I'm doing: https://github.com/samcday/u-=
boot/commit/c100cb3711ddf5b01601691f3e6a9ec890d9a496

After talking with Caleb about this for a bit, they suggested the patch you=
 see here as what I guess could be considered a "stopgap" solution that hop=
efully makes it into 2024.07.

> Similarly would normal memory type work for
> all other reserved memory regions marked as no-map?

I'll let Caleb weigh in here. My understanding is that the other regions *s=
hould* be marked as PTE_TYPE_FAULT because otherwise drivers might inadvert=
ently speculatively access regions that are very much off-limits, such as T=
Z app regions.

Cheers,
-Sam

>=20
> -Sumit
>=20
> > As per Caleb's advice, this simple patch only does the carveouts for th=
e
> > qcs404 SoC for which it was originally designed. The intent is to do th=
e
> > carveouts for more Qualcomm SoCs in future.
> >=20
> > ---
> > I'm not sure if it's feasible to get this in for the 2024.07 release,
> > but it'd be great if we could - it's the only thing that breaks U-Boot
> > master on msm8916 devices that chain from lk2nd.
> >=20
> > Signed-off-by: Sam Day me@samcday.com
> > ---
> > arch/arm/mach-snapdragon/board.c | 12 +++++++-----
> > 1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdrago=
n/board.c
> > index 3d5994c878..b439a19ec7 100644
> > --- a/arch/arm/mach-snapdragon/board.c
> > +++ b/arch/arm/mach-snapdragon/board.c
> > @@ -467,10 +467,12 @@ void enable_caches(void)
> > gd->arch.tlb_addr =3D tlb_addr;
> > gd->arch.tlb_size =3D tlb_size;
> >=20
> > - carveout_start =3D get_timer(0);
> > - /* Takes ~20-50ms on SDM845 /
> > - carve_out_reserved_memory();
> > - debug("carveout time: %lums\n", get_timer(carveout_start));
> > -
> > + / We do the carveouts only for QCS404, for now. /
> > + if (fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") =3D=3D =
0) {
> > + carveout_start =3D get_timer(0);
> > + / Takes ~20-50ms on SDM845 */
> > + carve_out_reserved_memory();
> > + debug("carveout time: %lums\n", get_timer(carveout_start));
> > + }
> > dcache_enable();
> > }
> >=20
> > ---
> > base-commit: 1c40dda60f5f7e83a6d6f541cf5a57eb7e8ec43c
> > change-id: 20240507-qcs404-carveout-only-7a15bbf3fd89
> >=20
> > Best regards,
> > --
> > Sam Day me@samcday.com
