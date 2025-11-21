Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E0CFC270
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 12:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450CA80433;
	Fri, 21 Nov 2025 13:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mV0vUb0B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 097188051F; Fri, 21 Nov 2025 13:56:50 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB04802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 13:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1VWyHE2vpkVuG49UR4hJrd2IZd9SnUVg+DZLUd4ZOOiAkNETGKRz/GLod0Lih+ucnTmg9Q3b2IxrcdVgyfefyhMRxY42S9M6iOGC7Sh8jV586iIeeSFRD+onIJ4gNGqF2xD+O1AIqMEyVqpkFYd2WvSLnMs9F9zbx4b0rHemsG4Bz6HKOHu2uGfC8hJCcJv7wekj5lxqsI4ohoyO4BKh90s9d+8I46XQwYYOrS2Dh37sgEYU0y9fYe+pu6gDxZXvBl4I5wCPzB+lDQ1nWZSvGJJX75SgaqudR2pV9vzrLC36DauYV0GOnlSS/lJOzqlu5+DMBGx2EgPMmcKlFl9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuizKy/AGcguB8k1zIOnSWp6+a0UwbjdOQ2f2p1Vu28=;
 b=ov3jST4auszVAxoqtcsAFeqW3/N4mk56OZkN7YXRWvpFc2zflasmNWE0wCMkrqBbkCF1cHcKFHhounsWm4rqYYQsYk+uOaFiLrG2Tu/OkwzQWLO+gnnXHvewdWiKI1uzJpn8mh7bImn6/S1I7lwdSy+YikxAQDdZ4LQENw2llyTwKLeijThyo02dn3pksFCBVQYR2vR28m1Aw82l/Z0ov8yUv2B2k016OcLj9Jj2q1AMXqyTRj9iQD6uXzWeCPvytbAiLqLFc5TLwUnSPQgPZqw3o+qgShtkgqVq1FcdrBCjeuV8Mivlb/QXL1e7o42cNCFPVLmMko5+wJXEqnV30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuizKy/AGcguB8k1zIOnSWp6+a0UwbjdOQ2f2p1Vu28=;
 b=mV0vUb0B0wSaserugvKv1KjO9dksRaOInWvaqWTfMw5R1DDjcu21+szxlWefSFWlH+t8+Y7M8UhLhTJvCeUHzfZch/dB/ptHF4jVRUmaecWO9Qk8uT35WJf1ZrWVXvCayMCw4DRwDJwpGryZVLBduCPNM+1pJ2/xHfy/fQ4ErHqGMQRbIAyuYn063OisJ+RaZb6Hqk/TFX7XZLYqWZnS8LL9luSNniq1HdQVbw4zQmDuFOVC2oJO3yrYOKkZGFICFjTrg3jdlkBj57afWZ7rLWypW+wb3MrGG+0QIa0QghFB3l6xE0S4PxAkyVZgNhIxDMKH08Grh209WQeK/irO3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PAXP195MB1512.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:274::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.12; Fri, 21 Nov
 2025 12:56:45 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%2]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 12:56:44 +0000
Message-ID: <8b4ac072-125c-493b-b12a-f0a4e9d56e7e@phytec.de>
Date: Fri, 21 Nov 2025 14:55:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/21] net: ti: am65-cpsw-nuss: Define bind method for
 CPSW driver
