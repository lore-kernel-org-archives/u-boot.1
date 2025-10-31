Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3578CCCF9F8
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:41:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4B583993;
	Fri, 31 Oct 2025 16:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386438399D; Fri, 31 Oct 2025 16:41:36 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975618397A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98.2) (envelope-from <daniel@makrotopia.org>)
 id 1vErFo-000000004W7-1bQ5; Fri, 31 Oct 2025 15:41:28 +0000
Date: Fri, 31 Oct 2025 15:41:19 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Beiyan Yun <root@infi.wang>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
Message-ID: <aQTYn1wbwXXXnlT6@makrotopia.org>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031152348.60571-6-root@infi.wang>
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

On Fri, Oct 31, 2025 at 11:21:07PM +0800, Beiyan Yun wrote:
> Aquantia PHYs are being used w/o SPI flash in some routers recently.
> Current firmware loader only attempts to load from FS on top of MMC,
> limiting the use on many devices.
> 
> Removed the old firmware loader, migrate to generic firmware loader to
> allow a wider range and runtime override of firmware source. (e.g., USB).
> 
> Tested on Buffalo WXR18000BE10P with UBIFS.

Does the Buffalo WXR18000BE10P use UBIFS as rootfs out-of-the-box, and
include the Aquatia firmware there?

I'm asking because most of the devices supported in OpenWrt don't use
UBIFS on UBI but typically use a squashfs volume, or even a squashfs
filesystem or cpio.gz embedded into the uImage.FIT which is stored
directly on a UBI volume (and not as a file within UBIFS).

Hence it would be crucial to make sure that using
request_firmware_into_buf_via_script()
works for those devices which do not store the firmware on a filesystem
which is directly accessible within U-Boot.
Imho that's also better than using a __weak symbol as it would allow
implementing the board-specific method for acquiring the firmware as a
script rather than having to write C code for each board.

