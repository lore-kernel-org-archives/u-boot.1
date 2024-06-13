Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0818C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 14:20:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CB1883F4;
	Thu, 13 Jun 2024 16:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="M0pKIa7A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA2748867D; Thu, 13 Jun 2024 16:20:02 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99889807EC
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 16:20:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35f1bc2ab37so1063961f8f.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 07:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718288400; x=1718893200;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TagqVV50o7mrfM4PTMgUhYU3zlZ/1fTK0li5hoB/2dk=;
 b=M0pKIa7ARNdjZBqBIFn2hdkkds5pUPQBD7SqtiR7t9w2qH/QMYO/cjUjmOixxHmJi5
 p+gaXIADaHk10GRnvvxfoGXjIXID+eqzEoplWH14b8of9tNEoWJSDeykfGEnl8WgNHfY
 7CnFHGHFoaqgYK0lhbyz8TXWWBQhrNNtRhuL6wLrCeAacX6EAY2ehIl1Hj+XDJO/tS9N
 hbsaSkuXmIGmf6pXmZ+YkazK/Jx6XacmP1wKkK+NJwnTUOGsd7eo5mGssH3xhqODZDH7
 nL+AZnAuCVImj5tKe0NllXMRHUShxyI/kWw02M4J+jk4sFTJ2b0Dj/HbxCVUX4pVMt7j
 /k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718288400; x=1718893200;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TagqVV50o7mrfM4PTMgUhYU3zlZ/1fTK0li5hoB/2dk=;
 b=egCLU3qkmKF15IxiWkRlTB+Yl5Itg3D4eNZ9F2yixJpoLZGmCWDdnFYIto2GppNzKH
 zj0Qf48H9BJ4TrqR6PqaAiF3kA5xaGhBKlTCoaliW/BV0raYmTh4Tc9R92nDUG+ND4XM
 ZC4kEFynwmY5e90KuEEi3NZ03jtTS0MogEmLpkP8a+sCgOstSZMiwFmsgW9zFaiVY3Eh
 JcpB1B1cqeu4jypz2R1SBX7JNuaOsd+iEy5cQ0Z57+jglcjvIMA5MD8C+pqTPAl2dMw8
 wKZfCsFjJWWlvTIqVN9sadHdCSt9fHGLWoVUWuz4TOVJykG8uwI16IE/x7z1yxRG5hKH
 nRKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx75iSb8vKAoxipQDbpAYmbOkfm4Mf3u70Mm12ZJh40rPRbpbqVzBpbe6gLqkomQbXbgXfCDzTEFL8xGT4sonAqsvgLg==
X-Gm-Message-State: AOJu0Yx4+YHXE8DVQWjptL0qzBAxDEggcMDPC7WVtTJRhnV+aJQHIuQ3
 WjeibL1ppuFXtPj6sNAEF7cmaPZtLMM3iW3/eiu+Ak/j1CIQoPVkwtFrevZMdSY=
X-Google-Smtp-Source: AGHT+IFWtNa5IcjaD6Qa5GOPJZHHywapMIQwXv2O8Dj7sML5FJEus9fSc3iZUFJSNye/ykHzsOGcSA==
X-Received: by 2002:adf:f648:0:b0:360:791c:aff1 with SMTP id
 ffacd0b85a97d-360791cb119mr999819f8f.2.1718288399972; 
 Thu, 13 Jun 2024 07:19:59 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750ad177sm1868283f8f.56.2024.06.13.07.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:19:59 -0700 (PDT)
From: Julien Masson <jmasson@baylibre.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Simon Glass
 <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, Guillaume La Roque
 <glaroque@baylibre.com>, Dmitrii Merkurev <dimorinny@google.com>, Roman
 Stratiienko <r.stratiienko@gmail.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2 5/5] bootstd: Add test for bootmeth_android
In-Reply-To: <20240613-bootmeth-android-v2-5-397f6e66eb29@baylibre.com>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
Date: Thu, 13 Jun 2024 16:19:58 +0200
Message-ID: <87ed90ncvl.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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


