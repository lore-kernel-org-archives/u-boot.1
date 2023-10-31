Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7704CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:29:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6AB6874F4;
	Tue, 31 Oct 2023 07:29:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="S7rIUXKS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BAA874CE; Tue, 31 Oct 2023 07:29:29 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB47687A6E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231031062921epoutp02fa55772714a0575cbb788b0949b9f114~THVsMJUR10936309363epoutp02X
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231031062921epoutp02fa55772714a0575cbb788b0949b9f114~THVsMJUR10936309363epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698733761;
 bh=ytLBCye/MCpT6XlcshcQHw/jNjhr3JutViCXays+p1k=;
 h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
 b=S7rIUXKSpqItJOMH/jDhU3L27ZGZfj+ZzLEYT9hLghMc6/HZPESOZKkMfGi7mE8w7
 sgvbOIE0OEzKCRwhHscHh4QPdWoPyQCwcdhFfFpZeKe7MYHtg+9NF71a+AFNc8U9B2
 Ue9h3ij41RLaJGlrB7dazqV4PkGgFclmfAd0QMFs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20231031062920epcas1p24a10893e905cc0dce46ae0e1303b5793~THVrjbI4B2478024780epcas1p2G;
 Tue, 31 Oct 2023 06:29:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.132]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKKwv4HHfz4x9Px; Tue, 31 Oct
 2023 06:29:19 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
 epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 3D.E7.09744.FBE90456; Tue, 31 Oct 2023 15:29:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20231031062919epcas1p3e659c4f54b6b800c0f8eebc159cab38c~THVqQK-kK2770927709epcas1p3w;
 Tue, 31 Oct 2023 06:29:19 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231031062919epsmtrp29af38132dc63886d53a32b1423ae98b4~THVqPfv_d3024330243epsmtrp2a;
 Tue, 31 Oct 2023 06:29:19 +0000 (GMT)
