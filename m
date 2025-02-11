Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2587C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 03:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1FB9803CC;
	Tue, 11 Feb 2025 04:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oKRG3Jwd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFE218043C; Tue, 11 Feb 2025 04:43:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F84A800CF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 04:43:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0Z7nTl7hEMZuZgtcT5JGHugfe6xd1IPp4Cw2YgbgPBj6pDeHrEJduKXu7hdM3tknISGusW/+VF/Nb0ht/8ULqYr0yA3n2eFfo37OioZn3NDZo5ITsOGxKS9EmGpBx8K8/gGlmFhoC5oXTGb9CT45U/+Yd4JxlRGXMzHtdkqds6FyRwHGyl6RG92NuRXsAnIJuo17AAMZ5yBZi/B/+sAD9zCN+LE2hfeL2PsfFEheurFMyNALg+iVR+LpqIzLRXSYZuWmckBVpyIfZml/0ezGX3Wx8FDRljY84m7RF9xqnu8t6ZhwBefjs5Deynvkdi7vP9f1tooYzEwKnxS9Z7Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvkECkjyqA8odeOI77trMYSmYXU3sX0bBqyzGEpWnU4=;
 b=HzSQGT61VxZYCH597TvAzB07D2SXejiN0Ea6cOZfuthacyfeJerNLnnkJiBdGBp04D+R/0X9NC3P4agRBL6JDulZ7W08dmyq+c+UO4uemuVofpG0FhcXZt+JEgOFU3lzUsq4kLZeGeZDtZ1IZz9feHmrmU41EQceMQPO19bBc2dHr6bkV5XDmbmMby7ZpWijF9PPN+lJWBMtiIm+tLGxuB2Cf4meLkNJ11ts6bQ8Phce3XA8eggxvlUrmlGioDcKSjnSJCfc3TeZIeKM5nuaOKHdhz6jHiQrhOYgMSNnvSflajXHnu9ZprPTFZqHbcrP22qieL5So9RS5FcCUaJXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvkECkjyqA8odeOI77trMYSmYXU3sX0bBqyzGEpWnU4=;
 b=oKRG3JwdmsCamkQO3uXfn+/ZOMR8nyt1LbKhSXaLg7K8vqK9CoKhR6s9UgUfNxRtCFfpHwOLL9DujZGOR9s8MWBsmZmgDIXAWYA7bplhegebayUHQhccM4fYqAVC9wYlhQGp/U4mkMLR/ls5vv1hAKev0dKsoKKoWSZY7/15nlndVA6NoXmPQCbbgDsVWq4ZRfy3xplNp8FumwOURvYXd/KPdkIjt7+07yBeibvJE7b+BMCcFzyyeH2KCjglqlkQ2l2QKobz+MCSYtNnDNvkwnjyrzvjD3TtpGdX1ZZT8aEIkR3Mq2IBh0ft8/hVUEr1vi39GuxGydZJMpH55MC9Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS8P195MB1824.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:52f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 03:43:19 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 03:43:18 +0000
Message-ID: <2983d702-e05b-416e-bcaa-9eab6e09319b@phytec.de>
Date: Tue, 11 Feb 2025 10:43:11 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] board: phytec: phycore_am64x: Add support for 1 GB
 RAM variant and ECC
To: Dhruva Gole <d-gole@ti.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, trini@konsulko.com,
 n-francis@ti.com, nmorrisson@phytec.com, d.schultz@phytec.de,
 sjg@chromium.org
References: <20250205043013.1404917-1-w.egorov@phytec.de>
 <20250205043013.1404917-2-w.egorov@phytec.de>
 <20250205055502.zduyeiflus7yxojt@lcpd911>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250205055502.zduyeiflus7yxojt@lcpd911>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::26) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS8P195MB1824:EE_
