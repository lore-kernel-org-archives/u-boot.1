Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0150C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 15:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459DD882B5;
	Fri,  3 May 2024 17:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VGXRpX6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D7F9882B7; Fri,  3 May 2024 17:32:27 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4FE6882B0
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 17:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YypTjmpNEwS2eGF1D3I4c2RY2MACsK9QLhJ3I5kN0HhsJxGTOnliNEssf2y6GpzyQVdXRq2CzhAEdwkY1j+l56ecophDCs98DQpSliec7zSXD/+9/sQGcB/H8AkyPyOqQgNLZ+REWFNNjKUbAXejBAP6j/hoDRfN1agdR7/UX5uBalNxh9LW8pTUj3WHQK8xrl58opWm//DDyWws09dpIRNvCIKvB9T9kCGgCKnIN+ZlELZ1tyuN4wL3+kVV0f+y3qA8l9OgmJcTG2wNL3yQjrPpkga24qDxXtyyW34Ybj0r8B4S20aT60K/PswO+jpKU3gI2stLPzdxhOMMamiDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EpPWHL4mfTJ+f66m+mI7f/2UCBPX9A91WATvj9ACvmY=;
 b=QRikLY2rhjJ4xoSgiWfyR8z41h3kr/7CTXViuje8d/6e1mdeh/NDVo7gqwiBK6671HNjTuR6jWpacrWSjTYtzMA9ZjF8Fj+dN0jtwR47i/WO0UINb4+Z+DfKyH+MicTXb337OFjKgKLQTkzoQzG6O2g5SDo1A8FOQtThp2DWIU9zroXe/VfUavGvhwHy0tvEhhMb9j3UjvAg7CT4Sxt9g7+zhG7MyXh5epIYzO9fTtxQq8ZX3UVMn1ujseoQkg324yoTCrM9DQo9hTf8oOEz3pgryWHPVhz9zrcbVS1vL8v3alDgu7yQKcVsxFZAVA4w5pZlUe6T68qlqUlILwGvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpPWHL4mfTJ+f66m+mI7f/2UCBPX9A91WATvj9ACvmY=;
 b=VGXRpX6CSpHwmPvQQ1VB0RyIAfgq8tfqrKfPuPUoPhHiAkemS+WCOd1rPiXyT5OOgFXbPMiLO75jE2CFZcpjEOA0+ZFHqlY/xcTTbYHTMgdQujv+x9j1OKVpjMXbHL7O3xkwhywRxq1mXcdTGV/r7DkszSRzxfqi+1BvjMFqifc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by AS8PR04MB7590.eurprd04.prod.outlook.com (2603:10a6:20b:23d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31; Fri, 3 May
 2024 15:32:22 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::ac08:df46:97bd:4ae6%6]) with mapi id 15.20.7544.029; Fri, 3 May 2024
 15:32:22 +0000
