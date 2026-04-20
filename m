Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BEF5A8B6
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:34:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252CE8441A;
	Mon, 20 Apr 2026 21:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yptd92ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1AC484419; Mon, 20 Apr 2026 21:34:48 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC7B984376
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b9910707d82so532862966b.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 12:34:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776713686; cv=none;
 d=google.com; s=arc-20240605;
 b=RcuIJACvALsxDqvNBmxDAnnlV6hHfp9Get6/QTGivPonnKnUyftp3Yd9DiJ1IZmHmu
 8J77M3LEJyrGkG9YZlHiGu9MgAbW+UZrXAIL0oS2XOLpgGGksEEkwI/uj90oBS1HApdb
 M5sJRO/grmKj+6+lOyTs0vHUnV3mEN+OUAADZ/sn6Idrn4k/wYMYpoKLrQZIifPalnXL
 3iP7TeQzaEAs9b26ovfXuffXOiSDyEAhPRU4P8SgFNr6Y+kfLc3WaeTTKDXx11IulvZL
 U9vWdcAantrGz/D9MN6BQPnqgPXGqJAF5ym45fBFP0nQQN6L82vhuqIYi7PObdy+pcHZ
 4vYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Me2apjqOYUAZyMPwT+AXD8o/0tr5hrLA4C42ylMR00Q=;
 fh=RMotW0d5XlV4ufFtnrZdzQ0yk4gZppNtVCUWCpNgShU=;
 b=QyvkZ9Z65Jlem8AoVK7gV7j0/BX6vfD3hnJF7y7xrfUfUWPzCZCH0mB1BjncGJEsGN
 RYN5ZIAby0ztExPimZ59U3DPPtSXbOtk5BeXzwXnXofSea+qUz6wx9iUwORunZat4U46
 xF/pfBiFVv25UFupqjVbqT9H65BIdSLum/X4KZmNdNbk8f/pUivAdD5t+o+xx1UeRltE
 Hz3hjHYpSZdn3a0D4sFDIQCYBw+Wf2Slmrq8fpa92F96w6oojhaBU1b0Y5Har9+RoXlS
 ccKebL2JiMbmZ3I8zPnt/4Z7egXj/GMw/RIEMi6D/xOz3AEuGbrtWksYiKalBln1rqaw
 OORA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776713686; x=1777318486; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Me2apjqOYUAZyMPwT+AXD8o/0tr5hrLA4C42ylMR00Q=;
 b=Yptd92owr6Q2XCKitVjhdHPI6jHDIVsDDvuSueLFschTJTh0pUbCFjvoq1PX6vBBSE
 EQksWquxTuajpSqEQ94a8TNm7JZ0FqxLAe4TaguwCHFjB3ivjaLAhwM3Jl608+lOsgPv
 B1eSAcc05afCHGRiMAmC8eOcQBoEBGSsnSFTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776713686; x=1777318486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Me2apjqOYUAZyMPwT+AXD8o/0tr5hrLA4C42ylMR00Q=;
 b=act58Y4aWl5qPKyEHYxVXqoq4Oy7S0eq/Xb5oVVzCpsVm0tIYRrBayN+8+eBm7j0UF
 huKdqwQwcIp0+QY3yXwZ+Kx5hNEd79tDA98lAKXEsIiyWsE8hwfkUoqVnzNnBRGQp2fO
 FIjDlVPCyUCqWehhgIgzRm4q9KxEGRHOMkB1GTsIA0KVW8XDBn75zfMyijizf7Qmk2+1
 o/0SvPEm1K949zZzaoYoX0zDBfoJIZo5scRoZE9ZYb6YFprzOSNlz227fluRR79onI2m
 zoQThlZQ/+1XSodLtfV9dIOdAPCkXZFgam3nRNGV/vFQfDFBxtSXv/xZx6Gur2iUhVc7
 cpKw==
X-Gm-Message-State: AOJu0YwM6qlCOxsXkU5voAVqPYXwJk/ezb8GUlASZKeb1WklvMYtdzCk
 wtnIzUncVhDuu0YiygQtR/5GZSLGjdLvAgA33vpHS7rX3MeiTeAaeQRWvwtylplzyzp0Q1DP3yV
 rH2fQWvNU9ye6OXATDoJcWycokn9ATI/Wui3BJJY4BMFHyqmdkJ5SmA==
X-Gm-Gg: AeBDietLktboXKQJh8brhNW6/jdXOsZKXFJOgLYvqnihq6AitZjugEVo+haH6Qfy1up
 i0CfQ0isFbfPH9WYexgXetoO5TNLOIeQdWNdJa8KLPVDeudftsrjULi3MBB/QcQ2ro/CQ0VrQyQ
 ATZI9f459xx8574wZffhHBvGE/dCMnwWGn5xPFlwNbivRTMsm/6gThLLSeFzV87COxyB09hpwdV
 j5v2FZfSUVyrptQi2EC+zthVchJgh7tSnuvY2wjKRPwkJCUKwbOegYI8rhIDEB17Qwnox/8f2vQ
 8eUWVDyv9WF4IQOA9i1wu1T76zO72eU=
X-Received: by 2002:a17:907:608e:b0:ba5:95b1:f152 with SMTP id
 a640c23a62f3a-ba595b1f822mr487432266b.0.1776713686444; Mon, 20 Apr 2026
 12:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260420074827.3917463-1-aristo.chen@canonical.com>
In-Reply-To: <20260420074827.3917463-1-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Apr 2026 07:34:33 +1200
X-Gm-Features: AQROBzDZpwr6J5_w3tPvGf63owq5kds3LAcLhsulhOrfypB-kugJbr2NuBPbtBM
Message-ID: <CAFLszTjR9uXXpxKXeaH4XotMxtQ-K0mAUegu4UZM8_E180WRhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] test: fit: Use shared make_fname from fit_util
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-04-20T07:48:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: fit: Use shared make_fname from fit_util
>
> test_fit.py declares a local make_fname closure that is byte-identical
> to fit_util.make_fname. Drop the local copy and call the shared helper
> at all seven call sites so there is one definition to maintain.
>
> No behavioural change. Both implementations return
> os.path.join(ubman.config.build_dir, basename).
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/py/tests/test_fit.py | 24 +++++++-----------------
>  1 file changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
