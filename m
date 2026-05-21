Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A990DCD4F3D
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 16:09:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 290E4846E7;
	Thu, 21 May 2026 18:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xSOwT0Cj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="We0qAlLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3748846EB; Thu, 21 May 2026 18:09:34 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8568846E6
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 18:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gLtdm4zPPz9v9c;
 Thu, 21 May 2026 18:09:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779379772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFsPo8u8kFmd4DW0nb2c6vWU8NXgQMiEFPFnn9pa2c8=;
 b=xSOwT0CjykyfF+/ajQcdHemnjRCsHn+0Gj9/XnmKPq69Y30mCWVTL3F6jt0ugBZGSRmv28
 qjF+5yCbLlf4G6czZuG8XAn/YaIip35SXlJd6cHvpOGnzxGzfdZI9V63znD6ppbd2z6Ggu
 yfIoql9z+HLtJs0/V2VuWcFdHe5HCNcSAB+iEGb2msVPeYOAbEdIRe+/fphCxkdVQ6ZuO8
 TVWKTx7vNk8tLRbp2yLGabjoiHIf+xg94uCjXW4kqiLBHSc1FNAT62xkpWiAojwzOAaW6H
 uPZUwaepdW9zIL3Z2XNYN+TuMM4jaT0J/5qSIkMZYboVDJe2xetRF5O0IbiXKQ==
Message-ID: <cf2f988c-e12e-4dd3-b80e-b58f846a8d71@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779379771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFsPo8u8kFmd4DW0nb2c6vWU8NXgQMiEFPFnn9pa2c8=;
 b=We0qAlLy+QHpSxB3bEllQW+r3pG5UL9rWn0UUr8yC94TsMB4wYpQ/q6MGrHpeXHz0qmtCY
 eVNKcqD1og2Iwa/FxxvBD0ihTVyEA1pLPUFrCXJBm5cr3QusxPqdNAH/aEUdTaNIqsUS6M
 BuvQ4uQydJ/SBD30Oarrk/LTfbkt+KmR4MspacoVxa30+R+n7F+a0DUUbHIL9zWVEaXZiT
 hwDMjiloVJjMu5JTAWB4B341KCwUB87y8o2sckbsvWuUuAldx0LeXf6NQLO6tkNV3KH5TV
 HxZSELpdj9IBYmpD2sxSFOYgIO0U1B2/RS22owsVacya1CyNHuWQg4uz5i8Fmg==
Date: Thu, 21 May 2026 18:09:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] tools: mkimage: fix get_basename crash on paths
 with dotted directories
To: Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
References: <20260521023503.29315-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260521023503.29315-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 346b80cdfcb6d3361ab
X-MBO-RS-META: hsjdiwodmpjsizd9cpqs79dcg384o468
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

On 5/21/26 4:34 AM, Aristo Chen wrote:
> The get_basename() helper in tools/fit_image.c searches the entire input
> path for the last '/' and the last '.' independently. When the last '.'
> falls at an offset earlier than the last '/' (for example "./mydt",
> "a.b/c", or "sub.d/leaf"), 'end' points before 'start' and the computed
> length is negative. The subsequent size check uses signed comparison so
> the negative value passes through unchanged, and memcpy() is then called
> with that length implicitly cast to size_t, which segfaults.
> 
> Restrict the dot search to the substring that follows the last slash so
> that only an extension in the filename component can become the end of
> the basename. This matches the function's stated intent of stripping an
> extension from the leaf, and keeps the existing behaviour for typical
> inputs such as "arch/arm/dts/foo.dtb".
> 
> Reproducer that previously segfaulted and now produces a valid image:
> 
>    echo dummy > kernel.bin
>    echo dummy > ./mydt
>    ./tools/mkimage -f auto -A arm -O linux -T kernel -C none \
>                    -a 0x80000000 -e 0x80000000 -n test \
>                    -d kernel.bin -b ./mydt out.itb
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>   tools/fit_image.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/fit_image.c b/tools/fit_image.c
> index 1dbc14c63e4..6c129117297 100644
> --- a/tools/fit_image.c
> +++ b/tools/fit_image.c
> @@ -265,8 +265,14 @@ static void get_basename(char *str, int size, const char *fname)
>   	 */
>   	p = strrchr(fname, '/');
>   	start = p ? p + 1 : fname;
> -	p = strrchr(fname, '.');
> -	end = p ? p : fname + strlen(fname);
> +	/*
> +	 * Search for the extension dot only within the basename. Searching
> +	 * the whole path would let a dot in the directory part (for example
> +	 * "./mydt" or "a.b/c") place 'end' before 'start' and produce a
> +	 * negative length, which the size check below does not catch.
> +	 */
> +	p = strrchr(start, '.');
> +	end = p ? p : start + strlen(start);
>   	len = end - start;
>   	if (len >= size)
>   		len = size - 1;

Why not call basename(3) directly in here ? Why reimplement it ?
