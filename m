Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218FBCD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:00:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 878A08341A;
	Wed, 13 May 2026 12:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G04+K2yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BDF1846AE; Wed, 13 May 2026 12:00:13 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90BB8469F
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65318dafbcbso7006423d50.2
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 03:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778666409; cv=none;
 d=google.com; s=arc-20240605;
 b=bvJrZCJ0wp8EKOmwQwO63v5Fe3XYUNqvXYudiVxVARk1tT2vdQbUZ82s7kCKq78ce6
 Lp3OjwHzL4C4bpfwxL0VuoXTkvb0jqyZqSdhz5WqjRkftX1u2D4r/OlFnNL2/qW7v2Kj
 31ReAfaZjjruHYj+H5TVJpNTWaXOudjlXYC1Vc00R8qcGvxp52fbtQ+mf5jmc6y1oE2f
 nOpRFpJAwuEyT8KXtfSFUlgn7OEKLPZYt3Lt8MHDQWeZc+fzF3bj2hrXmHp0VfW8Ddil
 1OJQsuxfBQwcE92LmBtTABXkaXRScse31QyPNvdhSkMVKAc9fkx5u37ni0xGC3qHjX1s
 YpLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MOEYtSuYbVvhJXWfmAzM5uy1mLI6Xh6J/U7lrpSje+w=;
 fh=afdFkhg+X0dJedjeczr8qfrLvDZpz9MX/GqWAgIgc5U=;
 b=JxuWaa1kj32TxVZ4m0NfiutyqxWf6bAmoA8De3uisFu+szhpuYwDZY0I3tt1qRR3aE
 w2iK0Mtyl4lSguGDiS0+SzSBp04MJAsMjza9XYYScQCP0w6DzG1QKjvJZMRmC9eA63m+
 3H4+GNj/zK5JIOrjb4kuvqOVpSmja5G0LH3AFOkdADnDiZT2dNpPRUic1LJCPmjZlhrH
 KmjzZr5jkP0Fqjd8rp1vf7zuO4Q/JWxsqdB8Lc4G8VTnkWz7WZhUd9UgpwPGgJk3bs3J
 zWr/EZ10zBrLHqP45upGzFs8nDtBD/luAo57X5QO/f+rDgUxGGC87M9Uv0Xw1nyTwk/i
 ErOA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778666409; x=1779271209; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MOEYtSuYbVvhJXWfmAzM5uy1mLI6Xh6J/U7lrpSje+w=;
 b=G04+K2ybzb1wZKl3Uc2MULDqQFv6Qe5dfJqCI7HATqH3f/bxTVcL6DJ8Dv+SWBNEXq
 EzdxVsQIEBN0jKpFICemPSiJxpQXB61KjIKz0hzPVibzS1TdtkHLQHKOXxJyawIbjxSP
 GrhR41h/u0xvufdo5/zi7irLEtfkHBJx808CeT3nm7nshA/rdKwgjmpqUWHJGtPwL0oW
 4aRq5WlB0LlxvuLBapmNyZOmS0uYBe5dUhaYPC3+DWnEKsF2ySBkyr1irthh5GGeIEXm
 AwnDJ1x/R+3QRifq/dHuKeqSJ0IDYaCUC118P/11CQ3uuzbY8kO6Mjyr0cax2TD5h6sM
 3egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778666409; x=1779271209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOEYtSuYbVvhJXWfmAzM5uy1mLI6Xh6J/U7lrpSje+w=;
 b=W2f/sHMtMJku24Lmv1RwoQAH8wvwZLXESiuVMEornONl8lRYLaUcQJ4jSZrz4wOoHK
 cV8XSSzABMsUjjI5U1SRR8HmXGKqB1Of9c0K0zZL/RDpFekUeIvFD8up8zAZwEQvtKsV
 qbSqNKzU2lrPu6jkolQRuu3woA0Cem47L6mzyRIsQE0DKyAB0E1bER2Kw1IwozfTshJ/
 o83W/YCrrH+WAeerU12MK/K732CHuaUH72QTFd+z27SITq1C2RSjHxsdBBoBYCVnzLgw
 fbCVkKaWY0kYFQ3Xt5WtPh+EYQGgBm0KYNxJ8IhggLn//BHKq49oOExoMoHwpFwfObx0
 W/Ag==
