Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC3C1073C9E
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 11:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4137F83D8A;
	Wed,  8 Apr 2026 13:35:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hbeKueZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A94083F98; Wed,  8 Apr 2026 13:35:50 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 635FF838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 13:35:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4563B60121;
 Wed,  8 Apr 2026 11:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F279C19424;
 Wed,  8 Apr 2026 11:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775648147;
 bh=fIgw+6URITORFbPZRqhI5w53nQAwyC7VJb6+hXsQjFQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hbeKueZVB6DXZn3yQUbZF8CwdTsHhhKWQxipf6St0bgG0zvTgrAhUtOVRT1wIJzf/
 9GcQTaWtyNj6F7K7+fa2mBi8/yr4wom1yGp+dC6n2VmIGmyyBxnS5UxRnUu2zXXkqh
 VlGrM7gDWpGk7nETeiv3fG2DcGa3R5UMAODEZ3Gj1x8Z7CYa6tIo9iCfNELDoS+k8Y
 2dpVjOJfu8xhmExH80M34X0aAta8OA34JONCgTBhEvuo+q5jCG3hhWtt1e3f4weNBi
 05AKKxo9I044zinyD4raNg5JfH/7pxYG2k/bne81Lrq0sGMFNrhR0wy1BLsTIjXNsg
 kCfLo1S6o5jzQ==
Date: Wed, 8 Apr 2026 17:05:41 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 1/2] serial: msm-geni: allow invalid clock
Message-ID: <adY9jXd1gYJrKsMk@sumit-xelite>
References: <20260320-casey-qcom-rpmh-serial-fixes-v1-0-b81d05832eec@linaro.org>
 <20260320-casey-qcom-rpmh-serial-fixes-v1-1-b81d05832eec@linaro.org>
 <adTs0aMJmGrIPKeR@sumit-xelite>
 <ac78f01b-7aee-4658-b682-67d4f53cd40f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac78f01b-7aee-4658-b682-67d4f53cd40f@linaro.org>
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

On Wed, Apr 08, 2026 at 11:16:24AM +0200, Casey Connolly wrote:
> Hi Sumit,
> 
> On 07/04/2026 13:38, Sumit Garg wrote:
> > On Fri, Mar 20, 2026 at 04:45:40PM +0100, Casey Connolly via B4 Relay wrote:
> >> From: Casey Connolly <casey.connolly@linaro.org>
> >>
> >> Pre-relocation we probably won't have a clock but it's usually
> >> been enabled for us already, or worst case we will enable it after
> >> relocation.
> >>
> > 
> > Not sure if this is the right approach, since the UART driver might just
> > hang without clock being enabled. What's the motivation for this change?
> 
> Hmm, I didn't consider that. The motivation here is to handle CCF, since
> we don't want to support clock pre-relocation. In pretty much all cases
> today the serial clocks are already configured but you're right that we
> ought not to depend on that.

I think this again comes down to that how CCF framework can enable
U-Boot SPL use-cases or where in U-Boot proper you get to work with an
uninitialized UART port for an OEM board variant.

> 
> I can't really think of another good solution than hardcoding this clock
> configuration somewhere :/
> 

That's true since we rely totally on DT based driver probing in U-Boot.

> Any ideas?
> 

Have you tried working with DT properties like bootph-pre-ram etc. that
allows only say UART driver to probe before relocation with CCF?

-Sumit
