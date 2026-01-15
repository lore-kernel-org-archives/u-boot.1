Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919B8D44C48
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 14:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E8B80325;
	Thu, 15 Jan 2026 15:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TIUObNe+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1291082BF2; Thu, 15 Jan 2026 15:20:22 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AE3A80077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 15:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lcJroou3UZr2Y11Y2gvESnJsuGhod65yiZhQhHMsEX9AxaOlVW9JpERzFMsEBdNb40XrgpnxSYVYc2KMxAqxPIdUm3FNwM0FiOW47TODcxLppEMUiyuZLi9P9hDzIbSGM58yU2YnpUdGdT9lEBN6vQZKRQwqQZbuthivS9sDmRd/mqUtSeLwSUoquNLDYXy1S2kbtdQSeQ1dvxY1fcWFLR6TujP4DGRN/qSvafcLnfwM1Cx2+Bs+LxLw+TwZxZU2XBqz8tJh2FonAcrqEGBvPoIqJ168iPBAnlRx816XwokiRUF+kJLv+HuONyxenEf+3YO7S6O8ZsvyEV3yWrA9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASDNov++SRCX4DHaRNB6P2g6toLgeVw+DmXOkyW11GI=;
 b=NIbO+pBopQTU1S89MbB2aOgUYTBISSbjb/Eup3/S+goEm8vgoonZ/e5QHbpKzNeJ1gHVU1Ei7qSbRP7tGgTscKncBHXDux/QCc/kV5pmGoIy6PkdDZGvL1u+TwkggUigANO9X7ori4sfslZpV3FdhHBSgAsDlwGAjZ58AUIMYkqQun6YP7q35p+VxqfT7boB5xIpCk/QrAHusYM1phEWJw794dIxbmIR13bnp5xHxEBlawn3UBcF0fRr9NVUJNlS5ztvfZoaiOFIkR394HTZVRDniP6vVk04vkcwKeFzZ9vH/xrid02qDQaq6Z0x7Su/GxwAP/x2gAHEZoaEN3vLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASDNov++SRCX4DHaRNB6P2g6toLgeVw+DmXOkyW11GI=;
 b=TIUObNe++XJP+PHLyWqLDZYnRh9IczVjOxOYevWg9nQUw+opNC23GoAe66fH0eQnWFFsFMcj/2+9ASqY9fCtZ4gxp2JiFhFhL0sdmhw/DmVaLaPE5v6jsPPp0bbDiYW7cGt76krqp1RqOVWLLgXAgaNz7pefDwaiK9au4y2HXQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:20:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:20:15 +0000
