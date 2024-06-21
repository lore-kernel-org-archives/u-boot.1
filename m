Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BEBC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F20588059;
	Fri, 21 Jun 2024 15:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E8A688405; Fri, 21 Jun 2024 15:42:29 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 033A888013
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DCF7DA7;
 Fri, 21 Jun 2024 06:42:51 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.71.241])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A643F73B;
 Fri, 21 Jun 2024 06:42:25 -0700 (PDT)
Date: Fri, 21 Jun 2024 14:42:18 +0100
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, rui.silva@linaro.org
Subject: Re: [PATCH] arm: dts: corstone1000: enable secondary cores for FVP
Message-ID: <20240621134218.GA1453200@e132995.arm.com>
References: <20240612100421.47938-1-harsimransingh.tungal@arm.com>
 <20240612160036.GP68077@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612160036.GP68077@bill-the-cat>
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

> > From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > 
> > Add the secondary cores nodes in the dts file
> > 
> > Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Rui Miguel Silva <rui.silva@linaro.org>
> > ---
> >  arch/arm/dts/corstone1000-fvp.dts | 25 +++++++++++++++++++++++++
> >  arch/arm/dts/corstone1000.dtsi    |  2 +-
> >  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> Can we move this to using OF_UPSTREAM instead? Thanks.

Thank you, we will be considering that.

Harsimran Singh Tungal
Cheers

