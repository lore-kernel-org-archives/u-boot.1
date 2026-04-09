Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6FDE9DE68
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 09:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D6F839D5;
	Thu,  9 Apr 2026 11:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="JNspyrc5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789AF83CF5; Thu,  9 Apr 2026 11:07:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 148F683693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 11:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqMxWaF4XewmR44sSpppotY8WkDhb7+YaosFyitIVaH6gMoK7qK7HC4BfMD6BnHPT+IuKsFsoFBgBWz1ZGksfEyz0SVwLDcpfUzXmWIekVpPRPD0OBUijT/JheaR2D1GIhG4liFAS18Pmy0DqQaqo+wDcsKq3kyO8NL1xCz1VR+EUDggwCnEY8S2bR6KcNSZ28bOOgh0FOR30G6wSmKhYotxnHq//9jYVj1d3FxU2xPn+gZ7C02UJVuOztQC5IQSF4DJaL/4gm10x/eoPkr80PWfdE4TI0f+5GOcG8S8lYM4sEagSdmQh3OzkFR0w4GsmDOQytqBX/6N6j09TQ78Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2DDaC5iJovpLSEEGNqnLQ9CzHLNopdtZ/NXZM7Bg10=;
 b=BdxToIShBTP+hLC2VeL+yCSZ6cYgicDtsWeBbdlw0q9spC+jtlJL0u0jDDsZmXEgz42CgVVj7EVwNbKaWZyEEp1lq9PzACQ4IiYwf3/p1rL838TmKVjiGy98ypUn/STZtQvYaYRWwdCv902jhANNB+Uu6fIUAs0GA9MfdT+EmckLPYImU/FHx+e44eQxFcVaoflDW3YQxbnJ+TVC63aH83odkRkilSpZmNZBeRJG7J/9LUrGA6xur3kMmex/ykxh+ce/U8t8MLymZCOB9/2bSFVHmamsEbHxMxU9ipj8iFnl91N2m05nZjnYXRNgmGbjYPx57QcSqpU7ZxEd2aglDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2DDaC5iJovpLSEEGNqnLQ9CzHLNopdtZ/NXZM7Bg10=;
 b=JNspyrc5KD5JS6SYAAwM8J7FtACAU4QoG2EkT6JXr6sQ421zyTfUwKEMPzZP1C8BeLMnKGZ7C4jxmnuGZq0Uq5BUPy+r8xfDxoTDP380SaHkCVw5w83brh8JAQv0uf85Sx8WYgSHS0YgOOeDMkAizg5H/caNWJek5zehUGcfI2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by DU0PR10MB6978.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:416::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 09:07:33 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 09:07:33 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tom Rini <trini@konsulko.com>,  Franz Schnyder <fra.schnyder@gmail.com>,
 <u-boot@lists.denx.de>,  Francesco Dolcini
 <francesco.dolcini@toradex.com>,  Franz Schnyder
 <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
In-Reply-To: <ac-ADDwtwS-xuFTE@livingston.pivistrello.it> (Francesco Dolcini's
 message of "Fri, 3 Apr 2026 10:53:32 +0200")
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
 <20260401051027.GA4471@francesco-nb>
 <20260402233029.GI41863@bill-the-cat>
 <ac-ADDwtwS-xuFTE@livingston.pivistrello.it>