To: Chintan Vankar <c-vankar@ti.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Santhosh Kumar K <s-k6@ti.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bhavya Kapoor <b-kapoor@ti.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, Andreas Dannenberg <dannenberg@ti.com>,
 Moteen Shah <m-shah@ti.com>, Beleswar Padhi <b-padhi@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>, Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Kishon Vijay Abraham I <kishon@ti.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250731075956.605474-1-c-vankar@ti.com>
 <20250731075956.605474-2-c-vankar@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250731075956.605474-2-c-vankar@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0249.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::22) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PAXP195MB1512:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f3a7dc-3628-4e3e-91fa-08de28fd6c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVdZand4S29jekNOUUNyOHo5OXhVQ0FMMHBXQVhVQ1hEV0ZrRFBkZ3BsTGp1?=
 =?utf-8?B?VWlGM2ZOemt3Q1FYbmlxKzFteGtnejBnS3VpaHgweE1jUE0zdEYvbzFOK1Fu?=
 =?utf-8?B?dnpUNjNzbzNCVXBzd29DaTkybkhHbzRVZEY5YVJ0Vi9YTVFkWjBrOUE3WE1J?=
 =?utf-8?B?ZU9uS2hYcXFlWHFpUHREQkZFNnB5elMxTm9pdlp4cE81emtoYUU2dmFzNm53?=
 =?utf-8?B?QWZaNTdKK1pIUnliaktYRFBwU0tvSGRERlFvZG04ZVB4Y0VScUsrd0hncXln?=
 =?utf-8?B?a3pHamdXV2N1dmM1Z01uaHRyUUR5cVdjWi90aDA5ZzIyamhzKzBYZVBJckE5?=
 =?utf-8?B?ZHFIdVB5eFhRZUVUa2xZY3c2Wlpsa3dyREVEd2J3MWVpSVA2WC8yQXFIYlpt?=
 =?utf-8?B?OWlLTVFkRkV1N1NxZWRidzRpMWZYM29ORm00UENBeEJ0SGdvdE0wNittYlRo?=
 =?utf-8?B?OHhlM3ErN1ArZjY4bU5MSFUxZXU1dnRsK0h6UnRMOGV1WEhkWSt6c2VOeXhY?=
 =?utf-8?B?VXpja0JPSE1IVGR1QTVsQlBYQWg5U2ZBc1FRZTE0dGtUQUNHNHlCRDBYQmMx?=
 =?utf-8?B?anB0UHNCR3Y1UVhGZ1NMcjFkN05ZMnNDand1MWhrb0dRRlkvWk9ZNUFhUmFh?=
 =?utf-8?B?VXg1aGpwbDNhY3BMMGhwYlVKcktVejRyU0lmRjNKMGExT1UyOTc1UXFGZVRY?=
 =?utf-8?B?K1ZBSFY3MG0rYzB5cENSWVBxY2E0ZHNOSTBzeUJIY1l3VFRJRW95SW5ORVA0?=
 =?utf-8?B?SmdSTzhlVnhtV3pUY2tQRmZCZ05YOHJvQWZsZ0pQVEJvSVBPUHp6MEFES3pI?=
 =?utf-8?B?Q0VUSkJJd01va2ZEMGltSVRQaWEzeXFvUlpuNnZlanBydmZSNFN1TXk0b3Jt?=
 =?utf-8?B?TFR5aHQ0WkxaVk1kSkx4Y0xWL3I2aUkvWkwwd3hzUUIxdXM2QW9EWG5GRnZ0?=
 =?utf-8?B?ZUVKRXpLS2diZ1Q4cnFDNWF6K0tPVnV5YmlCQ0JLL2V5dHYyUDg4YjRMZm1y?=
 =?utf-8?B?bmJhRjFUbUIwRU5vSmd2MEdHbVd4R1RIMEQwTUVra1g4WU41T3RPRExKNXRP?=
 =?utf-8?B?VWRVQzVDS1Z2b2ovUUxDWWI1S00ycFRxYUx0dDdEYkgzQXFOdXBEZWxNcVJV?=
 =?utf-8?B?aGRkSW1wT0VOSkp6QjJNa3AwL3pJUGl4dXRTZ1E0WHNQbFFqMGdXdlBVaW5C?=
 =?utf-8?B?SXJRSjQ4ajJJWFJGa0o3a0FiNGE1T3MraGlQa0oyUVNLVmZZZTVBVThRb0Vl?=
 =?utf-8?B?WkxMN285L09vM1U1c2p1TDBSMC9DbS94M2NOQ1RVdmRITlJGMjhtMm1MS3hv?=
 =?utf-8?B?ZXNneFpIMGJGc0J6RjRoNWNXYUtUNW9pRzN1dkprTTJRbFAxNFVtQ054NGdO?=
 =?utf-8?B?bEZqdm13SFFLZXVTM00rK1paZVg1UGlUQ3NBU0lLQ2kvTVprRkhHUzVtL1hz?=
 =?utf-8?B?TGFiQlFQSU1zaWlhOHhBZ3d0WE8zNmx5b0M0bi9wYmRVc3ZzaEZCTGFhTXpM?=
 =?utf-8?B?VFFRK3hLdGhFK0pGa0tjMEwwT1B3YnpHL00vQ2NsZ1hLeGRjc1R6NEhLSzRZ?=
 =?utf-8?B?ZVpBOWNnUk1CZlVqSDhHcWFmVjU3cXhtMmwxYXpRb1orc2dyL2QxWjdPRFNX?=
 =?utf-8?B?eXlhY0JkbW1lZTBmQ0RsSHBvYStRVzZnZVVadkpiVlNqNFluVEFFR3dMWU5I?=
 =?utf-8?B?RVpEN2dySWEzQjFaMmh0U2duWE5MRldlYXM4b2w4VWlNekZzRHgzSlNTRVR0?=
 =?utf-8?B?RUNPUFJKRm1qQVNpaWQ1bDlpS2JhclhkVmtqT0h6dDFlM0M1NkZMemZMUFBT?=
 =?utf-8?B?TlJZWmV1TDJhbGQrUG5GMStkMTBaUE9hNUEvODNGVFdaVW9RODg4bTJzSGV2?=
 =?utf-8?B?L1cwdDRNMlIyTkx0OGFLNWIvRERrSnZ6Z0xXc2QrK1FqR1M2QzZMVTBDUzNz?=
 =?utf-8?B?Z2pUQnkyVnBsek5tVWZzUDg3bUltRW1USVhnRU4xNVJiQlJGSzV6Q01QY2x5?=
 =?utf-8?B?R2t3ZEJWUTN2TzlGdzBTa3hhRkZkOWRMbUJCTHFRZGVMVGthWStRM3hRd1V5?=
 =?utf-8?Q?pELRrt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDFJaWJBOXdYMHR6RndoV1VNSTllUVcwY2dNSkpvZE11bEFXVmc5bmU0V2Jh?=
 =?utf-8?B?RUVuVWlOYUNpV3Q5b0pyS2FVQ2xBU1Rad05aQzA4S21XYnhqSTI3MWcvUFM0?=
 =?utf-8?B?T1hNbEJOYWpUK0VVbVEvSUF1TGJuZHZ2a29ydWlWc2M0cDEvNXhpakNpelR3?=
 =?utf-8?B?S1RXSHhHMTlmR1k2NEl4WFovdi8ya29MWXA3aUZLQWpjL2NWeEZxb2ZON2V3?=
 =?utf-8?B?THZGTUl6ZkUvUGs1UUhtMEQ3L0tXWUZua293T2dESy8wNG9uQW5UVjRIWHAv?=
 =?utf-8?B?ZFJWbzBJVDd2TkZoaG80Qjd5UXhpRW5ZamZpUEZIUlpHeHAxNnZTV2o2bnUx?=
 =?utf-8?B?c1hja0xXRWNGV1VDSVlYRTNSQ0FBYTVoRDZpbjVmRVB0MEFTc2E2UjJMWDlU?=
 =?utf-8?B?UHFjeVFia2ltdklMOTh2SjdWOGNqZ2Z1TUYrYllFaGNoRkUyZWtJU2pwZEho?=
 =?utf-8?B?VXg3NUlHZGdqdG5vYkc5OFoyazdPWXhmbGprWWV0TEFGM3U5OXpLekxUTjl5?=
 =?utf-8?B?clFIb2VDOFlRV2VyR2Fqd0poQmtzVStkR2tBRWdBcGVMSXU3aTlMNmdyVTh2?=
 =?utf-8?B?Uk9JNUlPalBFUnhqR0FmRUdZL2ZJSlJNY0dPZlZDWWVpaWp1dTA0cE5sYWI0?=
 =?utf-8?B?TCs1WXVrY2UwYmV0cmlvMEFka3V5NHFRYzJwUFF0ZExrKzBqYXRkUi9PWXpK?=
 =?utf-8?B?NDVpc3JhWGhKdjBjV2Y4WHJPLyt6VlVTUUJ3cGFNWnFGSFgvUU94MDNGRHJl?=
 =?utf-8?B?TWJndlhzbDd6OUROSG5sbDJjejRsbWI3MDdMYTlvTGhoeTVYRkdvOThFSFl3?=
 =?utf-8?B?clNCb2M2eVJuYUFHQlBKK2U2aWJWZ1N5WWFac0laa3d5WmJjdzNtdVR6RVl6?=
 =?utf-8?B?Wm9SbG1KZTZFWTJtckxGc2dXdy9OYlB0bHh5THZ3Ry9KQnZJZWdaUlFvSVhR?=
 =?utf-8?B?ajVmRWNyZFBRVFNiSnptb0U0dVZpa2x4bDZyQW84STJ3YmlrY0RBQmtLa2FT?=
 =?utf-8?B?c2hRVzYwSFFWSDk3TDRhT3ZHUXE2R0lERFplbHJIQXJlUkFQNlZFbWxzY2lR?=
 =?utf-8?B?emNsWnAwbjU1b3YreGg2dktuWTdOQ2FaM2hOYTJhWms5ZnV2alU0RUxqMzRo?=
 =?utf-8?B?bUV5NVhHRjlJamJTeElMNFA0eGhaUnBPZFZ2TFVkbXYwRHZTTWtWcVh1cHoy?=
 =?utf-8?B?OENweGZnTXIwcFJlMG1WRHZZNVNBZThVQXNpLzlncUhNdVc1eXhKdmZhS201?=
 =?utf-8?B?SDlqMzdjeHdhZnF5Qzk2THY4SnZVUy8wYzJ5ZVorQnM4Nk9UNU11Z2M5eWoy?=
 =?utf-8?B?WkFBN1BUTjJtMFh4NFhSQzc0SmE5bVcrM1JyTXI2WkRtTkJMeHhsNzdVZ1dw?=
 =?utf-8?B?QTFmLzYwdXBNYmp2TG1MZzV4MWt1ekVUMTQ1WDBqRlRveDJsUXZNSUxqVkx1?=
 =?utf-8?B?dTdFbU1jWnRrRlFjKzV6R28yL01oZnZqKy9WWllodU1KS2FSTFROeWI0VlR2?=
 =?utf-8?B?ODFpcXBiZFM0NzdrQWU5UDBEMHlvVmhkTjFvVXAyeStVOCtsTjR0MW9VRnFn?=
 =?utf-8?B?Z0h6ZWExbXBpWldzc3NiM0NlMEMxb2g3MDNadVFmUzNxeE9rNVJQMDc2ZzQw?=
 =?utf-8?B?QVdLbEdLL25BNVhtL0crNTcxWml5NVdoZGUrdGg5VXQxQUp0Wk4rVWlRUmky?=
 =?utf-8?B?ZVY0TDBMUkFITW9YWlpTSVlSVFhVZFhreGdHcm9ZUDlMNVB0VWZxY1JrclpL?=
 =?utf-8?B?MFlwMnRKK3ZBZm9aSUs2L1F2c2VGR0tuditJVHpoc1p1T21nZExGNUZFc1FP?=
 =?utf-8?B?eTJ3UXRIZGFoSDR2SDRycFhXRXhiMGNMaEVrclo0UTVtaWw3Z0JvN01Sczgz?=
 =?utf-8?B?d29BNU91eHFVcUQ3WTRyUHpMa3VhTUhTL2NMcWNBL0lyWjV6TmN2VEExYnpm?=
 =?utf-8?B?MldOdFF3Rm41YVhTUGY1TmUvcS82S1FEVEZqcU1yb01jT05zSWFKbmJXemI4?=
 =?utf-8?B?K3p2bDUybmwrZjNLLzRabmpvSWFNRGVJZ1BFdkhwa0VPQUwyYmVZWnBnbk93?=
 =?utf-8?B?Z0hZZjQ5ZTNGdWd1WkE3TGJ3QVRwdXhSSjNlWUkyU3V1cWluSXJPQndFUnZF?=
 =?utf-8?Q?4bhqs917LwTV3ifhMIf/G6F4C?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f3a7dc-3628-4e3e-91fa-08de28fd6c63
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 12:56:44.6262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KL6qevIeX18M3sjKRaG9TOrtSsPDXO5LZeRHP8dRHgZ7s6G4OnBpYIfJksnp6MlfjumoLa9CS4iVWaN2q09tgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1512
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

