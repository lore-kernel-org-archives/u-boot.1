Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF66DD5C0C2
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ABA889083;
	Fri,  8 Nov 2024 14:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="RWKGihkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 412C98900E; Fri,  8 Nov 2024 14:05:38 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::72a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA847890AD
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYSE6WQgtzAO/R5jXIKJL0g5FUKXm0FSGTKy7yI4Wu9a0YP3JBCr8d9usNRl2AH5C4Ib7+Lfw/ZRKFjgSZvLXOC+pNVKfG+M7zWB5tqeWdyaxCk/DRQ2YtcOyJ7uHqx3GtsThBo6kXZyJzJcrN5aBBjMB4HCm+OmPOutgomBVSxJhuFfupyCPzTguF3rM0vct/d6Snk1IvezYKv+kMzyJIJ6Ad1vtL4aZ0toi0MomMDQA/BQESVYoD63l3sEjkIcRsA31BROW4VRlRd0Mj+9zHnojmK3eGbbLFR5Ak8b40/LoxlTjpWLOwXcpPmVCISKNuC4Te44oiKxqrCWPPNBVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mXJrvD2NAK0MnTawKe82Cta1ndtAMLbTPTiKjQoYng=;
 b=p0N8XeaTiHqEMRDH2XbxQ2YiEb1cl4CqItVpcMc0wKkQ6QL/spObo6ZRmQ3m0XTTvHEN15wypR2GMJoft6YmSKUrhAViG83dyCmY7L5nAQNiDefxxMxrUrcgTA1N9GocnR5yb5LVXXEfXO2D1nCNdMkpBFB/N4U6bSc+4lgvi/0IzyVI9oo7R0cW2Z7OMBzdYoR8mjW6pgYSkogNLkZ1QnPL3eoXYUdRM1MCN3D5JG9m6EwXIEDMXWPn4ivSzEBy3PhGTv8sj1UYhpKJK1iMmUUFzV2LFV7VldKZzEKWvOFaQQ7FQvpF4iY5MsgSphodfmD1Mnf5GOpA/RbvWfLCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gmail.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mXJrvD2NAK0MnTawKe82Cta1ndtAMLbTPTiKjQoYng=;
 b=RWKGihkJ8sUGvETxwqSRuftZzbbhfygj/vJ5Mvc6U71KyIqEuOoG7/HYZoBpzOAG0bNsg129/RRzmCD+mZF3/WRDg5W7FKBYMQpoaPmgufRaG8OtPSPoP8Anw7o0Yso5K8E9CSW82NGMotjQDSm6nNig2LkuMKoeLb08v37obcg=
Received: from AM0PR01CA0139.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::44) by PRAP195MB1460.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:29a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 13:05:31 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:208:168:cafe::fa) by AM0PR01CA0139.outlook.office365.com
 (2603:10a6:208:168::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 13:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 13:05:31 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 14:05:30 +0100
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 8 Nov 2024
 14:05:29 +0100
Message-ID: <70b9a9cc-d110-4327-b200-a9e00aebf813@phytec.de>
Date: Fri, 8 Nov 2024 14:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH v2 5/6] doc: phytec: imx8mp: add OP-TEE
 documentation
To: Yannic Moog <Y.Moog@phytec.de>, "festevam@gmail.com" <festevam@gmail.com>, 
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: PHYTEC Upstream <upstream@lists.phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "manut@mecka.net" <manut@mecka.net>, Yashwanth Varakala
 <Y.Varakala@phytec.de>
References: <20241107-phytec_imx8m_optee-v2-0-bbc3747a60e8@phytec.de>
 <20241107-phytec_imx8m_optee-v2-5-bbc3747a60e8@phytec.de>
 <1f2af2cd-47bf-4267-b7f7-13c08c3ab4e8@phytec.de>
 <9a0a95e37095d1f4212df56fda58f19b8e7fbc48.camel@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <9a0a95e37095d1f4212df56fda58f19b8e7fbc48.camel@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|PRAP195MB1460:EE_
