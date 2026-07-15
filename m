Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63DAC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 403B884CEA;
	Wed, 15 Jul 2026 20:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gz5rdHao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5902D84CEB; Wed, 15 Jul 2026 20:42:14 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48DB584CC7
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so10369041a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140932; cv=none;
 d=google.com; s=arc-20260327;
 b=OEjDbOmtC3+z9vnvI6oKz3kQVbZQQEJt2f76OTPiPEHDYdHoDtXSnDUzxEJkoJ958F
 p0xf9YE8EAVItnhIIF4K/Apbi1skegYgdcm9dysKZoYqgSFya3WwG/nBbe1YoMIxXTT7
 1nwpL+DjU6aMCNrMHuxU4/lXbZpExY67gjaMZ67JhBMcWg5h3XQHHR0OQZo89gTALU02
 HYa0+b0WfRRkPSI7CuC7v4PIqL+pT/mI1PN6hE0VwymuzEpD5qLsmPyhkq4ajU/asWk2
 nAttYTm1POsW+IvYHO7jlD8PrNe/BBRYNnWIQ07oo5MDRqAmw9nd0T9KJU4FYlgXr5SD
 5RPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4lkiXGDSFPyTcgpfB8Kh+sbJ6JLu/tFGhVdTx7fwaqU=;
 fh=fB+XalEKEO7IV8va+4XmCALJx4H2t6IFTDb4IreKq+I=;
 b=S/gFKzliVa2XU337cyDUZuJ5vQynBBRI9ktGg5HyD0pGyMXap3Ih1V4Ce++Stl2R5b
 LVoYGcWx73Zg702F+89cEf0ECh1YbRi04/Sz2EFp5W/9pvSP2px/pjffISasWbIhM2es
 gKAnzciZsHkCocNc2wRwY7zQd+GSNaqXgiBTdtZefo1uS/OzFRIaz82obU5cGUNX8680
 mb2Q/xxwgjTgQNb7f251T6QGJwjKy0vIYAcyEUQzvAC6yoLpAJ4nVUxxGy0kYadXQE8c
 yu3R5/MOeajlagZPmlVXs0gKo+XzratSK8K7pNQq4JCt3EWvzT2qx9WYC+fSCxiLgIsU
 caWg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140932; x=1784745732; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4lkiXGDSFPyTcgpfB8Kh+sbJ6JLu/tFGhVdTx7fwaqU=;
 b=gz5rdHaoDfNBvvr0Qv5FA9jYwOiMKNtd3SYwHkieB4tODmNTcC+QNsMOaIyaqqjtgr
 whqfAIKqofLaKh2ie5e/7n+HrIcmhoEM8Tf9Ro8x2CVdoEmzkyi7OH/TXBGyEkbTAJgU
 DSvioMVvo692fty5KSke+JyBUItWRbASTD9M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140932; x=1784745732;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4lkiXGDSFPyTcgpfB8Kh+sbJ6JLu/tFGhVdTx7fwaqU=;
 b=AAn+OG9D5rgdTQnGGD6GIWjNtHVm9johxJjqu4Zc5m6j6ljnfCm4pkOKhZ7axny0T4
 gLI2R/tcmF7DOvu+2PuzEpKh+gw9gjrQhe/fxalivHlIlyfqvA7i093IEWGG2eh3/0TX
 BV1TRu77Gql3YT3SrHDsi9j2t9ni+rZXYyV0dBjELlbNi5Si8EwyHuDazOIy1/RJJmQ9
 vybBgDvDNG/fZDFILy6iYNNQ+fqi0qPNXlpCpY5MTeDkexh6Kheys0bVLefdPxzJI60f
 GZ0CgL1XK/oIA4gXOpIR2OTW9lE08CXOQJp8IttstMZKwhlsQhp506ViOoZ0D82jq3IQ
 IWUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2te/Id4cFE5ZZFXQhxsa7LZBe2ZfVXrdC2GI2ldz8wg+UDDJ9eQLppKkkJKshxlrLqv8GOoM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb7o9XB2obQB5ysC475dx+CmyrQTJZ65oo8KlyXNuePmPYaW/R
 vbG9EobbK8+N5Sa9UTosGJOJbGiIhXiKy1DcsJzdToWRUxEe1iS6FVA4Suzq603pu2yJQJVgoYX
 O+8ETrFhYlV0LJmRow1Q72W//0iUnWlVFo3AII4r7
X-Gm-Gg: AfdE7cnlSY9XFWDSmXuj+FsvLtGfTQnHoqUHGKgOQxZpBOMnK3np9qFNgY+2j4VOV+t
 J+NeR7BCMTYwvO9Rbs8V6AU9vjrxAeO74yEqzcvX/LdHXS7HKotokFZUMN9yff844NUyEHJAu3m
 T+T2wIXyisyIm2xGO0jvYLnPTXhdAkmqwUKFlfROlSq0uagBUHWHDpFsidd5JCHeNUlM+vw2N6S
 NK0Iced6kw/gvDHl2m5Fx79K/zurw4mYZL474k8gxLbCYIYF12NzhxjgsY4XcCTv9NlRvw=
X-Received: by 2002:a05:6402:c46:b0:698:3b7c:7e41 with SMTP id
 4fb4d7f45d1cf-69cd6dcd540mr4704111a12.33.1784140931679; Wed, 15 Jul 2026
 11:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260706215446.4068820-1-visitorckw@gmail.com>
 <20260706215446.4068820-2-visitorckw@gmail.com>
