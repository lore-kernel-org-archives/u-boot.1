Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FCEC9830C
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 13:16:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82C1640714;
	Wed, 23 Sep 2026 13:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2R5ryERDwxgO; Wed, 23 Sep 2026 13:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A160A406F7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790169375;
	b=UT6dgxdnMtJtVBB0szfnppA3+ji68FgRFmpMgmcS39c1Oxb5O0d7nAqDpFV09q2JcYlk
	 vba0yycglCH7uVKPFbTlMHEXaWzvKShcwQe+alKteFu3mRdsMqQwBQXy+rvwmPuvq9P1m
	 5ryyuBylNBgxZ1pJBFAsk5+QUjm5SFKl3biLe4GciCIDv2vJ6Uz9hh70Ttok4kvQVyCmm
	 vF+l11i/QcCmUrp0lHUY9NrMDcmIQPnqLVErtOdFkkjziYQaG81mbfTveVaqwVuc9G3QZ
	 EjbULZ3OHcDiQfdXveeYwTvp2+rSuBURDM8iImhnfDPjZ2ilVguhgCbHB0prsZTsHfA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790169375;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=7I0kuy7hqP/YLp608rvSrbB7l+e/YY8bYhe47TYBxyQ=;
	b=VbcQlvuYPufrx8CZ7pfkBrZwWzzl98oSxO0Jf8FhgLv5z7RyHRcapk1pqsmjuZGQ88IQ
	 LBcWllNi8dvjoGfS32K7KciHJ1i06bcilHcV1m1tfdhUztkzOOiVPca0ah8GujI3mP9ID
	 hKsfi8DHp/Fn0HOAzqete8JPzUc2UgHdDyhOgVH43qRhZ2UCMpDmymg9maz4EewEYbm9U
	 cvEuD0saOFBdMCEmBy7+1d3pEJPmf3amhQcf6swHdUB7Oj2r+WK6sTjF3bSa4yvSSPp17
	 GPJk0C2WhrskOppT8jj7hugvT2oetmjLGNLXTBe6RuY8Ktf/fYCEd/hJxa1UpRmpP1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790169375;
	bh=7I0kuy7hqP/YLp608rvSrbB7l+e/YY8bYhe47TYBxyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PiO6yLF/jmXMDYns/yujz+QvfxAjI5/N0vOo3LggalGbs7b9xqM0RbvkcKj5ggOv6
	 Jp0S9hoaKPzFh+NZjwjPsrTtr6zfiz9C96y05AS8R+WgM+7DtcisYqanI9Q51qv3AM
	 zG2EbySaqpaByANFM+bomKZN784MXoo5KXDAruGCUmX8VKC2vGMe+PFk6kirvROjuG
	 Yylc6AMSGGSDDlJW5sN669ZzkSzEmI+6bE0dnUKk4d2dyZ5ln9vTBROrkKy1QblsFx
	 fxbLbfIvZzcwqfN6/xEr/KqEMw39HRhLcUHC+dkzlnhGnmf7vQ7hyDSOaQPNP5OrOg
	 HgJOuCu5YlBnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A160A406F7;
	Wed, 23 Sep 2026 13:16:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9582F3A9
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:16:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BC7D4035E
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:16:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Gi4cdKhTZ4V for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:16:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 9FA2B4035D
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790169373;
 b=TFIwOBEzuaw3f0fI3fsnORaEFnma+Gj/wZg0qQvHw+35DxYDGCmlbpPT4CvVKAMQSfBC
 qtwoRzBlSl/CrK9Virj61N0ENiHd1AcfG/haGlXNtNncCs3E6bQTuNKSbYEPZrBLpdNKB
 RwEaDsPaM+Ji4A6GR4hYkjiMOkOZW2x7LWtnjJRV0o90hetY7khVCQPf0roI0TAdvxgeg
 J+TG03pcDX7DI0U3dDS/MgV8Z0B+ESOwsS+yrzZlVphC7pDmqy4szmt3XKYhcBfZTHeTk
 364YTFyzNXX1dRR3p70Go7gxfQsiBwThYfnBB/quQmo2Ppc3uTeaHkogTdfavayYUnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790169373;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=7I0kuy7hqP/YLp608rvSrbB7l+e/YY8bYhe47TYBxyQ=;
 b=TjeUNkPIv+fHHUXhiHV1WNu/gYLDbD4hxZUQYshkoKCKqZtp5lkSgqNv3FGm218AxXLP
 UMkfl2YwuXNJPJhqBfolw/clYkFDNW2Dmem1zgri8yJxiVO0LwGMhsXrGK99jT6gLfm3f
 BaQDuNSLEBByPtSv2pGuopJ3Uyp7XO5I1Om6nHiIOES1v0ocqAy+saDFiA6BXv7kQQ1iQ
 orwWiyeK8wpnN6l8t9jhPCbEFDVsVXd+EiVgemK9vyVOTkBkNiLPOKoFnYBrUf+Ncenya
 G+nZ6yI/DQLfKrGGkS5w11ZDkphOxwD3Bak75nHx6xaRCbHBLjUGNo+BUewkTPTNtEg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=T4ueQwiB; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=T4ueQwiB
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FA2B4035D
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:16:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6D326021A;
 Wed, 23 Sep 2026 13:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248C81F00893;
 Wed, 23 Sep 2026 13:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790169371;
 bh=7I0kuy7hqP/YLp608rvSrbB7l+e/YY8bYhe47TYBxyQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T4ueQwiBE1GBpflggTMpj7AVBVNPlvdCLqHQRieLcvdN/zCsF74+X2Hu9kY1h1+cW
 FNfPt6x/0/x9uIkvEv5hgXIPfU4YaA4AiiOTxhcGxFaEQcnaZ0wkSBPKBHcTaw6aLb
 Pujy3d859i0EBTVjJR4K8YNTiu2kR8TCwoGzls0BDHgvjaeCTVocLVv3Hvx0CTRM/k
 OvaGt7GMFikaD12VphyEb1JbQ3EGFHty8wfRB+E6y0t8alMidghVZN8+N9DFGQz14P
 +WCs7Dan6PnaKWcFcqWi8kUEfjhMyrw2wfJfevLYzICAQyCyaRjscCKM8/Vd8HJOba
 rIWpWNu458/qA==