Message-ID: <36c506b5-228d-47ab-ac6f-fb6dd784ff46@cherry.de>
Date: Thu, 15 Jan 2026 15:20:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260106203433.3133926-1-jonas@kwiboo.se>
 <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
 <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
 <a8a8dd8d-dfc2-4274-9203-a88d9bcb8a69@cherry.de>
 <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a823a8-a284-4a5d-5a80-08de544133fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFRlaWhMY3cxOUNTM1lwdkw2TGhOb1YxYllHT1dRQS9ZYmlmT1N0OEZPUGY0?=
 =?utf-8?B?Yml2QllFT2IxbHVJbTBlNzZ5YVVMU0NFa3NURUZpbU4xNXpENzlMRDNFY0Q1?=
 =?utf-8?B?ajY5NVhSTHhuTDRjY01FQ0dWV2UyZlg2ZTFRRk1VekpSZVZGL1cyY2FFQXln?=
 =?utf-8?B?NHdGcnM4Zmoxa1JtclNuK0ZpUEJmZ1pDL2QxQngyTDErYlZaL080aVR5cXlI?=
 =?utf-8?B?dGZ4QUZoY0Z3dEtuUGgvblh0VUdMUUdvaWZ1WXVnK3VFTEJVWXlRTURmekQ3?=
 =?utf-8?B?ZjM0R01KRGxUTldUcXluYzJtQXNpOU5lR1dPa3N5aXl1cm9QSVUrbUUrSmJ0?=
 =?utf-8?B?dGVXcUYwcXVlNU5wSGxCT0Q3S3N0dXdaSWV6VStvMGp6Ull1N25nWk1GTnll?=
 =?utf-8?B?cm9KeVNjMXQ5NWtUZFBiVng4YjNxYXZtekh2cE1CL2V6NVdMVy9vdW5yMVg1?=
 =?utf-8?B?RGxNTVVwK204T2szcDY1bXpDNlJCUlQ4V0U1YnpzZ05BZmpRYmN0N2dKTlZo?=
 =?utf-8?B?alRjb2ZmUFdzV1pMUzhnQnhiT3FraWdlcTlPUjdsN1RvZVNEeDROOVl1WVN3?=
 =?utf-8?B?WE9ma3RIVmx3VEpUSytDUkZ2cmZ1bEJRYytLdkdkaWtoSGlvVkdabjZ6NkxP?=
 =?utf-8?B?Y2t3eTZCRWNsRGNyZHNKRUx4QkNtcTZJa3RiM2pISzEwR05QVDNQNGg5V3ZV?=
 =?utf-8?B?ajV3cWJkZU5lNmNYQmw1OTRlWXVTZTlRb24rTU90R3BVVDQySDU0QjhZdlJG?=
 =?utf-8?B?RmkwWWdHd2s1OGRXTnE0MXJJS1h1b0JxL0NqQmthQXM1MmVKY1Y5cDU0VGpQ?=
 =?utf-8?B?enM2SHFWdTNPWXhxTnQrWC9GaDRnL09uNGQ1c2xQZWgrbWFpT3pXQ3Vxallp?=
 =?utf-8?B?UjZocXZDMUIrNEhxcFE3VTgrL2t1Mnhpakp6ZlMyckdoaEVYbEg5YlM4UkVI?=
 =?utf-8?B?TElSVEs4U0RwaGh1SUhPSy83emhHWFMrNHYxbjhEOFVJUjh5dGMvNFdEMkdl?=
 =?utf-8?B?MjM5K01vUkdHMGNsZkhuRVdRQ1BSQVB4emZNN2dGM1o3OW1landMTHJMSC9W?=
 =?utf-8?B?aHRYbW1CS1pNVlFocnA4dUFDQnhkQ1dSQ1NEWGNHVnBzRERYNm5ZT09KMW1W?=
 =?utf-8?B?M2x4N3FMZXpScXpaQ1dKM2NOcTdHdStUZ0VZNDlWYS9peEQ1Vm8zMzhja1h3?=
 =?utf-8?B?bFJZS01lWU9MRXpXUS9XZFp5N2pGQ2hiS1BlSjB3ZUc3eFN1N3lSd0tYOWY2?=
 =?utf-8?B?TUgyY2dadEZISDBLaHJydUN3aHBmdXZyZUZIY3BNWElISzlUNUlrY0ZuRktG?=
 =?utf-8?B?QWNuWXh5MFdoODRqMGhYTUJHNEc4UFFCcjVRYzVWMndPa2xEaExmWHAwbCti?=
 =?utf-8?B?LzVyNkJVL0sycW5nVEN6L2ZwN2dMTzdjVlhjQW1SYVNhUGl0TTJVaitHNG5i?=
 =?utf-8?B?a0R4RTNPcWhYOHRhOXo5bzlJYmQ4d211dVdqT2RtU3NLYzl1SnJOdVlZTEg2?=
 =?utf-8?B?V0lOdEdLdXZGa1FnTjF6WDl3MFYvb2NpdzNVZW0xM2dncGFlT2lYL1JBYkcv?=
 =?utf-8?B?Y0N4aStWOGVOOW9wY3ZIUy8yTm5lN1Z2c0R0Y1poU1RxSzNVUnVmV01PdWdW?=
 =?utf-8?B?YjMvT2VtaTNKaWh4ZWtYaWNmYkdHdmZMQnBXWHFScWcvWDZxZ2JYN1NpVVZB?=
 =?utf-8?B?VWRCRlE1QUdMTEhoUnRmVjVuVVBrV0ZYdzFjQVM1dUhqaFB3dVFGdHQ1Rm5p?=
 =?utf-8?B?SndrRTYxUmxweUhYRmRIZHB3ZGpSaTg5WGRIVm11Mi9iYm0wN051WVVqYjZB?=
 =?utf-8?B?YnZrditidFFud3V0bks4UjZUUVhwQm5rL1VwOXBZL3JLalJvSy9ERUxBZW5t?=
 =?utf-8?B?MWxXckpJMSs1WGdGVTNaUi91Zm43MzNNMXZCOXhnMlYwVGFDVVdpUWtKT0lu?=
 =?utf-8?B?czB2U2xwQUpqSnY2VDNaRUJySjJKakZ4OUNQRW94dTVtNnQ2MWVaa09vdHZJ?=
 =?utf-8?B?dVp6R2xsV0F5cC95dUxZV2dwMEo1UzE5cFNsY0dXMDNBYVVmR1lnS1p5bjhH?=
 =?utf-8?Q?FQJ8Z+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmVHNU9PcGJhVVljUjJJTEZ1emYrWHUrN0gyOTFHd1FtODlTM3R2QmYyZURs?=
 =?utf-8?B?eTFkdUQxS3JhRTZQejdocm5pdGtxdWxER2t5bVVwNi9vMmMwanpRUytxQ3pZ?=
 =?utf-8?B?RzYxdzF4bHUyTUxOOWUzTGg5WGYvQ0h5UlBIUTBMR0R4Y000cElhM1lDcE9p?=
 =?utf-8?B?cE9GR05NOVNlRURKOVFvY1psOENNWE4wdGovV28zYTRxY3FGdkJhTlA4N3V3?=
 =?utf-8?B?WHA2Wlh2akdLQjhGQU82c280VlNyMkdXb3BzcWVIV2FhR3RSSURZZ0dVdFJ2?=
 =?utf-8?B?UnZMUEhUNzJwSWRBbHBKMlFMUUpvM1BrVDBQdzJ4dnFWN1RHeklDcmlBWHpu?=
 =?utf-8?B?RW5maE8yZ2ZyT3lpbnJHUXBUR0tCZmszVVVZNkFsc1dONStHeEdkbW14VU51?=
 =?utf-8?B?UG1GclR1RjljNVBjYWYyci9Sb2NQaWc2S3FqMW41aGx3Vk5qSzNFRjVxNHRq?=
 =?utf-8?B?dFg3TStuKzhmUENpOHNYS1h2ZUN6RkplbFNOZnJBQ1lEdUVEMmtlNGVGK2Yr?=
 =?utf-8?B?bUtadGJXYjlad2Z5MnBiU2Y0WWhNb2NrUE54MGhGVnoydTV0QVF6bTNMVVc2?=
 =?utf-8?B?TDFhMFZsamlKc0VRWHNkNDRYS2dSNk1oOWpYSERtUEZYMDk0bldTN3RWaStS?=
 =?utf-8?B?QktZT0tWemI2RFJIdWZPajVGREJUcTd2eFdRMExDRnMyNW1NR3pPeVZpbFhj?=
 =?utf-8?B?aGR3dHZDTTJ1RGRnc1ZhYmRNakNBaGRuN01WM2VJQzVvbUZQTEQ3RTNZZ3F0?=
 =?utf-8?B?d25ETkJMdXRmYi9xS1pOUE83ekpvaXFzZnJ4RE5jV214cGVyR2ZGck5MSTgz?=
 =?utf-8?B?QjQycjlkaVN2NzB6QjRTU3JSRWc2VDRpSGNIYWVmb1RmQXR0WHl3NCtOdU5n?=
 =?utf-8?B?YUYyQ0svdDV2ZGk2K2FaM1Y0bHVRVkpyV3NJaWl3STd2cTZPdHdxM3gvQTJr?=
 =?utf-8?B?dEJ6RFdlN2JhYlVGSUxKeURpRWQ1a0dNR2xDWTRWVkdZRENqa1Jzb3RMUTFl?=
 =?utf-8?B?UCtWdWc1cHhUZzJiNldocmxTSW13blRQcGRrYXJBeEJVNlZTVUx0bXRxeEM5?=
 =?utf-8?B?NDhZdFFTM1hpKy9TV1dKVXFlZ3RkK0ZlUmM3QXRHYWRidG53REd0N2lZcEgx?=
 =?utf-8?B?M2UrZHZQY0VXODNNSStEZXk4Kzk1Z0RDaFU5ZVJHMEtiVXlObFQyRHNVQUU1?=
 =?utf-8?B?eUo3ZVVITWxURHNHRE1pWGFLcmVSOGdXeEJsRnJ0WWRONmQ3aXh6OXBRV21m?=
 =?utf-8?B?dzBoWlpZeGlVNHF2YVl3V3JFTXdzOTM3M3BVY09aR0FOcGVRREpYRUp2dXF4?=
 =?utf-8?B?SDBZRSs4bVNjZDJackIzc205Wk1tYmZML2h2Z3RSR0d0R0tGUHpjcEhjU0NX?=
 =?utf-8?B?bm56ZGFuZHlEYUUvaUJQc2tpNExxMzhGdXVKbnRTYVpyYmEzeGNvWkpQQ0d6?=
 =?utf-8?B?SUFHTFlqZGJuN3hnUjdBV051R0Z1V3BjQnZzZlF1Tk1yZGFkVS9hM1JIKytn?=
 =?utf-8?B?NGFxM0l1QmhQNnVaUFllbXhjdHZqRTF0SFJicjdJZEF3T21NT2VJQVU3Ym5m?=
 =?utf-8?B?eFpYS2o3ODdtcmxtZmdneGNiVkN6MEpYMHYxWlYrV3BwdlhxRTRWOTlsSjdO?=
 =?utf-8?B?czBjSkp1VnZVL2x0KzBuYXhVbGM5TDRpcUdWcnlqR0ZWa0dlZU53ZHVVcXVn?=
 =?utf-8?B?eHdTb2R6dk5xTm9xa3NaOXhqSStvVFBEY3FVNXhsTzRRZ0tod01JaUhacmFx?=
 =?utf-8?B?M3NRMXpJQjZFemF2MHhxK1hSZ3kzNVZ3MWxVMnJBN1p0cndtbTgxR2R1SzZI?=
 =?utf-8?B?cjcwczNveDIzTEprL3VXWW93SmlDWnRhVW94OHljTURQU1ZpVTZpbmhTQWNL?=
 =?utf-8?B?ZklRNmpnTzBHOE1ZaEtTSjV2MjVHdEUzb3BGeXZDQVlRaVluOElaVGxCOUVI?=
 =?utf-8?B?c1dIVkRlSjRtamF3ZU1Bek9mVkRnS1pFUHdiRUpCcWhHMkpNNS9wb2liKzh4?=
 =?utf-8?B?MkNLKzMwRW9rSlZwMGZQb29GLzZCVWZncXkwMnZkUWt6STNMVWRxQm1zWGt4?=
 =?utf-8?B?cVFvTlhiVllaRk9TUU95dExMQTZNZ0dWZUhKbmxCNmRaWmJjVzVTNFFLTDVQ?=
 =?utf-8?B?Wml0aEVjWGFDQlNlcDhYaWpaaktlSytkNGw3QzV3MXE5emYxS0FVSEYrM3dX?=
 =?utf-8?B?TGdBdTFwQU80eENHKy8ycVpYUTh6M1dZNzZCaXdWaUFxbUFkNE8zM2VPdXFH?=
 =?utf-8?B?aU9BKzM1MWNHL25kZ05OazFRL1o1SndCL2l1cm5JZDV4NWFoMEVTWVZObGNI?=
 =?utf-8?B?NXM0NVVMRWVaYzRkWFZtKzU0RHUxamt2TFJaMHltbVZ1R1dERy9DQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a823a8-a284-4a5d-5a80-08de544133fa
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:20:15.5804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BdBLsoLqnH63sWA6J+XZIeErKJ42U9CX0/kZfo32JTmKjRUXxb/Y8I2alb8J0LheXEyPQK9OvtgWc2SYAOkyweE7XMK4dNEKTyjqq+VbDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291
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

