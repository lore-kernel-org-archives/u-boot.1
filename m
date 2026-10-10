Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04512CA6004
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 04:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BCF3812F1;
	Sat, 10 Oct 2026 04:59:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7ORC5_zdglI; Sat, 10 Oct 2026 04:59:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E7D5A81316
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791608342;
	b=OpjuFBgP5MMGH4tiLzrAX9V91K2UfpzaqgvHmsnLF+0ROb8mYJTylcqXg3+vWpaJHdju
	 hqhPyR1zTW77+P5AxRB6AejmLiLrp5uHyG9RpbxABuTzohUV9M1vIgjqbSTcw+xYvYwF/
	 4pSMVogdwCehy+8WicX9/U5YXCFqSh3eWKWvi1sf5HLdyhVOfPW2ewhVbsaaGf6v1n+FR
	 AJs/D2eLLLNT/HOyTBnieyTuvt1cHfxeyBCAlH124nhDXPovH+x4885u7ctcUdi6wNwgw
	 ZqDU809TpCsCLS8hoDMcGbb+Wp/j4jDfBYBw5hBdW1ZM5yj76gOI13S81r6x5KPWXbw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791608342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EE1JUetpq23aHMZSKlVYgpuHEzoOvHVP/HAyuYImwk8=;
	b=id7TnyLw1p6XVJryUOIX0olR69KPx3qbT5WzoBCLzTTe/DYWClql6hFVzR6COMLwAtI9
	 bull9xxZYj9nitANNxph8PNMHppeN7LDa5zfNs1gJeHrYhI5cRxWOgEfccOfhv4Bhc7gk
	 qvo0cobI1X4O3knDR5NR+kSNlL9XhA99N3JFPT+A10BdSLqtI4LGBrC7CjcfRlQviFtVl
	 avJtU9Q/acu8AuWS1K2zLAOOuNbWDlVCyUxv0yGVqiyOD++iCVi3vZqlgoaGk1PMEb84q
	 JB9ti1xcw2qa80SIIuzkvy1GEYBq0HeyZUBoPaHBIT1eoNcgWKwNX28qUsknWS27Kxg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791608342;
	bh=EE1JUetpq23aHMZSKlVYgpuHEzoOvHVP/HAyuYImwk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fHJzZ7hMGpyIRacLnoJkJoxhVsmPhvP0ZpQ89h/DkUWK1Y5UsXSipN/FgKNFVHjgv
	 1GU4G20fMZEMk3w0vwXKa+F3129Z+9EPTeIsVs7TQxj7bhb7EtSRI18DNSQKgr0beE
	 uBSTzfD53rNneNXdl2PN0HdWvQA6r13vsz8pu/SQ2WE09BDP/DxkUiI9FXPMIw/L1Z
	 /7nKCVcvzo11tgOINImhjK7aP4TkyTesP2MYFDrLs76sfU0i3Dv863v0oDCNfaUWqu
	 uzs3EBONVVg4PkyASbEfM407V3NRCdB3gyKl9s2i1mYxBbMntlgzCwXewWRbspUAax
	 MS9aXs32Ms6fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7D5A81316;
	Sat, 10 Oct 2026 04:59:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 83A4E356
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BDF74081B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s5Dgmf-ZV0W3 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 04:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 621DB40818
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791608336;
 b=MLh+7r1I6ZgKSpRg/PXuzPEiA5AJPgLxeLACUT7pDmxxlPy8wHErX2I4MSmMIyZj+ipX
 qomhtSVCQylf1XKyJKiOvb/6oSBGIzId6yLclmnZcwfERUzY5mpaS3PivYZ0m0maER8Rh
 ecJ5t8PSY6gXkkcCbj4OVx2LyjQIvnnz9OIqzhV78LTi4GmFT5mfovCr+D+9G7M5l4Jbn
 zQqS3f+elNxPJfoyoCN8fabvBUn4Al6vvuoPctX4banqhX/DLRFD694wqM+itd9pD5e4Z
 LD5rkvdb05Z21uAPazNzvoPdHHsTbJ3AO5aFdFqAejx5itv+3Rab29GGOfVVXb4vlGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791608336;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=EE1JUetpq23aHMZSKlVYgpuHEzoOvHVP/HAyuYImwk8=;
 b=Z9D2qEmnYaJeyvgQ6x/bkSMBi7TStD74Zsop07PGMynHPM101E6tT3LQzMcTUOtjdc+n
 NZ+8W/Dr9Zkb/ozzZnYosRsylrhicpW/4T7SACnk85P4ootL5XorMJ3hyLpOCcN3eUzW3
 7swmNvKEI+g4ZOr+aAh+kYFXHQiYUM977Y4qFWuD83hz7irtx2SJpOgTacdS7aRcrjlcP
 mcdRmyI0DLA2EaqRiHttZa9DkAewt142V6dVvY2rFwWqcnSAcaP7m/P2FnO1xQwTU7jkJ
 X5wjQIDlb7UwsHrsamGxTflByEk7FP5ZU6F/Q5cNNTwQ74UwjRP6eFS+wzqAWcFh5cw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BQFoH+hJ; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=BQFoH+hJ
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 621DB40818
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:58:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C273760211;
 Sat, 10 Oct 2026 04:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA15B1F00898;
 Sat, 10 Oct 2026 04:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791608332;
 bh=EE1JUetpq23aHMZSKlVYgpuHEzoOvHVP/HAyuYImwk8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BQFoH+hJKdSEFyYvqO2k6+VL8JZGd3p58DZccXYTaS4FzuWXMDJ+NH9emkg6FXKAw
 896tueMEYw4k4in/CwicvH8A+TZhMKTHEi7drRvjl18ngPvex4++BkU/+X0Zqal1OO
 Crdx1v3qCmlxydUB1JhGRmqom4HOJuDeaYgTtB443fa6TgkVl6Q7xgkmPOSsIxGNng
 +oMRjWKLGhHzO2wRCpbAQMyd/P+UkTYJ6F6XY2si3UV8r9Yl8N0l9DgAfcs9Y7q/Z1
 eWyVA4nLQ30ivXCpmLxI+qsHEyAx2Sf0X/pLuu6qj7cgaX2oHAT6KOxZyWs0KCBtyh
 FU2gahGLlKA6g==
