Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA92EDF176
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F157383015;
	Fri, 13 Feb 2026 16:45:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Loh6t91D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C697283AA9; Fri, 13 Feb 2026 16:45:32 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70E6782A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqrP1eNVG+HFLYIBwyxea5RlqZLfT4pTD3Lebr4kjbXrtRRLN3ac4Lo2R7vSkdtyd4WspN9MtthwfjNIxXZpET8zyv8GFRw+W1PHXcnRC57OhwFkhgk6JmL1rcJP7/9JkqQo61SAo9ygBuSILxA/tcPC/Yr7Cx3uCoFoCS+rcS6X6A4N6KGPC3qZOsMImCOEAV5DM0pchh9jOq0yzLVlw3hCpNvFNzQA9OQmCKJA76lW4DXb5jiVOCa0BFCTl6B2XxAday4RU4ZEbYtujKZwuuaPzAJpSbjgWobxjf5NwzdZPq6UbKHFgTSft2eFTgGfUNrk8H75n3a5eWREMp9Axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ2+77hqN2vp6K2PHW8/sHcggMLkBB7NMOt02Xwc1U4=;
 b=N8WlXtMrWsp6ry+Xx1k91SNOt9Q3cWNjcmChvN0Q1cR3FsAhZyykfxfjme60jT2iOH71jzb0YQLwRYaWiBsxwvIzH5tqS8g/lfJZOI0JFdYjY5wyePF7yddaxgiNk3ldXn17wPl1ofjpc7MQtXGThvKLiT6GEkO9+IzKtLDI827Ngr4UaU9eD8b/DDRXwEpDEcsRj4Jymd4vjcFXI50zOk45vgB4QHEiYL2qGrbN/TImub1qltr0yldnOfsKTN6T+u3jEHP//x4kLM3YGm+HRINq495NomwituqZ2ay+1mlJh6JqibJAOrrSwiuEnXMTYQ9zneO31GWntSOdGwSteA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ2+77hqN2vp6K2PHW8/sHcggMLkBB7NMOt02Xwc1U4=;
 b=Loh6t91DUtAJ2G5XhT4cIRDdRCRl5VwoWgEoqfNzVfBG+wCMdagAFM53D3BvJGmTJrUxXrXsBcAlkkHkTSaduNBlLh8SNGXntGSz3ONsGsSDXMoauFCosLNP43qbPjcSeAEoZNNY4Pflb4wWT0OCEQqM59yBx5roCGtOPfOChFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU4PR04MB10909.eurprd04.prod.outlook.com (2603:10a6:10:587::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:45:28 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:45:28 +0000
Message-ID: <2b06df54-a041-460e-90bb-0319d7d02608@cherry.de>
Date: Fri, 13 Feb 2026 16:45:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] rockchip: board: qnap-ts433: Add instructions
 for how to use upstream TF-A
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-6-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-6-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU4PR04MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: d712b7d6-7d83-4113-fe68-08de6b16e97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007|7142099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Tzc5RzRMU2tSbm41d3YyM3NTc1ZhUXc1bnV1ZGw1eW5wWmhlY2F5blJHbW1P?=
 =?utf-8?B?cENPR3dKZjhTSXJxdUNzOVU1dmc1cmhON1hEZ0F5QzRpdmRjM0hRY2o2N2w5?=
 =?utf-8?B?M3FLcXJQWkFsSldYMlVmdXU0QjUyNEdENWlGR3ZhVFZZV0MwZU14WnN0S1pD?=
 =?utf-8?B?Qi9MSnZ2dmNPa1lyUk9BV0dRU1Z4RlRHNUNZWGl6MHdXQVd2QVhNVWFOdnhY?=
 =?utf-8?B?VGJnWmZQdzd2L2Q0ZkdMWFoyRmlTWXAyK2x3SUpLbnlxeHVvemRFelJGZmFE?=
 =?utf-8?B?YjQ4eEVCekpwNDZKYnI5QzhLSjRxRzVIWC9TTWhLYkxxeGZVSnh5V1MwVytz?=
 =?utf-8?B?TVNvUWRuYmRheTZvMkhVd3ZxOEZ5dEk4OUNPU1lOVXpCbjMyc29vTiswUVll?=
 =?utf-8?B?cUMxWW01ZCsza3VOb3duZS9Na1g3ZzYvdW11b29vNjlwcmdLOXlhNUdqNUJH?=
 =?utf-8?B?SThjRFVTT1lxVVloTWx5UUtGU09YNFM5QlFGZUxCbTdVaU16WXpwL25EOFNv?=
 =?utf-8?B?YVNUalphQk9FN3FjdS9Zdnd1WFp2MHl1UjNxdlNzcXpMYkZTL21XaWlvRFJh?=
 =?utf-8?B?OVVKVEM2Y2dDSSs5bC82S1JFcUI0ajdtTVVpRFBsd09BUlAzV1Rud3dlbzA4?=
 =?utf-8?B?YzZPSVZoTUloOVRKUTArOWMvVGJaR2VTM0Z4bHNMc24zbWdla3FRY1FCM1Ay?=
 =?utf-8?B?VG4wZWtOeVVqTVBsVCttYldWbm1vTzdabFlyL0puNXAvKzZFSDlPUzR0WUVp?=
 =?utf-8?B?VG5kclAvMkdUUkNkcld2NHlCU3V5VzdqOTI5ZDVtRjZMcmFxdjNJQVNHc3dH?=
 =?utf-8?B?VmJGNXEzcmsyajJvUHFGR3VNa0lwem5UdDA5RnRrM0dEbm9ScWtnMUhXdTA1?=
 =?utf-8?B?Wm1Ec21nallDQ2xzVkpaS1ovYW1pLzdEaFFaYTZrZkI1eXZkcWxRbW1GYldY?=
 =?utf-8?B?RVBDVWtnK3d2MVVqV24wNFF6TEViL3Eya1AzeGsrc2dVbng4bU02a0ZnSjk2?=
 =?utf-8?B?Q09ER1phdkRrOFRkUkJuZTNUaWpuWVJNNUt0cjhEdWR4cjlSRUt3aExQcTNT?=
 =?utf-8?B?VWVkSW9qK0VoVWVTdkRubzk0R2xuVjlkc254ZGgwZ3BPUlhqeVBVcnB6d3gx?=
 =?utf-8?B?RFJBUTlRMTdkWXVQelZFTkFLejBLV3Z3eHgzRE9hWkhaZTc0REFlMUZmL1ZU?=
 =?utf-8?B?RnJCUFZWQ2VVb3BkdmF2RnpOcHNWRUpVM1BmZGl3ZU1pdFJWSitCdFM4YkMw?=
 =?utf-8?B?NDhvbU43dy9DSHlNRVBhdGRFWVcxTHovNXEydnovNFA0STJ0RGx6TitIeWc4?=
 =?utf-8?B?SWhpZkVxTG9NUmdyalhVUFBJVzQrazJUQzlzZnJwTTQ3N1k0c2krRTEwZFRT?=
 =?utf-8?B?VU41UUk2V1NEWXEvY1BzdnJBdGFRMFBpUlhFSTBQWVNyUm1nVXJ3MWJ4VTJP?=
 =?utf-8?B?U044M2h1MTJCY1ZyRHRDbE5ZblllRFh2NEV1Tk1TUDFtMVg4L2duZHFPUm0z?=
 =?utf-8?B?RnlTN2NJZzl6Z0pjVW1EUDgzVTF6bW1LWWY3RHpxbXFPcG1mdTJhelpONjFx?=
 =?utf-8?B?SExuTGNJaCt2eXNhM2lERjhVcEtLL3MzbXl1N3lmN2h6TlhtbkxMSTd1OUwr?=
 =?utf-8?B?TEVJYUdyb0VsNXQzekNaT1ZLWUR2TTdjendwcVVHblNxL1NHYUFpMC92UUtq?=
 =?utf-8?B?MHpzVitLR29WWVgvdVB2TWRVQ284R1lKUjl3Sm4xZGtDOXBTaUZUY1M0UFBr?=
 =?utf-8?B?dzErUkVFbUhKMEVoZE1qUkxITEJKNk9BRDZZK1g4Q3hncit0bWlHdUxTelJp?=
 =?utf-8?B?Yi8wZENJVEYwWmV6NE9saWVEK2FaN05mVWxCYzNMSlhhYUIxM2JqQXlGVWJy?=
 =?utf-8?B?KyttaXZ0K0Qwd0RQaExiNHhXVzl3dVNkRlN4aVBNTHhhUjY2UGtnUjMxdTFS?=
 =?utf-8?B?R05TTlMyaDliWXNwbWZxT2dtYVNGVmtrL1VENHhmeWNxUTBKKzI1Ty9rbUhY?=
 =?utf-8?B?clN0bk13L2dMM2t4T3M2czZFR1cva3hLV3N3d0NzOFlkMDRXM1VtR1p0N1pD?=
 =?utf-8?Q?x8Uc1Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UitpMFN3Y1JZdkw0UU9rcW8wMUxWMGtIODdMQ3E4S09BU0ZMSmVidVAzcHhN?=
 =?utf-8?B?RHo2SHN1Z2cralo2cHRRS2s4NTBMdEVLcXRvVnAxZzhjZmhVT1ZtcCtHR01S?=
 =?utf-8?B?U1RkNDRNKzA5bzZJWTl0YXZrQ2greWNCdXVUZ283VlBBcnpDUkhKSVNTRXBT?=
 =?utf-8?B?RTYyNldJK29uWTNkbmtZU25nZW1VNEtqU1dzZVVCV0UzbDB2UC9RdXJ6UmtJ?=
 =?utf-8?B?RW1CcXdtQWpQajl4REcxU3czbkREVmVVcktucHVYUGliU0RBcTZNQWZmV0FK?=
 =?utf-8?B?cGZvdGtFblM3cytDeUJ6dU03KzVlU0VGcmUrVTRndHFidkJHVGgzcGpsWU5s?=
 =?utf-8?B?QmRNVEdzRnRCUkQzUHlsTFc3THJ0dzVmRXFLc09XRHZROEE1YnFLRWh1dWlF?=
 =?utf-8?B?NEJ0UGxlU3JvVUFMbXcrUkR5TkVrTWcrR1luMUZDa0J0WURxNUtSQVB3WG1P?=
 =?utf-8?B?cW1NY2lmS1F3L29GcVQvVUtGcDhwTGQ2bzc2ZHZtNzZwdjIvZVJhM1hJOXRq?=
 =?utf-8?B?TWdaczFzbVA3TmR0WU9HakdxNXIwbjRmVnJtK0FrMTFZSkU2UTk2Ym5OQWpS?=
 =?utf-8?B?alVsZk1qM09Ec3MxaW9tRGRjckgzWXpaZDErb2d2cUlzdUxweitNUFZWS1R4?=
 =?utf-8?B?ZnNGWGdYaEdVbG55YjJaNXdsaXJtRkVqRkExc1U0RjFEdWlwbVhkY2EzM21Q?=
 =?utf-8?B?QTNSL3NSL3duL05Bc1Q0UEduMW8wSW14eitPTTc0U0ZTTXVYMTVUQU1pNndZ?=
 =?utf-8?B?ZHQ4TzEvR05NbEhJa3Q0QU5QMWJLTEE5RktiaWtUbzkvZ1BnUG93Q21yOUhJ?=
 =?utf-8?B?cnl6dTkxS1Mzc1NublFvcExCVkFEOVcvYjVRa2VpNXZxeS85RXlnTkVZUWYv?=
 =?utf-8?B?U25kL3NjWkt4ZFNSbUR0ZE5EK21VWUNCc0VISW1kSlBxNUxSTERKVXZtZWRs?=
 =?utf-8?B?bWRuRjNtcHk0eWg2dkRHMUh6RysxSWxXZVphNSs0aXJPZk9UcCtWaDY2TUFw?=
 =?utf-8?B?REpYSkx1azdtcnY4aVdORk9zeGsyQllheTMrVG16Q2xVaUZ1b1JTZHl6MUJH?=
 =?utf-8?B?NU16azlsWXhTcnp3QTltaFF4My9sVFNrbFBSeExUbjNUbGlBejZJQ0x2YnJ6?=
 =?utf-8?B?eTVuYWE5NTFtQ3ZmYnZBWEtFem5JYmg2Z2c0bjVPeDRCU3BOWk1WTWxjTWRY?=
 =?utf-8?B?ZG5IcGo3UjhrYUlRb0YrRmNhWXR5ZVpjcy9kZ05QbisycjQzK3RMdGtQdmto?=
 =?utf-8?B?WTNkdmNPbFVQRTk1T0V4ejhvRDg4UzN3MVBJdU5TWXJ6bFJQN0NTM2wyUWQ0?=
 =?utf-8?B?L3AweWREdkYwNFVZWjVRemIvV2RlL2R2MTVNWHQzdjY5OTNNblhlaWl3MWoz?=
 =?utf-8?B?dFF6eWxXcDBMQUZQNDJadXM1VlhROS9QR2RnMFMxSkNOVG9lYWRzQllYaW5m?=
 =?utf-8?B?MmVnU0s1VUo5cTg0S2sxbTQ0T0tSYWh0SzhDMnFCMnVjd21jUFdYenpzbmYw?=
 =?utf-8?B?M0RNaWg2UHpRYks3RzVFaHpHSzYvZkJ3a21SK2s4blhVN1pPa2h6czV0Wm1q?=
 =?utf-8?B?RjF3bEVrZmhveHBUWUJBSm1qV0dFYWl0dXk1RW56OHdGYXBOZzFMWnk2VFpH?=
 =?utf-8?B?UGFSYzh2bjZMUmtLcG14TnVrUGZHeVZKNThCWWZSdmxtOWo5K05rNDc0ZWM1?=
 =?utf-8?B?am1pTlpEZHU1OUNnU2g5ZDRZc1NtQWREMFRRNGVxbDdxejZXRlIyNkcvQkVX?=
 =?utf-8?B?QXdjdlZOV20xZ25qSzZMbm5mbFk1T1pJcUYzdU51eitrS3hqVHlnN2QrV2ty?=
 =?utf-8?B?bVRkUWVoRFFPUGEwbGx3SVNyV2NYTGpCZWVDN0MwK2RFMzk2WkgyZFMveVZi?=
 =?utf-8?B?eGh2bVd1Zyt4akxzdHlSbGc5aUlOeTRWdmlWUk9vMjVDV3RtUDBIZCtRZkdu?=
 =?utf-8?B?V20xMFlqT2NoUjNVRjM0MER5cE91UDBEWGFkQVNIZmp6U1FOdHpmYlI2MDJ6?=
 =?utf-8?B?RkZSdGQ2ZWlVbWN4N0ppS0J4WkZyM0wycnlLSld1TmMvK3A0a3B5UFJDNkhS?=
 =?utf-8?B?TVZlVk55UEZRWXJrQU5hVVZzMzJEOW1CcFBKbURjZ0FoQkkrdURremZHa3J6?=
 =?utf-8?B?VEMxYjVvenUwNkJQZGZNKzhWK1RHeUltRCtHMnVyQlZ1Z0ZLdDFydWUrN0RN?=
 =?utf-8?B?dElNOVdid3U2MGZ3MDUwY1U1SzJLVWp2NkFXbG1vVlpJN0NYTld2elBaMS9w?=
 =?utf-8?B?Q3AvV2UveXJpdWhZb0l0ZEcvOWNPMkcyQWEyN3dNQWRsMDRZNW95SjBDRmV4?=
 =?utf-8?B?OVVRN05YNml6VXlmejdpd1RDbGpkNDdyQmxxMVVhekk0S2Z2ckQ4MUtsOUdk?=
 =?utf-8?Q?mMYocHXLv4M0fHBXRj/TYJNJsJftVnXLN0ihE?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d712b7d6-7d83-4113-fe68-08de6b16e97e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:45:28.5213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlPutF1a9+6tPieD4Yhni1N1PH/222QCWUn4aBW9Ozy6LHhdk0PCTXO4bACVnKymFb++e/ATrkMfkhLr3ZdTa4Is1rZkVPAMbj2aTg5jRRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10909
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> Upstream TF-A has basic support for RK3568 for a while, but only with the
> last release finally gained also cpufreq support.
> 
> The only known missing piece is enabling the ARM crypto extensions,
> but otherwise upstream TF-A is fully usable now.
> 

