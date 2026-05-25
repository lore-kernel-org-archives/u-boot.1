Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF85CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B2184862;
	Mon, 25 May 2026 17:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MCYISRdR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C1884878; Mon, 25 May 2026 17:03:06 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50FE284841
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:03:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-bcd0111ea98so1358375466b.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:03:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779721384; cv=none;
 d=google.com; s=arc-20240605;
 b=Eco+H9Pjv+e7gJWB0PmmpTHXl9aC3o7YcxCYEE8AvGTeWm39KAImbdmupKa5H35Qpz
 giuGsqEvOCdVWtjigwEhGRewjjTomO9KlFQmxxBW8UnxNP/YY7My/FFJ8SC7iZjRsqHZ
 2ChRwZbjillwT99Qt4/nDAu4RcEMfaLN0D5w/J/E+TeGM+zqimKy15SNSBbhLRtyP+0G
 97n0o7SgnfqJwMIgo55kgLisjbZ9FtODqdHDNAKZPlCCfkVsPTkHbuZNxIlktPn3kY6Z
 n05jL90zXhNg98GkrMJX0xTdi73E0M1lPhHlLKORXInjDavbelvQp5AnxO2kuiSGl5wa
 irwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YiutN1MZn9+vNGmLPRmO4drVG6TqmEdVEPrtRiNlAlI=;
 fh=uEwfVtgWmQ+BpqL3MMm4A4agCJ5OLHBunogpqm9TwOU=;
 b=kMyjJbXAApZQ4zcZIFdUz0JJONaozuNTUmyYriB/pcmqsNVB+v5k76KuW+LPAsXhzI
 FbB7R21bXFU1eS2+6keOjfmqTv4bJzEPXaPOD6YXjYAMuvRd+48p7HTOKLCae3N9g5zD
 89LRag+gd6Svvum9oxpTvUT7iGdNK3lJBhZMj0IDjQFJQ/eqW4L1YvnYNJCbPXuSoLFP
 evQ5tY2fMlurXSvVPijamA+j+hVlO/GNQWEoY09Xmrx6ztNi83tcmsYZhD8+jk0BAsfq
 w8p1YiM3jx+LaFYLr7xaUXrmWs8V/NBoDCiyoLkISzasKWzUBYCOQ209yfshy3/EkxDH
 Rjig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779721384; x=1780326184; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YiutN1MZn9+vNGmLPRmO4drVG6TqmEdVEPrtRiNlAlI=;
 b=MCYISRdRXvd6Jddyb8p9Yu/ymf7NAP3qVc2g+pQ2Gx7CeG6xBVh7uWUoYqinlA78tk
 SZIsoR0CF35/+z4TNT1eObLpmsA4aSxFi957xi2dC/nc4LQFGjj0KtSUZAxciDqDOAlI
 mjyTQCOHhyLzvyR3cR77aXVSWF89LnUMum12Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779721384; x=1780326184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YiutN1MZn9+vNGmLPRmO4drVG6TqmEdVEPrtRiNlAlI=;
 b=O3wI/gebafmUx/PUXrHwoyLxyZh/SxUs7cVuHjUjIVqdEx4ZRk9Ev7TLfBetAq0lJJ
 Hk53cYkfP8brQS9Gzh53dij2dHTbn6k/7RUyYARsXQytaFmamtQMn94lSRcGeQLGvaHN
 aFQ3qfen4CsGCfU+MKL3EeepbrKFLRKQI2A2NZTHCqG+Bc3jUaymtjnhGB0M2kp81gmc
 7Qjh5pJO0fKHbI+KAiVfYvfUCY9E3AQ0lXIE8wCHNNc3jawsJGZ1mjsr+olDNs+ICNmL
 oRyHH14W2ihGBaYKjAurkVcALyWHG/20C0hOSpwedZTV8kTNOB/JjbMzrUihK3p/XIpG
 22XQ==
X-Gm-Message-State: AOJu0YxlDj+emtbOKZ0xjw1R2V4W/nJEo5DFPAkJsOJLZmVeikxtDbD5
 EDowSEXcR8VuRWKbiy3e4l+ElAV36ZyLERYJStVDwEu+0tiEbi4U4xnF/z+qC/bgDMO8f00S59f
 jYohJhgL8AC8k2SHbsVqGBWMPDJNhlbSJ0qBN2/lA
