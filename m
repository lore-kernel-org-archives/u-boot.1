Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF6C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 12:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF65581FEE;
	Fri,  6 Jun 2025 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E4GCw7yl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A97D82977; Fri,  6 Jun 2025 14:43:46 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 829E881F0D
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 14:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EBAA543560;
 Fri,  6 Jun 2025 12:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAFCC4CEEB;
 Fri,  6 Jun 2025 12:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749213822;
 bh=b9S+D61V2F+TcltveM3elwjfEoa+dARl6OsbJ50ToZY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=E4GCw7yl0IWE6Fq6HffsJvGSrlPm2kbACfPPecbRJomSbETu2lucEBizbwA7/a59k
 stEIQju20gPHfzqVJNEI2xLG86FM8kE8q7NEOO+wnP3mShCnh6vlcYfoxYnkgPuVgD
 aiy6oVnezVJPY/olnqWyltY4z050gRTx8stdGVvcZNOqy/DVrlG56TpTtl4l7gsvBK
 uDzlKwq7JjxenC83QT8zeiLTKiCuVYjHEXOisyxE5SHpPkMPsGS475cZ9HhgTpNpPM
 cw3kTLbKDHCmcuEFeuHP06//RCsCXrfTRyDkifSVHneJPQvFT6b1i97bLPPkA0WECp
 5BhoaJczm3WIQ==
MIME-Version: 1.0
Date: Fri, 06 Jun 2025 14:43:32 +0200
From: Michael Walle <mwalle@kernel.org>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] env: mmc: fix offsets relative to the end of the
 partition
In-Reply-To: <10d4a4b3-2737-4908-92ef-af8c1dc09305@linaro.org>
References: <20250605074610.1424953-1-mwalle@kernel.org>
 <a2f93b49-aea5-4bc2-881a-11d3d85e4dc3@cherry.de>
 <10d4a4b3-2737-4908-92ef-af8c1dc09305@linaro.org>
Message-ID: <3815785b50849e02985504b89260f08b@kernel.org>
X-Sender: mwalle@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
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

Hi Andrew,

>> Maybe a Fixes: tag would be nice there, but since we don't have stable
> releases like the kernel, not sure it matters much :)
> 
> Please always include a Fixes tag when appropriate.

Will do. But please use reply-to-all as not everyone is subscribed to
all the MLs and I've just found your reply by accident.

-michael