Hi Jonas,

On 1/14/26 7:29 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/14/2026 6:08 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/14/26 4:37 PM, Jonas Karlman wrote:
>>> Hi Quentin,
>>>
>>> On 1/14/2026 4:01 PM, Quentin Schulz wrote:
>>>> Hi Jonas,
>>>>
>>>> On 1/6/26 9:34 PM, Jonas Karlman wrote:
>>>>> With the legacy networking stack, it is possible to use USE_SERVERIP,
>>>>> SERVERIP and BOOTP_PREFER_SERVERIP Kconfg options to force use of a
>>>>> specific TFTP server ip.
>>>>>
>>>>> Using the lwIP networking stack use of the 'tftpserverip' environment
>>>>> variable provide the closest equivalent functionality.
>>>>>
>>>>
>>>> It does read serverip environment variable if it's set, so this should
>>>> match the behavior with the legacy network stack no?
>>>
>>> This is what I first thought, however it seem that the lwip stack differ
>>> slightly from the legacy stack, in that the dhcp lookup always seem to
>>> reset the serverip env var.
>>>
>>>> As for BOOTP_PREFER_SERVERIP, this would need to be implemented in lwip
>>>> and isn't covered by this new variable is it?
>>>
>>> For the lwip stack it looks like the BOOTP_PREFER_SERVERIP Kconfig
>>> option possible was replaced with use of a 'tftpserverip' env var.
>>>
>>> For legacy stack I had something like following in a .config fragment:
>>>
>>>     CONFIG_BOOTP_PREFER_SERVERIP=y
>>>     CONFIG_SERVERIP="192.168.2.50"
>>>     CONFIG_USE_SERVERIP=y
>>>
>>
>> And this meant the serverip would not be overwritten by the dhcp command
>> for example (in the legacy stack)? When doing PXE/TFTP, I always do
>>
>> setenv autoload no; dhcp; setenv serverip X.Y.Z.A; pxe get; pxe boot
> 
> I tried to keep it as simple as possible, as I have not used network
> boot before, and used something like following:
> 
>    env set boot_targets pxe; bootflow scan -lbG
> 
> and when I need to use a USB Ethernet dongle I use something like:
> 
>    env delete -f ethaddr; env set boot_targets usb pxe; bootflow scan -lbG
> 
>> When I control the DHCP server, I can actually set the TFTP server
>> directly and can skip setting the serverip as it'll be set by the dhcp
>> command correctly it seems?
> 
> For my homelab I use UniFi and should be able to control DHCP options,
> however looking at U-Boot it looks like option 66 or 150 is just ignored,
> see [1].
> 
>    case 66:	/* Ignore TFTP server name */
> 
> [1] https://source.denx.de/u-boot/u-boot/-/blob/master/net/bootp.c?ref_type=heads#L952
> 
>  From my very limited testing it looks like I am forced to set serverip
> in env and cannot use a DHCP option to set the TFTP server to use.
> 

