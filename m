Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7BB606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ncrpoWJ6;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XyLvl68W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED54E60708;
	Wed, 18 Nov 2026 21:44:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qiAWwcuiUH09; Wed, 18 Nov 2026 21:44:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D7FB860664
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795038247;
	b=Jec/eFZohkjZv3VNIw6quCbu7mlFe0kXIm+pN354wntAPnKVXWiuOhy6xh/pqd+XQcuP
	 24g+0rta1hsaYtPA0IcuFjaAI9QBVqKPY7j+w//6XqEsIM1hIDNG9dZytsdfJkagLLoWC
	 Ru3oMnyffB60DH8NgQxpA3/dby45+WJsQ3yT0xGEi9/yamHbhblpRIFT84s+pNE8w3SUJ
	 0W0TEfR+jHWnYspw8gO5gwduKWeHxWgnAQrCQU5gZK2kIm2DL62eSV500EVY5It78U/NH
	 S84EXsBaHCKfEeFJs0/mlTg+I0CPERZL06CbAqmpri7EhyMemjMw1en5zDasfatPygA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795038247;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=E76hx7tYx+UxQ1cpi5/FnaL4O4UvwWsPo2JfcJ+KZWo=;
	b=JUM4kL44SHfm7QrBgii2OeIrThHOhgBsIHc8ipwKPfc53tzNbbMROp9jc/Ifk01PePZa
	 nlpwKvNzC479SCnLf7GR7lwd/aQkWlDqXYVsli0A6DJbKNVZW2WFBmK2XKwqJnZB67EP2
	 SzCE2f26udbPnmK5dlhj0X/9kDCbxlQXlMhW/fMkOw9P9IXiqFjvebWxuK0vvBlGmf8rj
	 4syCSBDyrKylKVF1oB6AZe632guJdqPgWcutLydYV2M4QhuuR/o0i9sAdi0FwhYqmzbDD
	 Ri7qj9LM0CooY+6FfmgSnSNx/jNB5Tq8o4lYejTdiHmi5dVdpsaPgfAleJ5QNvmVkKA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XyLvl68W;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795038247;
	bh=E76hx7tYx+UxQ1cpi5/FnaL4O4UvwWsPo2JfcJ+KZWo=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ncrpoWJ6U2PIjHgI4aPYDm42EVTiBfSNBesaXQv/mSPW7VUcvtLBCYggL2oRWy3Iv
	 b8KVdxwIhzaohCdMB2joEEZqkoDvWO+dgI3qioEENBxOhnSe4xBdcR3rZuR7DRZlMA
	 hvtLXIst9HuamZ+00gD9l7wsPAKFIVFrvrLYtu8Q/TVORLvP0SH/YHUmkwDnHD5DTa
	 5/aHdGFeEMEQp2qJKCdD74jJdefGT10EQjGZYA49G/HgDfxzds8avs6ErBrBtpH5rS
	 EAOmWB9oBRgqoQv4DvcvCBCRjPTzfbV7iJ+3MUHfaxdv4DxjryzmKKSGrkIvi2iCE5
	 psloA1VtEdDag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7FB860664;
	Wed, 18 Nov 2026 21:44:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 70757798
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6232C60664
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z0CT5oePr8QP for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:44:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 399F06064A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XyLvl68W
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 399F06064A
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:44:03 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so972539f8f.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795038241; x=1795643041;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E76hx7tYx+UxQ1cpi5/FnaL4O4UvwWsPo2JfcJ+KZWo=;
 b=XyLvl68WujR3BBcD/x6ikIUD+5hli39MzM7ZGXEroi0QIORLaDcTGSIU4NX+6Pvkhp
 SFTZlBnvBpjNh+2HriczAjxt7p3PguLfKbN+L8hEWCWfB1VRvl2oXOtduenQN/VDaOSQ
 5bI5sm9uBhOoy4xE/FAUxOOc/UXXaWG4oQtXjGC2nhsorZjgXty/7kW4EDmTlOOTGQSr
 DxH7crQqw7cpyph4ZB8zfhuKB+QLK/GOdjX8Wu6nd8enp4YERI6hhtonvhFp5NUCtu5i
 7tOQECzs52FkqAW0wiTgM537JF0ilhdigEU7eHuZaT/ue9mGCuQn1UhVqvI7P/+ZDd1i
 yZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795038241; x=1795643041;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E76hx7tYx+UxQ1cpi5/FnaL4O4UvwWsPo2JfcJ+KZWo=;
 b=2WBfgv8yVAsLVnE+38sZ5iFyuSh3IKlAKfov+zpGqtRVkNQttJ3AvHtqzaJZEucE1J
 gw0gMXCo5e57VhsuVIbIE+Az+ZrYTgUFxyq7Ln2El16MP4br7niEOTxJf9FWPDif9zmI
 2SvkgYzql+C5yl+NEwfbbnjIul14f4AM8tzzEbpIuSR4oTC47O5H8Wj4rBc+WiEkf0Gh
 Ocw9o8d1fo2kOeCCeIQlqvCBGT0YsurHlLY5okfy+M7Hcd7330smjSnPvsQLi2XnnH4e
 ctMkQzQvLn+8SY4XdDSmHQoADXbF4vh2372ehHHyv1JC0VgZ0wfau55O2/uVvtNt9QMs
 WbXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEZiTt5HkQJ25X8y5FMyq7yjj4uZgkth6CvskOFBuhHpd3MHaLDZnT43t/h3JjrNpz90Wte/yk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9E7OryMwmTVyEgFU3i3NGTfyGJwHS/8P8jw73CzTNcXn+5+tC6
 HyTgGl/rXaKPBGQOtkPEg4Cq+tAAQBvI2I8+Yf992Q2SMxaCybtjS1IayBNCFGz5W7I=
