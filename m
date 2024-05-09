Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC92AC10F1A
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 12:59:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BC108802D;
	Thu,  9 May 2024 14:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="NPTsuHtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA4A388076; Thu,  9 May 2024 14:59:44 +0200 (CEST)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F037587FCC
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 14:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail2; t=1715259581; x=1715518781;
 bh=2fZiz3dXT3P7rjR0pSIPJe5jxxqkoteUFb3H405bM04=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=NPTsuHtNhnqb3ZGUfneVdf4R6YR9ZBVS/Hsvfq5t4j/ME4rR93/inw/PqDHDuiPfr
 G4dx7bjLVp54D4WUMLAjJoSBnj6R9QMuNtVIRPV3IcUnkO1L44VLeYZ1uuJ9emIcNt
 SYuG8AvruHXuaIqbatHNoBIMQjIaIjl3rK+LxpEOx/RLyXvmzuMuc5JhSaZwU3GMck
 nen2U4uYUY9OYGfB3Hq3AtdEiqzsExj6QSIZB74HQKbRLT+hHRnSnDqnXvCDUo1uSU
 Xe5EihuFP5Qa4n8Rk9/eVbRVy6L5/Jr7u6FIVSFEVYarf9hkG63DOuaUTMRxQMw71u
 K6ETMbSyN1ucw==
Date: Thu, 09 May 2024 12:59:36 +0000
To: Sumit Garg <sumit.garg@linaro.org>
From: Sam Day <me@samcday.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mach-snapdragon: do carveouts for qcs404 only
Message-ID: <bHzxMz4-ns_UBmX6JiIwBdVyoBiKFJgmxJSqZptJjmGEmRNpYH7d0pv1MAIvvZQM-DnSgLud9Ws6B3HIs-XqxyptALQuCqECNRr1HZf_iak=@samcday.com>
In-Reply-To: <CAFA6WYN+2wtsyAtKNw5C_JSQyjHLNH3Bcbdr1FtizGFtS-vg7g@mail.gmail.com>
References: <20240507-qcs404-carveout-only-v1-1-93d06884b862@samcday.com>
 <CAFA6WYPEK0CeK-WATVymNSzYR6U3+gKxu0TpBeCQ7a03C7PObw@mail.gmail.com>
 <PaGjHRvdULVbxVZ6A0Mw4PKFhK2AmMa171TAjH-3X9skahkwpgp9AEvt_W7tfepnpu2cTHmJt0zhnaSo-ukBYGP0K7PdFieiiYUNaMpiG1k=@samcday.com>
 <81f02041-6cf8-439c-b7a2-9edbfe038de6@linaro.org>
 <CAFA6WYN+2wtsyAtKNw5C_JSQyjHLNH3Bcbdr1FtizGFtS-vg7g@mail.gmail.com>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 71bf6e99edbcd66118282ae9f17672ed315886ac
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

'Ello Sumit,

On Wednesday, 8 May 2024 at 4:48 PM, Sumit Garg <sumit.garg@linaro.org> wro=
te:

>=20
>=20
> On Wed, 8 May 2024 at 18:09, Caleb Connolly caleb.connolly@linaro.org wro=
te:
>=20
> > Hi Sam,
> >=20
> > On 08/05/2024 13:40, Sam Day wrote:
> >=20
> > > Salutations Sumit,
> > >=20
> > > On Wednesday, 8 May 2024 at 11:14 AM, Sumit Garg sumit.garg@linaro.or=
g wrote:
> > >=20
> > > > Hi Sam,
> > > >=20
> > > > On Wed, 8 May 2024 at 00:11, Sam Day me@samcday.com wrote:
> > > >=20
> > > > > The newly introduced carve_out_reserved_memory causes issues when
> > > > > U-Boot is chained from the lk2nd bootloader. lk2nd provides a
> > > > > simple-framebuffer device and marks the framebuffer region as no-=
map in
> > > > > the supplied /reserved-memory. Consequently, the simple_video dri=
ver
> > > > > triggers a page fault when it tries to write to this region.
> > > >=20
> > > > How does the corresponding Linux kernel driver handle this?
> > >=20
> > > Firstly: I'm something of a middle-man here. I would consider Caleb t=
he authoritative source on the carveouts stuff (since they wrote it) and Ni=
kita Travkin the authority on the simplefb handoff (since he originally wro=
te it for lk2nd to hand off to Linux simpledrm and then adapted it to work =
with U-Boot simplefb).
> > >=20
> > > I consulted with Nikita on your first question here. He linked me to =
this snippet: https://elixir.bootlin.com/linux/v6.9-rc7/source/drivers/gpu/=
drm/tiny/simpledrm.c#L877
> > >=20
> > > > Is the
> > > > framebuffer region required to be mapped as normal memory or device
> > > > type or something else?
> > >=20
> > > So I guess based on the link above, it's just mapped as normal uncach=
ed memory.
> > >=20
> > > I tried to do something like this a few days ago in U-Boot, but a) it=
 doesn't work and b) I have no idea what I'm doing: https://github.com/samc=
day/u-boot/commit/c100cb3711ddf5b01601691f3e6a9ec890d9a496
>=20
>=20
> Can you start adding some debug prints as to what might be happening?
> Also, look at my proposal below to hook memory mapping properly for
> drivers.

I got to the bottom of the issue. This commit seems to work:
https://github.com/samcday/u-boot/commit/25bf923c251b56d297d16898210fa36616=
294415

Calling mmu_set_region_dcache_behaviour alone is insufficient, as it
does not change the "flags" of the page-table entry in the way that
mmu_change_region_attr does. That's why it was triggering an abort
in the previous attempt: __asm_flush_dcache_range was trying to scrub
an entry that was still marked as PTE_TYPE_FAULT I guess :)

>=20
> > > After talking with Caleb about this for a bit, they suggested the pat=
ch you see here as what I guess could be considered a "stopgap" solution th=
at hopefully makes it into 2024.07.
> > >=20
> > > > Similarly would normal memory type work for
> > > > all other reserved memory regions marked as no-map?
> > >=20
> > > I'll let Caleb weigh in here. My understanding is that the other regi=
ons should be marked as PTE_TYPE_FAULT because otherwise drivers might inad=
vertently speculatively access regions that are very much off-limits, such =
as TZ app regions.
> >=20
> > Right, carving out reserved regions and having the driver handle them i=
s
> > theoretically the "correct" thing to do here. But I'm not sure that the
> > additional complexity offers much value from a U-Boot context.
> >=20
> > If we can teach the armv8 PT/cache code to handle this better, and teac=
h
> > all the drivers to map their regions on-demand, this would probably hel=
p
> > us a lot (especially as right now if you attempt to access dead space
> > between peripherals then you'll hang the bus...). But U-Boot is a ways
> > away from that.
>=20
>=20
> I am not sure if U-Boot is really that far away although you can say
> the infrastructure is not hooked up for Arm. Have a look into
> map_physmem() and unmap_physmem() utilized by various drivers which
> are actually hooked up on MIPS. So I think the right way to approach
> this feature on Qcom platforms is to start hooking up those APIs on
> mach-snapdragon to begin with via mmu_set_region_dcache_behaviour()
> underneath. We can always go ahead and make it more generic if needed
> on other platforms too.

So I'm happy to explore this further in a separate patch. Such a patch
doesn't seem like something that is suitable for inclusion in 2024.07
at this stage, right?

If not, I'm wondering if there's any chance we can still pull this patch
in as a stopgap measure? As it currently stands, the carveouts call is
the *only* thing preventing msm8916 devices from booting U-Boot when
chained from lk2nd.

-Sam

>=20
> -Sumit
