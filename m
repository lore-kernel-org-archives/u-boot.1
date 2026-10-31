Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526B606A31C
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m6gYskPL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DhD1xp4V
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4137C8112A;
	Sat, 31 Oct 2026 09:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0gE0kE5EYwPf; Sat, 31 Oct 2026 09:44:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6392B81127
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439857;
	b=rsednogXVmZvWvdHcdcpTVRSBDjWVRZBcjox+4wEVw+qKsOWydMMA4GaYh3WBwSLJ23r
	 9s5D14mImsovgL2u8f2/60pYYqm0L58TnQyJmdjPjvn1wyJLqHsxcYNx7Lq6sRUi6NdSw
	 yNt59clAw4WMWMeSphKeLH9HzMwTJZn5L8oHvLA3OdW3u+5kqyZQvRPR0oGZOtQpkJlA9
	 tTVmStF/K1MzHj8xcQdFC6YQfDWD5OwFL+gygmIicf25Zg1Z/qzi+50w9fLT6tL/uPN/I
	 0L0DdQ6TWi1IIW9iKy4UfUQg3lbfjdqSNM7DvGgQGGi7Wn0X9FOPqO4v0enoRu+E6AQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0m779Gb6/HT7rtEepxOlzOYpF+gbCSANUMiV5Wk8DQo=;
	b=pwe+VnPczIPXuaXP26dhRUoBysh6OWjzvIQjDdSy2MST/FPhe8B8az7JG9xL9fFDpP8K
	 DiuyfHW5VhXbbRKEcgE2SRSedBePriPebQApmj9Egv7RzVyGFzh8w5A30DkzpHvGuipFC
	 Ih4tn2NZgBgqP4QIzm17qFGtBRr9Nm6k8n+yOAbn0XLS20VgpxiONldsI7naxCOoRb+oo
	 ct4QP9p1yJJ2JxHYZGtbYM6VBu0GekoO0UxDOroRbVTOw1lAhX3QBzJ2EtQYaG1i0Fzwh
	 6r4BfIxBtuAoMG9mpYUl6poBaIZDh24lyz9wSP6vST8uEtl+ti++uxJYK55Z9hmjg5w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439857;
	bh=0m779Gb6/HT7rtEepxOlzOYpF+gbCSANUMiV5Wk8DQo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m6gYskPLVHGWAd1O+S+cG4MJJKRXptNoYJvZ07ItqfXmC0MFvb9e2MgQxJN6XwxE1
	 3p17vVou6gLeEAEdLMayCbQ/rCKTQqnnNvqjrff3fjwT3Z65NXsWpYIMuo7Tb4ZXkO
	 bPJyl2RmGqLG0ZPSD+s5IiLmNPEjilrrQG3EE5D5pEKRqIek1g3MthexvmQ5yTShi0
	 gDnbIVMhWkUgxDau0oFQH/OiCxmx3sHxeoaQCL7lFsrXetDnclZqKlWqWLIQzilm8a
	 uOe6B9HbIdaC+k+SVaCCNLbi4QlfXsenlukEqZTAXcZHGylZa1j1rrhtaHxjWpk0SP
	 XOB676peQ/pKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6392B81127;
	Sat, 31 Oct 2026 09:44:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DCFB3362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C9DCA40B03
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 89-3o2sX_jls for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:44:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4E3F40B01
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439853;
 b=awe2zP77qzgKMcl+bECzgQUmpUi1sOfAj94rIU3a/FXA5UA1WxUD0U8jFmLH6roo4T1v
 hPUhwZaxsjKOnEcBfltFtr8ZR59jk1yLiGRoGx2Iv7quEzOPu/1UoBgjinFW8KfmQvfE0
 KhZoU7qaD7+IMHcdeLV3XAL+4/Mc2oKCh6it5hHuT/3iriHiOBYmJ9+zjhoxaWw62gdlZ
 mMMlQpYm3zVXR2Ul16We/HY1Dzp5P4ZmIRFb5PTssrkm9GJ2VR+lI0TJRcPIqAWAdG5DA
 /qx8P2JYh5vk9Nap+cqDTMgcj3GdLECwy+BQV1Lo8wuA/Q95i0F2h1oLXGicWY2Z2Ag==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439853;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=0m779Gb6/HT7rtEepxOlzOYpF+gbCSANUMiV5Wk8DQo=;
 b=IC1ziC97962WJ4MGKHd3oljt7xluYULBep2wrnSFfrjGlM9EEHXo5T73I19M1MJcCNj4
 L7vli78MZff+80BZypf6C4shUdmXuDU9TLbw9kxso982U+GVzsztTG6pXbGiCgNA1D+QV
 BVtFNK0i0w7PMWeeN1ViCBe/cf497z2NuWHm1GAAbG7L+eW+6iMDxi38rgz8xfwTSy2FT
 fiAO+SLZoJB7EdhJQYcru8VO34f1gENfRj2eePePr8qrt7gabb0SaYdXFMtBIX3kfinWP
 vpOXr5RRXzP7uFfOWW8yuLBJIVNB1Hcjw7tyZbCakt2MN2ogyF3lXD6qqFLyRibx3sQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DhD1xp4V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DhD1xp4V
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4E3F40B01
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:44:12 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so240485366b.0
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439850; cv=none;
 d=google.com; s=arc-20260327;
 b=HI5ES1OGXpeYwq9Q5+rN7713HlOgmBEPZAQ37bP5AuHsDcLqQHwOMk0omh6IyWLR+E
 Y/bC01IAskm7ItzY1MQxX555CpJ+Z/Et2koqOfzfJt36ogBEORnNUbjzMCMlsT+KUdt1
 Z4DNMqBjqWNHxCptR1xu1LkhpUvMr0S8ogeLO7RxdxQYJ+f7SR9c/zbFYE2Xy09x2F6r
 4+h24pWjhdo/3wXbquVRf2ukAQnd+DTJia07egiII35nk8z/IZYFoZ/syZtfkomYZqzy
 YcsAtU2QR68UOOybkbSRA3JAOqhwgXZch7b2c1Zl6F1eRtq3nX8iwETI8TCPU/rqzO1h
 ilag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0m779Gb6/HT7rtEepxOlzOYpF+gbCSANUMiV5Wk8DQo=;
 fh=vAmY7hRBdMrkxhak4XNxRo2S+aXYqAOi9P6V2g3HEEg=;
 b=HBPaq4q2pKN6qM5/Z8nf8cf36jU3u+Ept3yhQbl3TPPvUuz56TIepS81kr1zL96elC
 GBM2mJzZvyTJPkQ/EwHb6NKqpL1zLZ6WuXybswHTa3HWiP6XHaO30XZsZqKePFkQAOkA
 ZAV5KjSSzWuzQl36qI/vXL47OHsI5/FLtDUtES4xyLIOQEU64rFYkJRGLIp+IIwSuDgQ
 fSOe4xmWagNF+PlhTwZ2QaX7QXhvox57wn1w1KL6lfUPMkYAmV9Qb/AnSZl4X/Mlc6SR
 VC4+bpH8FD5q9NCXiGxF/4+trZqyTWcFTXQs87jRHEHKQ2C9YfDdwiMALPDJgnmmDSFT
 w2Qg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439850; x=1794044650;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0m779Gb6/HT7rtEepxOlzOYpF+gbCSANUMiV5Wk8DQo=;
 b=DhD1xp4V7vzWMYOhzHZUcQvk/gDKZOiCJ/t6A08EaRYsNUofFyNtnL7W/YmRbyuICv
 /XpJ1Td/8wSeIvAmjH07gxCQIJj2pp8cdgalJ+LGe5Dr5T0fcUXcOo6bjK+keFRAL7FJ
 RYtPolnb+DR+jJyX9EOaoHP0zGySSGveUaoeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439850; x=1794044650;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0m779Gb6/HT7rtEepxOlzOYpF+gbCSANUMiV5Wk8DQo=;
 b=MSHPyvNZNNYGpS7K7hrJo3OjBwkjNXujgh60jXgkU9x10co9/E4wV4v6t92+XlLxri
 q77GNmQ15lCN7CV+zMLeqzfVvCFxqwt8Wz5v9ozldab7D7/KgFI8Z92U/4+ihqSkBKQy
 R6jYnWdMDAZjOs6psN+SNFF3CrOYovufzO1VdVEkl9Nu+eyM9ZZc5vucmMbqSDY/XeTb
 msUZGcfANqVkp8i5YPF7k3MnZidqSKtFLNziQlAxkGYH5PLxlEFvLWYJAaxRIAUS1TLz
 7Nq3pzPbfAHwk3FrmpxQoht0V+H958lmfU3qwIchdtoUz/cL6mtTDGESJtcEpE5xT8KH
 GNNQ==
X-Gm-Message-State: AFq9FYLG9MEmXnuMQKxFci8OfoV+MSWnLE4jcpfcmvsUjGjiUKK5X3cP
 qZf/XyYuj8x3Qt/TeS9F+sVqbOXJ7hbLviGlOppzOeqPPqMWfG8DbwoqR+4TsWOQOAnn7WH4aiC
 UCVzR6uHLRV13YcMdI27HGe6WvGNAohT4SXj6Y5JbHG6/xg+mDTY2Aw==
X-Gm-Gg: AYBFou0QwjdkBPl6Fskg2tCLveOGdTnXpHDS210fNThSnTqRlJ/GO47HtHT3WYAsTeN
 PQJ+dJOoCwydJdREjEDjewh3BEdN4Mdt5Z/ey20yI5QdWvmxWBqz3fu3bgbX9l5Q6z85legQaYa
 zvfI4YUydW7TibV9IVt9SDIUe6X/qfYZibxJ6vG4WNLrEsTRs4xvihH59oTwjqL3IkH06tWFNVT
 J5AvyJTwOpeids0gHKAWlu5QD5Wp0K487Edw7qBDA8dSZ8bfwE3CfdzdeFu0B0am/UHzVBwQfI/
 WORfA6J8cG/4s77XuPanXgs97yUXDVpTDXl/Rz8RSwVgGTVp+TJwXA1BnSg6w1DPH6hLlNUE29z
 Fo68ktwwkb6T4YnaL/evEQLAls70CzU8fS2clj7/Vu8Lu94HnTY+UUxCm5W/zHyA6sR+Moyo=
