Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A3FE77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:00:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EEFF8975F;
	Mon,  9 Dec 2024 16:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KyrCIrNX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED5689763; Mon,  9 Dec 2024 16:00:49 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 534A7892A4
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso157484866b.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733756447; x=1734361247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HJQyMncquvJMxLnkd02eXi6NyHE1NQxI4NB5dtFDpO4=;
 b=KyrCIrNXgklDcT3lVzszyEvrxcbqeJhGA4GPW9hJRmyY17YQYF9ar0MprKE+yVE/sk
 1SxIbnXFqdhj1xdEzVgxfdZf1NAacFDhLBcm76qphw2rjd31IWZvWIgh7nC5hiaz8PuY
 4Z7VNo6awPxGisXtOgsHMKi4dFq1wyj4cw5C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756447; x=1734361247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HJQyMncquvJMxLnkd02eXi6NyHE1NQxI4NB5dtFDpO4=;
 b=v9wncIETNa3QBJ0vjd8h4gJOLdzg8FZF3QX1Pdl9iBs4AV/2sSO0KLJ/vzN/p81WJV
 Wvcqy0wJ4QZlgNAjejsicwBcIEZk8/yyM2zFPGBlqFklmocuHeNLku3XPvFwrLHOG8/m
 0Nx+A+8g1O8vUXlVV8VlfYocDWg9/S9KtBxHRxBXjOXiVVMCSzGyDvZil1rjWvwJexV8
 oP9UiETOmGwGGl2hllL6jK9t6ci8odCfsdf6WoJKB2ffyLwh2meKUs2uDIWiARvKypXn
 IWTI3xfFMXyKrapjiL04PlubnF4pezlTzrHwx/lZoQj0nk3/LWBARrEKdumKLrc4O928
 qn8A==
X-Gm-Message-State: AOJu0Yxaa0KclXwKcI7lheENZ52+8oWkpm+pOnMpYH5oAPmtHhmCF7AF
 BNOa9IkX5julutDqi0ScI9rXY1c9R0Kz+xFdm4iBnQL7D0Y1WZhZ3yPV/L7F6Ihffu9XeCniNUW
 BJHQP6+9vSyvHLqI/XZMEXzr7OmQ3sfoicvbS76UVhQIUc0k=
X-Gm-Gg: ASbGncufUtKJMixmsp4vcJYLmRlP9iN/veqv3kivpQHfszwFMdrfdEGWOihNs9+Z2uZ
 y+5JXuf/o2HcycAoDD3L96mOrlHWMgXYc
X-Google-Smtp-Source: AGHT+IGAvClRCwAjgw+WGxVf0sxKSEZ/AH+Q8b7yT1oJtTa8X1iCXBgLUXF5FK1ZJGujXEtJg6+1FUAahagLLLcoYAk=
X-Received: by 2002:a17:907:7742:b0:aa6:7737:1998 with SMTP id
 a640c23a62f3a-aa677373e8fmr586708366b.3.1733756445716; Mon, 09 Dec 2024
 07:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 08:00:33 -0700
Message-ID: <CAFLszTi4wvZBVVXtx_Gj2mSFy827DUxKtcEOxocT558=XGmQBQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable arm64 host support in Gitlab
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Sun, 8 Dec 2024 at 12:07, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> First, thanks to Simon Glass and also Linaro, we now have access to a
> few fast arm64 host machines in our Gitlab instance, to use as CI
> runners. This series finishes the work that I pushed earlier and Simon
> had started that enables arm64 hosts to be used for most things now.
>
> The first notable change, especially if you use this on your own Gitlab
> instance is that "DEFAULT_TAG" is now unused and we instead have:
> - DEFAULT_ALL_TAG:
> - DEFAULT_ARM64_TAG:
> - DEFAULT_AMD64_TAG:
> - DEFAULT_FAST_AMD64_TAG:
>
> This lets us say that some jobs can be run on all runners, because they
> are small enough that anything we'd connect to CI is fast enough and it
> also does not depend on the underlying host architecture. Next we have
> tags for any arm64 host, or any amd64 host. Finally, we have a tag for
> fast amd64 hosts. What these last three are for is that we have a few
> jobs that need to run on amd64 hosts and so we have to restrict them
> there, but we also have now reworked the world build jobs to build
> (almost) everything in a single job and on the fast amd64 machines this
> is still as quick as the old way was, in practice.
>
> To reach this point, we say that the Xtensa jobs can only run on amd64
> hosts. Our targets only work with the binary-only toolchain and so this
> is a reasonable limit and we exclude them from the world build jobs. We
> also need to deal with ensuring the right toolchain is used regardless
> what the host architecture is and that we don't use the host toolchain
> by accident. Finally, because some of these changes needed to be worked
> out in the linter, fix some of the general warnings that notes as well.

I haven't tried out this series. Does this handle running multiple
test.py runs at once? For me that ends up providing a large
improvement in CI times (down to about 35 mins with just two fast
runners).

Regards,
Simon
