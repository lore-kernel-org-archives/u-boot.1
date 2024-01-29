Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8DFC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 13:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B455A87BB5;
	Mon, 29 Jan 2024 14:22:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yjRI5wHk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A6A87C9B; Mon, 29 Jan 2024 14:22:28 +0100 (CET)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4FB487808
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 14:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2cf338e1438so26559971fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 05:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706534546; x=1707139346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kXrtqe/l/RjjWKCzA1an0+3fOhl4nP7PwHO6kMwHmLQ=;
 b=yjRI5wHk0Hj7QrP4BerAkFuKrByFFUCW5o2GEpxmgJ/t5zdQDQ9gWf5N9aejos5SfU
 AsLqS/O3/RZJ4Dbu9LsAygidwWbHY/257/B9t6kbxbclzqjlVL3Ij0Yd8gn1hmmb5RI+
 0JVAMXD45rEl+RvpDPxxkyEgC0EN2v9ta3HNehQ9lTPTSywcsY8QnRp1u35o6H8dYvRj
 1MrrzFw0kEv9Yl08/l1YbnzkYxMOcE1sGA6ADYP0CzNhg9r23O9uKjDHtaXW/D2ez3v9
 0Go6yh+iqYVBMj772Oifp5aJ++iKhBJ68xF5oM0Brr206y+9uyqiwenvLjVhzqZA2St7
 6X8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706534546; x=1707139346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXrtqe/l/RjjWKCzA1an0+3fOhl4nP7PwHO6kMwHmLQ=;
 b=hFXGj/PQ7qABDc4JKBrRolUQCAB7W/P3nAP5a6MHz9B6N5AjaLZ6clU6wT1tT3eQc4
 yor1mi/bf7NQ4G5UaKI0fAzdzV2/wZvKyDjvdzqDahwilAyvuSATqUv3jR4bFWIo+vhu
 QjVmSD3wD8FKaj1O7naHDIPUtBb2nYqrPerNG86BSHr5TbVUPok2YIkoR4SAT5ue3zxb
 U5/7TBTkkXtZl2lIxoMkTSbUIgSrWrWJB3TB5oSS35MfsNmGVXZsP5cmtjfFP6L0MQ2e
 YGn4y3b7kz7rbBw/ykX1m1v17eiWc2HXZJu/mdTACJ2Ub5hWOBkw2MJj8BDpyxVr1Ehq
 0kDQ==
X-Gm-Message-State: AOJu0YxeeXrZm2Y6vFzCjSvHuKlqYLwADsB5t5xXnTvKgsoebguFwuv/
 WnLL20+rWPwYNq9cqqg4Q2jPKQBuAhCp4XAc+gNdlu41SgsmanBsO1YVl5fmbD8CeYAT3zt8u7V
 m6V33jvSvvnpHolyp9jIvDnvcr44eicSdyNm9XA==
X-Google-Smtp-Source: AGHT+IElXN4aGU53Lr7cZNX0O9Vod0WP29gVrFBsV4a/XfYinwDrmbtj0iUdCTmU7mhgomu/8nd29jwNWKepLu/CAwk=
X-Received: by 2002:a2e:be06:0:b0:2cb:280a:ad3c with SMTP id
 z6-20020a2ebe06000000b002cb280aad3cmr2441723ljq.13.1706534545941; Mon, 29 Jan
 2024 05:22:25 -0800 (PST)
MIME-Version: 1.0
References: <20240129125818.47453-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240129125818.47453-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 29 Jan 2024 15:21:50 +0200
Message-ID: <CAC_iWjKOjRYgTpbqjfB6Ygari2hRYvN2A0SZGx8yVveovyc-wA@mail.gmail.com>
Subject: Re: [PATCH 1/1] smbios: get_str_from_dt() - add sysinfo_id description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Mon, 29 Jan 2024 at 14:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add description for parameter sysinfo_id of function get_str_from_dt().
>
> Fixes: 07c9e683a484 ("smbios: Allow a few values to come from sysinfo")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/smbios.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/smbios.c b/lib/smbios.c
> index 7bd9805fec0..11b7611a84e 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -207,6 +207,7 @@ void get_str_from_dt(const struct map_sysinfo *nprop, char *str, size_t size)
>   *
>   * @ctx:       context for writing the tables
>   * @prop:      property to write
> + * @sysinfo_id: unique identifier for the string value to be read
>   * @dval:      Default value to use if the string is not found or is empty
>   * Return:     0 if not found, else SMBIOS string number (1 or more)
>   */
> --
> 2.43.0
>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
