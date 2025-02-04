Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA88C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40C280562;
	Tue,  4 Feb 2025 18:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="aNs/zRZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 611A780562; Tue,  4 Feb 2025 18:30:32 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC0680040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFvDkfR3TJoeIwOs74mCIAIdRM5iGFnc/WShP3HQzlBxab7nmQ/xJr5w1nwSqim1uJwn4tNt9Kyepq39Qp3KeWc6tO4VUsZWgCX9QMll07dF6X9E1Dc8zfmEBxL8ntzUyKFXKxS04c0txz9Nih1dqHkvbD153QhTRTmVoGBMpe5w5Us9GvUduJOOI8eIBADiFlVu1bdTe0n0ANquTU3Zi8Xjk8ySCXcSNyX7VZ0TVUNwb/PVBLJnOWMBxBmfhsrN4yH9cuqMgTNXMsOSlD7TBRw/OlMsdf3uRozGsZne5zMRL1T89a7yPQQaSn6G11jstJso5wWaz+y8nu14vMwiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tTlJKhmyuM+JGU8Xs1aRL481342N/5QxmYZIFcKnpM=;
 b=l95kG/f0ocGOktutfJENnWhALULrJeS2g1lqcQoD9eS7GP9JkduwF4Rb22JY3hTJqD+UJs7ifIi056CwpFj9U4PciVZCCH+N9uA8WtISV7yDNhiioqxkWNMlEDrjT17RPBEiqb9nyiTozc0gTXutdOvJ1IUGBEUWNLqc7EKztyUKvCD1vXBCeTyZuJnh0xWAUIlNIqaKj862aVbFMd6dPZNIGxxNgrawBZ5hR24L7pg1zWD5lHf2WEpbKsrCIboIwdlwznJduSEfs8R7J2OejMIK/Dve82RoWyrARr+frkzXbjAFiEtlPhMzjgJUGXf02TZwSffzOiQYVjO2ZBD96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tTlJKhmyuM+JGU8Xs1aRL481342N/5QxmYZIFcKnpM=;
 b=aNs/zRZ3Pii6zeMbgTnNQFAuEBVTEx9v5D3zRqFdnUHEAOtt3pWKH3ipWp0mk1nNPWIPYFofo22VDeC+E7vnM4D5EKNaOIDaTnFJDq0HNeUUL6wwUCzqjrSrQ9BDXn9G2AVB8qjan3Q4CA1En6EQKuLcBfvBooY0daGlDphqmcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8744.eurprd04.prod.outlook.com (2603:10a6:10:2e2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Tue, 4 Feb
 2025 17:30:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:30:28 +0000
Message-ID: <753811b4-5fb9-48c9-92b5-6c119d58fd99@cherry.de>
Date: Tue, 4 Feb 2025 18:30:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] regulator: rk8xx: Add CONFIG_SPL_REGULATOR_RK8XX
To: Justin Klaassen <justin@tidylabs.net>, u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Keerthy <j-keerthy@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, William Wu <william.wu@rock-chips.com>
References: <20250128213852.465664-1-justin@tidylabs.net>
 <20250128213852.465664-4-justin@tidylabs.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250128213852.465664-4-justin@tidylabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8744:EE_
