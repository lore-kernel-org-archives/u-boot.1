Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014FEC369C2
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 10:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FC88192A;
	Mon, 21 Apr 2025 12:09:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gNyGPPHU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85E6781F0D; Mon, 21 Apr 2025 12:09:41 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90B9A817C4
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 12:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e5e0caa151so6391620a12.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 03:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745230179; x=1745834979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BEIG8PVyl3bE/MFMfR8W1Ovw1xVEy0WqBgo1YDn1vO0=;
 b=gNyGPPHUd4X9sd1yFgni8y7iEVwusgr8UEQ0QjrFueb9Ddu49pg3jv2jU6+stLtmnk
 lCrjz36p35kdH0da08YUt9RRjvngGiSuJ4R+/XeqeG0F5n37F5bzM4ou61M6z78jkH1o
 ut3Yrn4bbDl+4wvVCvIbOHkCGW8jhYFQyu+dPMAVtpOx3Mh1++lr85AzY+P9zEwMXCQe
 XluxZ2vJJTFGDIjdKFVQL2qAMy2R/0ZmbvIYXA3DUshm2xwmUmKZCNArLhS36R7y5YKq
 kR7hIclLy44s6ZDS+iMX8YX+FYRak7xJmQL0z1dStz9mka9VVk9gygawEBrps/Qf3sBV
 /BDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745230179; x=1745834979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BEIG8PVyl3bE/MFMfR8W1Ovw1xVEy0WqBgo1YDn1vO0=;
 b=kN1JQwfP+/PSa9JtNgkqdaBjJS20fEKRP7d5qjrDF0VJx1RSCeAFsK+frrBx8i2bjQ
 4CxZ5W6Tv3zfcczoWupOagAkEoq7cmRqhstC7l9QkCwM443wXzIIBZZ4DXKtvgGm5hDP
 y4rvP5CAGvF3e4rGlxEs3IMByG+JrfWdPyt8tCHenMHp+DiYJloT953aLrZ2ew0mmVMt
 qDpNZN+k15mbL7NqPt9dzcA2Vp7PMqnrydgyV4Jha0zQaujsYW0E8nMzTLzgVjRQOOM5
 U6z0kUpcvihjYj0Xu2rmAThnv0VeOeeA/Zjg4eAese6bmcRZwDuqSYtVorRQLhFmO+pY
 D6hw==
X-Gm-Message-State: AOJu0YwKLvE0Ooiz3Tmt7R2C2WqYubCYXPDrOuxZ6NUqCg4lziZoeCMH
 NALisEopY0o4uMYn/75VIiZLNZeXzzD4V6xdMrkaNiO9dIxfmLJlBYtFklzYHTSO6jYesFzox4N
 PE+BECCvziiOPigawZTyr+o7uqbo=
X-Gm-Gg: ASbGncvXnXER8uZN3nsUOOE/6AJ+/7RIIbcL32+MVC0CKmANFVmIqjzjVv87lcxOx4v
 Z0rS09MgeCR11RFk7lT35rJ22lGKf2s8Zde/8k1m2mb8qExuSKr3pWmB9UImZzxeaH70+erhpUR
 D2CF9W/u5LBYTNOGx6j3fwbALZdIdw/K66At92zfF72dwLQHYD1Q==
X-Google-Smtp-Source: AGHT+IEfUyO0ymSvNKur+L9O6y6T45TJyWYFCA0E9mo52sHyqv2Afac8CAoywIyVyWCStyGAjxMW0ZLqWtzmyZSwio0=
X-Received: by 2002:a17:907:7288:b0:abf:6a53:2cd5 with SMTP id
 a640c23a62f3a-acb74dd0190mr1177622466b.48.1745230178970; Mon, 21 Apr 2025
 03:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <20241220003447.2913443-2-sjg@chromium.org>
In-Reply-To: <20241220003447.2913443-2-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 21 Apr 2025 11:09:27 +0100
X-Gm-Features: ATxdqUELOIt9fTrXX4i_3c-APd2bP_YuTH_9KiYEhjb8C5q7lEOzRFyZ7E87z_Q
Message-ID: <CALeDE9M2HMxnNeiA2Cb2AXhhAeYsadP2hjSdr=+T6qjO8UWFEA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] rpi: Add myself to the list of maintainers
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
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

Simon,

On Fri, 20 Dec 2024 at 00:41, Simon Glass <sjg@chromium.org> wrote:
>
> Add my own name to the list, since existing maintainers are fairly busy.

I've spoken with the other maintainer and we've decided to decline this offer.

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Add new patch to make myself an rpi maintainer
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba31f86feb6..8db1e605fc7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -210,6 +210,7 @@ N:  aspeed
>  ARM BROADCOM BCM283X / BCM27XX
>  M:     Matthias Brugger <mbrugger@suse.com>
>  M:     Peter Robinson <pbrobinson@gmail.com>
> +M:     Simon Glass <sjg@chromium.org>
>  S:     Maintained
>  F:     arch/arm/dts/bcm283*
>  F:     arch/arm/mach-bcm283x/
> --
> 2.34.1
>
