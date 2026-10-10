Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28D6CA9EBE
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 07:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75D9D813E7;
	Sat, 10 Oct 2026 07:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOhe7XPpXvq5; Sat, 10 Oct 2026 07:14:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8393A813B7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791616469;
	b=eJCq1pylMWuIPggh++x97Dq7tPUiOrvmNSZa2AWxr/9qq1032QmAThKcwpkVM3oIEjpL
	 uJzAQGKDCmMw3LtFhpSO8cdLHXMOhwGXAowIPxWxkxtqYCdQ4gofQYGQnFYNQLftGFcTG
	 e/xHi6aPMtMzDkI3lInM9hng16Rb1T2+wttQbWejDBc3+7D+EH8CtbX6YXFih2BkBIB9X
	 EVw8VfJhTXBK25UHuTpZ1xZIcNJ0k+diigZPQHFssyZu9hLruUw8gHikWwedO7/97kRym
	 /Uy841kX38g5EkO88sbF+jqlwxmzj0sJysJwcBho9CfisPu146rqMnMzOD/j1zJp1nQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791616469;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DKZedarbFGaG7CbaDsHrzUbGdXiKFEYtuRVV2iQCW90=;
	b=VtFhsUiDhEjCipfKPfHLLp94U5JA2SYtYcWD+KTuZwFHZoYYbLLfXj1eiQQwYqecdUxh
	 KLIDhRW+nR/GTtyk0qlOOUE3vNVtT+Ti6k3q6JCne1HX9uIQ5EAdrVunKQeNAYY3y73b5
	 NMvcMsTwJi5pKeBd8nNwy7WQ51XNYh2tJpIGdlboSqCE5CC8kwCJ8eHmIhOY+AhSihrup
	 veOBg40WmMsdY2RCINe6o5NnyumguJfkY4/iW1icsmsEx6VEGZKAk22AGQlWu8Knk2HBX
	 1/pQhUw2dFobCrq26Lng8AHLbloJ/wMKmKoKaYFwd4/s2xoeJK6jlKnOme5XCvxZ9Rg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791616469;
	bh=DKZedarbFGaG7CbaDsHrzUbGdXiKFEYtuRVV2iQCW90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TO1UEpbFVbd+oua9Y0+D5KXdVG8gbnfbFA8x+Ya4iJo97nSHGGqqKekVMiJOZxMLN
	 VMhElHVU78hmBDo1AHlsO4T7qOEBHBeo5FqqxlbKcGUm5OHq9E8KXSaimOuUmynrsu
	 6GP6aVu8zJNJ8f0i6gpvCGBO3LO6l+Yh7oWwKL2pmcXNY0KUGWoOLMje8KUSu9akPn
	 Hiuo702kD3dVrUd1334AyDP4+4qA3VfPQ683mAgXdE9FqqJjP6mhZKeQyjJY5QdCjH
	 I3DNQlSKrL7d0UtImks5knthlUivhkdKZDu3nX2fdpoUjRZdyrj5Sj0W1YfJVrvE9o
	 B+U4NA2PhG2aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8393A813B7;
	Sat, 10 Oct 2026 07:14:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D9CE975
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:14:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D7022400CC
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:14:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h2gjOyRU9Tcc for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 07:14:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 00E5040068
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791616467;
 b=EZXqFsfUR32YMv6+I12HvWLIYFLqvx2Q41mKrVp3M2mYOmOri/huBA0xHzDx4puPFvkz
 su/zn4Kavb65/ee+Hz72KzLhbE7yNn7vIryZ3Rlw4aO8M/y57Gq2gg7VN7JjC2XZRt2lN
 OI7n/ehb+WMAOwstNGjJDNTIxlLDxeLv7xbvEeIGikbwzB60y+5peK+ntV5xGefbWXsNl
 VPmJnbyddpheSrD2iDlbGcmkh70bHq88xjI5ei6Lt82KcDDMhx5r5Vfwgat9l87Av5S67
 Qkbdp0A4k45HMlGZ9Nd0SFBb2fxp1dnYdx1Tq8E+oBUMSxEIj8oPqZmyDv6qanaCKUw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791616467;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=DKZedarbFGaG7CbaDsHrzUbGdXiKFEYtuRVV2iQCW90=;
 b=gDPjgjDSBVCD6VM3xMPalKR3/nr3Sdd65gMwv0BtB4QRQ63aQUqbWZze1EKHXuydanrG
 Q+64mJosEH9HcyYO0BM5RNTJfk3HQac1ef4It8lVVL4Qb6z7+rjyO1QoO/zNhla6aq3hi
 CMXIU4mjOYBk4HOF78+gED34hxhrrsl+yo9u+LJJAA2RYL60CAQmvTjIMvhvPlVRXf9ac
 EQ1jV6ZnuDy7F+LTNFbKXo/RQ6u1CGx8VbI4yRjGnoXvEB3EefFqCDEkiSecwqRRmUrLI
 5E/nzA8Dgd7B24kcsMYuYX6vribB+AFhEox8x9GJDCU8r52CCuT4XnOw9WpoBH7u3Bw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hsqnYc5u; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hsqnYc5u
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 00E5040068
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 07:14:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CC6D0405D3;
 Sat, 10 Oct 2026 07:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB001F000FF;
 Sat, 10 Oct 2026 07:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791616465;
 bh=DKZedarbFGaG7CbaDsHrzUbGdXiKFEYtuRVV2iQCW90=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hsqnYc5uoTee7u40X9NpkamukJ3hlsC8aXQ2xKl7F9TyXxqGaEymeDmyRj4twbTP6
 g4nZrzBpnd8zgjrGbLh3BxhVjwORDWfHujxXUBUEafFtWiPIPrL4V6pUMxW+ukjj4U
 mGtw0ijXVWGhFbPva3/LWwqdTuHlumgRq2hKuxPlI+2IOE0Czbo3v/a6CLk+rLJQ0N
 imkFkm+mh+UskIGi34be04Dgl8844PlpExPdcXb8V/oFMMiUdJPvtcQMfckUDDcg2I
 9TT861IeJgM9Ju2PVUBLVhyr1lTzFdjiFWRpglaLTxwchNsnXxWVuAD75HcTSjZPKH
 psUvY7Zmo6+gw==
