Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D42DCC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 13:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A0079607CA;
	Wed, 14 Oct 2026 13:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8ZFpwTxR-Rc; Wed, 14 Oct 2026 13:00:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 890D0606CC
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791982852;
	b=E7+Qbl/Q7gHkl+a7DtccYQkIj0PcAmr7steTmUDnaTo+gCXl3piZKflFJyAy0SRmOuA8
	 y4skIBaEi3n3CsEIPpNc7aUuV1tuIy5zozI7sV+uDG+MS7EcLdMYxp4qWO762locuC8F5
	 4VaU9IPizoxwliqdNwOnTJxxr1mEh/mXi2Vsv92hvpuFaFFnvpbZYNYsIsxeLwqqg38ir
	 tT9HmY8qP9ofz1SekInHNOwszcVqKDCf8TTXVlfjVkDgzu+rOGc4lNzdGyrttAKL+UXHW
	 nm9MbtU82yRxkIAbCr345O0GnUrBDXkuwhdYK4dxnkXGIX9/Zx7LfUYpqVLfJBY6A0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791982852;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Debian-User:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6UEmXyaYtXY6bot3H3FGmhCy+OW4kZD/aVwrdeydl78=;
	b=BSeSVxicmYNOtu+KbWR8k0vrEGzbE/uRRuSQ+jzZauH3cMCBXamRHdLzko/9cHCCfnbq
	 wZ9vFBLlmMQEAh5lc6cIvbMdm+jIB8LbwNrsWEzV62U0t3CjUMqcdRpY254pa8IAgKis5
	 /29TTxtDLJ8EhN3Dgniu1QrqE8XSRqbwOLjSoKh2ntmDBfTSb0LLI6/wpfpmrnPXOd8x0
	 7vq40kMSoRL8zXH0v53n2RligwcFU/ZrA4O6tKwfusACdIw6xHuYq0rCAVnMD/Dy8R4pp
	 PiOEoDFK4GIV58ROnQq+u5VShM0NE+lFQ0msrEAkF0p/3B+wNYRJmNmEfSMQZ9GbkXg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791982852;
	bh=6UEmXyaYtXY6bot3H3FGmhCy+OW4kZD/aVwrdeydl78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n68xZFp1UmZzgJ/J10J5K3J69zhpZCQqXI91p46XRCYmxfgAGUYuEK4qQs9ns7KPz
	 GwTzePQId8cUkkKBmdCB5qmtxo4o/BpafmrJALolXhmA5wgtygA03tS+QfR03yJx19
	 nEDtisINwFe1THJJ8l6eEyIjm5ZJ+TRsHAauyYSC97pAYo450rtXTJQqLjbD6QOktY
	 gvK3Uy3RNpyk1yLLaicCdrYnF54mQ2bk7ERJlslPzfpCYenuEVLvGZZ/5Hp7/V/GG8
	 FN6a/6KiNR6tGDYUInX432fuhNr2erxO7Rz8T2B0YEgfOEFCAjiWiQ4AsVTvUNpNW7
	 K5RfetJslttXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 890D0606CC;
	Wed, 14 Oct 2026 13:00:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B8ED42E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F0834065F
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HXQ7fg1eDHA3 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 10:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB34540606
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791972973;
 b=cV3X0narzivMGbcaU583a5OaaY3CD+7xthrvDeD2h0ZCckNofeofQ5Kz/HyUz2XPOILB
 3tm4Dn9hpZaYrE+Y9tLwmHyPk7HQdo/ch6gTrMcyDARRYAYjBlCtdFHGlQUbmKzEYD4mz
 s6tXWqy0esNSJU5m+w5otEM642z/kAXrBEN8npML6qAq/jqIzYQB4M+N86dKI7qARdSWq
 uwkKXB9dD1kgu4vAtwn5OB8lAmU/tDpVw2cDIest6P373YXqtFNclHFsq1+7ZGvkXbFMs
 Uhs2zKYb7HMKYSFIA00jSf39T4XNyBXfhQ0f3E21FURJP4DlNgPepY70IMkluDZCHJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791972973;
 h=Received-SPF:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Debian-User;
 bh=6UEmXyaYtXY6bot3H3FGmhCy+OW4kZD/aVwrdeydl78=;
 b=RE8hNdQZyKrSNwCS/TQ3JHs9nrYQmFswgo5UBm56qimt66hKDUUc8a0etccx/nRUlVyc
 7zwtp7v/fwBSuWhbI5HZp97Dbdzhah1ZqaI/znQFcrsWDo8QzyW3bbDnWQe+zBRHRGMCO
 J9CMUfMR9pkx+yYtgit3GLF55SRvbqtdBsmQ0PrmgWJCuwNyWyCvsvdVtC5qrsE2+5WLs
 zOq2qRXXUuf0TNKdctZmNQOFg/18KjzIycjuoEjr1ADzTXXG3FSLzYPmmXyxpt9auPZb/
 PUvwoLROrp9qn3cGINdJNMaHd7XN2BklRCZZr+IO6fcDAYtRPR3J6bZcmv6IHZjAUfw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=fatal.se;
 arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org;
 envelope-from=andreas@fatal.se; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=fatal.se
