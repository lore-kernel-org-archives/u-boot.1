Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A16C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 13:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B516982E37;
	Tue, 15 Jul 2025 15:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="aQpPbovZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF9182F14; Tue, 15 Jul 2025 15:45:40 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A15982BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 15:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkhCtQ0heAX/MFZJyKHlHRgE5k0HYgRxqNQ76cmYi6YpJl4+PeCvT8YD6KigqOlPkVptloIf7N+NLdi7JpadlKPtSzAAr3kZgr4hvwW2yIvF7uM7x/TRcCqxSDJ+YOob3s14peOxQduhZc+3Ocs4AONDKz53QYjjrcvKZhlfCDidXLC/kgpWaeZe8vbmMHhiXfQASrmZjLHkksoZmVTMPtQB29nA2icuAULUdGc2lSlMiBQlDGk6A3ZMcs7kc4up1WSYmxvHLJTbGbegT6glcQXvNo7F0F8zDiy1IhEPwyAR2h450WwjV/iKlNCW1fhW+Wfsv6EA3NS2lyz0+loG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq3O0e2nQuZCQJoagbFGsdErS2c3YlgRFB/LxhUm7DE=;
 b=WuCH4STwxoLelzjJYGd6nx1sLuIHiiynVQCCvBSOBm4xToVziK1sMsfbe8qxGnZniMbdL3M8dBbgZnUVJ3N5BhnPG1Sid7/1hB3F7XctC/kxmmmM4O1SP5De13B4GnicNjuE1N71fM7myU7V5DFO8tAOXHtB4F0c/+XKZCKT3XN8m1b+8GrbtPdaCuDeRNS/TaiQ59zcILhWMVprFlozrjtbwKlUtxQyG/f75bkKlmeTb2QFUvLYWyFjkrS7XW67d8RpyDvnyMJ+cKD4Ex4uftlhmp5IZSJW9kSHSEEo/oy3sRhU1xP5j/dNPoU/SGkxnVhoIpV76Hu6cmH1ggb0mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq3O0e2nQuZCQJoagbFGsdErS2c3YlgRFB/LxhUm7DE=;
 b=aQpPbovZ/lkomUmI1wywcV1hJTeW3YjJ6JXrEsFj+jKQq/u1Qk3SECe/YQZ7s2xhtRdoJ8d8j8dVYQ8act4tzFR8LB9RfFYIQiE3fhL2UpVoixVHkNNEUeO3kwUdx4h5/gY3JaraloPI1pFq04koYpgPTetsc0ozuYa7lfrW1V0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB7992.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 13:45:32 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8880.029; Tue, 15 Jul 2025
 13:45:31 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,  Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <20250714232902.GB193579@bill-the-cat> (Tom Rini's message of
 "Mon, 14 Jul 2025 17:29:02 -0600")