Date: Wed, 23 Sep 2026 13:16:09 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Scott Bambrough <scott@riststar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Johan Jonker <jbx6244@gmail.com>, Siu Ming Tong <smtong@axiado.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 0/4] pci: enable designware pci and phy on spacemit k1
 SoC
Message-ID: <20260923131609-GKD353745@kernel.org>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 12:23 Sun 13 Sep     , Eric Chung wrote:
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> ---
> Changes in v2:
> - dts: Rebase on upstream DTS. So drop the changes in overlay DTS.
> - pci: Find the phy by index instead.
> - maintainer: Add the driver in the Spacemit MAINTAINER entry.
> - Link to v1: https://patch.msgid.link/20260705-pci-v1-0-beca83440a27@riscstar.com
> 
> To: u-boot@lists.u-boot-project.org
> To: u-boot-spacemit@groups.io
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Siu Ming Tong <smtong@axiado.com>
> Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
> Cc: Eric Chung <eric.chung@riscstar.com>
> Cc: Huan Zhou <pericycle.cc@gmail.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Pranav Sanwal <pranav.sanwal@amd.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> Cc: Yixun Lan <dlan@gentoo.org>
> 
> ---
> Eric Chung (4):
>       phy: spacemit: add K1 PCIe/USB3 combo PHY driver
>       pci: spacemit: add DesignWare PCIe host controller driver
>       configs: k1: enable PCIe and NVMe support
>       MAINTAINER: add K1 PCIe driver to Spacemit entry
> 
>  board/spacemit/k1/MAINTAINERS      |   1 +
>  configs/spacemit_k1_defconfig      |  10 +
>  drivers/pci/Kconfig                |   7 +
>  drivers/pci/Makefile               |   1 +
>  drivers/pci/pcie_dw_spacemit.c     | 391 +++++++++++++++++++++++++++++
>  drivers/pci/pcie_dw_spacemit.h     |  78 ++++++
>  drivers/phy/Kconfig                |   1 +
>  drivers/phy/Makefile               |   1 +
>  drivers/phy/spacemit/Kconfig       |  11 +
>  drivers/phy/spacemit/Makefile      |   1 +
>  drivers/phy/spacemit/phy-k1-pcie.c | 492 +++++++++++++++++++++++++++++++++++++
>  11 files changed, 994 insertions(+)
> ---
For the series, tested on Bananapi-f3 board

Reviewed-by: Yixun Lan <dlan@kernel.org>
Tested-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
