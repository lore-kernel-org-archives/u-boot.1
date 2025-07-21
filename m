Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CB1C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 15:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB33831C2;
	Mon, 21 Jul 2025 17:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="RsdXnoLi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF8D831D3; Mon, 21 Jul 2025 17:26:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB02831B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 17:26:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1753111570; x=1753716370; i=frank-w@public-files.de;
 bh=28cfsAG6UNC2nY7QS3ugT7lCcXaDVSlYp7TK9T8RDdQ=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=RsdXnoLiw0cnSvR0bVxYzd/64xjX2YKm5Cb0+rSxQvuJUBobZb9oVdKsEfuJFXwG
 Zeyiu6q0iH6IR1bxQ398P3fM82ktK1JumYpHbJZnnZZ3mfOwgCitTqaX05e8q/bDH
 CrEhnEloHrIk3ccNshPzVX/sk+MQboBxN5/EKF27XSW41jBk74KzkX6CBVQ2O9yMg
 VZ2gidTcPoDsriCVOFG6MHdc/OW3f2Ibyo2oPZFIRFry1hfAFqxCNgilV/DjFk5UR
 ZJqemgTg+lg9oIMOUXfpAURoJeXyrMPdqf8ZHfzTN3yD1SPqDBjMrGSXbu/ofnmit
 w4tIXjsJPVve6eVI5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [100.70.41.131] ([100.70.41.131]) by
 trinity-msg-rest-gmx-gmx-live-7b4f7c955b-vd6nb (via HTTP); Mon, 21 Jul 2025
 15:26:10 +0000
MIME-Version: 1.0
Message-ID: <trinity-ffcccc9c-109f-403d-aae9-e1309d08c2b3-1753111569975@trinity-msg-rest-gmx-gmx-live-7b4f7c955b-vd6nb>
From: frank-w@public-files.de
To: lucienzx159@gmail.com, ilias.apalodimas@linaro.org,
 jerome.forissier@linaro.org, marek.vasut+renesas@mailbox.org,
 paul.barker.ct@bp.renesas.com, pbrobinson@gmail.com, lucienzx159@gmail.com,
 u-boot@lists.denx.de, trini@konsulko.com
Cc: joseph.lin@airoha.com, wenshin.chung@airoha.com,
 lucien.jheng@airoha.com, daniel@makrotopia.org, ericwouds@gmail.com,
 albert-al.lee@airoha.com
Subject: Aw: [U-Boot, v3, 1/1]net: phy: Add the Airoha EN8811H PHY driver
Content-Type: text/plain; charset=UTF-8
Importance: normal
Date: Mon, 21 Jul 2025 15:26:10 +0000
Sensitivity: Normal
In-Reply-To: <20250720122852.22563-1-lucienzx159@gmail.com>
References: <20250720122852.22563-1-lucienzx159@gmail.com>
X-Priority: 3
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:zB0JIra99c0UmePIwYJC5abM3ZEncBYgQHwd+yWXn734ZwPG+DLq9+sDlLXD6SdlBGoFW
 JjQphdUctzQS5UcvK4aVD+ULdINcPTDJmvcpU5LLKkLvi1Myn+7CCrC/w8+T6NmQEkrgD78KyfeZ
 8CS1240C0YnPIeMfK2MS9Mnoa5htEsvYq/XvGIXJoRiDxwrcz6RvbfOKIHmJVufELLEpz+2tpqjd
 vnqTMweceZlDRJDr7hn/rSQTEWQL9K0FYvt+M5rplFi4T7gt9gki2lhdqg0Xjnk+LL9Vns9wU0M4
 O0ACWJeZ9G9ibVs8pe3AGlwacZfzOvgKFgKJmJc4i/RmTu+6ehuu1UNXVe7lmK0hoA=
UI-OutboundReport: notjunk:1;M01:P0:W6iQ0uT1sgU=;xWqToOodRxDXzZpQPyXYGb/Q5fl
 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
 A+4ESxc7oNCzc=
Content-Transfer-Encoding: quoted-printable
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

Hi

