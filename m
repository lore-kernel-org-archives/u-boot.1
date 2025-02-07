Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11244C02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A621809A8;
	Fri,  7 Feb 2025 15:27:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="ZZo8QTY0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D3B80756; Fri,  7 Feb 2025 14:06:50 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C35C807E4
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aMD6LLTTb8MG9rdblS1HX067Z4l6xb3U+uVR+7FUOz3YVwVU0n09vLEoezicLKEc7P0eQPwz0HMG9nzL+Wl/48ukI/RinrmloHL+rz5P1CWkBWUiAvjgWX3UebIw0+2N36SDrCXZ8yZ+VuRcUDKS0kzfDLA7FUwtxEv9MrT+G9Y+uE5utfZh9LECbOhh2S1jrBesRN4bryXHkjrlfNZO7vNVGIybFg7cHniWytiKPZ+qeSMChSK/jGVAb8GAur0F6WKR3y4zRowyKDpIPNAW+povFTCChooWsDg5dcLqwzlri8l7cJO2AjPXKIkcEANSJAIZxDXcC1ZOO905TmdTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8KPzlYgXS9XHx7CVJvkaT8Wnesshd3WHboKdEJ3DUs=;
 b=LASMjvL/ISnHhOzBf0phYAJalSQMIdRJp4Rt9fqeYkRnQmEAiKtaM6MT2aninsa6k6gkfXEBLiqKTW9STrGVraQx3BVnuzqU0LuWqg6lBJeawIX7gsXziCdSWUX4ZYtiT9I+/MlxiMwxQY8Erxujq8OHcQMOdvapM0nO2g6YiaRXmVkFcZTgoMhDX/pyA28P7t7jyElt5wrAY1oZUgMtahv59fRnu4Q7/Dwe//sXCJUxmXs7ZKbCJMZjHf1Rgt6xpmDI9HwIfGqFJo6N50IgfxqFdtz/K+oTw3x+ap9PD4sSg16JVS9sJE5mhwGtVRYSn9HWrjldwqt6Clh8rtGHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8KPzlYgXS9XHx7CVJvkaT8Wnesshd3WHboKdEJ3DUs=;
 b=ZZo8QTY0Mfh0IU+wQptLl1qMo5N1HQB0PbOpVeADMUZyiQt5KFqkg8NI7ZOiLBcmFgLIwAApo/1puKASkERNk8+BvodO2k9UaWHGCVRuxIgVu5UzAVenpf6Mr+lFfBXVflbT2Ku7vdUK/LYZ45gBdyB/ISXxUPdnDgAc0NmcIFX+bA0pPPEwr8YocLRhk606AbAM/8t04u7VnISFa5nDYQdALJ+DREfk2KJuktdVD4K8+4rM2csXF/0bYQ9T1MM23LJM01YX7ianH143rCfNH9HCKiYTu+ERUdEHITxebGU14xJTJhRUBdeadAGbmT8jeELnzgVLz9d2icquuPHh8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:06:47 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:06:47 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/6] =?UTF-8?q?=EF=BB=BFfs:=20fat:=20Support=20basic=20?=
 =?UTF-8?q?file=20rename?=
