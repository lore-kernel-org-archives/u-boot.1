Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD48CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 14:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BEA9839DE;
	Wed,  8 Oct 2025 16:53:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EJ/K+xNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA7FF83E8E; Wed,  8 Oct 2025 16:53:14 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E629839DD
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 16:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-639102bba31so12739222a12.2
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 07:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759935192; x=1760539992; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CiXCFVbRPVA9ATcwl48JN8ME2xH8OKrn3eJR9czLscQ=;
 b=EJ/K+xNy+Tp7ShD8NXfUh/CbKU605ciQkRbeR6UXeHuP9WDTsExyl0IdEA67aEzxn/
 mEDuCpnoSl0Yyb8XNjPqr/cB+GacG5pQfeSLXQM1uVSwt/PCjnibEFNU5+wA9kVSh+n8
 3y0ESdzwh2l6SUvzbG9DKkngwfOECcirQTfVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759935192; x=1760539992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiXCFVbRPVA9ATcwl48JN8ME2xH8OKrn3eJR9czLscQ=;
 b=JyvlYLv9OmXtm/akydbhZR4OCJ+sxyrF2obK1f8ymPZyNBuLXxHjiGkvGg2s3dpvkE
 b4FNxO1Pgrz1+6/BA9f6UvtjKRqKJHMSo9501bAKBiGOrXaTMdE30yOXHiHkG9G+fNxd
 TCGpkPCxK67vIR/zwTrQSeiWJKZJpUloiiBRyNGhN16yXQuacxNWnMb3XD85rDuxSAap
 sLUL2sVp7v/Eelfqm0UYykUi70p30azbJrsc5DR6v6GgHcbpDWP11S3oF6+Zis/CIxSu
 O/HzdpdhMaBfUeXMP87fKPYRpHVnW3so000g6B0Cujm1uI4tj+qVvSh6NnSU10TJrdfs
 h0UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyrj5CAE5O28v4yvlDN4UhpVd9AHJnDVrPSIU+SXcfijzAY1GGyfpgmsxcyhVyrK776/vy9FA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy3TMoOX0Q+2QKmKo6GBAvFYkjh5C3beoNMd2AjU4fSD53VO1Yu
 iJVv2j7TBD/GCKzA2GF6uDqLcuMvzX3So/dl94wHQZhOqOc40tJw/JIfHD9uZZIXrxOjFtajuuV
 LjsTghgI3hRPk4xszd/Jx0EHDQYW9FdaMMjtNXiwv
X-Gm-Gg: ASbGnctfR5gflq/R3/6o2Qk8U3VcOzpvBBrrsYHA6dQLvM/GIHEcWi4YAGjD+h+VIYV
 5Va2ochsE4S88UW6rlTHgAovGbLYcXCQSoy8feY8OGi8b65sKH0NwKpbX7Dr0ZU+BfYhZaPtB46
 GUutV3NraPDZZK5zg7naWAaLyIdmFyDWDj1CHgXNO8ngv7K1wfJ8V7cRmPTeaVAiw5V4ZOk9U3l
 YkfnNRZgKQczF2gAxChqYrYZCYd5Q==
X-Google-Smtp-Source: AGHT+IGw1qFJy2igR6l5Qh0jHbEnSzOtPUjXpozuOibvkm2eplyKgXw8oXNqTd6YmsI/NyGtGkRgXRUOQy2HiYFiu5Y=
X-Received: by 2002:a05:6402:2106:b0:634:5fb4:10e6 with SMTP id
 4fb4d7f45d1cf-639d5c32aa1mr3453763a12.23.1759935191711; Wed, 08 Oct 2025
 07:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251008-wip-bootmeth-rauc-tests-v1-1-3da21a731524@phytec.de>
 <20251008145017.GV298503@bill-the-cat>
