Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309B6CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:26:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E78A80FA1;
	Tue, 19 Aug 2025 09:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="C3f2XCAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A9B81D5D; Tue, 19 Aug 2025 09:26:23 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A825802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsVXvajjIZMNQjUgTrsLOuUss/0Twm2cvl73Io6oRK2wzmi20H0LBetpyMXogjjfZjBDmssYjhyKbshR8XNmhcpr2My8zMuCA7fMecDFRyyDGSem6ntV43+FmbF/+TmtqfOJZRsvAmE9Smgpf10nhlYEUdPd/9cgzwCvxm+QeoT6jqanyz6teGDyOjxtTn9ZU5J2EBRgPTCELoaWfmD5o8xEkfw84b1IuA1xdEFRQaq9CgrNJhFYAb1t0kPnfnzZfzQQPpGsY2QNAVbhHpnsqWPHba4RvzTduNJdvL6rWBn60yTyEwzu7SYz7Ue8b/wo7Up+Bu8XVd2zzDCo+OHGww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDsxC86N+iiz5NId+BWHBPkXAIuIu0p+rTC1I2mmXIY=;
 b=FrCX5kL7+Cn9Ct/YDFoF/iMxfGPGTyOKenQpn5VHX/2eCEhYB4j0xYxEVVcFTtKFKt2GFFWkxTVli81LrAdcL277D+WcggK/88d2ihSXBENwnGL0RJuwr+6B4PIK7ZGDck4eTSGcMymslctwE4kHlKXCvxKOB9k3FNmdJnglEOE6LKGPWR2fbvL1JDaW9QrkYsiPA3e6UepKA/GMyc14nexNMxZOSzHh57VHtlIP2NQdWWxTEyMBhXvMxYYEwf6vTE2Bm0A9/68Wpe3hRNmGYXiiBeDrdYSKlZ7GZUCm2PrPXa8pjh/MTsiuf3jpNq7wzQwhU0MiaCTCRz8/pz/PPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDsxC86N+iiz5NId+BWHBPkXAIuIu0p+rTC1I2mmXIY=;
 b=C3f2XCASEbkPp05TMlfs5CyiLEwnK8UmsjCUIkhWWNDWq5Swm+NEn8rs+cwsTpRRqaESIE61ZMXoh4EW5TMaJZJsmfJSq5ZMYmfFOBlU1d3E6EAaui5+oHvs5t9tWvjR5bykt4M/a+Zpa8nZSt7ZaxXQCq4r+zZW6GmN2gtFcESMdXj6St9w/FCCK6IVO6k2iMhwsbVpn8KUD4Zcp+/nAdTmTsewEVlBq4G38QMf1eAUBrt/jYAG40MWCeBaeYDadpzMJbcgpRVCgdbe+MzwIK49XwXvyASde1Ud2/+4TWTr7KlkqJZmJiJf+cdhw6o8s5svih9BiSLm0TehsQkFqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV2PR10MB7582.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:be::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:26:15 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:26:15 +0000
