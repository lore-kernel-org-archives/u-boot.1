Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99535C98302
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 13:31:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 269F340760;
	Wed, 23 Sep 2026 13:31:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HRl4VZswxxCv; Wed, 23 Sep 2026 13:31:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6DB7A4075D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790170265;
	b=GwKJrxHWVq0f8Sq2gUYFEQAPgMpwsG47yBsostUpqNIjxBGR97UHBoWvilZDcAhZbJtd
	 WsjvqZDja1pdf03M8wqFPrQWFss1BvfjA8kEs/7x2sHEQ+uIHtIgyFR67XynjncGqKFMk
	 HAS4q2E7pwQ0ytXnZE9WSm0WgAGRlvFYR2x2nf/eEaVH9CcNZY+m9dvVrJxQ6g9zGqxrE
	 Odo5XldHxHS8F4kWWQfpuaV/oMz4i/E3g24Bz71kIKvBLJ2XQsW15S3YkH1PAQ9CBqzcd
	 4N95b0JYla/oWNsa7mhefBiCLcc1AxwjtvfbS4M44IWEkzOXLqYy0A9rhTc9m70eYTA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790170265;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ux0Yjr8zT9kwpw6IHjxXXhQDNlypdShbloFdsvxHPas=;
	b=cFZ2wUtskbzpoVTKdtJZCgr+gkRmEKLrYBbDNIe5XMlwWnDmtf7H3U6Ai42KHTpApS/Q
	 Lj+uR8KNF+Haluz0jExRhjUqzic/qE2HTIt9JkN6aQa69XZjd9KQ7Vj4zTirb8NsgGEIM
	 ANV8uapOnbJpTzWDN7G8lzRToR/7uf8SDXV4WULxOlmBab/MY0MEW7XCnAQfirgVxibkc
	 H/lfZQAlsF1PxHXLhWa1AftfcN1OAqGv9qzRFPSG9+wJbsP6ldWNiSHhYe+XlONBg3Nsz
	 2/6E1HKwTDc9ihXKLEuyj/LvzS/ktfufL4BXtfWiK+IbvFBafIRxGDHYEBp8kePY0Lg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hEDgw366;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790170265;
	bh=ux0Yjr8zT9kwpw6IHjxXXhQDNlypdShbloFdsvxHPas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kG12RKisHo/Mjdg/QQVroGP32VooHmkNakgKgNCet/WCAHNjRNrmevviOLWSVGyCw
	 l1tqNvAn/JTVYrlKM2YGi+P9pbYp2ZzsVJuSPmpPZWFoeghasMQA88BryDrWkx9DIF
	 EdWRKHJoH3n4MHKmmh7jbNA3AJ0E6Ct+amAU9D4nKuO8zAlzWjLgPXsoRk9TlUkeOR
	 i0nXFtxtUI0pnPRhJBb4YfKsNYFh6UU7gPkX6XEEzbbs/areku/vXZIiK0iAD5BY2i
	 4UdCa6DWhn3hcfedez6MBWzhR0HTE7rZvPdv8lnsGfxSwCZF/YcX3Js625j8ES1R3V
	 wNLsh0exg9rlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DB7A4075D;
	Wed, 23 Sep 2026 13:31:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 009EC498
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E2B2F40758
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ySBF5HjH1cyn for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 13:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 540D640740
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790170263;
 b=kTwpIxvKeeLmNtzT/fovyjjlUQu3NMk14K9zb2nSrGkeENNmTeCcZO4o2c42+BAlznCm
 AqFBOtDfwEgSEuxRbOZ3UUiqhm0JPn0CDff482YiRQT1Fck3Wi74r2F48LtMTyjt4Uqka
 LL1D8xl6oIBQUsMi81IgI08Qwk6z3KEr0NoPnTN+URYGc/JBffZvf+8IefVtRqgDXPLXU
 8OhAcNDK5kc9mEYV8Z4POQ/PPF8AQ/0R7CzCBdEW3BSqs9e983OdHhmY4gnYWU8Nk55w8
 DgNS/PqlnBLz+flWyYXKivjP91rVkLaQYJhNEVZncf1OpTFLDf2G93ySAgjZaMEsmrw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790170263;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ux0Yjr8zT9kwpw6IHjxXXhQDNlypdShbloFdsvxHPas=;
 b=L6MD6gP3YTUYhuJTaAMTO3fHTroEKXuHWVHDUgkTtYNmZ92ZQ71A/bc55lP2ZmKcLnK8
 Cbbu5Rgvr1v3PtLSjdgPfzatHqBT4/Sv0v0J+Y0XF6MTHG4s4OCW7fpCOL7KBTbKEdgFf
 Eh9/DKicr46CEwz9uyipjpAPqvqcKPdwu05tR2GbNHDpYeytU0LjmvwH7r2DVSqL94q9B
 idWvTwWl3QVAjzCqZaSGEOlngvYHH2a4X0ggx0uxVaMrL8iNS1IB/OUiMdHf5mZCx5Yer
 He+nVWnzrWFPbAs3H6qBrBlok9A7DvTHQ4qjKqcLBMJ7osIodL2kl6Gl+kjFrWSdB/w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hEDgw366; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hEDgw366
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 540D640740
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 13:31:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5AEF340AA4;
 Wed, 23 Sep 2026 13:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE01F00893;
 Wed, 23 Sep 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790170262;
 bh=ux0Yjr8zT9kwpw6IHjxXXhQDNlypdShbloFdsvxHPas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hEDgw366s9kjRNRIaKlvuFnTKOaNjBjDZDXmXAJW6jIK+P0W9Pr8xwR4qUi6kFSTF
 CpGEZaQwuXqHZdMzOB2o6CnPI3Ly9Hsxksc+/DuatMyO7T3dOmrvR9ftkdxwdesGPO
 REjPgCHAV3mhI26yPloazBHqVrkFe9Fr9yycBX+V9ZwVPgEuxxX3yTV5oJI26twgP/
 bpW4sYjcCaKLVEeuT1uQHlh34TlKubvh9UBiz8MG7Tvz5LOb95rGWrXi+BUw13hsUY
 8Xz/2WosNb2wawHk2usIwNedZugFiWUo/+PzN1YrZfh+mAi1+1mWKoDpUpEGPIDkOp
 M698Wa5zwPY4A==
