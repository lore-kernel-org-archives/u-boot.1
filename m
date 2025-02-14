Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71B3C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 13:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636B580756;
	Fri, 14 Feb 2025 14:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q/sVJJAo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88AD180C83; Fri, 14 Feb 2025 14:49:51 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43DF7806FE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 14:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f678a27787so17991477b3.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739540988; x=1740145788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=thUDEP2dkKl4MHjrHMk2k8hS8eltBdfsdq3bquDqf0A=;
 b=q/sVJJAo6fzlCPVxSs/jXlnLC4FqVWYZnMCd9///NUF/EZNEQAcZ6jfHvoj5DsrquP
 O1KDuVK762Js3egRZDk1AEXrCBbEykWzWZdqMifYNvfnL9MWFLmTOrAbmQVm2bI0QgWT
 hHG+tTfhvIFQcQvqsC2PNRA44QNDjVyGHjg7HDc5wny0jCJXfTCNkCfjWxNXuXNl0tD9
 gnhFHNJ5Z1owI50uhjtJlIZAZssKmhkcp1lvKWUFAHQJ/XvFTkm+p+L6Bcp22nrrn91T
 EIDcAy7/LMZMoOJtzu5Qhmd6+DyiV+05S/dF13plA6UdYRe8EJroK7M6qaHoNKY0O6z7
 0yww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739540988; x=1740145788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thUDEP2dkKl4MHjrHMk2k8hS8eltBdfsdq3bquDqf0A=;
 b=lkkOZp100HuywT0f1Q0w7YrL0hRiJzCRRttKOJ4E0hvNM5q7iL4mfyzces6hqkR3Um
 NpcD0aWNCiTQ7EOsmSqTonaY3CoNGbDzAfzqFZ89c4KijOobShixhyyq/YIJYhWQbgFN
 qeW9QwMM4eDWS2tLeWFBgDUl5GkpBiF6JDguvWZp4RM8nQkAgQoZDQap8RuT9rv93wQ7
 o/G2SUmncRlLYo0WgSCjWn+zkaMQvxZc84XYYCgXQl6W2XN+vO1y/Bhp1dMMTX977B1d
 hcFBA9iHTVlKKLi1gne6vdL2A/9wIKcxsZRTgzpCP65sVsT4kTZIY5c1Rj0lYhY2dQzk
 aisw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCiU7N303gf8CH+eK4bEulYUbhcQD9sdxBoiDxNzn/NYUn4r0fVpFr80oaedO4KgXrmTZ+BR8=@lists.denx.de
X-Gm-Message-State: AOJu0YwxEFdF9J5L88T7HVHezZPgorkmpVPeactze5dO+Xry4amdfN80
 9zNtFUk2S05TwSmdhg6n9TyG02/pBwpKr/uB7GEG+DpFYi+mzHkZl8elqjwn7I8FqoHtqMfVRzk
 UGpf8RcaS5NfJO5jBolgjtAXi2RxEMBlyPTFroQ==
X-Gm-Gg: ASbGncsrL9jD2RNHww0OOQiGw/aptiJnafloU0pjswwsdpTl2YB3clXrZyuM+42cui5
 YU3EUIOGg77DQqwJaD7DyiRST2bnHWCouEW9Wc35dpRGqpNakS4vTWJH5cLXaeSc9+zyWdTbUyA
 ==
X-Google-Smtp-Source: AGHT+IGGM4x2OcNc1cPfUmLpb7PN8SXyoeCx0EngilgtPDFyeMXKdG0AV/7UG/2iPVjcta5B/F1cT1Lpf+UovPRbMig=
X-Received: by 2002:a05:690c:9b13:b0:6f7:534b:55fc with SMTP id
 00721157ae682-6fb1f17e625mr112674827b3.7.1739540988122; Fri, 14 Feb 2025
 05:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20250214134646.173034-1-ilias.apalodimas@linaro.org>
In-Reply-To: <20250214134646.173034-1-ilias.apalodimas@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Feb 2025 15:49:11 +0200
X-Gm-Features: AWEUYZmuiBncVsE_3AxtBRyT13xBOREgXVJEOhzwhjRFN2q1ZhZuojmtkzqK1Ng
Message-ID: <CAC_iWjK7ouA8DGDP7UHrUYScVUz7m=YDOnPLH4MTpWyppphvxw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove comparisons to string literals from
 runtime
To: xypron.glpk@gmx.de, mark.kettenis@xs4all.nl
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Apologies to both for the noise,

I forgot to mark this as v2 and add a changelog....

On Fri, 14 Feb 2025 at 15:46, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> For EFI runtime services, we manage to preserve string literals
> by placing the .efi_runtime section just before .data and preserving
> it when marking the runtime memory by marking surrounding boottime
> code as runtime. This is ok for now but will break if we update any
> linker scripts and decouple .text and .runtime sections.
>
> So let's define the strings we used to compare in the appropriate
> section for runtime services
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---

Changes since v1:
- Allocate the string literals in an efi runtime section instead of the stack

Sorry!
/Ilias
>  lib/efi_loader/efi_var_mem.c      | 3 ++-
>  lib/efi_loader/efi_variable_tee.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
> index b265d95dd6ba..31180df9e3a0 100644
> --- a/lib/efi_loader/efi_var_mem.c
> +++ b/lib/efi_loader/efi_var_mem.c
> @@ -19,6 +19,7 @@
>   */
>  static struct efi_var_file __efi_runtime_data *efi_var_buf;
>  static struct efi_var_entry __efi_runtime_data *efi_current_var;
> +static const u16 __efi_runtime_rodata vtf[] = u"VarToFile";
>
>  /**
>   * efi_var_mem_compare() - compare GUID and name with a variable
> @@ -331,7 +332,7 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
>         if (timep)
>                 *timep = var->time;
>
> -       if (!u16_strcmp(variable_name, u"VarToFile"))
> +       if (!u16_strcmp(variable_name, vtf))
>                 return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
>
>         old_size = *data_size;
> diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
> index 0d090d051dd4..6a1fa39bb6f3 100644
> --- a/lib/efi_loader/efi_variable_tee.c
> +++ b/lib/efi_loader/efi_variable_tee.c
> @@ -41,6 +41,7 @@ static u16 mm_sp_id;
>  extern struct efi_var_file __efi_runtime_data *efi_var_buf;
>  static efi_uintn_t max_buffer_size;    /* comm + var + func + data */
>  static efi_uintn_t max_payload_size;   /* func + data */
> +static const u16 __efi_runtime_rodata pk[] = u"PK";
>
>  struct mm_connection {
>         struct udevice *tee;
> @@ -858,7 +859,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
>         if (alt_ret != EFI_SUCCESS)
>                 goto out;
>
> -       if (!u16_strcmp(variable_name, u"PK"))
> +       if (!u16_strcmp(variable_name, pk))
>                 alt_ret = efi_init_secure_state();
>  out:
>         free(comm_buf);
> --
> 2.47.2
>