X-AuditID: b6c32a35-eabff70000002610-f2-65409ebf9e4e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EB.7F.08817.FBE90456; Tue, 31 Oct 2023 15:29:19 +0900 (KST)
Received: from jh80chung01 (unknown [10.113.111.84]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20231031062918epsmtip2546f2be5df60916b4e7c68325573ad70~THVp95BoD2851928519epsmtip2Z;
 Tue, 31 Oct 2023 06:29:18 +0000 (GMT)
From: "Jaehoon Chung" <jh80.chung@samsung.com>
To: "'Marek Vasut'" <marex@denx.de>, <u-boot@lists.denx.de>
Cc: "'Abdellatif El Khlifi'" <abdellatif.elkhlifi@arm.com>, "'Heinrich
 Schuchardt'" <xypron.glpk@gmx.de>, "'Ilias Apalodimas'"
 <ilias.apalodimas@linaro.org>, "'Ramon	Fried'" <rfried.dev@gmail.com>,
 "'Roger Knecht'" <rknecht@pm.me>, "'Sean Edmond'"
 <seanedmond@microsoft.com>, "'Simon Glass'" <sjg@chromium.org>, "'Tobias
 Waldekranz'" <tobias@waldekranz.com>
In-Reply-To: <554256c3-9fed-4795-b408-2036959745e8@samsung.com>
Subject: RE: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card
 registers
Date: Tue, 31 Oct 2023 15:29:18 +0900
Message-ID: <004401da0bc3$93f6e350$bbe4a9f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLXOqLA/gSsHjLYLSMDtv7qxw0UwQGv97XoAl7rG0SuSJoRYA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmvu7+eQ6pBmu3KFi8ut7LatHb8pvZ
 4k1bI6PF4c9n2S1uHjzPaLF/UZ3Fty3bGC0WHV/IavF2bye7xeGpHxgduDzWzFvD6DG74SKL
 x7xZJ1g8ds66y+7x4WOcx51re9g8zt7ZwejRuuMvu8fRPefYPP5sW8oYwBWVbZORmpiSWqSQ
 mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
 386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITujpXEia8FWl4qJ
 fX0sDYw9Jl2MnBwSAiYSjdufsnUxcnEICexglJg76TIrhPOJUeL0yk+MEM43RolJp/eywLT0
 tk+HatnLKNHR9BXKeckosWfyB2aQKjYBPYn/ixaC2SIC1hLTN1xiBiliFnjPJPHg6HpGkASn
 gL3EgzdtQAkODmGBcIm3i7xAwiwCqhIfrn5hBbF5BSwl1j3fwghhC0qcnPkE7ApmAXmJ7W/n
 MENcpCDx8+kyVohdThLvV/1ngqgRkZjd2Qa2V0LgCodE59SvYLskBFwk5p51h+gVlnh1fAs7
 hC0l8fndXjaI+mZGiaVLDrJCOD2MEv8arrNBVBlL7F86mQlkELOApsT6XfoQYUWJnb/nMkIs
 5pN497WHFWIXr0RHmxBEiYrEpdcvmWB23X3yn3UCo9IsJK/NQvLaLCQvzEJYtoCRZRWjWGpB
 cW56arFhgSE8upPzczcxgpOylukOxolvP+gdYmTiYDzEKMHBrCTCe9jUIVWINyWxsiq1KD++
 qDQntfgQoykwsCcyS4km5wPzQl5JvKGJpYGJmZGxiYWhmaGSOC/zo94UIYH0xJLU7NTUgtQi
 mD4mDk6pBqa62bOefJojZ/z1Hkd48C7X2WYt/cessk3O5CwW1XQubrzRu2PfvUN9kyeXC1te
 idjRHaHokxmz4GHtm4UyJqpPP3TU32ZS8nXykDk4V7qSY8njxst6VrX7d29lWJx5VDdEYyuf
 iPgJV76CP+WLoqaz6QXrRT978Df0etcm6/f3vNadfm3jfzduncQNl1mda785PHDRTtu54Hjh
 FZVJO3TPm8tw3dev2bvHSH5prudZRfWHydsEza9fVJB5rLTg6YrFuXPOd8hoHKt8uTB39qbb
 PlH8zfs2f9JNacn1sLr0fsrHeH1LT19L7tkWJg1XdTtV92pxvpwzK0nhVlub4rc9K2cbiidX
 PGWqWTDbLF+JpTgj0VCLuag4EQBjECjVUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvO7+eQ6pBnMOsFm8ut7LatHb8pvZ
 4k1bI6PF4c9n2S1uHjzPaLF/UZ3Fty3bGC0WHV/IavF2bye7xeGpHxgduDzWzFvD6DG74SKL
 x7xZJ1g8ds66y+7x4WOcx51re9g8zt7ZwejRuuMvu8fRPefYPP5sW8oYwBXFZZOSmpNZllqk
 b5fAldHSOJG1YKtLxcS+PpYGxh6TLkZODgkBE4ne9ulsXYxcHEICuxkl5s89yQaRkJL4/HQq
 kM0BZAtLHD5cDFHznFFiwo0TTCA1bAJ6Ev8XLWQGsUUEbCXmf9vABFLELPCZSWLW4m0sEB3b
 GCUONkwEq+IUsJd48KYNzBYWCJWYsGEyO4jNIqAq8eHqF1YQm1fAUmLd8y2MELagxMmZT1hA
 bGYBbYmnN59C2fIS29/OYYa4VEHi59NlrBBXOEm8X/WfCaJGRGJ2ZxvzBEbhWUhGzUIyahaS
 UbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcn1paOxj3rPqgd4iRiYPx
 EKMEB7OSCO9hU4dUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzfXvemCAmkJ5akZqemFqQWwWSZ
 ODilGpgiqudvcs6tlHyb5lHyadKTfQe5n3OnJ145efFe8NFE2ycTFlsaSQTVsC5e39TzROfN
 /ee3jt5pX6r+/fObdxeaWZkcXhU6y9RHy9x+/Gqn0dSvH3x3S0Z/KDL/9FHiZG7K9KKss+51
 R94nd16d/OR51Oycfa7uCydXJc7cvV/x6KKb3V+8bZd4zn68M+KRwky7SR5dStcfGFreCIha
 15kr/Krxvsqh4+4rLDY+2B4oeOWDnymTfK2sZeDa6eLN9jV1gvu5eZp4/N4/3+v4/8HJAq5/
 nyUaz/t/eNWa6PZ4A8/WmJTmIx9urGs59ksyrjXZP3SD6G6vfdUW/pX3k0S3PdAXZD43L6GZ
 Z0Ki8ffTSizFGYmGWsxFxYkALH7h3T4DAAA=
X-CMS-MailID: 20231031062919epcas1p3e659c4f54b6b800c0f8eebc159cab38c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd
References: <20231010124728.7930-1-marex@denx.de>
 <CGME20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd@epcas1p4.samsung.com>
 <554256c3-9fed-4795-b408-2036959745e8@samsung.com>
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

Hi,

> -----Original Message-----
> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Jaehoon Chung
> Sent: Tuesday, October 31, 2023 3:08 PM
> To: Marek Vasut <marex@denx.de>; u-boot@lists.denx.de
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>; Heinrich Schuchardt <xypron.glpk@gmx.de>;
> Ilias Apalodimas <ilias.apalodimas@linaro.org>; Ramon Fried <rfried.dev@gmail.com>; Roger Knecht
> <rknecht@pm.me>; Sean Edmond <seanedmond@microsoft.com>; Simon Glass <sjg@chromium.org>; Tobias
> Waldekranz <tobias@waldekranz.com>
> Subject: Re: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card registers
> 
> Hi Marek,
> 
> On 10/10/23 21:47, Marek Vasut wrote:
> > Add extension to the 'mmc' command to read out the card registers.
> > Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
> > supported. A register value can either be displayed or read into
> > an environment variable.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > ---
> > Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: Ramon Fried <rfried.dev@gmail.com>
> > Cc: Roger Knecht <rknecht@pm.me>
> > Cc: Sean Edmond <seanedmond@microsoft.com>
> > Cc: Simon Glass <sjg@chromium.org>
> > Cc: Tobias Waldekranz <tobias@waldekranz.com>
> 
> Looks good to me. I have tested with your patch on my target.
> 
> mmc reg read cid all
> CID[0]: 0x15010042
> => mmc reg read extcsd all
> EXT_CSD:
> 000:  00 00 00 00 00 00 00 00 00 00
> 010:  00 00 00 00 00 00 39 00 00 00
> ..[snip]..
> 
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> 
> Best Regards,
> Jaehoon Chung
> 
> > ---
> > V2: - Update documentation
> > ---
> >  cmd/Kconfig           |  8 ++++
> >  cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
> >  doc/usage/cmd/mmc.rst | 26 ++++++++++++
> >  3 files changed, 130 insertions(+)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 6470b138d2f..dcd99757a1e 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1307,6 +1307,14 @@ config CMD_BKOPS_ENABLE
> >  	  on a eMMC device. The feature is optionally available on eMMC devices
> >  	  conforming to standard >= 4.41.
> >
> > +config CMD_MMC_REG
> > +	bool "Enable support for reading card registers in the mmc command"
> > +	depends on CMD_MMC
> > +	default n
> > +	help
> > +	  Enable the commands for reading card registers. This is useful
> > +	  mostly for debugging or extracting details from the card.
> > +
> >  config CMD_MMC_RPMB
> >  	bool "Enable support for RPMB in the mmc command"
> >  	depends on SUPPORT_EMMC_RPMB
> > diff --git a/cmd/mmc.c b/cmd/mmc.c
> > index c6bd81cebbc..c29f44b7a18 100644
> > --- a/cmd/mmc.c
> > +++ b/cmd/mmc.c
> > @@ -1110,6 +1110,93 @@ static int do_mmc_boot_wp(struct cmd_tbl *cmdtp, int flag,
> >  	return CMD_RET_SUCCESS;
> >  }
> >
> > +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
> > +static int do_mmc_reg(struct cmd_tbl *cmdtp, int flag,
> > +		      int argc, char *const argv[])
> > +{
> > +	ALLOC_CACHE_ALIGN_BUFFER(u8, ext_csd, MMC_MAX_BLOCK_LEN);
> > +	struct mmc *mmc;
> > +	int i, ret;
> > +	u32 off;
> > +
> > +	if (argc < 3 || argc > 5)
> > +		return CMD_RET_USAGE;
> > +
> > +	mmc = find_mmc_device(curr_device);
> > +	if (!mmc) {
> > +		printf("no mmc device at slot %x\n", curr_device);
> > +		return CMD_RET_FAILURE;
> > +	}
> > +
> > +	if (IS_SD(mmc)) {
> > +		printf("SD registers are not supported\n");
> > +		return CMD_RET_FAILURE;
> > +	}
> > +
> > +	off = simple_strtoul(argv[3], NULL, 10);
> > +	if (!strcmp(argv[2], "cid")) {
> > +		if (off > 3)
> > +			return CMD_RET_USAGE;
> > +		printf("CID[%i]: 0x%08x\n", off, mmc->cid[off]);
> > +		if (argv[4])
> > +			env_set_hex(argv[4], mmc->cid[off]);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +	if (!strcmp(argv[2], "csd")) {
> > +		if (off > 3)
> > +			return CMD_RET_USAGE;
> > +		printf("CSD[%i]: 0x%08x\n", off, mmc->csd[off]);
> > +		if (argv[4])
> > +			env_set_hex(argv[4], mmc->csd[off]);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +	if (!strcmp(argv[2], "dsr")) {
> > +		printf("DSR: 0x%08x\n", mmc->dsr);
> > +		if (argv[4])
> > +			env_set_hex(argv[4], mmc->dsr);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +	if (!strcmp(argv[2], "ocr")) {
> > +		printf("OCR: 0x%08x\n", mmc->ocr);
> > +		if (argv[4])
> > +			env_set_hex(argv[4], mmc->ocr);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +	if (!strcmp(argv[2], "rca")) {
> > +		printf("RCA: 0x%08x\n", mmc->rca);
> > +		if (argv[4])
> > +			env_set_hex(argv[4], mmc->rca);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +	if (!strcmp(argv[2], "extcsd") &&
> > +	    mmc->version >= MMC_VERSION_4_41) {
> > +		ret = mmc_send_ext_csd(mmc, ext_csd);
> > +		if (ret)
> > +			return ret;
> > +		if (!strcmp(argv[3], "all")) {
> > +			/* Dump the entire register */
> > +			printf("EXT_CSD:");
> > +			for (i = 0; i < MMC_MAX_BLOCK_LEN; i++) {
> > +				if (!(i % 10))
> > +					printf("\n%03i: ", i);
> > +				printf(" %02x", ext_csd[i]);
> > +			}
> > +			printf("\n");
> > +			return CMD_RET_SUCCESS;
> > +		}
> > +		off = simple_strtoul(argv[3], NULL, 10);
> > +		if (off > 512)
> > +			return CMD_RET_USAGE;
> > +		printf("EXT_CSD[%i]: 0x%02x\n", off, ext_csd[off]);
> > +		if (argv[4])
> > +			env_set_hex(argv[4], ext_csd[off]);
> > +		return CMD_RET_SUCCESS;
> > +	}
> > +
> > +	return CMD_RET_FAILURE;
> > +}
> > +#endif
> > +
> >  static struct cmd_tbl cmd_mmc[] = {
> >  	U_BOOT_CMD_MKENT(info, 1, 0, do_mmcinfo, "", ""),
> >  	U_BOOT_CMD_MKENT(read, 4, 1, do_mmc_read, "", ""),
> > @@ -1142,6 +1229,9 @@ static struct cmd_tbl cmd_mmc[] = {
> >  	U_BOOT_CMD_MKENT(bkops-enable, 2, 0, do_mmc_bkops_enable, "", ""),
> >  	U_BOOT_CMD_MKENT(bkops, 4, 0, do_mmc_bkops, "", ""),
> >  #endif
> > +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
> > +	U_BOOT_CMD_MKENT(reg, 5, 0, do_mmc_reg, "", ""),
> > +#endif
> >  };
> >
> >  static int do_mmcops(struct cmd_tbl *cmdtp, int flag, int argc,
> > @@ -1229,6 +1319,12 @@ U_BOOT_CMD(
> >  	"   WARNING: This is a write-once setting.\n"
> >  	"mmc bkops <dev> [auto|manual] [enable|disable]\n"
> >  	" - configure background operations handshake on device\n"
> > +#endif
> > +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
> > +	"mmc reg read <reg> <offset> [env] - read card register <reg> offset <offset>\n"
> > +	"                                    (optionally into [env] variable)\n"
> > +	" - reg: cid/csd/dsr/ocr/rca/extcsd\n"
> > +	" - offset: for cid/csd [0..3], for extcsd [0..511,all]\n"

Is there any reason to add "all" option for cid/csd?

Best Regards,
Jaehoon Chung

> >  #endif
> >  	);
> >
> > diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
> > index 71a0303109c..c0924ba5769 100644
> > --- a/doc/usage/cmd/mmc.rst
> > +++ b/doc/usage/cmd/mmc.rst
> > @@ -21,6 +21,7 @@ Synopsis
> >      mmc bootpart-resize <dev> <dev part size MB> <RPMB part size MB>
> >      mmc partconf <dev> [[varname] | [<boot_ack> <boot_partition> <partition_access>]]
> >      mmc rst-function <dev> <value>
> > +    mmc reg read <reg> <offset> [env]
> >
> >  Description
> >  -----------
> > @@ -183,6 +184,31 @@ The 'mmc rst-function' command changes the RST_n_FUNCTION field.
> >          0x3
> >              Reserved
> >
> > +The 'mmc reg read <reg> <offset> [env]' reads eMMC card register and
> > +either print it to standard output, or store the value in environment
> > +variable.
> > +
> > +<reg> with
> > +optional offset <offset> into the register array, and print it to
> > +standard output or store it into environment variable [env].
> > +
> > +    reg
> > +        cid
> > +            The Device IDentification (CID) register. Uses offset.
> > +        csd
> > +            The Device-Specific Data (CSD) register. Uses offset.
> > +        dsr
> > +            The driver stage register (DSR).
> > +        ocr
> > +            The operation conditions register (OCR).
> > +        rca
> > +            The relative Device address (RCA) register.
> > +        extcsd
> > +            The Extended CSD register. Uses offset.
> > +    offset
> > +        For 'cid'/'csd' 128 bit registers '[0..3]' in 32-bit increments. For 'extcsd' 512 bit
> register '[0..512,all]' in 8-bit increments, or 'all' to read the entire register.
> > +    env
> > +        Optional environment variable into which 32-bit value read from register should be stored.
> >
> >  Examples
> >  --------