Message-ID: <8b3a7455-acff-4820-95a1-3815d3526f68@cherry.de>
Date: Fri, 3 May 2024 17:32:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] board: rockchip: Add Indiedroid Nova
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jagan@edgeble.ai,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240502185714.1045543-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240502185714.1045543-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0034.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::47) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|AS8PR04MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: a7fd1dde-0579-461a-742e-08dc6b8639f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHJkbWlDbmtNVDlVYlFpNTlqeUVEUzZTMVN5M0lPdVZIRjhsOFVNZVRpVi9L?=
 =?utf-8?B?aS9vb3Y0dmYrTms1LzJNUXdMSTJUZlRzWHdSb3pJQWNGdTBuaFBsUjVpOEhu?=
 =?utf-8?B?TjIvbUI2N0svaWYzNmZMSGJXS3hGNVVtTXpwczZYWkVBazRuc21Sb3loNlpr?=
 =?utf-8?B?RTMzS3ZBZDZ5MnVEb05vTmM2NTVkMW9jdXRwRVIvcExkVjV3Q0ZLOVJTZllR?=
 =?utf-8?B?SldINWFxU3NCcW1FY0Q0N290dlkzbzlnV2NlQ1c2QXJsRTI4eGlPVjJoYjdD?=
 =?utf-8?B?TUI0TER5Q0Z5elBsUVpSUTMrV00rMVF1aU54NzNxK0dsSTNwMEdZRHBwMWtz?=
 =?utf-8?B?ak9rL2E4d3RRNm1Sc3BscFJLM0F0N202NjBBemREck5WakVybFFhejI3SURk?=
 =?utf-8?B?MlczTmFZOUhOVnBubWxLU3l2Sm9CVUsxMlU2bmR0MnZMN256QkdiN1dGRnhm?=
 =?utf-8?B?UE1qNkdHQUNPOXhUQWJvSldWNmJxZisyQkVhL1BGM0xGM1VFR3JzZWd2SlBN?=
 =?utf-8?B?c0diUWlDZlhNTXc3NW9BUEM4ZVZXSmYyNEJIVFE1WC9JMVZyV29zdHJKV1Y0?=
 =?utf-8?B?Um41enRjcDcvaFRGTkNUbWdGRFA5WTByWDdJcDd3RGpXSnk5c2JNZXZFcExY?=
 =?utf-8?B?TzFBVWdiMzF0YjdWWjhhYitEL3lwMStWdzZUR1dMaXNIQlBobDd0ZVRCSWJ4?=
 =?utf-8?B?bVJYQzVSQ2xSK1A3MWxhczQzS3c4ejRaYkJQUlREbXhlL1FrWDB6b2paK0Yx?=
 =?utf-8?B?dHpxWFptNFFIR1VEcEhQV0p5OExtdy83WHdSdEhDYXVPOGxLbSsvdTBJVU1Y?=
 =?utf-8?B?NUpKVUlmb1ZuOXA2N3NjRVNtNlVqaGNmNmFZWDdLbmk4SXFEcUtHQS9aUGxz?=
 =?utf-8?B?RGlQUlZRdVEyUEJjV3NtSS92MGVyLzI3SWg4K1dENC9mc2ZOQ3lnZHFxTmF5?=
 =?utf-8?B?ZkVqU0RLL0hibmN2QTM5YzFxV21DRi90L1c5ZTJEY2VZRXZLbWl0T0xNMVBz?=
 =?utf-8?B?K1FDNzBQREhManhFUVdOcWNFc2ZEV0tSRUI3cmx3Z0d4aWlaNWsyaUtuTlI1?=
 =?utf-8?B?c2hlWlRxenUxZGNxcm80dWU4VkVFTDlPQkdEUGQ0NXRKRHBRUXdyMmVyblph?=
 =?utf-8?B?VVlLNHVPTWVHR3FsSG1MQTB0Z2tFRDIxSFZuREJXNGZGQnhSb2xnWk9CNjBz?=
 =?utf-8?B?WTFiUXBBbXpHQ252aUFyOFJhdVBZbU91T2c0a1lZY0dPWDJVRW5tOUkyWGgr?=
 =?utf-8?B?emk1YkhMNE9paTlPVVZ5WUFGWXlmdWtxMVUzbmpRclJ6TERET0F4alNFUDUv?=
 =?utf-8?B?TWk0MkFaUFM3L0duYjFvZ1I2dXdaSlpZblNqcFNla3AzVTRBUjZHQm5rZlNO?=
 =?utf-8?B?dmRqcEFVTiswYU5KNGxkY2hvRWszdlN3dHRaZWMvN1JHdEowUmJvMG51bEhP?=
 =?utf-8?B?anlXVEdIQ0tWVFlibW1hMzlLazVZS0dpKzlIQlI2YVZGc2JtcDREbHhSaTAy?=
 =?utf-8?B?cjl6bGREYk1sSDNWUEdKSlJwbGFjMUh2Q3N0YkdKd3k1ak9YMWl6V1NienBF?=
 =?utf-8?B?SGozVlAwUVhPbkl0bW1FbU9TTmpWcVBuMWJWWmh5TDZxd29sOGtnYzZ2N1Mr?=
 =?utf-8?B?U0VNdkIwcTFmSE1kTk5wOUgyT3R1dzVDVDFMV0d4aFdRbWtNYklJVWdJOFV1?=
 =?utf-8?B?M3RJaWh0ZDNFOGM5U1hXZjR2WW9IYmFyaXZHTjYvcC9QcE9xQ2g2elRnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWU1V1FEU0toSGh0ZHF5ODc4QjZ6MEtKaTNwbDRDVGVBMVd1YlEzdHRmdjYy?=
 =?utf-8?B?OW5lS3U0Y3dicGFvbTNEb244ZytFOW1GK24vNHZLQlJreWt5MCtlcERRNkVN?=
 =?utf-8?B?NXRuYUZhOWhxZDNIcmtOUENZSHFwZ1J4c3FmRTB0OTVvTkIyMzdGdmVnWG9m?=
 =?utf-8?B?ZVdGNlFScGZnSEU0aHlGazBlTFkzVGRkK0lubXVUdTROQ0FjSnd1eUMyazd6?=
 =?utf-8?B?L1hjYTdrQnJ5NGRtOXBCWlVZWDNLNUNWUWQ2SHFNaUs3RzlSb0QxdFNHTUJD?=
 =?utf-8?B?QStoc1FTUXNvOVB4QkFTNjY5UThFck45eDVpZ2VrVDk3Z2lWVWZPdWZNYXFL?=
 =?utf-8?B?eC9XOVJLVGErVERUTEZ1T0ZkZ21tWHNYd1BqSDNxQkJaYmM4bFNjRGVCTllX?=
 =?utf-8?B?Zk1TbHhxVU1iNUt6WGFIRWp3NkozRmR3SHQ1azE2cU1zMlByQlgvSGJjOEZk?=
 =?utf-8?B?QURHNXEvY01LZXRBTXJ0M0puMW1UMmM1VmN5T1JobDROV2NucDlVZEVhZEN6?=
 =?utf-8?B?YlliYlhCc0EwY1p4M2N3SWFYdVJ4ZURZb3lvenEyTllRTXk4SExRM0Qxd1pG?=
 =?utf-8?B?NG5IT3c2cStZVXR4RTVMWmFXVjRaY2x6ZkJXNkdSbEIrbGljb3BOWlMzQjVP?=
 =?utf-8?B?Zm90cjl3OW5EMHUxNDRENUtJajBmaWdrTlljL1VXUmNUYTJsb1BRWWJ2VlhG?=
 =?utf-8?B?YWtoaC9XanpZcXNKU2o4Y1lrdDlUSjNmb2FZazNRNU0ybG1mMHIvMk40djI3?=
 =?utf-8?B?Wk1BU0JFN2RqNXZ4TXdueXA2MG5TQjU3R3RMdkdHa0w3OFhhYldzV0dsd1Yz?=
 =?utf-8?B?TUZXVHd1dEQ0VUJkazNKRTBpU0NiTUFxY0V0S04rM3d6N3pTWjdDdkNzR1h3?=
 =?utf-8?B?WDhqN2RRWE0yYVY1MytyQ2VzMHpyWDBySG1kVk0wUlp0dzZ0WmZxYTlKZFNO?=
 =?utf-8?B?aGU2Z3Y0RHdra3VWU1Q2czFnMVFWNzZMblZFNUlrLzMvSk9zTTFBbTc4TTVT?=
 =?utf-8?B?YVNXbUNNbmJtWk9iZTgzUTJMOWVBK3ZmTXdOcW1BRXhmc3RQL3gva3BiRHVo?=
 =?utf-8?B?RlFvbGlrbThHY2FYTE1lT1RaMWhBTnQ1Q1o3OWFUc21sR0ZNd01CSEE4R1Ni?=
 =?utf-8?B?V3NQN0NtVmN0dFVIbE1kMHBMSnY0TWR5bUYwQU5nWkU5NjhUQ0w3cmdHU2lk?=
 =?utf-8?B?bGIvVVdjdTZHcUt5OVJ6Uk5RZ1I2Z3JMbEIydllpeDJGRUV5eXFST055MjdP?=
 =?utf-8?B?YmJWSm1SKzRLRXJ4UElOblh3b0dSR211Yk1GdUttTndlZnRGa25lVGw0bmph?=
 =?utf-8?B?UTRPTEdseVRpdldvZjJYV1BNSkF6Q1R4cjdZa090bEpTb2dpM0g5TzlXWUJI?=
 =?utf-8?B?YkhsTHNaTDFzR0FqK2YwZVVPc2FlK2xLSkgvM0M1RHdKaUo4a2JyKzU4UDVv?=
 =?utf-8?B?S3p1MjFmVmVrUlBtOG16V2w0VWRtbUFLV04yd3cyTVQ3U0ZyU29vZGoyM2x6?=
 =?utf-8?B?Y3FxQmlBTnFCVnl6MEF4eEJZOVlONHVxblBLa01udEg4dUxLSWNCNVJob0lX?=
 =?utf-8?B?elo2VTEvMXlBcmVaa1dmTUJBbUFKcmZUSE04OW5ScGJXNTlhQk5GUUN0bWEv?=
 =?utf-8?B?S1g4VnhNSk90Q1ZBamxOdHh5UXNXR2JmWXF0TkdWRXdYakFNM21ROFgyVVZv?=
 =?utf-8?B?bVUxcDEzbzhqeEtjZEFueCs0eWtBMXJ4MC95RG1hbVdkOVZZYXJsTFQxV1pI?=
 =?utf-8?B?N2hIekhVVi9sYVpaNW92NHBzc2JNdzgyTTk5Z0YxSXNQeVU0WVNuOHdHd1Jn?=
 =?utf-8?B?VzV5blhITmhXaExLdEluc0o0Ymg2c3o0ZmVmY3ZvN3BGYWRpVlE2QUFnaDlZ?=
 =?utf-8?B?cU1GbDhjU0IybnY0ZkRTZnRIdStUYjhhNmRET29odjVHMnEvUFdZc3M2RzU0?=
 =?utf-8?B?SHlXSjRFN25iYUYvWGRQcm8wLzZtdUdKWFM1QUtUZ3E2OElUMU55MXZ0N21I?=
 =?utf-8?B?eFJkT2dDNlpjbkVFanhsdkErVEg3R1hBdS94VWdaam9UQlZHVzlrMGVwODZ1?=
 =?utf-8?B?Mzd0akNMV1ZKeXR4WTFRNGhRSG9uNDdDNFlUdFc4M1ppakFaL1FyV3IvZ3VF?=
 =?utf-8?B?U0RFRk5ENDhQUEo4WXJ5NzlUdmIwL2puYVpzTko4UG5GVElFSVl6NkVoM1dr?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fd1dde-0579-461a-742e-08dc6b8639f9
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 15:32:22.3583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGlMIdxLSX9ynrPWtw4WFmHGq7cMowVxSPOlSa6yCwLylwlXzCDb0/AA7Qjzk/VZoG8oh2f7kP1lZtOD8rkjpesZ2CgdUFJIL+ejDuQCvkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7590
X-Mailman-Approved-At: Fri, 03 May 2024 17:36:15 +0200
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

