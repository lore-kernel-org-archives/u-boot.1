Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860B0D6392E
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 11:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF52A8964F;
	Wed, 20 Nov 2024 12:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="tJVPyK2s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 871028966E; Wed, 20 Nov 2024 12:26:51 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ADF3894F9
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 12:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uyTIjHBxqXqUVH9um9RqqSEdOliyilyCBLOvsqyntlY=; b=tJVPyK2s4spXt9GD5if97AFQg2
 5wlED5ZK9kEHssgAPqlhK8dEN9PZJCrLyibEe5+Co8WEA66SDtXMwdpgpqJbtpqY2b9P5jNYUXHTA
 NAhxEWeDFXRIKGfmKRjpl3irg8ZgJeevQAGi08uWAJmsQZE8U2TjaV/eykqlsfWMYpDEzipxJERsG
 yJ6yJ+Nj0LWEetyuMMkaDFT4TLdgYHfsbvTLvutqFas6hQ1BNHXNZy9NxabCNtzLvv9XLzgVSNpwu
 niMS2Gc6Jug7A0gr6VOo2S7VrtpC4rp6+in5ng9/Ft04pCHf5Aa4RY30VXMKUTWYMKSukHA8D45ni
 jraq+lMQ==;
Received: from i53875a30.versanet.de ([83.135.90.48] helo=phil.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tDir8-00070t-8E; Wed, 20 Nov 2024 12:26:46 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] clk: rockchip: rk3588: fix mask define for aclk_vop_root
Date: Wed, 20 Nov 2024 12:26:45 +0100
Message-ID: <13528783.O9o76ZdvQC@phil>
In-Reply-To: <4527740e-34c5-4669-b3ae-86792160b59d@cherry.de>
References: <20241120101911.1142500-1-heiko@sntech.de>
 <4527740e-34c5-4669-b3ae-86792160b59d@cherry.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

Am Mittwoch, 20. November 2024, 12:13:32 CET schrieb Quentin Schulz:
> On 11/20/24 11:19 AM, Heiko Stuebner wrote:
> > The mask for aclk_vop_root is 3-bit wide, not 2-bit wide according
> > to the TRM, so set the mask accordingly.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Was this a drive-by bug fix or did you actually experience some bug? 
> Basically trying to figure out if we should push for this being merged 
> for 2025.01 or if it's fine if it misses it?

on my side, it was a "drive-by" thing and I actually don't remember
anymore, what made me look at that. So I don't experience any
bug on my side.


Heiko