References: <20250714232902.GB193579@bill-the-cat>
Date: Tue, 15 Jul 2025 15:45:29 +0200
Message-ID: <87tt3dva86.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MM0P280CA0085.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:8::7)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c4fa75c-351e-4d92-8b27-08ddc3a5dde5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WnY0NXNIeEdndHJZelBPNzlrenV3OGlVbFZoamdCd0FUU0IrMVptQjNQMWFu?=
 =?utf-8?B?T1d4ZXpBWnpJMitwbUFab1YrNkRmbGZYMk1TVnBJY3FLVnBVSzRKcm9SV1dE?=
 =?utf-8?B?QjNoaGI4T04wSS9RVXROZzJQZEVxc3ZITzFXeFU2YUpwUnJlYnJBeS81UFlG?=
 =?utf-8?B?ZzJVKzJTZnZRbGl1Zm5NUjljQzFtWGNMRDdxc0UzdEVjRndVbGhhVUpudklq?=
 =?utf-8?B?YkZ3Q1hzSWk1Qm00bUlwSkRuTzhMTnJUbzVnTVU4bmMxbzRCK0xCeXF4clNH?=
 =?utf-8?B?K2ZZd1VxT0tXYUxUQk9hRm43KzJ2US9TQ2txZmdZZE9XZTM3akJCQm5zb0p2?=
 =?utf-8?B?UlNoK1dLNTZsbEdCamgrQ3EyWXh5SVFqUXJvQnFIMGhibUU3L3FNczBnK3Yw?=
 =?utf-8?B?emhjMklsQXdIVFV2TktBUU1WdkJWa3o0N1ZKek5IbHZNa3JLK2ltMzQ4QWlT?=
 =?utf-8?B?Q1VKRVF0cEk0dkJpYmVHYVJGMTVkRVRicW12QUc4Rmd1Zks3bTFMYzlOVzdU?=
 =?utf-8?B?K0NDTjJMWUZhMWxXeWp1ZTVmM2JrSmdlUVpZdU9KVUVjMFNCbDZhZkJ6blph?=
 =?utf-8?B?K0gyQzU0NXBDUkI1YVVpSUorbllLeHBnVEtHNUdrUmtML2g5d1FraGdkbGUy?=
 =?utf-8?B?VHFkb0xmbzF0d1hZTEdPQzVvd09LRnRzS0t4amhFalVGNk1RVlhRclB1YVBH?=
 =?utf-8?B?QUlMaXk5TEpIRk1GYjB5R0xpRjMzYUZTeEpLWHlpYVd6UVlZbXNMeWM0VXVa?=
 =?utf-8?B?WFJjN0dNYjQvUzdId3l6YTVrbVRNaTJpYUIxV3JzR0tackZMWU5qcUFtenBl?=
 =?utf-8?B?VGp3NmRWUzBFTkVJRGpmUzd0dkx5K1A0WktzN05aZ3YxUHVxMDBlN1N2Rmda?=
 =?utf-8?B?N1ZoS0wxcjNWdGZxV1VZbnRjR2o1d0U1dTlBUHIzd1dNUlYzTk15VXRFcVZj?=
 =?utf-8?B?RVpjRWI1U21GS1BJOUdMOUlXM0RVYWtPaDBiQ1JFMysyditVNDRQeTZUZ0Zo?=
 =?utf-8?B?UGQrcFBsZHlDY2I5eXBWVzMvOVd4eUpuaTgvRmRvSGVwNUJmcWNVWk9IelVk?=
 =?utf-8?B?eEJYNWV2azU4MUxuMno1Q1lkZFdrWjc1dER1T3B4Ky9aUFIwcEYvREp3OVJ6?=
 =?utf-8?B?YU1ZQjBvWFZsczZDZ0c0ME1HbHFLUlNjRWxNYUFHdU1OckZTd3FXa1lwSDht?=
 =?utf-8?B?MjJYSmlKYVdlUHBHdE9DRWRObFRvdkVtaVBkY3k1WXZlWG5oUDhhM2JzTSs4?=
 =?utf-8?B?OHN3QUpYY2E2TktTeERncDdGcW5NcnFZaXUzK1UvZU1EMG9vN2h1ZEV4NlM4?=
 =?utf-8?B?emJ0aFUwV081RlpKek1GaFBFcHVRaDNTNThITjg1Ry9XSktrKzVEeVZUSThO?=
 =?utf-8?B?aWRrSXU2L05BK0szT1R4UFhFc3NvWlpUNHBzUVZ6Q0FvUXRCck1ZenAzRmVP?=
 =?utf-8?B?NEhJQ05Sc2txVVNRUnRyQk1oWDJmcDZhZGY4Mlh4Q1Q3Tm5QTVREQUV0b0xn?=
 =?utf-8?B?d2hsTXNIRnpuRjBYYVplZ1FDekNuWTVPRHNvQi9TazJlVHNWR0lnTkltT2E2?=
 =?utf-8?B?YWlLbWFKMytVcklGN0kwTEZid0hDbjkyYlp3Z3hSMVFVVlBIT1VlRnBSSzlv?=
 =?utf-8?B?bmlSR1FPQjFoRHRzMHRqL3pLZ1NKTXB2R2Ryc1kyWUkwa2NBMDFUTjdpNVA3?=
 =?utf-8?B?Y1BYMmJZWWs4ckoybjlqakVma1F0YjU4R0NWakdjQU0wdDBESkhJdWwzaEJj?=
 =?utf-8?B?Sk1FemtPZStEci9wWjdsdE5FZHErQkJNc3lxRHdWbForYS92d3FUSmRTMFlz?=
 =?utf-8?B?bnBHR0RzOVQrWVlzRUxUM2dmRG84MFdzM2V5bUxyRFllekx6ZnRTZmJQSUlq?=
 =?utf-8?B?bTN5cDIxY0U2T2Q0TVJFdTUxVndLdzBUK0hQZlFzMXROanUrT0FWT1g4dDRC?=
 =?utf-8?B?a2xseTMxcHZ1TVhhVzJYUTRkcjV4YmJQZEp1THQ3bC9TRFQxOFAvTm1VSjEw?=
 =?utf-8?B?a2tiMFZ1ZHlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXN3U1FDbjFMWjh5Tnl1eTBsbGFqbHhzekZRNXRwdWxvUm9vQjVKSmx2Uk4z?=
 =?utf-8?B?U2xJQVdKeVFhTS9NaG1vSkkrNktPeldLQ2wyWmdUVHhQQ1FyZFYwS2lHME5X?=
 =?utf-8?B?cFFsTFNJeUt1NWVISHNnb3kvbG5JWTVUTWo2Q0poMi9zWkZtNm1Nd2JxTHFK?=
 =?utf-8?B?MXhUanc0NEhocVhXSVp6c3JWdE01T2hTOHF4elBTWWRNbERWVldBaFg3ditQ?=
 =?utf-8?B?ZjNRbXQvWlJDeDU3MzVjTWR5b0NuZkRxRHM0Wk5BSDJhYWRhbTdteTVrb3p6?=
 =?utf-8?B?eGFkVElRc1NoYVdKT3Y5VkVkQ1hEc2FITTdFTnkvbGpPS01EWmtoTGNQS1Fm?=
 =?utf-8?B?NjdaNGUxLzZDTEJLQm95Y3BOQ1ltTGErSzdiNFY1am1reUhhaUJGZnRtV3lx?=
 =?utf-8?B?SGZ4K2c1QUErV0IvaUZKdEt6eXpmWU5nclYvckJsVTNTRUtUekM2L3M0NHJo?=
 =?utf-8?B?UWV6ZExjN0htbVV2d1RHTkYzWjV4c05mY1RMalkweFZVTnVpcnlhOWNoaFpz?=
 =?utf-8?B?UEJabXNWQlRiTnlOYS9KdHhIZ3drSC9LWmV0eDZwdWl4VXM0eXFtODBwc0hP?=
 =?utf-8?B?c2VwMmg0cm9HRUJYWS93d0ZaYVB2L1RENXNSR2MreWdIRGw3QmRZaE83VWlv?=
 =?utf-8?B?SGtYVWxGUzMveUIvMWJWVVJUWERhWG1wYzEwL2tvTkJtRG1uNWFrTytnVDhK?=
 =?utf-8?B?OExOb2dZUE1QbkZDZVJmRk5BSGVZcEVPcVBCMldPZjVkRFVwMm10QXVoYWN5?=
 =?utf-8?B?K0ZXVmh2NldMMWZmTFpaYTNvY1dqMjFFREEyaFJIU2huUDVFWlRvRnUyblBy?=
 =?utf-8?B?d1VwaEpwQS9lWndUV2EvQXVPTVhoWDR6Q041bStRQjJtelJUcFM5MUJPU2ly?=
 =?utf-8?B?b1pyVzdpVjZESWJwb1ZJbHpXUnBmeVFKcGM1K1NRR2hlZzZQbnpBb2FJV05w?=
 =?utf-8?B?cUVRRGhBOVdmeEtaa2M5bmVUaHk3dWZYNS8ydG1TbkZwWTlOa2c5MVNxQVNm?=
 =?utf-8?B?R1lBSjJnbFNEUmVOSDdRbTYvTGtPNzVpZ01WWmpSd2xVQkkrZGtxVUQ4d2hv?=
 =?utf-8?B?Z1VKR1NneUh2a3REOGdQNFIwb3oxbWtJRVBEdTBIc1BMcDRCdnR6a29rMTJ0?=
 =?utf-8?B?Y1VSeTFPNFZDMFBrZWxGamlxam9GUnAzSmJpWXRwVUhIS1llMmtvYklmeTJW?=
 =?utf-8?B?WlY4cTFsejQvZytYRjRrN2hVcCtuczZ4cHorWjVsYlZlS2VzM0dOTzBFNnQy?=
 =?utf-8?B?WjJIcFlyS3ppMUhMUFNxTjRKU2hpVFpSVUVLeDJOekpTd0s1OFRNaGliWXpQ?=
 =?utf-8?B?RDNXN05qTngyd0NtVXMzUnVyMEM2aUEweHlHT21iQzBWbWZjbWhWcFRlTFpR?=
 =?utf-8?B?bnprMm9HNjRXMWU0UkFTb2tTMk9hc1FscU9RWTBIQUxJUG55MXk2QTFOdHRz?=
 =?utf-8?B?VXhIVForQkJKcEluS0VpWW8xb2pjZ08wWGZMM2dtbTVGL1g4ZFlDYWRiajA2?=
 =?utf-8?B?c2ZoNG9zTEFUbS9LNWZIdE9PallLbUw3NHlxNVpiREliVTN5ZWxmb0RPc2tp?=
 =?utf-8?B?NGtlYjlXSGR2UXE1UFREWjVVcFhqTnEvTWRjaHpQUHZRcW9yYk1QZ1VBWUZy?=
 =?utf-8?B?REU3SWV4WmR0SDdJWTdMRVdhQzYzdGV1UTRhcWUzdG85d3N2MDNnVnpTbEFl?=
 =?utf-8?B?eXdPTmNoMlJ1VCs4UUIzVmhPN3lvWWdGWXdkZHE5WlZGbkM3alFsaTVXQ2ly?=
 =?utf-8?B?MzNoYW9jSjdYSVlVTnRnTWpQM0NPTHFUSW43dEtRN0NXTlBRL2lRdkNWNGc3?=
 =?utf-8?B?dGIrbm81R01iQUpBMGRjTnR2RE13RDNoa0hOQzcxRlNaWUYreDI5bkxXbGs2?=
 =?utf-8?B?SE8zRWlkaS9FSVJ2b3JTNkk3azMzM2owdStjaElsVFh2M1dXcWRBdnhtelF0?=
 =?utf-8?B?bUhUZUkyc2N3Z1VCSUE3SWFMSmNBSDVNR1pTem9jNEZMYXlBZnJUTzhhWUlv?=
 =?utf-8?B?ay8rTjM0R2hSRkVmSkpvQlZIN0lYdDUvb0xpZVVyZWhXYVpFNkdUN0xUbkNT?=
 =?utf-8?B?dWZtbFBYUHNjRXAxV29PQ2U3eEt0K2J4R2E4dHVKNitMRjlWTGlrdE9tSjlR?=
 =?utf-8?B?MEhwOTcrWm1TelkzQzB3WVdwS21TWTZBSFBSM3pWMmhKTmllOFVBVlg1VEM2?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4fa75c-351e-4d92-8b27-08ddc3a5dde5
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 13:45:31.8330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmyMHQqXJndZDs1p+B+hByvAdp5i+qsFjnQ/M5gNi3bf6lR8uXsF/byPFcIbdYMWT8XnSw7Yqh1c+hS9a6qYCyYESfpjnkiTzOKdS9ICDOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7992
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

