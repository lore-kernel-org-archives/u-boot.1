Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953ADD2ECF5
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 22:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A83839D5;
	Mon, 19 Jan 2026 23:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2kBXv9JH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16EA6839DF; Mon, 19 Jan 2026 23:51:45 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDAC88389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 23:51:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fc+BegOc7s7uTV4mYNzOKSSxY+ib/73UAu+1YUsT15o+0UQDKwrKyUWm2xKYv0tsWIonxR+38osb7fWCgTALNJbt5FGeL4++XaAL17KogPp+ounqw2xMuEQOqK30tYC5oWYI3fvK61uj0z4yAYpHA0IS8m7ac8eOHVlNdvwEd2TYxAa35VxaMVV1toRxUu/+9XdjXXUlr07pSeEXdnU5tzKiaygh/ibBMKCIv16QBIGsHpKbgTPXFf4nHrcj/VAdLWBM7MijimbOzc2suJk4auQBmNhOf/PEEGENRz9E/cRKdduF9uVpstb4SoI8QLeoaay3HgtfSrJ7TKKuuPFL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1WxcYCiJ8DPqcnMhjWwgYPST11lOkqdHEWU8bAhYFE=;
 b=aEeJZ9ZIBwhrCWPv7B8dqxMNqnptBKaPJ2lnUTLe4EO+2usAHtypT56xobTatPD6vHZNQ0vwgmdZs5qnQLj/8+658Pl6gfMvuiQRoqkQuu5fm64YWUg6I30H65ZxWABSuUAyzo48cGEGt5oUfCowmKLX+tbWr1edJGs3LEoUnewBocE8jzwxNTLomwj7e1jDx1lDw4xjWQvW4X9R7zHBdZEF4xAGwRMXKYJpebzzGUYFkKFqUqsVX9t0EfIl187uEbh0nhMXd2NWzQO5BZ097V6ikZ2ywrX4pO6ghgSCwerkxsSZtgna9bi03/SS1r/3t+fypl9Jh8c5g+ytCo2W7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1WxcYCiJ8DPqcnMhjWwgYPST11lOkqdHEWU8bAhYFE=;
 b=2kBXv9JH/iQE/2L7ufD+eMKJWu7p9/6awQnfOC50n+YfmtDSBjsg5ltL+qlBM5aGa5NUMILS5kHV6Z1GXOxEu0dvz9V7EmJiQXEzcM25NP6RREcKkHJPc4HFFhVSZX6vC33HvOTcmZqyA0M59WQdMBO/sA6CB3MUPhvUq0cQpAGeQVEv8CO8dTHgiUhrVlUY8dqSIjSyHSbNJlm/BpBJI6jyytc6m1m2JdONMrFaRPAhxa+m0e3kJirdWnmOpGwbTBpl942xq8xhBWfYJ2TbdT/w347a5prcnG5V63NugAYHF+vBilrnis0KfSiBKFa9p+AODTseOdhieoXVKvjjkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB5943.eurprd08.prod.outlook.com (2603:10a6:20b:23e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 22:51:40 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 22:51:40 +0000
Message-ID: <482c296c-8b21-4022-b5fc-7c722d390895@iopsys.eu>
Date: Tue, 20 Jan 2026 01:51:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] disk: part: fix partition search boundaries
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Mike Looijmans
 <mike.looijmans@topic.nl>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119223305.3022690-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119223305.3022690-2-mikhail.kshevetskiy@iopsys.eu>
 <CAOf5uwkb+bsXsdt9Wn7a2fJRHXX5mOkMGZxifSTY568rwnq8KA@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAOf5uwkb+bsXsdt9Wn7a2fJRHXX5mOkMGZxifSTY568rwnq8KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI0P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::15) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: c3602ff6-c0c7-404b-f044-08de57ad4eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elU5VXpQMUpQenRWNlc4MWo5bFFEWHJJWFU0SER1dTlGYVQrVjNjdTVDWXUr?=
 =?utf-8?B?WjB4Vm9EQVgyNk9OcFRhUU41NDFsd0ZFMjdzdU1Mb0d6RGFLNGlPS1lDM3pj?=
 =?utf-8?B?eFJGUTRzVWJBOUlBYjhZcGFWcFU1Q3hGUWlZMmgyYnZSVnpYSlRUZWVJNHJ2?=
 =?utf-8?B?YnJVSzhvYjg4WGsyY2Mzd1RNbG91N1pwZXhUQ1Y3aCtrcm04MFg0MUQwcjlS?=
 =?utf-8?B?MkUxSG1hemNrT01YdFRGL1ZHNXBuM0NhMnJJUVp6Q0VzVUNhZmVUc29RWkFU?=
 =?utf-8?B?RTluN3h1WTM0R1F5NGdYQmlaNWYvRWZOczQ5bmxyK1FIcmU4bFBmZFp6cC8z?=
 =?utf-8?B?bE9KZE5EOGEvcFV1ZDNWR2hKdHNVdzJlaXlpN3VWU2d3UGFkakU1Z0srVkRI?=
 =?utf-8?B?VUx6YlpqRy8xcHE0THZDWHJNNW1JZGY0RzZzMkZodXVmamlrbk4yWUdzY2Jj?=
 =?utf-8?B?K2Vjczh6V3hnRjRJamgyRlpMZWxwbzhVSDJ5dWlDSDlsUzhsZ050TWFiNk83?=
 =?utf-8?B?S2FGTW5QblUzZlE2SC9WdmRtYWF1aXo2VDkxVUJpUmNWSTY0RDdnK3pnalFh?=
 =?utf-8?B?RUM4d0x0K2ZXWVNhc1ZRdFhGR2JIbnljWWRZeEcwRjE3ZWNPcTgzRlp0N3lB?=
 =?utf-8?B?RWxsR1B2TnhsY0ZxQjlhaHhUSkpFdE95S0trZ2p0TzkwSUpuUksrTE5xVU9O?=
 =?utf-8?B?Y0V0bGVlSkJ2UisrOUpvSkhSdmRJMnVqSlZJTGE4SDJuaEpDYitPUXlNMUF4?=
 =?utf-8?B?QTV1a0IyWUJmU0M0QTBKTFRsQ0R2Yi9SM3UwdTBBTkpURzNaYnZ4a0ZjSEpU?=
 =?utf-8?B?UTZxVTVyWDdBRlFHT0tJNDlzalNmVzhUb0R3TThsMnlxWUpCejl3QlhGK3Vv?=
 =?utf-8?B?K2RiTThRMlhPU3dPeGR4TEkxVmc5dm05dHlGVEZUd3V2V2RWR0J0Y1g4eUVs?=
 =?utf-8?B?RFFZdkxRQWNCQ0xOVGhJWURuZG1rMEZtZ3Z4NDZ5dDRMNi92MTg1aEloRVhC?=
 =?utf-8?B?RFE5MVhDNTVEOXB2cUhKaXNkelY3SUN6Sm1lUElmdEZvQkUvMnphZ1A1c3RI?=
 =?utf-8?B?M1paQ1VUZDJBTVEvVGZGNkFGMFdrVUV4ejNYNU9pQWxST2laRnVTZ1lIOVp4?=
 =?utf-8?B?cFVhZG5sNloveUd3M1VZRmwwSDFhaDZIVjBWMDlSMWpraGpVaUdqRkU2amxZ?=
 =?utf-8?B?aWRmYzU5Mkp6SlhwR3E4NzlMMk9McmoxL0V6cWZPOWlOZnJtMjRkcXlpb3N2?=
 =?utf-8?B?SEdIaTFtbEhNYmdLMVV4UmFJbWJMYkJCRkxEV2NKRnZHak5GTHdzaG5tWFRX?=
 =?utf-8?B?U1IxS1Noak9yQzh5WjRkdUZGbUVVTXNnMDNtZXkzUlUyMk5vMUxFZmIwd1RL?=
 =?utf-8?B?Wmc1aEdyN0tzZVVwMHpIaWRtZHBHcnRSZEc4RlVqaXprMEQ5dWNqYmdhM1FZ?=
 =?utf-8?B?YXB1SlRLNGJMYWx3TkEzQlpkNXIyUVc5Vm9HNTI5dzFnWjV0NXlWeGNwOUZ3?=
 =?utf-8?B?NnFPcVJ6WCtjRDl5WHFHM2wwbW9QR3NOc0hOSThETExKNDJqQnVJcVk0eTBl?=
 =?utf-8?B?NXorbVJiY3RxSTBpVDlqWllpREZjeTNmZHJMQlFFL05GV1BtajkvbmZaWXJV?=
 =?utf-8?B?K1ppRm1LTllaTlJIdGMvano0WXdiVXpKUGxXdExVUGlQWUpNQk5mRkNET3ls?=
 =?utf-8?B?VzRON0c2dENMaDl1aWgzNTdadTc1dW44RkF0Q1pYODlsb3ZEbldvZFBIWU9I?=
 =?utf-8?B?RTNrek13aCtoa2s5NlRGRDFFc2FTSU5QbVVFZ1lPTEVITEFxUVN6YWFqSk9a?=
 =?utf-8?B?R01MOEtRbXlab0cyZnlXVDFGaGM0Z2ZpdExMM1ZWMEwwRG55ZEgrUGQ5KzlG?=
 =?utf-8?B?ZXlJZFMxZzFQckZtelQ5ZCsvWjNFeHNzV1ppTlNGSS9iL1VWL1p2bThHVGov?=
 =?utf-8?B?Y1ZvZjRldURvUmJqRFJhMmZMbEU1cHhwMWFUajBQcTRXQnhvbE9EVXhzYldL?=
 =?utf-8?B?MTU0ei9iZUtBUEJjRFlUT0oyVzlFTzNDY2JZNmpqQk9xOWlrdDZnbGoreU9G?=
 =?utf-8?B?Vk9QUzM3bzZPOTZObUxJSUtEbk9iN1RKdnlYd2pZNHE0NDJUc1RzeGNiNHBP?=
 =?utf-8?Q?CpYI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hYcklFTFFDWVdJdWRsY2Q0SnlYZ3ZBbVFtNVlZblpRbnR5dFpwLzZlMmlX?=
 =?utf-8?B?Y3pPSWJYVDgvQTMzd0dYVWcxOHJ3dEhSQituVVZWQ0JFOFJ3WGJlUTB6NVVF?=
 =?utf-8?B?RitjaFFOMGsvdzZSYmdDTjJ2dnIwUDIvNkNRcnZhV08yZ0FWTEh3SmNOd25r?=
 =?utf-8?B?enpJdkpLN3d1VEUwTkZ4aWdSa25aY0FGWTFMcGhoVGVkSnovaXZzTVpPUVBn?=
 =?utf-8?B?eEdnL0E4eUhKZG95TTlMUXFIUTBEUVFSdDBQdXVPRXh3T2VnVEdKeWZhQldX?=
 =?utf-8?B?YmZJSjRqWEd3VGNBUWR6alRiUGNMSkxqZkRYNG1mTk96UHZHUDZ0UXc5TzNl?=
 =?utf-8?B?S2tudkJSV3pQUGUydVg4WnlQR0tmU3R4KzhpVFRGNDZ3RHVwNVV3d0ExeU5k?=
 =?utf-8?B?SHpCSWFseHNDUERTSkVQaVBpT1RBWXRoc01EandDVERrclJ2elg2SXdRNEMx?=
 =?utf-8?B?RFhad0xTaGFvZHdrdmw1S2pmNk04M3lOMldHcEMxb2FFaUhuMUY5Ti8yd1BS?=
 =?utf-8?B?d2U5UDB6c3RlaUVjUWw5byt3Q0d6ZUlac1JlWWtXUk43eUUvQ3JET21EcWEy?=
 =?utf-8?B?YUxsWFRBZ2pad2Y5NXNnU0VkQUk0SEsvNzFZVmlHRjJuSXdHcnEreFY1aDhZ?=
 =?utf-8?B?YjRPaVg0SU9PcTNnWm5DN2V3NEQ1T1FYSy9FSHdsWGNIYWE2ck9NVWRRZzUz?=
 =?utf-8?B?V25PUzd0S1F0d0ZqZ2svcmhoYlF1eWdZVmV6L0MzWllwZFFXYjY5THlQZGJD?=
 =?utf-8?B?cXZwcUV2aTQxZjJCWUVsa1ZvM2t4MFVtci90TU4xMDNXQW5wOEZlZVBxV01E?=
 =?utf-8?B?ZGQxL3NDRWtueUJrNEUvbXZrMUJUVGlRWU1IK2JlcUNCcGZiZFBTM3Q2aWFP?=
 =?utf-8?B?TTNkSFM2WFZ1M0FKVFYvd0dXcWpGUGRSSG9MQURTSFNSUGJIcTVXdWs2U2Vs?=
 =?utf-8?B?SGl3NElzYVN6WnQyVXNNNFN1Z2NWUmMweG1oNzIxSUx0Z3dFZ01XbnR4MytB?=
 =?utf-8?B?U3JjelZBRGwvdUpObC94bnN6Q042L3F1aGdKTU1HY3pySTNKN2pFYXhtcnEv?=
 =?utf-8?B?YWRaWGpueldXNTNXRlJtbVpjRlZJN2tNRzFUQmFYSFNGeEoxZHIrZCtnOHZL?=
 =?utf-8?B?cFBqcmpDS013UDJ1N21iZzF6V1lLNWZiSkxsSnRNQ09UQjdyeDlDaGlsNnVq?=
 =?utf-8?B?T1BCUE5CRjB2MjBnQnpjc0dnczNMRVZoUVowb0srRDBjblBCeGtXZExCN01l?=
 =?utf-8?B?SFV2cW5rZ21qRjh3bjlLOUdDUmptcVNBcUZrWnplNEtyK1lhZ3lJUnFId1NW?=
 =?utf-8?B?bEJLVFpqWTN6WVZCZmdlbXloL1FISUk1S0dETWFIQlQ5YSt6OTZhUE9ab1Vy?=
 =?utf-8?B?OWw0c1BIajd3eWV2QXV3eUNTQm42QWZDTGdKeU84d1ZJam9jWDdjbExQSkhK?=
 =?utf-8?B?cjA0aWM1cVlodms0anBHVEVlNVdrVEdYajdLRHlaSkhraTBzbGMzcTdZaUJh?=
 =?utf-8?B?cmN2N3dnNVNvb2tIVzRRN0g1RUQ5ejhCN1ZZQkJGdm8vNWNLY3lVUHlPNUMr?=
 =?utf-8?B?VzdoY2hIbTZLa0tDUFBxb2o4M2xMQ0F4R3FveWRFNmQvN0p6NEovbVJYOFpL?=
 =?utf-8?B?eUtVeTc5aWFRdFZzU3JNS0hBdjRVV2VQbzM1TGplWFlNUTZ3MDRMUksxK3l5?=
 =?utf-8?B?Y2RManlIS2ZwbWxURG53ZHFLWG1xR1Qybk5YM2IvUEVPQ2hEYXNHVFZZRW50?=
 =?utf-8?B?Q2FQNlJMTXE5bzJUVjUxOVZGckdlL0VIR0thQitUdjZLSDZDdW1kdE9LR2R3?=
 =?utf-8?B?QTlJTExnQmMzQVdURk1SSHNic2JBc25HWEgyTGROY0pCNFRwVHd2dWw4N2Y4?=
 =?utf-8?B?cVAzSEM1ZHVIa3BzZHhVNGxnRWxkNDZ1dmg5NGpZTVhOamR0dUhRT1FrRG5l?=
 =?utf-8?B?OFg5d1lFY3ZnR0IvYmxTUGxYK0owS29qbUozcU9tNjkxaUJmQks0ZmVEQ2ZJ?=
 =?utf-8?B?Y3ZLQklaeG1iY1REOTlCbWJHSVUxS2RERW85S3J1Q095a0ZzUzFMVHB4RWJK?=
 =?utf-8?B?TnJFY2pDSHpGSmVHWE9NRlZyc2JCWkQvRXJhdC9DaWdUc1cwNnBoUFVKK1lj?=
 =?utf-8?B?ZURWTWcrYzZ3UUN1RDZBQnJXY3NZVUJ4NXlKMHErd09Wdm9hZ20wK3o2anpF?=
 =?utf-8?B?ellrZ0JBU3E0VmZmRldtSTJmWFE1V2c1L3hRYjdURnptY29NUjJDK0dsclN2?=
 =?utf-8?B?Vnk5U0JtbWp0aVNKNzU2SFR4dERTbDFYODNrWERsUFFuTDJXdlhGTzNhcm5T?=
 =?utf-8?B?RWNha2Mvb1RrS29MZzIwMzZlMW1aa1NFeFBRYUd3TmZSMGpGNFdUdXQydWZP?=
 =?utf-8?Q?ymH4lsTbT8xR0GWE=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: c3602ff6-c0c7-404b-f044-08de57ad4eeb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 22:51:40.0734 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDOGXJ9OWO0u1XikGbsgHjkFOge9EDDh+PXvEli+E63RJ6hvJbIGwx+otAk8S0hS21WOmV6bvaQ2kit8fd1MptBRB4s3z/XE7m7xNQyjM+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5943
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


