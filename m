Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F94CD98E4
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 02:00:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E218B8499C;
	Thu, 18 Jun 2026 04:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bwhFF4jz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24B08495C; Thu, 18 Jun 2026 04:00:02 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF5FB8495C
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 04:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8YpxMtd1TXk7CWzw+ZjgGivEhokjF6uwDO7If7lSCJzeA61hgslji1p9eVaMfa7HLPbWihbVPm602L1XKj0qZFazYASbok96kFUDcbIM7BcttYIdE1jKc9qrsihU6eKwyGHDUiKsySGmHAygPXxlLtptUTCJO2zwrxReFBQHWVuSnJ5Z3N3q0Wi1oXYCJR3pivwL4s1nFiTEOqOE7apUbP75dupRoYN46QsCcceyYV7eRVytZ3hyh0IRlw3YqL5WANSXr1t1vYcu6wLSJVETOkIlEmsBaDrE5vIuJDBmiMDFHCSam6ogawictlx6rWnPQAjYPBgd+E2fVWGjd9+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrOVs5XbG6H7dFZcc8MLZHkugAj3DSnoHM2bkHM3e6Y=;
 b=Chjsa3KyuARU9XBISzzTAjq/MbjxrdfMvlZ9Et8GabmjWIbeE+0CxmQQrPUWKsdMigSIpOFXOeYQdYSzr75PY0vooJCmh3ea9TLRMroRF1zlCtDNRoolzg2u3NtyQwDZl5gHnPNTjPh3fUcJmSbmIuLQT3sRrGyp3ngvhMt1PTtlo6Yz+TXZFEoA9BbiZLYAW2J5TI3WwZtRc2DxSxshBI66JV/4BAMpC7YzoF8rY3rmKOnTOxAhSg1WF0/A0uzZ9gwwUKob/fTchWdtsA9dxZyEdy/1BsKcgX9rxmBMfp6rjWN8KzCQJqsMOGZkpeUGq6kmG3DK2LDssLxo0QdJAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrOVs5XbG6H7dFZcc8MLZHkugAj3DSnoHM2bkHM3e6Y=;
 b=bwhFF4jz7loc4EN2DaihmAjekgcyrCbQaI5p+1vkdKLRcuupZEzV8IM3VHbnjPzl87jkkmlCTXSDWXhth4mAlWAGDa6hzK+3tiUSK/MzIWSHuujTfBv2e6/PZaWZmEomWJOtCb5gkPTwSjjidttYRi593FNjxo1acx54Yt/0pCmDqaRPARGrc+Oxjq5PiLbeaw/vPVEpdtDsuj8C1LcstueCsQ99N3Z5Dd5DGpal82fl2w5pdwpZ0TUJqCjCySKcGAIAZm1cOC0nPsCJRLccCG91p39t275TvegGnp3XYbly9swFZrVcRFDAkMsG5MCwLkjr5379yZ1NJOoS+vKYww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 01:59:59 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 01:59:59 +0000
Date: Thu, 18 Jun 2026 10:03:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: ye.li@oss.nxp.com
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
Subject: Re: [PATCH 3/3] imx9: scmi: use 48-bit MAC add instead of
 incrementing mac[5]
