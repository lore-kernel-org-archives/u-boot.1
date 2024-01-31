Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71B0C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 17:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A1988799C;
	Wed, 31 Jan 2024 18:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JdmIT8+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AF087B75; Wed, 31 Jan 2024 18:04:38 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF08C8785E
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matthias.bgg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5148461775;
 Wed, 31 Jan 2024 17:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA6CC433C7;
 Wed, 31 Jan 2024 17:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706720675;
 bh=oPtkbDNNmEmspr75L2euCefrDZ9J1VxPFONCS0vZvnc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JdmIT8+dyP+eJFX4jCyPAMbgPMxVBmkrwh4Px4KRL1ILC+vEN43GCzhJpSbGru2Rg
 2DECdwK9j0V8KtC0dh9tqIyyYpnFqHjAQxvJDrp91k7o+l7KOfdCSB13L/6l65CiVI
 mux95M86g27suqq54wr+uVyCTMubCm0//fnr3XWeDOTjM85PpjQr17jEvLpsugSSSC
 WVH27GlVGGZbrJX2w34pxghqt37FJDKrg8UcBYU05zepEfcdhjS3MiQ6ktV4f3ihKa
 EW5/VDVJ9TVVl0/AraGJOzlRn22o+KorBHTjObNYcesBuUP5vYnTaUOnphj/TrrwHv
 arLwbxNAxEqeg==
Date: Wed, 31 Jan 2024 18:04:29 +0100
From: Matthias Brugger <matthias.bgg@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/3] driver: rng: Fix SMCCC TRNG crash
Message-ID: <Zbp9ncssh-Fu9-ef@ziggy.stardust>
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-3-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131141426.34926-3-o451686892@gmail.com>
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

On Wed, Jan 31, 2024 at 02:14:25PM +0000, Weizhao Ouyang wrote:
> Fix a SMCCC TRNG null pointer crash due to a failed smccc feature
> binding.
> 
> Fixes: 53355bb86c25 ("drivers: rng: add smccc trng driver")
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
> v3: add Fixes tag
> ---
>  drivers/rng/smccc_trng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/smccc_trng.c b/drivers/rng/smccc_trng.c
> index 3a4bb33941..3087cb991a 100644
> --- a/drivers/rng/smccc_trng.c
> +++ b/drivers/rng/smccc_trng.c
> @@ -166,7 +166,7 @@ static int smccc_trng_probe(struct udevice *dev)
>  	struct smccc_trng_priv *priv = dev_get_priv(dev);
>  	struct arm_smccc_res res;
>  
> -	if (!(smccc_trng_is_supported(smccc->invoke_fn)))
> +	if (!smccc || !(smccc_trng_is_supported(smccc->invoke_fn)))
>  		return -ENODEV;
>  
>  	/* At least one of 64bit and 32bit interfaces is available */
> -- 
> 2.39.2
