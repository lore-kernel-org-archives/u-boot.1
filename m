Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B2DC3ABDA
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 02:18:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40D4782AE7;
	Thu, 15 May 2025 04:18:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qnmIjKJ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AED0382AF6; Thu, 15 May 2025 04:18:27 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DFE82AD2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 04:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erOFuZ2PW1Un6+QDi5Fo0w7xb1PvTNCzYypu+2kWAl0FuWz9aOfdX39A4N0IckZn0tu7BJI+kB3XizFh3neirI6K+zsIw1+/YgNXRDQr2SzJe+fBW93nHkPll0dkLIs23uYrVij95m8b/7VbqbtM7ok05xv4lChWp1TwM81NYZ7+HETa1z+bnRLiJLRsJDthqKpO6BRsXwwr3xz3bq3KvR8+QzGo8mjfc4vDd7adlGzqiP+lzR9cD/7JnTKiYIiUDF0rhAUx34sHSm3OzDwLV43F68fpUeGVzByvYL24BKybeloywG7zP/fIB6QttsooC4eC70BwxrCxl02iqAxJYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU1h7RrIVObn0mBO+0scvPRcuUSlCKNKd0jTQVXt2hQ=;
 b=a+A9ZNLhtlJb4lWQU73mbXr3ItH9FrNhlueYmbtWPj5qSbO8UBmH+ImxlpQa2uXl47hraz/Wf/Pb7lQcmGdyNucYmTLVlLvh8c6EiwmP30MxV6C/ucUsTaYzWsJysZH1Ke5FLi6iZQp+BLio4OBWjvPrs0zgSsogQlYBuPbCXsOP95JoCQClEAI0QUWvpzivuWHZ16F3SedgA76yhSk/qh3IDG6WDWDi2mC4NbA9HNtHN5d10MkslSMr3SaDkWOPEq4/jYFyNGW/OdfWLnlTKUieLYaOZMfB5dq7wOdqoSnO6Xy0D44ogEMILGhDaffUdcNIULSLO6eci9QsblXdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU1h7RrIVObn0mBO+0scvPRcuUSlCKNKd0jTQVXt2hQ=;
 b=qnmIjKJ35bpCELKWO4j8mgRzmQnlg0KKtnuHbBdIVVqjEe0KU57TDZ7y9fhlR6NPBzBXk1v8wQri7DyO8W4PdY3i3/OngiWs4YJS3JHnTSGtOLzBEPizLOAVp34Ox4zyzeTHK+bo4pf1gBFhTCKFL6BE8ERP4X3WUhyLDRIh2EOSLIuXm+2GnJgwZHXl30GMU3h3lhWZgNyqjgaOkf+ZfyZE7/i54kegvnjR9Uo9tmbowvnS+hDM7+p8CMqqqTUBdndzqz83132RlRKXRKPTz+qBvatWyksA1/g7to1egNFdy+y6mZpGBy2gkXZem8TVfUIieBz5BTPdAYoyxhfL5Q==
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA1PR03MB6548.namprd03.prod.outlook.com (2603:10b6:806:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 02:18:22 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 02:18:22 +0000
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
To: "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, "Meng, Tingting"
 <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 1/5] drivers: ddr: altera: arria10: Add DRAM size checking
Thread-Topic: [PATCH 1/5] drivers: ddr: altera: arria10: Add DRAM size checking
Thread-Index: AQHbvpD+ClCDxxSwIkSCF9oZRble9bPTAJHw
Date: Thu, 15 May 2025 02:18:22 +0000
Message-ID: <LV8PR03MB813724B6833FBC40DFD808E1A790A@LV8PR03MB8137.namprd03.prod.outlook.com>
References: <20250506141246.6672-1-nareshkumar.ravulapalli@altera.com>
 <20250506141246.6672-2-nareshkumar.ravulapalli@altera.com>
