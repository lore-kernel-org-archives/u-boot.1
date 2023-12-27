Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0231CC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464DE876F8;
	Wed, 27 Dec 2023 10:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ifcaSAll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E87F87855; Wed, 27 Dec 2023 10:53:49 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504C68764D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:53:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e7288a6e1so2814485e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703670826; x=1704275626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5MZrjsYZHWPN27ms/FcxHnA8598boJdgCEaxM/cf6e8=;
 b=ifcaSAllxec25Cva1ro0CxoPbi9sMmmYfkS5EQVelPaN321+yVobjx9EBErv1EYogD
 bz7vDewr7aFPU90nLR+rRfAF111SfVF1zfNUe72Lgma/0jZsEEEXVoEyFZYc779GPNQI
 dyEm0Hfn05ouEwM1Dm2hh6friDeKK7XJwCR+ujlMAUmEJdbsUDer7qRa+KAAUbidjI5c
 GAzqoiEVYZl/Fl45uXztRiWk8drOK7NBy6qirxdcb7/xcewJXyVOITGOiNl3/wClnNpr
 +HE1iJAUKTWwSd1mMxZX+assVOJGQI4K40X8pUzStAaK0HXF69BSf8+JGYzdvQ5y1C60
 jwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703670826; x=1704275626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5MZrjsYZHWPN27ms/FcxHnA8598boJdgCEaxM/cf6e8=;
 b=bfdtTIqXmsFOfqAX4qY16UTM/zFtX82dYVY3VrtV/eNQWYabsM6uA6LxN5FMqwFGmb
 adkWlBhINsGcQmUd2eo+C/eGOmjvolyiE7hGd4U4T4yQEwY5oW46ZDUTdgQcZRZB974V
 kZAhl9plYRo8+Cp+ncefUUu8s1BDxpMUFynCuBKYOE3FyqALPPKhNrlbCntJevIuqAAQ
 oTa82uKhhK9vTd3v8ecD3sG1YQgk02doHGaKeDwILURU+SCeMJrjg5XRa20vwnPe5SAB
 jCWm7gFS7jH6ydl3lzQhoIyB/IXm87xisDl3iScPX9PI3d9Hnq8pNvAlR4b3HRW6PVdC
 06pg==
X-Gm-Message-State: AOJu0Yx0vfaDT0rc3N2gvzC6hWRg3qymVa0tGH8XpGLKuyvH0ySXKpkG
 1kscTh3+ue8QBsQEIqJB1lwRRd1dmrCg7dz6cuZ4AypT/tOKBQ==
X-Google-Smtp-Source: AGHT+IGxOmtTAztPTgCzTOiC2UmnIhhI503gufYvdFWsH5oaJEH2pNVa9oV4JD3/YG46dJ35CV8dCfrD+/5xZIunTqg=
X-Received: by 2002:a05:6512:2211:b0:50e:7d20:a74c with SMTP id
 h17-20020a056512221100b0050e7d20a74cmr1543455lfu.50.1703670826537; Wed, 27
 Dec 2023 01:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-3-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 11:53:10 +0200
Message-ID: <CAC_iWjKEeQ6V9O1EPfP1oR+CyZfEE-gANg_su=53QC=MdMkauw@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] bloblist: Adjust API to align in powers of 2
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

Hi,

On Mon, 18 Dec 2023 at 20:19, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> The updated bloblist structure stores the alignment as a power-of-two
> value in its structures. Adjust the API to use this, to avoid needing to
> calling ilog2().
>
> Drop a stale comment while we are here.

The patch does more than what the description suggests. So either the
new 8b alignment is wrong or the commit message needs and update and
explain why we are changing this.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---

[...]

Thanks
/Ilias
