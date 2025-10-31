Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4A1CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 16:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22145839D9;
	Fri, 31 Oct 2025 17:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="PPpWIy5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6F76839DF; Fri, 31 Oct 2025 17:11:46 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster2-host4-snip4-10.eps.apple.com [57.103.64.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3B668394A
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 17:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-7 (Postfix) with ESMTPS id
 9D7D7180335C; Fri, 31 Oct 2025 16:11:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=wJMOuFOJ+5UWeLzkpWz1h6hXUub9moW4QKKoUEFQd+A=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=PPpWIy5RHF3h1EN9ua042M9Sp6i9Yz5HsurtT1vfhhzU9Keh5BV9tAcyX3GRkReUixwQWtYxDCdNCXldrOh5E8Qu94mMcbNddx91ihF6C1ZZQ01a5aFHtF+hMbDwDST8Nl8/WEYsaKOsGJwcWRZevGdl9XGrBsCVrpDq7r7B2+jKmyjxLQlPYZ6GO3MnUJZ4yf4AoK7sO66Y7RrgjQetKOJ7rUyJajpuxzqepND2fXN6aaXYu86R4gBSDdD+AodvAsR9a6CHqkWZZmraejdtHfUf54vdw/rI8HgSAcUTt6lBcSZTwHVP9ElOyLFqVUzP7varYBCCiQwa2vKA5HWDCw==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-7 (Postfix) with ESMTPSA id
 767661804D73; Fri, 31 Oct 2025 16:10:09 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <5C422BCB-7BE6-42BF-B828-993ECBC6D055@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4 5/5] net: phy: aquantia: use generic firmware loader
Date: Sat, 1 Nov 2025 00:09:56 +0800
In-Reply-To: <aQTYn1wbwXXXnlT6@makrotopia.org>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Weijie Gao <weijie.gao@mediatek.com>
To: Daniel Golle <daniel@makrotopia.org>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-6-root@infi.wang> <aQTYn1wbwXXXnlT6@makrotopia.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-GUID: aM5LdORGnyk3aCvZPCnnsgpH7anrdday
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0NSBTYWx0ZWRfX3HDPLDcrJ4nE
 Lpmi8NyXK4Ub70lIHNeRgmyjVHwvpYYFV502R2eFM39XMOBlipS7v7E2huo9Ao+SS2brsLZ7kmA
 yTw+XY66D31xgjfCaPmbo5dpFP4DG/eLvsrqBYhZAA8y81VZw0SiaHejgUiR9VfqUssZYyuuXYm
 bZV0RggnZd5W77kiPxRAvcfImTsbgSTCDN7aZICgGuszjTJPQxHFnGm+ybsXG5bb4mtFA+HS7Vr
 VCSz8XyEBm9YgRCRpUgjiY9fjKRdEqaxNvpF/Qbej1Miq1K/24pNzRWRlt6wh1xd8KW2WsoP4=
X-Proofpoint-ORIG-GUID: aM5LdORGnyk3aCvZPCnnsgpH7anrdday
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2510310145
X-JNJ: AAAAAAAB0t0MP+RXx+gjn07nZ+mprFhrXxv+CnzRWnapJj+DwvRQphaVMquj5j2wP3XODSJorU1myBs8gImLHA4ol/jj0DVnTg/FFGafrwEZMBNHBrv31xtiQBVbqmZi3ecvyjkQxkmA56YsbS344ov0ID+X1Fc8qNQnSsOb/hWFlheE1p8RNe5Jwd7vuGixs07NqFdzyqRCluSzt3oHo3vStfN0AsomfRje8ufldFrN9mTYKsj1wpSObE8tSBkI/9hJNi5ALQY9+MSFV0ESgy+3l3xJ9dC/6rfCq/Uydd+68/7aHCC1cuaqcg5PwT6zxD79SvecuRPmVQaUVY6oMhXsD2TknktJgPzyjJhH6UI9LQ9CowpScxUNp7IAlQXMx+/sjSvAb4Pwy8/5OhhBcIN9E+UAlcZp4Op18TANjX+VYS7NY3f0PvR0mtslXziimDdT1iZKfULZXvdKHFvbX0qoOCfALRxT7oxrm+8iLY5NmUdkkmhQWV4VrFOSr9D+NpJVIwCQ+FLCHz9Uhip6Pa880ce8lV0G5YB+dOJRS6KhcgEfrPULZvIef9Wb07V4OCRLwUcgic16jcA1vjdy7m6jCTe8TetO+A45EN2t4lr1pjg2gf0/Yi88aaFd5jykqKiXgbe4KA8FFwXvonGFov2oADCM+8CO4Qc5Bo8D5suPC68lRCtCUU5mzqClW5y85lnftpAXmoLfW96CylmfyYNpRLM57EAqxFkvYfF4QAN4fCCcb06ok2euXhlmyLvWV6QgE6HthPKrO6/DMH2Wn3XxDxmRi/ktCNp75boVyRdnK42T5SO/0+iJeTzvrIkDs13Rvd5wMBYjFrjeD88ePPOEsVkE
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Daniel,

