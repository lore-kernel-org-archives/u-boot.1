Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E068E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 13:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810D0890D9;
	Fri,  6 Dec 2024 14:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jfpGENhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70EB78927A; Fri,  6 Dec 2024 14:28:36 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBEB388CEA
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 14:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v5pcqkqnEGnAttKK70Fga9radGljbACLzwjnDcHhU6HqbXdJXUiDdR2+sQscLb4f2nO3l8sbn0/Bdz9eISMh0auvSzRDhp10wyJz+Y5vvVJ9zIWNIxUrDwMM7p+CxrKkeSEoPc9yu+PHIcuv7VAkQjgD5Fw4HTeTbyJ77nlYzjHXOCYMYnnwtMr8cnDGVYZXkqDHDKu2PkAWzyLb5veZ3r1DntvhqEGqxrMAXZfNpLFql2covwOAWXq+tGlKlqtwWSnwAekXzd2iG2pBKDhsLJ//bumbWYnBmY+I1EGHUiO2GKyCMOdKLi0xJ7fZCOd8Z3/LlrbHS2f4U32hGKr1zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SneTejwqzKIsnzvk8h6LNhIQNp/JkRWnbD7GQh2/gTI=;
 b=UaekYw7NeLSdabwtC29TaL0E5hfRrhRlEixjPqNV2sAZnHBSC3Kpz1arRo/TdubBSXNlg+7QoqabbalcrL9lgsv3mMCjLwG1Nv8odkP9iksIW/2cu91A8NoHNXgmxnX/QPu1NiWqVOUTzCT6vDS8g3XNhHvAwSm+joCcd+GcrmMJokYlaPmVtiAvYYDK4fFYY7MNxQjcXWJM1v0o9FlbuWH1N5yEVwL8+MjF29x8CE8feFCSYs8exhxBZRT3mGdgZ/wxZHPGujV93RFn5s2nrkpcUSkSgHI4nbJCl7OYi5xARj9GZOXXmI3tqi3oKjiywptj/n062g3phFis45N83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SneTejwqzKIsnzvk8h6LNhIQNp/JkRWnbD7GQh2/gTI=;
 b=jfpGENhS50m3upt6A5j3XhG4dPT1zGpaqRx1hpDbkCrUmbdGCey1Dgo8KXuRy7HZtKXvJbsxyEFvdsj0z+nquj6YJXSTCb9UGnnHXES2aUn8/ApmbQAcp6uDV0WXaqbHQ3bo5Q03a/AJmny6J48xyykJmLLr2UdLTt/yMybcMnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 13:28:31 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:28:31 +0000