X-MS-Office365-Filtering-Correlation-Id: 471d1d23-04f7-473c-aa4b-08dcfff60632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzA5RjVDRUdFWTQ0NUhQRkxVMnVUYy9TQjlpRUxsdlhTSVJLY09pcjN3ZlNC?=
 =?utf-8?B?UjhoTUlSWEV6eEJqNVhMMWV2c21ZY2xqbUN1QzhuMnB1LzRHOGdqYkNIRWtV?=
 =?utf-8?B?YkYzeWI1U0FtMzk5NDZQbjRyM2dzM2l6ekdBdFdWVURweVM2MnJHc01RSEFE?=
 =?utf-8?B?MEtFeFlZWXBtV0lpbCt3MEEzYjk1cXdWNWdIZXExbWZFcU9NMmFZN2t2aHJk?=
 =?utf-8?B?VGJMMXVqbHRjci85UitFZDVlck9xbkxvTGZPVnhNOXJ1T1VjS0IwVWZFLzZn?=
 =?utf-8?B?dVRYOXBHVG93THBkWEZTcHMzN2xmdjBZbXI3WDZWNlJFTlhxU0tmNlkrYVZt?=
 =?utf-8?B?Y3BnUzVFeDNETlFOb01XN3lFVFRKNU03L1lCUTdkY1NFR3luc3VucXJXTzA5?=
 =?utf-8?B?L2dTUVNaK0EwdE52d0NGenM3ZUpwRFZwSnlZYkkwMCtsUHRsSFg4cndtRk00?=
 =?utf-8?B?WkF3N1p1blV0enRsRkxsbHluNlBlS0JnakpCNDBQVHdHblkrdkUraTY0dHNv?=
 =?utf-8?B?NlNKdndPNFZpN0FxUHFhT2FrR3c2T1NrUUlaUzIxMGtJT09UQW1LR3dSRlNM?=
 =?utf-8?B?RWJqSUJ0bEFUd3B3Z0g5VU9lRWpITFlWR0RCNlRyUmJQcUZINnlLRWlhaHdo?=
 =?utf-8?B?VVhEbGxJaCt5aHNDSFVZc2JOczNmb2dHQ0lJRzNqMXpla3EvMkRrbTNpZDhs?=
 =?utf-8?B?Zkt3TGVrSGUwQTJCa29kempkblF2NkhQWTRLOFJIUzYyem85YXZBdnNVMlI5?=
 =?utf-8?B?M1p3WnhEL0JZcHhpaVBCTkt3VFJObGdZeldvTUJpWHpmSDlKUjNQcFBmYlNJ?=
 =?utf-8?B?eTY5dkRtZk5HVnhRS0UzY2duV0JHMitoalVVRFUwQjk5ZzRJZzVmeDkzdWRC?=
 =?utf-8?B?c21rSVdZMUtNd0hVMkxEdTdKaENFT2lsQUhKUXNnRTdIbEJiZTRmajQ4Qm5x?=
 =?utf-8?B?aW5wL3FzRnJsVFpyU0ZJYlFXdDk4eEdyWk1XYmNDcnNtRWtSWStFN3Nvbmhq?=
 =?utf-8?B?VXpwdWVUVDNqbk9yOWFUZ04yVnVLdmlDSnl4cHlqWmZDREJIdE1jVUc5Wjhm?=
 =?utf-8?B?ajJmQ0hJWStzTWk3d1JyNm05anJSa0JBU2Z6MytwODN6elUwRkFmMVhKdnQ5?=
 =?utf-8?B?b3NLQ0NPblhxbUdkdGxvQjZTTmFDc1ljZzU3TUdOWlVIcnl5UVJpcERMSjdt?=
 =?utf-8?B?azYxN3BwV3l2YVZ2c3k0MDB6NUJ5NWQxZEV0QkMrMUpCcTRxM3cxVm1nY0ZT?=
 =?utf-8?B?eEloQUIrSjlDemRVdHliS3RINHBiN3hmOStzb2I5QWljR1ordHArd2I1c3NU?=
 =?utf-8?B?OXB4ZjFkaC83UG5mUkxWRzhZNUgrS2JXZ3htM0pFS05FOWNLek1FcVZ0dCtZ?=
 =?utf-8?B?RTlwbzJ3TFIrekdScm1wZGprZHJyYnVFMjhOZ1NCeEpKMUt0QlZ5Y0xNQWJM?=
 =?utf-8?B?OU44K2lwb0RDYzRjZk5vaXYvcXJJd0Zxc3lkVEpjY1VKRjVCUjlNRHVVWGdS?=
 =?utf-8?B?S1FZKy9BemlmeE9EZXhPc0ZrcjFkOHI2N09vSjBPeDBxUDZmMTEwVGw2SnhG?=
 =?utf-8?B?SWkvdXBFV0tUNjJGMUVvNXRqWkttZVB0WC9LSnRpbUFsSFRpRHg0ZTF0U0JH?=
 =?utf-8?B?Y0Z3NG01VDhXa2thMzBnc084L3VzbU5tUjdmYXgrMk5XSVU4QlBXTlBQcUtW?=
 =?utf-8?B?WU9tbm85RExiencvdXJuKzlRc3lPRWJXY3p5amh6SEt5cEZQNUVyYnBmNi9r?=
 =?utf-8?B?QU5POXA3TVhsWjRpTXBnaDlZcnRnMkYydHIxQlpSZ3F6ZlZPM2x0djV0Qk8v?=
 =?utf-8?Q?YXZW/7du1yhNSmCo2r+CjFIwIb60QKh6JyOOw=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 13:05:31.0320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471d1d23-04f7-473c-aa4b-08dcfff60632
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1460
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



