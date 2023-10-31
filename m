Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5C7C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9832787A6E;
	Tue, 31 Oct 2023 07:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="kh7Vwz+q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 817B887AB9; Tue, 31 Oct 2023 07:08:32 +0100 (CET)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B51187A6E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:08:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20231031060826epoutp04f77b065bffb6f806f29561b79914a96c~THDbNnzYn0943009430epoutp04h
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:08:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20231031060826epoutp04f77b065bffb6f806f29561b79914a96c~THDbNnzYn0943009430epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698732506;
 bh=TOOIAZLikNzCGStVJJJw5qbj4pY+ArDC4vLT+vpVqmg=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=kh7Vwz+q4rn9VN6l/txpN3Y7mSuM9ScI+gWfPOUfe03Y4ZTL9t9U8MLNtX3Xj7XER
 QaLPLoQoC5ThUjhZ019WWMJhjo+zymHeePxHOJMZ1xUaD9FJasUdsK/5N2ctzPx8pm
 3JkOlVYNdumW/3cXMGAEdsGWzi99ubEUZ2vjURmk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20231031060825epcas1p33254b81fc4e547f9785771bfc1989c9d~THDayPUoU0645106451epcas1p35;
 Tue, 31 Oct 2023 06:08:25 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.136]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4SKKSm5HT3z4x9Pv; Tue, 31 Oct
 2023 06:08:24 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 FC.08.08572.8D990456; Tue, 31 Oct 2023 15:08:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd~THDZmA2py1522715227epcas1p48;
 Tue, 31 Oct 2023 06:08:24 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231031060824epsmtrp1fa147656782383ad4515bb77c023976f~THDZlCqAu2873228732epsmtrp1o;
 Tue, 31 Oct 2023 06:08:24 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-e3-654099d8c072
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 78.AB.18939.8D990456; Tue, 31 Oct 2023 15:08:24 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20231031060824epsmtip27ce581aec644d1d4584aa7f2441e0477~THDZW0VlS2852328523epsmtip2x;
 Tue, 31 Oct 2023 06:08:24 +0000 (GMT)