In-Reply-To: <20250506141246.6672-2-nareshkumar.ravulapalli@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR03MB8137:EE_|SA1PR03MB6548:EE_
x-ms-office365-filtering-correlation-id: 69b80d3c-1ac9-4938-e19f-08dd9356c409
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eflrxqU7Mu/BmGVO6UvTdGC/60/D22MYXPfB8c+k+b+V+nACuYrnnlL/KzN8?=
 =?us-ascii?Q?G0kgge+Ue4hJFNz9W1iBFK5BtEM3QchVLju8wLefXyL7WpPL/5Y81UAEt8G7?=
 =?us-ascii?Q?/mNEPwnKFsLGBvjBjNKRjb8nCv7rVvdN+k3zlpuAa/1Im0ZmICDfuQklaqu7?=
 =?us-ascii?Q?NKHmVhKFsXPBANBB9fK8/0yq/9nUJdQWMKGTEByMBF/j4nvUTKlKUCvMVgc5?=
 =?us-ascii?Q?E68vn0KhW68Qt+hHMb+Vctc5NCijtIvJlJcJt5ZAVQdc6sA6/5Gc7E7iBCEU?=
 =?us-ascii?Q?39qDY/3HbxLaWfoZxFKVFM5pEEcPgIFzmNKejBzdIk1hp5DIQPvVO3P9IOgZ?=
 =?us-ascii?Q?RTMVqtBpVUEpsqsFk0e4EGVOIzQhdwy0UtGMv4fa4dunPDD4d38T1NAtJ/7b?=
 =?us-ascii?Q?SF/aaMCteDot/NwLw1sFh1OA0PbFevUsu1r8uSN53yhmYRWELEgXHDNYfpgN?=
 =?us-ascii?Q?7D03KmOUztZTcKnsKRG6PEEd4U4ni4SX0bYhzEBO1Zgv/GyDRaoRRzMJcwfr?=
 =?us-ascii?Q?04TD/oaTKFsYY9VKSDKGsWJSyXg7nHtilT5whzfhi1RYOj9e6a/GxV+oPnIs?=
 =?us-ascii?Q?SjzeGKNXQ0Od8IfUc4ooT6p6b3r0R06ilD8WFTUaYV099KuS0o1fF6fAsPKh?=
 =?us-ascii?Q?f6OnHB/M3+NTJ713WHzdi0jlEcFtYdByyMxEGQGeI2eQFujV8aEH4/306oqI?=
 =?us-ascii?Q?BxRxZ6QYJZcwr/iou0sCIdH5uIKCZTNRE9YKAlkP4iu2C/op9TbeXck3PC8v?=
 =?us-ascii?Q?S/hyxhwpwgkvGxnwom3aBsak1rkgNc+bbeoSa1HLG/dL6m62FzeLvMUUFUjL?=
 =?us-ascii?Q?Zywehp2Em7irJqF6YYwh00fa5faYt7muuUu6/Lp2HUXmQ11yvpweZlhenl3f?=
 =?us-ascii?Q?bn8uYuuPfRGM02EVv127AAQzPCPYLiAbeoWBOwMITxRUOvTkLjJkdcVfqQ35?=
 =?us-ascii?Q?Z0Z0X1qGlpeN6B4s0VYk314r7bBD4zWNFBrSybpcskK3OF2QVvnMKG8W6KzC?=
 =?us-ascii?Q?ausf6rZsTQUGt7kZqrVDZQrZUFApm6NGRYcvQSaqQMAByV3yZtTLBSILjEuL?=
 =?us-ascii?Q?YNKdNwWDL5tAriDo4DZGZWYLcD3M9HZ5qD71kLqQER6MJrIIE4E3KFSNfkwu?=
 =?us-ascii?Q?auf0XGtO3VpcaBgkEx5AosOdj6WF7ortylEZbUUKW8mAaItnr/S5nSxZ2T1x?=
 =?us-ascii?Q?XExeN1nT+eRt9UuPo/nkqn+T93CusVwSP81VJt7Y4ldzOAqrP4ESMWRD4xRn?=
 =?us-ascii?Q?zwNtP9iTUDhxddPgb066xcuv5zpNifSBzTpmo0/jG4jK/NAUFgFi3MgiHBB8?=
 =?us-ascii?Q?EBjaI/5hR4fSd5Fhd6ufmaBFEyYt7WnyfGiGx9uakrpVJ8nf4b6s1anFBA+U?=
 =?us-ascii?Q?Xxaqa2SMyFhcI5r/pNUkF+aEkd2va7tBXdJLbjSoWs41t2dzxiSIptz4XDGq?=
 =?us-ascii?Q?Fo9Cr/bPJSY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n6gEKWf3QNixEKR6G8H5FiCTXouBe4u8vS4zTuIlHxenUmgVJkgIgiR7RJfu?=
 =?us-ascii?Q?l6rxqkOtVmLgLfaxKM5vjI2baN/WC1ZAQqFrgcXBFHqsJVckDzLaIsk0oLv6?=
 =?us-ascii?Q?FsnnPUJAP9Q25SZxg4nWn9tdBCLiHLxasnf3JjRagu9BecoHSx/XahFXILsz?=
 =?us-ascii?Q?pzBfd6xSEbNQjZix98o9HVcVrJWJVbcxFe0cC0JpcPb8E2rkpt7LvorNYQ/Z?=
 =?us-ascii?Q?JUAlC7jybbsDuj44Y8SozSMXjUMNemXyTyHL7Ebzzh1zyIdAp1r76ugkqoOE?=
 =?us-ascii?Q?V+ULkJLc+5crEREEVxXdLTPrDnql+mYdmSbeHjqcfFyETbDd0BnziFbluXJY?=
 =?us-ascii?Q?yM451jW3GbKnmZ8XrDhoOki/7kIGnhMJlTwtjPfXTtDz+VR0u/ZX/3c48Sxd?=
 =?us-ascii?Q?dLVpz5VSSf/PaTRZJxpm3JUmpohZYon72nz05NRIRiEwGZKgMri3/k0cbqXY?=
 =?us-ascii?Q?0eMrou5WZSJ+kGqL32LKsCLrdMGft+kMFnHg3RmU6TlgEDL6yZlt0SlEl0wP?=
 =?us-ascii?Q?xAr56JJhGjrswf0sDSNv1BMtnJnfQni+6RN+BUzXact4XyycsQ0EEEdcWgZb?=
 =?us-ascii?Q?Sm/fWr/1pEh4+IvPfCUAXmVOLX63+r5CXvnzYjbBXjESJM2Ld0QII+BilyD3?=
 =?us-ascii?Q?R1Vp8QPnOhvOXIWNp8Xx1zVZEuEmB+8KjJWpObcHmqFHBFwlgsX3HhAz4LNH?=
 =?us-ascii?Q?NxMls5jv6pTgrZ4dLQPwnPnBT+bnU96O3lCTJmX4GHSVuxVqt2K0FnWopuQj?=
 =?us-ascii?Q?2ILD/TOXHsuugQeI9X32LB9kTboPMeKd8akEaS9hZnjO3GOWu1GSHwD+f7OW?=
 =?us-ascii?Q?GNynIX4jnFRYdDGSW6InmdnYwv6ZzDYIe1kKI7ba6bDywRKOJhizxvN94kmp?=
 =?us-ascii?Q?6XzVoBU2UmNp278e7cAolb0ZY1JsFZuFuGs4JwTqDeEY8OkkBKgQhgrCxNK5?=
 =?us-ascii?Q?7s6AP9SPbE73tDfgBtki9ogMjvVAi7fv85onIJgA5wrVIFXGtHP75VbXz6jX?=
 =?us-ascii?Q?UbrxqzmGj/1BrxCAkyxLaYR3daP8CopTlhY3CvuVW8FlYh6nbRTYSStLOSWR?=
 =?us-ascii?Q?PaqqRxROMSGMGriCFUzNGur/ibt8vZKOz+q/PMHV8R0e+p2sIFbNNuEFMmOt?=
 =?us-ascii?Q?yKxkoBm0dP2xH2+jG6/dsfKfA9tz6VZO7Ypn9jmZAoB5pGOm360IDgArlevQ?=
 =?us-ascii?Q?v+YhgQnm9f37xXPpjApU5veJU5mEFjHfEr9sbNKTbyl9TqKakvDMHQCw5Ubq?=
 =?us-ascii?Q?gBK2n3zyOxlLuIDyFbsPvpurWShVxq4HhlfsNpnjelH5kUeciHtCx6e7xErx?=
 =?us-ascii?Q?IYLmKu7vidoUTRccUo6hSbcnXkYOby6Q0Jh173GQu2QJOzrcPGdy5+LWN0kx?=
 =?us-ascii?Q?qBZs9bsssJP6oUhrseHG1n7mgOJ7eLPrq3V5CvxZ+mZLr617lBSHnLaW864R?=
 =?us-ascii?Q?FiNSNyz3fQqq0CIvRS7YYpsOQCRO+JgU/YN8uXSkQhL4S5vxshsWBfzFBvqQ?=
 =?us-ascii?Q?q4oTwiTcYolYcZe1mwFl90mJkVMBQxN9dAzvDvWbdfQAX7SAkNNYwD3MdNpN?=
 =?us-ascii?Q?Xul85Xhn+OYeBzkdo77TXDinxjQ6eAsLR3sgNS9W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b80d3c-1ac9-4938-e19f-08dd9356c409
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 02:18:22.1481 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eO2sFn+H9L4j5/zr8R/v4qCDYXEBov28NnEBSLiosVcabwea2T8WzZMa7B99dpRS2T9Oo42jCOFu1+5maQW9ukOm2xF6Q/OnzmKgBk6Oacg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6548
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
> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
> Sent: Tuesday, May 6, 2025 10:13 PM
> To: u-boot@lists.denx.de
> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
> <tien.fong.chee@altera.com>; Meng, Tingting <tingting.meng@altera.com>;
> Tom Rini <trini@konsulko.com>; Ravulapalli, Naresh Kumar
> <naresh.kumar.ravulapalli@altera.com>
> Subject: [PATCH 1/5] drivers: ddr: altera: arria10: Add DRAM size checkin=
g
>=20
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>=20
> Trigger hang if DRAM size from device tree is greater than actual hardwar=
e.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>=20
> Signed-off-by: Naresh Kumar Ravulapalli
> <nareshkumar.ravulapalli@altera.com>
> ---
>  drivers/ddr/altera/sdram_arria10.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/ddr/altera/sdram_arria10.c
> b/drivers/ddr/altera/sdram_arria10.c
> index d3305a6c82d..d75203a1d2a 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -1,12 +1,14 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (C) 2017 Intel Corporation <www.intel.com>
> + * Copyright (C) 2025 Altera Corporation <www.altera.com>
>   */
>=20
>  #include <cpu_func.h>
>  #include <errno.h>
>  #include <fdtdec.h>
>  #include <init.h>
> +#include <hang.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <wait_bit.h>
> @@ -702,6 +704,18 @@ int ddr_calibration_sequence(void)
>  	/* setup the dram info within bd */
>  	dram_init_banksize();
>=20
> +	if (gd->ram_size !=3D gd->bd->bi_dram[0].size) {
> +		printf("DDR: Warning: DRAM size from device tree (%ld
> MiB)\n",
> +		       gd->bd->bi_dram[0].size >> 20);
> +		printf(" mismatch with hardware (%ld MiB).\n",
> +		       gd->ram_size >> 20);
> +	}
> +
> +	if (gd->bd->bi_dram[0].size > gd->ram_size) {
> +		printf("DDR: Error: DRAM size from device tree is greater
> than hardware size.\n");
> +		hang();

Hardware size should be used instead of hang()

> +	}
> +
>  	if (of_sdram_firewall_setup(gd->fdt_blob))
>  		puts("FW: Error Configuring Firewall\n");
>=20
> --
> 2.35.3

Best regards,
Tien Fong

