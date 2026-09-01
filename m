Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F19C61DD6
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 08:58:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8787A60743;
	Tue,  1 Sep 2026 08:58:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bqCjU_xk4yU4; Tue,  1 Sep 2026 08:58:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788253087;
	bh=eA53AmlWvQbF/FYVAd4h/Eyt8EhZzhTZfvxkHkhGFOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZIt56E6V3taOLCZOXZmIvSjrXuSUCSSk6Cglb1eIHm07pW2YXQdKUUX/1+Yi+ExIL
	 I7rssGdxH1nWTo15Fh/n7SxxmhlsxfycT7G/PainoelNkvNGyv7yCiFTsjJC4NPysd
	 yjTTrBCiNPV1YZf/KqIBOSpIk4Leqeoy6anTVbqDv0HB8S1mQ3m6T43QfIlBR6UPZr
	 i4RmrV1oiTKUZRsMFThXky8K1iD5Mg4nzPlEPznMhioVjTxOVHD0TSjchLdG05oHw+
	 8TEH7tZJr2ToVmQczs9xsecPbaDH8/2GFbTWgcSQIRsWTNTzu174xEwI/xuMlXj9/F
	 l9QebZxFO+xuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13E266073D;
	Tue,  1 Sep 2026 08:58:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3023F1D9
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 08:58:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F89480B2E
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 08:58:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4yjbtt2imaKo for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 08:58:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=Y1CLbzf9
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 134B280B07
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 08:58:03 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-865bdc6ed72so30994607b3.2
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 01:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788253082; cv=none;
 d=google.com; s=arc-20260327;
 b=NH5wUODWakgfuVv6lZV6549x9eN63gf+gEXtA8hPptUN6Ww/3ZgS0E5DhHG/72Tunq
 +STM1w+aJkFGCdlZS/Vh4TNz4SFMZn8k9Wgf39a4qPZmx6JoLaHOyqWfjeuEGyaJrcLB
 4VwmAlunIAcdlVf5dS0Eufxav84wr2TkdOTCIHA6jnCysOAeYVMZl2f0MQGBJG2hrFXt
 2FS0SXnR2lf+OxR6xDxjvqOpraxSUbm6oUZud4m8cEsSYVmHqYYrEhSqw05025FYcdQg
 XcVXK1KkxnG+N7OY/O98amSQlHyDtX/XfzYajJ+lQClNO3CPSnbmOEdFgLUL35zgxu5D
 BYYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eA53AmlWvQbF/FYVAd4h/Eyt8EhZzhTZfvxkHkhGFOw=;
 fh=GBYcUsgVPWiTGz5ZQbNvvwPF+y0mZZUiqt7nrsCFXW8=;
 b=nk37OUj/8fNFWk0a/T7O4oYx1FtoHOgkL5ktQAMpQuyVBfrs4lOYmJdN4WlQno3TbR
 XBCqRCsN0iLdbEBRYMry4eVUOoJjx4LdTot94Hw0x2eGhuf49kVfZrIrBV9CRjrxQcug
 Mef6zO5yO2dGrpQVMePzlNnjBUGfp5RQecjMzhyeIf+k1ziY6iBI93zd7epWi7Nu5Nl/
 k3v55natHa1tuEFliN2Gjiqx0bJRHb2lQhNJ939P2m7YwWd2eMBKJ8w7uwH8ALxWcJ6O
 HVDWK+oPhCiwJTKzQdip3i0Tsni7UfeFXWEuWW83HdYtGIVpZiWC/3kAjWpOWwuE47ER
 teMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788253082; x=1788857882;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eA53AmlWvQbF/FYVAd4h/Eyt8EhZzhTZfvxkHkhGFOw=;
 b=Y1CLbzf9CtnSdrSisXASLfFTjCHJIFvuWC8RsxUVuEbFmtCE7aesfGTuXZWglGBVge
 R2BkRmntcLfy4tWcEzwx0Y1Daof9SMydYIX9JvEUCSIGRqNzQDQk91XiqVKnydpDGVOE
 2h6kaw4lttL+rci40Mgbh/cinVvQyslLwzuZ9kw4xIORyLbeDzKZYsZxWni4p4LG8334
 1oMI6F2YNcP+fziQ3qygEm5gkdKd6b4zjeSJZku0TLoqMt/vkRjH3n4PdWmEtsXxf03E
 ANYcf1s7bpVBvmG//wOzwR/p1erUubr3lxO30NtkRskqrhniJXt1JgapIO+JuaPMAFN5
 at2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253082; x=1788857882;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eA53AmlWvQbF/FYVAd4h/Eyt8EhZzhTZfvxkHkhGFOw=;
 b=H31ftHoaiA9yjlMhfKrL/Vx0SMbJNQjDm0aA1ANwHm4lbbNnmX8a5wtbH8AP9ejirY
 jqQS3ruN7j0xvMVDZCCW0OW2fufYr5z0iCzb1MLrJDuRnYQsgPvfdQdhm36XfRQ1prDX
 e39ZDGqzK6xl4zpTaBuK/A83TvlZFNich9zvlECeTS4tQXZt5rwRrkapQAAlWSEu5UvY
 y+m/1u0O2Wi8+vGu43RAHh408aw4I6zvCKwb7kevkuKyv5mneEj0TJn1RRePnCxwfKX3
 znjB2TxPz3V1l/5OvGim8kpKDNGC7mYMNcIa8RKrPGuZklz68vbOkx11Ava623j2Jf1K
 QwHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4CzgOAkHkrBeUz34a00vbKcCUyPP614k0BM73HVCojFjBmJVjVFaFLLYB2VcQ3h9CzbGDtBA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lz5uyU4uPHJ7UDDJjl5F5wEzz2YoP0cVzBoo7gWYzFGKHGMVUb
 8lOA7YpHqho+fYgwm7mM1xPgI4XMj05ybPL2VyNA/WaksVb7dF2gsZ8jTLyXaMXFyAICjwBMgPT
 E6Vlkjl6W4S0ilNzY6YtoflGC45lOmGJLwXNDLYeV3A==