Hi Chris,

On 5/2/24 8:57 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> The Indiedroid Nova is a Rockchip RK3588S based SBC from Indiedroid.
> 
> Specifications:
> 
>      Rockchip RK3588S SoC
>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>      4/8/16GB memory LPDDR4x
>      Mali G610MC4 GPU
>      Optional eMMC
>      2x USB 2.0, 2x USB 3.0, 1x USB 3.0 C port with DP Alt
>      1x MIPI-CSI Port (4-lane or 2x 2-lane)
>      1x MIPI-DSI 4-lane connector
>      1x Micro HDMI 2.1 output, 1x DP 1.4 output
>      Gigabit Ethernet
>      Realtek RTL8821CS WiFi
>      4 pin debug UART connector
>      40 pin GPIO header
>      Size: 85mm x 56mm (Raspberry Pi Form Factor)
> 
> Kernel commit:
> 3900160e164b ("arm64: dts: rockchip: Add Indiedroid Nova board")
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
> 
> Changes since V1:
>   - Refactored to use the upstream Linux device tree now that that is
>     an option.

Lucky you, I still have to wait for a bump of the upstream dts repo 
"copy" to be able to use this for Tiger (will be in v6.9, so not too 
long to wait for anymore :) ).

>   - Added board to doc/board/rockchip/rockchip.rst.
> 
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig | 10 ++++
>   board/indiedroid/nova/Kconfig         | 12 +++++
>   board/indiedroid/nova/MAINTAINERS     |  6 +++
>   configs/nova-rk3588s_defconfig        | 70 +++++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst       |  1 +
>   include/configs/nova-rk3588s.h        | 15 ++++++
>   6 files changed, 114 insertions(+)
>   create mode 100644 board/indiedroid/nova/Kconfig
>   create mode 100644 board/indiedroid/nova/MAINTAINERS
>   create mode 100644 configs/nova-rk3588s_defconfig
>   create mode 100644 include/configs/nova-rk3588s.h
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index 39049ab35a..820e979abb 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -78,6 +78,15 @@ config TARGET_NANOPCT6_RK3588
>   	  Power: 5.5*2.1mm DC Jack, 12VDC input
>   	  Dimensions: 110x80x1.6mm (without case) / 86x114.5x30mm (with case)
>   
> +config TARGET_NOVA_RK3588
> +	bool "Indiedroid Nova RK3588"
> +	select BOARD_LATE_INIT
> +	help
> +	  Indiedroid Nova is a Rockchip RK3588s based SBC by Indiedroid.
> +	  It comes in configurations from 4GB of RAM to 16GB of RAM,
> +	  includes socket for eMMC storage, an SDMMC slot, and a 40-pin
> +	  GPIO header for expansion.
> +
>   config TARGET_RK3588_NEU6
>   	bool "Edgeble Neural Compute Module 6(Neu6) SoM"
>   	select BOARD_LATE_INIT
> @@ -223,6 +232,7 @@ config TEXT_BASE
>   
>   source "board/edgeble/neural-compute-module-6/Kconfig"
>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
> +source "board/indiedroid/nova/Kconfig"
>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>   source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
> diff --git a/board/indiedroid/nova/Kconfig b/board/indiedroid/nova/Kconfig
> new file mode 100644
> index 0000000000..271d15a0ed
> --- /dev/null
> +++ b/board/indiedroid/nova/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_NOVA_RK3588
> +
> +config SYS_BOARD
> +	default "nova-rk3588s"
> +
> +config SYS_VENDOR
> +	default "indiedroid"
> +
> +config SYS_CONFIG_NAME
> +	default "nova-rk3588s"
> +
> +endif
> diff --git a/board/indiedroid/nova/MAINTAINERS b/board/indiedroid/nova/MAINTAINERS
> new file mode 100644
> index 0000000000..9c56d01bf0
> --- /dev/null
> +++ b/board/indiedroid/nova/MAINTAINERS
> @@ -0,0 +1,6 @@
> +INDIEDROID-NOVA-RK3588
> +M:	Chris Morgan <macromorgan@hotmail.com>
> +S:	Maintained
> +F:	board/indiedroid/nova
> +F:	include/configs/nova-rk3588s.h
> +F:	configs/indiedroid-nova-rk3588_defconfig

Typo here, missing an s after rk3588 :)

Looking good to me otherwise.

Cheers,
Quentin