X-Gm-Gg: AZFdTZc8qXfrZzjAfu/4sb5392aRwr7yn0gRAR48JBjqgB+2jC5ZkIF1AITqFQpKIyC
 XqdfFUlU7UUdo9KYJcbfW5rNiB+jcWJs4yOKWpCR8U9DLFMwZQajGlLv634jkrcRrl6P1l+U7m2
 WMbtT+2EsEPQTCG6FtAHHyz8SwIYXq2obil3Bok4Qu9sUy6Dx26zxVNmzMI6zqbGmbkckb9ZhNc
 cedH7psr+k41qqx+VKugN+CvUTnWEuh7f3PgaR9vhSQDbp+0kCBy7GTM3uiyJpeNv3uNvRLV0EB
 /UlQGH65PSNxKxBPWpyxguQCyesf1s1q68IhxfzJZbvSs0FfN8YtIduWwQWoREzxQWCFZHmOlaP
 tT2t0FCMbOSYW0LC78vepKPR2zUGjnIvADU7HyxJqt8nrPYMbhjhkyqPNeBsCL9NwVALaQf67r2
 6qhvAjdhgWJc4ZS1Lvf42mV9fovBlP+Psjcc+2vrQQUKa6fCoYAufe/grnUx/vQ7PnQ6CNrvXC6
 3PMD6WK1kPyKXZw1BzxXGRw4VViUS9fDGL0jLe88fAsdymV5sz3Bv7L86YZrc2Bg83fgumdA3fI
 FMBqDkcMEEk6K6+rGvUQR8uaQ6NTcLZ7E6gTcmGvC7X80OQyNTk=
X-Received: by 2002:a05:6000:4b1e:b0:499:9f62:d64c with SMTP id
 ffacd0b85a97d-4a63984a9dcmr8375752f8f.10.1795038241383; 
 Wed, 18 Nov 2026 13:44:01 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c257sm6506025f8f.13.2026.11.18.13.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 13:44:00 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 4/5] test: avb: test verification of preloaded partitions
From: Guillaume La Roque <glaroque@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
In-Reply-To: <179501661323.306911.11688771039281338221.b4-review@b4>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
 <20261107-upstream-avb_tests_b4-v1-4-9177277458f9@oss.qualcomm.com>
 <179501661323.306911.11688771039281338221.b4-review@b4>
