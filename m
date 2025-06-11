Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E54C678DC
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 13:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6C882B63;
	Wed, 11 Jun 2025 15:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NE0T266z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF5582B70; Wed, 11 Jun 2025 15:25:24 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C232882B20
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 15:25:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XreiGFt9Aw82FWo8Gc37TxSSvDDKc3CrOxgzALugVFcLyNTjat06i3Unqea5tNVc9tazdGvDt90jg7F0zIpejF2Larw+t8nX10HKchtLCgSM5Mpf6MSYb0R0KFDTzHduttIE3Eu5WcVZchIDOHL9T7yD+q/mDVqPo1KuXcR5FoRyBoT1wKxEcVPbXWA7IhbagucYfwXNkolH2z6FKJ9dTqGLibTbnQmY9ueDQar9Fw+DDgPa6SMTxMGKqd04lj1ZuQ2PqZYLOS9h1Fd6QrfHzSGslF3puizFoYvdkyfZLVPm6DwzHSdGd/cpUXoEhCd20Unw3vXOUeA8tSOqh0HjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SBxJBHPhNAGuLYYfuSKVlOCekXcjqC8MAKiwXSkbeY=;
 b=A7ZOkVnCEdEiHxrV8Ln24uxatf+wde+kluAHzKXJwTjuyiAyZ0vlYEq7HeSQU4yt0a/7Ik4PZNs8HB5TcMwzmU46dVEjABeRpZGF2GGqXZT9OyBFEYQ42I9ueYJ9CoKUMeMfRirYfeCkZVSANcGLLM7nyRyDzrQfEO9ldQndlDBALgieZwLz5blDo7a2EuZfB//5OAlQStW67orkewV7ZQZQ/1agq2sP8eZj4S6HCM5WDOy9TG6nOLivSJGbyhJ0KouZ21CD1M6f7p4DtXs6hYJvBLCMnwC+TaIYaUPm09ze6fx026unfiZGzm/GmHF+6CZNrm8J65GxtFd9ZyTDQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SBxJBHPhNAGuLYYfuSKVlOCekXcjqC8MAKiwXSkbeY=;
 b=NE0T266zUSXDAgK1Bo1dlFaJkr++jyJc1wO21Vipp8aSA9B8KDjgcyLRFwYW/WXvr+4TxcmlrT6WOpgkuWLl9hp6bmUqrHoiALJcgfpGIo/IJgWvM/rLGOZKEdnmOvjiRPCYBUMtfqxMA7vR08keOkB3edDZo5KfHurUMpmgYug=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7524.eurprd04.prod.outlook.com (2603:10a6:20b:286::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Wed, 11 Jun
 2025 13:25:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8835.018; Wed, 11 Jun 2025
 13:25:19 +0000
Message-ID: <022e0516-137f-4a2c-8a92-c3da1a705e85@cherry.de>
Date: Wed, 11 Jun 2025 15:25:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] Support stm32h747-discovery board
To: Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Dillon Min <dillon.minfei@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, uboot-stm32@st-md-mailman.stormreply.com
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
 <dc8bb4a3-c465-4ae0-a61d-bb2f74a42b64@foss.st.com>
 <aEbgxo0WUDPd-S8Z@sumit-X1>
 <CABGWkvox-1a1VSGjX8toQ=WsVTma0JcL8su=MGWaAwq4UZFkrQ@mail.gmail.com>
 <aEcAe80kh66cf0_c@sumit-X1> <20250609155019.GR1382132@bill-the-cat>
 <aEcGzCbZXajCthrh@sumit-X1> <20250609162239.GT1382132@bill-the-cat>
 <aEfyYd64P7txX7vS@sumit-X1> <20250610160454.GE1382132@bill-the-cat>
 <aElxoV5qvC-R0t3D@sumit-X1>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aElxoV5qvC-R0t3D@sumit-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc584ec-3f0e-4ca2-1c98-08dda8eb6944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUdTUGhjWnQvY0JCazNjL0pNK2N1azM5MlJuRmx0SjA0UWZsY2JHbFVXUFJ1?=
 =?utf-8?B?bytldGlKSStLb3hqRVQ4bjlheGtFUEw0TmlYOUx5akoyMSt5U1phWmdlQWJz?=
 =?utf-8?B?dmtvUWNMVW1oWmF4ZGRLMXRzTUltdmh2NUNCQjBNK2pmK1o2QVFHVWdQekNQ?=
 =?utf-8?B?S3VVbFBGS3A4VVNOTk5NM3pSRThzdnhKNUtIMWZjSmxFWnVQcFo4bVNIRW11?=
 =?utf-8?B?Vmx1RWwycXBpR0Y0N045ejdqN3N5V2xaVWxPNFhHWDZxeHY4ZGRhNVVLRDVt?=
 =?utf-8?B?Q0VvUVQxYkdlWnZ6MmpGQXREeC9tMWtIMmJURWhvMmVmOWZIQmorOHpNUFJz?=
 =?utf-8?B?cEtVYnQ0enNPdmdicXpiaGVGcFFrZUFveTEyaU5ac3RrNEU5VlU5NzVoTGtW?=
 =?utf-8?B?c3ZUcCs2M3VZVXZsM0tjb0ZQcXBheWVDQVBZc1hzd2tZa016aHlZTGdXOW43?=
 =?utf-8?B?VFROdm81aDdjSG9aRU9MRUFYZlYzTUFXd2JGbEZWZTE1NndLQ0dUbnZKc08z?=
 =?utf-8?B?cTRYMWJhMG9IaS9vNnVmQi9jUkxjYmJRTFF1N2VZSVVkbGE0cDA1MXNPcnBL?=
 =?utf-8?B?ZmtpYXNqQVBJMjRCWkE1QzNWeGdqbDQ2Q2dMSW1OdngrK0IxWDhYMUFWdExv?=
 =?utf-8?B?TER4bG1Ic2ZxRVNsRDBTaEJZZnBlY1ZQRkZUeDZKdGJaY0J1RXMwa09KNVpF?=
 =?utf-8?B?aHlHRE1ad1Iwd0lMTzhJMzZxZEY5dnplZ1ZuS1c2MHNTK2xJL05KSHExZjBT?=
 =?utf-8?B?K1J5MnEyZzVaMVNjY0VxWWpLYUR2U0lBS1VGWnVKWndGblVvV2hDOVBYSjBZ?=
 =?utf-8?B?YmMrb2lISXo1aTVDRGRLOW1KTVBFVERGRnJ6MEZWck80L09aendZRUtzaXJB?=
 =?utf-8?B?UDhSSzFDU0xWeUhQQis4R0ljU1ZxbERnT3JmU05tYnZrUWV2ZTFoZHpTSGgx?=
 =?utf-8?B?TU1CckZtR1lMTXVVdW9LMVh6elNtU0pETk83emZGUlhrM0gvZTFSbWRPUG50?=
 =?utf-8?B?Qld5eGUzbHFNNWFIQWtHWTFycWt1OWRDQVQ4Y3NCUjduaGI3MmFjc1g5Mnpm?=
 =?utf-8?B?WUlvZjVtK2VCUFNRdWZPRW1UVDUySnJyQ2JrWnRwWW84T2tXUENENlpJNGlC?=
 =?utf-8?B?Nk5FeUNUUmtFVlE3bzVBcGRjWmRNTTFUbzVFdkZiMnM0cnptaElpR2V2ckh3?=
 =?utf-8?B?ZVZuU2phWFRLcnpOWGhCcGNXL3VRanhkMURUSXIrdU1EK2xaeXYxRXhRTFJU?=
 =?utf-8?B?cHhPQXBxZTRoOGxXOThvV0NOYXltYnR6ZnF0N2ZtSlZZWVRDbDBTY3VlMVJy?=
 =?utf-8?B?OHkrNndLbmd3RURUR2cybi9Vd2J0emFsWFp0U0ExQk50NkNLc0Ftc2t6RlJt?=
 =?utf-8?B?OHE3MU80TDNkYnFHWmNWbUpoVFRRU3VrbU1OTXlEbU5haHVqT004SGdJTGhZ?=
 =?utf-8?B?NFJlbitEeVNuazZ6aUx0N2lwbld1NXFKb2srU245THArbUlCNnUzRzJqb3lH?=
 =?utf-8?B?WFIxcXBtVXBzYUxiektsQXZmdjFXeXkzbThaWFF1TFgxQkRvTVdHWWlSdTA2?=
 =?utf-8?B?VEZCTDIvaWhlU2lOd3FpbnVILzlvT0orTUlZZEV0SnN2cU1TR2tmbU5GV3Rz?=
 =?utf-8?B?dkpMOXNmcXM5UUdrYjNDZ1dFcE5xbWg1WXNrQlJ3djB1V0NTQXV0ZU9YRGNP?=
 =?utf-8?B?LytWYm1qQ04xVzZaL1lmNC9DSjdJR0RUOWJOdWJ4NGlTeE9PTk9wNnVrRUVu?=
 =?utf-8?B?dkRXS05PRlFRb25lUy9MVkpieFd6dnhXL1lCMmU3T0xuMlZkUE5yL29rMFpl?=
 =?utf-8?Q?R31fjvr4AGCq6toL1ziDRUGEIWzUnhmJX6NdQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktrcUwraStVUitVRHVyRTN1clVBbTVwS1FrNkcyWEROekFmL2oyR3RRUlcy?=
 =?utf-8?B?ZHhqa1FXbDdIbFlkZFpzVU5sYnB5cThCL3ZqQUY4dXRKMTBnZTNTYWVjOWtB?=
 =?utf-8?B?WThZaWN3cDJCNDZ4YUxoT0hNNkJ1cE5nZGlqQytwTUl1cnVRdlQzOE5CczMx?=
 =?utf-8?B?RHVvaThUcW5LRGJnaUs2Mjl2bllxV0M0ekttM1ZQZXJjZkVJYnorQlVpVmhk?=
 =?utf-8?B?QzhkdFpIbmdBd0NWNXNEMmFYLzFMZWYveUFjNWg4aWtTVTVZVkY0R2JEdzRW?=
 =?utf-8?B?ZHdXdTBQenY3YUVjZmdBWFppdkdWQVo5aWZzSWNOY2sweFFwYTZzYWR1QytN?=
 =?utf-8?B?Wi9LV0wrMXJhS0Z6VUExWlI0N1ZFaTJJc3RJNzJyWkVpbEUrWmNsY21MaFZm?=
 =?utf-8?B?a21iRDBvNnhZUDNaVmxQaEJQQkd0eUJSTWtJSEF1U1FXYjIxQ2x6VW9EL3lu?=
 =?utf-8?B?U2lCVFJuc0hMQ1BBc0IzbnVOV3lHc2xBK3dOTlJHVlBCRjY0RFV2WENlbW9x?=
 =?utf-8?B?Z2RQbDY5Y0NtUXJMUUlDQnUvVzRBVTlLY3FYaktTMDFKUU11VUxqUXV3UThT?=
 =?utf-8?B?dSs2Z2hJeXNobDN5QzJ1YTJsZ0o0NG44WnJIcUs4a2Z3QkV2UW9WR1k0T0lT?=
 =?utf-8?B?TFlhU0k2NnFpY0gxN1piNFYwZnBhMG5SWjZFVk1XMXBoS0V2UzlibldMdlhJ?=
 =?utf-8?B?MTViaXFBeHJEeFY4UzE1d0FyV1h3OEpkZHdINlNYNXlzYXRZNENrTllBWDd5?=
 =?utf-8?B?dld3OFpwVzVrYlBFQlFxblJuSy9Qb2FlTlZ4dkJETlFaNHdEMXZQMWVtRS9B?=
 =?utf-8?B?YkQ5elVLdTFhNGZHZkFSSEhOb0JtcTRENkJEUnlNRTh0d25DeVdxYlJjTDk5?=
 =?utf-8?B?NVhWN2pIMmRlcXl0d0dHendSd0JoaTFhS1R5cnNweTFEcXpEeE51LzB4UHFr?=
 =?utf-8?B?VVZCelR3Vmx3NUVXL3BWaS8zK28yOWFmc2dFUThBeEdvbjhzaGlWOThnMHgr?=
 =?utf-8?B?dHErK3AvbHpURmt3SXM0Y1BGVW5OYUIxWVRQNXBJcFVoUkc0bUovZzNFeEla?=
 =?utf-8?B?NUVYZ3NCRk9RTnp3UUpLTGwyQm1QVVRaNjZ1dlh3M3UrTWU1N0k1aTdBL0Rn?=
 =?utf-8?B?NXVKUG9oQW5lek1wNEI1ajVkK3kxQUJZSFd3N1pGOWJYeUNBbmk5Wk9HcWVD?=
 =?utf-8?B?ZkF3UG9WbjRSSkVRRWh2d0VaUzkxa09hZzZvK2VIVU9kRnNMUlN0ckg1R3Vn?=
 =?utf-8?B?czBnMmR6TG03a0ZHTVMwcURKZGEzUko1bDM3bk9nSHdBRXNjZ3VabnVDOU1M?=
 =?utf-8?B?VzRTc1VmT0h3WXNjMUhTSjZUVlNsUlR3TCtlZWZmZUNlMk9TcDYwQk5HZ0Y4?=
 =?utf-8?B?T0RLV2E4d21zUHlYaS8yYUR1Z1hpam9NMUlNUnhVTkg4UXYzNFMrdVN5VDF6?=
 =?utf-8?B?NW4yWVVHRkZ0TUlibnp4elNETk5vaXVRVVUzQlBac05lclRJcjFrcXBFUy9T?=
 =?utf-8?B?NHl4am15U0IxMnNXS2lCTTJ4anViWWsyT0MxaFFnc3ZaeGJLTlYzMlorR2hq?=
 =?utf-8?B?YmZFSG5SUWNZeU5jYlVKdE16WmFrRkQySzZlRHBVcGN4OThwK1pscXlRKzVu?=
 =?utf-8?B?MWRGTUtMT09mbm01eEpNeFM1cW5PY0c0cWQxT0IrN1ptRU4wSVhsU0ZSNDRo?=
 =?utf-8?B?SlM0U2VKOFJIK2I1dzBYdUlzMEtWMnhNNWRxbUFLVDJlOXdYZjAxZldXa0gw?=
 =?utf-8?B?dW1YY2gzQlZEZHRNMU1uOFcveFlNQ251NXl1ZTZsMVMzam04TnNQOGxNWG9P?=
 =?utf-8?B?UlZsOFJhZHFnOGNBQldKZXpFd0NRanBZQS9BUXA2ZXI2WVZ2Z05iZUR0SkI3?=
 =?utf-8?B?VlREYnBJakY2OU9KUVBNRy9PZTR3TkdLMHZwWGJSWTE4RWpOaU8rc1JoSDRa?=
 =?utf-8?B?ekpyTytZMjJPV0p6emRpM3ZaT3llQ3JqdnBSbCtIOTJpNmZZQUVUSmpncXRp?=
 =?utf-8?B?SENKYlozODNwQnhYRWZIaVZ3cnJoeW0xNUxyOXhtT2ljZ3BSV0hMb3o1Z1Z2?=
 =?utf-8?B?U2hRNEJIc3NSbUMybVJmNHVZdzZGd09wMFhvZ0NGUFpSQWxQU1pxVkgyODVq?=
 =?utf-8?B?WnNoUXdCSlRFbmdXbjZjVG81UE00aW9PWVd0amJ3NmpWa1RTelFnSXZ4RFNH?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc584ec-3f0e-4ca2-1c98-08dda8eb6944
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 13:25:19.8522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7vYtWeuqNS25qClYeaexXfSHVCz3pVUUTbGLOS4at+ZVG5eel4uQZvj2sAmbgYXuXg6HBYfaggf7F3apwDys0riAWNlX5wIGRLoVb2RLnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7524
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

