Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BEAC5AC80
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B39428131D;
	Fri,  7 Aug 2026 20:45:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EeenLo7xsI7U; Fri,  7 Aug 2026 20:45:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBC11812F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135507;
	bh=0qk7PTEMXrdK7iaV+jAw8j/0QJ1eNVNsa1ZM4tVOi1w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QzyNBvxVZn4gWBDSoK9JPE2DF0cEvvF/bmN4Hw4iRHo/3x/UBCFV7cwpHTKkyup9Q
	 gqSc+0iU+BrcdcWLvVjww/WVSbawPich0oRQLfsUEN+1y0lecdj3920otvqGFHzZBl
	 lYwmiCz7U4R9tumslURGnJsn8RxArkvBElDEKunNMwO7lqahh00dd1inNcEjPbm5Q2
	 2vISLyT4ns3Gb/cuvbErrb3DRj/C+Rq57+0gwO+Rn7tludERfqDOIJR80zmiVrozZm
	 ejTB5UgB9Z3JMiD96ntidIAuz808YCQFBT6X9uOeRU8Y+WB6Kwskv50JEFBcN0hubw
	 CDqk7HY9gXMpQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBC11812F6;
	Fri,  7 Aug 2026 20:45:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A96DA259
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9B83240328
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SB1dVxG1ejvP for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:45:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BEE02402C7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEE02402C7
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BEE02402C7
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:45:04 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1fbe461f59so547123366b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786135502; cv=none;
 d=google.com; s=arc-20260327;
 b=lArVEUHIqyUg6YOJqiQp+aF2BCNIsWflCNBCWGSQwUaIuEwn4O8m3gIp6/ydv+ZXR2
 pVNSFnn/IScM0ieuozUviNlDHOeYcrxUR/EuUuo5+AX81RmMl8Cyumw+XdU1TddZk4RE
 HwCDS7/lGknAwdzHyRj3VIECWUua3oJYHPs7wVnNaCq5f4CsPWIWg+zhXliJgLpQoWBZ
 TMjaZRtNR9hnB0y/umI+uogmkc9ShMs09IlfU3+p4gj8kXj4YbfSvnODNSI2DF8qDnTU
 tWXZpC2GRDrgfh5GA93AqQynSY/Sfxls+Xeiw9Yk1vDQNA0p2AbD3XAaCDOVoOTRbgdR
 0BYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0qk7PTEMXrdK7iaV+jAw8j/0QJ1eNVNsa1ZM4tVOi1w=;
 fh=ijpGqnd/DhBct2Cw5aDmEJPs+G5NkZyVrRaaBz7981M=;
 b=bWCTKocZ7IDYysqb5mt02yC/vPV33UABmZq5iYY3AatNYK/C0hVv41pJkRE8zYCpQO
 nMxY14guxrCjUel5IlIW24mm+Y8NnAVeN77Ylx+nDXD45yuMSJsXV2EqjZCeAQiu/R9h
 SavQ/5D4VF3w2UJ1nnbYggtp3HllZni1/EHhkElXgFQsw+5HCigZxoC6ziIyirnrWDDX
 EOGD8VPNYR1kiI33MsYvHyH5MnibM3OC2Z44vPqCAjnrcCjI3NR38rnL4oag+6kW2mLu
 f6cdP5otT2tTyWGsxJxp8EryMlktWRVzZ+wXrajz96MJeb1xb9VFRXfqq2BHoT7URLS+
 PvoQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135502; x=1786740302;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0qk7PTEMXrdK7iaV+jAw8j/0QJ1eNVNsa1ZM4tVOi1w=;
 b=tLqYtN+Tn0uULUgbqL0R0OFC1giEU0yg4HOWYysaO9+YCQoJI31eIQbkMn0JX1o5ay
 1B8gKKf84aEf4N9gcAyQXatUiBYAoT4jNw7o4qS9Ef6oXxJgZ7cJi6NkdBNqR/Saa3LW
 ylu33JbTqSGUABAzLBiNlcuxNzSl8y6vpq9HLfdcDeQbT4j8DtB2BabliZ04Ye3cKtxX
 tQClA2V/K2Sv5sntuaVJXjOb0GFhHIxxe3UpNc5MUkpBUDsIkVW5V7KvrUcxNw2haTh9
 5VSmkqrdJzy/ulBtyuJ2hnD6v0+L3/zLYKxo5R5fiewMp+STzLdS3e25i5OmflUpPpvn
 aTmA==
X-Gm-Message-State: AOJu0Yx2LkXCo4LSqpffRA8+qF/6GE0Dz18OdcOrrvut7hEjGL0DH3U1
 0+mdQYoHv6XQbF598KymcFHYJrHC9opyDZYgV9EkmEcv7h+XdPiLzisfEfy16DZIM5lG0j3i+yE
 id18Nwv19fwwJRsGP7y8E76L6X9R5juZW+/W7Vyx/
