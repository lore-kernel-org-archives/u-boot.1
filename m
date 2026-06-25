Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8CFCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:48:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EC58498B;
	Thu, 25 Jun 2026 19:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rNPBnBzN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503A984704; Thu, 25 Jun 2026 19:46:45 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59BE8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 19:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yordy1902@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5aea5e1775fso51950e87.0
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 10:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782409602; cv=none;
 d=google.com; s=arc-20260327;
 b=dBfw1abB5mDMhubfcgKw2w7h/GsFbhYwxREH0UTtobBII06drBZTycY+MvfJwjsnJR
 jRZiyjHAvY7TPcNE2kLx8B+H3st40I11wKbfsDV361zsiGMDV3cmck6Bfy9QcwTbye/x
 YQsm3Ne0ZQXGLlOsXdVNytpi0esimZDPiX0c2EnlZHeqmFR0sCFPqun8AjKPZdGqQnWz
 4IAvv8NZVmA4jmb0aCC6aFxyqncTNZ9n9ozu4RoXlY7frfXqyRWg3hjGpkUgHjQ9EXTG
 UbA9GpzvF0JiJ4XdcDib/KAuFF+rZmKrYeZEoH0SIJ+TpMwr9yUlH/+Lt6Hl6dVLVE4B
 tApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ARjmXG/R0X58MPlNhRyOFpxRi3dxSuFid/X6Zwe6U6k=;
 fh=FCmzCjCQ1MwpOEssjdJ+0XFkTIwVdmA93Y2/YC4POb8=;
 b=SIQHyz+n2kcomg6GnTuVhFo6lJ9demRJ+jtyoK1x8zhbloJSzV5F8I7KoHZ7Hrz5N3
 Pg1fstIClB5CGVpAhJv47v7R8T3yIrOrGyCleYG1LHe0tPMjzy0ThMQuAGFJIw9yNo6K
 ssR8xLjdSr102z68XrYPhrmGlwLAxgMap0rcdfRToXcW94C5lzxaJAzX1G5pbQCIENwF
 +5wXq7aLg4SK3wLVEFwy1dfQcDoCTP093ml4BXcYesK/Z4CH+CWHPU3jDPr9+egTAbKe
 4eYo2+dGBAtIYJqsC/CoVs+UGrhdNf20GftEpYQTt+SGLL3iQ+1kNVWPUoM39C6djPun
 uQlw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782409602; x=1783014402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ARjmXG/R0X58MPlNhRyOFpxRi3dxSuFid/X6Zwe6U6k=;
 b=rNPBnBzNw3swnTgENYeRW/8/feXy3rssygKQSz3bd0IQ5a+gzJiy/hTPnS6LJzsMqw
 MFvAKUVZeVtAnVBkJL3mzSgckPiQqJI8g1/8RB3FHLt1vjv8yM/JBt6HjGzrRL4v9k/g
 FCDRi6Cs28UZcEo7PkvXmgUkTgi1v4GT1mrCjpqK350jhwi9qCQO5PesVlBHf2dGip/S
 0zFNgi/MdQ+sViTO0wnfzBmyS10OFA/nv9JQFrBGz9wmVctxMyb1TJa3tE/tON8OEgwa
 TMSgNRmNf4x7uRXVL+qOaC4UCVk7k+BL/3Zz6XG+q53ZPDAPfCIeVUTpKIMcPNcgeS4i
 fmrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782409602; x=1783014402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ARjmXG/R0X58MPlNhRyOFpxRi3dxSuFid/X6Zwe6U6k=;
 b=adm3yuXChSFpsab6wCJ0UXi5b3+NRUvGrRBhJ8rBA5vWvaG8gumUGrfXhgGUjQZFNe
 xJarZbmmp+8E4tmuMlLKoxZYp/l5tChWjlsqAHfUBSZRHV4bQK/DfazDGMgi3KkCMkRw
 cqJDQqWY2fEXJTNUnzE9iKud+jphzZznyx3FVbr2uqD2jLOlmfR0KczMv5xJ+sY+EC16
 LsiBrhDYKj1m291OVTAxHksBimUGn1oSobdnXakrzIAyFj6J+Ud+nbwdfLG2QDXRfplY
 q4FgqJPMCHd721m3GJCWdjADwT8P0TazFsZbMKfggvCVaQvfO+gi/6j1jAgs54VX33Pp
 HQ8w==