Date: Fri,  7 Feb 2025 13:45:21 +0100
Message-Id: <20250207124523.85026-5-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207124523.85026-1-Daniel.Venzin@mt.com>
References: <20250207124523.85026-1-Daniel.Venzin@mt.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: cde160a0-f5ad-4926-c90b-08dd47784727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVVITTZsbTRMLzFEN2Z1M3lONmJzeFZKendJbk9wTDBzeVdkKzFFc2grTnNF?=
 =?utf-8?B?dmpyemRLRFRHUkJsV0pUSmJ3WDU4bEd2cjBwY3Y4T2xIVHFqbEtHRGhQc3FP?=
 =?utf-8?B?blhqdjJzcU4yWVgyQ2dWczB5Y3BoeVVMZURxNm9BTDI0YlNQbE5nSTlFd0cy?=
 =?utf-8?B?SnZvbzdHVXQ1RG1mWkx4YXF0UEV1cHBGRGpTVDY0dTBwL3ZBaVViUWxCL0V6?=
 =?utf-8?B?RmZydkVpVmZWdFlrTjZ1TVJ5T1BWMWs3eFo5bU40OUQzdkdEOWVTUjZVcEZH?=
 =?utf-8?B?K094cGlQN2pON3pCM2xFYkh3eS9sbWNyd0JDaGZDV3c2V3FZZEE1U3l3N2da?=
 =?utf-8?B?ZGkwaU11T2ZmTCsxeFcrRmZSbXVta0gveXk4b0ZaUzhJK3hrcWh2SmM4aDVY?=
 =?utf-8?B?eWQ3dlo4RE5aNmJqVXVEUzBid1hVeXIvVy9xNElLd2trVG0yczZUcDVlcHpO?=
 =?utf-8?B?QUp0aExGVmdidVdRVGJsbGdRWXlhcUljeUZSRDE3V3FaQUlRUDdra3gzZmZP?=
 =?utf-8?B?czdzNHM2NmpUb29YdERNa1dZOEpJTzdZQmRNdVRoU2pLajRVQ1F6SnBONG9o?=
 =?utf-8?B?a25lMGwzQTkyU0loZlVsTzFld1B4QVZ4c1haS05IS3dOUUhhMkNJUjh4cGkr?=
 =?utf-8?B?enRqcmt2WTIwRTlKZTBBRWxkSDgrdS9oVGpSWEN3dWJ6T2RmeC9CVEJXN2c1?=
 =?utf-8?B?U3dSakdFa0F2SjhGaXlaNVdha3M4RUpqNUF0RytpQUNLWTVIakZtdHg0NUxy?=
 =?utf-8?B?ZUw1TUx6Nk5ta1FUREsvQ1N4Yk1DRE0xcE1WaVdQaUpPMmRHRU45T3ltSTlX?=
 =?utf-8?B?cnpmSTd3SVMrT1hQU2pFVlVyWUw2cFFaUW1DYzhiZXREMU1Kc3Fadm9LUFpN?=
 =?utf-8?B?bDMrQWtJWkxjYk5EM29QR2psSE1DeDd3UnpoejNqMWZLMVdKOU5GbzBJekxi?=
 =?utf-8?B?aHNSZHMzKzlUZElCVFRVTElPYlovNWpBMHpKL1JnZkVuRzIvcysxU2RmbGQ4?=
 =?utf-8?B?TzN2WktOWFFETmxDeHo0RjltQ29ZcUxxSm56dXlwSWs2cTE1cTM0MGxWcEE5?=
 =?utf-8?B?bk16UUY4MldUSElaVU5ZRjVjTVNqNGFVRGhvWExJbC9wd1dsRmE5a0VRRHFt?=
 =?utf-8?B?NmdsekVLaUV5M0NUU242a3NCSWVDZkZVdTBMd3VlMFFDUGxBVnRRYmxRMU5w?=
 =?utf-8?B?endKbENOclg5L3NaTEJMOFV4Q3BGQStGZSthbUJhQU5xSFRQUUJKR1MrNEhS?=
 =?utf-8?B?MW54Vk00UEdzaXBUQXRIWlkwQ0RzNEVXazBzNStvdGpNOGEzK2cwY1F4cXVB?=
 =?utf-8?B?MUREdnVDOUthSTFSV25NWXpUdkJyS3ZCdkg4VGpiVFZYNEtVRWxPdnQ2ZFZS?=
 =?utf-8?B?UldJeUJNbUZDaWJJdGIrQUg2WmhrUkVjSFh6QlE0bGg3Nm1LS3BSMEI0M1Mr?=
 =?utf-8?B?d043Z0EvU1FYUlBCd1BMTnRmdzRKeEZITlFyNFNCZlhEaEZIbUJ6OWllamwv?=
 =?utf-8?B?ZXU4V3lGVDV3cUM1RGtsRHBoUnlkbUVVTU1sVkNWeVZRYXV6OXdzVGlta29Y?=
 =?utf-8?B?dm5yT0VTMEhXMHhDR253U1JIRGRGRmtzMXNRV0lqZ0MxVW1QdjJ2ZWs1elhC?=
 =?utf-8?B?bkNiZU41WlJ1WjNkZ1NCK2EvbHRnL1hUVVVLVnplaUQ4NHZ1eXJmaS82Wngx?=
 =?utf-8?B?ZkoxVktJNjM2RzViUXc1RUF0TkxKWlU5VVBLMndkSmdvRkY3WHBuajZRY1VU?=
 =?utf-8?B?OFhCTzMwZVFTUkpnYURoaEdtbFVTaGNpb3RNS2EvUGNMVEdDRXNTb004Q1Vl?=
 =?utf-8?B?dTdoVFBtL3RJUEk5VE5rc1V3cWNiQVdYQlBmWHNSTTZRVWc0b3Joc0orY3lW?=
 =?utf-8?B?b05NZGZqUzZMdE1EZFpDRXE2RDZOOHhlRnVPeU1tai8yelRqSVFoTzdTanQy?=
 =?utf-8?Q?ixwEGHal3PJVNkYDX3HM4h9ev2feMvT2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGNKRHA3ekxRQnE1Tzh5ZGFLRlk2bXhnK045ZjhrSTBkbDYxdzhrNkVUVnNC?=
 =?utf-8?B?eHdQR0QwQWhPTVdmY242NmZtU211NDRVTktLZjNHY2V1bG5vS0kxVzJVUDQy?=
 =?utf-8?B?ajFKVWxCZm1lZW1IaXRsNUdveVRBUVZIeVBUaTJlczliY0sxQkZDQllrU3Z3?=
 =?utf-8?B?RFc5RHNSeWYwTVZEREV3QmZIeDE2OENuVXNZdk85RVVIL0MyK0xQNm1ZM3cv?=
 =?utf-8?B?ZkRtRlp0UkwycXJCeG1uNzdOODh4Qnhod1F5OFhxMUV2NjZQSHh2WVRCS3VQ?=
 =?utf-8?B?L1RTbVZNK21Qb3NmVnNtcGtCTDVyNFh2RFIwcDAzcjI1cDN6ZGNxNU4wL2xO?=
 =?utf-8?B?UjBrNTBUd0Rtc0pmSklmSlBHaEtzVGExeldVRHN6dVUybCsxbWpaeWM1M25o?=
 =?utf-8?B?VWhtRmlvdUpPOWJIMlNFaW56RmJrQnU3Z0xOdTBpSVlJelhvTENuR3dOU2Ra?=
 =?utf-8?B?YTN4S1hHUDd6QkdXc3g3bmd6QXA0SFlBVGlaZ29RcUUzQlI0U015d284bVl1?=
 =?utf-8?B?SGQxMXpYQjFEelZWa0V1OVVPb1JybXZyL0R2TC9LZnlNVDQ0R2U0ak1pQjQv?=
 =?utf-8?B?TzdDVnd6ZmEweTVOMFE2ZWpMaC91SzJkd3dOa3NEeEVObDFBcHVvS0xja1Ax?=
 =?utf-8?B?Y3FsdGlDRzV3WE1xM2VWNjVoelI0Kzcwdjk2d3FoZjZuTEdHQjJtS1U3ME1z?=
 =?utf-8?B?UjJ1cTFGV1VLbWRia09ESVZYbkl6Rm1QWnp0bkJtV3l1YjRydHJrbGI4MUxi?=
 =?utf-8?B?alFibkp0NStld2xqdnpHV2c2VVcyektSZldMRXBVdEh5anVkWjZ2OFNoZlRo?=
 =?utf-8?B?bXFZamtkL21LdnBnbnBUYnl1b1ZPTlcwWDJZVFRxMTVpRis5Q2plN29GQ2l3?=
 =?utf-8?B?eDFKbzlFaTVjMDNyOWgwQUd4L1ljWjBvNGN6L1Z2cnBMNXg4anNQNEVBUUp1?=
 =?utf-8?B?NUp1UTNhM0lvWGd2aGQxYkVSQkVNaFlHRHpzRmRsanRkTzdqWmdIWlJvKzBq?=
 =?utf-8?B?Q0dGUmNhVnBUWjBZR0hacStsL2k2Nzl0TjVBdEx0QzdhM0d2V0J3bHBuRlV6?=
 =?utf-8?B?M2tRV21SVXJMUUlMTjdmbndXS1FwUENmMG55dGRNeWc4RjhTSjUwcHcxTmg2?=
 =?utf-8?B?UzMvNk0ySEhYSUdPYXdRZGxrSHRtRW1VYTYxTU1idmlkbm81cys2S1kzY0Fo?=
 =?utf-8?B?YnpDWkdxVHRucy92SXRzTjdDYmF6VUZtaUFEM0NnSUMvUFBzVEZyMHRLb0gy?=
 =?utf-8?B?QjFVdXhJVkhIYWMyei9QclN5UUJuMjVBOHVEd253RFhsd0NmWkF6TEpTSWRk?=
 =?utf-8?B?RVpKL25DcE90L3l6VzhWZHVhK1Z3UE1xK0loR0p6ZVduZUlTUGhSSXJTbEc2?=
 =?utf-8?B?QWYvUEh6clJleC92NUh2NktUSWszWllQVEJJUFFHQklDSXdqRk04SWRYMUc5?=
 =?utf-8?B?eEw2S09rdEpPMFZaYVg2eEZxeGYrVmpwMHplVXBoYzUxcnZ5L2hGWWN1OUNQ?=
 =?utf-8?B?MCtPQjlvNEpWN2NVeG1TbUpIUEpWaGlzK1djcm9yY01XTGhJNU5IN2xDQ0Nu?=
 =?utf-8?B?SlRxN3JaRmpFcEZnL2NVYVpZQUE1Ti9adk82RC9TdGM5aW02VWplN2FBS0Ns?=
 =?utf-8?B?a1RGYytnUDMvdHpZVWZDTFpXNGp6UW96d2xtbGJWWk1kRzZ5NkxXVG05VlNt?=
 =?utf-8?B?dmhKZDczTWtjcHFTaTJ6VE00TjZuSnlvcmZTMlh4MEhGSmI4RXhxZmlwL0Vm?=
 =?utf-8?B?bjcraVlFOVNvSDFBclRoNzJ3Y2MrRHZwMGNUb2FxZFBwTGNmRGwrSGtjWGUr?=
 =?utf-8?B?VS9IMHRGaVlzcWE2dXFBYmpLM1VuaDJIR0tFUjZMRnJuWTdKOTBnNko3UHk3?=
 =?utf-8?B?c3EvNExBU1B4Qys5WGthS0dCMHNpYjNDcVg2eWJIVmZiRUtLeStVWjhEdmQw?=
 =?utf-8?B?QUw4OWh4NlBHcUNaeWNJaitQeVNDMUpNZmZuc0VkZUlLV3Flb2g1dW5ocDly?=
 =?utf-8?B?amNvQ2ZDVWRIcWZLcXVVVGlWRXc3ZjRNV015ZFVlbnRoQXpHVG1OU1hVZWlj?=
 =?utf-8?B?NWR3eWZxaG1VSmtSZzZRZU56dVBLR2NxVno2M2pmUTNEUG9oTzVMdHFSWDBC?=
 =?utf-8?Q?zw3suVsfIty3tDWn6vMTDa32F?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde160a0-f5ad-4926-c90b-08dd47784727
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:47.3130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/46iuOvPVf6MHXYpuG+6GK+stJPmQtJR4yzDVwUiQzlYIquNnZOwJUl4ylvGCIHsmyOeXy92WYXlu80TY67jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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

