Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 267C6C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 15:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8533A82B70;
	Thu, 12 Jun 2025 17:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NU/AP0Ec";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yKMVzJ0I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B19D82B97; Thu, 12 Jun 2025 17:40:57 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F579828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 17:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bJ6F225fgz9tN3;
 Thu, 12 Jun 2025 17:40:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749742854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZoCJV3LwmEKnPARrmaJsi2+ri70pTutnf+EU95VdnU=;
 b=NU/AP0Ec6if9SqTJ7UOkAQ4pT6cIZpKfc1WELaed7m4BN3bvECPTv+Gz648Wl00AipcqZL
 NMjlD2WhCqe+R/IrOoh5WtDM9V06Z8vgu4ugQznWCZZ9ejlGiMHRJrI+/pKddcCgM6o5kS
 mpM1YaQIf5miNillnwy1CzbJHAJer6bQQwUVvWMQ539LtUmwOG6ahyjpRpOO+43ShKggOw
 srer8/UpkCY7OoR79COJKxOTOBHPKaZjIQo47DjuAzjnwFfBUUJiZNKnXmb7telZK0dIsI
 /nf3QRpTZ3gEgC7DcNPFO5JPDC6SeIp0W/GmD+IInEcoLr7X8IO3tlGYk+gRwg==
Message-ID: <c8748620-afad-410a-8888-195161ca38ab@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1749742852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eZoCJV3LwmEKnPARrmaJsi2+ri70pTutnf+EU95VdnU=;
 b=yKMVzJ0IjBe2n9svy1iFxtIH6lhh6uH+34A9xaB/W+bxi/o2bzl4T8bHS3AilY5NeSDz43
 GGbdo+iXonOlI+BP5q6GSclPUhu9FtlD67QEHxSxy543DOEYR8SvtPGEhqvH0stI2J1AY9
 SOis9Mg+Rie9cHd8DmjyMiQyqFhksw+Zd2bppH7LLncsRjfQyGtnvaT3hURmm0h++dwv49
 G8h5RXIEfujaO0jSyskXh2huqsJrhw7FIfbAlNrSsGHJXXhGFMQrvxPx98bnUkIPGbkQ3f
 sGlxHjk19pqnyTwN9LtgD8OMVC0ynday0/vwf2eAI/izFd0moNVkRyI67OyD7g==
Date: Thu, 12 Jun 2025 17:40:48 +0200
MIME-Version: 1.0
Subject: Re: [U-Boot, v1, 1/1] net: phy: Add the Airoha EN8811H PHY driver
To: "Lucien.Jheng" <lucienzx159@gmail.com>, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, u-boot@lists.denx.de
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com, lucien.jheng@airoha.com, 
 frank-w@public-files.de, daniel@makrotopia.org, ericwouds@gmail.com
References: <20250511051400.29853-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250511051400.29853-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xhbxxzei6kodq4i3kfsod8nt7otwt8cc
X-MBO-RS-ID: 105b3f263136636d757
X-Rspamd-Queue-Id: 4bJ6F225fgz9tN3
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

On 5/11/25 7:14 AM, Lucien.Jheng wrote:
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
> 
> The driver uses two firmware files, for which updated versions are added to
> linux-firmware already.
> 
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via MDIO.
> If need board specific loading override,
> please override the en8811h_read_fw function on board or architecture level.
> 
> Linux upstream AIROHA EN8811H driver commit:
> 71e79430117d56c409c5ea485a263bc0d8083390
> 
> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot sequence.
> and have validated this on Banana Pi BPI-R3 Mini.
> 
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
>   drivers/net/phy/Kconfig       |  43 ++
>   drivers/net/phy/air_en8811h.c | 852 ++++++++++++++++++++++++++++++++++
>   2 files changed, 895 insertions(+)
>   create mode 100644 drivers/net/phy/air_en8811h.c
> 
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 3132718e4f8..384cef845e1 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -79,6 +79,49 @@ config PHY_ADIN
>   	help
>   		Add support for configuring RGMII on Analog Devices ADIN PHYs.
> 
> +menuconfig PHY_AIROHA
> +	bool "Airoha Ethernet PHYs support"
> +
> +config PHY_AIROHA_EN8811H
> +	bool "Airoha Ethernet EN8811H support"
> +	depends on PHY_AIROHA
> +	help
> +		AIROHA EN8811H supported.