X-Gm-Gg: AR+sD13a/Vj2Di9D30JS2/zhOwwwz5l/id/ouMsCnYdlVy+WL1JQ8aBQzmr3ieeXgu8
 8Z2Lvvpui8Od58ZLxbAP5HE6RVlgkz/2FVNi7BCRL9GKA87oF2W6sFyT663BOPsnshQ6w5TNPwF
 GtsRNk347edOvOYYKN5lAa0k3dAd/kW5XMY15NFIHAEKNEOUJc6G4DpCO9646Wg859jT+t5tvdT
 SYExb0V7ZXcrMtQyeHgeoLr+jcj9NYqJrbW1mXRnts/6edaetl+1XxTJn7qf1Me98Qm5EgAC9/V
 L++ZAzMwLCecEPZgi8L5aJ6uluYXi/5XyS3xooVOsJw=
X-Received: by 2002:a17:907:7b97:b0:c20:53c7:488d with SMTP id
 a640c23a62f3a-c207324a87amr648933566b.14.1786135502534; Fri, 07 Aug 2026
 13:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
 <20260807-riscv-full-fit-support-v1-4-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-4-21a34f79c350@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 7 Aug 2026 14:44:50 -0600
X-Gm-Features: AUfX_mxzcxRpmspXKoBdtEbKOif0ik2sBT4mUGwv6wb1GMz2Ofxo6-dkA0612hQ
Message-ID: <CAFLszTgFhbRsDhu+1HkhSCHiEkf8Z8y5Ru9=rJEd4BS1GeQ40Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] spl: fit: Record loadables to spl_image->fdt_addr
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786135502; x=1786740302;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0qk7PTEMXrdK7iaV+jAw8j/0QJ1eNVNsa1ZM4tVOi1w=;
 b=KrRMTo1oHOfyY9yh7wGrZDIAnYuzZOqvd1O6MQys4KWFtP+V3aoBGg0cPg8C0QM7IZ
 A1Et8ZAwpz81TF+hBG+kieIl+P8R8l6oJQnjccuFCZ9dasccB2CPllhKGziIcWWZ+Gdn
 PjzFadkYMejw/2/2J0Kzp16aVNpewnA9iiwgw=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KrRMTo1o
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Nikita,

On 2026-08-07T08:06:41, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: fit: Record loadables to spl_image->fdt_addr
>
> Record lodable to FDT passed to next boot stage.

Typo: 'lodable' should be 'loadable' (also 'lodables' below).

>
> This is required for spl_invoke_opensbi(), for example, which requires
> u-boot/kernel load or entry address to fill opensbi_info.next_addr
> entry.
>
> spl_load_simple_fit() does it, make spl_load_fit_image() also capable of
> recording lodables.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> common/spl/spl_fit.c | 44 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 9 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -1009,17 +1009,43 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> +             /* Record our loadables into the FDT */
> +             if (spl_image->fdt_addr) {
> +                     ulong entry_addr = -1;

Please use FDT_ERROR (from image.h) rather than a bare -1 - it is the
sentinel used elsewhere in this file for a missing entry point and
makes the connection to the 'entry_point != -1' check in
fdt_record_loadable() clearer.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -1009,17 +1009,43 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> +                     /* Try to make space, so we can inject details on the loadable */
> +                     ret = fdt_increase_size(spl_image->fdt_addr, 256);
> +                     if (ret < 0) {
> +                             debug(PHASE_PROMPT "record_loadable: couldn't increase space " \
> +                                   "for fdt: %d\n", ret);
> +                             continue;
> +                     }

This grows the blob by 256 bytes on every iteration, whether or not
the space is needed, and nothing checks what lies beyond the FDT in
memory, so a large loadables list could silently run over adjacent
data. The spl_load_simple_fit() path handles this once, in
spl_fit_append_fdt(), with fdt_shrink_to_minimum(spl_image->fdt_addr,
8192). Please can you do the size adjustment once, before the loop,
ideally using the same approach so the two paths behave consistently?

Also the trailing backslash is not needed (adjacent string literals
concatenate) and 'record_loadable' names a function that does not
exist - log_debug() would be better as if can show the function if
CONFIG_LOGF_FUNC is enabled.

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -1009,17 +1009,43 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> +                     ret = fdt_record_loadable(spl_image->fdt_addr, idx, uname,
> +                                               img_data, img_len, entry_addr,
> +                                               fdt_getprop((const void *)header, noffset, FIT_TYPE_PROP, NULL),
> +                                               fdt_getprop((const void *)header, noffset, FIT_OS_PROP, NULL),
> +                                               fdt_getprop((const void *)header, noffset, FIT_ARCH_PROP, NULL));

This open-codes what spl_fit_record_loadable() already does a few
hundred lines above, just with a node offset instead of a ctx. Please
can you pull this block out into a small static helper (e.g. taking
the FIT, noffset, idx, uname and the load/size values)? That would
reduce the duplication, keep these lines within 80 columns and cut the
nesting depth in the loop.

Regards,
Simon
