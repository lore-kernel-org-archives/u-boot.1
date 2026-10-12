Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B74CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADC5B6069D;
	Mon, 12 Oct 2026 14:10:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JLUFN-Ir_Dut; Mon, 12 Oct 2026 14:10:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE3D16066D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814249;
	b=hCjkWlBdfBYUOso5iK6Loq6CR0dKoVw0AOBX4UxtmdFQPu5vSINt53WImXlJAZtTocg4
	 FRd/b/VFGFUm1RNv1TNVNUH2NZiBT1aigtEsHhTtGWxVOdVcwhcBoDswPgtD7F6AQJ0dE
	 ak6j+oec++69JKqwQFRhP+dy0DnlFsRX40FrqiCMvuL3L1ftAge0HEl6MRPFE7gYTT9T8
	 LzI8yZt3cZpT2CRBdW5Td3cI355UReOfxGb4fjHJvVVOguETFVx+mEt//USn5KwU2yEkM
	 O6p1l/PssuXiG4SNH36ov8gQy21OccU8EyxkyAW0tISpVni1hNFZWeqEM0QQ1ZB9m0w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791814249;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=P73HgBGYO3jDHjDiodMCCIwhCJZlLQ98/+myjGhZRpk=;
	b=bi+Jf0J5y8rYccUMkGwgqLLAvB8xR0aX1WW7kmvUd9b6K02Eqy/6ZjhNKkUrX6ds6Xlt
	 sA0/YgkQihJDgEj71oW23hJWDlauZdaXgQoTodXJS4zuUkuQl8m/fcld4MZd9eGk4oDpi
	 7UA4TBjQZrCN0UkwPVk/lVl7vGyb63ANL6Lh8mGdX9R3P5qSC4sAO+cZC7LT8DV84gnaz
	 ejNc/bO7A7+YYARD/Hi/yCwzKBA70v/Xf5AGbleFuVX4Jav444PFVScCQA1r2zhNtAryN
	 /DCmjfgOMMG86u3wtNssJ6uY62VwnxFvDpVHxhJKrL4W5/XGUL94VZtFdl+MQpwAeSw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791814249;
	bh=P73HgBGYO3jDHjDiodMCCIwhCJZlLQ98/+myjGhZRpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y1EyfPopqBkm7DsWNtQF92a4FAYvVppPqfX4ofvpliHGQt4xoPSoSnzqoI91tAsRQ
	 J89qcN68aZpykYsoaFSbnrZXKooEwgB8aXNizWdw7igaDCQDs0Um9NOfQpQWlIudPv
	 nbSc/B6FboGr/jjGLbXBzva2kixsK1MtQK3rpYr6WcILrJDX3bK9rfL5s5JsL9/ak1
	 KMSymVjmAqqsjjnnFVhGkvz/7Lh8YuYcgAFT1rMMmidXNJgT+qsypiyKNvOIGuaPPL
	 bjLOIGIycuibt3y7ekglYx4VOmYS6Fz9osHAVqLaaXzbWKR1lqFJObwNc7Zqd6oC6p
	 Ikdah3xnv5BDA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE3D16066D;
	Mon, 12 Oct 2026 14:10:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6BF2C156
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:10:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5DBE440057
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:10:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PpxDEyb2YCc2 for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:10:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 49D124004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791814245;
 b=D1F8IATQOzYc37ypVf0nMTas7YEI0ETyc/NbOQgGmyG4qao8xDYFN8ZopdSVRqUaZHGg
 B9aJFlL/uzhxemZFpYv5xQBestDRje4OFSVsr7GrKw7VAlNwyULpmDRN2AH6xyjvfCnHz
 lnvTW8QHKBUhiUu6VFb8X4Nd/xoyD24T9zz7ZB7AG14SpYg1LXDlBzQlnLJsmMlrkkVBI
 +ECrLGYdBw0uvywA+Lz/E9jPOYbN+WNcE/Ju6Ewke+6E3B+ztSm+xVcvHob+8jjNlt9Zc
 H+FNIqH/1ol7yvJ8SWQ4OZc8NNSLKAefotNCdltnGEeaB5BynOpiKZnOebv+zGRcMmw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791814245;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=P73HgBGYO3jDHjDiodMCCIwhCJZlLQ98/+myjGhZRpk=;
 b=VlpTsz4ANZEJYCUbSJX38DMZkG5L+DKc8s7+2XsWpUOkJpkKOvQVsroVVHl727/N92mP
 W7dA+shVEYSYNAJYfQE6AzUwoGC4zVPuX79iuhp0xXVLkTAP+ECLzhh08jF70VNKILAYb
 gmB3LGo6GkQwMMSw22t4Ej1BwcGUeys5b5o98roXtvLvRyAMQQjGAgVF2/ZDTC+MTXb97
 wHMOW96U+cKoY06bnEbs1/pM1ThwHTWx2s74gbu6jNwSPEY9grZQjQqD7eTmxn475ubOi
 wXzlhZS4sjvOQ494vXNB6U6J1TsZlVE87tpKjXq88bCcklEdY9EekK9un0UKT5DdDXg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PnBHAM3t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PnBHAM3t
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 49D124004D
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:10:44 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so2540967a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:10:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814243; cv=none;
 d=google.com; s=arc-20260327;
 b=K7MaQnvU/Bxa1Vf9GzjnQ17wbLzdRdGxTt9wZmJJA2C4onloVe7RUuv3X7h2bxi45Y
 uvEOAe4Ubjdu+6JvfGMBbRtI3q3jK49d/i+rxV4092Y6QnwEIgIeL8HzSbSCCiScj0Dr
 zernNUrhz4InyNSwIhhe8jMKDqTl72TQTNKukyx3fWR13LUIs6nmfA2y5knwqoATTEBG
 8/WYncebwOzsgprAESgN8PeJohwsub9TZu8DI1UqIiRzwQwDsDWOmzRFGHjmAaPMwYbP
 YNKijcD2b4HFDJ2+mhiN2CyvKtVGNhzkAf3UC6DDCbo4fue0HFMX8uHcodp/ChGTojBx
 itlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P73HgBGYO3jDHjDiodMCCIwhCJZlLQ98/+myjGhZRpk=;
 fh=+mRVRj12DiVDeDzC3sPS1BqRrKpBYKxXemRHUSoUlLQ=;
 b=tDNQ4jpqDLJ3GmIoRwsG99F4vQGKt3YMlf7jogwCqZkh1BWrhinr1D9e/juchXeadV
 +n5H23zh1ozWtALsp7WfNiOUjy1spMklaLOXhBEAeFZ0Gzny3DvwzRam/kAU7BAhN0Sq
 nXmcMsSruSJsoGjOjxutM1fWxeMvfAmuGXN8NtXysOiwg0BtW82v6IrMmzc5mEdkGibv
 QvMdurHKjSHiJyzp31xaaZr6pj1Y2EF+HcmEKu/IhxcnGzwuq9Im3jP8XQHMbu8gvsuv
 pEXTHGFioNgiJyVUsAvWv1L8FGdABjNIlbKVmCHemAz4mFec8pPWP+dC3wLSwHwny+VO
 EnKA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791814243; x=1792419043;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P73HgBGYO3jDHjDiodMCCIwhCJZlLQ98/+myjGhZRpk=;
 b=PnBHAM3taDX1qYzgNbNlttPK3f4Jw9FHDVWFtLc/0jlsuNRwZhqefFDWqgbb+oVc7T
 DgLU2WH3JtZFIdnkk/xngeIzeT1GSysFMo3WydqtkJ7dQWyXZrWFMBe5F7SXcr0W1hKq
 PfHwU0GMO/DaP86nNu9cMtl5MAi/MkMmTodAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791814243; x=1792419043;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P73HgBGYO3jDHjDiodMCCIwhCJZlLQ98/+myjGhZRpk=;
 b=W4F0+l90u/tlJid6XhKOk6H9NoSbKuf3ibfCbcUKrLMTpPcoznHG+6pEF+VGY0w/jC
 mns7fEguvEmBf4AeWFRIvxDPdMVg3zso0XMjaNc5qNyEm78KluPKTjQNY4RvPCnq/mwG
 7+Szd2q40fmWIXsWmdTiFeCMPtkMvEKh3kR+aXVGRH0aP3u8H/Fx88LuP/fZFqvshU+k
 tFwJGtt8zRLCyHDqU/27hDcYTvxvG9txkRiCGz0af3evP8XcHshkrH0D8U/bBfQmddNg
 vq1mViJdzmzo51Dpg8rVSBcWX9OnwQh88KYR5ezpgk+v60MdLBvQeR5wqO8a6cU5KTCd
 N+YQ==
