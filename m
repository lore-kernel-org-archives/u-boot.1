Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D15EC4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 17:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AB1480EBD;
	Wed, 22 Jul 2026 17:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4oBat1QA_j9N; Wed, 22 Jul 2026 17:12:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1A40280DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784740373;
	bh=m6lpYOeh1YeOWVoOa0W6Q3JoSUtEQ378B9o4Ddwj0W4=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=N24Wl28ToX1aod1N0mLBWohaIPN0C6a9rEbEoWeRbweREAZgwvV+1UFMt6dW8WyTP
	 DpnJ9tWHG7TFNmFAwH7fJ22fxheNKkUsrLktVvzX7VPtnBwFdJb8A7XpGCmtSzOij7
	 +jwXd5AwnKijidyQtdJ/yKRT/G2jOmQBk0gTMiaXmZgAaycbtZQ2rULLU7OvcHm7QX
	 VkOTvqSxTw1xNLOjDUBOejRmf/qhohjiXgLgxQ6k1LTSC8ZwjY5E9EZSyZzsFjJKkS
	 4HDg7XN3K0IC438V/QFUgAoFGieMNQcJr9SDqWB4VngfDkCXGizQqvqEGc5Qhvs1JX
	 s3/nkcwsvn1lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A40280DB9;
	Wed, 22 Jul 2026 17:12:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C55C939E
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB0C460829
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:12:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vJ4unB7ce0Rp for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 17:12:50 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=quentin.schulz@cherry.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1E1E7607FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E1E7607FA
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E1E7607FA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 17:12:49 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9966846A4; Wed, 22 Jul 2026 19:12:47 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6496D83E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 19:12:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUFUWJEaIDRl8RhDKsBVlPgFkeLMVWDCHwLJ0IKYPSNmTBERa70SllkxU9Che4WwRNoNbZ8Y9d0E4VdQcM+4HMSxJmIZSOQKFXuGPxHFgp3uqS/fIJb4McrhAO32YIEh4Zw6j2hfmB84E6ALwrR4KDjpxZ55/1PXAN67aIAvUl6fWHdv1BIrUzcN2pLIwqS2rQqg72mx2yzqr78Y4kFsu6HXcWMreuVmDGU1VZYlq4Dv1ePKbeUSpawpQA817wS7cVPLGyzG9SaJAs3CNTWYPlPf81n7jp5GbTJ7HfsLa3OGOInXP1yr77BXzzUiIjziOJ7HJkjygm0qAylCZygJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6lpYOeh1YeOWVoOa0W6Q3JoSUtEQ378B9o4Ddwj0W4=;
 b=qvtmxyA/l325GleDdat0gk5g0sbuYUNFBVIW4DqUGxCwdFNp1dckAd3YWN6MXU5Kmdp+Dq7Y3WTducE6lDn5Kjjn058z4tBJuYy2KFi+u2WOkuXZV2KXNpCvCRhKMeIih03VCxlMQtiR8v+HnQbBZUl/Edpi8g8qJlDY4WI9/WgTI1V6JTINt6lfrIist0GfFaz9n+xPn95BSS3PKk/6AyKjtWrNNQpuqVMNNiUNJfW3ZhDO6qXLz6o+EyeTJQnONkh1DKIfG4PvHy0jMalbFjVw1nTCit+O8Kmu0vJDvV2W1q/tb/6/N1EBPIBsmwB9mPET4NDowFHdUd2w8ZLe8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AS5PR04MB11417.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:12:43 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Wed, 22 Jul 2026
 17:12:43 +0000
