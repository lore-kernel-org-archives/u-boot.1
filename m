Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E0DCA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 16:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0924831E1;
	Mon, 11 Aug 2025 18:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i2mhuyFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8299831E4; Mon, 11 Aug 2025 18:36:46 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E035282B07
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 18:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMr0hYE6Rc7Y29KFvnH/sJhL/9WfwXC/SqAe6RS3L5Iym7CWrcH9idyJ/VCVFteZ0Z5IEAZT8Xs/mzd5dNT2LYFrrm3DY8KLtUv6QA+6c2WoKKQEUHicGya1OPydh7O56KyHmoNxnVeeyi1RahbXmeHVeYM78umJrXfpexmfryjkad7KJe4HNthPCJkVuQ3ZwWvdH6Kch7SbAFGb2cWo6T9aZyCdn0AdycMu9FaTZcCS/2gqRdYDfdUeNv9GzE9t1GpAEWygf5o7qdjz/FNr+ZNCip37Y+Dvy/tVB7H4eg7l8XLOYbAJCEGYZa8XqpEa76BnTOIPMP/OuHCsQ/5S1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egwOla9Jppsenoz1W4g9M79pvuJr2NPqxmFncgzbXVY=;
 b=OsxZAk4sFqurKfnY8yh+zsH2tZ/qEYgzvCnE6YWGFPvXWwjldYaejBsQR9V3KqwfzL6XDXgYPvkIjIwD3LVcLmesS9mZRsSwHBcJC+9bB8DofZ8swnEoFuTyuEDFc1icxJteVxoLAu9PnpCI59QRHFqCrMxYFm3+F1xYMEZOtdDqhrKl2gVzaDqiOOBslZHeb8qepGXR1eAHM63PDdp9ZMqlaVN1EYi3F8NT+uEXm3/qjdJFmWauSyM7+D0+pZmuBEAfMFyMNtvEWsd9a13r60nRRKmMnXoZzEVny7CDea6HOCHgn5hBx2ri3gkTB0UCZ/SLPgtW3rbpoRAuoKVnzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egwOla9Jppsenoz1W4g9M79pvuJr2NPqxmFncgzbXVY=;
 b=i2mhuyFsGHGJCgGjcxk2yp3jDiwGNJkRJScGH25bk3wJymhYTyyfMpo0MsjqCdVJmsC9kujEWgTcNkUUnKKwxiRgENtPZeSnbSPFTDUu57zIbJ4fWM3nBbPTbB9aC4UxcUH/bIjgGUc+jhyOkSRG2hBG1UuLJ1gIEDiv0zVb9JQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB8342.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 16:36:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 16:36:43 +0000
