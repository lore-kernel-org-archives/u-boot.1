Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE370C5B543
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 12:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E334800D7;
	Wed,  4 Jun 2025 14:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="mV2W89mQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BFD882D21; Wed,  4 Jun 2025 09:07:28 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE3282B07
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 09:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM4RZM7uNsRcGb6IFCV5GVjDJb3MRTBTWo4DP7/9HDRlQ0VyLoYVkWs3x6xjzeReeNvSuAn6BDqOoJfiGLD7PnwsDQ0UHJ8E6k6Cm0AyqK97bk2u2y3drOTMw0n6yoOb7yD5wQXReCo6oqVILCOqsruMFRVtDNqG65KmDYfuh4rn/tsDoADTtAwB6ZttV3apPMoPwWPf3wlszN2Kekjj0VUafqNm2ItIBD4Nn+ulaPvr60i/zAS5s/D79IWvlteMDT4b9XvhT5F8r5MsOWm0h/hkS/oUxstPR1C9yrSiCki+exIcClUTUNKXBLT6q4Ymw8hYwYxeiVEMBA6k6Mf3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ke4yx2gOX/th63qrZdCKuLPQ2giKmsUnhzlFmW7afs=;
 b=Ud8t3BQftZDtGbQ3BegsqmKh4m4HKIrP6sN1xqBAPguHQ8/WT3h8g9D6y/+TULxoCiihw6NY91B/A9m9jh7j65YkqHmPFCs4KOzWPZv1ef5SWJv4wCPc9MmAI0uiPyBsQQMCJTLy24YLKpMwlnZezSXaniut8hRsu5ZjW8fpA1bRJpjrhK1Z3yiAmI5qsaC00/R9ohNuGk7Xe5se2CBXRQMDYqVY/MfHheqJy2PISPFWZ0m76jZxRPWpnGXZTn+jGeqbX8m2yHbJSuCoGoKmHWfRNknZxZ9UvCxC0LtV06MJTKyhx1RqWP+9uXl9VZtAVGNNCVFkzTIC/5pze98yWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ke4yx2gOX/th63qrZdCKuLPQ2giKmsUnhzlFmW7afs=;
 b=mV2W89mQDH33MzLibD7BUsUhZ3PVitKYBiafz3eaHd4R4wm3a6wiU/xTKBlZ/cgcwF0WZAQAxvx2KXLf/L7HA90taeryusqK8ro51W+6kkDlKAF175CX8I0vtUbj0UkP2ZGnN1qE44Zpts3L5YpsJgPsyBJlPK0b4PjlhLIPlaM90HvT21zqQr90/c7WlRcZxCkkGOef9MNecPDCSlvgB5GXbCuiRzYxoV4LP2ml+3SdLB7nKuDTtnNYtM9HOiIhKgz8ob3wvZiKPVRhyKWL4CUFUxQlqO3rU0i+aGNoAdilOg7X4eQqqW/RhkL4Ji8KNK4V17WM/ulx6XXh5BqXRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB7PR03MB4811.eurprd03.prod.outlook.com (2603:10a6:10:30::19)
 by PAVPR03MB9090.eurprd03.prod.outlook.com (2603:10a6:102:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Wed, 4 Jun
 2025 07:07:23 +0000
Received: from DB7PR03MB4811.eurprd03.prod.outlook.com
 ([fe80::3e98:6b4:8038:1a82]) by DB7PR03MB4811.eurprd03.prod.outlook.com
 ([fe80::3e98:6b4:8038:1a82%3]) with mapi id 15.20.8792.033; Wed, 4 Jun 2025
 07:07:23 +0000
Date: Wed, 4 Jun 2025 09:07:04 +0200
From: Wojciech Dubowik <wojciech.dubowik@mt.com>
To: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] usb: udc: ci: support USB gadget driver model
Message-ID: <aD_wmIj-odxVYLIq@mt.com>
References: <20250412-msm8916-usb-v1-0-2925239caf4b@samcday.com>
 <20250412-msm8916-usb-v1-1-2925239caf4b@samcday.com>
 <Z__8RKVP37t6Aw1K@linaro.org>
 <D9AIEUQMBE8M.2OVJ76ZRNATCM@samcday.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9AIEUQMBE8M.2OVJ76ZRNATCM@samcday.com>
