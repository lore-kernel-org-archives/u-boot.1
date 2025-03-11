Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F238C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8198580FB9;
	Tue, 11 Mar 2025 14:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fVQSlxLZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16EC48141D; Tue, 11 Mar 2025 14:22:01 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA90807D7
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e549be93d5eso4828886276.1
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741699317; x=1742304117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I1HCPd4owMRS9EzQP4dcjEzMBrKOrEEorEy/X13Pc0M=;
 b=fVQSlxLZ6JBCM8iCj5RD/Akqiopch/ohOmABD1lY1dGKn5mHJYBB5InAZRX8xuo6Vi
 DA9jZqqcoZiOGrXIPv2Rj3IkJwZCNDOrxnfJyJBdmGlWsYN8a4lEJLDpPivFvQ5BRTwQ
 8oRz4uIl7xQeeixkK2nBlWFORKfNmaCjtF+w2E2isy8tlA/CJiMdmubrkwzLxPmgLZzk
 NGydE7fEvum5yEUPh1MkDftUxus+XQ494qGUOQm/d1iJnfxN6KQXTR8uN8wmKaZX1EKB
 xBxqzfSarlRej4I+98EueNLH4XQtzchoGzgC56/0xyFcRuot92Kgw9gAWi8z7MCFA+IJ
 xtpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741699317; x=1742304117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I1HCPd4owMRS9EzQP4dcjEzMBrKOrEEorEy/X13Pc0M=;
 b=URKv1QmahID/9+xSXVdwhrm2Bw8WYCqxniO9GK+3LMbhTA3d8ayJQjoWY7ZteCJVcp
 FUH64Hwn9Rl48Eb4UI/NNNa5OvxsHQcEQMSHcU708BBgyjoXzC+A0VOgzoAI6uPAQ7Hb
 P/Oil6PPnHbcqvZXuULu13qzaIj2Q9FLdKZ8bUTLa8n+ZXlh+4eZnGrGKHxPV2nwtpDn
 Vw3Mxu2XFxPK6xCR0CYmQRbOXokQUG7Gr8OboYutKxAO026+en76/tMsMmWxJEH/CP1+
 N4rXzwN3j+pFZd0GiW15SN3VFIu+0KOpK3s4rDg935uxaVNahmsL8ADEmfKQY8cEZ/71
 wE9Q==
X-Gm-Message-State: AOJu0YyD4ABumwO83Uj5tonBUpeS1Im87YSeLLzr20MlAELoHf16yCJc
 nT10e1nN7n7inFzU/PG6zq+gtUX5fU2WAkVOz1A+Qs0LXaUpoBDBuqVfspLH6XnUB7ALMhV0jTa
 5C9eOQKXwJpiesfMs1Lavy46Cl+zyS09ytNVUCYci28N7V90BfBU=
X-Gm-Gg: ASbGnctebYMsBFen/oC+VNOvkpLU3DlgN/5cCEbIBpR7X7LNwKab6qUn7TwhK6Gusm/
 QAvQaec398H6kvSoKEmIjDuBTx+ysD2PpIfUw2hnqvk1TMJ0BmYyYMhIqkbqPMzaGiS5jWHMQmF
 yCCVFKyaIbC1LUehKaJ1ZXXw5JkiI=
X-Google-Smtp-Source: AGHT+IGGgVjNMmXfIejzkCgo5bPzvYTsyq0BQ5jpS0XlWUUVy/ufEf8BZAxMN4JLXabkhTWL9xILwCz8wfUvuDl2p8A=
X-Received: by 2002:a05:6902:200f:b0:e60:a1fc:1229 with SMTP id
 3f1490d57ef6-e635c0f92a8mr24525266276.7.1741699317578; Tue, 11 Mar 2025
 06:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250310115750.1019051-1-sughosh.ganu@linaro.org>
 <20250310115750.1019051-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250310115750.1019051-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 15:21:21 +0200
X-Gm-Features: AQ5f1Joje-PKkpjLpWd9NQvWpdXTyT6npi5wDe3MsTQEs01nrgA477p6iQxEQDM
Message-ID: <CAC_iWjLiufizRnkEYoKXF9kpC1pPzknz5EbsJ50fpE1Bn7YrYw@mail.gmail.com>
Subject: Re: [PATCH v7 1/8] efi_loader: remove unused code from copy_fdt()
To: Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Bin Meng <bmeng@tinylab.org>
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

Heinrich, do you remember why this was originally here?
 I looked at 6422820ac3e59 which moved that code around, but the same
code was there as well

On Mon, 10 Mar 2025 at 13:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> There is logic in the copy_fdt() function which is iterating over the
> platform's DRAM banks and setting the fdt_ram_start variable. However,
> this variable is not used subsequently in the function. Remove this
> superfluous code.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V6: New patch
>
>  lib/efi_loader/efi_helper.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> index 04b2efc4a3b..15ad042bc61 100644
> --- a/lib/efi_loader/efi_helper.c
> +++ b/lib/efi_loader/efi_helper.c
> @@ -454,23 +454,11 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle,
>   */
>  static efi_status_t copy_fdt(void **fdtp)
>  {
> -       unsigned long fdt_ram_start = -1L, fdt_pages;
> +       unsigned long fdt_pages;
>         efi_status_t ret = 0;
>         void *fdt, *new_fdt;
>         u64 new_fdt_addr;
>         uint fdt_size;
> -       int i;
> -
> -       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> -               u64 ram_start = gd->bd->bi_dram[i].start;
> -               u64 ram_size = gd->bd->bi_dram[i].size;
> -
> -               if (!ram_size)
> -                       continue;
> -
> -               if (ram_start < fdt_ram_start)
> -                       fdt_ram_start = ram_start;
> -       }
>
>         /*
>          * Give us at least 12 KiB of breathing room in case the device tree
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