X-MS-Office365-Filtering-Correlation-Id: fafd5cf1-155a-40cf-4872-08dd45419d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWl1bHNsU0xxUXFsZU4ySVpWR21DZm9hdk4wTThib0dsQWs2TGNXblFjQjA2?=
 =?utf-8?B?ekg3eEVteVZXaVl5cHFUWUNnR1NQTEt4UnpYOXhnN1lYdUJSb0NkZ1ZWL1Fy?=
 =?utf-8?B?OUt6VmFkcGY5TkhTMkd1VXk0RlpKRmoyMXBMSHgwMkplYWhKcWlhdzFjMkpT?=
 =?utf-8?B?Mm16Z0RFcFMvVWdYU2RCMEJzUXZsUXBJQnNqQ1pMOGRRQUszcG1VMHNRN09n?=
 =?utf-8?B?ODZWZGI1RERaZkU5ejZ2U2lVN0FDdmliamVXemJ3aUtYdlJJZnVuTkFUU0VG?=
 =?utf-8?B?NS9VVWh4REdNNHVZVzlLenIveVlQa2ViR1pJTWtGdFE5djVlbmxxcGgvREVq?=
 =?utf-8?B?S2tCM3BkdUJVVDVBZGZhT1RPclBvcEVoMTYzTzBCREd3a1ArTzNLZjYyTW43?=
 =?utf-8?B?OHZhL0l5K1E4M2hkcFJtUHJEMGVjQU5Wd1RlTjN4Q1dVUmJzKzR3SDdOL2J4?=
 =?utf-8?B?aWdzdFhvRWpnUU1xSFdnMmozeWJ2UkN1azdjT0JrTWVBQU1QQ2UrUllmYkFn?=
 =?utf-8?B?SDJHQW5QMlV1blNiMjREVGFMd1Jlek5LODVtUjNFOHVNcXVFS1NJZmR4bFc5?=
 =?utf-8?B?NDJ5azFZWnJieTVIWGFxRHZLVDNBMXdEc2d2d1RZR0JDZzFVWHM4UHgyZzVl?=
 =?utf-8?B?UmxRT3hlQnk5bDl1NVVaYWdaNitKa0swSjFsalFmd214YmhvTzBsaWNrOE9B?=
 =?utf-8?B?Sy94cjZEYjJyYjIxL0ZhTE9kYlhyQjY4L2JhVXJNRlZ1dlh4S0trWEx1Q29Q?=
 =?utf-8?B?SmMxUWtVcVNLSXBFOGtrL0ZxVXk0aml1QVg3SXRUcEpuTGZvajhlUXNPcHFI?=
 =?utf-8?B?VHQrQnZKUERZekUrc3lvdFRGZlBHU3JKZDJpOHJOZmxTZ2ZmUFR2U1Q4R3gw?=
 =?utf-8?B?MDZ3eDhKdjd3WTJrV2ltdXJVYkpWOElaWnpuYlFsdWFkNHFQSDVTc0pSL0ZM?=
 =?utf-8?B?eDNhSmtEWEl4U1NhRXpZOUVHbm55K2FNWXFtbTZHYVcrcjZuNHdCeTZlcUwz?=
 =?utf-8?B?VzdxR1A2Mk5FY1MzeVhqOE5aemszU2NlRE1mRXJUZlkvajhZMmFFQTFkRjBz?=
 =?utf-8?B?RUZIQmJDZm1XZEgrQXJoTm1UelBZaXJ6VklsMlZ5NUl1eDc2Y0dWMGVlOTFX?=
 =?utf-8?B?OTloNkQvYWtERWNqSVBqcHozdVpxSWd6a2lTbzlMVkNsbVVjQ2dvSXBxL2ly?=
 =?utf-8?B?MnRMaHZzYW42T2tLRmhKcUEybkN2QXNLVWJvNExZKy9RUU1IWE9SU09XSnNs?=
 =?utf-8?B?Z2cyT3NLRlk3MVR0K3h3QmNrZWRqRmVEU3k2MG9uK1lyRVAvOU8vb0VMTG5s?=
 =?utf-8?B?TEtYOFVia2owODY1TksrZ2hQN1pWOUxiS1BXUEdvUVhFYWVOY2xSSEYxQ3ZF?=
 =?utf-8?B?bElDMENJelp1UXZCNVB0NzdlQjdLRllZZldKeGRvTFcxSk9qb283ZkFyKytT?=
 =?utf-8?B?dHdlNzZyTTRJSktiNHFWRjB5eDJ1Tk1PTFFjYng0ZUJXSjN1NWE2ZXNvckdE?=
 =?utf-8?B?QkxBYStMQ1JrenJ2YWZPeW9xOUozYXQ0cHlYWCtMaUg3VXV2dU1OTWxTV2JS?=
 =?utf-8?B?ZzFIbmpLY0VybXlUSFBBb2RKNHJneXhQelgwY3A5UzQ1aG13eXJjdlZ4Yll1?=
 =?utf-8?B?dG1FYzNNcER3ZmNmS05Mc05mM1NuOHFWWFpkQU1zVjRiS3pQcWZrQjNaWUNm?=
 =?utf-8?B?WVhlVFd5K1VIRHhlZGlwRDA4TGlTalUrM3o3KzlnM2E2V3piYm1scTl0eVZv?=
 =?utf-8?B?WWF3YzF6MEE1S3lDMXNUZTkrWjJoakN5YmRPL05iUmlOMG12VFBIV05XanpH?=
 =?utf-8?B?Mnl6aU4yb0FzdWtsZ2dERXhCOVNqZHlUUDRVQVVPcWJyOGdJMjZoQkdHT1dV?=
 =?utf-8?Q?J7InUtT9ybRxd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzRtL3ppVXgyM1ZlekVGVkFxZlJZN3BEU1BOcFJ6YTBzcGs3WjE2c1ByeHFy?=
 =?utf-8?B?MDN0MytMeldBMUt4cko0RXdTcXhXaWpZT3ZvcHVZdGY4Yng5WHo0dVEwV1pV?=
 =?utf-8?B?ZG5mMWFRenRiQ2VvS0IvS3prVWNrVTlucSs3dzVLZmFqbkpBTldLUVlXdWh6?=
 =?utf-8?B?WW84bXV4b25meGNSN3FiUVNKVzFDMDQxc0VQVTdtR1VqMFhUcGFmYk8xNFFM?=
 =?utf-8?B?ZlFFakdsbWhCMnpVSmNZREs0Ny80Z2lzazMvYmM5eTFUQm42eXFZNFpucjBx?=
 =?utf-8?B?c2JzRDN2a0FoRUkwT1AwSlU5aFJZeGkxVnE2bWp5c2hBOHh5cW15VURNL2c5?=
 =?utf-8?B?QzlDTmxJOEhhNXpuR1lKeHpJSzdsWjhqNkhxeGtyMGl0RmhqZ2lMTlBYazRJ?=
 =?utf-8?B?dE5IR2ladnlrOTcrYUV1MkJBQnFCd0tBQXlFZzF1WVo4U2VEV25LcTdJdVNV?=
 =?utf-8?B?TzlPT2ZacjdMV2xldFJtNkRrWndKdEtFR0VPbXl1NGhkckJ4am5OT00zUy9z?=
 =?utf-8?B?Z2lHNm9NN08wYldDRnJyV2dwYzB5VzZtbDR0eXFUYlBWek4yM3l5N3V5TStt?=
 =?utf-8?B?ZzgvSGZHdGtkQWtnZCtJbnkvamNSTVFXK05mbjFZUmlDbW42bG9ZVDJySXdq?=
 =?utf-8?B?WlpiZ3JvZzE5aWt3ZTB1Q0FxUURWZnVZY3crbFVmanRVWEdPT1BsMW5BS0ZW?=
 =?utf-8?B?b1dzcnlKdnlYdmRpeEFHV0RsckowYmtaRnJhbmFQY1dxRFlZeCs1WVQyeTlw?=
 =?utf-8?B?eU9HQXY2YkJ2cGV1VURXUDhxNTBLM2FpRTkxcUY1aVJTYnlCRnVmTEpOaGhZ?=
 =?utf-8?B?Zi95UXVHR3JUUzg3dWNWdXdHbzlXRnlxR0dIWmZTLzZrVkFCT3FILzRYNmNn?=
 =?utf-8?B?ZjdHcStmdVJDZUZwK0o4dDA2cWpUWm40ZGowMzZ5WkNBTysxYWl2dG1kRzFt?=
 =?utf-8?B?MjcvSUNZb3grSFM2OUJSaGMxL0ZnRkI0RGxXdmhabGZLRjRBNEJOUDZRdlhZ?=
 =?utf-8?B?NWIyY3JEVUJYTUVoZFliU2pBY3ZKbkpWUXQ3MTJyMWhEY2JqNkFoeDlvWC9a?=
 =?utf-8?B?VWhoYkhZZ2QzMUFwNEwzNjVtcWR6cjAvSVh1TmE2NGtNYUcyQ0tJYWdGTFJH?=
 =?utf-8?B?bUM0Y0RTS1JBMTlaa05KaGNLaFgwRUtubU8veHF4REVqZ3BxazZmVTRyVXlo?=
 =?utf-8?B?V3RONG5qWFBQcHZ4ZGpTY3RWZFN4aW5nZFVtanlBb2w4bll5NjNuQXNlaW0x?=
 =?utf-8?B?UXpJYUNVMVZJNDRCQ1VIS1BiNUxSbStJcWtBU3FRdUNnTTNnQ0VhSVBKZE9H?=
 =?utf-8?B?YUtoZlFZaG9jZnVPUXlDR3crZG9wZTZDRUdHTHNlWUpiWU1kYnNxYU1INmwy?=
 =?utf-8?B?dEs1RFNVTlZRUnpWZ0JFcU5BRSs5KzdaTmhNK204ek9mQ2ZKYkRTSG9JWGVE?=
 =?utf-8?B?MEdtSk00MVV5U2hqa01neXdvZU0yTlhrUUlCb3ZBbW9iZzBYOXBuRCtOUDVH?=
 =?utf-8?B?SFRja1A3R2VHNjV4WGl5ODF4N1NjaExDTi9CdWNDT2ZpUmEyWC9IVWZLeUlH?=
 =?utf-8?B?cEh0Wmlja2M1cTlWdEcrK2REandySE5kZTNQNXA1Uzd5dE0vWC8vNENyOUhF?=
 =?utf-8?B?cVhqbnE0dWJvTGx5T0pTRHJaRUxQZE5lRXZWSEJyOTYzM3hmM2FsRWg2NSsz?=
 =?utf-8?B?eFFabFA2eXprVXJZRUVENm0vK0pWYnNmdis0MTM1TXVEa29OZnRsU1ZoMHpw?=
 =?utf-8?B?ZlpadlBjMGF2amNrNzVuUXNQeWMzOVdrZ0tRNzFrTVFGRWNFazY0YlZod1hl?=
 =?utf-8?B?TWhtbmZnbEwwOFJrMVpZUjU1RTE0eXhlbk8zOFhlMHczMTBXSWU4QXdEakdy?=
 =?utf-8?B?RWpWcnpNK0EwU29HU2hkYjNqUjN0ckdqNUxOSm93ZU5NMEZtUmtVK2dLRVZi?=
 =?utf-8?B?bmFGblZFTmkvYjd0Rm10eVdweWFBa2R1QiszeXBVQzFEbXZjRmRCU2FWZWNI?=
 =?utf-8?B?ZWsrS1d0TURETk1XTG9oYi8zaGUxcTA2VkRWL0ZxdU50VkxDdnlFNzBvbHkr?=
 =?utf-8?B?eXhFTkF5dERYQ29BQ0JhYnFnTU81cUh5ZzBHcEk5T2NTY1o1MW8ySytBbGxS?=
 =?utf-8?B?VldpZ3c3bnljUC81bENWUWxKdGxPRjFzQndKYUZYUnIzUS9KdVkrZFlFQnRw?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fafd5cf1-155a-40cf-4872-08dd45419d34
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:30:28.2546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/qMLaR0LbODBHqU0aGBY1k2yJdWtDlyWPCJNGtPSoLBIs/5FormlvuumnfggJNMsRnj1qGBiEqh+6mPUoluZO3qH0/TjBptdW8k8cq9kcs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8744
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

