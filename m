Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6182EF48C7
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 08:49:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5456383C6C;
	Mon, 16 Feb 2026 09:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="sG/JZkUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B88E83CB1; Mon, 16 Feb 2026 09:49:56 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A52718063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 09:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maEhuzhUFEwX+AKv9zjB7mCzhatJ/HgeSqHxokawg1G56kDx/WFs4FY7ejpW4IPx96Oeahbwek01ZQ88Z+sVHrMR0BPRt7nlUY7Pfld/WthTFVfeMIjYGrSufnmycwcUwfrwQtooXzLqNJ/pTu8gUKvbSkTakvK1DXR7vR7Se7XI26KFnrHp2uSMMzsr7Dk89B6nNiw8SlRsWPF48ydhCt+3D54n2Fsv8ic2fPzyxqsEwyBxloCFXdCpeWf9bGe48FEfLveZYtx0VanYQHn9uteio/BwgMsGXDLJIk+42WuO8HDtTKwToR1m3p1b3zqP1MHs3uk9Dze/TS6EERW3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RR01VGfzV/JGPyM7PjHcK8PeRalz7gZTb33WGnFi+ls=;
 b=rO2DoMc4ZBWRP8Hfq0qtw9iKXhpOemz41Z07LQPbG533ZjpSIit43ssLjQVJ8B2rLwAnM/K7+dYGRu2qxm0zskU5hls0lwz85Mo66klhF1VhhOzow9+CXN/T4rj6aSU070BAaHEI5eO7VY/BZh4X+jaQX8J3FCXDCb71fSQLmdttz0vq5bU8XUiyKW41evzNJtDZd/9ubN2+0cTJ1n7hcen+x46cjM7TkIrzJX13/7VAElaANUwjkfePbCEJWw5VCx9ra2Tmlz0slfEYw4eXvBj+Uj+yQ2kwj2KXJ0XcYIoBS/3WQ576rM73+pn4gPEeipp4Tn8ODUSalImfDpuHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RR01VGfzV/JGPyM7PjHcK8PeRalz7gZTb33WGnFi+ls=;
 b=sG/JZkUpJ11T7/d7MpvjxcTWoMWJZJwYalz0+cLkBG9jOi5k6ShlNEp92fkzVkiWMqe3pX1HyNe8AnvlIWEkt0Iqw8SRauY5uDB54C2oFryFTi3JFxvPcnx2TYtw5SJhhYzgTiArOehf7pj0pH46iGOG375IZOHvYAGi2DirFPIljvpulMVw3aVASkJHrsdXGqU21sRO07IZOntBbu4YqBobNYoauc7QsGH3mP0Uv5kIRdUOGJZhSXDkuwg6S0R9FWFi68bd3xodBS3HmzH4NYEhqsITad4wzr+63epCQ3cxw38XL8ob95Mg6X8DFMwc/W40WfvEJ9vzRs9xfV48gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB8347.eurprd03.prod.outlook.com (2603:10a6:20b:523::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:49:49 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::6fd2:12a9:4423:8ddc%6]) with mapi id 15.20.9611.012; Mon, 16 Feb 2026
 08:49:49 +0000
Date: Mon, 16 Feb 2026 09:49:42 +0100
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, simon.glass@canonical.com,
 quentin.schulz@cherry.de
Subject: Re: EXTERNAL - [PATCH v5 6/6] test: binman: Add test for pkcs11
 signed capsule
Message-ID: <aZLaJj0C5QKc5E2I@mt.com>
References: <20260128080515.1275941-1-Wojciech.Dubowik@mt.com>
 <20260128080515.1275941-7-Wojciech.Dubowik@mt.com>
 <CAFLszThiCuO23=m6zcVw4EHt2HdYX2Dei-91eLdieo9sQA08RQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThiCuO23=m6zcVw4EHt2HdYX2Dei-91eLdieo9sQA08RQ@mail.gmail.com>
