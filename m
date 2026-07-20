Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805CFC4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 14:56:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E2F80517;
	Mon, 20 Jul 2026 16:56:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="SKWg7EqW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A07838D7; Mon, 20 Jul 2026 16:56:32 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6DCF80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:56:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAD9le1kbGcOUHyCF+erfAGI51ckDLeeQjB9MfskB4VtdlpFDIu9GJphMsj3qRtlkb3wU08vDr9qIkPnGXJHBMgIwo2cCHVyEBZjzpT96fYF5FWul4GXoJbJltB+dVg51oAypkw3vL3kcJdBaJIkUGM7HwfN/CCCe0J6wvscdOsxCkYomDDdCB0bFdp8n1kTcO9oSZ9a/Ro9/wI4QgnEet5sLkJOcFoizPYCrkBHEMea9JnFMjnTBj3wOLPQhPfiUkqfbTgDVyK5/qAqHWu4XJ2r6mH3AsexknxFhA93HMYy/skPDHSiXAV84F1V/lD/PRIgQyt+tmBG9HZZo1+ENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHX66FiinoLxKIFyT/N11NjwbSQ6cJuVjZ0N41qlQss=;
 b=WwNz8javosIsaHpWsWbCTpNi+oJ4Z/JBTWa16eXKuzBcY+PvRXWvVxBVhUYckr6lR2wJa7jGGLTx/ARtVk2Fm2tGcJKVXM8PNcMBvxMVtLBOdfvZ/XPO/CPCj7H/sWgInmo5GaQyWX8IcL2slZK7daLx/IXOEAxe6MBnjac8LmwWEwCQ0Qj7okO2Oegni5lzUySxd+tcxtctrZsZYvsvuf0xXCe0z8Mit71cZz4BOywyDfQDAnMde3dMnt5PvJl95toycXGlYAFpBDUCKWuLZ0MsLnah7V7950yiCHii2aE0L004u06O5c/fxEWDsT14GxNxzcEE33ldX7v9d4uH7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHX66FiinoLxKIFyT/N11NjwbSQ6cJuVjZ0N41qlQss=;
 b=SKWg7EqWpzIhnHvEtOvBePzvJ/fMF+RnTKjyF7H46BtQZ/TCkCFFjE6U/1mICgOsGccMX7W207cEC0QSHGG27+tv4Uv93g1QdaVZI1vOn3v3AblvWOKycMgp62BtbBef4IR4oDQk6CX6nAWPc2ObRBCljZIaV1r2WwLPLpRCA4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS4PR04MB9483.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 14:56:20 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 14:56:20 +0000
