Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593A5C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C17288616;
	Wed, 29 May 2024 18:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="x06fKQ2y";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="x06fKQ2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385E8883F6; Wed, 29 May 2024 16:46:32 +0200 (CEST)
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6468A88602
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:46:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vasileios.amoiridis@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBOB1XVjO7y2ud/FN+dyEZHFCgDcgFSV/wkJD2Ue0Nu350zgNawyOjT7ijspaew8Cf4BWCThw83PdcD6UTM50sZ/DFM6aURyo8nQsKk2c6N+bQnnTE0eQ6/g6vHXbjRLRhuV21ztXlaoaLzoqcsS+w2lj3DZLa/fcPjOW4UoCLVtPK8nn2+g9n8l+yy6cccWNZE/aqnWbaR31Z9d8iDpBK9EeOz4vnncVWTSYL7+zWsAdcxSOJ5LWc3bbsACYgDeOBev1C3k2Hkws8EuM4dRBT2o6KiAYBb480dY5pAKLEl2jPJivn9hmGkJbmNkH8Kd8ulzE0IMNSIm+V2+tfoREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn63SnTR6X7RhNcvHuColDGg1swKbHWvSrCl6wFWW2c=;
 b=RBAiq09AlNgnff5rj6YuhR1W72oXPHvQro/oCmjmluAiVWeBm9d3kkB9tBbnUW0UVEwBRccF+V/ZfCMclaSPeMqePWGue+EgIwJ/hdJsT0oGZuFWp8EauDxWpxN3fFE5Z6Q02pnT6mc/IrxPEsOIxDomZOiJHJ2HYtRDuS+nz7vUgfBZR1x76xLCeW1B8y/hruDi+X6KGLW6tSTi7rFa27/borEk9HEbkvJ5S2SIcaQ/3uWweqM/mzKBTBMUPw739b1r6zK3npBNAFy+ef/clVXMz2lDpY967u8end6AfoZzLj/LY2N9yS6lAcQiOvfvxg1ouK90pXmkpvPhTGOmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 51.103.219.121) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn63SnTR6X7RhNcvHuColDGg1swKbHWvSrCl6wFWW2c=;
 b=x06fKQ2yKTRRaZ7WAsEfmGfpcfnlaDfcvS/r+9AzjeTln2U8UetB4Gm0g+dDLdUSmhKGojpCBw4jdCMk/Z10AN0ITlcUdHoOUrxfRaoACdJpdLaSrO++qwRGtGqbc3sbCXBiQLMAMxnewxpknoy+busa80uu1LtF4/qfwX3V4TA=
Received: from AS9PR06CA0528.eurprd06.prod.outlook.com (2603:10a6:20b:49d::15)
 by GV0P278MB1458.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:69::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 14:46:28 +0000
Received: from AMS0EPF000001B1.eurprd05.prod.outlook.com
 (2603:10a6:20b:49d:cafe::70) by AS9PR06CA0528.outlook.office365.com
 (2603:10a6:20b:49d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 14:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 51.103.219.121)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 51.103.219.121 as permitted sender) receiver=protection.outlook.com;
 client-ip=51.103.219.121; helo=mx1.crn.activeguard.cloud; pr=C
Received: from mx1.crn.activeguard.cloud (51.103.219.121) by
 AMS0EPF000001B1.mail.protection.outlook.com (10.167.16.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Wed, 29 May 2024 14:46:27 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
 by mx1.crn.activeguard.cloud (Postfix) with ESMTP id 6AA59FE0FA;
 Wed, 29 May 2024 16:46:27 +0200 (CEST)
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17012008.outbound.protection.outlook.com
 [40.93.85.8])
 by mx1.crn.activeguard.cloud (Postfix) with ESMTPS id 12B2DFE0EE;
 Wed, 29 May 2024 16:46:26 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=x06fKQ2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn63SnTR6X7RhNcvHuColDGg1swKbHWvSrCl6wFWW2c=;
 b=x06fKQ2yKTRRaZ7WAsEfmGfpcfnlaDfcvS/r+9AzjeTln2U8UetB4Gm0g+dDLdUSmhKGojpCBw4jdCMk/Z10AN0ITlcUdHoOUrxfRaoACdJpdLaSrO++qwRGtGqbc3sbCXBiQLMAMxnewxpknoy+busa80uu1LtF4/qfwX3V4TA=
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) by
 ZR1P278MB1628.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a6::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.25; Wed, 29 May 2024 14:46:24 +0000
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67]) by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67%3]) with mapi id 15.20.7633.018; Wed, 29 May 2024
 14:46:24 +0000
From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
To: "michal.simek@amd.com" <michal.simek@amd.com>, "vassilisamir@gmail.com"
 <vassilisamir@gmail.com>, "trini@kosnulko.com" <trini@kosnulko.com>
CC: "LPolak@arri.de" <LPolak@arri.de>, "venkatesh.abbarapu@amd.com"
 <venkatesh.abbarapu@amd.com>, "santoshsagar.algapally@amd.com"
 <santoshsagar.algapally@amd.com>, "ashok.reddy.soma@amd.com"
 <ashok.reddy.soma@amd.com>, "sr@denx.de" <sr@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] xilinx: Add option to load environment from outside of
 boot media
Thread-Topic: [PATCH] xilinx: Add option to load environment from outside of
 boot media
Thread-Index: AQHarHAoArfvtZn95EW7zII1J7AbWrGqt9CAgAOdQoA=
Date: Wed, 29 May 2024 14:46:24 +0000
Message-ID: <769bbae66bdcc97fed4f7970285e2bb809f64fc0.camel@cern.ch>
References: <20240522174738.73522-1-vassilisamir@gmail.com>
 <bf2c5b91-a76b-420b-9653-0cc9ae47a9c4@amd.com>
In-Reply-To: <bf2c5b91-a76b-420b-9653-0cc9ae47a9c4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic: ZR2P278MB1164:EE_|ZR1P278MB1628:EE_|AMS0EPF000001B1:EE_|GV0P278MB1458:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ee2501-fdba-4496-acb5-08dc7fee1ef0
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VlE4anBaYkpHdU1HRWd4RUU0Wm9sSm5ZQ0t6MmlJYTA3a0orWGFtVDloOWZF?=
 =?utf-8?B?RkM4S2tSYkZiRksxZTFoeGZIYzZlNHBndEtBeFhHRnhGeWlLclFXMnd5UkM4?=
 =?utf-8?B?QjVsbXcxNTJrcmNIMjRRVzlQdTRDV2Z0VVd3TFA5ZTMvTzYwWWJ2VDQ4aDRV?=
 =?utf-8?B?RlZDQWFmQ2N2bytwamhVYnlaK09FL0F6K2ZZcUZuZ3B0MmY1Z2xDa3hHdU53?=
 =?utf-8?B?L3NjU1l5MVRYWUZxbHJoczFXSldUVEtDcGMxL2haM3VSM29zUkFBMUpLSXpS?=
 =?utf-8?B?Mk9UU0EvTFZPWGxXeVI4L0xxUUtOejNMbDlIK0FFSWFZNXNZSlpOczFVM3RX?=
 =?utf-8?B?NVF1QUQxMXBZVHRiTzBHUkdGSjZCMmtHTnZwM1Vwamw2T0x4QnZOZFpMdDRr?=
 =?utf-8?B?VWxEQkI5bWIwbzlNTVQ2STM4azVjSWFJdkRjbWFUVkZ0cng2cUZTL1dNRi9K?=
 =?utf-8?B?ODN2dEVkcEZ1eENHTjFoVVhsTmVEVkxhVERMRDd6WklDMGNnVW1QZjFEWjNp?=
 =?utf-8?B?THJKMWNEdllRdXR5akJZTjN1dW5FR0FaS1dsUnJPSlpIWWNXTjdBdmg5b3ZY?=
 =?utf-8?B?b042Mk5qMGo3TnRLTW9hZ3c3UHc3S0NGTDFaellHaFdEd0MrZlFkWEsyY2Zv?=
 =?utf-8?B?K0Z3R2FZTDNHSnJCVHp1V0w5S2gyLzk2RHErSHJiSGp0ZS9KMzVHRlVEczRz?=
 =?utf-8?B?VnYzR3VsNkhOT3o0YStRR1pRR0VGYTArQUpMbjVkL0E1Z0Y3amVuTzAwazVX?=
 =?utf-8?B?QmdQekUxaHhZZ1dhQ1FydWVWZExsWVd2SmtuZWJaeEw5OFpzZXJkeUQyMVRm?=
 =?utf-8?B?K0FWTkZ6UmR0RTFpcHM1cGFySC8yVXAxY25IaWMrY1BBeEpnNkQ3UmpJSGNF?=
 =?utf-8?B?cmQ3cm9VVVl2Q0N6RFRoM243R2pQcHVEMjRvaDYrbEIzNEZEbU5Mb1IyZldo?=
 =?utf-8?B?cW9yRVE2b0p4MEFuTW41SVlzZmducjV0Y1Jab3owZkN5TUo3TjNpSXdKQmZB?=
 =?utf-8?B?REVpQ2VDY1F2SkpjYTYxd05ubVlpSmt5T21jQ3ZJcWZySkxEbEdmcFVLRjdl?=
 =?utf-8?B?RDE5WGlFNVlZV1hNSk5ZdWVWeWczU1Q3ZHljaGQyR0tXL1BNR1lNL05LOW5i?=
 =?utf-8?B?R1VvL0tkUlN2aXNSZ3gxTlB1YjFoN2hHSHJGN0xiRjBnWlNtOVQ0dWh1RDhM?=
 =?utf-8?B?RkpTelo2ZTdUMDY2cDNiT2h0eVpwT25WL3k5bkJpdE9PQWtrL0ZPN2ozSU4z?=
 =?utf-8?B?REY0UWRua3VqTmRyRklSWWtPTExZMTVwZVZhb2VGNTRFRmNsOTBkY1BLbWZT?=
 =?utf-8?B?MjFETnJ0QVNDQVdmVWZzSEFCTTcxV3FkcTRucjc4aFBHUHcwWVRjclk1dWZW?=
 =?utf-8?B?K0JwUWhQTDlZbGxSeUNmQTd6dlY1a0V1VlZ3anI3b09YZVNOMEdEM3VMb1g1?=
 =?utf-8?B?WVRTeDRGZDF6OG5oanczQ1ltbjJranVEYVZPT25NMVZsc2Fnei84UHh1c1o4?=
 =?utf-8?B?NmlLcnRNNWl2YnlCdXN3TUlnTTFERTJJaWJNYTNLYUl0VDNsd3ZFYU5mdll0?=
 =?utf-8?B?UXZ5SVFXVDFQNmNucmZXTjZFZnFmWnE5eFdGb3AwUmgwZ0w2UDB2YmdWTWs2?=
 =?utf-8?B?cG9acCthc2U1aGVJaGE0L1FmRTMwSUV6OW9uNU1Rb2VMbVZrUkR5STRUQ1cz?=
 =?utf-8?B?aE8rWVhmUHdtTDB1VkJFTkJFVTEyQnZLM1JWdWdScTNnMUdZVEN2cFpVRE9l?=
 =?utf-8?B?ZjU3am5aUFNuS3lHMDEvMUFCNHdrdTJ1RktoRThRSUlqWEhSL2NBUEU2WHdH?=
 =?utf-8?B?VnB5S0RRRHFDVk5mVHpQdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <148878CE765AD04CBDD22E8ED9F8FB84@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1628
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 58ced3dd-72b5-4a9e-f419-08dc7fee1cbc
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|35042699013|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MTljUzlLWlBOZEJiNVBPK2tTZ3gzNENOYWxtcC90VTJabXdkdEZlbGVhdytq?=
 =?utf-8?B?RVdhRUhNS29VN1VJajdhQjBQd3pOZlNQSE13R0ZOOG5yZ3h6K2lBMjQ0MTd4?=
 =?utf-8?B?M2xaY2dlK1hkTUNOczVGM3M0dE50ck1KVEcvRTJwdFl5eHkxK2hqVHFjMCtN?=
 =?utf-8?B?dHBoQzFFbm1SNDNsOUlJMEdOS2o3bFY5d096L3dkOFR1MHViZTBLeXFGRFRF?=
 =?utf-8?B?TWU2WkE1bnlOcW8wU3huRlRaSmN6ZFlHekVNZTI1L2kwN2d6SlZQVzdkMFpQ?=
 =?utf-8?B?VitkcUhENjIzdFk0WG1VaU1wdlhJODc1MFozZ1daaU5WTHZ2WkFPcW5wVEt6?=
 =?utf-8?B?QjZydTZyVXpXMWxrdEtJYWVhYWp4eU9GanBqTXZQQ1ZPUFFtTFhQUk1NaEhD?=
 =?utf-8?B?OWdONEZweGZvRmFobVd5a2YxeXFLR2JwdXJVbDdjdTB6U09nd044ZUlpcEZk?=
 =?utf-8?B?Vk51ZiticTFoS0xKMmhKZU04cVlZTElub3hiWm02MXlPNVVlR1lUczZuSzdu?=
 =?utf-8?B?UHNJYU5wQ2ljcjBKQ0RYM1VvUHBqK1NRb2RENDhYVURzdERsTDFyRDZRdDlF?=
 =?utf-8?B?SllUZFpYa0c3Q2Mrc0MxbW14cWFQNThZMzdZK3ozb2tGT2dQVzc5R29Mblc5?=
 =?utf-8?B?eVdMYUJKc0RqUHM4UU4weEdpUGlHUUYvV092bFpOVHk0YUlLR09YdW9jSzVC?=
 =?utf-8?B?REhHSVlLcWltQzkrRG1HclltRTl1ZHVxWWxLUU9ROW0vNXN2WDAzSkdGTC83?=
 =?utf-8?B?T0pNbXZ5VHI4UzFXbUdWcHZ4eWlwWTNZWG8vMmZLSmpTa28zc0JydkQyS2tN?=
 =?utf-8?B?SmFqQUlEWU1HakRHSE8rZFcwTHM3QnhGRUZKMDB1bmtoUnkydXUzMWRRMzhx?=
 =?utf-8?B?TS9vRFBGM0lsTkgveFdFR1FOZnZSN1QrZE1vYUdyWnI2dnZQOUMzUlAxYTdt?=
 =?utf-8?B?elFqN2FVRFoycURLbU5pbm84VExwTWZEWVB4amhSc0RHdExKK3RzVTRSQnpF?=
 =?utf-8?B?ZTB6cDlGMnpITFROQXhjeVZ5OTNERHRkMFZJL1Z5TWE1WEd4N0VqemNpVml0?=
 =?utf-8?B?aDVaazQ1VTJOdmVKLzhHUU1hWlpIbE1vRC91bDJEcEZtc05obWRhdThBTE04?=
 =?utf-8?B?aTdJZlU0cW9DallRU0VjQytOVUgvdHNsTkdxeWllaENvQTZvS3V2ODdudGJI?=
 =?utf-8?B?Yk5DS0lkQ1ozWlNYUkp1eGFsbGdZMEl0bmJCM1czMEhjRXZibGg3dnpCM3cz?=
 =?utf-8?B?RkFrZzFpR3dNQ2tJVnpvQmxCeEdHY25LNWZHQkRxTEJwZng4OXJqUVljenN3?=
 =?utf-8?B?WENPeVM4d29XbWxPTkFVZVQ3NE1weHg5MHR6VEg0a0dpK3pPdnVqb1JwUmNN?=
 =?utf-8?B?aW5QVGF4YVlBcWFldDZJREFsaTJjR09jbm1HUW8yaU1GM2QvWThSU2R1RXQ3?=
 =?utf-8?B?QkNaWG1HeWxkQk42ekFJVGxEOXVQdm5qYnR2NzNxeTc4alJHUEg5MVlGQUhj?=
 =?utf-8?B?NUVXZDRlUzVDamhFamphNVZhNHEwd3pqekNYWDVKdy92M09hRzhJZnlQUlVk?=
 =?utf-8?B?RFVjb2RURVZwOW1STEJaMUFLS3d1WVhrMk5lcTg3R1NDQnV3SVpVbjhHYkov?=
 =?utf-8?B?RTJzNCs5b3d6dmg5cnZMQ3ptNjhIS255aW5sSU9YNlQ2UDVFRmsrdDJtOTRB?=
 =?utf-8?B?QllIQnZUekw0ZFBwV29YSUVaYkxuWEc4Y0pzQmhERHVYTzhSRTFBNHJaNkdr?=
 =?utf-8?B?UTljOE9xRHhLNlAzeURyWGVhS3A1TkFWYnpnR1RHZUZTM3BCdTF1ZWxobWtS?=
 =?utf-8?B?OVBEZEpKeDNsQ1lMZXNjZE1xcmNYZkFBK0ttR0d6MUs0Rk5BemVJaVVDRk0r?=
 =?utf-8?Q?BEIc+kLDxuf5C?=