X-Gm-Message-State: AFq9FYIAAIyK+CgHA6SzvoeUrA8Ct5oAgVrwgZl3lc9p35OAgeab3SPx
 kjz8sonPexWLDiAmcgstI6LkPvYl3EPSxalBL0L5Ck/adxT1WNnqNEAG3n4KZqRsmhgusbslpUJ
 py4BBtbOH0Cgb+qGfZaotCrNqB8+VqiW/FzbL1Sz4
X-Gm-Gg: AYBFou2U7aYApbfB++l//ap2HHRXCQKS2RH0WgQObvSCi9nJnMS7cFen3PJapP7fl/1
 7wh9echEeD8DezZEwf/Gv/T2wHLNKrOeyxFSt+jsZ+5EHOgVsSe4FJfbL6vC5uGbj7BkqhMa9kQ
 ZRaRpg12FcYhDVKyT5nc662hK4mWlJUxFzRRfyFA7fiMBkRxbYRK3nnSUVWC8QuHyw1s3JQnz5+
 AMUwNSVh7AZBHdEpNqINnSzauHYg5PYpAHynObKnjAdCiuoSqXMcPCYfZCccHKFoDlfUOg1eQu7
 lnHBqeAQileVkHfOVGI/EZCfJTjVb8NOz1pz5dHZskvCBj3O880uPEq8W33UPeFh7g==
