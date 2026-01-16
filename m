Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE41D4A619
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133FC83923;
	Fri, 16 Jan 2026 11:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vOaj/wuG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE94D83956; Fri, 16 Jan 2026 11:01:33 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89D4F8309A
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7904a401d5cso19694297b3.3
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 02:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768557690; x=1769162490; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4qu9B8khwtGq7Q26S032+z1PKICTq6vIsvwzmYb08Tk=;
 b=vOaj/wuGbdEfS4LD+24Cix2gWzczeQtoInQ9Gdi0ndmfmY8yWQ18MSG8vXuNuOkVG5
 TMJq3BIP9z9YtiClCK66GN+ni0ZOND/9PeO5QlBtIroLWS/1w4Hygk0mWKq5Qv0LSKSK
 sAv/mACbaL0L5Ct+ggigsTYV1EwzpRTeJ30P3LqN2C4axm4ZZF7ZIDz0r1tPNQabSbv5
 TJS64cI+2NqcIzhL4J+F1UU1HuzANdVfT4TZCbq8PcL4JX/uEukJLW4P/Yi5JUBChWkM
 rNrLwMgnBX8cw9KpvjBMQ8Z7Q/NlXk62fzRqOAjGJHS/a6RKr1XiOIapi52O3Jwb4ekg
 m3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768557690; x=1769162490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qu9B8khwtGq7Q26S032+z1PKICTq6vIsvwzmYb08Tk=;
 b=Zudl5MuB8INdAz/e81a5wAeLv936Rx10igJio+/Dm389PMUze3mRCUFo3wLVCYV9wz
 AvWNPtzOveBR7hc1R2Y6BjcGEm7xUPRbK1msw0nORtwob2fIycoEPqjoZt8Sjw0YqPDm
 PJlTK0/wUy/NV0pnJhuuIkHpyQkp2WbAsOhCTxBovJRgxt7XmYWbCz/fsj/q51YBd75w
 QjGwPeOGx1hMPg6S9BZ5cNvIh6+qqiCURDHEECbHWlngfCpX3ZMZRW8z6EUjqxLp3PAg
 4QvvTzHLQkxvYmvGf8f/eplU1V+i3lLXBEpUnQDGrDiu3OCszF04JxxIOWzNogoucu2s
 pz9A==
X-Gm-Message-State: AOJu0YznV1bVjFr4V1NKSwrKBoutEeCM+8z4EGmDAWfH5PbvrobmdEvG
 XlFyb5AqoGXJlNmSqAP7RONZTA+sJjs3IWlFDInZzcpk682jgzKEeKs+7INZyg3cmeVnKh+m8IO
 5KB978QmdJyqJwItYoVuGVycwCdmOn9rLcr2XtFTHVA==
X-Gm-Gg: AY/fxX7ippP9/iPOB7RjeGvlF5y/6o3xyBrw4VM40DeRWxL7oGlEC3FJR3ZvvurDR5B
 ymDED4qVkfe/pq2QISdGhlf5FoDDEMGUDe9Y72fAV/O49d4d8YQ9XuMuHHSBOGicnn3PyeABJll
 VxnDtSTBW6junECQv7aBv0lNFZ0cPg2hmKUrBEGaWqExoNSGUPluzTsp/QAlG774O+tcVGmTTed
 C/KErSOOhyfqD+02lOZmwiX1wt6JwODTDGKm8d81k78wobSzQ1pechzq5EcPJuBPrx0JEGWLr+T
 ZeSh5CV56aWRBwrlNN6tZ/GXBk396FFP9Z5upxiF/AytM5RD4o9p+jGV2sgYrBlZBramBjjncGJ
 3aFLZnzd0DPsbS4q8QN08ZSogC8jh46smag9zmHe2w6hpHS4BA7JpXxunuOHxDl3lbhMxNR/KSp
 y0/ZrelXWdbSlKXYgmBrPIhwHjZuRiCeP7Yhgfu1hOXmq53w4M5G0iAipdUcb5aljWvL2bKCiBa
 8WBOGGE1LxUnCRSCyy1oQmKS9H3tOoMRkRyjD4VmTFVOvEG38pS2uAhPORGYocAsD/eVKsOBN95
 7aLQOXd4YRTRjfP1C/zqhyVV0upgs+uo
X-Received: by 2002:a05:690c:9a11:b0:78c:6a2b:c6aa with SMTP id
 00721157ae682-793c53c6a92mr22292657b3.58.1768557690349; Fri, 16 Jan 2026
 02:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-7-trini@konsulko.com>
In-Reply-To: <20260115222828.3931345-7-trini@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 16 Jan 2026 12:00:54 +0200
X-Gm-Features: AZwV_QiG7B_PuE0RJ9MT1HIcQOlgxzmYDutzAdVSCp443B9KyRy-bTyQYFqsds0
Message-ID: <CAC_iWjKJdEsoNmgh67nE4Ng0-u=dvSomRjh89sp0HFaq=UjJNg@mail.gmail.com>
Subject: Re: [PATCH 06/10] nios2: Update linker scripts to ensure appended
 device tree is aligned
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Beleswar Padhi <b-padhi@ti.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Chou <thomas@wytron.com.tw>
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

On Fri, 16 Jan 2026 at 00:28, Tom Rini <trini@konsulko.com> wrote:
>
> With commit 0535e46d55d7 ("scripts/dtc: Update to upstream version
> v1.7.2-35-g52f07dcca47c") it is now a fatal error to U-Boot if our
> device tree is not 8-byte aligned. In commit f613a6e15ef7 ("ARM: OMAP2+:
> Pad SPL binary to 8-byte alignment before DTB") Beleswar Padhi explains
> that we must have ALIGN(x) statements inside of a section to ensure that
> padding is included and not simply that the linker address counter is
> incremented. To that end, this patch:
> - Aligns the final section before _end 8-bytes by adding '. = ALIGN(8);'
>   to the final section before the symbol.
> - Remove a now-spurious  '. = ALIGN(x);' statement that was intended to
>   provide the above alignments.
> - Ensure that we do have alignment by adding an ASSERT so that when not
>   aligned we fail to link (and explain why).
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Thomas Chou <thomas@wytron.com.tw>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/nios2/cpu/u-boot.lds | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/nios2/cpu/u-boot.lds b/arch/nios2/cpu/u-boot.lds
> index 5b9e27d94062..fc366d44341d 100644
> --- a/arch/nios2/cpu/u-boot.lds
> +++ b/arch/nios2/cpu/u-boot.lds
> @@ -60,8 +60,8 @@ SECTIONS
>           *(.sdata)
>           *(.sdata.*)
>           *(.gnu.linkonce.s.*)
> +         . = ALIGN(8);
>         }
> -       . = ALIGN(4);
>
>         _edata = .;
>         PROVIDE (edata = .);
> @@ -124,3 +124,5 @@ SECTIONS
>         .debug_typenames 0 : { *(.debug_typenames) }
>         .debug_varnames  0 : { *(.debug_varnames) }
>  }
> +
> +ASSERT(_end % 8 == 0, "_end must be 8-byte aligned for device tree");
> --
> 2.43.0
>