Hi all,

On 6/11/25 2:08 PM, Sumit Garg wrote:
> On Tue, Jun 10, 2025 at 10:04:54AM -0600, Tom Rini wrote:
>> On Tue, Jun 10, 2025 at 02:22:49PM +0530, Sumit Garg wrote:
>>> On Mon, Jun 09, 2025 at 10:22:39AM -0600, Tom Rini wrote:
>>>> On Mon, Jun 09, 2025 at 05:07:40PM +0100, Sumit Garg wrote:
>>>>> On Mon, Jun 09, 2025 at 09:50:19AM -0600, Tom Rini wrote:
>>>>>> On Mon, Jun 09, 2025 at 04:40:43PM +0100, Sumit Garg wrote:
>>>>>>> On Mon, Jun 09, 2025 at 03:46:27PM +0200, Dario Binacchi wrote:
>>>>>>>> Hi Sumit,
>>>>>>>>
>>>>>>>> On Mon, Jun 9, 2025 at 3:25 PM Sumit Garg <sumit.garg@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>> Hi Patrice,
>>>>>>>>>
>>>>>>>>> On Mon, Jun 09, 2025 at 03:15:14PM +0200, Patrice CHOTARD wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 6/7/25 11:37, Dario Binacchi wrote:
>>>>>>>>>>> The series adds support for stm32h747-discovery board.
>>>>>>>>>>>
>>>>>>>>>>> Detailed information can be found at:
>>>>>>>>>>> https://www.st.com/en/evaluation-tools/stm32h747i-disco.html
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Dario Binacchi (9):
>>>>>>>>>>>    ARM: dts: stm32h7-pinctrl: add _a suffix to u[s]art_pins phandles
>>>>>>>>>>>    dt-bindings: arm: stm32: add compatible for stm32h747i-disco board
>>>>>>>>>>>    dt-bindings: clock: stm32h7: rename USART{7,8}_CK to UART{7,8}_CK
>>>>>>>>>>>    ARM: dts: stm32: add uart8 node for stm32h743 MCU
>>>>>>>>>>>    ARM: dts: stm32: add pin map for UART8 controller on stm32h743
>>>>>>>>>>>    ARM: dts: stm32: add an extra pin map for USART1 on stm32h743
>>>>>>>>>>>    ARM: dts: stm32: support STM32h747i-disco board
>>>>>>>>>>>    ARM: dts: stm32: add stm32h747i-disco-u-boot DTS file
>>>>>>>>>>>    board: stm32: add stm32h747-discovery board support
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi Dario
>>>>>>>>>>
>>>>>>>>>> For the whole series
>>>>>>>>>> Applied to u-boot-stm32/next
>>>>>>>>>
>>>>>>>>> Please give some time for other maintainers to review this patch-set.
>>>>>>>>> The dts/upstream patches in this series aren't clean cherry pick from
>>>>>>>>> upstream.
>>>>>>>>
>>>>>>>> All the commits are already in the mainline Linux kernel, specifically
>>>>>>>> in v6.16-rc1.
>>>>>>>> If you're referring to the fact that the patches can't be applied
>>>>>>>> cleanly, I believe it's
>>>>>>>> because the target path in the Linux kernel doesn't match the one in U-Boot.
>>>>>>>> In fact, the DTS files are located in two different relative paths.
>>>>>>>
>>>>>>> That's exactly why we have (refer here [1]):
>>>>>>>
>>>>>>> ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
>>>>>>>
>>>>>>> You should have waited v6.16-rc1 tag to be synced into
>>>>>>> devicetree-rebasing [2] for the cherry-picks to work. This way of
>>>>>>> manually patching dts/upstream is not allowed since it is going to break
>>>>>>> DT syncs in one way or another.
>>>>>>>
>>>>>>> So I would suggest you to wait for v6.16-rc1 to land in DT rebasing tree
>>>>>>> and then send v2 with proper cherry picked patches.
>>>>>>>
>>>>>>> [1] https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing
>>>>>>> [2] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git
>>>>>>
>>>>>> To be honest, I don't think this is a big deal. Git will be merging
>>>>>> based on content and not specific hashes. And in the case of conflicts I
>>>>>> just copy the file from the tag to our tree.
>>>>>
>>>>> The essential problem here to me is we are going to allow manual
>>>>> patching of dts/upstream tree given this example? How do we keep track
>>>>> if all that manual patching landed in Linux DT mainline? The cherry
>>>>> picks ensured that we always keep in sync with mainline.
>>>>>
>>>>> Lets take an example what if Git automatically resolved a merge conflict
>>>>> for you with duplicated content or if manually patching a DTS file
>>>>> diverged from upstream and get unnoticed during DT syncs?
>>>>>
>>>>> IMHO, we should try to avoid manual patching of DT subtree otherwise it
>>>>> is hard to set a policy as to what level of manual patching is allowed
>>>>> or not.
>>>>
>>>> Part of the problem here is that from the standpoint of applying posted
>>>> patches there's no functional difference between what Dario did here and
>>>> what could be done once v6.16-rc1-dts is tagged (if it's not already).
>>>> It's essentially a "manual patch" either way.
>>>
>>> Nope, there is a difference here. The cherry-pick from DT rebasing
>>> allows the custodian to rather just cherry pick corresponding DT patches
>>> rather than applying patches posted on mailing list. I usually do that
>>> when reviewing dts/upstream patches if they can be cherry-picked cleanly
>>> or not. So there won't be manual patching in that process.
>>>
>>> ./tools/update-subtree.sh pick dts <commit-id-to-be-picked>
>>
>> Alright. I hadn't foreseen anyone doing that rather than "b4 {am,shazam}
>> msg-id" to grab the series.
> 
> Maybe we need to have some custodian specific docs listing best
> practices.
> 

Or extend

https://docs.u-boot.org/en/latest/develop/devicetree/control.html#where-do-i-get-a-devicetree-file-for-my-board
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing

?

>>
>>>> We make it clear that
>>>> dts/upstream/ *only* gets changes that are in Linus' tree. If someone
>>>> tries to be sneaky and push something in that's not quite what's
>>>> upstream, it will get stomped on later and there's not going to be any
>>>> sympathy for the now broken platform.
>>>
>>> For us the upstream sync path is via DT rebasing tree only. It usually
>>> lags behind Linus' tree by maximum 1 week candence what I have noticed.
>>>
>>>>
>>>> Yes, we document saying to use the cherry-pick script, and that's what
>>>> people should do in general. But I don't think there's value in adding a
>>>> further delay between "in Linus' tree" and "in devicetree-rebasing". In
>>>> the linux kernel, there's thousands of people working on things and so
>>>> strict rules can be understandable (someone will be running a bot to
>>>> look for "(cherry pick from commit $hash)" and fail things where $hash
>>>> doesn't exist, makes sense). Here if the ST custodians are happy just
>>>> verifying the kernel commit, OK, that's fine. Or if they want to wait,
>>>> that's fine too. We can be a little relaxed and let custodians do what
>>>> they see as best.
>>>
>>> The reason we adopted OF_UPSTREAM was just to get rid of the manual DT
>>> patching and the syncs. So is it really that few days lag of DT rebasing
>>> tree which is again pushing us towards manual DT patching? I am just
>>> trying to understand the shortcomings that DT rebasing tree puts in
>>> front of us.
>>
>> It's mainly that I want to be flexible. So long as we don't violate the
>> content rules (Linus' tree *only*) I don't want to hinder the people
>> eager to now upstream U-Boot support for purely process reasons
> 
> This flexibility has a cost associated to it which I hopefully was able
> to clarify above. But finally it's your decision which prevails.
> 
> BTW, DT rebasing has already got the v6.16-rc1 tag, so it was really
> just 3 days gap. Quentin (CCed) has already done some proper cherry
> picking from there [1].
> 

Not sure why I was summoned here but I can give my (maybe undesired) 2 
cents :)

I (a contributor) **really** do not want to have hand-crafted patches in 
dts/upstream. Use tools/update-subtree.sh for patches in that tree. Only 
Tom is allowed to use pull because it's a mess to send a patch for it 
and he usually announces he's doing it and then pushes to the next 
branch directly, contributors can use pick instead. If a pick fails, 
backport everything needed for it to apply cleanly. Yes, this may be 
tedious. Make sure you do not break any other board as well.

I was already surprised we have U-Boot specific files in dts/upstream 
(e.g. Makefiles :) ).

1) Doing it manually doesn't enforce the addition of the commit hash 
used for the backport/cherry-pick in the commit log, which may be 
problematic (how to quickly check that the patch contains what it should 
contain and not more, or less?). How to verify it actually was merged? 
In that state and not after other changes? Let's imagine an upstream 
patch that changes the SoC.dtsi and associated boards dts, if 
backporting manually one could be tempted to skip a conflicting board 
dts (because another commit needs to be picked before for it to apply 
cleanly). Also, until it's merged in master (which can take a long time 
depending where you are in the release cycle) there's no guarantee the 
patch is actually going to make it as is to the tree (it isn't unheard 
of to have reverts or even rebases in maintainer trees before sending a 
merge request to Linus).