On Mon, Jul 14 2025, Tom Rini <trini@konsulko.com> wrote:

> Here's the latest report from Coverity. Good news is closing 5 existing
> issues (overlap with smatch I think) but 3 new ones. Or maybe it's
> related to Rasmus' cleanup series? I can only run one report a day I
> think so I don't have granular breakdown on which changes today brought
> these up.
>
> From: <scan-admin@coverity.com>
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
> Date: Mon, Jul 14, 2025 at 5:23=E2=80=AFPM (1 day, 9 hours, 56 minutes ag=
o)
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>    - *New Defects Found:* 3
>    - 5 defect(s), reported by Coverity Scan earlier, were marked fixed in
>    the recent build analyzed by Coverity Scan.
>    - *Defects Shown:* Showing 3 of 3 defect(s)
>
> Defect Details
>
> ** CID 573150:       Integer handling issues  (INTEGER_OVERFLOW)
> /drivers/pci/pci-uclass.c: 1531           in dm_pci_map_ea_virt()
>
>
> _________________________________________________________________________=
____________________
> *** CID 573150:         Integer handling issues  (INTEGER_OVERFLOW)
> /drivers/pci/pci-uclass.c: 1531             in dm_pci_map_ea_virt()
> 1525     		if (ea_entry & PCI_EA_IS_64) {
> 1526     			/* MaxOffset 2nd DW */
> 1527     			dm_pci_read_config32(dev, ea_off + 16, &ea_entry);
> 1528     			sz |=3D ((u64)ea_entry) << 32;
> 1529     		}
> 1530
>>>>     CID 573150:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>     Expression "sz + 1UL", where "sz" is known to be equal to 18446744=
073709551615, overflows the type of "sz + 1UL", which is type "unsigned lon=
g".
> 1531     		addr =3D (pdata->virtid - 1) * (sz + 1);
> 1532     	}
> 1533

