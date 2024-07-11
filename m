Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD455C41513
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 13:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1F6387F7D;
	Thu, 11 Jul 2024 15:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="i6j/lZwG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA69D881B8; Thu, 11 Jul 2024 15:49:36 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A298387CDB
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 15:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3678fbf4a91so448321f8f.1
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720705774; x=1721310574;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/51lSXHUfROkUkbyMuF9ZqQqtcsonpIaZYP+jcjSup0=;
 b=i6j/lZwG8vzruSmbXjtiLQw0uTRtTHoA4WhqsQaasYefOekVuizk5WPT+ylHh8m4ST
 c8+RGcprqVrepOqIytXtyxkUZUU/C9WqtOKm1CwaW7KWyWDKdq2mVop8PsZlK36bTZP1
 7Qlp0ZJs+BGZ26bkpp86RJd4qa82+jzx3PQ9f7d7WjnR1jTWML+peGS9ns/XHZt+DnKo
 cZcXxTltXTXaGQV2RYAEgl6/qrKAde7+w9TZYK9bK4wmjW2wRg2L6YgWcH90iBJHXmMJ
 gzbxSFl7wXCNb0cqA+DmpPO+w4Fd9hOoZ5nHIe0oWkNCQXrPw4Y9wxen8a58otyROA17
 R5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720705774; x=1721310574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/51lSXHUfROkUkbyMuF9ZqQqtcsonpIaZYP+jcjSup0=;
 b=qfdc2VJM68MO1uVgahd4vsI/BH2Fon3PqNBm2TtMjecpYNsGURD4j3XHLAd9euG9eO
 JxUWEks+gQ/DvzV0MGJrGom20AwJxeUPxD1UtWO8NL54yG7w4R5H5ridpsq8mqRG6Eya
 EBUT+/YHh9qXDanQK5VYYK33n9YXj5rM7l6MQ64GIyFnsgswMWPpS533yk1ncGv2SZF/
 ScCddk5kWc0qXUReUskixPOXWgHXog8kA8pbwqwEoOxTgQqpJuDmrJpCtfUfVo13wAu3
 lXwbVOF1xeb8Lk+qloqyh8sjDkul86H6rs1hWRur3D711lCIwpxjtY9k9HZI42yf2B1u
 352Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKCYmek6o4DqwijtKB2O8/rqX+xOWa7aPx85zLoZklET7ZEroyP9Nfkh0Ml/ombhyXgiUovkCF+bChyUHOoDe49EMmCQ==
X-Gm-Message-State: AOJu0YxLv65SooJsifxhfZ3wbOFHburZuPzraKWj+EuN7rxvJBinB10r
 ITRVsO6ET7qWCJToPE33oRj9+UNwcMcaSmLuphdPNy1whg6llj4XSFxO4S7gvoE=
X-Google-Smtp-Source: AGHT+IHIzTVkjD1nXGJNApkcxgL6QebEV4uLo8g5uNaYTxjOujcTEXJOGEDHwgsOuuGdnsztF93kLA==
X-Received: by 2002:a5d:674f:0:b0:367:916e:4206 with SMTP id
 ffacd0b85a97d-367ceacaa2amr6101458f8f.46.1720705774008; 
 Thu, 11 Jul 2024 06:49:34 -0700 (PDT)