Received: from stravinsky.debian.org (stravinsky.debian.org
 [IPv6:2001:41b8:202:deb::311:108])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB34540606
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:16:11 +0000 (UTC)
Received: from authenticated-user by stravinsky.debian.org with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <andreas@fatal.se>) id 1xGw1l-004Kpf-0Y;
 Wed, 14 Oct 2026 10:16:05 +0000
Received: from m1pro (194-218-217-50.customer.telia.com [194.218.217.50])
 by pi.fatal.se (Postfix) with ESMTPSA id CB8EA88;
 Wed, 14 Oct 2026 10:16:02 +0000 (UTC)
Date: Wed, 14 Oct 2026 12:15:58 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
Message-ID: <spbtjsrstebjyprloueyfsdzgyhqhb66ydaqearauvgvohgkjs@xmu2mzrtodqz>
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
 <as9MaWwEpGTAEFzj@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as9MaWwEpGTAEFzj@francesco-nb>
X-Debian-User: ah
X-Mailman-Approved-At: Wed, 14 Oct 2026 13:00:51 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Francesco,

On Wed, Oct 14, 2026 at 11:33:29AM +0200, Francesco Dolcini wrote:
> Hello Andreas,
> 
> On Wed, Oct 14, 2026 at 09:46:44AM +0200, Andreas Henriksson wrote:
> > On boards with >3GiB ram, we can end up with transfers above 4GiB
> > which is not allowed by SDHC driver.
> > 
> > fsl_esdhc_imx.c: esdhc_setup_dma():
> > 	if (upper_32_bits(priv->dma_addr))
> > 		printf("Cannot use 64 bit addresses with SDMA\n");
> 
> [...]
> 
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 021a82d4709..a5f2e3e1058 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1371,7 +1371,7 @@ config SPL_LMB_ARCH_MEM_MAP
> >  config LMB_LIMIT_DMA_BELOW_RAM_TOP
> >  	bool
> >  	depends on LMB
> > -	default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
> > +	default y if ARCH_BCM283X || ARCH_IMX8M || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_JH7110
> >  	help
> >  	  Some architectures can not DMA above ram_top boundary,
> >  	  which is after 4 GiB or 32-bit boundary too. Limit the
> 
> Is this specific of imx8m? This driver is likely used by other i.MX
> platforms.

Your thought crossed my mind as well, but to me it kind of depends on
if we see this as theoretical or if there actually needs to be a
practical problem.

For me on IMX8M with 4GB of ram, this is a practical problem.
On other ARCH it depends on how much total ram and if that all fits
inside the 4 GiB address space... so where is this a *practical* problem?
I don't know.

AIUI It it also not only the ESHDC driver specifically, so should we go
through all drivers and derive everywhere those are used and set the
limit even if it's never a practical problem?

In my mind, others will have to send additional patches when they
discover that this is also a problem on their ARCH_IMX8, ARCH_IMX9
or whatever. (Or tell me that they have a board in their collection
that is affected and they want me to include theirs in my patch while at
it.)

> 
> Francesco
> 

Regards,
Andreas Henriksson