Hi,


On 7/31/25 10:59 AM, Chintan Vankar wrote:
> CPSW driver is defined as UCLASS_MISC driver which needs to be probed
> explicitly. Define bind method for CPSW driver to scan and bind
> ethernet-ports with UCLASS_ETH driver which will eventually probe CPSW
> driver and avoid probing CPSW driver explicitly.


I just noticed a new error message with this patch.

On the phycore-am64x we can see that the 2nd cpsw port is getting probed 
but fails. This is not really an Issue because we are not making use of 
the 2nd port. But the error message does not look nice.

Why is this even probed? The soc-level device tree disables the ports 
per default. And we do not activate it in our device tree.


U-Boot 2025.10-rc1-00085-git (Nov 21 2025 - 14:48:38 +0200)

SoC:   AM64X SR2.0 HS-FS
Model: PHYTEC phyBOARD-Electra-AM64x RDK
DRAM:  2 GiB
I/TC: Reserved shared memory is enabled
I/TC: Dynamic shared memory is enabled
I/TC: Normal World virtualization support is disabled
I/TC: Asynchronous notifications are disabled
Core:  89 devices, 35 uclasses, devicetree: separate
MMC:   mmc@fa10000: 0, mmc@fa00000: 1
Loading Environment from MMC... Reading from MMC(1)... OK
In:    serial@2800000
Out:   serial@2800000
Err:   serial@2800000
Net:   eth0: ethernet@8000000port@1am65_cpsw_nuss_port 
ethernet@8000000port@2: Invalid PHY mode, port 2