X-ClientProxiedBy: MN2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:fc::42) To DB7PR03MB4811.eurprd03.prod.outlook.com
 (2603:10a6:10:30::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR03MB4811:EE_|PAVPR03MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: c61ff2c1-3163-4a3e-61d5-08dda3367429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kCNJfVbKcnU3JGkRW16X24U1vdSF6KSZQyLnnH2y/pgYLPBIKCopudXzMGzr?=
 =?us-ascii?Q?rRa+luizVvO+A7CBqOTZjlyDNxVobtX30/zjImjLCNw6O3Cv6YvldDOUuD+X?=
 =?us-ascii?Q?6lkWw8ZSFwQ7F2bmz0+/H4SviFySFL4H4XGCMg35lH2GJHAiWaSzLiSYjKnA?=
 =?us-ascii?Q?zv84j+bvLtFpU5WZwTxi0NzCaZNBZeqDj8EasOsoKsn3MifLDYAxYhAP9lmi?=
 =?us-ascii?Q?2wlOoSDK2k66EOnSNoIhZia2BARWwlJLAQwTUuBebtbYfQ/4M+2HzcSPW2M5?=
 =?us-ascii?Q?sVCj7n7wyA6f7yJdGhvJW1k0K4XVscZ9P0HmFtxCElFMvd3u5GVn/u82nhXF?=
 =?us-ascii?Q?dn5+5xMJe+OnamBtm20jk3XPy8ZXpRlEGx5aTaDWm8JmooBQwLotkA+tGAWI?=
 =?us-ascii?Q?SmGXEyMEzKm2/MfWE0epvnBqf/RAInheCYHjGRVB8obj1DyWpENKVBk0HyqU?=
 =?us-ascii?Q?k4s9tFRtsN5yWeT8DBdbNX6d7bVx3whgkX3/Jds/dQ00fozz1+QwlQ62VSD4?=
 =?us-ascii?Q?qcpudv/5WgOpHKiGJ60OKaIyQ//UXPrx4PSVFClFQ1W/y3M9/ozpo4YiPYCV?=
 =?us-ascii?Q?LICKdT1SiAoQtih4KGOv37wICk3GnYkq/RYqumDUNioZg/MwcOLy6tm5Dbc1?=
 =?us-ascii?Q?jIgrbgbpSIUXO4uSvI1Wtqg4ygQn6ajjSLXuAyEcFPRa/DZnK9uVAuXkgSCn?=
 =?us-ascii?Q?Taz20hOKaBIe1R8BHxg0oT0UiMMCA84bCGcDKcQlzHPQKFq3ueiReWNk+33L?=
 =?us-ascii?Q?fhZ8K0RYXIpEiKYisLdVy1T633CJSqOd4NtIhjvrV0dWFKhyxW0ITJNSz5hu?=
 =?us-ascii?Q?Ti9XmVSLz4es3qn6Hhl4Gawd9hi5bZfvoBh0lcXfukuI5J676DtLFc/TBlGU?=
 =?us-ascii?Q?uJUQT9zi7rj649DhVUl2pQ5ZIWSblsbjd+Po6cH/hY0xasE8epa5MFMNl3AV?=
 =?us-ascii?Q?RTN9McV4y1YoyQ5Tres3P2/LdNfZIgkwXAEaSMUiK1XEEyFgyczf02tgWqi+?=
 =?us-ascii?Q?jM+9Yd8VcjIxrcD1uLHy6VxWElUJ60zd1/QSAkVzUmVZodPDEjSLBHpTLW4J?=
 =?us-ascii?Q?1P3OGQxjjG611AfoFNqlTp/bPnr3XBwdYIfbQ6r+MMoXMYbV3mxQ4TzW0wW4?=
 =?us-ascii?Q?XZcLlmUDyyUDxEPPaSlBenJGRuabCfcScDbapG4NAa8WjjK5FP5LvIXTn1AQ?=
 =?us-ascii?Q?cfoqwuN09I4hhoMNcMxgOX3nXGdB8CmvgMJg3VzZgKsL4tX0g7Mf05le7kqN?=
 =?us-ascii?Q?C3dbOwdKXTKhpjPPq9cW8noLF1+WIms5FfrkEVgzOq6+4NSxlhygWuMHAldG?=
 =?us-ascii?Q?Dn8WpnhqnK8jwcp/RFGhjgIu4WRje+2gmXXmOeopLeMUi3VkAsVFG+KEI3o/?=
 =?us-ascii?Q?f7yYHFb1cIBxThAivHE1M/ZEz6OOZe+8VNankE3Y3hJ6FLq4bDOeuh0O3rrl?=
 =?us-ascii?Q?80fFJEwxHM8OcwiGXsakNFfr2/ZRpltPYQyFtnoJdpN1CHOq3lRrIw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR03MB4811.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j8DpaMgFES8+vpUATnATr3D+V5vbesE+4uRkprcDifNZ5vPJh92/1pEEAeUc?=
 =?us-ascii?Q?Gb/Txn6FITSy6nqvzX8J/zZdj5znKru9VIEZ1Tu6YO7C1V+LyTGUv6gZjUp4?=
 =?us-ascii?Q?RKyqzqPlwaFCkcphJzwbs4VdngfDb/L/8U2UREqsMKh69Ka46X2y84ew2OFe?=
 =?us-ascii?Q?rDvSbGHjo7Y81JeDLbQ/b8Iv3tzZnvfHos3TSl27U+2Be8/rQeUtUAXy3Mf2?=
 =?us-ascii?Q?lxn41JyFxtrTJtwCUz+uEP/D3IY8lMkLVOSh9nWNw1SlbphHBQCz19A+14Ji?=
 =?us-ascii?Q?sQFxKEu+3A5wCzQgejRWnQROnb1Vqg3o+Xv5t5Ueibi5XdfE37+iFKD6C3sw?=
 =?us-ascii?Q?sfjcH2oWXpm3MD1M9rftuoEWpg6uKMRrLp8UsESlxaPaHvfegaJTscsgreum?=
 =?us-ascii?Q?i6OoYuJx95Kf4HuwJNw3u7lhlj+wdWvgp3PmgZ6zJQDOSu9fc04+ibqxcXyf?=
 =?us-ascii?Q?Ysmi1IXPKluqiCtFc9GziTndWsOK1X0ynWn/IlMldVw0WHwTzZiFNyAvgldH?=
 =?us-ascii?Q?VV0rRQIJ4MZ0UmfZZZFSZk+hn29Rrk9dlSxbiwGleI/5ukA88E0TIGdyeEKi?=
 =?us-ascii?Q?lKHUm5+hgy8LmFDKHjBIW7pm2o6i7b105/TqXCc5QcyaSeL1SDK9wZQIG8VX?=
 =?us-ascii?Q?yb+H2Ae4R0RlB4pHB+9agMT2yILpDp0tI0YIMoqxG8K0Vj1xtxV5A5wj0Gqc?=
 =?us-ascii?Q?YmCyBFxCs5Da9jIm4R6mK9QwGUAGuHIpK0tkbDXxyjWArB0In/rTb7VBtcQC?=
 =?us-ascii?Q?GrIMZxafglS/VjHU82JO4ntyYCzm49fPsORaWJw5wnTH3dA8XWP9kTnrtysM?=
 =?us-ascii?Q?PnRuFrI9yrI7jtngMX8qCpIqmfNvhu6eKJWVgz5/GZVDKummfUXX7rU36rhI?=
 =?us-ascii?Q?obJs8YNQz2hVUOKmp5HB8KukNN/Av4O47+j2+E7jDHDKrBhL1R7pAF5Tww4o?=
 =?us-ascii?Q?nvHuLOMpaHwggYJz2kQouwL0oLR+BXYt+glzf0/qG2AgvrJ9ToNPc8/n4QJR?=
 =?us-ascii?Q?qNAwCR3Edt/53mWi9COVkdZjjpM/YMELq+bb3HjQskulNw0JhtWgx5Wv/Az3?=
 =?us-ascii?Q?VkJaVb2av93uRwilFU9CpdnrikOS2BK+vYLVQLe2CWZsQ8ov+J1NA99jmhCY?=
 =?us-ascii?Q?q4cYsEh/6V0AHIGO/eczSRe25JZMQtWB5+Q8x538N+/INZVUna7ju/BMvvEm?=
 =?us-ascii?Q?yYJZorXNOZzvwLPa1nXXDPItrGVwy1wV4ixSZOWljOEyXxqDJkt/3wmo969y?=
 =?us-ascii?Q?aCt/uNryLlR3ExSCHOhMYBLgRyWJnogjO9B+uNuWbSMQHs1hSLYgD/65mwYh?=
 =?us-ascii?Q?amD/GbMyMMqy4UnGuk+nGtWzCCbFUjfoZyBBwSErAVMfflFhGPlhLzP9B4NI?=
 =?us-ascii?Q?MZuE7//tHcKfN4n+3A+RGc4tczbg+uRHQEXfdyKuyQYOCQxmR9AL/QS4GJhI?=
 =?us-ascii?Q?8giCgJvu6yGRq+kDdvlyEg/grnJ08+p20p6+kbAmWV1oKOK8jjKGM7NFiTfN?=
 =?us-ascii?Q?W6+9AhK3OQgegXudcNKE61qGndmLwBvAVkjaYWgqH26lj5mlv9vEPUz357KS?=
 =?us-ascii?Q?EzBZS6lrJUJ//LR/MXDBYmfIM+1qTA6bWhadRnln?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61ff2c1-3163-4a3e-61d5-08dda3367429
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4811.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 07:07:23.1091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AD6XBd2Ej75zRFpomg3cwH/jqj+SQrS/pN5VKMjBuQKr+1UUSXuj2shELHu6Y+jcAVYvesX+ZC8O7ACMTd8tbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR03MB9090
X-Mailman-Approved-At: Wed, 04 Jun 2025 14:48:22 +0200
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

On Sat, Apr 19, 2025 at 09:32:04AM +0000, Sam Day wrote:
> Heya Stephan,
> 
> On Wed Apr 16, 2025 at 8:51 PM CEST, Stephan Gerhold wrote:
> > On Sat, Apr 12, 2025 at 07:39:57PM +0000, Sam Day wrote:
> >> When CONFIG_DM_USB_GADGET is enabled, a UCLASS_USB_GADGET_GENERIC driver
> >> will be defined that wraps the ChipIdea UDC operations. The
> >> (dm_)?usb_gadget_.* symbols will no longer be defined (as these are now
> >> handled by the UDC uclass).
> >>
> >> If CONFIG_DM_USB_GADGET is not enabled, this driver behaves as it
> >> previously did.
> >>
> >> This new driver does not declare any compatibles of its own. It requires
> >> a glue driver to bind it. The ehci_msm driver will be updated in the
> >> following commit to do exactly that.
> >>
> >> Signed-off-by: Sam Day <me at samcday.com>
> >
> > Thanks a lot for working on this. Seems to work without problems on my
> > dragonboard410c. Just some minor nits below to reduce code duplication.
> 
> \0/ Thanks for the review and testing!
> 
> >
> >> ---
> >>  drivers/usb/gadget/ci_udc.c | 84 ++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 83 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
> >> index 4bff75da759ded6716641713fbe47f6ba79386dc..179f8540da30c693d11d772aacc00cc37f7669c5 100644
> >> --- a/drivers/usb/gadget/ci_udc.c
> >> +++ b/drivers/usb/gadget/ci_udc.c
> >> @@ -10,6 +10,7 @@
> >>  #include <command.h>
> >>  #include <config.h>
> >>  #include <cpu_func.h>
> >> +#include <dm.h>
> >>  #include <net.h>
> >>  #include <malloc.h>
> >>  #include <wait_bit.h>
> >> @@ -94,8 +95,18 @@ static struct usb_request *
> >>  ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
> >>  static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
> >>
> >> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> >> +static int ci_udc_gadget_start(struct usb_gadget *g,
> >> +		struct usb_gadget_driver *driver);
> >> +static int ci_udc_gadget_stop(struct usb_gadget *g);
> >> +#endif
> >> +
> >>  static const struct usb_gadget_ops ci_udc_ops = {
> >>  	.pullup = ci_pullup,
> >> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> >> +	.udc_start = ci_udc_gadget_start,
> >> +	.udc_stop = ci_udc_gadget_stop,
> >> +#endif
> >>  };
> >>
> >>  static const struct usb_ep_ops ci_ep_ops = {
> >> @@ -927,7 +938,7 @@ void udc_irq(void)
> >>  	}
> >>  }
> >>
> >> -int dm_usb_gadget_handle_interrupts(struct udevice *dev)
> >> +static int ci_udc_handle_interrupts(struct udevice *dev)
> >>  {
> >>  	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
> >>  	u32 value;
> >> @@ -1072,6 +1083,71 @@ static int ci_udc_probe(void)
> >>  	return 0;
> >>  }
> >>
> >> +#if CONFIG_IS_ENABLED(DM_USB_GADGET)
> >> +static int ci_udc_generic_probe(struct udevice *dev)
> >> +{
> >> +	int ret;
> >> +#if CONFIG_IS_ENABLED(DM_USB)
> >> +	ret = usb_setup_ehci_gadget(&controller.ctrl);
> >> +#else
> >> +	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
> >> +#endif
> >
> > ...
> >
> >> [...]
> >> +static int ci_udc_generic_remove(struct udevice *dev)
> >> +{
> >> +	usb_del_gadget_udc(&controller.gadget);
> >> +
> >> +	if (IS_ENABLED(CONFIG_DM_USB)) {
> >> +		usb_remove_ehci_gadget(&controller.ctrl);
> >> +	} else {
> >> +		usb_lowlevel_stop(0);
> >> +		controller.ctrl = NULL;
> >> +	}
> >
> > This style is nice for compile testing. But in the probe() function
> > above you're still using the #if/#else pre-processor style. Can it use
> > if (IS_ENABLED(...)) too?
> 
> Ah, I had converted a few of these when checkpatch reprimanded me. Guess
> I missed this one - oops!
> 
> >
> > 	if (IS_ENABLED(CONFIG_DM_USB))
> > 		ret = usb_setup_ehci_gadget(&controller.ctrl);
> > 	else
> > 		ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
> > 	if (ret)
> > 		return ret;
> >
> > This seems to compile at least.
> >
> > If yes, can you make the same cleanup for the old !DM_USB_GADGET case,
> > so the two code paths are consistent?
> 
> Thanks, I've done this in v2.
> 
> >
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct usb_gadget_generic_ops ci_udc_generic_ops = {
> >> +	.handle_interrupts	= ci_udc_handle_interrupts,
> >> +};
> >> +
> >> +U_BOOT_DRIVER(ci_udc_generic) = {
> >> +	.name = "ci-udc",
> >> +	.id = UCLASS_USB_GADGET_GENERIC,
> >> +	.ops = &ci_udc_generic_ops,
> >> +	.probe = ci_udc_generic_probe,
> >> +	.remove = ci_udc_generic_remove,
> >> +};
> >> +
> >> +static int ci_udc_gadget_start(struct usb_gadget *g,
> >> +				 struct usb_gadget_driver *driver)
> >> +{
> >> +	controller.driver = driver;
> >> +	return 0;
> >> +}
> >> +
> >> +static int ci_udc_gadget_stop(struct usb_gadget *g)
> >> +{
> >> +	controller.driver = NULL;
> >> +	udc_disconnect();
> >> +
> >> +	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
> >> +	free(controller.items_mem);
> >> +	free(controller.epts);
> >> +
> >> +	return 0;
> >> +}
> >
> > I wonder if you could just define the start and stop function outside
> > the #if blocks and call them from usb_gadget_unregister_driver()
> > and usb_gadget_register_driver(). This would avoid duplicating the code,
> > reducing the risk that someone forgets to update one of those when
> > making changes.
> 
> So, not quite unfortunately. In the case of ci_udc_gadget_stop(), the
> controller.driver = NULL happening before calling into udc_disconnect()
> is important: the generic UDC uclass code has already called
> driver->disconnect() and calling it again is a Very Bad Thing to do. So
> we can't just delegate usb_gadget_unregister_driver to
> ci_udc_gadget_stop outright.
> 
> In v2 I've tried to unify the codepaths as much as possible though,
> both to avoid duplication and the risks of future patches making
> incomplete changes.
> 
> >
> > The same could be also said for probe()/remove(), i.e. moving the
> >
> > 	if (IS_ENABLED(CONFIG_DM_USB)) {
> > 		usb_remove_ehci_gadget(&controller.ctrl);
> > 	} else {
> > 		usb_lowlevel_stop(0);
> > 		controller.ctrl = NULL;
> > 	}
> >
> > block to a separate function and calling that from both variants. Not
> > sure if that would also be worth it?
> 
> Good call, these ones are less problematic, and I've done that in v2.
Hello Sam,

Are you going to send v2 soon? I am just asking as I had something similar
in the pipeline.

Regrads,
Wojtek

> 
> Rock on \m/,
> -Sam
> 
> >
> > Thanks,
> > Stephan
> 
> 