X-ClientProxiedBy: ZR0P278CA0164.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::14) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f8448c-9d7b-4807-3788-08de6d38581d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?juDZ+IurUcowrDxHk0kMBHwi7AOPoMH6qnUa2NqvbuWilFXN1+OOffxhMLGP?=
 =?us-ascii?Q?D6R4+7+66GUUXV2K4LGE9uO453iA1IceRDw6f/Ot6XPotmFNHIWOhR7wTA00?=
 =?us-ascii?Q?W4f8L59ni9ZzvtQp8WML8XtpoCK2K2s6OuGXfuQ1Hf7COqcuNaF3LRLojQng?=
 =?us-ascii?Q?xHRu0sL4AeYsiF9MXTqWg7a4zi9HIE9qER3KfocIpBo1VQmPm7maxnH2hXwr?=
 =?us-ascii?Q?3TMzddTXzaR100YbWH4NskPz7AjN61O1GXXGuw2xU/tDH2ppq8GNxOgjxGRP?=
 =?us-ascii?Q?DEXsmAV7P5ZRPDiEv5+pCrPUEQUifw439kjxfyysDG1KH+KE8CoJowXV29Z9?=
 =?us-ascii?Q?sSvlyMsJufqpSNSBHx3Q3ZCNTsumxfZBMJy+R658P1SeSi+IeL9FQ8I0Lgjs?=
 =?us-ascii?Q?rq2oSB4giNZs8JgWh/9vCtN90a81OsonYAvr3toXf4sdKM2+LS8a4ri6NoyD?=
 =?us-ascii?Q?+gzdZ1KilANiiFCCVD0FGEKmrBn8/io1Gs8Uj78tndWPNnU1PUQvZeYiyo7V?=
 =?us-ascii?Q?8FppHRlk+05bVzN745dRkz5w6B+R/Mp/50G4LOJVpBCHx23xSxdMaSJxg1xm?=
 =?us-ascii?Q?/kxqYN07WnpW5PlH3INzOgAc1IVjFkg4OAxze9aRWL6relrRirSoC69A47T6?=
 =?us-ascii?Q?uae9SRmWaWhxjWqzf++LlVOPHb451GzRtw62alv/6ORKyVsJWmb/Aoedi0Jf?=
 =?us-ascii?Q?P6/YRtu0zBJFDQX7x+kSrJafqC9fPWkSKfdPM/jj7KT32GC4CPBeVcph2WBY?=
 =?us-ascii?Q?PL4omHmmDGp24Zsy+G0r2NoF4hXfzxYNYUn/bClxvmudU4NlGZcubWcdcNf4?=
 =?us-ascii?Q?L6hb072v8Ub55A0qpElcrh/794oF8PuioGZ+Xp+TD41SS9YaPvUzyJFYE7ZX?=
 =?us-ascii?Q?b85RW3OVDbjfJSm8GmlnBNnszRWJZoutqwgKOrQjHmF9t0HTol8JidrCh/Wf?=
 =?us-ascii?Q?jVfJieFlu1QE5ZdtNN9kbCOvyP6MZAPqSnyrmRR3zxSgPVhrhxzs2kACdLu2?=
 =?us-ascii?Q?8FLK45sHRxRikAZ7+dLPeQUk9LfzRch+WTD3bfgTqMseeIWebD+Dhq+SxGDx?=
 =?us-ascii?Q?gJaC6AwjJqh9lbF4luzm7qkKc8eMTK/AbkOisc2TRZx2XISZnlqt2hbgOM5t?=
 =?us-ascii?Q?rw04TO9+i3oA+yfHWy3G231RDPR1Jza3h7v5ZHUxY6W5iFAYaB7XKhwYNlV1?=
 =?us-ascii?Q?RKyIq+KNNznyTXc4LXT8i8g+51w8BIe66VYXPB3sRX7DKS/VlKUFZ9uG+XV/?=
 =?us-ascii?Q?rwe2CnUAwyusN412oqcMik3nNpaLRXKEymK2yxZ1mvf/JLWZNPrsfZUPOh6o?=
 =?us-ascii?Q?9pMUG6RGYWO+xNpiCHwXlUg+VWmBmK9WB1WgHWa0hW6mvmBfPd23Ra84FICG?=
 =?us-ascii?Q?SbtXiqfPBDfQtC8Nx7Kxg/zII8MJYPWYLgonZBc+0tWHIirxFrybSzYZdJMN?=
 =?us-ascii?Q?k76BDSMQVS45tJ/3beLWCP1mEJh6bWk4Tu2Ki7+yOnj2nOqDGNruIU4ZYRKk?=
 =?us-ascii?Q?/AxAw/PRQpChgYSP/xhBbDjfKbjVkUHlbupDhdtJPJpNFHS12RkEx5vnRKCn?=
 =?us-ascii?Q?Uv6brhRxqQR+8jV13shV9HosyQ7AcyKbFE0t32KqDIAslL2L9JEIpWZSYmYw?=
 =?us-ascii?Q?tAiKV4315XmW6kj/3HIB4ng=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(7142099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Rh58bN5FDZSgcTAwfG3qh8MFr2NCioMgVY8p+IIiuchx+j0Fpvt8hKhq/u3?=
 =?us-ascii?Q?odXhAxCNAPlNeUcGIxUWJXZBQ1MZWwFzBXsUrMmmHX8j95MPmvXV6BIIjXhP?=
 =?us-ascii?Q?VbpadXZDAOV24kO4qDDemxM1k+bUSI1kHWDfiX/28rA5pAE/NFXO9YNCNf1H?=
 =?us-ascii?Q?igoc/8OV/m7uI0VQUUaEWKB/bnYeXC8I2Og5jvv0qVtA5ogKrWW7CBFY04Yi?=
 =?us-ascii?Q?sWPkQrkTty/qj0d6EeIWcJRWtHtBtEc6RsU3hfc1FnSIBXRMKpkQ26o+ny80?=
 =?us-ascii?Q?mxC97fAH2K4UF1xo7Y0NgsVPF5vGOJlQww7O1Z9VrXVuAQeOqicIcy7mXUAk?=
 =?us-ascii?Q?4Mm+Tx3uS4TQvIadX6H1RGJ8/VwijGMx6COY4dyrWz3cMUwb6smo3YkYLul6?=
 =?us-ascii?Q?wsQJQoyIEwHLBhtKGnkdtm3kr+fc3p6xJ1S1i/e+ghpkD3sGhKu28JxycRp8?=
 =?us-ascii?Q?lNoCWBNKmhC1D0gpl9j9hQaK1GZbFuTNaKnlm6TWPldA0mJSiGxyZoueUSHd?=
 =?us-ascii?Q?uYAExxPE2pkiAI+aV+ZUmFtu98stxnWmXeAWYobK0DhmkMQg6LsDwAPZrQMH?=
 =?us-ascii?Q?5UuvalUbAYTv/ngmXQVmNzkdVSJBiHHgCll26W2AftKRoOQg0c9ZDtKIZ+Yp?=
 =?us-ascii?Q?L2c5PXOYOA4bkLDFDux2gIGyNQhk6GI5oAr8TC8/w0VBFYKmIN6Wb/j/FrRe?=
 =?us-ascii?Q?K7IZPY+THEeihOftWS3chN3aDu+ymJuP52jE7QFPvUn1KkcbprDYQv4KkrG7?=
 =?us-ascii?Q?yGiJpGCc5i9Ra0fXW19DCIqN8sLxjL9s/6BAhGn/fptRkHKvXWoMRXr155h7?=
 =?us-ascii?Q?XXyEc2iF61G4AHeepJ9clj9sSaKsP4o5FfB4jJS/yTiSNE9x1UJFk5W3IbsU?=
 =?us-ascii?Q?n+zkXR8wfMdui6PBFFqb7QRrWiAk38QBt531pxUxz/biy8NlgiwVro3vYFJq?=
 =?us-ascii?Q?jcgRps2V+1T0RF0IrYlQUHvV2R/NjBAPVxuWotZ1hXAtTXY/QW5rtSuHW/pD?=
 =?us-ascii?Q?p9Mf47xEZsa4x364t8iyCH+kTjqi6gQBoHnMDQWvHE6soCizaTVERbeaArvi?=
 =?us-ascii?Q?N1ud9w/8DRhk7jK/6IXrk2WAnfL6VY/Yh6b+9Oott4q1qYR5N9gx88uCq2hY?=
 =?us-ascii?Q?CP6+qxPS97kPoGxE2jHHbNikdoEiaEDGUly44il/5AkKRo9qbimhUODqD6LD?=
 =?us-ascii?Q?kb2cYWZHE4zjgUqsrGddYwxWFhwy1wzM7BEyu5DyfVLlDWNtfUxzT5y6VSfw?=
 =?us-ascii?Q?WbJIF45DwSwEHu6yQ0eb8SWs/aYxSKUGW7uuAmR/h9LviTePKZ0mvWiR39c1?=
 =?us-ascii?Q?ARM3PVX7+vp155d5mteSCYaLzdWkxUZkUTw2AxCgp4exMaF2AlWFUxDf83nR?=
 =?us-ascii?Q?gN9szZ1HeC6pSQcmHlvtx35+nDRgGkr9wFjAgbYI2tP4QK72V6+iBerwKbKT?=
 =?us-ascii?Q?lEhy3/pdwfThYZaApFe8e4fF2MFCfFfb2cVASAvfV2wnM9kK/g6jNMB4kvbQ?=
 =?us-ascii?Q?uIzcZmnXyg1+884e2z+M1AoDu0wd1qcDlN2k51Pj7mGs64qYfYgQx+y1kGT4?=
 =?us-ascii?Q?PH4jOgR8caLvXhhoYNIgDgok1XUfO8rEdMio/bHLEXcG6v395otKgBKGu44w?=
 =?us-ascii?Q?5QTSjQKxvSgzag1pf8bHkDNBge7MVVypF928mhFPPSDz0NKJAGhBMiqVQN2K?=
 =?us-ascii?Q?M8JzddLEw9mw7VxwyQV1fwIhAecaNHl12j64Eaml69cvRhy5o2itDMyIY7xj?=
 =?us-ascii?Q?dNz4bWF/3w=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f8448c-9d7b-4807-3788-08de6d38581d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 08:49:49.8222 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NutFBZQyBHJgDFmEE2TnHr8s9nu7OB7xubbPhCUheNZSMJ2Cd1BMMeJOAP87uEnDsxk2upsMDXnzmWtTr0kvgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB8347
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

On Fri, Feb 13, 2026 at 10:52:44AM -0700, Simon Glass wrote:

Hi Simon,

> Hi Wojciech,
> 
> On Wed, 28 Jan 2026 at 01:06, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
> >
> > Test pkcs11 URI support for UEFI capsule generation. For
> > simplicity only private key is defined in binman section
> > as softhsm tool doesn't support certificate import (yet).
> >
> > Add bintool support for p11-kit as it's needed in the test
> > to find library path for softhsm2 module.
> >
> > Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> > Reviewed-by: Simon Glass <simon.glass@canonical.com>
> > ---
> >  tools/binman/btool/p11_kit.py                 | 21 ++++++
> >  tools/binman/ftest.py                         | 66 +++++++++++++++++++
> >  .../binman/test/351_capsule_signed_pkcs11.dts | 22 +++++++
> >  3 files changed, 109 insertions(+)
> >  create mode 100644 tools/binman/btool/p11_kit.py
> >  create mode 100644 tools/binman/test/351_capsule_signed_pkcs11.dts
> >
> > diff --git a/tools/binman/btool/p11_kit.py b/tools/binman/btool/p11_kit.py
> > new file mode 100644
> > index 000000000000..9d8d5d848b44
> > --- /dev/null
> > +++ b/tools/binman/btool/p11_kit.py
> > @@ -0,0 +1,21 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright 2026 Mettler Toledo Technologies GmbH
> > +#
> > +"""Bintool implementation for p11-kit"""
> > +
> > +from binman import bintool
> > +
> > +
> > +class Bintoolp11_kit(bintool.Bintool):
> > +    """p11-kit -- support tool for pkcs#11 libraries"""
> > +    def __init__(self, name):
> > +        super().__init__('p11-kit',
> > +                         'Pkcs11 library modules tool',
> > +                         version_args='list modules')
> > +
> > +    def fetch(self, method):
> > +        """Install p11-kit via APT """
> > +        if method != bintool.FETCH_BIN:
> > +            return None
> > +
> > +        return self.apt_install('p11-kit')
> > diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> > index 21ec48d86fd1..a66030c7a56f 100644
> > --- a/tools/binman/ftest.py
> > +++ b/tools/binman/ftest.py
> > @@ -7,6 +7,7 @@
> >  #    python -m unittest func_test.TestFunctional.testHelp
> >
> >  import collections
> > +import configparser
> >  import glob
> >  import gzip
> >  import hashlib
> > @@ -7532,6 +7533,71 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> >
> >          self._CheckCapsule(data, signed_capsule=True)
> >
> > +    def testPkcs11SignedCapsuleGen(self):
> > +        """Test generation of EFI capsule (with PKCS11)"""
> > +        data = tools.read_file(self.TestFile("key.key"))
> > +        private_key = self._MakeInputFile("key.key", data)
> > +        data = tools.read_file(self.TestFile("key.pem"))
> > +        cert_file = self._MakeInputFile("key.crt", data)
> > +
> > +        softhsm2_util = bintool.Bintool.create('softhsm2_util')
> > +        self._CheckBintool(softhsm2_util)
> > +
> > +        prefix = "testPkcs11SignedCapsuleGen."
> > +        # Configure SoftHSMv2
> > +        data = tools.read_file(self.TestFile('340_softhsm2.conf'))
> > +        softhsm2_conf = self._MakeInputFile(f'{prefix}softhsm2.conf', data)
> > +        softhsm2_tokens_dir = self._MakeInputDir(f'{prefix}softhsm2.tokens')
> > +
> > +        with open(softhsm2_conf, 'a') as f:
> > +            f.write(f'directories.tokendir = {softhsm2_tokens_dir}\n')
> > +
> > +        # Find the path to softhsm2 library
> > +        p11_kit = bintool.Bintool.create('p11-kit')
> > +        self._CheckBintool(p11_kit)
> > +
> > +        p11_kit_config = configparser.ConfigParser()
> > +        out = tools.run('p11-kit', 'print-config')
> > +        p11_kit_config.read_string(out)
> > +        softhsm2_lib = p11_kit_config.get('softhsm2', 'module',
> > +                                           fallback=None)
> > +        self.assertIsNotNone(softhsm2_lib)
> > +
> > +        with unittest.mock.patch.dict('os.environ',
> > +                                      {'SOFTHSM2_CONF': softhsm2_conf,
> > +                                       'PKCS11_MODULE_PATH': softhsm2_lib}):
> > +                tools.run('softhsm2-util', '--init-token', '--free', '--label',
> > +                          'U-Boot token', '--pin', '1111', '--so-pin',
> > +                          '222222')
> > +                tools.run('softhsm2-util', '--import', private_key, '--token',
> > +                          'U-Boot token', '--label', 'test_key', '--id', '999999',
> > +                          '--pin', '1111')
> > +                data = self._DoReadFile('351_capsule_signed_pkcs11.dts')
> > +
> > +        self._CheckCapsule(data, signed_capsule=True)
> > +
> > +        hdr = self._GetCapsuleHeaders(data)
> > +        monotonic_count = hdr['EFI_FIRMWARE_IMAGE_AUTH.MONOTONIC_COUNT']
> > +
> > +        # UEFI standard requires that signature is checked over payload followed
> > +        # by a monotonic count as little endian 64-bit integer.
> > +        sig_input = self._MakeInputFile("sig_input", EFI_CAPSULE_DATA)
> > +        with open(sig_input, 'ab') as f:
> > +            f.write(struct.pack('<Q', int(monotonic_count, 16)))
> > +
> > +        # Verify dumped capsule signature dumped by meficapsule during
> > +        # generation
> > +        openssl = bintool.Bintool.create('openssl')
> > +        self._CheckBintool(openssl)
> > +        openssl_args = ['smime', '-verify', '-inform', 'DER',
> > +                        '-in', tools.get_output_filename('capsule.efi-capsule.p7'),
> > +                        '-content', sig_input, '-CAfile', cert_file,
> > +                        '-no_check_time',
> > +                        '-out', tools.get_output_filename('decoded-capsule.bin')]
> > +        result = openssl.run_cmd_result(*openssl_args)
> > +        self.assertIsNotNone(result.stdout)
> > +        self.assertIn('Verification successful', result.stderr)
> > +
> >      def testCapsuleGenVersionSupport(self):
> >          """Test generation of EFI capsule with version support"""
> >          data = self._DoReadFile('313_capsule_version.dts')
> > diff --git a/tools/binman/test/351_capsule_signed_pkcs11.dts b/tools/binman/test/351_capsule_signed_pkcs11.dts
> > new file mode 100644
> > index 000000000000..ae93bf83936f
> > --- /dev/null
> > +++ b/tools/binman/test/351_capsule_signed_pkcs11.dts
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +/dts-v1/;
> > +
> > +/ {
> > +       binman {
> > +               efi-capsule {
> > +                       image-index = <0x1>;
> > +                       /* Image GUID for testing capsule update */
> > +                       image-guid = "binman-test";
> > +                       hardware-instance = <0x0>;
> > +                       monotonic-count = <0x1>;
> > +                       dump-signature;
> > +                       private-key = "pkcs11:token=U-Boot%20token;object=test_key;type=private;pin-value=1111";
> > +                       public-key-cert = "key.crt";
> > +
> > +                       blob {
> > +                               filename = "capsule_input.bin";
> > +                       };
> > +               };
> > +       };
> > +};
> > --
> > 2.47.3
> >
> 
> I tried this out but I got a test-coverage failure (binman test -T):
> 
> tools/binman/etype/efi_capsule.py                          65      1    98%

It's because I test only private-key, public-key-cert is still using local file
and not pkcs11 token. For the latter one needs to import public key certificate
and it's supported only from softhsm2 version 2.7.0.
I didn't want to introduce yet another tool to do the job so this variable is
not yet covered by the test. I just wanted to start with something simple.

So we can leave it and I will adapt it once new softhsm tool is widespread or
I could rewrite it with pkcs11 tool.

Regards,
Wojtek

> 
> Regards,
> Simon
