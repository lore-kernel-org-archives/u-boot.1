Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66117C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 17:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E52E587A80;
	Wed, 31 Jan 2024 18:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="q0hvaKgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF4887BE5; Wed, 31 Jan 2024 18:06:33 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 527D98799C
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:06:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matthias.bgg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C1E386140C;
 Wed, 31 Jan 2024 17:06:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E47C433C7;
 Wed, 31 Jan 2024 17:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706720789;
 bh=PPpgG/mhURkY/r8Fsm6MzC3Rv8lY6TJuISJXSYYHvlA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q0hvaKgdXwrtD7zuoWmyqCVJXSxpDCvnv8FgYLSVAzjejI96iP+y90ZgAW8+EeDu0
 +R9LAes4DVkaK7J3+wHYzEcfi1XvLmQTpjRW8GVV0RhzhP3inTNNibbDZuXztYv0wi
 XlRzZ/bFm18uTJhleNA3ekV2qWa19scFKtXJJmjsoHqew3vHV7Sl8BJ5CXvcrvftSx
 t2pN0yQgTGHIgg54krxp6uHFtCVMGncuCq7KMPA1iexxNWmetpxSAS2JbjycARHw7G
 zjXdspBsF5KDqhlgwlkG6VTrk4OjCd+6EWnXZ00lMhIcOAZ7O1fqqyXbC/mYBcAgtv
 1l+vhPEMTTYDw==
Date: Wed, 31 Jan 2024 18:06:24 +0100
From: Matthias Brugger <matthias.bgg@kernel.org>
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 3/3] cmd: rng: Add rng list command
Message-ID: <Zbp-EOfK_sQxblT_@ziggy.stardust>
References: <20240131141426.34926-1-o451686892@gmail.com>
 <20240131141426.34926-4-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240131141426.34926-4-o451686892@gmail.com>
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

On Wed, Jan 31, 2024 at 02:14:26PM +0000, Weizhao Ouyang wrote:
> The 'rng list' command probes all RNG devices and list those devices
> that are successfully probed. Also update the help info.
> 
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  cmd/rng.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/rng.c b/cmd/rng.c
> index 52f722c7af..b073a6c849 100644
> --- a/cmd/rng.c
> +++ b/cmd/rng.c
> @@ -19,6 +19,22 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	struct udevice *dev;
>  	int ret = CMD_RET_SUCCESS;
>  
> +	if (argc == 2 && !strcmp(argv[1], "list")) {
> +		int idx = 0;
> +
> +		uclass_foreach_dev_probe(UCLASS_RNG, dev) {
> +			idx++;
> +			printf("RNG #%d - %s\n", dev->seq_, dev->name);
> +		}
> +
> +		if (!idx) {
> +			log_err("No RNG device\n");
> +			return CMD_RET_FAILURE;
> +		}
> +
> +		return CMD_RET_SUCCESS;
> +	}
> +
>  	switch (argc) {
>  	case 1:
>  		devnum = 0;
> @@ -56,12 +72,9 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>  	return ret;
>  }
>  
> -U_BOOT_LONGHELP(rng,
> -	"[dev [n]]\n"
> -	"  - print n random bytes(max 64) read from dev\n");
> -
>  U_BOOT_CMD(
>  	rng, 3, 0, do_rng,
>  	"print bytes from the hardware random number generator",
> -	rng_help_text
> +	"list         - list all the probed rng devices\n"
> +	"rng [dev] [n]    - print n random bytes(max 64) read from dev\n"
>  );
> -- 
> 2.39.2
