Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1824C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 15:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 149FC806FE;
	Wed,  5 Feb 2025 16:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="meO1oEPr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA00F80762; Wed,  5 Feb 2025 16:25:13 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB43180562
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 16:25:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f9d5f8a4b9so2410040a91.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 07:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738769109; x=1739373909; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NEJ/zcQWR5iCRkH98gmrNkYdW96iy/TWTnc5iQKd+FQ=;
 b=meO1oEProDLAn5ek1vEdYodj4MlRDeEGuDYWUEHSxKnQSMCEC4ab06hUUSmZnay07I
 k3qyMjnx0k4a+tqywpH39/JBc15hni2/AA5jd1xEZwi+/eL32pADF/PCXYVmgP/KFFgr
 Y8tAyGYTE9jGfxWU+RheBabG30evVKtmxMGUx3whabvs5ZsrMxisEkKFxJQENAH+8byz
 zeVET0J7ttJPAOgErJfZWzJIShj4kU6/2270gPPqNc0RiE+DxYHzVb5un+Afh3L3NCQT
 q37g2F6PEt6qHQK9B4r/iWeACQ6GZP+R4Je/oRp+IrVusBEOK4gTg7nm65rr5wAa9O5u
 AyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738769109; x=1739373909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NEJ/zcQWR5iCRkH98gmrNkYdW96iy/TWTnc5iQKd+FQ=;
 b=t2BqFPXNvRjmZBmYbSqOFQqbMBr+Iguj/0w72SxZpsjKQOBS8+pBr8/3uOHq+Ifi0B
 k5g9nvnbfXX0ksrEnwHMmIKF3ikrths9Ryerdo496Ox8o5RPgrQe8T8bkgbUECCQbBfT
 T/vLC4jVXYaRP93mYI0WZapLC/CniML2t/XycjsBmIFGa5/piRYdoQdMOVPbL2s2KCnb
 88LyUgIObpgISpkmWx3J4x+UU6Kh5kbQFcHscpw0wfaBZdAQILMvU9R7kHOLD2/wnhWH
 m43UrJZjY+G7WhwOhTD8Eydjj11O/tg5ho+UkekfmhhlOeUq+0wCge91noeQcDDviCSm
 1AFA==
X-Gm-Message-State: AOJu0YzcC/cTN+fdy72/RHZ/kQjk1QS01Ih86nZQr5p2po+mLm9TebRY
 sLRigdrR4JJr4Q1x/2gcHfJUs51iA68X08OIwHkuSwYjCjF3eDD7vZPhONZZT0tuCWRvA0Id9ky
 RRRiOWyFUDLK8NhyF3zugtKlME8PYq8fpUUT7wYjiV721QZW5r9Iotg==
X-Gm-Gg: ASbGncv8LUJlrFlW5q2mDtIrivta4ExfF7Q1TF5e9c1pxmqfoloDAvdCBFMlK7BENMx
 sQeoQ+DolOEsQl1FulJS9SBlrpi82Kl8sSKpthwdLm1vtQt7Hj6KF2wxWTapB90lUUAPuxYpmxB
 hB6ubFlWy+GCGn4y4Gx4CGDFKuOpNI
X-Google-Smtp-Source: AGHT+IFznn70XWD6ya3xYhDHgdabCX81RIKbsmigB33oN0s5rr0ZQ7WRjJr4tRTPcDRV19WtDu6rpyBov2MKnV8tUHQ=
X-Received: by 2002:a17:90b:1c03:b0:2ee:d63f:d73 with SMTP id
 98e67ed59e1d1-2f9e0760646mr5550816a91.11.1738769109056; Wed, 05 Feb 2025
 07:25:09 -0800 (PST)
MIME-Version: 1.0
References: <20250205015606.2686149-1-sjg@chromium.org>
 <20250205015606.2686149-29-sjg@chromium.org>
In-Reply-To: <20250205015606.2686149-29-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 5 Feb 2025 10:24:57 -0500
X-Gm-Features: AWEUYZmK3LdwX5vtFX42RpmVeTtq2rachviH6a1-1e3b54jYXBT4L2Tg8GnA5uM
Message-ID: <CAEfUkUKoe+1LQaqOUb8_1M5yy8ELr=jG66+wRd1b3Oq5BB2bSA@mail.gmail.com>
Subject: Re: [PATCH 28/29] Revert "bloblist: Load the bloblist from the
 previous loader"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

+CC Ilias,

Hi Simon,

On Tue, 4 Feb 2025 at 20:57, Simon Glass <sjg@chromium.org> wrote:
>
> The logic of this has become too confusing.
>
> The primary issue with the patch is that U-Boot needs to set up a
> bloblist in the first phase where BLOBLIST is enabled. Subsequent
> phases can then use that bloblist.
>
> But the first phase of U-Boot cannot assume that one exists.
>
> Reverting this commit seems like a better starting point for getting
> things working for all use-cases.
>
> This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
>
> https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>