Message-ID: <ajNR40PYgH5MJ/Nu@shlinux89>
References: <20260618011749.2871269-1-ye.li@oss.nxp.com>
 <20260618011749.2871269-3-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618011749.2871269-3-ye.li@oss.nxp.com>
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DB8PR04MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: b2eaf886-1f96-40c1-69dc-08deccdd4d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 6pSwvzd4Ww73gt9mSwkwmXPZj8ByXVBm/TIeKDMKolIIXgL35l0CKnPuekbOGdVuDtQTje0gd7cmdpL91My8e2vodpz8qf4FQ+L+Ntwt8Z/p/rMgvtTOg6Pcp4kNBQhUX82fXU4Tli9CmLG+d/GvDd5nXzLMhBlhEcwVvW5WBx4a7EkSFzyTlJOg9qbvIOJfjwZSmat9Hd67Nbwg4uDjFXIGrx/OeUeKi0tWJxlPcm3whvVBLMp2sfx01wEPph7yVazuvoZocQQI989hvsXYl67LpduHHMjX4mnO5/nfPxTZUt9NlLUhEpIz9kWMx4PA3lnP5+TeSbaSJR8Z4VlmrU8KSoBoiqMPtdb/7gszKUqf8rNxoHtsoejenbvh51VuT5Z1mCKhBljGTysoEgFCq9dU8nRSsWditri+imuqePt5j/FMN5qI9QWAs5QMoPGJe0pHpdr05eNtUOLfj6FGxT6yyv35WcR+NQGskD5sj4gtZ7tX5Qnp5u/Y53NkqpzVpaVuYxtmPdA7JWXB+2Eqx/BF1rukanM2fA+dhSfQKaQRoT0rB7521rC/kFSRyWv9rI5TKX7I7E+XLkPQH/kTUBwvaBSiHkpdopsr90zo0wfPbG+KN/l46xZOgLBKZDmcG6KpmHO9TFo4ih8HO1BoTnJQgDYORsOplZKIr/m7SCGtg9Q3uiNwbcQ2OMbLYEjQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zOhxrPpdZPMSMlVLVomZo3/KtaMEo1bL6EezXNSL3L8wxYU3ZRb20lQK27yK?=
 =?us-ascii?Q?u7XQN5NHIO4OZzP9ibfXxcoos+5MCcM4kXqY0CxR5DeUNU8BPWarKapEKO44?=
 =?us-ascii?Q?NbyPbUXEgonYUy0860lXIV+C5fx1SZNUDyl1nfslolRAm9jyj5f0KwEHpFyi?=
 =?us-ascii?Q?jAjcn/E5Ls3368qKkoKn26erzwO+EAamovT4y6i9xNk17cVTikYtIsAvuXaC?=
 =?us-ascii?Q?65RAfeUreSzthVjJpQCLxYobLoiyACZjBsoCum7ClEchbM1njGtfT9t2qSHP?=
 =?us-ascii?Q?ZTfyPwt9LmiyhShc0O9S57y1U61mmLnWRgzzc/54rOyv20QwW98R/gGI5Qm6?=
 =?us-ascii?Q?uZ4Ka6z5T/Tj9rgTHgTNm8JDRHomr9H14iNvyjDG2uPf5N63seftKvCrTj+h?=
 =?us-ascii?Q?nqaJMMGflyLryrPvSpTO6RgZXlLc1y0E13H3i+oIBfWV8/NbfJW/aS1vsIm8?=
 =?us-ascii?Q?EFvYFSRKVGIU7LR4cfTLB50rOo2sa8wl/7/Nyp/R+jFN0bdFi2htG+r34wwr?=
 =?us-ascii?Q?P5Y2SPTOwmjd3qjBsIil96fftiQq/MFQESjwluYXWCdVrkaSr/QdRXsQz4Ja?=
 =?us-ascii?Q?X/Nnd9B6cpuJqzvbpu9HWzbWov1+V6IAn49SdpCbu8d43xvBzPnEbCWmJZjd?=
 =?us-ascii?Q?WptJL4Q4l9mTSFXfN2FWSjJ7prJSzQZudnKx7gQSZpSvyz9bOUJ0VVCoouiz?=
 =?us-ascii?Q?x7qN7Ziy7rwnBqqkvzzc+9caBmfkTrVgn0dDEOreyMcmIxUPdOuL9VvcPyVa?=
 =?us-ascii?Q?UIqNZJwLpuR4JSJeTy84xMKvsB962UBRQ1nK9mJJndcyu3z3DjM8ekhawXvK?=
 =?us-ascii?Q?NxQ78rJv8rSOXg9LoStD96jYXNt53BHY5F8/NY46Y7xwVP69sKWANtubQyt/?=
 =?us-ascii?Q?M8KObaBGugxk/xLjr3sexslm3Ov3IRkaqSg0Fzvr6kXhC55+31HoHVZMzEB1?=
 =?us-ascii?Q?ZW5LB+u2NZuwwItGI0zoY/LVdPhjl1bHGEZtUWCiDH/Gmh/Ui+ZygIn12bPh?=
 =?us-ascii?Q?bOToJNZtxItXbAyvEy6w6dalBHiBsZvHBTdeL9vWM0eVizGsXuwNmrFSOAK/?=
 =?us-ascii?Q?C2gXzOiirMNSus2QIns8p0BODjxYrkXJgMzvpAzE3FfmdAdp1MBKfUmTDry7?=
 =?us-ascii?Q?Orfih22vwGo9p2JkIv6C3fdaM6pTZdDrzwQU0na28azez2sv3iLbYqLE/UwC?=
 =?us-ascii?Q?QFhggzYsnRq/X3w0IWRothAMQH3JsLsOPnqUzEpNuprUpXZ5vg433pTn6OxY?=
 =?us-ascii?Q?U+8Mzcjr5FWSjcQOz4fYgY1mXkD3oFO3sN58eYyU+5i0nnTvueWtNP7DQeul?=
 =?us-ascii?Q?MboGEWiOLXGms44KibfiBizDXaeieXb/IuXXHO2aofGAaptC9EZxQ5d/S8PE?=
 =?us-ascii?Q?xc4USobX7+06ISbLcoH3u21mwyDwpXM6badGSTfPQV9ZYOZJ4O9RtH39DyRr?=
 =?us-ascii?Q?7k2GGStTh5XP6x8b9SjVvi/bglH17yvlUm9iLeKVz7/b+9eTcPVayoljhCEn?=
 =?us-ascii?Q?KINO9BHk3kNEZaKyzAGlB362S/gbv+WZwt80tXh+EUpK7xbM32ZGc/007AqU?=
 =?us-ascii?Q?azhOGI5xm7fsWlB8h659lXQ13KeTnvbI0qgYzapjdYr00pDoOUiy+Zf3tvMZ?=
 =?us-ascii?Q?JjfeQo5PgfcwIuZspxHA4eQ1WH6dl9dlKeSBdd1Bgxu4+7uvKFzI8oxY0awL?=
 =?us-ascii?Q?qA16iexePdca8ZQ5xi6wM9jNaHrHBpmQdhtsh2iXIGB4HZ/zHriG+aJ6nmAS?=
 =?us-ascii?Q?l/CZ7tgWOURMgfGPQi0+dKpCqzwrBByCxYLOBnqHeFltFJo77YHj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2eaf886-1f96-40c1-69dc-08deccdd4d8a
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 01:59:59.4832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSa/BdRVBglM4jvoxJfTr17Jr8j+YL+iPYGyDKUoSk1XkVG3Pxsv4EXhFvSOjJM0aIeBO5cMY3C9KrgbwUFBf9qrNxYpiZDMd66/1Nc/wDx84V6rVWAeLicxiPeDEcjd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
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

On Thu, Jun 18, 2026 at 09:17:49AM +0800, ye.li@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Replace mac[5] += offset with a proper 48-bit MAC address add to avoid
>overflow issues when mac[5] was close to 255.
>
>Example:
>i.MX95 MAC2: 00:11:22:33:44:FE + 6
>Old: 00:11:22:33:44:04 (overflow, wraps to 0)
>New: 00:11:22:33:45:04 (correct carry from mac[5] to mac[4])
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
