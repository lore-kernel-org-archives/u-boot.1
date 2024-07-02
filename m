Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE77C3065C
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 09:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 709F8883C3;
	Tue,  2 Jul 2024 11:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ihk6zu6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4CF88113; Tue,  2 Jul 2024 11:16:34 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::708])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38264883C3
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 11:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWkYxywyH4Iq7kC86kdBypC0LwjFPE8faXSvSBGUM+E5O2iGQj53g/uG2WqciwRM6fVwpGKWaQugYBO4TN0x8SdV4LJQkEpxWxRlDQS/pL9hpEwYZ6KDzAuMVVB57B2Be1bR2edX6n1D7dXtdap6v0LHgsGZTyigPMCCiH+nmidFg1EL8bEfrBV67sREj8nj9GxPsfFy6ZSctVjiYYqfg16nu0V/lLqp9MiNkBeDoBtpuItjqUZj3WGo62127PZEuh6qE+bfgX2PUWgB4HnJ6XPd0n8dRTlaC720ObuMW/2lvbhUsqPD76iygH8Sw+2GncJ0EpCvkgFjdZezM5E74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gE2R/cKgV07TF9o1DhztD7wA7SyrAniTZbRoU6hXRMY=;
 b=TDxvFRPY8wg8Z+xJxSkpeSm+WIzuVw75yiYWu3dnvaJ1LSrauwRDIICfzn+wJybQ4K8GbADU5yAvOYA/za1Ghv+8jZZJQjHeiR+q+AHFmjUZlkPEofkI0j5cJIFRmIzjApJWFfBiQV56BABcFb4lIMtn3TcrifdPyub0YCH6bYbMpNyoXNF4mfaE6Vdgp2AGTfhxkOpjX5czZUl0Kd/4bHxo0s+EbeTyqAZEekOqS40RrENrE/kqi5G5w7Z/2Txp1K2oskFK0LGhsd3992phQuVjeDyf18UY6xf6RAKTPMFkCMtYu+qmKWJPdPSdZZWoXY8UFRuasklf4RPwtiLT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE2R/cKgV07TF9o1DhztD7wA7SyrAniTZbRoU6hXRMY=;
 b=Ihk6zu6X9NhMjjLx/Fi+NHShIyaM49fWmubsQ5BjAAds8mb/djeqICRAwsEynl8TjYVBEQT1CBvbQV/tw2SwMRqnDjTQkAKpotgSi8pZGp2TbnbbO2c+OQdggCsNorUSS39nsnzPrRqf9dA7a7YDia3ULyddI3QGCCRE4HKEWS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GVXPR04MB10491.eurprd04.prod.outlook.com (2603:10a6:150:1eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 09:16:25 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 09:16:25 +0000
Message-ID: <d609b656-19db-4dc3-956f-7dbec5de9975@cherry.de>
Date: Tue, 2 Jul 2024 11:16:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Import environment variables from FIT configuration
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Niko Mauno <niko.mauno@vaisala.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Emmanuel Di Fede <emmanuel.difede@cysec.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Orlov <ivan.orlov@codethink.co.uk>,
 Joe Hershberger <joe.hershberger@ni.com>, Joshua Watt
 <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Piotr Kubik <piotr.kubik@iopsys.eu>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240702064834.9543-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::22) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GVXPR04MB10491:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd14df3-1246-4cca-1763-08dc9a77a5f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzFlemNDU2o4MGNKZ1A1aHcrWTViNDlYV2tyWi81UEthMUUydnV1ODFHUGtG?=
 =?utf-8?B?MTBuVWhUNkMrNFUyK3EzVU02aVpHVkpSOUFkNURPWVNUaHlPamlDbFpPTTVC?=
 =?utf-8?B?KzRLaFAwTGJXOUhYU2hFUDQ1dTZ5RElWZVhTYWVabE5haWNLZnB5UU52bnR6?=
 =?utf-8?B?Y2FsOFowekRadnVPOHE4S2Q0ZmM1NWpkOHlCZmFnb0lKbXdZanY5WGdiRnlF?=
 =?utf-8?B?UUJUdG0rSEFNbUtqcTZuNEhSMDBDelFhRGZzUDNKaExOY0FXQjNYUFl4QmFY?=
 =?utf-8?B?RjlsNUJkY25jd0FEL2VsaU9VdnY3cVVCenh0TUlZaVNpaWc2ZXllUEl1ampD?=
 =?utf-8?B?T1h3Z0RZZHNoR2JOdzBGUXFQMTg3QzlpeTNXc09OUDcvR3NKNGJpOUJSd1g5?=
 =?utf-8?B?cURWUFFmL1FxSGw0bERQTWVMK01URmd4MFR1S1BKVkZLbXlMb0NYak5lRnVJ?=
 =?utf-8?B?YzFxWVdSYUxHZ3NlS0xqWGFKeDFQSnJoTUZKVlBEc1VQdERnM3ZmZW1BUEVL?=
 =?utf-8?B?QldMRTNia1ZON0VhYVdQQ3ZLOE4zaVd3YSs1dHF1UEViVyt1ZE1iYUJIcGFL?=
 =?utf-8?B?QWl2eTNoM3NwMXVmYXdxbzNpSnNKNFkxblNCMnQ1N2lFdjN4UmYza2FxY3pF?=
 =?utf-8?B?UnJKdmJUa0xGWU5TWXNIQ3NYRmsrem15QkUzTDhWcURCWEVhZFFNTDZCKzVo?=
 =?utf-8?B?a25mdWFXVyszanVQdGx5NU8xcjQyWDR0TnplbThKamFzd09JQ3ZZYW91WmI5?=
 =?utf-8?B?MmxvM3UrYzU3bGllVmxTYjl4ZUdFdmtVM01YSjl4Vm8zOWV3d3FyR1pJTzlS?=
 =?utf-8?B?NXNZWW9hTmZ1dG1qYUpXOWhvcm9GWXhvajN2bzkxQ0FNdjJpOWUyNUk2aDBL?=
 =?utf-8?B?b2x0R3pldWtPNFZwaXVlUEZiaERoU01wWEtRV3N5a1g2RVRlejcxV3A0MW8w?=
 =?utf-8?B?MjBvQXFibzhnRTdSSDgvcSt5OVJoYWZUbFNQU0lxNDNaUW04bTFQY1o1ZS92?=
 =?utf-8?B?b0xweU9Ea3Avay9YZlk3OFpoT0VsNmt1blFOOWJoZ0RacmtBdThIUTdUQVRO?=
 =?utf-8?B?MkJreTBuSGxKVU81eFNnWGprWFpvMzQyQjJEQlN2bk0xZVIveHZCWllITTV1?=
 =?utf-8?B?TjBselN1WEtzVk9VQ256S2RPWEU1OSszU0JRa1MvMnc5TUMzS0NyZFJkL1M1?=
 =?utf-8?B?c3Fjd3Nia0h0ZG9ZalJEMDl0SFdaOWdsbFBwNUF2eFBraWxFT1k0b3c1WjlR?=
 =?utf-8?B?d2xsYys5NVBKS1JRQlJDTFpIUkR6OVBhTHk2SzY1UGNzelpZTTRQNzlrWVZa?=
 =?utf-8?B?QUdEemdSeGVENDJTczBYNXdaRCt1N3lJOHpEKzhzb0loZnRuSGo3VnpwVkVI?=
 =?utf-8?B?SDlRUVB2R2FpMTRNS1BwNUZFbVNIbVRQenhCV3Q5dzZiWHFZT3U3NGdOUStN?=
 =?utf-8?B?aXZFek5ud1N5ZEUweDBGZ3pCUG5VbTI3SGxLTkc1eENoQWl2Y1gwbmRxVU9s?=
 =?utf-8?B?ZmVSamg0RE9NMXcwWThjV3kveGlqaUNDOFdrdTVyYk9LdDVPdkVSZ29ab0FC?=
 =?utf-8?B?Qnpma2doMDBaQ2RoYUxlWVVQRnhjVG5OZ00razBpY0tZT1I1YkdORlZuK2dw?=
 =?utf-8?B?azluU0lKRUlyT3MyWjBqNDVuSVdQeXNUUHZWM1lERWVySVo3d3BzSTFBUkFO?=
 =?utf-8?B?UlJoR2RUYml6S3QrZ0cySXQ1SUk4RjdIekF0eEIvN1RRMlpSWU5QeU1qdXBw?=
 =?utf-8?B?ckRmeDlEU0F2ZFlSQjk0cHh1czlVaGVtdnhWNUpqMERmWDNyVEJBZ3BlMU9m?=
 =?utf-8?B?Z1VNdEk3aTJsQXQ5cFBHZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXdZYmZnOUMwcVhDWno5L2Jqa0tCVExjUkJ6bkhyYWFZNWdwK0RBN0JYUDBQ?=
 =?utf-8?B?dStCTHBmQWVWT3doZ0VHSURmWlNTa0VGZWx5ZjE0U3Qwa1RTSjZEWmVpcit6?=
 =?utf-8?B?SCtpOXQ0Q3diaE5nRG80aUpvb1VaMGNxcmRaUWx3L3hQVHFvWEs2dEI1S1BX?=
 =?utf-8?B?V0IvSDFVY09YUldxaFR2SlRRQ3RVeEsyMGlVL1hXTit6Z3Y0QVk2WEtoRHRa?=
 =?utf-8?B?aFNnSW5pa0JBOTIwWE5wOHBIL3hEWEQ3UmlhSXVjdE1NbGVaWFJCZ2ZOZ2pZ?=
 =?utf-8?B?YStIOGRQL3UvUjM4M0JsV1hnbGI5bVZPVzNLb2U1eGI0Q3JyV1JQS0VMeVpj?=
 =?utf-8?B?cml0bEJPeVdnR0xkVURIU1VDNE9vbDNOL3kydWFLQWoyRUdIV1VkNU9CbXJW?=
 =?utf-8?B?QnpJVnJrS2Y0UmRKVU94SWpOcVpacStENUJWTnZWdDRqODhXU2x5cm1jQlFs?=
 =?utf-8?B?T0w0SUtnOEdYMHJBVlBQem42STNJVVB6RmJwb2JiSnZhcXBSc2RvQmdYeEhL?=
 =?utf-8?B?K2E2UFFHc3kwcUM3cVJTMFliNU5lMUtKNVZBT0pJcFkwdDhGNG9DcCt6SGg1?=
 =?utf-8?B?dm1SVUVsdXFEQ3BXNEZHTkNRNDZZTm9CdjFyaHZ2alVicW80T1Iwc3U5ZUcr?=
 =?utf-8?B?Slo1UW5LYVVzbThOUW94Yld4MTArTUxxWXdVOEQxOVhsZFVSRDhyRWRWT3Rk?=
 =?utf-8?B?L1JiMmV6d2dENEh1TXRQSEFhUkdWTmlKdGxsNzVXczNmVUhiQVMvMmpPS1F3?=
 =?utf-8?B?YmJaVkVmSW9BNWJ2di8rdkp1U1ZGeDZRbnhFRHZzUXpiQjJSY3NUR2t6bXhV?=
 =?utf-8?B?K0lXQUpUL3ZXb00zNmdmV0lDbDFTWjBQVU9MRXI1cW43ZmVXUUVCalorWnNu?=
 =?utf-8?B?NmMyUjA1a2JSYkdWMUc1ZXdaVW1vTlVUdk9ZRFRvMzVZdU94aVlJZ2s4K0Nu?=
 =?utf-8?B?NEh3UTNxeVg3dnU1eWdtZ0luL2tXaVdjN1lORFR4Y2Y4KytJNWRWUEpxUDE0?=
 =?utf-8?B?ckEyNlBoT3FZc29Pdk56cTB3bGVXMDRnYmJGS3hFdDhJYnJrNVRMNmhiN2Nu?=
 =?utf-8?B?U3lwMDZucUJCalpHcURYMFJlYmtVZmFnTUFPVXA0dExOMGdFZ0RrcFRRMTFJ?=
 =?utf-8?B?TElZUWpvOHk0RGtoTEZhREFzZ3hHZXlPNmJ4czR5OThEaFZvQU5OQjA0Y2NT?=
 =?utf-8?B?RGpkcWJJZnRGYUkvN0VRNGZ4Nk9yWmt5SkpkdDFyaC9kNWU3T3h5aDlFQlV1?=
 =?utf-8?B?ZFlMWmwvdU84NHMrQzVzMjN5VDFRdE1JWUxyeXZQYUFtOWkxQWo4c2FGZmU5?=
 =?utf-8?B?TVM0SStZZE93Sm1YUnJyTTlzeWJVWFo5bzNBeXFrRUNqa0sxZXJ0OTR2OTJG?=
 =?utf-8?B?ZEdmVUEwbXJGRkovUHQybHIvRFFsZzVLMmczQWZXdnNEVXZ1VnF2bUV3aHRs?=
 =?utf-8?B?NkI3S2lRV2FFR2FzNTlXQWV4TnowelVta3lUNUdDUUFxQnMvemRJZkx5RHBY?=
 =?utf-8?B?R1c2UTFUUUZPQkE2ZWo5M1ZNL3RJUVo4RmdGR1VnUXU5ZkJDOW9wVmJkdVpa?=
 =?utf-8?B?ZE4xK0srbkkvbE0yK2xiaERJam1WcHV0cER1Y01DQXRucGRheXMwWmMvVFlG?=
 =?utf-8?B?am11T0JlR3NrVlJ6VVptNnM0cXVMaGtkMTNKMi9YdDdBNXl1SEtVdHJSWkZI?=
 =?utf-8?B?ZkZ1UzVmclpDOFh0UWlobk00UHJIeGJZQm1DZmJRODB3ZjB4V2ZWSHkycC9I?=
 =?utf-8?B?MlhSZFpOSVZnUTZ6c253NTYxdnZyYzZaY01TTHEyRVhRRDJMTEZEUHdPc2tS?=
 =?utf-8?B?ZlpRWlBDeDBsZXlnVkJjVExZRTBRamxrU2R5eFFzYWw4VGRGY0pPTWQyemJK?=
 =?utf-8?B?blhOWW5sUlh2NVh0TG43UTN3ZHJubmd4b2tlMzdzZXhxWHNxZ3hQem1oZG1i?=
 =?utf-8?B?UFRid1pNRXBaSWgxTE94eGxHdjhWbGtxVG05d1VyUEd6U1ZEc0ZPMStFN0ti?=
 =?utf-8?B?NXJTdFVPNW9LYW5wYWE2Q0JlM3NGbHV3Q0NvR1h5cGQ4ZDNteEF1NmttQ1FQ?=
 =?utf-8?B?K0Rld3h4alFkR2VnbE00NW9Fb0RreGRFcGhGaXZwVlNERkMrN0JwaHUvMzJO?=
 =?utf-8?B?TWZNZDVkL240R2ZCOFkxcERtMWhLQU1WZ05zKzY0YmVpVjdFVDRJcXQvOWxH?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd14df3-1246-4cca-1763-08dc9a77a5f2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 09:16:25.6740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 33mpB+7z+cnz3GotsWfJn7kdgVCB2eVLl2Rru69ZhDVXn2bMoagDM1qMv2eYRP6ChqrYCnUpk1XM2X2I0hf4NrWNkLb5xnpR4N4fvPkZj3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10491
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

