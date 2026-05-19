Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C18CD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FFF846FA;
	Tue, 19 May 2026 15:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="NHkQIm8h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7858470B; Tue, 19 May 2026 15:36:32 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A760E846F1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCCazJjfT49QRgcAD+T97tkUtBBsbqvQKcJ9hfAHIgJishcP1Uhl9CtKisFpeuEKimsPps9iXnRnALboztY/hEKJx2NPsskFQawQnDfkMzeexANRDTjuvtpFR1kiFjY+DjgVIvz6852daaPndzBr/z/M9CM2rGxZwjp5gwJA07m0hSg+IarPd8viDTlwKnUKrDZR2vF+X1mTJ0oS+j3gJmlXrBDrnqjvCZMRqKH2B6f7Ue6Crq5sYb+IxHiGc/JBXnx3wsY3Qxd1E6qxjHgq9W9T3EaPMND/MWPUPbe5jdT2BpR1x43hhxp81cE7t1uZRa/jcQQC/yfPaqeImTmMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+cSGsm+pjlEXZDlkoV9dmG573Ie/+Nnsat8LCDgfrc=;
 b=BQ700UzNU+61L7EEiknhf7WVZnKBqAIvKOxmyxrEwIruaPVdWMO4bP5X8Q+DiCFghhUwszl6ORng1To2pUFMPONsSok1SAvypKzCAqQtkRHyNRlawTujXXsAHw3uJNNM3rUAvxNYrQfpRwapyzA/Miq2YQjOF1VPe2hLJa7gS1yrz5NaYFcnh6tBaP3cTV/qIlQQLhhB9HiipZir+6n0ayd4Lnz0judPLOJygLl4arztBwGrk655bJuzXwsQl4q6f9FxkgJREDFdRxyZlTeVCvpXg+g0g7wiG8WMiogJoYQpAk/M+2NELQ7wXGdDwjtU9GZhEfjhDoRduVWR9HLYAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+cSGsm+pjlEXZDlkoV9dmG573Ie/+Nnsat8LCDgfrc=;
 b=NHkQIm8h0PSA0y9dpmy6AYJwbM1/gjuQX3+CUjLROxUvYlr1tcCJR2roWGfhIsGM5W9pNlUg+lmaQrFY6hgEs3xh0jVYFnPeo9F0e537mafeqJECGmI9YT5wY2j3G++kThCn3vLCecQA5+W/SpVE+UBjq8hVNbFeawRqPMPMNN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:141::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:36:26 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:36:26 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [0/2] allow control DTB to double as "FIT image"
