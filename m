Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A44D2E9DA
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 11:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B6889366;
	Mon, 11 Nov 2024 12:15:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PmGZG/hW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC678936B; Mon, 11 Nov 2024 12:15:25 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A533788F8E
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 12:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2e2e6a1042dso3521877a91.2
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 03:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731323722; x=1731928522; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X5LmZmxcLSfVrRTae+pscOVfIAEqhriVN/sWSA99zN4=;
 b=PmGZG/hWUbkHisVsCRmUt+62+Rq91uukIrThVF1ZQNzZ3D2xzakLmyU6jdP3YoNjkv
 jJvl+55oB96NdQaEdshdL3efRe2p4l35CY+Ml9iVh9oJD/V1BPFTFYj4yJXaq+gwrDHb
 4ybJ1a4qrzjCbAqcd4ItENo+w8yBiFyzg8KGoeXb0QvS2YMgZztzlzBSDVmyq2738JpS
 4KEel0M27JhkMdxH/icOVuhItIYGj7X8CHo0IET7CdAAyPgct6mDH2oF35XwOKUYOZpx
 vFtt5/wX+FqaMVguUhQl92oaeUgL3J9vGSkBEzBW+3lXUoE2TK9Zb2nLGuj18z8WJQ/T
 unUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731323722; x=1731928522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5LmZmxcLSfVrRTae+pscOVfIAEqhriVN/sWSA99zN4=;
 b=asfoUo1dKQIw+spejQhrwqSsf3Wm/O3ZVC6M1n60B0UnbMoPufaF+Ho4yQAoNpil6d
 vDJx6P25cyeU960X7tx9/J5jyRtcSECq86uJlI7ALSpfzfSt90Pm10kuGz2MZrDAWjXc
 8sxR3O6kAnH8fy5wLkSzpsmQqFnrTpF+Pnr6bWm0LeIRLrF1eq0rzqdZ0T4oE8JqiTIo
 1pngi4whRQMDXJWDbWLkMee7wJIF/3Unwclo0VCadlYp76FW+Pby2OY4cuevQ1CoasfV
 RwEAufYU4BU9qNHklMRSx8gnlrqHFPz6v9syMIalK+JKE4TkuFXU11k4uHcZqkEOoJ9t
 ybGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDpZmHiVUN/NbjpEwjK8vFisoO9HJHxevQp0vD0kh9xJITkrAMVnkAqDsMaClDBDya7IWxfxA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1XqKbHUF7Bo6WJgBOu2b310cfOVt+a22EGpvcd+cxzsCTbnAj
 61WRFiASqPI2Y1I6F9IPMZD6qoMVEvlkF7/P758meT+P4uhjXW8cjS0uNCXE5UZRxGULC1xj3VY
 QxRd590A0M1p4ky5bIUu+t3Jwvh20EddFivXJPQ==
X-Google-Smtp-Source: AGHT+IES1D51RgEs7pdL0ZbhQTQkMVqU6PA5qzA81qFRlmrmV+QM/tcHDn0KBndg9oaijx3OoDwK6H+nhaCJJ+eh4M8=
X-Received: by 2002:a17:90b:4b88:b0:2e2:c681:51ce with SMTP id
 98e67ed59e1d1-2e9b16e552fmr17245950a91.1.1731323722057; Mon, 11 Nov 2024
 03:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20241102102737.107531-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241102102737.107531-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 11 Nov 2024 13:14:45 +0200
Message-ID: <CAC_iWjJ3d7qtw76M2aWHwRkzBg7F_nJnAjg6Td0_PtkqFQXL_g@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: use memmove() for overlapping buffers
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Sat, 2 Nov 2024 at 12:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The behavior of memcpy() for overlapping buffers is undefined.
>
> Fixes: 4c57ec76b725 ("tpm: Implement state command for Cr50")
> Addresses-Coverity-ID: 356664 Overlapping buffer in memory copy
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/tpm-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 59e6cbafafa..ad2b5ab0c32 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -821,7 +821,7 @@ u32 tpm2_report_state(struct udevice *dev, uint vendor_cmd, uint vendor_subcmd,
>         if (*recv_size < 12)
>                 return -ENODATA;
>         *recv_size -= 12;
> -       memcpy(recvbuf, recvbuf + 12, *recv_size);
> +       memmove(recvbuf, recvbuf + 12, *recv_size);
>
>         return 0;
>  }
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
