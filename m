Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA31EF48D9
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 07:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 919D382BF2;
	Fri, 13 Feb 2026 08:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KZw0cppV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4708883015; Fri, 13 Feb 2026 08:00:53 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28C5380FA1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 08:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 679EB43C9A;
 Fri, 13 Feb 2026 07:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3A8C116C6;
 Fri, 13 Feb 2026 07:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770966049;
 bh=L1WIefbMeW2alcg5ozsLmujiiTBB79hfN/TAb62Pnas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KZw0cppVQaNFZ6SUN2agpKvTYvNsS4nXoomoBbSkLxUuMPIVdN8a6N5IYqI4kNMdo
 WcDpUnGdITccTq4s5ObCLrewoeT3u22R9d5GBie4Bjl7Po+TC3v9DVhTuzog4HzGv/
 NkYK8OJMdgjikxz/uSC7fhD3abgUFqd1mPmpC2ft4jkUlKrZHxBfCclP2S4SVSlbGn
 1gdYoAwrgvjTGB8wQJOlHt4nnbHNg8+l6sZ1T1in7MpmynLO2olAnmLy+Q1jzJQbjE
 3ETlG7cibl1dv3q6hrUc6guhUgF0fQF6e18DtDHwLejcFQdxzxJOiqqN567hGXeu+x
 OCt4xZfFkjHwQ==
Date: Fri, 13 Feb 2026 12:30:41 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, quic_varada@quicinc.com, me@samcday.com,
 sughosh.ganu@linaro.org, ilias.apalodimas@linaro.org,
 balaji.selvanathan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/3] Add FIT multi-DTB selection for Qualcomm platforms
Message-ID: <aY7MGQXNsUesQR6h@sumit-xelite>
References: <20260129184817.224101-1-aswin.murugan@oss.qualcomm.com>
 <bebb1333-5bde-40cc-b9e8-b1a1bf506e9f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebb1333-5bde-40cc-b9e8-b1a1bf506e9f@linaro.org>
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

On Wed, Feb 11, 2026 at 02:54:18PM +0100, Casey Connolly wrote:
> Hi Aswin,
> 
> On 29/01/2026 19:48, Aswin Murugan wrote:
> > This series adds dynamic device tree selection from FIT images for
> > Qualcomm Snapdragon platforms, enabling U-Boot to select the
> > appropriate DTB based on hardware parameters detected from SMEM.
> > 
> > Qualcomm fit based DTB format is documented in [1]
> > The fit image contains only DTB, while the kernel will be part of UKI image.
> 
> Excited to see support for this!
> 
> Without getting too deep into patch review yet, I have some high level
> feedback with this approach.
> 
> Regarding SMEM, did you take a look at my old series refactoring that?
> I'd like to resend it if you guys didn't pick it up yet.

I haven't heard anybody picking up that series yet. So feel free to
rework and post.

> 
> The main issue that still needs to be solved is how we deal with the
> multiple incompatible versions of the "ram_partition_table", this needs
> to be detected and handled properly at runtime. Are there relevant
> version fields in SMEM we can check?
> 
> Of note, with the smem refactor it won't be part of the driver model, it
> will just look-up the SMEM node manually and use a global since that
> vastly simplifies things since it can be called from so many contexts
> including before the DM is set up.

This approach sounds reasonable to me.

-Sumit

<snip>
