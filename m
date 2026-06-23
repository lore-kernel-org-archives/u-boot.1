Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 924EBCDB46F
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9F16849BB;
	Tue, 23 Jun 2026 16:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="naNxOZGm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB10B849D2; Tue, 23 Jun 2026 16:12:15 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75066848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCvlpdz0AjDikt5VcBZKChcNZFZu1PR7cNSz7oppzn4X+lJPOFi4FBY2mVjG0HNAoy75/3ck65y8xsvRraaSj28J98KnouTqCPcUAJHBljjwrKf6e+Wp17MwG8S85Ox3OYF1EwR32Txc5NjRYQLWgb13IhGnB8/V1D/YR8ySqfPznZ2tHgJOIaxoO2MlFOlWLAIHvXC7BPq7PWG/Rp0uKXZuddKww/8usIO0mBhJuI55OfYkhEj9QfJUS5ijheNM8wiiO/Jonu0bgAv0MKb1+VD7UXyyBkeUcAm1zEB4dIUQFCpYv3H9Hb5NSCyxF18cORGpTs70qBvbOOgBego/Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MVtLda3RAYk1Gx6gb0uYN9vUvPHcuQ/011H6xtCOZiY=;
 b=Cq5YoEHCwv8Jd+mPzukcnMtfSmtNmXOeeA1J4B9jL94WXB4fdS7kpOV20xAOVbXiLKuD0p05Vw+Lc/i3ouHxPp+to8i0OdqNDQl3Ueg4lvGIuptWJZlea3BCppTYFiliEBCvrtWVgEg0M/UP32Mu44TZKlynOeUh/3hMRGAgMmCbuynMtDocTC8p61UwKSNgQjORXY49o8gfDFuXk7h5Sz8sk0+dgBgSrdMIb7fBw+blcH1tbfPwzScofitDjX4slIzBMf3zpw9X7zyTW30kyPVdjBTRke0K9r8u2nFEEA4zkozbqwE/+TRxt5CL9iYDPIYGNRQeTs7gF88bYDkpsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MVtLda3RAYk1Gx6gb0uYN9vUvPHcuQ/011H6xtCOZiY=;
 b=naNxOZGmIaEVGSBK5FmkQvQ5BBICOfEb9s8nday1uJmfhMU5ZhedO8TAC0joa5ibEEPhIugDiUXXxVfy+ytYp0WCXMqgtuphX63Kse961uXWU6HE2BuuXjKNpZLHuh5t2GAKR3PRUvYFaLmicFqYMX7ekiL8jLI8FVyY86rHaus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA2PR04MB10471.eurprd04.prod.outlook.com (2603:10a6:102:41f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 14:12:10 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 14:12:10 +0000
Message-ID: <d40725cf-7f70-4038-8a67-aafe04f90119@cherry.de>
Date: Tue, 23 Jun 2026 16:12:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 4/4] all: Fix lists.denx.de links to
 lists.u-boot-project.org
To: Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Heiko Schocher
 <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>,
 Simon Gaynor <simon.gaynor@ezurio.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Yao Zi <me@ziyao.cc>
References: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
 <20260623-osuosl-ml-switch-v2-4-28fd46e89e46@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260623-osuosl-ml-switch-v2-4-28fd46e89e46@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: WA3PEPF0000051B.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::676) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA2PR04MB10471:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e9e7ce-fa66-45bb-3713-08ded1316a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|7416014|376014|366016|4143699003|5023799004|56012099006|11063799006|6133799003|22082099003|18002099003|4133799003;
