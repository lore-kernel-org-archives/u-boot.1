Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3DDC87FCF
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 02:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1B1183AEE;
	Tue,  5 Aug 2025 04:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="M/XvEQYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBA8D83DF3; Tue,  5 Aug 2025 04:33:50 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C536A83A81
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 04:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMdzh7PGY6htYdZ4gzs2snDHm7Q4Nad4Ms1JTZ1M1K8XzncZ+8LUasLYWh2AIttr2cDLOhTHj3r7gmmVXurtAMBoheBxGUpnaEbdW/qYIxeff7MUK4bjDA11NeyBjOS5b4cwKRzjPrlHqdBQlYALaDMayaUU3LE9g3x8OzzmP1nyuwgEDgsSOjtC7Z5+WlWBucfeg4zKs2SRVqK1X1e9CPY9KL5tp1sRY8I5Eg2oGmi31Sa4LP46dWVMCBoH7dCIf7ufEI9cCOcB1wJISxoVIaBkXo0QdS3pAywLh75sNzncJ62iHzthy/Pi25gHdFXeIvLPYHR9SjJlhHMTLETApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn5qot/c5698VOJxP8PqxHvS/Z1sfEnmwXz5axNEb6E=;
 b=JZGSv1/lo017Fcm0O2Iy+ayUOCKwfcVpvGZX09FP06LnaZG5sq3UBHE7tdIdSNi/4cKbIVm1yNTKhCrGmXTDSvwT8ZDW4EYjsQ+KJzzSSTIrB6byCC4lHmgq8sZhDD5h9fkPhzbXQOc/X3m+spfK50MpKMa8CpmChSvbJWenCFc38CnTzG4LG7dT7JlOhpa5qiDb9iXOGEO0RLC1Y7yzQmkTzO4H4vZdMUDH12tTuTKo0MceJpvxevc79PzkvYWyM1IVFDr0KrIe14Rd85ccqtMX8TkpDZC1TFPBz2o/WyUYxr0zOZj6j6ZpPK6Kx7a7E7xS65Iq+1uWJ+szAlvZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nn5qot/c5698VOJxP8PqxHvS/Z1sfEnmwXz5axNEb6E=;
 b=M/XvEQYGLmD+/v27/MgwQpDI0EB76FppO8Ug7i+IiKOP3BzUcx0V9jx9cnWgldBTiJolAlskP1Xywyfn6kCQKc80/EHM4xPySZKZOj6WETWzkHaM3TbHGrOGbrhCcSctD5uJF+hky1yl04Qoey0zf9MK07FBm6gy7VbA74ZhmgONG3oryY0LM5qE/miPoqqoukAK5TlMsuhnPn/WkkdzpygEG3GdL+/XaVvW+qpZkfmsf/cm1lG2kHzfeDuA5mXnXQfspd1kkAz1Mw3resa/2jGifMwaSJH+QnK5mmN3ho5PY41MMVcPdtReC64Ss+hOnHmGYPECT44AfHtaXNATPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10158.eurprd04.prod.outlook.com (2603:10a6:102:404::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 02:33:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 02:33:46 +0000
Date: Tue, 5 Aug 2025 11:44:29 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: Re: Smatch error report in drivers/misc/imx_ele/fuse.c
Message-ID: <20250805034429.GA29103@nxa18884-linux.ap.freescale.net>
References: <876b019c-4505-43cd-9247-3a63991e664c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <876b019c-4505-43cd-9247-3a63991e664c@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA2PR04MB10158:EE_
X-MS-Office365-Filtering-Correlation-Id: 27177a1b-430b-4fda-dd1e-08ddd3c8806b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JTeuSF6JeLa3BpMJfGARL8QGGD0gRcpWeAFvx2EQWSMyX75ky0XP5WJ6pAn7?=
 =?us-ascii?Q?CYC7OvFP8z8gDDJ8nx8kiGERSUGIBXMlF8poy/taA/4n4ikTNsl64chxAhqX?=
 =?us-ascii?Q?WQiCaJ1Y2v+/UC582ORA/uc/5Av4fI4608rS8Tjc3P+D4g5HCPBr1mG8Xz5/?=
 =?us-ascii?Q?Yo5oWTX6LCyVnuKyeG27YkyCKU8FczD5MN03DpzOwJCadGIAw2z6i8arHDZU?=
 =?us-ascii?Q?+gj7dZHlzfSb4MovCeT7ZGzzi3CKpFp5W0JrTtYJZnFemilbVIy92RZ3lfnN?=
 =?us-ascii?Q?Befg4dgE9egI/XUrGdgmnhPlwJ423nmGTgUBCMChf6X08m8IeFVp9NXwnIjW?=
 =?us-ascii?Q?RejOxZir3fGeRMziH4MaJpbwF2zCI3+qpm73qgPdepU423qwbquCtDUHTOZy?=
 =?us-ascii?Q?Gksdy/NazZYy22Ztk7wqNYRw7vlIM5xHFp8NgZgfns333c9soVgPyQu65Txl?=
 =?us-ascii?Q?9iaYyQNWriUo4WmkvC7yhf2TnzJ3DMw48SnBWCZgippUB1xSor2HpCa/VaWW?=
 =?us-ascii?Q?gBGiDrD8j4TBdxy8CA8huXM9PBT6Z/BinROX2fEB0tGnXcIUVkkDl8Bc9yLL?=
 =?us-ascii?Q?079KeDsE5TV2EuGvOzbfXA0/ULf3nQiOwCIFl0UdsI/KvsHKH37hJtvZ4LaB?=
 =?us-ascii?Q?j4PAhQ6WJcBEBNEehmMdMK+gZarGeNuMSbdEvq3Kw803lmy6DvkrAHtg7ChK?=
 =?us-ascii?Q?mnPzPODGnmZXQQzkabKmWSLGUFqXtKV785gEkABbUyI3o8Vf7MrNm1NljGga?=
 =?us-ascii?Q?anJanbM3vuhfsxEovet+cj/Xg2tXv961zIbYGMFzKLix+UQplHiZDtldkCYP?=
 =?us-ascii?Q?jOQ+3S3aqz10jfVkKSLCPhbSH7WSJ/m5d4b5v8A49zqdUL0ZG+LqlCCvWipm?=
 =?us-ascii?Q?BM9ZOmMN4hqN0jwOZhRivk1QL3F2ePhkUao1LAS+zs/Fcb4LcQazjiUskJQ1?=
 =?us-ascii?Q?7nrFIYMfV5easiD3B7gHw7XiEo8n9+SsXQr2ELAf6kPH+YHT5h58RaqvMgLv?=
 =?us-ascii?Q?Z3rXp9e0FQHUeGLBOr41q9d6vyluWMQnwardsm0TZqzPo2HLp17epssRLuUW?=
 =?us-ascii?Q?R1ShjANCosIOlvbszSVV7O+tAktzr/WMbDLr/gLqXvu0dheVhhKylninGnPF?=
 =?us-ascii?Q?2kKfuJU08e04gFF0fFK6RyGuHsV4xrKUbSc5Lhp7F42tzRQOSLyrDQAH03Dq?=
 =?us-ascii?Q?hG0prrtSuSYRcAL7P0BrJiw8qRjVBb4R+ztgYyZjvv790cdx1aSK+qFbbqiL?=
 =?us-ascii?Q?FEfCNiZ/ak12OuS+9YrrIKHEzQY7d2bL5Y+MmXsOYTO7bRP7lph/JI/SHLIo?=
 =?us-ascii?Q?PuLJLhgBq7eYcb6BGid04noUO6eQ34dRCcsFsj62OUPGy39Lbhhj7BUBFyyS?=
 =?us-ascii?Q?aYqADzXP0HWnbUrVMftYFGuWRk+EogkS9VHFIk38JItNphS+686avoQlgMY5?=
 =?us-ascii?Q?opiD3eG0xhkqdxKiT0cqEKy8yGCGGx9rJ1D7FE3A0vexRZMjosEAdQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fEZhjSVIOfgNHlfMY0YeRyNZ1WXVptDs2q7XItBFDhVBxiYo9vJx/8REW0WK?=
 =?us-ascii?Q?gkV7dU09obENxPHcleuhNdy/Kf22OBypAvBG151hV15fKEdR1IqowJzuCVld?=
 =?us-ascii?Q?Ls8MHVxLsi7KgD8EV29ogYLP4t/7aCVR/bW0uMkAmVd0PqaZjL0iG1osFbcO?=
 =?us-ascii?Q?jgtkn5OvBNsPUlwDJilXEdoj3G3QY4YuF4e+zOxFw5CEZY47AXHZUvBG6nj6?=
 =?us-ascii?Q?Vx5vYDzso69/Q1+EjrjgxVQ2elDgHSjcpe2omshXGPq/9Uk4lkcCf3S4VKae?=
 =?us-ascii?Q?1MdlNcWyff5YgjRo+UwyMC4gpEqwo319yHYsrY6gu3QwL3DLB+3a8XhJyv6U?=
 =?us-ascii?Q?qmS4QMGy2LCrudtuxu20RVVzT4p2a+c34+z+kS8geOMmnta7TEQPW0K+Vc3b?=
 =?us-ascii?Q?X+Tw2w8jxTvXY1Ueh5ikWhO7V9AQu7O3WGEoEKPtvXJLpkWrsK2Z88ykcS40?=
 =?us-ascii?Q?j606uLQ+5B3GaIA4il+nhA1oeublLmFbelWsX5xkkJtcmtj1nMDhX/GFwimv?=
 =?us-ascii?Q?HUCVGl0TFCL8UegI1CoxcQdiv6gRKfGVHBe5nSCFC+jXxCjFWdXnfwifczx7?=
 =?us-ascii?Q?pPPRkp4vkIydMYZuIQzERUpoL98elCPpHypNcfiVBXVHE4npihYBB2+U96DS?=
 =?us-ascii?Q?uJ8Nm593WMO5fkA8d+c3fvyKevnmAYeDXFiNQuSQ4wQYw824e4f8gi2KsALb?=
 =?us-ascii?Q?EnqCPrRpN4PNhjMCAf41QULOgFh1Wdtzb4d+U1tjVwg1+K/AjhM1TiZ+pfDg?=
 =?us-ascii?Q?qU/8lknkCSesO1T5q03GwzATx1SH1qMtkrVvmcBKlbRGH3wotg+zBv3UagPn?=
 =?us-ascii?Q?RtbqoaoqmWwXNkuQmwKYysjZC8fvcmdTZyPxSZcqVo2vLEfPO1rYbhtZWP+z?=
 =?us-ascii?Q?n0cpNnhiTbLwawoBeuMv+2XRgGzQ+fJ8fZvQ45sHDWNbqTCXn9vH0GT6UC34?=
 =?us-ascii?Q?hlfY0jqsVVXuRkqJ6Gjw/b6xrMInj1YH2ImCRr7qw8o+XLbN+qlPBQ4z7wW4?=
 =?us-ascii?Q?lPYKdbrs9Dz1Je97i1uX6S65j9ux+FNDt6u1oJDsXgnVT6gefdVFxmRHJIYa?=
 =?us-ascii?Q?RAP/JX2tEw/S9ceyAdUyBatlPX8+vQDOFBqDcKngO7mFDEdwWTO7yfzzdYNY?=
 =?us-ascii?Q?8oNw7tYV/h3+Xs5EnKRCPsMMo/2UbwDM2IqYGnfNXNKGG4FTed76znFfRDE+?=
 =?us-ascii?Q?9zv9DzSoH8VXaWlqe3PuBEr5tIN0GYHxqqfpzItc+3aAIxKq+w6oTimaT2e1?=
 =?us-ascii?Q?JVJnIqSNyNJwyQ9szNXnaJrc0fmz5d8c2Q1XVGnvNWsy+zLvagMRqQS5gH14?=
 =?us-ascii?Q?EIuMv2draRLOzeMZ18OiqNLW2uD6y+6mO21ogSGe6UcDDWNdWP2ImkrYeV/j?=
 =?us-ascii?Q?hZDVkA7zdwh7pb/WxpBSK5nSnqex2AhaXfJt+JUB2xDGsdTLML3h13SEL00c?=
 =?us-ascii?Q?8vLQJRcy7n2cDyE95N46/tRJO02jNYuBZh945aMLY+Aimv9YVLUJ9ODV7lRx?=
 =?us-ascii?Q?2jxPjNC9kan3bLcRIXXd5G5O92e49ynz15u9OWuNBeec/UvBh6YIh7q4VDYj?=
 =?us-ascii?Q?NHiyWEL7/qD9v1/EsI+sComr5p0kCZrtbEiynCtF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27177a1b-430b-4fda-dd1e-08ddd3c8806b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:33:46.0626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmXDq7dhk75+6cPvV9/3iV+ki9rbGlfE+UdYyGb3Rjhpdk+yVvy/mqtf+nz9LEe10W3DI49hleQyjFZsgxBBgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10158
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

On Tue, Jul 29, 2025 at 12:18:39PM +0100, Andrew Goodbody wrote:
>Smatch reports the following error.
>
>drivers/misc/imx_ele/fuse.c:218 fuse_sense() error: buffer overflow 'data' 4
><= 7
>
>Looking at the code I can see that at line 198, word is checked to be less
>than 8. Later at line 203 data is declared as a 4 element array. Then at line
>218 word is used to index into data which means a possible out of bounds
>access if word >=4.
>
>There seems little point in increasing the array size of data as
>ele_read_common_fuse will only ever read into the first 4 elements of the
>array.
>
>So I am not sure what the correct fix is here. Is there any guarantee that
>word will be < 4 in the case of word_index == 1? Or should this be an
>additional check?

In ele_api_mapping_table, OTP_UNIQ_ID is already limited to 4 as max,
so no issue.

Thanks,
Peng

>
>Thanks,
>Andrew