Hit any key to stop autoboot: 0
=>


Regards,
Wadim

> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v3:
> https://lore.kernel.org/u-boot/20250225114903.2080616-2-c-vankar@ti.com/
> 
> Changes from v3 to v4:
> - Moved initialization part from "am65_cpsw_probe_nuss()" to
>    "am65_cpsw_nuss_bind()" method.
> 
>   drivers/net/ti/am65-cpsw-nuss.c | 40 +++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
> index 9b69f36d04d..754076d807c 100644
> --- a/drivers/net/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ti/am65-cpsw-nuss.c
> @@ -705,7 +705,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
>   	struct am65_cpsw_common *cpsw_common = dev_get_priv(dev);
>   	ofnode ports_np, node;
>   	int ret, i;
> -	struct udevice *port_dev;
>   
>   	cpsw_common->dev = dev;
>   	cpsw_common->ss_base = dev_read_addr(dev);
> @@ -732,6 +731,7 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
>   	ports_np = dev_read_subnode(dev, "ethernet-ports");
>   	if (!ofnode_valid(ports_np)) {
>   		ret = -ENOENT;
> +		dev_err(dev, "Invalid device tree node %d\n", ret);
>   		goto out;
>   	}
>   
> @@ -763,12 +763,6 @@ static int am65_cpsw_probe_nuss(struct udevice *dev)
>   			continue;
>   
>   		cpsw_common->ports[port_id].disabled = disabled;
> -		if (disabled)
> -			continue;
> -
> -		ret = device_bind_driver_to_node(dev, "am65_cpsw_nuss_port", ofnode_get_name(node), node, &port_dev);
> -		if (ret)
> -			dev_err(dev, "Failed to bind to %s node\n", ofnode_get_name(node));
>   	}
>   
>   	for (i = 0; i < AM65_CPSW_CPSWNU_MAX_PORTS; i++) {
> @@ -798,6 +792,37 @@ out:
>   	return ret;
>   }
>   
> +static int am65_cpsw_nuss_bind(struct udevice *dev)
> +{
> +	struct uclass_driver *drv;
> +	struct udevice *port_dev;
> +	ofnode ports_np, node;
> +	int ret;
> +
> +	drv = lists_uclass_lookup(UCLASS_ETH);
> +	if (!drv) {
> +		puts("Cannot find eth driver");
> +		return -ENOENT;
> +	}
> +
> +	ports_np = dev_read_subnode(dev, "ethernet-ports");
> +	if (!ofnode_valid(ports_np))
> +		return -ENOENT;
> +
> +	ofnode_for_each_subnode(node, ports_np) {
> +		const char *node_name;
> +
> +		node_name = ofnode_get_name(node);
> +
> +		ret = device_bind_driver_to_node(dev, "am65_cpsw_nuss_port", node_name, node,
> +						 &port_dev);
> +		if (ret)
> +			dev_err(dev, "Failed to bind to %s node\n", node_name);
> +	}
> +
> +	return ret;
> +}
> +
>   static const struct udevice_id am65_cpsw_nuss_ids[] = {
>   	{ .compatible = "ti,am654-cpsw-nuss" },
>   	{ .compatible = "ti,j721e-cpsw-nuss" },
> @@ -809,6 +834,7 @@ U_BOOT_DRIVER(am65_cpsw_nuss) = {
>   	.name	= "am65_cpsw_nuss",
>   	.id	= UCLASS_MISC,
>   	.of_match = am65_cpsw_nuss_ids,
> +	.bind	= am65_cpsw_nuss_bind,
>   	.probe	= am65_cpsw_probe_nuss,
>   	.priv_auto = sizeof(struct am65_cpsw_common),
>   };