Date: Wed, 18 Nov 2026 22:44:00 +0100
Message-Id: <179503824009.2286122.6686071496349320129.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038240; l=7453;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=G1BlpDmmlRF1WNVY7wxBFMf2fApEfCvsgKIj4oSqYCk=;
 b=u2fM18e5hTRmkwAZs4prjVqS1kNnOrz81PZ4kjrvyjM1eBA+G63edvobLBJL30KgIRkz53oT4
 6NacCrP/24pBe/u8DPJMlItbeqMTFIVTRY8YEpvzzNgq5mX7nnbFtMA
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-18 16:43:33+01:00, Mattijs Korpershoek wrote:
Hi,

> Hi Igor,
> thank you for the patch.
> 
> > The Android bootmeth hands libavb the buffers it boots from, so that the
> > bytes it verifies are the bytes it boots. Check that libavb hashes the
> > buffer rather than a fresh read of the partition, that a tail the boot
> > image header did not announce is read into the same buffer, and that a
> > buffer too small for the hash descriptor fails instead of overflowing.
> 
> If I run this as following:
> $ git clean -xdf && python3 -m venv venv && . venv/bin/activate && \¬
>     pip install -r test/py/requirements.txt && pip install setuptools && \
>     ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v
> 
> I see failures because mmc12.img has not been created:
> 
> => =>  ut bootstd avb_preloaded
> Test: bootstd_setup_for_tests: bootstd_common.c
> Can't map file 'mmc1.img': Invalid argument
>    sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
> Test: avb_preloaded: avb.c
> Can't map file 'mmc12.img': Invalid argument
>    sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
> test/boot/avb.c:71, avb_preloaded(): desc = NULL: Expected non-null, got NULL
> Test: avb_preloaded: avb.c (flat tree)
> Can't map file 'mmc12.img': Invalid argument
>    sandbox_mmc_probe() mmc12: Unable to map file 'mmc12.img'
> test/boot/avb.c:71, avb_preloaded(): desc = NULL: Expected non-null, got NULL
> Test 'avb_preloaded' failed 2 times
> Tests run: 2, 4 ms, average: 2 ms, failures: 2
> exit not allowed from main input shell.
> => FAILED
> 
> This can be worked-around by first running other tests for example, by
> doing:
> $ ./test/py/test.py --bd sandbox --build -k avb # creates mmc12.img
> $ ./test/py/test.py --bd sandbox --build -k avb_preloaded -s -v
> 
> But I'd prefer if we can run it as standlone (otherwise we depend on the
> test execution order which is error-prone)
> 
> Do you have an idea on how to fix this?
> 
> Another question below
I reproduce the issue too, and not only on this test btw. I see it also
on the existing Android bootflow tests, e.g. bootflow_android_image_v2
(missing mmc8.img). The pytest tests in test_avb.py are fine standalone
thanks to the avb_device_id fixture, only the C tests run by test_ut
depend on test_ut_dm_init_bootstd to create the images.

i think solution is to add some check in ut_ubman fixture in test/py/tests/test_ut.py
to generate images if needed, today it's not the case images was done only
in  test_ut_dm_init_bootstd.