Missing ARM crypto extensions means crypto stuff is going to be slower, 
not broken right?

> So steal and adapt Quentin's wording from tiger-rk3588 on how to use
> either upstream or vendor TF-A.
> 

I see you carefully removed the logic to detect the proper file to use 
without having to hardcode the version number though ;)

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   doc/board/qnap/ts433.rst | 28 +++++++++++++++++++++++++++-
>   1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/doc/board/qnap/ts433.rst b/doc/board/qnap/ts433.rst
> index 2cd7cf13d67..5c81dc953a6 100644
> --- a/doc/board/qnap/ts433.rst
> +++ b/doc/board/qnap/ts433.rst
> @@ -39,17 +39,43 @@ modification and also a new maskrom downloader can be build:
>       $ tools/ddrbin_tool.py rk3568 tools/ddrbin_param.txt bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
>       $ tools/boot_merger RKBOOT/RK3568MINIALL.ini
>   
> +Get TF-A
> +--------
> +
> +There are two possible options, pick one or the other.
> +
> +Prebuilt binary from Rockchip
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +.. prompt:: bash
> +
> +   $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.45.elf
> +
> +Upstream
> +~~~~~~~~
> +
> +.. prompt:: bash
> +
> +   git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
> +   cd trusted-firmware-a
> +   make CROSS_COMPILE=aarch64-linux-gnu- PLAT=rk3568 bl31
> +   export BL31=$PWD/build/rk3568/release/bl31/bl31.elf
> +
>   Building U-Boot
>   ---------------
>   
>   .. code-block:: bash
>   
>       $ export CROSS_COMPILE=aarch64-linux-gnu-
> -    $ export BL31=../rkbin/bin/rk35/rk3568_bl31_v1.45.elf
>       $ export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3568_ddr_1560MHz_v1.23.bin
>       $ make qnap-ts433-rk3568_defconfig
>       $ make
>   
> +.. note::
> +   If using upstream TF-A, one should disable ``SPL_ATF_NO_PLATFORM_PARAM`` symbol in
> +   U-Boot config (via e.g. ``make CROSS_COMPILE=aarch64-linux-gnu- menuconfig``) which
> +   will, among other things, enable console output in TF-A.
> +

Wondering if we shouldn't add a config fragment which disables that, 
such that it's easier for the user (and can be part of build systems).

In any case, unrelated, so:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
