Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EADC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E103084113;
	Tue,  5 Aug 2025 08:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="ipGtHkUd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DDE28412C; Tue,  5 Aug 2025 08:36:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39B5A83A81
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHb8t6aPOgjXSsb4Mb+4eXYyVm+3FXJSo785SDaX1hf56FdAjJCqCzW/isNryZXUtNK5+JLoD5vtFuYY/z3AAyPMdPIl/bkgnYDXJJsTVQrbrOEA9i51JgsNnd2h0bmRF2uQyW1zkYG+aW7q9S4Sg/0nTGf/XWjHhnKqiKSt6E7QI6WL+uAwwgfgEsO9gn5OYoq9XfEuC8q86RPuM4I9ZRf6MLVP5rnWoOa19wH9FhfB8JypD8cxbu75a1l4suyXz6qTaw7zQ1ncQeXkaNSuNpuwBLFxLMyEjvFkc1gsjaeyZcYUuFslNndai4Qv5jEXjyabrlz96NNzWT/oYDTdpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7nZVLB1XsKMQMKVH9hFsPm1L3Yiw0LXrqmayqCrp+g=;
 b=TAAC8zsM4FSSI18fPgtGTVntRd2CTZ+vXf2seSAmssc5Y5rMBj8cF0evrSMQKnbcp2pwaSuObXa6xAHUDabC4Sive9howBdFqu01+qKqE99T7ITZq0pw9kqLyBwtpoIAOUGgzR3dv7ptiFywecBlDKoyZqg1wVjxi0VvwfIJutViofTTMTC8EECI9/c8Px7iLQVRPFcz7fN4OnVVNpDRcrqS48cM2baZDhbYbS5oxW6O4s608JOKJLIHynfv3IejBLi63br94ILWlMtUVM2g3a/qYuiNE/3DFUdIjXey+7MkJpyh7xKuOMIBwxhYHzEqdV6mxmxnG7ljskZwjoIwfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7nZVLB1XsKMQMKVH9hFsPm1L3Yiw0LXrqmayqCrp+g=;
 b=ipGtHkUd3Ut3kW2+ZEj0QTgRDq5kevUdIvCVdvmZl9swG26dj5nAgJlhYLSjGlo5KUBdJ2zv8U7MyHzMatB/aFCDxaaziWjH3sTPljS6EY606KY/iBUDSEIb6mLrfv+Q0KlJOgszoqgXgLexFdxsmPissaHVbZRPbLEKO+dnr/056Qgo92k0J2VzK6EJfmrpf/zHosVLmwI2LhPRwCLKcfyHLcRkJYrFTLM38lgofD+Xf4PrVBmKd+kNoyrP5/9ZqWcUG3n7RH1CGHZfMtrbf6+2pcQvERfTLYpCDMguwb/md2BxrJzYTA6PXu+WYInOlciMu+VWaipJHzBUpcA+lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB6102.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:570::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 06:36:51 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 06:36:49 +0000