Date: Sat, 10 Oct 2026 04:58:47 +0000
From: Yixun Lan <dlan@kernel.org>
To: Zixian Zeng <sycamoremoon376@gmail.com>
Cc: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong.xu@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 David Lechner <dlechner@baylibre.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Eric Chung <eric.chung@riscstar.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Guodong Xu <guodong@riscstar.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: spacemit: add K1 Ethernet driver
Message-ID: <20261010045847-GKB26088@kernel.org>
References: <20261002-b4-k1-emac-v1-0-e1b6806b018a@gmail.com>
 <20261002-b4-k1-emac-v1-3-d9be2ff07c9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002-b4-k1-emac-v1-3-d9be2ff07c9f@gmail.com>
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

Hi Zixian,

On 12:46 Fri 02 Oct     , Zixian Zeng wrote:
> Add the SpacemiT K1 Ethernet driver to the maintained files.
> 
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
>  board/spacemit/k1/MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
> index c1d6b8f3a1c..a9af13ab0a9 100644
> --- a/board/spacemit/k1/MAINTAINERS
> +++ b/board/spacemit/k1/MAINTAINERS
> @@ -10,6 +10,7 @@ F:	doc/board/spacemit/
>  F:	drivers/gpio/spacemit_gpio.c
>  F:	drivers/i2c/k1_i2c.c
>  F:	drivers/mmc/spacemit_sdhci.c
> +F:	drivers/net/spacemit/
Let's not bother adding it explicitly, since the top MAINTAINERS
already cover the keyword 'spacemit'[1], so should fallback it well

But, don't treat this as a hard policy, if there is file that k1 specific
and want to highlight it, then please add as you prefer..

[1] bdc04bcabfd8 ("MAINTAINERS: add new SpacemiT custodians")

>  F:	drivers/pci/pcie_dw_spacemit.c
>  F:	drivers/pinctrl/spacemit/
>  F:	drivers/power/pmic/pmic_spacemit_p1.c
> 
> -- 
> 2.56.0
> 

-- 
Yixun Lan (dlan)
