Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5104CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 15:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E7FE8486B;
	Wed,  3 Jun 2026 17:57:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O2n4du44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C71B58489D; Wed,  3 Jun 2026 17:57:49 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA8AF84868
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 17:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7e685ddb3b0so4858457a34.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 08:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780502266; x=1781107066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rdJfSqV9pZFxNJmOYm1CBjOj2rCAHXv1nnpnJZ9RZcs=;
 b=O2n4du447SueROaHqQdNVLg8bghsgADZU79XlnmyZ/+dQk4fnK8qUh9zjqHGVK2/qT
 4DD6jp7SKD1D372jwgEcm7vftkYANJGMVGjE5ExxfIMcc2yK+RD8O4sgGepmdxnOxps8
 a/CPTXUNvx9yfbG+NMYAOQPUIPTSt1bgW+2wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780502266; x=1781107066;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rdJfSqV9pZFxNJmOYm1CBjOj2rCAHXv1nnpnJZ9RZcs=;
 b=iMFqQoYMSlMg3EU+Z9sYZAd16DZKHmihkc0WvnC7xRz7rZS6GGkgRnqk4OaDmJSTD5
 1bb16VjtsyrIp3KuvmDYyMkJdy5QhoFINfmXMeYIBt34nQH2h/WhhI7RCt7FMEJVv0zv
 SSxZxZvkijqSSHFPtrBtsg80sRDV7D0MnjOBMtDoh8ojfvvIo3mtIDTEWftisMUf1TA+
 9KdyX4uUdqpPXqKDYj6TG1VC6N+nd4v7ssAtqy1ByI8STgCNr2JJuHkaPPzCHf7rP9HK
 T4Ssruh6TNFVigJ45vk5UO8R4CI5QDRJx87rUkPN2xeC0VPmAZCFnGG62gPv7ve5UKsA
 NacQ==
X-Gm-Message-State: AOJu0Ywbz+ayDNHj/IVIc8Fxn8J1OhzMZySd0gjGES/aMuNVwIXKNxLz
 yLQgaXcWm0OHhex3CKy1M4ZXCynflRzeom2dm5j2j0wZRHfo2AxEgR0ZEbeniIiZ138pYjL97wb
 2l6nH1FI=
X-Gm-Gg: Acq92OFlEaJsvrmg/E7uiroNzXqe6nmxMpWTaf3fNTpc1y7n9paz8X71J+slhecmfsN
 zAqYPhmZnMe1CzzJL2SFfhnLkJjKgwAXpYrpamP5icpwDQf19Tpldj+ZaBWbTJ2f/SjWKZiehX+
 pCFg+4tgJmcIj/aU+wO+z2g6TVT3uuFIQiVdnO/tizDBGtHd/QsCj88OFDfO1zUfEiy2RtIWH1y
 VXvC2AmVBMP+TU/Xz97qMoFI41V6fFKypqk7yqteO7lfvH6uxKRvVTRhyYIY8Xixx8m39iinWTh
 J0EPPO9dCa9UmNwcaZCqsgK90tz5rxLMZHWPqquFXXrSZO653c2XZlY34lEtq/GPHEaws0XZtKU
 BVKJuSszQYm7p0oY4lD9CuXz4fashVYjQyc/zN90HUIHOe1vfKOuOZYapggHeKdH8m/9/+tmpMz
 DOHAserVtG6yu/4DiyWkdnafKjrRp5QfMYTf8lCfwD4/uUqHcMdeqVCpnukb/XANZajk25hAKxT
 36b9FDG8PMvEn8B7Q3a7tzOzuQd0/Ko3WxaYrY+oMsiLHIcZd9KXnUVaBE3
X-Received: by 2002:a05:6830:378f:b0:7e1:cba6:9837 with SMTP id
 46e09a7af769-7e6e94dbc52mr2192339a34.6.1780502266414; 
 Wed, 03 Jun 2026 08:57:46 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e78e7f9csm1970441a34.17.2026.06.03.08.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:57:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Giovanni Santini <santigio2003@gmail.com>
In-Reply-To: <20260518204605.1415006-1-santigio2003@gmail.com>
References: <20260518204605.1415006-1-santigio2003@gmail.com>
Subject: Re: [PATCH] Makefile: fix extra dash in KBUILD_CFLAGS
Message-Id: <178050226536.2193579.17069464320203740908.b4-ty@konsulko.com>
Date: Wed, 03 Jun 2026 09:57:45 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 18 May 2026 22:46:05 +0200, Giovanni Santini wrote:

> Remove an extra leading dash from the KBUILD_CFLAGS assignment
> under the CONFIG_CC_OPTIMIZE_FOR_DEBUG conditional block. The
> extra dash breaks the build when CONFIG_CC_OPTIMIZE_FOR_DEBUG
> is enabled.
> 
> Fixes: 56ae3c2a44fc ("Makefile: repair CONFIG_CC_OPTIMIZE_FOR_DEBUG support")
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: fix extra dash in KBUILD_CFLAGS
      commit: 81d60060831afa50a43a6dcaf8e34932e6b8ccc2
-- 
Tom


