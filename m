Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89753E8B365
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 21:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 079C783BC7;
	Tue,  3 Feb 2026 22:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W0wqa4zc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B86F83DCB; Tue,  3 Feb 2026 22:31:09 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE50802C1
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 22:31:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8715a4d9fdso706175566b.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 13:31:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770154266; cv=none;
 d=google.com; s=arc-20240605;
 b=D8hiVVvoaObHOdSC/Wo1FYlZhrqM1Y1enDu7pHkEHHj0JbV5erT17z9u6An6NqRfEr
 aAatx2TVspvyriZrHqh1bI1ek7lNAsG5MGmoJsffYTHR8zm0m2nhKJmA+nR88sM0MOq0
 MZTvMygUVXURraWTW0d3iPyGN7X3qQlj4eGVt6XLo8Y6WDWBoYjJC+GA4aDv6yhKSKab
 q2+I8JaoKob7jTgRuX7mow8L8mHnR8ybnSmViIgNsfMVS7pbO126fuisGQISFMhZm2Pp
 QF2cn/TqOF7o/w9aem1+nGe2na8Uj/Ui1AmxkZaTT88b3ZTDi9WfcFF8Zv25JDRyv1t/
 cgyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nd+GP9cMvBcs+7cZWrg2okMlrorE70TRFI7BgO05R/Y=;
 fh=ed0Ie8kN2ZRpM9JpRUh2QtwLMXwIkJzbEqpXUxMla1Q=;
 b=RUcKGp47G/59UOdRbSE+9xByOjymQ/I6RczoUD1aRqtUrM4jz6BOoE6U13XjI0f5qO
 Xi3eCAvQMJjRnkIqnFn7DCBrdVNwD4qazw352wFWCTty/cUjbzOqh5DCS6JjDQ6/Ox4B
 01ooc0Tenp9g6sDYYFwzL1hFSlVIU6xGa2JPz5spuTdBKHEsPHbQWm6j4PbGMornEt19
 t/NHy/gIKvp37elCNCK5IM6v2dkSr8RP8AbYHJOXaHNFJTh8hsWXAHDZn7l2+7DnKxzs
 AyA801phZtM/eHGYEyj0M6tAL7RrW4UEK0asrZJnCycTdsZjzJDcOzv61TtO7tgyLmWk
 aiyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770154266; x=1770759066; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nd+GP9cMvBcs+7cZWrg2okMlrorE70TRFI7BgO05R/Y=;
 b=W0wqa4zcnid/ZqOrq9keTLmt8WWcdGOCFaRnIGPAZZgUPhtq+LL2C7gMqHeCTS8dcK
 i9nblSKSo6ZqNyZTqMoVQAhA0A/FxT3UDnFTr4Po4kSj7GCmeHThdXUcdFHPlly0WLK9
 XKW1QZdmH++960bdZvMo34sLE25apSfKuuG2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770154266; x=1770759066;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd+GP9cMvBcs+7cZWrg2okMlrorE70TRFI7BgO05R/Y=;
 b=XSeEsUsEUaiRNKF3f+Ricw36ulwaqobgbeH07FhUAKWUe06A70apNbTu3/p8S4dCUl
 o41xvTfNQtrLNKZUFRk1QxJJlpCdWHw/a8wGPWKKsWI5GvBVbUcAUALIqvKq4g5kAOsZ
 4bWHY5PU1VlT3XQwn31aZBUgRMTakA3YkC7uLzDOatFX2NNZGDRSoR5KdVspOO2Jt8Ys
 IqFG56q06ymDS+h1XNAltkfL5KQ2Ph9Fg/xFNFvhwVNqysov3P9kG3mpZHZ8p2L4bUBC
 QQ0fp3xq9sD53qAeMXvdaya5HfhpHt8RVOlkpLI5iXguUj4h7hWcsY0715/8gMQMqHYf
 sAjA==
X-Gm-Message-State: AOJu0YyMHfMCvx9VQiYLXXDVIEqyQdJxtKX34J3fAa6qmfQmsExGDTFQ
 u/M6L6YK2Hhmnaa4Yh06QP7dsurK/sKE9il5A3B0z85n3u4gIuW4sm3P8jdU54TnIzs0jW8TK4O
 Gi56lpaMVaBciKuFUYU93VmYbxh7frI1H7VXOMssP
X-Gm-Gg: AZuq6aJyogrhLiU08MhmRB266uciMlLOG4z2pKPDHYfEXixf3NjZUxyL/H1koPXTjma
 hWt/5v6Nj9oqshxFc+Cmi4LXbTR/WQmiRuq4eBZPz4eWZmi3PQzKPPy5ezqSfY52+tPrRimn6Ll
 eIuewrwZwCFDn+jlMNdgjB9Mk7mvPmLjSkp6QihtHheqq+v9g2izllyYEOwkkUqTnBV0XRZyPiT
 Dxt311C2prgRc74dppLIkvjlqOFFQj4kco16y9qUIp/Yy78uCQd1Y8j2uPZyhlKwaopHe061oA4
 rRuDxQ==
