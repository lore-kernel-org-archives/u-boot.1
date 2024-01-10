Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A95FC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 14:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 321D787A7B;
	Wed, 10 Jan 2024 15:12:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YdQX71+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A6DB87A79; Wed, 10 Jan 2024 15:12:01 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED7887AB9
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 15:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50ec948ad31so2782495e87.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704895917; x=1705500717; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wVYqvbUgva5GBq1nfKmGHfzF1QI+Y6z6rHSylnduZRQ=;
 b=YdQX71+EvH7EwiUMV+BF7BFfkJB8i6My8yaPuOyKWD37B59AjeUy4LL7aGnYi7rZo7
 k2KqXhE33/tgXgxpdW9rnTz0+v0dm/pIyzatj+bVzTO0YBFOgLvJROLoq8p5jEnUq/HN
 D5tnVWiuovU5KqYiCroSKD9SFuliYqk8Lq/MOnj0tv7KWcQP1zldigQpkMupAg42F1Ml
 pUqfpMv/fFUacrTd91umVPEozGzK/CrQm1rOquwQGbwpqOyCWaC09LWulgIWaNYppHHc
 QIp9guvNmcQSVhaj4sO2XdIDy3NpKf6oiv4y9nQMg6Jw9D+hLXv0KrjaxRjN2nUE3K0U
 xfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704895917; x=1705500717;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wVYqvbUgva5GBq1nfKmGHfzF1QI+Y6z6rHSylnduZRQ=;
 b=RaFs147+cluLmaFzMG98NgdqmsnDJejQDShtQPyYSMw82i96sp2SrQ31aW+5Ch+kxn
 N1r+WPAnRMbo2l7JbTqx1s1IPHo03hX91onZRwhGxn9ydTu1oFuDXTRVSrfMSGqboL/u
 ajhrbUX/V7aRbjETJloqw3oHQSqD47Lfr73Y7HRdPKcm2cHO5g/rh4zoAS0i9kQ7mJcv
 00u1fYFsYSxN/Qpkxgk1VXQWGLlFF+Nn9kx9/y/puR+8bSmt3sdeZxijIWvVsS+rZ7tb
 neFFQOTsGlOCaPHFQxs02jf1TEOOJ/epLJkM0CPNLjhsO+LMXw/ZoWHNqI7tUr5tyutZ
 GuGQ==
X-Gm-Message-State: AOJu0YyOAGBUrti8cIaR9sVK+yzli0va0BAGqRObG3NkmFLy/SRmmzc6
 phx5Vx5t7V2syGVcpCOVytgI2QwOcTlt0+60jbfw93b3mXxAPA==
X-Google-Smtp-Source: AGHT+IFBGQcEkoCQuFM1kZtGkrsuNWumyawvF+iXYBTKx02mn9dtgOEiVYhrIRz5PX9x9CTJaYepeuh+a95K9hxYG/Y=
X-Received: by 2002:ac2:4f81:0:b0:50e:a431:de2e with SMTP id
 z1-20020ac24f81000000b0050ea431de2emr374398lfs.138.1704895917373; Wed, 10 Jan
 2024 06:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20240102221237.1007090-1-raymond.mao@linaro.org>
 <20240102221237.1007090-3-raymond.mao@linaro.org>
In-Reply-To: <20240102221237.1007090-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Jan 2024 16:11:20 +0200
Message-ID: <CAC_iWj+q0zCSm3mcsZz8_iiQsiFRaSeSS6qAqiKb4f2OqHGTLw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] bloblist: check bloblist with specified buffer size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>
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

Hi Raymond

I think my r-b tag got lost across versions

On Wed, 3 Jan 2024 at 00:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Instead of expecting the bloblist total size to be the same as the
> pre-allocated buffer size, practically we are more interested in
> whether the pre-allocated buffer size is bigger than the bloblist
> total size.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v4
> - Update function header of bloblist_check().
>
>  common/bloblist.c  | 2 +-
>  include/bloblist.h | 9 +++++----
>  test/bloblist.c    | 2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index acf67304d0..4039eb3a03 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -384,7 +384,7 @@ int bloblist_check(ulong addr, uint size)
>                 return log_msg_ret("Bad magic", -ENOENT);
>         if (hdr->version != BLOBLIST_VERSION)
>                 return log_msg_ret("Bad version", -EPROTONOSUPPORT);
> -       if (!hdr->total_size || (size && hdr->total_size != size))
> +       if (!hdr->total_size || (size && hdr->total_size > size))
>                 return log_msg_ret("Bad total size", -EFBIG);
>         if (hdr->used_size > hdr->total_size)
>                 return log_msg_ret("Bad used size", -ENOENT);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index bf9e12ebf8..1906847c15 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -348,12 +348,13 @@ int bloblist_new(ulong addr, uint size, uint flags, uint align_log2);
>   * bloblist_check() - Check if a bloblist exists
>   *
>   * @addr: Address of bloblist
> - * @size: Expected size of blobsize, or 0 to detect the size
> + * @size: Reserved space size for blobsize, or 0 to use the total size
>   * Return: 0 if OK, -ENOENT if the magic number doesn't match (indicating that
> - * there problem is no bloblist at the given address), -EPROTONOSUPPORT
> + * there problem is no bloblist at the given address) or any fields for header
> + * size, used size and total size do not match, -EPROTONOSUPPORT
>   * if the version does not match, -EIO if the checksum does not match,
> - * -EFBIG if the expected size does not match the detected size, -ENOSPC
> - * if the size is not large enough to hold the headers
> + * -EFBIG if the reserved space size is small than the total size or total size
> + * is 0
>   */
>  int bloblist_check(ulong addr, uint size);
>
> diff --git a/test/bloblist.c b/test/bloblist.c
> index 17d9dd03d0..7dab9addf8 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -207,7 +207,7 @@ static int bloblist_test_checksum(struct unit_test_state *uts)
>         hdr->flags++;
>
>         hdr->total_size--;
> -       ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
> +       ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
>         hdr->total_size++;
>
>         hdr->spare++;
> --
> 2.25.1
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
