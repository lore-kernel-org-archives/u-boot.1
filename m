Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25754D609C4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 09:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DB9C89731;
	Wed, 27 Nov 2024 10:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gy+pSKFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F2389775; Wed, 27 Nov 2024 10:47:29 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1703D89773
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 10:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3D8A0A41DEB;
 Wed, 27 Nov 2024 09:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECB2C4CECC;
 Wed, 27 Nov 2024 09:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732700845;
 bh=d+X+L0PzlNxX1oIvcJ97sDeVOApKbCAzHgalL3bgAcE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gy+pSKFvcBu5sxZ2qYr1aqBOT0k6ToXseoRtQV7GzHv70A9DyCQFggEbswKa4Jfid
 Xjb17NWguiApZ2651m57g3fCW8lk2z71l+6XuhSumoJTAkYDK8uy/gGJnjXX6Jdhrp
 YVgZGPMgcauBFeCU1dABvOU0zpwwW+LdZWhWzrEnsbNojtkK0pp4DUoF9sSksCeCMr
 jBw6rvxULGDD0v3GcXYfcD+uKR85BQUx2ALKLVDCwtq5ymPtnZ+vQaZColSDcjoTxW
 1qmKOPx212S6CHXK9kpdboVh9wgorkNsF4K69vYC5yY+EToYGiksRibj+Y+Z+t+EE8
 S31yw7REx6OEA==
Date: Wed, 27 Nov 2024 10:47:21 +0100
From: Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>, Stefan Roese <sr@denx.de>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] cmd/rng: fix long help text
Message-ID: <o6h7ajw3qkwkuurllnaqhw3mudjxbqnma6kfgqtx2g7lik6kh2@m2asyz3a55bh>
References: <20241126142026.68680-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126142026.68680-1-heinrich.schuchardt@canonical.com>
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

Acked-by: Marek Behún <kabel@kernel.org>

On Tue, Nov 26, 2024 at 03:20:26PM +0100, Heinrich Schuchardt wrote:
> The number of bytes may only be specified if a device number id provided.
> 
> Correct the formatting.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/rng.c             | 4 ++--
>  doc/usage/cmd/rng.rst | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/cmd/rng.c b/cmd/rng.c
> index 2fb7202303a..4d91094a8ec 100644
> --- a/cmd/rng.c
> +++ b/cmd/rng.c
> @@ -75,6 +75,6 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  U_BOOT_CMD(
>  	rng, 3, 0, do_rng,
>  	"print bytes from the hardware random number generator",
> -	"list         - list all the probed rng devices\n"
> -	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
> +	"list          - list all probed rng devices\n"
> +	"rng [dev [n]] - print n random bytes (max 64) read from dev\n"
>  );
> diff --git a/doc/usage/cmd/rng.rst b/doc/usage/cmd/rng.rst
> index 4a61e33d272..c071f01e841 100644
> --- a/doc/usage/cmd/rng.rst
> +++ b/doc/usage/cmd/rng.rst
> @@ -12,14 +12,14 @@ Synopsis
>  ::
>  
>      rng list
> -    rng [dev] [n]
> +    rng [dev [n]]
>  
>  rng list
>  --------
>  
>  List all the probed rng devices.
>  
> -rng [dev] [n]
> +rng [dev [n]]
>  -------------
>  
>  The *rng* command reads the random number generator(RNG) device and
> -- 
> 2.45.2
> 
