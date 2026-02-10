Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224D2EA3F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 05:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A378341A;
	Tue, 10 Feb 2026 06:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HvZmQu73";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD8C8388D; Tue, 10 Feb 2026 06:20:50 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03E38309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 06:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8731B60008;
 Tue, 10 Feb 2026 05:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81ABFC19421;
 Tue, 10 Feb 2026 05:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770700846;
 bh=vPrG0SPSoHOazo5tiGieNzpgPKOlAC4GUg78Xh5DWoo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HvZmQu73Tu53qNmiJBqNyzfkay/qoCTsaHuGNs1Gg9Cc+N5947rjFeBypGk0v/yUy
 TxxBKA3EoGhvBon9SfWzMDOpPF6cNGjcJhz9xbt9cXtltJ76oRkGF1aPLdR/u+WhJQ
 PM0woQ61ZDeZkVMOdHhJQhz9O0G/dR5iyeQFX41IjoJFsYg/nxp6kSDbYi7GCHU+ni
 ddovG/t9RmvBeKI9oDli62AVincRlkb0DR8b1raqARwJKFWmTtWOsbMkVnofXo4Vq9
 BA0SLUvjFYw4oiaHUYLtXm06ptgFP2qIRAIpnI64NdgaA4Obj90lXhk3BF7n3CHh3c
 PtLVsLD84FYSA==
Date: Tue, 10 Feb 2026 10:50:38 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 neil.armstrong@linaro.org, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH v3 2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup
 support
Message-ID: <aYrAJrZZFRmy8Exv@sumit-xelite>
References: <20260127062341.723966-1-sumit.garg@kernel.org>
 <20260127062341.723966-3-sumit.garg@kernel.org>
 <2aa39055-ea59-48ba-becc-39df8f62540b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa39055-ea59-48ba-becc-39df8f62540b@linaro.org>
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

Hi Casey,

On Mon, Feb 09, 2026 at 07:49:50PM +0100, Casey Connolly wrote:
> Hi Sumit,
> 
> Thanks for respinning this.
> 
> On 27/01/2026 07:23, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Add support for OP-TEE live tree DT fixup support which enables U-Boot
> > OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
> > the live tree fixup to be carried over to the OS for the OP-TEE driver
> > in the OS to probe as well.
> 
> The EFI DT fixup protocol hook seems to be missing here?

The EFI DT fixup for OP-TEE node is already taken care of by the common
OP-TEE library as part of this code path:

efi_dt_fixup() ->
  image_setup_libfdt() ->
    optee_copy_fdt_nodes()

-Sumit

> > 
> > Note that this fixup only gets applied if OP-TEE support is detected via
> > checking for OP-TEE message UID.
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >  arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
> >  1 file changed, 35 insertions(+)
> > 
> > diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> > index 5b6076ea8e5..644afc22d88 100644
> > --- a/arch/arm/mach-snapdragon/of_fixup.c
> > +++ b/arch/arm/mach-snapdragon/of_fixup.c
> > @@ -25,6 +25,7 @@
> >  #include <fdt_support.h>
> >  #include <linux/errno.h>
> >  #include <stdlib.h>
> > +#include <tee/optee.h>
> >  #include <time.h>
> >  
> >  /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> > @@ -164,6 +165,37 @@ static void fixup_power_domains(struct device_node *root)
> >  	}
> >  }
> >  
> > +static void add_optee_node(struct device_node *root)
> > +{
> > +	struct device_node *fw = NULL, *optee = NULL;
> > +	int ret;
> > +
> > +	fw = of_find_node_by_path("/firmware");
> > +	if (!fw) {
> > +		log_err("Failed to find /firmware node\n");
> > +		return;
> > +	}
> > +
> > +	ret = of_add_subnode(fw, "optee", strlen("optee") + 1, &optee);
> > +	if (ret) {
> > +		log_err("Failed to add 'optee' subnode: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
> > +			    "linaro,optee-tz");
> > +	if (ret) {
> > +		log_err("Failed to add optee 'compatible' property: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
> > +	if (ret) {
> > +		log_err("Failed to add optee 'method' property: %d\n", ret);
> > +		return;
> > +	}
> > +}
> > +
> >  #define time_call(func, ...) \
> >  	do { \
> >  		u64 start = timer_get_us(); \
> > @@ -178,6 +210,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
> >  	time_call(fixup_usb_nodes, root);
> >  	time_call(fixup_power_domains, root);
> >  
> > +	if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
> > +		time_call(add_optee_node, root);
> > +
> >  	return 0;
> >  }
> >  
> 
> -- 
> // Casey (she/her)
> 
