Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1402EC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 04:02:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E8288E23;
	Thu, 25 Apr 2024 06:02:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mailtundra.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailtundra.com header.i=@mailtundra.com header.b="FuizOk2r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085ED88E54; Thu, 25 Apr 2024 06:02:43 +0200 (CEST)
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40AF888E20
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 06:02:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mailtundra.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwleeds@mailtundra.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailtundra.com;
 s=protonmail2; t=1714017757; x=1714276957;
 bh=D/UGTcNuz78Zd/e35NHhQWG4+rtwdlYs7mYYMmquRv4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FuizOk2rPTqHCZ82YN2DesXk2gbCjfGXVyk54iPYOViwEwBqtabX5Dh81851IYmJi
 hmPAbQJ62N0UKBbMQw8gX3090REO4L2XYwFdO1q5pJNsr/QFAfxgpZdL72LfSDYC4/
 B9Iwm3k6EL2faDEvtO7arvQKSrYI4rIoz/2/gRNEZb2Mv0JAjUhiyvMxQCkOc2u2Bs
 TMQWsQ5NW/wRaTvcKL80oOg6KFAeqoNZzNHub7hzCC2aERIBGZTGV+3RhSjWqBi8fP
 8e6pfWZmoghpZD5spxoDop35sSXgDbMkopu/wDmI0yYe4drVySCVC/MWpWARqU8mAq
 A0o4FjNmun7BQ==
Date: Thu, 25 Apr 2024 04:02:32 +0000
To: Caleb Connolly <caleb.connolly@linaro.org>
From: mwleeds@mailtundra.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 3/5] zfs: Fix unaligned read of uint64
Message-ID: <yMP4wWXZMjDL0Xi9eeSdNuUBW7pE82Ie-UoUMbNBa7K1Vckv8A4da_KjBUlGkpeQfQsADCJ8z73FxL9AlyQjSJ41TJM1ohjNHzAStZpdhUk=@mailtundra.com>
In-Reply-To: <16d96fa3-4d95-4bfa-beac-6585426dc703@linaro.org>
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
 <20240407014743.13872-4-mwleeds@mailtundra.com>
 <16d96fa3-4d95-4bfa-beac-6585426dc703@linaro.org>
Feedback-ID: 106267484:user:proton
X-Pm-Message-ID: c56777ee2579e32ce5e6b75e2492f613054e797b
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

Hi Caleb,

Thanks for this interesting feedback. I saw these patches were already merg=
ed
since you sent this but I added a few thoughts below anyway.

On Friday, April 12th, 2024 at 11:50 AM, Caleb Connolly <caleb.connolly@lin=
aro.org> wrote:

> Hi Phaedrus,
>=20
> On 07/04/2024 03:47, mwleeds@mailtundra.com wrote:
>=20
> > Without this patch, when trying to boot zfs using U-Boot on a Jetson TX=
2
> > NX (which is aarch64), I get a CPU reset error like so:
> >=20
> > "Synchronous Abort" handler, esr 0x96000021
> > elr: 00000000800c9000 lr : 00000000800c8ffc (reloc)
> > elr: 00000000fff77000 lr : 00000000fff76ffc
> > x0 : 00000000ffb40f04 x1 : 0000000000000000
> > x2 : 000000000000000a x3 : 0000000003100000
> > x4 : 0000000003100000 x5 : 0000000000000034
> > x6 : 00000000fff9cc6e x7 : 000000000000000f
> > x8 : 00000000ff7f84a0 x9 : 0000000000000008
> > x10: 00000000ffb40f04 x11: 0000000000000006
> > x12: 000000000001869f x13: 0000000000000001
> > x14: 00000000ff7f84bc x15: 0000000000000010
> > x16: 0000000000002080 x17: 00000000001fffff
> > x18: 00000000ff7fbdd8 x19: 00000000ffb405f8
> > x20: 00000000ffb40dd0 x21: 00000000fffabe5e
> > x22: 000000ea77940000 x23: 00000000ffb42090
> > x24: 0000000000000000 x25: 0000000000000000
> > x26: 0000000000000000 x27: 0000000000000000
> > x28: 0000000000bab10c x29: 00000000ff7f85f0
> >=20
> > Code: d00001a0 9103a000 94006ac6 f9401ba0 (f9400000)
> > Resetting CPU ...
> >=20
> > This happens when be64_to_cpu() is called on a value that exists at a
> > memory address that's 4 byte aligned but not 8 byte aligned (e.g. an
> > address ending in 04). The call stack where that happens is:
> > check_pool_label() ->
> > zfs_nvlist_lookup_uint64(vdevnvlist, ZPOOL_CONFIG_ASHIFT,...) ->
> > be64_to_cpu()
>=20
>=20
> This is very odd, aarch64 doesn't generally have these restrictions. I
> got a bit nerdsniped when I saw this so I did some digging and figured th=
is:
>=20
> 1. Your abort exception doesn't include the FAR_ELx register (which
> should contain the address that was being accessed when the abort
> occured). This means your board is running in EL3.
> 2. It turns out there is an "A" flag in the SCTLR_ELx register, when set
> this flag causes a fault when trying to load from an address that isn't
> aligned to the size of the data element (see "A, bit" on
> https://developer.arm.com/documentation/ddi0595/2021-06/AArch64-Registers=
/SCTLR-EL3--System-Control-Register--EL3-
>=20
> I'm not sure who's in the "wrong" here, maybe the driver should avoid
> unaligned accesses? But then again, I don't think you should be running
> a ZFS driver in EL3.
>=20
> I'm not familiar with the Jetson Nano, but maybe there's a documented
> way to run U-Boot so that it isn't executing in EL3? Or if not you could
> also try unsetting the A flag.

I may look into this if I get a chance. However if I write some assembly co=
de
to change the execution level or unset the A flag, I worry that the code wo=
uld
work fine on the hardware I have (Jetson TX2 NX) but behave differently on
another platform. And I don't think I can easily set up testing environment=
s
with u-boot + zfs on different platforms to find out.

>=20
> If this really is something to fix in the driver, I don't think
> hotpatching every unaligned access with a malloc() is the right solution.
>=20

I'm certainly open to other ideas. The difficulty is the data structure we'=
re
parsing in this file is read from disk and it's only 4-byte aligned.

> > Signed-off-by: Phaedrus Leeds mwleeds@mailtundra.com
> > Tested-by: Phaedrus Leeds mwleeds@mailtundra.com
>=20
>=20
> regarding your question about re-sending to remove these tags, I'd say
> probably yes, and especially if you're going to send a new revision anywa=
y.
>=20
> fwiw you seem to have gotten pretty much everything else about the patch
> submission process spot on :)
>=20
> Kind regards,
>=20
> > ---
> > fs/zfs/zfs.c | 18 ++++++++++++++++++
> > 1 file changed, 18 insertions(+)
> >=20
> > diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
> > index 61d58fce68..9a50deac18 100644
> > --- a/fs/zfs/zfs.c
> > +++ b/fs/zfs/zfs.c
> > @@ -1552,35 +1552,53 @@ nvlist_find_value(char *nvlist, char *name, int=
 valtype, char **val,
> > if (nelm_out)
> > *nelm_out =3D nelm;
> > return 1;
> > }
> >=20
> > nvlist +=3D encode_size; /* goto the next nvpair */
> > }
> > return 0;
> > }
> >=20
> > +int is_word_aligned_ptr(void *ptr) {
> > + return ((uintptr_t)ptr & (sizeof(void *) - 1)) =3D=3D 0;
> > +}
> > +
> > int
> > zfs_nvlist_lookup_uint64(char *nvlist, char *name, uint64_t *out)
> > {
> > char *nvpair;
> > size_t size;
> > int found;
> >=20
> > found =3D nvlist_find_value(nvlist, name, DATA_TYPE_UINT64, &nvpair, &s=
ize, 0);
> > if (!found)
> > return 0;
> > if (size < sizeof(uint64_t)) {
> > printf("invalid uint64\n");
> > return ZFS_ERR_BAD_FS;
> > }
> >=20
> > + /* On arm64, calling be64_to_cpu() on a value stored at a memory addr=
ess
> > + * that's not 8-byte aligned causes the CPU to reset. Avoid that by co=
pying the
> > + * value somewhere else if needed.
> > + */
> > + if (!is_word_aligned_ptr((void *)nvpair)) {
> > + uint64_t *alignedptr =3D malloc(sizeof(uint64_t));
> > + if (!alignedptr)
> > + return 0;
> > + memcpy(alignedptr, nvpair, sizeof(uint64_t));
> > + *out =3D be64_to_cpu(*alignedptr);
> > + free(alignedptr);
> > + return 1;
> > + }
> > +
> > out =3D be64_to_cpu((uint64_t *) nvpair);
> > return 1;
> > }
> >=20
> > char *
> > zfs_nvlist_lookup_string(char *nvlist, char *name)
> > {
> > char *nvpair;
> > char *ret;
> > size_t slen;
>=20
>=20
> --
> // Caleb (they/them)