I don't see how this one could be due to the int limit patches, as I see
no reference to any _MIN/_MAX macro, also not indirectly via the
definition of PCI_EA_FIELD_MASK.

I also have no idea how Coverity can think that sz can be known to be
equal to ~0ULL. Sure, if it phrased it "if sz is equal to ..., then sz+1
overflows", but that's not what it says. Nor would that be very useful,
as just about _any_ arithmetic expression can overflow for _some_ values
of the referenced variables.

Honestly, this sounds like it has been AI-infected.

> 1534     	return addr;
> 1535     }
> 1536
>
> ** CID 573149:       Integer handling issues  (CONSTANT_EXPRESSION_RESULT=
)
> /lib/efi_loader/efi_file.c: 594           in efi_file_read_int()
>
>
> _________________________________________________________________________=
____________________
> *** CID 573149:         Integer handling issues  (CONSTANT_EXPRESSION_RES=
ULT)
> /lib/efi_loader/efi_file.c: 594             in efi_file_read_int()
> 588
> 589     	bs =3D *buffer_size;
> 590     	if (fh->isdir)
> 591     		ret =3D dir_read(fh, &bs, buffer);
> 592     	else
> 593     		ret =3D file_read(fh, &bs, buffer);
>>>>     CID 573149:         Integer handling issues  (CONSTANT_EXPRESSION_=
RESULT)
>>>>     "bs <=3D 18446744073709551615ULL /* 9223372036854775807LL * 2ULL +=
 1ULL */" is always true regardless of the values of its operands. This occ=
