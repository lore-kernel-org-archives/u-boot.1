Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF38F5544D
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 03:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF6083DCB;
	Wed, 25 Feb 2026 04:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NYXE/1Uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAEE83E13; Wed, 25 Feb 2026 04:32:34 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E406783D8A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZAtihPt3kyY/gjf+ey9gRBX5MJsgc4tRFn19GeCXCXo02Rw/q9VAjh23qNYbBHd6koyJJQYlG4Nz3iWC9vEmo0fn+pK3yRVHvBrYP6swDLtR5bsChxQaX7LJkoIRIxDnyVGhF5A6ynrSV+YQolmLJgZfqX+o4uRBYUra/5gNakWYsPvvAIZqpcU6fndVTFfIThCr4rdsD6edgx3NabyME3ZSsW/uSaG6/k+b4uRilIlAFHXXe3NUZwpcLPuyIXEHRNN6ZBsoTnATSZCxnfrJpYmepMSQIyjpholVHT6LGxoI1HgUyDyP3s6Hgz036kr5lOG1L1O3SdfRtVG7a0AkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtuYfTwkBOVW8IRSOJFO6PPMV74T5fc0CzK4WlOZyUI=;
 b=DoceOn3xMLQT22ui+WjJlAekTxFMrvwkvl0VO9MFrF2fAgWwtm9TcMeQWSPawSNWtIA88J27IlC7vOMGK045poeO5m1UXwasr8XP/4XCE8Ecf3jQaaDscBfpvfLUbH5K48ESti8d1NaeakMtv4q6SnhcJhbXnHZhB5yDDoThcl4g7sZ/4P46stKHeNvtA/AamD+bVLM6+KMo6Uhi2la3NcwTeITwIwFcP2IV+7pLgVdcDrMYFfGmkk3t5xRH+X3LxtSsexUO7G+LFZwnuKbm/O/fdQEkzEwb14Ky36QRUgRoRtQIdntu5Ew4j/IxOBLLdZYklQWDXt8N1LTE3WsBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtuYfTwkBOVW8IRSOJFO6PPMV74T5fc0CzK4WlOZyUI=;
 b=NYXE/1UhLdYBBEDXW/Y8D0zC7exzmKC3pBPMzTv8gb12G9/Y3ed2CF9yVpB30Fpf1A1iD6Ubimhh9zimFcMfysJhe2CKpy8J0gArZ1H5633z66tW2nXJBDWRQPZ35zzVwkMXdUyJEq3QBDHPcY2FjnIlaKBhP5xgN4hBYWYhzFh6+3efb1L/tHYiUCijzEtXN12kijpAzFzDULwP3Tib2+zc4WH97o0kaI90AqiPhpbU48XEGu5vxu+jOZe3f2lH1VpjFMjxns3ddtvRymcMQNhQrfrqDXYm9PKJArLHoRECjLxx0KBfWKd6Be09PW6B+E/wKoqZfZBFNVwMPZm7Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS5PR04MB9853.eurprd04.prod.outlook.com (2603:10a6:20b:672::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 03:32:28 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::5732:4a55:2959:6da1%4]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 03:32:28 +0000
Message-ID: <dc163ea7-9063-4dfb-a39a-e643c0bcccf1@oss.nxp.com>
Date: Wed, 25 Feb 2026 11:32:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] serial: lpuart: fix RXFE filed offset for i.MX9
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Julien Boibessot <julien.boibessot@armadeus.com>
References: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
 <20260218-lpuart-fix-rxfe-offset-v1-1-86a78b224f13@armadeus.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260218-lpuart-fix-rxfe-offset-v1-1-86a78b224f13@armadeus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0055.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::11) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS5PR04MB9853:EE_
