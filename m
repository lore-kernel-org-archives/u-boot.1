Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75932606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=H19WnXMe;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fuk/2szm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 483FC60A8C;
	Thu, 26 Nov 2026 22:35:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2bcdazAIZ9tO; Thu, 26 Nov 2026 22:35:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96D8060AA1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795732511;
	b=RE1gGycJaxlOD/7taIKfVmgKjfWX8zf6Cn1omL/6/nNWDfahQa5YcK7xb6ctyoxRQhtB
	 0vKMsDuofc7K8zvZ86i/mJQ2p2+HhWSUZbHVmMHCU9UAb/gyoGcSr84XRlXBFxzHGSVvi
	 bWM6if5VDrSDZUpkitA5FAOT59+cHUgQtA8oAuMgjgthYRfi8n1MG4sl3Jp2eDfGtdOhx
	 1osn6zJM3LOjESNR53526+cV0lT1NAqSPFUH6zE7wOUmxUaTqNSQMhWR5+wzxlpzR2g11
	 Afq5zU49U73HwvbSHJfw3MilRbrop8Ec06+Rqq9YJxeDjDxmQ/zlChz49K45ARGBtTA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795732511;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rOc8SeRVzPD15Xp1Pfxz1076ACgxnNl7Xc6ad/H8Ess=;
	b=bGPYQJ1UHhFoJr6HHBMV10VSVSogl0/JVgYz41mO1HbE6ZSdz0npK0pR6uTslAfmzEqa
	 RkOw/GtkLLZFYj7ExqpZU0nH0oMnB0OceMMfixYmpR1//yW66YD3q1zutkf/V3/JIihyX
	 SFd6NSh+idNkEPAwKzonw5yJnr9CtBaFbIhr+ZTM6N4UVEZ+4EaKyOBdDTO1TFPFb6saS
	 Zfcmt3rddQJxY6qzeMZC/cTD1UQhoQG6mKqoNx+/nDmgrSIpDF4WRPCQO76dEU2sCwxkC
	 kyANIb28gQhQTCo9bDZdc6p+TvruOBWahIFwy7d0QR8ZuOZQ2Jrarc1nGTAhGkMpnsQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795732511;
	bh=rOc8SeRVzPD15Xp1Pfxz1076ACgxnNl7Xc6ad/H8Ess=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H19WnXMe4OMSiQ0sWLoBachJ3VBdUi4oCoo/jSePuHVoOCGRrNthQ0PUQlqAArYzQ
	 mWqmOMKR0fWdBulb6bmRswMnYCYxZYRhoNh4LGyclREjUTq4P5xCB6nCsJlRsyWIhC
	 mt9zx7dHUI5bdL9JzSt0+yBbpo9OYGkwu/Unvgp0N0NZx2mVG8ttFmbXgDj1H5B59a
	 zskAiF1IITB1/diXhLw8FEwKxUJgUvuvdFaoQ7jTEkZoeJ6SXzPF87hHK7H0RP0lmx
	 qW0c7z5pSoxxLTW5u3gNzPNYnUJIhRW+o9q7Y0uw55VVZxkdoFyErk/oqyHVT1ccLv
	 52BIUckGShgGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96D8060AA1;
	Thu, 26 Nov 2026 22:35:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F4671AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 80FC7400CB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPdJfuHZZMP5 for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 22:35:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DB3F3400A0
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Fuk/2szm
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DB3F3400A0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E703C4115D;
 Thu, 26 Nov 2026 22:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EF51F00896;
 Thu, 26 Nov 2026 22:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795732507;
 bh=rOc8SeRVzPD15Xp1Pfxz1076ACgxnNl7Xc6ad/H8Ess=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Fuk/2szmItSpjPiJq1sQCQzBaZAKufFRhVWFNRW33lHUcfJf5bFmK+ciclGsbp0PJ
 sMx3Pf4QH18FBoN4fQ5t/YiEKjf80lGZ/sfo3nAg4aIuANBf0FMaVOAbmVHWOXU2zZ
 MX9p2H48kfjljb4K8C9EdFgMqJLJpOYK4UcUvkQoRH5ikYSn+dPiHoSJHIHrxfbAm7
 weDn5vJ/5SecbTJ4HRzfxpcveyQ82SPJq1i9dYifXFN4qQYaClzYkoQ2oRy9lLtKrl
 X7q4eDRBaIPOOyOU9miSm/bwXE8MfMZgWTAh/R6/4B0wPXWiY5Gnin5z+hUwxlKh8z
 xhFbgTSqeGRzA==
Date: Thu, 26 Nov 2026 22:35:05 +0000
From: Yixun Lan <dlan@kernel.org>
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Eric Chung <eric.chung@riscstar.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] mmc: spacemit: k3: Add compatible string
Message-ID: <20261126223505-GKA8249@kernel.org>
References: <20261121-05-spacemit-k3-sdhci-v1-1-0c9eff3d6b71@kernel.org>
 <179569871260.2402123.15029160949676379277.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179569871260.2402123.15029160949676379277.b4-review@b4>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Guillaume,

On 14:11 Thu 26 Nov     , Guillaume La Roque wrote:
> On Sat, 21 Nov 2026 00:14:23 +0000, Yixun Lan <dlan@kernel.org> wrote:
> 
> Hi Yixun,
> 
> > Add compatible string for SpacemiT K3 SoC to enable support for
> > the SDHCI controller which necessary for bring up eMMC and SdCard.
> 
> Nit, this should read "which is necessary to bring up eMMC and SD
> card".
> 
> >
> >
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> > index fdedb9a301a1..35f6c0a7cd7c 100644
> > --- a/drivers/mmc/spacemit_sdhci.c
> > +++ b/drivers/mmc/spacemit_sdhci.c
> > @@ -660,6 +660,7 @@ static int spacemit_sdhci_bind(struct udevice *dev)
> >  
> >  static const struct udevice_id spacemit_sdhci_ids[] = {
> >  	{ .compatible = "spacemit,k1-sdhci" },
> > +	{ .compatible = "spacemit,k3-sdhci" },
> 
> spacemit_k3_defconfig does not enable MMC nor
> CONFIG_MMC_SDHCI_SPACEMIT yet, and only the CoM260 IFX DT enables
> sdhci0, so this cannot be exercised on a Pico-ITX with the default
> config. Do you plan a follow-up enabling it in the defconfig?
> 
You right, there is no SD or eMMC on Pico board.. even only SD on CoM260

Yes, I do plan to submit follow-up patches for defconfig and dts fix-up..

> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> 
Thanks

-- 
Yixun Lan (dlan)
