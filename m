Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A7606A31A
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rXXVa705;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=o6RyTwsc
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3E494061D;
	Mon, 26 Oct 2026 09:40:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zs-lGX8cGm0w; Mon, 26 Oct 2026 09:40:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16FB840611
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007637;
	b=r9VoIhhVfOtqmwDOnkl2cG+CAYziiUYLiIDFRYEVXLVmornPGBiObYzn1kAQsizuJ9Hj
	 by0zvy+nRYGPhVgu7oDNzsyE5fBm5H4E5I7PVCSTgKPavZewl9pz0hv2g4c34jbPSjzy5
	 6F0MFoOODjcnnwi7aYQVsIoqg85g/VVNNNCBDy5SHfXVyNQ6icNcduRIP3a6trvm2rDts
	 ZsQ8j3+JjGj/T0QABYIHmJfh3lgEmh+QmgWTlxQHAPH8FE58fSGWZz6S+LRVgu3W//Xxw
	 y8IGrpVPlKOU0Y9sFvni6NOzIG8jnFXKmMyJ/Uco1M3Tsdm3WxhappZIfDnvkQyCtnA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007637;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ongUdrfp68Nf7PFTWCHULW4HfnI4jcH2stV2YECN8ow=;
	b=Yj0QjOdG9uivxU2lN5frVeq9Bd0kfkilB1OJGHAnogV4u+cEASULLnI62v7lb4tTYw6x
	 4tnsKSCvthmYJgEGmLsqlQeaQJS4+hQeOiu/a4CwEOBH9KSBrrtT8Isb1Hmshs0Lmjtkl
	 f/UZlCDPIrDJCXAzSKzlKkn6YJBYZ7y348lrSqRTWsTKUdidAkjInv3hrsUETP4OpMvTt
	 MblhYNLwCMOB9XQ+TnfqurnpayAF5MIK7o4Gy0dgwp5JFrCbluHRVIZmKOCaoPh8BDvb6
	 zPGWg8xltT9C9IrD6qxh9uAFQgfAIbpz2LNX04Nq5H8leGSDEBiEH1ccfm7YDGpUcYA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793007637;
	bh=ongUdrfp68Nf7PFTWCHULW4HfnI4jcH2stV2YECN8ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rXXVa705MzdIcTQ1QAXWFOpohq77/RaznNG/Gxi25SlOw75gbzhGg+LHgS6ZX5R6R
	 b7Nw0hIBjoPDp+50Dq0aIzXoXc9nkARL9rTSINR/NB7zH620thEGn24Iza6WY8zQ4N
	 /ekndfa0Rdm8FJleaxOjgiUGmvv0HtGST2nJI+d25t8YixTPKEJr51V23vE/kQ+yWx
	 FMLqE52aX8JIMHqqCUFRYrQapqQgK5B9KQ5gM12Ez2FQbuANFUV8Iw8wf1wL44jbDv
	 2rR/WeJLUKzopLQckRBcGH8KKvbKUYDTW6rLt3OUB9Jto8faS1zRpGV0OT/ImBJxQe
	 WJ6sdoQpg8sSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 16FB840611;
	Mon, 26 Oct 2026 09:40:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42220356
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:40:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 345254004D
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:40:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BHcu6mR18j3a for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B94A740049
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007634;
 b=LmhMlUvV3M8o6zaWN2o2tyBvIAVk4TEpEorUXlTiOw1Z9QCVg3U8vyKqJUqLNzISrBRZ
 hp8Bw4tk/wBFZkmpMR9l7OUflhi3Kq2YRIncvUTe2magYGfZlo/V/xbPKNCl3h9OSh0DD
 iOBdsbkZaRSAJ/88kqIpr0bCxj9zJD4sNcSIkTk01BfA7388T2s1E1VzAOk970DkSRRpj
 7zK97Z5Ti7GezE1Gabq9JbBByUuPvcZ8u5MTIftl0P1MJ40I44dnnYR2BGIuP7NZQKnBU
 1uoLboLgt9CnH01IUgc9IZDR4aI4LzuhfbfGVdzJSh5I9Pg4P59RxS2Fd3vnpDi6lhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007634;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=ongUdrfp68Nf7PFTWCHULW4HfnI4jcH2stV2YECN8ow=;
 b=bKm5ljNkGpD4+WhNFyimk84aKqDnlbAyo/qAxUo2M4sVl2mruA8m/q0AohMA8Vy049ih
 1UeSn46tFeG411lYT5UHgWGRZBY59RJccdmMNbzvnykx9tXzkiVC48WqNz0IshWZ9miXp
 57UMOZRb8jqt2wAsezecGLZNcXOFuukKA0TpNxOE2FXYZ8NR0NCzq59rZj6UOhIPY7grs
 34arfZ9yZpOc0CPFe/tTmTePgKCBV4VjFHkrUuZe5dBeTC+nzmlTpY1EuLNp3xnYxlW3e
 qRZZqoaEcy8JVjWvPAyAuCG130NfVZLEbHw5VXqS10mR2b0fYBoG15aA2iO/sAnMVMw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=o6RyTwsc; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=o6RyTwsc
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B94A740049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:40:33 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso28160135e9.3
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 02:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793007631; x=1793612431;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ongUdrfp68Nf7PFTWCHULW4HfnI4jcH2stV2YECN8ow=;
 b=o6RyTwscVnGZTvC3QRiS+IFxIEjDuZQoWggFaGdRy8dx6Z8ZCklEbBUHR2vUQe4Jtv
 9an7zuufZohkOH6qcp3QhFnxmzNDdfcVkWzquBiqBa/cEakP2kYE/5Z5CP5eEeKc25wL
 Z8dsEUor3QBRgKXYYt6P3nAotThl1BF1oHOJRDhfi0tMsWz4mqsTjy9tHavbYpLBNBaQ
 yLDs6jRox9znlpg/Teq8n8bIu8kdfC7OfNsRto8meMxOaNFIKrKC3YTpK2urra2M3VgE
 GP0SdO3E8ro4qXXO7YxWzmXcwP8h9xWc0MBQ5T4zhqr11PqkyLFTsMsgAICHJFomFItD
 xd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793007631; x=1793612431;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ongUdrfp68Nf7PFTWCHULW4HfnI4jcH2stV2YECN8ow=;
 b=M6uKU2/XMfLTTDjcmboj22xMkDUeDrozCW8vsk85Yb2NSUrJjc6KmQzoKMV7qZHnH+
 NXyTdypEEX+fyNIvkTpRFvhhumGzHFWKEnHk+WnaahyG7XNihLZOgumGw4qVCDpVWX+6
 13Bd/QbEvm5ctIGA6gxy9xJebsyFIbUFd4uGOJHIQ2gS0PgWKvmutXe9m8PX1dqGR/Gn
 ovQqOCf5erd+kWqmBMpnY7PZEoYPvVPx9I6QxRRm4dGq/Q8H8f+jXaf+GBuNGcN+L3al
 xfYdlQV1BWTbY8JyCtPbj/cniyTq08hQHPXy+vgR8nMp8QC9wgU/n6guC5DwR4CcB6Gs
 q+GA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzW/5DuUkL+ePgfWm02SUqavHzEuUM1SvAzBFc/84joqcg7nUJC898RcjjuUIHoWCO0aenCmOQ=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLxxJIxAozCQZIowYkE9vbJxmYXa7Rixf6oxwCOq7aQr+bVng7b
 QqIx3iufHHRaBqzY/w3RYO+KE3cLI9xKDSzQt0aUypkvY9qiJpT04IyZkbTDfShM8hY=
