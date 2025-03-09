Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B94C282D1
	for <u-boot@archiver.kernel.org>; Sun,  9 Mar 2025 08:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B380B801DE;
	Sun,  9 Mar 2025 09:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H0BFZ0Ga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4BE580F0B; Sun,  9 Mar 2025 09:45:49 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9693D80107
 for <u-boot@lists.denx.de>; Sun,  9 Mar 2025 09:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so2544289276.2
 for <u-boot@lists.denx.de>; Sun, 09 Mar 2025 00:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741509946; x=1742114746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yzGMmFm+mi1yPm92MBOZpMDAhz1S0b9eAd46iDju3nc=;
 b=H0BFZ0Ga3AR33e01ARVfBTPFJwqV8dWPofCUhi+6EP5bz6O68d6WjGwZL1+/PHkhxe
 xf9d8Gs9hRFV/SSCHbdNMdruclCNl60kaU/gjjchfyhZtUa3VUJ9cJYKNkDqOqRceb+Z
 g92w2asKHMG1tGf5MaN+5LrVnLPjnLCJYdOCiCb/vfz2yKQH9gPYHup7DDFyiJ+/oE2v
 HKDMJ4ZdtgfNU8Npa9o1vB+A9cuml9qfcBYR9RvcO7sT1LvY9bPPPn8jJbaYM6oSby3m
 U57W/KYO3+N5nQnkU+3gl+WyZEuNLWjK2x55JBVHztJkiM1/pjRB/oSxhRgOPKrG/z1q
 nM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741509946; x=1742114746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yzGMmFm+mi1yPm92MBOZpMDAhz1S0b9eAd46iDju3nc=;
 b=CuYcZDq+qVRz1wtdsJAxrbYxakR99GNmSnyRFU83Nx/3mKxi3ZmA/Brzui3ScHSFZs
 THfz7ynodWtGJLnxv4yoxaUPHxtOjayuVXi7MTIEpfHoNEwlDyaXR01V5Aty2raLlL6N
 BD7+/KA/LjmaqzsBDbkGgNgdsG/A8eYHEAlvn40/xyL3uxExkYBmfv0zsBj3d/j/6OmE
 F3G68CRdPUlSidvVI9gXdQDzbs9Ypu8hchOfft9BhuufuyjbQWogJSu3wtiCikviZZ8Z
 8dWgjHy81hBipMXH+Tu3UCnf5Q3BwtOWhQCFzj98bVkHvq6AYQgFjQilm8pTCcwSgagi
 3PyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpAX7jezlp3Vzg+DVX9vgrujRbpP2dePZOqH3+gmBCF8Uimx6Y3HDLPTVbpgFs4LdXKmC8hQ8=@lists.denx.de
X-Gm-Message-State: AOJu0YwXR+zkE2SSlYP9ZRhb2+h5JjN1FFipBPVAuaMNixZLDhSbUQQl
 jPzXEzwLhJ8UMBdvBKZRbSX0Zthcgh+0x5lo9kjRc8pYhkD8gAZkJIK1aFYlFP6Eikg5T6AXTBQ
 nV0zrv7M++BBdCDQrXAH9CthoyA/s+WwFqOy/3MWX+V6qEdavGFc=
X-Gm-Gg: ASbGncuMiwToYGQJ3OH13ZFuF/XZu2LZnJC/5cMnkeIaj9uEWmMdoizTg/bpYwqvcnd
 F7biBaErlZIOvgIItSWOEGjikDVdWUMuDTc19HoY7I1szJL55feFdyqgflowkB9xDCGdDygHzoi
 KxIY5BWdwMdy8z4BG+/J3Z/4mhVWA=
X-Google-Smtp-Source: AGHT+IHhCqUb79icLjLfpTtJWazp4IEPnbim6XIM8VcuOYLDzlLKzkJoP/9idB2rAlI4R7D4h4ekJU0VBV671wDcPBk=
X-Received: by 2002:a05:6902:2609:b0:e61:83c:d848 with SMTP id
 3f1490d57ef6-e635c1897e0mr13008651276.22.1741509946512; Sun, 09 Mar 2025
 00:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-4-CFSworks@gmail.com>
In-Reply-To: <20250224055524.1334929-4-CFSworks@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 9 Mar 2025 10:45:10 +0200
X-Gm-Features: AQ5f1Jr20_u12NgFyBk-eBqLVWm4aEIHVj_0Nk-5PIm2tTig5LxnFzfCb8SlHHA
Message-ID: <CAC_iWjJ0_A6w0N9+yBc6KGCNRfopxtJ=q037OS1k3ie0oSz7_A@mail.gmail.com>
Subject: Re: [PATCH 03/17] arm: Add __aeabi_memclr in eabi_compat
To: Sam Edwards <cfsworks@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de
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

On Mon, 24 Feb 2025 at 07:56, Sam Edwards <cfsworks@gmail.com> wrote:
>
> LLVM's code generator will sometimes emit calls to __aeabi_memclr. Add an
> implementation of this for LLVM compatibility.
>
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  arch/arm/lib/eabi_compat.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
> index 602efe04c04..e4190c049a3 100644
> --- a/arch/arm/lib/eabi_compat.c
> +++ b/arch/arm/lib/eabi_compat.c
> @@ -37,3 +37,8 @@ void __aeabi_memset(void *dest, size_t n, int c)
>  {
>         (void) memset(dest, c, n);
>  }
> +
> +void __aeabi_memclr(void *dest, size_t n)
> +{
> +       (void) memset(dest, 0, n);
> +}
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
