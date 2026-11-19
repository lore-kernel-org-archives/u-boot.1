Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214A606A32F
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NfcBT23i;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiDBDqHl
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7EE33812C5;
	Thu, 19 Nov 2026 08:26:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cb46W9PPfQZ5; Thu, 19 Nov 2026 08:26:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 65DC0812B9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795076804;
	b=GO+X2DpcIvXCpzcodjjxJ7fZdAVdRRoS1YPQg7xVpgyMWMBg3yoTv0DCbxFInVXo2Yxg
	 09gh14mYP7iDGb8wZiQwcweqbHYBI0xgrQNEonAsuf4HNkCEoDuceoIlRO3QWYezVUnQC
	 zWlQotXloM5zVN3ftS/c7v24qW4p7k3JKh8dyLIwzY52/ZhCvQ/nzXFc5Kdw4v7A9GS9e
	 Nger9A9tq70dh6BzHGRWeu0v3H7AddaBPNlc0mDdxBNfn7NaRovEw8wBVBXybTMhqjYDB
	 O31cW9QM3nlFFzvs8ap/KO9QksKpQBc1S9oiqanDQ7DN3PpVxxtlZmnlQdhl4b+y+YQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795076804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=C07G+9zFkRt1YRAnHIwMs9d6EfcerwDse+9hNMgEfCM=;
	b=P4yKzF7feWZIbr6m7Y9awzqFkjOnpq/+O5SdiyY5yfDjQJYmOtGXjbO+Y9WKhKSNSovN
	 s/LBAzuABHFOKygEXFwBWYkUxhfweOAgSjsOZO2Tu8Q+qtaB5WB1H/FjF/3EkSKQvqeFZ
	 pQ7UnDYVDW2sAaRMCwXpEUfPQ3TzO9Sk+azqZ9K3d9Ko75dcLOx6DjzmHcEpLC0f8Xtrx
	 t6rhd5RuLXnm9FJ6Nw48gjQRN/pFUM5ZDPqWRWZbWTqfwFbgFIpF6Fqi3KgAWpuVsK3JM
	 0YDMc+ng/MoMPOrpWjtASFSwGFwAoezjnaRt72QXCvvwgSm+ABJCoNbHBMc0lJZmpZg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795076804;
	bh=C07G+9zFkRt1YRAnHIwMs9d6EfcerwDse+9hNMgEfCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NfcBT23ip+7ALpHnH9+iNOp7e8XpEKxFMVYJMpp9kAqPfyl0huIL9n/u+4q0eYfC2
	 v4BUZpGCfEMiMiIntEiurcKkXar3UBp+wo/PlvFItEMR1tBG2VsdpWX93MeQLgAYhj
	 kF1Lw5xaTYCwYNTSQJLPsmBPHKDxnXtnqyIphCp+IJOtZxOZ/eIin3YSeexy5S5X9q
	 IUowqrKBBuN3BOc062gwa0wp/+gYn3Lh5aG6udSsT5qd5fnIwcqOi4/jGxobLNOn12
	 7/3gPAZ3C+T5V7mMsrsezWy31rfdQz++k8FVcBxfU5cWzSbFRu9w1s8c/4+3wVAESF
	 3JpuGUrDzIcIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65DC0812B9;
	Thu, 19 Nov 2026 08:26:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CA8770B
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2339760A94
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:26:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mqfljz26goGB for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 08:26:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2597C607F7
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jiDBDqHl
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2597C607F7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 08:26:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60A0048DB5;
 Thu, 19 Nov 2026 08:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42931F000CC;
 Thu, 19 Nov 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795076800;
 bh=C07G+9zFkRt1YRAnHIwMs9d6EfcerwDse+9hNMgEfCM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=jiDBDqHlEqYgxGG8qXiSxi1mM5nCYMQ3fbSSWGBQ+V+BMLomXqFl3VSVD/8j+3unL
 /aFz+FsryKSHgnKuG0yg4eYchtcyObOmkWpfFQnh22KotV7Iuo64PiytDEjIAeJHv/
 FyMSeikmISdghiNOT8wOj3Ma600EyJZtNK/xLE1P8xIQyIBavZj0NYyTATOHh/dd/h
 tN536OBjJr+AcGE4VFBZ1TCtc6nBDxZOvpFfcTz8Is1gYEAjSBcuyWtvj2KYkXNulV
 N5CUaiPi/vGyeKIUJMM2xN3FmC7Cwt4/B2ngMt8GrldorOycJdEbCM7AiI6DQGqzIW
 WcdM0Cift9CSA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, Jens
 Wiklander <jenswi@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 4/5] test: avb: test verification of preloaded partitions