Message-ID: <56c497f8-4109-42a4-95df-7c0e0b6277e8@cherry.de>
Date: Wed, 22 Jul 2026 19:12:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RK3399 TF-A hash verification failure for atf-3
To: Vic B <u-boot@vicb.net>, u-boot@lists.denx.de
References: <alujuCnNh13eRfdA@vicb.net>
Content-Language: en-US
In-Reply-To: <alujuCnNh13eRfdA@vicb.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIVP296CA0104.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:355::9) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AS5PR04MB11417:EE_
X-MS-Office365-Filtering-Correlation-Id: d92955b2-7869-40f8-df6a-08dee8147143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: E+6BWmPya2x8+TMZD/tOtSDJuSVsSb8np5Edvtsyvo8eVNyVnUjE0S42uT2pOejT37utGlF2iQPhpoeoqijx/JQRMxRYQHy+DhgbekkXvmSVuidyIpRW+aEGDxFykbEdk9JGocibQSOlR+BVupMmAFlLCNozGCA3tfiTBIZl+vvgF4wmvk3ibKpKWjZTeGraeaW5GF4SNT90MmSc6+Nr7GSIYJJxZA34XEt6ohFWSm95pGAp2GWXB/mFqr+S2eyRVwzSmb6dTFBWlm3jQMPxj7vTLE2W+JAOpXT+iFwWcpVK2wJbdfpkMxldLs4+oxEHCGW9/qZOOQQMvdUKYP2YBCb6/QQaUY6qnaRTZ93Sop9zId7lJQ3Y2OpVEIcB2LU2hLm8RXot6EgdFHJvE0ygkQ6gmtJkFHAlVMpI6zoe+HG4L3xOyRK6nfFKtkA1YNn3K1Hg57VdQAJ5KUjpsX8g7sPOwtkUreZmV2TkQgfbJZT/CChK4PL5XQLSy7K3Ytkh8MpUDzE2wU0IcMqiq5irN01fY4shiHrSsQ0QYV2nkPZCuR1g2gTMWCZ/dFs+DFtHNUusF4QLnapY1sG1KqAyFUkvcapwLrMHxbpJW/WIFr8jZHh2D4EMWq6Bo5QqtnSC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4133799003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2drM1NNSDA1T2J6MkFXNDEzVHR3TUdmeVFETnpaenp4Rm03OTlkNlp2V0ds?=
 =?utf-8?B?OXozd1VXaHF0Nkpqd1RTeWJZRDRFc3R0elI1ay9Mc3liOFRZZXphL2tpeEtu?=
 =?utf-8?B?YWlwQzV1SUNIUXBiaDVOQWw1NXlqRTdILzYrSW1qVlVqTHAzTGg3K3RldW9J?=
 =?utf-8?B?NVdjRzdwY21vQXlhaFhzTCs1YS9uRDdxR1ErRk85a3JUcThob2VRQlovR1J3?=
 =?utf-8?B?dGQxNitaU2krUi9iSVVlYkg5QUlSZGRlSER3bkt0SFJLSWhzWkFmWThaL3lm?=
 =?utf-8?B?YTR3b1l5cUhGelYrMUNDR2swZVlKayt1K0w3RVJwajlNRWptTmpsTlpreUZN?=
 =?utf-8?B?L0ZUaVlYUUZSejU5dFUrSDdKT01tc1FzaUwvQm9KbERTckN2YmRjWmR1bFBh?=
 =?utf-8?B?aG9PTTB5MGdKVXdmM2dneGkzK0kzRHc5Y0lYVjduTUNLRzhHOTNSMUNpUUVs?=
 =?utf-8?B?Y0R4ZWQrTHAvWjlaK3VNeCtpTTNSckxWS05BR2VZRkxPYm0vUXc2QjZsTHRq?=
 =?utf-8?B?TWlKNHRGR2xlSjY3Z1p0SEVNN3cyM3JCUzJLeXArcVB2aDZPb2JHZGZIYmVn?=
 =?utf-8?B?dFJFbDRMajB5Ym5TbC9KZ1hNaS9HeEwzZnZYcTJ4SktvR3RpNS9zWW9WS3RE?=
 =?utf-8?B?dXpFOVJxVWd1NkRTRVBKdmpjMVhxanJLVGpQQm90QnJVYUk5a3drNEcydHgv?=
 =?utf-8?B?M2FPUzU0L2xBNVFuMUhjWmdQL3J0RFF0eGpjbURxbk9LV2gxclhvcFFkZFZE?=
 =?utf-8?B?anRybW4yV1JtdDl5byswMHlpZ1lEcS9ha1NwSmFheDBMNXhxS0tPenRNWEt1?=
 =?utf-8?B?a1MrbDdlZXZKM2M1YU90NDZnYnJhSWRTeG02UkJkOUtZZ3V5TmVzUTdJR0VH?=
 =?utf-8?B?QjVGSGZDV1ZZWk9wNWFWbUxCVzlZSThlZmtjVEkwdktUM1VqTjBBZ0RGT2hR?=
 =?utf-8?B?bzdGK0l0QjhQMlJOdzVXNVVYViszaklKVTB2c0hFbUQzUURGZ1I5YmYzVEpB?=
 =?utf-8?B?MUw5bzRGYWM4azlMSm8xSk9jd3pldmVxTVI0Y041b05JeUFkQVJPVklpL3Fo?=
 =?utf-8?B?eFZlWVIvTkM3NkxZNlBJWjVEVlkrckZVUkdYM0VoQlp4UWdpcDgxR0RGSUFG?=
 =?utf-8?B?OUlNNmF2eDZ4SXdrckxPTm9DbHo1T1dyV1p0anpKaUZ0NC9iVXVpa093M3V6?=
 =?utf-8?B?WHkrVGs5a2ZBTnlCdEdEWUR3UW1QaytkYnVIRWtGYkh2QkRGNVVsVVIzWWs3?=
 =?utf-8?B?WmZCVHdTdDd6MUZmdzVuZDFyODJEYXBFSnh3Um4zN3RmTVJDcWpNVXkrN2Vt?=
 =?utf-8?B?czJ6M0M0OWlJQWNRWEJ4ZTJ2RWQzajVUalE1SGROYkZBc0dsUmhWdW83ZFFN?=
 =?utf-8?B?Sm4yZ25iVkRtZUZVRmZRZkJyOEtUWGZJSTlzdzgwVzVlTm9vWDhlS1FZZ2l3?=
 =?utf-8?B?dEk3MFFOUTA1SEpCcm1XR0FWbVBsN2dlZUFUQzhrTTR0MTB4bkdpSzBDZlpa?=
 =?utf-8?B?aWRLWHJvWWtFR2tIMTRpZXFVcXVnQWFaQ0Z0cTBobHVQemlkMXpRS1hmQVV5?=
 =?utf-8?B?U2ZFdGJPSWY5K1l4OHFvb0RuTVVYTjJiUDVaMGRmY0VyRmlMTTE5ZzNOajJQ?=
 =?utf-8?B?Tmt4V0lTOGh0UTJtUGRKa0tnaHBWSytNR2Ywb0dRZXN3STkrMnRiMUdHVTV1?=
 =?utf-8?B?SGRnS0ExZFhmVXJYcEZaYlpRMEVpclRZNDh1UmlacThldXBsQ3A5NnZtZ1dU?=
 =?utf-8?B?eWUxMHRPTFdicDl5bVdsblhKZVZSWmxVMklGajJJTXE0Tlk5UjR6ZUoxc1dF?=
 =?utf-8?B?bmMzaDZmUkFTclFURTlkWDNCcmpHTnYzTlBUR2RGb3MyR1BBNDlWOGJsQ2pC?=
 =?utf-8?B?eUlmQldIOTJTTU81dXgrUVExUkh2OXl3NDI1NnJabWtzdlJpbmZSd2xVZ0Fz?=
 =?utf-8?B?K0xCY3M1MnJUd3JjNW1HSXVtdmphNGM1SVRpZU9xQ1pHUnRjRzBwTHFoWTNh?=
 =?utf-8?B?ZmUzdUdtd28zd2lIVFJWejI3STNXbHlIL1NXU2ZKK2VKVmtUcTc4dTI1a0RX?=
 =?utf-8?B?WFdOR290cHNrT0Z2cG5PUlRNVElnVy9uMU5ON3NjTHVaUGpwSXNIZzJyUGN4?=
 =?utf-8?B?YjhqTWJPN3VrVlU1eFVVelJKWkJpd2dXT3RvVTg5WmlBVDlXY0hvNVdjOFBw?=
 =?utf-8?B?Uk11Z3lTbUxrbHJZTHFZejJOQmJqWGlzejR3QmUxZk8zVW5BaFYxbStpeHlZ?=
 =?utf-8?B?U1Erb1kweVc1aTduUTdpNkN0cVdXVkljcWZPb05HNVNXK0JkZ3lPY2FuSGI0?=
 =?utf-8?B?am1rK1FGdTNYaWYyOUgvZmd0enllelcwOEV0cnNpRitldUcwZEwvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d92955b2-7869-40f8-df6a-08dee8147143
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 17:12:43.1816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNmBYiRlTvJ2Iz3FirSAGV3p+f0wl8TABZ+i0ttUyPcGY4OJ8DbvLMGiW3ULpTgzHBGLBl5AlYKO6sGfk/scPHV6292z+rRB4V1UImbCs0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11417
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6lpYOeh1YeOWVoOa0W6Q3JoSUtEQ378B9o4Ddwj0W4=;
 b=mDKi1vP1eyMCXkwsi1jnN/So4sdzx23yU3Pr8DMxa+HSVRs0NJERy0gDPXkeYcXhTIz2afRHDcS4SL0gdJJXmFofHeOslIl4VAjaH3bdVLBJ5EwHIudZrZYyUoUjUlUjZL2Z5HhpGfgRrfDNDkvXZ8pGs7hbRd5+0ykrCzmtbNE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mDKi1vP1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="mDKi1vP1"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Vic,

