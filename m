Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95A7C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 11:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459588848D;
	Mon, 10 Jun 2024 13:10:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tmF+roZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 310D088378; Mon, 10 Jun 2024 13:10:52 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 865D08848D
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52c8ddc2b29so619911e87.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718017849; x=1718622649; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jrTuhZJ3uLToniYKQpIhih4M5i4acpXJObBRow8bEP4=;
 b=tmF+roZ4InbzeqiwKkfeSmVt9n84lUjGjCBD7WycmKkxE7bwrBeBjmjCq1TCd4BpNk
 tctsDL+qQ1pDAYva8P+FZBirikaG+nsU15tPRHrPkoOesW6nO0LHN6Wd6I8sWLSL+x4O
 k3QKO+qznAvE9L3nUoKZ9iIaTtprqxvVkpn+D5e7tcJwpqF9LL/Btdk3+VYCn/vCh+OM
 Tv7TaQO3Nva1cmtsMzX75BEDWGFCXbzUSiKpyaF46qhShLr2Igena+sGD0kSOh8KNWdy
 17MtcwoP4MV/gbkCECIrH92I8myIBCcDbABkfVGnzHlgT7i4xNtcsCajpQnJ22jCdgIN
 GrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718017849; x=1718622649;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrTuhZJ3uLToniYKQpIhih4M5i4acpXJObBRow8bEP4=;
 b=qog3JgLDuAy7LTWyle+womZN20VbICSJEM8PZ9tbDz199J7f8PkoYdCO6PJJDwtm04
 Hm3vSk+aQJTuIdK/UJu1yiGgOpZcr8zIX4sqtW0yV54z73iB++ZWMclurZVJx0uPfrs4
 aovlZE0JYbpfsATf4HktsfcAsQ0lvEIWo1YfEMEbKn1b5qxw88OUIRfjsXE3tHXdTzM5
 09zx9XuA1HgNMl1PTk5+x62wjvUdhMbxxu1PwDsUW5XD1JAyQmHbF6MhY3eLrj/+X+G1
 23UvHYPd7PCoOPPaM/aXkcIMmXbPaOcwr924/97rHN2UjAGAwkq7iUjW3gCU9E6cEal3
 GLdg==
X-Gm-Message-State: AOJu0YxrinllUbtWejkvOfk2IFqapJ1yDLcfoq3r4siGQ4FuqTbq9Sbx
 Hp4zA0hn9NfZ/9q6maH44fHE2d7/nV//HeQkC0xqT//mbVwIw8fb9LWzE5Zrp70=
X-Google-Smtp-Source: AGHT+IGubZek7BpQ/WhJ2nEuS5HZbeKr3mxTO+lKjbW4haVjgwCGyeRtS8SIDkF7xNNZpdR1SnLmyA==
X-Received: by 2002:a05:6512:4012:b0:52b:827e:3150 with SMTP id
 2adb3069b0e04-52bb9fc938cmr7931865e87.54.1718017848727; 
 Mon, 10 Jun 2024 04:10:48 -0700 (PDT)
Received: from hades (ppp089210091242.access.hol.gr. [89.210.91.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f10c62f0esm6452894f8f.25.2024.06.10.04.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 04:10:47 -0700 (PDT)
Date: Tue, 11 Jun 2024 00:42:18 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 07/31] lmb: remove lmb_init_and_reserve_range()
 function
Message-ID: <ZmdzOk4XHvmBS2/4@hades>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-8-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-8-sughosh.ganu@linaro.org>
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

On Sat, Jun 08, 2024 at 12:22:16AM +0530, Sughosh Ganu wrote:
> With the move to make the LMB allocations persistent and the common
> memory regions being reserved during board init, the
> lmb_init_and_reserve_range() API can be replaced with a simple
> lmb_add() call.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  boot/bootm.c  | 2 +-
>  include/lmb.h | 2 --
>  lib/lmb.c     | 8 --------
>  3 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/boot/bootm.c b/boot/bootm.c
> index cd1003120c..73e72a710d 100644
> --- a/boot/bootm.c
> +++ b/boot/bootm.c
> @@ -248,7 +248,7 @@ static void boot_start_lmb(void)
>  	mem_start = env_get_bootm_low();
>  	mem_size = env_get_bootm_size();
>  
> -	lmb_init_and_reserve_range(mem_start, mem_size, NULL);
> +	lmb_add(mem_start, mem_size);
>  }
>  #else
>  #define lmb_reserve(base, size)
> diff --git a/include/lmb.h b/include/lmb.h
> index d2b829ace1..f3e3f716e5 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -85,8 +85,6 @@ struct lmb {
>  };
>  
>  void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> -void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> -				void *fdt_blob);
>  long lmb_add(phys_addr_t base, phys_size_t size);
>  long lmb_reserve(phys_addr_t base, phys_size_t size);
>  /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 8003aae6f7..5c056800c3 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -253,14 +253,6 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
>  	lmb_reserve_common(fdt_blob);
>  }
>  
> -/* Initialize the struct, add memory and call arch/board reserve functions */
> -void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> -				void *fdt_blob)
> -{
> -	lmb_add(base, size);
> -	lmb_reserve_common(fdt_blob);
> -}
> -
>  /* This routine called with relocation disabled. */
>  static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>  				 phys_size_t size, enum lmb_flags flags)
> -- 
> 2.34.1
> 
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