Date: Sat, 10 Oct 2026 07:14:23 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 3/3] mmc: k1: do not release the shared AXI clock and
 reset on probe failure
Message-ID: <20261010071423-GKC26088@kernel.org>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T140306-0400.mmc-v2-0003.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005T140306-0400.mmc-v2-0003.DaveWK225@protonmail.com>
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

Hi Dave,

On 18:11 Mon 05 Oct     , Dave Klotz wrote:
> When the probe fails, the driver releases its clock and reset bulks.
> clk_release_bulk() disables every clock and reset_release_bulk()
> asserts every reset, and the first entry of each is the SDH AXI bus
> clock and reset, which all three SDHCI controllers of the K1 share.
> 
> One controller failing to probe therefore stops the bus of the others,
> and the next register access to any of them hangs the hart. On an
> OrangePi RV2, whose device tree enables the eMMC controller without a
> max-frequency, the eMMC probe failed in sdhci_setup_cfg() and U-Boot
> then hung at "MMC:" probing the microSD controller.
> 
> Keep the clocks running and the resets deasserted on failure.
> 
For the clock part:

This doesn't make sense to me, but I've not put my hands on board to 
test and actually replicate the case myself..

It occur to me the clk driver should take care of the consumers and
only disable the clock once 'enable_count' drop to zero, see

https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/blob/main/drivers/clk/clk-uclass.c?ref_type=heads#L744


For the reset part:
As I checked the code, it seems exactly match what you described here,
where there is no enable count tracking mechanism, so release() will
trigger an assert() operation in hardware layer

so, would this issue only relate to reset?

> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
> Validation: executable diff unchanged from v1; exact-base replay and
> checkpatch pass. Combined-firmware warm-boot results are in the cover;
> probe-failure paths have not been retested on hardware.
> 
>  drivers/mmc/spacemit_sdhci.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index 4284553177..88e06a681c 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -642,10 +642,14 @@
>  	spacemit_sdhci_phy_init(dev, host);
>  	return 0;
>  
> +	/*
> +	 * Leave the clocks and resets alone on failure. The "core" clock and
> +	 * the "axi" reset are the AXI clock and reset that every SDHCI
> +	 * controller of the K1 shares: releasing them would gate the bus of
> +	 * the other controllers, and the next access to one of them hangs.
> +	 */
>  err_reset:
> -	reset_release_bulk(&plat->resets);
>  err_clk:
> -	clk_release_bulk(&plat->clks);
>  	return ret;
>  }
>  
> -- 
> 2.55.0
> 

-- 
Yixun Lan (dlan)
