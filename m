Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28900CA0EEB
	for <u-boot@archiver.kernel.org>; Sun, 24 Aug 2025 13:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E55582FC7;
	Sun, 24 Aug 2025 15:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UW6eeeP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D7983013; Sun, 24 Aug 2025 15:33:44 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9B2982AE1
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 15:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61c68525abbso188465a12.3
 for <u-boot@lists.denx.de>; Sun, 24 Aug 2025 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756042422; x=1756647222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a88aK2QAjJAO69Y+nOuwEZkKVM40AO3zW48JQGDNaRE=;
 b=UW6eeeP2AIBAl1u5EORrdPL5Pajta+XUhL4l72K1710qQXReIYS90p6lI9uZKqY5qF
 sftRJdJ7SuNDsSx2aF+D76LcqAgcTs7L47XqSCbMeZMVVVs5r6G7hnuUFnXW0r9scySv
 ZyptltDbFhaRwlWDOVVLwD9EPkxT0I4SqZr/bQ45wGiqWdU3OlUV4C7DzXsAkafyqu9h
 2cYg1WQ7ssiDRF6ZbUg4HmlBOIXQMG29x7JBhJL9Ggl88tpzIv7ybY6LF8bLoFIPjgzX
 lF5QkizVNo3SlgLnqks+wLtEZtkvEWo3LrJ6CAbuXFkti81f83jBswnUdtKWUf2mla12
 iLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756042422; x=1756647222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a88aK2QAjJAO69Y+nOuwEZkKVM40AO3zW48JQGDNaRE=;
 b=InHxDw+UIwht1uVxjKLsa+QEXEIYvWB3bWPx0rLz70po5dd0rAYmY+6Gv3fwi0V/Si
 KGyCD79BfidsFXwR79TzQUoUhDXKpdfp+yIrm7mDGJFFOjAf/Q/8ifIM0BXC/ceJcJNM
 yJmunBqCSRoCkVVz9sUC0CDu1kcRMcROsSG7rPAxB6WsVtISeaxwmfLTQ3kfKuLm2f8a
 yGI+WO/9CSoih8hN3K464ad7TQEf1zhbqmQfhXtddWkYLwNui8Xr7HGmdcEKqqxrp6L5
 5wIy0Xz0i/fBl+F7aRrqT+w3psylyW9pWsn9RJqzETZ9ZQoZrGgbPO8izySw/Cvp1Hpt
 C5nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7hS37VpFNCJJ1vXzUQii3vVyIBEfwW+wUlmZfi+BgWkfTEsY7op8EZJGkCk1s97ptbbp0UvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzMZsMRkdGQ6+8y4z49QzpmqZn12oUWA72EE3D/3A75FTMfX+jI
 +3Y+1slF2CO9kzsbISht0QKcOWlTBf52NLnq03xf+C+W9xoueZGl8IPoRv3T0EK52ADTa/Df1Gd
 Lzg2C1WI13dNSxe+LY01G8x5f8yU1ru0=
X-Gm-Gg: ASbGncuyzFqkZsWgQlKY0JZtLdLbpJsYUYY8IwHj66dwG0nfyOtNBsyoiYFREkus7w9
 +NKk/uos/PKVlks2U1zEfrnBefFwZ79CCOv6A638jV66fVxv1jW3eBbcukoOo/jkfqUzIOoBNk8
 LVSsXMOl1NIbHZNhL9dY7qrpbIKfgnOq0PeyXtI6niqrKeujIq4C7HUUtNLVk9J4ftR0aST/zv6
 CgOOA==
X-Google-Smtp-Source: AGHT+IFnwtEXPQpjWas+bYYZpaGKKEQbKyHXeG/h4zcC7KTPqPWfGz8AnLS/nnsfCIALvXOrrFd+MDAbDwTZFNU3DZU=
X-Received: by 2002:a05:6402:2813:b0:61c:4dca:9d2a with SMTP id
 4fb4d7f45d1cf-61c4dcaaaacmr2721548a12.3.1756042422114; Sun, 24 Aug 2025
 06:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-b4-exynos-power-v1-0-9e2f2f740029@grimler.se>
 <20250822-b4-exynos-power-v1-3-9e2f2f740029@grimler.se>
In-Reply-To: <20250822-b4-exynos-power-v1-3-9e2f2f740029@grimler.se>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 24 Aug 2025 19:03:25 +0530
X-Gm-Features: Ac12FXzWGVKxsn33rc6pfrwOjVDymDLAE17RI-8XkRUxfteQiUkb8yE3mcuXJKM
Message-ID: <CANAwSgTPJBb2UVSO3tC6jiidx=s9YXheSgoKWB4SR3_KEFybhg@mail.gmail.com>
Subject: Re: [PATCH 03/11] power: pmic: s2mps11: remove check for
 voltage-regulators node
To: Henrik Grimler <henrik@grimler.se>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 David Virag <virag.david003@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, u-boot@lists.denx.de
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

Hi Henrik,

On Sat, 23 Aug 2025 at 00:05, Henrik Grimler <henrik@grimler.se> wrote:
>
> All devicetrees that use s2mps11 driver have been converted to use
> regulators { };, so we can safely drop the voltage-regulators fallback
> check.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand
