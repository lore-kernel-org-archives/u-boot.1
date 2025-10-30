Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDE3CCF9EB
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 01:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40703800B1;
	Thu, 30 Oct 2025 02:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="TqtKlQB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 047A481E13; Thu, 30 Oct 2025 02:39:46 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FB88003E
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 02:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 478f8278b53111f0ae1e63ff8927bad3-20251030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=KsYZtoHgVDGYyxk0JPOyU6rrQ9WNfctY78U1ySB8SUk=; 
 b=TqtKlQB5yzhOpeCoxIEcwpLLlcim+6GcCXJQRA7EIiOvI3wrv5r65SqtGTwQoImnnuSAM+TS3VyPOTc05anbs7Wqf+QJhj0loDf8Smh1c0ks4y1MCPjsaFvmTlCI1wQEsIo6mv4yzCkxMfEhuHYkD9v64L7VR2pcoUH1/JOkHAI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:53d1d795-406a-4e88-8bc5-fede87183311, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:95ab6726-cfd6-4a1d-a1a8-72ac3fdb69c4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
 ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,CO
 L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 478f8278b53111f0ae1e63ff8927bad3-20251030
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 784525564; Thu, 30 Oct 2025 09:39:30 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 30 Oct 2025 09:39:29 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 30 Oct 2025 09:39:28 +0800
Message-ID: <097d9cd500572065624dd301de8eaffb82a2789b.camel@mediatek.com>
Subject: Re: [PATCH v3 4/4] net: phy: aquantia: use generic firmware loader
From: Weijie Gao <weijie.gao@mediatek.com>
To: Beiyan Yun <root@infi.wang>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Yao Zi
 <ziyao@disroot.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jerome
 Forissier" <jerome.forissier@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Lucien.Jheng <lucienzx159@gmail.com>, "Marek Vasut"
 <marek.vasut+renesas@mailbox.org>, Ramon Fried <rfried.dev@gmail.com>, Romain
 Gantois <romain.gantois@bootlin.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>
Date: Thu, 30 Oct 2025 09:39:28 +0800
In-Reply-To: <0BCDA96C-117C-4FF1-8B8B-C9E3620D8752@infi.wang>
References: <20251014121318.453701-1-root@infi.wang>
 <20251014121318.453701-5-root@infi.wang>
 <b0e62d688e281cc9b8144db23b10a143b977f523.camel@mediatek.com>
 <0BCDA96C-117C-4FF1-8B8B-C9E3620D8752@infi.wang>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK: N
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

On Wed, 2025-10-29 at 17:54 +0800, Beiyan Yun wrote:
>  	 
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> Hi Weijie,
> 
> Sorry for the late reply.
> 
> > On 15 Oct 2025, at 8:43 AM, Weijie Gao <weijie.gao@mediatek.com>
> > wrote:
> > 
> > Hi Beiyan,
> > 
> > On Tue, 2025-10-14 at 20:12 +0800, Beiyan Yun wrote:
> > > External email : Please do not click links or open attachments
> > > until
> > > you have verified the sender or the content.
> > > 
> > > 
> > > Aquantia PHYs are being used w/o SPI flash in some routers
> > > recently.
> > > Current firmware loader only attempts to load from FS on top of
> > > MMC,
> > > limiting the use on many devices.
> > > 
> > > Removed the old firmware loader, migrate to generic firmware
> > > loader
> > > to
> > > allow a wider range and runtime override of firmware source.
> > > (e.g.,
> > > USB).
> > > 
> > > Tested on Buffalo WXR18000BE10P with UBIFS.
> > > 
> > > Tested-by: Beiyan Yun <root@infi.wang>
> > > Signed-off-by: Beiyan Yun <root@infi.wang>
> > > 
> > > 
> > > ---
> > > 
> > > Changes in v3:
> > > - Select FW_LOADER with PHY_AQUANTIA_UPLOAD_FW
> > > 
> > > Changes in v2:
> > > - Add support for script based loader
> > > 
> > > drivers/net/phy/Kconfig    |  24 ++++---
> > > drivers/net/phy/aquantia.c | 133 ++++++++++++++++++++----------
> > > -----
> > > --
> > > 2 files changed, 88 insertions(+), 69 deletions(-)
> > > 
> > > diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> > > index 185c6a3156e..68765290671 100644
> > > --- a/drivers/net/phy/Kconfig
> > > +++ b/drivers/net/phy/Kconfig
> > > @@ -1,4 +1,3 @@
> > > -
> > > config BITBANGMII
> > >        bool "Bit-banged ethernet MII management channel support"
> > > 
> > > @@ -90,23 +89,30 @@ menuconfig PHY_AQUANTIA
> > > config PHY_AQUANTIA_UPLOAD_FW
> > >        bool "Aquantia firmware loading support"
> > >        depends on PHY_AQUANTIA
> > > +       select FS_LOADER
> > > +       select FW_LOADER
> > >        help
> > >                Aquantia PHYs use firmware which can be either
> > > loaded
> > > automatically
> > >                from storage directly attached to the phy or
> > > loaded
> > > by the boot loader
> > > -               via MDIO commands.  The firmware is loaded from a
> > > file, specified by
> > > -               the PHY_AQUANTIA_FW_PART and PHY_AQUANTIA_FW_NAME
> > > options.
> > > +               via MDIO commands.
> > > +
> > > +               This option enables loading the firmware using
> > > the
> > > generic
> > > +               file system firmware loader framework.
> > > 
> > > -config PHY_AQUANTIA_FW_PART
> > > -       string "Aquantia firmware partition"
> > > +config PHY_AQUANTIA_FW_MAX_SIZE
> > > +       hex "Max firmware size"
> > >        depends on PHY_AQUANTIA_UPLOAD_FW
> > > +       default 0x80000
> > >        help
> > > -               Partition containing the firmware file.
> > > +         The maximum size of the Aquantia PHY firmware. This is
> > > used
> > > to
> > > +         allocate a buffer to load the firmware into.
> > > 
> > > -config PHY_AQUANTIA_FW_NAME
> > > -       string "Aquantia firmware filename"
> > > +config PHY_AQUANTIA_FW_LOADER_SCRIPT
> > > +       string "Aquantia firmware loader script"
> > >        depends on PHY_AQUANTIA_UPLOAD_FW
> > > +       default "aqr_phy_load_firmware"
> > >        help
> > > -               Firmware filename.
> > > +               The firmware loading script variable name.
> > > 
> > > config PHY_ATHEROS
> > >        bool "Atheros Ethernet PHYs support"
> > > diff --git a/drivers/net/phy/aquantia.c
> > > b/drivers/net/phy/aquantia.c
> > > index d9df0e23a45..98ee7ae10e7 100644
> > > --- a/drivers/net/phy/aquantia.c
> > > +++ b/drivers/net/phy/aquantia.c
> > > @@ -17,6 +17,10 @@
> > > #include <malloc.h>
> > > #include <asm/byteorder.h>
> > > #include <fs.h>
> > > +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
> > > +#include <fs_loader.h>
> > > +#include <fw_loader.h>
> > > +#endif
> > > 
> > > #define AQUNTIA_10G_CTL                0x20
> > > #define AQUNTIA_VENDOR_P1      0xc400
> > > @@ -127,53 +131,7 @@ struct fw_header {
> > > 
> > > #pragma pack()
> > > 
> > > -#if defined(CONFIG_PHY_AQUANTIA_UPLOAD_FW)
> > > -static int aquantia_read_fw(u8 **fw_addr, size_t *fw_length)
> >  
> > I think it's better to add a weak function, e.g.:
> > int __weak aquantia_read_fw(u8 **fw_addr, size_t *fw_length);
> > 
> > And put the default fw loading logic into this function.
> > Overriding this function by board allows using firmware data
> > embedded
> > into u-boot by binman.
> > 
> > It's useful in case that firmware data was damaged in filesystem.
> > 
> 
> Good point, I can see that’s how MTK U-Boot manages the firmware
> currently.
> 
> There’s a catch though: I’ve prototyped the change locally, realize
> it breaks current assumption of lifetime. Let's say we override
> `aquantia_upload_firmware` with a wrapper function to bin data array,
> in that case we can not free `fw_addr` in `aquantia_upload_firmware`,
> or a dumb memory copy is needed.
> 
> Maybe we can add a structure wrapper with additional info like Qcom's
> `struct
>  rpmh_request`? That’s a bit too much for me, I’d like further
> opinion.

I use the return value to tell the caller whether the fw memory needs
to be freed.

In the mtk 2p5ge driver:

static int mt7988_i2p5ge_phy_load_fw(struct phy_device *phydev)
{
	int fwrc;
	void *fw;

	fwrc = mt7988_i2p5ge_get_fw(&fw, &fw_size);
	if (fwrc < 0)
		return -EINVAL;

	......

cleanup:
	if (fwrc > 0)
		free(fw);

	return ret;
}

The return value of mt7988_i2p5ge_get_fw function:
0: no need to free the memory
>0: need to free
<0: error

> 
> Cheers,
> Yun
> 
> > > -{
> > > -       loff_t length, read;
> > > -       int ret;
> > > -       void *addr = NULL;
> > > -
> > > -       *fw_addr = NULL;
> > > -       *fw_length = 0;
> > > -       debug("Loading Aquantia microcode from %s %s\n",
> > > -             CONFIG_PHY_AQUANTIA_FW_PART,
> > > CONFIG_PHY_AQUANTIA_FW_NAME);
> > > -       ret = fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART,
> > > FS_TYPE_ANY);
> > > -       if (ret < 0)
> > > -               goto cleanup;
> > > -
> > > -       ret = fs_size(CONFIG_PHY_AQUANTIA_FW_NAME, &length);
> > > -       if (ret < 0)
> > > -               goto cleanup;
> > > -
> > > -       addr = malloc(length);
> > > -       if (!addr) {
> > > -               ret = -ENOMEM;
> > > -               goto cleanup;
> > > -       }
> > > -
> > > -       ret = fs_set_blk_dev("mmc", CONFIG_PHY_AQUANTIA_FW_PART,
> > > FS_TYPE_ANY);
> > > -       if (ret < 0)
> > > -               goto cleanup;
> > > -
> > > -       ret = fs_read(CONFIG_PHY_AQUANTIA_FW_NAME, (ulong)addr,
> > > 0,
> > > length,
> > > -                     &read);
> > > -       if (ret < 0)
> > > -               goto cleanup;
> > > -
> > > -       *fw_addr = addr;
> > > -       *fw_length = length;
> > > -       debug("Found Aquantia microcode.\n");
> > > -
> > > -cleanup:
> > > -       if (ret < 0) {
> > > -               printf("loading firmware file %s %s failed with
> > > error
> > > %d\n",
> > > -                      CONFIG_PHY_AQUANTIA_FW_PART,
> > > -                      CONFIG_PHY_AQUANTIA_FW_NAME, ret);
> > > -               free(addr);
> > > -       }
> > > -       return ret;
> > > -}
> > > +#if (IS_ENABLED(CONFIG_PHY_AQUANTIA_UPLOAD_FW))
> > > 
> > > /* load data into the phy's memory */
> > > static int aquantia_load_memory(struct phy_device *phydev, u32
> > > addr,
> > > @@ -218,27 +176,27 @@ static u32 unpack_u24(const u8 *data)
> > >        return (data[2] << 16) + (data[1] << 8) + data[0];
> > > }
> > > 
> > > -static int aquantia_upload_firmware(struct phy_device *phydev)
> > > +/* Common firmware upload implementation */
> > > +static int aquantia_do_upload_firmware(struct phy_device
> > > *phydev,
> > > +                                      const u8 *addr, size_t
> > > fw_length)
> > > {
> > >        int ret;
> > > -       u8 *addr = NULL;
> > > -       size_t fw_length = 0;
> > >        u16 calculated_crc, read_crc;
> > >        char version[VERSION_STRING_SIZE];
> > >        u32 primary_offset, iram_offset, iram_size, dram_offset,
> > > dram_size;
> > >        const struct fw_header *header;
> > > 
> > > -       ret = aquantia_read_fw(&addr, &fw_length);
> > > -       if (ret != 0)
> > > -               return ret;
> > > +       if (!addr || !fw_length) {
> > > +               printf("%s: Invalid firmware data\n", phydev-
> > > >dev-
> > > > name);
> > >  +               return -EINVAL;
> > > +       }
> > > 
> > > -       read_crc = (addr[fw_length - 2] << 8)  | addr[fw_length -
> > > 1];
> > > +       read_crc = (addr[fw_length - 2] << 8) | addr[fw_length -
> > > 1];
> > >        calculated_crc = crc16_ccitt(0, addr, fw_length - 2);
> > >        if (read_crc != calculated_crc) {
> > >                printf("%s bad firmware crc: file 0x%04x
> > > calculated
> > > 0x%04x\n",
> > >                       phydev->dev->name, read_crc,
> > > calculated_crc);
> > > -               ret = -EINVAL;
> > > -               goto done;
> > > +               return -EINVAL;
> > >        }
> > > 
> > >        /* Find the DRAM and IRAM sections within the firmware
> > > file.
> > > */
> > > @@ -268,14 +226,14 @@ static int aquantia_upload_firmware(struct
> > > phy_device *phydev)
> > >        ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR,
> > > &addr[dram_offset],
> > >                                   dram_size);
> > >        if (ret != 0)
> > > -               goto done;
> > > +               return ret;
> > > 
> > >        debug("loading iram 0x%08x from offset=%d size=%d\n",
> > >              IRAM_BASE_ADDR, iram_offset, iram_size);
> > >        ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR,
> > > &addr[iram_offset],
> > >                                   iram_size);
> > >        if (ret != 0)
> > > -               goto done;
> > > +               return ret;
> > > 
> > >        /* make sure soft reset and low power mode are clear */
> > >        phy_write(phydev, MDIO_MMD_VEND1, GLOBAL_STANDARD_CONTROL,
> > > 0);
> > > @@ -289,8 +247,63 @@ static int aquantia_upload_firmware(struct
> > > phy_device *phydev)
> > >        phy_write(phydev, MDIO_MMD_VEND1, UP_CONTROL,
> > > UP_RUN_STALL_OVERRIDE);
> > > 
> > >        printf("%s firmware loading done.\n", phydev->dev->name);
> > > -done:
> > > -       free(addr);
> > > +       return 0;
> > > +}
> > > +
> > > +static int aquantia_upload_firmware(struct phy_device *phydev)
> > > +{
> > > +       int ret;
> > > +       ofnode node;
> > > +       struct udevice *loader_dev;
> > > +       const char *fw_name;
> > > +       u8 *fw_addr = NULL;
> > > +       size_t fw_length;
> > > +
> > > +       fw_addr = malloc(CONFIG_PHY_AQUANTIA_FW_MAX_SIZE);
> > > +       if (!fw_addr) {
> > > +               printf("Failed to allocate memory for
> > > firmware\n");
> > > +               return -ENOMEM;
> > > +       }
> > > +
> > > +       /* First, try to load firmware via script */
> > > +       ret = request_firmware_into_buf_via_script(fw_addr,
> > > +
> > >                                                  CONFIG_PHY_AQUAN
> > > TI
> > > A_FW_MAX_SIZE,
> > > +
> > >                                                  CONFIG_PHY_AQUAN
> > > TI
> > > A_FW_LOADER_SCRIPT,
> > > +                                                  &fw_length);
> > > +       if (ret) {
> > > +               /* Fallback to DT specified firmware */
> > > +               node = phy_get_ofnode(phydev);
> > > +               if (!ofnode_valid(node)) {
> > > +                       printf("Failed to get PHY node\n");
> > > +                       ret = -EINVAL;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               fw_name = ofnode_read_string(node, "firmware-
> > > name");
> > > +               if (!fw_name) {
> > > +                       printf("Failed to get firmware name\n");
> > > +                       ret = -ENOENT;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               ret = get_fs_loader(&loader_dev);
> > > +               if (ret) {
> > > +                       printf("Failed to get fs_loader instance:
> > > %d\n", ret);
> > > +                       goto out;
> > > +               }
> > > +
> > > +               ret = request_firmware_into_buf(loader_dev,
> > > fw_name,
> > > fw_addr,
> > > +
> > >                                               CONFIG_PHY_AQUANTIA
> > > _F
> > > W_MAX_SIZE, 0);
> > > +               if (ret < 0) {
> > > +                       printf("Failed to load firmware %s:
> > > %d\n",
> > > fw_name, ret);
> > > +                       goto out;
> > > +               }
> > > +               fw_length = ret;
> > > +       }
> > > +
> > > +       ret = aquantia_do_upload_firmware(phydev, fw_addr,
> > > fw_length);
> > > +out:
> > > +       free(fw_addr);
> > >        return ret;
> > > }
> > > #else
> > > --
> > > 2.47.3
> 
> 