> 
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> > ---
> >  MAINTAINERS        |   1 +
> >  test/boot/Makefile |   1 +
> >  test/boot/avb.c    | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 108 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 76a06fbf7ab2..f2469e28cfb6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -121,6 +121,7 @@ F:	common/avb_verify.c
> >  F:	doc/android/avb2.rst
> >  F:	include/avb_verify.h
> >  F:	lib/libavb/
> > +F:	test/boot/avb.c
> >  F:	test/py/tests/test_android/test_avb.py
> >  
> >  ARC
> > diff --git a/test/boot/Makefile b/test/boot/Makefile
> > index a8803ded814a..8214151bd1bc 100644
> > --- a/test/boot/Makefile
> > +++ b/test/boot/Makefile
> > @@ -4,6 +4,7 @@
> >  
> >  ifdef CONFIG_UT_BOOTSTD
> >  obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
> > +obj-$(CONFIG_AVB_VERIFY) += avb.o
> >  obj-$(CONFIG_FIT) += image.o
> >  
> >  ifdef CONFIG_VIDEO_SANDBOX_SDL
> > diff --git a/test/boot/avb.c b/test/boot/avb.c
> > new file mode 100644
> > index 000000000000..f2c3c58cccfc
> > --- /dev/null
> > +++ b/test/boot/avb.c
> > @@ -0,0 +1,106 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Tests for the AVB operations used by the Android bootmeth
> > + */
> > +
> > +#include <avb_verify.h>
> > +#include <blk.h>
> > +#include <dm.h>
> > +#include <malloc.h>
> > +#include <part.h>
> > +#include <asm/global_data.h>
> > +#include <dm/lists.h>
> > +#include <dm/ofnode.h>
> > +#include <test/ut.h>
> > +#include "bootstd_common.h"
> > +
> > +DECLARE_GLOBAL_DATA_PTR;
> > +
> > +/* mmc12.img: boot (boot image v2 with a hash footer), system, vbmeta */
> > +#define AVB_MMC_DEV	12
> > +
> > +/* Verify boot with the given preloaded buffer, return the libavb result */
> > +static AvbSlotVerifyResult avb_verify_preloaded(u8 *buf, size_t size,
> > +						size_t max_size,
> > +						bool *used_buf)
> > +{
> > +	static const char *const parts[] = { "boot", NULL };
> > +	AvbSlotVerifyData *data = NULL;
> > +	AvbSlotVerifyResult res;
> > +	AvbOps *ops;
> > +
> > +	ops = avb_ops_alloc(UCLASS_MMC, AVB_MMC_DEV);
> > +	if (!ops)
> > +		return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
> > +	if (avb_ops_add_preloaded(ops, "boot", buf, size, max_size)) {
> > +		avb_ops_free(ops);
> > +		return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
> > +	}
> > +
> > +	res = avb_slot_verify(ops, parts, "", AVB_SLOT_VERIFY_FLAGS_NONE,
> > +			      AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
> > +			      &data);
> > +	*used_buf = data && data->num_loaded_partitions == 1 &&
> > +		    data->loaded_partitions[0].preloaded &&
> > +		    data->loaded_partitions[0].data == buf;
> > +	if (data)
> > +		avb_slot_verify_data_free(data);
> > +	avb_ops_free(ops);
> > +
> > +	return res;
> > +}
> > +
> > +/*
> > + * The bootmeth hands libavb the buffers it boots from, so that the bytes it
> > + * verifies are the bytes it boots. Check that libavb hashes those buffers
> > + * rather than reading the partition again.
> > + */
> > +static int avb_preloaded(struct unit_test_state *uts)
> > +{
> > +	struct disk_partition info;
> > +	struct blk_desc *desc;
> > +	bool used_buf;
> > +	ofnode node;
> > +	size_t size;
> > +	u8 *buf;
> > +
> > +	node = ofnode_find_subnode(oftree_root(oftree_default()), "mmc12");
> > +	ut_assert(ofnode_valid(node));
> > +	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
> > +	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, AVB_MMC_DEV);
> > +	ut_assertnonnull(desc);
> > +	ut_assert(part_get_info_by_name(desc, "boot", &info) > 0);
> > +
> > +	size = info.size * info.blksz;
> > +	buf = malloc(size);
> > +	ut_assertnonnull(buf);
> > +	ut_asserteq(info.size, blk_dread(desc, info.start, info.size, buf));
> > +
> > +	/* The preloaded buffer is what gets verified */
> > +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
> > +		    avb_verify_preloaded(buf, size, size, &used_buf));
> > +	ut_assert(used_buf);
> > +
> > +	/* A change to the buffer fails although the partition is intact */
> > +	buf[0] ^= 0xff;
> > +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION,
> > +		    avb_verify_preloaded(buf, size, size, &used_buf));
> > +
> > +	/*
> > +	 * The boot image header may announce fewer bytes than the hash
> > +	 * descriptor covers: the rest is read into the same buffer...
> > +	 */
> > +	memset(buf, 0, size);
> > +	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
> > +		    avb_verify_preloaded(buf, 0, size, &used_buf));
> > +	ut_assert(used_buf);
> 
> I understand the value of testing fewer bytes than the has descriptor,
> but zero seems a "too special" case here.
> 
> Can't we test something like 'size - a couple of bytes' ?


