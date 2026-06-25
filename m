Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E36CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 14:10:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E20684894;
	Thu, 25 Jun 2026 16:10:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="g+nUbVEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1802384894; Thu, 25 Jun 2026 16:10:18 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D366A846F4
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 16:10:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYr89PI+J6KvgKNg3vfEvBbJ3N8s/osTRyWUO4TaXIlJLH055YgDmSNkd0ZpZdjN66L0SSiBuVHxV7wJEXWuKw43uHaMqwZHm/6TO4YpHalrEToXoW+37T5mSYWSFzSz+EVMSXGkVi9wXAVizxoClY7gPlVbPC6zW7wiUZA0/f3C/VOheg8KSjOS0jLbBjUZobqZpo1VOBPDD9CXUxlUBk81ae1a94h8iAtKmON6I3z+kGKQLh9Hg8aYfu9FUylzPxPAJZHwIO38NtbqYOp3ehGlg8iH5rqWPT4XRZXKOClKP30CCsiP9dm4/KELvwH+Sh8G0rpT6JmiR206ltQ/4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtPQknl5n8ra5X0tuEouulAYmngSGxza0mrU9PYTDTU=;
 b=oFy6WBink3F64WECcJ4Wx5wIFSvV3W4GhDQ6qXgUYslghmFBocqjaWgpLEBC8sNWMo41BqCPAXQwMuzuxfMd1EjYCBFv7ocgX/R1+X+Jc5zcE5vTr5u36Fk8KLGVK+0xdDD9QciH98n54zmM9agdA8hwml0lZLt0j1fMYo13tFt4+UmnryhecqDyvLsGeCUvo1hRq8Y2F+KF4ZUbycdtyQDrgxeTzQ/IkyeB6FpdezCyh+jtKYIbEcURXWc5xoLt/RhIbgvFYgdgnAvmmGFA62y81M1inKi2e+GG+B+hO1gw0MnTRGYF+epAcskCtfmRZgN3DK4/TxGBA8pWwYxRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtPQknl5n8ra5X0tuEouulAYmngSGxza0mrU9PYTDTU=;
 b=g+nUbVEKs7flmJnA5XolmbUQResbBU058/ZLFBsjFcg+SK2uYP3eoDPS6IUsjjuyS964Y75lIuJYLLWmlG3onR3Mmv5sQWbM94qBnntrN+CL782uWdvumABYmWOx2NavHIO1YBeFHbJXvW9TPuKdCtsGF6F1/ovEKQmLSQ4pxr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU4PR04MB10863.eurprd04.prod.outlook.com (2603:10a6:10:588::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 14:10:14 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 14:10:14 +0000
Message-ID: <bc565581-c31f-4fde-b487-f9265ca76c00@cherry.de>
Date: Thu, 25 Jun 2026 16:10:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: usb_onboard_hub: add support for TI TUSB8041
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+usb@mailbox.org>
References: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260601082717.239518-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0126.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::7) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU4PR04MB10863:EE_
X-MS-Office365-Filtering-Correlation-Id: a7393268-8865-4617-fa2a-08ded2c379d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i1MS2awQGUIL4D8R5UCpZvjnEg9Q+9EdXk5cgljcLE93hEc7QfCKK+/flRAyb4i5+SX5Oo1ZLJFXZGIDJK7+9v8CtCHj1fxxMYldnBCxAWr4YIG5xUmJFxSgd1rAOTx/9+NrQzAv4kVtyBjOf5j+wUmHGltNakr+G8fiz16ToRrxZ20WJJ1gdaCL2MoR/Giyb9NPiLQPsmXclBv8ddlYIJXJFu0dwXfBnd9CgGOOuW2Kh9TpijHhn2G9034ThRNls1MSaJPcja0bGLtLMtlGycyfrcIDslu5BUQTvGmxcdcxX7lKbub7oge7Ye+sePcp2iANYIEvkWTwY95kaTz63R1vTaZM7vDzDu7ZcCwLvin738qyNRz43n2koEF7NlZAvsBLJ78DLuklyOLF5Ffep9jG45oABNXMFijowexpdi1PevvsbGZ7vJOit9EHtvOYp/38v1lLdqC5JsgawiXV0/kMTXbq1H1YCOYJzwQ+mlSCzPlPVVFlwzFnMsIBN17j/ia0KmPF9cklUWYgmyOEM9npN3u00YI43NS7dd6yGV71c07Uhour5NmKj5Dt/290vwOhrljecRKCyOsD2Rn8Rsev9t8zgH+NlcpyK2i2N/f98owsHQrXubYnxhcd0MhxuA66RvSV3pOcTDkhOOiTNJ1ZjH+MwQUWDev/rfdrFDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enk4SG8xaUZNNzQvRTNxVEplQVRTNkh2QTIyaFdNSXFncmlQcWtVSFp4NlFw?=
 =?utf-8?B?L1hrajB6UmcxSnB6M1JxYzRxLzduUlFFVnZpS1QzZ3NMcHNoWjFFZFVDRVlm?=
 =?utf-8?B?VEcxNkV2UWl3dzlOUGdFTHhsNXZ1bHVRSm5xVEJjYnkwYTZWK1R4NWl4b3ZM?=
 =?utf-8?B?SkFlQ1RHQXRyTjFBd3dxZ2pEY3gyVFkrUzNTLzFPQVVUTjRRT0dkMGZERXVO?=
 =?utf-8?B?RmE5d2d0Y3h1SjZ6Q0t5bFFsZHpsaEx4THhnYVYxVmdHSGpHMURjSEpQa3c0?=
 =?utf-8?B?c2VmclY4azZpbWJBTEc1R3B4dDBFZFpncFpURWlVZUZ3K01wZnFDTzJPc2Fl?=
 =?utf-8?B?NUlPMWJ5cUJJamwzd3E5Z3ROWDNIK00xYld0M2RMNGhZTHZ2ejI2ZDdBSkpQ?=
 =?utf-8?B?aEdlcEJNUGdmTWlDcllKY05vNnZrM2hPWFdLMjhQb1NyMk13b3g5cTQ4TUxv?=
 =?utf-8?B?Q2pXRW9lZFB6bXZBM0JRY3FmcFg4TnMvVEZuTm9HS0k2ZHAwZ1Bha2JZMDRC?=
 =?utf-8?B?cWJyM2RrMk4vYnZVTUNpU0w5Z3JtVlRacFgycVhiMGhiMEpVR3dYWTZnTDNm?=
 =?utf-8?B?M0lJZ3Z5OWU4K2hwNEJISmNnRHRQZEVCWHVlTTVUQVQ5NzBBbEpEL0RmR3Q3?=
 =?utf-8?B?LzcvdVhrUzY3QnhDUjZTcFM0cFErbTVMM0JMZzQ1bEM4bzhoR2xBM1IyenZw?=
 =?utf-8?B?RFZEZXluanRWZ3dKMm9Oc2VLa1Bla0laM242ZTFuZEJVUXVNQWd2bHlOeDlz?=
 =?utf-8?B?bnhGRGhGRFJJMkNEclRDZjQwQUdaRGVJN01sWC9LQUF1cmx1U3V5YVRsRFJV?=
 =?utf-8?B?Y1M3VFVwYytCSHJxeGxZQ3hmWS9VaUpJZlEyZWVEajhSNTVVVlI2WUpIU3NU?=
 =?utf-8?B?Mktwd1dGRk9uMzRRVlAvTG0zaDJKR2RCUGNFa0pyMGxnamtNK2xYci96dXA3?=
 =?utf-8?B?clFETDJITk94OCtHU055QWZKNjE1dENhNmdiZ0dUMHBBT1JzQTdYZGw1TlJm?=
 =?utf-8?B?YWg0V0RpOW9wcW9rNEN1MWJRK05vaVlTSG9CQUVKcUJpQ0RmQmxMd2QxcWx0?=
 =?utf-8?B?YWVNUEE4UUdIa0E0TkxjOVJZakFLQzVGLys5MTVOVE9TTi9iK3VDY0E1Tkx5?=
 =?utf-8?B?UE9jVWJ3TVBOdkRvSERINXgwR082b1A3UTlIMU42SFc1eU16bTVlVnpKUnVo?=
 =?utf-8?B?Ui8vcklnOHZxZ3RuSU1KcWtBdldRRFk5bXUzcXhsREpaV05ZaTVKRVNLd01Z?=
 =?utf-8?B?NE45YXhMZnRoVERtL2RNb0pOS1c5c3h6dUIybWdxaGhiR2FrZnlZOGtPOFBP?=
 =?utf-8?B?UUdHVzB6aXZYRDc3OTNFSlBXLzhXZmx6Uk0vdVhJVWZ6TSt0WEVHRE0wN3Mr?=
 =?utf-8?B?cWpEMGVRUzRycUExcTdWTm84T0JjbGFxOHlpTlRZTksrY1N5cU0yVFc1ZGsx?=
 =?utf-8?B?eGVXRU82VUZwTEFaNXc3Y1RWZ2xWa251cnphdmYrM1l3L1pjZmJuUW9GUnpG?=
 =?utf-8?B?UUdPYmpBdXY2dVdwMGdtNWYxV3k2b3ZVNzVqcWJXd0c1NTRKeTVwQTJxc3ow?=
 =?utf-8?B?Si84N2s5Wi9HWE5yVEpGbGFzSXdWNHpsMHR5Qzd2NG5rb1JlczNSRWY0czUx?=
 =?utf-8?B?WWg3S01pOExvOUFlZGdoSUR6NTJkOGlLeFJyMkZsZGNOcnp4eGxUdjF0MGk3?=
 =?utf-8?B?RlgxK2NnUE1LelBZSjkwb29BczV4WXY0dEN2OFBJS1c4aUdQTjZ0ZWM5eHZC?=
 =?utf-8?B?Ujc5cVZVMENoMmhISzJjSkM2UUVJR2NmZVRqQnZiL2pHcFkyR1VBeWEzOUlY?=
 =?utf-8?B?V0w0R0lmSGExRnQvQkx1N1VxZWZLMExDY293bHRUazI5ZlpkMkJmOFR3SlRx?=
 =?utf-8?B?QWJUTFJyUmEwVDhMejBDbVRyVlJQUnZ6M3dlRlVTRnhBbWRHdWRJa3ExUG9J?=
 =?utf-8?B?Q3hRQWI4QURtNk1XSVE3V2NPWEVwa1ZaOUJZaVh4alliTGxLQWQ4SE9GWmJy?=
 =?utf-8?B?bzcwZUxreER3OGMyM0hNeU5RQnN0dG5paVBIRXJ2L3BLYXd3OFlrQUY0a2Vm?=
 =?utf-8?B?U1R6Vm5rR3RFa21xOHBZS3RxR09rT1habUhwUDNPK3o0NjMwM0tXWitWNkg2?=
 =?utf-8?B?bno4ZTdPRzk1eHF6YjFyWVo4RHFLMG1LYzJQRnFZei81U2FJbFZ3L2tOdGcz?=
 =?utf-8?B?L3V0cWZqWUZVZWdZVGFXa2Mxb2FSZGNZQ2NxYTlJSTcwelJjTlV1MmpicFhT?=
 =?utf-8?B?bjROUVhDd0ZESzlsT1ZGbXdzWk1Hek4rNXllRGwyQjB0Q1VwZzg2UEc3TE1t?=
 =?utf-8?B?RncxQ0o1NGZ1ZVBBTXgyMnFjME1WQSswNmxtdWEwcEE5djBRRFNXUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a7393268-8865-4617-fa2a-08ded2c379d3
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 14:10:14.0079 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gDyPf215Jpi1CVTcpEOvdxdpY6y/ltBbBQL3KptsHPHbkUAgatdAPFfRJTEWEZj7SbHO/2A+7+WWOmBkv8NBn9FzowaiKZbha9J3p9x7M4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10863
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

