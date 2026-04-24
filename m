Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1E47FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 849E984312;
	Sat, 25 Apr 2026 18:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oPxxacKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63EF584277; Sat, 25 Apr 2026 18:07:39 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F4288421D
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
Received: from GVXPR04MB10475.eurprd04.prod.outlook.com (2603:10a6:150:1ea::5)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 16:07:19 +0000
Received: from VI1PR04MB7120.eurprd04.prod.outlook.com (2603:10a6:800:124::18)
 by GVXPR04MB10475.eurprd04.prod.outlook.com (2603:10a6:150:1ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Sat, 25 Apr
 2026 06:31:56 +0000
Received: from DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7)
 by VI1PR04MB7120.eurprd04.prod.outlook.com (2603:10a6:800:124::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.23; Fri, 24 Apr
 2026 19:23:35 +0000
Received: from PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 19:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsTNUDXwyXcBKYk9F2eC5R3F+zhpAhmAfBrXwmuLdQLcYZwyxqKVqxbAVKbHKBrE3AjSJ0kMkN75v5SnC9sVPY5ArKU1Xh1IZ4cYFlkUj2M6SmCgdmErJcmMvAyfsQvRkBcNT8NxNc8f+CI4rj8AOW4+CDB7uIFLOe0APlH+7mYlH4eC7AK+DDZQI6patFf6eRWEpJCqyKbqx8XSlSipo0+4biDgt0k5Tt1d3vZs45vOl4lTAoj1WDg5rdX9OMCxIbaiu8R2Xf11Wlh7oKWIA5ycMZ1kNIGnqTXhd9Ge1YamzzNjuktJ/cfN79L6Ebg5Puf6KYO/VD7rk6Oit7uvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXhN7pVCDlcKnOB8lEtcDyw6v4vRwAwcaRsMF7C5Kog=;
 b=ORRM1nG6Z4Io08PWlyLVI25FP3E5axRc0m/wfEg/NrCPu20YSRjrEIDdGxyIhCjPrtDtQ3Il/jiZ62nhkPMIa3HboQdo+jx/nL4yBQBcsnZ5s5lBHbqN7eT/ddhabOHveTTZV2+XTsE//KzsxEG7DuXThvVmFsFi1oF+V8N5Fk9jwF0/YfI6vyVNXrYnOOxt1m4Ea1EfycKrrPXw69NfNmS7LJvgtw9DA6VmGtVhZ1AolOa/K3/x2R2SUEmCR4fs4dgbIo1BxGe9A7X0UlIgsk8Xa79npP+5Lj8yiKujh4Aem2FJ3DV50YlYDSf2qv+W7gItlRG6KWN4PFzFxurHcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXhN7pVCDlcKnOB8lEtcDyw6v4vRwAwcaRsMF7C5Kog=;
 b=oPxxacKNftRvv/h35PNe8UM14FuZjo+Z8Isanqab1DhR24C6G6Ob+CcB/s7QvvvNHWCIH5cLwUTc/sqoj12dTbmqOQ5JF7pT99c0OdLHSF3qzDU/mzc85Heh9suov3z2Ftn4BZNpMxhUiUO6/6u+JpxhJVjOMp1e5qnSadqZHDo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8960.eurprd04.prod.outlook.com (2603:10a6:102:20f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 17:02:25 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9846.017; Fri, 24 Apr 2026
 17:02:25 +0000
Message-ID: <4264e62d-2b59-48d3-a619-aa2a7c6dee89@cherry.de>
Date: Fri, 24 Apr 2026 19:02:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Add FIT multi-DTB selection for Qualcomm platforms
To: Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org,
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com,
 jonas@kwiboo.se, marek.vasut@mailbox.org, peng.fan@nxp.com,
 sajattack@postmarketos.org, balaji.selvanathan@oss.qualcomm.com,
 wolfgang.wallner@at.abb.com, e@freeshell.de, yangshiji66@outlook.com,
 jan.kiszka@siemens.com, funderscore@postmarketos.org, hs@nabladev.com,
 kory.maincent@bootlin.com, jj251510319013@gmail.com,
 carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260420181159.GA2373171@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260420181159.GA2373171@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0215.eurprd08.prod.outlook.com
 (2603:10a6:802:15::24) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8960:EE_|DB8PR04MB6796:EE_|VI1PR04MB7120:EE_|GVXPR04MB10475:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0ff719-f41a-4621-b3f2-08dea223425c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZbKzkg9TpZRn5ei3dwC+DyXIiY2MX6u6sI2O+/+S21g4gUGumeflCD45UgR3rqf4NIiG8DYk1hTSg+6IHUANDUrmOoVZxDdvyv/m+NdkCwXDSWxhPwF8F117c3gmt9R6LRd0VBQRw+mfiXpWqGjufBTngr6znwhKuxba2C4CaPSdnA786DiakTHGQdfN5gbh80DszaJWK1IqNYjxkRJDDGnsHu4YQ/piISCXAfwWRA8Idshc7sXLoiWJ9fkElXchgid8oUmD34dbL6xOKhbfZcM53rgy9atxPscCvzrGDcIwwnsAyndTg2auUONTLVSUMk3wnLonUVdjy8XyvDNZuyoOywSl2JrrT6gzkc6XNriOZ+8WXyOaL+s11u0YYKShyvfBCgDX0CsQXYcVn2Bt98LVDkOW6V41pOAMXm+hUDpEKAAuGxGMvsoakxS8vG+alXaB4zBTQ64MISA7n+GsP3WXDDb1jXp0Zo/DkrbeHuI3FH3lXs/4D9+EvZ5+Iq7Vn3u4PRQKkCTMIUMvqhx+UPzaPircdaqr9XF1CmEUZkaDKu0JK80giACMoMW8xuuHnn7FEF1taNw2wHJX7SaysFFi32ELTD8/okAUk9x25yIaEWc15fmX/UIYk6Ar6qA7FrpH5LvZSydSovcHDTJGOZM9cQQh1S1r3qQSB0RTcbqGgYxkFX3qRxoFUlui4zvEWr7JgVkuoIJ2qKoaK8SfWwxuTWxs+7zJiCp3TVsSAE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTBJWHFBVXdUaE9heHhlSWx0S0IrY3RnalllSllydHpqYUp5aUJvODZmUW5M?=
 =?utf-8?B?Yjc5bDg0NG5iUTFqb1p0em9rZWZaS1Vwa0dLeEptK0RSZUZ3RjZKdThBNGNF?=
 =?utf-8?B?dVAzWTVSY1ZwUHdoVFlqSjRjVVM0UTl1YUxMRGFtSzRxRlpHTGc3SC9vMEFH?=
 =?utf-8?B?RS9tcEd6U2pjNTFRamRpNXphekhLTDhiMWRwM1VMZ2p0TTF1eVBrK0d6R0I4?=
 =?utf-8?B?SlVDdlNaM3A1c3UxeERUOU9PUGlrZ0E0L0ZnZ2JoTGluM1RDTFpIN0tRYmlZ?=
 =?utf-8?B?K2JuL2hkb2FrQVAzMVBueTYrM0w3Wnc4aWJrS3lycS9DNnJzOFZTaVNWSUZL?=
 =?utf-8?B?eGp3WitUcFhNMmhVbjVocVpSRWlQdWNTUzNlZUtQK0xHVTJuSGphN3JmMHMv?=
 =?utf-8?B?RFdWV1d1VmloR2R2Mm9iZDdXRk5JRmVXaTU5cGIzYi9Cb2JVTU8yU2xPQ08y?=
 =?utf-8?B?L2IxcGM0bTRlZFFGQVNUVlJHMFMxSHRTa1pkeG43dHJuUXRqUVluY2d2V2hW?=
 =?utf-8?B?YWFOSDcrZzBreVRjb0NTckZ2QnRWd3FGNG5JQjI3S3p4a3VjL0EwMFJWQVBT?=
 =?utf-8?B?UUQzMk5BTm1HYTdiTW9GZlY1RVU3b1RFdWRIcFo1M1RwYXBMd0pvbGN2aFB1?=
 =?utf-8?B?VjJtQnowN2s5Smd2aUJJcHc4TkdOT0Job1kyQ3RoMXU0ODZkTkRBOUo4aGZy?=
 =?utf-8?B?SFQ5MzVUY1VEMHhZUDZEQjdnWjArYWdNNUErRVJIOGExYVdjOTJmazF0UHlO?=
 =?utf-8?B?MWhGaXliaUQ4M1FRbGV6cmRscUd2NnBaNXNZN2N0TDY3YTErNS9xV3lWTGJy?=
 =?utf-8?B?em9Qdlc2NVkrVWdTTXcrM2dMVHNJVnZtMWlhaWU1TytjQ1NBTTVXcmFoemlW?=
 =?utf-8?B?VmdKTW9INkNscjRhWjFPY2lTZVlmZzIreEU5cFI5MUNWVFptNjM2OVJ1TjZa?=
 =?utf-8?B?VlFuQkJPV1VDcDF5dlhiMytJQTNOVGdwTHZnOGZXNTBhSlBvTFhmb0lFbnlj?=
 =?utf-8?B?OFQ1YkZoK2U2WVo2RnVQUC9DV1NkczNOQkNpeERCS2phaXVOZGdQYWc1cU5y?=
 =?utf-8?B?L3Q1NnpCOGZyNmJIZjRXSHFLc2N0MDhLcE92Z3JJdzhwZkRmTE1YdCtnKyt5?=
 =?utf-8?B?YzFCWm5RMFBHYW5aWjUwZWE2TVhsc3RJUnJodjN5MFUxd0E3TldCUlhsYVo4?=
 =?utf-8?B?S0ExT3VUQXBzZ3h3ZUhIWG1tSEVONlBQZk1nYTZXTWYzWmlna0lWc3dUMG9i?=
 =?utf-8?B?SnkwOWo2TE9tTzRnd1U2Y3NaVjZQTVowVzgrdnlqZkhnbWxTcUpnUnhyWUkw?=
 =?utf-8?B?SkFSMmkwYmNJallCMnM4eFlodE1BRUs1ejYzWWdUQmJqMEozNktDbDFZNjlN?=
 =?utf-8?B?cTdXWU90UVYzRU9EYmtCcWdwUkVlajJaZjVudEF4T25Yd0xORFRQb3ltL0Fw?=
 =?utf-8?B?OWo5c1JZbWlFSUtsL1FOengzaDlTL1Z6RXdnTnZLU3VjbDVxWVRpV3NFeVp1?=
 =?utf-8?B?Y0I3ejYxbjFtUUVVOFdINFBDWHJ4dFMwU1hJVGlaVWF2WjVreEJWUUdxOHRJ?=
 =?utf-8?B?dUlOTGhDNzQ0cCtMNC9mdXJwcGRETW9oTEx4dk1HREc1cVFhVCs0ZDhadVR3?=
 =?utf-8?B?cm5ORXFWYzVOZXZxM09QOW5ORGVQeHZPa1JKL3lOZFk4RTlIeVZTZlZJSEl4?=
 =?utf-8?B?YytxdmNoeDNmVHhQZS8xZFNPd0p0eEZaNFNFRGlONmtXaXVSbXNYbmw4NXls?=
 =?utf-8?B?QzNSdU5vUnFHN3lYVU56V0k3cmZsTE42ZW00akxrajFaQm9udElRdEhvT0hB?=
 =?utf-8?B?amJ4VDhBbXdSTzNZeWR1VjFCQllMbXBSNHV6RW0yWXRDWmRSS1Y4cE5xTzlr?=
 =?utf-8?B?YUJpblFkaUYram44K0Y0QnFkUGJ3TkdlUk9Ca01qVWVsRXU1d1Q0c0ZocE9E?=
 =?utf-8?B?eFhLTmZ0eXROSHRxelc2clpRYTgram51VE9Iai9lOXRTWGVTblBWNXEvcEpp?=
 =?utf-8?B?K3FveU9uazZNREh5M2VIVWp3UVE2VU9mWmFUT2pXKzFuVVhWTGEwUUdKRVpT?=
 =?utf-8?B?UzhyWGNLeUJSbXFKTUwyTG91dFcyTUNxb3c3QlNISThtMG9JbVBjSkZFREJO?=
 =?utf-8?B?SzY2U1VIQ1NtbkhEYjF6U1dudmV5aExqeE5CUmc5Qk13L01PelhyRUd5WGN2?=
 =?utf-8?B?cFgva0Z5ZXFjRXB1T0dneFZqbVY3blBiUjdMbnREN3hYNFM3bjBsMnFKTXlx?=
 =?utf-8?B?ZzNSYStKamN1am45aVVlYy8wL0puTjJkZ05lMjUrWDYyRUt5Y3JURGxIWHZ2?=
 =?utf-8?B?b1JuSEcxNFlkajlUb0FZMnEyUk9KRk54U0U0UmIwM0JRbEJyQmdNc0tVOGhD?=
 =?utf-8?Q?tQWMbSaebG0D7n0gc8qd7kHrGMJ2a0e4AcNF8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ff719-f41a-4621-b3f2-08dea223425c
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 17:02:25.6005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DgYp7XWxFGKKyU609MU4P0cUIxGq30W+PW/l9/a9Qjq+6l1xG9sMZC6PxWGjbUd9sQfT4/Umbi3qNYZ/Yrf0ptG63CtNnQGA67o3Gzudng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8960
X-OriginatorOrg: cherry.de
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

On 4/20/26 8:11 PM, Tom Rini wrote:
> On Fri, Apr 17, 2026 at 05:39:44PM +0530, Aswin Murugan wrote:
>> This series adds dynamic device tree selection from FIT images for
>> Qualcomm Snapdragon platforms, enabling U-Boot to select the
>> appropriate DTB based on hardware parameters detected from SMEM.
>>
>> Qualcomm fit based DTB format is documented in [1]
>> The fit image contains only DTB, while the kernel will be part of UKI image.
>>
>> The implementation consists of three parts:
>>
>> 1. SMEM cache infrastructure: Provides cached access to commonly
>>     used SMEM data (socinfo, RAM partitions) to avoid redundant
>>     lookups during boot. Includes socinfo header from Linux kernel
>>     for SoC identification.
>>
>> 2. FIT multi-DTB selection: Implements the core selection logic
>>     that reads hardware parameters from SMEM, parses metadata DTB,
>>     matches FIT configurations, and loads the selected DTB with
>>     overlays. Integrates with EFI boot flow by setting fdt_addr.
>>
>> 3. mkimage: add fatfs image type for FAT partition images
>>     Added fatimage.c handler that uses mkfs.vfat and mcopy to create
>>     FAT images from a directory.
> 
> I'm unsure why part 3 here is appropriate for U-Boot. It's wrapping
> existing tooling to create a fat image?
> 

I concur. Aswin, you need to justify with a usecase because I don't see 
a benefit for generating a fat image from mkimage for now. Why do you 
even need a filesystem for just the fitimage? Why not flash the fitimage 
directly on the partition?

Cheers,
Quentin