Still on my RK3588 Tiger (on a different network, legacy stack):

=> env set boot_targets pxe; bootflow scan -lbG
Scanning for bootflows in all bootdevs
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------ 
----------------
pcie_dw_rockchip pcie@fe150000: PCIe-0 Link Fail
Scanning bootdev 'ethernet@fe1b0000.bootdev':
ethernet@fe1b0000 Waiting for PHY auto negotiation to complete...... done
BOOTP broadcast 1
DHCP client bound to address 192.168.1.144 (5 ms)
missing environment variable: pxeuuid
Retrieving file: pxelinux.cfg/01-aa-38-40-51-be-af
Using ethernet@fe1b0000 device
TFTP from server 192.168.1.211; our IP address is 192.168.1.144

My DHCP server is on OpenWRT at 192.168.1.1, and my TFTP server is on 
192.168.1.211, with the setup steps explained in my first answer. If I 
don't boot (remove -b), then I can see serverip is set to 192.168.1.211.

So *something* is working here.

> And when I then also tried lwIP, and that seem to result in new or
> different issues, e.g.:
> 
> - lwIP seem to be configured to allow very few packet fragments, trying
>    to use a reasonoble tftp blocksize, e.g. TFTP_BLOCKSIZE=4096 or more
>    seem to cause drop of packets.
> 
> - lwIP is very very slow to timeout compared to legacy when serverip
>    point to an invalid TFTP server and pxelinux.cfg files is looked up.
> 
> - sometimes got hit with random SError issues when second file was
>    loaded from TFTP, this issue was thankfully fixed with [2].
>    