On Thu 13 Jun 2024 at 16:19, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Add a unit test for testing the Android bootmethod.
> 
> This requires another mmc image (mmc7) to contain the following partitions:
> - misc: contains the Bootloader Control Block (BCB)
> - boot_a: contains a fake generic kernel image
> - vendor_boot_a: contains a fake vendor_boot image
> 
> Also add BOOTMETH_ANDROID as a dependency on sandbox so that we can test
> this with:
> 
> $ ./test/py/test.py --bd sandbox --build -k test_abootimg # build bootv4.img
> $ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc7.img
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  arch/sandbox/dts/test.dts |  8 +++++
>  configs/sandbox_defconfig |  2 +-
>  test/boot/bootflow.c      | 65 ++++++++++++++++++++++++++++++++++++++--
>  test/py/tests/test_ut.py  | 76 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 147 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index a012f5c4c9ba..5fb5eac862ec 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -43,6 +43,7 @@
>  		mmc4 = "/mmc4";
>  		mmc5 = "/mmc5";
>  		mmc6 = "/mmc6";
> +		mmc7 = "/mmc7";
>  		pci0 = &pci0;
>  		pci1 = &pci1;
>  		pci2 = &pci2;
> @@ -1129,6 +1130,13 @@
>  		filename = "mmc6.img";
>  	};
>  
> +	/* This is used for Android tests */
> +	mmc7 {
> +		status = "disabled";
> +		compatible = "sandbox,mmc";
> +		filename = "mmc7.img";
> +	};
> +
>  	pch {
>  		compatible = "sandbox,pch";
>  	};
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 93b52f2de5cf..bc4398f101a7 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -15,6 +15,7 @@ CONFIG_FIT=y
>  CONFIG_FIT_RSASSA_PSS=y
>  CONFIG_FIT_CIPHER=y
>  CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_MEASURED_BOOT=y
>  CONFIG_BOOTSTAGE=y
> @@ -40,7 +41,6 @@ CONFIG_LOG_MAX_LEVEL=9
>  CONFIG_LOG_DEFAULT_LEVEL=6
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_STACKPROTECTOR=y
> -CONFIG_ANDROID_AB=y
>  CONFIG_CMD_CPU=y
>  CONFIG_CMD_LICENSE=y
>  CONFIG_CMD_SMBIOS=y
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 4511cfa7f9bf..934c4dcbad2b 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -27,6 +27,7 @@
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> +extern U_BOOT_DRIVER(bootmeth_android);
>  extern U_BOOT_DRIVER(bootmeth_cros);
>  extern U_BOOT_DRIVER(bootmeth_2script);
>  
> @@ -518,12 +519,12 @@ BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
>   * @uts: Unit test state
>   * @mmc_dev: MMC device to use, e.g. "mmc4". Note that this must remain valid
>   *	in the caller until
> - * @bind_cros: true to bind the ChromiumOS bootmeth
> + * @bind_cros: true to bind the ChromiumOS and Android bootmeths
>   * @old_orderp: Returns the original bootdev order, which must be restored
>   * Returns 0 on success, -ve on failure
>   */
>  static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
> -			    bool bind_cros, const char ***old_orderp)
> +			    bool bind_cros_android, const char ***old_orderp)
>  {
>  	static const char *order[] = {"mmc2", "mmc1", NULL, NULL};
>  	struct udevice *dev, *bootstd;
> @@ -545,12 +546,19 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>  				"bootmeth_script", 0, ofnode_null(), &dev));
>  
>  	/* Enable the cros bootmeth if needed */
> -	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros) {
> +	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
>  		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
>  		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
>  					"cros", 0, ofnode_null(), &dev));
>  	}
>  
> +	/* Enable the android bootmeths if needed */
> +	if (IS_ENABLED(CONFIG_BOOTMETH_ANDROID) && bind_cros_android) {
> +		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> +		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
> +					"android", 0, ofnode_null(), &dev));
> +	}
> +
>  	/* Change the order to include the device */
>  	std = dev_get_priv(bootstd);
>  	old_order = std->bootdev_order;
> @@ -589,6 +597,37 @@ static int scan_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>  	return 0;
>  }
>  
> +/**
> + * scan_mmc_android_bootdev() - Set up an mmc bootdev so we can access other
> + * distros. Android bootflow might print "ANDROID:*" while scanning
> + *
> + * @uts: Unit test state
> + * @mmc_dev: MMC device to use, e.g. "mmc4"
> + * Returns 0 on success, -ve on failure
> + */
> +static int scan_mmc_android_bootdev(struct unit_test_state *uts, const char *mmc_dev)
> +{
> +	struct bootstd_priv *std;
> +	struct udevice *bootstd;
> +	const char **old_order;
> +
> +	ut_assertok(prep_mmc_bootdev(uts, mmc_dev, true, &old_order));
> +
> +	console_record_reset_enable();
> +	ut_assertok(run_command("bootflow scan", 0));
> +	/* Android bootflow might print one or two 'ANDROID:*' logs */
> +	ut_check_skipline(uts);
> +	ut_check_skipline(uts);
> +	ut_assert_console_end();
> +
> +	/* Restore the order used by the device tree */
> +	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> +	std = dev_get_priv(bootstd);
> +	std->bootdev_order = old_order;
> +
> +	return 0;
> +}
> +
>  /**
>   * scan_mmc4_bootdev() - Set up the mmc4 bootdev so we can access a fake Armbian
>   *
> @@ -1160,3 +1199,23 @@ static int bootflow_cros(struct unit_test_state *uts)
>  	return 0;
>  }
>  BOOTSTD_TEST(bootflow_cros, 0);
> +
> +/* Test Android bootmeth  */
> +static int bootflow_android(struct unit_test_state *uts)
> +{
> +	ut_assertok(scan_mmc_android_bootdev(uts, "mmc7"));
> +	ut_assertok(run_command("bootflow list", 0));
> +
> +	ut_assert_nextlinen("Showing all");
> +	ut_assert_nextlinen("Seq");
> +	ut_assert_nextlinen("---");
> +	ut_assert_nextlinen("  0  extlinux");
> +	ut_assert_nextlinen("  1  android      ready   mmc          0  mmc7.bootdev.whole        ");
> +	ut_assert_nextlinen("---");
> +	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
> +
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +BOOTSTD_TEST(bootflow_android, 0);
> diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
> index c169c835e38a..39e1abe02a68 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -423,6 +423,81 @@ def setup_cros_image(cons):
>  
>      return fname
>  
> +def setup_android_image(cons):
> +    """Create a 20MB disk image with Android partitions"""
> +    Partition = collections.namedtuple('part', 'start,size,name')
> +    parts = {}
> +    disk_data = None
> +
> +    def set_part_data(partnum, data):
> +        """Set the contents of a disk partition
> +
> +        This updates disk_data by putting data in the right place
> +
> +        Args:
> +            partnum (int): Partition number to set
> +            data (bytes): Data for that partition
> +        """
> +        nonlocal disk_data
> +
> +        start = parts[partnum].start * sect_size
> +        disk_data = disk_data[:start] + data + disk_data[start + len(data):]
> +
> +    mmc_dev = 7
> +    fname = os.path.join(cons.config.source_dir, f'mmc{mmc_dev}.img')
> +    u_boot_utils.run_and_log(cons, 'qemu-img create %s 20M' % fname)
> +    u_boot_utils.run_and_log(cons, f'cgpt create {fname}')
> +
> +    ptr = 40
> +
> +    # Number of sectors in 1MB
> +    sect_size = 512
> +    sect_1mb = (1 << 20) // sect_size
> +
> +    required_parts = [
> +        {'num': 1, 'label':'misc', 'size': '1M'},
> +        {'num': 2, 'label':'boot_a', 'size': '4M'},
> +        {'num': 3, 'label':'boot_b', 'size': '4M'},
> +        {'num': 4, 'label':'vendor_boot_a', 'size': '4M'},
> +        {'num': 5, 'label':'vendor_boot_b', 'size': '4M'},
> +    ]
> +
> +    for part in required_parts:
> +        size_str = part['size']
> +        if 'M' in size_str:
> +            size = int(size_str[:-1]) * sect_1mb
> +        else:
> +            size = int(size_str)
> +        u_boot_utils.run_and_log(
> +            cons,
> +            f"cgpt add -i {part['num']} -b {ptr} -s {size} -l {part['label']} -t basicdata {fname}")
> +        ptr += size
> +
> +    u_boot_utils.run_and_log(cons, f'cgpt boot -p {fname}')
> +    out = u_boot_utils.run_and_log(cons, f'cgpt show -q {fname}')
> +
> +    # Create a dict (indexed by partition number) containing the above info
> +    for line in out.splitlines():
> +        start, size, num, name = line.split(maxsplit=3)
> +        parts[int(num)] = Partition(int(start), int(size), name)
> +
> +    with open(fname, 'rb') as inf:
> +        disk_data = inf.read()
> +
> +    boot_img = os.path.join(cons.config.result_dir, 'bootv4.img')
> +    with open(boot_img, 'rb') as inf:
> +        set_part_data(2, inf.read())
> +
> +    vendor_boot_img = os.path.join(cons.config.result_dir, 'vendor_boot.img')
> +    with open(vendor_boot_img, 'rb') as inf:
> +        set_part_data(4, inf.read())
> +
> +    with open(fname, 'wb') as outf:
> +        outf.write(disk_data)
> +
> +    print('wrote to {}'.format(fname))
> +
> +    return fname
>  
>  def setup_cedit_file(cons):
>      infname = os.path.join(cons.config.source_dir,
> @@ -477,6 +552,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
>      setup_bootmenu_image(u_boot_console)
>      setup_cedit_file(u_boot_console)
>      setup_cros_image(u_boot_console)
> +    setup_android_image(u_boot_console)
>  
>      # Restart so that the new mmc1.img is picked up
>      u_boot_console.restart_uboot()
> 
> -- 
> 2.45.2
> 

Reviewed-by: Julien Masson <jmasson@baylibre.com>
-- 
Julien Masson
