Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFC4C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F85240676;
	Fri, 11 Sep 2026 11:45:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ja9uc1YZPJWa; Fri, 11 Sep 2026 11:45:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CC06A406EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127104;
	b=Wu4K7xKTS8s0v1567t4QYj36slJwyYKXGcL/cDGPVj6fEt3y7OGQXznKHVOf+GQ9Ty74
	 Qk1x5bHetNy+FrCgCu54DexJNytMKfDeUgC/okSh1dkM0Uk0zkSjM/dYxtSV1QDUddrK9
	 Tv1vZAoIcKE1tS0VSSrsq3SjNNtLIdR6oYwxDYLjyxVIt+2Ywg93BGslXk5eaG/tVOD8I
	 gvcEj45F8wocqMFjG0lCKi8mlF3xYzohpk7A4uWQAsdCk/OjqRoGbeTl5aYp1qDlYSfTT
	 Vti9jQ8+Ti3seZZExXjahqov9TJLC5utoLv0ALu852BLuD/OuhXdsbthl2I/k437xCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789127104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=//Rm8kpu0qoA5ne/Bcs4YVV9k57bnQ+kztvBoqWZ5VQ=;
	b=Z3UlWOV8Xk6n10XgvEORDsCOvA7qu7CT48XYDlD6vXpUXGDsTgM8D9Ht/u9Rg+YHH52R
	 nRCP2+Y+CoEY2UN3emR2HiXwZVZeIBK02wLd1CPDX/dtxsniCdB0YdWoRkTjK05jzQ9jZ
	 PrFaKfV/+IxAqQfp4LqFOW5FJ/A5Pw9DLLY9WVhPwWktQz4bporpVYKarapxEKcNkM0p+
	 I9amJmwVfN2iAw88mAoIAoicZACCD/x/8wQOxmSuL2/LL9uAesvgDiRsyu2V97A9q8cGG
	 qe/ar1la57I95daFPCSR46f6SnFwr7UuiIWfdZSEYsHlpBuMvmJqpVJNWW8tM4bOejA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="PF1w/6LJ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789127103;
	bh=//Rm8kpu0qoA5ne/Bcs4YVV9k57bnQ+kztvBoqWZ5VQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dyntIuAgjO5eQGBrNRQZ16vi62ehklf1heqLjsw67H+rBJKvzFBWMZA9gsYVYlhFV
	 uwXTSvp81TPIcWyDTtu/TvvSNsi8BDcJzSVTpybcJejrmpK1PLG5MVVEdCXU6+iSxo
	 9cQEcNlb1dFwBg+K4F6WzywiCz01Qui0BSmuNaCspTflg/RJL3TQlCiuzp3pRaE2ZM
	 DXvWe2KIezELr266EIUcFPkmcStpjX9KHtlqp1IatnkFbHcRbdVbpfLvhgsaTTSg38
	 P7i2Dk0AXS4Q6oBhQsyjEoDcRneNkPNB6q+2UtIpOTqjNTeYZHwbXOk0G0RQI7yQ7U
	 7EJjywjnRa7kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC06A406EB;
	Fri, 11 Sep 2026 11:45:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36B8D2E3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1C5C540343
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-ixjku183Eh for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:45:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 04ECE4032E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127101;
 b=soUtX7HmBVZqOvFNETTqT+ZgXtZd0+8JOSiAkGZrdWeoTYaQfNZKZYYDnG4B1u6KkVTX
 L/Xaay7JLKS1fFzgo8RMmnfX7VWjpo1rfC+qOiIivqiDmhYQmDFEzu7tcKkHARKJKwhN7
 nASZVpyHjKKheJOuq4cOTSnatqE0YmpX6Jj0t3Ma2w3aupRjsDBSTP/B6Fyp6ZcH5y6fo
 xVcq8YyqPOqFdAktYeLx4D7C9FobPUdfJY+p3fuonsW0i1MbKVkNGH7sz3w8ngETu4pBw
 RBlJK2IyvrvITxTNLkY/b8IUdCyN/qogfJhAzZDwd2ZCmLIKQqPuEDfNx4S+D3wYr9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789127101;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=//Rm8kpu0qoA5ne/Bcs4YVV9k57bnQ+kztvBoqWZ5VQ=;
 b=dxQtE7B3euGGjOThibfRmhKJ6+hfLsEQvPM5lXdIB2aj/q09SmvMq2/AlnDd4ey4T4uI
 R7oju2rBmpYh/mKESN+6U/ynzOJhC52fiO8BEK+GtygEmvzscHD8TfW0gYUcVAtatJY/W
 +f2OnwtAvcNVUwS07oTrPjxRNdZWqCpoSbLk9JebZdPEgg965fQAZWZsq5budk+d+zxTD
 7sJXMYjpCr0U7946QVVDflX7GFjAyqlpYzW2k6HcqJpJCR7A5XT3/uzuBMUuhpmdCsdr4
 p84XAU6EtRB/50MxuY/SIsWBM42nES6mOPI4BjxCCC2ekfheeaAz9FBVNtaZ/LOUO8g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="PF1w/6LJ"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PF1w/6LJ
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04ECE4032E
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:44:59 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae52so1407759a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127098; cv=none;
 d=google.com; s=arc-20260327;
 b=mHT/il93zGJsKt6zOLQhdKCoKfUH5anrLdhhpMeBx2XEAOLGMlnxrJcPYuCNe0tyZx
 AQwNOeVPozouOCgC8LXDPiVDoT0myiLeCLSxMae/ACeHKIhmNYse+wP0nJ/N3bJyHtsN
 Jw585zNr3lo9UpkXBCop3XSnfMl9WOuGfCjrMZBnLORPxpsG58JlEiUlydmEBcEmtlEK
 mTvB/WG5wCSwDiFH904nzBrzi824SZSLPGephmpgElA+TH8pIybl2o4B5XdIcGLGP/Pb
 onC5lK6RZokQ8/KppOaPOjGPgAiYyp7BvLHyQHz1Bj7AyreYk4ql6nkQE3F3MGsxpt5Y
 JVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=//Rm8kpu0qoA5ne/Bcs4YVV9k57bnQ+kztvBoqWZ5VQ=;
 fh=fNKbeQz3bnuSKk2qT4C1sjgPFrSX+rBHqdIVnvMQf/A=;
 b=apo0pSEjPNvZcYxckZ/Gy0lAYvzVkd4S9Db/IYuNztLLnSgx6ksHny3qs3QBIhA4hE
 ETCC8wvDmVUAcrV1c+pqHKCsGQdLSON1E2kMoHls7Y3aan542TxUyqB0DfrGYWlKaNvO
 mAZ3E6lEZwP37YTSSSOvi5xW890m9xU3ZmRHswbkwYD9Yyqz3wFFfbgfDXAZ7No+j/fX
 /BjLfTUpLstutAD8nr7VRrSbif+m7Y2NEKo2t3WyXKKpd7P3hsCEeJHcLYnjsm1rI0Nw
 Us2bBQz8AIlHTq+IrNPJ7e1Hfgg053E0oi3L8TGeTryL1T4LkA7Ncfvlcjdb/dMzNIAE
 1maA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789127098; x=1789731898;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=//Rm8kpu0qoA5ne/Bcs4YVV9k57bnQ+kztvBoqWZ5VQ=;
 b=PF1w/6LJF4zIqZ7P1JXFy+gyOWSrfqtU9MJd4TNa4r7xOYViVdEyjnuOJJHJYFQaJV
 tc5RFyWMF+7YfQAzwyrfBsgBI/Pobx4r6sL4+DsbypBD3aFwW7KIum+g+FNuStGLKN5f
 DwButWvsAufeqTZza3TCmaPkyXaKoxb0gZkMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127098; x=1789731898;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=//Rm8kpu0qoA5ne/Bcs4YVV9k57bnQ+kztvBoqWZ5VQ=;
 b=auyGkKGm+VyF6quFBou0fn3+nFe0DjiowUjAbVhke699cK3PO2ficzB2O9YTHkBydd
 5quD5HvFIYjD+/R5MZCGJ0veqYYHie/bipA5V7S/x08ROv6yZxSWPRhQXcIlsTL3239T
 1s8pNvEEWCSNLHgybZxgvl60YJL0QVaSakuZGqSjiCtdi3qniiSqW2b1shnxrXSQH69o
 NblB4aHbnhCwWgPfL2LR0idElwsl+To2hlGl8OaOtpWXFgaN/YKR7BMzXqtSUdwWOV2W
 vs47EqffecMTx+HJ3A18HHMPXx7uLQIYrAJqNp7rGxx6KVEu/T/u6a876gFQ7Gc8qq3/
 aqFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzMUzBrYdBJrhJl6fm3SaoRErsAVh0CyceulqWRtnj8ZpaNB4+Xe6vEQbCS6hnj2M+asTlMKoM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mAgMiVaySSb2946arSfnKoIgbWeSSJDikSrFcoRZkIka4dhbLQ
 CiktmSqWGGPacLnghBujtBxKzfQfrG/ZMsBCY4KCb7TH09E5ZSGLxZ7DMOTg/W2t6JPqpFALD3U
 HjX8BzYoILEboR9QdPb8b6a1gBkfAFt+fFoZ5Yo8w
