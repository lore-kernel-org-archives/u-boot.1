Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854FFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 15:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F398584374;
	Mon,  4 May 2026 17:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mh7xrrwY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44FDE845E3; Mon,  4 May 2026 17:18:33 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1F0980F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 17:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E3pMo4RUj+cGni0WGAvvHuNn8/T044vS1RCP9VRGdvDyhrtGnyngDwKWwRULfWUAnwREtJ8fTIedv9XzF2LapDi+aWIj2KkX+1U8AdfOeYCtOF1g8eDhoamCspbNT4b0xqzYkf5ctI8rpsqXE/aWdxUFrsWEQv71HVWiIkWWiaqj4SJe3pZXI+O5XMefhQYJGmS8Yvv5OrXy8I+zn3zKAxlei71tcE0ZTlvk+JVanuzHFnHpXh+S204QSIZHK+2xqvLqd7JEqhEDi8eERfG5HnXqzZph4yDx+IEXiikD+oHcxSc9CvE85e5h3InH8zpzgt3vLExiV1efgDluDc23Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2KfbATFtOIj9mP37QHBOG+uM3XttT9xDK/0qbNHjiA=;
 b=i+Lu3UES9UUYrYkTO5QlkNCpJjMX1cXIclW4LHnJF3SJIvvFEM7H+8NXdTCoyFO6bVFjWARHeOo3Lw+SqyIVSZApepYtpcNMk7CSCu2U8GP6goe+Iyb90fUDHXbEmHFwu+Fu1fPND4N/a71PbilH9wjZ2R4G0FesvCaEOMF1mNzQWgBUJobelfBO+kImoAcPejLKLCTR8GiMkNZl41r0KkzjNiv7qy+BWp4aCnNE1suqVCbqqSa1g0Ua5aiPNYd2aTLWsGFtv7Z69HWdO5Ps1+oXXxUHGk/PB9EhgarUf+yzj4wdXtk+UzE7gotT/jKvAKMYDKqoG/eSti+j/iFI4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2KfbATFtOIj9mP37QHBOG+uM3XttT9xDK/0qbNHjiA=;
 b=mh7xrrwY2NEzlUgFukAh8nkbFjs6q3F0QUXI5eZZ0zraOB1Wvj1BCBkxMJm78K+gX8u4u6kCuL3Ly2jR826H1I3lG/8yT9NcUDB0bnZiEM/pmP1H17NF/4M6AtUgJx0tnIQdKRNfiHBoi8sM0QqUuH/tkk7gsAxtmiDNh+na5Po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM9PR04MB9013.eurprd04.prod.outlook.com (2603:10a6:20b:409::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:18:28 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:18:28 +0000
Message-ID: <00d74d79-4188-4500-bddd-9030812ed45d@cherry.de>
Date: Mon, 4 May 2026 17:18:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] .mailmap: Update my email address
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20260504145820.1727552-1-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260504145820.1727552-1-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::6) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM9PR04MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 171d8713-a478-4b26-6a5c-08dea9f064f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: d4MWoGQEaoa4MMw2cyIjjoI4m3i4Z+KSKJNRgk/J3YZHpbDw6dZRjg2zGBYd3zy2N5KtzD+Qa8HV760BtEGNhA0JIlSnuKL7iyXLUMat9d1VMavY8o7PKQzXIMad6dgpcKMT3rRXAibdnDwTRZC0TpAWHHNgFKZaBQYlwL03uX82IzMW40IX5c2rjsphgVAhDHVkpTgha7+7xMBrTiyGA9pFWalvAtSX+kiL31o8vfxOv6EQwi0i9pLI06HwNLJYmToBUmfaCxbsxr0x9CVcZHccC1aIwpu+taOtGcfTvXJ55HDZy8Tnw8vkedhkBR0kanw+eiMNa31Lx6L08UPsMLTJ9qymwC32ui55bzNc/PxwlzMisQg8JTX3BUZIhnzl1QBzKVBcg1KA2ypWFfut2j4zOCGZyAFJ/PWU0uftJpuK2iXw5470a3KrVGkqb+qQ7M4r/MEFmO3R2oaLZjXIUsDPXUpuPOl56EYoQTF6it39yEsRBiWA8bV4uySZsb5ujdkEy0j3t8UYT98VDpwa+8rxQRL92LeKMYnNSfoAI171HIY9uxcuSRAgUKZUD0lRNvZlEH5UNrwGso5RKuVpruXa8I3SceSZZkntwEfmCPAmq2A5G5ZCYEiv3xGMW2wG8QZrZTSsUtrbISYUVfC8m0NUK6pe3WbGU8EA+c59L6zPVU4/jiRbx1kfCSLIDq5z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dExndUlxWDRwNlF3S0JFbkd0RHRyaFpwclJQcm05RXJIQTRRbzJnRmJOTnFV?=
 =?utf-8?B?S21vblZYbmthbVd2NHV4ZVJNT1hhU1M4dVJwWHJLN21RQndHR2tudTRFNE1G?=
 =?utf-8?B?Uk5PYUY4SVJORGdPeXZhbzJQemRBSGFGRXhhVlZqNmNHZThGcmNmKzVwb2Ez?=
 =?utf-8?B?M0pVWUFKYUU4V0ZTdFVnTXVXb3QvV040cFFjZm9UYWFuUlJTTFAzMjVCUUln?=
 =?utf-8?B?RGoxVEc2ZlN1V0t4dklvNlBOS0RDTkhTdTRmcmdNa1NUdTVRK3dqZHZUQW1o?=
 =?utf-8?B?K0s3SXFjZldqZkl3eGVES3BDekU1Z0J4RDZ2MWZWV1pRUHpnd0w2MXlFdlYz?=
 =?utf-8?B?VzdsSWJ2azdDREo5SHRGQUczVGYydEdob2FEMFQyb3VyNU5GR0ROZEdaM0N4?=
 =?utf-8?B?SHZ0WXQ5TFhXdytXUnVVMGl6amhCNE8yVzk4b242bnQyeW9XVDFUVk9aNkdm?=
 =?utf-8?B?YjZ4anhjZHR6TkFQejRyRVhNMXh3cUdYd3A2blJtQVZpTWFtWWJaanVmUVdR?=
 =?utf-8?B?ay9jNjIzQWw4NEFoNTZ1QTEyMTlDOS9TbHVweFJYMmRqdHEwOHpBb1ZDcDRP?=
 =?utf-8?B?NVV1U0FLVStZTndBU2dLcmIzdzBPQ0M1Q2thRUFDNGR6WFNYWkNMeFNtTjdB?=
 =?utf-8?B?dDkwSXhReEhwLy9sWVVTWitwaFl6WXZNeERTekU0SnBNY2ZhajNLbmVSU3ZN?=
 =?utf-8?B?OFcva0d5aDhuZTg0aG1qajBsN0dLRWErNWZFa2YzNU5mdXFoUFVvZ3FGVzly?=
 =?utf-8?B?bXZPWm1rc1YyVWJhK2RKUWJrTzEvTFZEWWF3LzRQRG5Jc1NBYjU3ZVNHeG1l?=
 =?utf-8?B?VWxTNHFQcXUySytwN1FGRVNSTzRMbTNxdkowV1pGai9hU1lVV1hIeWRrQ01D?=
 =?utf-8?B?Z3FCbkNyakxvL1VSYmJLaU15RmQ5cWozOVpFc2hZd2ZHZlBLZ2VyZWU1N0FF?=
 =?utf-8?B?Um5pQ1ovZk9neTRMdFQzZCs0dDFrODVJNkk1RUEyNUk1cmJudytHdHluZysr?=
 =?utf-8?B?OXNyeDVPSi9OREZjZWdHZTBaZEIrWEJydWdyVURIR0FXNmRUUGdLWk9UY1lx?=
 =?utf-8?B?Q200VFU2YXI2ZWRyZGV4UU93d0hxTWdXZWhNMEQ3MFJyWnRpYlV2K3RmWG9v?=
 =?utf-8?B?WFJhZ0xXZXBmWTJnWnFOT2UwZlJiNHBjNGV3QkN2dk9YYzZHcmJzUlZsWTJq?=
 =?utf-8?B?SDJCN3hCcmszNUgrRzVnbWhVejdsckRrTThudDVZV05aVjlZbmF0aGdxTTRs?=
 =?utf-8?B?cmZ6M2oxdkFkeFRJampCbDVIZkpIcEFsMVhwa3V0OWZ4WE1ZR1RzQ2lPankx?=
 =?utf-8?B?SFd3K29qVFIyQ25XbFVVMU84VkpxR2pHNkp6ckd1dWc0Yk9vbDg4bmdsRW5O?=
 =?utf-8?B?d0x2blRRTCtRYnhqSnhhL0hDNUgybmxhUWJrbVpVby8wMlk4cHhpS3ZvMG5W?=
 =?utf-8?B?czFwU2djMnFSWnRNRkNYa1BxeGNRL0MwNHpqYVVqRitTcFdEWFh5K2cxVmRW?=
 =?utf-8?B?VlhsQTZrdnE4TFNFNGtaRXdkNDRoVTVOWllBTWEwdStnY3hrZVBrdk8xVENE?=
 =?utf-8?B?aDVEbVpzSDJhQkZXZ0J6ZUdpYnlNTXZWaEsvM2o2Z2ZqYzE2a1JqcW9rYXdt?=
 =?utf-8?B?eXN2RVdCWHlmZFFWbFhwS0xlVEJLaXBUczF2UFVLZFdBVWJtKys0UDBJQW5H?=
 =?utf-8?B?Y1IrdmtUQVkyOUJZVW1CME1tUHp5dTNLT0gzZnBJOHpkOGlMQmovTDlUYkUx?=
 =?utf-8?B?ajd3TEQ1cEVhRCttYXdLbU1rNDd4UFdnOVVrZTdyNFNOT2t0YzVCbWVsekF0?=
 =?utf-8?B?QllNNnAvZlRyUWVnZXF3aTJRT2JlVzNFZDNSaFJjS1JxQ0tFMENoa0k1MitW?=
 =?utf-8?B?Ym1ZUjVYeVZkMHUyTVZYa29RalpSYW83ekpad21Ua0IrbVpSNVBmKzh5Skc5?=
 =?utf-8?B?aGY0Y1Y5d05XLzFLVlJGYi82Y25JaXlPd1J4UW84VkVoaTdTQ2xtSE1jODk1?=
 =?utf-8?B?MjFZN0xkRklPd1lEWjNzQXdxZmx0SDV0bFExRkYrMkk5MFpyc0J4WjRsbDZ4?=
 =?utf-8?B?Vi94WXpDc1NpazhrcnVoZHloRmZzZDVqdWlKdUJMM0NmUWFXbm95V2ZLb1lL?=
 =?utf-8?B?em1tWkwrV2R0SVhJdjBKMmFDV0hUNjVzSEN4ano0MGgyTUQ5eVNkNHZvTndF?=
 =?utf-8?B?TmFDMU54SWxXbExsMDg0NFhJQjZET3NaeUJzZUE5TjkxNXZSZkRwc0ZoN29Y?=
 =?utf-8?B?WW1yTlhMWUpscS8vczVqMStzSUJ6cHl0U2pxY1IwUDdCY0xTcjFxdWdYdUQx?=
 =?utf-8?B?azBOdm1PVXg3RVJTb2s0UE5IR1pMcXdTekw0bm4xNjk1NVp0V1ZLbTlNays3?=
 =?utf-8?Q?agjdPRG3WPYQt5O5aYqopNd+iXyXwAyhmleXuJcVD9NQQ?=
X-MS-Exchange-AntiSpam-MessageData-1: 7agGatMOzEM+NjJdwovAPjfAM/AUeElEGHw=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 171d8713-a478-4b26-6a5c-08dea9f064f3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 15:18:28.5879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR9TOnMzdwui+obUFM04JoCf1Hd7ClAaf6F7s3/isEZPR3VHaDOfOP6Pe2dAdBCBFuFr0s9V7uoD+e6j6W+tdVwPV3oWnpE4oX9uI4XuVEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9013
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

Hi Simon,

On 5/4/26 4:58 PM, Simon Glass wrote:
> Add a .mailmap entry so my sjg@chromium.org address is used for all
> email.
> 
> Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Thanks for the prompt patch!

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