> 
> Signed-off-by: Beiyan Yun <root@infi.wang>
> ---
> 
> Changes in v4:
> - Split firmware upload helpers change
> - Reorder `aquantia_read_fw`
> - Make `aquantia_read_fw` weak to allow overide
> - Rename exit label in `aquantia_read_fw`
> - Kconfig polish
> 
> Changes in v3:
> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
> 
> Changes in v2:
> - Add support for script based loader
> 
>  drivers/net/phy/Kconfig    |  28 +++++----
>  drivers/net/phy/aquantia.c | 122 ++++++++++++++++++++++---------------
>  2 files changed, 91 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 018be98705a..4a74a0d4e8c 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -1,4 +1,3 @@
> -
>  config BITBANGMII
>  	bool "Bit-banged ethernet MII management channel support"
>  
> @@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
>  config PHY_AQUANTIA_UPLOAD_FW
>  	bool "Aquantia firmware loading support"
>  	depends on PHY_AQUANTIA
> +	select FS_LOADER
> +	select FW_LOADER
>  	help
> -		Aquantia PHYs use firmware which can be either loaded automatically
> -		from storage directly attached to the phy or loaded by the boot loader
> -		via MDIO commands.  The firmware is loaded from a file, specified by
> -		the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME options.
> +	  Aquantia PHYs use firmware which can be either loaded automatically
> +	  from storage directly attached to the phy or loaded by the boot loader
> +	  via MDIO commands.
> +
> +	  This option enables loading the firmware using the generic
> +	  firmware loader framework.
>  
> -config PHY_AQUANTIA_FW_PART
> -	string "Aquantia firmware partition"
> +config PHY_AQUANTIA_FW_MAX_SIZE
> +	hex "Max firmware size"
>  	depends on PHY_AQUANTIA_UPLOAD_FW
> +	default 0x80000
>  	help
> -		Partition containing the firmware file.
> +	  The maximum size of the Aquantia PHY firmware. This is used to
> +	  allocate a buffer to load the firmware into.
>  
> -config PHY_AQUANTIA_FW_NAME
> -	string "Aquantia firmware filename"
> +config PHY_AQUANTIA_FW_LOADER_SCRIPT
> +	string "Aquantia firmware loader script"
>  	depends on PHY_AQUANTIA_UPLOAD_FW
> +	default "aqr_phy_load_firmware"
>  	help
> -		Firmware filename.
> +	  The firmware loading script variable name.
>  
>  config PHY_ATHEROS
>  	bool "Atheros Ethernet PHYs support"
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index 461d4b07a40..934bd17eadd 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -17,6 +17,10 @@
>  #include <malloc.h>
>  #include <asm/byteorder.h>
>  #include <fs.h>
> +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
> +#include <fs_loader.h>
> +#include <fw_loader.h>
> +#endif
>  
>  #define AQUNTIA_10G_CTL 0x20
>  #define AQUNTIA_VENDOR_P1 0xc400
> @@ -127,51 +131,67 @@ struct fw_header {
>  
>  #pragma pack()
>  
> -#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
> -static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
> +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
> +int __weak aquantia_read_fw(struct phy_device *phydev, u8 **fw_addr,
> +			    size_t *fw_length)
>  {
> -	loff_t length, read;
>  	int ret;
> -	void *addr = NULL;
> -
> -	*fw_addr = NULL;
> -	*fw_length = 0;
> -	debug("Loading Aquantia microcode from %s %s\n",
> -	      CONFIG_PHY_AQUANTIA_FW_PART, CONFIG_PHY_AQUANTIA_FW_NAME);
> -	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART, FS_TYPE_ANY);
> -	if (ret < 0)
> -		goto cleanup;
> -
> -	ret = fs_size(CONFIG_PHY_AQUANTIA_FW_NAME, &length);
> -	if (ret < 0)
> -		goto cleanup;
> -
> -	addr = malloc(length);
> -	if (!addr) {
> -		ret = -ENOMEM;
> -		goto cleanup;
> +	ofnode node;
> +	struct udevice *loader_dev;
> +	const char *fw_name;
> +	u8 *tmp_fw_addr;
> +	size_t tmp_fw_length;
> +
> +	tmp_fw_addr = malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
> +	if (!tmp_fw_addr) {
> +		printf("Failed to allocate memory for firmware\n");
> +		return -ENOMEM;
>  	}
>  
> -	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART, FS_TYPE_ANY);
> -	if (ret < 0)
> -		goto cleanup;
> -
> -	ret = fs_read(CONFIG_PHY_AQUANTIA_FW_NAME, (ulong)addr, 0, length,
> -		      &read);
> -	if (ret < 0)
> -		goto cleanup;
> -
> -	*fw_addr = addr;
> -	*fw_length = length;
> -	debug("Found Aquantia microcode.\n");
> -
> -cleanup:
> -	if (ret < 0) {
> -		printf("loading firmware file %s %s failed with error %d\n",
> -		       CONFIG_PHY_AQUANTIA_FW_PART, CONFIG_PHY_AQUANTIA_FW_NAME,
> -		       ret);
> -		free(addr);
> +	/* First, try to load firmware via script */
> +	ret = request_firmware_into_buf_via_script(
> +		tmp_fw_addr, CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
> +		CONFIG_PHY_AQUANTIA_FW_LOADER_SCRIPT, &tmp_fw_length);
> +	if (ret) {
> +		/* Fallback to DT specified firmware */
> +		node = phy_get_ofnode(phydev);
> +		if (!ofnode_valid(node)) {
> +			printf("Failed to get PHY node\n");
> +			ret = -EINVAL;
> +			goto fail_free;
> +		}
> +
> +		fw_name = ofnode_read_string(node, "firmware-name");
> +		if (!fw_name) {
> +			printf("Failed to get firmware name\n");
> +			ret = -ENOENT;
> +			goto fail_free;
> +		}
> +
> +		ret = get_fs_loader(&loader_dev);
> +		if (ret) {
> +			printf("Failed to get fs_loader instance: %d\n", ret);
> +			goto fail_free;
> +		}
> +
> +		ret = request_firmware_into_buf(loader_dev, fw_name,
> +						tmp_fw_addr,
> +						CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
> +						0);
> +		if (ret < 0) {
> +			printf("Failed to load firmware %s: %d\n", fw_name,
> +			       ret);
> +			goto fail_free;
> +		}
> +		tmp_fw_length = ret;
>  	}
> +
> +	*fw_addr = tmp_fw_addr;
> +	*fw_length = tmp_fw_length;
> +	return 1;
> +
> +fail_free:
> +	free(tmp_fw_addr);
>  	return ret;
>  }
>  
> @@ -227,6 +247,11 @@ static int aquantia_do_upload_firmware(struct phy_device *phydev,
>  	u32 primary_offset, iram_offset, iram_size, dram_offset, dram_size;
>  	const struct fw_header *header;
>  
> +	if (!addr || !fw_length) {
> +		printf("%s: Invalid firmware data\n", phydev->dev->name);
> +		return -EINVAL;
> +	}
> +
>  	read_crc = (addr[fw_length - 2] << 8) | addr[fw_length - 1];
>  	calculated_crc = crc16_ccitt(0, addr, fw_length - 2);
>  	if (read_crc != calculated_crc) {
> @@ -290,17 +315,18 @@ static int aquantia_do_upload_firmware(struct phy_device *phydev,
>  
>  static int aquantia_upload_firmware(struct phy_device *phydev)
>  {
> -	int ret;
> -	u8 *addr = NULL;
> -	size_t fw_length = 0;
> +	int ret, fwrc;
> +	u8 *fw_addr = NULL;
> +	size_t fw_length;
>  
> -	ret = aquantia_read_fw(&addr, &fw_length);
> -	if (ret != 0)
> -		return ret;
> +	fwrc = aquantia_read_fw(phydev, &fw_addr, &fw_length);
> +	if (fwrc < 0)
> +		return fwrc;
>  
> -	ret = aquantia_do_upload_firmware(phydev, addr, fw_length);
> +	ret = aquantia_do_upload_firmware(phydev, fw_addr, fw_length);
>  
> -	free(addr);
> +	if (fwrc > 0)
> +		free(fw_addr);
>  
>  	return ret;
>  }
> -- 
> 2.47.3
> 
