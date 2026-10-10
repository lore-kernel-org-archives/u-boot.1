Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A198CA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 08:45:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 287FB60727;
	Sat, 10 Oct 2026 08:45:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ud6p1eeftfEU; Sat, 10 Oct 2026 08:45:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3EC966066D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791621954;
	b=Rrihss5XOihpMIzkYX3PMR4GbwPtn3Qm+ti7Lx6dP6+xIqT+CuTJBKV0vv7dy0l320jL
	 0i6rRmJ3lniB3B6dwAAjOGJW34yD4n8FphovNIuz+JAQ7sYvax2U2xGHvo1DrrDSKMeff
	 1WZ9SL/n6+U9eAr3wYdna1jXIyaFy+LZlIF17hqKJj7g5hlq6ZHiDy/wjLSIr7Z6ROFRe
	 sRZAs1RCoqjSBPg3Ahnii2ATAA0S+ngKwww/X6xeKnWejwQ5pcGpO0m+hINYLL5+geIZG
	 nLc0/xX6VNK5N6MRSh+YirrNfRQVJl/BPbIg9if2JWVoQhC/LDdO4Rim0FF/SvLN7Xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791621954;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3d/rO+dzhupKcjZBpvjANfva2JRwAsEJ0FFOivDLZkg=;
	b=qqW4iGhYnNNsc++FjWIDCBUkFLHiQIvU1k3sRw1bqry15T2eiaWtWGCWEA4WPikTiR4L
	 CH6bYQvU/0Jyb0zZTs0pjEaOCG+9q7XvU6GWGvKcS3kldWmuHeCIh8/6wnOWQ3EB/jWFw
	 YKKZTRX4H/IeHsDZjtbY0AawjIsn88jkSuaoKJEf7De88735/yq0XFxeRBLGAFdOS80YN
	 uNJUb3S7O/7fQW2ojsUmHGIwog3q8UvmmQDUvMbTtrOwp+lSlfRrjIO827UGE2DLxZyrb
	 fF56fgFEf3lQArKVfqNv0gMXLCNjsjVbSqQrRqUP3fS67n/062N46FT7a0/+NsU2kVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791621954;
	bh=3d/rO+dzhupKcjZBpvjANfva2JRwAsEJ0FFOivDLZkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q0KLusy8ydFuE907zoGNkmPRvrYs2Kip8nYNl7dUbQwgOodiKhjuCV0Hk2Fz+C8zk
	 ywpM+BngB0MYS9exZPVApKJzIPBB2V7VSFQzsDlSkQHiOA0d3TqVd/uuxU/r3JZY2C
	 xaW2OBP/U3O4jHH5MtmLeqf/zAYR4kF05kzIZHrknbooSM6LQaIuP8a4XbfMo2ipD6
	 aW2vJbh02PYJxiMT0Zv6UhiggeYZYfRLETJFeXpvE/ahZGvmcelHpJK4OSDQOXbxl7
	 zXGmlQsBPphCJtTa5lLXA43anxE3CnaE7rtZ6WD1KWCjnuDGCl0xAgOHMNQIaufEnY
	 BdXSCI2TytXeA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EC966066D;
	Sat, 10 Oct 2026 08:45:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCE17111
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:45:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE87381479
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:45:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cPN4YzAzaGwb for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 08:45:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 987EC8146E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791621952;
 b=rL+/9Xtlgh8C6vlg1uo5iVpBVZzH9i2L+lvpNmnpXO1qk/EpYAP96RrQTGtwjkL0sVp4
 jI41zLMGPGwp6gdeqL01w52v4rThpC0Yg1KF15urNruocHwLc5fHxee11EGX9BMP86499
 Yv2N36E4gB29IcL5To6Yf2o1aDohaG0GUbELFEAyzFFnw1LPsN9fHgBbPE7s841kmZawG
 c9FsmBY8vEo8JUOwPMzTBM9fFODymfAISM6uIg9JpgCYlTM/1ubIzWHLpLUuFS43O6Gvi
 oU9M27P+PNU0BUDnUjS/W0j0PvFsTOATP7X5BeYaKmF9hU4y5G36UzuszOmlysCCihQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791621952;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=3d/rO+dzhupKcjZBpvjANfva2JRwAsEJ0FFOivDLZkg=;
 b=JVbKcmgljHX87GF00fHpnawTcqb/DAO9u4V6Fd0jnF0aCRrYc8OV/nOlKFrjQw5l3WAb
 1DoWZpwxtav0fXV6T9zCR+5oF0oQehPreM9vBl5X9bXUKOFKnbS1f+fDrC4EQ8Ydbe5cd
 snm1oz/1b0N9Hd1G0mDbP2d5kcYauXfFoEotRMrPTrZt6e9MPeYsYH77gBEYW3NNAjfMg
 kNv1/JZpq1lDZnkfFwWymuQzmKp/Pf7uaahF+BGNkLKi2pYv1ufvWeCV7Oa2AhB1iaJR6
 9pupAa+21LYamhPbxlQqq4VaYxqq6c11vtqDwzv9QOEGFLwjqbHtqcVWKpYLTotvZqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zhlur4zA; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zhlur4zA
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 987EC8146E
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 08:45:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AB54601F7;
 Sat, 10 Oct 2026 08:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C901F000FF;
 Sat, 10 Oct 2026 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791621948;
 bh=3d/rO+dzhupKcjZBpvjANfva2JRwAsEJ0FFOivDLZkg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zhlur4zAeca6KcBFYIIzLkjaYhdBsqL0nH3uPQvYsdga+ZbhG4/B90i3SCNKw9+5S
 U30V4m7E39J26lWbVUI9HKE/AshHN5b040lO2zMqwTBJnZH03BKOsdzSu4R/XSEjO/
 /YYEsSBXzRaY19XAytsTth/aEah3PKE26NSLf5f7cbSnHzaaI3YNeXPwgKYMY3w0EY
 zffJ9vmTbLwaVnNMSD+YjqfUAu1XcYvbLSqz9c+z2v29iYDRLDl4KsFNVcx5yul10X
 V09OKkxAWKUt7aKTqGYwGTq9+6PMwFCOjAE89iJ0CWtMPHQO+cvCWveb3xNkFHchNv
 V4Ode2vE2wR/A==
