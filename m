Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2920C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42668808A2;
	Thu,  6 Mar 2025 14:21:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="BPYIUs+H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C20EA80FE1; Thu,  6 Mar 2025 14:21:40 +0100 (CET)
Received: from mail.per1cycle.org (mail.per1cycle.org [188.245.231.141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2E6F805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C1A423F8B0; Thu,  6 Mar 2025 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741267297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kn6Me38vrddDEYnI3MzeAuizk3kQUB77Zr3z8qVdAak=;
 b=BPYIUs+HyUfVxyjfS+aRxgu+kXg3PkKwsKPqEbpebJqxxBhd4R/7BqXcQW3RZKbhTWLDEU
 WoDtPSVmMC440H8aeoKVtM01P3EyG2QajAIaTwL0IpqdIQt020W5UaB1dBgrWYVyW3ObGD
 kGUpbwdXCAe0e/fQMSuz3gaK5Xi7/PVuJeJrC5kPdwCErSYTpLsF4nUJo6aLmkvMxEQCLR
 bl2aKIJNN6P5NLIB5C9VCQ5fkTwRTU1sUJL6v/18lZgReNjzKT6DueL5C4qCYHFnjsB6SV
 hTIUfmQOiN27BfKho538n+CJguRLGka/dlqWHEnL0tiNxxAbGjKY7IjInudSKQ==
Date: Thu, 6 Mar 2025 21:21:22 +0800
From: Huan Zhou <me@per1cycle.org>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH 2/4] riscv: reset: k1: Add reset driver
Message-ID: <ejpkolndsgtmxziszqbjr3ul7vlxocl5aoyqabmqvmwuhatgb3@f7mihvwgbmel>
References: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
 <20250304-reset-k1-v1-2-dc9510ff1113@per1cycle.org>
 <Z8koWq8immMfhMr8@swlinux02>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8koWq8immMfhMr8@swlinux02>
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu, Mar 06, 2025 at 12:45:14PM +0800, Leo Liang wrote:
> Hi Huan,
> 
> Please run scripts/checkpatch.pl against your patchset 
ok
> and respin a v2 after all the warnings & errors are attended to.
> 
> Thanks,
> Leo
> 
> On Tue, Mar 04, 2025 at 03:03:28PM +0800, Huan Zhou wrote:
> > Add spacemit reset driver.
> > ---
> >  drivers/reset/Kconfig             |   7 +
> >  drivers/reset/Makefile            |   1 +
> >  drivers/reset/reset-spacemit-k1.c | 438 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 446 insertions(+)
