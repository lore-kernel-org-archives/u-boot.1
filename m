Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B6CF94CB5
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:47:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D7A83E76;
	Wed, 22 Apr 2026 00:47:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lux8Ll4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E1BF83AC5; Wed, 22 Apr 2026 00:47:14 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EB783E76
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ba388bc0a9dso845111166b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:47:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811632; cv=none;
 d=google.com; s=arc-20240605;
 b=FjhnQGvRG+d0KX6T2FUuRJVqu8wGKGrL7FaCScqM0thIToWQdasBjOH2n0WxFfeA9O
 3ubAJ9LIystSGWvd4LSxMcoUgzRPLTNW03Qi2eozSsqiLupmsXSoWk2gFWgkcg3UhaKY
 +8b8EckCCtmdvX7BByQtf7VYuKN/ukEdo7XSjWX1Lm2CE79E6+dff0ONM2STAIzxLiLr
 5TXnUxXirkeaDRrFpoHb7FdsWqgKqstlLPi+tTh/lrcGPZpzW9u0VX2QfyhgZRPHkRFa
 FxeQYiXCLuw0wO6niMRXZchIEoAFOZd1L3LkIxA8LCzfaexdqAZ9GLImQx3Xv9WwscTs
 9Tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zwXBu3DpRSlVe0DWL05QmF1vC5TQ4KnCUbuj1DBTLms=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=MNUyPpAjjzEnOhNnSUULiw1JobRBoud/SYa0gV3I6xuuPDqXhzZVf+O1O/KZNZGgLK
 blRkK+mpo7tUPmtBYLivy4JT/D6Pn2atXleUoSMpBrtXQtgO8AjSoMP4rpHn5HnS9IN6
 OR6x9mY8SNbqEyB9AXAkNw+k3xH9zQGYu4bTIME+pLg7J9Fm8xIJ6SJzbp/y6dS9Oz3E
 MOyxc0V2RVDDH3Rvpp2E89uSYoKPbOCKTe8nka/3rnpw7rRoZEe80Cj+EtoUVCpx/xMc
 hQL8xeT5VLJ58nXhJc2Ok8BuOmLOwH7BD0MqerjTT85q/ir1ucGok6pj24iy5SrV2kgW
 ZjxQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811632; x=1777416432; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zwXBu3DpRSlVe0DWL05QmF1vC5TQ4KnCUbuj1DBTLms=;
 b=lux8Ll4Ins7Mim9/2IIgdCVGu7gE0rUfVWdhN9Fn4nUCLKQNy/dE5B8wumgLb25g6n
 ItuwYIXXDbvZgsz54f51QsxGliGcNaF/FUTb46NNM2j20sdZvEcAm48pq/a5q0K4wELm
 OLHIYR7sBYg8JZu3AXgyBgBTjVzFUH5gxwH9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811632; x=1777416432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwXBu3DpRSlVe0DWL05QmF1vC5TQ4KnCUbuj1DBTLms=;
 b=fmVJvxBe7b+ESe5gRmF+4wchTCRb3F5P2Q+Ixz4tL5Oj6bLxORVABhSTtLVoFbbKw3
 FNkdtVt+kqskYleAQBLldmJJACnOqRvYrylxG7srVNimkS0U52VSrk14dZnsgVEM6dNG
 nUvaLDER99TmXTc+fBJC8N3bgd2Mz9V2DwwexA6sFcSGsmdU8CV2fDHNhd+3eMI+RnOn
 XVdRl4CH1co5ACdOa6MqtRqa/kqUV2/8WH+weQnQ/9ad6gmOF8gtCZTxfEkD+V4w9I/y
 kPpfXw00YvEQPnJT4oyyzpq0HGcQXXoehsEbQUKIGy2xZRIJsQhKHKuN586T28JaXDWm
 r57Q==
X-Gm-Message-State: AOJu0YxdQGHMq+inUsH36/43O5dxax/E6Z6AVO/NPexczbQ8UyuIN7P3
 0XO0t+g9f08wqC56yMjHAz4xkEwjk0nyS7PWdVvVLQGToQhhH2hZG8Y8asHVDRLOIoGXkh9yhY8
 4vDdP/u1O8bPybGRE8VxBEqgxBN8Jqd3Nu4OVaMr+fbEZd6Hrn8MmZQ==
X-Gm-Gg: AeBDietbjAb1/9u+FFsHSItiZEFBpTvt5+PxkZ4mrKXtKdAalrrGln7V8KUTyYD031u
 UwnAPTeT7wgIQnJhP1/qVpPjczp88/e6OJ2J1M62JjyH5gqRBt2GnbUDe4KxZKBKymaNlkRq81K
 bnYI+O8djdx+VSU3amprTR7cPx+87/KWkhJKUA42x4sALjMzLJCIBTdemvWd2ANJxi9yAQvPBSo
 474scION9YSk5eVbL23eAKgGMc40tiMrdCpjZnA6KRjW/IPn8caQSajWcNLFlzt1K9s4GT3Qizr
 e3PUnRqFS3a83rZWX2lu
X-Received: by 2002:a17:907:748:b0:ba3:e99e:18dd with SMTP id
 a640c23a62f3a-ba41aef07c6mr945277366b.35.1776811631754; Tue, 21 Apr 2026
 15:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <bc5c9f9ec365ad6100709ff6bb260afb1aec9a50.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <bc5c9f9ec365ad6100709ff6bb260afb1aec9a50.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:46:58 +1200
X-Gm-Features: AQROBzCpZP_hUybhXnk32AZlv2S4h4g11niYwnIE0vXgt7Cv9pd1rP4AFxdR1_E
Message-ID: <CAFLszTiuXfr0u=j-uFj5hZZtgy0-8wgvEvPLbYV65TRsPU4+OA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] cmd: ubi: expose more APIs to public
To: weijie.gao@mediatek.com
Cc: u-boot@lists.denx.de
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

Hi Weijie,

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: expose more APIs to public
>
> Export ubi_detach/ubi_create_vol/ubi_find_volume/ubi_remove_vol to
> public for better ubi manipulation used by other modules.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c           | 10 +++++-----
>  include/ubi_uboot.h |  5 +++++
>  2 files changed, 10 insertions(+), 5 deletions(-)

> diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> @@ -47,10 +47,15 @@
> +int ubi_detach(void);
> +int ubi_create_vol(const char *volume, int64_t size, int dynamic, int vol_id,
> +                bool skipcheck);
> +struct ubi_volume *ubi_find_volume(const char *volume);
> +int ubi_remove_vol(const char *volume);

Looking at patch 8, only ubi_find_volume() and ubi_create_vol() are
used by the env code. Please can you either only export the functions
actually needed, or mention why they are exported in the commit
message.

Also, the dynamic parameter is declared as int but used as a boolean,
so could become a bool ?

Regards,
Simon