2) If there are manual changes made to the patch that aren't upstreamed 
in the kernel (or dependencies (git context) are missing), if we diverge 
too much from upstream, Tom will have git conflicts when pulling new 
versions. How to resolve those conflicts will be interesting.

3) Worse, if there are non-upstreamed changes that aren't inducing any 
git conflict (via git context for example), then the merge/pull may not 
say anything about it and we'll carry non-upstream patches in dts/upstream.

Maybe we should not even do a subtree pull/merge but erase everything 
and reimport everything every time we bump, to make sure 2 or 3) cannot 
happen?

For what it's worth, I've caught some (Rockchip) contributors sending 
patches to dts/upstream that weren't even sent to the kernel mailing 
list. That wasn't done on purpose but there are probably a few patches 
already that went through the cracks. I am not sure how we could enforce 
that (which needs to be done with maintainer tools as there are already 
too many ways to contribute to U-boot (patman, git-send-email, b4, 
etc...)) or even if we want to. But making dts/upstream the new 
arch/arm/dts/ (for ARM) directory doesn't make much sense to me.

If you cannot wait for devicetree-rebasing to receive the new tag, do 
the changes in -u-boot.dtsi and revert the changes once we update 
dts/upstream to a newer tag (or cherry-pick once available)?

v6.16-rc1 took a bit longer this time to reach devicetree-rebasing I 
think, but it landed this morning (UTC) so it isn't THAT long compared 
to the push in master. We could ask devicetree-rebasing people to push 
the master branch more often to avoid the up-to 2-week delay between 
v6.15 and v6.16-rc1 for example.