X-MS-Office365-Filtering-Correlation-Id: 238fe1d2-b788-4568-43f1-08de741e7fb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|42112799006|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVNKdW9PVVM2OGUzZGkzWmtCQXQ0WjJLZnV3RU5iU1hiWEM1dk1OQzY5cUY5?=
 =?utf-8?B?Q25mK1dtRENtQm03WFdJYldsMzBiSjVQdU1BY2V0c0p1djVMQ3l2SzJwY2s2?=
 =?utf-8?B?Yk1FVDBwLzJ3dUZyNGVvRU91aFNXNjFhb3NDOW01dE1QTGNjcDZRYUZ2QzdJ?=
 =?utf-8?B?SUpMREJjOTR4MXNUbUI4OVlxT29LTWh1TTBrWTh0VVRRdUZHSDRjZzNWcm8x?=
 =?utf-8?B?dUdQQ2U4eGpwdEt3aXFwVHZYQnZkdVNXTHhBVDg4KzVSRjhYeUNycHdQSTZT?=
 =?utf-8?B?dGRhQkFLNVFVa1hkUU9iTWhBU0FGU3hUMXBJUlh0d3U3NmRIY0dkMjAxeVNX?=
 =?utf-8?B?NUtHVUs1NW8rRks5YlN6Qmk0SHBDK3V1blBmSFIyYjJjalhGRXlsN0xMd1JF?=
 =?utf-8?B?RWNYNGZRZUpyazl6bzlvMm1aVC9Ec2lHZFM0NFVCVzlaeFhESzJlVW05Tlgz?=
 =?utf-8?B?KzcyWG1uQnBsVmhsYitXeWJneTl2OUl5bHlTNVM2RG14WXJBclNsRGFIMFpq?=
 =?utf-8?B?cEVHa1ZTNW5WRXI2RWM0WGM2cU40dzZzSTNiZ05aSlFGZm0ycFNZSGlnV09B?=
 =?utf-8?B?SXM0NU9tWUgySFR6aHNPWWhsWGpNMFloSy9uc3lzZEFqaklvUzZMdytrdHpW?=
 =?utf-8?B?bEZNa3E4akVjaENKVE1BeC8zSGx6bW16eHpuRWpRTlpkOUs0UDMzbDlhRzh6?=
 =?utf-8?B?Ri9vWFdIK3hGSWVGMVFMNG81Y3BTejdaY1pZbUgreGdudWY4MEV2WkxPZnF6?=
 =?utf-8?B?MDl0cVEwaXMzbEVKLzR4QXhPRTAyZFc2QS9mRkN0MTg5elZ0NmNocmVuWU5F?=
 =?utf-8?B?TGZETVhkeUNHc3pXK2dLMm5EY0dObDVPOVhjcDJJL0FBd1BudWZWVUM4Nzkv?=
 =?utf-8?B?d1RGRGhiV1c3MkUvVGlnMWl3TlFMaDN5L2Zmam1qVDVJQXRwQzFJYW9DM0lp?=
 =?utf-8?B?RGY1M2RoTldXYmY5elZqTGloL3lNYnM5WDNETUJsUmU2Rm8vRWNycnp6N09F?=
 =?utf-8?B?a2RNdFpSQkdQbzBrTEc4QVRuRTV0UWpObkVDMk14OHN1Z0Y5ZXU4TVlMNHRk?=
 =?utf-8?B?Tms1eENNZ01LalMrUGlwZjJCM05yRlRDa3N2WmRQd215VGVIL1c4ZHJkSGRJ?=
 =?utf-8?B?MVRmY0NkR0RqZWJXNUpXUEtPbG9pVEdVeFlMMjFVeGhHOWV0YkhqZFZ2TGpY?=
 =?utf-8?B?bmFnYUpvSkFrT1ZLNk1xV2Nxb1c3OGtscExNNXNmNis4ZTlkQ0w0Y2lJb3Bm?=
 =?utf-8?B?VUpVNlpQWWtYeW05VnhCZU1rWWVKZXJnTjh2bnRpTlp1NGxBdU5TTnA4Z3N2?=
 =?utf-8?B?Rm1uTDhtU0ZNbllvYy9hMTVLOHpIRXhCVDZBSm9FUkhQaHBRQU1yV1JMMlcz?=
 =?utf-8?B?Mk8wZG5ZNDlZckZzaThFYVF2aDhERFVYZk1JZlhVcG85YVM4MWg5b2ZJbEFv?=
 =?utf-8?B?RzljdGt0Y05qdFVCd0dWYmhKNHFUalVoMzdOMXFhclA1c1pDN2xuMlBIQ1V3?=
 =?utf-8?B?Rm5Sb0VRMTVlSXlIYVUwUmlBangvQ3hRNXpuWklQWFE0MDRzaldFNzBpUjdv?=
 =?utf-8?B?TzdFVFZaQ1Y3RUlaSisvcVd6WG8zUWZMazhjczVZaEZIeHZNZHprZVNUVGJa?=
 =?utf-8?B?MWRwRmVHUXZWaWRlUFhvWVJXdDNrTmZXa05sS2M0dnJQNkdVVnE3YTNkbmV3?=
 =?utf-8?B?YnVtUUk0bkNUZUQ5M0szTGV3UmYrampueGJIYzRDN25YYWFzd3ZYcEwxREk5?=
 =?utf-8?B?RkRPNVJiczUwdWt0ZGErcnloK1l6YVNiQXlDTXZZdEJuemtnOGRvSW1JdllO?=
 =?utf-8?B?Q2owdlhSWkQrMmtwMU9HRStqeTdjTTJVZk9lazhtRk1CV3d1U1BlSDNxSjdQ?=
 =?utf-8?B?aklSK01MeWNpbldURGlpRXF3MC9idXpRM3ZpRlQ3ZEg1eGoyYWgyNEFURWJ6?=
 =?utf-8?B?TWUvc1RaMzE0YmpPTFU5TjhtcEtCNEhPMVFjcHFUTFBCSnY1eEJsclQvM21B?=
 =?utf-8?B?VURpc1NnZVVZVUZPRUxUTVBaQTQxa1lQMVovWUhVdlkweTJ1bDR4Y0RwaU8w?=
 =?utf-8?B?Nk44S3JmNjFiVnpDNkp5NTBTL3FkU04yN2hrRTFoSmdTcFltN2VsNkZEVGVo?=
 =?utf-8?Q?gg24=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(42112799006)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWRyM3JlellLTFVvV1hQK3ZSRlVRYko2amRKRjdxc2JrdHRwblZ5MVlmNDdV?=
 =?utf-8?B?enY2MCtpWkxwZDgwdzB6RE1jcFZKL3NGclVXRnpqZ2dVNEREbTgrSWx5SHVy?=
 =?utf-8?B?eHJiRURsYkRaNzkzRlZYaGx6aXNVNis5N3djWi8zemVCMWE1RlNCSWkydU1Y?=
 =?utf-8?B?T1oxRE5rRHNlT29EclYyTVZ6SldlRWpCVFlIby9sQ2JMSjZNMVVXY1NUUjdp?=
 =?utf-8?B?eWtueFVNbnU4MVZ1RzBQTXRVblFBLzJOeHI2andYY3lpS2RFdXJmZlY3WDR4?=
 =?utf-8?B?alJSc0tua3dRUkpMUjJFOTh3VGYxVDQyaXVTNTYyYVR5R0JXb3RFaTR0Y1FG?=
 =?utf-8?B?Z0NzQlZKaHdLM05UeGhEYjQwQW5zMkkzcnI0dnZYemlySERUSWE3d0E3cW52?=
 =?utf-8?B?SDZqcEl4OFdtbmF2YXNNcTl1cGZFSHhGMGp1ZGJNRnpKQTR3UzJsUGhLSjUx?=
 =?utf-8?B?OTFHWkVDNEZ4TDFWZzF4ZkZycnZ0anliZUNXbkpyd0FrN3pVMjVaUjM0VElH?=
 =?utf-8?B?Y3RJd1I1NjM2NURqSTFzL0U3ckFHTnFBY3V6cXk0VHpIdE1TMzlaaVQxNThX?=
 =?utf-8?B?MlhmNWkwSTkwUFN1ZWF5OTJBdStzemlxeFhrVkU5VkU5VzRqVHgvbENUbE0w?=
 =?utf-8?B?cytaTkhLeXRuRzlyOWZ3SzVLMjc5QzlSYTRRNldsVlRTNjZXeXlqSDlJSDVM?=
 =?utf-8?B?Z2RXTk9ZSHVqRFgxeDNRampMVlo1RlFYbk9LVDFPV0gxYlprZ29sQ3NhSit2?=
 =?utf-8?B?NXgrSEJiTnhCZi9WOXZWKzFwOStxTUwxYktNZWRRZVduYUhRbUxXRTRPakNY?=
 =?utf-8?B?aEdLKzhqVVFDaDNmY0pqaldDbGoyZ1lQVzJMLzNpcUR6QkEwNGEzcHYvakgz?=
 =?utf-8?B?R09VRkczOUl6V2ZzbTdxSUVhSVpOU2ttaWVzcE9Hc2ZGeFNKT3Q0amdiZG01?=
 =?utf-8?B?S2JiTkprcnlIR3lQRTI1RmMvS2h4TnNHYkxoY0FpbXV2bTV6dTlFa3NxQ01X?=
 =?utf-8?B?TFhRRFFMTlFxL2pjbWVyVTNsc2EyUDBtdVpwUDR1b0lkeFlXUTBQYmQ0ODVG?=
 =?utf-8?B?bExPRlg2REh6RHZrS2Fkc1R3SlFhWWRxa3FXL00vdmRtaVRybUlaQUV5b2F5?=
 =?utf-8?B?SlJWNFUyVlFZdTBMNk1PMlNqYzU1VlZpZXlHaDhVQ0lhTG41M0hxQnA2VnJ6?=
 =?utf-8?B?U2NRRUlJUEJFZmtEaHZGUXlNVWlRMFE1bDhMWSt4K2NzK3Z1eEY3cy90NGdh?=
 =?utf-8?B?ZFRTL2pPSkZ5Z3FRZTRzM0xSN2xrK3RDRGxEdEZuR3orSG9xSzA3c2liWkd0?=
 =?utf-8?B?d0s1VDlTRlFwbmFDQXQ2eXJmZTM5eEJobHZ5OHEvTmRNaXcvVjJ1Q1ltQUpS?=
 =?utf-8?B?ZmV2VGtjL1poczRyVHNFUXFiTGxlckYySTNsSGZGVGk2TXNNV1RkcXAvYm85?=
 =?utf-8?B?NHd0N3c1Ymhjczh6U0h6bGc2WDV4cTNMdUNJNEJLTUtpNFE3dHMwdGpsU29O?=
 =?utf-8?B?eFU1UGdWVkhlMXh2elpzckhNQndtdHJoTHlUVUF5WGpQV2ZmV2x2SS8wQ0h6?=
 =?utf-8?B?UzRiZitFL0NoUHZzWjhPTCtXcHVpM1NTaUNKc1U0bTVNd2o0K3VkaXJhaVpi?=
 =?utf-8?B?a0piNk43eXRPNG93cVV3cTExK3l6ODJwWGU4WHkwaFBBSTlUME5Ubmo3Mno4?=
 =?utf-8?B?OWJHYkFOZS9YZzQzdU03OE1idTFpUlNsTXZIMjJsSlZ1NzMxWDFPeXNGT2kw?=
 =?utf-8?B?dVdjVzVoQnpOTHBVb2dqVUZBYk9HV3lTZm1RRWtpd3hoaCtlWmxJRWlrU3R2?=
 =?utf-8?B?a1RDbytUT0MrbnNCamFHNWphUnNKRHNpNFdURGNib1ZORWVtUlR3VjVkU1A0?=
 =?utf-8?B?QW5GTXAxUGVLTjd5RUFJOXlwUGxVMEF2RFE1VzR1bWEyRnJCM0pBMGYrVUUr?=
 =?utf-8?B?T25sdllweVozQzUzZGdGaXVDMUJQbWVDdXFMK1JiNVR4VHl6eGZsa1lNR3gr?=
 =?utf-8?B?eGY3MzB6a2RCUkltN3IvVGtQZUEwV3ZyVnpBWVd6VndJeTBYUkZTQjdRSWFo?=
 =?utf-8?B?RFNqTjFVcEpNaWxCeWZidFpTVEQ3aDZ5NGl5YnBOb24vWWQ2dkFEWU1lZitI?=
 =?utf-8?B?RTB1a21OQnJEN0tIdnYzOU5JSnNuUmw3ME9MS3V0WXR3WHZEbGJOY3hPQXQ4?=
 =?utf-8?B?dEozekRoYkEyOEo3Y003MTlkbTRxZW1jdHVVV2FjYVJKeDBnOTE5RmkwUG9P?=
 =?utf-8?B?VE04cjZVcmNYRGRudHYrd2M1WFFXc3JyLzNETFUwcGZYcTYySTdYUW5sYS96?=
 =?utf-8?Q?F10NklFHFYrfgsGIPB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238fe1d2-b788-4568-43f1-08de741e7fb5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 03:32:28.2449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZyOTOU5YaOt4uhTyNew77YdvRRtXvShQEAsKyFTMrSlXGl0KCGDHnoi9BnT+KZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9853
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



