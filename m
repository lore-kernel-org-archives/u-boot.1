Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC3CCCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 14:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74402838CE;
	Mon,  3 Nov 2025 15:21:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BlOgpqmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A425C838E5; Mon,  3 Nov 2025 15:21:21 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5653D83700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 15:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEouWFVxVl6R/uuK8SENB53CFynLyL5tle0CocTCmR6zvM+764ZNKT9A7PyQU7j5nvtYsr+REO/az+1It1yMbVCbE/WgEPZ8MMQbB9d8a9eNPKgpChQjLuPYEbPFq+0+AfyFPY4lfAomNPCUQe4bs3k4DMjW1BWC1dXk4mHid5Bei56G2z+czvWN3Dj/R6G1j0pywR9wdtoUJ1rJJHt87aP80FRPSq5mrpVswk2Z/b+RFCA0RmuDYSxr+POVXDmaoqE12Rx/0fJ1WrHNkHw4m5xmBakhuFg4GlaJhb7q5RhvH/EOs5uE/rsg70Ajm2+sg1MH73vEjDU6tCWGfEHpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DF5ms+JaeAxgSfG5v7ySImhw0pjEDsMmovr81ZL06OI=;
 b=RiiFvbfvbfM3EhNy+gI4aD3Gwt5UlT8/mf+ESAZp2uASTt7zbjM+XVV16VjcGIAddIasgqE+Dc3BqwX7Kwcrb1QlppC8W8YyX0rFF8vNL1YbX3FvhyJUNS2JyVZnqBDqi5mBPYbD8V7bWvPQGAhTkl7YzKMnuOPq8mB+4V+EQkLdKk1aJUtpdfVRc2TKlyitMGA9AQHJu/N4rIIsEJ5Vc0tVs4IFlEH9Nb4FBYnfnfe2uSDZvBOvhiN2o08lH0TxQzWVKWLa3KcJpi/6D3i/TMlCQ8PX80z0ONRLU2rmgb4dl/l38kq6mmFHX6/kM0SKTAQax8oH+UN51pyLzrDtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF5ms+JaeAxgSfG5v7ySImhw0pjEDsMmovr81ZL06OI=;
 b=BlOgpqmDW+fgizRTP6shFPga2YOzQFtNK7Gkvs85Np3pd2AsOI+tauvBrKp5qzaH7O1E+GlHbKbDQR/5g/Ljym8Z3xleHAKa0jAfyf9BeT5AxXY3WCcXI/pAHili6nwWOrKAb5IZN/r7MX9O50lLGWx0Gfm6RR9pV0mZGvf2vpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:21:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 14:21:17 +0000
