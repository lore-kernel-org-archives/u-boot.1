Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883B310FCAD2
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 20:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E89C383CE3;
	Wed,  1 Apr 2026 22:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="o5SfXE1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF5583D8A; Wed,  1 Apr 2026 22:57:38 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A16E780517
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 22:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6501cbb52e5so223168d50.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 13:57:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775077054; cv=none;
 d=google.com; s=arc-20240605;
 b=hdIxy98h65VP9zbYQqYyueN+nvBldBgNiHFm/2DEVV6C6xYS4pn1ZTKGwps6o7Nvwt
 Oi3o0eohmuf+I9B2wW8JY9alE1Q5Kh0xt8IZYLEJF9XkeJK4Iv+DirRQyZC1ZQ9JRFJZ
 aC3qvs1sjZpqeUqB6DIXPLhGHAyqSAfdGeVPoVv2JeT+u6tLoGQtacxaGmKB0OSqHVaZ
 UNz8+rnemIPC4oecYXV3hLJlXOI9vdj/m9Zy7BtD7e8gJhmBrmnNpWpn6c8/faECtwzC
 96x5yGCHtmWwMoqm+Ita5EDCptbQr3ZNjnkGY931N3fvlhZ1KTjIjtI8BMnVDbg0jVCj
 ExaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XUYJKeNP6s2bDgwM6/g5Tmq/B2GD1fl+NpRMbRu05d8=;
 fh=oQlnA0dehNeFfzzpluIn/4G8xuCtRFC5E/ixe8uXaBs=;
 b=Ape5TtSH8qANpGZW+LFm+CbY9MDFN47+d2lbyosOAM1/PidMSKicxmr+Y6A+zGhUqB
 Jk8I10dlMO+oOmYEgSrnI0NZTnfTRrg+N4L1CV2obYGykg7KMkm6+kbEHLw0nbsFgJDF
 Fcf8DvphSjGXwsD5xlLnb11LnmvpEMNgTwNAl+829j3q1fKbFrRNyb6sSFzOmQUvMKum
 1fqx+g2Cnc2XlEYOeYyfztaABf0S62t5Hn+urMqsWckiwKuUimIkQgVw6TF77EH3GIMl
 2NGESuVV1Bp0zGrg2uNmixbU5y1kPAut6dVUgvtrX3c6TJJRCnLiTAlGK+sV1qKnZafK
 l8hw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775077054; x=1775681854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XUYJKeNP6s2bDgwM6/g5Tmq/B2GD1fl+NpRMbRu05d8=;
 b=o5SfXE1LfFrY304a21tNgIFfJntHOWUenp3IXliYiD9cmd/YbA0Hiyv1otwGypNj3/
 5jVIqpVsh46vh05hp11F00KlPfuB19TIPcqR8e2bnumPzgRIwc9MxnHE5ePgfuAtkpYR
 NqPWEQJkHt8vh+V94oQRqsO9G8dMfHekAEjLlmMaknnNF1/PUPMVFXGQo4fEKsC+thnw
 NmCEc+EqTABkXMyiUrBRefOfjIs/UFKN7II0DHkEOaZ8rhirBYAmxF400ivFeGRCLtdn
 2MOR9FtTesAVBlPBnk8c2m6VDYmTy8EskDoQ8r1CB7eYtURkWfp2Ipwzsmsz4KyTdlwt
 +5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775077054; x=1775681854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUYJKeNP6s2bDgwM6/g5Tmq/B2GD1fl+NpRMbRu05d8=;
 b=j71S5zfmLUbqZm2/MZ1RmDcWnxnkE2+YGfot7ou6Pmm58NQ5J/Y3Guz9RJfTMBmuZ3
 ps8aakD4KSouCP41ZCyrbKTx5Ki73q/OEbvwzImrcYF3Z2fnRjJZHvil8tyL7lGkPVe4
 nkaRp3sqQye+dXC/NPJ+o5PEeyz7pTNQStyP2MwCjCloXzFralfyg+oPIDJ81hHomjoA
 CCtHWe+hVt/WH8dutrXD+/dxMPPZ1ZJdrDIhh5dLp3tM6Q8AKhQ2WX/NLQQSbhTaM/9y
 yEkiuE6U5FbJuxJFtP8Q5hMLTKghlhfTPrPcokkzdrzkNPLhrJw9EJCjftS3bB94gDVL
 iaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfNY/RSa5GBfWNWoYWI16dAo6sUJZNWYRIBaVojdyh3AhskW4KtBG/bLY/UFpri3rEXdjSKME=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6KiK67kgxBUIg1F7CzH/rgeHzmqfkPQzFONUyI671dIzOZeEH
 fvwIFQmNumN4Ydp058UwmrYzlJdUfK2lCtmvb/ON6pNgMPVhCRZzFr8Yj3ncXGZPj3FT03t9i/h
 bmtbTndrt/KUsQEiwE86xs9dtkHQwA2m88o3q4Kkfra5jwMadkTfH
