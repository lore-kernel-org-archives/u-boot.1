Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D15606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dBk810b3;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdU/9mU0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 438D940A2F;
	Wed, 18 Nov 2026 15:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o_3LDJQemQSH; Wed, 18 Nov 2026 15:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2BEEF40A2B
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795016634;
	b=fnYNuZbaXUcEitdRuXgFA7IJnLFaPMbwpbo4E5QazkS9CQgz3VveZp3A5fJ86ieMlaC2
	 ET1nm9zBnIk8Rc8NaiRAF2BMwfVIf26nqi26FGQOv/a5uxaK0UaW8JDbk8LFv8BONsovF
	 KchklDak4/ATmJi7H5a5Jcft8i89nwbHZwAh96nMkmfHRYn2A5tNPy0wuPAcIlsblWwWa
	 1OgtXG++eEDYMdwhixEHXqD9FclLKZn23jQUO+3EbJqBBIgqTnkqlhO9GQizp4EULDe13
	 zmKPoOkSBL8JIeh0jucAzSCvmd9M6S+edTrnVWersw9Dgxi5UUt1KSwMkSGUz/nH8LQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795016634;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=islF7mMey6Iuw9pXYbsZL2w6vn4Y9GWkXF00czXRU8A=;
	b=cXKycIMbsOCnrt4T8fd5Vhob+jKaADmBSxCkjgVZmFLgLOdUGmMCbh29Wz/nwVDI1PNq
	 0l3xHHLzh3pzEc3fnXU110ePi9VfW+L0vlUztb/udOoitzdUxo0vR4sRkoTDAmFj54Ujz
	 8joGMxvUgjj2tseXtXgp5bUCr093AFf1t0UwEaXBnfiT6oGh7UR07EO8t2u8vogCRYfrn
	 vOvwuda8WStfwplExO3thX4oaQY+ChImLQquSMbIlm+kyMo/6Crspd/7tGuoXC+YQ918j
	 4+ylzQSefyI9RmhkgIc8FNhuuHypFR7BQj2jocH1cUjSFQQPYbv9abeV/Nm7irg3Ymw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795016634;
	bh=islF7mMey6Iuw9pXYbsZL2w6vn4Y9GWkXF00czXRU8A=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dBk810b3jk7HbCK27ivB8EyrU7mQBpPma5G4OwAfwBW7cxjy11sd5B9kgsPD3VSsQ
	 BAOUvmB9vA7GJ0rdC5MKikT9Pox8aBm4V5EdtuDsPIn0m19k0djzmlnN28IFMXb/rT
	 dlZoiefjmzw4j7FNAyJ7oroFtIOJnOCnS1zKg9ddzDBnHE2YXL0eENKjEz3nSJANDi
	 9B+0rQe6nda6PERuRwIfdoqBuQr3OyZgZWo00VmXaHTu9Jnf5h/9FbsOe283UnQBES
	 lzpBrHD69msj9kEh+Msjodp5YlzI9RhTIzUVhI4dU2EvoU0F/ASEcXLMRXxokYERGP
	 Vji4c8ziunZ9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BEEF40A2B;
	Wed, 18 Nov 2026 15:43:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 688E228C
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4ED9860A6F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y9x09lOIvrWt for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 15:43:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52A7960A51
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=FdU/9mU0
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52A7960A51
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 15:43:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 800956240F;
 Wed, 18 Nov 2026 15:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93FE1F000C4;
 Wed, 18 Nov 2026 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016625;
 bh=islF7mMey6Iuw9pXYbsZL2w6vn4Y9GWkXF00czXRU8A=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=FdU/9mU0IQCUE+TtWDRKjcH+UQqOzG7VuBRa/+iGWcqIfCFa3bmsj56jGTZs/36lw
 Fz3maCfbQcTLKHOmXvL9y3RgyqMFJCVoLEHkYziooxdHBAjuex01SmLygnOHDJo36n
 K+K0KD88JgZ0gCe3xOpNhJsQQTMmc9RrQ5YJfM7buVDKqy3CqEyQpoTO6ozfv0gY3w
 TG6kjUULWGZdqNs9bnZ0aPEOlB64g2M+9wknWQlNKeWj+6HfO2phhjVbzGawJTSoUP
 m59EWHZKAV5nVqT3tb44Xh8JCrb0hedo8iwzRkKoSGgJha571GodKujzbCJUziAtPk
 wqRhR8zEbmJzA==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/5] test: avb: test verification of preloaded partitions
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-4-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-4-9177277458f9@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:43:33 +0100
Message-Id: <179501661323.306911.11688771039281338221.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6532;
 i=mkorpershoek@kernel.org; h=from:subject:message-id;
 bh=zF9OJ/V+tGS1eNE3xQl2vePsWYVgX2VfTp6UV3gmfYg=;
 b=owEBbQGS/pANAwAKARkNHbRmThk1AcsmYgBq/cenxl3/zKEqKmCWdYmQ+g0DRuASkwiH4uKqt
 FwdFNPofT2JATMEAAEKAB0WIQQu6UKnth9qvlMTrQAZDR20Zk4ZNQUCav3HpwAKCRAZDR20Zk4Z
 NfS5CADcZ/Iu9bHDvBHAgKwJiCjp2iQCniyWfiJodboVA4TfObrwXOR6dLT60x3auO52/reGZU4
 o0kSErLTAZuCw8dHDiWXvLF2lptUpJmupPCpIAem2dLgdjAHIY1vcmmHXYPwifKO3r/dn9+mUko
 MJVdsF799G3eZDCoujbfHGoBtJWC4yzvWWamQPAmX2ZWxej/2C8fYIuh812WxgJn+VxA15PMGfN
 JtuADor0EN1Uts63qUueC5fLFJ5A2pZwy4JnLDokSS19d73ZBHc0JerOgdqkP8NOdCK5fduGTsk
 myY2YfTTbg8tkxH8u6HdcIzyG1kg7n13mJy2OEIPB4ZCxSZS