In-Reply-To: <20260706215446.4068820-2-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:42:00 -0600
X-Gm-Features: AUfX_mzKKN_2P0vn2Ye_XCR0p6j-U3HVGai53Sya1snKrgo_4fU-4PPDUXszBhU
Message-ID: <CAFLszTg9ZK7LceDF8XjD3964sbJFcDyEunEfQf9=Evvkbtx2mg@mail.gmail.com>
Subject: Re: [PATCH 1/4] net: 9p: Add 9P2000 protocol support
To: visitorckw@gmail.com
Cc: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On 2026-07-06T21:54:42, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> net: 9p: Add 9P2000 protocol support
>
> Introduce the core 9P network protocol client implementation.
>
> 9P is a network filesystem protocol originally developed for the
> Plan 9 operating system. Add the baseline 9P2000.L protocol handling,
> including message serialization, client registration, and basic
> transport operations.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> include/9p.h    |  82 +++++++++++++++++
>  net/9p/Kconfig  |   5 ++
>  net/9p/Makefile |   5 ++
>  net/9p/client.c | 272 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/Kconfig     |   2 +
>  net/Makefile    |   1 +
>  6 files changed, 367 insertions(+)

> net: 9p: Add 9P2000 protocol support

The subject says 9P2000 but the client only negotiates and implements
9P2000.L, which is a different dialect. Please can you say 9P2000.L
consistently throughout the series?

> diff --git a/include/9p.h b/include/9p.h
> @@ -0,0 +1,82 @@
> +struct p9_client {
> +     const struct p9_trans_ops *ops;
> +     void *priv;
> +     u8 *tx;
> +     u8 *rx;
> +     u32 next_fid;
> +};

Please can you add comments to the structs and exported functions in
this header, in the normal U-Boot style (see include/fs.h)? Each
function should document its parameters and return value, and each
struct member should have a comment.

> diff --git a/include/9p.h b/include/9p.h
> @@ -0,0 +1,82 @@
> +struct blk_desc;
> +struct disk_partition;
> +
> +int p9_fs_probe(struct blk_desc *fs_dev_desc, struct disk_partition *fs_partition);

These p9_fs_*() functions are only implemented in fs/9p in the next
patch, so please move the declarations there, so each patch is
self-contained.

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +#include <9p.h>
> +#include <config.h>
> +#include <log.h>

Please define LOG_CATEGORY at the top of the file (LOGC_NET seems
right) so the log calls can be filtered. The <config.h> include is
not needed, since the build system includes it automatically.

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +     if (rx_hdr->id == P9_RLERROR) {
> +             ecode = get_unaligned_le32(c->rx + 7);
> +             log_err("9P Error: %s failed (ecode=%u)\n", step, ecode);
> +             return -EIO;

In 9P2000.L the Rlerror ecode is a Linux errno value, so please return
-ecode here rather than -EIO, so callers can distinguish ENOENT from
real I/O errors (as fs/9p does in the next patch). Also please use
sizeof(struct p9_header) instead of the magic 7

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +     if (!c->tx)
> +             c->tx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);
> +     if (!c->rx)
> +             c->rx = memalign(ARCH_DMA_MINALIGN, P9_MSIZE);

These 64KB allocations can fail on boards with a small malloc() pool,
so please check for NULL and return -ENOMEM

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +     if (c->ops->request(c, c->tx, hdr->size, c->rx, P9_MSIZE) < 0)
> +             return -EIO;
> +
> +     return p9_check_error(c, P9_RVERSION, 'Tversion');

The Rversion reply carries the server's negotiated msize and version
string, but both are ignored here. A server may reply with a smaller
msize than requested, in which case the P9_MSIZE - 24 reads in
p9_client_read() can exceed what it accepts, or with the version
string 'unknown' if it does not support 9P2000.L. Please parse the
reply, store the negotiated msize in struct p9_client for the read
paths to use, and fail if the version string does not match.

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +     char path_buf[128];
> +     char *wnames[16];

strlcpy() silently truncates paths longer than 127 characters, so the
walk would quietly go to the wrong file. Please check its return value
against sizeof(path_buf) and return -ENAMETOOLONG on truncation.

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +     return p9_check_error(c, P9_RWALK, 'Twalk');

Not quite complete: per the 9P spec, only a failure on the first path
element produces Rlerror. If a later element fails, the server returns
Rwalk with nwqid < nwname and new_fid is not created, yet this returns
0. Please check that nwqid equals nwname and return -ENOENT otherwise,
so callers such as p9_fs_exists() get the right answer.

> diff --git a/net/9p/client.c b/net/9p/client.c
> @@ -0,0 +1,272 @@
> +     if (p9_check_error(c, P9_RREAD, 'Tread') == 0) {
> +             ptr = c->rx + sizeof(*hdr);
> +             *actread = get_unaligned_le32(ptr);
> +             ptr += 4;
> +             memcpy(buf, ptr, *actread);

The count returned by the server is trusted here - a buggy or
malicious server could return a value larger than read_len (or the rx
buffer) and overflow the caller's buffer. Please check it against
read_len before the memcpy(). The same applies in p9_client_readdir()

Regards,
Simon