X-MS-Office365-Filtering-Correlation-Id: 70aca28b-b51f-461d-598b-08dd4a4e3953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTdrK3hZd2xjZFFMd2tCbDY1dUgxQVRTL3dhUGM3RzIxbW5GVk1NV3NSaUg0?=
 =?utf-8?B?MnRXd2FGSXJHOWFlK2MrSVg5U1Q1T3ZhZFprWUpvS0hiS2duR1dOUzJNR3Vz?=
 =?utf-8?B?aE9YbUtQMlUyZDgwWDZUcFhQQW1HbEtJZjI0YjJBRlJaK2NoQnF0SFVXd0g1?=
 =?utf-8?B?WS9XQ0FQd1lDZmg3RjFTanY1MkxSVU9EUnR5Qks0Tk9SQjFMbFRWTVlLc09l?=
 =?utf-8?B?OWozdlVFZHVKRk1qNVE2OWF6cHRjUHlvMlhaUm1iQVVtQjFRRXFDM2tXMWNS?=
 =?utf-8?B?cVdmZXRmcnZRbUxhdEpqQ1BWR3gyN1FDTFFndUc5UjJwNTVSczdwcEFtcEpU?=
 =?utf-8?B?T2ViOE9COVJnWlJna2QyeTI4SFNyUm1uQlg4Q2hMY0F6c3FrZXRSVFVsWUQv?=
 =?utf-8?B?eURMQ1ZobkpsclZtMHp5Vlgwa2pzL3E3eVFOMHR1Q2FYdmsyRStFTGZ1N0FD?=
 =?utf-8?B?V1N5YUVObVJxMFZrSlJDQ2tEa0pMdlYzWTlTalhzYzlQL0xiZ3AwT1AwSmVU?=
 =?utf-8?B?ZE1aRVJSNXZiM2N6VjV1VVdweUo2RzdwczE0U3MxN0hrcEVWWTQrcVR6NmVM?=
 =?utf-8?B?RlhaZ09YdjlwKzZoVnREY2VMcjZtSjhEZ0VKT0FyUkhySHBkTGVRazRlUEdu?=
 =?utf-8?B?WU12bVlZMFdKUUZWK01oc1BtaHNJN3htTjNUU0p3MXE0VHNtSmg5dVV3bWVZ?=
 =?utf-8?B?Vzl5cnpwTEtxcHJGejhkRTFEZGFoVnl5b3FoYmJVUVFKQ3NWTFo5aTg2TlpB?=
 =?utf-8?B?enozVDBOT2lJYnVNZ0l0RElzWlhjS0FOWDVieVBpQVlKRFhaRGJKOHJxTGcw?=
 =?utf-8?B?UjVEUk9wUjVZL3MwMnlQMWNQUkJBU3ZNbjRwV3FxZkxRVndveXVQV3MwbGx3?=
 =?utf-8?B?ZzhPL2pMM0N6Um1DM3I2aE9GVGI1Zi93aEF1aXNPWVR5YUNiWktwRVdNTTlu?=
 =?utf-8?B?M0RnU25pOGJOQkZWMmR4R0dzOE5selpXRUZSTGVMS2JnNGgyVCtoWXFuTm8r?=
 =?utf-8?B?TGNIUWZGRGNrS2lDYmJlQUloZnYxbTlLWTdMSk4rSERVK004STNiVEI3MmNl?=
 =?utf-8?B?QjgxcG1haHFZR28yN2gvVjhVY1gxd1FMMEloYzQ5VFlvMThaSzhsN3dqZHds?=
 =?utf-8?B?bVlHMFh0MlF2eW56a0RPblFCdDBGdCtUZXE2WXc2dnlaaTFVYnhHWWwwdmhJ?=
 =?utf-8?B?TzJSeGZGeU1oMlZkbDIyVmk1a2sydGhyNmJ5YzZ6VG1sRW9PSkJTQ1dWQkhH?=
 =?utf-8?B?amE5RVd4WmlXaXdiUlUyVXFDd2pLR2ZuWkJlTzlLcDVwMXYzenJIRnBUTGVO?=
 =?utf-8?B?dStXZ1JOWlI5VDR3ak81bFNFZkJIRmMzdHR3aWcxLzJ6L2RGTW5kWE9xWkxh?=
 =?utf-8?B?aW8yNHIvcHVJZitkb0pFZkpCMk9icTVyRE0waWt5bEZvU0k3c0V1RGZQNzJ2?=
 =?utf-8?B?R3NGVzIxWUtYVFhrOXJCNGNINGZ2MXllMko1UHhPVHFKN1pEY2VXb3N5aXNw?=
 =?utf-8?B?ejh0K25tVFliUjRUWEJsSEtiTjM1ajQyUnlQS3N5ZVUxZFU4cFVDRWFqRkJQ?=
 =?utf-8?B?dXNTazJ6V01GMUxUa0J0R2xmdVUyWm1uVmpTTGVxL2hHcUhEWnI5TFI0U0VS?=
 =?utf-8?B?Z0hzWlhQMlVWM3BxcnNUKzBiU3VvRm9DOE1LaFRyR1J1WFhDYzN3aGF1N0lj?=
 =?utf-8?B?Vlk3aWdRK1c1R0FjeVQrZ0ZTaXNtdFd1YVVBWTRtRi9XeG9VdWEvVDU2Nndi?=
 =?utf-8?B?cnZ1YnBIaldXOGpRL1FYQjZwSjBJTEsvV2xyci9WdWV6ejFuUHdTWW1rQ0tH?=
 =?utf-8?B?bjZxZzd1QUU1cmg1VmQvVlFlQkMzQlBKdmxDdEViUTM2OTZtS2FHZ3lYQ0s5?=
 =?utf-8?Q?+Pd3FmpJFmgqk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE10OG9udVNzR0t2aWlvNTU0YS9JMG9vRWt2T2c0QVVYUmo5Q2g2Rjk0eVho?=
 =?utf-8?B?Z3YrMHBqTmtsb1cvbnBmQ2ZEdWVVdU93cFh6clk0Y29wR1NjVHZ1b2ZhVm9U?=
 =?utf-8?B?cWdpU1ZJd2dJS0lLQXM2U3dvTVpkUG8rSThweVNUSk1nczYrQ2ZPTnRNaHYv?=
 =?utf-8?B?ZVhPa0YvaDVvWUUvRkJPNkRmM3NiYndVK3JZMmRBQXowY0psbXBkTWZRUXVB?=
 =?utf-8?B?Z2FSZ2t4amNXYU0wYjhIVkMwL1U5cXFGdUI2ZnZrY2ExZ3hqZzYzZFJuQUlZ?=
 =?utf-8?B?V3dXNi9qRW5sWFpEa3ZIeXd5M0E1d3BJU3NTSTdXUnRzMkttRUVQdE9ISW5t?=
 =?utf-8?B?Y0RoN3hZQlQwLzZFN3dJZGI0K1pFMkN6OXhLTkk4QUZFUnc0RDIzVGJEM3Bk?=
 =?utf-8?B?aWFuODBxVmordTg4N1pGTm9uSWRuRXVsR1QxRlllNTYydDBTK0szK0M4R2cx?=
 =?utf-8?B?N0x0SWltS2JmV29Bdlh0b0ZLWFp4K2hJN1NxcC9aWDJNTDIyQiticVYwRXlG?=
 =?utf-8?B?OFREMVdSMllDY3BMSGRtVWlUOEZHR3huNjVLRnJTRVZBazNYOXNwWU9jTlFX?=
 =?utf-8?B?bk96cStyU21EYmFwWk11RGpLd1RrVGFvcHdJRWM2ZFJjZC94Y2poYy9XYy9P?=
 =?utf-8?B?T1R2dG1JU3hRT2ZJT09leWwrc2RVZDRMdCtaQnpRd0JqVXFhRWExeEkxRFVW?=
 =?utf-8?B?bE52bWpKUGlIZ3FvTzZpSnhaa2Z3ODBVb0R6Rk9ncHR3QXVxVnk2Sld0Wm5m?=
 =?utf-8?B?ZldFM2VNMTRoakNwV1AvdDQrMW5LK3VuUWxDODRRdmU2UU1JWUtsQW9UTHg3?=
 =?utf-8?B?NjZWMnlXLyttWGlqSk9pbWp6NFFXSGZHSmRZb0hleDEzaExvYzFaYkhtR2Q2?=
 =?utf-8?B?akxoeExkKzJYR1BOVXMrSmdFQXlMRTgyRGFvdHhSU0x2ZXpqQVZERjZTTDNL?=
 =?utf-8?B?RkxmL1NVL3c5OHY1MXJOSE0wWWV4c2oydm5hUXJXUis1dmx2Mzh0bHg3d3pi?=
 =?utf-8?B?OWppUFZBS3NiM2J1NlY4ZDVJTTJ0eGJmcmpuVGNYNTUrOGhUbWlNM1puZTZN?=
 =?utf-8?B?Y1pnTG9Ra2E3ZEN5T0JKK0c4aSswZ09BWmdycGNZQTJXVWcxTitQRnJFZDBQ?=
 =?utf-8?B?bjFTNi8vV0dWNTJuWmIrdmpnUFZ6dS9JWGc0OTgrenByUVNEeThBbnFzUWlt?=
 =?utf-8?B?NTJ2T0VKWFJRK3hpc0FLVUZQNU5MdXFRaWtqeFBzY2o5WWdoNHlWM29QYWRN?=
 =?utf-8?B?ZTJHUko4QWYzR1JQZ2NYRTNoZWIzbCtZd1ZJelJQRUNXR1BlMXJFa0JBLzli?=
 =?utf-8?B?bGY3TnlGd0ovZWFrZnJMOWZOZVBDcHNaYndoWXJmWVE4WXpFaGwrSHAyMks1?=
 =?utf-8?B?NngrN21uTWY0UXY2Nzl0ai9BU3VBbGtmbGZUWEpzWWlPQXlSQlZnWDRHU0hs?=
 =?utf-8?B?WTQwMXhadVozY3UvUlJPT3hFdG9CNVNaUEJqeUw3R0tpaE9MZURBZjRIT0tz?=
 =?utf-8?B?OTdOTzZtV1NvQTE5S2ZmTy9xVW5BMWFZdXUwZTdVV2w3VjJoTkxtR0tXNjdt?=
 =?utf-8?B?Yy92UlF2bEFvMnN4aGFDeXFXZ3pzVk43b090V1hlT2pZTUhTZHdaMGpDWi90?=
 =?utf-8?B?SkJTMlcrL0RlT0diNFhrRWp1a2hadzk2ZEx1VjlUK1RnaGpBcHRxZVQ0Tkg5?=
 =?utf-8?B?a1JFV0g1K1NZTm1RdkZGL0NpOWdsbEVNRXJFaGdCalJyN2dDUlNGcTVYN2dE?=
 =?utf-8?B?YnAwY0VpNk9qV254b1J3NVN1UlhEVjJscG1pcjJIcnM4WTY0RXVLYUNhbGV2?=
 =?utf-8?B?bWc4dmNNOEFvS1M2NC90K3AyMXJtdHg0VTFyUk40MU10ZDkvSTcyS0FTUFo1?=
 =?utf-8?B?cE5jbmhvTEpMSVVEcFZjcnJTRlpMbnZWaGYzKzNZSi94MkZUM0NvOU94dlM3?=
 =?utf-8?B?YzNna1plSXFKYnFoYjZCNllNbEUreFdzbXJXTEJERDRrTE9HY1Q5ZDE4TmdT?=
 =?utf-8?B?bmgxRlZiQ2prcjc5NUkvNDJHUzh3MW9vYUNiV2pxZEhRV0lIRU1Vc1pSSjFE?=
 =?utf-8?B?YklqZzVxM2IzcEVwaUlvNjFMblM3eW5lcStoR0M1citxQTlMMGRpbVhkQUx6?=
 =?utf-8?Q?wVY6Tr7PUDujG14ejMD0HFQ9l?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 70aca28b-b51f-461d-598b-08dd4a4e3953
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 03:43:18.8412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKl97Ssd5anTl3DbsV80DkgtQMnHft5EGI5qq3aq9eeyEsRuhITZQiRpLjPb1P3yrLPgFsrVBpUsNZqSsyAS7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1824
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

