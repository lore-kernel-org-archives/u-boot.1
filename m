Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD79BEE3698
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 15:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D7D8388D;
	Thu, 12 Feb 2026 16:26:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="DyJLGXLc";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F2+tFpRK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55A483A47; Thu, 12 Feb 2026 16:26:48 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4E183015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 16:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fBfKd4pmtz9tvC;
 Thu, 12 Feb 2026 16:26:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770910005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhizUN/p7EZEzRwHDSB45hpkSGHNkVkaM8gmdYrlFyk=;
 b=DyJLGXLci9ptaeRK56SXajWxlsSQEg0XA8FIoept63V3EbKLj2e2NpI3/LzDObdR06VKos
 FOtbwosoDx1Jq5i4P+8J98c5W0VsegbWiFu8T47Pi4Nf/tn2M06Kd2NlKoUXqs2NMcZuH+
 mVeOXLcToTKHLvigpAxMkUKuG0qJQGgxXu13e0vWfNlhaL/jh17bAHFuhVewqXU9abGF5a
 gwdSZ/Li3HAbqQJlSQm787lAmT+6MURWeeNxJssAJpzFniohV0kyvRpn4GcsvQu8sZRqCo
 qfLxmWmD+RcRfhVEkiwIbG4DtD1nZBVzAqIu3LXgyeqSZJLJCiNM32uI++U7Lg==
Message-ID: <cf72da71-12f3-45ab-b703-6cc776ed28ab@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770910003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QhizUN/p7EZEzRwHDSB45hpkSGHNkVkaM8gmdYrlFyk=;
 b=F2+tFpRK3h2U+FuJteElNphywtY1q8vNEeAu5Jw9OZJ0NBnj+uUwNJFwr7TL2zGvEio4dS
 6EhUKFKGOX7h87qFiPb20WHu5z/K5RQ0brQfTugaApfjOwiIXgZspcJpDLNrPtgbs33KPL
 qNXH+8cAyHOAurZhUeXCIw3oMVf2ESi3bGlrxet0wnQzUcqDqADFkJ/9rP9eKOCXCwWmZe
 xzSxd/zWbeNQmeUB83J5iyA1wn7vIXrqP4zFROY0OYtzbioujnWkZkWVCy2R5ij6s4a3K/
 W9Zf+La3ZNIM4mdw89+S2ey3lYl+uNbG2P1iHPMs9iWnbzPHDSlLxPuZ7XHQ8Q==
Date: Thu, 12 Feb 2026 16:26:41 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: James Hilliard <james.hilliard1@gmail.com>, u-boot@lists.denx.de
Cc: Jamie Gibbons <Jamie.Gibbons@microchip.com>, Tom Rini
 <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
References: <20260211180645.3313596-1-james.hilliard1@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260211180645.3313596-1-james.hilliard1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: hoowcidzyqkhx4ap8k5qqfxq47nqu81r
X-MBO-RS-ID: 6268590e58c8df01ef4
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

On 2/11/26 7:06 PM, James Hilliard wrote:

> +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
> +					ulong extra, ulong min_dstlen,
> +					void **fdtdstbuf, ulong *fdtdstlenp)
> +{
> +	const void *fdtsrcbuf;
> +	void *tmp = NULL;
> +	void *dstbuf, *newdstbuf;
> +	ulong dstlen, newdstlen;
> +	int err;
> +
> +	/* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
> +	fdtsrcbuf = src;
> +	if (!IS_ALIGNED((uintptr_t)src, 8)) {
> +		tmp = memalign(8, srclen);
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		memcpy(tmp, src, srclen);
> +		fdtsrcbuf = tmp;
> +	}
> +
> +	newdstlen = ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
> +	min_dstlen = ALIGN(min_dstlen, SZ_4K);
> +	if (newdstlen < min_dstlen)
> +		newdstlen = min_dstlen;
> +
> +	dstbuf = *fdtdstbuf;
> +	dstlen = dstbuf ? *fdtdstlenp : 0;
> +
> +	/*
> +	 * If the caller already provided a large enough writable buffer,
> +	 * and we're not moving the FDT, nothing to do.
> +	 */
> +	if (dstbuf && dstlen >= newdstlen && dstbuf == fdtsrcbuf) {

Can $dstbuf ever be NULL ?

> +		free(tmp);
> +		return 0;

You could try something like this here, to reduce the duplicate 
free(tmp) in the code:

"
err = 0;
goto exit;

...

exit:
   free(tmp);
   return err;
"

> +	}
> +

[...]

> -	load = (ulong)of_flat_tree;
> +	len = fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_buf);
How does this new length calculation work, can you please clarify that ?

I don't think this will work for fitImages with external data (generated 
using mkimage -E) , but I might be wrong.
