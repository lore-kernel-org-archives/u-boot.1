Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F420DEC8732
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 14:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 508138657B;
	Thu,  7 Sep 2023 16:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m+54dRmy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F4AB869D3; Thu,  7 Sep 2023 16:23:04 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0E13869F2
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 16:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5007616b756so1703190e87.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694096580; x=1694701380; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AJ5oYYktQajki733I4I1yj8renUq37nMLSi5MYWxSKM=;
 b=m+54dRmytQ/D/dx1el4KcwbLiX2bphq1s2Bku1aoM+x43Pck6ud0bX9wyYd6Zm1NTJ
 eUbe2m7WbP/lcuHmW1ZXXMTl1FIzBUog7YJjaF6YtDxURqWv+XiJn0VwvDo1udcFG865
 5SVQTDPmGxh3/sqR1gBbqRTbA8TC2AWusruCNfgYrWrNalUhsRcBS7IeQeNrML+gZoVB
 ATFM3akgv+VtLumoqjSCU/4qBVkbsZMNGpez0+IyhcCoi9m8LlUJIxIjnH3al1pGeAjO
 vZ1HrLuPQdSyhRvquYs6aidb6bT/CE9K920wBbe0adiCSeRGuEwi6IVAzFID0bi5OXGG
 EgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694096580; x=1694701380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJ5oYYktQajki733I4I1yj8renUq37nMLSi5MYWxSKM=;
 b=VBiserX7lcD5ALNrQjRh3K6i5N/jSvgza17MKtY/4jAwDJ28ux+DjoPXgjOey0BdyX
 XnVOHBb5W7aqf/H4mfl5KZxCQUKhrw9O4Z91EKXzrm8kFiQ9hxRISL8lP3V6Rk4WpwSR
 hkD0ZBNQhBuaZY3XHnzNp/kv98DpQnDLNaxxQzZa6lLa6S2XX/vY62GoQA+ZI0aUU+CQ
 3zt0rSrSabP0lfv+VVRbFKazBsbmXwa/QVyTmf8fFus5V6nsei39Q6VgM+72DHtnxd4J
 OGFHQbgT+2jJCGHd/dTyhZlmQcvAUETiW4e+uOTGC7QCPrUY5uSAyVVKTOnLkhMcaQMj
 hnhQ==
X-Gm-Message-State: AOJu0YyfdO9w+cwsKBFG9Z/n1PKlBYHIf0wdb2y/ZhgR+jdeO0JayEF4
 s7l+r5rcPEmhzO6BCopARPDQJr56R2JkXoR6ssO1eQ==
X-Google-Smtp-Source: AGHT+IFhsgYOExqfudmLkrAB0DziiRGGyYZY6PLj2VwKWt3czAUWHo97Len5d4WIw2IygKFcOoB0aVGwktEQQu+Glt0=
X-Received: by 2002:ac2:4c36:0:b0:4fc:df79:3781 with SMTP id
 u22-20020ac24c36000000b004fcdf793781mr4649086lfq.66.1694096579888; Thu, 07
 Sep 2023 07:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <f0276ada1166fb05bb4277c213b4c8f96b63173f.1694091345.git.michal.simek@amd.com>
In-Reply-To: <f0276ada1166fb05bb4277c213b4c8f96b63173f.1694091345.git.michal.simek@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Sep 2023 17:22:23 +0300
Message-ID: <CAC_iWjJ18Qz5fKq1+0HM8mv7PAE5eL0BbKX2e3cUxyU3syzCtA@mail.gmail.com>
Subject: Re: [PATCH] sandbox: test: Fix typo in test.dts
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Simon Glass <sjg@chromium.org>
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

On Thu, 7 Sept 2023 at 15:55, Michal Simek <michal.simek@amd.com> wrote:
>
> s/parititon/partition/
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  arch/sandbox/dts/test.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
> index cf1b3da9cace..19f184e791bf 100644
> --- a/arch/sandbox/dts/test.dts
> +++ b/arch/sandbox/dts/test.dts
> @@ -112,7 +112,7 @@
>                 /*
>                  * This is used for the VBE OS-request tests. A FAT filesystem
>                  * created in a partition with the VBE information appearing
> -                * before the parititon starts
> +                * before the partition starts
>                  */
>                 firmware0 {
>                         bootph-verify;
> --
> 2.36.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