If my understanding is correct, you want to add some logic to control
when the U-Boot should or should not get the bloblist from the
existing register argument.
But xferlist_from_boot_arg() should be called when a valid register
argument is there, I didn't see this in your patch.
Maybe you plan to do this with other patch series, but simply
reverting this results in a breaking of handoff policy and the
firmware handoff won't work.

Regards,
Raymond

>  common/bloblist.c  | 64 ++++++++++++++--------------------------------
>  include/bloblist.h | 10 --------
>  2 files changed, 19 insertions(+), 55 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index e8acfc74331..7eda94ecdf9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -487,57 +487,37 @@ int bloblist_reloc(void *to, uint to_size)
>         return 0;
>  }
>
> -/*
> - * Weak default function for getting bloblist from boot args.
> - */
> -int __weak xferlist_from_boot_arg(ulong __always_unused addr,
> -                                 ulong __always_unused size)
> -{
> -       return -ENOENT;
> -}
> -
>  int bloblist_init(void)
>  {
>         bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
>         int ret = -ENOENT;
> -       ulong addr = 0, size;
> -       /*
> -        * If U-Boot is not in the first phase, an existing bloblist must be
> -        * at a fixed address.
> -        */
> -       bool from_addr = fixed && !xpl_is_first_phase();
> -       /*
> -        * If U-Boot is in the first phase that an arch custom routine should
> -        * install the bloblist passed from previous loader to this fixed
> +       ulong addr, size;
> +       bool expected;
> +
> +       /**
> +        * We don't expect to find an existing bloblist in the first phase of
> +        * U-Boot that runs. Also we have no way to receive the address of an
> +        * allocated bloblist from a previous stage, so it must be at a fixed
>          * address.
>          */
> -       bool from_boot_arg = fixed && xpl_is_first_phase();
> -
> +       expected = fixed && !xpl_is_first_phase();
>         if (xpl_prev_phase() == PHASE_TPL && !IS_ENABLED(CONFIG_TPL_BLOBLIST))
> -               from_addr = false;
> +               expected = false;
>         if (fixed)
>                 addr = IF_ENABLED_INT(CONFIG_BLOBLIST_FIXED,
>                                       CONFIG_BLOBLIST_ADDR);
>         size = CONFIG_BLOBLIST_SIZE;
> -
> -       if (from_boot_arg)
> -               ret = xferlist_from_boot_arg(addr, size);
> -       else if (from_addr)
> +       if (expected) {
>                 ret = bloblist_check(addr, size);
> -
> -       if (ret)
> -               log_warning("Bloblist at %lx not found (err=%d)\n",
> -                           addr, ret);
> -       else
> -               /* Get the real size */
> -               size = gd->bloblist->total_size;
> -
> +               if (ret) {
> +                       log_warning("Expected bloblist at %lx not found (err=%d)\n",
> +                                   addr, ret);
> +               } else {
> +                       /* Get the real size, if it is not what we expected */
> +                       size = gd->bloblist->total_size;
> +               }
> +       }
>         if (ret) {
> -               /*
> -                * If we don't have a bloblist from a fixed address, or the one
> -                * in the fixed address is not valid. we must allocate the
> -                * memory for it now.
> -                */
>                 if (CONFIG_IS_ENABLED(BLOBLIST_ALLOC)) {
>                         void *ptr = memalign(BLOBLIST_ALIGN, size);
>
> @@ -545,8 +525,7 @@ int bloblist_init(void)
>                                 return log_msg_ret("alloc", -ENOMEM);
>                         addr = map_to_sysmem(ptr);
>                 } else if (!fixed) {
> -                       return log_msg_ret("BLOBLIST_FIXED is not enabled",
> -                                          ret);
> +                       return log_msg_ret("!fixed", ret);
>                 }
>                 log_debug("Creating new bloblist size %lx at %lx\n", size,
>                           addr);
> @@ -559,11 +538,6 @@ int bloblist_init(void)
>                 return log_msg_ret("ini", ret);
>         gd->flags |= GD_FLG_BLOBLIST_READY;
>
> -#ifdef DEBUG
> -       bloblist_show_stats();
> -       bloblist_show_list();
> -#endif
> -
>         return 0;
>  }
>
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 1e1ca34aa92..5063ab66e4a 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -482,14 +482,4 @@ static inline int bloblist_maybe_init(void)
>   */
>  int bloblist_check_reg_conv(ulong rfdt, ulong rzero, ulong rsig);
>
> -/**
> - * xferlist_from_boot_arg() - Get bloblist from the boot args and relocate it
> - *                           to the specified address.
> - *
> - * @addr: Address for the bloblist
> - * @size: Size of space reserved for the bloblist
> - * Return: 0 if OK, else on error
> - */
> -int xferlist_from_boot_arg(ulong addr, ulong size);
> -
>  #endif /* __BLOBLIST_H */
> --
> 2.43.0
>
