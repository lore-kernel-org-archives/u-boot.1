Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E69C5AD49
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87B088306D;
	Thu, 29 May 2025 19:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="txSjlTWU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06EDB82B27; Thu, 29 May 2025 19:55:05 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C634B82B27
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4064ec636a4so641723b6e.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541301; x=1749146101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdqSjahCHZJnt3zyCCBelKvClH5drj3IUYkS3zSXrDs=;
 b=txSjlTWUZSH5ROwErBjj6s5dba5QOZEAKYd6wkur3a8It+MP29pv/vFg6m8aaBbTmd
 uMxI8FHQsTKmx/IVISCOh3UsjpD2lLTthMGAMgEbWkyfWaw2adcQgbUOgcB147ni3xyk
 3HtjNm0Mv2DXRFqEXgLnt1/vvqMzuORrlLTAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541301; x=1749146101;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdqSjahCHZJnt3zyCCBelKvClH5drj3IUYkS3zSXrDs=;
 b=Rrg0rscdfqP2fKtWpH4TIWy/k6rfbiGGHZge6xxKVc2lg8iK0+jq2t67GNn6OrPkc9
 TsuaCOiBVRVg4DGFr6ZhVGWctd56CVycuoA4C8NJSKzvNemS+8lvZZIDzWJR5zudnPrZ
 QQR/ENV0S9Fl7aNpHhDlA2Z8wgTfZWJBC6/QyzXAc4HPbAxCRSvxbyBLaJ85nyTdPE35
 5Zdjut607nIY2WXHqg7EZ5cN3vJG7Arq7KvzbO2AU2oOtnV2JADLpDBh8tvhP4fPNdE2
 YvwX9QVt9m88X0DCuW3CQRWyPsYGSAP+N79r3/Uc3aDLKcgXLg1aHTaa7OabRYsM9EVZ
 TxFg==
X-Gm-Message-State: AOJu0YzRMbqfb1z721luuPxkrPaHwfa6NKJ44Tb3zOycRFbkVx/qfjBf
 D85am5Y1VFcOiPejad0Gtt0Zd/NmyNaowpmTVNn7aLeuqZL7xIXr9vRS7hyeJVrrKrA03Nft3Z9
 vRTSi+sk=
X-Gm-Gg: ASbGnctcKOI+K3GpcovJo7GQU/Cw2aE4XfEzxlCl9bXe5QEWXw5jC+djz6qiDEsWS/f
 jw7R2f1O6XyG9NLXLCX63/W7362Px+vLFpnc3ty1Xr4B1NwaLhG0txHsKoqNnd7yyZ0I7hu1qek
 1MY/s4zzxHZvtVp6HTwKdu99YL+jOGsvA0NiS5tv0uptISPA05v1mGQmcZnXponBvT2g814uSiB
 KoQZM6BwBUejDUpTzDNx0IfVCCBv4DzwUeGY4oLzQQbmDsGg2PZNyRaqLsX+53Ory9RfxPGVmOs
 ZYgcnQZe1qFEjkE1ejIEi3mm0vS2cYJ8UUvIgIUYzfYp6f+3xB3EgwvsrIDQ0siZpyuHyJMvFDI
 A4lr6t0YPzjQ=
X-Google-Smtp-Source: AGHT+IF+xYtfx2cRojwMTH3pEEO49cjeVJhaxCwycvvqyTAbT7jatOt0jhFbNocSixEGcsU6hE/f/g==
X-Received: by 2002:a05:6808:3849:b0:403:56f4:8780 with SMTP id
 5614622812f47-4067963173dmr301241b6e.9.1748541301482; 
 Thu, 29 May 2025 10:55:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c42c16sm77455eaf.7.2025.05.29.10.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:55:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Subject: Re: [PATCH v2 00/12] regex patches
Message-Id: <174854130056.3917659.17138175311263264969.b4-ty@konsulko.com>
Date: Thu, 29 May 2025 11:55:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 13 May 2025 10:40:22 +0200, Rasmus Villemoes wrote:

> This started as a rather simple patch, 1/12, adding the ability to
> more conveniently do regex matching in shell.
> 
> But with that, it became very easy to see what the slre library can
> and especially what it cannot do, and that way I found both outright
> bugs and a "wow, doesn't it support that syntax" gotcha. I couldn't
> find any tests ('git grep slre -- test/' was empty), so I added a
> small test suite and tweaked slre.c.
> 
> [...]

Applied to u-boot/next, thanks!

[01/12] cmd: test: add support for =~ operator
        commit: 04044a567b6b177eb24944343d9e9e61a89edd53
[02/12] slre: add myself as maintainer
        commit: a5af8f9ad2779e2a18bc9d723c687ee2213086f0
[03/12] test: slre: add tests for regex library
        commit: ced883d92c0568cdb15b5b67106c29a4623b19d8
[04/12] slre: drop wrong "anchored" optimization
        commit: 19b3e24083eb0b1b5299e689d0bc5f1a6c4ebdcd
[05/12] test: slre: add more test cases
        commit: 09b48305d3b6492553982df75e3a9f99d1f856d0
[06/12] test: slre: add some (negative) character class tests
        commit: ebdd78c487f6599f693e53e707606d7295f20f6e
[07/12] slre: refactor is_any_but()
        commit: 457f19815c8f8b74c36d8cbef454a0b575ea7068
[08/12] slre: fix matching of escape sequence used inside character class
        commit: 5d3f91d6a82386e94c3178721641608563560871
[09/12] test: slre: add test cases for escape char in character class
        commit: 4d08883556b588bc1e6ef392349c51eceb550829
[10/12] slre: implement support for ranges in character classes
        commit: fe4f21185050ef3f2cc847ba04701d1e714522e3
[11/12] test: slre: add tests for character ranges
        commit: de6e54d74dec9da5d7b8572d5a0711c7280eae2c
[12/12] doc: document test command
        commit: 6990cc5257283a631a286a4321a3515c7537f636
-- 
Tom


