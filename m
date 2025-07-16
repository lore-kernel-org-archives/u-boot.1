Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B746C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 09:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44425831C8;
	Wed, 16 Jul 2025 11:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fKUlMD2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0C13831D3; Wed, 16 Jul 2025 11:05:38 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 559B7831C3
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 11:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 32701A53C55;
 Wed, 16 Jul 2025 09:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6791BC4CEF0;
 Wed, 16 Jul 2025 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752656734;
 bh=S5tvrSb1P+2glJwEJa6W9rCi9WJAtFDAsvm37+19yjY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fKUlMD2v5KyO6Ss17z0TkF9Nf+DoChHrGItViSONaeYwd+zjYVeypqJGoFn6bFa73
 THw0/QkWZqLhCA2oZESPdzukBz8yFRv6ewC1vRjNS/uHPDx1v9BayTS1cyAUuB//b3
 wBOOx9jdrbEOH9V+s7gVmSFfyjTX7mSze4IpaDyhGgTk/nUFYV6/hLCBV4n5Zy3lCP
 5crem0O+2wPUpbJAAcAFdvygoc833PgDM62Mmh0QdhuaitQ6ImkrIIDJNelzT5Bp0i
 CrYve/rY+N5BXwnyukXCZnhzOdJTViPCAFfZypKaqLpUn7n3oUr01hJympxj9Iiop1
 GSyKdyvL4yyIw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org>, Tom
 Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg
 <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, gchan9527@gmail.com
Subject: Re: [PATCH v4 3/6] bootm: Append bootargs value when
 bootmeth_android provide cmdline
In-Reply-To: <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
References: <20250630-sc7180-android-boot-v4-0-24cdb50e860f@gmail.com>
 <20250630-sc7180-android-boot-v4-3-24cdb50e860f@gmail.com>
Date: Wed, 16 Jul 2025 11:05:32 +0200
Message-ID: <871pqg4iar.fsf@kernel.org>
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

Hi George,

Thank you for the patch.

On Mon, Jun 30, 2025 at 15:56, George Chan via B4 Relay <devnull+gchan9527.gmail.com@kernel.org> wrote:

> From: George Chan <gchan9527@gmail.com>
>
> Old logic wipe bootargs env with cmdline, new logic cater the value
> by prepending cmdline value to bootargs.
>
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
>  boot/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/boot/bootm.c b/boot/bootm.c
> index 4bdca22ea8c..d8e0c3527d0 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -1165,7 +1165,7 @@ int bootm_boot_start(ulong addr, const char *cmdline)
>  
>  	snprintf(addr_str, sizeof(addr_str), "%lx", addr);
>  
> -	ret = env_set("bootargs", cmdline);
> +	ret = android_image_modify_bootargs_env(cmdline, NULL);

I don't think it can be done this way. bootm_boot_start() is used in the
ChromeOS bootmethod as well (boot/bootmeth_cros.c)

Changing this would potentially break ChromeOS boot behaviour so I'd
prefer to find another solution.

I know that TI has a downstream patch that changes bootmeth_android.c
instead:

https://git.ti.com/cgit/ti-u-boot/ti-u-boot/commit/?h=ti-u-boot-2024.04-next&id=9d802d798ac143e06ffe545606aa657a6c32cc63

Would that work for you?


>  	if (ret) {
>  		printf("Failed to set cmdline\n");
>  		return ret;
>
> -- 
> 2.43.0