X-Received: by 2002:a17:907:1b16:b0:b88:48ba:cdd with SMTP id
 a640c23a62f3a-b8e9f2f5cbbmr56981466b.43.1770154265740; Tue, 03 Feb 2026
 13:31:05 -0800 (PST)
MIME-Version: 1.0
References: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
 <20260129235647.660906-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260129235647.660906-3-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 10:31:06 +1300
X-Gm-Features: AZwV_Qj-PMT1N-gXiQnEMXY9uUbtPKF7ZY-RGrKE0ItnCi83JAdXdVcCwv7hmRo
Message-ID: <CAFLszTjMp4crBRadU7EfDtDa9FbR4tp_=Wg7xLvhAj5fKLchsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] test: cmd: Add test for zip/unzip/gzwrite commands
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
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

Hi Marek,

On Fri, 30 Jan 2026 at 12:57, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Add simple test for zip/unzip/gzwrite commands. The test works as
> follows. First, create three buffers with a bit of space between
> each of them, fill them with random data, then compress data in
> buffer 1 into buffer 2, decompress data in buffer 2 either directly
> into buffer 3 or into MMC 1 and then read them back into buffer 3,
> and finally compare buffer 1 and buffer 3, they have to be identical.
>
> The buffers are filled with random data to detect out of bounds writes.
> Test for various sizes, both small and large and unaligned.
>
> The test uses ut_assert_skip_to_line() to skip over gzwrite progress
> bar. Since the progress bar updates fill up the console record buffer,
> increase the size of it to compensate.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alexander Graf <agraf@csgraf.de>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Use ut_assert_skip_to_line() to skip over the progress bar.
>     Since that fills up the console record buffer, increase the
>     size of it to compensate.
> ---
>  arch/sandbox/dts/test.dts |   7 +++
>  common/Kconfig            |   2 +-
>  test/cmd/Makefile         |   4 ++
>  test/cmd/unzip.c          | 123 ++++++++++++++++++++++++++++++++++++++
>  test/py/tests/test_ut.py  |   6 ++
>  5 files changed, 141 insertions(+), 1 deletion(-)
>  create mode 100644 test/cmd/unzip.c
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index b7402d7042a..762c1d9bbe2 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1272,6 +1272,13 @@
>                 filename = "mmc8.img";
>         };
>
> +       /* This is used for zip/unzip/gzwrite tests. */
> +       mmc9 {
> +               status = "disabled";
> +               compatible = "sandbox,mmc";
> +               filename = "mmc9.img";
> +       };
> +
>         pch {
>                 compatible = "sandbox,pch";
>         };
> diff --git a/common/Kconfig b/common/Kconfig
> index 47d17f4e7c6..63448bdc13b 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -26,7 +26,7 @@ config CONSOLE_RECORD_INIT_F
>  config CONSOLE_RECORD_OUT_SIZE
>         hex "Output buffer size"
>         depends on CONSOLE_RECORD
> -       default 0x6000
> +       default 0x20000
>         help
>           Set the size of the console recording output buffer. When this fills
>           up, no more data will be recorded until some is removed. The buffer
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 2476068aee6..273009a034f 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -45,3 +45,7 @@ endif
>  obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
>  endif
>  obj-$(CONFIG_CMD_SPAWN) += spawn.o
> +
> +ifdef CONFIG_CMD_ZIP
> +obj-$(CONFIG_CMD_UNZIP) += unzip.o
> +endif
> diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
> new file mode 100644
> index 00000000000..dc4a9c93745
> --- /dev/null
> +++ b/test/cmd/unzip.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Tests for zip/unzip/gzwrite commands
> + *
> + * Copyright 2026, Marek Vasut <marek.vasut+renesas@mailbox.org>
> + */
> +
> +#include <command.h>
> +#include <env.h>
> +#include <dm.h>
> +#include <dm/lists.h>
> +#include <dm/test.h>
> +#include <linux/sizes.h>
> +#include <mapmem.h>
> +#include <part.h>
> +#include <test/cmd.h>
> +#include <test/test.h>
> +#include <test/ut.h>
> +#include <u-boot/crc.h>
> +
> +static const int sizes[] = { 32, SZ_1K, SZ_4K, SZ_1M, SZ_16M, SZ_1M - 1, SZ_1M + 1, 6758401 };
> +
> +static int do_test_cmd_zip_unzip(struct unit_test_state *uts, const int size,
> +                                const bool gzwrite)
> +{
> +       env_set_hex("size", size);
> +
> +       /*
> +        * Prepare three buffers, $loadadd, $encaddr, $decaddr, and
> +        * fill them all with random data. Add slight space between
> +        * the compressed buffer 'encaddr' and uncompressed buffer
> +        * 'decaddr', because the compressed data with gzip header
> +        * might be longer than uncompressed source data 'loadaddr',
> +        * and if the uncompressed data buffer 'decaddr' followed
> +        * 'encaddr', the decompression could corrupt end of 'encaddr'
> +        * buffer.
> +        */
> +       ut_assertok(run_command("setexpr encaddr $loadaddr + $size", 0));
> +       ut_assertok(run_command("setexpr encaddr $encaddr + 0x10000", 0));
> +
> +       ut_assertok(run_command("setexpr decaddr $encaddr + $size", 0));
> +       ut_assertok(run_command("setexpr decaddr $decaddr + 0x10000", 0));
> +
> +       ut_assertok(run_command("random $loadaddr $size", 0));
> +       ut_assert_nextline("%d bytes filled with random data", size);
> +       ut_assertok(run_command("random $encaddr $size", 0));
> +       ut_assert_nextline("%d bytes filled with random data", size);
> +       ut_assertok(run_command("random $decaddr $size", 0));
> +       ut_assert_nextline("%d bytes filled with random data", size);

I would argue for calling the functions directly instead of via run_command()

> +
> +       /* Compress data in $loadaddr into $encaddr */
> +       ut_assertok(run_command("zip $loadaddr $size $encaddr", 0));

Perhaps add a flag to avoid generating so much output from this command?


> +       console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +       ut_assert(strstr(uts->actual_str, "Compressed size: "));
> +
> +       if (gzwrite) {
> +               unsigned int sectsize = DIV_ROUND_UP(size, 512);
> +               unsigned char *db = map_sysmem(env_get_ulong("loadaddr", 16, 0), size);
> +               u32 crc = crc32(0, db, size);
> +
> +               ut_assertok(run_command("gzwrite mmc 9 $encaddr $filesize", 0));
> +               ut_assert_skip_to_line("\t%u bytes, crc 0x%08x", size, crc);
> +
> +               env_set_hex("sectsize", sectsize);
> +               ut_assertok(run_command("mmc read $decaddr 0 $sectsize", 0));

You can use run_commandf and %lx for the args. No need to set env vars.

> +               ut_assert_nextline("MMC read: dev # 9, block # 0, count %u ... %u blocks read: OK",
> +                                  sectsize, sectsize);
> +       } else {
> +               /* Decompress data in $encaddr into $decaddr */
> +               ut_assertok(run_command("unzip $encaddr $decaddr $filesize", 0));
> +               ut_assert_nextline("Uncompressed size: %u = 0x%X", size, size);
> +       }
> +
> +       /* Input data and compressed-decompressed data */
> +       ut_assertok(run_command("cmp.b $loadaddr $decaddr $size", 0));
> +       ut_assert_nextline("Total of %u byte(s) were the same", size);

ut_asserteq_mem()

> +
> +       ut_assert_console_end();
> +
> +       return 0;
> +}
> +
> +static int dm_test_cmd_zip_unzip(struct unit_test_state *uts)
> +{
> +       int i, ret;
> +
> +       for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> +               ret = do_test_cmd_zip_unzip(uts, sizes[i], false);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_cmd_zip_unzip, UTF_CONSOLE);
> +
> +static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
> +{
> +       struct blk_desc *mmc_dev_desc;
> +       struct udevice *dev;
> +       ofnode root, node;
> +       int i, ret;
> +
> +       /* Enable the mmc9 node for this test */
> +       root = oftree_root(oftree_default());
> +       node = ofnode_find_subnode(root, "mmc9");
> +       ut_assert(ofnode_valid(node));
> +       ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
> +
> +       ut_asserteq(9, blk_get_device_by_str("mmc", "9", &mmc_dev_desc));
> +       ut_assertok(run_commandf("mmc dev 9"));
> +       ut_assert_nextline("switch to partitions #0, OK");
> +       ut_assert_nextline("mmc9 is current device");

Is this actually needed? It seems that the zip command specifies the device.

> +
> +       for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> +               ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 6d535b5206d..b7166d59943 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -522,6 +522,12 @@ def test_ut_dm_init(ubman):
>      with open(fn, 'wb') as fh:
>          fh.write(data)
>
> +    mmc_dev = 9
> +    fn = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> +    data = b'\x00' * (32 * 1024 * 1024)
> +    with open(fn, 'wb') as fh:
> +        fh.write(data)
> +
>
>  def setup_efi_image(ubman):
>      """Create a 20MB disk image with an EFI app on it"""
> --
> 2.51.0
>

Regards,
Simon
