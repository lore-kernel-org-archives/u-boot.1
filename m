Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54259CCF9EB
	for <u-boot@archiver.kernel.org>; Wed, 29 Oct 2025 09:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C45A80422;
	Wed, 29 Oct 2025 10:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infi.wang header.i=@infi.wang header.b="bhVK+4Sq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEC7B832AD; Wed, 29 Oct 2025 10:55:09 +0100 (CET)
Received: from outbound.pv.icloud.com
 (p-west1-cluster1-host7-snip4-2.eps.apple.com [57.103.64.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5C28003E
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 10:55:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infi.wang
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=root@infi.wang
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPS id
 E5A2318000AF; Wed, 29 Oct 2025 09:55:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infi.wang; s=sig1;
 bh=jMapH5mJf2MQ1yMxKjmoh20cqBWoGkhmtocDZs/9rtM=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=bhVK+4SqNFhNUOs8SsZGH43V0k/ELvoe79rA2yMcqnACVrfocqj3QTX3D+tMozAok6nkvojuKxdwtVsZMia3GNzEzNIsHosC1NmyVLj+/qAxvaQtSukr9Ftwiy+lDVavImMDPZXbOSKk/1eRsqR9ZNNycONZV9dZCVxbwq7aEzRnY7M2ViWqoXYQ6PdqDyvOlAtTLNeWDZox6fU7vp+SQJTnDQ4pXYk0erB5hPBaZkgbg43+B99avOHuhZ3+3mwkWTgIiw7Pz8f1D27s7/jucb2miph6J20eSmvKsbEN3/YPB6gUK10U7phfc4L4/S1NOw38sNheFIVJAT/sbywdbA==
mail-alias-created-date: 1549370554000
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-3 (Postfix) with ESMTPSA id
 C8F3718003D0; Wed, 29 Oct 2025 09:54:58 +0000 (UTC)
From: Beiyan Yun <root@infi.wang>
Message-Id: <0BCDA96C-117C-4FF1-8B8B-C9E3620D8752@infi.wang>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v3 4/4] net: phy: aquantia: use generic firmware loader
Date: Wed, 29 Oct 2025 17:54:46 +0800
In-Reply-To: <b0e62d688e281cc9b8144db23b10a143b977f523.camel@mediatek.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Yao Zi <ziyao@disroot.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
To: Weijie Gao <weijie.gao@mediatek.com>
References: <20251014121318.453701-1-root@infi.wang>
 <20251014121318.453701-5-root@infi.wang>
 <b0e62d688e281cc9b8144db23b10a143b977f523.camel@mediatek.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3NCBTYWx0ZWRfX++HX5NL0wiKi
 dwYvNFU+bvvjPSKywXopYNnWXtABdtaUp69JHiugiqvbfmzbUkDrkP+tvM7BUs7HbKnEQ02yzOt
 2fseyVVg/mJw6UeQGC3T/YVf5e5chBxIm8A0kf0ZzQ5D4+z268V9pqdGg70Oim4PBUjsF6Wccpu
 75CY2ILYTxgvnKts9GQtmOOKqNyN01BsDo5Y9ryx2SC4Ou4yDEoF4tTrjhp9JACG5xLplOSU8X6
 AxgUw2QlcvzahsD0ilmR0CDudnH8yWSrZjZXOwKy1SIYMjwwUojtnLbmt7+SGTjCtiES5gHno=
X-Proofpoint-GUID: lDODi5U5--7H2umIan2GoW3iiCzFAB1e
X-Proofpoint-ORIG-GUID: lDODi5U5--7H2umIan2GoW3iiCzFAB1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290074
X-JNJ: AAAAAAABFXPCccf8LPrVfQM1s8v41VMrAhhr01cVHUpaDk7ePtSG941YUykxMN/uS95DiMxXQuvNOWl3GfiopQomYJa/7NpRn/7j/UDTEEL6UT/pB0o3+t419ouawlLbWBp0/S5EsXblCbldSlKgUkEUPABYCbMv8cD7Iry+GaU3HA7x8JJ/TFoI4FTZ3zFmkoRM8htlxNWid9LZNeJ6Ho7JN7EMzh1O9ZKyrvmq5IoyNes7N2VBvdAn5cQNRLiERPstgfolhhNsEsIiv++qsK1Nn7lvLXJ0ghvxNFfMgvvmLxAus5rMonCODOMvqWvzIscVFYsD5EtcEqIUqKpWIQmdo/1ukN45kBM5m1v2T1OakNFeGjHOhrMjf3Y3zcU4MhwV6+PNkWssMHtQslQ76BXmGyae6iwJgJ+/VX8fheddplK18VvKMxNRXQDaEDYrpHVdEZRxM88j5cYtIN6RWCrJF17WZDLxcyzYO/J4D0zSAOZ8n8yEN1J3AZnzUMJUTsPYOxv5KDH7x7NE+EuWqjErADRwGF1yXmERVm29/ub+EMGUztCjRfvECHH7EBnAd16Au+c/hqkXgAoeqy08s8NO5oGg9QNPwz/QJ2ZGo9Euw2fBX7n6zcFaDtK9VuFi/YpAfAKM7NfG50Z67jZj93YiZL8rKypcaknqj/kwQjtMxHQgoBMpD6gnNZ8Hox83MeQdfy8KkC7ij40IIC5dcgB9vDx8b2dSINomlaT0r7KmdjeqlMULpdhTQRhkIlBSQ9TrUZqDF1hg0reg1VOuPdAgkfRUEatQqz6ewSk90JQthfZU//JeBUVg4w==
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

Hi Weijie,

Sorry for the late reply.

> On 15 Oct 2025, at 8:43=E2=80=AFAM, Weijie Gao =
<weijie.gao@mediatek.com> wrote:
>=20
> Hi Beiyan,
>=20
> On Tue, 2025-10-14 at 20:12 +0800, Beiyan Yun wrote:
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>=20
>>=20
>> Aquantia PHYs are being used w/o SPI flash in some routers recently.
>> Current firmware loader only attempts to load from FS on top of MMC,
>> limiting the use on many devices.
>>=20
>> Removed the old firmware loader, migrate to generic firmware loader
>> to
>> allow a wider range and runtime override of firmware source. (e.g.,
>> USB).
>>=20
>> Tested on Buffalo WXR18000BE10P with UBIFS.
>>=20
>> Tested-by: Beiyan Yun <root@infi.wang>
>> Signed-off-by: Beiyan Yun <root@infi.wang>
>>=20
>>=20
>> ---
>>=20
>> Changes in v3:
>> - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
>>=20
>> Changes in v2:
>> - Add support for script based loader
>>=20
>> drivers/net/phy/Kconfig    |  24 ++++---
>> drivers/net/phy/aquantia.c | 133 ++++++++++++++++++++---------------
>> --
>> 2 files changed, 88 insertions(+), 69 deletions(-)
>>=20
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 185c6a3156e..68765290671 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -1,4 +1,3 @@
>> -
>> config BITBANGMII
>>        bool "Bit-banged ethernet MII management channel support"
>>=20
>> @@ -90,23 +89,30 @@ menuconfig PHY_AQUANTIA
>> config PHY_AQUANTIA_UPLOAD_FW
>>        bool "Aquantia firmware loading support"
>>        depends on PHY_AQUANTIA
>> +       select FS_LOADER
>> +       select FW_LOADER
>>        help
>>                Aquantia PHYs use firmware which can be either loaded
>> automatically
>>                from storage directly attached to the phy or loaded
>> by the boot loader
>> -               via MDIO commands.  The firmware is loaded from a
>> file, specified by
>> -               the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME
>> options.
>> +               via MDIO commands.
>> +
>> +               This option enables loading the firmware using the
>> generic
>> +               file system firmware loader framework.
>>=20
>> -config PHY_AQUANTIA_FW_PART
>> -       string "Aquantia firmware partition"
>> +config PHY_AQUANTIA_FW_MAX_SIZE
>> +       hex "Max firmware size"
>>        depends on PHY_AQUANTIA_UPLOAD_FW
>> +       default 0x80000
>>        help
>> -               Partition containing the firmware file.
>> +         The maximum size of the Aquantia PHY firmware. This is used
>> to
>> +         allocate a buffer to load the firmware into.
>>=20
>> -config PHY_AQUANTIA_FW_NAME
>> -       string "Aquantia firmware filename"
>> +config PHY_AQUANTIA_FW_LOADER_SCRIPT
>> +       string "Aquantia firmware loader script"
>>        depends on PHY_AQUANTIA_UPLOAD_FW
>> +       default "aqr_phy_load_firmware"
>>        help
>> -               Firmware filename.
>> +               The firmware loading script variable name.
>>=20
>> config PHY_ATHEROS
>>        bool "Atheros Ethernet PHYs support"
>> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
>> index d9df0e23a45..98ee7ae10e7 100644
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
>> #define AQUNTIA_10G_CTL                0x20
>> #define AQUNTIA_VENDOR_P1      0xc400
>> @@ -127,53 +131,7 @@ struct fw_header {
>>=20
>> #pragma pack()
>>=20
>> -#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
>> -static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
>=20
> I think it's better to add a weak function, e.g.:
> int __weak aquantia_read_fw(u8 **fw_addr, size_t *fw_length);
>=20
> And put the default fw loading logic into this function.
> Overriding this function by board allows using firmware data embedded
> into u-boot by binman.
>=20
> It's useful in case that firmware data was damaged in filesystem.
>=20

Good point, I can see that=E2=80=99s how MTK U-Boot manages the firmware =
currently.

There=E2=80=99s a catch though: I=E2=80=99ve prototyped the change =
locally, realize it breaks current assumption of lifetime. Let's say we =
override `aquantia_upload_firmware` with a wrapper function to bin data =
array, in that case we can not free `fw_addr` in =
`aquantia_upload_firmware`, or a dumb memory copy is needed.

Maybe we can add a structure wrapper with additional info like Qcom's =
`struct rpmh_request`? That=E2=80=99s a bit too much for me, I=E2=80=99d =
like further opinion.

Cheers,
Yun

>> -{
>> -       loff_t length, read;
>> -       int ret;
>> -       void *addr =3D NULL;
>> -
>> -       *fw_addr =3D NULL;
>> -       *fw_length =3D 0;
>> -       debug("Loading Aquantia microcode from %s %s\n",
>> -             CONFIG_PHY_AQUANTIA_FW_PART,
>> CONFIG_PHY_AQUANTIA_FW_NAME);
>> -       ret =3D fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART,
>> FS_TYPE_ANY);
>> -       if (ret < 0)
>> -               goto cleanup;
>> -
>> -       ret =3D fs_size(CONFIG_PHY_AQUANTIA_FW_NAME, &length);
>> -       if (ret < 0)
>> -               goto cleanup;
>> -
>> -       addr =3D malloc(length);
>> -       if (!addr) {
>> -               ret =3D -ENOMEM;
>> -               goto cleanup;
>> -       }
>> -
>> -       ret =3D fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART,
>> FS_TYPE_ANY);
>> -       if (ret < 0)
>> -               goto cleanup;
>> -
>> -       ret =3D fs_read(CONFIG_PHY_AQUANTIA_FW_NAME, (ulong)addr, 0,
>> length,
>> -                     &read);
>> -       if (ret < 0)
>> -               goto cleanup;
>> -
>> -       *fw_addr =3D addr;
>> -       *fw_length =3D length;
>> -       debug("Found Aquantia microcode.\n");
>> -
>> -cleanup:
>> -       if (ret < 0) {
>> -               printf("loading firmware file %s %s failed with error
>> %d\n",
>> -                      CONFIG_PHY_AQUANTIA_FW_PART,
>> -                      CONFIG_PHY_AQUANTIA_FW_NAME, ret);
>> -               free(addr);
>> -       }
>> -       return ret;
>> -}
>> +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
>>=20
>> /* load data into the phy's memory */
>> static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
>> @@ -218,27 +176,27 @@ static u32 unpack_u24(const u8 *data)
>>        return (data[2] << 16) + (data[1] << 8) + data[0];
>> }
>>=20
>> -static int aquantia_upload_firmware(struct phy_device *phydev)
>> +/* Common firmware upload implementation */
>> +static int aquantia_do_upload_firmware(struct phy_device *phydev,
>> +                                      const u8 *addr, size_t
>> fw_length)
>> {
>>        int ret;
>> -       u8 *addr =3D NULL;
>> -       size_t fw_length =3D 0;
>>        u16 calculated_crc, read_crc;
>>        char version[VERSION_STRING_SIZE];
>>        u32 primary_offset, iram_offset, iram_size, dram_offset,
>> dram_size;
>>        const struct fw_header *header;
>>=20
>> -       ret =3D aquantia_read_fw(&addr, &fw_length);
>> -       if (ret !=3D 0)
>> -               return ret;
>> +       if (!addr || !fw_length) {
>> +               printf("%s: Invalid firmware data\n", phydev->dev-
>>> name);
>> +               return -EINVAL;
>> +       }
>>=20
>> -       read_crc =3D (addr[fw_length - 2] << 8)  | addr[fw_length - =
1];
>> +       read_crc =3D (addr[fw_length - 2] << 8) | addr[fw_length - =
1];
>>        calculated_crc =3D crc16_ccitt(0, addr, fw_length - 2);
>>        if (read_crc !=3D calculated_crc) {
>>                printf("%s bad firmware crc: file 0x%04x calculated
>> 0x%04x\n",
>>                       phydev->dev->name, read_crc, calculated_crc);
>> -               ret =3D -EINVAL;
>> -               goto done;
>> +               return -EINVAL;
>>        }
>>=20
>>        /* Find the DRAM and IRAM sections within the firmware file.
>> */
>> @@ -268,14 +226,14 @@ static int aquantia_upload_firmware(struct
>> phy_device *phydev)
>>        ret =3D aquantia_load_memory(phydev, DRAM_BASE_ADDR,
>> &addr[dram_offset],
>>                                   dram_size);
>>        if (ret !=3D 0)
>> -               goto done;
>> +               return ret;
>>=20
>>        debug("loading iram 0x%08x from offset=3D%d size=3D%d\n",
>>              IRAM_BASE_ADDR, iram_offset, iram_size);
>>        ret =3D aquantia_load_memory(phydev, IRAM_BASE_ADDR,
>> &addr[iram_offset],
>>                                   iram_size);
>>        if (ret !=3D 0)
>> -               goto done;
>> +               return ret;
>>=20
>>        /* make sure soft reset and low power mode are clear */
>>        phy_write(phydev, MDIO_MMD_VEND1, GLOBAL_STANDARD_CONTROL,
>> 0);
>> @@ -289,8 +247,63 @@ static int aquantia_upload_firmware(struct
>> phy_device *phydev)
>>        phy_write(phydev, MDIO_MMD_VEND1, UP_CONTROL,
>> UP_RUN_STALL_OVERRIDE);
>>=20
>>        printf("%s firmware loading done.\n", phydev->dev->name);
>> -done:
>> -       free(addr);
>> +       return 0;
>> +}
>> +
>> +static int aquantia_upload_firmware(struct phy_device *phydev)
>> +{
>> +       int ret;
>> +       ofnode node;
>> +       struct udevice *loader_dev;
>> +       const char *fw_name;
>> +       u8 *fw_addr =3D NULL;
>> +       size_t fw_length;
>> +
>> +       fw_addr =3D malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
>> +       if (!fw_addr) {
>> +               printf("Failed to allocate memory for firmware\n");
>> +               return -ENOMEM;
>> +       }
>> +
>> +       /* First, try to load firmware via script */
>> +       ret =3D request_firmware_into_buf_via_script(fw_addr,
>> +                                                  CONFIG_PHY_AQUANTI
>> A_FW_MAX_SIZE,
>> +                                                  CONFIG_PHY_AQUANTI
>> A_FW_LOADER_SCRIPT,
>> +                                                  &fw_length);
>> +       if (ret) {
>> +               /* Fallback to DT specified firmware */
>> +               node =3D phy_get_ofnode(phydev);
>> +               if (!ofnode_valid(node)) {
>> +                       printf("Failed to get PHY node\n");
>> +                       ret =3D -EINVAL;
>> +                       goto out;
>> +               }
>> +
>> +               fw_name =3D ofnode_read_string(node, =
"firmware-name");
>> +               if (!fw_name) {
>> +                       printf("Failed to get firmware name\n");
>> +                       ret =3D -ENOENT;
>> +                       goto out;
>> +               }
>> +
>> +               ret =3D get_fs_loader(&loader_dev);
>> +               if (ret) {
>> +                       printf("Failed to get fs_loader instance:
>> %d\n", ret);
>> +                       goto out;
>> +               }
>> +
>> +               ret =3D request_firmware_into_buf(loader_dev, =
fw_name,
>> fw_addr,
>> +                                               CONFIG_PHY_AQUANTIA_F
>> W_MAX_SIZE, 0);
>> +               if (ret < 0) {
>> +                       printf("Failed to load firmware %s: %d\n",
>> fw_name, ret);
>> +                       goto out;
>> +               }
>> +               fw_length =3D ret;
>> +       }
>> +
>> +       ret =3D aquantia_do_upload_firmware(phydev, fw_addr,
>> fw_length);
>> +out:
>> +       free(fw_addr);
>>        return ret;
>> }
>> #else
>> --
>> 2.47.3