In-Reply-To: <20251008145017.GV298503@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Oct 2025 08:52:59 -0600
X-Gm-Features: AS18NWDB3YEhmd8wW690fKJnH5I8MknibAcOshtedPRsridcyGjqRjCKcUH8YNs
Message-ID: <CAFLszTgKH0=y=04dag8FGcMM6mb2+HTZ_HNQrjbRxppLn9hzpA@mail.gmail.com>
Subject: Re: [PATCH] test: boot: Add test for bootmeth_rauc
To: Tom Rini <trini@konsulko.com>
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.denx.de, 
 Andreas Pretzsch <apr@cn-eng.de>, upstream@lists.phytec.de
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 8 Oct 2025 at 08:50, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 08, 2025 at 08:57:30AM +0200, Martin Schwan wrote:
>
> > Add a simple unit test for testing the RAUC bootmethod. Provide only the
> > very basic tests for now, running a scan and list, to verify correct
> > detection of the RAUC bootmethod. More advanced boot tests of this
> > bootmethod can be added in a separate patch.
> >
> > This requires another mmc image (mmc9) to contain the following
> > partitions:
> >
> > 1. boot A: contains a dummy boot.scr
> > 2. root A: contains an empty root filesystem
> > 3. boot B: contains a dummy boot.scr
> > 4. root B: contains an empty root filesystem
> >
> > The bootmeth_rauc scans all four partitions for existence and expects a
> > boot script in each boot partition.
> >
> > Also add BOOTMETH_RAUC as a dependency on sandbox so that we can test
> > this with:
> >
> > $ ./test/py/test.py -B sandbox --build -k test_ut # build the mmc9.img
> > $ ./test/py/test.py -B sandbox --build -k bootflow_rauc
> >
> > Signed-off-by: Martin Schwan <m.schwan@phytec.de>
>
> I'm glad to see the tests. A question:
>
> [snip]
> > +    # Generate boot script
> > +    script = '# dummy boot script'
> > +    bootdir = os.path.join(mnt, 'boot')
> > +    utils.run_and_log(ubman, f'mkdir -p {bootdir}')
> > +    cmd_fname = os.path.join(bootdir, 'boot.cmd')
> > +    scr_fname = os.path.join(bootdir, 'boot.scr')
> > +    with open(cmd_fname, 'w', encoding='ascii') as outf:
> > +        print(script, file=outf)
> > +
> > +    mkimage = os.path.join(ubman.config.build_dir, 'tools/mkimage')
> > +    utils.run_and_log(
> > +        ubman, f'{mkimage} -C none -A arm -T script -d {cmd_fname} {scr_fname}')
> > +
> > +    # Create boot filesystem image with boot script in it and copy to disk image
> > +    fsfile = 'rauc_boot.img'
> > +    utils.run_and_log(ubman, f'fallocate -l 8M {fsfile}')
> > +    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
> > +    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {scr_fname} ::/'])
> > +    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=1 conv=notrunc')
> > +    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=19 conv=notrunc')
> > +    utils.run_and_log(ubman, f'rm -f {fsfile} {cmd_fname} {scr_fname}')
> > +
> > +    # Create empty root filesystem image and copy to disk image
> > +    fsfile = 'rauc_root.img'
> > +    utils.run_and_log(ubman, f'fallocate -l 10M {fsfile}')
> > +    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
> > +    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=9 conv=notrunc')
> > +    utils.run_and_log(ubman, f'dd if={fsfile} of=mmc{mmc_dev}.img bs=1M seek=27 conv=notrunc')
> > +    utils.run_and_log(ubman, f'rm -f {fsfile}')
>
> Can we use mk_fs from test/py/tests/fs_helper.py for this part? I know
> we can't use setup_image without further changes to allow for 'spec' to
> be passed (which may or may not be worth doing, I'm not sure) but I
> think we can use mk_fs here? Thanks.

+1

Other than that:

Reviewed-by: Simon Glass <sjg@chromium.org>

and thanks for doing it.

Regards,
Simon
