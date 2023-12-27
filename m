Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A2CBC46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 09:57:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25EE876F8;
	Wed, 27 Dec 2023 10:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h2q0JTIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA808776E; Wed, 27 Dec 2023 10:57:49 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1AC58764D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 10:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ccd4b743e2so10674391fa.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 01:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703671067; x=1704275867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DxbboORiDWpQSxAfHT7JN1b42fpeltxUuJRTiG8jBGs=;
 b=h2q0JTItTZzFp/MTnZNZigj6jzlOmDv6Vy6Jgi4ogUhJT26eLj80KOGhX0SCGxOXRt
 kKsbiP41ndtOnjjvZl5N4mTYs90q6TsY33tzMdOE24ZWWEsqONAsl9J2Vx7Oz2f4gsd+
 IntNdWG5QapLQdFDGaVHU6Y+SiuJKh2SnP5hNVyiHY1ERlxVp9s/+XZ5i/l+AuiLVcCq
 awChh2dst7IMA1xNsY+tI2L3hruokYYNdzMK3BjDSYgUKprowmsRBUZwy7LVuTofxVXF
 UQViW2qwiWUC3L46Um11ymvU+o4ghbuh3I6AbeBg+eLjWgdLPABjOZxZrknbNAWp7XCN
 MXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703671067; x=1704275867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DxbboORiDWpQSxAfHT7JN1b42fpeltxUuJRTiG8jBGs=;
 b=KOfPLjZNV4K7ND6lMiz7bwVVe4YkamhnG+c3xOy5z1cptEFmUEZmTqTq/ppq4Lomfm
 yl9KMmK9HzJ+uohd+aG8FMLD5DpgosMLn6LcH6USMeGWGMKzgldVaj8c0+0Pla3o7GEe
 +g9GsE6sG+Dx37ACGhta9SiaBC03askQnk7po0oCmp8KCV3Q0UQHWglrUqo56Uujjmq1
 7uQh3lnx74F0ujCz07JCYGwpliKVFFuaw8rC3CXLAjsY41XcgdY5Mf2mY4xw0YKAumT/
 MmFRQCg31HNlQtSqLaPKSpte1bbr0HJUlcY/+Z8oq1sx+EEB1wLR2fjUvHfJsEuC1oMW
 /mzg==
X-Gm-Message-State: AOJu0Yz4TAQDgzWIVlZk7vh4R9H9a8UU1DH7P022NM87HoAZfqcMDUR7
 0m0F3+oJYf0Wf+yR3hx54gD7tIrz132YoLK/z6cC1RLI5vt5ZQ==
X-Google-Smtp-Source: AGHT+IHE0kwswoXZLfq6JUYkGq4Orj8BRXqd7leoZIbfLkjlfAGzN2q1R1lf0ZUZhLGnGz3t/VHrOAJlELltB6Mr7cQ=
X-Received: by 2002:ac2:4bcd:0:b0:50e:7702:a184 with SMTP id
 o13-20020ac24bcd000000b0050e7702a184mr1899770lfq.15.1703671066997; Wed, 27
 Dec 2023 01:57:46 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-9-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-9-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 11:57:10 +0200
Message-ID: <CAC_iWjKEQyE+nmj16QVBLjnP5k3Wv+g4kYxXXAkzx_tPPhparw@mail.gmail.com>
Subject: Re: [PATCH v3 08/14] bloblist: Checksum the entire bloblist
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

Hi Raymond,

On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Spec v0.9 specifies that the entire bloblist area is checksummed,
> including unused portions. Update the code to follow this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  common/bloblist.c |  9 +--------
>  test/bloblist.c   | 10 ++++++++--
>  2 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 32692d8319..705d9c6ae9 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -319,17 +319,10 @@ int bloblist_resize(uint tag, int new_size)
>
>  static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
>  {
> -       struct bloblist_rec *rec;
>         u8 chksum;
>
> -       chksum = table_compute_checksum(hdr, hdr->hdr_size);
> +       chksum = table_compute_checksum(hdr, hdr->alloced);
>         chksum += hdr->chksum;
> -       foreach_rec(rec, hdr) {
> -               chksum -= table_compute_checksum((void *)rec,
> -                                                rec_hdr_size(rec));
> -               chksum -= table_compute_checksum((void *)rec +
> -                                                rec_hdr_size(rec), rec->size);
> -       }

Why do we need patch #7 if it gets removed immediately after?
Can't we just squash those two with a proper commit message, since the
spec requires checksumming the entire list?

[...]

Thanks
/Ilias
