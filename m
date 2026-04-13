Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806ABF34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 12:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 031BD839DF;
	Mon, 13 Apr 2026 14:52:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rUahZXd0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65A1E839D5; Mon, 13 Apr 2026 14:52:49 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE8183DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 14:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 73ED861333;
 Mon, 13 Apr 2026 12:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DEDC2BCAF;
 Mon, 13 Apr 2026 12:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776084765;
 bh=0Qz2gEsVr6PvKb92/BVEOsiTOlvFfK4ReD8sfI6WezA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rUahZXd0w+fq3/TsrZQF4ujIA3xNkoqrV9c/qN31c9vb1ITZFB2pWiQjheJjnbRIu
 pzwu1L4qNJjGz3LzAUGPKdqDMoTqS7hxys2Gj/VE2EvTAzs2Qwl9xFqjcwLZRLVFkK
 NzeSDMM0gsUuh7SUVKGYu7cJsO06MZ5UMRmFR1yNn5KXo3Yi7WLSjegAebbIijCMto
 ifsmJGiQfsYgBJMmvBMpezGaT8tNOw2oXezs17LHeC7+ljlx1q+uGspAg9sQmIYgIw
 JgY2FI6kMjKrlaJ89FvJbCjd468LxtE1zGolUrYTDJUGkpRxbaRwOuV8870BVkAaG1
 ScyWYxq7fYvOw==
Date: Mon, 13 Apr 2026 18:22:39 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: Add optional support for device
 programmer flows
Message-ID: <adznF-hzUtiZ6QaV@sumit-xelite>
References: <20260409-cmddb-v1-1-b10549b34133@oss.qualcomm.com>
 <177608330028.1177412.9846637830549940803.b4-reply@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177608330028.1177412.9846637830549940803.b4-reply@b4>
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

On Mon, Apr 13, 2026 at 02:28:20PM +0200, Casey Connolly wrote:
> On 2026-04-09 21:15 +0530, Balaji Selvanathan wrote:
> > Add QCOM_COMMAND_DB_OPTIONAL Kconfig option to allow the Command DB
> > driver to bind successfully even when CMD DB data is missing or has
> > an invalid magic number.
> > 
> > This is required for device programmer flows where U-Boot runs
> > without AOP (Always On Processor) being invoked. Since AOP is
> > responsible for populating CMD DB data, device programmer scenarios
> > lack valid CMD DB and would otherwise fail to boot.
> > 
> > Normal boot flows should keep this disabled
> > as they require valid CMD DB data populated by AOP.
> 
> Presumably this is only used for development and isn't meant to be a supported setup right? In that
> case how about just using a normal macro rather than a whole kconfig option, then you can just
> build with make CCFLAGS=-DQCOM_CMD_DB_OPTIONAL=1 or something?

Looks like the commit message lacks to describe the motivation here.
This patch is a preparatory step to allow U-Boot to be used as a device
flashing/provisioning tool. In that environment, there isn't TZ or HYP
stage running and U-Boot is expected to be launched in EL3.

> 
> Kind regards,
> 
> > 
> > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > ---
> >  drivers/soc/qcom/Kconfig  | 16 ++++++++++++++++
> >  drivers/soc/qcom/cmd-db.c | 10 ++++++++++
> >  2 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index 8243805e46a..239d87e044f 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -18,6 +18,22 @@ config QCOM_COMMAND_DB
> >  	  resource on a RPM-hardened platform must use this database to get
> >  	  SoC specific identifier and information for the shared resources.
> >  
> > +config QCOM_COMMAND_DB_OPTIONAL
> > +	bool "Allow operation without Command DB data"
> > +	depends on QCOM_COMMAND_DB
> > +	help
> > +	  Allow the Command DB driver to bind successfully even when CMD DB
> > +	  data is not populated or has an invalid magic number.
> > +
> > +	  This is useful for platforms where CMD DB is not populated by
> > +
> > +	  When enabled, missing CMD DB will generate warnings but allow boot
> > +	  to continue. Consumer drivers must handle cmd_db API failures
> > +	  gracefully by checking return values.
> > +
> > +	  If unsure, say N. Most production Qualcomm platforms require
> > +	  valid CMD DB data.
> > +
> >  config QCOM_RPMH
> >  	bool "Qualcomm RPMh support"
> >  	depends on QCOM_COMMAND_DB
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index d0a6047b8a6..b4682d811f7 100644
> > --- a/drivers/soc/qcom/cmd-db.c
> > +++ b/drivers/soc/qcom/cmd-db.c
> > @@ -252,8 +252,18 @@ static int cmd_db_bind(struct udevice *dev)
> >  
> >  	cmd_db_header = base;
> >  	if (!cmd_db_magic_matches(cmd_db_header)) {
> > +#ifdef CONFIG_QCOM_COMMAND_DB_OPTIONAL

Switch to IS_ENABLED(QCOM_COMMAND_DB_OPTIONAL) check instead.

> > +		log_warning("%s: CMD DB magic not found (0x%02x%02x%02x%02x)\n",
> > +			    __func__, cmd_db_header->magic[0], cmd_db_header->magic[1],
> > +			    cmd_db_header->magic[2], cmd_db_header->magic[3]);
> > +		log_warning("%s: CMD DB data unavailable, resource queries will fail\n",
> > +			    __func__);

Convert these warning rather to log_debug() since this will be under
special config check anyways.

-Sumit

> > +		cmd_db_header = NULL;
> > +		return 0;
> > +#else
> >  		log_err("%s: Invalid Command DB Magic\n", __func__);
> >  		return -EINVAL;
> > +#endif
> >  	}
> >  
> >  	return 0;
> > 
> > ---
> > base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
> > change-id: 20260409-cmddb-394afa003818
> > 
> > Best regards,
> > -- 
> > Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > 
> > 
> > 
> 
> 