urs as the logical operand of "if".
> 594     	if (bs <=3D SIZE_MAX)
> 595     		*buffer_size =3D bs;
> 596     	else
> 597     		*buffer_size =3D SIZE_MAX;
> 598
> 599     	return ret;
>

So this one might be triggered by the new definition of SIZE_MAX, though
SIZE_MAX was also a compile-time (though not cpp) constant previously. I
think we should define SIZE_MAX properly instead of via that UINTPTR_MAX
indirection, which itself could use some cleanup.

But aside from that, we should be able to silence Coverity by either
just changing the <=3D to < (because in the =3D=3D case the other branch of
the if would have the same effect, but it's no longer a tautology). Or
we could maybe do *buffer_size =3D min_t(u64, bs, SIZE_MAX), though that
might expand to something with the exact same problem.


> ** CID 573148:       Integer handling issues  (INTEGER_OVERFLOW)
> /drivers/pci/pci-uclass.c: 1581           in dm_pci_map_ea_bar()
>
>
> _________________________________________________________________________=
____________________
> *** CID 573148:         Integer handling issues  (INTEGER_OVERFLOW)
> /drivers/pci/pci-uclass.c: 1581             in dm_pci_map_ea_bar()
> 1575     			addr |=3D ((u64)ea_entry) << 32;
> 1576     		}
> 1577
> 1578     		if (IS_ENABLED(CONFIG_PCI_SRIOV))
> 1579     			addr +=3D dm_pci_map_ea_virt(dev, ea_off, pdata);
> 1580
>>>>     CID 573148:         Integer handling issues  (INTEGER_OVERFLOW)
>>>>     Expression "4294967295U - addr", where "addr" is known to be equal=
 to 4294967292, underflows the type of "4294967295U - addr", which is type =
"unsigned int".
> 1581     		if (~((phys_addr_t)0) - addr < offset)
> 1582     			return NULL;
> 1583

Wait, what? Just to be completely sure, I copy-pasted those two numbers:

4294967295
4294967292

I think my 8-year old can see that subtracting the second from the first
does not lead to a negative result.

So from my chair, that's another point added to the AI hypothesis.

Rasmus