Message-ID: <e974da22-6696-4537-a4c2-692029bb0c53@cherry.de>
Date: Mon, 3 Nov 2025 15:21:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
 <CAFLszTgKWU7mnFdXAOX7rH8jcGs3QrEVy=49om49=FbdNj1q=w@mail.gmail.com>
 <77d2b661-3416-41ae-9f73-68977a26aa30@cherry.de>
 <20251103141733.GK6688@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251103141733.GK6688@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: 251f6b87-2d88-4f88-08ee-08de1ae4407c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWxlSkhTK0ZaMHdWK1FJc1JDUE5uVnpjOTdNQVkvRVptOTNxdGYvYVc5OVc3?=
 =?utf-8?B?dzBjTVQ5eDR2R0tueENDU3FwSVc0M0ZJT2lpa1hSd0FOeFcrY2ZJWUx1UElX?=
 =?utf-8?B?Q3hnTkV1eEQ4YTFvSnVONzVUUmxMdDlRTUJNWmN6cG5qaWwvQWd4UkJDQ1JB?=
 =?utf-8?B?Wkl3WjZaeStuMWw0Y1hUK1dDTzJ1VXB5R3g2N3lCQVZ6MTA0RUplUkdtMm92?=
 =?utf-8?B?U29qcjAyTWNwNi95dGJBQkoxa01uL1NmelVTQTRZaEZXYzJpbEpDSDZHVE5J?=
 =?utf-8?B?bTN1VGp6eGduZzhGUW5sY3hvZklKT0pNUUEzVWFSWlNQZkdyR2wrTjdaUlp2?=
 =?utf-8?B?Zm9kdmppSGRhMHZnTDV6V09oSjl4T1IvRFFqL201a2lBTFBHY1BXbk5OSXNU?=
 =?utf-8?B?U2tDczVVYnVOSFczckp3Z3lPSVhKTmVVOEs2VmxmdG9QamJuNkVLbGZLTHgv?=
 =?utf-8?B?YXdUQVYwNHAveVNKWkJnS2VPU0JEZlhQczBnVDB2czVqcDByMllZaFpVeUFo?=
 =?utf-8?B?UXVxUTZZUElRQ3hUZlNBK2puZTZUWEhXd0E0WHlOYTMwemk4Q0t5MXJEWnAy?=
 =?utf-8?B?Z2lrNW1KNFI3Y3BEUDAxU2hRVTZVbVBWaTFFK3FOYWRPTTlEc0RNbGMzNVpK?=
 =?utf-8?B?Y09tcDQ4THNpT3NhaXhUdWl2YXlPUzdXZDFDU2JONG5KZzNESVhlOCtjeFRJ?=
 =?utf-8?B?M1Z2cGc5NmVhM3F5OG5XZE9mK1F1UE1uSVV4aXhTMHdtUGNLK21xNytkWDRu?=
 =?utf-8?B?Q3BwZjd0amxzZkUvam5rNkFyUk8xT1ZScFFHM09sa1ZuYzI0NXFjcERjZ29x?=
 =?utf-8?B?Z0hzQlVSZkZ1eitxQkljdEw0am1HT1JpTDJSMkhpcm1SVWdwNDloS29SSzNI?=
 =?utf-8?B?RVNkbStJb3dKUVRuTExmdnRRSGFpRWt1MmxZYytlRDhPMGFJLzhLU2dVdWwz?=
 =?utf-8?B?R3J4RVpSdGxRZjNqRkVsUjFmNGJvMHFOUlBVNUdZazVFSjNuRWdFbGJFOVRa?=
 =?utf-8?B?UnpCVDVRZmM5UkJjYmRhUEVhWG8waWhhZm9BeW4xdURVZEZwWk9TSFZ5aGNB?=
 =?utf-8?B?MVpCT2lmUFZ6a2oxdHFPMmVtY2VSU1RpM0NWbWN0YlV2NXlBSWFwZVh5Mmox?=
 =?utf-8?B?MURKQnZhQWpLQUFWN0t4b01iakgraVIrbFBLVXN6N01RcDhEa1dvWGlLbEp6?=
 =?utf-8?B?WmxMeWlobW9lYjgvL0dyT0VsZU1GK2RIMVBJd2toN002TXJKbGZxeklIVEJr?=
 =?utf-8?B?bk0zYUxrWWNSQVNUbFEzY3RxeEJxaktwN0JERGZEYVR3U1RuUldqRUhFZ1Vz?=
 =?utf-8?B?TjBOcnYvd0M1TVV3UlVkVEVEVjY1bXd5S3pWTUJ1L2E0cUtCeVA1RXh3VTJz?=
 =?utf-8?B?NGtpeU5Rd1dxY3E3c0pOYTdnVVJWMXliNlRmcWxhRTljWVZvMGpnVk15ckZG?=
 =?utf-8?B?bEd1Nk4xaHY4anpCU01QdUdiN291V3pSaWVubTRyR3UyUGpjL0FNbTU4SSs5?=
 =?utf-8?B?bzIvenFRMFREb01ycWdSMDk1VFh1alN4ZGYvUXVNL0V6c2dDVklKOXM4MURk?=
 =?utf-8?B?bXl1b0dGSjlOM2hGVnVDY2dCd2tKSU1RM3BvWnR1K1FnNUF2dDUvZWhnYzkv?=
 =?utf-8?B?UDU2dU1ZNU5UL2ZidTlpekZ0U0FWblUxclB4M2NRL0JjRlplREpwR2o3SHRU?=
 =?utf-8?B?VzNrS3VFUURlZHVCK0NlQzNNS1R4ei80V1RocnZyVGxrTEdhWXl2ZEFvUGRX?=
 =?utf-8?B?M3EvVVQwMVVvZHZXMTNFTE9td0N4OTJpNmF5YjlDaWg1WmxrZ3RwNXVWQlBi?=
 =?utf-8?B?NmdDRllkN1YxYms3WGFHakhRUkVEU2tFdm1zMjYzT0NTdFR5Y29GcVpCWmFF?=
 =?utf-8?B?VnlQLytBRU1DZVVLNEtxam5xYUU3VWQvbndPNjJOK2RDVG1sNWRXZTFPMHp0?=
 =?utf-8?Q?JsRoQyw2bhJa5Z0sUjXf2K/SfW7UQKvb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjVlSVp5dnFMTnFHOHhZd3IycHM1TTFJL1ZMVFIzRTI2TnhDWXRCMDdVRzdY?=
 =?utf-8?B?V0JUL0JNSHhnbDE0bHRMcGFNVlpZNmhGZWZJUjRySXpFSHRWekJOODAybC9C?=
 =?utf-8?B?UC9MRkQrQ3pjR2ozVlNZc283SHJoWGZMYlVFM0lBbitRbWdHSDN5b1F1OGZT?=
 =?utf-8?B?TVQ1UStMRnRueHpxZUhiRlY5Zk16ZkdMWnovRDZwdHRoak0zWlRmV1R5elJu?=
 =?utf-8?B?SExNWVFWakpvdGdaRmdzMXN1Z0JTNThFRnFKNW1LN20zVklRV0lvb1NJR0cv?=
 =?utf-8?B?ejNMcTBWV25zWXBpcGRUTHh0TTFUTk1QLzk5NnEyZWNpQjFnSGs5YzNxSTRQ?=
 =?utf-8?B?b2VTOG1icVdHazBERWkrSVJOUGk2eTgxdElnSlVpTURBRUNBM01hbGVxSFly?=
 =?utf-8?B?N3NiQm00QVpPdHFCaFd1a1pmak9pa3N1SGYzVFYvb2t1eGkvVkQrbjdRMWVF?=
 =?utf-8?B?OFhNS3d4VzdUNXFLZ3pEbU15dllpS21VcjBYVERtT1M1T2t5L29EcGFCQnBz?=
 =?utf-8?B?ZlJadFJidzhMZ1Y2ZjZKMkdBRHl5R2FlOGRHMElHWW5tSVV0Ulg0eHdMN09L?=
 =?utf-8?B?OEdxZGNzRGxzNmN0U0NndUg2Q0ZYT2N5bmFxbE9lZCtWQWduQ0dDZXJQdHpn?=
 =?utf-8?B?V092djNXbTQrMjJFS01Wd1lSRDBHVkw5QXlMNVdvL2UvT0dxb3E3MFUzcFJ0?=
 =?utf-8?B?WHNjL1dJZjhmWTd2SG9SYnRacFEzazVEbXFCd3NkajNTTm5VaUExTUFHaURq?=
 =?utf-8?B?WXBzQW44ZWdCYVNZeDlZS0NIQzBzVHVuWllNSlRRQXp0eWpJaEd2dkRBTk5w?=
 =?utf-8?B?YmthUkhrMVFhVTdhS3lEVjF4MmdXR0Q1eGt5RERXQzM2ZWlocGlPUWFZdjRR?=
 =?utf-8?B?Wm4yOHI4NVB4MnlBR0R1QW9UUk1hcWltZzUrMDZCTWU4THlZNWlMY2p2UE9n?=
 =?utf-8?B?N2F4WHhVVTFMdWx2dExGdnIzditmQmFCUWY0azFQcnNZc2QvNnhrYlBnUC96?=
 =?utf-8?B?OTJicVJFWkFRU0pIcHRXSmJMR05GSzQ4NHhHSG1WNG9Mb3ZHYjlNT0V2aHFr?=
 =?utf-8?B?bVJ0MzBtZStRUzF1am1LRkVSdzcweWZuSkJCdkpSTG0yUXpYZnM2YW5jMnQ5?=
 =?utf-8?B?MDRja0ZNaksyQlRxeGtib3dNVUFvVWdBM3liS3l2eTRKbzRGdHArcmdJUlBP?=
 =?utf-8?B?OGRTd1JXVVZ2ZTY1ZUU1WUdRRy8rbVFRSC9nOTJEbys3WFYxeDZpSmxDUDNR?=
 =?utf-8?B?M3F5NndhdjlRbDJXbTVlTy9UZjR2V2ErL2t2K0dQVTVIVDZLUFF6UzM3SEpG?=
 =?utf-8?B?M1Jnb2JSazBoQ3IwaTBtQUFxaVZCZ0NwblpMcWtZQTQrdVpybzF0U1BFYjY2?=
 =?utf-8?B?V3RhVnRMcHVkVkM5TmhZVjZXdXc0MWtEaGd2R3RhM1hpRlQwRjVXZjhJbXkx?=
 =?utf-8?B?U1gwNUVhUlBGWTk2c2hRV2pzNUNab1l1R2g2YnNNMHE0bEhxRWxzbE9ZOUJC?=
 =?utf-8?B?V0pua3NCemU2dmppRWZaVmdrU0xybE95R0VsSGo2aVh3STdFcVRLVXBPZDVD?=
 =?utf-8?B?L2RYRWNGVjkvYmVXaHhBeDBTdjZ0ZHlndlN3R1lLcFpWV0JXNTgrdWJwRHNI?=
 =?utf-8?B?QmJObGQ2MkpOcXpPN20zbkliVnZ5aWtEVHU0YVZjcWVZMnV5ZWxWc1FOQ3NQ?=
 =?utf-8?B?ZTRSTHBOdDRraml3Z2xFMnFhQVkrRmcyblJsMTJOcFp5UU1EcndQQXltYWF1?=
 =?utf-8?B?cWROd1Q1MzFaTHRZcTFCQ0NwTFQ3OEZmSFpZL0tCZ0dNcEtRVm9VeXZBNTJ5?=
 =?utf-8?B?Rkp4V1dtT0Y0Yk9UQm8xQ01WK0tvT3JNRXdoVE56MVhMcndSU1ZrWDl1d1kr?=
 =?utf-8?B?SGl5enRPUWJ1V2RxS2xKU3lLRG85cjNmOVNVbDlsc2NOOUpSUjUzbVdMRWd5?=
 =?utf-8?B?NFQ1c04wLzFZU2xpUDRJQmdxZ1U3cSt0NEJqQ0cxeFhFL0d5QzRqVGE4WTBw?=
 =?utf-8?B?d1dwVGZXdUlRT1VSRUcxRHFxanJUNTRYU0gxYmo0c1RJKy9VODZJdXpUM1FZ?=
 =?utf-8?B?eUhqQnRwWUM5Z21wUHoweG0vMTc0MCt4SDlRMmhEK3JFalgvci9aQndwbksy?=
 =?utf-8?B?Rjd4cEttVmRkZzY5anJ0YzFFTENHcFBSSHFFK2h4b1NWYzZNVFZZeEszWndt?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 251f6b87-2d88-4f88-08ee-08de1ae4407c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:21:17.1419 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYHURT4QALsO69Sy/B8o2e9I9szgGQ5S2oS5gBcOMLHCLpxNRDm0xDTcnbK+otn1RZIsHe1JPJz6RqqNekt8hrJdlrUlKow0FfLI/T6Gv8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
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