Hi Dhruva,

Am 05.02.25 um 12:55 schrieb Dhruva Gole:
> On Feb 05, 2025 at 05:30:12 +0100, Wadim Egorov wrote:
>> Detect RAM size via EEPROM and adjust DDR size and banks accordingly.
>> Include necessary fixups to handle ECC-enabled configurations.
>>
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
>> Tested-by: Daniel Schultz <d.schultz@phytec.de>
>> ---
<snip>
>> @@ -11,9 +11,12 @@
>>   #include <env.h>
>>   #include <env_internal.h>
>>   #include <spl.h>
>> +#include <asm/arch/k3-ddr.h>
> 
> If adding new header might as well put it below asm/arch/hardware.h to
> maintain some level of sort?
> 
>>   #include <fdt_support.h>
>>   #include <asm/arch/hardware.h>
>>   
>> +#include "../common/am6_som_detection.h"
>> +
> 
> I am already seeing 3 different way am6_som_detection.h is being
> included. Please can we consider using <> to abstract these relative
> paths?
> It looks much cleaner that way and easier to maintain IMHO.
> 

I'll keep this in mind for a future cleanup series.


>>   DECLARE_GLOBAL_DATA_PTR;
>>   
>>   int board_init(void)
>> @@ -21,15 +24,113 @@ int board_init(void)
>>   	return 0;
>>   }
>>   
>> +static u8 phytec_get_am64_ddr_size_default(void)
>> +{
>> +	int ret;
>> +	struct phytec_eeprom_data data;
>> +
>> +	if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_FIX)) {
>> +		if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_1GB))
>> +			return EEPROM_RAM_SIZE_1GB;
>> +		else if (IS_ENABLED(CONFIG_PHYCORE_AM64X_RAM_SIZE_2GB))
>> +			return EEPROM_RAM_SIZE_2GB;
>> +	}
>> +
>> +	ret = phytec_eeprom_data_setup(&data, 0, EEPROM_ADDR);
>> +	if (!ret && data.valid)
>> +		return phytec_get_am6_ddr_size(&data);
>> +
>> +	/* Default DDR size is 2GB */
>> +	return EEPROM_RAM_SIZE_2GB;
>> +}
>> +
>>   int dram_init(void)
>>   {
>> -	return fdtdec_setup_mem_size_base();
>> +	u8 ram_size;
>> +
>> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
>> +		return fdtdec_setup_mem_size_base();
>> +
>> +	ram_size = phytec_get_am64_ddr_size_default();
>> +
>> +	switch (ram_size) {
>> +	case EEPROM_RAM_SIZE_1GB:
>> +		gd->ram_size = 0x40000000;
>> +		break;
>> +	case EEPROM_RAM_SIZE_2GB:
>> +		gd->ram_size = 0x80000000;
>> +		break;
>> +	default:
>> +		gd->ram_size = 0x80000000;
>> +	}
>> +
>> +	return 0;
>>   }
>>   
>>   int dram_init_banksize(void)
>>   {
>> -	return fdtdec_setup_memory_banksize();
>> +	u8 ram_size;
>> +
>> +	memset(gd->bd->bi_dram, 0, sizeof(gd->bd->bi_dram[0]) * CONFIG_NR_DRAM_BANKS);
>> +
>> +	if (!IS_ENABLED(CONFIG_CPU_V7R))
>> +		return fdtdec_setup_memory_banksize();
>> +
>> +	ram_size = phytec_get_am64_ddr_size_default();
>> +	switch (ram_size) {
>> +	case EEPROM_RAM_SIZE_1GB:
>> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
>> +		gd->bd->bi_dram[0].size = 0x40000000;
>> +		gd->ram_size = 0x40000000;
>> +		break;
>> +
>> +	case EEPROM_RAM_SIZE_2GB:
>> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
>> +		gd->bd->bi_dram[0].size = 0x80000000;
>> +		gd->ram_size = 0x80000000;
>> +		break;
>> +
>> +	default:
>> +		/* Continue with default 2GB setup */
>> +		gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
>> +		gd->bd->bi_dram[0].size = 0x80000000;
>> +		gd->ram_size = 0x80000000;
>> +		printf("DDR size %d is not supported\n", ram_size);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +#if defined(CONFIG_K3_DDRSS)
>> +int do_board_detect(void)
>> +{
>> +	void *fdt = (void *)gd->fdt_blob;
>> +	int bank;
>> +
>> +	u64 start[CONFIG_NR_DRAM_BANKS];
>> +	u64 size[CONFIG_NR_DRAM_BANKS];
>> +
>> +	dram_init();
>> +	dram_init_banksize();
> 
> No check for any failures from fdtdec_setup_memory_banksize ?

No need to, because dram_init_banksize() always returns success in this 
case. fdtdec_setup_memory_banksize() gets never called for CONFIG_CPU_V7R.

> 
>> +
>> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>> +		start[bank] = gd->bd->bi_dram[bank].start;
>> +		size[bank] = gd->bd->bi_dram[bank].size;
>> +	}
>> +
>> +	return fdt_fixup_memory_banks(fdt, start, size, CONFIG_NR_DRAM_BANKS);
>> +}
>> +#endif
> 
> Nit:
> Try and end #endifs like this:
> #endif /* CONFIG_K3_DDRSS */

Same here, will keep this in mind for a future cleanup series.

Regards,
Wadim

