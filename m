Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAE3C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jul 2024 19:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E2AB87D1A;
	Mon, 22 Jul 2024 21:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HkVr3BVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 568AB88440; Mon, 22 Jul 2024 21:38:20 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2C3787D1A
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 21:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so4440782a12.3
 for <u-boot@lists.denx.de>; Mon, 22 Jul 2024 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721677096; x=1722281896; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZmQrzv7fY1CszRaklanlmHkYjuTOKTrfK9dbknWUetc=;
 b=HkVr3BVqg95TGq+hDdM7qsuVaaBzLBKPEM6yyKUjia93azm2h0FVveYyNGYJx/gH9f
 pMs/1rJqPNYhhl5fRU1GsVyyelRXqM7NLpb0rQomvXBpx1g7YFwzJ0lO9OLmmUXzpS1O
 6bGX1bSulX/GJbczr2cJMs/+ZieJ7XcpZIptWJkyia8lRmzWP9f1rVInsPswaHUFPwPT
 R7qd4uEQDTboUruyIYWS9h4wrFOoyiRYXBpB8YFmHGA2kWNZy9hrJK+GFn6G5hI2Vsoy
 bklw46rTnp87FYnkt2PW3KCXBsrInelkQyh5WHmr/IwWuTGb/IQxSNAnJSqfrsm6+98g
 2CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721677096; x=1722281896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZmQrzv7fY1CszRaklanlmHkYjuTOKTrfK9dbknWUetc=;
 b=WkHu2hxAIaDqsWsi87O9Zbvi17GGYpDC2tTg9TcCBELdaJ3W7ZHqyn3v4VAERr+Ko0
 2YPMOBZRchO67XvUJgz9huUwWhd6K77oGwR9hwaqHa4AkZlTJ585+Vj0r5kAYu69FJ8l
 LEyKgOAxCtj2tavWATFMxEUzYY0z0xvlhaDqFFRxKTHuQR4cJECS/JSkWIiJdR3o4sJN
 O+r53hvucOuGab9HNn30eAefjD0Dimd/vpjuPAUMjFK4y630f/OjzxDobn2KhiteKC8q
 t1PDgY/NL+25quKIzo/PSUOROhFWTfgjjO3S6CidSjRVz6r7kwN6al6X/1l/GmVCSkeS
 bo+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHroc+BDYuNtcYoRgVW5mQZXGAhejeLArTY6RBRFEwIUDIIE8i+tlJBs6LCrS/dpX7RRTP81xeAc7lOJqXl6i0P/EhdA==
X-Gm-Message-State: AOJu0YzGFhcLQz2LF/hpvKgLmhpX8Hib5qnKVFpP3uhi/c08EvRo/CgM
 hvZcEOAF8mDRFu1RrIjoiRhzqeIeYTm6HxN/PYIyLB15mWAyNVADXbC9MrKBnmQ=
X-Google-Smtp-Source: AGHT+IEipec9GIANZFRKzzjMobn/qHcAAeDVGM0uJ8x4OxTfkcvz9bKibCSnufh/ZvjpyNgHjUVdFQ==
X-Received: by 2002:a17:907:7285:b0:a6f:59dc:4ece with SMTP id
 a640c23a62f3a-a7a87c005fdmr59586466b.2.1721677095848; 
 Mon, 22 Jul 2024 12:38:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:364e:69c1:558c:15f4?
 ([2a01:e0a:3cb:7bb0:364e:69c1:558c:15f4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c91db91sm457451366b.152.2024.07.22.12.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 12:38:15 -0700 (PDT)
Message-ID: <2676f8e8-a424-4009-a4ef-d04a4c5c7450@linaro.org>
Date: Mon, 22 Jul 2024 21:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: Add script to update git subtree projects
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: sumit.garg@linaro.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240722193052.57592-1-raymond.mao@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20240722193052.57592-1-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 7/22/24 21:30, Raymond Mao wrote:
> Recently we are introducing multiple git subtree projects and
> it is the right time to have a universal script to update
> various subtrees and replace the dts/update-dts-subtree.sh.
> 
> update-subtree.sh is a wrapper of git subtree commands.
> 
> Usage: From U-Boot top directory,
> run
> $ ./tools/update-subtree.sh pull <subtree-name> <release-tag>
> for pulling a tag from the upstream.
> Or run
> $ ./tools/update-subtree.sh pick <subtree-name> <commit-id>
> for cherry-pick a commit from the upstream.
> 
> Currently <subtree-name> supports dts, mbedtls and lwip.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - Refactored the script.
> - Update the control doc.
> 
>  doc/develop/devicetree/control.rst |  8 +--
>  dts/update-dts-subtree.sh          | 48 -----------------
>  tools/update-subtree.sh            | 86 ++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+), 52 deletions(-)
>  delete mode 100755 dts/update-dts-subtree.sh
>  create mode 100755 tools/update-subtree.sh

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

-- 
Jerome
