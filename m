Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE466CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 12:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D3C083EAC;
	Thu,  9 Oct 2025 14:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XClkXuW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26B7D840E4; Thu,  9 Oct 2025 14:53:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D396E83A4B
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 14:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 5246B48E32;
 Thu,  9 Oct 2025 12:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B15F1C4CEE7;
 Thu,  9 Oct 2025 12:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760014382;
 bh=KBe7UB7psDtn63FItLmNiQ7x1rj+YiwCIVJaeeqlDkU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XClkXuW6UFosLBGu+rO+80yOMg24wVTthfesS13CCJfgAiQg32/W5ZGWFD0po6eWM
 Gl/4ngHms7EnlyIIp20o9ANO8JYMM9pgY2xzuqstiat1JaS9d/z1fHvDHO+OuC4nWx
 VXru5WmhjcmpQ2UQZg/7laUYnuuzy0cJY84r6XP8bjoaEkzXHT6dglqjcPVWcIcTNd
 nvJGZjnhG0MMzAq/NH+mT7jx244sUZUMtYrCuuQZ/2HZgnhHVqAtvCuGjTga8d1ohZ
 suTX+0LTq9/0ogQt3/B3XtSkKD5+DHW0udrKTZjhurOvcnd4TJiKb+f2jJhZMVBeOJ
 bYoL99Sy0JZmQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Guillaume La Roque
 <glaroque@baylibre.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Maximilian Brune
 <maximilian.brune@9elements.com>, Moritz Fischer <moritzf@google.com>, Sam
 Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH v4 1/4] boot: Improve comments related to global bootmeths
In-Reply-To: <20251009092959.260121-2-sjg@chromium.org>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-2-sjg@chromium.org>
Date: Thu, 09 Oct 2025 14:52:59 +0200
Message-ID: <87347sw82c.fsf@kernel.org>
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

Hi Simon,

Thank you for the patch.

On Thu, Oct 09, 2025 at 03:29, Simon Glass <sjg@chromium.org> wrote:

> Add a few comments about global bootmeths and first_glob_method
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Drop the spacing changes
>
>  boot/bootflow.c        | 1 +
>  boot/bootmeth-uclass.c | 1 +
>  include/bootflow.h     | 3 ++-
>  test/boot/bootflow.c   | 2 +-
>  4 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index d79f303486d..15df7069209 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -344,6 +344,7 @@ static int bootflow_check(struct bootflow_iter *iter, struct bootflow *bflow)
>  	struct udevice *dev;
>  	int ret;
>  
> +	/* handle global bootmeths if needed */
>  	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
>  		bootflow_iter_set_dev(iter, NULL, 0);
>  		ret = bootmeth_get_bootflow(iter->method, bflow);
> diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
> index 188f6ea1895..bb2dd8447cf 100644
> --- a/boot/bootmeth-uclass.c
> +++ b/boot/bootmeth-uclass.c
> @@ -204,6 +204,7 @@ int bootmeth_setup_iter_order(struct bootflow_iter *iter, bool include_global)
>  		goto err_order;
>  	}
>  
> +	/* start with the global bootmeths */
>  	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && include_global &&
>  	    iter->first_glob_method != -1 && iter->first_glob_method != count) {
>  		iter->cur_method = iter->first_glob_method;
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 32422067723..2ef6eb25cf5 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -250,7 +250,8 @@ enum bootflow_meth_flags_t {
>   * @cur_label: Current label being processed
>   * @num_methods: Number of bootmeth devices in @method_order
>   * @cur_method: Current method number, an index into @method_order
> - * @first_glob_method: First global method, if any, else -1
> + * @first_glob_method: Index of first global method within @method_order[], if
> + * any, else -1
>   * @cur_prio: Current priority being scanned
>   * @method_order: List of bootmeth devices to use, in order. The normal methods
>   *	appear first, then the global ones, if any
> diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
> index 8de5a310add..7cd83dc7443 100644
> --- a/test/boot/bootflow.c
> +++ b/test/boot/bootflow.c
> @@ -401,7 +401,7 @@ static int bootflow_system(struct unit_test_state *uts)
>  	ut_assertok(device_probe(dev));
>  	sandbox_set_fake_efi_mgr_dev(dev, true);
>  
> -	/* We should get a single 'bootmgr' method right at the end */
> +	/* We should get a single 'bootmgr' method at the start */
>  	bootstd_clear_glob();
>  	ut_assertok(run_command("bootflow scan -lH", 0));
>  	ut_assert_skip_to_line(
> -- 
> 2.43.0