X-Gm-Gg: AYBFou2wzuxhKOPH7O/aeC615kIbw7dYigT65bxZgj24GLmPVrheQ1s37X1ykkdrA3J
 zvksxIA9+o05lq+T65w8nne0NgKr6zegnaHAvvWFnogMTj/GMvyX0+Hr3usT4mS3PoTVcqeaIl7
 ZdLbeBWZVZX2wC5ah6HhMTbriYwVtNL0UvV/sI7IndcdeAoIpoQxsvEvV3AWbeqSEoCU7REVnoI
 CB9uBqCi3dlU4UhVrfWcotTnAjAY58xyHzn8DLSKGzU2Acs8qtYU0Fqy5SqMhKk7i3YK9DHe7JB
 et7+QWu/p0gW2fcSI/i/e5eUfFfVAVi32H0GNYvLH5/tNlzLkTD+5iw=
X-Received: by 2002:a05:6402:5112:b0:6a5:f912:b09c with SMTP id
 4fb4d7f45d1cf-6a9b561afbdmr3128603a12.4.1789127097814; Fri, 11 Sep 2026
 04:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-4-visitorckw@gmail.com>
In-Reply-To: <20260829192119.2658328-4-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:43:39 -0600
X-Gm-Features: AcwNN1XuA0pEB2PfUhwItft-YwREj-cttoyLdeKhcXPw0NkACEK4QLy8v-pJyb0
Message-ID: <CAFLszTh6STRL=4sE1eYAuTKQEymKK1xXmJwxA0u7p1BPGU9pmg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] virtio: 9p: Add 9P transport driver
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Kuan-Wei,