Date: Thu, 09 Apr 2026 11:07:31 +0200
Message-ID: <87v7e0o624.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::10) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|DU0PR10MB6978:EE_
X-MS-Office365-Filtering-Correlation-Id: 161dcebf-e296-4d48-ea36-08de96176f3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HSRP7hBHBX8bY8fc8dBsPve/2l+fBPk3feKLc12XCsSRCw1I8IffFAdmMTEv3tvm1SP6rfB4fzmL+TYj3vSG3kyXrWGnGY61/of8LIlXBeeRIgPA12/OE4dTuFRY6dY6YzCeyOjj6P+2WX2wOzn3ees2MP8t6Wd8ZG/YPEBFJtnN0avtDKxIVWa7vE9UTZOUYq+0AHR9Wy5h0MtmnyFCQeJgu3e3JfGMfG9FWBPYyPWUp3HdRleN13jy/LAxSxMb8173bGYyYAdpqul6B9sQ9bvzeX7+RVDli05F9ylAQvn7V7Rzp1gehFLsYfiMvAhktSBIhlNFO4auEBFqdTdIBR3zoiJTP3zugRM0YPD/UE9JvOB8ZGBVmRI4zjmgamH0kfw+W+Lzt4fq3L/lah5VWdG01XlqMOl44e3TipHZV+QwIbLll8KN7II7SwOUCJSsMB7iEzM7pc6UJUyFmribCXTqfvzKN0qEY4Q6WZSjvFgFFTH66Oj0qe28B/D2ZzqOJGFM524dRsNFTbMWcprV7mx2BwHflWbD6MVvXaB25bpyBwtRygbTwx6YM00evehBmUBk7+dPCanjy+qaYF5kXAZOqHb7HKLzrobbkSJ2PO8n6Y+2uM0ZskkljfvWC2eyIlt+XwXCXnUcGk91k1DmPJj7/ZSZd31rSyVHfGcBMfzFU1zqpIO99Z6dRg1RTvSWbrs4Y37lv6ap2zEwO8mGCf28eIe30+rE4161OlMKQba7G3YZo8srgnc/WDp2/yn94rqPmwHtdL3Qk3ovXKx5tmVNPlCEAcazw4OGaqu6rro=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7iH195WiRd6o/jE+IeXzARTr14W2iyVeOIVdTleL66vNbEBgVzUSmJ4EaOb?=
 =?us-ascii?Q?6V3C0au1QZb79akNhIUWdWoEuDJfqcbwfsLszES1wVm3MC+Ht9Dd9X0sxjZ2?=
 =?us-ascii?Q?eF6A9h3EsVd5V2FJhPwLVth2BLnT0H3WO6PUXf3uVD9eNg3/gCjlfjDXz4ww?=
 =?us-ascii?Q?pD/TjYe5Ur8KcsuQAUNhMid3cCbFgqBp8Ew98P8ASvYoFXPWXuvMTnYN1Ef4?=
 =?us-ascii?Q?cAobwPx77CWuqcT7B79CwKCM/qlvq71fQdWNsATRApH7IG5IKzsLh05IQzcc?=
 =?us-ascii?Q?N76nTtt16KlqgABNiZ4VxsnK8Ua0RLMeMClmJeskKr6shwIhE2kXhltVC31P?=
 =?us-ascii?Q?UVPeXIq1wg5OOIRbYwbl99UOZiM4YWQp1UeNBn9JRAyS0ub1GChhSHe8kQBt?=
 =?us-ascii?Q?yFYZ+R6TgMsVO7ZJQGZYKssGgT0FPEZ+ydRDbrluAZNgyTNPgE2VXrPJcQe0?=
 =?us-ascii?Q?i01DgLOU40a9xgv6+G6DmYTUmem0qMhMvD2la+EbZAa3+I7XyDFe0KsabkIq?=
 =?us-ascii?Q?FzowsPDRHcNOBhVNiPrB2TaB60nrfe+xxnJBr3D18WE6VTt/4l0xa1oUb8Tz?=
 =?us-ascii?Q?pUBv08BsGAPkxP0smhNFy1Z9q4iWo4vAVexgH7i7OQRf65yCsblVz/TjqJMd?=
 =?us-ascii?Q?Zwg39aIEg/7L9ghzOYX3oM1T2d4aFK2JFC7j0jSPnp0qSnoC+ncuU9dtLgbx?=
 =?us-ascii?Q?WXek7v1SSc8HYUYQNIr0C/tbiiyEffxxYKVo/qF2I5f4f1Uy7IhyiELKu1wZ?=
 =?us-ascii?Q?hoyRFMwDkj3p4Cciv2wlCFPLHCLIRQdwPZYXp+nEpDw+vQ7k/8g3BLVDYoWm?=
 =?us-ascii?Q?jOFeeRwVawK7wz3A8j5AOHQnvGJVPvelvb8ZUgiXc/1sLz/VWRvLEKnM4zTg?=
 =?us-ascii?Q?z2oWHV38cTqTH2dVsSgecnketWPJ9ScskWXGGtsulxeU7DRC0SwJzt43GWKv?=
 =?us-ascii?Q?0j4ZZ2ih3TeWtyjbmnSvRUCZxwF6/GCyPGPslc+7xfUk5NONRv0N4UOk/pj2?=
 =?us-ascii?Q?xtf6hRI7bU36AyDY7wIvZIO0QWmT1UZmwedOmdpT0ENSo8uR+jvPBAX4UY8Q?=
 =?us-ascii?Q?+/5QJ5v4qJo0RShmCjnqnTHVq2it/GQ5/VQ5CdI4brN112RpY+ukHLPJL1/H?=
 =?us-ascii?Q?WdRFvteweDrZ8dyVmDdBDIsLwtbvybsbjIqcmfG5obdkUcUAEuWggH/2omVT?=
 =?us-ascii?Q?s9qGHXZiDBfwY2GTQZt4ExG9vC4YSYgtKYLJ5M7hm3jRBiH0UKIZL/+NkjFf?=
 =?us-ascii?Q?NoAgJ3xTBd5ruFWXSIm53Y0Jovu78up1i3kNqtHluBZz+8gEdcmMfbo+eLE+?=
 =?us-ascii?Q?9krWGCRqEKZZnVcqDnFpbN1UXQ8pybTPlbY96myvMMLDWB7fd+tHE2JrBtPf?=
 =?us-ascii?Q?1lS0bhdJ2+kI7bpAlPfaoR+5367FNEFElxxbBkFgnh1aV0KwKMs6NhMlbiMd?=
 =?us-ascii?Q?x0v+vtnTGCSKxB3s8pCZjeXLnGYXZlwxHyirsgB/3UaFwHXTNeDSFjVesS+2?=
 =?us-ascii?Q?caKusBke3wxYOKUx2V7oXkHF3dPbxtWoryNZ/+QjR2fzPAWhY7+Af/hN3bmK?=
 =?us-ascii?Q?N7/hoUFsSm2gZ8UqF9Ro/oBAoxm2GlHUhgt5oxPLTWFDrfjdJ5Z+p8i1fifz?=
 =?us-ascii?Q?WTeqm1z9mMTWb/NQuC+1WExsvOQppI/v1+IJn0oI5sZlV+NK2HQGv60sQOaJ?=
 =?us-ascii?Q?htXf7ggzQ3OGNxkowk0S0avIPXz2wx2BIhb3gA0WZorBSstwdmQ2dC/2skLu?=
 =?us-ascii?Q?vUeo5Q6r4urrQ/tolnrQYFWiqxvR1ic=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 161dcebf-e296-4d48-ea36-08de96176f3b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:07:32.9641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+IOKD5GTQ/X+VYqDOpWhJoeq4A1RgIIr2n7i99TwXnhxGEpygAsvNv//fFrfhx+YRVujk/TFhMMSBvhXuhl2oYk3DqmIw/p48ntFEVjd5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6978
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

