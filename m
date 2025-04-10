Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F48C369A6
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:44:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F4E983A79;
	Thu, 10 Apr 2025 10:44:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kH30Izfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEF44839DD; Thu, 10 Apr 2025 10:44:55 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E819683A92
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A02D949E9D;
 Thu, 10 Apr 2025 08:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 839F0C4CEDD;
 Thu, 10 Apr 2025 08:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274690;
 bh=tFuDJA5wyyr0nuwQ4fWLo8i4sCJbtGIewuX9nsFof/Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kH30IzfdWq2lAPOd//M9dDAngU25sjVBJI8ErQj0P10wnKCWZAPU5BIIo8o/LxZZk
 ato1iNZGQBxxvKqjIrRuDzkJkpcvGcRFP2OotIA3DLvTuc6aOnkGkMHwrLgRdkpvi0
 ibcp9b71Xh50mT0XvegKIFhSLFfRVUVrB7rDRPal8jYN5GukbycEvMBQpk15lhSfri
 hsiaHlKuHp/euq25fNeVl4kGoEw8S0stpC3rbNQu2KiIUkS1jVqXZpfeLFeF5Dgl9A
 Xthcmbossy/rvWMrrKQblwOkUD5zKcO6ig0vr3mocG8La6HOvcOq2VXa/gn4dmd9qP
 LYRdkKljuFx6g==
Date: Thu, 10 Apr 2025 14:14:44 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 1/6] event: signal when livetree has been built
Message-ID: <Z_eE_JjxDb84s-k2@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-1-76dfea80b07f@linaro.org>
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

On Wed, Apr 09, 2025 at 07:17:24PM +0200, Caleb Connolly wrote:
> OF_LIVE offers a variety of benefits, one of them being that the live
> tree can be modified without caring about the underlying FDT. This is
> particularly valuable for working around U-Boot limitations like lacking
> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> peripherals like the sdcard being broken (and displaying potentially
> worrying error messages).
> 
> Add an event to signal when the live tree has been built so that we can
> apply fixups to it directly before devices are bound.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  common/event.c  | 3 +++
>  include/event.h | 9 +++++++++
>  lib/of_live.c   | 3 +++
>  3 files changed, 15 insertions(+)
>

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/common/event.c b/common/event.c
> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> --- a/common/event.c
> +++ b/common/event.c
> @@ -47,8 +47,11 @@ const char *const type_name[] = {
>  	"ft_fixup",
>  
>  	/* main loop events */
>  	"main_loop",
> +
> +	/* livetree has been built */
> +	"of_live_init",
>  };
>  
>  _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>  #endif
> diff --git a/include/event.h b/include/event.h
> index 75141a192a48b0931667632f41be8ff4d6139f7c..3fc673ba635ed45467aae8587705d37bef1c2a3f 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -152,8 +152,17 @@ enum event_t {
>  	 * A non-zero return value causes the boot to fail.
>  	 */
>  	EVT_MAIN_LOOP,
>  
> +	/**
> +	 * @EVT_OF_LIVE_INIT:
> +	 * This event is triggered immediately after the live device tree has been
> +	 * built. This allows for machine specific fixups to be done to the live tree
> +	 * (like disabling known-unsupported devices) before DM init happens. This
> +	 * event is only available if OF_LIVE is enabled and is only used after relocation.
> +	 */
> +	EVT_OF_LIVE_INIT,
> +
>  	/**
>  	 * @EVT_COUNT:
>  	 * This constants holds the maximum event number + 1 and is used when
>  	 * looping over all event classes.
> diff --git a/lib/of_live.c b/lib/of_live.c
> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..e1962b8f1fb9d8c2c87d04ca4e238a1e4d00376a 100644
> --- a/lib/of_live.c
> +++ b/lib/of_live.c
> @@ -10,8 +10,9 @@
>  
>  #define LOG_CATEGORY	LOGC_DT
>  
>  #include <abuf.h>
> +#include <event.h>
>  #include <log.h>
>  #include <linux/libfdt.h>
>  #include <of_live.h>
>  #include <malloc.h>
> @@ -334,8 +335,10 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>  		return ret;
>  	}
>  	debug("%s: stop\n", __func__);
>  
> +	event_notify_null(EVT_OF_LIVE_INIT);
> +
>  	return ret;
>  }
>  
>  void of_live_free(struct device_node *root)
> 
> -- 
> 2.49.0
> 