On 1/20/26 01:40, Michael Nazzareno Trimarchi wrote:
> Hi Mikhail
>
> On Mon, Jan 19, 2026 at 11:33 PM Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
>> be read/write from U-Boot using read/write command. Here is an example:
>>
>>   => mmc part
>>
>>   Partition Map for mmc device 0  --   Partition Type: EFI
>>
>>   Part  Start LBA       End LBA         Name
>>         Attributes
>>         Type GUID
>>         Partition GUID
>>   1     0x00001000      0x000013ff      "env1"
>>         attrs:  0x0000000000000000
>>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>>         guid:   5452574f-2211-4433-5566-778899aabb02
>>   2     0x00001400      0x000017ff      "env2"
>>         attrs:  0x0000000000000000
>>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>>         guid:   5452574f-2211-4433-5566-778899aabb03
>>   .................
>>   8     0x00158000      0x0034bfff      "apps"
>>         attrs:  0x0000000000000000
>>         type:   0fc63daf-8483-4772-8e79-3d69d8477de4
>>         guid:   5452574f-2211-4433-5566-778899aabb09
>>   128   0x00000420      0x00000fff      "fip"
>>         attrs:  0x0000000000000000
>>         type:   c12a7328-f81f-11d2-ba4b-00a0c93ec93b
>>         guid:   5452574f-2211-4433-5566-778899aabb01
>>
>>   => read mmc 0#fip ${loadaddr} 0 4
>>   Could not find "fip" partition
>>   ** Bad device specification mmc 0#fip **
>>   ** Bad device specification mmc 0#fip **
>>   Couldn't find partition mmc 0#fip
>>
>> The error is caused by invalid boundary checks. This patch fixes an
>> issue.
>>
>> Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_info_by_uuid()")
>> Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>  disk/part.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/disk/part.c b/disk/part.c
>> index 49a0fca6b89..4923dc44593 100644
>> --- a/disk/part.c
>> +++ b/disk/part.c
>> @@ -674,7 +674,7 @@ int part_get_info_by_name(struct blk_desc *desc, const char *name,
>>         if (!part_drv)
>>                 return -1;
>>
>> -       for (i = 1; i < part_drv->max_entries; i++) {
>> +       for (i = 1; i <= part_drv->max_entries; i++) {
>>                 ret = part_driver_get_info(part_drv, desc, i, info);
>>                 if (ret != 0) {
>>                         /* -ENOSYS means no ->get_info method. */
>> @@ -709,7 +709,7 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>>         if (!part_drv)
>>                 return -1;
>>
>> -       for (i = 1; i < part_drv->max_entries; i++) {
>> +       for (i = 1; i <= part_drv->max_entries; i++) {
>>                 ret = part_driver_get_info(part_drv, desc, i, info);
>>                 if (ret != 0) {
>>                         /* -ENOSYS means no ->get_info method. */
>> --
> Perfectly agree on the fix but still I prefer to think that things
> start from 0 and not from 1 and move up to < part_drv->max_entries.
> Do you consider the amount of change needed to make a more common pattern?

this will require
* change part driver api (see 'struct part_driver' from include/part.h),
* change all part drivers,
* fix all api invocation

It's quite easy to change part driver api and fix all part drivers, but
it's also quite easy to miss some api invocation.

>
> Otherwise:
>
> Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>
>
>> 2.51.0
>>
>
