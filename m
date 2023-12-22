Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C8BFC41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 10:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 930FF877CD;
	Fri, 22 Dec 2023 11:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="adNKP1qE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07DDC877D9; Fri, 22 Dec 2023 11:56:26 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AEF5877CD
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 11:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2cc9fa5e8e1so18336931fa.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 02:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703242583; x=1703847383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OxULbp5PfIt5ZwDgO5uKTN5bsO24nWTsxVrw+HJa7kI=;
 b=adNKP1qEGY+yhYat92qgDNMgVhEZQsc30tDANknTKiGWFCTiteaokM6uYL3YoUTnBw
 8RDopSY9TSj21PXU6Tb1cVxTgN7r42O44lrk+qSsHMk8O1/UjhXR7ArrtIUaorZOXhLV
 8mBh74C8Ownn18kMkexgqOwI2GDuOMC5D9R6ZipT0nXSaomalNEA76fy9RhGKdrkROVC
 Y7+KlinNOzE3pUhKrWXhilNatLQ6Iczq/NkYgdFCPvTwlM51vQsMr1t9A/Az2e5p0e5B
 Ic9l+Got92WjtBxnXsUBxghQDTIrr2U+H2PikZP+b3mbblgfx96Uggnc7CxZHrSGfIM8
 2GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703242583; x=1703847383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OxULbp5PfIt5ZwDgO5uKTN5bsO24nWTsxVrw+HJa7kI=;
 b=YjSx3dZr08IR1vHR0zWfchnx7UxtYKFQ7db6qeK0X+4OKuDoLjovp46PgIqnh0xf54
 YSupDUhU73mIqTtgMIvVOwXlN0+Pq9aLZ8WSQjYhHx7ge+rJt2L3/XUnxUMRGZ5dcoll
 MED2bGWWJiDbaHcAxsdV4aApFBPCVrm3ga9esXB4nXatxRwusPCMgGoSgYzyFf3BXyX0
 VnMdh18aT6qMJF9wpdrr1SgAtUjiEsrHKRsvlEW43ICwFeocqx40h5tZ8PFHgiw15wa5
 t2jTJEmptvdgkX4Divp2f5xg7jsFhgtZAzBLzCUf7cbhr0UBm8Ptzuw4+XhVLNRz5wUf
 bvYA==
X-Gm-Message-State: AOJu0Yz9uSfideu4qZ3FsQa4JMhMI3RFxWvU3WoLs1W8fjnm3hHRpq26
 pN6m8HVtcDlpAVEqUp0BfO9oTh8fO5S711BVAhVhqLcxVW+hdA==
X-Google-Smtp-Source: AGHT+IHTJd7fAOqI3spfiJg+RXx/FB0eZs8EyXKrRYVhG2N+3rOs6dUeWGxgJRZtJFL/0m7S7PA4ZZFMqhgS1l9oV/c=
X-Received: by 2002:a19:e05b:0:b0:50e:4acc:d101 with SMTP id
 g27-20020a19e05b000000b0050e4accd101mr602103lfj.28.1703242583497; Fri, 22 Dec
 2023 02:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-3-raymond.mao@linaro.org>
In-Reply-To: <20231221004030.581388-3-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 12:55:47 +0200
Message-ID: <CAC_iWjJZKTjSFiveL6hxao8gv4=u7W4JBqTqFh1GAK-Xm9hEfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] bloblist: check bloblist with specified buffer size
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Stefan Roese <sr@denx.de>, 
 Sean Anderson <sean.anderson@seco.com>
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

On Thu, 21 Dec 2023 at 02:40, Raymond Mao <raymond.mao@linaro.org> wrote:
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
>
>  common/bloblist.c | 2 +-
>  test/bloblist.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 193122a8af..be2050611a 100644
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
