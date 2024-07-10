Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8C5C38150
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 06:15:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD6B8860C;
	Wed, 10 Jul 2024 08:15:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KPkLSJh8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A0F88860C; Wed, 10 Jul 2024 08:15:38 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979E887EBD
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 08:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46A6FUSe061418;
 Wed, 10 Jul 2024 01:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720592130;
 bh=UwxTSic3SVPdMwgOwji2ufODMXMk3pjBfdj7TG6gFOc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KPkLSJh8xACjc5BWpzw/M+wGFWhnJqVJ9kbBmBmmoBD+KmIWTQ4GgqEvo1t9Ni6wD
 ma2pLgQGncXySG64W9527f5xk44raQRpjkp7QepDIlPKraOOoWnQFeiJWXHwLo03+c
 QX7ZR0J8+RAQrpHHF5UtISeDhv0YuA89I7h6yWYg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46A6FUtR028188
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Jul 2024 01:15:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Jul 2024 01:15:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Jul 2024 01:15:29 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46A6FTfb063149;
 Wed, 10 Jul 2024 01:15:29 -0500
Date: Wed, 10 Jul 2024 11:45:28 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
Message-ID: <20240710061528.4afx6lcsdsbookug@uda0497581>
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231217163627.2339802-10-sjg@chromium.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 09:36-20231217, Simon Glass wrote:
> The existing bootph binding is defined such that properties in a
> subnode are also implied in the supernode also, as in this example:
> 
>    buttons {
>       /* bootph,pre-ram is implied by btn1 */
>       compatible = "gpio-keys";
> 
>       btn1 {
>          bootph,pre-ram;
>          gpios = <&gpio_a 3 0>;
>          label = "button1";
>          linux,code = <BTN_1>;
>       };
> 
> Provide an option to implement this in fdtgrep.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Coming back to this patch as am facing some issues with the bootph-all
propagation to the parent nodes [0]. We have a dmsc/sms node in our
devices and it is a parent node of k3_pds, k3_clks, k3_reset. 

During U-boot proper we are initializing the serial console and during
that time we have to make some calls to our Device manager for clocks
and power domains. With the DT modelling, the clocks and power domains
come under the device manager node ( dmsc/sms ) but interestingly that
driver is not getting probed while putting bootph-all in the child
nodes. Do you know anything about this? I thought putting it in child
node will propagate it to the parent nodes as well so it'll be probed as
well. We are having to put bootph-all explicitely in the dmsc/sms node
for it to work.

[0]: https://lore.kernel.org/linux-arm-kernel/20240705-b4-upstream-bootph-all-v2-0-9007681ed7d8@ti.com/T/#t

Regards, 
Manorit
> ---
> 
>  tools/fdtgrep.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
> index ca639a2d9f4f..f1ff1946bd4a 100644
> --- a/tools/fdtgrep.c
> +++ b/tools/fdtgrep.c
> @@ -63,6 +63,7 @@ struct display_info {
>  	int types_inc;		/* Mask of types that we include (FDT_IS...) */
>  	int types_exc;		/* Mask of types that we exclude (FDT_IS...) */
>  	int invert;		/* Invert polarity of match */
> +	int props_up;		/* Imply properties up to supernodes */
>  	struct value_node *value_head;	/* List of values to match */
>  	const char *output_fname;	/* Output filename */
>  	FILE *fout;		/* File to write dts/dtb output */
> @@ -606,6 +607,16 @@ static int check_props(struct display_info *disp, const void *fdt, int node,
>  					 strlen(str));
>  	}
>  
> +	/* if requested, check all subnodes for this property too */
> +	if (inc != 1 && disp->props_up) {
> +		int subnode;
> +
> +		for (subnode = fdt_first_subnode(fdt, node);
> +		     subnode > 0 && inc != 1;
> +		     subnode = fdt_next_subnode(fdt, subnode))
> +			inc = check_props(disp, fdt, subnode, inc);
> +	}
> +
>  	return inc;
>  }
>  
> @@ -955,7 +966,7 @@ static const char usage_synopsis[] =
>  	case '?': usage("unknown option");
>  
>  static const char usage_short_opts[] =
> -		"haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTv"
> +		"haAc:b:C:defg:G:HIlLmn:N:o:O:p:P:rRsStTuv"
>  		USAGE_COMMON_SHORT_OPTS;
>  static const struct option usage_long_opts[] = {
>  	{"show-address",	no_argument, NULL, 'a'},
> @@ -985,6 +996,7 @@ static const struct option usage_long_opts[] = {
>  	{"skip-supernodes",	no_argument, NULL, 'S'},
>  	{"show-stringtab",	no_argument, NULL, 't'},
>  	{"show-aliases",	no_argument, NULL, 'T'},
> +	{"props-up-to-supernode", no_argument, NULL, 'u'},
>  	{"invert-match",	no_argument, NULL, 'v'},
>  	USAGE_COMMON_LONG_OPTS,
>  };
> @@ -1016,6 +1028,7 @@ static const char * const usage_opts_help[] = {
>  	"Don't include supernodes of matching nodes",
>  	"Include string table in binary output",
>  	"Include matching aliases in output",
> +	"Add -p properties to supernodes too",
>  	"Invert the sense of matching (select non-matching lines)",
>  	USAGE_COMMON_OPTS_HELP
>  };
> @@ -1202,6 +1215,9 @@ static void scan_args(struct display_info *disp, int argc, char *argv[])
>  		case 'T':
>  			disp->add_aliases = 1;
>  			break;
> +		case 'u':
> +			disp->props_up = 1;
> +			break;
>  		case 'v':
>  			disp->invert = 1;
>  			break;
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
