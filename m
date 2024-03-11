Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAC0C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 08:50:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0889587E88;
	Mon, 11 Mar 2024 09:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="iiDl4niB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D3F87EF2; Mon, 11 Mar 2024 09:50:16 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB75A87D50
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 09:50:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byW684i/7nQY9Ta+9r7HXdCs1vrWSoRZ8AHazUf72T6/HYVYFItiNh28seARFHXt7krNwEmDIbmK+XKo2dPM33hwuEWijEblzv+ty2wA6SeIzHmKRpUMcuVPm7l60moQd3wDBq+8t4n3Ubci11DBdFx4oqwI6BkZ4bwReiMouhuKQ97fe+Da3WO6aBs1FYvQ7/fPLzgdrLRDNuclsUY/yFSMdbaZcWsYsnEmLLVsa/ZYDuxHQD7Cj2rOdnedIy8yLyP/rMrErfsomsdgoZiXvAQQSdCJEDTrlRmwvhoZaPHPBlDweFh5e1/o0PO8keg+7Dklcm6xYtm2l3bqdqFIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=regHRijZjc2pfTZ1//MSb2upMxye3pfu1lUyVRbR3Mk=;
 b=imqt+zboMdJbHYszTJdLt6DuyJPZNOpYfcvc23vlI2ycOraA8JvEdNz9QLweM8CquTYBiDNExgOC24WJ8+7E/SVmJsTd+H5Ii4ewqyQsOTd+mYcTtidzdHCtRlmOtAICWMHIkRRhcMdUPym7f3mm+HFoqHNlN2YVMKcyvf8eBlHQHie62qsCjIjlt6Rirj417Okvd1bmerNwm0dX4oBuDSKHi8FNqkNt+mnbVm5SPYsip3yMTiZBiauHj4/r6lis5lZmIEfLjchY/TVFImzDcMtk7yWhZAW9N3pu5amuDCRKWjdfJXgaR4d0btGbL7jo9TgG4gRiBtx0BC+Bt2kWnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com; 
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=regHRijZjc2pfTZ1//MSb2upMxye3pfu1lUyVRbR3Mk=;
 b=iiDl4niBntmjSMWYNs0TdWmwwMHLvhbW1AslLh9K6Ub8dejVGAAbmz8isqquLyBkFnshklCPDIfK9hJ9AVht1xMZg01KG2jYucb/KM5Ya3EJRK9fA3N5vOQTO+/7guRkwOADTQEmRedav8Yp4Z+FtxRIARfXiXEtFiWdWWYnhck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 08:50:12 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4ca1:4adc:e34d:58d2%5]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 08:50:11 +0000
Message-ID: <ac10f1c9-40e0-4667-90f3-2c2d22e74262@kontron.de>
Date: Mon, 11 Mar 2024 09:50:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mtd: spinand: Add support for XTX SPINAND
To: Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Cc: michael@amarulasolutions.com, dario.binacchi@amarulasolutions.com,
 jagan@amarulasolutions.com, bruce.sun@xtxtech.com