X-Microsoft-Antispam-Message-Info: lI9Yb3cxS6mkYNKOcAfRe5EBfyEEFJSUbn30LC4JkTiZiR/FmroWKGPgfFUKF2BNtcDtg6N4/B9rNxEJ6nePJwUgQ6IXCqvCLU/LAcqc7luEhnu67ZrLDuzw1kiqeG0vfopxsZA5PJpSMgYPXZWwbE2PzJtoMg+04Fp8EOfrJ3PPBQ5pYD0Cu/l2Z3Aq2fUNa8jXt9XcSCC9nDzX0uTZw7RRxBqIcd42cqaP23fH2etNra69KnsEBMhZPOHwXGnwW+dbKanLpUZTieweEOGU+y5s2YguX2Dvq1Qen2CGOX4zWl+zb21sEnc6AcX0tnfVNN1IVAvwK3nRm4xxGm+30kzyrBldH/Yxd7Gr3gruTjjLaMIb/K+REswryHU3Jf62b8FXuyZgs24dbk534zdepQM3G17LtwiQpQ2hwFNYENzih5YG2lBxJXKWhr14TKGSp0Ke+/U/KR/hzn59P2nQxrixJLKmWWLj/Zs3mtLe8Hxs+aTkPpmVkco4QRVcVkDW0WQeNCNISdbTyq2/zeqEiayRtvrXibBklAWGXsVTvmMS/EVS4gv2Vckgknqwb7Ym+Xsb2ioZxLhtUdlTBXpZEPkrIKo5CHCiLx7mEv0K/ev7EJ12vRfQNvdRmsFHDjjj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(4143699003)(5023799004)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjJCMDNpSlAxcDFNSHlZMXFtUWY0OXYvVGVVQTNpWXZKRWoxbnRPNE9sM2kw?=
 =?utf-8?B?NU9LbEVja1BiYmNlSTlBcjFLUXFodC9ZTEJQU2xHK2w4cFVnUTFsV2s3dTJQ?=
 =?utf-8?B?cG1SMXZMdG80eGNlWXlOTDJudjNuekhNTE5ReDloUGoyVVlDWnVpN0tkNVhh?=
 =?utf-8?B?akZHNjdBZ2JtUm13aHVFYUpOMUJjNkNCeTlzTTdBWGxmWmVRMklDL3VUb09u?=
 =?utf-8?B?MGRWdElpdUFsVlRBYlZzbjdmUXlOUUUwbWtveHVqZFd0TTJ5THpZbGtJRWNt?=
 =?utf-8?B?UTR0N3lTZ082cHJMeWp0VXgxNGNQSnZFancyREdpTkdHcG1ZcStGdklSZnJI?=
 =?utf-8?B?VWRGOTNPSjRJUHYxSS9sRWxKSDR1RCtleUNlUnlaOHdLWHNRQ1pCSTV6MWMw?=
 =?utf-8?B?LzQrMGw5ODhDbFVNcXdNOE5PMGprWnNHOEx0d1hWb1J4OVVKdVh2ckxkV29G?=
 =?utf-8?B?eDA0clFLdnhnRXNJRjRUYy9xTjNpb1pqSXo2YjJSbWJWaWJ1TDI1akhLL01S?=
 =?utf-8?B?OGkyL1JHK2RMTTRsNDdBN2FSOFJyQWNxdXgxeUhHTkJMZVFOKzRYUHh6cWRK?=
 =?utf-8?B?RFh2TUdmT1JrVlJRc0c1UDVQZnJObkVSK0FFeUdpVWdSMi8xVkVuOEJVcGsx?=
 =?utf-8?B?RENpTEFDOWsxT1NRSjRJQkFwVmhtUjVpV2NzMXlQRnJhY2JudndxQWxabWhx?=
 =?utf-8?B?K0hDZStJcHUvNTRPaVpPUFNZUWZGSnNHS296NFRMeXpjbmVBM2J3cEN2YVhG?=
 =?utf-8?B?bTQ4eG9GZjlpeXR5UG4xMUxJTm4yeHhwdEtOdll0N3lvaXl1SEg2RW9HUmxF?=
 =?utf-8?B?OWxLcnh2ZW1URGlIWjNTSjlnOGR0VXBHM2Zqb1cwRE5OSS93ajUwSU1idEZo?=
 =?utf-8?B?VExDaDN2TEsvMGprci9aVnNlSFdTVDhQdm9LVzdRSG85UXIyNkFhV05JclRK?=
 =?utf-8?B?SGVDV0JhUUt1cHRVU2ZNQlBpTGhOOUE4VVJzdUVQa0pBUEVYc1E2emZ4TGhG?=
 =?utf-8?B?WWV1UXRQYlRqTTk4TnQvbGtOeUdNMDNDUU5ZU0RWMmZpZ0I4U2JJNnVJSVpM?=
 =?utf-8?B?ZHdldkFkRlpyMFhZRGdEaUh5TXNDME1Jek4rWWVLSVJTTGVUWkEvdGV6Z0lq?=
 =?utf-8?B?THBpZ0ZrRUxHTERpeE9lM1lpRVUxeEx0V2VHcDJDZ2lHNXJRUytNU0RLdlAz?=
 =?utf-8?B?RWJIUUJuM3M5bTJSeU9qOVFPQnJabUJadnFwWGYycHB6TWZwWGcya1E0Mkxp?=
 =?utf-8?B?U1FBZFZVSzN3WXh2VnJ2MHI1YnN6UlpNSlZ6UXBvOCtrTWJRcnVSWEpnWlVU?=
 =?utf-8?B?QUt6dXRUaHdSd1I0L25VdElVSmhuODQrL0J0eW9odjVTbFNlOUpDVUdjdURo?=
 =?utf-8?B?b2wyNnRiUVpqU2tpU1llSE9aV2ZoUEU2VzAwTjIxZ28yVUNmc3dIQTNxZ3Rq?=
 =?utf-8?B?TlFwbXgrSW90TFFiNWtTWFFGS2txWkFvdkdISkhONHdNTnJrMUVpb0d4RWJC?=
 =?utf-8?B?TzM2ckZHck9IY2ZXSzlaZWRCNCt2YmRWM1R3SGJCRzV5Q0ZuSFZlQ0RnOUFR?=
 =?utf-8?B?d3dzeFl4dENJcHFKN2lQVE1vNE1jWG5YeXhaR1RncVhZT2R1bXZmL3VEZVNl?=
 =?utf-8?B?VVRLSkJiUjE5UnBncEJ5ZmRPL2c4NkxtKzJJV0RHcEh3K0tJRXd0OHFmYmxk?=
 =?utf-8?B?Nzg0SGNHK0lMUFd6b1JoZ1JqQ2NPb0pKeTdpTytrS2FnaGhBYkNHRG1LRWRB?=
 =?utf-8?B?UjZCam1KZUVxQ0p4aDBjbnc1Z0tuUkJUOGg1Mk1OSVBNTkZ3Mk96L2pjNlNL?=
 =?utf-8?B?dWVmQml5QVduWXNWQllGcmJZOEg0TmN5TGk3bzJVdmJmc24xYkNHMVV2VnRp?=
 =?utf-8?B?UHZwWnhkQ2tENzlyaHlaa1hGaU9kbFhEK3Jrb1JlNW16RlhHeXc0dytHcXcr?=
 =?utf-8?B?dE8wdEtuVTUzTjBtMlZ0UTBlQnZDeHpRRW5KR0R0S2hHY0tLMnQwengrb1Bn?=
 =?utf-8?B?a2d1elhmTCtBNFVUR2hKMmpBbkVwSUdqVkt5eG16RFNtdHZJUU9XVFpUOUlP?=
 =?utf-8?B?MFhqZ0lxQVlSR0VKSm1RNGFhQStoeUk3WWRjdnI5NHdHeHYzNWFwa3VVQStP?=
 =?utf-8?B?MTl6aTEzUGlITnVaeTd1NUdIYzdTc1M5M3VBOXRkOWlXaEYxUUVJd1BPM3Zj?=
 =?utf-8?B?YjhuY3hXUUZnZmdaVDFIbVQxS0YyWXBiQ214VW5PUFp1ZDRTVkRuVEY2S3p1?=
 =?utf-8?B?VnpRY2VxUE9pbXh0UkcxRFNGZ1lLakczSHUzdElienB2UHBGaEVoL2Z3NGZv?=
 =?utf-8?B?Ym5EZDhJdUlYWnJwOXBQUTBObHhtZUY4TEtQUzBwOXRlN2hpM2hxdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e9e7ce-fa66-45bb-3713-08ded1316a4b
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 14:12:10.2467 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo+/2yfryUDzvmRekvlEfbMVmKuS+HKOrx73rV0C7CZcOdpzxja3YIuyAUwkjrMllHq51ziEbdZLpNETF53mKaXW5p8dcA8TlQv+gNTIFTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10471
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

