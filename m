Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FC1D6AB00
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 19:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF79483D8A;
	Thu,  2 Apr 2026 21:41:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QC3uSUru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91F7C83F7D; Thu,  2 Apr 2026 21:41:26 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F3683CF5
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 21:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b980b35534eso395294566b.1
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 12:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775158884; cv=none;
 d=google.com; s=arc-20240605;
 b=E6zYW57hWsmumrRriU/5Ly+lfA+99ktLdwC4BSm0aXmbn1mO2yPueijzJUfgp+7iqc
 AZ2LHMpfMSDuA+Pe4AJFn1Ju/lWqJQarHpHoxKoRHJ0p2/DZfP3xrq/J1XqUvS74K4B8
 u+QJFtKKVK9T7E//gdyaRQPX1kC/+NMDc8P/ySa6+cF39I5b56QX2cSwci5/sctzOeK8
 wHbEI0gpzxXoJtMr6Eys4CsipuiavofHvUqMLxf4tiFkwNAlCGsiWiQvE5r2OdQE+cL2
 T11344b7155ewob4VuvZnIHEVmI/QblyYWF34kVpU+62CKlN8Zo+ALcK4TpPS91Lzxj4
 UVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d1v4W2e+Nt9BtWn2o0WHq+5qRb1lOhFYQsxl0skpjoE=;
 fh=tiKxKG0ExrUaO6gh/AgaM/7ncl/D75hR3irjI9i0s/Y=;
 b=iBlMc6CypsB7VrViH2kg4+7r7g8wqQiH8KwHwMPq40XRO2f/5tn6v60CF1F86iJDlt
 WQZfMlEGQpSTSitrWv+zajm1BARLoyqHkoL61aIcC/2aiJqfzeUxtGKK4crmnbPsqya7
 13y4cRaiKyKbt6wxxqeN5pSR28al43At4xjYOvBwDVUIu3nCxI6r1C8Sppr5IsmCwylY
 AzQdLMp5rlJAt9y/B6x6OYvF8+U/lfwmXSxs9q7u8NsgMzHdsEpSMDCieG3HSlDZGs0D
 qzNu9ZAQOSL7hWWDY9yTvIZ9Kk9ST303+5wX6wjx9Xw5xvoE8LE00fbG88K2msM9NZWK
 Ij+A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775158884; x=1775763684; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1v4W2e+Nt9BtWn2o0WHq+5qRb1lOhFYQsxl0skpjoE=;
 b=QC3uSUruVDmqe6bL4bs1WZPsw7OldL1tBPAhSu63B6YN+T5YceDjXjrPGB9llMFujJ
 KdSSoPfXRLzVJKE7yQRIfE91KUYiadRjBc0UPW52a7sTOvFmS70gzyoHBvqWg50DCgvK
 Wv+wPJEmtvXVCoJy2N2UHstQfa5Mb5S3vE2d0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775158884; x=1775763684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1v4W2e+Nt9BtWn2o0WHq+5qRb1lOhFYQsxl0skpjoE=;
 b=VfkwVDZprz46KMdekXLVlSoqFuxfhL4yVuMo7sp1AXXqpl+7x8O4Y5mNEkQmc2uksn
 Wa5bDDROezq0yrDQrF3YLdn1/xbyawrZ4bcoaGL0QWeumLPKrWB8JlBDb7H6+aQSj0lc
 E773/uZu2eH3B7pyaQgaqE3c3y1J7/PCXmR/hvdMaASlVqQZSiDDwCZnxjJDEsWQraXt
 Fiyguv2rymysipSY8vnYdVMKoZtqt6i3NO7n7GUGhLuhKGddsV5GUqYWxFO3K2AqzbLZ
 PUebawKPpC5bH+H7i7jDCCZ4SEcxwyzGRuanISVzdm2lAqM8tr/beKRBD72GSHqhUAy2
 qZuQ==
X-Gm-Message-State: AOJu0YxC+E+7Cz80cCS3uQ3VUJ3PAZbyfRoJR8l79lJMvtv/MncTocpQ
 HgIQwR2oaV39sGAUtufN+/gqBBEl557PPecnbGPlQ6YUixAblJQ5hkGcGmIiLPzxqe+DH8S+Y7I
 mbB3VE7TtxdCxzutmyfCjerzOfWI5f/ktdqZaj7KI