X-Gm-Gg: AYBFou2BJ/ABGNVituvAhe954oFaUAmEvjM7WmBgrKoZgUV7J/y/25Vzxmf3QssSi4d
 BWJFGly9BzyK4ZElGRtwxZp5AQPAWY7tWRypJnze+0X/WMEFnNQM0hd2EMA/joL9eJleRTgU6f9
 jm4m+MMdSqMfV8b/qBG1y/7FgJZpx+F2aTsgCu011csQ1a87QMGYpXHaafnSZk+YS7RLGlRr6tM
 AT30BojcLiX+WgaDXvHGwTtaNN9gT2c4BqW2F5YnjnsQQflaDnZyc6BJnsQWIaeWsG1VXZFtdfQ
 ReHGbRf9ZCrdcKRyq+HhTKa3OrgG7Ibb3wSXJU607lj0JGJ69vEWwlXA/E9Vob8TfpNBUzNYsUC
 cZ2CFxQhCPtfE8qWVRa9N1SqYgJC3g+K3NLrlcW/1iOeQxSKAWAxHH0NHNP5aemXYE+0EjjaP2p
 Ay/mDhqQFrbpOEViLKw0NkLjsDndFpRpdldN98UV+68SFZyPxNqptyKeqihJVv8pIc/9AEcuiIq
 TwpVkxkPmeBr6HhILQTxiG10k8B3FFX1ta11D50QsUVYVFvNtHjLyl76Zm2gTV34qnWjrT91ieM
 IzeMyTTqavKWcoIUdQLtQPESflorf/EPxj9pDnV14WMhmweBkxztR6n+vC30e1F/Kn8Uo6yrPFH
 7qUHr6WM2Vnmvfn4hyA==
