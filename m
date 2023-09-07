Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CCFEC874B
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 17:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7BF86A30;
	Thu,  7 Sep 2023 19:09:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="UFtxBo4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0098F868D7; Thu,  7 Sep 2023 17:45:14 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11olkn2080e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::80e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA8386A10
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macromorgan@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGw6flWOymRkbchv1baaeUi+tbbmcWY6D2FE9CRUBqc7SvnvMOrwCN52il7pkhRp0QC1Ng8AjRN7TBzYnxVHoDNF7qQS84bzMSrjbQGfeUl3SXu9gVEjSlBrLW+vXRQNRP24dWORh+DkGV+wjhnzV/S/YRTjlJ/JI+ZWRssNA3LPR7AypJgSByz04g/zp9c7q3PA2mZ3Jazjvn8Ed1rhZu1EcQ/vf08d3Lze4a4LoZ0Yjz4khmEn/WvQbU7Y+SahigqX+EEZaGpKq5HtqpMDaXYMTpcsmQLb9qmo6EuvnGGA2bxoUvAqC1uGGh43/ZoR2K0pDpaVaBQt0IBjjy+iWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6KjmYj12O9BigllBYpILxmIDjw7zRr3oK1uVOvw0eE=;
 b=Li7wV2bKt9X+B1agL4uV1OMEIBA0yEoKeLKBzs+vSFseEn34VIN4K7x1ZUjWtrXJrPhmCQw0P8JHPqZUbGs/htN759XPkOPf4NBr04ByeUN9SQICPIuLE/2gwI1HXdjKDUtFD78c8+NzGEBlPhZUnQaV8NNnBKMt7TC14ciF8/3e5fp6r71c4bh8vFkUP+LiecYxG+ZLE7YCoUnuX7/SNql4VHzrHx9U7K5BvLS7EmNnBXXho40oruPtgUZ6PsXRE3TnRuUjoM2BRHXXdprMXRbHc4QMZxkMhy3tjoBSS8r1lySZIg5H1cexI+5Bw6gw717rUHtucCoUWnETVYFLjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6KjmYj12O9BigllBYpILxmIDjw7zRr3oK1uVOvw0eE=;
 b=UFtxBo4LEHTL/8XvvP2T4JZCgPI2whmuJCG/IqJJcColnkmkVIsT0gyKpBqdfxvZnM1VY5eZYheJwRrZ+NZ894ajXrELKahLi/NmAbyKsSzY8nn+vl5FfpvmAr4FysQuKhDte/2astV7MQUcqyozj9kv+wsLkl5oJJZwecAysq82OowaCTyB1L1Q6VyTcsrpSfgHfGUkYz+48YIQhD6ddMEuFoAA9OUBgGHXaolFNbojs9oThHbtdUFiTG8ibUee8L43V00YgHUFOP6bjqzAFjG470WK8AAqEJzbTdEsHY3L5HBCvQTsZdPqe/TNNV2NIQCUlP1bsxDmtQKQHDCpew==
Received: from SN6PR06MB5342.namprd06.prod.outlook.com (2603:10b6:805:f9::31)
 by SA2PR06MB7596.namprd06.prod.outlook.com (2603:10b6:806:136::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Thu, 7 Sep
 2023 15:45:05 +0000
Received: from SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c]) by SN6PR06MB5342.namprd06.prod.outlook.com
 ([fe80::c40c:bbc8:b103:459c%2]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 15:45:05 +0000
Date: Thu, 7 Sep 2023 10:45:02 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: seanedmond@linux.microsoft.com, u-boot@lists.denx.de,
 dphadke@linux.microsoft.com
Subject: Re: [PATCH v2 3/4] cmd: kaslrseed: Use common API to fixup FDT
Message-ID: <SN6PR06MB534261328C12EDFB9E697205A5EEA@SN6PR06MB5342.namprd06.prod.outlook.com>
References: <20230829203710.84201-1-seanedmond@linux.microsoft.com>
 <20230829203710.84201-4-seanedmond@linux.microsoft.com>
 <CAPnjgZ1EK5pe+z2V1LNN0xs254v_4ciKRQPN2H=eZPAEY6g9ag@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1EK5pe+z2V1LNN0xs254v_4ciKRQPN2H=eZPAEY6g9ag@mail.gmail.com>
X-TMN: [I5rUFKY6axl9ZWyutSmc3h1WMPwjIc8b]
X-ClientProxiedBy: SN6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:805:66::27) To SN6PR06MB5342.namprd06.prod.outlook.com
 (2603:10b6:805:f9::31)