Hi Alexander,

+Marek in Cc as maintainer of this file

On 6/1/26 10:27 AM, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Add support for the TI TUSB8041 USB3.0 and 2.0 Hub. A reset duration of
> 3ms is specified in the datasheet.
> 

Matches what you sent to the Linux kernel... /me checks notes... 4 years 
ago.

I see a few other compatible with the same configuration in the kernel, 
should we add them too in U-Boot?

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>   common/usb_onboard_hub.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 6fc34489a98..e7bd0b9ccdd 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -277,6 +277,12 @@ static const struct onboard_hub_data usb5744_data = {
>   	.supply_names = { "vdd-supply" },
>   };
>   
> +static const struct onboard_hub_data tusb8041_data = {
> +	.reset_us = 3000,
> +	.num_supplies = 1,
> +	.supply_names = { "vdd-supply" },
> +};
> +
>   static const struct onboard_hub_data usbhx3_data = {
>   	.reset_us = 10000,
>   	.num_supplies = 2,
> @@ -293,6 +299,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
>   		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb451,8140",	/* TUSB8041 USB 3.0 */
> +		.data = (ulong)&tusb8041_data,
> +	}, {
> +		.compatible = "usb451,8142",	/* TUSB8041 USB 2.0 */
> +		.data = (ulong)&tusb8041_data,
>   	}, {
>   		.compatible = "usb4b4,6504",	/* Cypress HX3 USB 3.0 */
>   		.data = (ulong)&usbhx3_data,