Indent of help text is two spaces right of indent of 'help' Kconfig keyword.

> +
> +choice
> +	prompt "Location of the Airoha PHY firmware"
> +	default PHY_AIROHA_FW_IN_MMC
> +	depends on PHY_AIROHA_EN8811H
> +
> +config PHY_AIROHA_FW_IN_MMC
> +	bool "Airoha firmware in MMC partition"
> +	help
> +		Airoha PHYs use firmware which can be loaded automatically
> +		from storage directly attached to the PHY, and then loaded
> +		via MDIO commands by the boot loader. The firmware is loaded
> +		from a file specified by the PHY_AIROHA_FW_PART,
> +		PHY_AIROHA_FW_DM_FILEPATH and PHY_AIROHA_FW_DSP_FILEPATH options.

Indent, fix globally.

[...]

> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c

[...]

> + #define	EN8811H_FW_CTRL_2		0x800000
> + #define	EN8811H_FW_CTRL_2_LOADING	BIT(11)
> +
> + /* MII Registers */
> + #define AIR_AUX_CTRL_STATUS		0x1d
> + #define   AIR_AUX_CTRL_STATUS_SPEED_MASK	GENMASK(4, 2)
> + #define   AIR_AUX_CTRL_STATUS_SPEED_100		0x4
> + #define   AIR_AUX_CTRL_STATUS_SPEED_1000	0x8
> + #define   AIR_AUX_CTRL_STATUS_SPEED_2500	0xc

Please fix indent, and be consistent about it:

#define<space>MACRO_NAME<tab><more tabs as needed>0xvalue

> +#define AIR_EXT_PAGE_ACCESS		0x1f
> +#define   AIR_PHY_PAGE_STANDARD			0x0000
> +#define   AIR_PHY_PAGE_EXTENDED_4		0x0004

[...]

> +int air_phy_restore_page(struct phy_device *phydev, int oldpage, int ret)
> +{
> +	int r;
> +
> +	if (oldpage >= 0) {
> +		r = air_phy_write_page(phydev, oldpage);
> +
> +		if (ret >= 0 && r < 0)
> +			ret = r;
> +	} else {
> +		ret = oldpage;

Invert the conditionals to reduce indent

if (oldpage < 0)
   return oldpage;

r = ...

> +	}
> +
> +	return ret;
> +}
> +
> +static int air_buckpbus_reg_write(struct phy_device *phydev,
> +				  u32 pbus_address, u32 pbus_data)
> +{
> +	int ret, saved_page;
> +
> +	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);
> +
> +	if (saved_page >= 0) {

Invert the conditional (*):

if (saved_page < 0)
   return saved_page; // this is OK, because air_phy_restore_page() will
                      // bail in case saved_page < 0 , see above

...

> +		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_MODE, AIR_BPBUS_MODE_ADDR_FIXED);
> +		if (ret < 0)
> +			goto restore_page;
> +
> +		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_HIGH,
> +				air_upper_16_bits(pbus_address));
> +		if (ret < 0)
> +			goto restore_page;
> +
> +		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_ADDR_LOW,
> +				air_lower_16_bits(pbus_address));
> +		if (ret < 0)
> +			goto restore_page;
> +
> +		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_HIGH,
> +				air_upper_16_bits(pbus_data));
> +		if (ret < 0)
> +			goto restore_page;
> +
> +		ret = phy_write(phydev, MDIO_DEVAD_NONE, AIR_BPBUS_WR_DATA_LOW,
> +				air_lower_16_bits(pbus_data));
> +		if (ret < 0)
> +			goto restore_page;
> +	}
> +
> +restore_page:
> +	if (ret < 0)
> +		printf("%s 0x%08x failed: %d\n", __func__,
> +		       pbus_address, ret);
> +
> +	return air_phy_restore_page(phydev, saved_page, ret);
> +}
> +
> +static int air_buckpbus_reg_read(struct phy_device *phydev,
> +				 u32 pbus_address, u32 *pbus_data)
> +{
> +	int pbus_data_low, pbus_data_high;
> +	int ret = 0, saved_page;
> +
> +	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);