> On 31 Oct 2025, at 11:41=E2=80=AFPM, Daniel Golle =
<daniel@makrotopia.org> wrote:
>=20
> On Fri, Oct 31, 2025 at 11:21:07PM +0800, Beiyan Yun wrote:
>> Aquantia PHYs are being used w/o SPI flash in some routers recently.
>> Current firmware loader only attempts to load from FS on top of MMC,
>> limiting the use on many devices.
>>=20
>> Removed the old firmware loader, migrate to generic firmware loader =
to
>> allow a wider range and runtime override of firmware source. (e.g., =
USB).
>>=20
>> Tested on Buffalo WXR18000BE10P with UBIFS.
>=20
> Does the Buffalo WXR18000BE10P use UBIFS as rootfs out-of-the-box, and
> include the Aquatia firmware there?
>=20
No, it=E2=80=99s part of my WIP porting and ubootmod, as a) vendor =
layout is (unfortunately) UBI on NMBM, and b) for some hardware and/or =
Linux quirks I can=E2=80=99t make one of the two CUX3410 work without a =
soft PHY reset. Bring it up in U-Boot not only solves this, but also =
gives us two more usable port in U-Boot as a bonus.

I opened a OpenWrt forum thread at =
https://forum.openwrt.org/t/adding-support-for-buffalo-wxr18000be10p-media=
tek-mt7988a/239795 if you=E2=80=99re interested.

> I'm asking because most of the devices supported in OpenWrt don't use
> UBIFS on UBI but typically use a squashfs volume, or even a squashfs
> filesystem or cpio.gz embedded into the uImage.FIT which is stored
> directly on a UBI volume (and not as a file within UBIFS).
>=20
I agree, UBIFS here is more about PoC, and a single `firmware` UBI part =
is comparable to similar implementation like some Airoha board's =
`en8811-fw`. We might read from overlay, though that could be too =
complicated in U-Boot?

> Hence it would be crucial to make sure that using
> request_firmware_into_buf_via_script()
> works for those devices which do not store the firmware on a =
filesystem
> which is directly accessible within U-Boot.
> Imho that's also better than using a __weak symbol as it would allow
> implementing the board-specific method for acquiring the firmware as a
> script rather than having to write C code for each board.
>=20

FW_LOADER support (request_firmware_into_buf_via_script) is available =
since patch v2 ;)