Hi Neil,

On 6/23/26 3:22 PM, Neil Armstrong wrote:
> The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> domain, so fix all the links in comments still referencing the
> list.denx.de domain to the new domain.
> 
> The URLs were manually updated since the mailman links don't
> match anymore after the archive import in the new mailman instance.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/powerpc/config.mk           | 2 +-
>   board/boundary/nitrogen6x/README | 2 +-
>   lib/efi_selftest/efi_selftest.c  | 2 +-
>   tools/rkcommon.c                 | 4 ++--
>   4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
> index 6e30df6504e..26fcdc4e884 100644
> --- a/arch/powerpc/config.mk
> +++ b/arch/powerpc/config.mk
> @@ -32,7 +32,7 @@ archprepare: checkgcc4
>   
>   # GCC 3.x is reported to have problems generating the type of relocation
>   # that U-Boot wants.
> -# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.html
> +# See http://lists.u-boot-project.org/pipermail/u-boot/2012-September/135156.html

Sorry for the mangled URLs, it's changed company-wide at the 
server-level so nothing I can do about it. We went from "please don't 
click on any suspicious link because security" to "click on this very 
long and incomprehensible link wink wink", I'll never understand.....

In any case, wrong link. You want: 
https://lore.kernel.org/u-boot/1348500648.2514.2.camel@petert/ or 
https://lists.u-boot-project.org/pipermail/u-boot/2012-September/134737.html 
if you want to stay on our archives.

Cheers,
Quentin