> Gesendet: Sonntag, 20. Juli 2025 um 14:28
> Von: "Lucien.Jheng" <lucienzx159@gmail.com>
> Betreff: [U-Boot, v3, 1/1]net: phy: Add the Airoha EN8811H PHY driver
>
> Add the driver for the Airoha EN8811H 2.5 Gigabit PHY. The PHY supports
> 100/1000/2500 Mbps with auto negotiation only.
>=20
> The driver uses two firmware files, for which updated versions are added=
 to
> linux-firmware already.
>=20
> Locating the AIROHA FW within the filesystem at the designated partition
> and path will trigger its automatic loading and writing to the PHY via M=
DIO.
> If need board specific loading override,
> please override the en8811h_read_fw function on board or architecture le=
vel.
>=20
> Linux upstream AIROHA EN8811H driver commit:
> 71e79430117d56c409c5ea485a263bc0d8083390
>=20
> Based on the Linux upstream AIROHA EN8811H driver code(air_en8811h.c),
> I have modified the relevant process to align with the U-Boot boot seque=
nce.
> and have validated this on Banana Pi BPI-R3 Mini.
>=20
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> ---
> Change in PATCH v3:
> air_en8811h.c:
>  * Add U-Boot environment variable(en8811h_fw_part, en8811h_fw_dm_dir, e=
n8811h_fw_dsp_dir)
>    support for firmware loading.

Thank you lucien for taking care of this driver...

>  drivers/net/phy/Kconfig       |  25 +
>  drivers/net/phy/Makefile      |   1 +
>  drivers/net/phy/air_en8811h.c | 880 ++++++++++++++++++++++++++++++++++
>  3 files changed, 906 insertions(+)
>  create mode 100644 drivers/net/phy/air_en8811h.c
>=20
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 8d88c142900..9f12238e1ea 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -79,6 +79,31 @@ config PHY_ADIN
>  	help
>  		Add support for configuring RGMII on Analog Devices ADIN PHYs.
>=20
> +menuconfig PHY_AIROHA
> +	bool "Airoha Ethernet PHYs support"
> +
> +config PHY_AIROHA_EN8811H
> +	bool "Airoha Ethernet EN8811H support"
> +	depends on PHY_AIROHA
> +	help
> +	  AIROHA EN8811H supported.
> +
> +choice
> +	prompt "Location of the Airoha PHY firmware"
> +	default PHY_AIROHA_FW_IN_MMC
> +	depends on PHY_AIROHA_EN8811H
> +
> +config PHY_AIROHA_FW_IN_MMC
> +	bool "Airoha firmware in MMC partition"
> +	help
> +	  Airoha PHYs use firmware which can be loaded automatically
> +	  from storage directly attached to the PHY, and then loaded
> +	  via MDIO commands by the boot loader. The firmware is loaded
> +	  from a file specified by the U-Boot environment variables
> +	  en8811h_fw_part, en8811h_fw_dm_dir, and en8811h_fw_dsp_dir.

maybe something like PHY_AIROHA_FW_IN_SUBSYSTEM =3D (MMC/USB/NVME/...) as =
choice? or better PHY_AIROHA_FW_BY_ENV and then check env-var with default=
 "mmc" for maximum on flexibility without recompile.

