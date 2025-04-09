Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BD8C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 11:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90C868366C;
	Wed,  9 Apr 2025 13:14:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nXrTVdx/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C308366F; Wed,  9 Apr 2025 13:14:46 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F9F8365E
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 13:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNysb6F5kY6ZEIFTGa4iektJGv0JiF+iZ8eTx3uYwbj+Sf8zOLFMO7eSMmxrqCcO+r4e3Mn/3tkERAB2cpGNuTclVErOlLZfVyjTz0wJxooi2RQ1FgiTF5nn50w3Z/5MsgZzW+IMYn3aqDRQgqQAzk/WxIFiHF7RXGDvCCy/Si7NzryJ2/Wwqq6agrXGVefoKsdQgSBGg/Pmhb+G+ywdqLvno1n3UL1aQlk89kXJb/rl3+JKCREYlu5dsRrdySIOBSEA7ejc8Xj92XW0zxYLl1AXU8K6wvMX/z9CRVUWxFWH7onfsPEG/na7rUJDUFgQwv8Z3hN3NCDwZBgtHgiJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6qBul3hs7JXHidj0PPZ5ur063FUkn2gpohQPXSlw/o=;
 b=B0UlegiWTnsoaO19zWqHKXwOMIs39xAmKc+uS7dpMSNn+eklWnWVLIlMf/gq7aBc3p9wDpbvt6ipt4+RBVEYmQ3UKYogsjV/w3a3PYepN9wyfLbNt9rIcI3rZ8DlaPuJOcgHLn917lnL/YPtstjRfS/7obJMuqFszLwHwjgFNQHMf9kB1jMW8HQIA9JjNFcY4rPnq2GdnYk8ArcxVaqJGlTV5J6qa3nssDNM4YVhG43OYP74HJchGv0yK3goKxZHc4VLpWqUUp215M36ejLbANW6FV5DWzXXnc6WcOZ5wZdOHE+9Q2qXcjxMMHNYdgdRW0BvNnBLQvrTQ5I0/p6ChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6qBul3hs7JXHidj0PPZ5ur063FUkn2gpohQPXSlw/o=;
 b=nXrTVdx/NFa2VIVmRsGqttRTCy+fYRJmq9J11jsXau/0+GdUsU3eTE9Wyuh6p1J9a7c6hviZPAPtYYZsr9CbXnEF2nCZ6W6awasQ4YQmnCjF9m/JkJgqa1+l2rAZQw4Hbe/8P6udOJsgPOtkn56V5A9Pz8dl3uBkiH96VjBkOqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DB9PR04MB9329.eurprd04.prod.outlook.com (2603:10a6:10:36f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 11:14:41 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 11:14:41 +0000
Message-ID: <914cfe6b-6ee8-4a9e-a932-4c980b18a7fd@cherry.de>
Date: Wed, 9 Apr 2025 13:14:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] rockchip: Add SPL_PAD_TO Kconfig default value
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250329150626.2879942-1-jonas@kwiboo.se>
 <20250329150626.2879942-11-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250329150626.2879942-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DB9PR04MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ed65315-1393-4d8d-3014-08dd7757b96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmFSbnRKWktWOU1vSDFHYXNNKzhtYXpnUmdCSUZ2a3B0aVl5NDFYcW1LQ2gz?=
 =?utf-8?B?cG9RaUdTNm12RjdIZjFSR0xvRUJQSmJvc3QwUmxtUHZrZ1VCcXZXYjdOMnFN?=
 =?utf-8?B?OTExL2NteENzZ1RXNWo5VEM5QStzUFJXNEF0U1VGSlhaRnlVMmJkSURKMWU4?=
 =?utf-8?B?a2NkZXBiZDFjaG82VzFLTy9COW5nM1p3b2t0RTBSL1hhM3FuUUFybjFaMjBx?=
 =?utf-8?B?QzJUNGRZaW9ZK3BYa0xTTFdkWVdlYmZSRjZiNmd5VUVNUmVmM2Z0WmRBTkYv?=
 =?utf-8?B?QnlqbmdsNE5QdFBQNUdtNUt4b0taV2VXbTdQanRaa2Z2RnZvZUhaNnE4bjlO?=
 =?utf-8?B?Z0FNRlhPR3RLVXdTTDhTSERTbWFlWFNwV1dsMzZoQXNNditCUytZSkZsbXM3?=
 =?utf-8?B?bFFBVzYyOUVUaDNwVXFUWk5Mb2cxTVJPbmtrTzNFdU9adGE3SjNnbVpzNWhH?=
 =?utf-8?B?TS9XY0I5d0w4WlY4QStTeWVoekNvN2IyR2ZONUJ4U0k2NlhXdHpCeFd2VDl5?=
 =?utf-8?B?UzNRM1l2TEFUQklPaDljcmVlNzl1T1pNL3lHRFFKNEdZa2lLNTlpZzNGbm5O?=
 =?utf-8?B?anJUc2NUS1dBK3FkSVZSTFl2ZHE2MW5lbFYxQXY1WnRoWjhlc2V5MHQyVEFh?=
 =?utf-8?B?cDlMdCtzOEdpZ3QwMyswSXpQT2cyZXlOaEU3NitoY2lQZ0lpWFFCcVdMTVBI?=
 =?utf-8?B?RG5aamRDVEJqdU1ubHF0K3I1QkhwdXRMWXFIY3dVOHRMNndYaHIxV05CcU1j?=
 =?utf-8?B?SXJyMDhRdFRIYm5ZTGZNOWRYU2pYem5sYkFvWXkzREZkTFlCTkovaDhiMURE?=
 =?utf-8?B?OFFPeVBhZTRZRkJjQjZoSVU5RkNnYTd1eU5zM3RSOHNPVXZYTUdCMWJTVlVE?=
 =?utf-8?B?bUdGRXRIMGJMYmVEQzlZcEYvNWZvUXdldEJ5bVhxTk9IUjVlejZMRUJ4SG5T?=
 =?utf-8?B?R1lORmR4RFhPeURBRDlQRExOb2lGcUZzdDFIWW9sbzlvanBka1BpSDdoNG80?=
 =?utf-8?B?WFZpRldBbytVNGtEb2FqUElRRVNYQlpOeDd2YkVoTUtIaDgxKzlWU1g5YzJz?=
 =?utf-8?B?WEV5bVl3SlBSa29kQjZDcDdrZFQ3ZVR6d0dNQlMrMThReGgwbmpZZGxjQVY2?=
 =?utf-8?B?N2w5VDlNRUU5VUF3SWJBZWFhM1JnVVJ3MDNSVzBzb3lvSnZUVDQ0K3Rtd3pu?=
 =?utf-8?B?ZS9ZOHZBYU10SmNCNVBGSEhtN1FYNEtJL1E5dWpBYzJqMysvVkU4eVFPRSt5?=
 =?utf-8?B?MFVBUEdCUGgwK201N0dWUjFFdlI3SUp3aEFiZVcrajdOY3IwRGdZUkhKbVdO?=
 =?utf-8?B?MzVYYkNNN0M0djNTTTgvejVCQ1p1a082dG1NdW5CdWpZNittSUo3eXJiQmRQ?=
 =?utf-8?B?Y0dNczh4WmVpYTNmdjhWNkdVejZBRGJKb1pISks2QkUvaGN3WDRQTTA5NTJq?=
 =?utf-8?B?bjVVQ1l2aFRjOGFralZTeWZ5YnI5YjVONkI3Y0o5MDExUzg1N3lWbFkyaUFD?=
 =?utf-8?B?ZENtRllOa2VFWXV4N1pacGFvTXhKcVludWhycFVHTFQrcDI4S1R4VXA5RFY2?=
 =?utf-8?B?cS9ydjhPMkhJdUxOblo1RVljUTcrLzR5M1NFYzhyekMvZExXVi81emhqc1Y5?=
 =?utf-8?B?M2JKSGh6TjFRRlJPZW9EWW9LUkJHbzM1ckNyaUNFWm9rbW91bGwrNFdaVFZi?=
 =?utf-8?B?VEtYbEN2UXorb0NzbkE5WjlNaENnUnZ6NWlHUFpYdGxyU1RlelJVVitwc3cw?=
 =?utf-8?B?SzNsbU9XTFNRbW1pQXpGekNWN2RSREFlMy91cXRhQ0lWYzF5bjd5ZzUwR09t?=
 =?utf-8?Q?CTWRXHEuoHVMv4/eHK0Ux5XwDbBxtRyeziANk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0V5d1NQZUtnNzdTK3k0TVdEMGNCWHBCN3UraWhiWWdzT2NNc1NmWU9VYkUr?=
 =?utf-8?B?MTMyVVRJeHVlTjNHSXkwRUtmalAxTVVvM3lDb3VlWjNFR2x0ek1Sc2hwdGlL?=
 =?utf-8?B?alZndlQzRjZIYzhTMG51UGxlakZ3WG1ZNVBEcU0wY3drR0lQMTg0WVozcVNo?=
 =?utf-8?B?c0Z0VldxUHF6bkRYNWM5aEdITjFQTUF5YWRacWdkWmVZbDh0MEtBNVR1UTQv?=
 =?utf-8?B?dkh1bFpEYmhuS0wzMm9HdjQyNVV1U250TDBackNJYW1icGVVcktVWEtBN0d4?=
 =?utf-8?B?WXZHQkZ1ZHRCMzJRamVMZ3kwM3pDWUkweWtzczlJNGFHNVVDV3hqVm5OWjRV?=
 =?utf-8?B?U3NuV0lKVFdjMFd3VVpMeWN4MzZTak9XWUhHdnZvZjE1UnQ2TTZabytzQUVL?=
 =?utf-8?B?Z0ZHcm1QTXZmNy9CWVd3TWR2d2VzRDdoUkt2b1BxVUQrVHBOSWxYaTRvVEFX?=
 =?utf-8?B?UlRZZmMyaWtJVVBvV216ZWdiZWRhWGJQTFJwUjZITGNRbXA3N0J4bmhST0t0?=
 =?utf-8?B?dUs3czBlTlRDZTdkL0o4RU5MdnNlVHFhVzNDR0RWTytrQ2crSUM4U0pobkE4?=
 =?utf-8?B?bDVOWjU4ejZKTU5ISG95eXNaK2luL21VUWwxU05ic1BFb2g5Q1d4cFY2cUUv?=
 =?utf-8?B?QXNsU0dBWlFxNk83TEw4aFpTWXQxa29MYnlCQ3JmU1hOQmNockc1Nm9NN25R?=
 =?utf-8?B?d0o4NEE3eTA2TEM4WlprelBpVTVoYXlrVVhVc281QTlkUmpGTzIwWW1YSE11?=
 =?utf-8?B?amF1MFE2NVR3MW40NnNacnF2bktoUjM2OFJZZm5mZVMzaWZKcWJOb0JYOC9r?=
 =?utf-8?B?Z2F4WXhJTHRPcW9udmVLRStZT2RHUFZMSTBPUEtZbFdsSXFzcGdzbVJMUnVK?=
 =?utf-8?B?aHRwZ1ZTNE1SZG1HTkFzV1M2QVVxN3MvS2lzSGJ2cGZMMEI2WFNiZTY4Q2p3?=
 =?utf-8?B?dml2ZTF2bnR5Qjd2dlJuVm1BWkdDNjg5cmRsVmJaMXB0T01UNVM5QWY0TG11?=
 =?utf-8?B?RlJzS05FUVhpdjZnYU5McktuUGpxdWlmNytxQjhNazM2SnBYbXp0V2Nyd3RJ?=
 =?utf-8?B?NnkyZkpJQjhhSjlPRnhac2dSelhzUnNta1p6VG81cW5XSnRickRlaDRISnFN?=
 =?utf-8?B?ZFBkekpTUkFZaVBNaE9BUnhEU3ZJcXF2SHN6eUQ1QWRuTkd1bThvOGIzV290?=
 =?utf-8?B?SUdZd2ppVWkrVFp3VXduVTRVVzRkamx1S0wyeWp6MWoxcWp2R3JFSHVEbjFp?=
 =?utf-8?B?QnYvNUZuREFvYkhKa0NqUUk5SDZ0cEsycjUvR2k4cmE3Y0phOGowRE4wWmlE?=
 =?utf-8?B?NjFtR2ZkVXRrZTFtVnVyM1YveUl2bmhOVnNmMk9CMHEvWXdrK3FJQnJyaTlU?=
 =?utf-8?B?eXJoRHVHU1UrMVYvTUt6Z01uUVRvTVZtMTkyQk9FTkdLL1dDSEFmaUlFaVZZ?=
 =?utf-8?B?Qmg0YjcrcUhHeVpFcXhibkk0aEN5ZGVNcnVJa3VKNFlUQXQyaHBjUXN3bjZS?=
 =?utf-8?B?UjE2RHRtYm15cFRsSzFhOFE3MGtGeDdyVHRzNW1NbzdCUnhMdmM0WDNCTVZG?=
 =?utf-8?B?QkJMbDR0SmtwU1ZTSWU1N0plcmszVjIrL016UFFSNTNrRHBzWGJPSFlSM0k5?=
 =?utf-8?B?eTIyT3N6ellTWXNtY0gwT0xoQ3QwMTZnczU5VjRqL0N6Q0Jia0RRT0ZJR1Vy?=
 =?utf-8?B?Zlh2RXlCaWdyN1RkWDRDSytCdThKMk9iU1BqcUtMQ24vcHIvbU9NMXFZYXZW?=
 =?utf-8?B?amJ5ck9Xdnd4SnBpZjFmS1l6UkJ6bjlNVG1OWTZTby90VFFySHVXZi9wMlJX?=
 =?utf-8?B?Nzdwd1JhM250T0pzWnZVSjRVMHpzTFNMbXFXWE5VR2pKOGtVY1JXZnpHOHF3?=
 =?utf-8?B?bC9BMXFBdFpDY0NCKzY1dUpwRHo5OVR6SGlkeFVmNjVPaFRLbDc0clhGMmI2?=
 =?utf-8?B?R3N1QWlCLzArQmdKOFlLbW5GN095bTJtbDZMRS9yT3d0dldybXVxNVdpY3lS?=
 =?utf-8?B?SDVqWitjWXVrK0xiZU9iZFg0UTZTYldRWnNVN0pjWXZSSEVNZllYMXRrT2pC?=
 =?utf-8?B?bHBqVm11cWI1eU85R3lUbHBMSUhVbmlyYnJ6VjN0c2dLaFBCSm1LUmowSDlT?=
 =?utf-8?B?eVI4TVJ0d3pzYW92eWZoUXVMM3V1bG15UzBCZzYwNHdOZEd2N29COXZYNXlu?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed65315-1393-4d8d-3014-08dd7757b96a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 11:14:41.5533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2GMJLokxiAmjobbR6Q+WKdHz5XZl/9OjcwFoy2rwZzxQlpVigiskeaKCL97/A79bL9TYbiw5nPogdsFVGH49D5dOlVU7KI0yN2CkWsk5Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9329
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

On 3/29/25 4:06 PM, Jonas Karlman wrote:
> Almost all Rockchip boards use the same Kconfig value for SPL_PAD_TO,
> 0x7f8000.
> 

Would be nice to say why :)

https://opensource.rock-chips.com/wiki_Partitions

u-boot.itb is typically expected to be in loader2 partition by Rockchip, 
which is at offset 16384S (32KiB). But because the image is flashed at 
offset 64S (32KiB) typically, then we subtract it from the padding, 
which means it's (16384S - 64S) * 512 = 0x7f8000.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
