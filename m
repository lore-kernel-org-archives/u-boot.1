Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE4BC02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:41:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1869800B3;
	Tue,  4 Feb 2025 18:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UK+1fWpB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AFC0801DE; Tue,  4 Feb 2025 18:41:40 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F3C80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eB43/OW6tuQ1GySms15j2ih8egwl9bmzf3lDajxH1WjNXEnMwAzfupuaFs4mCrO7/WN9BqhvFng/jY9EIhSBK3b3NklvzQEfVtPtronVrGV4VjCWl3Gedp9A3AOxEEy/CryBByRNJL8bZzZFcZx9YAuwRyKIem6GZQTPwXd4rOMfAMWE+VsVjs3scbXvDlE+L5SNjDL+Y+YflJLTcus/h2DU/0KZh2opLHWIdlziOdPwK2vTcBeuGT6TGhk3PDeSCrGcD48FCbvlwnglWnr3+tAd7BZI9YRFUa375JFxsiKH5R1OYmkD8O7sZvonzOqkmQvO1lsSy4EEvJjbN2hHww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/vHrIsZ8Gzh8cz3bAH94CPRKAX7GPXyjGIzskhziqg=;
 b=HCk69yL1YrkBO5MsUZdSaSq3ieMtRTEOZoccHVZ2heQmTxHxRf/3Jpyv7LUxH8N68qG0jywD+sxrO3d0w+lYAfdMq1AG8wqugMOa8dWrQDdMO2lvPcY/1VqZBgid3Oz692IFpOw9US/0nZfYarCVKqVAGHuGWm/v8xx9BumBeWAoSW3k4utSB/uSceqTTTdUYBJGqFp8+C9kgHIadyS7Spn8MFM36m7JTEyHpcxrU7IIypGdOC/T/R8u7FRWovGIpG7aAmDocmRC2RlySUcIhdff4HMORYCR5ef/qiUWT+EMuLAlxBS76ztc5HlikX9j/mc9VUaxrLe+mfRMbWfJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/vHrIsZ8Gzh8cz3bAH94CPRKAX7GPXyjGIzskhziqg=;
 b=UK+1fWpBdxMRl95d9HYktp720Z0WXvPJOcdy01S7K5qffvcBuczKkcS1VLSEZKq4PF+jUgIA+8UOsX64GmEKReCxEH8GegYbllrs8k+T5IkteCDpa8GlFv1ci7W5YFPvHKUVyf1r5puOZz64W+Pwxy3AJrj4r4+aYd/hVioHhQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10796.eurprd04.prod.outlook.com (2603:10a6:102:48e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Tue, 4 Feb
 2025 17:41:36 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 17:41:36 +0000
Message-ID: <222e5d09-f18d-45c8-8d36-f6bfa00a34a7@cherry.de>
Date: Tue, 4 Feb 2025 18:41:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: io-domain: Enable by default for all supported
 SoCs
To: Chen-Yu Tsai <wens@kernel.org>, u-boot@lists.denx.de
Cc: Chen-Yu Tsai <wens@csie.org>, Akash Gajjar <gajjar04akash@gmail.com>,
 Alexandre Vicenzi <linux@alxd.me>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Deepak Das <deepakdas.linux@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 FUKAUMI Naoki <naoki@radxa.com>, Heiko Stuebner <heiko@sntech.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>,
 Levin Du <djw@t-chip.com.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Nick Xie <nick@khadas.com>,
 Paul Kocialkowski <paulk@sys-base.io>, Peter Robinson
 <pbrobinson@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Shantur Rathore <i@shantur.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Suniel Mahesh <sunil@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>, Tom Rini <trini@konsulko.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>, Xiaobo Tian <peterwillcn@gmail.com>
References: <20250204172319.3361870-1-wens@kernel.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250204172319.3361870-1-wens@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10796:EE_
X-MS-Office365-Filtering-Correlation-Id: 826d0142-57c8-4fe3-1602-08dd45432bf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MkdKUjhwbStab21qemlWWWd2N3VlT1ZHVWlaaVBaRmhBN1hMVTU4SGE1OEtn?=
 =?utf-8?B?eUltL1F0QmN0TVEzZSswTmxiTzNYR1c2V0FWTW9tekMxQ2xhMlJ3dUxwUEkx?=
 =?utf-8?B?SU9PbG1TaEpYaW41bk5IUnMzUDBqdkwvTTlKNzFRbTVYTFZDdHpBeVpvdnhi?=
 =?utf-8?B?aXNMenl0UEhIeFBKMHM4dWRFZGxOSE96ckpDaFpGckVEV3lHb2czMVFFTllT?=
 =?utf-8?B?TTFJL0RPTjQzZW12TEFWTXhBVlFwMnRjNEdma1o1bGZyMlR2Vmo5Yno0dW9q?=
 =?utf-8?B?a296eVJzK0NPMGd6UjRqRElvT0JhR0JvcDhoVXI1eVU2dzdyKzV5cWd3UlBp?=
 =?utf-8?B?UFkySVZ6ZFdHOFJYS3V5VUl1VzhSM1dWMExZN0diVTRYbVdjL1drTEsyK1Fa?=
 =?utf-8?B?MGZDeUZ3UzluYk5OL3dvWVFTMzhWSWRreHpFSE5kMmdxU2V2TnY3aHlJQjh2?=
 =?utf-8?B?WjBSc2FXekhyN0x6L1loUjVHcEFQNmpoUTBzVE13bkhqZ2VKVnZldEhVVC84?=
 =?utf-8?B?YkVMQlhDVVVtWjZGSzBldnUrUlpRMkF4blpVdzZ5aytvYU5qNTZQYUlUNDFX?=
 =?utf-8?B?UUYzNDdOdHBWVWxJbVhhdzJidGZoVXY3cFB3Tno2RVBJcmM0eXhwNFdxTFY3?=
 =?utf-8?B?SllabUFQZTlkRkRLZTZYTDNXOCtkM0xQMU9hSER3SjJyOUs2bXlmWjJuUXRa?=
 =?utf-8?B?RThUd3owcDhkQ3lIK2MyQ29pQUlzQ2Jwd0MzN080ekJKc0l2VzRiUmZGMmVq?=
 =?utf-8?B?R1JGdHZmRGIyZDNNK01jV2ZsZGRMeHVIbzJFWk5yQ0FYU2dJa05PN250M09q?=
 =?utf-8?B?M3NLZ1huYjFCZHpMYnR3Snl1ZVpiaGFwMG5JNlFwRTJLejh6M01vUmZpM2Jy?=
 =?utf-8?B?ZXdzOXNnM0FTdkgxWS96MmhOcWVKcnA3SWRUVmFsS25PV0orem1DR2p2MzdB?=
 =?utf-8?B?am1hNUVkaXQyRkxMY0k3ZE9JQzNtaVhGNmpiY2M0SStYRXFEMHd0OUdVSnU5?=
 =?utf-8?B?UmdjY0JYSGFqSmxsZ0VqYUFoVlM1VXlqR2c1eGIrTXc3RWFaRkcrRjF2Tms1?=
 =?utf-8?B?cy9kWjRIZDI1S0FDNG5MamtZeWZqcy9RZmtTekNucFY3YVNOWEJoMTBBNFBz?=
 =?utf-8?B?WmpESjltemhWNjdMNjZYR0l1MExyWXdKYnRxZzRNTkxabGRpYUdRTzBocUdj?=
 =?utf-8?B?VTN6RVBwWTZaU3JZRFJrMmZVeGRQOEtwc0UraVNwNlp3dUNFenh2TVFQTjF2?=
 =?utf-8?B?QXN3eWtkTndqdnBMQ2UycTZoSGxwMGord2FIcTAvYWU2MkJLZWoxTmpqVGNq?=
 =?utf-8?B?bUJMcU5leFg5YjI2K00vRWNwL2ZzT0VZTWM3QS9YOFVjWFUyTklMVFFZZExY?=
 =?utf-8?B?RVpJemRtOTRMbGZVSHVJTjRJUjdJVmd1bjQyTkdXSUN1UHdSaThLUk5WWkt4?=
 =?utf-8?B?elRCbWxVYk8rdkxMWUliZG94UUtNZFpCeUdHYnZoTWdWckV6bGdlTHZzU0M0?=
 =?utf-8?B?S0VyclNBTURKMFMyb01BTGRIVXB2K2dYTGhjUmk1bDVaenFaWDVkYTMrYllW?=
 =?utf-8?B?cXBlM3BkSkgvZmZDdjA1aTFLckloMU9uMDh5VGNoSHVpMU1iUi95ZjJ6NGFr?=
 =?utf-8?B?aURxcUdQa3F6WWlPeWorTHdzaFRVZlRNekJKYUwvWWZmcHFiS0NndDl2eFRu?=
 =?utf-8?B?U0JTMER2U2tEMERuYkxEVVRQejdmNm0wdG56TWVqOEFhM0ZDTnJ6ZUhxZWI2?=
 =?utf-8?B?SGpPYmpNVmlSeVl3bFRQc1VpSUJOVStkYmhqcnAyRlNTNnMxMS9BUWl2emlC?=
 =?utf-8?B?UnFXbzBXWEJKc0M1TGhpYXhpa1poQVJ3bHZWWStHMDZxN3BkSlhxYXN4Z2VH?=
 =?utf-8?Q?XfD8NMPNO/PAk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBiK1lNZi9wd090eEc1SjZKaDBMdjFlNHIrSXhuVlRXNTBoMnlCUldCK2Ex?=
 =?utf-8?B?UHEwN0FhUG5lclc1WUpXU3hsNzRCb04zeitCK3lzZVo4MTUvV0RQUU95N1dn?=
 =?utf-8?B?WTg5dEloT1RjVVEzSS9EM1lQOHFpR05OYTdra04rV2VNYjhsWXhSeGNoWlJH?=
 =?utf-8?B?NXJTVmcyMWFYYkMxS05zN0dtd3FrQ29oMUR5aFR2Ty85N0tmQkJhclg0dStY?=
 =?utf-8?B?aTVWblRnNENTd3hMaWxnYUNVaEtWS1F4K2hUTUk0TGJ3aWlwZ2t3S1laTjUv?=
 =?utf-8?B?eGhFQ1RCTXcrb3pwd0dBa09mQ0JBdUdZNXhtTUJiM05nTFowREdZRGs0ZXBT?=
 =?utf-8?B?bkZka252U2w3WlpzeTQyZURSN3ozcGxjaDZ6cGdmaFBTVkEwbG5CMjc1cFhk?=
 =?utf-8?B?bkI4b29iK05VUExQcjVpWUowd0FRWjZiRWJkNnZzRVBPSi9ZN2pMREJ4enhw?=
 =?utf-8?B?SUMvOHpET3c3NTlzdHQzN1Nxdi9QS1VzdkFjaXV1Q2RidmkzamtBVU1FNVB2?=
 =?utf-8?B?SWVJTmxKTDVXOW5rQXRiNlI0cnVtNUNtRU4xQ3F3QU1hWGZGK3pLcVExWHhs?=
 =?utf-8?B?dG5mY2JBNFFQZ1VuV01tZlBBZzA5R1dkUkpKSTBIeUxWdnJMZnVPNlNGS3dE?=
 =?utf-8?B?Wmp2YWlXQUxFWnhsS3FvYzBVS0pISUk0WUs4cHBOZUxReFo2MVVhczNnUUZj?=
 =?utf-8?B?VjhxSEoxZllaR0ZOVm9SU2hjbGJqdGZwWkdQcDUxdU53bS8wK3lkanlTUFNS?=
 =?utf-8?B?WkQrL3Y3bkVCMVdEMmdDTFFieDV5WjZ5NCtnSFZ5a2puZ1l3VHVTSFdSYVFQ?=
 =?utf-8?B?b0YwVkR2WU5hVEVUaHVDRDREaXhQN1B6UCsyNjh0VzZUYUc0dW42VGNzT2pm?=
 =?utf-8?B?TE9Kb1NtMVZEeXVPS2JiMzloWFVqT3czV21UbGduamNrZTNUeFpWL2NtSVpm?=
 =?utf-8?B?R25ON3FRUEp2T3R4aGc3b3BoSkhiTzNPQUN2L1Q5WEtJa1F6RDU1QWR1aW12?=
 =?utf-8?B?aGNRbWFFeUZxc3V3Wm94bjM3U0hRazVVU2N0Y0xQYThSYTc2ZHcvdmQ4U2o3?=
 =?utf-8?B?UXlDcy9BVkRqUmxQT2wwWlF6aEhaNmpmRWN0WncxZkxCbTFNU1FTcXYrTW9a?=
 =?utf-8?B?SDRDZVVxd2dxUC9DMy9sVjVaczlBUTkvYXVVMjJaK0VSZytHWnNKaUxtdG1i?=
 =?utf-8?B?WUNJYkd6SEI4R2pJbktjZEFzeFdLUVhhNlBQLzBkaUt2UFNRRDhpOFVuSFFX?=
 =?utf-8?B?R3pIZ25KRDZBWEthdzlkMkpDNXY2eXl4aGFDbER4Z1E0UG5CazBWRE1hWmJa?=
 =?utf-8?B?YUMzYlJVZWJxczQxYVdaOXFQa0xocDNXaDU3dzJEMHVwd2dpdzR4WjI3NG92?=
 =?utf-8?B?NnUyQUd5K3Bod2xHa0hyMlVWcWttOTkrd2xwYmtQMlcrQkRhN0U3VXZjY1pt?=
 =?utf-8?B?b2Jpb2luWDNYSnc3MjdTWXo2VWdoQVJoU28xSlE4YVJBRGY0eWFLUDlkWmhZ?=
 =?utf-8?B?U0ZKOGNSUU0ycFQwd0FBaDdhSEtkVktDUGV3WVRETFloUHo3YlJhVVhhUmxa?=
 =?utf-8?B?Y1VyQXJmRjQ1N3RtSjRKR2Fad2QyQnhtdENINHRjem15Y0JtVitpRFBKN2ky?=
 =?utf-8?B?eGs2akFPRTZFVTYrVlpHMFlLQXdXb0FPZ2pzekZGOTY2bWhxeFlrVndSbjFK?=
 =?utf-8?B?M25xb3BVZ2Flb0dtTGI2MDhOeUg4ZGxCQmVRRDZJTW8zOFo3VmxXcFdXM3JZ?=
 =?utf-8?B?UUE5NmxueFRGSzkwVTRtQTYrYjdyc1J0aGcvSXdVdG4vTTFDMFBCOTh3MkZM?=
 =?utf-8?B?a3AyQnFQZVZzeUIveityci95L3RWNVQ5SmRrZFdqUXdOb1pmOUJSTDdNWlNx?=
 =?utf-8?B?azhQc2pxeHVzZ0E5b3NGTFZMUmIrcWdVTkFtS2RQcDYvVlg5bThEMUxFYjNZ?=
 =?utf-8?B?bVFJWHZiaDZmNHdObHZZemZYbUU2NGwydTNNeU5hU1ZYYkNPcnI1eTBJdkov?=
 =?utf-8?B?R0hldlN6ZkJoUHppSFI1VVY0Rk5MdmYxL1RnZXZSaWFvcDg2cHZMNUFkaGZo?=
 =?utf-8?B?TU9HVm8rQ3NBdm1BazVVZ3ZCNkg4cElCMVdxNFhramYyN0U4bWZ1NmxFTUpN?=
 =?utf-8?B?MFgvVUxMSjRVQitOU29VZFE0ZVRZWEpYelk1YjU2ei9GdmUwZlVzL1ZPRjBL?=
 =?utf-8?B?b1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 826d0142-57c8-4fe3-1602-08dd45432bf6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 17:41:36.0958 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqEoeDgQLwqaKY3p94f7CtnqQ7p3IVZZf38/zhzXyJATRinfYt0sPikmm3vPxc6eNfq2Yl15iahImUZ2lFZWGAfa7YIi9yJQdlJMr2HA3hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10796
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

Hi Chen-Yu,

On 2/4/25 6:23 PM, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The IO domain driver controls the I/O voltage for various pins,
> MMC included.
> 
> Enable it by default for all supported Rockchip SoCs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
