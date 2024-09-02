Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1691ACD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 11:14:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 865BB88600;
	Mon,  2 Sep 2024 13:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PdgBadpN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5954488717; Mon,  2 Sep 2024 13:14:37 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577B687DEA
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 13:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQHIfn20aIV3T/Z9BhM++UAWLxm5ArX/jQY//56l5D2qD2fRBjGMDvExqcMAKrZuBrhD3OX+jhGSYgwogQmbbr1xGF0ve3YyTu1MBE7KjQ8GmvxM+qZf4YfrEl05fUqngVLIsVTBgEircTY4l+Wok5KRVe2o1nsLR4xw8yazRLcjsOJcvKPZwyFCtSeTWj4JG7Rb86OamU0DSjHtKVrebRkMUjWtwpHVQ7P6XSTnWdXIdVHIDzRr7WfvYU51Ca8gP+nz3MCyqgleauJsh6kLGptMtAizzIEAg3NrLWQ5qaOTFMnyNNPJul7hAH0fvY7Pk+XtGE+qduuI4tCXlNx+Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKlMoq8akXdDdIriZIpGKrB66fPrVLRtHg17VXwn2bQ=;
 b=IUuZETLvYpEhNfnT06NETXIQIzi+RXdTuQ4cqMMkM3poRkG65leFtTnwiHPi5fuQAGueTHnyUPIH46ZOAIpnr0FnlPxWVjzsEWG1Fq9ukgL7156tIdN/huuXyaVlAy59LOc6AcMv+Btu5Pc3mUUmu5VFzJZluVY+FFuTsbM2HNr9YpOaxYtJOQMQWZmBqhJzEgpoJjPO3IFA4ni46KKNL2RqpFLB4kraw/v51ojIP1/BY8fV2d2xz/MnDRDsNr6ORhSjmpaQ44czqy3hRA0P6Kiel1m8WeppbeLYv25vTjcQ9guJ0IoVJmd7c5WSRssZFq4oAhRrJmSf5Ds+KWTx/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKlMoq8akXdDdIriZIpGKrB66fPrVLRtHg17VXwn2bQ=;
 b=PdgBadpN0lcBrcReJfzMc99MJthNGrmL4nYYIpozPNVgkMZe1WVRAZFqE2JscJBg4lyKRVC8aAiHpsrmYkAlE6eNQn28tkkQeNH6vPT2Yih9IInFfZVwm7I9J25CixQjnyhRn4E9nlnf0qPJlandrR7bx/CClkbdXddR1iVMVl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9255.eurprd04.prod.outlook.com (2603:10a6:102:2bb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 11:14:33 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 11:14:33 +0000
Message-ID: <c88ecb98-b5e1-40aa-9a25-3739642e4ea0@cherry.de>
Date: Mon, 2 Sep 2024 13:14:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] regulator: rk8xx: Fix buck get and set enabled state on
 RK806
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240830224207.2568205-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240830224207.2568205-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0143.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9255:EE_
X-MS-Office365-Filtering-Correlation-Id: 711cfefa-900e-46c4-1305-08dccb406c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZldhcFZtSHRIMEJEWjN1OWN1SkMwSldRRDJpc0dlV250VUM5cGJOVjBUS1pq?=
 =?utf-8?B?eGJkdzJsNG14em56alYvOFZ5U1R2T290MG1UUlJHLzFKTmNIaVpFWWFPVTZC?=
 =?utf-8?B?MnNYaEJWdVNVUno2WFhQdmJFekRBb2o1S2ZkZWs1ZGhmc1pjQXl6UjB4N0Nu?=
 =?utf-8?B?KzlmWG9VQXZ4bmtIYVZmZzEzSzhGS0QwRUVINUpRZDgyNXhDVDJlWDFlZVdV?=
 =?utf-8?B?SDBTa0ZWeHN3ODVkcHU4Z3k5V2VHQ3pRVDlhaGhFQ01mb1pSYVFjQ2tZVUF3?=
 =?utf-8?B?SnFyYlVZVU9vbE1nTThLWXQxSlhSdG52eFlSQ0tQUElHZ0xOTUpTQW81Mll6?=
 =?utf-8?B?K3hnTEE0d1FpNzRGVkZDbXd6WUJ1Qy9IWlNvQ3JwSGZPaThIMW5HTDZrV0Qz?=
 =?utf-8?B?ODFrZllRaFp4dTBaNGRzYkxMY0R0VEhyY0x1Z1FsTW5GTmxwUi9ZWDVIV2h0?=
 =?utf-8?B?ZFpHUWdZWkw2OUg2ajZkWm16eWFiWC9MdkxHbE95NXBNOHl6M1lzRy81WVVN?=
 =?utf-8?B?MFFXeDdjcmxtVFBzMnlKb2xZOHpLSnFKVzZXNWJhL0p5Q0I1L2ZWNDQzY3RS?=
 =?utf-8?B?eFlMcGgyd2FPS3FXTmkwaUNpNitHZ0tYK3VKemxCM1k3Mm81K1ZFTzBqUFM1?=
 =?utf-8?B?SlBycjg1QTJQU0lmWWlFQk11UUplUllkWThDd1pWeVJYL2hjYXFIWFlGTXZo?=
 =?utf-8?B?QmpTRE1rV0xrSmxhV2EwR1NBeitzZ3NJUGY0ejdBL2FWWk1rYjFXcHN4K2Yr?=
 =?utf-8?B?STBwKzlmRzVpVzU2TEdIT25kanZuQnkvMk5IRk9jRENxSXl5ZFhOYXd1RElN?=
 =?utf-8?B?djNWdHdacG9NQWp5dlpCcFJYeC9iN1pxemlLYnNRTVNuaXFKUGFXbFBVeXpC?=
 =?utf-8?B?Q3FqMExqWTNoejFyVjhBUlFRS3FaVHBKNDdLSXhxNk9xZjlQTllDTU1PWS9j?=
 =?utf-8?B?K3dpajJjL2tkQUxlWTZ2TnByY3pNeDQ4T0pzazJScHN5ODFid1dPdklOTEpV?=
 =?utf-8?B?WnpGcWFKUWJEYytCQ1lGTDh0Mms0dFFnc3hsTWxMVEpia0ZpbytZTm91V0NB?=
 =?utf-8?B?Y2pCOGxLV0R1YWVzSkpFcW50MVV3NXZQSklFdmRpeHczd1dmeVZKV0VmdmFr?=
 =?utf-8?B?QXpWUERxcHVGVEQ4VEJFZWdnWktnR3hvaUlWdEJsNnZiZ1N4N1ZzOCtUWWtC?=
 =?utf-8?B?MlJkQkFSSWt6d0UrMTVJWWwvYi9CZmlnaytxMUtWT3BYSjU4T0t1RkhBSEdG?=
 =?utf-8?B?R2FCMzNNbGQ1Vm9GNDl0Z09tUWJTRWZHaGxaZHU5TjVXcnJGaVFIYTQ4eGhJ?=
 =?utf-8?B?ZEFpQzA4UTFtUkk2ajU2N2xZd2FoZUtYWityOTd1amEyYXhYTy9FV1JQemFw?=
 =?utf-8?B?OTJqbG9VTTdsRzR1eEhOZ3FOT3YrbUdRcDhOTllQaXVoclY2aTUwS0l3elZn?=
 =?utf-8?B?U3J5S3dUa3RwQWVmd1NDenE2dzBpVTg5Y3JLRTdmVHpxemlvUlJpVXVONGJP?=
 =?utf-8?B?bFhPUzg3WVlvclYxQzB2WHN4dlBFRDNOeklMWGN0aW1kMGpyWGhpdDBjNmFH?=
 =?utf-8?B?TFhoN0NhZ2lnZVdCaWlMMlpwTFBXS3FwWVJ4Q3p0ZGQyNksyYXZJSDVReUsy?=
 =?utf-8?B?NC9SaVlPVlhmOWFqK29oOUhCbEdHc3paeFg4TWZwTDFjbHVqSDBoOWJzWGN1?=
 =?utf-8?B?OW01Y0JZamY1SkdQK3NNTkxHK1A1UStBTEVaTEVVOXZaMSsyYm9SR0FUMWJ1?=
 =?utf-8?B?cE5naFFaNlovUHVXa2RTQVkwRDB2VUhpRkxqRmc1U2E2QnVwVThsa3hQOGs4?=
 =?utf-8?B?WGM5SlVWWHJsRUZCOHpFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXJDNTNsQ2h6aWVVcktoWldtenlMbU5Tc2RoWWpDUzM1Ly9JRHlVVGpsNXlo?=
 =?utf-8?B?UW9vQkgxeWRSc0l1cU50OEZNWHk2Ni9nWFoydVY0Q3JUUG93dmFGRkw3RUtu?=
 =?utf-8?B?ak9EK1lGOTYwQzl5SDFvblkvS202bndxYVFMbWdPeGtZNTlNUENUd0FIb2tC?=
 =?utf-8?B?UUJHd3FQTXRISXBIUWIzTVZDZHBkM3N0RXpIbkMvZk9DenJ0VUdEK0VwYVZo?=
 =?utf-8?B?Q3hDVVlJcFBTR2Nua3RKOUtKdENiU0hwNG4vcUU0RjgrdVhZU2E4Qm56UER4?=
 =?utf-8?B?S091c0Z2RmtGWkttSGNSOGZVVDJ3MnRFdXJGblFyZDJ6Tm1VWm55T1czQTYv?=
 =?utf-8?B?QmVkQWZhNVRSY2lHKzQwU3NDTVRXVU5mUjZ2ZThuTGRia2QrK2VEMytkSVA4?=
 =?utf-8?B?VHhRUno4dzRBMm5UV0NjS0wyOEt6N1VvckUzOFp6Um5XUXQrdkpqajFvMldz?=
 =?utf-8?B?d2N1Z1hlRDR1UTF6R2FOYzhnYURqQ0cwVFFQMTVKOXd2UHlEZWIySkYwVEVv?=
 =?utf-8?B?aE52S3ptMjRmWFV0TTcrVmQxcmgwSkdNOEJrcVBmbEIwZFZkYlFIUDlqUDdY?=
 =?utf-8?B?TWRxSkJjd0FMRVBobWRPZWsyQXVxM2VvaEwvYXRydXQzVE9UYXZxdXVURjla?=
 =?utf-8?B?VEJBb3VDeWRvQy9YamdOdlVKU0RuMmVLU04xRXJyYklkWEtwZGFmdkdmRFl2?=
 =?utf-8?B?UlA3L2FZUTllcVh4dnhndlJyaE01anYvSHdPL09sUlF6ekpKUTk4V3VJaFlI?=
 =?utf-8?B?a1NyTTV0RFpjbCtXR0hnLzRQeFdNMUtJWTlVTHZSWVdZTVljRUxEQ0JVNzlO?=
 =?utf-8?B?RTBwQXF2UzdpRmRVRENNN2ovd085TThFZHVyYzErUUNGbmpveVNiMk5KcWJk?=
 =?utf-8?B?RmZsWDMxUGhrTW1udk9MREpOZ0hhRDNQQWtSOWtOR3pnVzFjcE8wLzh5R2RZ?=
 =?utf-8?B?MUc5Wi94cEdwVUN3MkIva0RsTVNITGU0N2R3NzFqZFhKT2ZvaHE2WGYrYTY2?=
 =?utf-8?B?UU5QcFhNbHZRTVBUVG1BdHoveEVNZStIdmxUdUJMMTVDZm54TkNENzVzRVhm?=
 =?utf-8?B?YzdyZE4zYUw4LzJzKzFYb280MjFMTFp5ZytERm56ZFpoTTdLbmVxSTQ3T1pX?=
 =?utf-8?B?cGdQZU02MXlaYzBKMVAxYUMwMU1PYjlZTGFnMTBSMU9oMU1oSjJSNHJ1MExS?=
 =?utf-8?B?TTJMVWhJLzByNFJvcUdLVEtRcWFldlJWdkdZYzlOTVpBalRtZ3B2eDB5dWJF?=
 =?utf-8?B?NXYvZXBEemMwUVNuQzBwRWhQc3FwbXh6MHYxSThiQy9CdXpsMzluMzFJNkVJ?=
 =?utf-8?B?akh6NDNram54cnlTbU1WTHU1TWxlVVZGOU1CUWlUNU9VTllDMDdScUZhVjJX?=
 =?utf-8?B?VVhxZmI3Y2t0bU9RemxPemhvMGRCZ2NCMEhrblpFeFVXaDdpYnBoY2JLSHlr?=
 =?utf-8?B?bWwrZDAveU9JQmVuVHJxT0dmeVZENHU1VW1KQ2FKK2tTR25hVjN1TzhBTUpP?=
 =?utf-8?B?cUEzNEU0NnFPbFMyUzgra2RMc003ZUpDbTB5RW14SXBUTk1uWlFhUC9FamVO?=
 =?utf-8?B?cWZ1b0pCZHpiQ0xjVHl6SnNFeHkrLzhPeFFqOWhIYkhyRzdJdjRGYytsa3ls?=
 =?utf-8?B?MkY2YmhZaitYNU1YNFU4YncrckJnbUZ1cG50Wm04cUFzSXJBU2lBRlhiRmo0?=
 =?utf-8?B?UG1PM2VrblhPWitKdXBpRG5PcUc3dTM5bU8vUG1mTXlSdEVPRkcyYTh5RmxR?=
 =?utf-8?B?aVBOYklMTGZhS2VJTU8rK1ZINlY5c0pFalU5RjhHVmxYMlNRYVBZOXo5VU9F?=
 =?utf-8?B?VzhqOXRvTW44VTRzVW5NK3djNkMwUENqcEZwWTVObW5xdU5MbGVKaUQ0S0dU?=
 =?utf-8?B?S3hHR01SeXhrRkNYZzF3WW94bVFlRkNVclcrcGtPcDdRNktTQ245d2Y3Zy9U?=
 =?utf-8?B?TmZKcU9Cckw2cVV0MTZ6a2tQY2tndWJzWThVMXZ4U1ZKNEpFTzk4alRHVHhT?=
 =?utf-8?B?d1BtQVlqaUJUNCtRbys1V0s2eGY5b2w0UDJWMjlVa003bFBpOGc2Q0tFL2Q0?=
 =?utf-8?B?NzRnejlGTWhLNXplSG9YZWRBUDB6MjNZYTYwbDUzWUNjTjJwdHRTRDZpVHBI?=
 =?utf-8?B?UCtWNFAzVmhaL1UrcXhPcHo5N0xQNENZSzI5TjVYWXNtNHRlR3BxWEtpbXNx?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 711cfefa-900e-46c4-1305-08dccb406c13
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 11:14:33.4295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIuowDEfNgdD5bwgLdapWSeEJ2Ae8V2eR11LcOyYqMmXtgL5oebE8DsxQHii+EHMVATAbViDKfnmwGPNe/NJQDvOCoHj9yNCouZ+lWB4jZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9255
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