Hi Tom,

On 11/3/25 3:17 PM, Tom Rini wrote:
> On Mon, Nov 03, 2025 at 01:13:04PM +0100, Quentin Schulz wrote:
>> Hi Simon,
>>
>> On 11/2/25 8:53 PM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>>>
>>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>>
>>>> mkimage has support for OpenSSL engines but binman currently doesn't for
>>>> direct callers of mkimage (e.g. the fit etype). This prepares for adding
>>>> support for OpenSSL engines for signing elements of a FIT image, which
>>>> will done in the next commit.
>>>>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>>> ---
>>>>    tools/binman/btool/mkimage.py | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> Please make sure this is tested.
>>>
>>
>> That was the anticipated and feared answer. I'll need to figure out how to
>> create a dummy OpenSSL engine which doesn't require any hardware so it can
>> be part of the CI. I have no experience with OpenSSL, so this will take a
>> while.
>>
>> Just to be sure I'm not sinking time into things U-Boot has no interest in,
>> would supporting OpenSSL engines for signing be mergeable? OpenSSL has
>> deprecated engines with their 3.0 release in favor of providers (see a
>> recent series on the U-Boot ML for their support in U-Boot and
>> https://github.com/openssl/openssl/blob/master/README-ENGINES.md for the
>> official stance of OpenSSL on this). Porting my employer's engine to
>> provider isn't planned (yet?) but I would like to know if U-Boot has no
>> interest supporting that use-case, in which case I will "happily" keep this
>> downstream only.
> 
> This is another case I think where the utility of adding a test is
> important too. For the question of supporting SSL and engines, the
> answer is that LibreSSL isn't doing what OpenSSL is doing and we will
> continue supporting LibreSSL using hosts. And I would rather see this
> code in the project, so that the real life needs can be accounted for in
> future changes to the code than it be kept out because introducing a
> dummy test wasn't easy and so didn't end up happening.
> 

I wanted to make sure the time I would spend on writing the tests 
wouldn't be lost on me if U-Boot had no interest in supporting signing 
with OpenSSL engines in the first place :)

I'll add this on my ever growing todo list and will send a v2 in the future.

Thanks for the quick feedback!

Cheers,
Quentin