X-Received: by 2002:a05:6402:2498:b0:6ab:1e8:8b7e with SMTP id
 4fb4d7f45d1cf-6b17c27bf79mr8607921a12.32.1791814242636; Mon, 12 Oct 2026
 07:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20261011152235.8842-1-aristo.chen@canonical.com>
 <20261011152235.8842-3-aristo.chen@canonical.com>
In-Reply-To: <20261011152235.8842-3-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:10:27 +0100
X-Gm-Features: AclHuK-7lCOA-jnBaeTIKPAHWlUJzEEvf6iOEHIrDS3epLE9o_zVw58AHcbzFaY
Message-ID: <CAFLszTipcALnr0MWK94fYhHZAxr-Dha=J0MeK_OxyKoRBVuPsQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] image-fit: check the length of the external data
 properties
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 anton@binarly.io, pranavkasthuri@gmail.com, 
 Daniel Golle <daniel@makrotopia.org>, Igor Grinberg <grinberg@compulab.co.il>, 
 "tomas.melin@vaisala.com" <tomas.melin@vaisala.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

Hi Aristo,

On 2026-10-11T15:21:13, Aristo Chen <aristo.chen@canonical.com> wrote:
> image-fit: check the length of the external data properties
>
> fit_image_get_data_offset(), fit_image_get_data_position() and
> fit_image_get_data_size() pass NULL as fdt_getprop()'s length argument,
> so they accept a property of any size and then dereference the first
> four bytes of it. A property shorter than that is read past its end, and
> the bytes that follow it in the FIT are returned to the caller. An empty
> data-size, for example, is read as the structure tag that follows it, a
> small number such as 2 or 3, and selects a few bytes of the external
> data instead of failing.
>
> Ask for the length and require it to be exactly one fdt32_t, as
> commit c2b8eefd4e10 ("image-fit: check the length of the
> data-size-unciphered property") does for data-size-unciphered. Every
> caller already checks the return value and handles a failure like a
> missing property.
>
> Fixes: db1b79b886f0 ("splash: add support for loading splash from a FIT image")
> Fixes: a1be94b65410 ("SPL: Add FIT data-position property support")
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> boot/image-fit.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1012,15 +1022,20 @@ int fit_image_get_data_position(const void *fit, int noffset,
>  int fit_image_get_data_size(const void *fit, int noffset, u32 *data_size)
>  {
>       const fdt32_t *val;
> +     int len;
>
> -     val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, NULL);
> +     val = fdt_getprop(fit, noffset, FIT_DATA_SIZE_PROP, &len);
>       if (!val)
>               return -ENOENT;
>
> +     if (len != sizeof(*val))
> +             return -EINVAL;
> +

Counting fit_image_get_data_size_unciphered(), this leaves four copies
of the same body. Please can you add a small static helper, e.g.
fit_get_u32_prop(fit, noffset, name, &val), and call it from each
accessor? That would also win back some of the 60 bytes this adds to
SPL. A follow-up patch is fine if you prefer to keep this one focused
on the fix.

I checked the callers in image-fit.c, spl_fit.c, splash_source.c,
socfpga_arria10.c and (after patch 4) fit_image.c. All of them treat a
non-zero return as 'not present' or bail out, so -EINVAL is safe.
There is one change in behaviour: if data-offset is also present, a
malformed data-position now falls through to it rather than winning.
That seems fine, since having both is already invalid.

Reviewed-by: Simon Glass <sjg@chromium.org>