>>=20
>> Signed-off-by: Beiyan Yun <root@infi.wang>
>> ---
>>=20
>> Changes in v4:
>> - Split firmware upload helpers change
>> - Reorder `aquantia_read_fw`
>> - Make `aquantia_read_fw` weak to allow overide
>> - Rename exit label in `aquantia_read_fw`
>> - Kconfig polish
>>=20
>> Changes in v3:
>> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>>=20
>> Changes in v2:
>> - Add support for script based loader
>>=20
>> drivers/net/phy/Kconfig    |  28 +++++----
>> drivers/net/phy/aquantia.c | 122 =
++++++++++++++++++++++---------------
>> 2 files changed, 91 insertions(+), 59 deletions(-)
>>=20
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 018be98705a..4a74a0d4e8c 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -1,4 +1,3 @@
>> -
>> config BITBANGMII
>> 	bool "Bit-banged ethernet MII management channel support"
>>=20
>> @@ -91,23 +90,30 @@ menuconfig PHY_AQUANTIA
>> config PHY_AQUANTIA_UPLOAD_FW
>> 	bool "Aquantia firmware loading support"
>> 	depends on PHY_AQUANTIA
>> +	select FS_LOADER
>> +	select FW_LOADER
>> 	help
>> -		Aquantia PHYs use firmware which can be either loaded =
automatically
>> -		from storage directly attached to the phy or loaded by =
the boot loader
>> -		via MDIO commands.  The firmware is loaded from a file, =
specified by
>> -		the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME =
options.
>> +	  Aquantia PHYs use firmware which can be either loaded =
automatically
>> +	  from storage directly attached to the phy or loaded by the =
boot loader
>> +	  via MDIO commands.
>> +
>> +	  This option enables loading the firmware using the generic
>> +	  firmware loader framework.
>>=20
>> -config PHY_AQUANTIA_FW_PART
>> -	string "Aquantia firmware partition"
>> +config PHY_AQUANTIA_FW_MAX_SIZE
>> +	hex "Max firmware size"
>> 	depends on PHY_AQUANTIA_UPLOAD_FW
>> +	default 0x80000
>> 	help
>> -		Partition containing the firmware file.
>> +	  The maximum size of the Aquantia PHY firmware. This is used to
>> +	  allocate a buffer to load the firmware into.
>>=20
>> -config PHY_AQUANTIA_FW_NAME
>> -	string "Aquantia firmware filename"
>> +config PHY_AQUANTIA_FW_LOADER_SCRIPT
>> +	string "Aquantia firmware loader script"
>> 	depends on PHY_AQUANTIA_UPLOAD_FW
>> +	default "aqr_phy_load_firmware"
>> 	help
>> -		Firmware filename.
>> +	  The firmware loading script variable name.
>>=20
>> config PHY_ATHEROS
>> 	bool "Atheros Ethernet PHYs support"
>> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
>> index 461d4b07a40..934bd17eadd 100644
>> --- a/drivers/net/phy/aquantia.c
>> +++ b/drivers/net/phy/aquantia.c
>> @@ -17,6 +17,10 @@
>> #include <malloc.h>
>> #include <asm/byteorder.h>
>> #include <fs.h>
>> +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
>> +#include <fs_loader.h>
>> +#include <fw_loader.h>
>> +#endif
>>=20
>> #define AQUNTIA_10G_CTL 0x20
>> #define AQUNTIA_VENDOR_P1 0xc400
>> @@ -127,51 +131,67 @@ struct fw_header {
>>=20
>> #pragma pack()
>>=20
>> -#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
>> -static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
>> +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
>> +int __weak aquantia_read_fw(struct phy_device *phydev, u8 **fw_addr,
>> +			    size_t *fw_length)
>> {
>> -	loff_t length, read;
>> 	int ret;
>> -	void *addr =3D NULL;
>> -
>> -	*fw_addr =3D NULL;
>> -	*fw_length =3D 0;
>> -	debug("Loading Aquantia microcode from %s %s\n",
>> -	      CONFIG_PHY_AQUANTIA_FW_PART, CONFIG_PHY_AQUANTIA_FW_NAME);
>> -	ret =3D fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART, =
FS_TYPE_ANY);
>> -	if (ret < 0)
>> -		goto cleanup;
>> -
>> -	ret =3D fs_size(CONFIG_PHY_AQUANTIA_FW_NAME, &length);
>> -	if (ret < 0)
>> -		goto cleanup;
>> -
>> -	addr =3D malloc(length);
>> -	if (!addr) {
>> -		ret =3D -ENOMEM;
>> -		goto cleanup;
>> +	ofnode node;
>> +	struct udevice *loader_dev;
>> +	const char *fw_name;
>> +	u8 *tmp_fw_addr;
>> +	size_t tmp_fw_length;
>> +
>> +	tmp_fw_addr =3D malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
>> +	if (!tmp_fw_addr) {
>> +		printf("Failed to allocate memory for firmware\n");
>> +		return -ENOMEM;
>> 	}
>>=20
>> -	ret =3D fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART, =
FS_TYPE_ANY);
>> -	if (ret < 0)
>> -		goto cleanup;
>> -
>> -	ret =3D fs_read(CONFIG_PHY_AQUANTIA_FW_NAME, (ulong)addr, 0, =
length,
>> -		      &read);
>> -	if (ret < 0)
>> -		goto cleanup;
>> -
>> -	*fw_addr =3D addr;
>> -	*fw_length =3D length;
>> -	debug("Found Aquantia microcode.\n");
>> -
>> -cleanup:
>> -	if (ret < 0) {
>> -		printf("loading firmware file %s %s failed with error =
%d\n",
>> -		       CONFIG_PHY_AQUANTIA_FW_PART, =
CONFIG_PHY_AQUANTIA_FW_NAME,
>> -		       ret);
>> -		free(addr);
>> +	/* First, try to load firmware via script */
>> +	ret =3D request_firmware_into_buf_via_script(
>> +		tmp_fw_addr, CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
>> +		CONFIG_PHY_AQUANTIA_FW_LOADER_SCRIPT, &tmp_fw_length);
>> +	if (ret) {
>> +		/* Fallback to DT specified firmware */
>> +		node =3D phy_get_ofnode(phydev);
>> +		if (!ofnode_valid(node)) {
>> +			printf("Failed to get PHY node\n");
>> +			ret =3D -EINVAL;
>> +			goto fail_free;
>> +		}
>> +
>> +		fw_name =3D ofnode_read_string(node, "firmware-name");
>> +		if (!fw_name) {
>> +			printf("Failed to get firmware name\n");
>> +			ret =3D -ENOENT;
>> +			goto fail_free;
>> +		}
>> +
>> +		ret =3D get_fs_loader(&loader_dev);
>> +		if (ret) {
>> +			printf("Failed to get fs_loader instance: %d\n", =
ret);
>> +			goto fail_free;
>> +		}
>> +
>> +		ret =3D request_firmware_into_buf(loader_dev, fw_name,
>> +						tmp_fw_addr,
>> +						=
CONFIG_PHY_AQUANTIA_FW_MAX_SIZE,
>> +						0);
>> +		if (ret < 0) {
>> +			printf("Failed to load firmware %s: %d\n", =
fw_name,
>> +			       ret);
>> +			goto fail_free;
>> +		}
>> +		tmp_fw_length =3D ret;
>> 	}
>> +
>> +	*fw_addr =3D tmp_fw_addr;
>> +	*fw_length =3D tmp_fw_length;
>> +	return 1;
>> +
>> +fail_free:
>> +	free(tmp_fw_addr);
>> 	return ret;
>> }
>>=20
>> @@ -227,6 +247,11 @@ static int aquantia_do_upload_firmware(struct =
phy_device *phydev,
>> 	u32 primary_offset, iram_offset, iram_size, dram_offset, =
dram_size;
>> 	const struct fw_header *header;
>>=20
>> +	if (!addr || !fw_length) {
>> +		printf("%s: Invalid firmware data\n", =
phydev->dev->name);
>> +		return -EINVAL;
>> +	}
>> +
>> 	read_crc =3D (addr[fw_length - 2] << 8) | addr[fw_length - 1];
>> 	calculated_crc =3D crc16_ccitt(0, addr, fw_length - 2);
>> 	if (read_crc !=3D calculated_crc) {
>> @@ -290,17 +315,18 @@ static int aquantia_do_upload_firmware(struct =
phy_device *phydev,
>>=20
>> static int aquantia_upload_firmware(struct phy_device *phydev)
>> {
>> -	int ret;
>> -	u8 *addr =3D NULL;
>> -	size_t fw_length =3D 0;
>> +	int ret, fwrc;
>> +	u8 *fw_addr =3D NULL;
>> +	size_t fw_length;
>>=20
>> -	ret =3D aquantia_read_fw(&addr, &fw_length);
>> -	if (ret !=3D 0)
>> -		return ret;
>> +	fwrc =3D aquantia_read_fw(phydev, &fw_addr, &fw_length);
>> +	if (fwrc < 0)
>> +		return fwrc;
>>=20
>> -	ret =3D aquantia_do_upload_firmware(phydev, addr, fw_length);
>> +	ret =3D aquantia_do_upload_firmware(phydev, fw_addr, fw_length);
>>=20
>> -	free(addr);
>> +	if (fwrc > 0)
>> +		free(fw_addr);
>>=20
>> 	return ret;
>> }
>> --=20
>> 2.47.3
>>=20