On 8/31/24 12:42 AM, Jonas Karlman wrote:
> Wrong POWER_EN reg is used to get and set enabled state for the RK806
> buck 4 and 8 regulators, also wrong POWER_SLP_EN0 bit is used for
> suspend state for the RK806 buck 1-8 regulators.
> 
> Fix this by not adding one to the zero based buck variable.
> 
> Fixes: f172575d92cd ("power: rk8xx: add support for RK806")

Shoot, I made a lot of mistakes in that driver :/

Thanks for catching those :)

> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/power/regulator/rk8xx.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 34e61511d884..3f5ec02b3824 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -415,7 +415,7 @@ static int _buck_set_enable(struct udevice *pmic, int buck, bool enable)
>   		break;
>   	case RK806_ID:
>   		value = RK806_POWER_EN_CLRSETBITS(buck % 4, enable);
> -		en_reg = RK806_POWER_EN((buck + 1) / 4);
> +		en_reg = RK806_POWER_EN(buck / 4);
>   		ret = pmic_reg_write(pmic, en_reg, value);
>   		break;
>   	case RK808_ID:
> @@ -494,7 +494,7 @@ static int _buck_get_enable(struct udevice *pmic, int buck)
>   		break;
>   	case RK806_ID:
>   		mask = BIT(buck % 4);
> -		ret = pmic_reg_read(pmic, RK806_POWER_EN((buck + 1) / 4));
> +		ret = pmic_reg_read(pmic, RK806_POWER_EN(buck / 4));
>   		break;
>   	case RK808_ID:
>   	case RK818_ID:
> @@ -541,10 +541,10 @@ static int _buck_set_suspend_enable(struct udevice *pmic, int buck, bool enable)
>   
>   			if (buck + 1 >= 9) {
>   				reg = RK806_POWER_SLP_EN1;
> -				mask = BIT(buck + 1 - 3);
> +				mask = BIT(buck - 2);

I like my (+ 1 - 3) here to match buck + 1 above. buck + 1 represents 
the buck number in the datasheet (index starts at one), so you need to 
subtract 3 to that index to find the bit index in the register.

>   			} else {
>   				reg = RK806_POWER_SLP_EN0;
> -				mask = BIT(buck + 1);
> +				mask = BIT(buck);
>   			}
>   			ret = pmic_clrsetbits(pmic, reg, mask, enable ? mask : 0);
>   		}
> @@ -592,10 +592,10 @@ static int _buck_get_suspend_enable(struct udevice *pmic, int buck)
>   
>   			if (buck + 1 >= 9) {
>   				reg = RK806_POWER_SLP_EN1;
> -				mask = BIT(buck + 1 - 3);
> +				mask = BIT(buck - 2);

Ditto.

Just a matter of taste though!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

@Kever Since it's a bugfix, can we have this in your next MR for 
v2024.10 please? Thanks!

Thanks!
Quentin