Received: from ?IPV6:2a01:cb1e:1b:8b90:ff86:419:29a1:4bd0?
 ([2a01:cb1e:1b:8b90:ff86:419:29a1:4bd0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde8904csm7712079f8f.49.2024.07.11.06.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 06:49:33 -0700 (PDT)
Message-ID: <6391a4a7-f5a6-4a04-b1c6-4eb9336ece10@baylibre.com>
Date: Thu, 11 Jul 2024 15:49:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] bootstd: Add test for bootmeth_android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
References: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
 <20240710-bootmeth-android-v3-5-b99406e22da3@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240710-bootmeth-android-v3-5-b99406e22da3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 10/07/2024 à 10:40, Mattijs Korpershoek a écrit :
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
> $ ./test/py/test.py --bd sandbox --build -k test_ut # build the mmc7.img
> $ ./test/py/test.py --bd sandbox --build -k bootflow_android
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   arch/sandbox/dts/test.dts |  8 +++++
>   configs/sandbox_defconfig |  2 +-
>   test/boot/bootflow.c      | 68 ++++++++++++++++++++++++++++++++++++++--
>   test/py/tests/test_ut.py  | 79 +++++++++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 153 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index a012f5c4c9ba..5fb5eac862ec 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -43,6 +43,7 @@
>   		mmc4 = "/mmc4";
>   		mmc5 = "/mmc5";
>   		mmc6 = "/mmc6";
> +		mmc7 = "/mmc7";
>   		pci0 = &pci0;
>   		pci1 = &pci1;
>   		pci2 = &pci2;
> @@ -1129,6 +1130,13 @@
>   		filename = "mmc6.img";
>   	};
>   
> +	/* This is used for Android tests */
> +	mmc7 {
> +		status = "disabled";
> +		compatible = "sandbox,mmc";
> +		filename = "mmc7.img";
> +	};
> +
>   	pch {
>   		compatible = "sandbox,pch";
>   	};
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index da8c1976d7bd..36e43e0e21ab 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -15,6 +15,7 @@ CONFIG_FIT=y
>   CONFIG_FIT_RSASSA_PSS=y
>   CONFIG_FIT_CIPHER=y
>   CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTMETH_ANDROID=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_MEASURED_BOOT=y
>   CONFIG_BOOTSTAGE=y
> @@ -40,7 +41,6 @@ CONFIG_LOG_MAX_LEVEL=9
>   CONFIG_LOG_DEFAULT_LEVEL=6
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_STACKPROTECTOR=y
> -CONFIG_ANDROID_AB=y
>   CONFIG_CMD_CPU=y
>   CONFIG_CMD_LICENSE=y
>   CONFIG_CMD_SMBIOS=y
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 4511cfa7f9bf..8b46256fa48d 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -27,6 +27,7 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> +extern U_BOOT_DRIVER(bootmeth_android);
>   extern U_BOOT_DRIVER(bootmeth_cros);
>   extern U_BOOT_DRIVER(bootmeth_2script);
>   
> @@ -518,12 +519,12 @@ BOOTSTD_TEST(bootflow_cmd_boot, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
>    * @uts: Unit test state
>    * @mmc_dev: MMC device to use, e.g. "mmc4". Note that this must remain valid
>    *	in the caller until
> - * @bind_cros: true to bind the ChromiumOS bootmeth
> + * @bind_cros: true to bind the ChromiumOS and Android bootmeths
>    * @old_orderp: Returns the original bootdev order, which must be restored
>    * Returns 0 on success, -ve on failure
>    */
>   static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
> -			    bool bind_cros, const char ***old_orderp)
> +			    bool bind_cros_android, const char ***old_orderp)
>   {
>   	static const char *order[] = {"mmc2", "mmc1", NULL, NULL};
>   	struct udevice *dev, *bootstd;
> @@ -545,12 +546,19 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>   				"bootmeth_script", 0, ofnode_null(), &dev));
>   
>   	/* Enable the cros bootmeth if needed */
> -	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros) {
> +	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
>   		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
>   		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
>   					"cros", 0, ofnode_null(), &dev));
>   	}
>   
> +	/* Enable the android bootmeths if needed */
> +	if (IS_ENABLED(CONFIG_BOOTMETH_ANDROID) && bind_cros_android) {
> +		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
> +		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
> +					"android", 0, ofnode_null(), &dev));
> +	}
> +
>   	/* Change the order to include the device */
>   	std = dev_get_priv(bootstd);
>   	old_order = std->bootdev_order;
> @@ -589,6 +597,37 @@ static int scan_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
>   	return 0;
>   }
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
>   /**
>    * scan_mmc4_bootdev() - Set up the mmc4 bootdev so we can access a fake Armbian
>    *
> @@ -1160,3 +1199,26 @@ static int bootflow_cros(struct unit_test_state *uts)
>   	return 0;
>   }
>   BOOTSTD_TEST(bootflow_cros, 0);
> +
> +/* Test Android bootmeth  */
> +static int bootflow_android(struct unit_test_state *uts)
> +{
> +	if (!IS_ENABLED(CONFIG_BOOTMETH_ANDROID))
> +		return -EAGAIN;
> +
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
> index 58205066ec88..05e15830590c 100644
> --- a/test/py/tests/test_ut.py
> +++ b/test/py/tests/test_ut.py
> @@ -11,6 +11,7 @@ import pytest
>   import u_boot_utils
>   # pylint: disable=E0611
>   from tests import fs_helper
> +from test_android import test_abootimg
>   
>   def mkdir_cond(dirname):
>       """Create a directory if it doesn't already exist
> @@ -423,6 +424,83 @@ def setup_cros_image(cons):
>   
>       return fname
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
> +    test_abootimg.AbootimgTestDiskImage(cons, 'bootv4.img', test_abootimg.boot_img_hex)
> +    boot_img = os.path.join(cons.config.result_dir, 'bootv4.img')
> +    with open(boot_img, 'rb') as inf:
> +        set_part_data(2, inf.read())
> +
> +    test_abootimg.AbootimgTestDiskImage(cons, 'vendor_boot.img', test_abootimg.vboot_img_hex)
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
>   def setup_cedit_file(cons):
>       infname = os.path.join(cons.config.source_dir,
> @@ -478,6 +556,7 @@ def test_ut_dm_init_bootstd(u_boot_console):
>       setup_bootmenu_image(u_boot_console)
>       setup_cedit_file(u_boot_console)
>       setup_cros_image(u_boot_console)
> +    setup_android_image(u_boot_console)
>   
>       # Restart so that the new mmc1.img is picked up
>       u_boot_console.restart_uboot()
>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>


