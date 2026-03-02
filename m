Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEBFE9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ADE383F4C;
	Mon,  2 Mar 2026 14:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qQMHl0Yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A051583D17; Mon,  2 Mar 2026 07:40:32 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DEB483F14
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 07:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUA0hcwYCsp+dtwmxHtOAuBE6yqF8opm0fRT1iEFfHbuuqoE9/TB/D+9L0DKtHEOInD9JnbdRfwlzEpmu5395/pR42iNhRzuj19thzDvXe8hVSw6080SqkIgSVvdzxzeYTDvHd/UG74IfWUpvjvLENGv32PiQ3fWROxRbHgnP7bCShjdTVgbCQ5rSg3Mupm/eDEr/SarTo2yDJVR37iF4OEDjtMJQRYTH5uOChwutZSM481+VNUbpRV5o54a93zKJ1CKeI/Q9X1mEtKiiXBNIT2JquJCIgE3KYdCGzO2qJTMlUjida4xfIbV29LEEcDcxU29teSFLvq525laK1q6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5pxKIoA4MX79QDnu3gu71gKpW1DJdEXda1hhxZFBlE=;
 b=Vi8ddOVzgmTVc7292Hlosvl5HDAuoiljZd5vrDqzgD0/oIBH5yJIxpB4h1mH8Dq8tTi7slW6MrIiltbfpmvvu6ymyBDAb82vLJt8c/8A8yqApTXCCB6MtzTlgqBnPdPA2enXf1XHgn+08FRAKd7Ix2/nsvkkW51BSlS8l8zQxZ9k1LjkxTZKLPsovhqbVoLvWIY8T7xTjyMzWWgxhqlBPjvC4YiJ0S4h77JPHlj9E2gaolu8lZ9giWOIzP39cUGbPxfqaGtcf/jqFHd59cCg6uW2WPHaba0cWDIO4ahQOA7H5UBRS0oGWgNjrxSbOMOKkr5KfKDxUy/fkoGLxQ0IhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5pxKIoA4MX79QDnu3gu71gKpW1DJdEXda1hhxZFBlE=;
 b=qQMHl0YhSfYU3UCzqErphCkkW5qWYWXzMVOFcYfkcDyemTI0Wl8Bz+BasHMpSmR4jMSIXFAtj0sd4meG2qopRIdmNdT+PbtwBMMMXH4sg0Tuflc0DsU3/hIeElXGXKAPiP2Dvbm9yqFErYxiJ9bATiKpr0FXCibpTm8wbkrUWZKi2fZ0bmzA85/59V+uBcOjGWZZYHe1k/78+ygidUcIsv0EePbfEp/lAvkFzwI5/F+JeYJh7Sr/2yFFgs0zVQqyiI/9MsmdfJAbOJ08IEjf0bZtNeb0UOjqjnKtFpEPj9iocWIgtBc8uYOBNvZ3j0FWpJVi4demmDJG5rLl5vsrhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11728.eurprd04.prod.outlook.com (2603:10a6:10:624::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 06:40:28 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9654.015; Mon, 2 Mar 2026
 06:40:28 +0000
From: alice.guo@oss.nxp.com
Date: Mon, 02 Mar 2026 13:20:02 +0800
Subject: [PATCH v3 01/13] imx9: scmi: Get DDR size through SM SCMI API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-imx952-v1-1-069d6167c0cb@nxp.com>
References: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
In-Reply-To: <20260302-imx952-v1-0-069d6167c0cb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Ji Luo <ji.luo@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, Jacky Bai <ping.bai@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Frank Li <Frank.Li@nxp.com>, 
 Niko Mauno <niko.mauno@vaisala.com>, Adam Ford <aford173@gmail.com>, 
 Joseph Guo <qijian.guo@nxp.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Fedor Ross <fedor.ross@ifm.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Simon Glass <sjg@chromium.org>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11728:EE_
X-MS-Office365-Filtering-Correlation-Id: 72fe5520-7612-49d3-8f03-08de7826979e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: zoEhZHh+tgJXU2KyGAoDAQlJJOAZT/cJlM/hXec0YtoXlBRtAiPToG14tp5RZrBATfBBnBe4n3VdpdrxkLHp3jheesd+JAR/4zLMSnA911sT5jZgYD85YgZsoi4gK9pakUmzEeVR3BrVhJJv2UBiQSEMsdbEYKhAKDArA3J9Xbcd8WM098n38zwG1N1ok5GKBKSi9e8+0r30PqdGKw7IMLfYTy9iGKtSbK4DG4IxZ5UGiCBdTRnx4sJBEljj520vRgT7hb22YkN5bARZ5oNZNiAeukrIXt/INPU7rWIjxvUZ3gaHZdIgntGvFpFg0tLBkY+JoEVK3QMRIoH1DGHhm/FA6uHcxvChFGW8jtcu+H9q3aIz3hpnhc0eDojjG0zpCC6yY4YkfAliD/DRsjwXGtkNLij6VMt0oMvble0EW1faMHLngqwBLu5qlZS149ejGQoumWsjHj5RT9KdSWe09/onojeP8dO/Ikdr2iYrRI95FOy8Ml+ieApSMUN2WgHOTnAkMy0TJyyJGb8w61/mBwsKi/Tgk9aX8LIWm9SjihFM6EkHnDq15BP0Yfb94S6QAVAU2wuuawwJiBpSGv4fuKC/UrdTKxo0nH7YXAL9Q7w893ICWoAnhHS6NmiFY09AyH8cEsh7q3+YIOtPWNd5y/+SFUBWnDFGiwIstJ8DNvFibMqmsEkUAlRTTpePpWXyoCkFvggoWwimYtziBGjYBaRiHHHdkRt49x5i7FY4MRVSApWu4G3vbYXKhKeXY904FCVlqM0ACCBpSrRTPuHAgXpn/I4TBkaEwkwjOxCQFxs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0lGYmh5ZFpUck1TdUxRRFlERmo3Nkt0OTB2SzloMFlqQ3E5MXVKbTBEWlBv?=
 =?utf-8?B?d1V2elk2cGorc1NzNkZGdFVYZ2tCZXQ2U3QvVjBxQ202T093aVBYM29TUVo3?=
 =?utf-8?B?cGxocUhaQlBDNXlxb0VqN3BNUFl4dW84ZUxncjNkMlg1Y0ZTUWdSOUNoVzlk?=
 =?utf-8?B?SG91dlFSZ3RnSnhVVzFVd3N1S3ZQNzg3aWdkOU5TbUpHdmRobWtOMnphbjlY?=
 =?utf-8?B?bWtYd2NIKzNLbjdxU2FNYmpTdTFLTkJrMXBlVVIvaDZWRHA5OTRoQi8wcTVk?=
 =?utf-8?B?M2M1QitVbXcwOUtlZ1FmaFhCb0trc3ZLSlM2bHVVekp6QVFRRzFmUTNJZ3ps?=
 =?utf-8?B?cm95ajlWSmgvdko4Yms3K1FDR094K3lic1Z5RUFKYkZHVjNhUldTa2tyZVlW?=
 =?utf-8?B?V2pEbGVGbnkyUFVjZFhyaDNuOFlrVm5SUEZ0c3lMYWQvdWMxa09oa2trNHlR?=
 =?utf-8?B?T0dUN0dScHVidU9kWW01SS9hQzAzbC9qUEZxZ3QwTmF4cytCTFQ5bWZJVmdH?=
 =?utf-8?B?T3V5Mkp0MGxHa2djenl5ZmY0a0dHSXNydlhFZlBPUUtWWmJUMUl2VUdKdDdi?=
 =?utf-8?B?dmtTa1MxeXdVaVh5RndjNVIzSGFGVkZSWmxPaW00eUFQTVgrM0lFNnEwTkFs?=
 =?utf-8?B?aHkycDl0R21GVkZ6YTZDSDhoM01kTWMxRTBRdUNYM01uTjNVVWsvTTVJV3M5?=
 =?utf-8?B?YkczT2xGN3d5R3kzbGZKUU5MZlpuSmZQRFJMOWkxYzZabG1xdlZnbkJyK3NO?=
 =?utf-8?B?ZXdWN2dMd29idGxlQ0JHWnpGYVR0bSs1Y3JEbzhlZ3VBeWMzM1VSWWpiZVo3?=
 =?utf-8?B?WWFHUDA4aGMxR3FjOFhubTRJNEowWnRiOXYrN3d0OURidlB4eCtEZGdvdjdG?=
 =?utf-8?B?YThPYk8vNTI3cjRqcFo3ZzUzWVBiaGNtUzQzWXlIV3BXVDU0UERnYVYxdHJB?=
 =?utf-8?B?dmNWTUd6UDZPNENyMFJFRlQyZTFlRjZZYy9uUHJYY1lYOEJWdUtHRitkUE5J?=
 =?utf-8?B?RjFsbHh3bk5TNnhBQ1U1d28vWEpkWXNNNEhaNVpqVzF0ekh4b2h4aS8wMkwr?=
 =?utf-8?B?MVorbGdkY1pocnBzUUlZa1ByNHBLcXorNGNaNStqU0ZId0FpQXUvNDZsaVBs?=
 =?utf-8?B?OUM3aEc2RjFRd1E5TW1nbzdkSWllVHlKdzNGVm9yS0pwOTlIcXByUDM0QjJy?=
 =?utf-8?B?WElvMDZabGNaUmJ5UURaWHI1Y3hsQ1dOclE5WFZUL1FJTlhPUlZkMG50OUpP?=
 =?utf-8?B?RGdtWnRnRGp0dW5xaWVIYzY0T24vYk51Z2JhRHZKRm55OFhPU2VnUjAzMjhL?=
 =?utf-8?B?dkRlUWRtVXMxbURrTjNWeFhJRGNoaGcyL0pRUTdCc3lmVFZNVlROT0pJcVFG?=
 =?utf-8?B?Mmo5UEIwRklWM1ArRDhtNmlMRXpnMEl4ZTBJNE83ZFQweEtOdXllaDUwN2hy?=
 =?utf-8?B?UXJWSGNKWVJZZVlaNjBjaXVWcStoa1pDZ1RYeTk3S3BQNUZiZUc2SytqMDJQ?=
 =?utf-8?B?Wk5xTWdJYXBjQ0ttUGxUa1dndCtGT1JnbWxMTFh0YWdHSDRvZHJpT2ZpZGZR?=
 =?utf-8?B?OWZRM0hXNHRHejJwU3NKVWNvLzF3MUxIN2Jwd0p4Tmw1QnMzMDJEM0VHdS82?=
 =?utf-8?B?OHp0cHFJN2w4dkFHQ2YyakUweGNnbnRGcjBYUENSU2xidUIzeDVpRytRTVRO?=
 =?utf-8?B?a0NZWStZaVJZckxRSXFnS20yOFhZVjBRWUh1aUVJcVdOb2lkUzNTajRuRktE?=
 =?utf-8?B?WjdwR2tjL1BaRGI1YlhwUm9VU1BRcXhVU3JzZCt6L1JEZ1J5QUpqakplVzRQ?=
 =?utf-8?B?UGhXVWJHWS92OWV2RWN6NTgzVHJhRmhtaUwveFpHTHNMYlZUTHF1RGtpanB4?=
 =?utf-8?B?dUQzZFd5N09Td3N4VXhoT1VHYW95UUtLSmZVT1NpUDFQSlEzSm1VSUlZOXA5?=
 =?utf-8?B?VDMyT0F4dXlBWDA4eTh0dnFSK0VXdGhtOTR3aUtIcTZxVk9VYnRKdEJJRDVM?=
 =?utf-8?B?azBaMDJWbEVEQ2ptTGhJQjhHc2NKeXh4S0JTL0xZMkRRbnZ5Qms2cjFMWWRv?=
 =?utf-8?B?dUk5NnRPdWIrNlgvR0RTQlJFc0JQUXdITld6ZXBERkVhM1JiT2hnMjRwemw3?=
 =?utf-8?B?YThCTldTeFNMNDFJUWFMTE1iQUFrOEV5ZXNNcFRHVWJCSmc4bnR1Nzh2YWtX?=
 =?utf-8?B?aVM1REd2YTg5VUdWRU53UGZKbUlyVzg0SldDWngzeXFQS2xYVTRqWjJrYzBM?=
 =?utf-8?B?S3lyK0xZcHIwd2F6QnhVK2pKN0k4SFZxbTlFL2dBVEZJeXFMTGRTSmc4bE5P?=
 =?utf-8?B?Rko1czdveGRQOCtWd3UvRnU3WDRWQ0lOOEJucGsydDVKbFdENVkydz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72fe5520-7612-49d3-8f03-08de7826979e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 06:40:28.2443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjpIVZteDN5V7D70tttCLJC04Lllm2KZVpWQe9ZZJSujzivVj5cKU3cps4blYKf5sj2nRWO4Y0OKYs4jgniTnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11728
X-Mailman-Approved-At: Mon, 02 Mar 2026 14:22:38 +0100
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

From: Ye Li <ye.li@nxp.com>

System Manager(SM) has implemented the MISC protocol to retrieve DDR
information. Using this API, U-Boot can obtain the DDR size dynamically
instead of relying on static configuration macros.

This change addresses the DDR ECC enabled case, where 1/8 of the total
DDR size is reserved for ECC data. The scmi_misc_ddrinfo() returns the
DDR size with EEC overhead already deducted.

Implementation details:
- Query the DDR size via scmi_misc_ddrinfo()
- Replace direct REG_DDR_CS[0,1]_BNDS register reads with SCMI call
- Switch from PHYS_SDRAM[x]_SIZE macros to runtime detection
- For backward compatibility with older SM firmware, fall back to
  static PHYS_SDRAM[x]_SIZE configuration if the SCMI call fails

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/mach-imx/sys_proto.h | 37 +++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c         | 75 +++++++++++++++++++++++++------
 include/scmi_protocols.h                  |  3 +-
 3 files changed, 100 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/sys_proto.h b/arch/arm/include/asm/mach-imx/sys_proto.h
index 46da7a1eff5..13857b921a0 100644
--- a/arch/arm/include/asm/mach-imx/sys_proto.h
+++ b/arch/arm/include/asm/mach-imx/sys_proto.h
@@ -254,6 +254,43 @@ struct scmi_rom_passover_get_out {
 	u32 passover[(sizeof(rom_passover_t) + 8) / 4];
 };
 
+/**
+ * struct scmi_ddr_info_out - Get DDR memory region info
+ * @status: Error code
+ * @attributes: Region attributes:
+ *              Bit[31] ECC enable.
+ *              Set to 1 if ECC enabled.
+ *              Set to 0 if ECC disabled or not configured.
+ *              Bits[30:18] Reserved, must be zero.
+ *              Bits[17:16] Number of DDR memory regions.
+ *              Bits[15:11] Reserved, must be zero.
+ *              Bits[10:8] Width.
+ *              Bus width is 16 << this field.
+ *              So 0=16, 1=32, 2=64, etc.
+ *              Bits[7:5] Reserved, must be zero.
+ *              Bits[4:0] DDR type.
+ *              Set to 0 if LPDDR5.
+ *              Set to 1 if LPDDR5X.
+ *              Set to 2 if LPDDR4.
+ *              Set to 3 if LPDDR4X
+ * @mts: DDR speed in megatransfers per second
+ * @startlow: The lower 32 bits of the physical start address of the region
+ * @starthigh: The upper 32 bits of the physical start address of the region
+ * @endlow: The lower 32 bits of the physical end address of the region. This
+ *          excludes any DDR used to store ECC data
+ * @endhigh: The upper 32 bits of the physical end address of the region. This
+ *           excludes any DDR used to store ECC data
+ */
+struct scmi_ddr_info_out {
+	s32 status;
+	u32 attributes;
+	u32 mts;
+	u32 startlow;
+	u32 starthigh;
+	u32 endlow;
+	u32 endhigh;
+};
+
 #endif
 
 /* For i.MX ULP */
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index c1458ccca3c..2ac2a93e796 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -58,6 +58,34 @@ uint32_t scmi_get_rom_data(rom_passover_t *rom_data)
 	return 0;
 }
 