X-Received: by 2002:a05:600c:6289:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4a35acc8109mr107320355e9.21.1793007631452; 
 Mon, 26 Oct 2026 02:40:31 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4ba7sm15564456f8f.33.2026.10.26.02.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 02:40:30 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:40:29 +0100
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 5/7] configs: mt8189: enable eMMC FIT boot from SPL
Message-ID: <at8gBkXKWhGtb56i@macbook.homenet.telecomitalia.it>
References: <20261023-mtk-genio-720-spl-v1-0-f2c0ee094fd0@baylibre.com>
 <20261023-mtk-genio-720-spl-v1-5-f2c0ee094fd0@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-mtk-genio-720-spl-v1-5-f2c0ee094fd0@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 19:09:11 +0100, David Lechner wrote:
> Enable SPL on the Genio 520 and 720 EVKs, entered by an external DDR
> loader, to load BL31, OP-TEE and U-Boot from a FIT in eMMC partition 1.
> Pass the transfer list from the DDR loader on to U-Boot proper in
> registers, through BL31, and allocate the SPL bloblist when the DDR
> loader does not pass one.
> 
> Reserve 256 KiB for SPL: the MT8189 BootROM loads at most about 930 KiB
> from eMMC, and the DDR loader needs more than 600 KiB of it. Place the
> BSS right after the SPL region with the stack above it, and the heap
> away from the firmware that SPL loads and the memory reserved for it.
> 
> The DDR loader describes the DRAM in a transfer list, like TF-A BL2
> does. U-Boot proper applies the devicetree overlay in it, as when it is
> started by TF-A BL2.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Carlo Caione <ccaione@baylibre.com>

> ---
>  configs/mt8189.config | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/configs/mt8189.config b/configs/mt8189.config
> index 0dc3c2873f9..f25e1ffc5d6 100644
> --- a/configs/mt8189.config
> +++ b/configs/mt8189.config
> @@ -63,3 +63,39 @@ CONFIG_VIDEO_MEDIATEK_DSI=y
>  CONFIG_VIDEO_MEDIATEK_EDP=y
>  CONFIG_WDT=y
>  CONFIG_WDT_MTK=y
> +CONFIG_SPL=y
> +# Fixed destination and copy window of the external DDR loader. The
> +# BootROM loads at most about 930 KiB from eMMC, so the DDR-loader region
> +# and SPL together must stay below that.
> +CONFIG_SPL_TEXT_BASE=0x40000000
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +# Place the BSS right after the SPL region.
> +CONFIG_SPL_BSS_START_ADDR=0x40040000
> +CONFIG_SPL_BSS_MAX_SIZE=0x10000
> +# Leave 448 KiB above the BSS limit for the stack, global data and early heap.
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x80000
> +CONFIG_SPL_SYS_MALLOC=y
> +CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
> +# Keep the heap separate from the loaded firmware and its reserved memory.
> +CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x5c000000
> +CONFIG_SPL_SYS_MALLOC_SIZE=0x800000
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SPL_SERIAL=y
> +# CONFIG_SPL_USE_TINY_PRINTF is not set
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_SPL_PINCONF=y
> +CONFIG_SPL_WATCHDOG=y
> +CONFIG_SPL_MMC=y
> +CONFIG_SPL_LIBDISK_SUPPORT=y
> +CONFIG_SPL_EFI_PARTITION=y
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=1
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_SPL_BLOBLIST_ALLOC=y
> +CONFIG_SPL_ATF_BL33_BLOBLIST=y
> 
> -- 
> 2.53.0
> 
