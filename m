Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1D8D63939
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 13:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E81389649;
	Wed, 20 Nov 2024 14:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oMBg1VKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6517895F3; Wed, 20 Nov 2024 14:49:05 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B309F89426
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 14:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cfaa02c716so2746853a12.3
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 05:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732110543; x=1732715343; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=whuiXhh1Co/d2hGJ9u+c3IzbZ33Fu12J7NUqY7b6vUE=;
 b=oMBg1VKNdeVgp/fSByuItNEn68gFvMY14yulCTgj2KuoQNFDQtBQh8AoLWPqwqFPa+
 RsGHaoB257mtozPI3ExFl0fh8HS1IGJEalNtJ2oSZW7QkBUN0tgGiRc1BVFtmOqWZq46
 rXo9JGKqPnhtiReEr/NSFjdhz5ZqBkEwZGKak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732110543; x=1732715343;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=whuiXhh1Co/d2hGJ9u+c3IzbZ33Fu12J7NUqY7b6vUE=;
 b=gvjF9V8gbTTWrR1EtGHOR9Ojq1VoLrCmUijHv/1BeQ5LvxRfWkYEf9j078+vasVKwH
 RybW6QA32dsmGp8y2QQCc/ASswUnZ8H4TUD2LRsJkWDcqPsLfcaj/ouDO2gl8ElVLBHA
 w+bVBUEpxX0XouBRcCaiSpFCdkox+osUoVIncw6jAZX31HePSOgManYm6fHZlLIl+eph
 NcjhO9s49NOFV5VD4eRUtOW5h8HMwakiY3pmJomqmUt4uCPk6zCVtEtrNdfxiVTN+8Oz
 KHReZTqkja2HskuCuIcBr2TzIMm5x5ZRj4xGx/TgdRhBITOV572FvO/ZUYfoposJPYAI
 T0+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzNlOIRBBiQQ9YjHOgAfS02+XEn3aLdF0/wgLqtLHH17Jf+fZSRUal/gxkj20F5uR62NA8MC0=@lists.denx.de
X-Gm-Message-State: AOJu0Yy96Zll4BkKQ1oPQA7/B9CE2/Ajk7qpzGmUQv8BQzUKEuaGSMCW
 1wtDpP+rcVscz9HBdFYnyQUAz7I/pOlBRwfEWWIdc+rjFBGatjUfOUYXdfS8+qLKJIVTh+TCkis
 IIr3ZtN9N3KR4POrw1DOmQs0+JAIpx4i0zKSd
X-Google-Smtp-Source: AGHT+IHm68xsIPMPtForsjQsPqRGuUExHAq9tHtvrOy8VufLBXb6qwa24bHRGF06Z+AdqL4vz3qlSLEdT97/EJ56HYU=
X-Received: by 2002:a17:906:fe0a:b0:a99:f71a:4305 with SMTP id
 a640c23a62f3a-aa4dd5517f3mr310245566b.18.1732110543159; Wed, 20 Nov 2024
 05:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
 <20241110115054.2555-9-ansuelsmth@gmail.com>
In-Reply-To: <20241110115054.2555-9-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Nov 2024 06:48:50 -0700
Message-ID: <CAFLszTg6yQVVgv1oQODfMggmYDFDt50JjpVd55=vCjr14bduQA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] test: dm: Update test for LED activity and boot
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
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

On Sun, 10 Nov 2024 at 04:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Update test for LED activity and boot to follow new implementation with
> property set to the LED node phandle.
>
> Also update a copy-paste error in the function name for the activity
> tests and actually enable the test with the DM_TEST macro.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/sandbox/dts/test.dts |  8 ++++----
>  test/dm/led.c             | 18 +++++++++++-------
>  2 files changed, 15 insertions(+), 11 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