+int scmi_misc_ddrinfo(u32 ddrc_id, struct scmi_ddr_info_out *out)
+{
+	u32 in = ddrc_id;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_IMX_MISC,
+		.message_id = SCMI_MISC_DDR_INFO_GET,
+		.in_msg = (u8 *)&in,
+		.in_msg_sz = sizeof(in),
+		.out_msg = (u8 *)out,
+		.out_msg_sz = sizeof(*out),
+	};
+	int ret;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		return ret;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out->status != 0) {
+		printf("Failed to get ddr cfg, scmi_err = %d\n",
+		       out->status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_ENV_IS_IN_MMC)
 __weak int board_mmc_get_env_dev(int devno)
 {
@@ -335,25 +363,44 @@ void enable_caches(void)
 
 __weak int board_phys_sdram_size(phys_size_t *size)
 {
+	struct scmi_ddr_info_out ddr_info = {0};
+	int ret;
+	u32 ddrc_id = 0, ddrc_num = 1;
 	phys_size_t start, end;
-	phys_size_t val;
 
 	if (!size)
 		return -EINVAL;
 
-	val = readl(REG_DDR_CS0_BNDS);
-	start = (val >> 16) << 24;
-	end   = (val & 0xFFFF);
-	end   = end ? end + 1 : 0;
-	end   = end << 24;
-	*size = end - start;
-
-	val = readl(REG_DDR_CS1_BNDS);
-	start = (val >> 16) << 24;
-	end   = (val & 0xFFFF);
-	end   = end ? end + 1 : 0;
-	end   = end << 24;
-	*size += end - start;
+	*size = 0;
+	do {
+		ret = scmi_misc_ddrinfo(ddrc_id++, &ddr_info);
+		if (ret) {
+			/* if get DDR info failed, fall to default config */
+			*size = PHYS_SDRAM_SIZE;
+#ifdef PHYS_SDRAM_2_SIZE
+			*size += PHYS_SDRAM_2_SIZE;
+#endif
+			return 0;
+		} else {
+			ddrc_num = ((ddr_info.attributes >> 16) & 0x3);
+			start = ddr_info.starthigh;
+			start <<= 32;
+			start += ddr_info.startlow;
+
+			end = ddr_info.endhigh;
+			end <<= 32;
+			end += ddr_info.endlow;
+
+			*size += end + 1 - start;
+
+			debug("ddr info attr 0x%x, start 0x%x 0x%x, end 0x%x 0x%x, mts %u\n",
+			      ddr_info.attributes, ddr_info.starthigh, ddr_info.startlow,
+			      ddr_info.endhigh, ddr_info.endlow, ddr_info.mts);
+		}
+	} while (ddrc_id < ddrc_num);
+
+	/* SM reports total DDR size, need remove secure memory */
+	*size -= PHYS_SDRAM - 0x80000000;
 
 	return 0;
 }
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ecab021b472..555ffa0a61b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -54,7 +54,8 @@ enum scmi_discovery_id {
 };
 
 enum scmi_imx_misc_message_id {
-	SCMI_MISC_ROM_PASSOVER_GET = 0x7
+	SCMI_MISC_ROM_PASSOVER_GET = 0x7,
+	SCMI_MISC_DDR_INFO_GET = 0x22,
 };
 
 /*

-- 
2.43.0