Message-ID: <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
Date: Mon, 11 Aug 2025 18:36:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking advice on API return type inconsistency
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0433.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c80914a-3508-4d27-15e6-08ddd8f54198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGVHTFhlc2lKdWthVERwZ2twUDl0Wno2ZXFKc0hmbEFmaVdpeGJZSk0zRGhQ?=
 =?utf-8?B?TXg4RCtIMkJlUS9vRDVOeGNPb3ZvdDFaMmJ1amdEWFgwZkFGclI4bFRueHBs?=
 =?utf-8?B?bFVSS01SNkVQWXhrR0l6ZFRraHk1dWw1Q3VFMTQ4WjBpcXdldjkyd2UzTlRh?=
 =?utf-8?B?VWQxOGw5YWdXMUVxUStuZXBpS3oyTmNyZmZKb1lyVUYxTHhTcDVvR0dZaEFj?=
 =?utf-8?B?RHNkTU11UDU2bC8vR0lIdHRGT3N2V3Fldml5MWxtQ3ZWZWpWY2lwU0M0WlFP?=
 =?utf-8?B?bnN6V2dDejhZZkh5UXlqbWo1ZG5IUzdmTTRsNUNOaGhJeWJpaHJEdTRWdW9X?=
 =?utf-8?B?NlF6M3ZSbUZseHhTMzh3aTNOZm1tWTNBb2Y4MGk3Sm1PdHhGKzVCYy90MXJL?=
 =?utf-8?B?dXFwRDlQdHhEbkl0WUh3YXhwN0paWTFWUm13VkV6T3NOZzJjY0FvQk9ldjVG?=
 =?utf-8?B?NUx5T2JmcFNCRVh4eUQ3enhxZ3A4RnZoTEVIREYvaytvbFFFMXBzaDhWdzJr?=
 =?utf-8?B?TCtPWHdUd3QzU2g3SzNoWS9MdHVGd3JaMlJqSDZHbWJTQUcwWmkrVXJsUDVD?=
 =?utf-8?B?Y1hWZnpxU083UzN4NjYwTGhlWHRGQTQrSVVnTi9HTXlyNkFpc25EVkdsTlNE?=
 =?utf-8?B?RHpjZVJsdVJQb1Q4UW4rTXlWUVRjcWk0cWFoejFRQ3BKTDYzYzJtVEtCWGM2?=
 =?utf-8?B?UVArWEhaZThwS05LQkhBcnphK2VyaDBkcHVBcmxLNitaQjBhbDF5SngycUUy?=
 =?utf-8?B?bDRTNW9mc0ZzakJyNmdOa0VHb3MwRmFVN3pCZHkwdG81TDFiMDhHc0ZoRnBY?=
 =?utf-8?B?a2hLd2FadjNrbUVyVHM4WFdEUCtObnhkRC9SODR2SXkycDZKU1BiTXVCTWU0?=
 =?utf-8?B?VXRDdzUrVW9aRDl2aFovb085S2xZOHdhSE90UlhUQXBtN3pOZTB5Tk1tNU0v?=
 =?utf-8?B?MDlTVzhOWkVNa0gwc2dXRkh3dW0vWlV5R0ZudDhqRTNxNWZGZ3RHNHB5bFhy?=
 =?utf-8?B?ZFQvR1lwN2dRaUFUZkxsWVNQRW5LSEpDRXZtV2hWVWZVOGd6RFBoMGlmVEdP?=
 =?utf-8?B?VTN3L3ZZUW5JMkNQMHhDemRQbEx4SHJheFo2RHRyeUVBUkJVZGdzYkdXSitH?=
 =?utf-8?B?RkVrK2lYcjF3Y3hHR3RxTmZZcTRjNE9DRWNsTXlxMkJ5cmtvRVc4SVlLSVVy?=
 =?utf-8?B?cHp0bDBDWE51WUR0OE43NmtITWVzeFF5elYwY0Jud2dCWVZ6VFpUdTVzKzdC?=
 =?utf-8?B?Q0FkSnlabzQveU1aNHY4OU1uS3VqT0laTzNpV2NzUDJTV3JTMjdOaXNINWxv?=
 =?utf-8?B?QXpRNzJVTnhEOXNiRlFUUXpsS0ZycGViakJvbnNhaXpJY0JNN3VRVjdrOEdu?=
 =?utf-8?B?c0tEZGo3dlRnekR2VTN4Rk5ydXhNcytkaWwwWW5TZWw3TTBmMGdGQTZtTU1C?=
 =?utf-8?B?UTE2R2Zpdmx5eDNmR2NwRGJtWEt5aERzcnd4ZUtUV0VxdHhyM01GcnNsS1d0?=
 =?utf-8?B?Vzgwb0lPV1B5ZE5Ba01PVk1XNVZ1RExxV3NHSzlJclp4cmRtNU5LZmM1L0pO?=
 =?utf-8?B?YmFMSmh0QzI2c0JHZ2lWUzNSVXRnMGVTVHFxdWp4azVEYmhMeGFuVHk1Mkdh?=
 =?utf-8?B?U1VVSUNSL0NDVXhUSmQya01IM25kKy9Nb09BVDZiSWVlemQyc3hHc1lQMkhu?=
 =?utf-8?B?c05XaVMyR1NWbUxyYVhRdFFFbUd3Y3I2alJVVUVDbnhRSkZpUVJmcU0razNo?=
 =?utf-8?B?NmdYNHdBdEpTc2FwN0pBOVMzY2MrSDVPM0hTUG9HbEZmNHdxb2dyK1Jua1d3?=
 =?utf-8?B?OHE2c2w0a3lPdDh1TWtxb0JlZjliZkJBNlY2aEFOVkVZdTJNVUU5RW9jZnNo?=
 =?utf-8?B?OW5sRUZDWjhyS0VsUWtHZUdzSDdwaXNLNGx5RmZtT1Mra2gzNGxnWEVVbTFK?=
 =?utf-8?Q?F9q7DC7lNjM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cExHMHhnR2J2T2FsOFlJSm5ycDhBSittQm1NaXlyTmM4QmVjOEhRTVg1Yjcz?=
 =?utf-8?B?b3JJRWpad1kxZ042a1RjSlg2YnREL0JVYjBzV3dSQUEvNCtmVnA3enVkRDFt?=
 =?utf-8?B?eTZqRDhHUGsvVnJIc3JXd2R5VEt4YW0reHJOdDFWZkZ1MTBUK1dIbVRFSmYw?=
 =?utf-8?B?U3ppd0VBV2R5SGJzUWhvVFpOZmJFaUVqZk1xaTg5ZFNxb1plTlVac3RZOUlY?=
 =?utf-8?B?U0gzcGFEaTJwU3FVQzdibm1RVEUzUXN6UVJSb3BPOFptT1RmTjlKTGpqYWc5?=
 =?utf-8?B?T0NZTUthVkYwR2hpNENqK2pvNXprRlpyVDNTeXptRng5TUhjZGFYNW83clpr?=
 =?utf-8?B?Nm9sRzhCZ0pIbzkrWnByOTdWd2pmQ0FGaWc0dHBDYkRkdFY0ZFc1VXFFc3VM?=
 =?utf-8?B?KytlTTlHWkJhSCtTRzFVTGNlY3psYmpZeThucDJRb2xpUDEwc2hPUWZFUG5a?=
 =?utf-8?B?aFY3L0Z3dmNaRTlMWG1jMmU3SWdLanN6MzRsMkRvSlFWOEUycXZoc3p5a0g5?=
 =?utf-8?B?UjdoalVIRTc4Rk8vTXdHODMwNVFwSXF3ekFRRVB2ckpzcXdzanQrdzFMRjBv?=
 =?utf-8?B?U2Ztb2MwZm9lRUJ4T1RiZ1R2MkFXMG5vMkxiNkc0OWtPeEhZVjk4ZTZxYmQ3?=
 =?utf-8?B?NGZEcS9BcVpoZVFocStVTm5HWjNpV3F4T0ZCQnh4Um95SE5pazNCY3RJVzE4?=
 =?utf-8?B?cUgxL25FRHgrRjlzS2JhUjhpNWlQeVJYRG1nSXo2N1FCSXVHZWxhWi9SZ296?=
 =?utf-8?B?cXFjbkZJTzRyM2pvMW02TmJTWVR1Tlp4ZkdjVlFHQUo1azlGWHhyL0lpend1?=
 =?utf-8?B?TXNVVExIR0JSdWJtVG1GOFVscHkvSUxhajZiTlJ6R3BPYlV1a2JWa2RtOURH?=
 =?utf-8?B?QXBCVU5jZWE2MTBrV3pZaDJFNkFFcHRheHBHYS8zZ0svVWdvYVNGKzhvY2hw?=
 =?utf-8?B?R2lyVXVxTjNybzlxOHdaTmdhZHFXd051SFJReVRWM2wzV1lPQnlEWmMzN0pX?=
 =?utf-8?B?YjFLMEZxeWZwVzljN0h3eENqY3gzN2NVczIvQ09hclRuckUrN0Y0SlR4c2Zx?=
 =?utf-8?B?S0hqMFMrR0psUE03bHVBK2dJVTlIYUxzeTVkNE9FWHptT1JDUmthU0JoT2Fm?=
 =?utf-8?B?NE92Y0REaHcyS3JCR094TGZyeVhoUDlaakZtano0dUkyTHV6YWtQKzFUWTk4?=
 =?utf-8?B?eHNRZ01vNWhtSGRrRithMmlGR0VpQnZzbC9JQXhEeXFkb0h4UnE4aEQ5eG02?=
 =?utf-8?B?UENrM05vRTFoZmo0K2t3aE5rcVBnWktmTkI3bE41cHVXUisxM01XWmp2K1pV?=
 =?utf-8?B?SFhwa3FLZDVUSlkrN01VOE1DamVjTDRhL3QxTjB6L2FWaDRwVFZXY2dnTkxt?=
 =?utf-8?B?WCt2cTFRN2FRZW5qTTVtZ0prZWxDL1dVSWRIWnNETzdrMlBROXVYSWwzNXdk?=
 =?utf-8?B?VU1vd1NtNXp5WXJMZmVaRlRTZmE2bU4vMTBxTWtjSjFsSXFROG45eWpjL294?=
 =?utf-8?B?aHpUREtYZzBaZXY0aFdDbWxDVmtmdjdTV09RdDRBdW9IaWx5RW12N2lmZUZC?=
 =?utf-8?B?UWZmeE9acnlsTXRYU25sWThkd2kra1pBeDFJdTI0UkFlQlg5eS9SYjNXeVJk?=
 =?utf-8?B?WldpZnRSMDh4cmt6SWhlbDZpVlZqOVVZbzdjMUZEOFFXckdqRitGU2lUWE9U?=
 =?utf-8?B?M3ZMbzNTUG5iTnFuamp6ZnJ6Z1ZUSyt6dkh5N2pwS0xyQ21IUVVXSXZ6WTht?=
 =?utf-8?B?c291ZkhEL2Z3UEc1dkNaRmxJYVZpR1l5YS9hU1o4bmlxbEZBdjg1eDBpb1VS?=
 =?utf-8?B?a2l4a0FveUxvY2ZFVm05NG93K25RQkdlY3JBSzZzQ0JYQUFBUU8ySmxIVGQ2?=
 =?utf-8?B?RThlMHZvUE5BeXpZTXk0SlpUZUdHWjNFZFpZNHljK2lqa3RremFxaDFpK0tT?=
 =?utf-8?B?LzFPUzVrS2p2UytlNmZNNDFyNHNuMHl4RWFpL0lNbmlaZG55MXF4L3RlTXB0?=
 =?utf-8?B?LzZGV0RndVg0YUhqMVFLVUg3Z29CSGVhOVZTMC9nUDNtZGxNQlZjN1NsTVdQ?=
 =?utf-8?B?MnhIVmp5VHkrcTNaNUFxUGR6RlFqQ09XV2FKVkpQeExSNjRMejhhVTd2WWpW?=
 =?utf-8?B?ZmgxTUswdEw3NlhFdWVpVHIwNWdlYU5hRFFabmZtUVhpb21URlE4eHFPNzFk?=
 =?utf-8?B?bk41cmpuMXhNN25rSExpTVJaTTR2N21aTXcyZytqdWZpYUhpU1ZCQjJBcmQy?=
 =?utf-8?B?cmhJa1dtelptRk04VlgvODMwS3JnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c80914a-3508-4d27-15e6-08ddd8f54198
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 16:36:43.6658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QaLvuEnGoj2iE6mqX+80nBJVNluZcq2IDtOkB7oQh00Gg2+z3PXO3m/4J3YGDWIDoc87nCLyzi8RQ03Q5kMRXMfqbbljrW1Da3jnB46kZVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8342
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

