Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D684E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:44:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB6FD8634D;
	Mon,  2 Oct 2023 03:23:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NDJXh3cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A19C874E1; Mon,  2 Oct 2023 03:23:21 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51108874CA
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32325534cfaso11174881f8f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209781; x=1696814581; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GhFkCVVoGnatNFE1DqXBevJ/nlG9ILoN9SP2sSoYmWw=;
 b=NDJXh3cVH2vBvI+pEAW98WMM+cBpZEosQnsvOKh9NAVhLBMnNq2Imz9WIXy+zwPl4/
 qATXbBWZMiZbyUWw3wl5WVavUdEP8JJX3eR6M9ghX8GHKIUdthWGjPL/zkk3STDfGZef
 Hd0Nk0Rd6Zb4Z4ssr68bggYPwfaKRr2IAgMng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209781; x=1696814581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GhFkCVVoGnatNFE1DqXBevJ/nlG9ILoN9SP2sSoYmWw=;
 b=R9En2VCeqEjBGtgdefO9rd1mDCnhoVmdKXgdX5XiPL5s9ga0ItukySSWrBtceWWIsW
 HErJOXrJrkQNmKajlFOICLgXrvQSOskw3JspXOYYREkZH3qcvRZLrVG/52Zl9It1Aey1
 lNki39XYkCiGJEbxSeFM7paXAeFb/B+9bbpV0UwfbstUqpIbqpoKRfugSbNljfX+Iun9
 lqd6lLkGi8vuL+xMjA2HJLxBL8Z6Pu9o/+OCwTfzLVk5eZ9Xqz1tp8QofUCN58QUX8EA
 ZM62ovE/KAB+PFALXv+ahLdJmOIWrd4x9Mgo7Ch9QFAesME2FRdEXac/gTISrawAaGxt
 DxqA==
X-Gm-Message-State: AOJu0Yx7HrihID5LnPUc3yqt8D3XhQ+EpT+kH+471GIRBKjiCdZvQKlM
 UfZ9rnm5pUIfzhXh4ZMkPK8LXjP6MgWVADyb3MkGEw==
X-Google-Smtp-Source: AGHT+IEgCvA7dSm46WJhQYzKa5ZRXBTqgGArsx1ZQA/+d+3W6LzGVx+FD42yLY5CO7OAnrmbRTNiAJr6GaZZIphZRK4=
X-Received: by 2002:a05:6000:1005:b0:319:7b66:7800 with SMTP id
 a5-20020a056000100500b003197b667800mr7684239wrx.55.1696209781067; Sun, 01 Oct
 2023 18:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-5-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-5-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:13 -0600
Message-ID: <CAPnjgZ2-Ci6LgPraMXgNtS8-xQhbQBjowu=KcZ1SjSvjRef0kg@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] test: dm: add protocol-specific channel test
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de
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

On Tue, 26 Sept 2023 at 00:58, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> Any SCMI protocol may have its own channel.
> Test this feature on sandbox as the necessary framework was added
> in a prior commit.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v5
> * new commit
> ---
>  arch/sandbox/dts/test.dts |  1 +
>  test/dm/scmi.c            | 20 ++++++++++++++++++--
>  2 files changed, 19 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