Message-ID: <c94cc81a-3733-4f23-a38a-a1e891b859af@cherry.de>
Date: Mon, 20 Jul 2026 16:56:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] CI: install python-cryptography for world build
To: Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michal Simek
 <michal.simek@amd.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260720131325.37436-1-casey.connolly@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260720131325.37436-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR10CA0085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS4PR04MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a748e91-0db8-42b8-07b5-08dee66f0f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: uRiebNxZH+3K3ZbNedLvFOr9ZPHZ7njggFfqOxYG2U/iOOc/+vgolS9k3XyGMkkn20HSIY0HptVTWxXZszYyO9pM6LQx3C82IVg2H4Z0wwQPqM+9nURT9nuoFY/hUX++SaTtHHuYSfu0CNCnH9yfGYtiqthDKofko/XvQtIvIlwwVS4un4VJB7BoZ7j1YbyPy+uA/MYnv3JLUdGrWuA4sWnCw7rgDz5iLZapL4G9do1h68/ZucmvcLWwt8UGzxukp7V+xlA0l4Y8A8p38F8gEGzMD2ZHbqWEbUHleFcJTuhKVnXPWNZheWvP33xeqGJFU3A9uhuryC9+OgfMoEHcFF9tzheoQ9M3KSHa9vpFjyDdkvAfOuVGN/ZKR1oDgwdZX8qfmIYvbSxJa3mcTDNfaOf2NyQ2+yDWBoBnYzgVaSdnxZDWMZbOZxlyAXPsN3F8+zcg12BG2xBqBduRD01vuhogg4o/5xSHhgFDr929yTon1K17wXnzjPFQYnWcCVGDOa8fblxZP9jHrj8H9pN9KXC2H8LjoA7n8QfmBxyE9t//sLC1oL82URx4VFm4fZZyVEpPnA7mnxWrGpyqGsrEoFK4XLtEmGHrmBTYLiTSapgbbbMkL0Eamh1p0qNYkWDb4ebjES94JFgPBtoUGAy1N1QI3BEz5e+9FWb8sYZbNyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5pcUM2WWFBT1RVNDRYc3NHWTQ5ZjZnVUVReThidTNOdzBMNXRaZVVzK2I3?=
 =?utf-8?B?Q3VjN0RlZHZuUFlsODlheGlYZWtXSVJzSlhmZnYwRXZMYmZhT2RTQXF5SFc5?=
 =?utf-8?B?K0s2WEIzVGxIUUU2WkNWSVV4N253U3FqWE1KZFkvWWhlNnpoWXVCMGxxM3dZ?=
 =?utf-8?B?R2oyT010R1ZVZys4VzdUTDBYejcwRzA2T2FjenlSRWhreHZER1gvVU04TUlU?=
 =?utf-8?B?dVpqUFRyNk5wK3dCZjF6cUFTb1B4bGZSN0lVU2NuWmUvbnpZNDR2VGN0M3lM?=
 =?utf-8?B?aGlIV05UcWtrV0hUSU5JTFowa1VUck1mZXBzaVV3enhudnNZdWYzRWhPOFBs?=
 =?utf-8?B?eXRXNVQ4UGppcTVNUDlSSFVNa21KajV3Q2RocG84L093WWZXSURtT0pLSDJn?=
 =?utf-8?B?OGJJVWRKVFc0K3p1cmRoYmZoZXpnTDB0eU5FcllKYnhQYitJaUJrYmxwYkZi?=
 =?utf-8?B?NmZ0TkxMTHVHWktRTVlzNGROVXZIYURvZk1RL09Wa2dmN21MT0pPcGlaTmZy?=
 =?utf-8?B?aEJLVHFiY0ZQSVBkOFErMEZLRjRDaUpzNDVVa3pxcmZFeDRraHY1QkRVQkkr?=
 =?utf-8?B?WWNYeDZDRVZ3SzI4RGREcCtseFhOTG9RYjNFRU1POTV1emlRMjY1OU5FS3J2?=
 =?utf-8?B?ZklENzJ4eGdhb2lNRTROYmNPejJVSnltTVpoRzFRWHdsaTAwR3JnYk9MdzN2?=
 =?utf-8?B?MXBqdEVObDZ1QUwvQTdhalFFUzhSNWhodTJPRTlVa2VLSFRXd1VobGQrOFNp?=
 =?utf-8?B?OGV2MjhBWlZoSnZOSlA0S2pxNk1PMjgyMDdiRFp6bm0zMWRIOVhDL2FYdFAz?=
 =?utf-8?B?UmhidjIvS2VJOXV1MkwzQkw5SXhpTjVpMGNDU0dzRzhlcmpkdXBieS9iaHhM?=
 =?utf-8?B?dHE3ZHpYSkhyVjBObEF6OWVpZUJCa01PcEtuSWJucXlabXl3MDJXdmVWRFZ6?=
 =?utf-8?B?TXkyT3dKaWRCR3dla1ZUV3d1NVg3cFY0WmR4aFQ1UHQxbUdOeVBsbUxHUWZH?=
 =?utf-8?B?VDV4ZDJHYnYzMG1WSWpKYmlLdFlqUElyVXZBakhDMG8xbGUvb2Jrd3lQQUVn?=
 =?utf-8?B?NkNGSmJ2N2RtR1RHN045NlF3aWh6bjg4SGozK0tjSis4VTBXSGtTWlVFdWJT?=
 =?utf-8?B?Z2tJanFxbmRhd2podFJ4a29KUzRwakJqMTh0akhjdkhEcDJETHgxb1dkY2Zl?=
 =?utf-8?B?VElvTUg3R0VaQ0pPcHY3aU9hOHFmZDRUWnNGTlVycDU2blY0QjBLLzNBYjMx?=
 =?utf-8?B?YjRNbXpNckNhRmkyaFdEc3JiYUZ6aHFpeUNNcVhpR1JJUmhoZXRscmF0V09D?=
 =?utf-8?B?KzVyVm5mdVRsNjUzUUMyMTFVMFlMcDU5cmJTOU16dldlNVQzSDF5TW11dm8y?=
 =?utf-8?B?L2R1eUNMamV3QWpMTTkrWTNSUmptTm9xTFVYb3IzQ3BlWjByUVpnQ1k3ZVY4?=
 =?utf-8?B?MWlLaW9oY0RBc0lNNWdodDA0QWRIaVRzMkpjUnQ3dFJvUS9WajNQZTRRN3hE?=
 =?utf-8?B?ZDdYdXZiQ3R4VWJFOXBDazdneG5TVmxHaVl6ZGpib0dDOGhKd01yN0Uyc3dW?=
 =?utf-8?B?OHVaeUdNT05CS2Z6dlNBZE9mK3hvcGVxT2hqbTRDUCtxNUxGVzQ3K1ljanBr?=
 =?utf-8?B?L3dEUFdpVi84T0tobkI5UVlTQWxjcm16V2FOWnZyUnlxN0oxVDIrZmxrUjV5?=
 =?utf-8?B?a1BaQVVPd3NFSGVkeWM2MnVGT0YyNElrbUduRFZOcWZuUGhvREk0VnZ1NDM4?=
 =?utf-8?B?ZzRBQWt2Mlg4bGtsdzVHQkRucmpLOW5PM0gyWHdCb0RzN1pPSmVqNXBxeXRM?=
 =?utf-8?B?eEhGaEIyN2xnRDdScVFpbksvVWRBK053eE4yNDFiKzVEVWlWVGd6NE1TZDY0?=
 =?utf-8?B?TFMxQVVyaFpUd3lFTFJxOE1uMmZ1UnlGREhtWFZXNzN6ZzJINDAwcEF5Wlcw?=
 =?utf-8?B?OFF2a1AyT3N4OEIyamlFVUFBM3FNUmFPSnpzNGlXaGs5VWh2MTVEempmRXQy?=
 =?utf-8?B?b3JLbXVqVkd0UVBHMVdaNmNENUd3S2NqaWZqRkVVMmx0QTN2TmtIaFlyNUlM?=
 =?utf-8?B?UzZKdFllcUlEVEFHU2pOZU54Qk5rU1BZbGlkN2x1Y0g1TUI0eW5zU1RUOVFt?=
 =?utf-8?B?VVg1ajJwSXprbjBWTkVyM2RYOVArZENnbVoyVllWWkJiZEZqdkpETFVyQ1NT?=
 =?utf-8?B?U25nTGZWd1lwaGs2bU9nYWJncmpDRGxteEloN2JrdUtTNCs0WVhUdFlvSHFH?=
 =?utf-8?B?L255YTRtWnhhRTZlYVpRTHRYWnhYMVZ5cHJyY2dMRDFuU3VQME02WFdDOWdh?=
 =?utf-8?B?bHY5Vkk2WU8xdG1RWWlpUGpGYzlFcE9uMC8wVHFDZjlSNzJNT3hpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a748e91-0db8-42b8-07b5-08dee66f0f3b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:56:20.6097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t43xmnS9klWCBgHoHyiui5/cl/1ke77PW17SjzcW4RlveDKzD2FXDd18pAaXexBpq4vk7kqBxandD9ZGJ9wtncm8xyErxCD8h3N4P3yKjE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9483
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

Hi Casey,

On 7/20/26 3:13 PM, Casey Connolly wrote:
> The mkmbn Python tool used for some Qualcomm platforms needs the
> cryptography module, make sure it's installed so the world build can
> succeed.
> 

I would suggest to have a requirements.txt somewhere in 
tools/qcom/mkmbn/ (or the parent) that reflects all external 
dependencies of mkmbn. This will make it easier for integrators to know 
which dependencies are required for building which part(s) of U-Boot.

Then we can add it to the list of requirements.txt we install in the CI.

Cheers,
Quentin