X-Microsoft-Original-Message-ID: <ZPnv/naNsbx+NtDQ@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR06MB5342:EE_|SA2PR06MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e76b44-8597-44c9-8a6b-08dbafb96803
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZZaeI1JjdV7DzAYryDmvjoUR0w8kx4s36YXqzb0EcJ4OD9gYS3UEf5W1CxuzoAM66nJoVtpXsbys+O4br2nzVg/FS42/PXhQwiKs0OEC/ePEpW6vpyvabkh8D+vpWfr6Ul1KQlNObO3pB0w7A6qCMTvPI0O0AxVly4YNQCfM2cepMXwxe7IWYkVaccdGtZVWp1tdtaf6g01qMe6T42VNooaGJkdfdBx6T+0loEQZNsgBcWUVfHec47gT+S5B9t2XOuA/3qb0af7riVw+p232qBD3q9DXYklsBX7rw1HlGkcIugzQ4GfFF90zx0y1b3/zI+ttBdqBc7Y13CxzpuA3vLotad1NLlw6LjJCD5dJ2CREg2ZSurCaAiKAC1ctIJLLvo1SjAlItx4BOwkArwPpbFMyqWVBDRqRS9diubxeY+aBpGpf/ISQEDLJkvZji++2Wve1kJl9mXXx7fhJjsPxuISR5aeHyCR1lJQWz0/GoI8HMSMhN5MKk6DrX+gTcASeBMM3sN38P8JzNgzjQPk7+oLtB5qvzultMbZfUaCl9wpsLdkxbYDAH6FpJGMiLnR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqIS3Wp5BwbUyFSC77EaZ277o6KeHZGnN1ruj4yj3+4EDxP6SZzoxQNxVGew?=
 =?us-ascii?Q?wL8XK2CpV4JItxlJ9D0rmerz+4N5jIH0YA1/H09hNj1IKfbOybeX2ZpHTzz4?=
 =?us-ascii?Q?GmVF5qllHT1DMe0oBybwodrlkJH50TnHrsbPy6AFVHOUCIarOgU2P5N13zon?=
 =?us-ascii?Q?PrpOpHZ0N56Ndjiekee1gFq0S9USx5xV/jFz8FEsRu1sHp9X+EhN6j/eGGPd?=
 =?us-ascii?Q?tNt/Tpgds9vxj+15pGaWbTFyBAdQEFAS8dC84M1g9vUnDg2eRYpw2HHV4S46?=
 =?us-ascii?Q?n+8GPyr7AgurNUwI1Ad69Z54QtRGJ1h/Zjy/FsFDjQ2cgljJTIwQRcAXyWMG?=
 =?us-ascii?Q?R+fF86/+pnLKVdxFljZz6+LxKl8Sx7VcWsMWBMiawdGDCGBGwKmVlAz/1wfy?=
 =?us-ascii?Q?Xr8uff9mDEGsLMO1TpgLNBXAHRvVxKwAbCN1fFOocf+oaC24lIif5GT2JiIK?=
 =?us-ascii?Q?f+D4Spm7gsJnAB59NtkAoVdC3TneY4fcglB77Y2v05ZJRlEtpt+HuNjItgmo?=
 =?us-ascii?Q?jZXmoV3bbP0RX41HWSaqGWbd7Zb44WSlRKF4I0sueoOgGTf7ns4C2pxaQP5i?=
 =?us-ascii?Q?izSfQCSUAXue3mK0s6bBbgNxRueHqtsSjCpJH7IAGKuSHv1Gfq6QromVfzNn?=
 =?us-ascii?Q?4CC1AdZcWE39iOlLveOHFdr2c2viFk4nMuDp3zMidF+NdzwoZNdFH/QRyihZ?=
 =?us-ascii?Q?fcfQri8Il/phTDXeGifwR6uTM6TrmxUsVfQi35YwWvbcNKspLueFKkWcc+oY?=
 =?us-ascii?Q?zT+yCz0kDEOEI2Zg/7JHnFv+Y9K+fhCLKQG16+oYOqOtPcHZwJQ16d4ad8Og?=
 =?us-ascii?Q?s78yNagsN09Xc2V3T7cAnTLaO+kweDdb4zs4U/q4IbX4nNpBVnz08KGrcY7W?=
 =?us-ascii?Q?DBTDaZ1IuY3hQ2Hu2apITw71YwLJ2mh+O1ImUVvMIU7rxe4t3r06p1y/lVFD?=
 =?us-ascii?Q?z3UBug9pB2X3Q8DIm/1H1Eqm44qE/1Sirbie1S8O8VgZAsuJT3paCmTTaWIp?=
 =?us-ascii?Q?QzzZEHi/u7fXUi5nSHhASQrHq5OICSd8Hda/xEQL/IBAFIzleevqHeydqOrn?=
 =?us-ascii?Q?lDTQoON+CorrEV6oChK2wJPZXeSNJty2iA5isPBNM507SMsjaxvimLxtv0LK?=
 =?us-ascii?Q?2mOY+RFd/i9MaufSVIPq+9xSA3HnXCcm0R8pefHyyM98F0o0f4gKF9S83Blw?=
 =?us-ascii?Q?CBrvZgkVQbkvNSI/fKrS0gFtKJ/4kZsb6xCP9kJo7efDqMSW2/Jcmov0B+g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-89723.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e76b44-8597-44c9-8a6b-08dbafb96803