Message-ID: <554256c3-9fed-4795-b408-2036959745e8@samsung.com>
Date: Tue, 31 Oct 2023 15:08:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cmd: mmc: Add mmc reg read command for reading card
 registers
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Ramon
 Fried <rfried.dev@gmail.com>, Roger Knecht <rknecht@pm.me>, Sean Edmond
 <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, Tobias
 Waldekranz <tobias@waldekranz.com>
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20231010124728.7930-1-marex@denx.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmge6NmQ6pBq9Oa1q8ut7LatHb8pvZ
 4k1bI6PF4c9n2S1uHjzPaLF/UZ3Fty3bGC0WHV/IavF2bye7xeGpHxgduDzWzFvD6DG74SKL
 x7xZJ1g8ds66y+7x4WOcx51re9g8zt7ZwejRuuMvu8fRPefYPP5sW8oYwBWVbZORmpiSWqSQ
 mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
 386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9dLy+1xMrQwMDIFKgwITvjd88dloI51hXL
 mpYwNjDu0u1i5OSQEDCRmLv9N3MXIxeHkMAORok9//6xQTifGCWmL2pkhnM+rPrDDtPS036I
 BSKxk1HiydImJgjnPaPExzfzmUCqeAXsJA5vPghUxcHBIqAqsanBGiIsKHFy5hMWEFtUQF7i
 /q0ZYEOFBcIlZkw9DWYzC4hL3HoCMUZEwFRi7azFYPOZBc4ySXz4dQGsmU1AR2L7t+NMIPM5
 BYwkVrxXhOiVl9j+dg7Y1RICJzgkDnz5wQZxtYvEkzWrWCBsYYlXx7dAfSMl8bK/jR2ioZlR
 YumSg6wQTg+jxL+G61DdxhL7l04G28YsoCmxfpc+RFhRYufvuYwQm/kk3n3tYQUpkRDgleho
 E4IoUZG49PolE8yuu0/+s0LYHhKXO/rZJjAqzkIKl1lI/p+F5J9ZCIsXMLKsYhRLLSjOTU9N
 NiwwhEd3cn7uJkZwUtYy3sF4ef4/vUOMTByMhxglOJiVRHgPmzqkCvGmJFZWpRblxxeV5qQW
 H2I0BUbORGYp0eR8YF7IK4k3NLE0MDEzMjaxMDQzVBLnVZwwO0VIID2xJDU7NbUgtQimj4mD
 U6qBaZJZiPqtuNjp6RIq0msn/Gi4tPvhU9vgSSVH9OU4l77e8v+Y96MIn7u28fvZNIXZ+YNL
 lphEhEjb774f/kj17lVh3a0K0bERNZfbQid0tH98bl00bWFoouVuZq+l0ydO/f6GrTjtrljO
 1umT3p9PPXFhfka2TMk2Nhv1Y87XzzYclT9Z4D1FkXN6z2+ZS5Vbr3o+391mJ/v27zflWSxJ
 c0vk7t2+80w2qnf2t0XfXh58uIvtTN7FndcbfBz+sWU6insv+XxcR/fCzIdvlhQfqd1pcW2x
 ZdPFjTrvuLj/aupUKdif17V+KbH0x4els3Yu/j7jH0/+zwVX9s+s91a6f6ktOO2E+9otZdfN
 Lr3cWHlIiaU4I9FQi7moOBEAE7fselMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvO6NmQ6pBodPC1u8ut7LatHb8pvZ
 4k1bI6PF4c9n2S1uHjzPaLF/UZ3Fty3bGC0WHV/IavF2bye7xeGpHxgduDzWzFvD6DG74SKL
 x7xZJ1g8ds66y+7x4WOcx51re9g8zt7ZwejRuuMvu8fRPefYPP5sW8oYwBXFZZOSmpNZllqk
 b5fAlfG75w5LwRzrimVNSxgbGHfpdjFyckgImEj0tB9i6WLk4hAS2M4oce79ZSaIhJTE56dT
 2boYOYBsYYnDh4shat4ySsw9voMRpIZXwE7i8OaDLCA1LAKqEpsarCHCghInZz5hAbFFBeQl
 7t+awQ5iCwuES8yYehrMZhYQl7j1ZD7YKhEBU4m1sxYzgcxnFjjPJLHm+AWw+UIChhJn9+1k
 A7HZBHQktn87zgSyi1PASGLFe0UQk1lAXWL9PCGIkfIS29/OYZ7AKDQLyRWzkGybhdAxC0nH
 AkaWVYyiqQXFuem5yQWGesWJucWleel6yfm5mxjBUacVtINx2fq/eocYmTgYDzFKcDArifAe
 NnVIFeJNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2aWpBaBJNl4uCUamCacLFU
 MGLKN/2P99doPjOMmbF6bn9Q5Z2f37y5+DKtw86wXA9afuvyu3VXA0XZlvwMt1ZlWMD/ySBL
 u3i14iyZIBblngty80uq9p9tbOINlYmWvrZvd+gBxuu8qXIXFU4V/wyznSyWo1rb9jWT53iB
 TGeehmnqX8PnS5ZI7xO8uH/Rp+1O2uzPwo4sSj75lO+Lt1TTsRXhPvGyTZc+rZO+yKU8ZY6j
 K/dGf+YtF6Qi/gRvsq+Nbreayn360yKLd6xC15Y8T5jWF3Nx55e0+YKl2ccfR4Tfr5oi9/l9
 xoSETCkeq93L4i8bKfsXTF1/uq1eqql6wY3c7YsmzHy99037tSPqBirPil5NXMMrdotHiaU4
 I9FQi7moOBEAQPmbzykDAAA=
X-CMS-MailID: 20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd
References: <20231010124728.7930-1-marex@denx.de>
 <CGME20231031060824epcas1p4948c3250847cbc5ffd3cb739c9020fbd@epcas1p4.samsung.com>
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

Hi Marek,