Hi Lukas,

On 7/2/24 8:48 AM, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> 
> This series enables U-Boot to import environment variables from the
> selectd FIT configuration. One use-case is that the overall build process
> enriches the FIT configuration node with dm-verity information which
> should be injected into the kernel commandline. U-Boot will then read
> these (possibly signed) environment variables and put them into the
> actual Kernel commandline using variable replacement
> (see CONFIG_BOOTARGS_SUBST).
> 
> Example:
> 
> Config:
> CONFIG_BOOTARGS_SUBST=y
> CONFIG_ENV_IMPORT_FIT_CONF=y
> 
> FIT:
>      configurations {
>          default = "conf-1";
>              conf-1 {
>                  kernel = "kernel-1";
>                  fdt = "fdt-1";
>                  env,dm-verity-args = "dm-mod.create=...";
>                  env,bar = "someothervalue";
>              };
>      };
> 
> U-Boot cmdline:
> => env set bootargs="rootfstype=squashfs root=/dev/xyz ${dm-verity-args} ro"
> => boot
> 
> Kernel cmdline:
> Kernel command line: rootfstype=squashfs ... dm-mod.create= ...
> 
> 

I think FIT supports storing U-Boot scripts and running those via 
`source` command (usually the file extension is .scr).

I do not know if there's support for automatically loading this .scr as 
part of a config node though, but if there isn't I guess it'd make more 
sense to support this case than to come up with yet another implementation?

What do you think?

Cheers,
Quentin
