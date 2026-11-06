Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E15606A328
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mOxdRuoa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6jXYPCX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A226680F9E;
	Fri,  6 Nov 2026 06:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ri3Ij1ozE_EM; Fri,  6 Nov 2026 06:59:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8D4C880F74
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793948362;
	b=FNZv2dU/IoGTU2KSqvzLM2EC+833CSV+lDhBlkXOCP1twx/H4fQz/pXj8nUQHGUcZp11
	 9O0O+fRX8iHuFjW5+sAx0TSGBAZ8qdYvl4T5BIS+JjCLKRxDlWahU4daKbTjBtxuhSPHN
	 e3LEuutXGmmwcca0pSM9L5B99Blg6xec53LYeDWqvG9MkkhR77gMOLYDIM2KZsLaC8qKZ
	 qnnaOeBy73N0p4zquFGaA3q/38XLMo8w3T1x3cqDutKVFPe6c+WEbbYZENBZWk5FatmG1
	 5h/XWS9+IVd1HKIdofMKkjIOod4LwvZrM6iMf1vqRO5te3wsjFc6MTbWaJqzpv7XWGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793948362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=l2XZmQFmWROhIFBB4KDqoHfNhuq4cvlePYM+mtu2h3k=;
	b=L8uKyzsx1HS6DhdHGGPzY5pcyOjk1cH9VfOdrsKasrvlrAtBmvhrKJNsvPOYh78lltPZ
	 jaotjCKhh1zTiXFB7P1L/vvAYO0Z3//kgeW0d2Bisel3D/5+4o5TmsS4eESgk2GwdE2xX
	 nuPuE9Dqj4vlC7fNzsd/6hypaT32etgL9VQjcYm6qMw1rLSpxXSOc2fyAE8+2RgFKqQA7
	 eniyk92+LC/+dG8PxEJAV2Sjfa0qNici46Mr5RgNJ93qOMf9+hP9ch8qkxMwdlhEb6zAY
	 Z3LvyqsVPnqw4xFdeNBh2eLUjFObDr6J5KLh58j5tyoaktiHKhjFpJ81k4IVU2bn9gA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793948362;
	bh=l2XZmQFmWROhIFBB4KDqoHfNhuq4cvlePYM+mtu2h3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mOxdRuoaYOe2km2ximWKHsryoIhnukfqHU5U3PGi/JdjcwvBGMC9C9c2pXYlVTMgr
	 x0ytL+SdVQeMv4gDg2D+fziVbuK5tKCrWZc9RC+ekbi81AKHYO84ntB8341eJkJ/Ma
	 eYG4wy9D4+7i5TKeoiAgDgmdfY5zwu9meNomMoOm5WGIOQHj0+ZUBJaJcnftljGVVa
	 Wmbv0idxl9QhkIExkd4gY5JwGpR899OSE4P61VcJ/Tx3LVsMiljhoS4j6TIuXcDtdI
	 e4PikTjRn5RlYD3e2TnztHuX+lJDDEUTtehMBHafK7km85/bz+4yIg68yVFS/iOJu4
	 PxwT2DvPgebyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D4C880F74;
	Fri,  6 Nov 2026 06:59:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 402A01E3
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31BBA401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:59:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WBGUwyJJfDDr for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:59:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3E41C40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=k6jXYPCX
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3E41C40070
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:59:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 061F840DDF;
 Fri,  6 Nov 2026 06:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D48C1F0089F;
 Fri,  6 Nov 2026 06:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793948358;
 bh=l2XZmQFmWROhIFBB4KDqoHfNhuq4cvlePYM+mtu2h3k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=k6jXYPCXkECiXmkmKcrWpFD6IOLz1n2qTXBCsFGijXD+6n9rRI9klwG5am1xA926n
 Jpnz49D/oJwvfKH8WDwSBbnMdkYWc2hpy9XQCOBf8Mp8EppVHc1ED1OIByXEhzfMJM
 s+vcfMRNoORS27WGRrxeoxATvn1jHHhKls1af7rF7gKc1T1dwOGCyehOj+Uym7eVqx
 YCXMgniU5BWyhY2tQCdxbuTdKi9cbmoFbf5jo8BCErXqfIvgce1v2Wl6R9AFSyVR0M
 tchgfEyeroqErlOYGLf/OEcS7rvcoV9KqzWyHs38MnyfxvaIYMWuOoMDxuI4CcLDIk
 2SY7YwkVjjB5A==
Date: Fri, 6 Nov 2026 06:59:16 +0000
From: Yixun Lan <dlan@kernel.org>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 u-boot-spacemit@groups.io, Tom Rini <trini@konsulko.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 E Shattow <e@freeshell.de>, Huan Zhou <pericycle.cc@gmail.com>,
 Eric Chung <eric.chung@riscstar.com>
Subject: Re: [PATCH 3/5] riscv: dts: spacemit: k3: Add SPL device and image
 descriptions
Message-ID: <20261106065916-GKC249737@kernel.org>
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <20261106-k3-ddr-v1-3-1e60e1d78020@pigmoral.tech>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106-k3-ddr-v1-3-1e60e1d78020@pigmoral.tech>
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

Hi Junhui,

On 00:40 Fri 06 Nov     , Junhui Liu wrote:
> Add the DDR controller node and mark the UART, I2C EEPROM and required
> clock and reset providers for use before DRAM initialization.
> 
> Add a binman description for spl/u-boot-spl-mkimage.bin, combining SPL
> with the external LPDDR5 PMU IMEM firmware and wrapping the payload in
> a SpacemiT K3 boot image header.
> 
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
> ---
>  arch/riscv/dts/spacemit-k3-binman.dtsi | 24 +++++++++++++++
>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 54 ++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+)
> 
..
> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> index 352e85e7de8..0976b2647b5 100644
> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> @@ -4,3 +4,57 @@
>   */
>  
>  #include "spacemit-k3-binman.dtsi"
> +
> +&{/soc} {
> +	ddrc@cb000000 {
> +		compatible = "spacemit,k3-ddrc";
> +		reg = <0x0 0xcb000000 0x0 0x01000000>,
> +		      <0x0 0xcc000000 0x0 0x01000000>;
> +		spacemit,apmu = <&syscon_apmu 0x4e8>;
> +		bootph-pre-ram;
> +	};
> +};
> +
I'm not sure if it's a good idea to also move "ddrc" to mainline kernel
dts, at least to reach a consensus about stable compatible name..

> +&i2c2 {
> +	bootph-pre-ram;
> +
> +	eeprom@50 {
> +		bootph-pre-ram;
> +	};
> +};
> +
For adding all "bootph-pre-ram" properties, I'd like to see patch 
submission to mainline kernel tree, see similar thread for K1 SoC[1]
so eventually it will get synced to a proper directory under dts/upstream/..

But, I know it would take long time for the upstream dts hit into U-Boot
tree, so a compromised solution is that we temporarily accept this patch
before the sync, then fix it up later accordingly..

Link: https://lore.kernel.org/r/20261024092558.143621-1-alan.tseng.cs@gmail.com [1]

-- 
Yixun Lan (dlan)