On 10/10/23 21:47, Marek Vasut wrote:
> Add extension to the 'mmc' command to read out the card registers.
> Currently, only the eMMC OCR/CID/CSD/EXTCSD/RCA/DSR register are
> supported. A register value can either be displayed or read into
> an environment variable.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Roger Knecht <rknecht@pm.me>
> Cc: Sean Edmond <seanedmond@microsoft.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tobias Waldekranz <tobias@waldekranz.com>

Looks good to me. I have tested with your patch on my target.

mmc reg read cid all
CID[0]: 0x15010042
=> mmc reg read extcsd all
EXT_CSD:
000:  00 00 00 00 00 00 00 00 00 00
010:  00 00 00 00 00 00 39 00 00 00
..[snip]..

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
> V2: - Update documentation
> ---
>  cmd/Kconfig           |  8 ++++
>  cmd/mmc.c             | 96 +++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/cmd/mmc.rst | 26 ++++++++++++
>  3 files changed, 130 insertions(+)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 6470b138d2f..dcd99757a1e 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1307,6 +1307,14 @@ config CMD_BKOPS_ENABLE
>  	  on a eMMC device. The feature is optionally available on eMMC devices
>  	  conforming to standard >= 4.41.
>  
> +config CMD_MMC_REG
> +	bool "Enable support for reading card registers in the mmc command"
> +	depends on CMD_MMC
> +	default n
> +	help
> +	  Enable the commands for reading card registers. This is useful
> +	  mostly for debugging or extracting details from the card.
> +
>  config CMD_MMC_RPMB
>  	bool "Enable support for RPMB in the mmc command"
>  	depends on SUPPORT_EMMC_RPMB
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index c6bd81cebbc..c29f44b7a18 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -1110,6 +1110,93 @@ static int do_mmc_boot_wp(struct cmd_tbl *cmdtp, int flag,
>  	return CMD_RET_SUCCESS;
>  }
>  
> +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
> +static int do_mmc_reg(struct cmd_tbl *cmdtp, int flag,
> +		      int argc, char *const argv[])
> +{
> +	ALLOC_CACHE_ALIGN_BUFFER(u8, ext_csd, MMC_MAX_BLOCK_LEN);
> +	struct mmc *mmc;
> +	int i, ret;
> +	u32 off;
> +
> +	if (argc < 3 || argc > 5)
> +		return CMD_RET_USAGE;
> +
> +	mmc = find_mmc_device(curr_device);
> +	if (!mmc) {
> +		printf("no mmc device at slot %x\n", curr_device);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (IS_SD(mmc)) {
> +		printf("SD registers are not supported\n");
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	off = simple_strtoul(argv[3], NULL, 10);
> +	if (!strcmp(argv[2], "cid")) {
> +		if (off > 3)
> +			return CMD_RET_USAGE;
> +		printf("CID[%i]: 0x%08x\n", off, mmc->cid[off]);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->cid[off]);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "csd")) {
> +		if (off > 3)
> +			return CMD_RET_USAGE;
> +		printf("CSD[%i]: 0x%08x\n", off, mmc->csd[off]);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->csd[off]);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "dsr")) {
> +		printf("DSR: 0x%08x\n", mmc->dsr);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->dsr);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "ocr")) {
> +		printf("OCR: 0x%08x\n", mmc->ocr);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->ocr);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "rca")) {
> +		printf("RCA: 0x%08x\n", mmc->rca);
> +		if (argv[4])
> +			env_set_hex(argv[4], mmc->rca);
> +		return CMD_RET_SUCCESS;
> +	}
> +	if (!strcmp(argv[2], "extcsd") &&
> +	    mmc->version >= MMC_VERSION_4_41) {
> +		ret = mmc_send_ext_csd(mmc, ext_csd);
> +		if (ret)
> +			return ret;
> +		if (!strcmp(argv[3], "all")) {
> +			/* Dump the entire register */
> +			printf("EXT_CSD:");
> +			for (i = 0; i < MMC_MAX_BLOCK_LEN; i++) {
> +				if (!(i % 10))
> +					printf("\n%03i: ", i);
> +				printf(" %02x", ext_csd[i]);
> +			}
> +			printf("\n");
> +			return CMD_RET_SUCCESS;
> +		}
> +		off = simple_strtoul(argv[3], NULL, 10);
> +		if (off > 512)
> +			return CMD_RET_USAGE;
> +		printf("EXT_CSD[%i]: 0x%02x\n", off, ext_csd[off]);
> +		if (argv[4])
> +			env_set_hex(argv[4], ext_csd[off]);
> +		return CMD_RET_SUCCESS;
> +	}
> +
> +	return CMD_RET_FAILURE;
> +}
> +#endif
> +
>  static struct cmd_tbl cmd_mmc[] = {
>  	U_BOOT_CMD_MKENT(info, 1, 0, do_mmcinfo, "", ""),
>  	U_BOOT_CMD_MKENT(read, 4, 1, do_mmc_read, "", ""),
> @@ -1142,6 +1229,9 @@ static struct cmd_tbl cmd_mmc[] = {
>  	U_BOOT_CMD_MKENT(bkops-enable, 2, 0, do_mmc_bkops_enable, "", ""),
>  	U_BOOT_CMD_MKENT(bkops, 4, 0, do_mmc_bkops, "", ""),
>  #endif
> +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
> +	U_BOOT_CMD_MKENT(reg, 5, 0, do_mmc_reg, "", ""),
> +#endif
>  };
>  
>  static int do_mmcops(struct cmd_tbl *cmdtp, int flag, int argc,
> @@ -1229,6 +1319,12 @@ U_BOOT_CMD(
>  	"   WARNING: This is a write-once setting.\n"
>  	"mmc bkops <dev> [auto|manual] [enable|disable]\n"
>  	" - configure background operations handshake on device\n"
> +#endif
> +#if CONFIG_IS_ENABLED(CMD_MMC_REG)
> +	"mmc reg read <reg> <offset> [env] - read card register <reg> offset <offset>\n"
> +	"                                    (optionally into [env] variable)\n"
> +	" - reg: cid/csd/dsr/ocr/rca/extcsd\n"
> +	" - offset: for cid/csd [0..3], for extcsd [0..511,all]\n"
>  #endif
>  	);
>  
> diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
> index 71a0303109c..c0924ba5769 100644
> --- a/doc/usage/cmd/mmc.rst
> +++ b/doc/usage/cmd/mmc.rst
> @@ -21,6 +21,7 @@ Synopsis
>      mmc bootpart-resize <dev> <dev part size MB> <RPMB part size MB>
>      mmc partconf <dev> [[varname] | [<boot_ack> <boot_partition> <partition_access>]]
>      mmc rst-function <dev> <value>
> +    mmc reg read <reg> <offset> [env]
>  
>  Description
>  -----------
> @@ -183,6 +184,31 @@ The 'mmc rst-function' command changes the RST_n_FUNCTION field.
>          0x3
>              Reserved
>  
> +The 'mmc reg read <reg> <offset> [env]' reads eMMC card register and
> +either print it to standard output, or store the value in environment
> +variable.
> +
> +<reg> with
> +optional offset <offset> into the register array, and print it to
> +standard output or store it into environment variable [env].
> +
> +    reg
> +        cid
> +            The Device IDentification (CID) register. Uses offset.
> +        csd
> +            The Device-Specific Data (CSD) register. Uses offset.
> +        dsr
> +            The driver stage register (DSR).
> +        ocr
> +            The operation conditions register (OCR).
> +        rca
> +            The relative Device address (RCA) register.
> +        extcsd
> +            The Extended CSD register. Uses offset.
> +    offset
> +        For 'cid'/'csd' 128 bit registers '[0..3]' in 32-bit increments. For 'extcsd' 512 bit register '[0..512,all]' in 8-bit increments, or 'all' to read the entire register.
> +    env
> +        Optional environment variable into which 32-bit value read from register should be stored.
>  
>  Examples
>  --------