On 2/18/2026 10:59 PM, Sébastien Szymanski wrote:
> Like i.MX8 and i.MXRT, on i.MX9, the Receive RX FIFO Enable (RXFE) field
> in LPUART FIFO register is bit 3, so set FIFO_RXFE to 0x08 on i.MX9 too.
> 
> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> ---
>   drivers/serial/serial_lpuart.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
> index 9fdb6503085d..bbce59443388 100644
> --- a/drivers/serial/serial_lpuart.c
> +++ b/drivers/serial/serial_lpuart.c
> @@ -53,7 +53,8 @@
>   #define FIFO_RXSIZE_MASK	0x7
>   #define FIFO_RXSIZE_OFF	0
>   #define FIFO_TXFE		0x80
> -#if defined(CONFIG_ARCH_IMX8) || defined(CONFIG_ARCH_IMXRT)
> +#if defined(CONFIG_ARCH_IMX8) || defined (CONFIG_ARCH_IMX9) || \
> +    defined(CONFIG_ARCH_IMXRT)
>   #define FIFO_RXFE		0x08
>   #else
>   #define FIFO_RXFE		0x40

Previous value 0x40 is wrong for all platforms. You can directly change 
it to 0x08 and remove all ARCH marcos.

Best regards,
Ye Li
> 