X-Gm-Gg: ATEYQzxMGh7awbL7Mrtks795ewwkfGTDhuy21RU4QX9iuQUeOQGhpV4k5PiWkQia+po
 xvCeVg5h6/aD09SJMN1UptDoPtjV2Cm9Q7LYvB+ygzHw3BARmYuMe5JQ5Fby2v1mKw7N3k1ESPO
 9OONlzQ/u7e4qN0IrC3WTdV5J4vZtCQD2xn8acQZ6VlH6BnmdPbTyg5tJmbRf1+17lCL+L2MvRI
 lYrPBUeGIjFObePVnm52SccJ8zyb4UCcqBcfpA/pvoVIktwSsCiLoOUuXObHkaY9gYfHBVKdPrj
 bt5/Sqweg65I5VVZ
X-Received: by 2002:a17:907:9407:b0:b90:b959:4c72 with SMTP id
 a640c23a62f3a-b9c65596656mr20707866b.6.1775158883969; Thu, 02 Apr 2026
 12:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260327081858.311591-1-christian.poetzsch@kernkonzept.com>
In-Reply-To: <20260327081858.311591-1-christian.poetzsch@kernkonzept.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Apr 2026 13:41:11 -0600
X-Gm-Features: AQROBzD46vIt7_ylRxBV2-KDiTKZteUOWR5RARBIhqrxD4NUgn0MXD913rpB-K0
Message-ID: <CAFLszTjKtFM6RXE_ZoEFbpW1ZGPtLCcqzJeceaLGPYoTfGA9vQ@mail.gmail.com>
Subject: Re: [PATCH] virtio: add support for SIZE_MAX & SEG_MAX features
To: christian.poetzsch@kernkonzept.com
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Adam Lackorzynski <adam@l4re.org>
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

Hi Christian,

On 2026-03-27T08:18:58, Christian P=C3=B6tzsch
<christian.poetzsch@kernkonzept.com> wrote:
> virtio: add support for SIZE_MAX & SEG_MAX features
> virtio: add support for SIZE_MAX & SEG_MAX features
>
> Some virtio implementations may forward the virtio requests directly to
> the underlying hw. The hw may have some restrictions in how many and how
> big the requests can be. Therefore, the corresponding virtio device will
> announce this limitations with the SIZE_MAX & SEG_MAX feature.
>
> Add support for those features. Split an io request into multiple virtio
> requests if more than seg_max segments would be used. Also split a
> single buffer request into multiple segments if the buffer is bigger
> then size_max.
>
> Signed-off-by: Christian P=C3=B6tzsch <christian.poetzsch@kernkonzept.com=
>
> Signed-off-by: Adam Lackorzynski <adam@l4re.org>

> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> @@ -119,7 +145,38 @@ static ulong virtio_blk_do_req(...)
> +err_free:
> +     for (i =3D 0; i < seg_cnt + 2; ++i)
> +             free(sgs[i]);
> +     free(sgs);
> +
> +     return status =3D=3D VIRTIO_BLK_S_OK ? blkcnt : -EIO;

The err_free label is reached from both the success path (fall-through
after virtqueue_get_buf()) and error paths (goto from malloc()
failure, virtqueue_add() failure, or unknown type). On error paths,
status is uninitialised, so the final check has undefined behaviour.
Please can you separate the success path from the error cleanup, e.g.
with an explicit return before the err_free label.

> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> @@ -145,38 +145,38 @@ static ulong virtio_blk_do_req(...)
> +     while (i < blkcnt) {
> +             u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * priv->seg_=
max);
> +
> +             ret =3D virtio_blk_do_single_req(dev, sector + i, blk_per_s=
g,
> +                                            buffer + i * 512, type);
> +             if (!ret)
> +                     return ret;

The error check is inverted. virtio_blk_do_single_req() returns blkcnt
(positive) on success and -EIO on failure, so if (!ret) only triggers
when ret is zero. I suspect you want if (ret < 0) here.

BTW please add a function comment for virtio_blk_do_single_req() so
all this is clearer.

> diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> @@ -67,50 +74,69 @@ static void virtio_blk_init_data_sg(...)
> +     // The virtio device may have constrains on the maximum segment siz=
e.

U-Boot follows the Linux kernel coding style which prefers /* */
comments over //. Please can you convert these.

Regards,
Simon