Same change (*) applies here, see above.

> +	if (saved_page >= 0) {


[...]

> +static int air_buckpbus_reg_modify(struct phy_device *phydev,
> +				   u32 pbus_address, u32 mask, u32 set)
> +{
> +	int pbus_data_low, pbus_data_high;
> +	u32 pbus_data_old, pbus_data_new;
> +	int ret = 0, saved_page;
> +
> +	saved_page = air_phy_select_page(phydev, AIR_PHY_PAGE_EXTENDED_4);

Same change (*) applies here, see above, fix globally.

> +	if (saved_page >= 0) {

[...]

> +static void crc32_check(unsigned char *buf, u32 len)
> +{
> +	u32 ca_crc32;
> +
> +	ca_crc32 = crc32(0, buf, len);
> +	printf("crc32 is 0x%x\n", ca_crc32);

Shouldn't this produce some return value , in case the check fails ?

> +}
> +
> +__weak int en8811h_read_fw(void **addr)
> +{
> +	loff_t read;
> +	int ret;
> +
> +	printf("\nLoading Airoha FW from %s %s\n",
> +	       CONFIG_PHY_AIROHA_FW_PART,
> +	       CONFIG_PHY_AIROHA_FW_DM_FILEPATH);

debug() instead of printf() .

> +	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fs_read(CONFIG_PHY_AIROHA_FW_DM_FILEPATH,
> +		      (ulong)*addr, 0, EN8811H_MD32_DM_SIZE, &read);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Calculate the CRC32 */
> +	crc32_check((unsigned char *)*addr, EN8811H_MD32_DM_SIZE);
> +
> +	printf("Loading Airoha FW from %s %s\n",
> +	       CONFIG_PHY_AIROHA_FW_PART,
> +	       CONFIG_PHY_AIROHA_FW_DSP_FILEPATH);
> +	ret = fs_set_blk_dev("mmc", CONFIG_PHY_AIROHA_FW_PART, FS_TYPE_ANY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fs_read(CONFIG_PHY_AIROHA_FW_DSP_FILEPATH,
> +		      (ulong)*addr + EN8811H_MD32_DM_SIZE,
> +		      0, EN8811H_MD32_DSP_SIZE, &read);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Calculate the CRC32 */
> +	crc32_check((unsigned char *)*addr + EN8811H_MD32_DM_SIZE,
> +		    EN8811H_MD32_DSP_SIZE);
> +
> +	printf("Found Airoha Firmware.\n");
> +
> +	return 0;
> +}
> +
> +static int en8811h_load_firmware(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv = phydev->priv;
> +	void *addr = NULL;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {

This conditional should be in en8811h_read_fw() too , the malloc as well 
, so user can completely override the loading and only return a buffer 
with firmware from wherever they loaded it from .

This:

__weak int en8811h_read_fw(void **addr) {
   if (!IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC))
     return -EOPNOTSUPP;

   buffer = malloc();
   ...
   load_the_firmware(buffer);
   ...
   *addr = buffer;
   ...
   return 0;
}

And here:

...
void *buffer;
...
ret = en8811h_read_fw(&buffer);
if (ret)
   return ret;
...

> +		u32 fw_length = EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE;
> +
> +		addr = malloc(fw_length);
> +		if (!addr) {
> +			printf("Failed to allocate memory for firmware\n");
> +			return -ENOMEM;
> +		}
> +
> +		ret = en8811h_read_fw(&addr);
> +		if (ret < 0) {
> +			free(addr);
> +			return ret;

Remove the free() and goto en8811h_load_firmware_out;

> +		}
> +	} else {
> +		puts("EN8811H firmware loading not implemented");
> +		return -EOPNOTSUPP;

Invert the conditional, reduce indent.

> +	}
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +				      EN8811H_FW_CTRL_2_LOADING,
> +				      EN8811H_FW_CTRL_2_LOADING);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DM, EN8811H_MD32_DM_SIZE,
> +			    (unsigned char *)addr);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_write_buf(phydev, AIR_FW_ADDR_DSP, EN8811H_MD32_DSP_SIZE,
> +			    (unsigned char *)addr + EN8811H_MD32_DM_SIZE);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_FW_CTRL_2,
> +				      EN8811H_FW_CTRL_2_LOADING, 0);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_FINISH);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret = en8811h_wait_mcu_ready(phydev);
> +
> +	air_buckpbus_reg_read(phydev, EN8811H_FW_VERSION,
> +			      &priv->firmware_version);
> +	printf("MD32 firmware version: %08x\n",
> +	       priv->firmware_version);
> +
> +en8811h_load_firmware_out:
> +	free(addr);
> +	if (ret < 0)
> +		printf("Firmware loading failed: %d\n", ret);
> +
> +	return ret;
> +}