X-Gm-Gg: Acq92OHn/9afMSoz/LTanZqbt+/lGegPUboxiI+cMkFh/yKRbwN3vbGSUAofwIe1lEK
 X49bmYnLJWPGqf4rer9zqENNBZLe1sbgxUrgh3ugu50WdtcGZv86TPT1a4TwMXNLto3x3spsSJe
 0OVuGPb0SmYY3Ziy1fDevK9d2dARZlE+Y1gDGEnJ9xii1l0LagCx4wY4lY7maEuEqOF6uE5OAnG
 RSxHOTaCP99yqvgfjmOGbzPDj89Zn+wfpQlTxkzf9Hz7MHMR78XcB8B/AD3u4NEmW9rpZDlEjNW
 1NdLRg==
X-Received: by 2002:a17:906:7303:b0:bc4:b970:e47f with SMTP id
 a640c23a62f3a-bdd282a4831mr903794666b.9.1779721383550; Mon, 25 May 2026
 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-6-ravi@prevas.dk>
In-Reply-To: <20260522212756.3169222-6-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:02:50 -0600
X-Gm-Features: AVHnY4I80HBVFSwii2opK11NCTiYdrWjhyVJNjgltUYFFpRcRyose1pBisMO--M
Message-ID: <CAFLszTi-se65R5w99LSUT3BwgJbe9UrXzB7VoTVo3CSSVg9Pkw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/9] linker_lists.h: drop _2 from section and symbol
 name prefix
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Rasmus,

On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> linker_lists.h: drop _2 from section and symbol name prefix
>
> Since commit e2138cf1e60 ("linker_lists.h: drop never used ll_start,
> ll_end macros"), which removed macros that would create
> __u_boot_list_1 and __u_boot_list_3 sections, the first _2 in the
> linker list section names doesn't serve any purpose and is in fact
> just confusing. So remove it.
>
> There never seemed to be a reason for the symbol names to have that
> _2, other than perhaps for consistency with the section those symbols
> belonged to. Regardless, remove that as well.
>
> All linker scripts use a '__u_boot_list*' glob, so they will work just
> the same without that common _2.
>
> Keep the _2_ part in the separator between list and entry names for
> symbols, since that is called out in the documentation to allow one to
> define sublists and iterate over those. I cannot find any current use
> of that feature, but a later patch will make use of just that.
>
> [...]
>
> include/linker_lists.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/include/linker_lists.h b/include/linker_lists.h
> @@ -19,11 +19,11 @@
> -#define ll_start_section_name(_list)        '__u_boot_list_2_'#_list'_1'
> -#define ll_entry_section_name(_list, _name) '__u_boot_list_2_'#_list'_2_'#_name
> -#define ll_end_section_name(_list)          '__u_boot_list_2_'#_list'_3'
> +#define ll_start_section_name(_list)        '__u_boot_list_'#_list'_1'
> +#define ll_entry_section_name(_list, _name) '__u_boot_list_'#_list'_2_'#_name
> +#define ll_end_section_name(_list)          '__u_boot_list_'#_list'_3'

>
> -#define ll_entry_symbol_name(_list, _name) _u_boot_list_2_##_list##_2_##_name
> +#define ll_entry_symbol_name(_list, _name) _u_boot_list_##_list##_2_##_name

The linker scripts all use a '__u_boot_list*' glob, but several other
places hard-code the old prefix and this patch does not update them:

scripts/gen_ll_addressable_symbols.sh:14 greps for
     '_u_boot_list_2_[a-zA-Z0-9_]*_2_[a-zA-Z0-9_]*'
  which is fed into the LTO keep-symbols build step (cmd_keep_syms_lto
in the top-level Makefile). With the new names this matches nothing,
so LTO builds silently lose the __ADDRESSABLE() guards.

scripts/event_dump.py hard-codes
     PREFIX_FULL = '_u_boot_list_2_evspy_info_2_'
     PREFIX_SIMPLE = '_u_boot_list_2_evspy_info_simple_2_'
  so the script (and test_event_dump.py) stop finding anything.

test/py/conftest.py has
     RE_UT_TEST_LIST =
re.compile(r'[^a-zA-Z0-9_]_u_boot_list_2_ut_(.*)_2_(.*)\s*$')
  which is how test.py enumerates ut subtests - this breaks test
discovery for individual UT suites.

There might be others too?

Regards,
Simon