In-Reply-To: <179503824009.2286122.6686071496349320129.b4-reply@b4>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-4-9177277458f9@oss.qualcomm.com>
 <179501661323.306911.11688771039281338221.b4-review@b4>
 <179503824009.2286122.6686071496349320129.b4-reply@b4>
Date: Thu, 19 Nov 2026 09:26:37 +0100
Message-ID: <xhkdbpkw1p6pu.fsf@mkorpers-koolstof.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 22:44, Guillaume La Roque <glaroque@baylibre.com> w=
rote:

> On 2026-11-18 16:43:33+01:00, Mattijs Korpershoek wrote:
> Hi,
>
>> Hi Igor,
>> thank you for the patch.
>>=20
>> > The Android bootmeth hands libavb the buffers it boots from, so that t=
he
>> > bytes it verifies are the bytes it boots. Check that libavb hashes the
>> > buffer rather than a fresh read of the partition, that a tail the boot
>> > image header did not announce is read into the same buffer, and that a
>> > buffer too small for the hash descriptor fails instead of overflowing.
>>=20
>> If I run this as following:
>> $ git clean -xdf && python3 -m venv venv && . venv/bin/activate && \=C2=
=AC
>>     pip install -r test/py/requirements.txt && pip install setuptools &&=
 \
>>     ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v
>>=20
>> I see failures because mmc12.img has not been created:
>>=20
>> =3D> =3D>  ut bootstd avb_preloaded
>> Test: bootstd_setup_for_tests: bootstd_common.c
>> Can't map file 'mmc1.img': Invalid argument
>>    sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
>> Test: avb_preloaded: avb.c
>> Can't map file 'mmc12.img': Invalid argument
>>    sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
>> test/boot/avb.c:71, avb_preloaded(): desc =3D NULL: Expected non-null, g=
ot NULL
>> Test: avb_preloaded: avb.c (flat tree)
>> Can't map file 'mmc12.img': Invalid argument
>>    sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
>> test/boot/avb.c:71, avb_preloaded(): desc =3D NULL: Expected non-null, g=
ot NULL
>> Test 'avb_preloaded' failed 2 times
>> Tests run: 2, 4 ms, average: 2 ms, failures: 2
>> exit not allowed from main input shell.
>> =3D> FAILED
>>=20
>> This can be worked-around by first running other tests for example, by
>> doing:
>> $ ./test/py/test.py --bd sandbox --build -k avb # creates mmc12.img
>> $ ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v
>>=20
>> But I'd prefer if we can run it as standlone (otherwise we depend on the
>> test execution order which is error-prone)
>>=20
>> Do you have an idea on how to fix this?
>>=20
>> Another question below
> I reproduce the issue too, and not only on this test btw. I see it also
> on the existing Android bootflow tests, e.g. bootflow_android_image_v2
> (missing mmc8.img). The pytest tests in test_avb.py are fine standalone
> thanks to the avb_device_id fixture, only the C tests run by test_ut
> depend on test_ut_dm_init_bootstd to create the images.

Yeah, I was aware that it was reproduced on the bootflow tests already.
If that can be fixed as well it would be great, but it's not a blocker
for this series, in my opinion.

>
> i think solution is to add some check in ut_ubman fixture in test/py/test=
s/test_ut.py
> to generate images if needed, today it's not the case images was done only
> in  test_ut_dm_init_bootstd.
>
>
>
>
>>=20
>> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>> > ---
>> >  MAINTAINERS        |   1 +
>> >  test/boot/Makefile |   1 +
>> >  test/boot/avb.c    | 106 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>> >  3 files changed, 108 insertions(+)
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 76a06fbf7ab2..f2469e28cfb6 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -121,6 +121,7 @@ F:	common/avb_verify.c
>> >  F:	doc/android/avb2.rst
>> >  F:	include/avb_verify.h
>> >  F:	lib/libavb/
>> > +F:	test/boot/avb.c
>> >  F:	test/py/tests/test_android/test_avb.py
>> >=20=20
>> >  ARC
>> > diff --git a/test/boot/Makefile b/test/boot/Makefile
>> > index a8803ded814a..8214151bd1bc 100644
>> > --- a/test/boot/Makefile
>> > +++ b/test/boot/Makefile
>> > @@ -4,6 +4,7 @@
>> >=20=20
>> >  ifdef CONFIG_UT_BOOTSTD
>> >  obj-$(CONFIG_BOOTSTD) +=3D bootdev.o bootstd_common.o bootflow.o boot=
meth.o
>> > +obj-$(CONFIG_AVB_VERIFY) +=3D avb.o
>> >  obj-$(CONFIG_FIT) +=3D image.o
>> >=20=20
>> >  ifdef CONFIG_VIDEO_SANDBOX_SDL
>> > diff --git a/test/boot/avb.c b/test/boot/avb.c
>> > new file mode 100644
>> > index 000000000000..f2c3c58cccfc
>> > --- /dev/null
>> > +++ b/test/boot/avb.c
>> > @@ -0,0 +1,106 @@
>> > +// SPDX-License-Identifier: GPL-2.0+
>> > +/*
>> > + * Tests for the AVB operations used by the Android bootmeth
>> > + */
>> > +
>> > +#include <avb_verify.h>
>> > +#include <blk.h>
>> > +#include <dm.h>
>> > +#include <malloc.h>
>> > +#include <part.h>
>> > +#include <asm/global_data.h>
>> > +#include <dm/lists.h>
>> > +#include <dm/ofnode.h>
>> > +#include <test/ut.h>
>> > +#include "bootstd_common.h"
>> > +
>> > +DECLARE_GLOBAL_DATA_PTR;
>> > +
>> > +/* mmc12.img: boot (boot image v2 with a hash footer), system, vbmeta=
 */