X-Received: by 2002:a17:907:944d:b0:c43:bf29:1517 with SMTP id
 a640c23a62f3a-c4ca7a4b193mr426970766b.12.1793439850393; Sat, 31 Oct 2026
 02:44:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:44:08 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 00:59:33 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902-riscv-full-fit-support-v2-5-493e904a129e@maquefel.me>
References: <20260902-riscv-full-fit-support-v2-0-493e904a129e@maquefel.me>
 <20260902-riscv-full-fit-support-v2-5-493e904a129e@maquefel.me>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:44:08 -0700
X-Gm-Features: AclHuK8YzicReVovhppuLVgwHhvBRgGpEiUpKvirCbp9Zh5yulcUaX4Ht_SCO38
Message-ID: <CAFLszTiLV=v+bxHgV7tz-o-JEpmRo=9jDxyGZxAXESmfUZJJ3w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] spl: fit: Record loadables to spl_image->fdt_addr
To: nikita.shubin@maquefel.me
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Nikita,

On 2026-09-02T06:31:15, Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> spl: fit: Record loadables to spl_image->fdt_addr
>
> Record loadables to FDT passed to next boot stage.
>
> This is required for spl_invoke_opensbi(), for example, which requires
> u-boot/kernel load or entry address to fill opensbi_info.next_addr
> entry.
>
> spl_load_simple_fit() does it, make spl_load_fit_image() also capable of
> recording loadables into next stage.
>
> One limitation remains: if the FIT image does not contain an FDT blob,
> spl_load_fit_image() will not use gd->fdt_blob as a fallback,
> unlike spl_load_simple_fit() which does.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
>  common/spl/spl_fit.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 16 deletions(-)

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -601,6 +601,17 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
> +static int fit_record_loadable(const void *fit, int node, int idx, const char *name,
> +			       ulong load_addr, ulong size, ulong entry_point,
> +			       void *fdt_blob)

This line is over 80 columns. So are the new fdt_shrink_to_minimum()
log_debug() line, the fit_image_get_entry() call and the last line of
the fit_record_loadable() call below. Please can you wrap them, and
add a short comment on the helper?

> diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
> @@ -1104,17 +1118,33 @@ int spl_load_fit_image(struct spl_image_info *spl_image,
> +			log_debug("record_loadable: %s entry addr: 0x%lx\n",
> +				  uname, entry_addr);
> +
> +			ret = fit_record_loadable((const void *)header, noffset,
> +						  idx, uname, img_data, img_len,
> +						  entry_addr, spl_image->fdt_addr);
> +			if (ret < 0)
> +				log_debug("record_loadable: couldn't "
> +					  "record loadable: %s\n", uname);

log_debug() can show the function name, so please drop the
'record_loadable:' prefixes. Please also keep the second message on
one line so it can be grepped, and include ret in it, e.g. 'Couldn't
record loadable %s: %d\n'

Regards,
Simon
