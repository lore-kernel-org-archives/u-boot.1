Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A64F8D761
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 17:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89CA841F2;
	Thu, 16 Apr 2026 19:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lXsXsGij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7CB98420C; Thu, 16 Apr 2026 19:37:10 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E30083EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 19:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-670ab084a39so10550006a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:37:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776361028; cv=none;
 d=google.com; s=arc-20240605;
 b=ATFf0JH9PZyaPvhwBKvLAOBbvv4a4DukXBMZYnveQOAY0/dWdzT20JV1iR/HftHpul
 gNqM1ql8BMOXGdzZsWDDeW0oqlrE32ayJnnJZ49N1zvu+95gY/0n2Yn5HTFDYqGf2a5c
 TBKbL7PFjIds+Lspo2opa+hp50qYSRyJz46vrjgQ/S5Q4LqHtJUZBdjWoGRnnGCyFE1v
 tO2YwybdYqUZjWDuL10c9jt9x8aD8hMTZD3EtYk4d1uyM5d4kBfXgb2qXzQuviTTfbli
 pbdbGAOHxr/SMJH99cu5YS3bhQDiLce7PTx9EZCoUzobHKpiMgdMmTVEH0OudIVh4mJD
 rlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZEZF71XitWO9RtWc6mkvmN3wgEInR9MyO8ANsgNvCUI=;
 fh=hkkPB+DKhD/mA73SUgQq3n4CINq/b3TsBZ/Yn0wAVUQ=;
 b=aQg83QYrPeaqtggmjdHEtDcMh42TViAgIvBRWNHADp4JoYc0N/R+gBPlbqrME3mhqC
 uCq1iz4PfWhJnKdVbn/30YqmJeMbATFC3YsiVlbpQyeNLWM/XkdHgFBo6AyuviXZYK+o
 t26f9Bn+VwxukEsNoPiRUxOh6hG8pBFNq3705jALeaKNnGB6qbvqB3Mr3pilSsQFKV7A
 aJsvBVxEatX+BHtk9SPzBHV/2H8B5T08xSL9C9smrKA856KV48Rka9RqSICM14cS7WNe
 qpSUlgWzoVVnyisZJOz0gXEYcxLytTSU2GkuShfj9XCRDSDnMeOhOlldHYtyUkBxKKRr
 rIFA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776361028; x=1776965828; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEZF71XitWO9RtWc6mkvmN3wgEInR9MyO8ANsgNvCUI=;
 b=lXsXsGijnXxqlIeebn5i0rvTwyYWHYuJTrbtmfy6JE8R5L1j+4JoLi4V+Pa3rv6MrM
 hBDLH57nkoL5A/J6sGcqC7O8Wyganu1BvY5Q2IJ1FEsmGtNTT4glq4b6BO0hFCsRt+Z0
 TxPd/4SPoICr/1CqoEQU7fojOwx69c7mvkW8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776361028; x=1776965828;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZEZF71XitWO9RtWc6mkvmN3wgEInR9MyO8ANsgNvCUI=;
 b=c0nPeWr/nZeTxkM5GWfXhyk4Z7QvN6Yo8cJi0Mxjbw/5OCHIBeARNIFHqG/r1e3aM7
 GKJ/IcPAHp3+abSJW55KZRRU9pPWazntR3lcE10XfQevKhVJyztFvmS+iqGmtUwh6rI1
 GeSJvytmmXBw1mjMLuOMUCu8zFXYEVIaOVG7O7l2xmZu/fA/LchQq/zcuIRKVmxhhlpf
 LH/HOvKZ5L+HCSfj7KyS20RDKAnpiwKtLEQQJm3GvSIIeK992dbrB7cIaNRzu9ArfEWC
 QTJnd7AEzARpjpqIGRDY4+xwoH5fRSW/JOBJY37ZV19krxVd50tau9ns715d8UBVGZWI
 Tlzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N0ULiX60Jh51Ofx/lIyhuvIHWI7LaZKpbe6jjpmKJf8YCV3zFv21NEsooqhI7yDXoM32sR3w=@lists.denx.de
X-Gm-Message-State: AOJu0YweCIQkIhuV3Be3ux6urkXHhmR05S96hei3cIf5WdJgtpQf95qS
 8q8zn1UrS2ZPCNKR/aHpZ3jjXPoJnDFjb9oFLMEngspUinoMDIjNbCiwRUrnRj7fsflsGDDjQ5+
 2FJtGKqiBRaEqMKdAM2S58biEisRDojwpScVDVdNY
X-Gm-Gg: AeBDietbqFtJVNMRIy8Km9NfAL68+CnZ8xVd71zKb32PaABXZPT/O6yzJTpudQzv2xB
 dVcAhNYVifVaOzQHJgi/MpVmWtLEhpQsV5mBfbAzm6aiErIPD89oGQAHeQXf7K3KrL8v4+uHXv+
 W/YJEaQs+7NSXHeg53ajsfKqFV9ZWTVBYu+2qxhyn0gbPBe/jbQWHjjuqp+z+4ns6IibYv6K3zK
 CK0uvrdLZ0M6y6aRTdrJCi7tBl5Xtx+1bzLWwhTqaSjHqXmm1vbZuoTgMYBA8/Mh6eFjTB+dc8S
 WfwgM5WJjE/xmxUjdhEy
X-Received: by 2002:a17:907:d113:b0:ba2:7377:6a33 with SMTP id
 a640c23a62f3a-ba3daaa26a8mr23038266b.16.1776361027821; Thu, 16 Apr 2026
 10:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260408150201.217942-3-paul.henrys_ext@softathome.com>
 <20260414131558.538656-1-yan.wang@softathome.com>
 <20260414131558.538656-3-yan.wang@softathome.com>
In-Reply-To: <20260414131558.538656-3-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 05:36:54 +1200
X-Gm-Features: AQROBzD3793tjd5Ox1UjoqQqu7HFsx45yL5nBb7a8Yui9jtzkqayFKGWu0CQCKw
Message-ID: <CAFLszThfGF7X1GQ_O5Qg5TUxKqbQReLiNDoWdi3W2AbHud0mRQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] binman: collection: Set build_done on referenced
 entries
To: yan.wang@softathome.com
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com, 
 paul.henrys_ext@softathome.com, u-boot@lists.denx.de
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

Hi Yan,

On 2026-04-14T13:15:55, Yan WANG <yan.wang@softathome.com> wrote:
> binman: collection: Set build_done on referenced entries
>
> The collection etype uses phandles in the 'content' property to
> reference other entries. Mark each referenced entry with build_done
> to avoid rebuilding the same entry data multiple times.
>
> This is important for cases where rebuilding may change the data
> content, e.g. due to timestamps or random IVs in encryption.
>
> Refactor GetContentsByPhandle() to return both the entry object and
> its data.
>
> Signed-off-by: yan wang <yan.wang@softathome.com>
>
> tools/binman/etype/collection.py | 9 +++++++--
>  tools/binman/etype/section.py    | 5 +++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

> diff --git a/tools/binman/etype/collection.py b/tools/binman/etype/collection.py
> @@ -45,12 +45,17 @@ class Entry_collection(Entry):
> +            # Mark referenced entries as build_done to avoid rebuilding
> +            if required:
> +                entry.build_done = True

I believe this should use mark_build_done() instead, as it recursively
marks child entries in sections.

Regards,
Simon