X-MS-Exchange-CrossTenant-AuthSource: SN6PR06MB5342.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 15:45:05.7811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR06MB7596
X-Mailman-Approved-At: Thu, 07 Sep 2023 19:09:23 +0200
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

On Thu, Aug 31, 2023 at 01:02:02PM -0600, Simon Glass wrote:
> Hi Sean,
> 
> On Tue, 29 Aug 2023 at 14:37, <seanedmond@linux.microsoft.com> wrote:
> >
> > From: Sean Edmond <seanedmond@microsoft.com>
> >
> > Use the newly introduced common API fdt_fixup_kaslr_seed() in the
> > kaslrseed command.
> >
> > Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> > ---
> >  cmd/kaslrseed.c | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/cmd/kaslrseed.c b/cmd/kaslrseed.c
> > index 8a1d8120cd..c65607619b 100644
> > --- a/cmd/kaslrseed.c
> > +++ b/cmd/kaslrseed.c
> > @@ -19,7 +19,7 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> >         size_t n = 0x8;
> >         struct udevice *dev;
> >         u64 *buf;
> > -       int nodeoffset;
> > +       ofnode root;
> >         int ret = CMD_RET_SUCCESS;
> >
> >         if (uclass_get_device(UCLASS_RNG, 0, &dev) || !dev) {
> > @@ -45,21 +45,15 @@ static int do_kaslr_seed(struct cmd_tbl *cmdtp, int flag, int argc, char *const
> >                 return CMD_RET_FAILURE;
> >         }
> >
> > -       ret = fdt_check_header(working_fdt);
> > -       if (ret < 0) {
> > -               printf("fdt_chosen: %s\n", fdt_strerror(ret));
> > -               return CMD_RET_FAILURE;
> > -       }
> > -
> > -       nodeoffset = fdt_find_or_add_subnode(working_fdt, 0, "chosen");
> > -       if (nodeoffset < 0) {
> > -               printf("Reading chosen node failed\n");
> > -               return CMD_RET_FAILURE;
> > +       ret = root_ofnode_from_fdt(working_fdt, &root);
> > +       if (ret) {
> > +               printf("ERROR: Unable to get root ofnode\n");
> > +               goto CMD_RET_FAILURE;
> >         }
> >
> > -       ret = fdt_setprop(working_fdt, nodeoffset, "kaslr-seed", buf, sizeof(buf));
> > -       if (ret < 0) {
> > -               printf("Unable to set kaslr-seed on chosen node: %s\n", fdt_strerror(ret));
> > +       ret = fdt_fixup_kaslr_seed(root, buf, sizeof(buf));
> > +       if (ret) {
> > +               printf("ERROR: failed to add kaslr-seed to fdt\n");
> >                 return CMD_RET_FAILURE;
> >         }
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> So this command is intended to be used in a script? I am just trying
> to understand why we have the fixup code as well as this.
> 
> Regards,
> Simon

This command is intended to be used in a script, I wrote it as a
command a while ago and thought it might be useful for others so I
pushed it upstream. Since then I've started applying a kaslrseed value
with a fixup (basically copying what the rng-seed fixup does) so I
don't have to do anything special with my boot.scr files.

I'm perfectly fine with either eliminating this command all together,
or making it use a software RNG (again I can't speak to the security
implications of this, as I'm not a security guy). I can just start
adding the kaslr-seed in the board files anyway.

Thank you,
Chris