[...]

> +static int air_leds_init(struct phy_device *phydev, int num, int dur, int mode)
> +{
> +	int ret, i;
> +	struct en8811h_priv *priv = phydev->priv;

Use reverse xmas tree sorting for variables, i.e. 'int ret, i;' goes 
below struct en88... , fix globally.

> +	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, AIR_PHY_LED_DUR_BLINK,
> +			    dur);
> +	if (ret < 0)
> +		return ret;

[...]

> +static int en8811h_config(struct phy_device *phydev)
> +{
> +	ofnode node = phy_get_ofnode(phydev);
> +	struct en8811h_priv *priv = phydev->priv;
> +	int ret = 0;
> +	u32 pbus_value = 0;
> +
> +	/* If restart happened in .probe(), no need to restart now */
> +	if (priv->mcu_needs_restart) {
> +		ret = en8811h_restart_mcu(phydev);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		ret = en8811h_load_firmware(phydev);
> +		if (ret) {
> +			printf("Load firmware fail.\n");
> +			return ret;
> +		}
> +		/* Next calls to .config() mcu needs to restart */
> +		priv->mcu_needs_restart = true;
> +	}
> +
> +	ret = phy_write_mmd(phydev, 0x1e, 0x800c, 0x0);
> +	ret |= phy_write_mmd(phydev, 0x1e, 0x800d, 0x0);
> +	ret |= phy_write_mmd(phydev, 0x1e, 0x800e, 0x1101);
> +	ret |= phy_write_mmd(phydev, 0x1e, 0x800f, 0x0002);

Bitwise operations do not work on signed integers , do proper error 
checking on all four return values above.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Serdes polarity */
> +	pbus_value = 0;
> +	if (ofnode_read_bool(node, "airoha,pnswap-rx"))
> +		pbus_value |=  EN8811H_POLARITY_RX_REVERSE;
> +	else
> +		pbus_value &= ~EN8811H_POLARITY_RX_REVERSE;
> +	if (ofnode_read_bool(node, "airoha,pnswap-tx"))
> +		pbus_value &= ~EN8811H_POLARITY_TX_NORMAL;
> +	else
> +		pbus_value |=  EN8811H_POLARITY_TX_NORMAL;
> +	ret = air_buckpbus_reg_modify(phydev, EN8811H_POLARITY,
> +				      EN8811H_POLARITY_RX_REVERSE |
> +				      EN8811H_POLARITY_TX_NORMAL, pbus_value);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> +			    AIR_LED_MODE_USER_DEFINE);
> +	if (ret < 0) {
> +		printf("Failed to disable leds: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[...]

-- 
Best regards,
Marek Vasut
