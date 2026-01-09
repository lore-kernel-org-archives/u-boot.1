Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 793C9D167FC
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 10:24:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E309A84132;
	Fri,  9 Jan 2026 11:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Mmgr20UO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F07168414B; Fri,  9 Jan 2026 11:24:10 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF1583CDF
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 11:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 60E8E416B3;
 Fri,  9 Jan 2026 10:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B841C4CEF1;
 Fri,  9 Jan 2026 10:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767954247;
 bh=w8q44n/TfhRHmLw3aCPPZE9QA5sxYYyobUSCVSQ1s90=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Mmgr20UOuMnrFujuV4VtCE8aj/vyYrJE8XcLT8N4O9TkS2RCigzKjB57mNJw3NUS7
 LA75IzC9v4ok1S9guZs2BXkSKLN1KCn/Eef+XRUsvJAZQlRPuSyVlv/kkbLNE8wyse
 M2XUy+OOHha1Vc6y/W/j1dtI1qdjUfQ3dYvOhIV+L9/b3N2RlFfuuKxbGgAd2pABxY
 dAsJbH1dUmWr0ynVXEsdnm0w5slkVs9nQ6FFCKduLo0NHVKp6DKMEmKkXOk/Zzh+J/
 uAMgTzjG0nupUqcl/duFcCdF8VwGdsCbDGr5r77vYXjT9sAV30Ci1okGyMiRQUI6er
 XqQ+F/tQNaaeA==
Date: Fri, 9 Jan 2026 15:54:00 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, trini@konsulko.com,
 casey.connolly@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
Message-ID: <aWDXQFXQcaoeV7ka@sumit-xelite>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
 <b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org>
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

On Thu, Jan 08, 2026 at 05:19:32PM +0100, neil.armstrong@linaro.org wrote:
> On 12/29/25 12:43, Sumit Garg wrote:
> > From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > 
> > Add support for OP-TEE live tree DT fixup support which enables U-Boot
> > OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
> > the live tree fixup to be carried over to the OS for the OP-TEE driver
> > in the OS to probe as well.
> > 
> > Note that this fixup only gets applied if CONFIG_OPTEE gets enabled.
> 
> Can't the presence of OP-TEE be detected dynamically via scm calls ?

SCM calls aren't present in case of TF-A/OP-TEE flow.

-Sumit

> 
> Thanks,
> Neil
> 
> > 
> > Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > ---
> >   arch/arm/mach-snapdragon/of_fixup.c | 34 +++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> > 
> > diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> > index eec2c0c757e..29a99f73cf3 100644
> > --- a/arch/arm/mach-snapdragon/of_fixup.c
> > +++ b/arch/arm/mach-snapdragon/of_fixup.c
> > @@ -146,6 +146,37 @@ static void fixup_power_domains(struct device_node *root)
> >   	}
> >   }
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
> > +		log_err("Failed to add 'maximum-speed' property: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
> > +			    "linaro,optee-tz");
> > +	if (ret) {
> > +		log_err("Failed to optee 'compatible' property: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
> > +	if (ret) {
> > +		log_err("Failed to optee 'method' property: %d\n", ret);
> > +		return;
> > +	}
> > +}
> > +
> >   #define time_call(func, ...) \
> >   	do { \
> >   		u64 start = timer_get_us(); \
> > @@ -160,6 +191,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
> >   	time_call(fixup_usb_nodes, root);
> >   	time_call(fixup_power_domains, root);
> > +	if (IS_ENABLED(CONFIG_OPTEE))
> > +		time_call(add_optee_node, root);
> > +
> >   	return 0;
> >   }
> 