Message-ID: <47438e01-90c7-4f17-9434-71869349ddca@cherry.de>
Date: Fri, 6 Dec 2024 14:28:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add Khadas Edge2 RK3588 board
To: Jacobe Zang <jacobe.zang@wesion.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, nick@khadas.com
References: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA1P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::22) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 346f7771-4131-40f6-4c95-08dd15f9e022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0JreWRGTnE1UUhFekJqMlJyNFBDeFZHdWJ4SmJoQ3B6ZnRyMlRLOEtXbXlV?=
 =?utf-8?B?M1E3L0lydFEwZDdiYnhRalljVk1tT1JnRkF2dk0xWjFOd3gyWVdpT1RWNE4x?=
 =?utf-8?B?Uko0TEdsTUdpdUlaMnVwa2pwT1RRazV3ZE1MQUdIWUxyQ20xY2FjS2ZYbTBh?=
 =?utf-8?B?T1FEQ3hnMVQ3YzZ4UzNTNG9tYlJjcWhTSWFiZm10L0xFdysyZFp1TVBEVFI2?=
 =?utf-8?B?WXltLzl4WnZOcXAwdkh2N2xndXIyWmIyYVBQanlmMTFlTmFTTEpNeTF2OE1Q?=
 =?utf-8?B?dGZOam9XbUhhZHZDRkxxRGRmT09od0wyTXdZR1RQVnVJOXNmK1J2RVM1dVhJ?=
 =?utf-8?B?WlBQWHRXN3lDeFc5ZnRObFpuZEYzSEpPQXlFNlZIWUJWc3MvVUZXK3p5eWc0?=
 =?utf-8?B?c1prdEU2TVR6cHJqWGlqcjg3MEtna3Y5NWhaL3RuVkIrOGhncFpMYVhFc0x5?=
 =?utf-8?B?dU85eVdmSGpwOTcrQjdtK0dLcUZKQ2NtSGZxS2hMZW5QLzZidVR1alVVRkVX?=
 =?utf-8?B?UmYzK3dZM2NML0NPejdJVGJSSFNGNis0amhrNlM1SHZhODhENW1JSnJHU2Ez?=
 =?utf-8?B?eDB6RUFsVm9VOVd1T0gxWURkUHl6Y3BPZjc0N1MzeW81akhwYTF1cXRPL2Iy?=
 =?utf-8?B?THJNZE5xaTdQYWVmUW9CWU1yc1Zzd2JQYjYzVjZxRDlGWWJ4UXR5K0kzU2d3?=
 =?utf-8?B?RmxJaE9WQWhOWlVuMEZwallybEl3K1VrV2ozR2hGaUQ0b1ZUeTJld2JxeVRK?=
 =?utf-8?B?SS9LUlZnOFlLaW5YMUcrZlgrV2x5K251cWdseXNNVWpyd0hueUVmaExFejd2?=
 =?utf-8?B?YlgyeitpUmdZVXVHYjFlSWloL2VQZW8vSmxOZ0VIaXdWNGFhbG5OWlVKdzQ4?=
 =?utf-8?B?c1YxR0JhbkY2OHVVK0g0UXZJUTBLY2xvc29zYmRLZ0dqeUpVRXdoblpiVXdw?=
 =?utf-8?B?Nmw5dnZLVVJHSzA1K0kwa21mcUExTjBERnRoYmtVaUdXTmlJWUJWR2tNZlFm?=
 =?utf-8?B?VUh0bHhGbWJGRE5mUTdHZ09IWWEyRlZ5ZzBqVjBFRHU4ZlNmTGFLVGFzTGQ0?=
 =?utf-8?B?a09Ia1YyMW9qYmQ4Vmp2R0VHdVdjU2RicGtUSlo1NXRFU1Y5c1BtZVF2TEF2?=
 =?utf-8?B?VUpjYjN5WmY0S1c0cEFzQWFtWGg1eDZxK0ZZSThrQTVNRVgvaDBYdmo3MUNr?=
 =?utf-8?B?NVQzMzc2Q255Q1kwVUJZRjRneGVBWUMzSFROZTRValV2TEdaVVc1K1JPTGxm?=
 =?utf-8?B?YjJienp2d2xMQy9aZE9UN1hsam5XK2ZKeW0ySFl3Z3FIMVBLM0h1eUo4Zlhl?=
 =?utf-8?B?UkQ1b1pSLzVZRDMzeVNuRWpINmxPTjRMTG10ZXlOay9RVlE4VWlmUlIwY1V0?=
 =?utf-8?B?ZkE1S3pGOWhyTkVCNlNtQ1RPOTFTc1NJcTlkNXBKRUw3WEd5UW5yVnJvcHFC?=
 =?utf-8?B?akNJZWtsUnZLN1JMdHFIRW9KVVpjME8zOXJQQ1NHNkZrWFBqb1dGN0dwUW5X?=
 =?utf-8?B?V1RNWEtGYXFHc0dmR1g0YWkrVVBkdGJOUlBJbm9PUEdrTkxuYXdPbmUvWURM?=
 =?utf-8?B?QjZJaXpZL2EvUWJ1dkpHTDJTZDJ2ZzFxNHBvL3lEWkcyWUI2SHQweTZFRldV?=
 =?utf-8?B?dVJVZUF4U1pKRlM5bFpGb0dwdWwyUW9uVkIzNU5FQzRxUDh1SWt6MmtNVXFG?=
 =?utf-8?B?alVvdm54cG43Q2xrRVZxUHBVMHo4S1pMa2NjMlVQOGsvSC9BcCtLSmZxUERx?=
 =?utf-8?B?OUVhd3lJRytnL1gxa0c2L3dLR0J3cVFzdmNLMFQ5ZG43eVQwdGIzc3RlZTlD?=
 =?utf-8?Q?qNm6SqKQ6CoGM+Zulym/X+TDbsO9qdKBPYL7c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWtPdVBaVEpsdC8zczVicmNVUncwM1RGRVdkc0xORG1ZZDl2b0ZmMzFvZ3BS?=
 =?utf-8?B?enlCNGtHRFJFclpjeTZ0L0h6VDZVRGdaWlNscTVqNEw4cTEyemRBbkJLenF1?=
 =?utf-8?B?aVMwbCtQaFRieWpOTzE0R3VoUlRoV2hJSzN2azJVTmJwa2JDcUx5b2YrbDh4?=
 =?utf-8?B?MFJnV3NGaU5iY0NXWDBnWHduN3Zud2JRelpFRjdLWU1Rbm5pZkMzTFJrTms0?=
 =?utf-8?B?c3VrTVVjY3JlbWpERFBpNG9LbUdjVXBxTlZLTWlDM2RUU0VOazFWTFU5Tmha?=
 =?utf-8?B?UTl0VHQ4MU55dDhBKzhucXpjdXJhWUhnUlphcVlDazdBaFJZSUYvZW16eEdC?=
 =?utf-8?B?MHk4Sis2S2RDZGFZQk02NWptRlRTcVhST3huUFRtUDFkOTFXcFJHWTlXek9y?=
 =?utf-8?B?T200d0dXUFVsL1ptODl0b01Eb3ZONmZzWnVKc3JLbWFrMkZmTjBVUEFrNHlC?=
 =?utf-8?B?bHdTOWhUUWE5SVhBRkRCbVhEMGZNU1QxanNWeUc0dlgrUUVqVEJGNm82Vm9p?=
 =?utf-8?B?eStRZGxmUVl0SG8wOWtuUmdpeDFxNXBEM3lPSkZGOFE1cmFpOGEvSXErN2Q2?=
 =?utf-8?B?VXpHb2VuZmg3bWNESEVVcUNmbHhoTDBBU2lSU0lEL1NMeXc5Z2orUWNacTNo?=
 =?utf-8?B?dTJuV3lNTGNmZkRXNHp3dDh0d25VVUVaS2xodEpPcEdFRExYMFVmY0VmRmps?=
 =?utf-8?B?MkZHazV6SjF1elcrelJhNCszNWdEU21XZm9GaDRuWXI2b0huNjkrcDl2QWhD?=
 =?utf-8?B?bjE4M2hNMm9SNjU0czM5QmJhN0YyU0VDelJOVUx4Qk5yOGZYZkdRSHRUNCt1?=
 =?utf-8?B?Vy96YnhTN1VGOEU0UTI2b2kvTWZpc1pvbklyQlJnc3ZXYWxHUkpjL1hybUoy?=
 =?utf-8?B?OHRiT2VqZmQyMUZncWEzNzROZ0ZwRElwQlNPUnUvY1prU051cjJJekJxend6?=
 =?utf-8?B?dVhWRUtNTkFoZzNGNFRoaExLS0kxVGZwaEF1SFJTUGxJVzAyNnR0OWVUWFl3?=
 =?utf-8?B?bEJNazR2UEpVSnVYWEplVGt5NXhWRFZKdTBvR3o0QVlKUlc5WllGZ2xSTFNH?=
 =?utf-8?B?SHZNU09aOC9LaCt4SDhLNS9ZTFdzQjR4VkpZSWx3bldlYStvc3BTTHFWTXRn?=
 =?utf-8?B?UStBMG5odWNhNjZNcCs2TUc2akdSbUJUSTJ5OVA4MlpXVU5qR3YxZmNhdlF6?=
 =?utf-8?B?YUhGd0p1OSs5MWdNWEJyZHZ6VTVuTG1lc0VZZHlIWjF0V3M5NmM2eS9yZ09V?=
 =?utf-8?B?N1NCd1NVRU1PeDdRZC8zWWF2U3d6SEtqaXZnMmxZb2RGdXJGRzBjNDlqNElU?=
 =?utf-8?B?VWxQdG0vTElmN1NCSmxxNmtoNEJURFpYWW9JOGVqT09RL0NKWEpWaGo3c3Uw?=
 =?utf-8?B?QktoZmxPMHRVVi9XWXFrTGJad2lBaS9DK0F6anRBUVlscFhzL1ZaVDVnZUZh?=
 =?utf-8?B?OStDVTFqdUhBRjBtcE85dzg2MHI1eXBWalkwVjBTUy9NbVNCT09PNmVvNmJu?=
 =?utf-8?B?ZWxNNVNVbVREbk1VRXZ5S0kxSU5UbW1GREh1Zk9jMnBybENWTU1HTnRCRkZB?=
 =?utf-8?B?eG1jTEY1M25nZU9yWWhPZ0Q5RVdvSSs4OG02Y0F4NjJ4NlBRUnJzNjZNbXRN?=
 =?utf-8?B?UHB0cG9VMG45aGdud0VVWTJsVENHYTR2SXN3dnRmenhERmZHcWJweTc1aklQ?=
 =?utf-8?B?TTdieHNkNTZzL1BKcC8reVltQjVSUU12UVFJTnVCNTV6MEFxc0dQbHZwcnRN?=
 =?utf-8?B?ZFJmaC9nR3V3S1dvc1ZKY3lkNTlSNEJQQUZoQ0lwN0dTN1RzankrZkh6UE1B?=
 =?utf-8?B?OURiTGRWOGpUV2dUakI2QmN0N1ZxS1dJNXE0bm1HVmx5RTF6YkhwMjEybEE4?=
 =?utf-8?B?c3pEOG1FVW1tQ0Y3c2FDWjI2b3hyc0t3OWREZVloRDVIb0pzc0JTV2lWeEZG?=
 =?utf-8?B?WVoxUzJPYWtyTTFmRDNnblN0bGpmSGdCaS81VFhGTlJtVERxUEoyS00yTXdG?=
 =?utf-8?B?SWszRnJtbGxnZStDb1p0THBjKytySlh6N1ZOaFo3aWZCZCtEdzhoWnlEN09N?=
 =?utf-8?B?US8wVnd5RmEzbFpkV2tLNWdrK3R3OGNkSFR2bGlmNWlXOGtnUFZhdlFST1Zj?=
 =?utf-8?B?cGNLV21Ia1kza3VlVDRqU3dlYStuZ2hyb3VNcHZMeC80d1dsK0k0dnJXQzEx?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 346f7771-4131-40f6-4c95-08dd15f9e022
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:28:30.9828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9mA8+E/5b2BbnKCjm+SHH9ds7JAgJ+oMZjfTLGdO/SL2BdvG/ppoMaP0pCfz5z8NKnXfZDJWC8IuHXLlxh3h1WrTb2d7yLZlAdlV5j6Oqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539
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