This implementation currently does not support
moving files between directories.

Signed-off-by: Daniel Venzin <Daniel.Venzin@mt.com>

---

Changes in v3:
- Abort the rename if the destination is a path instead of a file

Changes in v2:
- Separate the rename implementation from changes in the filesystem layer
- Eliminate code duplication with delete_dentry_long(..)
- Ensure that the source file exists, but not the destination file
- Free the fatbuf if it has been reinitialized with fat_itr_root
- Delete orphaned FAT entry after copying file metadata

 fs/fat/fat_write.c | 125 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fs.c            |   2 +-
 include/fat.h      |   1 +
 3 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index c78b80e0b7a..6e4ff7c57d4 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -1821,3 +1821,128 @@ exit:
 	free(dotdent);
 	return ret;
 }
+
+int file_fat_rename(const char *path, const char *new_fname)
+{
+	fsdata datablock = { .fatbuf = NULL, };
+	fat_itr *itr = NULL;
+
+	dir_entry *dentry;
+
+	char new_path[VFAT_MAXLEN_BYTES];
+	char *new_fname_copy = NULL, *new_fname_dirname, *new_fname_basename;
+	char *path_copy = NULL, *path_dirname, *path_basename;
+
+	loff_t actwrite;
+
+	__u16 starthi, start;
+	__u32 size, entry;
+
+	int ret = -1;
+
+	new_fname_copy = strdup(new_fname);
+	if (!new_fname_copy)
+		goto exit;
+
+	split_filename(new_fname_copy, &new_fname_dirname, &new_fname_basename);
+
+	if (strlen(new_fname_dirname) > 1 ||
+		(strcmp(new_fname_dirname, "/") != 0 &&
+		 strcmp(new_fname_dirname, ".") != 0)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	path_copy = strdup(path);
+	if (!path_copy)
+		goto exit;
+
+	split_filename(path_copy, &path_dirname, &path_basename);
+	snprintf(new_path, sizeof(new_path), "%s/%s", path_dirname, new_fname_basename);
+
+	if (!fat_exists(path)) {
+		ret = -ENOENT;
+		goto exit;
+	}
+
+	if (fat_exists(new_path)) {
+		ret = -EEXIST;
+		goto exit;
+	}
+
+	ret = file_fat_write(new_path, &actwrite, 0, 0, &actwrite);
+	if (ret)
+		goto exit;
+
+	itr = malloc_cache_aligned(sizeof(*itr));
+	if (!itr) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = fat_itr_root(itr, &datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(itr, path, TYPE_FILE);
+	if (ret)
+		goto exit;
+
+	dentry = itr->dent;
+
+	starthi = dentry->starthi;
+	start = dentry->start;
+	size = dentry->size;
+
+	free(datablock.fatbuf);
+	datablock.fatbuf = NULL;
+
+	ret = fat_itr_root(itr, &datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(itr, new_path, TYPE_FILE);
+	if (ret)
+		goto exit;
+
+	dentry = itr->dent;
+
+	fsdata *mydata = itr->fsdata;
+
+	entry = START(dentry);
+
+	dentry->starthi = starthi;
+	dentry->start = start;
+	dentry->size = size;
+
+	ret = flush_dir(itr);
+	if (ret)
+		goto exit;
+
+	clear_fatent(mydata, entry);
+	if (flush_dirty_fat_buffer(mydata) < 0) {
+		printf("Error: flush fat buffer\n");
+		ret = -EIO;
+		goto exit;
+	}
+
+	free(datablock.fatbuf);
+	datablock.fatbuf = NULL;
+
+	ret = fat_itr_root(itr, &datablock);
+	if (ret)
+		goto exit;
+
+	ret = fat_itr_resolve(itr, path, TYPE_FILE);
+	if (ret)
+		goto exit;
+
+	ret = delete_dentry_long(itr, FATENT_CLEAR_SKIP);
+
+exit:
+	free(new_fname_copy);
+	free(path_copy);
+	free(datablock.fatbuf);
+	free(itr);
+	return ret;
+}
diff --git a/fs/fs.c b/fs/fs.c
index b746d05ebcd..3576d5c6644 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -208,7 +208,7 @@ static struct fstype_info fstypes[] = {
 		.write = file_fat_write,
 		.unlink = fat_unlink,
 		.mkdir = fat_mkdir,
-		.rename = fs_rename_unsupported,
+		.rename = file_fat_rename,
 #else
 		.write = fs_write_unsupported,
 		.unlink = fs_unlink_unsupported,
diff --git a/include/fat.h b/include/fat.h
index 3dce99a23cf..415ebd7b7c8 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -207,6 +207,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
 void fat_closedir(struct fs_dir_stream *dirs);
 int fat_unlink(const char *filename);
 int fat_mkdir(const char *dirname);
+int file_fat_rename(const char *path, const char *new_filename);
 void fat_close(void);
 void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
 
-- 
2.39.5