I have read nothing in this thread so this is absolutely not a jab at 
some contributor or maintainer in this series.

On a side-note, I think we should add -s to tools/update-subtree.sh's 
git cherry-pick call to know who contributed the change to U-Boot (as 
the commit author will be the same as in the kernel as far as I remember).

To be fair, the whole process is a bit constraining, especially for new 
boards. You may have to wait up to ~2 months (a full kernel release 
cycle) to see a tag with the device tree for your board, and only then 
can you support the board in U-Boot with OF_UPSTREAM. In Rockchip we 
typically force OF_UPSTREAM for new boards, but we also typically do not 
accept hand-crafted git commits to dts/upstream. I don't know if it's 
deterring contributors but we are still getting some contributions here 
and there. Not sure how we should be handling that :/

> [1] https://patchwork.ozlabs.org/project/uboot/list/?series=460450
> 
>> (which
>> happens, E Shattow on IRC was asking how to at least locally point
>> dts/upstream at something else, at least for local testing).
>>
> 
> I would love to hear problems from people if that's for downstream
> development too.
> 

We can add things in 
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#where-do-i-get-a-devicetree-file-for-my-board 
and 
https://docs.u-boot.org/en/latest/develop/devicetree/control.html#resyncing-with-devicetree-rebasing 
to be clearer on the limitations. Though til we enforce a check, this is 
just information.

Cheers,
Quentin