Message-ID: <d4e3714d-d687-427d-8136-5388694603ec@kontron.de>
Date: Tue, 19 Aug 2025 09:26:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 19/21] mtd: spinand: propagate spinand_wait() errors
 from spinand_write_page()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Gabor Juhos <j4g8y7@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-20-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0323.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV2PR10MB7582:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b12cb27-d81b-450e-8c6b-08dddef1ae6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnFRZTd6QlgzTFlwR0Q4ZmpPbXJ5SmtkYU15WlpoWlMxRlptT3FyeTExOCtQ?=
 =?utf-8?B?Ujl1eG1GVWxIOUZpamhzMG5NMzJ3WDh1eCs3U1VpdHJLQTN3Z201cTBybHRX?=
 =?utf-8?B?Z2J1SkdTR2JJUFlId2RKamxKZ0EybDlNbWhmdUE3RHNXSVFtSmZzdUtrRTNt?=
 =?utf-8?B?Rnd5YWxkeWd6TnpYazk4dG54SHlyV3JJTUxUV0hITlJTTWRXcVRTQ3NxU2c5?=
 =?utf-8?B?WnhMVjhnUE9FekJpd1owdDB0c0xjRnV6Wnp3clc5SDlyN0toZ043SFp2SlFm?=
 =?utf-8?B?SWJ0ZWhUdlo4bFl2eWFNVDRPb2xYelh2bFBOSEs3R0Y3bmhiOWwxS28wYUVi?=
 =?utf-8?B?WS9BZkM5UDNlYTlNWktaanRzQVF3MFdxbmF2aHM3ZlR4OTRwa2JXQmxDSm95?=
 =?utf-8?B?U3BJL000Y3BmMzVIV1V4dm5mZlBOalB5OS9pdGJyZFByekJBUDNseFNFSUF0?=
 =?utf-8?B?OHpPejFiSXFVL0hvQ2U0dTQ0di95a1QzWGxVMHJhcVViUFdyVFo5OXE5bGhK?=
 =?utf-8?B?ZTA1a25OMGNSblVnQThFakEzeHNuMzIwamNGMDdTYXlDRWhDS2JBR3I5Tm5v?=
 =?utf-8?B?N05LRzFGWnVMYm1XQUpBWmJZKzVGWnhDNkdrL1phNEJUSE1tM254b2JYRkVo?=
 =?utf-8?B?Y3RrTGg4bGdWQVpRVG5pWXhxRjlmajZSUE5jaEdjVGZwQjI1SmtmSkZEOElN?=
 =?utf-8?B?MnR6d0M2M2xMR0JoR3pSL3c2aTJsVmxIa3kwZU01R3BtTk1WVVhmZVNTRHpZ?=
 =?utf-8?B?eU5qU0pyT1g4dFkyRVQxRUEzWWViUUdmVnc3Z2x6dzFQTUpoRVEwSW5Bampa?=
 =?utf-8?B?ZFI4dTJtZzlvRG4ybEZEVm0rT2h4MHh5TENvNS9uTEZjZy9ESEpNWml0cXVa?=
 =?utf-8?B?Y2V2SkdNTnRxaEFxMHhkdTZvSXptWmlWMnpHU0JkSUNlaS9TTmpMamNrNDda?=
 =?utf-8?B?V2V6L0Q3enNTWk1GY0p6QjBOdE9XMmJGSlRicGRyYkpPY0IvakJtMzgwdnd2?=
 =?utf-8?B?bmlmTW8zY2lUZ0F5OGpkWi9PdHZLUWRIbURBKzUwbjBTM09XZzdnYlRmUkRC?=
 =?utf-8?B?VXpmblMreTdRbHJRWWVQeDNpTVR5UzUvWk1SZWJoZ1ZxRWl5eFEzUExFRUoy?=
 =?utf-8?B?czNFTjVkUVlYWW1weGFyN2NFVmpWZlFrVGRpREx6RUNYT25RdnJrRDRVRkE1?=
 =?utf-8?B?NHRNUEFDSDhVUE16STNPVkxQK1pDdUZ2eHBaU3d0QTg2MXMxUlpaUnFLSE9M?=
 =?utf-8?B?VXUxeE1OQm1wUjRqRmRtb0ZrWGhOWjh4YXEwN0lQWUJnaW4vbmdaeDhtbERP?=
 =?utf-8?B?cWVkb0h6ZEN2bGozajZ0VjN0bExMZFJKVUZaZ01WZ0lyenZmM0ZXY0tOdXV6?=
 =?utf-8?B?SldwMkFsR2NadGxkUHUzNlFZcDAwc2dFa1FUUDZqNWNIa2gzR1Jaa3o0Zkhx?=
 =?utf-8?B?SUtmNlM0ZTZnUGVyWHdOWk9ySDhieUk1RXUvdW5CNXYzR2M4aGp4cjRtNFU5?=
 =?utf-8?B?TzNwUXpyZ3pGRG1PQUp2eVpPcWl5WEtsVE9ZNFlxZW5iWEFLMTBBdlZXMmE0?=
 =?utf-8?B?NjROU0NwbU1XODkwajNKaEVZSVBBWGhaZktnUERLRHFscFMraVliU3ZMUnc2?=
 =?utf-8?B?SytFNWdNTnk1bVAzOFlTYlhVajZhQ1lscXA5azJqbVFOTGRoamFsekloZ3J6?=
 =?utf-8?B?U1JLYjAxMVVaM2ZMelBkdDlidTFPN1l0ejYwcVFuOVB3SHBmdTlNL1Y3MGZK?=
 =?utf-8?B?UG8vMUdPOG45dFYybEY3aGdXM2hLeldWeWhuYmViMUI5dnZ6QW9rM2Vacm50?=
 =?utf-8?B?UlI5enNoOUZaNHdtaDZIbzdMcDhrV0JSdUtMZ2xWaU0vYmFiK0RkTjV2M0ZK?=
 =?utf-8?B?MTd4UmJ1Sk5xV25wK1MwdjBXTzRFSFZIWWhIOS9JNlVObzFGTTJpU3lSMGhY?=
 =?utf-8?B?eUdGMHdwUW5xS0tOZ1orS0hDdlRvL2N2Tm5sWjUxemhNWGhUcUR3QmtvMUVH?=
 =?utf-8?B?QUI2WkVDZFd3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVJxU25RV1VkYnlaZVdza3dBZ0EweTM3R3pyMk5PR2tySitwNzFCbTh6Y1FT?=
 =?utf-8?B?U2RhTEhaM1pOV1YvZHo5UjdpYVgxOUptRTNWNFl4c2Vja0ZXWS8wN3Zud3hG?=
 =?utf-8?B?d1Y0RGxQNFNjOTUxR2d0cW5XTW02TFZnckpFaFc5YnBQSXlQM09EaWNIejJn?=
 =?utf-8?B?TWVUajF5ZnZ1RVZubDBxTXFEc0lZdDRSTWxGTy83Ulh4K01yK3JzU2lKeHBC?=
 =?utf-8?B?RWtwYktiV200N3RRVWtheFQxMzIzdzl1ZlVrWFFWVXNJZEVBZ1J0Q05RTHR3?=
 =?utf-8?B?Ym9xZ080ZlN4Y05KTzNoRzIycGptUndKNHFZb21VYjkwY0R5c28xbXJpWTVn?=
 =?utf-8?B?RGE4bUdyQU5tWVdlTmhxYlZENGpmNWhCNm5oSnV2Rndpckxha2xqWXVMY1pB?=
 =?utf-8?B?WnExbzZDcC9GVjgzUTZ5T1BBU0pZVFVmVXZDMXgzcFdSODhFTzE3cDUvK1hz?=
 =?utf-8?B?VDFOMVB4V2xjeW4rQUEwMzZ5dzNnbjlNK3FKYzlWbkFYY0JIOXFadXhmYUt0?=
 =?utf-8?B?Q0o5cko5YjBJWlFQWU5NVzduS0h1UG85NFh3eE53VWx1QXpscHFOUUZXUzM3?=
 =?utf-8?B?NUVjSlA5SUloVGYvblVWRTBVTWRmQW9xMldqeFlFL2hiM1ZxTkU0OGZDOWQy?=
 =?utf-8?B?cnNDcHp3T2kvVVRaRkJ5R0dqdFh3ckZHYWNPSlJhYlcwSi9NUHpsRDRwY2Jj?=
 =?utf-8?B?YlZhZml1RkJyQ0RzZ3U1YVRjSnNZZytvN2pTM3V2NVhaTjYvRGprc3FVdWNx?=
 =?utf-8?B?M2VUemM1YkVPWitDSnNucEJZV2YwVnlNZndQaEZwbWluV1lNKzJxTHVZUWxK?=
 =?utf-8?B?MkZKdVdhdnpxbldpMldrblBTNFJTOXRETGppZzcwUFA1THBlVjZzQldnV2pt?=
 =?utf-8?B?RktidEJLbE0rQzMrdUZtNE54NzhJRlQyUU5meGxTWUxhelBBdXVDMWtsYkFC?=
 =?utf-8?B?VkxBYU5QOUhsQjRkU0JiQjNDNHB5LzNMYjJsWU83NUxYb01HdDQrdVlOVDFF?=
 =?utf-8?B?Nk5TSFZxWGZ3WmRHTlM2bTNHMlpQdTExTVVkeTdLaVZOMEdxU0dFeFp6R3hD?=
 =?utf-8?B?SkJGOSszNStDc3RzVkpHMFRIa0F1cG1HRGFSS3RFOVllbk04VWlqdDJMWmhW?=
 =?utf-8?B?OVpyK1E1Y2dPRnFBOTFnZExIZStMU3Y2TFFheXpkRm9ONG9aRGZyazA4bVZT?=
 =?utf-8?B?ZmZsRDBzNjFUS290aThCd0R6OW4xendGOWo1Y3R1RlB3bjdDaVBjcGZZVHVY?=
 =?utf-8?B?aDBHdXoxd0Q2ZkluOHhkT0dpMjVRNW5nM0l1T3MvMVpHMU4vTXhLTGx2SDJU?=
 =?utf-8?B?K284dDQvUFBjTVI0ZE9VMm5yVXlOb0ZYWXpjb2VOb2pYSzRBSUxVU2d5eWNP?=
 =?utf-8?B?eHBoMi9rMGZsOVE2eURVWEdWZkh2NGp2c0RIYXJFNUlBTTVWMnNSSUFGaVor?=
 =?utf-8?B?bTQrekZkUVFmUi9tYVpYNDZ6NzQvc0tNMWt2M3dzdWlWd2FXSTMwMmVRT0M2?=
 =?utf-8?B?Qm91VnpQYW9zQmxGc3hLOXlPSTZSZlBUT1l3alkvYXFDZjQ2M2pnelo5YWdk?=
 =?utf-8?B?WDNMVDMxbkRyUFlQY2s3bVZxOUd1RlU1bEloaXpEZ1VjVzBRK0hFMTNZcTcz?=
 =?utf-8?B?VEtnYXN0bElqeFMxWkZFb0R1SkcwMUlwS0RIZ2ZyRW82dGQxc3lFMjM0SWdN?=
 =?utf-8?B?MXJPQ1BDSEtPQUd0L3A3bEpQa2xpQlF4MWdlL0pCaEJWS3J3NmtmckY1YXhN?=
 =?utf-8?B?cERmSHV5cFk0andxMWdHbWQyODZ6TUMxNjVlWFhmd251aG03MExOa1VzWGFU?=
 =?utf-8?B?RFBqaGFGUVpUcmZvWmNpNXg3NUNOSmRvOHYxVS9ELzNFdVZMR0xMTlY4bW9o?=
 =?utf-8?B?aTBWdXpUZ3hSbkcxZVoydUtEa3ZOWklObGFrd3l0alczRnFQUE1SMjdPMnJ4?=
 =?utf-8?B?bzRiakpoM1RXWkh2aVh0Tmp2VWhNQ1hjdWNPRjRId0IyNmh4UW5uL2o0aU1L?=
 =?utf-8?B?d0tqazVUSzRvYTF2N3ZQL0Znay9pdEFjaGk4Zm8vRGwrczYzMTBWVkNJMk1t?=
 =?utf-8?B?WnFhM2JEbUZPMHpIR2ZPa3VjWEsyRDdGNVYrM1RtRHhsc0ZSSlJraVRqNHQr?=
 =?utf-8?B?bHlYbElveFJkU1FvSEh6NlhzMkpFUit5TFNSTXEvOTRXdWxVMTNqb2hUZ2Ni?=
 =?utf-8?B?TGc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b12cb27-d81b-450e-8c6b-08dddef1ae6b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:26:15.2698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjdXv7ivTtD7+QU9aC9BQhYfkREXUPnXRRC5tmDLBVPrg1/lzxeaZaoLVpZiqhr7PYSoXyG5gTlaVRMQHB3xTcAVK/ieoPcUvgVmrsUXq8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7582
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> From: Gabor Juhos <j4g8y7@gmail.com>
> 
> Since commit 3d1f08b032dc ("mtd: spinand: Use the external ECC engine
> logic") the spinand_write_page() function ignores the errors returned
> by spinand_wait(). Change the code to propagate those up to the stack
> as it was done before the offending change.
> 
> This is a port of linux commit
> 091d9e35b85b ("mtd: spinand: propagate spinand_wait() errors from spinand_write_page()")
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu> # U-Boot port

This seems to be a fix for a change that was introduced in patch 10 of
this series. We should avoid introducing regressions and fixing them in
a later patch to preserve bisectability.

Can you please fold this change into patch 10?

> ---
>  drivers/mtd/nand/spi/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index daf6efb87d8..3e21a06dd0f 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -691,7 +691,10 @@ int spinand_write_page(struct spinand_device *spinand,
>  			   SPINAND_WRITE_INITIAL_DELAY_US,
>  			   SPINAND_WRITE_POLL_DELAY_US,
>  			   &status);
> -	if (!ret && (status & STATUS_PROG_FAILED))
> +	if (ret)
> +		return ret;
> +
> +	if (status & STATUS_PROG_FAILED)
>  		return -EIO;
>  
>  	return spinand_ondie_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);

