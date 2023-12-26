Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C72C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:49:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF1087900;
	Tue, 26 Dec 2023 10:48:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HjvqCbSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF418781A; Tue, 26 Dec 2023 10:48:01 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D38078786E
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35fea35c432so27413165ab.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584077; x=1704188877; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7Vdt2ZrlarYYLjq+P2Sk/tSH1ncEI1leGSaCsmmEXA=;
 b=HjvqCbSDwtQO1hsmpNBAxaB7hAbrrpJsqNhvSVsWvYBlpUm/ND5DeYEvRYHxEuOYJk
 n+a6Qc85WceBHskLXeCjXm6CaY+1NAiwsGnn8BgVR/Q8QkfGjmV8KCZlAmpukCmeD7FB
 CjJOCtxpUsQ4E2mrpCwnB3yDfPOTajzSUxRBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584077; x=1704188877;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7Vdt2ZrlarYYLjq+P2Sk/tSH1ncEI1leGSaCsmmEXA=;
 b=uOlniVOo709bOIuYl+SSW0KaM2dI2Cb55U2rGHShrmIS7JoyRIeVBG7L5I29WJzQSK
 chaojZCjYscBPw/PajXFx/30wv0ZrJ8G1ztI8vkOP/sS8SUVmUme8c9FD7oBCNWJ8Pgm
 aXb3Y8WWcDMBzUpZEAM9nR4kYGvS3a6wGeCql0/Yuj1CbqQ4HzOWZcwYF7NvZMs9WY7D
 1g1JWHbUmhT5UpHqd/3bc9zNva+E4ILduuq1l6vsfn+JPB1EuWlpGedBMZLtLgsXEjws
 7KllzdpzojrTiU1Bit4z65fJ9ExJXPAAdBB0nEYxNPERUQF+bP1VS4m+m6ctJ2sMCbD9
 xMlQ==
X-Gm-Message-State: AOJu0YwmrqeWF2nrnotPe+oytr6GxrcLl13bF+QzRUEAx6jFl9tqdFJA
 m3kME/3RrvWiRxL6qa1FKRcasvrFcvhAV1iuXGoHKiiYSrn4
X-Google-Smtp-Source: AGHT+IGCGHbNxZF+pfUyqO9mUQEPOqUQGfA6s/rjnfizl7yRe/Y5pZFAg9c15IeX470d2oUlt8J8KL5Dj7gQcpAsyAA=
X-Received: by 2002:a05:6e02:3105:b0:360:18f:dc14 with SMTP id
 bg5-20020a056e02310500b00360018fdc14mr3914831ilb.54.1703584077507; Tue, 26
 Dec 2023 01:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-3-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-3-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:40 +0000
Message-ID: <CAFLszTgW9Gqn8RhDN_2DBFJm4ZpLB6eHd07xhQmJQOMiiK59-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] bloblist: check bloblist with specified buffer size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Shiji Yang <yangshiji66@outlook.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Raymond,

On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Instead of expecting the bloblist total size to be the same as the
> pre-allocated buffer size, practically we are more interested in
> whether the pre-allocated buffer size is bigger than the bloblist
> total size.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
>
>  common/bloblist.c | 2 +-
>  test/bloblist.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index ba17dd851a..db3fbb20cf 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -384,7 +384,7 @@ int bloblist_check(ulong addr, uint size)

Can you please also update the function comment for bloblist_check() ?

>                 return log_msg_ret("Bad magic", -ENOENT);
>         if (hdr->version !=3D BLOBLIST_VERSION)
>                 return log_msg_ret("Bad version", -EPROTONOSUPPORT);
> -       if (!hdr->total_size || (size && hdr->total_size !=3D size))
> +       if (!hdr->total_size || (size && hdr->total_size > size))
>                 return log_msg_ret("Bad total size", -EFBIG);
>         if (hdr->used_size > hdr->total_size)
>                 return log_msg_ret("Bad used size", -ENOENT);
> diff --git a/test/bloblist.c b/test/bloblist.c
> index 17d9dd03d0..7dab9addf8 100644
> --- a/test/bloblist.c
> +++ b/test/bloblist.c
> @@ -207,7 +207,7 @@ static int bloblist_test_checksum(struct unit_test_st=
ate *uts)
>         hdr->flags++;
>
>         hdr->total_size--;
> -       ut_asserteq(-EFBIG, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE)=
);
> +       ut_asserteq(-EIO, bloblist_check(TEST_ADDR, TEST_BLOBLIST_SIZE));
>         hdr->total_size++;
>
>         hdr->spare++;
> --
> 2.25.1
>

Regards,
Simon