X-Gm-Message-State: AOJu0YzB95jDUl82a3Jtwuq8Y5FtvKU360N1sAgzeAYPad9XqZMyZpPk
 7Tr9aBROYT15B9vntzMBvHcfVsQwAHlbtHwOKfTYEvKb1/5l+6RIfjZCCpyXR4EFqKG7Pwp5AVd
 XAf8dqHnHQ+TvbCwxhrVRjUmyrnkf+rTtVVz9SQqRZQ==
X-Gm-Gg: Acq92OHa/d1z0jpsfLp68+u0OSnxHf5j4IeznQcjhe7DoFBJiAmyELWJPXIzbG99LYy
 zUCJ0O2+AHo2AQdGDKSvGsChL78HzI7iLBvKDc2ydtpzlOKzz5DovihN+Q1NSzqNC/0dF4TUrdc
 yDEUwyo7RpsriWyv68Xu471PKo4YhYEW240qqCqD8LOa9SBgLPLxRjQ74dFJcxoJmHw7pE9Jwd8
 DQFwkr72YUk309CxLmugkXd2F2C0FKbraCpDPq0GXPqKdfwyYKkWLL8mSPWmhvhGlrkpGlI0K1w
 PRZW1on3W7GQP7JtihCNIk/XvHJGg2LCeuo4/nnjzgYdSrfqEqkNfJrU9nYO+WpnF2MaXt0tCzk
 iUJaWOSy3ctIOg/9Ib1CdIOp4nSS0ISIW0sxISaDzWAlIus4X8Ttmv2zRQTJujQfFihAvc+0RZp
 exVy6z4ilJ697kc1BlietemNqyz/opxjHj9jhZUTBtu3rEeotlT6j17UBhagrwfD+0YtZ/lgvWi
 +8oA/AJMlrTCWSmyuiq4GGexQTs1zFl0kZMBHO1XqtHYJB5hu+iI67ekUjFWM0+DEtCeSvut918
 nLfkV5JthQM6TqllYTgTY3nbZDMB2v94W0bS9G1Rzyp8jumFkJq59XhWVhnpWxGNh5gFtHcqkGm
 h+DAppg==
X-Received: by 2002:a05:690e:1243:b0:65d:c58f:e311 with SMTP id
 956f58d0204a3-65df7df50f0mr1787331d50.0.1778666408124; Wed, 13 May 2026
 03:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
 <20260512-b4-mmu-unmap-fixes-v4-3-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-3-fab802f647c9@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 13 May 2026 12:59:32 +0300
X-Gm-Features: AVHnY4Lr0zR7SJ2Xa0ybpBVPzNqtD8fSiGWn6PYjPNae1jyGwplIFAvGmWiITTU
Message-ID: <CAC_iWjLNEYBzkZ37rmA-2N+zW==O6w7+Mzgcif1kFs_TTWtrPQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] armv8: mmu: commonize the set_one_region() loop
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>
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

Hi Casey,

On Tue, 12 May 2026 at 14:13, Casey Connolly <casey.connolly@linaro.org> wrote:
>
> This loop is duplicated 3 times, put it into its own function and call
> it instead. This simplifies the logic in a few functions.
>
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>  arch/arm/cpu/armv8/cache_v8.c | 95 +++++++++++++------------------------------
>  1 file changed, 29 insertions(+), 66 deletions(-)
>
> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
> index 36d337378fcd..e9ce6335ee9e 100644
> --- a/arch/arm/cpu/armv8/cache_v8.c
> +++ b/arch/arm/cpu/armv8/cache_v8.c
> @@ -1022,8 +1022,31 @@ static u64 set_one_region(u64 start, u64 size, u64 attrs, bool flag, int level)
>         /* Roll on to the next page table level */
>         return 0;
>  }
>
> +static void set_regions(u64 start, u64 size, u64 attrs, bool flag)
> +{
> +       int level;
> +       u64 r, va_bits;
> +       get_tcr(NULL, &va_bits);

va_bits isn't used anywhere

[...]


With the above fixed,
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