X-Gm-Gg: ATEYQzx2bk7w+FQWAC41qBVjlHzrFHrqUU4nZ2vlvq6uN/LGaZSeRSCca31sHZbApAs
 c9yS1KKzp88SODva7By8EjfMWqVZDVYEZh1MwA9rhv6gFkC2tep94dpLduArza5l28cJKZHYtVa
 v6BjQMz/WL0h6lxw5BPEBj/4fvugTbOmr7MRo86mgugbWY1uYnhVp5SUx/6PgQofwVhULgHtnAq
 CHrwOypoJ9JXN4yoVlAWz/Ljigi0tNVbBq7Clr3O++A5aIaW+DfyjrsNCq193DHMH1ZOMV5L8rV
 NW0q8ouKoJf1B+Ag1L9aVU9hlH3gXTQC2gxaTmEEwO9JKXmynZ5wlCwTp/sOg1YkaWKINIR7lnV
 RRa2VsMweYBJLGO1z8HPHfQ9luJG0BrJu1z4JJiK93fNAmURoZTeKHqpPs/8WMyQcF7txD1kS5Z
 NZ1XkVcAmagGKXSR1i6bzIRnxfLWmyH4QXUOYBymH0ON3+t/qq194FxPebJhGwfzLJmxRLTygot
 zFKJPf09SHJNyMpFOjfzAUeHNuj0d/M9CfE3XE4KUwOVzXoTH67h4ZsNCkll5x81b5h98cBvKcU
 SnPkOLhN2MtWWhnOyytHz1SQl+YtgLuHA7bvXU7exX8=
X-Received: by 2002:a05:690e:e83:b0:649:b535:46ab with SMTP id
 956f58d0204a3-6502fe52552mr5343263d50.49.1775077053695; Wed, 01 Apr 2026
 13:57:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <CAFLszTgW7DDPesNt1o9CMQW7WN7zN3BqenjDdwENQbQQc0j6KA@mail.gmail.com>
In-Reply-To: <CAFLszTgW7DDPesNt1o9CMQW7WN7zN3BqenjDdwENQbQQc0j6KA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 23:56:57 +0300
X-Gm-Features: AQROBzDULiBG7hl_uuNP777hjc_xTRd6lg45A3zmuG72mvzG4ZhpuV2qrobK-sM
Message-ID: <CAC_iWjLmb9+hJht9qhs6WqbbQdN4P-gFd73UPRjCuu+spex4TQ@mail.gmail.com>
Subject: Re: [v2,4/4] common: Allow relocations on the top of the last bank
To: Simon Glass <sjg@chromium.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

On Wed, 1 Apr 2026 at 22:59, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On 2026-03-31T08:01:10, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > diff --git a/common/board_f.c b/common/board_f.c
> > @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> > +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> > +             phys_addr_t old_top = gd->ram_top;
> > +
> > +             ret = fdtdec_setup_mem_ram_top();
> > +             if (ret)
> > +                     debug("failed to relocate to ram top");
> > +             ret = fdtdec_setup_ram_size();
>
> If fdtdec_setup_mem_ram_top() fails it will restore gd->ram_top to its
> original value and return an error, but then fdtdec_setup_ram_size()
> is still called. That will recalculate gd->ram_size even though the
> ram_top hasn't changed, which seems inconsistent. I think the two
> functions should both succeed or both fail.

yea that's a good point thanks.
/Ilias
>
> Regards,
> Simon
