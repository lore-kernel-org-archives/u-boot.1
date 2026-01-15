Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54B0D4117D
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 12:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DA9680325;
	Thu, 15 Jan 2026 13:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nB+OvO3f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6EBF835B3; Thu, 15 Jan 2026 13:36:20 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6EDB8003E
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 13:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKOhCysiCMrxdK2gwVwx9vXuFxvGHBA2BBc7e93La4HOjqqpEIRys01y14w/Y/wsSty1wLHpN/nyR10cjZskRiCQCmAp47C94M4fUG6o1Z2Ns7N7UrIKfiIpyIG76vDra4gnChoN8bp7iHLCPAYab0zEsUwKemid/uBJw0LmZylD4yUawPvKIAkcq4UwTUFIh1bkCoeiVZ4it+ivUD+yGYy/dpV/4s4PaLdepX0msMOnttpOI6MNYajtAxcfUdHViL+oXNCao2pH+xWKkgSuZ/FQGMIstCJ7ERx3iE08Vs5LIYeKIaUGqCBShQ8N268iNdaEWxRjn+SHW4FiMcnywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPReCcYvSXpnztV0aSwVkcSTGfoXyw1e/SwoeTGkmlA=;
 b=mOtecjEO2FWw3rzBb6KugUjxIK9xDm4fKRqcn4Q60YJR1A4eBuDfhTvLwzhqYPBz5A+IKO42HK4zOplDp5LlatjXEMy9q4LDVjmU/Jd2PXnOq9BhFMQS8pDSk2Zib2d/PwdQSsn3Rc/CtnJHTR6g7PD9pHT5qSM6uTOg7QN1wmbz1ImXcOcayJ+o3HdKPDW6k7bx5Eo3niT9SgSCS3+d+DJEkpOGqGZISN1fYl6xpvs/iIRmKBQSis88nB3rIYsxYmW2mMFRI5dCaJfh0VsS8nTGvMQM26NOqsvtmbSe9HSf2GN0l5Mg3vDUHWzuZyAl4Hek4QSFG4OAVc6sWL3PQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPReCcYvSXpnztV0aSwVkcSTGfoXyw1e/SwoeTGkmlA=;
 b=nB+OvO3fR0bXe+N6UMHPJvl33HXwnrY6LM3eJLa9QvTIdvvZGxtEFm19QF2Dh5rXkG+Duxbs2/lslECNDUVXtOAnCBDuxB+APIRzYP2sxDficIo4Q1FYIiSw+MYfPftwnRhKnHWKNe7bW1Rf90hyrP6xEovH5p9IespFKfvRE2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM7PR04MB6983.eurprd04.prod.outlook.com (2603:10a6:20b:102::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 15 Jan
 2026 12:36:16 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:36:16 +0000
Message-ID: <082479d3-3b0d-466d-8749-552e60101fd5@cherry.de>
Date: Thu, 15 Jan 2026 13:36:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boot/fit: print name of config node not found
To: Frank Wunderlich <linux@fw-web.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Frank Wunderlich <frank-w@public-files.de>
References: <20260111092338.16555-1-linux@fw-web.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260111092338.16555-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM7PR04MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f277a3c-d9a2-4e98-fc1e-08de5432ad62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WENQeHNYRmNVNTJ1MlNHQStYeHpxV0xQYWwvSi9JZEtCUTczZHkwZGk0QVkr?=
 =?utf-8?B?NzNzQ2xLRW9pbm42QXk0T0U1R3FFZGpFYjh0d3h2Y0V5RnZncXk5Ti9zQy9l?=
 =?utf-8?B?cXdmVWlBL3p5Q3ovTVVqazN1dUVxNTdWbWg1c2ljUXp3TXRZQVdFc1FwUjZK?=
 =?utf-8?B?MWlIK0hnYkh5VVUrYjdFbVVRaXRMdkM0dDV4cSszU2FMMGhLSllicVRuZTZZ?=
 =?utf-8?B?WHVOOTNSWGwyazVrd3QvT3d0dXRFM3RQV29NemxBeXZVTFp3cDdaUXhmWTdX?=
 =?utf-8?B?bkNVN2d3MExLdlBjek1iWEc1SkZVWSs0NmVHNnFFZ2J3K2U3czdCWHBqVTVH?=
 =?utf-8?B?RWFLMHhHdjV6VG91L3ZXQXZPQ3hlcnI4NDBQUFlYZXhKc2MwZlN1UWVwMER2?=
 =?utf-8?B?WWdGSDlZdVdIaDZXY2V6ODdqMThaSzBOeUkvR282eWthSTZjbmQ3YWdJWm5l?=
 =?utf-8?B?aHo3SjNCdnRjdkJQb21waFY4dVVvUFpGcnF0YUEwQVBFaVVDL0RhUzhRT0h6?=
 =?utf-8?B?NDN5R0pWcGtoeDhpT0llNWVuWGhjem9tQ3A3blAyQjRTeXBvTlFMZlpFc05v?=
 =?utf-8?B?UmgzR2pKSlMxWWV3T2Irb0hqYzN5c3VFWXBQZWRaeXRONmswbnF5OWhKZ3ZD?=
 =?utf-8?B?bXRZWTNPaDJvdWJ3NmJhbVMrdk5rUUMweGVBZlQyL0RiaUJqZWtvZDBTZGQv?=
 =?utf-8?B?WXVNckhGYXJNSkpSbDk0TitvZTBJQmhDUGw1elRKV1ZieUhDR2pET2VJOWpT?=
 =?utf-8?B?NkppK0JPQkRFWnlQQ0F2YWxmQUJuUVV4aW04dlNYTENDdzlCc3F4cUViUVNp?=
 =?utf-8?B?M05xL24vMnVEWkFDY3pkcnExVDJDTFN4M2YvdlRUcXBtVzJCSFhRVXVqRE12?=
 =?utf-8?B?b1hrUHdTQkMrQmlDWlJxc0Y1VWNWaGR6cFU5WmZmOGY5cHBNNHA0QVNkTTFs?=
 =?utf-8?B?OGplZmltSWRzTEVJVVRlQzUxT3FQbFdUTTBGWkMxOHpjclBUMWh3cDVXYmhu?=
 =?utf-8?B?ajc3SkpCOS84MFZnSko0WTFtbFM4UGdCWWNsVlprWFJGVkRNcGN4d2ZXaWYv?=
 =?utf-8?B?SDlLbFZvTFdGQ3BNdnRNeGhMblNZbjd3YTRRZDNkQkgrQXdIWXdVenZPWXhE?=
 =?utf-8?B?dWprWjZtc2IwenpndWZ4WTdBTTIrVkZPMWN6alZCM2svWk85dHlXWS9PejNn?=
 =?utf-8?B?aTc0SFBvYlQ3MXp4OGUrSHY4ODIza0w0K1BzL1pGRE80dlc4RnBEVndmSHhG?=
 =?utf-8?B?WSt4NGZsZmxEdlVjYWp1aGZVSXNuMml1SmowME1JbklaQU05ZlpmY2FOcERS?=
 =?utf-8?B?RzRWSGZCbjNTZ2pUS1lSMTJmT3d2bjJJRVZuSHNkaXJMektaWFltcksrNHlQ?=
 =?utf-8?B?TzBuSDhveXJpYXhFa2gvNkh2SlFnd004NFFBbDhSV25NZXdweGh4dXhPanBP?=
 =?utf-8?B?S0h0MDNla25KeVdlN0hrVWMyWGZWV0NVdjFwaHNEMmxrRzlYTTJRNk82YS9y?=
 =?utf-8?B?ZGZMQmlDMit5eENkK1VkNi9OR1ZqSyt2UTdpQTBYbWQ4VlhtcDNjYW9BbnVL?=
 =?utf-8?B?dzQvSytUZGNwbExpWEg4NEkwNVJHeGY0Z2F0Ymk0OWNIUE05Ui80YU5GV0pH?=
 =?utf-8?B?YytMN01GaDIyZEdLSlY4UGFUVjlEMW0xSU5aaXJLZSsxMHp2bHVkSnRESjZL?=
 =?utf-8?B?aFdlcmNrV2NocmNWWC8vRG16c2NJOUJkVElITHIrcDJOV1N2RzBKK3hEa3FG?=
 =?utf-8?B?OFdud2lzRkV3ajNBTEFsd25uWWl2N1EyK0p5OGJPOGJ0b05LUHUrNDBkZVNP?=
 =?utf-8?B?Y3MzRmt3K1p3R0Q0dmE3djFZU2FTNTJhWm9wcmR1WHpseGp4ZTM2aUxMaW9o?=
 =?utf-8?B?OFBoVDNyM21uSTRrM3dvOEY4ck8yZ0ZrU0Y4RGRtSnFqaktwYTFueS90SjZR?=
 =?utf-8?B?ZWw5RFdzTmNSVXNLVVRlZ0FqbTNLOU5vK1hwSlNRdVFzY2R3UURkbStqOUZj?=
 =?utf-8?B?N2xIb3FJeUpGT2cvNkgwNG53TUllakNBckR6M3RHcFJLOXRFVjFPcFd1Z0RL?=
 =?utf-8?B?QXFSb3pGS2VxWVV6VFo1L0NXd3lKbXRxMW1vWHkzclZ1RHdKbzZOam9JL1hB?=
 =?utf-8?Q?KYA4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1FULy9DMlBJbTc5UkZnR2hUZG1vRU0xbUtML0ZRWDB1RDRRVEJRTGVjWVZL?=
 =?utf-8?B?RHlLTHUxK2QrZFgxM1VyUHMyVzVNaE9CdGx5V1VGZXcxL3hqMkl5RzQwWHRv?=
 =?utf-8?B?RjBiQTBjV2daQlZkamZwYWp3TkZGeVlCN0NTbjh5SlBWRytFREtobWhvdVJH?=
 =?utf-8?B?ZkhMOHBiakZlbnVHWnptV3MzWmpCTEI3KzV5b2FaSGR4SjJrM3llTngwV2hu?=
 =?utf-8?B?RW9xYjVwQXdhKzZpd0dHU2p3NDRSSWdIbVQ4eTdmbjdMRkNXeDZTNzVqUHpP?=
 =?utf-8?B?czF1ODMvbnBwNlcybzE2MnRRR3pXUDFZczdiWVZGUFNFdEhFT2F6ZkZGUEx3?=
 =?utf-8?B?bUJmcFZoYU9iUC9xWG1BSU5OT2h5RmVWTFpPbjdWRi9rMlFvb3lMOUdjRmFW?=
 =?utf-8?B?eksyYmdrRzdhby9wczE3QXVnWlE3cFYxSHhOZHdYVmJxcjg5dHNSU09mQ0lR?=
 =?utf-8?B?aVZ0cjJTYk9vcUdRamtXRnVKMlJEeUVLem9qcWRCU2FmMWEySU9seE40NFZ4?=
 =?utf-8?B?YmMwQmM2U0VCdWU1Mk1xWGY0MVRPMVRwQzhDWFQ3ZHRGVDk5ZndJdVEzNFdo?=
 =?utf-8?B?ZnJCVkQrRlNuRitHdmlTVmluWDJyTlduUG1ENWovdGt6bGNQVnNIOFk4NTdr?=
 =?utf-8?B?MDlXSENsbFlFVlVqSW9lRzljMlZaV2Z2ZjZkVU1Dd01KQ1ZHSkNwK3Zhbmd5?=
 =?utf-8?B?NXh5blFQakJma1o5WlcxcytrOVVBUU1ickZsc0hFdVp1VVpFWU1vdzl2L1Bu?=
 =?utf-8?B?eFJEclpmbXVpRTZ5Qlh0dmxFa0pKS3RXUVc5MHpxMmpZdHgrZUl4V2dTeHl2?=
 =?utf-8?B?UUZJbG0rUjhDZ2hGcDZjdUwvV1g3L0kxSUJGbk5uWmFQcnI3U0NyVWxKNGtI?=
 =?utf-8?B?b3FBdGEzbkJZYllGTW4zU2VXbm1MM2VBL0dtMUpTQjBSQXFhN1lacHcxNUNl?=
 =?utf-8?B?TUlSTVBwUmtYZUx1dHlvWjZSaEJwZkxCb1hFb3g5aTNGRTN1Uk5UbWNwQ1pZ?=
 =?utf-8?B?SDJmZSt3MXZPOEMrOHRWYWE1bXc5cWNZMnBkaEJGVWFzc3ZXU1BaRGZ4djNq?=
 =?utf-8?B?VzJxRkN6STJKZnAwUFNra2JEVG05c0VoRm1pRGZIN0pvQ0RaQmNyTTh0dW5l?=
 =?utf-8?B?MUdOdVBBNDVNRGNaUGJsdElPcHFMbHZ4VlFncysrS1Zqc1NTQnVTbXp2TmVS?=
 =?utf-8?B?d3IzbUxpWXhKWDlzM0l4RkpTaTlHM0sxODFkV0hpd3piY0tUN0RRclNCaHB0?=
 =?utf-8?B?STZyVTNFWUVHSUw5bE5lN3pTNnlBSzlISVNqOGRWUW1JWWQrN0lkZWJmdHA5?=
 =?utf-8?B?MEVaNlJvY3hGR0gzWXRDcS9JeUtQTGFKUncwa2MrRi9DVGt3N0pXL0V2aXFR?=
 =?utf-8?B?MDNaazk0dlNjY0lGOUZQWlhKNkdJMk04ZmZHeEQ0M0NnOTIydFpHdGlObWcw?=
 =?utf-8?B?TEh6T29qSXhvZ3YzZWFDSjM2WVdkcXU3YnE2dUVpUEowbWVRVU82T2thQlp5?=
 =?utf-8?B?WWFQSEJkRHRvdlUySlQ0Wnh2U3ZVOUNCTmFMZXlZbm1IUzVpUnc3WVNVZEZO?=
 =?utf-8?B?UlBDYUpOTGpKc0t6ZnYwSnQyTFk0M0pBUFNGdlRQcDg2cEU5Uk4zTC9Ya2tm?=
 =?utf-8?B?S1pFYTBCUUZDUzlleUUxRWd6QThLTk8wN3NhRU9uTHF0TFJTQnhYb3RLK2RT?=
 =?utf-8?B?MWRCeUxrWmFDS1cyZUZqWjl6YzR6YTBSdFUwVmF5SDYrOGhmMUxyakg4NkJr?=
 =?utf-8?B?S2Z2MVFYMjQ5YUZoY244ajZQYmZYNWFNQTkwbmpKUGFKb3V5QzFQbWl0ZHJi?=
 =?utf-8?B?d1N6K29iK1p6WGlsakxQM1BuNGVadm55Q3NnKzRmVTI4RVdwY2FVRXBBQlo0?=
 =?utf-8?B?UmY2WnJuQnhaQ1dVOEsxSThNa2t2OVZsWTZTREE3NmVaWFhCeGtmbldZU1Np?=
 =?utf-8?B?V1Z5VXFQMVFDK3lDOU1DZGFnZ20rR3pURFUydjB1RVVKbUlWM3hwNlJGeUF6?=
 =?utf-8?B?YWcvaXNjaFh6MlVWQXJFYmV0RVVLVzR3a0RhL0xGOTVGdGJIMEZHREhoL1Az?=
 =?utf-8?B?OTJxVko5MUFFSGh6emV2RjlaUWFncWZVZnFZVm1UTEJ4b1JRU0VkTU1zTGs3?=
 =?utf-8?B?U25LeG9PTW81OXo1LzJmanBSbHVNY2JpdzhuQWc3bFhmNHhTZ1pnTmtKOWhQ?=
 =?utf-8?B?d2U5R3FBbTZFYktMWkJuTDFMbjhSS3RJNFl3U3p1aGFPNWg3UlRrVVB6Vmp6?=
 =?utf-8?B?RU5XNk9PV3Y2UG1ZMDMvV3B2S2U1WnpvREg4TFF4WnE4YithQVRFMXJiQnpK?=
 =?utf-8?B?ZXhsbVZid1YvVVoyUXNjSnpkMEIzUWhkdUd0WWEvOWNLQWRQekQxQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f277a3c-d9a2-4e98-fc1e-08de5432ad62
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:36:16.8594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+UZgXuJBKPz+Y3VoSRvEwyb2C9+bJJ/zIaAVo7dyVZfZ4SYqVREdIkgGR7OE1F/NsQ65UFUatTHO8t9sHbrZEEaXI7tpfqFGSOiOgqx9Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6983
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

Hi Frank,

On 1/11/26 10:23 AM, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Show name of configuration node which was not found.
> 
> current state gives no hint if fit image is wrong or the requested name.
> 
> Could not find configuration node
> load of <NULL> failed
> 
> After this patch we see name like this:
> 
> Could not find configuration node '#ov-test'
> load of <NULL> failed
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   boot/image-fit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 2d040e38d97b..92675e98f2eb 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2125,7 +2125,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>   		if (ret < 0 && ret != -EINVAL)
>   			ret = fit_conf_get_node(fit, fit_uname_config);
>   		if (ret < 0) {
> -			puts("Could not find configuration node\n");
> +			printf("Could not find configuration node '%s'\n", fit_uname_config);

It seems like fit_uname_config can be NULL (see outside of the patch 
context). How does printf behave when this is the case? Should we do 
something like

fit_uname_config ?: ''

instead? That does seem like the message could be confusing also as now 
it says "Could not find configuration node ''".

Cheers,
Quentin