>> > +#define AVB_MMC_DEV	12
>> > +
>> > +/* Verify boot with the given preloaded buffer, return the libavb res=
ult */
>> > +static AvbSlotVerifyResult avb_verify_preloaded(u8 *buf, size_t size,
>> > +						size_t max_size,
>> > +						bool *used_buf)
>> > +{
>> > +	static const char *const parts[] =3D { "boot", NULL };
>> > +	AvbSlotVerifyData *data =3D NULL;
>> > +	AvbSlotVerifyResult res;
>> > +	AvbOps *ops;
>> > +
>> > +	ops =3D avb_ops_alloc(UCLASS_MMC, AVB_MMC_DEV);
>> > +	if (!ops)
>> > +		return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
>> > +	if (avb_ops_add_preloaded(ops, "boot", buf, size, max_size)) {
>> > +		avb_ops_free(ops);
>> > +		return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
>> > +	}
>> > +
>> > +	res =3D avb_slot_verify(ops, parts, "", AVB_SLOT_VERIFY_FLAGS_NONE,
>> > +			      AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
>> > +			      &data);
>> > +	*used_buf =3D data && data->num_loaded_partitions =3D=3D 1 &&
>> > +		    data->loaded_partitions[0].preloaded &&
>> > +		    data->loaded_partitions[0].data =3D=3D buf;
>> > +	if (data)
>> > +		avb_slot_verify_data_free(data);
>> > +	avb_ops_free(ops);
>> > +
>> > +	return res;
>> > +}
>> > +
>> > +/*
>> > + * The bootmeth hands libavb the buffers it boots from, so that the b=
ytes it
>> > + * verifies are the bytes it boots. Check that libavb hashes those bu=
ffers
>> > + * rather than reading the partition again.
>> > + */
>> > +static int avb_preloaded(struct unit_test_state *uts)
>> > +{
>> > +	struct disk_partition info;
>> > +	struct blk_desc *desc;
>> > +	bool used_buf;
>> > +	ofnode node;
>> > +	size_t size;
>> > +	u8 *buf;
>> > +
>> > +	node =3D ofnode_find_subnode(oftree_root(oftree_default()), "mmc12");
>> > +	ut_assert(ofnode_valid(node));
>> > +	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
>> > +	desc =3D blk_get_devnum_by_uclass_id(UCLASS_MMC, AVB_MMC_DEV);
>> > +	ut_assertnonnull(desc);
>> > +	ut_assert(part_get_info_by_name(desc, "boot", &info) > 0);
>> > +
>> > +	size =3D info.size * info.blksz;
>> > +	buf =3D malloc(size);
>> > +	ut_assertnonnull(buf);
>> > +	ut_asserteq(info.size, blk_dread(desc, info.start, info.size, buf));
>> > +
>> > +	/* The preloaded buffer is what gets verified */
>> > +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
>> > +		    avb_verify_preloaded(buf, size, size, &used_buf));
>> > +	ut_assert(used_buf);
>> > +
>> > +	/* A change to the buffer fails although the partition is intact */
>> > +	buf[0] ^=3D 0xff;
>> > +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION,
>> > +		    avb_verify_preloaded(buf, size, size, &used_buf));
>> > +
>> > +	/*
>> > +	 * The boot image header may announce fewer bytes than the hash
>> > +	 * descriptor covers: the rest is read into the same buffer...
>> > +	 */
>> > +	memset(buf, 0, size);
>> > +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
>> > +		    avb_verify_preloaded(buf, 0, size, &used_buf));
>> > +	ut_assert(used_buf);
>>=20
>> I understand the value of testing fewer bytes than the has descriptor,
>> but zero seems a "too special" case here.
>>=20
>> Can't we test something like 'size - a couple of bytes' ?