Date: Sat, 10 Oct 2026 08:45:45 +0000
From: Yixun Lan <dlan@kernel.org>
To: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 1/3] mmc: k1: handle a missing max-frequency and
 clk_set_rate()'s return value
Message-ID: <20261010084545-GKD26088@kernel.org>
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com>
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

On 17:55 Mon 05 Oct     , Dave Klotz wrote:
> The driver sets the io clock to the max-frequency the device tree gives
> and fails the probe on any non-zero return from clk_set_rate(). Two
> problems follow:
> 
I can understand your problem and what to solve.. but wouldn't it be
a more simpler way to just setting max-frequency?

currently, only two boards are supported in mainline uboot:
  k1-bananapi-f3 k1-musepi-pro
so, you likely also need to add a customized u-boot dtsi file for
supporting OrangePi R2S, something as file below, where setting the
max-frequency property
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi

> - clk_set_rate() returns the new rate on success and a negative error
>   code on failure. The SpacemiT clock driver happens to return 0, but
>   any clock driver that reports the rate makes the probe fail.
Could you elaborate a bit "happens to return 0, ..probe fail" ?

> - A node without max-frequency asks for 0 Hz. On the K1 clock driver
A node with DT property get 0 Hz - that's expected behavior

>   that picks no divider at all and writes whatever the calculation left
>   behind into the io clock's divider field; host->max_clk is then 0,
>   the capabilities register gives no base clock either, and the probe
>   fails in sdhci_setup_cfg().
I occur to me, we should further check these logic, like a rate = 0 input
for clk subsystem - clk_set_rate(, 0) is actually a valid case? also if
need to set host->max_clk ..

> 
> Treat only a negative return as an error. Without max-frequency, leave
> the io clock as an earlier stage set it and run from its current rate.
> 
> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
> 
> Changes in v2:
> - Use ulong and IS_ERR_VALUE() for the clock API return values.
> - Validate clk_get_rate() before narrowing to cfg.f_max and retain the error.
> 
> ---
>  drivers/mmc/spacemit_sdhci.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
> index f5578f38bd..6488ae0fdb 100644
> --- a/drivers/mmc/spacemit_sdhci.c
> +++ b/drivers/mmc/spacemit_sdhci.c
> @@ -606,10 +606,30 @@
>  		goto err_reset;
>  	}
>  
> -	ret = clk_set_rate(&clk, plat->cfg.f_max);
> -	if (ret) {
> -		log_err("Failed to set io clk: %d\n", ret);
> -		goto err_reset;
> +	/*
> +	 * Without max-frequency there is no rate to ask for: leave the io
> +	 * clock as an earlier stage set it and run from its current rate. The
I'm wondering if we could set a sane default max-frequency if no DT property
provided? as we can't always trust previous earlier stage which may in
an undetermined state, it will be fragile and easy to fail..

> +	 * capabilities register gives no base clock on the K1, so it cannot
> +	 * stand in. clk_set_rate() returns the new rate on success, so only a
> +	 * negative value is an error.
> +	 */
> +	if (plat->cfg.f_max) {
> +		ulong rate = clk_set_rate(&clk, plat->cfg.f_max);
> +
> +		if (IS_ERR_VALUE(rate)) {
> +			ret = (int)rate;
> +			log_err("Failed to set io clk: %d\n", ret);
> +			goto err_reset;
> +		}
> +	} else {
> +		ulong rate = clk_get_rate(&clk);
> +
> +		if (IS_ERR_VALUE(rate) || !rate) {
> +			ret = rate ? (int)rate : -EINVAL;
> +			log_err("No max-frequency and no io clk rate\n");
> +			goto err_reset;
> +		}
> +		plat->cfg.f_max = rate;
>  	}
>  
>  	/* Set quirks */
> -- 
> 2.55.0
> 

-- 
Yixun Lan (dlan)