X-Gm-Gg: AYBFou2iS7UPDk9XONnfAXeqcBwsQnv3uUyHcZIWpnZUJ77tQn6sum2XX9tSYhoZLah
 qsdhfdZZOTa80EXpwqxRPJXLxJGL2iJplttnVlMGQTe3ajCcF6Lu1xLRIGWslY1aBa8Zthu816v
 zvrADrpDGr2MbGn0SMkOPoFBcGVyTmh0qjrsAinRfZ3UglNKzkuiYo8o//Wp9ETthPb5FpSw8Jp
 c3rDTIZsmq7bHaWvLCvrf7kWfUOH3XyF2GcUA/FhsaYC3rJwUr3JXM6/4wjkdI25/Rr3EFki7oR
 rOD8qHhcU1mXkXL0QPOrPZk5hnEAp4UiAtzEITXaklIqClJ/rBxngnKyeTLwq7LYIZ4wTMHdQYn
 NGWYm/xgaYSK6QbWvJ/uKaqSJcNNcgTZaDmF6ixwWxUiLmBi89IMHrBbKg62Q4o1EznsSbBC82g
 ewFn+nDXjW+rfgp+YPQOEVFOBi/Xks5a/CZuxIogVRDskauEgPYS7JX9K5RgdL8Juc2kgWF1Xrx
 74I9NtYyMfH/pZfkkwtC0gfOw76+p6IwkCnlhEO18JUI5bC+USS5+fzZc/hGJzc1DV8Ae81A59k
 fDDej8eu0TNwI9YrBD5aXE37szucWOYP/sVGLz6vETg0FaJSBtlkSsKeH5effJVuzzsc/zbwafh
 08vJPDT8plVmnr6MakdhpI4ctorBvo1dECiSX9ey5AhI=
X-Received: by 2002:a05:690c:31a:b0:81e:deab:43af with SMTP id
 00721157ae682-8686e1baed8mr35569357b3.4.1788253082238; Tue, 01 Sep 2026
 01:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260830084400.250238-1-heinrich.schuchardt@canonical.com>
 <20260830084400.250238-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260830084400.250238-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 1 Sep 2026 11:57:25 +0300
X-Gm-Features: AcwNN1X5uQGEXlas63LEGiUfvaD4C4uqatIxGR-YT4xmFkTJlvTTKYCzjZ351-w
Message-ID: <CAC_iWjKME5syXX--Q-41TqOC_6b9qAAw2m1b__HMQ9CiGRA90A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] efi_loader: remove debug in platform_get_rng_device
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Denis Mukhin <dmukhin@ford.com>, 
 u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 30 Aug 2026 at 11:44, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> All callers already write messages.
>
> * In efi_rng_register we have a log_warning().
> * In get_rng() we have an EFI_PRINT() statement.
>
> These different message types are adequate as get_rng() runs inside the API
> and efi_rng_register() runs on the U-Boot cli level.
>
> Remove the duplicate debug message in platform_get_rng_device()
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         remove the message instead of replacing it
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/efi_loader/efi_rng.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
> index 7810b4e47ea..e920eec9d7b 100644
> --- a/lib/efi_loader/efi_rng.c
> +++ b/lib/efi_loader/efi_rng.c
> @@ -30,10 +30,8 @@ __weak efi_status_t platform_get_rng_device(struct udevice **dev)
>         struct udevice *devp;
>
>         ret = uclass_get_device(UCLASS_RNG, 0, &devp);
> -       if (ret) {
> -               debug("Unable to get rng device\n");
> +       if (ret)
>                 return EFI_DEVICE_ERROR;
> -       }
>
>         *dev = devp;
>
> --
> 2.53.0
>