In-Reply-To: <CAFLszTisVttLYAOt5ZTR8un=MUMFGQ1Sa_sZ4UHZsTvkXK858g@mail.gmail.com>
 (Simon Glass's message of "Fri, 15 May 2026 07:33:03 -0600")
References: <20260512161631.284143-1-ravi@prevas.dk>
 <CAFLszTisVttLYAOt5ZTR8un=MUMFGQ1Sa_sZ4UHZsTvkXK858g@mail.gmail.com>
Date: Tue, 19 May 2026 15:36:25 +0200
Message-ID: <87bjebed2e.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0012.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::13)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3581:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d52211-cb93-42c3-6732-08deb5aba040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014|3023799003|4143699003|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: FP21HUUIr6azLoWKUd7WnN/LQPgi4cwtg0NteRRlgVlDnqDYj2mXJVVWlcKrg6DVnspdToVoklD3LPqD2Hs/EWEFN+GGWcbEiyagHstQY8KNa0RAyuQvSVzz/If3hCoC4us5iDIy6OqdwsNBsAG+81akFE0IxxcspDD6EHrl+GNGVre41o7SXK17I05rLbmff3q6gXyfNaqsvrL65tZc1YYkrefB0SoTRQdQDz+Oy1GjrYa4shkgQIAo7peh0T7asXSWvlKyMzRlU6Ft0FQCRtzFv0/el8RivBg4FQsqoSfjQkkCWTOJeBaW7U3vCpmT9vAOLY3g1Bq3CWhhdgbi2F5XzBbJf3LFHe+VqgLjtlXfDHWk9apjJ5h5mTgYVOA9JowgnKip3Dwnx6MFK9u3lw7xraZwCsUpXr/QFnCUdvHihwsCf62i4HYof+UJbOB/dmmjoRvemKeg4XyDPiDbQ12sW9tZuqGU0l5YXnotdVFJyEMRy12eQi7Cg3y7ZIl6LH+UHJJ8ngyeBbRBDo2J/jQad34QMVt8KstLuXOoL5HHqpI5ws9U+vjdAVmkrT/qsFwdYiJ/L1r0/8HwWZin9D6sOsJ1vnyciwTq/APeaUBDdSacrNBpSND31+mrytTryg92TXM/OmWwXQMoHit0LXGCJkoBAmvZvtM6Q27F5HfpwGd4UwAXhD9U9yqInNw199JEVx0BGRFkLL0wd/HHzSTroUSbzCHmLrmd1hwxlj0F1UDUeqQn5x2ek+lZAVmK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(3023799003)(4143699003)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vcRyS/N6nFiOoL7ZClV+w9iAIKF+c9kQYdRIVKff9rRj6C+jgxbwfCbAp4EE?=
 =?us-ascii?Q?3AWjLeV7ttKVD71LiBa0dBCVek/6FSXNTe6Yxiy0+PAaTJQq66VR46ArlwcF?=
 =?us-ascii?Q?uijEQd53I8NeCK8gTWid7pYXa8Vpnv1mRevpjC4g8Si1iQZnilpWjJABlFVH?=
 =?us-ascii?Q?6db0nulxOR48nG4zt9Ed698pH0KMY9JrShp5pP0mJToAZk0FQ4qHMb6BkKa6?=
 =?us-ascii?Q?1aDZFWvzQ8VgvD4D46No4bIcFQAqN37PNrdHXvVdKavQm96IhR34XdyW8wKi?=
 =?us-ascii?Q?RCH1n0AEq+gQS8NYejLeM9kLSvNeAzZZPRyn5B7n+AGKxOepYpNHpaPoCwE9?=
 =?us-ascii?Q?Afbjmdpc4sEo+WTgdPz3fujqtrP7mgVeQUAC/MtSfaC+FQVBWhrOvJY1VTpg?=
 =?us-ascii?Q?XdLHcqbBtQ5DnXKW56p8y7HCEqfHVngrjdd6vFoifdypvMzgbBzZJjF5LBmZ?=
 =?us-ascii?Q?qzW+Tk0BDqaY5/AEvoCk9yBAYijuSy0O728L281n1vdaWOeZgGU+tQJoHmFg?=
 =?us-ascii?Q?CMijv8vYwFi/zs/hP/L2esMCSdSddMsGp5Ib1iV/5K+7W/Hkxv1zeF+E6NEU?=
 =?us-ascii?Q?lxohFrPb96ld3yLa+6vrlCqE29T2rso71AWApIaiP6ISEwUWjMYN7smvMOaU?=
 =?us-ascii?Q?nN6Hs8DZK9qgMvCIXNI4c6zZS3PXkwUt2S51YiyWKxQnluTSR4fO/klGi/Az?=
 =?us-ascii?Q?yk9U2RW22yed1ZPTGKAU6i4LbS8Ng9wZkyGeF8rpWfQamCFzudA/M7loSgG8?=
 =?us-ascii?Q?KWMnZw2UKPTCuPooFT08K37He10U2NBEB3d3/uoOt8h5KSsuRz0JbOBZ4ajo?=
 =?us-ascii?Q?Q3kWm8hfn0bKB/x28jSca62AgZeVRuLWdjg2xjVUza4H8ltV20wGJAjw5R9F?=
 =?us-ascii?Q?xWWbuo4KbAKRzWDUuiPtQyyAzxZxE5RgRRB8KhdOe7xNXmMxKx2EJl/WWpjr?=
 =?us-ascii?Q?/DRzc2Est2XzeCye0fjCB2DZi1w1XHlsKAz8bCuGo1ef6HAvFMxR/NJGdZ/W?=
 =?us-ascii?Q?VFsy09/+KcX5TgrLqAX4T6SK66O/K9U8vyvcat+PqNtHxc+TTHQpWKaBy6//?=
 =?us-ascii?Q?9Rcn1IdcYPZDeYzsDygCVByUC5qq7NWo+qgY3RnCGaX454YciRaijVvxroxc?=
 =?us-ascii?Q?R0v39BfQNOia2XJJFvCm1ahsCQP+v1Hc8brXqQntyivfjMyA/Qm2niDSnfBy?=
 =?us-ascii?Q?v/8MJtwk4Bq9nZwyBqNvh9XUZVdOha+iC1pilcQivPjz3Vn3dsmD3slMD3IW?=
 =?us-ascii?Q?H2kyseQEsPjpJHJ9A2IFMKwtoBV2ekXZkrsgGWX96zgSpgTWn37RcSQdtr9V?=
 =?us-ascii?Q?92RXAGivWzUMEDwziiN6yP5lLO94THuEqYYbeiqRRVzAdeLUVr0+3wAUbf/A?=
 =?us-ascii?Q?siFzTICy1EyXH1sdxcS07fUu+29PHAryeDdiafkw7GOazENiAU774J1Xscux?=
 =?us-ascii?Q?yy+htGNdNAARN84AwfJnAOymK52PxOkSJYYvhuKmMZQau4f85hlQHTpxIYJq?=
 =?us-ascii?Q?SRhIcagaADR5Zqrd9h6FX0G2ETq4zp+r0lpGJ98e0dm51hFAjZWbs1s2E7CD?=
 =?us-ascii?Q?X9dxciYIq3Rv3KYz7DQwiEsrQJqMnwJEn/hQuBGbQb3R20Q+aoeaI1g2rWtq?=
 =?us-ascii?Q?IPghy6+5kBjJoy+Uy615zY8UjKHHSSgvl1RN3tJF99LgvWsMB/ZJQyhcz5lZ?=
 =?us-ascii?Q?PEiN4xMbe37/EssH3YRU1BcPnPM4QxOZJAW5f46Tf4M4j9iUM8RoZX8GXqxS?=
 =?us-ascii?Q?LwJT8Pq3aFo2xCshIQ+NoztW0xsRaac=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d52211-cb93-42c3-6732-08deb5aba040
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:36:26.6928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/hDvFIc/q9wglWegV7UkufDn3kY0oJ1ZexcHrp9f1OJa7X5itDofGFc16dUw1/R2lTqsWIVM0rXCcDy1RO4Sgztx3lh8oplP7Hacaxn1ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3581
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