On Fri, Apr 03 2026, Francesco Dolcini <francesco@dolcini.it> wrote:

> On Thu, Apr 02, 2026 at 05:30:29PM -0600, Tom Rini wrote:
>> On Wed, Apr 01, 2026 at 07:10:27AM +0200, Francesco Dolcini wrote:
>> > On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
>> > > From: Franz Schnyder <franz.schnyder@toradex.com>
>> > > 
>> > > With correct POSIX handling, unquoted empty variables can turn the
>> > > expression like
>> > > 	test -n ${fdtfile}
>> > > into
>> > > 	test -n
>> > > 
>> > > The POSIX handling for single argument `test` evaluates it as true,
>> > > so the fallback initialization will be skipped unexpectedly.
>> > > Quoting variable expansions in `test` expressions will always result in
>> > > correct behavior for empty and non-empty values.
>> > > This change was triggered by
>> > > commit 8b0619579b22 ("cmd: test: fix handling of single-argument form of test")
>> > > The aim is to have a less fragile codebase that is not dependent on a
>> > > quirk of the shell implementation.
>> > > 
>> > > Use quoted variable expansions in `test` expressions throughout.
>> > > 
>> > > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
>> > 
>> > Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>> 
>> I've decided to go with:
>> https://patchwork.ozlabs.org/project/uboot/patch/20260330140106.401876-1-ravi@prevas.dk/
>> to make sure that everyone that might hit this problem doesn't end up
>> broken, thanks.
>
> I am wondering if you should apply this in any case. This change is generally correct.

I agree. And note that this really isn't anything to do with the 'test'
command per se, it's simply that using any variable whose value can be
empty or contain spaces is prone to produce something other than exactly
1 word, exactly as in userspace shell, and once the shell has done its
parsing and word splitting, the called command really has no way of
knowing that there's an empty argument missing.

> In the past when trying to move to some more modern shell as default stuff broke
> for us, we reverted the change without investigating. Maybe it was exactly the
> same issue.
>
> See https://lore.kernel.org/u-boot/20240111170418.GA7220@francesco-nb/

I don't think that was the same issue, but there are certainly differences
between the old and new parser when it comes to quoting and escaping,
and that 'env set set_apply_overlays ...' line looks quite prone to
being interpreted differently.

Rasmus