Hi Andrew,

On 8/11/25 5:24 PM, Andrew Goodbody wrote:
> Hi,
> 
> I was wondering what people's thoughts were on API return types. In 
> particular there is this and other examples in include/clk-uclass.h
> 
> /**
>   * get_rate() - Get current clock rate.
>   * @clk:    The clock to query.
>   *
>   * This returns the current rate of a clock. If the clock is disabled, it
>   * returns the rate at which the clock would run if it was enabled. The
>   * following pseudo-code should hold::
>   *
>   *   disable(clk)
>   *   rate = get_rate(clk)
>   *   enable(clk)
>   *   assert(get_rate(clk) == rate)
>   *
>   * Return:
>   * * The rate of @clk
>   * * -%ENOSYS if this function is not implemented for @clk
>   * * -%ENOENT if @clk->id is invalid. Prefer using an assert instead, 
> and doing
>   *   this check in request().
>   * * Another negative error value (such as %EIO or %ECOMM) if the rate 
> could
>   *   not be determined due to a bus error.
>   */
> ulong get_rate(struct clk *clk);
> 
> 
> get_rate is declared as returning a ulong but the description says that 
> it can return negative errors. A simple test of the return value for 
> being less than 0 will always fail so errors can go undetected. Casting 
> to a signed type seems less than ideal.
> 
> What is the best way to deal with this? Cast to a signed or update the 
> API to be signed or...?
> 

Note that clk_get_rate() in the kernel has the same function signature 
so I would refrain from changing the type otherwise we'll have some 
"funny" bugs to handle considering it isn't that uncommon to import 
drivers almost as-is from the Linux kernel.

You have get_rate, clk_get_rate and clk_ops.get_rate that should I 
believe share the same signature?

This for sure isn't helping you but I also couldn't come up with 
something the 5min I thought about it :/

Cheers,
Quentin