Hi Simon,

On Fri, May 15 2026, Simon Glass <sjg@chromium.org> wrote:

> Hi Rasmus,
>
> On 2026-05-12T16:16:29, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
>> RFC: allow the control DTB to act as a FIT image
>
> Thanks for the write-up. Makes sense to me.

Thanks, and thanks for the nice review.

> A couple of series-level concerns beyond the per-patch comments.
>
> First, this needs documentation. The control DTB doubling as a FIT
> image, and 'source ${fdtcontroladdr}:foo' becoming a supported idiom,
> deserves a short page under doc/usage/ covering how to set up
> CONFIG_DEVICE_TREE_INCLUDES with an 'images' node, the constraints
> (script type, compression none, etc.) and the security argument from
> the cover letter.

Completely agreed. I'll add a section below "External .dtsi fragments"
in control.rst.

>> I am of course happy to put this exemption for gd->fdt_blob under a
>> CONFIG_ knob if that is deemed necessary.
>
> Please decide this now rather than leaving it open. My preference is a
> Kconfig option (default n) so boards keep the strict
> fit_check_format() behaviour unless they opt in. That also gives a
> natural home for the doc/usage/ page and makes it discoverable via
> menuconfig. What do you think?

I've added a CONFIG_CONTROL_DTB_AS_FIT option (as always, naming is the
hardest part), with a short help text and a pointer to control.rst for
further details.

I'll respond to the per-patch comments and then send v2 shortly.

Rasmus