References: <20240311025434.7270-1-bruce_suen@163.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240311025434.7270-1-bruce_suen@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3588:EE_
X-MS-Office365-Filtering-Correlation-Id: e189daf0-cb79-4803-4ded-08dc41a84322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdJROx6dkeD39vpnDOHZfjIOuzcLT7kJZGsSKSMF+r/xvBObcTkRvQT0aKXuqxE72qT/QkUY4gnGnO28yyPpE/LAoM/hKh5nETmz89kgKHVlqxXDlVMe+yn8oPvJEVK5afu0My9zX8DZhFwjCz/wzGUPLeixSd2zQe0zn6jRLIn+WQDwGLfyuupJD0buREYN+J6djPIqEgWoWGAZpMUd4SJK5Smt1jiw22QNqijw03SyvISjVw3V8heKCEUVu1Wj8btplfvNge5CPn22quxNGYo46o78NCUPZ3KkV5Qpm8sPjiz3t7OpUgVD8nQ+k1BP0GT8PoJsbmN5eXWy7Vv87HnDdFu43ZWRRzBcIfkffd1c6rVZWycdidBvj8e546HeTMJrF6GxIXqrjK9bcOjVUIgYD1hQ77FvncK8kJyHqcfRtoPwpDzddD1ruRMN6b9dOzgu41DGhTWw4sNiVkaTHmGw441/v+5EXkajXY+ApsAEmFM5NB6lrhw2oyqM5pMCIdr64j5hSxN/SXX7juecxuATRNqnmtV8aQZyMM+JPWPv/bOmk1cAopPlTFfDppD6WOWVmBKUb2KvCssWUHNpDEoEFi5/6VYATxOtvhwPjXo8jTp0wRrU7mb0Fpj6hZVhKqXxbrSnmM/EqGsWQ+/SGs1V4LjqnegeI2I+S3EouTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFQvQVNtZkwyZEFrdkd0alE4ZC91TDlpUGVHOTBaV3VGdUpCQ002RU40OVlt?=
 =?utf-8?B?TnhqYy9ZTU5LY1dLTTBWdlNITTRWK3ZSWTVlb2xJMXMwb0loL3duWE9RRzNT?=
 =?utf-8?B?YW1ZRUlVSWp3Qlg4UHRNSFBIWWZzSW0zV2c5TDd1dFl5UlprMVllckkxbFB5?=
 =?utf-8?B?dUxWdkdxaWE2bjAxdklrc1Y1b1hqcWd0bE5xeHd1WVpjTit5Nk1IYTJDNVFP?=
 =?utf-8?B?M3VTUXQ2cTJpWFZHK3o2V1NiTmQ2NmtFRUI1WE9kZTZPbldSR3I2bWYyN3h4?=
 =?utf-8?B?VVk2RTFiNHJiTDFuNGNYc3lPUWVJVXNXVXdKWmNqcmVLTkZ5QjV2amlEMlJR?=
 =?utf-8?B?L1hMK3Q5aHpmMUJWOHBSTWVnNWVucUZDOTdIa0YyWFp3R0hLaHNjZy9mb1A1?=
 =?utf-8?B?WklPcVFFbEpSUjN0Q3Vsc3NHQ21Xc2FmYkFyeFhtVlU1MDJLUTVCcEJET1Nv?=
 =?utf-8?B?dkNLTzdsM0FXWDR4TVl4Tlgzamduekppc21lU0k3Z1FHbjYxWWc1ZU9ERVhu?=
 =?utf-8?B?MmRXSVloNnIySnlxTlhORzUwM05OT2xITzkxN2RKc3NrUGdLK00zVEp1V056?=
 =?utf-8?B?UUJWb1RHY29qTVB6RWtnSVFidEwvL0t4ZHhTNzZQNXRiUWVkbFdtbkpUNE4v?=
 =?utf-8?B?aWVEU3JRWDF2TWZGak9HaG9leE5uTS9DK0JJamtQZFhpRFI1VFBndncwRWJo?=
 =?utf-8?B?aEtMMWxuVktPRHhjMDYzM1dPb2MzYjhvaGVwYzZYYXJxYWZkQjBNcXFhUnpB?=
 =?utf-8?B?T2puMHA4emErY0h0NmVVRlRobndKeTlaMFpYZnNNMkNFV0g3UFliS2pGSldi?=
 =?utf-8?B?WHZwdk5sd0U1eHdDN3VyS20zUEl1U2FGemdJVHBvQnBPTE1iR0JsaTEzVStY?=
 =?utf-8?B?Yy9teWMrT0xLWS92Q1RvOXptWnZVTVRpRFdpNlN4dlhjdlZaYWdrbDNBUmxD?=
 =?utf-8?B?N3l3UHdreWYxbG5FOVRia2tPZ0lWTE91VmJPckhRb1o0MzJsK0Q4NGtEM2s1?=
 =?utf-8?B?RGlpa2pjbmcvU3ZBc1YrTHJyd0o0c2VlTFBaNGFBTEVkaDA3aFF6b1BUd0h5?=
 =?utf-8?B?L3dpRkF6cU10M2g0VWxjUnVPcVRjTW9vcVZwalR6YnpEemljVDNLSXdrM2lP?=
 =?utf-8?B?b1dhaFlKZTR6QzhxYzlwUGN1aWhSd0k1SmxxTFFaUXpVR0VGTnRzTjY4a2NR?=
 =?utf-8?B?VzFVcEhTSXlIQ3J0OVJuSGcrZjAzZGx3R1FFRitaa0ZLeWIrOVVkM2tDMlRp?=
 =?utf-8?B?V2dTRW9xbVFMOHh3NVYwamd0ZFZXOXEvQmQxOTZsdGlsdDdGazhMb3dkWmQy?=
 =?utf-8?B?eHllM0M4OWdGVlBUSmlmL3N1OHlOTENsSkwvdk0rV20wM1FGNlNCL0E3S1Iw?=
 =?utf-8?B?Wit0dXo5MUpsU243WnI3ajdhMUtESUVyUllJT2ltZktzTGdFUlI5c3JmdC9n?=
 =?utf-8?B?MldVN0dvNjQ5c0Z1QmRud082SXlyaDIrYnZiOUZQYW5MbmgxL2J4Y1FRZ09Y?=
 =?utf-8?B?WlRvelBGL0tKeDdnVUVKMHpFZnhVYzhMUTZtcFpaWmpHY1gxang1MlBHYm5q?=
 =?utf-8?B?Q1hWMi9NLzZTd2tnMjJwV24wYU0ycWJvVUczR3RlYWc2WkltM3JINmx0cUVK?=
 =?utf-8?B?U1k2OXpQc09CNkQyeWdINXlkQ1JkT1ZYZnlnWmZKaXVDUUJyZ1kwMDRxMFRu?=
 =?utf-8?B?L3FiL2d4cXdwSFVMYXdWalIvaGRDTFh5ejYwTlhUMzhVMDVMa1g2dzk0ZkZY?=
 =?utf-8?B?RUxhelE4Nm0zSzBLTktQVytNR0JVOEVyRUlncVpmNzB4dlVZODJiZW5NYUNt?=
 =?utf-8?B?cWhOQzBhQnpXYUVMTy83QUJUVUxKTDVINlFCRWdrYkJ1dEhFTVZjcWxrNkpF?=
 =?utf-8?B?WWJxMWF4SWFadE5sNnZUREhtUHM0NTFEdVV6dzJ2Vi9hd2lVWUZhZXFqWHJY?=
 =?utf-8?B?S0FCU3UzZnMzSk5mbHpUSE5aU0ZLaUJWcEkxRkpIUkUzb0FET0JReWoyZXRB?=
 =?utf-8?B?cWlRY2kwdVZhSVFYRWJoM2RSK29jckxqQ3kvUHh3QkFyT25HelNVak5pQ0U5?=
 =?utf-8?B?VXlETzVNbUJQOVArc3ZPMGRhRmdvNGdVNjNSODZvb2R6Q3ZZNU1KVG4xcXJJ?=
 =?utf-8?B?WktHMTlVVEpLdWN2dTIwWm90SjMrRExIeWk1K3NJdVl6c2kxNXpvSUNFVWFi?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e189daf0-cb79-4803-4ded-08dc41a84322
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:50:11.8228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0wFCe0UEW1v+aKd6s/Ig2d9M2YQsKGtPfxgFeduil2zVo0jzOdMSfTTAFImd5k/wvsHvQtFOodJ7yvsYpLzee5SRQ2Ce1YUmdqOTYZ7c+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3588
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

