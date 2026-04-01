Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E5C10FCACC
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 19:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44A383CE3;
	Wed,  1 Apr 2026 21:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Wf6+V8Y7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22D3783D8A; Wed,  1 Apr 2026 21:59:35 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA6980517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 21:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66bb6eb28acso334137a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 12:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775073571; cv=none;
 d=google.com; s=arc-20240605;
 b=fv0p8pWrLlK4UfPHTVB/pY02OpSIokaB4kb3h9cLGRfd5gLfnxmJ0Rm901sybB/Lme
 q7hjyO9y+uTjSLHiEiZUS1FXFloFf7CUorGddW8XYx2GtaZBIZrB7s8dnjW0+xEs0rzT
 z61XP5ttt+xiQpoVUq4I2I0JxzqzY4c1Jo0sHcXzn/vCQq+Wp5dCSlOrMs4c+i82yZOe
 q1gXw4qns8PR7BJaNTWsz94YmFaZo7V7AJHpkKH0F8sUOjv/khSW3YJ8kxQ1wPzq7OHg
 ooKzikhjWbZ5KuquC33J7oa3/CHfpwI1AIrGUr+yZUjx9wmponEkeRLFAQtQkhpdmfdR
 8vvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=V7ck+kJ79bYVNQ3rhpY9GJbz46SxAjD1AZHxIHIQhRY=;
 fh=70qyz+Idt9wiBIzlKAgthYxXp8N7URjol3SZ6FGdTgk=;
 b=h0iI1BraJtCB8EqFg4TaON4pWZNU97F9+h+dmPO6xUnyO/fRUX+p44QOrnUM8hApKH
 ikJfQs1Z+ycidGXXa6e2y8+01PQUnnlMDvluc0cgyzdo4n4Jco/JkJiCQ5swOMDgCT7A
 3lWMICdRbM1Gri41/Fy+WtSOCNfTfFPWZcguReX5+90QHoEJXcAVoxveml5pm85nLwpi
 RBgYoaTVkv5+Ke3aBDQzgpqzQdnJhVKirEOwY7724UZPYZJ71n7C07HWSydrEaGp9CVr
 EHJ6mGMvZOYn7AUa6EV3IpVH2/VFy0jecvAzyKON6IWpTJrgZxtksqH3STgIOL6TZL3h
 pvgg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775073571; x=1775678371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V7ck+kJ79bYVNQ3rhpY9GJbz46SxAjD1AZHxIHIQhRY=;
 b=Wf6+V8Y7qkbqHCxmIPavWLOKQk61k7mcOeFCAKCD+5mLlvHmurYvnupf8HKRDhtgkP
 8DfF0TIEVghhedlWh73klk4gy1mdvXcrSP7vrHTBLe+Tbjix8sJ4F1Nm5HCVB5dxmrt4
 TqFgNfDtv+1PjkNUvuZmJBQNvSo/OgjebASZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775073571; x=1775678371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V7ck+kJ79bYVNQ3rhpY9GJbz46SxAjD1AZHxIHIQhRY=;
 b=EbHfmkFvtl+5zsg8PCx4gq7wJ8MDFFpG401wvGTgmOlpSPMqqSloADR0nN5RjJwW0G
 IXpbHauWdctMT9qfWi4owfUbodklXC8OZvPbx5F0iLnhn7oXxyMZQ2Y7UBmOG9awz5Lp
 J8YjolKV4Pwkcbd7YVlyrymU+gomGt3+G/39etAYtd6EPK1qkwX3NkACHqbds6Xpu5j2
 M/JFB51Yxy1mV7FRJDKxJNBwWgHC93jx8DYVZdZJ7tW+z2iqmZNYysQLVR8SvKAtYt2S
 7eo4QYDlQiTh7xNZU3XTWw03h3RrXwbOSS/3vY4vacSbniT57JeKpDl11YA8sN+E8k4p
 eYZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWONXBXVQIHJENH92qq7uwICoBiWiMnoZ9rn/pnRbHLI9TrO4LWyhd8pNNSTUJK5H78xdXAnw8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8fioz503IND+fdzCdU40cCqyj1JowQY0LT/mJ48aQJXL/xM/A
 35vqaDSHgHCnksegr/vPbBjTD4UnHJp0UyMMHWYU3E4GoN5Rjft5mnOxUMMD+PMgezDMRL7NSy5
 O6e4iTyQ95eTa4oGoiDXejoajp9S0l0u3tnk/n8mY
X-Gm-Gg: ATEYQzzP0M185otMljjTRyQCG2hUNjWwKM5SsDmVEfmTLOMFDc2YE8LczZuFzcwZSbK
 1nU7RJitNzbr8jUdw9kfYJ7Ye1IpZpvoYlqC9z0+DYn1MX+Fyl8ZKU1peI8OAVR5Y2dwUZ19xTg
 vcT1StoObLK5p7Fz3TTQ2mtjfKLjPBTUE4Yu+xktBR11v4cL0wG/3h/KAZgsc+K9BZ3wAOHpSyx
 PiX5r9kO2NpDpsCWIwch6qbhZHO10YP+m+vH7khn4ro4Ct6MbaHnaexSW4yIXRvbh+uanZxb1Vu
 6FuA0v6bqFHq+8zHMtedETaw+YiR58hS9MvdvRyOrolvp51A0Q==
X-Received: by 2002:a17:907:2da6:b0:b97:cebd:8273 with SMTP id
 a640c23a62f3a-b9c3f117448mr30375666b.24.1775073570859; Wed, 01 Apr 2026
 12:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
In-Reply-To: <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 15:59:18 -0400
X-Gm-Features: AQROBzCVz0WQf5J9RIZpeEk5pYaguDjOMibncHvd-u8H2ZCKjbwRrGY1mlv3Ggo
Message-ID: <CAFLszTgW7DDPesNt1o9CMQW7WN7zN3BqenjDdwENQbQQc0j6KA@mail.gmail.com>
Subject: Re: [v2,4/4] common: Allow relocations on the top of the last bank
To: ilias.apalodimas@linaro.org
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

Hi Ilias,

On 2026-03-31T08:01:10, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> diff --git a/common/board_f.c b/common/board_f.c
> @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> +             phys_addr_t old_top = gd->ram_top;
> +
> +             ret = fdtdec_setup_mem_ram_top();
> +             if (ret)
> +                     debug("failed to relocate to ram top");
> +             ret = fdtdec_setup_ram_size();

If fdtdec_setup_mem_ram_top() fails it will restore gd->ram_top to its
original value and return an error, but then fdtdec_setup_ram_size()
is still called. That will recalculate gd->ram_size even though the
ram_top hasn't changed, which seems inconsistent. I think the two
functions should both succeed or both fail.

Regards,
Simon