On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> virtio: 9p: Add 9P transport driver
>
> Add virtio transport driver for the 9P filesystem.
>
> This driver binds to the virtio-9p device exposed by the hypervisor and
> registers as a DM UCLASS_9P device. It implements the transmit and
> receive routines.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> drivers/virtio/Kconfig         |   7 +++
>  drivers/virtio/Makefile        |   1 +
>  drivers/virtio/virtio-uclass.c |   1 +
>  drivers/virtio/virtio_9p.c     | 119 +++++++++++++++++++++++++++++++++++++++++
>  include/virtio.h               |  12 ++++-
>  5 files changed, 139 insertions(+), 1 deletion(-)

> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> @@ -0,0 +1,119 @@
> +static int virtio_9p_remove(struct udevice *dev)
> +{
> +     return virtio_reset(dev);
> +}
> +
> +U_BOOT_DRIVER(virtio_9p) = {
> +     .name       = VIRTIO_9P_DRV_NAME,
> +     .id         = UCLASS_9P,
> +     .ops        = &virtio_9p_ops,
> +     .bind       = virtio_9p_bind,
> +     .probe      = virtio_9p_probe,
> +     .remove     = virtio_9p_remove,

Sorry, I gave you the wrong function name last time. Other virtio
drivers set .remove = virtio_remove, which calls virtio_del_vqs()
before virtio_reset(). Going straight to virtio_reset() here leaks the
vq allocated in probe(). Please drop the wrapper and use virtio_remove
directly.

> diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
> @@ -0,0 +1,119 @@
> +     start = get_timer(0);
> +     while (!virtqueue_get_buf(priv->vq, &len)) {
> +             if (get_timer(start) > VIRTIO_9P_TIMEOUT_MS)
> +                     return -ETIMEDOUT;
> +     }
> +
> +     if (len < (int)sizeof(struct p9_header))
> +             return -EIO;
> +
> +     return 0;
> +}

Looks good, It might be worth returning len to the caller so the
client can cross-check it against the size field in the reply header,
but up to you.

Regards,
Simon