X-Forefront-Antispam-Report: CIP:51.103.219.121; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx1.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230031)(1800799015)(35042699013)(82310400017)(376005)(36860700004);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:46:27.7176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ee2501-fdba-4496-acb5-08dc7fee1ef0
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[51.103.219.121];
 Helo=[mx1.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1458
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

T24gTW9uLCAyMDI0LTA1LTI3IGF0IDA5OjM0ICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6Cj4g
Cj4gCj4gT24gNS8yMi8yNCAxOTo0NywgVmFzaWxlaW9zIEFtb2lyaWRpcyB3cm90ZToKPiA+IEZy
b206IFZhc2lsZWlvcyBBbW9pcmlkaXMgPHZhc2lsZWlvcy5hbW9pcmlkaXNAY2Vybi5jaD4KPiA+
IAo+ID4gQ3VycmVudGx5LCBpZiB0aGUgZW52aXJvbm1lbnQgaXMgbm90IGluIHRoZSBjdXJyZW50
IGJvb3QgbWVkaWEsIHRoZQo+ID4gZW52X2dldF9sb2NhdGlvbigpIGlzIHJldHVybmluZyBFTlZM
X1VOS05PV04gb3IgRU5WTF9OT1dIRVJFIHdoaWNoCj4gPiBpcyBub3QgdHJ1ZSAoaS5lIGJvb3Rp
bmcgZnJvbSBGTEFTSCB3aXRoIGVudmlyb25tZW50IGluIGVNTUMpLiBUaGlzCj4gPiBjb21taXQg
YWRkcyBhbiBleHRyYSBjaGVjayB0byBmaW5kIHRoZSBlbnZpcm9ubWVudCBpbiB0aGUgb3RoZXIK
PiA+IHN1cHBvcnRlZCBib290IG1lZGlhLCBrZWVwaW5nIHRoZSBzYW1lIHByaW9yaXR5IGFzIG9m
IG5vdy4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogVmFzaWxlaW9zIEFtb2lyaWRpcyA8dmFzaWxl
aW9zLmFtb2lyaWRpc0BjZXJuLmNoPgo+ID4gLS0tCj4gPiDCoCBib2FyZC94aWxpbngvdmVyc2Fs
LW5ldC9ib2FyZC5jIHwgMjEgKysrKysrKysrKysrKysrKysrKy0tCj4gPiDCoCBib2FyZC94aWxp
bngvdmVyc2FsL2JvYXJkLmPCoMKgwqDCoCB8IDIzICsrKysrKysrKysrKysrKysrKysrLS0tCj4g
PiDCoCBib2FyZC94aWxpbngvenlucS9ib2FyZC5jwqDCoMKgwqDCoMKgIHwgMzEgKysrKysrKysr
KysrKysrKysrKysrKysrKysrLQo+ID4gLS0tCj4gPiDCoCBib2FyZC94aWxpbngvenlucW1wL3p5
bnFtcC5jwqDCoMKgIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ID4gLS0tCj4g
PiDCoCA0IGZpbGVzIGNoYW5nZWQsIDkzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+
ID4gCj4gPiBkaWZmIC0tZ2l0IGEvYm9hcmQveGlsaW54L3ZlcnNhbC1uZXQvYm9hcmQuYyBiL2Jv
YXJkL3hpbGlueC92ZXJzYWwtCj4gPiBuZXQvYm9hcmQuYwo+ID4gaW5kZXggZGEwMzAyNGUxNi4u
NTY0OGQ2Njg1ZSAxMDA2NDQKPiA+IC0tLSBhL2JvYXJkL3hpbGlueC92ZXJzYWwtbmV0L2JvYXJk
LmMKPiA+ICsrKyBiL2JvYXJkL3hpbGlueC92ZXJzYWwtbmV0L2JvYXJkLmMKPiA+IEBAIC0zNzIs
NiArMzcyLDIxIEBAIHZvaWQgcmVzZXRfY3B1KHZvaWQpCj4gPiDCoCB7Cj4gPiDCoCB9Cj4gPiDC
oCAKPiA+ICtzdGF0aWMgZW51bSBlbnZfbG9jYXRpb24gZW52X2xvY2F0aW9uc1tdID0gewo+ID4g
KyNpZmRlZiBDT05GSUdfRU5WX0lTX0lOX0ZBVAo+ID4gK8KgwqDCoMKgwqDCoMKgRU5WTF9GQVQs
Cj4gPiArI2VuZGlmCj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNfSU5fRVhUNAo+ID4gK8KgwqDC
oMKgwqDCoMKgRU5WTF9FWFQ0LAo+ID4gKyNlbmRpZgo+ID4gKyNpZmRlZiBDT05GSUdfRU5WX0lT
X0lOX1NQSV9GTEFTSAo+ID4gK8KgwqDCoMKgwqDCoMKgRU5WTF9TUElfRkxBU0gsCj4gPiArI2Vu
ZGlmCj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNfTk9XSEVSRQo+ID4gK8KgwqDCoMKgwqDCoMKg
RU5WTF9OT1dIRVJFLAo+ID4gKyNlbmRpZgo+ID4gK307Cj4gPiArCj4gPiDCoCAjaWYgZGVmaW5l
ZChDT05GSUdfRU5WX0lTX05PV0hFUkUpCj4gPiDCoCBlbnVtIGVudl9sb2NhdGlvbiBlbnZfZ2V0
X2xvY2F0aW9uKGVudW0gZW52X29wZXJhdGlvbiBvcCwgaW50Cj4gPiBwcmlvKQo+ID4gwqAgewo+
ID4gQEAgLTM4OSwxNyArNDA0LDE5IEBAIGVudW0gZW52X2xvY2F0aW9uIGVudl9nZXRfbG9jYXRp
b24oZW51bQo+ID4gZW52X29wZXJhdGlvbiBvcCwgaW50IHByaW8pCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9GQVQ7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FTkFCTEVEKENPTkZJR19FTlZf
SVNfSU5fRVhUNCkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZXR1cm4gRU5WTF9FWFQ0Owo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBFTlZMX05PV0hFUkU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgYnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBPU1BJX01PREU6Cj4gPiDCoMKgwqDC
oMKgwqDCoMKgY2FzZSBRU1BJX01PREVfMjRCSVQ6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBR
U1BJX01PREVfMzJCSVQ6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJ
U19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fU1BJX0ZMQVNIKSkKPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX1NQSV9GTEFTSDsK
PiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9OT1dIRVJFOwo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKg
wqDCoGNhc2UgSlRBR19NT0RFOgo+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgU0VMRUNUTUFQX01P
REU6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVsdDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmV0dXJuIEVOVkxfTk9XSEVSRTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4g
PiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gZW52X2xvY2F0aW9uc1twcmlvXTsKPiA+IMKg
IH0KPiA+IMKgICNlbmRpZgo+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL3hpbGlueC92ZXJzYWwvYm9h
cmQuYwo+ID4gYi9ib2FyZC94aWxpbngvdmVyc2FsL2JvYXJkLmMKPiA+IGluZGV4IDRmNmQ1NjEx
OWQuLjhhZWQyZTk3ZGYgMTAwNjQ0Cj4gPiAtLS0gYS9ib2FyZC94aWxpbngvdmVyc2FsL2JvYXJk
LmMKPiA+ICsrKyBiL2JvYXJkL3hpbGlueC92ZXJzYWwvYm9hcmQuYwo+ID4gQEAgLTI5MSwxMiAr
MjkxLDI3IEBAIHZvaWQgcmVzZXRfY3B1KHZvaWQpCj4gPiDCoCB7Cj4gPiDCoCB9Cj4gPiDCoCAK
PiA+ICtzdGF0aWMgZW51bSBlbnZfbG9jYXRpb24gZW52X2xvY2F0aW9uc1tdID0gewo+ID4gKyNp
ZmRlZiBDT05GSUdfRU5WX0lTX0lOX0ZBVAo+ID4gK8KgwqDCoMKgwqDCoMKgRU5WTF9GQVQsCj4g
PiArI2VuZGlmCj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNfSU5fRVhUNAo+ID4gK8KgwqDCoMKg
wqDCoMKgRU5WTF9FWFQ0LAo+ID4gKyNlbmRpZgo+ID4gKyNpZmRlZiBDT05GSUdfRU5WX0lTX0lO
X1NQSV9GTEFTSAo+ID4gK8KgwqDCoMKgwqDCoMKgRU5WTF9TUElfRkxBU0gsCj4gPiArI2VuZGlm
Cj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNfTk9XSEVSRQo+ID4gK8KgwqDCoMKgwqDCoMKgRU5W
TF9OT1dIRVJFLAo+ID4gKyNlbmRpZgo+ID4gK307Cj4gPiArCj4gPiDCoCAjaWYgZGVmaW5lZChD
T05GSUdfRU5WX0lTX05PV0hFUkUpCj4gPiDCoCBlbnVtIGVudl9sb2NhdGlvbiBlbnZfZ2V0X2xv
Y2F0aW9uKGVudW0gZW52X29wZXJhdGlvbiBvcCwgaW50Cj4gPiBwcmlvKQo+ID4gwqAgewo+ID4g
wqDCoMKgwqDCoMKgwqDCoHUzMiBib290bW9kZSA9IHZlcnNhbF9nZXRfYm9vdG1vZGUoKTsKPiA+
IMKgIAo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHByaW8pCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
cHJpbyA+PSBBUlJBWV9TSVpFKGVudl9sb2NhdGlvbnMpKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9VTktOT1dOOwo+ID4gwqAgCj4gPiDCoMKgwqDCoMKg
wqDCoMKgc3dpdGNoIChib290bW9kZSkgewo+ID4gQEAgLTMwOCwxNyArMzIzLDE5IEBAIGVudW0g
ZW52X2xvY2F0aW9uIGVudl9nZXRfbG9jYXRpb24oZW51bQo+ID4gZW52X29wZXJhdGlvbiBvcCwg
aW50IHByaW8pCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gRU5WTF9GQVQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fRVhUNCkpCj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9FWFQ0Owo+ID4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX05PV0hFUkU7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
Y2FzZSBPU1BJX01PREU6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBRU1BJX01PREVfMjRCSVQ6
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBRU1BJX01PREVfMzJCSVQ6Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fU1BJ
X0ZMQVNIKSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiBFTlZMX1NQSV9GTEFTSDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gRU5WTF9OT1dIRVJFOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgSlRBR19NT0RFOgo+ID4gwqDCoMKg
wqDCoMKgwqDCoGNhc2UgU0VMRUNUTUFQX01PREU6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVs
dDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVOVkxfTk9XSEVS
RTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4g
ZW52X2xvY2F0aW9uc1twcmlvXTsKPiA+IMKgIH0KPiA+IMKgICNlbmRpZgo+ID4gZGlmZiAtLWdp
dCBhL2JvYXJkL3hpbGlueC96eW5xL2JvYXJkLmMgYi9ib2FyZC94aWxpbngvenlucS9ib2FyZC5j
Cj4gPiBpbmRleCA2YzM2NTkxMDAxLi42ZmE1MDE2Y2RkIDEwMDY0NAo+ID4gLS0tIGEvYm9hcmQv
eGlsaW54L3p5bnEvYm9hcmQuYwo+ID4gKysrIGIvYm9hcmQveGlsaW54L3p5bnEvYm9hcmQuYwo+
ID4gQEAgLTEzNCwxMSArMTM0LDMyIEBAIGludCBkcmFtX2luaXQodm9pZCkKPiA+IMKgIH0KPiA+
IMKgICNlbmRpZgo+ID4gwqAgCj4gPiArc3RhdGljIGVudW0gZW52X2xvY2F0aW9uIGVudl9sb2Nh
dGlvbnNbXSA9IHsKPiA+ICsjaWZkZWYgQ09ORklHX0VOVl9JU19JTl9GQVQKPiA+ICvCoMKgwqDC
oMKgwqDCoEVOVkxfRkFULAo+ID4gKyNlbmRpZgo+ID4gKyNpZmRlZiBDT05GSUdfRU5WX0lTX0lO
X0VYVDQKPiA+ICvCoMKgwqDCoMKgwqDCoEVOVkxfRVhUNCwKPiA+ICsjZW5kaWYKPiA+ICsjaWZk
ZWYgQ09ORklHX0VOVl9JU19JTl9OQU5ECj4gPiArwqDCoMKgwqDCoMKgwqBFTlZMX05BTkQsCj4g
PiArI2VuZGlmCj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNfSU5fVUJJCj4gPiArwqDCoMKgwqDC
oMKgwqBFTlZMX1VCSSwKPiA+ICsjZW5kaWYKPiA+ICsjaWZkZWYgQ09ORklHX0VOVl9JU19JTl9T
UElfRkxBU0gKPiA+ICvCoMKgwqDCoMKgwqDCoEVOVkxfU1BJX0ZMQVNILAo+ID4gKyNlbmRpZgo+
ID4gKyNpZmRlZiBDT05GSUdfRU5WX0lTX05PV0hFUkUKPiA+ICvCoMKgwqDCoMKgwqDCoEVOVkxf
Tk9XSEVSRSwKPiA+ICsjZW5kaWYKPiA+ICt9Owo+ID4gKwo+ID4gwqAgZW51bSBlbnZfbG9jYXRp
b24gZW52X2dldF9sb2NhdGlvbihlbnVtIGVudl9vcGVyYXRpb24gb3AsIGludAo+ID4gcHJpbykK
PiA+IMKgIHsKPiA+IMKgwqDCoMKgwqDCoMKgwqB1MzIgYm9vdG1vZGUgPSB6eW5xX3NsY3JfZ2V0
X2Jvb3RfbW9kZSgpICYgWllOUV9CTV9NQVNLOwo+ID4gwqAgCj4gPiAtwqDCoMKgwqDCoMKgwqBp
ZiAocHJpbykKPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChwcmlvID49IEFSUkFZX1NJWkUoZW52X2xv
Y2F0aW9ucykpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZM
X1VOS05PV047Cj4gPiDCoCAKPiA+IMKgwqDCoMKgwqDCoMKgwqBzd2l0Y2ggKGJvb3Rtb2RlKSB7
Cj4gPiBAQCAtMTQ3LDIyICsxNjgsMjQgQEAgZW51bSBlbnZfbG9jYXRpb24gZW52X2dldF9sb2Nh
dGlvbihlbnVtCj4gPiBlbnZfb3BlcmF0aW9uIG9wLCBpbnQgcHJpbykKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX0ZBVDsKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VOQUJMRUQoQ09ORklHX0VO
Vl9JU19JTl9FWFQ0KSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHJldHVybiBFTlZMX0VYVDQ7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmV0dXJuIEVOVkxfTk9XSEVSRTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBicmVhazsKPiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIFpZTlFfQk1fTkFORDoKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9J
U19JTl9OQU5EKSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBFTlZMX05BTkQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fVUJJKSkKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX1VCSTsKPiA+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9OT1dIRVJFOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oGNhc2UgWllOUV9CTV9OT1I6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2FzZSBaWU5RX0JNX1FTUEk6
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJU19FTkFCTEVEKENPTkZJ
R19FTlZfSVNfSU5fU1BJX0ZMQVNIKSkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX1NQSV9GTEFTSDsKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9OT1dIRVJFOwo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGJyZWFrOwo+ID4gwqDCoMKgwqDCoMKgwqDCoGNhc2UgWllOUV9C
TV9KVEFHOgo+ID4gwqDCoMKgwqDCoMKgwqDCoGRlZmF1bHQ6Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX05PV0hFUkU7Cj4gPiDCoMKgwqDCoMKgwqDCoMKg
fQo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGVudl9sb2NhdGlvbnNbcHJpb107Cj4g
PiDCoCB9Cj4gPiDCoCAKPiA+IMKgICNpZiBkZWZpbmVkKENPTkZJR19TRVRfREZVX0FMVF9JTkZP
KQo+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMKPiA+IGIvYm9h
cmQveGlsaW54L3p5bnFtcC96eW5xbXAuYwo+ID4gaW5kZXggZjM3MGZiNzM0Ny4uN2U2NDZkMzQy
YiAxMDA2NDQKPiA+IC0tLSBhL2JvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMKPiA+ICsrKyBi
L2JvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMKPiA+IEBAIC01ODgsMTIgKzU4OCwzMyBAQCBp
bnQgbW1jX2dldF9lbnZfZGV2KHZvaWQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIGJvb3Rz
ZXE7Cj4gPiDCoCB9Cj4gPiDCoCAKPiA+ICtzdGF0aWMgZW51bSBlbnZfbG9jYXRpb24gZW52X2xv
Y2F0aW9uc1tdID0gewo+ID4gKyNpZmRlZiBDT05GSUdfRU5WX0lTX0lOX0ZBVAo+ID4gK8KgwqDC
oMKgwqDCoMKgRU5WTF9GQVQsCj4gPiArI2VuZGlmCj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNf
SU5fRVhUNAo+ID4gK8KgwqDCoMKgwqDCoMKgRU5WTF9FWFQ0LAo+ID4gKyNlbmRpZgo+ID4gKyNp
ZmRlZiBDT05GSUdfRU5WX0lTX0lOX05BTkQKPiA+ICvCoMKgwqDCoMKgwqDCoEVOVkxfTkFORCwK
PiA+ICsjZW5kaWYKPiA+ICsjaWZkZWYgQ09ORklHX0VOVl9JU19JTl9VQkkKPiA+ICvCoMKgwqDC
oMKgwqDCoEVOVkxfVUJJLAo+ID4gKyNlbmRpZgo+ID4gKyNpZmRlZiBDT05GSUdfRU5WX0lTX0lO
X1NQSV9GTEFTSAo+ID4gK8KgwqDCoMKgwqDCoMKgRU5WTF9TUElfRkxBU0gsCj4gPiArI2VuZGlm
Cj4gPiArI2lmZGVmIENPTkZJR19FTlZfSVNfTk9XSEVSRQo+ID4gK8KgwqDCoMKgwqDCoMKgRU5W
TF9OT1dIRVJFLAo+ID4gKyNlbmRpZgo+ID4gK307Cj4gPiArCj4gPiDCoCAjaWYgZGVmaW5lZChD
T05GSUdfRU5WX0lTX05PV0hFUkUpCj4gPiDCoCBlbnVtIGVudl9sb2NhdGlvbiBlbnZfZ2V0X2xv
Y2F0aW9uKGVudW0gZW52X29wZXJhdGlvbiBvcCwgaW50Cj4gPiBwcmlvKQo+ID4gwqAgewo+ID4g
wqDCoMKgwqDCoMKgwqDCoHUzMiBib290bW9kZSA9IHp5bnFtcF9nZXRfYm9vdG1vZGUoKTsKPiA+
IMKgIAo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKHByaW8pCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
cHJpbyA+PSBBUlJBWV9TSVpFKGVudl9sb2NhdGlvbnMpKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9VTktOT1dOOwo+ID4gwqAgCj4gCj4gaWYgKCFwcmlv
KSB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN3aXRjaCAuLi4KPiB9Cj4gCj4gcGxlYXNlIGxvb2sgYmVs
b3cuCj4gKE5PVEU6IEFib3ZlIHlvdSBhcmUgbm90IGZpeGluZyBhbGwgaGFuZGxpbmcgYXJvdW5k
IHByaW8gPiAwKQo+IAo+IAoKT2sgSSBzZWUgeW91ciBwb2ludC4KCj4gPiDCoMKgwqDCoMKgwqDC
oMKgc3dpdGNoIChib290bW9kZSkgewo+ID4gQEAgLTYwNSwyMiArNjI2LDI0IEBAIGVudW0gZW52
X2xvY2F0aW9uIGVudl9nZXRfbG9jYXRpb24oZW51bQo+ID4gZW52X29wZXJhdGlvbiBvcCwgaW50
IHByaW8pCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gRU5WTF9GQVQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlm
IChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fRVhUNCkpCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9FWFQ0Owo+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZMX05PV0hFUkU7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgY2Fz
ZSBOQU5EX01PREU6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChJU19F
TkFCTEVEKENPTkZJR19FTlZfSVNfSU5fTkFORCkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gRU5WTF9OQU5EOwo+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoSVNfRU5BQkxFRChDT05GSUdfRU5WX0lTX0lOX1VC
SSkpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBy
ZXR1cm4gRU5WTF9VQkk7Cj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJu
IEVOVkxfTk9XSEVSRTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBicmVhazsK
PiA+IMKgwqDCoMKgwqDCoMKgwqBjYXNlIFFTUElfTU9ERV8yNEJJVDoKPiA+IMKgwqDCoMKgwqDC
oMKgwqBjYXNlIFFTUElfTU9ERV8zMkJJVDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9TUElfRkxBU0gpKQo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVOVkxf
U1BJX0ZMQVNIOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBFTlZM
X05PV0hFUkU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYnJlYWs7Cj4gPiDC
oMKgwqDCoMKgwqDCoMKgY2FzZSBKVEFHX01PREU6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgZGVmYXVs
dDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIEVOVkxfTk9XSEVS
RTsKPiA+IMKgwqDCoMKgwqDCoMKgwqB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4g
ZW52X2xvY2F0aW9uc1twcmlvXTsKPiAKPiBBbmQgaGVyZSBjYWxsCj4gCj4gcmV0dXJuIGFyY2hf
ZW52X2dldF9sb2NhdGlvbihvcCwgcHJpbyk7Cj4gCj4gVGhpcyBjYW4gYXZvaWQgZHVwbGljYXRp
b24gb2YgdGhlc2UgZW52X2xvY2F0aW9uc1tdIGFjcm9zcyBhbGwgb3VyCj4gU09Dcy4KPiBBbmQg
cHJldHR5IG11Y2ggZmFsbGJhY2sgdG8gc3RhbmRhcmQgaW1wbGVtZW50YXRpb24gd2hpY2ggaXMg
SU1ITwo+IGdvb2Qgc29sdXRpb24uCj4gCj4gV2hhdCBkbyB5b3UgdGhpbms/Cj4gCj4gVGhhbmtz
LAo+IE1pY2hhbAoKVGhhdCdzIGEgbXVjaCBjbGVhbmVyIGFwcHJvYWNoLCBJIHdhcyBub3QgYXdh
cmUgb2YgdGhlIAphcmNoX2Vudl9nZXRfbG9jYXRpb24ob3AsIHByaW8pLiBUaGFuayB5b3UgdmVy
eSBtdWNoIGZvciBwb2ludGluZwp0aGlzIG91dCwgSSB3aWxsIHJlc3VibWl0IQoKQ2hlZXJzLApW
YXNpbGlzCg==