Date: Wed, 23 Sep 2026 13:30:58 +0000
From: Yixun Lan <dlan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Scott Bambrough <scott@riststar.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Johan Jonker <jbx6244@gmail.com>, Siu Ming Tong <smtong@axiado.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Pranav Sanwal <pranav.sanwal@amd.com>,
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 2/4] pci: spacemit: add DesignWare PCIe host
 controller driver
Message-ID: <20260923133058-GKF353745@kernel.org>
References: <20260913-pci-v2-0-4fa1a8b5de06@riscstar.com>
 <20260913-pci-v2-2-4fa1a8b5de06@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913-pci-v2-2-4fa1a8b5de06@riscstar.com>
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

Hi Neil,

On 12:23 Sun 13 Sep     , Eric Chung wrote:
> Add PCIe host controller driver for Spacemit K1 SoC using the
> Synopsys DesignWare PCIe core. Supports up to 3 ports.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> ---
> v2:
> - Locate the phy by index instead.
> ---
>  drivers/pci/Kconfig            |   7 +
>  drivers/pci/Makefile           |   1 +
>  drivers/pci/pcie_dw_spacemit.c | 391 +++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie_dw_spacemit.h |  78 ++++++++
>  4 files changed, 477 insertions(+)
> 

Would you like to merge this patch via pci tree? otherwise, I could take all
of this series via spacemit custodian tree, let me know which way you'd prefer?

Thanks

-- 
Yixun Lan (dlan)