X-Gm-Message-State: AOJu0Yw/dHasBI8EULogLd4UxjpWQzd1mgq1RJ18a9KUueVAj0/LLjO5
 95s9l0OBiRwLpaeelE8YCNPm3S+Hpk4PcdQqHMqMajs175LVKrrJ+YL2sBQOOjYC3EOOVBmlXMN
 60d1/uqqD6ffzBTQeJf8kPjHlrWqjnEz2EtwOB5E=
X-Gm-Gg: AfdE7cm5wvEnqk5jv8dXL0b7q3IuSeKdFlaH2v3wsxF+Zo59OJIbnPDPVDiy6C8UxV2
 Qxs7PEzKHeBJqAEMhbE/GPMGOcSTpjKDHEa0MBCCvDPuU7Oa6v91ZlcBPs+ullzcu4p7PZc1ThU
 2bdNFEubp3kVylQU43Heid6acPpovy7x7O5EaeHFsX84AsOowhasm4/ObFJiq2Mn3W9TFbgEKvi
 mXJJCLu2ATHnDGVOtoZDVauH5GwmbgH2BGTDJR1eN6ufrHD4lzkb9jEUMspK7GnYA9sRj4H
X-Received: by 2002:a05:6512:4509:b0:5aa:75f2:c996 with SMTP id
 2adb3069b0e04-5aea1f2f77fmr1164449e87.16.1782409601506; Thu, 25 Jun 2026
 10:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260614103232.3586246-1-yordy1902@gmail.com>
 <20260625174121.3633162-1-yordy1902@gmail.com>
In-Reply-To: <20260625174121.3633162-1-yordy1902@gmail.com>
From: Jordi T <yordy1902@gmail.com>
Date: Thu, 25 Jun 2026 19:46:29 +0200
X-Gm-Features: AVVi8CdlLMUH6lh6qYixVxvixbpM4UWHc_p-1ab_Bh6k6Fcs3Uz1vjR7GGtl4j0
Message-ID: <CAKqxRA_cKJdQUwsH-s6Dte6AX0oDptDRtfEg2FuJYzeS5L-j9w@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, vigneshr@ti.com, nm@ti.com, 
 anshuld@ti.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:16 +0200
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

Hi Anshul,

Thanks for the review and for trying to reproduce it.

> I'm unable to reproduce the delays you have observed with the J722s EVM.
> Are you using a custom DT perhaps?

You're right that the default EVM build doesn't show a large delay, and it took
a board test on my side to understand why. No custom gpio-range property is
involved - it is the SoC's stock 7-entry main-domain gpio-range. What changes
is when pinctrl@f4000 (main_pmx0) is probed.

On the stock EVM defconfig it is first probed after relocation (caches on).
There, single_add_gpio_func() is only ~18 ms, and ~1 ms with this patch - easy
to miss in the overall boot unless you time the function directly. If you put a
get_timer() around single_add_gpio_func() on a stock EVM, you should see that
~18 ms -> ~1 ms.

The 723 ms in the commit came from a product configuration where the node is
probed before relocation (caches off). This happens during the pre-relocation
console bring-up: setting up the main UART applies its pin mux, which probes
main_pmx0 with caches off. That board also runs its LPDDR4 clocked down, as it
is an early sample and needed that for stability. The two factors decompose
cleanly from real measurements of the same unpatched function:

    caches off vs on, same board   : ~17x  (723 ms vs 41 ms post-reloc)
    reduced DDR vs EVM, caches on  : ~2x   (41 ms vs the EVM's 18 ms)

i.e. 723 ms = O(N^2) x caches-off x reduced-DDR. On the EVM's stock DDR, a
pre-relocation probe would land around ~300 ms. Either way, the patch removes a
genuinely quadratic full-FDT scan per entry and produces an identical
gpio-range list.

On the code points, all addressed in v2:

> Why rename 'ret' to 'ret_total' here?

Leftover, dropped. A single 'ret' is used only for the one phandle lookup.

> The size check is redundant

Agreed, dropped; v2 uses just if (!list).

> You could just do if (!phandle_i) ... is the validation required?

Correct, a valid gpio-range never has a null phandle. v2 reads the entries
directly; a zero phandle terminates the list, as in the original loop.

> I wonder if we can just allocate a pool of ranges[entries] ...

Done: v2 does a single devm_kcalloc(dev, entries, ...) and walks the array,
removing the per-entry allocation and its null check.

v2 follows shortly.

Thanks again.

Jordi