Hi Justin,

On 1/28/25 10:37 PM, Justin Klaassen wrote:
> Allows use of the regulator functions of the RK8XX PMIC in SPL, which is
> necessary to support the functionality of the Rockchip IO-domain driver
> on relevant platforms.
> 
> Signed-off-by: Justin Klaassen <justin@tidylabs.net>
> ---
> 
> Changes in v2:
> - Added separate patch for added CONFIG_SPL_REGULATOR_RK8XX Kconfig
> 
>   drivers/power/regulator/Kconfig | 9 +++++++++
>   drivers/power/regulator/rk8xx.c | 8 ++------
>   2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 958f337c7e7..9b50128f859 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -241,6 +241,15 @@ config REGULATOR_RK8XX
>   	by the PMIC device. This driver is controlled by a device tree node
>   	which includes voltage limits.
>   
> +config SPL_REGULATOR_RK8XX
> +	bool "Enable driver for RK8XX regulators in SPL"
> +	depends on SPL_DM_REGULATOR && SPL_PMIC_RK8XX
> +	help
> +	  Enable support for the regulator functions of the RK8XX PMIC in SPL. The
> +	  driver implements get/set api for the various BUCKS and LDOs supported
> +	  by the PMIC device. This driver is controlled by a device tree node
> +	  which includes voltage limits.
> +
>   config DM_REGULATOR_S2MPS11
>   	bool "Enable driver for S2MPS11 regulator"
>   	depends on DM_REGULATOR && PMIC_S2MPS11
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 368675ebb9f..88453bb7bdb 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -16,10 +16,6 @@
>   #include <power/pmic.h>
>   #include <power/regulator.h>
>   
> -#ifndef CONFIG_XPL_BUILD
> -#define ENABLE_DRIVER
> -#endif
> -
>   /* Not used or exisit register and configure */
>   #define NA			0xff
>   
> @@ -202,7 +198,7 @@ static const struct rk8xx_reg_info rk818_buck[] = {
>   	{ 1800000, 100000, REG_BUCK4_ON_VSEL, REG_BUCK4_SLP_VSEL, REG_BUCK4_CONFIG, RK818_BUCK4_VSEL_MASK, 0x00, 0x1f },
>   };
>   
> -#ifdef ENABLE_DRIVER
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>   static const struct rk8xx_reg_info rk806_nldo[] = {
>   	/* nldo 1 */
>   	{  500000, 12500, RK806_NLDO_ON_VSEL(1), RK806_NLDO_SLP_VSEL(1), NA, RK806_NLDO_VSEL_MASK, 0x00, 0xe7},
> @@ -454,7 +450,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>   	return ret;
>   }
>   
> -#ifdef ENABLE_DRIVER
> +#if CONFIG_IS_ENABLED(REGULATOR_RK8XX)
>   static int _buck_set_suspend_value(struct udevice *pmic, int buck, int uvolt)
>   {
>   	const struct rk8xx_reg_info *info = get_buck_reg(pmic, buck, uvolt);

I would split the modification of the c file into a separate patch as 
the addition of the symbol and the modification of the C file aren't per 
se co-dependent.

Their order wouldn't even matter in that case.

In any case, looks good to me so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
