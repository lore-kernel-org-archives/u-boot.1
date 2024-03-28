Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A20C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6469A87E75;
	Thu, 28 Mar 2024 12:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ct8aUZ7r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392E388157; Thu, 28 Mar 2024 12:21:41 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0B2887DE6
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6F2FE60EB3;
 Thu, 28 Mar 2024 11:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76745C433F1;
 Thu, 28 Mar 2024 11:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711624897;
 bh=GacNbMSvPmNmkRPf03s0DIJ+V7E9KR2PXZxDV32TPHM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ct8aUZ7rhqxU80FkYsTFk0yXiJplLXTtNBmC200iqIdnDwRwHixdpPMiAGw9gqiIs
 kdQO7dqaT8gO2dk7u2PMBCc7aRVODS3FvGb0eXTAN5YRr9hFju+q2VW7csoiu3iVBx
 hR5cGdqicsw3p5Gnyk24xf3Ok4RhkhmYy8MM2EXYVMnoUPVZQgrbm7zJf2NcqVq8IB
 w+GX+0zNKL5tnNwQJdrHNHIDIF43FSmHkdnAh3A9gvXsQcnAXpmfu2195XuSEo1IzU
 59V+IzxOG5t6+MfOtABwmY9KObbSUlyUtvqRa3VyS06yvDWGWIQMc07hJB/v7qAj1F
 tapdsZXw4iusQ==
Date: Thu, 28 Mar 2024 12:21:33 +0100
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH u-boot-mvebu v3 11/18] arm: mvebu: system-controller:
 Add support for SYSRESET
Message-ID: <20240328122133.12b0e83f@dellmb>
In-Reply-To: <81922125-aa47-4be2-9e0c-c7dfd57c4ebc@denx.de>
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-12-kabel@kernel.org>
 <81922125-aa47-4be2-9e0c-c7dfd57c4ebc@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.39; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 28 Mar 2024 11:04:45 +0100
Stefan Roese <sr@denx.de> wrote:

> > +static int mvebu_sysreset_request(struct udevice *dev, enum sysreset_t type)
> > +{
> > +	struct regmap *regmap = syscon_get_regmap(dev->parent);
> > +	uint bit;
> > +
> > +	if (type != SYSRESET_COLD)
> > +		return -EPROTONOSUPPORT;
> > +
> > +	bit = MVEBU_GLOBAL_SOFT_RST_BIT;
> > +
> > +	regmap_update_bits(regmap, MVEBU_RSTOUTN_MASK_REG, bit, bit);
> > +	regmap_update_bits(regmap, MVEBU_SYS_SOFT_RST_REG, bit, bit);
> > +
> > +	while (1)
> > +		;  
> 
> A comment before this endless loop might be helpful here.

The code does the same as reset_cpu() in cpu.c, and the while() cycle
is not commented there.

But we can add something like
  /* something has gone wrong if we reach here, so we may as well stay
   * here */

What do you think? Could you amend the patch?

Marek