Am 08.11.24 um 13:59 schrieb Yannic Moog:
> On Thu, 2024-11-07 at 10:07 +0100, Wadim Egorov wrote:
>>
>>
>> Am 07.11.24 um 09:23 schrieb Yannic Moog:
>>> Add documentation for the phyBOARD-Pollux i.MX 8M Plus on OP-TEE
>>> integration.
>>> Also add missing '-' to TF-A build instruction while at it.
>>
>>
>> Would it make sense to move these instructions into a more general
>> section, so they could be reused by other imx based boards as well?
> 
> I have not put much thought into it. At first glance though, when reading the documentation for a
> board I don't want to be redirected to other pages. So using an include comes to mind. Is that what
> you had in mind as well?

Yes, I was thinking about using includes to reduce doc duplication.

>   
>>
>> Seems you missed to update imx8mm-phygate-tauri-l.rst
> 
> Should be in the (next) patch for the imx8mm, as Tauri is based on phycore-imx8mm. Let me know if
> you meant something else.

Ah! I missed that you change both files in the next patch.

> 
> Yannic
> 
>>
>>>
>>> Signed-off-by: Yannic Moog <y.moog@phytec.de>
>>> ---
>>>    doc/board/phytec/phycore-imx8mp.rst | 26 +++++++++++++++++++++++++-
>>>    1 file changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
>>> index fda751aeffb..4bcfa9f39ca 100644
>>> --- a/doc/board/phytec/phycore-imx8mp.rst
>>> +++ b/doc/board/phytec/phycore-imx8mp.rst
>>> @@ -9,6 +9,7 @@ Quick Start
>>>    -----------
>>>    
>>>    - Build the ARM Trusted firmware binary
>>> +- Build the OP-TEE binary (optional)
>>>    - Get ddr firmware
>>>    - Build U-Boot
>>>    - Boot
>>> @@ -20,10 +21,32 @@ Build the ARM Trusted firmware binary
>>>    
>>>       $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
>>>       $ cd trusted-firmware-a
>>> -   $ export CROSS_COMPILE=aarch64-linux-gnu
>>> +   $ export CROSS_COMPILE=aarch64-linux-gnu-
>>>       $ export IMX_BOOT_UART_BASE=0x30860000
>>> +   $ # with optee
>>> +   $ make PLAT=imx8mp SPD=opteed bl31
>>> +   $ # without optee
>>>       $ make PLAT=imx8mp bl31
>>>    
>>> +Build the OP-TEE binary (optional)
>>> +----------------------------------
>>> +
>>> +.. code-block:: bash
>>> +
>>> +   $ git clone https://github.com/OP-TEE/optee_os.git
>>> +   $ cd optee_os
>>> +   $ make CFG_ARM64_core=y \
>>> +     CFG_TEE_BENCHMARK=n \
>>> +     CROSS_COMPILE=aarch64-linux-gnu- \
>>> +     CROSS_COMPILE_core=aarch64-linux-gnu- \
>>> +     CROSS_COMPILE_ta_arm32=arm-linux-gnueabihf- \
>>> +     CROSS_COMPILE_ta_arm64=aarch64-linux-gnu- \
>>> +     O=out/arm \
>>> +     PLATFORM=imx-mx8mpevk \
>>> +     CFG_TZDRAM_START=0x56000000 \
>>> +     CFG_DDR_SIZE=0x80000000 \
>>> +     CFG_UART_BASE=UART1_BASE
>>> +
>>>    Get the ddr firmware
>>>    --------------------
>>>    
>>> @@ -42,6 +65,7 @@ Copy binaries
>>>    .. code-block:: bash
>>>    
>>>       $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
>>> +   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
>>>       $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
>>>    
>>>    Build U-Boot
>>>
>>
> 