Message-ID: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
Date: Tue, 5 Aug 2025 08:36:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/22] drivers: mtd: spi-nand: add missed add missed
 MODULE_DEVICE_TABLE()
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
 <20250804221122.1420516-5-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250804221122.1420516-5-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b537cd2-ee4e-4abe-d729-08ddd3ea74fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elh2ZmtJWHk5OURITk1ya01MRWYvU2p4eVowUzV6THoxQTlkMHh2MHo5L3ZQ?=
 =?utf-8?B?WjJXOGwrd2E0dnh3OTh2N3RrcVBPdHJvSmJRTjQzNTU0TW9QR1dhZVBwa2lp?=
 =?utf-8?B?MG9vQWNQMWp1VkpLcFZFTTZjZjdKcWhXM0k1RStlTFNPQ2poVEhEajlmcXlQ?=
 =?utf-8?B?cDVXQlNJak1aV3hTQmV2NVVRdEtWS1ZWL3duRk8vQ09oTjFnK0dZNldaaTVQ?=
 =?utf-8?B?YjlBTlArS1hJeFBUdGNmT1lkOFBvZXB1ZGRuMmdTT2R5cXV0ZHNSNytEWTFO?=
 =?utf-8?B?WkM1bks0NEFsWm45L1Ztd2UxQlE5V3FYVjQ3UTg1QXdQb2dWREVUUjZWUVov?=
 =?utf-8?B?Qi9XcGVROWRyL1IwcDRkT3RaeGtZVVE4VU5tUnVZSnVVTHR5KzZ3a2tlMjRP?=
 =?utf-8?B?VUtXQnM2RHhtOE5nNG9aWlFOdEZ6T2tISktVc0RNbjduNlFGTDgwNGwwYldl?=
 =?utf-8?B?UG43VjNadXVyOFJXT3VFWU44Z2UxeG11SmNqbS83WGJDMERPQzJMdmlmR3Bo?=
 =?utf-8?B?Vk12cXlLbUcybitTc0VBMjlvSCswU252NFBiMlUwcC9IRHZyeVFYWDJTa0E2?=
 =?utf-8?B?MXIrUFJXV01vYVBZdVFvd1h0SlZoeHhqOUdWdDBYSVh6RDJja2lVbGRxeUNR?=
 =?utf-8?B?NGdKRkhsWERray8xdDNLZEY1WENkTkQvVDM0V2wvZVlmYnplSkVhK1BMdmFy?=
 =?utf-8?B?eS95SDFhRFNBV3NZV2UyeHFGaSs4T2hZajY5ZHFlWXBOYjdaUDVvdVY3emFD?=
 =?utf-8?B?RGt3enB2eXdEY0I4Vkd0SXgwWDNVVk9ZeFFhaTNSTWdQZ1RNYWJ4NDhNQXdN?=
 =?utf-8?B?NUhqaFJnSU5CL3p1SWxycHZ2NTZyNTBoS1hVV05IVEkxZ2pDdG93WFlNRlRx?=
 =?utf-8?B?YWFnYlpyUzVOYVFaWmVxdmhHR1hiZHhVMjllNS9Oa0g2V3VnMHN6eXRDZWZ5?=
 =?utf-8?B?a09RY0hKMEJWK2Y0ZEo0TVZ4V3NFYmtkcFhZRDNram9XVVlyQU05aE9iZGpM?=
 =?utf-8?B?ZXNrZHd5R2JKUjIvK2YxY1krZWI1ZUJLenAzUlhOM2lVeXlBb1FjQzZGZit1?=
 =?utf-8?B?VVlGZ0gxVGhkVndHU1krRlNnenBrZ2dubktyWWlVcmtvZFU4TVltSzJodFhE?=
 =?utf-8?B?TEx1TFF3WGNFNzY0MmY4NkNpUVB3S1FOcm9neHo4cWV1S21Ed1VxRlNjZzBU?=
 =?utf-8?B?YXEwK2pkY09nN3BON0ZyeGgrclBpbURSYk1OUXVQTlRWQ0xlSjYyL3ljenIr?=
 =?utf-8?B?TGpRMEpoNVZaSE9jbzJLcEhaRGd2MGU1RUttMnQrbVdReVdrTjFSZ3JPNDBS?=
 =?utf-8?B?b252RitTbGFCMWExcXRzUnRmVnpCV2RnaUdwM081eXp0cC84R1JvZHZkaFV3?=
 =?utf-8?B?cVBOYS9zdENUZG1jdE04TG1GRDNud3pEWjR4VDN0M2gwSGlDYnhZNEZBcXQw?=
 =?utf-8?B?VUtYcmJPdDhyN1BFTk0zQU9uVllERFIwYnU0Q243VFBtU1FvbnNnT29uMEQx?=
 =?utf-8?B?c0I3M01Bc0pYVjJKd0RaRC9nTzZSN1JFTDNzSVVJRTZQMUp2aE9OV29TMVBX?=
 =?utf-8?B?SlhBTlNYM1BHR3IxNzZPNU5tY0xLcWJlNnlPSEJuZW9YOU1jN3pzYk0zbFZT?=
 =?utf-8?B?TWZvdlJEeVZlNEJyWkwvbk8vVmkyRS8xWkljT0NKb1N2aTRuL2Y4eXVXOWFr?=
 =?utf-8?B?UHJCOWM3NEcrMFBtSlVWTldsT0pDYWZhQ2gvellNMXpZMCtzWUpKMWJKeHVW?=
 =?utf-8?B?cU0rNm14TldtSGx1YmwvaDhpZ1dBVUxHekFZa3lveVU5anp3TWFiM1FHdHZN?=
 =?utf-8?B?RWdJd0swZEx4MExGNkx5cVRxK01vOTg4QTIvSlVRNWVacHpaZjFDQnJJNWRr?=
 =?utf-8?B?ZERCYlZSWERKWVN2VTRoMlZYZEVDUXlTWmhpdHp5Snpjd1htbFRKd2wrUEQ0?=
 =?utf-8?B?K0RGS0VpVnRISGd1TWtzYVVjd0EwaTZEYWk3clRXc3dmcTlFRHUrcHNDZHpl?=
 =?utf-8?B?VzZYaStMZy93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0hadzZXeUkybEVDMXBCSjJST3R6MXAwOWErZUIvZEFnandJeWxBaysxVzkr?=
 =?utf-8?B?RGJHTXVmRklUOXBxN2QyUS9vZnJYZU9XNFNHYWs5clhadlZiMFF2R21oUVVW?=
 =?utf-8?B?RGJGUExaeERzdlNKWXNXR1hmNXZseWt3UGZPWlZnTkdJSFJ1VGNPMEVSMmxR?=
 =?utf-8?B?eWpKdzZTd01rMHRCUUtTYW8zejhzUGlidlZKVEwzTG5QcjdHYkEyZWZBSDZL?=
 =?utf-8?B?RmxIOWRJZ0dHQXpJdTVnK2d3OXBQbWVUb0NGc1RncWZMOFV5RDgwcm9PU1o5?=
 =?utf-8?B?dzY1UHVORzdrb1cvKy9tQ1VIQi8yM3RXSndhUkduRXZWNWt3WGs0cFpMZHQw?=
 =?utf-8?B?eldiYWlZQkZnTThpaTF2dGVMU0JpSlhjWk9TVmV6NTdKTHUzY1BNa0lHblpz?=
 =?utf-8?B?MVQzdm5pSHArazJBY3dzNnI1WVM0ZTh3ajQ5c2dMc0NpdWlzQnFSb0czUlV3?=
 =?utf-8?B?RnA0VG9YTDhHVlM2cHVvenlFUmd4cjNiY2hhQWpvUHZnaE80NHd6N0V1UlNr?=
 =?utf-8?B?QzBBdDRleXJ3K2VhTnVVaFRBQlR3dFNkZFNMRHpVQVNQdmYzV0R1bEg1VkQ3?=
 =?utf-8?B?WXprN3hoVEVFcENGck9Fa2NkckY4WlRlVnV3ZWJ5V1FoOW5kTFZMOGMwTEJr?=
 =?utf-8?B?b083eU5qdzNPQ3NMaUpnUHRZRDAwMStVeVVaSUxMQlJxRWExbUlPaEJiSlpn?=
 =?utf-8?B?cFhGVk9kSjYzZzRxemRnTEQ4ZFlPQzVvOTJLa2xVOXVtTkNORlV3Z0tGbklL?=
 =?utf-8?B?Q2VXUmlvRld4ZDFFMUxaZm1ueU0vdlMxaHpsb3hWSkRlYldVbHh6clI2c1RG?=
 =?utf-8?B?bWczR3Y5RmJWQlpFTU5WN0JpeEFZTWp2cEpkdGo2d1NHaFNnc1ZhSDdzUGl4?=
 =?utf-8?B?dUc2YXVyZXc3ZTM0VkdVbHJ6N3lFcTVMY0Jhb211R2pJZUprRFptakpNQ014?=
 =?utf-8?B?dmNVWlZFUUpRcm4ycmR3V0drNzdnVVBqWU8vYVpFcWJ6N0JrT2VwQXJxQnRQ?=
 =?utf-8?B?Qk1tUVIvcGpSb2E4ek10T21xazIzMUtuNkJVVzRQTFZOb1lBeDVIS3dmdFJr?=
 =?utf-8?B?M3lrcS9ZM2pmZXZxUDEvL2hwZGlwWTJmWHQ5bVJSbzlMWkdLd3I4SVFVdDBY?=
 =?utf-8?B?QThQRXd6YzgxR3B5ejN1MEJZUWtkdUF6T3VQNXJ1VkczYXFsZzVNTTN2MkVI?=
 =?utf-8?B?S0JwaU9ZS2trdXVINjgzekVuWktsejVYUjFSWElxeVp2bDF0VmgyMkdYTWRI?=
 =?utf-8?B?VDl6RVp3bUtkTFNCYTBZWUJGVWJyenBwbS9aMkpPTmtXWnJYYzFQZEtBanFY?=
 =?utf-8?B?cUFNNjV5dWFTSllNRERGbXdmZC80Y0pyTGhlYWc5SGhmWjRCS1hZVitpZDN3?=
 =?utf-8?B?TDFnUDkzQjNZVGhHRFhKNzY3NE1JNThqV2JPMTlYencxNjRSZnlwek41ZzRn?=
 =?utf-8?B?VHFPejhicjVXeTdDT1JLRUlQV1BiOHpiemNDUWpLNVdLK2RSbFhpa0xkS2J4?=
 =?utf-8?B?YjBUTzdadFh3ellPazJOSVlia0lqdjhxMWU4MXJiZzZCL2xldDQzeGo2eEw3?=
 =?utf-8?B?N0tRUm1KMGZYL0N2NnN2dTZQdmNsUmxqQ01TSlVtNXRHQkJzUDhVMTBUalFh?=
 =?utf-8?B?Q1lBdW8xMnJLcDRMVDY4RE44cnJkb2wzSUFZNlc2ckNFVXRBTVlkWEdueTFs?=
 =?utf-8?B?TzJkUzdjYU0wUjI2V1E4Nmc1WkU2QXU0RW5SekVQRXB4azdiMElIVUJYL3Jh?=
 =?utf-8?B?MUtTSnBESXNnTnFPUlpnOTZMZms4ZmxhMEZGcE1VU0pITHAzNmd1YWhQbzJn?=
 =?utf-8?B?N3JieVNuR0tjUUsvUGlYMGtNWm1YbHBWeVE1QmFocktYaXlkS1hwZWpaS29F?=
 =?utf-8?B?MFpEOEp0TFhxMnhZdmVEYms2Vzhvb3lLaWtxa3MySXJESmQ0OXprN2lwZmJn?=
 =?utf-8?B?L2hjYU9oMDd1WWxNNTJ1ek9oekNycytZRjJtSE1IQWp2UEZvMS92eGQ3RXgw?=
 =?utf-8?B?Q0hRTjV1NUV1UmtMQndmY1VvbFgzbE1ZNTlyTlZWb2hUSzQ5TkZObTFGaUJK?=
 =?utf-8?B?MyszU2xPMk1VaDVLUEF5eC9xdmVlbjdMZHc4a2drZlQyK0lyU0RPQWVRUEYv?=
 =?utf-8?B?VGlmVFRmc0VwT1NBVGNWRFVaOURWR1ZNRm55ZytVcGwyblg3ZHgvOFNsVklQ?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b537cd2-ee4e-4abe-d729-08ddd3ea74fd
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 06:36:49.7090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS/9MKYRDNaOdrng97x49W4+KSKF9pIPpYABpLsXV/8SsRIUR8FW4wBO/KZG8ZKNcTpgfMzqYmeqdwSbQIlfbEHtKc1G+S/jEKqkgKdXLbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6102
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

Am 05.08.25 um 00:11 schrieb Mikhail Kshevetskiy:
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

There is some duplication in the subject line of this patch. Also it
should be "missing" not "missed".

The prefix in the subject line for this patch and all the other spinand
patches in this series should not contain "drivers:". And also "spinand"
is more common than "spi-nand", I guess. So the prefix should probably
be "mtd: spinand:".

For simple changes like this that are directly picked from Linux, can
you please try to pick the commits from the Linux tree as-is, meaning we
can preserve the authorship and you can add your SoB-tag for doing the port?

> ---
>  drivers/mtd/nand/spi/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index d8abd03e919..34e5ac33c63 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -1285,12 +1285,14 @@ static const struct spi_device_id spinand_ids[] = {
>  	{ .name = "spi-nand" },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(spi, spinand_ids);
>  
>  #ifdef CONFIG_OF
>  static const struct of_device_id spinand_of_ids[] = {
>  	{ .compatible = "spi-nand" },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, spinand_of_ids);
>  #endif
>  
>  static struct spi_mem_driver spinand_drv = {

