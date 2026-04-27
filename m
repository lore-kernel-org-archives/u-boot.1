Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3704FF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 11:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 450D783693;
	Mon, 27 Apr 2026 13:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="NpR8lHCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA9283AA9; Mon, 27 Apr 2026 13:51:16 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BA2080433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 13:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/xfIVU8JXBlvEd0swP3kQ3ecdN519Hv48/NGkCx8CQFqi6f9vyAOSwkjU3zksPsp5GGZWFoaFxZ0wZmY0poZaUbEEUA2gt0a+HMyAg0ozXnHH5KfFOkt0wZ7fOcdFcetET6k1GUZ3wJoZZ1vvz7hcd8wnleDME3kwo59CuM6lfZVpm+54wmxVVuL79GCTFK1fFula6PeZ1rCOEnbTJC2KnKwBm0hd8P9H8z6n0j1My3lsdLLm/EONKhJPs0bGh5OqNlQO+t9golhgEQWW42rEQtg+9RGeN/KM+obGT1RALuEwYL9Cken2koOY0fDE1ixHJ3+/8HJshb4oK5f6fjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WxA0wlelWRgZrj3Gfvftvt9n8/4lGyfwQaw6n3r5gI8=;
 b=B0QRH2+OESMqE3owMSfWH5oBGsOTnClSGRBhtsJOAaOo5q9bDSvA/C9NYqFeq1NsEPJIJ9D+/SdSSi/Mcp4jD6awU5G83vFE4z/W+LKLOOlFnxH98qxgXldXhaCMWNYO26fbiQNwd+5dWOvQEs6dgD3pG2rjK/43RIB9aZcNBRj+0s+o3QO64Wgsv6q0olRYTkJncyJJJxBj+0N1F9S/DriZGI5JCSu9t66vBu/sjQjF708ZnooH2fPaDvhsGUaq+ZmiCZEXVZ3WuF/7tPqPimfTrzohVCMG1FaP9wuOkWcum9bZDfZgfOYzdyXbZwnl5hZfoYOUoMlNzwW3xF+bRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxA0wlelWRgZrj3Gfvftvt9n8/4lGyfwQaw6n3r5gI8=;
 b=NpR8lHCNwG7T2e5rC0jYZmvABbxJ68H3F3DACcv/59zU/bRvBnW72aayTZ0SVrw6TlRcVbms6ZS7h+NnC2M/wzaQL1U2Y7Yb1Rok6MSnT7cOnOQiGwhf4T0hJ0Eu+NY3RhTD700sPywj+5cv2N1GH9cXWb5b16M3PT04gDDdXoU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA4PR04MB7646.eurprd04.prod.outlook.com (2603:10a6:102:f3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 11:51:12 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Mon, 27 Apr 2026
 11:51:12 +0000
Message-ID: <46bdc381-d2b5-4fef-8b2e-50f0fa1cfb05@cherry.de>
Date: Mon, 27 Apr 2026 13:51:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Couple of clang warnings for Rockchip boards
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <CAFLszTjWZ9DBKVui_2EE-nSg8K+5eC9V8jvwp638dLeyp_p6vw@mail.gmail.com>
 <175e1198-2ac4-48de-b68a-c29f786832cc@cherry.de>
 <20260423192013.GH41863@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260423192013.GH41863@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA4PR04MB7646:EE_
X-MS-Office365-Filtering-Correlation-Id: cb419141-b791-4900-4da4-08dea4534792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pIE1xoW2mpHjqVlqSf6t0ZeJ8ATKL+KXeR8UCXpmwDtDgjZRYHwpE7CVtlNM5ZqGV91CcU9FmOavGS0qPNZxuTe5lViuv3vef7hZZGa7ouoRNoxol4g2EgXr+kHtnqF7JMferLfQamzgc7hjEIFfA8D2e+ccA0kp5QAEMxCrfd9nhOo7N3Dtsop7Kv8//Q+MgoLOovtCD+YZIroL4O605VRaJ+W4h5dzp+l5kdiEPp2zD6UPt2Bo/55KGurKdJKNABg8UO1snTeOGTJ4fAhbNYW0F9Pka+Rc/xAFOh30FSs4TlIcjgcKL+YI0CImB+uI6UutrOtoS/8LxQYhhD64popjSSj+OnkkmhcUlqdG3vipUaj9p7cdwxAMfVHC0jSvVIFX/dUn3oUwlUI/o0yBvukCx3GILORJdot/T8roaG1ScdO5w2F3egsARpbazPscY75DboImJv5D9E+GMd7ElhfK9Frol/4DkEZJYFrMl+bnC4lWwr0qWkTZqrKF1OeL3AtvXV1zCbHleGidOQqzG9fK+b0GP0sGRXHInWbNDUH2XWu8rGMVTI+sUoh5IDeeB70lXXtanMNqRwytwf1dPLrFmZj9iwN8T9MoTLQA/CbkMKR/dhTSkQ5Ntoiv+GhxwFaeTbARaq4SlIYVM6DdL44778IAstXEowtWu2RY5eCkiDRRe4oG19GATWQ4teeZm+inQ2ZGSm1IFSTb/k1MurI9RfXFNVVZbwC/LqhE6Og=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2paUElmYkRzNFg4NXVRRmRTdVo3VElnK0lPNXJTUmNUVS90b1FRUFg4a1lp?=
 =?utf-8?B?ZVlERTEveW0vbVV0dTl5bUNTblhaVFpOcFVwNWx3U2lQY0E4UWlMY3NvaXY1?=
 =?utf-8?B?b1RoN2FNRjRiZCtFMzBVVlpra3ZVdW9OWXM2dmV0ckFueDYvd3M1SVUvRXRn?=
 =?utf-8?B?dkcxaTZkWmtveHdZVHZ0NHFYSFFZTXJiYnBZQkRZdms4RFhBdjlramhvZmxi?=
 =?utf-8?B?RGxCYXJDTDZyTE0vaHArNlNJU1dNWVBKbEM2WmtMMzhaKy92UUNONVRyQ2ta?=
 =?utf-8?B?djM0a2FQTWlPRVdRK3dKWHJ5MnJucnVueUVwSEdkWlV2eXJWZWYyQ21ZbXpo?=
 =?utf-8?B?NlhQM3RVazdud0FqOHJQcnNVTmhTM01UNFAwMWUvZWhDNEt2MVpmUWFDc0hu?=
 =?utf-8?B?RUdnaVRZVUZJNVdoVVV3TzE1NUJab1FPUGxLZEZpR3JRZ0s0SkNSTzFFLzFJ?=
 =?utf-8?B?TFJETEFZaGdxMjBQTVY5NnNKZVg5YXgyUUtlQlltRTlnb094djVMZ3lDdWJ2?=
 =?utf-8?B?RURsbGt2S0RzVjNCNnF0ZUh0Y0JvTWNDaWNWSFEwUkxneHFBS1BiLzdLYlN5?=
 =?utf-8?B?OVdtVXVXanpkUll6c2NneVZMcmI2UmczNkFDdHA4RS9TSXpYaVBvU2FnNHM5?=
 =?utf-8?B?b0haOXhwUUNHNUdpeXRFUGl3aTZpNUdVQ0g0RVh2N2VMdEU0aDFkcHlIcTFv?=
 =?utf-8?B?Q0h5dTBJYUVCeUZLUkFIcG5Tem5UZjJTSlVFdTlvNnJCcUJORjkva2xPWFJG?=
 =?utf-8?B?akJFcWE0bmdUU3RocGo2ZkN1K3RqWDlQUmFaeHJHUVh5Y2REZ0FMMS9BdERu?=
 =?utf-8?B?YnFwVXBqODFLcDhlRncrVE1Xb04ybVNTZGpRcmYvckErVkZGeFU4Zm9ndGpX?=
 =?utf-8?B?QTdicVREUnkrQTJ4MDZYVU42NkNleDR5RUJuY2Y4TnFscTdjL3pZS0JFL3B5?=
 =?utf-8?B?T0hEQmxMTlYzYmN1VFlqSXFueGJ3eFdUTGRvUGF4RWtqNnV4eEwyMlJJY1M5?=
 =?utf-8?B?SjdOQVdjc2FrZHVnckZVaHIvckppWWNPUThDY1YyUUpZOWVLc3I2V1FYNWQ1?=
 =?utf-8?B?eUUwdXk5aDIyNjAzdnVrMlNycnlBVjA2MXdobkREYUhuTmV1SERxNlZQWmw5?=
 =?utf-8?B?RXJSSVBkbWQvb3BkQVdzZ1FSZW5qMWtMcHdPNldyVHg4Um5MTVpOYktsQ2N4?=
 =?utf-8?B?NDZWakxiY3loSXMvSS9lV0ZKaXRNellqak9SdmNURThEREJxTm5INHUveHpt?=
 =?utf-8?B?M1M1TC9idVFMcDJtZ1pPY01MOVQ0NnNtTk1mYmFxY09WNGxBWWFvOVFOZ1Zn?=
 =?utf-8?B?eGpCNVcvdmYwMGlCZHRMRUVYdlJKbklhdnFQTXRNWjQ3ZkZzMGxGc1pXMERU?=
 =?utf-8?B?amlKSUtQYm1SV0R6WnVsRnV6aEd3c0ljcVAvbVlzT290aldpeXhTZFJvVmlh?=
 =?utf-8?B?dWtLTHhwbkhVbzlDbUx1cXVESXgzdGdzeFBEdUVYVm9DeFRHTVE4bFp6R0kx?=
 =?utf-8?B?WlJ5UmEzTm5vR2pzcit4UnJld1haeU1RWGtpd2pnV29KUHEyQW9ycHJlYmNx?=
 =?utf-8?B?bG5NazFQdHFVcVRxbngraEsvdjBIMklkNWlEcmFOMWdkSUNlVFlwTDBJUGRn?=
 =?utf-8?B?T1RvVGgydGljTVFRRzA3OTZ6ektFZVZrdlBtNjRwci94WmlEV3dIdmRPNzYx?=
 =?utf-8?B?VEw2Z0pPcVlETG9PS25yOUFvYm1JSFZSUFZINzRSajZZRHgvMGUxalRyMlBT?=
 =?utf-8?B?WWpkcExkWVVEOHFrWTM4aTRMcXhHWGlxRmNhaVdDdXNCRXpHWE9BMFNRWjll?=
 =?utf-8?B?ODlVM2JUUWhOTDhBNGZEeFZIZXZadVZseEZlL1RVNDRPTEJ3SzdFWExWVUpP?=
 =?utf-8?B?Vit4dXFlbVNMdWFQQUl2SUFtNDByQU16cEJGMGNZVzh6MUFxQUdNWEt3MDY4?=
 =?utf-8?B?cFl4UVNVRWEyTFZJRUZqWXdUc0t4UzJMZGxCTTVZQVNKNlM1eFR4dU9IMVd1?=
 =?utf-8?B?clFHWFYxWXp5VFZLb012Mk9ROGZzZkNPeWpFNTBZckJtbEorUVNHYTlIYjBp?=
 =?utf-8?B?SjNzdDVFRXBtY0J1R05kYWlad3J0Uk1SUGpJdkNadEdLV0R2MHFKYlIxZjVx?=
 =?utf-8?B?d2Z5NXZDckRrbGg0ajkrTFYyUEJnOXQ4eUtUaWQ4cFppRk95WmhYV0JXVVhN?=
 =?utf-8?B?cmpZK2VvS0llSGg4M2Y3QVplYlJ4ZUFuMHh5aDl0Uzc1bHBqc0hHNWhpUWIv?=
 =?utf-8?B?UHZUbmQvOFJmUDNTbWk1eDczaCswYkJ6QncyY01hN0hDd2JMWHlmcFpBUStt?=
 =?utf-8?B?dktPOERtMkxuOG9CNGlDb3ZWTm5iS3dJYndFUm4zakdGdlFSc2Fjc2c2WWJi?=
 =?utf-8?Q?vL+WU9AbD7I2dbAD7cyYrqAI9F6MWXSGRxfbA?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cb419141-b791-4900-4da4-08dea4534792
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 11:51:12.4760 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxblxbsd2apotc2Dvv4rLwcgUXtZUxHSXmEm8CID1Nktaaq8CBkn0hvX3WIFC7XJStN/zUD3mrjB1eanNQ6dCuCdcCVehRBeiZeTjUEjfzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7646
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

Hi Tom,

On 4/23/26 9:20 PM, Tom Rini wrote:
> On Thu, Apr 23, 2026 at 12:24:13PM +0200, Quentin Schulz wrote:
>> Hi Simon,
>>
>> On 4/22/26 11:57 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Thu, 23 Apr 2026 at 01:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
[...]
>> Also, FYI, enabling CONFIG_WERROR doesn't apply the -Werror flag to the host
>> tools, which I believe is an oversight. I see buildman sets
>> HOSTCFLAGS=-Werror, maybe we should do that in the appropriate place based
>> on CONFIG_WERROR as well?
> 
> What does the linux kernel do here? We're just borrowing logic again.
> 

27758d8c2583 ("kbuild: enable -Werror for hostprogs") and 7ded7d37e5f5 
("scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=e for 
hostprogs") (available in v6.18), set

ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
[...]
# While hostprog flags are used during build bootstrapping (thus should not
# depend on CONFIG_ symbols), -Werror is disruptive and should be opted 
into.
# Only apply -Werror to hostprogs built after the initial Kconfig stage.
KBUILD_HOSTCFLAGS       += -Werror
KBUILD_HOSTLDFLAGS      += -Wl,--fatal-warnings
KBUILD_HOSTRUSTFLAGS    += -Dwarnings
endif

so they do it.

Cheers,
Quentin
