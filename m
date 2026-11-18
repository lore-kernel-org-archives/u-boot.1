Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60868606A32C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 07:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vMkTiE6m;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jrH4d9xr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34B6440853;
	Wed, 18 Nov 2026 07:32:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r3B4f00g3VHZ; Wed, 18 Nov 2026 07:32:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3566D40848
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794987130;
	b=H855Ng2a3a5XppSg9Fmwzmp7zdLizrzAdFY4TjPXqVuiWrSIq6Iu5L5GWowH7pBjYVEg
	 ckguuueJ2Me5u63tZ4RRD16XWOHWnXb+lPdAvXe53AP27ezdQyL2GKUgLgWEqFS+8n27h
	 hRkk1yDqlkDRw1WsnyCKVCGztopSY/GqxfxhK8qZBJK9Gmvg/vsVU65MJuEdF4RlHcrDO
	 8CwxAdfBw49FjkrbIj+AOby5BdyD2ERXAakewcA3cOsu2d8/3dz8OZqjQPVuc8CWSge9v
	 DE5LNeLVRxS55Jb7ZUIsF09f36SSV/8ekU05cVB7kyf5q4Fi1UFTpJ268k7P4BLEsgg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794987130;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=pa5ahd62sZdjP7VWuTdJbTmhSHpeLU5tXVv66AuAAQE=;
	b=SW1hHufN8B9hk+n3zpih4gbK55qKlwZOtAD+3hTsQPHf6WkNAcqNEHmrXzB4LgM+rnbJ
	 i5EU7/R0bFIVT4CVU3cNS2zzJZn7JbsZPaEOpxzkNvyUxRgEXLyDvUvXwRSLwZv8a5Bsd
	 gglgaoa+pFw9N2Zkgrr+NDmQ8A3ZEdSU8rN4F4ptkZE0G/FUeBZytBo7W6Aelgic/I89x
	 GlC2233NEGWcStxk86pnAgFfrrgQAthzmRHg3pqSI3dv5pvhIUKdWXpMU7ypNzjUfccp7
	 sCVKoAafkkw9iPD5AQ9lh/AKEbnN/9MrYCvzT5X3cFVG3IJIu02HxXyOngyUdpi0C0Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794987130;
	bh=pa5ahd62sZdjP7VWuTdJbTmhSHpeLU5tXVv66AuAAQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vMkTiE6m0DTXbI3Fh+KMTruIjYpGO+qKby6P/UevDHNLzZb/J1k1zGPC/70B+bq5V
	 yCPyEGromiBhZBf8Njr+b9Y/ATJQvIyexmjrxtsOD9ZjUAOpWhgvkRuMFc8K2DVckC
	 aUhu3+PMn8OBoQLWBk379sQkpg6CbMvIGABh/F7+ey7IaXXlWEWvPjDMjX1Bb4umX4
	 KytzxOQA7nmQmyC3bFE46FajzY2Qw8rAL4tpkrcdizzRux/5YX5qRFZKxvK+fWxbnm
	 VtOrK4ShGwc8XbTCuTg5eYM8ru8Q60gP0UU3teVpvI55bV4CV2mzUshb0jTrstw6vT
	 DtTrk89kvMwLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3566D40848;
	Wed, 18 Nov 2026 07:32:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4E7DD9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:32:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 401C181091
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:32:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdhqgz0Fqu8b for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 07:32:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 399868107F
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jrH4d9xr
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 399868107F
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 07:32:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 595CC6186E;
 Wed, 18 Nov 2026 07:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E30A1F000C4;
 Wed, 18 Nov 2026 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794987126;
 bh=pa5ahd62sZdjP7VWuTdJbTmhSHpeLU5tXVv66AuAAQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jrH4d9xrg8UXX8HcQrZS2SftQKvfbQCZStMAlXxG/enZX6MiRwHuVARHzNJpNpNT5
 oG8j7nQAC09milq0xmj8ZDP2198J3/82032JjwXDiXiRUbQ0stgnVT6gwhtdVbHOBL
 68ZSIP9Nxu57QMIPJQNSnzACeuA+S9tTGYLoZulv3bwZCceoSIMjVyVxb5cB7PXV8g
 kXeqaEww9ZYCrXS8I11QMb48cBefIcvPPQSvxmtbOCMspmxYaEP3VoccmBX9Lp+orS
 bQl7sIklsgjful9pzrhq1KgGiLxHQCggNJTF5tB3sD53Vvz6IP1+EJJkWB+wmeSZm9
 +p3RUGStaLqbA==
Date: Wed, 18 Nov 2026 07:32:03 +0000
From: Yixun Lan <dlan@kernel.org>
To: E Shattow <e@freeshell.de>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v3 0/4] Spacemit K3 enable Linux boot
Message-ID: <20261118073203-GKC156369@kernel.org>
References: <20261116102653.36927-1-e@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261116102653.36927-1-e@freeshell.de>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 02:26 Mon 16 Nov     , E Shattow wrote:
> Adopt some fixes needed for Linux v7.2.10+ boot and enable
> BOOTSTD_FULL together with minimal env addr variable defaults.
> 
> Build and test only with vendor BSP k3-br-v1.0.10 having reduced [1]
> configuration to avoid a memory resource conflict. The vendor BSP SPL
> in its default configuration attempts to load opensbi separately from
> u-boot main app, and also attempts to load an embedded controller OS
> image, neither of which is useful for mainline opensbi, mainline
> Linux, and mainline U-Boot.
> 
> Changes since v2:
> - Add patch 4/4 which adopts a proposed Linux series [2] to reduce the
>   initial memory configuration to 8GiB for CoM260 and Pico-ITX boards
> 
> 1: https://lore.kernel.org/u-boot/20261029003327.1890979-1-e@freeshell.de/
> 2: https://lore.kernel.org/linux-riscv/20261115195112.32120-1-e@freeshell.de/
> 
> E Shattow (3):
>   riscv: dts: spacemit: k3: override reserved status of mimsic and
>     maplic
>   configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
>   riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb memory override
> 
> Junhui Liu (1):
>   riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC
> 
>  arch/riscv/dts/k3-com260-ifx-u-boot.dtsi | 9 +++++++++
>  arch/riscv/dts/k3-pico-itx-u-boot.dtsi   | 9 +++++++++
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi   | 4 ++++
>  configs/spacemit_k3_defconfig            | 9 +--------
>  dts/upstream/src/riscv/spacemit/k3.dtsi  | 2 --
>  include/configs/spacemit-k3.h            | 6 ++++++
>  6 files changed, 29 insertions(+), 10 deletions(-)
>  create mode 100644 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi
>  create mode 100644 arch/riscv/dts/k3-pico-itx-u-boot.dtsi
> 
For the series, 

Reviewed-by: Yixun Lan <dlan@kernel.org>

-- 
Yixun Lan (dlan)
