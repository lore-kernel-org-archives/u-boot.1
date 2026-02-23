Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129E4EF5864
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 05:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD4B83642;
	Mon, 23 Feb 2026 06:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gwO0+nrb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDFB83C39; Mon, 23 Feb 2026 06:03:37 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7850180050
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 06:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 430BD6001D;
 Mon, 23 Feb 2026 05:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB17C116C6;
 Mon, 23 Feb 2026 05:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771823012;
 bh=SGSY2ZPjLze8mP5kFIYYwmCWigE+VL1uWs77Ewr1TTI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gwO0+nrb8H2mafyTPon14U2MbDZWH15CZ8JuCkl6RgcwEBG/33VcNzA7lLyJywJ36
 RpaDVoHGU4K55H7xwkvQSmC8EnMvDIGze0Oh951k3VMkV+RVF0hoQzTbt943jO4LD3
 oYZbJIgnqu4jgqqtolDcYDoXzBV+0sMAiT3XdBtlCAw6tFiTfFnajZbHIsd8YEI/x9
 8PEMpgXDRwg8xR0JFu0TuXnbpXwoFtjMf/9sT+J6R2OE7ZPDMR2SbmDhUly1WYsLVz
 3axK09coS1wvSK+4hQiE3RDtd5oWgOPJ/IwDlxXT4Tv+rafV2L/W31CoSWm5mNkmEe
 gQERxL2/jdFQQ==
Date: Mon, 23 Feb 2026 10:33:25 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: "Lucien.Jheng" <lucienzx159@gmail.com>, jerome.forissier@arm.com,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, vladimir.oltean@nxp.com, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 3/4] dt-bindings: net: airoha,en8811h: deprecate
 pnswap-rx and pnswap-tx
Message-ID: <aZvfnT8C-g3DXBgp@sumit-xelite>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
 <20260221163114.87553-4-lucienzx159@gmail.com>
 <20260221164556.GZ3233182@bill-the-cat>
 <8e1c4274-797e-4f2d-b1ff-c6ef67bffacd@gmail.com>
 <20260222164950.GB3233182@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260222164950.GB3233182@bill-the-cat>
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

On Sun, Feb 22, 2026 at 10:49:50AM -0600, Tom Rini wrote:
> On Mon, Feb 23, 2026 at 12:27:02AM +0800, Lucien.Jheng wrote:
> > Hi Tom
> > 
> > Tom Rini 於 2026/2/22 上午 12:45 寫道:
> > > On Sun, Feb 22, 2026 at 12:31:13AM +0800, Lucien.Jheng wrote:
> > > 
> > > > Deprecate the proprietary airoha,pnswap-rx and airoha,pnswap-tx boolean
> > > > properties in favour of the standard rx-polarity and tx-polarity
> > > > properties defined in phy-common-props.yaml.
> > > > 
> > > > Update the example to use rx-polarity with the PHY_POL_INVERT constant.
> > > > 
> > > > Link: https://git.kernel.org/linus/44f62aa1b1209232cedcfb39097fc1bfbe75bbc7
> > > > Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
> > > And for clarity, my comment about cherry-pick also applies here. The
> > > script tools/update-subtree.sh makes doing the cherry-picks
> > > straighforward.
> > 
> > Thank you for your comment.
> > 
> > I checked devicetree-rebasing.git and it only has the v6.19-dts tag.
> > 
> > I will try to manually cherry-pick all phy-common DTS-related commits from
> > Linux.
> 
> Outside of extra-ordinary circumstances, we just wait for them to be in
> the rebasing tree and do a proper cherry-pick.

Exactly, directly patching DTS git subtree shouldn't be allowed. I
would rather say it's better to use alternatives like *-u-boot.dtsi etc.

However, in this case v7.0-rc1-dts tag should be available soon as over
the weekend kernel has been tagged with rc1 release. So just wait for a
few days for that to be available.

-Sumit

> These changes look fine
> (but waiting for other comments still) for v2026.07, so there's time to
> wait, really. Thanks!
> 
> -- 
> Tom