Hi Bruce,

On 11.03.24 03:54, Bruce Suen wrote:
> [Sie erhalten nicht häufig E-Mails von bruce_suen@163.com. Weitere Informationen, warum dies wichtig ist, finden Sie unter https://aka.ms/LearnAboutSenderIdentification ]
> 
> Add support for XTX XT26G0xA and XT26xxxD,the driver is ported from
> linux-6.7.1.

Please, fix the spelling like this:

Add support for XTX XT26G0xA and XT26xxxD. The driver is ported from
Linux 6.7.1.

Also, did you test this driver in U-Boot with some specific board and
SPI NAND chip? Then please add the information about your setup to the
commit message. Thanks!

> 
> Signed-off-by: Bruce Suen <bruce_suen@163.com>
> ---
> V1->V2:
> - remove patch errors

Checkpatch still produces the following warnings, please fix them!

CHECK: Alignment should match open parenthesis
#90: FILE: drivers/mtd/nand/spi/xtx.c:44:
+static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
+                               struct mtd_oob_region *region)

CHECK: Alignment should match open parenthesis
#102: FILE: drivers/mtd/nand/spi/xtx.c:56:
+static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
+                                       struct mtd_oob_region *region)

Thanks
Frieder

> ---
>  drivers/mtd/nand/spi/Makefile |   2 +-
>  drivers/mtd/nand/spi/core.c   |   1 +
>  drivers/mtd/nand/spi/xtx.c    | 266 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |   1 +
>  4 files changed, 269 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/xtx.c
> 
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index f172f4787f..65b836b34c 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> 
>  spinand-objs := core.o esmt.o gigadevice.o macronix.o micron.o paragon.o
> -spinand-objs += toshiba.o winbond.o
> +spinand-objs += toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 8ca33459f9..62c28aa422 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -829,6 +829,7 @@ static const struct spinand_manufacturer *spinand_manufacturers[] = {
>         &toshiba_spinand_manufacturer,
>         &winbond_spinand_manufacturer,
>         &esmt_c8_spinand_manufacturer,
> +       &xtx_spinand_manufacturer,
>  };
> 
>  static int spinand_manufacturer_match(struct spinand_device *spinand,
> diff --git a/drivers/mtd/nand/spi/xtx.c b/drivers/mtd/nand/spi/xtx.c
> new file mode 100644
> index 0000000000..6b7b265136
> --- /dev/null
> +++ b/drivers/mtd/nand/spi/xtx.c
> @@ -0,0 +1,266 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author:
> + * Felix Matouschek <felix@matouschek.org>
> + */
> +
> +#include <linux/bitfield.h>
> +#ifndef __UBOOT__
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#endif
> +#include <linux/mtd/spinand.h>
> +
> +#define SPINAND_MFR_XTX        0x0B
> +
> +#define XT26G0XA_STATUS_ECC_MASK       GENMASK(5, 2)
> +#define XT26G0XA_STATUS_ECC_NO_DETECTED        (0 << 2)
> +#define XT26G0XA_STATUS_ECC_8_CORRECTED        (3 << 4)
> +#define XT26G0XA_STATUS_ECC_UNCOR_ERROR        (2 << 4)
> +
> +#define XT26XXXD_STATUS_ECC3_ECC2_MASK     GENMASK(7, 6)
> +#define XT26XXXD_STATUS_ECC_NO_DETECTED     (0)
> +#define XT26XXXD_STATUS_ECC_1_7_CORRECTED   (1)
> +#define XT26XXXD_STATUS_ECC_8_CORRECTED     (3)
> +#define XT26XXXD_STATUS_ECC_UNCOR_ERROR     (2)
> +
> +static SPINAND_OP_VARIANTS(read_cache_variants,
> +               SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> +               SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(write_cache_variants,
> +               SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
> +               SPINAND_PROG_LOAD(true, 0, NULL, 0));
> +
> +static SPINAND_OP_VARIANTS(update_cache_variants,
> +               SPINAND_PROG_LOAD_X4(false, 0, NULL, 0),
> +               SPINAND_PROG_LOAD(false, 0, NULL, 0));
> +
> +static int xt26g0xa_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                               struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = 48;
> +       region->length = 16;
> +
> +       return 0;
> +}
> +
> +static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
> +                                       struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = 1;
> +       region->length = 47;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops xt26g0xa_ooblayout = {
> +       .ecc = xt26g0xa_ooblayout_ecc,
> +       .rfree = xt26g0xa_ooblayout_free,
> +};
> +
> +static int xt26g0xa_ecc_get_status(struct spinand_device *spinand,
> +                                  u8 status)
> +{
> +       status = status & XT26G0XA_STATUS_ECC_MASK;
> +
> +       switch (status) {
> +       case XT26G0XA_STATUS_ECC_NO_DETECTED:
> +               return 0;
> +       case XT26G0XA_STATUS_ECC_8_CORRECTED:
> +               return 8;
> +       case XT26G0XA_STATUS_ECC_UNCOR_ERROR:
> +               return -EBADMSG;
> +       default:
> +               break;
> +       }
> +
> +       /* At this point values greater than (2 << 4) are invalid  */
> +       if (status > XT26G0XA_STATUS_ECC_UNCOR_ERROR)
> +               return -EINVAL;
> +
> +       /* (1 << 2) through (7 << 2) are 1-7 corrected errors */
> +       return status >> 2;
> +}
> +
> +static int xt26xxxd_ooblayout_ecc(struct mtd_info *mtd, int section,
> +                                 struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = mtd->oobsize / 2;
> +       region->length = mtd->oobsize / 2;
> +
> +       return 0;
> +}
> +
> +static int xt26xxxd_ooblayout_free(struct mtd_info *mtd, int section,
> +                                  struct mtd_oob_region *region)
> +{
> +       if (section)
> +               return -ERANGE;
> +
> +       region->offset = 2;
> +       region->length = mtd->oobsize / 2 - 2;
> +
> +       return 0;
> +}
> +
> +static const struct mtd_ooblayout_ops xt26xxxd_ooblayout = {
> +       .ecc = xt26xxxd_ooblayout_ecc,
> +       .rfree = xt26xxxd_ooblayout_free,
> +};
> +
> +static int xt26xxxd_ecc_get_status(struct spinand_device *spinand,
> +                                  u8 status)
> +{
> +       switch (FIELD_GET(STATUS_ECC_MASK, status)) {
> +       case XT26XXXD_STATUS_ECC_NO_DETECTED:
> +               return 0;
> +       case XT26XXXD_STATUS_ECC_UNCOR_ERROR:
> +               return -EBADMSG;
> +       case XT26XXXD_STATUS_ECC_1_7_CORRECTED:
> +               return 4 + FIELD_GET(XT26XXXD_STATUS_ECC3_ECC2_MASK, status);
> +       case XT26XXXD_STATUS_ECC_8_CORRECTED:
> +               return 8;
> +       default:
> +               break;
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static const struct spinand_info xtx_spinand_table[] = {
> +       SPINAND_INFO("XT26G01A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE1),
> +                    NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
> +                                    xt26g0xa_ecc_get_status)),
> +       SPINAND_INFO("XT26G02A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE2),
> +                    NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
> +                                    xt26g0xa_ecc_get_status)),
> +       SPINAND_INFO("XT26G04A",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xE3),
> +                    NAND_MEMORG(1, 2048, 64, 128, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    SPINAND_HAS_QE_BIT,
> +                    SPINAND_ECCINFO(&xt26g0xa_ooblayout,
> +                                    xt26g0xa_ecc_get_status)),
> +       SPINAND_INFO("XT26G01D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x31),
> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G11D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x34),
> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26Q01D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x51),
> +                    NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G02D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x32),
> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G12D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x35),
> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26Q02D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x52),
> +                    NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26G04D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x33),
> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +       SPINAND_INFO("XT26Q04D",
> +                    SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0x53),
> +                    NAND_MEMORG(1, 4096, 256, 64, 2048, 40, 1, 1, 1),
> +                    NAND_ECCREQ(8, 512),
> +                    SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
> +                                             &write_cache_variants,
> +                                             &update_cache_variants),
> +                    0,
> +                    SPINAND_ECCINFO(&xt26xxxd_ooblayout,
> +                                    xt26xxxd_ecc_get_status)),
> +};
> +
> +static const struct spinand_manufacturer_ops xtx_spinand_manuf_ops = {
> +};
> +
> +const struct spinand_manufacturer xtx_spinand_manufacturer = {
> +       .id = SPINAND_MFR_XTX,
> +       .name = "XTX",
> +       .chips = xtx_spinand_table,
> +       .nchips = ARRAY_SIZE(xtx_spinand_table),
> +       .ops = &xtx_spinand_manuf_ops,
> +};
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 6f479fa5ad..13b5a52f8b 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -251,6 +251,7 @@ extern const struct spinand_manufacturer paragon_spinand_manufacturer;
>  extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
>  extern const struct spinand_manufacturer winbond_spinand_manufacturer;
>  extern const struct spinand_manufacturer esmt_c8_spinand_manufacturer;
> +extern const struct spinand_manufacturer xtx_spinand_manufacturer;
> 
>  /**
>   * struct spinand_op_variants - SPI NAND operation variants
> --
> 2.34.1
> 