Hi Jacobe,

On 12/4/24 10:45 AM, Jacobe Zang wrote:
> [You don't often get email from jacobe.zang@wesion.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
> by Khadas.
> 
> There are tree variants depending on the DRAM size : 8G and 16G.

What's the third variant :)?

> 
> Specification:
> 
>      Rockchip RK3588S SoC
>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>      8/16GB memory LPDDR4x
>      Mali G610MP4 GPU
>      3x MIPI CSI 4x lanes
>      2x MIPI-DSI DPHY 4x lanes
>      32/64GB eMMC
>      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>      1x HDMI 2.1 output, 1x DP 1.4 output
>      USB PD over USB Type-C
> 
> Kernel commit:
> 04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")
> 
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
> Add support for Khadas Edge2
> ---
> Changes in v2:
> - defconfig: Update defconfig made from upstream

How did you generate the defconfig?

I applied your patch and ran make khadas-edge2-rk3588s_defconfig 
followed by make savedefconfig and they are different enough to make me 
suspicious of how this defconfig was generated?

> - Link to v1: https://lore.kernel.org/r/20241119-edge2-v1-1-b10c5d7626ca@wesion.com
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig         |  23 ++++
>   board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 +++
>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 ++
>   configs/khadas-edge2-rk3588s_defconfig        | 146 ++++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   include/configs/khadas-edge2-rk3588s.h        |  15 +++
>   6 files changed, 203 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index b5a0e624a53..7d817e7f1bd 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
>                - fan controller (AMC6821 emulation)
>              * 80-pin Mezzanine connector
> 
> +config TARGET_KHADAS_EDGE2_RK3588
> +       bool "Khadas Edge2 RK3588 board"
> +       select BOARD_LATE_INIT
> +       help
> +         Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
> +         by Khadas.
> +
> +         There are tree variants depending on the DRAM size : 8G and 16G.
> +

If there's a third variant, please make it explicit as well here.

> +         Specification:
> +
> +         Rockchip RK3588S SoC
> +         4x ARM Cortex-A76, 4x ARM Cortex-A55
> +         8/16GB memory LPDDR4x
> +         Mali G610MP4 GPU
> +         3x MIPI CSI 4x lanes
> +         2x MIPI-DSI DPHY 4x lanes
> +         32/64GB eMMC
> +         1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
> +         1x HDMI 2.1 output, 1x DP 1.4 output
> +         USB PD over USB Type-C
> +
>   config TARGET_NANOPCT6_RK3588
>          bool "FriendlyElec NanoPC-T6 RK3588 board"
>          select BOARD_LATE_INIT
> @@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>   source "board/hardkernel/odroid_m2/Kconfig"
>   source "board/indiedroid/nova/Kconfig"
> +source "board/khadas/khadas-edge2-rk3588s/Kconfig"
>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>   source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
> diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/khadas-edge2-rk3588s/Kconfig
> new file mode 100644
> index 00000000000..dd7b6cd8054
> --- /dev/null
> +++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_KHADAS_EDGE2_RK3588
> +
> +config SYS_BOARD
> +       default "khadas-edge2-rk3588s"
> +
> +config SYS_VENDOR
> +       default "khadas"
> +
> +config SYS_CONFIG_NAME
> +       default "khadas-edge2-rk3588s"
> +
> +endif
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> new file mode 100644
> index 00000000000..3f16923b0f2
> --- /dev/null
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -0,0 +1,6 @@
> +KHADAS-EDGE2-RK3588S
> +M:     Jacobe Zang <jacobe.zang@wesion.com>
> +S:     Maintained
> +F:     configs/khadas-edge2-rk3588s_defconfig
> +F:     include/configs/khadas-edge2-rk3588s.h
> +F:     dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
> \ No newline at end of file
> diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
> new file mode 100644
> index 00000000000..bc9e8f39ec5
> --- /dev/null
> +++ b/configs/khadas-edge2-rk3588s_defconfig
> @@ -0,0 +1,146 @@

The board seems to have an SPI-NOR flash. If it can boot from it, you 
probably want to enable

CONFIG_ROCKCHIP_SPI_IMAGE=y

to generate u-boot-rockchip-spi.bin?

> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SYS_MALLOC_F_LEN=0x80000
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_MMC_WRITE=y
> +CONFIG_SPL_MTD_SUPPORT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SYS_PROMPT="kedge2# "
> +CONFIG_AUTOBOOT_KEYED=y
> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
> +CONFIG_AUTOBOOT_STOP_STR=" "
> +CONFIG_CMD_BOOTZ=y

Can one really use bootz for Aarch64 images?

Otherwise the rest of the defconfig looks pretty similar to the rock5b 
defconfig so I guess this is fine.

I'm very surprised there's no -u-boot.dtsi file though. You may want to 
check that everything that can be used in SPL/TPL makes it in the 
respective DT (spl/u-boot-spl.dtb and tpl/u-boot-tpl.dtb). E.g. if you 
want to be able to fallback to SPI-NOR for U-Boot proper when booting 
from eMMC/SD card, you would need everything related to the SPI 
controller the flash is routed to (as well as the pinmux, pinconf, 
regulators, etc...) be present in the TPL/SPL DT. Nothing we cannot 
improve in later commits though, so not necessarily a blocker.

Cheers,
Quentin
