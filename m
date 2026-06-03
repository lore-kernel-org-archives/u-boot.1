Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48C7CD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 156CC839A8;
	Wed,  3 Jun 2026 09:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Qz92GYJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D5383EF9; Wed,  3 Jun 2026 09:35:26 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0218341A
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cImpvPt0tmemAoPekt8POKIkndegcrvPCau5sCKhAEJq/7Tgvz6cmJgezGzlrNJzvPXOfxkMeF527OQ5fJmOYbq8+a56uMlU9s4dCjDeXthh2Wh4lX/H6AyK3SRTfJuDH4aaFzIANzK7mjdo50OXPEvZ2oG+lX9gdcqmGgA0el+TBTfruXOVCT9N9xmuTEteJWmKCsF3ZXxwhoDzqTcjS25T3NGvmJ+4YU1jjsiXUbVznOslglyz73W7ygnklIxDXm6B6J32dPhYZ5fc1UJRDqYzXmCYIlhm6Xea1RF8/cWxVMxJUIJC4bAl0/o7qBOfMAEiuZiOIYbpCIUipB/Z3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdLq7a8PioeVcug2T3trIeyv7hVT5jIdTMUH00ZVjvk=;
 b=X291ADaxzZ61u8zcE6e4vD7gd6Ri3X54Czc6esp00mYp+OlZvV6LsjvdEobOlmbUxjJNyESMojsrPKM3ZznXw7hBotjcp53nFpBp0oIB+Ecc7z4nG0xOQvInmPnLxBSvsLlkUrJDm6AW5XVzBD8a1hCvhwCQGUOEb/cEcDLnYSG12GUcd6/2yO7fJvowZEPsYDYUKBkYShoq+NRKzI19QBc9L1PdEjZGaSiLFuvWisORmqMMZ3Lm6QDeGItDAJo7z35IntUlXkOrStWQISws1t99El13UmrhporetGxtg0ZaH86p6lVrUlxXSUKCf+tcHo2/OyM+MNeqRjj9MLgfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdLq7a8PioeVcug2T3trIeyv7hVT5jIdTMUH00ZVjvk=;
 b=Qz92GYJT9Dtz3vObZie6DtZ/qJXd5FGbE1E2rlVKtmUWvZPVqkUycN3oftMtsa0auwYAAH3DZcu7hEGnZ0c6+WOSqxdaED3/u8v2zAvBbwIoy9hen4/XDqEyMnHJlciGAVbgsOu74IszV6dwd4ShDgdZnTMCGVpNc9ZnfgSR9L17SxKFAtQ+VBRn2kzNIUPHuUMvJCHKKa71x3FFKJbPr6OoR3tIepFw0aT/CM8QS2pYUcRwZwps96ykuAa3CIj2H4yVBxfFPNoiFDB7TnhoqdM/RcOzzz18t16X/LRrJ0PPQ95T1D8yvx+0BqCOBa1GHI5eQo4pDcx3pqP4Jfh8lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by BL1PR03MB5958.namprd03.prod.outlook.com (2603:10b6:208:313::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 3 Jun 2026
 07:35:21 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:35:21 +0000
Message-ID: <d79e4b7b-9e38-410e-90a7-0f9cc0ce9899@altera.com>
Date: Wed, 3 Jun 2026 15:35:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
 <20260518011245.19083-4-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260518011245.19083-4-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|BL1PR03MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: a959ef0a-25ca-4b35-1a17-08dec142aac0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|55112099003|22082099003|4143699003|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: PwZBM5bVu3XgRP+vuqieHPPlzfdraZEKhQPQIyTkg03od6vgyhBKx9qy2xtwuHlsHohyTLbKCmmZ4/e/ckA7irDwhkbWP8FFlJmldUoh+WlwA4Cma2dH8Uarr+0i950hofqislGZ4WZjjI2JvO6wwDgmSd6LqTdwbf2gAEHubOJQ58OulmX5oMSYNc4UshcePiIC2NLW3Dkq7rjdgUpLA6R+4DgUqWnUBrc+jq+n7X9aqoRmULJ9Sw2Etn6OexlmZrS+Uy+1u1ZKiM/dwD3N9yZnYJE48+Pa0tIkv3MQCLQm5NP+4EdX/SstyBRhYQsUlKtFh39USmx1EPieQn2D/l5NWJIBxPYOYSnKBFpjV2GgsXFXfKvw9sjsGWjjnnXplp6ZoUzLpViPDDYtDNAwp8nC79YzCVYYtzL5SkftfKVivYKQLvQ938SeQZG6ZyIlNbdN8zzfTDoScl0ypCBEyw7nr29sqBPc7tZpMFJYThNnZzFBDdDVmGse5sWuYxtbdUbWMp033LyZkKGSTKchalfJ8+8olBp6sCBGP20Dn1USTgdmwNROVXcK7ZYqOpCCZxmKph1XLVQEHNS75JyjMtf9GljSpvwy0uOmOkbBLvThPXlIgrt5VgkLBpsvabeRSToTAf4WLDeGW25eC9S8buBHX3xRFv6SWk090fRLG2Svk0bJVqKzj8+cDrusy79H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(55112099003)(22082099003)(4143699003)(18002099003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1dyMjFpS2lydnlPbFBmaUIycjMvZ1JwZHk5cWFvQ2dIYnR0Y21Ua2pFYWhN?=
 =?utf-8?B?WDFNTE1vdVRMNzNGVlozZHkveVBlc1VrRENnRnF5TjdGeDNJWHdSTVQ2SU13?=
 =?utf-8?B?MUZLcy81bnRseE9xK3RkVWtXUU8yeW5RSWVhR250Uk15QlpRZHNKZFo0eFY3?=
 =?utf-8?B?YktoTXJvT3YxNW41MHZ5YUpEdXNkS2FkSW1uRFdTZ1pRZGs5cGtIanZBMmQ1?=
 =?utf-8?B?RURIWENBVU4rcG1tNThIMFNXakhEb3FjTHFhQWxCUndxSWFIckhIeDNsUjJz?=
 =?utf-8?B?QmxzSytrdTFhTDlxS1FvcWh5dTQxN091T2h3MXdQRU43c1JYVEtsNE1Ea1RG?=
 =?utf-8?B?WkNtRzhvbDlHa0QzdGtPcmVsdW04MGx6VXpRdTdHbUZMcDRBeENleEptdC92?=
 =?utf-8?B?YzZDTVNNbWxKWGNaTUhZSVZ0V2Y5UXVJNlZocnFnK1NkTkpLRk9nYWorU3Vu?=
 =?utf-8?B?MDFMQi84Zzk3Y0lnWGtlSkdaQjlneHk4ZURIRDFrS1JxUlN2UHpYdUczL0xZ?=
 =?utf-8?B?MDQyMmpxQlNaTk9GOVFJWUlBcnc3NXhqcWpNWjZpWTRYTHo0dFlST2tJTFIv?=
 =?utf-8?B?ZTREL0FTaFZENDdyY0NlNUZsZUVWUHJSZTRaUUIxZjRkTmtkSjVmMVpGTnhn?=
 =?utf-8?B?MjFDRjlURllZVFV6K2NZS2w4NTVreHMzOGcyczhraEpOSUhqaDZPSGJpTzBR?=
 =?utf-8?B?c3JsVjk5d3lhSWdzZndqT3N2Z3pmQVV0T096ZmFqTlB4UXcxa09GaEtpdUlU?=
 =?utf-8?B?dWV2eUs3ZnBieWQ1bE9QVmNzUS9Gd2FwdlVaY3RDWTIzVFlCTW80VHlzcDZH?=
 =?utf-8?B?WjY2UGNPRFd1WHF2SWFSZ0FuS2pROThLalNWK0hYY0VNeklmQ3hzYXMzUC9u?=
 =?utf-8?B?cFdEMmpWc2dMV1FhVFluZTZKbC9ZelJiRFZCS2R2aStSd3JSK0gzcVR2THMw?=
 =?utf-8?B?aTlRQjRUVklQMmNNNFJVbU5oWm5DVWNHM0dxVWdZZGpnQlhmR0kyT3V4N05w?=
 =?utf-8?B?WnN3ZzRtZ3Bvc3ZhUGRMMEJNcG5QemFmSzU3RVFrTkpLMExiUkcydFNIZmRZ?=
 =?utf-8?B?ZEFmbGl5MGNsUEdRTVREWklJd3ZkeWxuUHNHWEdkKys5OEd1TmFWVmkzL2dm?=
 =?utf-8?B?dWh4ZUZyclhsRUphbDN2WlBUS2g2WnljMys2WlJaRGl1NjlSTWNUbkJwUThP?=
 =?utf-8?B?clpDVTl5S0ZuNnpnaE9pdHc4NnMxQWVvQ2wxVnQ2bXZzL2tUenZnK0JNaU1C?=
 =?utf-8?B?aHI0SDVLSEcrZ1h2Rkc0TFMwN1Z4Z0dUSFRtSHZhYWtQTkUxS3BHYmdFSkZn?=
 =?utf-8?B?MUFnQjZpMGkxY0dsa3R2b0twWGdpSkF6UE5tdzJPNitQUStPTnZFMDJVQ0RH?=
 =?utf-8?B?R0NYMjZ3eW9XZDJFQmFRSDdGNThJMHNwclhKMTFDaU93OVRZeXp4aFl4L1Ux?=
 =?utf-8?B?Q2FtRHd1YzVTdThvenVPTTR5dlFmNmt2MGszeFcrd0JXaGVIM2E4S0ZYa3dw?=
 =?utf-8?B?M1ZtR3R5eVJhY2Y1bjVucHRLRUg3eW14cG1sTk8vVVlNOU80c0UvMkpGWTFV?=
 =?utf-8?B?aFZWeG12cjlKRmNNTlNzZXRBMUFIV29sZkRTUThUOEtKMklUaUxIL2UrcjBD?=
 =?utf-8?B?YTlnS1dUY2MvRU0yUFNLMGNjeWszZmY3UFFuVlE1c2Ewd3MzaUdKQ2xnK1JN?=
 =?utf-8?B?TnRkNXV4dWdWb3NQaVd2SGxxUGNPUkNYeWY1bUc0MDNuRnB1SElhYlFMK242?=
 =?utf-8?B?SDEvNmlqREcvOG9ZWG5xMmZKQlpKN1VrRDdpTFB1SnZUa2gxOEJYTWYwaW9I?=
 =?utf-8?B?dHlESm5GanV6VU5kbi82SmtUZHYwZEZuUFZVWi9LTEVlMU0wQzR0UWhqbVd0?=
 =?utf-8?B?cHlTSFFZbzFBRC8zQXk0aE1RbnpMU2wwRi8rM3dHaHpORHc1bzhZSHRsVEpS?=
 =?utf-8?B?QzJQQlVXcDJTWTJzNjdjRWcrUDE0ZlhINmVMTEhvc1l1ZWp6Vk9qZy9kbUx1?=
 =?utf-8?B?bk8zSUJ6MzVhMktkNHd4OHFYWGRSYzBUQkpOeGM2QlZoYkNsS1N0WExpdGpO?=
 =?utf-8?B?YVZrVXM0cjBJRDdJbHg2Z0NuejR3TUtZejlWUndGbXVaRkNUcTBET244Vmwz?=
 =?utf-8?B?TVlEYVlNNjlrLzIydjBwZnhpSFVKZ0V6Wk1XLzNLUXhQSktFcG1iMDRBUW45?=
 =?utf-8?B?L21pU2FkTGsyWHZzL1ZmaXI0bGRER3hpMCttRy9paXdzT1R4ajJLSXlyYXJu?=
 =?utf-8?B?dWNZZTZCLy9PT3dpZEhzVmZzdW9iVDJPdGhOUEJJcGttQnZiY1J1bU9sL2g2?=
 =?utf-8?B?cmRqc2Z3UW9vTXl0L3RINTBjenpXMGhmODg5cjFpRjAwaEVRSWpHWkprVnkw?=
 =?utf-8?Q?sI2bpeU1Zt8uLTFw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a959ef0a-25ca-4b35-1a17-08dec142aac0
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:35:21.1244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdTiG1kANP2KPcnPGnIr+bMlIfAmgrMdCSNVMy/bhHMJW2o4PMf3sPMK1Me8dnfCNd1qeBsqxkmlN9SnMxACV7t4BTCYknoVF986czasits=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR03MB5958
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

Hi Alif,


On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Migrate the CCU, firewall, and high privilege register configurations from
> hardcoded values in the source code to the device tree.
>
> This helps to centralize hardware configuration, improves maintainability,
> and allows easier customization for different platforms.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Add at least one header - L4 per/sys firewall moved to 
socfpga_soc64_u-boot.dtsi (same tables Agilex uses); replaces 
firewall_setup() in PARENT spl_s10.c.


Best regards,

Tien Fong