X-Developer-Key: i=mkorpershoek@kernel.org; a=openpgp;
 fpr=8234A35B45C0D26B31C1A2DA570338B018144F28
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Igor,
thank you for the patch.

> The Android bootmeth hands libavb the buffers it boots from, so that the
> bytes it verifies are the bytes it boots. Check that libavb hashes the
> buffer rather than a fresh read of the partition, that a tail the boot
> image header did not announce is read into the same buffer, and that a
> buffer too small for the hash descriptor fails instead of overflowing.

If I run this as following:
$ git clean -xdf && python3 -m venv venv && . venv/bin/activate && \¬
    pip install -r test/py/requirements.txt && pip install setuptools && \
    ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v

I see failures because mmc12.img has not been created:

=> =>  ut bootstd avb_preloaded
Test: bootstd_setup_for_tests: bootstd_common.c
Can't map file 'mmc1.img': Invalid argument
   sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
Test: avb_preloaded: avb.c
Can't map file 'mmc12.img': Invalid argument
   sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
test/boot/avb.c:71, avb_preloaded(): desc = NULL: Expected non-null, got NULL
Test: avb_preloaded: avb.c (flat tree)
Can't map file 'mmc12.img': Invalid argument
   sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
test/boot/avb.c:71, avb_preloaded(): desc = NULL: Expected non-null, got NULL
Test 'avb_preloaded' failed 2 times
Tests run: 2, 4 ms, average: 2 ms, failures: 2
exit not allowed from main input shell.
=> FAILED

This can be worked-around by first running other tests for example, by
doing:
$ ./test/py/test.py --bd sandbox --build -k avb # creates mmc12.img
$ ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v

But I'd prefer if we can run it as standlone (otherwise we depend on the
test execution order which is error-prone)

Do you have an idea on how to fix this?

Another question below

> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> ---
>  MAINTAINERS        |   1 +
>  test/boot/Makefile |   1 +
>  test/boot/avb.c    | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 108 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76a06fbf7ab2..f2469e28cfb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -121,6 +121,7 @@ F:	common/avb_verify.c
>  F:	doc/android/avb2.rst
>  F:	include/avb_verify.h
>  F:	lib/libavb/
> +F:	test/boot/avb.c
>  F:	test/py/tests/test_android/test_avb.py
>  
>  ARC
> diff --git a/test/boot/Makefile b/test/boot/Makefile
> index a8803ded814a..8214151bd1bc 100644
> --- a/test/boot/Makefile
> +++ b/test/boot/Makefile
> @@ -4,6 +4,7 @@
>  
>  ifdef CONFIG_UT_BOOTSTD
>  obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
> +obj-$(CONFIG_AVB_VERIFY) += avb.o
>  obj-$(CONFIG_FIT) += image.o
>  
>  ifdef CONFIG_VIDEO_SANDBOX_SDL
> diff --git a/test/boot/avb.c b/test/boot/avb.c
> new file mode 100644
> index 000000000000..f2c3c58cccfc
> --- /dev/null
> +++ b/test/boot/avb.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Tests for the AVB operations used by the Android bootmeth
> + */
> +
> +#include <avb_verify.h>
> +#include <blk.h>
> +#include <dm.h>
> +#include <malloc.h>
> +#include <part.h>
> +#include <asm/global_data.h>
> +#include <dm/lists.h>
> +#include <dm/ofnode.h>
> +#include <test/ut.h>
> +#include "bootstd_common.h"
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +/* mmc12.img: boot (boot image v2 with a hash footer), system, vbmeta */
> +#define AVB_MMC_DEV	12
> +
> +/* Verify boot with the given preloaded buffer, return the libavb result */
> +static AvbSlotVerifyResult avb_verify_preloaded(u8 *buf, size_t size,
> +						size_t max_size,
> +						bool *used_buf)
> +{
> +	static const char *const parts[] = { "boot", NULL };
> +	AvbSlotVerifyData *data = NULL;
> +	AvbSlotVerifyResult res;
> +	AvbOps *ops;
> +
> +	ops = avb_ops_alloc(UCLASS_MMC, AVB_MMC_DEV);
> +	if (!ops)
> +		return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> +	if (avb_ops_add_preloaded(ops, "boot", buf, size, max_size)) {
> +		avb_ops_free(ops);
> +		return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
> +	}
> +
> +	res = avb_slot_verify(ops, parts, "", AVB_SLOT_VERIFY_FLAGS_NONE,
> +			      AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
> +			      &data);
> +	*used_buf = data && data->num_loaded_partitions == 1 &&
> +		    data->loaded_partitions[0].preloaded &&
> +		    data->loaded_partitions[0].data == buf;
> +	if (data)
> +		avb_slot_verify_data_free(data);
> +	avb_ops_free(ops);
> +
> +	return res;
> +}
> +
> +/*
> + * The bootmeth hands libavb the buffers it boots from, so that the bytes it
> + * verifies are the bytes it boots. Check that libavb hashes those buffers
> + * rather than reading the partition again.
> + */
> +static int avb_preloaded(struct unit_test_state *uts)
> +{
> +	struct disk_partition info;
> +	struct blk_desc *desc;
> +	bool used_buf;
> +	ofnode node;
> +	size_t size;
> +	u8 *buf;
> +
> +	node = ofnode_find_subnode(oftree_root(oftree_default()), "mmc12");
> +	ut_assert(ofnode_valid(node));
> +	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
> +	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, AVB_MMC_DEV);
> +	ut_assertnonnull(desc);
> +	ut_assert(part_get_info_by_name(desc, "boot", &info) > 0);
> +
> +	size = info.size * info.blksz;
> +	buf = malloc(size);
> +	ut_assertnonnull(buf);
> +	ut_asserteq(info.size, blk_dread(desc, info.start, info.size, buf));
> +
> +	/* The preloaded buffer is what gets verified */
> +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
> +		    avb_verify_preloaded(buf, size, size, &used_buf));
> +	ut_assert(used_buf);
> +
> +	/* A change to the buffer fails although the partition is intact */
> +	buf[0] ^= 0xff;
> +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION,
> +		    avb_verify_preloaded(buf, size, size, &used_buf));
> +
> +	/*
> +	 * The boot image header may announce fewer bytes than the hash
> +	 * descriptor covers: the rest is read into the same buffer...
> +	 */
> +	memset(buf, 0, size);
> +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
> +		    avb_verify_preloaded(buf, 0, size, &used_buf));
> +	ut_assert(used_buf);

I understand the value of testing fewer bytes than the has descriptor,
but zero seems a "too special" case here.

Can't we test something like 'size - a couple of bytes' ?

-- 
Mattijs Korpershoek <mkorpershoek@kernel.org>
