Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEE6C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 15:39:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF45C80FF7;
	Thu, 13 Mar 2025 16:39:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD80180FF7; Thu, 13 Mar 2025 16:18:06 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E5F6180540
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 16:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vincent.stehle@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A10C1477;
 Thu, 13 Mar 2025 08:18:12 -0700 (PDT)
Received: from debian (X72Y076X74-2.nice.arm.com [10.34.128.247])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEC513F694;
 Thu, 13 Mar 2025 08:18:00 -0700 (PDT)
Date: Thu, 13 Mar 2025 16:17:57 +0100
From: Vincent =?utf-8?Q?Stehl=C3=A9?= <vincent.stehle@arm.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] imx8m: soc: cope with existing optee node
Message-ID: <Z9L3JY2NZa-qg0IN@debian>
Mail-Followup-To: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Tim Harvey <tharvey@gateworks.com>
References: <20250310123621.389594-1-vincent.stehle@arm.com>
 <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
X-Mailman-Approved-At: Thu, 13 Mar 2025 16:39:18 +0100
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

On Wed, Mar 12, 2025 at 11:12:35AM -0300, Fabio Estevam wrote:
> Hi Vincent,
> 
> On Mon, Mar 10, 2025 at 9:36 AM Vincent Stehlé <vincent.stehle@arm.com> wrote:
> 
> > --- a/arch/arm/mach-imx/imx8m/soc.c
> > +++ b/arch/arm/mach-imx/imx8m/soc.c
> > @@ -1270,8 +1270,9 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
> >                 }
> >         }
> >
> > +       /* Locate the optee node if it exists or create it. */
> >         subpath = "optee";
> > -       offs = fdt_add_subnode(fdt, offs, subpath);
> > +       offs = fdt_find_or_add_subnode(fdt, offs, subpath);
> >         if (offs < 0) {
> >                 printf("Could not create %s node.\n", subpath);
> >                 return offs;
> 
> This looks correct.

Hi Fabio,

Thank you for the review.

> 
> However, shouldn't we add the optee node only when CONFIG_OPTEE is selected?

Peng has answered this question already, but I would like to add some more
details:

Currently the ft_add_optee_node() function does add the /reserved-memory and
/firmware/optee nodes to the Devicetree passed to Linux when OP-TEE is detected
at runtime (the information is in the rom_pointer[] array).
If we skip this when CONFIG_OPTEE is not set, Linux will not even have the
reserved memory information anymore and the Linux optee driver will not probe.

Best regards,
Vincent.

> 
> --- a/arch/arm/mach-imx/imx8m/soc.c
> +++ b/arch/arm/mach-imx/imx8m/soc.c
> @@ -1235,6 +1235,9 @@ static int ft_add_optee_node(void *fdt, struct
> bd_info *bd)
>         int offs;
>         int ret;
> 
> +       if (!IS_ENABLED(CONFIG_OPTEE))
> +               return 0;
> +
>         /*
>          * No TEE space allocated indicating no TEE running, so no
>          * need to add optee node in dts
