Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D415C7EE33
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:19:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E529B803CC;
	Wed, 25 Jun 2025 15:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b3P4q+3/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22E3182CBC; Wed, 25 Jun 2025 15:19:26 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28AD38006D
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApnjFysCSyGYka8esNt+hVZ6lHIb7U8zPAZNaqbuzlXPW7jdah+nO25OlQtwmAId23UesTuWXZ2IWd2n010j027n/IRk8P7ZAJyYgqTIeo2CAXVAVeZvnWwFc47lnyYLQM5PMFqk7fUqwi6rPSwQSnQIivrmzJcFtTVy/UaTXJGOXqC8jByqqyECMxoQPUaK75CNvkuaKddYKDEaw0kJSIPT3kfkE5Nhe3W7Kwfkp5Hvt7ojSk9yNaAmKf0xf3OIoDyPDXLGzolQE+AJkbQF1QM0Cbaa4tg9Hct+neH0hUcwxl/QvB3AJZko38vxZHWrj/WYEK3XuriTkaiOofDdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKsUC35oG1kh2g+inZnDjABfmmk/42jBbjueKTBHcU4=;
 b=HvxdGrPOorEh8oLHUOxOCyF67gFhg+i5nUerozyrpvirXrmpOdO/VdFB/4SLlM8LlzO70d2gOC4zJs+emA3xzpxCRqonG/il1ci9q+ynO52R2rIG8oAiHTPsre2/dsr5+vdP5E/w2TKFMF286T3UHbSkuCsBrTwbHMpLZTpLutALLAb7mYLedcyirj0kLdNQuPQuFSkIK3g6h7OHG54Z//B/7DeO50h6INs0mTT6tdpj6tvx8slI6GfIl3AxbIBK3Ufd5cLfAgIZg+8QIa2cwgBjy/NnY9mpJWabIylsUwKYLL0uZgAKBxKwBLVAbDEP5a7cziB+YI7iKF/AjYRoGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKsUC35oG1kh2g+inZnDjABfmmk/42jBbjueKTBHcU4=;
 b=b3P4q+3/RUE/Ok6s0/SFzeaqbCO7E/Wci1P91+Ev/vtvlDZZL6GbOgEFujrXPw1KSbw4gRo1VhLmxiGI41RR/+xBroo2oUpmV354sQ+ttj4tgY7UTOW7UUf7k3iEdVIQByGZ+7xNms7AMUpMl1QPjQMsOcVYE4mI6JV0NESKgaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10953.eurprd04.prod.outlook.com (2603:10a6:800:271::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 13:19:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 13:19:17 +0000
Message-ID: <8420640a-d3c1-4d1b-b927-ff7021e6d93b@cherry.de>
Date: Wed, 25 Jun 2025 15:19:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE broken since commit
 2a00d73
To: =?UTF-8?Q?Thomas_Lorblanch=C3=A8s?= <zlika_ese@hotmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <DB7PR02MB3676199B1B33A23B5A3DEC33967BA@DB7PR02MB3676.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DB7PR02MB3676199B1B33A23B5A3DEC33967BA@DB7PR02MB3676.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0030.eurprd05.prod.outlook.com
 (2603:10a6:803:1::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10953:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1f98de-8340-40d6-79d2-08ddb3eae340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXBWU2NMb293ZytzNkJNdUxsTExIQ200L0VGenBKZUNBUlRBTThpdXZ3SURh?=
 =?utf-8?B?aWljM21aam5EWVNMMU5WOVA2NWRxWjliejUyNHByejFwU0QrOWdpS2t5aUFi?=
 =?utf-8?B?SnJ5QzlyYWU4b1VIcmpoOGpNTHdkcHJ1aEdkNStVb0hoWjlwN3NvbUczenhz?=
 =?utf-8?B?VDM5YVlaRUhKLzd4VEJwVTNiSDIwQmJRRmFjd3F6YmpRdURpRzhPZTRpTXZR?=
 =?utf-8?B?RDR4VE5xZmlDeE1vUDZIOXdvampXU3hBdmlGLzhWUXJHVUlXRmVUajk3M1Ji?=
 =?utf-8?B?eENxNnRsRzY4Ylk0TWdLYW5tU2tMVUxmUGNoVGIwS09ORHU0TDllTTlUNnpP?=
 =?utf-8?B?WW1uWm9qN1IyL2RMcytxZWZGZXNRMkRXR0hLRWEyVFJzL01WVmE5d0hwdklB?=
 =?utf-8?B?bWMrbWFUZWxROFE5M1BMZ2s1bGhibml0UlB6UUVCLzNEclBqSGxvUTMwVy9H?=
 =?utf-8?B?Y2dhdjJLYmVjV2FDbE11bWduODJvV3FMN2NGRVpVQVZDL0taZEYxNUZ4L29p?=
 =?utf-8?B?a014V2cyQTF6VW9vSE04SitGc0NGRkVLNTRHdExPRXBCM2FqaUZIUlRnQytS?=
 =?utf-8?B?TXdPS0tVUU1xSFFSa283ZmZCR1ZTOVdnQjRtU0lzb3prc3YrbHNHak5XbnFB?=
 =?utf-8?B?ZmpLQm92MzVnTG03K0NPZjJzUVJOZVF2ZEVoZVk5U0MzYlNuSVIvQ0NtQUxF?=
 =?utf-8?B?UmJoNnFvY29lYWVVT0hnaE9Wek9td1kyRkNaNlpZcE9GUzVFc09IYmg0Y2o4?=
 =?utf-8?B?a280YmhHcktuMmpZWFlkVVl5WHZzWEozbDN2Vm5PZmViZGxmZU9DWlBaT2JX?=
 =?utf-8?B?NnpCZy8zVFFuZUxuVWtkRUpINnVuT3N5UVEyQzNoQlJ3b0ZTRkF2RjdoQldO?=
 =?utf-8?B?bXZraDNoWTcyOERvQlRLd2lvU3hmNkliTFFkcXRZV3liUnQ5K2Nnc0ZWQ1ZS?=
 =?utf-8?B?c1ZVdGY2Z3cwSlBiUEZ4bDE4MXpSYkJsNFowc2dFcnE5aTJzWDhTeWQ0cjFo?=
 =?utf-8?B?UTZ3ZVV2ZVhsRjFUVXJQOGwwV2VVeGRadmhzOVFJRmc0NGllVW5ZWVFIQ0hh?=
 =?utf-8?B?Mk0yTjhvbnU4ejV3VXRUNElVMUd5NVUvZzI0RkVYQmhGNk56QWZ0ZERJR2pX?=
 =?utf-8?B?MjdUcGNvdk42S2gxRWNOd2VmMGRWK0ZBNExJdVVlUE9nSW9UUU5ham5WMm55?=
 =?utf-8?B?OEphbThzRk5uQWZjTXQ2azR4YTNmMmJieEdXWUlNcTJJYTY2ZjFPSW45NUYy?=
 =?utf-8?B?S0YvbG9FRG5QMUxFUXRQSXppK0hvRHkzNG5VbCswVlZyMldGWmV4R1J5eVBi?=
 =?utf-8?B?Qy8rUmYrdDRlNFNMR09hL2xHd2YyUE9Vdjk3emRuSXJOU211U1VFTmhRaExO?=
 =?utf-8?B?dzhmbFl0ejRpL2F5dFk3NGE0ajI4Q05mUGp5eDRMQlF0Qm0wRVdnbFdqVEhh?=
 =?utf-8?B?SXNVeXZhQlFlZ0l3dERqbmEzTDhTRW8zZmV2aXI3aXVYTlV5ZlNMMGtsbGpJ?=
 =?utf-8?B?M1JDNTE2WnZkdEJ2bU1NajU2b2ovNGtvYjJWYzNWTVNrU2RjdldCM2FWbnBK?=
 =?utf-8?B?YXdNZmRGNE4rY05aa2RBQWc3aEY3OE5zMGlyV1U3MzJ4b3JCYis5Z1RBMjAw?=
 =?utf-8?B?b2pDREhFOUNQUURsYTVLYWxQL2FublpyRm5XUjFTMGVZSlJ6T04zSmhNTVBP?=
 =?utf-8?B?QW9ZcUQ2bjhGK1lQY0VYTUxOU2g1dkNtN0p4UkJVYUNDWnp0ZkpYY0NxKzU5?=
 =?utf-8?B?SW4yVVZ1bmNJRFJ2VWxBc3hCRllsQnBoTjl6YTBXRVFqNWVjMzNMQ1psSXBM?=
 =?utf-8?B?UFhkWTM1MnhSQlZqV09wOHhXZC81Wk55YkFxRnhKaDRBa3RmU25lWkN2Q3dJ?=
 =?utf-8?B?RGE4TDV6SkZPaWxtZk9ZTkp1NzhLakhWZlAzaVl2b1J0KzQ3bHhXZW1uMURW?=
 =?utf-8?Q?hCpPvWzG3xw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjJZRlBsZnhGNFpqdE9vWXEwUVo2L0ZLSDNjdW4wVEk5SG9VVE04ZFRFdjFK?=
 =?utf-8?B?QkJGOFRHZHd2ZzhzZVRkbThTK3l5aUpseFFvTFpXdTh0bzRVUS90N2ZHTkti?=
 =?utf-8?B?UUMxNEQyNGZPeG1XNTNmVEk1QUVFODBzUDcxZ0E4ZkdRV0UrWVJQemhyRjRE?=
 =?utf-8?B?U25GZ2JrcnZENEFUVk9lTnlxK0tVcHJvc0NEdkJYbjI0bTdDblBtTWY2TDdI?=
 =?utf-8?B?Z0hBKzR3K3BYZGJza3FIR3cxZVJETlRzeERhSlNWTHM4L0ttT3hLbkV0Zjhu?=
 =?utf-8?B?andlL0xLcXZWNUNQTWRZSlZDWEpVNFAySldvYlBheElLUWp0OG9NN3hOdUJM?=
 =?utf-8?B?dGtiVEwrbU8yc0RqQ1RLN0hjTUJ4cFVpcW9qN3BJa0o4czBLRVZJZXJPM3dr?=
 =?utf-8?B?d0FWeTN0VEVSandjUGRaT0VjaGdXQUFUanhUdFB2Y09ha2JWM0pHSGJlYkY2?=
 =?utf-8?B?QTVzSDRhZFNqakpQek1hRXZ0RldWVUo1L0hqOVhtL0VVOUdTN1BBeklFNHRw?=
 =?utf-8?B?dDVMbzMwMzBnbCtnenJvYlpIa1hsWE5FZ3hLZ05PNytUYTdackhtREk4Q3JT?=
 =?utf-8?B?b0hWYi9aTmpwQk9HMVlUOThnTU40aUtFMGJJWnc0YzhqL04rYzRvaStCZHpW?=
 =?utf-8?B?Z05RTE1FZEROR0VRUnJoN0NGS1ZHODh2NE5vRXV0WGJhWGxzZ2NTMVZRRVVl?=
 =?utf-8?B?dXNlZWh5MDV5RUVyRzRMb3hRSFovV3JmOG9mckJoV1VmWEFBMkNmeVBPOUlx?=
 =?utf-8?B?MTY0RnUzbVdWZ2IxTis0SzdQbWxvdlE2azNsVU8wc09FaXlLaERUQ0hTRHRE?=
 =?utf-8?B?aFNqOVU4bVUvRVJ6ZkRYV3U2TVhaRmJqRHRmaWE2L2VxL1BNU0o3bk9PcGZ0?=
 =?utf-8?B?N1MxM3JFUWJCd3R5QXlXdVV5V0ozMlI0Sk84OWV1N2Y0dzc3WWtMSHJhdWk3?=
 =?utf-8?B?Z0NhaDdOcFVKNWEweUluV0tqWkMxa1FTdkYvV1licFpSTXRPY1cwcHFCL25a?=
 =?utf-8?B?ZDNyNzNURmFmV01JUlJlbzBnQ3VFNHIycjZHVDRKNmk5Zk1tdFd4WC9hbWJw?=
 =?utf-8?B?Y0FFaDAyUndzeU5vQmNtRkNsTmlFcXdWM2d2SUtJNGlKNmtaUXhpOHpIRjZQ?=
 =?utf-8?B?dkd1ZUZOdGhTaFEzZDdUR3JKY2M2WU9lNUEyY2ZwRGxvbzZwdmN2Tkx5QUh4?=
 =?utf-8?B?bFhVU3hmMUY4RlVWaXA4RVpHenVua2FWZDdmQ0tmZ3NxYWh3TzBJRzB1ZlA4?=
 =?utf-8?B?bVR6OGdrekFRbDEyR0ZhRTdxeURzTEgwdTVScFBSYlVTNXJBVUxKQWZuVG1T?=
 =?utf-8?B?MG43cUJlNUZzSEt1c1RhdWVxditDL2VJcitYQlJ5dlFsMHdDVGVRUGpyMExs?=
 =?utf-8?B?Q29aQk9lZGFCSGpJQXZldSswNFMwcWV2UnlKbm5hQkNjSEVrcVZKMldYdk5S?=
 =?utf-8?B?a3pFelVadE5DZ1dHdnRuQmJ6YjFvWUE5Sjh4RWd3dVIxOWgwc2JuTFJWMUps?=
 =?utf-8?B?emlLbExBdEU5Nk0wcUdDQ05qSGlBZ1NYV0JPTWRPWWJDb3Q3Wkcxd1Z2K0dU?=
 =?utf-8?B?a1ArR0dnREZ0eVBQN2hWV0Y3Wks5MjQ5ODMraXFRcVFONnZNdUdReUE0dHJi?=
 =?utf-8?B?bUcybTVRMnJsTlhqZXl3MUhXdEdXWGFPNkVOU0NyRm94ekxpaXJBYmR6SHYw?=
 =?utf-8?B?VXFiTWpKRFErVkdEMVJxNi9IMEJSY0hTMW9jTDlnQ0F0TUpmeEFQQW5KSEJH?=
 =?utf-8?B?SThpQ1FaQmgvY1QvNkxQQ1pEQTRSVHZ5TFd1S1ZXb0o2Y0dKVGx1MCs2UldL?=
 =?utf-8?B?YisxZitEUDNYZ2VOMWcyZHdzUldKYjduZ2V0Z3h4SGFWMFIxUHdkNnlUQUJq?=
 =?utf-8?B?V2V6SUQ1bXZqSkxyMnpGUVhNWFY1QzdvMWJlRnU5UkE2Q2tCc1IvNXBWR2sv?=
 =?utf-8?B?NU9JYTZaci9yeXRxdk1vVUxBaFRiemZOb0pMMURsYVN2SWZ1ZUZCNTRod0th?=
 =?utf-8?B?anNQZnREN0ZOdHQ0MFBNL25CZjZqTGlUZlhZOHVhV2xrTnEwM1BiOEI0SmZR?=
 =?utf-8?B?ZUkyQjhLcVJyOTlnQ1RqbG9MajZXc1JyNzdvOU9wWWtCTXZ6VmVSc3lxU3J5?=
 =?utf-8?B?OFd5RlZxSFRaOGIwSVJZeXM4WXU5S29OeHRjV3dDOC94bzZlZ25jR2h6MGVi?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1f98de-8340-40d6-79d2-08ddb3eae340
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 13:19:17.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtaaOeWkKQhRK6zSMpRKVuLCvupDD8lFZ+Ew8yc32J16GjmdKIPffCjVe9CEt/SfyDajRZytlzKce5ihUaaduoUTb9nxMgqB1qt5uys5Je8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10953
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

Hi Thomas,

On 6/25/25 2:44 PM, Thomas Lorblanchès wrote:
> [You don't often get email from zlika_ese@hotmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi all,
> There is a problem with commit 2a00d73 (spl: mmc: Try to clean up raw-mode options):
> now options SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION and SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE are mutually exclusive.
> However, SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE is only used in common/spl/spl_mmc.c inside
> a "#define SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION" block.
> So this 
commit breaks the option SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE.

Seems like you're right indeed.

I think we also have an issue with dead code in 
mmc_load_image_raw_partition() function where we have ifdefery around 
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR which cannot be set since 
it's another choice Kconfig in common with other 
SYS_MMCSD_RAW_MODE_U_BOOT_USE_* options.

To be honest, I'm not sure how to fix this appropriately. I'm also not 
sure the

#ifdef SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION

addition in arch/arm/mach-imx/imx8m/soc.c of the aforementioned commit 
is proper as it surrounds something that allows to get a sector, which 
isn't something you should be needing when using U_BOOT_USE_PARTITION?

I won't be available until 3rd week of July so cannot dig into that 
myself unfortunately. Would be nice if someone else (you?) could dig a 
bit and maybe even come up with a fix?

Cheers,
Quentin