On 7/18/26 6:03 PM, Vic B wrote:
> [You don't often get email from u-boot@vicb.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> while trying to compile u-boot v2026.07 (or v2026.04) for RK3399-based
> NanoPi R4S, I run into issues with current mainline TF-A (using 2.14, more
> precisely the lts-v2.14.4 tag). I'm cross-compiling both TF-A and u-boot
> using GCC version 14.2.0 (Debian 14.2.0-19) from Debian Trixie.
> 
> First, I encountered TF-A build failure with the
> 
>   region `PMUSRAM' overflowed by 3928 bytes
> 
> error message, which seems to be a long-term issue know since 2018:
> 
>   https://github.com/ARM-software/tf-issues/issues/650
> 
> and recently also mentioned in this mailing list:
> 
>   https://lists.denx.de/pipermail/u-boot/2026-April/613754.html
> 
> Although some discussions suggest that this issue may be compiler or
> toolchain dependent, I've eventually found a solution in Armbian

Debian toolchain issue, reported to TF-A last year, see 
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/36981/comments/877be809_5abf10d8. 
We wanted to rely on Debian upgrading at some point their TF-A, hitting 
the same issue and working on it but it seems they are stuck on 
lts-v2.12.1 (which is slightly concerning considering we're at 
lts-v2.12.12 already) so this hasn't happened yet. I'm building on 
Fedora and my company's CI has lts-v2.12 pinned to avoid this issue, so 
I'm not going to be chasing this myself. Can you try to work this out 
with Debian maybe? You're not the first, not the last I suspect either.

Cheers,
Quentin