Rough first experience with lwIP :)

Are you planning on new Rockchip board/SoC support to use lwIP?

> [2] https://patchwork.ozlabs.org/project/uboot/patch/20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org/
> 
>>
>>   From my notes, for an OpenWRT DHCP server:
>>
>> Network → DHCP and DNS → PXE/TFTP tab → Add button
>>       Filename: default
>>
>>       Server name: fileserver
>>
>>       Server address: <TFTP server IP address>
>>
>>       Force: checked (may not be necessary)
>>
>> Save & Apply button
>>
>> I'm assuming you need this for your labgrid farm so hopefully you have a
>> way to control the DHCP server :)
> 
> Correct, I have been playing around with network boot in my labgrid farm
> and hit a few mines along the way :-)
> 
> Should result in a few network related patches in next few days.
> 
>>
>>> Adding NET_LWIP=y made pxe booting stop working and 'serverip' always
>>> ended up as the dhpc server regardless if it was set to something else.
>>>
>>
>> Interesting. With tiger-rk3588_defconfig (legacy stack), I get:
>>
>> => setenv serverip 192.192.192.192
>> => setenv autoload no
>> => dhcp
>> ethernet@fe1b0000 Waiting for PHY auto negotiation to complete........ done
>> BOOTP broadcast 1
>> BOOTP broadcast 2
>> BOOTP broadcast 3
>> DHCP client bound to address 10.2.162.193 (1394 ms)
>> => printenv serverip
>> serverip=10.2.0.122
>>
>>> Since lwip instead prioritize the 'tftpserverip' env over the 'serverip'
>>> env for tftp use, adding a similar env var Kconfig option was easy but
>>> may be wrong path?
>>>
>>
>> I don't mind the addition but I'm wondering if it's not a band-aid patch
>> for something else? Maybe lwip missing setting the BOOTP server from a
>> DHCP lease for example?
> 
> Possible, setting tftp from dhcp also seem to be missing from legacy
> stack, if I am not mistaken. I do think the separation of tftpserverip
> and serverip for lwIP stack at least is a step in right direction, I am
> new to network booting from U-Boot so what do I know :-)
> 

I'm not sure the point of lwip is to keep all the quirks from the legacy 
stack, but it doesn't hurt to bring this up :)

Cheers,
Quentin
