Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA55E7FDC7
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 20:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8386883F59;
	Mon,  2 Feb 2026 21:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ZfGo1znw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3A8D83F5B; Mon,  2 Feb 2026 21:04:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F4883C04
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 21:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770062632; x=1770667432; i=xypron.glpk@gmx.de;
 bh=w5fN9FBBJ2Okx4DPfQiuN/qY+sHJdzD27XwiaaWkJ/8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ZfGo1znw7z6CI81n6uUyZV3pr3d3FGjnHZLLuji/x14fmbn9kjf/EtBVzbVGHjEu
 rX1D6JJawUYg4TSw+x3xJ54R3qP6W3LfA9pkMzka3vsrSCEe5a+deChhvlIe2X+Hl
 BuQMailLruYUnTfMvf/YZvx3/6oex4nDs7/3wJL9ZJeXk0PacXQ6JSgApVat+GL6P
 tXeyfUzW7EDeg+te4MhNaWWsjI4fCaFdosTmYuoKOe7NFn1Ys1z0GGedO99rIXgpG
 f+rFkRZqGxnQpUgDnrUjE4LdYzg2KBK1/g4SMTBEOFslCiqcsRLJuX0WJvGOf1Ve6
 4YEXAVklBE4AChFHZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.127] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MoO24-1vTOud3srY-00miUg; Mon, 02
 Feb 2026 21:03:52 +0100
Message-ID: <79edd776-5993-4a67-b909-afb3c4e43123@gmx.de>
Date: Mon, 2 Feb 2026 21:03:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] test: cmd: Add test for zip/unzip/gzwrite commands
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Graf <agraf@csgraf.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>, u-boot@lists.denx.de
References: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
 <20260129235647.660906-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20260129235647.660906-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Vp+fAr1ukrkiTGdnbPwC89rgtjBNGVoPaoeRx74aAiosFk2xQJ
 YK69g6JVH846cY2+LJfiRfOfrD2ZGj5Dk/xgJ37u0DC4HSlnoaoWJV1ZKHf6/U05gQvXKec
 6OcM0RyijKVMX+IioHtm4Qe2C59V3qt5GHhovQemUUGZPaht7o/3Fd8SHK2bs579/feviM/
 aGZS5WlZvHVuUPCqxvNIA==
UI-OutboundReport: notjunk:1;M01:P0:EiZX88tXzEk=;n29ab5l30vkLvlskFPmtEgBaBXe
 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
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

On 1/30/26 00:55, Marek Vasut wrote:
> Add simple test for zip/unzip/gzwrite commands. The test works as
> follows. First, create three buffers with a bit of space between
> each of them, fill them with random data, then compress data in
> buffer 1 into buffer 2, decompress data in buffer 2 either directly
> into buffer 3 or into MMC 1 and then read them back into buffer 3,
> and finally compare buffer 1 and buffer 3, they have to be identical.
>=20
> The buffers are filled with random data to detect out of bounds writes.
> Test for various sizes, both small and large and unaligned.
>=20
> The test uses ut_assert_skip_to_line() to skip over gzwrite progress
> bar. Since the progress bar updates fill up the console record buffer,
> increase the size of it to compensate.
>=20
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
>      Since that fills up the console record buffer, increase the
>      size of it to compensate.
> ---
>   arch/sandbox/dts/test.dts |   7 +++
>   common/Kconfig            |   2 +-
>   test/cmd/Makefile         |   4 ++
>   test/cmd/unzip.c          | 123 ++++++++++++++++++++++++++++++++++++++
>   test/py/tests/test_ut.py  |   6 ++
>   5 files changed, 141 insertions(+), 1 deletion(-)
>   create mode 100644 test/cmd/unzip.c
>=20
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index b7402d7042a..762c1d9bbe2 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -1272,6 +1272,13 @@
>   		filename =3D "mmc8.img";
>   	};
>  =20
> +	/* This is used for zip/unzip/gzwrite tests. */
> +	mmc9 {
> +		status =3D "disabled";
> +		compatible =3D "sandbox,mmc";
> +		filename =3D "mmc9.img";
> +	};
> +
>   	pch {
>   		compatible =3D "sandbox,pch";
>   	};
> diff --git a/common/Kconfig b/common/Kconfig
> index 47d17f4e7c6..63448bdc13b 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -26,7 +26,7 @@ config CONSOLE_RECORD_INIT_F
>   config CONSOLE_RECORD_OUT_SIZE
>   	hex "Output buffer size"
>   	depends on CONSOLE_RECORD
> -	default 0x6000
> +	default 0x20000
>   	help
>   	  Set the size of the console recording output buffer. When this fill=
s
>   	  up, no more data will be recorded until some is removed. The buffer
> diff --git a/test/cmd/Makefile b/test/cmd/Makefile
> index 2476068aee6..273009a034f 100644
> --- a/test/cmd/Makefile
> +++ b/test/cmd/Makefile
> @@ -45,3 +45,7 @@ endif
>   obj-$(CONFIG_ARM_FFA_TRANSPORT) +=3D armffa.o
>   endif
>   obj-$(CONFIG_CMD_SPAWN) +=3D spawn.o
> +
> +ifdef CONFIG_CMD_ZIP
> +obj-$(CONFIG_CMD_UNZIP) +=3D unzip.o

