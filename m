Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A763610AB827
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 20:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7398A83F00;
	Thu, 26 Mar 2026 21:40:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="TiFQ0Dau";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mqcrfgAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B10583EB3; Thu, 26 Mar 2026 21:40:24 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9002483EB3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 21:40:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fhbJ435S6z9tsw;
 Thu, 26 Mar 2026 21:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774557620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RgS3DT3hI/rWPdh2RZc5XF8UHGTIM1mVOFGbYwtJ3Y=;
 b=TiFQ0DauAXs8P/KRy7GP+aq7PBFcbJV/MK1eMgrgScEChoPGqJpzQN1ectYIQ/EI5iZrGF
 1HvNQmyO0DXC8ZNRtCedAGGVV0bs7AKZhaZVvPfZRQkmj1NGo4peZbkw2kOTlfgL3SNiQg
 /ykBrZmmppIfiTcx0gvMvTo3lHB3nGHtXen8cWP4Lhpf8Ah4SUnbi/1ZavctSg8FscDmAe
 7ktEGmFmMOXKCCjQY/pQUcruI8Pvfuv11icX3bG3KwkzujeHpoDqsykflIb/PpEJ1+w8ty
 s8wNZuxEgkYQdsqlcAeb3DLGIoFaMsPqpXAMKq6H02uUwKIC+7mWQ2kjpklSaQ==
Message-ID: <ce171493-712b-4551-a895-a45f386180f0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774557618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3RgS3DT3hI/rWPdh2RZc5XF8UHGTIM1mVOFGbYwtJ3Y=;
 b=mqcrfgAaiuzU3wWlJmh1m2ockgEanhkbiGOS4qgODSDP7xLzoJ0uVl+Rj2GaBNw+r0fxgy
 dP2eX1X9FY0nwDhaBJiZkWI9p688Y0SJxCbQk6saOscs5m55yfT51n8+K+o7tm4ePLqde1
 UU1IzFHmPrZgdIb5i4mz6Z4YtEIuLs/UkjrW9Y05Zi/kdMvJ/dU/qhi3gNkoZKdMQTLIcE
 R4Taa2zVzK654a8UEjXdT6O5jNH04+0tpweWwTceFxGEWnzpDBNOyW02pFA28uFYmLGIF6
 4YYl1UxDOwZagZSGIoLYjUIvhh/BNHbSiMRPJbNOrNw66g5IO1b8SQvVwV4g7w==
Date: Thu, 26 Mar 2026 13:54:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 2/3] fdtdec: Introduce fdtdec_setup_mem_ram_top() to
 determine end of topmost DRAM bank
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 marek.vasut+renesas@mailbox.org, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-3-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260326115111.1631261-3-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yhjbrtfqyqzgycwcoqqyoqhsnyk9zor3
X-MBO-RS-ID: 48b54ac97e360904660
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

On 3/26/26 12:51 PM, Ilias Apalodimas wrote:

[...]

> +/**
> + * fdtdec_setup_mem_ram_top() - decode and setup gd->ram_top to highest address
> + * available in any memory bank
> + *
> + * Decode the /memory 'reg' property to determine the highest end of the memory
> + * bank and populate the global data ram_top with it.
> + *
> + * This function should be called from a boards board_get_usable_ram_top().
> + * This helper function allows for boards to query the device tree for topmost
> + * DRAM address.
> + *
> + * Return: 0 if OK, -EINVAL if the /memory node or reg property is missing or
> + * invalid
> + */
> +int fdtdec_setup_mem_ram_top(void);
> +
>   /**
>    * fdtdec_setup_memory_banksize() - decode and populate gd->bd->bi_dram
>    *
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index d820f75b031d..c5ee2ecb3a49 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1162,6 +1162,26 @@ int fdtdec_setup_mem_size_base_lowest(void)
>   	return fdtdec_setup_mem_for_each_bank(fdtdec_setup_mem_size_base_lowest_bankfn);
>   }
>   
> +static void fdtdec_setup_mem_ram_top_bankfn(struct resource *res, int bank)
> +{
> +	if ((res->end + 1) > gd->ram_top) {
> +		gd->ram_top = res->end + 1;
> +		gd->ram_size += res->end - res->start;
Since this is called fdtdec_setup_mem_ram_top(), it likely shouldn't be 
manipulating with gd->ram_size ?
