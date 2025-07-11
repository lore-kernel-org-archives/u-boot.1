Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9A4C83F1A
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 08:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E87806D8;
	Fri, 11 Jul 2025 10:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BvKI/tP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8515280836; Fri, 11 Jul 2025 10:02:27 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DC7805D7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 10:02:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D4FEE61483;
 Fri, 11 Jul 2025 08:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0482BC4CEEF;
 Fri, 11 Jul 2025 08:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752220943;
 bh=KoJS5oDBgaJNyoGUT3431jzdIpSm3mnWp+bC7TsngPc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BvKI/tP6B/bYelApw6dQ643RW5CYLd6RK1ZgSoGbYhygbxHubPNfDSPi0TfNPlxI6
 ZO/XN6IUn20OwAqSQtzzpuk7CQwU91gHjKo/h4TZN8cjsTY37wRjXLKBFOpLnPkVOA
 khnRvoITpGQb48NVI4CiQPqNAzZ0m9ftYh0jSwrQ48jmKY3fyY1SLfUBm5wTg+ncfv
 8TA3UcAV9+2ocmhNmbBKX6Z+ArvJb1CjIn4LxqACfwUcrcBcyH1WXVNdB+uinTJ9zU
 BixEp6AYrKPdxozUnSUPr07dIITt83C9kn64MkXvLKPsHYdoDmjIlOpeuavnTJf5ua
 Dqy1eUVs4MurQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Subject: Re: [PATCH] dfu: Fix dfu_config_interfaces() for single interface
 DFU syntax
In-Reply-To: <20250709042342.13544-1-semen.protsenko@linaro.org>
References: <20250709042342.13544-1-semen.protsenko@linaro.org>
Date: Fri, 11 Jul 2025 10:02:20 +0200
Message-ID: <874ivjjgtv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Sam,

Thank you for the patch.

On Tue, Jul 08, 2025 at 23:23, Sam Protsenko <semen.protsenko@linaro.org> wrote:

> As stated in DFU documentation [1], the device interface part might be
> missing in dfu_alt_info:
>
>     dfu_alt_info
>         The DFU setting for the USB download gadget with a semicolon
>         separated string of information on each alternate:
>             dfu_alt_info="<alt1>;<alt2>;....;<altN>"
>         When several devices are used, the format is:
>             - <interface> <dev>'='alternate list (';' separated)
>
> So in first case dfu_alt_info might look like something like this:
>
>     dfu_alt_info="mmc 0=rawemmc raw 0 0x747c000 mmcpart 1;"
>
> And in second case (when the interface is missing):
>
>     dfu_alt_info="rawemmc raw 0 0x747c000 mmcpart 1;"
>
> When the interface is not specified the 'dfu' command crashes when
> called using 'dfu 0' or 'dfu list' syntax:
>
>     => dfu list
>     "Synchronous Abort" handler, esr 0x96000006, far 0x0
>
> That's happening due to incorrect string handling in
> dfu_config_interfaces(). In case when the interface is not specified in
> dfu_alt_info it triggers this corner case:
>
>     d = strsep(&s, "=");  // now d contains s, and s is NULL
>     if (!d)
>         break;
>     a = strsep(&s, "&");  // s is already NULL, so a is NULL too
>     if (!a)               // corner case
>         a = s;            // a is NULL now
>
> which causes NULL pointer dereference later in this call, due to 'a'
> being NULL:
>
>     part = skip_spaces(part);
>
> That's because as per strsep() behavior, when delimiter ("&") is not
> found, the token (a) becomes the entire string (s), and string (s)
> becomes NULL. To fix that issue assign "a = d" instead of "a = s",
> because at that point variable d actually contains previous s, which
> should be used in this case.
>
> [1] doc/usage/dfu.rst
>
> Fixes: commit febabe3ed4f4 ("dfu: allow to manage DFU on several devices")
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>

Good catch! I can indeed reproduce this on sandbox after enabling
CMD_DFU:

$ ./u-boot -T

[...]

=> setenv dfu_alt_info "rawemmc raw 0 0x747c000 mmcpart 1;"
=> dfu list
[1]    116917 segmentation fault (core dumped)  ./u-boot -T

And I confirm it's fixed with this patch.

Thanks for all the details, it makes the review and the testing
so much easier!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/dfu/dfu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 756569217bbb..eefdf44ec877 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -147,7 +147,7 @@ int dfu_config_interfaces(char *env)
>  			break;
>  		a = strsep(&s, "&");
>  		if (!a)
> -			a = s;
> +			a = d;
>  		do {
>  			part = strsep(&a, ";");
>  			part = skip_spaces(part);
> -- 
> 2.39.5
