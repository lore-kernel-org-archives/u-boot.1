Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DDEEC83F17
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 11:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE3BC83824;
	Thu, 31 Jul 2025 13:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753962324;
	bh=coIhclRXIDq8r9iw7TiihKK7jIMO8+pAThXCQ7pwjng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v0irfjvHR6i1KkC5jeiqVUrPPIstolBpxEiSPHownRgNiqmdmn/Uq2SVaWntufZmG
	 RWz6eZhPFzLzEk7s0TWCowIk6s9/69MWon0fOqIYyWyMEXjW5EJ8lO8KayD4u+NnHF
	 9rvst23SdBcrpFLGXZn0LXNsQS/UJx5MDijQpJeeOt8lyYtFaOoYTlJRoZi41ab3yo
	 86ZHwWXzrLiEKzo3CMvSBUJnBYphIK9p1ZwMcc+dZsjc8xL+h+EqTcpUjzSjiwLw53
	 snomv8eOZHYcK4xhO+WNdVun7mTATPSMInyQhOPR178Mn7S2RQ4iQOU8rJtWbB+1Y2
	 yjgnSY5EAOTPQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2D7283885; Thu, 31 Jul 2025 13:45:22 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE8C83816
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 13:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="auDRvi3D"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0EE5C1038C126; 
 Thu, 31 Jul 2025 13:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753962318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=coIhclRXIDq8r9iw7TiihKK7jIMO8+pAThXCQ7pwjng=;
 b=auDRvi3D6HpLWCGf5I/znysIdzr5jSEViT2butCZ+ZpQom6afhN4De/pK03c7A6/vtnyXy
 0J8X+TMde1xYChu1usdi921zNi4tz7kJblS2APh2fvU/ctPFLbBRSLO7aJg17vzGbVn/Kg
 t4OTQhYb5ll8Ee5rLQpoV5QTdoygGfwpWYQpCZjxfMbYhlei9YkviT0feYqO52mKNnYxwW
 FkLi1qDqAOAuNzCPlh0eqx386C5qclmLhzqN8vySboQ4twoeRRmfpVjyBCh+gGWN37t2ah
 SAM82H76eiZP+rBAxjU+nwv8P1JLgpGkSirIfBzdpCQ3KkbQUTl1TZe0fT0poQ==
Date: Thu, 31 Jul 2025 13:45:15 +0200
From: Philip Oberfichtner <pro@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Paul Kocialkowski <contact@paulk.fr>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Trevor Woerner <twoerner@gmail.com>, Marek Vasut <marex@denx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Kconfig: typo restict
Message-ID: <aItXSz1FcmATTYQe@antares>
References: <20250730125427.587976-1-heinrich.schuchardt@canonical.com>
 <3f34945e-9e4f-451e-85eb-5a5e4e5cd265@cherry.de>
 <0b5e6888-6652-4ec7-971e-710dc9cd3a77@canonical.com>
 <20250730143250.GP1807455@bill-the-cat> <aIoxIl6rdyN3NbNc@antares>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIoxIl6rdyN3NbNc@antares>
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

On Wed, Jul 30, 2025 at 04:50:15PM +0200, Philip Oberfichtner wrote:
> > > With VPL_SIZE_LIMIT and a patch for UBOOT_WITH_SPL_SIZE_LIMIT pending things
> > > get even more involved.
> > > 
> > > We should think about a documentation page on size limits:
> > > 
> > > CONFIG_HAS_BOARD_SIZE_LIMIT
> > > CONFIG_BOARD_SIZE_LIMIT
> > > CONFIG_SPL_SIZE_LIMIT
> > > CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD
> > > CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC
> > > CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK
> > > CONFIG_TPL_SIZE_LIMIT
> > > CONFIG_VPL_SIZE_LIMIT
> > 

Hi again,

> > As Philip has hit adding a new MIPS board and need for specific size
> > check, yes, better documentation (and then perhaps adjusting and
> > cleanup) of our various size checks is much needed and would be
> > appreciated.

I just posted an RFC on how we might want to start cleaning up the
current situation:

https://patchwork.ozlabs.org/project/uboot/list/?series=467406

Best,
Philip