Building the test depends on CONFIG_CMD_RANDOM. Please, add all missing=20
dependencies.

Best regards

Heinrich

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
> +static const int sizes[] =3D { 32, SZ_1K, SZ_4K, SZ_1M, SZ_16M, SZ_1M -=
 1, SZ_1M + 1, 6758401 };
> +
> +static int do_test_cmd_zip_unzip(struct unit_test_state *uts, const int=
 size,
> +				 const bool gzwrite)
> +{
> +	env_set_hex("size", size);
> +
> +	/*
> +	 * Prepare three buffers, $loadadd, $encaddr, $decaddr, and
> +	 * fill them all with random data. Add slight space between
> +	 * the compressed buffer 'encaddr' and uncompressed buffer
> +	 * 'decaddr', because the compressed data with gzip header
> +	 * might be longer than uncompressed source data 'loadaddr',
> +	 * and if the uncompressed data buffer 'decaddr' followed
> +	 * 'encaddr', the decompression could corrupt end of 'encaddr'
> +	 * buffer.
> +	 */
> +	ut_assertok(run_command("setexpr encaddr $loadaddr + $size", 0));
> +	ut_assertok(run_command("setexpr encaddr $encaddr + 0x10000", 0));
> +
> +	ut_assertok(run_command("setexpr decaddr $encaddr + $size", 0));
> +	ut_assertok(run_command("setexpr decaddr $decaddr + 0x10000", 0));
> +
> +	ut_assertok(run_command("random $loadaddr $size", 0));
> +	ut_assert_nextline("%d bytes filled with random data", size);
> +	ut_assertok(run_command("random $encaddr $size", 0));
> +	ut_assert_nextline("%d bytes filled with random data", size);
> +	ut_assertok(run_command("random $decaddr $size", 0));
> +	ut_assert_nextline("%d bytes filled with random data", size);
> +
> +	/* Compress data in $loadaddr into $encaddr */
> +	ut_assertok(run_command("zip $loadaddr $size $encaddr", 0));
> +	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
> +	ut_assert(strstr(uts->actual_str, "Compressed size: "));
> +
> +	if (gzwrite) {
> +		unsigned int sectsize =3D DIV_ROUND_UP(size, 512);
> +		unsigned char *db =3D map_sysmem(env_get_ulong("loadaddr", 16, 0), si=
ze);
> +		u32 crc =3D crc32(0, db, size);
> +
> +		ut_assertok(run_command("gzwrite mmc 9 $encaddr $filesize", 0));
> +		ut_assert_skip_to_line("\t%u bytes, crc 0x%08x", size, crc);
> +
> +		env_set_hex("sectsize", sectsize);
> +		ut_assertok(run_command("mmc read $decaddr 0 $sectsize", 0));
> +		ut_assert_nextline("MMC read: dev # 9, block # 0, count %u ... %u blo=
cks read: OK",
> +				   sectsize, sectsize);
> +	} else {
> +		/* Decompress data in $encaddr into $decaddr */
> +		ut_assertok(run_command("unzip $encaddr $decaddr $filesize", 0));
> +		ut_assert_nextline("Uncompressed size: %u =3D 0x%X", size, size);
> +	}
> +
> +	/* Input data and compressed-decompressed data */
> +	ut_assertok(run_command("cmp.b $loadaddr $decaddr $size", 0));
> +	ut_assert_nextline("Total of %u byte(s) were the same", size);
> +
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +
> +static int dm_test_cmd_zip_unzip(struct unit_test_state *uts)
> +{
> +	int i, ret;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sizes); i++) {
> +		ret =3D do_test_cmd_zip_unzip(uts, sizes[i], false);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_cmd_zip_unzip, UTF_CONSOLE);
> +
> +static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
> +{
> +	struct blk_desc *mmc_dev_desc;
> +	struct udevice *dev;
> +	ofnode root, node;
> +	int i, ret;
> +
> +	/* Enable the mmc9 node for this test */
> +	root =3D oftree_root(oftree_default());
> +	node =3D ofnode_find_subnode(root, "mmc9");
> +	ut_assert(ofnode_valid(node));
> +	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
> +
> +	ut_asserteq(9, blk_get_device_by_str("mmc", "9", &mmc_dev_desc));
> +	ut_assertok(run_commandf("mmc dev 9"));
> +	ut_assert_nextline("switch to partitions #0, OK");
> +	ut_assert_nextline("mmc9 is current device");
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sizes); i++) {
> +		ret =3D do_test_cmd_zip_unzip(uts, sizes[i], true);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index 6d535b5206d..b7166d59943 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -522,6 +522,12 @@ def test_ut_dm_init(ubman):
>       with open(fn, 'wb') as fh:
>           fh.write(data)
>  =20
> +    mmc_dev =3D 9
> +    fn =3D os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
> +    data =3D b'\x00' * (32 * 1024 * 1024)
> +    with open(fn, 'wb') as fh:
> +        fh.write(data)
> +
>  =20
>   def setup_efi_image(ubman):
>       """Create a 20MB disk image with an EFI app on it"""