> +endchoice
> +
>  menuconfig PHY_AQUANTIA
>  	bool "Aquantia Ethernet PHYs support"
>  	select PHY_GIGE
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h=
.c
> new file mode 100644
> index 00000000000..1020b6d75b2
> --- /dev/null
> +++ b/drivers/net/phy/air_en8811h.c
...
> +__weak int en8811h_read_fw(void **addr)
> +{
> +	const char *fw_dm, *fw_dsp, *fw_part;
> +	u32 ca_crc32;
> +	void *buffer;
> +	loff_t read;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC))
> +		return -EOPNOTSUPP;
> +
> +	/* Allocate memory to store both DM and DSP firmware */
> +	buffer =3D malloc(EN8811H_MD32_DM_SIZE + EN8811H_MD32_DSP_SIZE);
> +	if (!buffer) {
> +		printf("Failed to allocate memory for firmware\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Get the partition name where the firmware is stored */
> +	fw_part =3D env_get("en8811h_fw_part");
> +	if (!fw_part) {
> +		printf("Error: env var en8811h_fw_part not set.\n");
> +		return -EINVAL;
> +	}

this could include non mmc partitions, e.g. usb,nvme to be more generic (m=
aybe separate var).
CONFIG-option of course needs to have different name.

> +	/* Get the DM firmware file path */
> +	fw_dm =3D env_get("en8811h_fw_dm_dir");
> +	if (!fw_dm) {
> +		printf("Error: env var en8811h_fw_dm_dir not set.\n");
> +		return -EINVAL;
> +	}

imho path could be separated from filename. Filename and Directory (which =
is mostly same for both files) could be hardcoded,
maybe as fallback if vars are not set, to same value as on linux. So users=
 have only point to device and partition.

so default for dir: /lib/firmware/airoha
filenames: EthMD32.dm.bin and EthMD32.DSP.bin

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.gi=
t/tree/airoha

linux driver only defines subpath, but imho on most systems this is below =
/lib/firmware in rootfs

https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/net/phy/air_en88=
11h.c#L23

if i define as dir only /lib/firmware and the airoha-path with filename ge=
ts expanded by driver, it will be ok for me,=20
but imho it makes it harder to verify path is set or not and if airoha nee=
ds to be added or not. So i would use full
path, but default to linux default.

> +	/* Get the DSP firmware file path */
> +	fw_dsp =3D env_get("en8811h_fw_dsp_dir");
> +	if (!fw_dsp) {
> +		printf("Error: env var en8811h_fw_dsp_dir not set.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Load DM firmware */
> +	ret =3D fs_set_blk_dev("mmc", fw_part, FS_TYPE_ANY);

this could use a subsystem env-var (with default mmc maybe) to support usb=
/nvme too.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Read DM firmware file into the start of buffer */
> +	ret =3D fs_read(fw_dm, (ulong)buffer, 0, EN8811H_MD32_DM_SIZE, &read);
> +	if (ret < 0) {
> +		printf("Failed to read DM firmware: %s\n", fw_dm);
> +		return ret;
> +	}
> +
> +	/* Calculate CRC32 of DM firmware for verification */
> +	ca_crc32 =3D crc32(0, (unsigned char *)buffer, EN8811H_MD32_DM_SIZE);
> +	debug("DM crc32: 0x%x\n", ca_crc32);
> +
> +	/* Load DSP firmware */
> +	ret =3D fs_set_blk_dev("mmc", fw_part, FS_TYPE_ANY);
> +	if (ret < 0)
> +		return ret;

same here for subsystem and part

> +	/* Read DSP firmware file into buffer after DM section */
> +	ret =3D fs_read(fw_dsp, (ulong)buffer + EN8811H_MD32_DM_SIZE, 0,
> +		EN8811H_MD32_DSP_SIZE, &read);
> +	if (ret < 0) {
> +		printf("Failed to read DSP firmware: %s\n", fw_dsp);
> +		return ret;
> +	}
> +
> +	/* Calculate CRC32 of DSP firmware for verification */
> +	ca_crc32 =3D crc32(0, (unsigned char *)buffer + EN8811H_MD32_DM_SIZE,
> +		EN8811H_MD32_DSP_SIZE);
> +	debug("DSP crc32: 0x%x\n", ca_crc32);
> +
> +	*addr =3D buffer;
> +	debug("Found Airoha Firmware.\n");
> +
> +	return 0;
> +}
> +
> +static int en8811h_load_firmware(struct phy_device *phydev)
> +{
> +	struct en8811h_priv *priv =3D phydev->priv;
> +	void *buffer;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_PHY_AIROHA_FW_IN_MMC)) {
> +		printf("Airoha EN8811H firmware loading not implemented\n");
> +		return -EOPNOTSUPP;
> +	}

this check is redundant in en8811h_read_fw which call follows, so imho thi=
s could be dropped here, maybe put printf in en8811h_read_fw.

> +	ret =3D en8811h_read_fw(&buffer);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +
> +	ret =3D air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
> +				     EN8811H_FW_CTRL_1_START);
> +	if (ret < 0)
> +		goto en8811h_load_firmware_out;
> +

regards Frank
