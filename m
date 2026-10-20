Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D12606A31C
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MuIwU6Tv;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fR3+ULAm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0354C6084B;
	Tue, 20 Oct 2026 07:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oU2MHlXlpEL1; Tue, 20 Oct 2026 07:56:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C310607ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483015;
	b=RMMjNXHgEsC6ZXeyzq6mNDEBT7EMIiI5FmSZbMPZV3+TQ8lyB3y+4pnhegfPX4KcrALc
	 fgfME4d1XFhnSshaE6wTiQzhQ+Ij9eA86OsYoTtLeMcVgyfn4Ezhn6Lhpyi0Fouo99s/K
	 fzbhwAqYlEOrjlScPF7D9r0Pa67mdjDNYdSdOfaInsGZGv0MgT4XNcmu2mU5vRzX29wJi
	 R2TMBrC5K6IWEXaZVLBEU6al4MlUqUnHjw99WI64Yzm6XW1FqGlflVPbVRlur2xqgZK3N
	 pNto+m0bvPbdXFp00+QJRGf4iT/LeE+MPCJMmw7R8iWi45bug2Uuuo/bgf2Fo2wFjow==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483015;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WUL+C3gxnvBRcpQPQpihKD+aUp81VLNOMBmIZ6KaZ2s=;
	b=AQaja8FF491hUyo2VdYKSquBurk0ayyLEPclxAsuRd+uK+JePZ0KLa34YD50RGdOIhPh
	 Jl2pZZFpcc/DnK7O4cxFjctJ4TS6wmsmuPRhsOYt+SO8fF03TZQIuE08jPU48O5P9AnRd
	 oo/lVDGZhL1MITl7gZjG1t4h+cf9/K7Z/2R6Jnme3nfzTFMelsSQO3IJqV//gcMwi4adX
	 tx2PhPhb0Tp+qacCq/+09eA+FxKhew4PPnM4YOezsu5K8CJIlmdBfkN9HYXbPY0XPJHTn
	 V15fTQP59Yk1U5mAwLu0FjwdEzQjJ8m681DnlMNg1+rcu8MUSNH5FtjeVsdm1uqeVkw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483015;
	bh=WUL+C3gxnvBRcpQPQpihKD+aUp81VLNOMBmIZ6KaZ2s=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MuIwU6TvrjbNWYvti2UmWcHwl4sP0nhiQ35oHwAmp3FWWtmAgEsR8q6RbmX3nXigJ
	 P0Kyd8pAhiQcu3ggUuduF6CUWoHXwq8ZCYvy080XGNnvDpoynGjy4aWMMZNwbQmPG1
	 ZcgDMYKbsHIGyJRtc5+nz/f1NRhphUffqxd2Do3IyhDgmNo72fjZ2RtZam7s7jzliz
	 TkI1AQYdsFqeRvXvtiQwek4SvM03YNecpggD+jnG2jeNQCe9NCYsz0M5zhKUibxeYQ
	 XhiGg8ILXBa7t1Wr1psKwaeGSZCMJjRqD7vGz+StyMDcVuEgV8+/qxVEOCCgJe3B3e
	 BfxwcxI2ommFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C310607ED;
	Tue, 20 Oct 2026 07:56:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B4DC465
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6B0A581006
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hU1j88LVWwlQ for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BFC5180FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483012;
 b=rv1N/q+8RhfXAxGbyJqjcgSt9LU0d004qGPxpppHVF0hI92UQ3Fh8YT78E3iJrSpIoU2
 MyjZtrZSkz+Yy6qSkIzYhZJJnxkPWY3a63B56Ad6/1veljxWiUcoFMmPnqVXoPfzSMGIV
 b83N5ALehfmWtijtHE7VleXJVqGbWu+0HsBPd4FAEst/ny6FOSUQ5p1Q0gThO2E+/RdjJ
 XCJT7eIEamTUpV3B/aBd/WlTdR7P+D6boH+xbq9bWxCz1qO2/UQ4j9s0o8C9h8c3UTTqO
 Zz30iWgF4CNNlYnAl0PpeXWyNJGSz3tpmJDZefYn10CS1A2G0j5DIjyy2tvxjZGMCmg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483012;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=WUL+C3gxnvBRcpQPQpihKD+aUp81VLNOMBmIZ6KaZ2s=;
 b=G8M2ajAsdKQlUhb87lrz41o9I3O4nL9nHZ1kv7J1ZZHIURXnA7Pb22Czlkdga/FI5/DJ
 6WK2h15Fy77f69PKmFsKkQ2zod772XZ862C6nieaALbp7RaF1cOxLiHNKkVaIcJCSAO+n
 qgqzjOAG0icZVH5hJ52q4SXm0DE22fw2e+9Xa44nVImj1vbPMmnphxalawakF0xxF/Kxm
 BgwLfXjtcFn39xPGKSnZqjaUGjOWHhRWuc5rTsEGfLeoolZkjOm1u9XRNwThX8f2+0iQz
 vINw3o1OrNMwxKSLNflF/Alm4t1xXH4dIGzwHfMKXuoJKccrlAdD3qpFYOsDtn7QgTw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=fR3+ULAm; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1033"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=fR3+ULAm
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BFC5180FE8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:52 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3acc96a256dso1945763a91.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483012; cv=none;
 d=google.com; s=arc-20260327;
 b=s61QHydPsoKtH45n+jjy/lEkxdkZTT8/N+lThGS6JPIZ3VBtf8+4J2mTg4eyBGwi8/
 4Gv1MVXJNjkFNInsGTRof2y83IKvvMymXcrRhSGoEDMk0/YLLc+UuITa7mEoiz4B1RzS
 YNuevJlxjE/QYsUG9fikj50Ze58QT3krlElgRnjmqb+H0TAT3UBLfN/oHExLhZ7OPB8D
 HHCZe9QWUjWL0qoisHMq5+1kYoPCHkeYgJekEgJrDGS+xMjAhhs4k7XnU4kat5N6V6ij
 eVH30xKRXcxfupBvWm8fGflwFol3hdgHuWrvJFUwXDqLZYMRuPbSuIwZhi4rEc25fSfY
 QFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=WUL+C3gxnvBRcpQPQpihKD+aUp81VLNOMBmIZ6KaZ2s=;
 fh=25KyrAthXVEbf0vXmMneaDAO9+ArylJGPdsNmnsDYlI=;
 b=szU5h/RP+UzgWGL0uTDTw7p45Vk9y83AVrFlf5wlx2kSAl9RVmYKoXdu1BH0Semn/9
 uuROwR7XFvL2vbVhYyUxZgCM77w3MVl7GuMVuJ0t2Fms8l0WFdCEdiG9pthsE1B35CxO
 m9LSxRTtah4PuC9caZv3G9R+nFw23JWvsiSHTkSUoQptxxHdSqAmwm6A1dKCFIWhO4gr
 fK6zqWDiOgGSQ4U6c9BxnUqtvdghdbFwcURFETjEPxcXJt+LiNzgKmaK1jPXZJzfJH+W
 UGotEh8L/9VeA+QSV37vh07MqwDHD0rIRmMecPxBB5+PyBDpOKaWZjQwIHOt/NO2iBJU
 xDcQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792483012; x=1793087812;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WUL+C3gxnvBRcpQPQpihKD+aUp81VLNOMBmIZ6KaZ2s=;
 b=fR3+ULAmEwlK/q4Acx6yXM/VWEEkM/VmzOqLpQnKCMuEsm21nPF+1OTZ+DaO1LhD0Z
 T6+OGRc/8iPeo6ibVO/2fHe4Lu/qIjFPFVI1NwJnB0sgVuvD1IWfkMBfNK5Z463clrze
 qZa9KQhEXUVwIbp4eiM4mCpdvQBtNCvEHydK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483012; x=1793087812;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WUL+C3gxnvBRcpQPQpihKD+aUp81VLNOMBmIZ6KaZ2s=;
 b=STzfSY/2VKm8hw4kFRPkPrCmIOxiA32sMOIz9teWUaloRRnJxZDlR8nnV/8XkjH1no
 kQ7lqEtzkm7i4qVZdf6qUcOlPIv4xvRGsfDEYyaftkndi8/h5wiEvBmXQd3zo6/oNqXh
 Qo+6QOuMT44s8HPe0LH9GKCNPJJJJbw245L2wp4vaYP+BgjDy9m+xbE83WoJExEdYGDE
 zAoKrlt66RzFzad0x9sCwKVM4atws574q6ehjFodr/49TFqc/SEdzO6G3Iv77SrKVsYT
 QBeNq69zYbrmFqhXIv0QKDUYFS5bSDVgoJ2zumLGL0gsNycTIJorctDIMcmbkXKK1BLJ
 tSdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwY0If1NE/2ZzaWCH9ygpkCmDG6r9xjS+jkT/KjYyfIrauVGszppXEZeM3KEJtFrVB3zVzqMdY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIxSP9EDJ3sHOV2Cd7gm090eNqiONUqAd2usnDM3sLTSnvap2aZ
 1TvoPXxU1dEz/GfN3D1sJyvLwNEQe/PigNuFi7Ofji1uZ72T3KZqJrXYGq3imHhuM0WnHABUPCx
 pvEvhOpBmJw+tz4HwnLupe0wuVtUrggv1DwkANfl8
X-Gm-Gg: AYBFou2D/DlLB68Q21kd3kJJsrrzrGhNZvsBy76dHHOaooW07EhO+e0ISujAXB9Hipd
 lk43B9CVr6TGXVNZlW6d3EajnjZCx47VSBFV+6FPHZ65VhCnOu+VT8LUD//I2uZQHqDrAiEq3Tq
 ZZTer4jIJ8U29o3fXqj/nYTeeGtLn7VGXP5TeSV/b4ilrelzcIhsuTccCmc0OyoPwZoLgLw3tTh
 X97h7Gv4T0MbMIcFp2ufKhNhOUSeJX+LMUiqAzSW3KOhzTSsJUXlGS7XAmDT361lPPuwTMx84g1
 kIv6W9+qn0Nt/VsPtXoT8i0jnnGqO4KjB0U723Af8z6zlpy6YVOlAw==
X-Received: by 2002:a17:90a:d00b:b0:3ab:f38:2b41 with SMTP id
 98e67ed59e1d1-3acef29e6ccmr7581066a91.39.1792483011731; Tue, 20 Oct 2026
 00:56:51 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 02:56:48 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 19:32:00 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d72da3f8f4489f302298fbfcd795cdd452d96df1.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <d72da3f8f4489f302298fbfcd795cdd452d96df1.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 02:56:48 -0500
X-Gm-Features: AclHuK-KB2H7rH42-fG3ZhmwUuRODJJVYpgZhB2S9_QY3BywKLbROsMCfKFgW18
Message-ID: <CAFLszTiiH-dYTWYRW97sptYS3G59WAdPxAK8bmhdcnKA1VFcyQ@mail.gmail.com>
Subject: Re: [PATCH 09/11] boot: fit: share the external-data offset
 calculation
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: share the external-data offset calculation
>
> fit_image_load_storage() repeats the data-position / data-offset /
> totalsize-alignment sequence that fit_image_get_data() performs, and
> writes the result through an int pointer where the getters expect a u32.
> The copy also omits the range check on the sum, so an offset that the
> embedded path rejects is accepted here.
>
> Extract fit_image_ext_data_offset() and call it from both. The storage
> path gains the range check and both agree on one expression for the
> alignment.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/image-fit.c | 82 +++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 51 insertions(+), 31 deletions(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1056,6 +1056,47 @@ int fit_image_get_data_size_unciphered(const void *fit, int noffset,
> +static int fit_image_ext_data_offset(const void *fit, int noffset, u32 *offsetp)

The sibling getters are all fit_image_get_<thing>(), so
fit_image_get_ext_data_offset() would fit the pattern. What do you
think?

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1077,29 +1118,14 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
> +	ret = fit_image_ext_data_offset(fit, noffset, &offset);
> +	if (ret && ret != -ENOENT)
> +		return ret;
> +	external_data = !ret;

With the helper doing the work, 'external_data' only serves the
if/else below. Folding the embedded case into an early 'return
fit_image_get_emb_data(...)' on -ENOENT drops the local and leaves the
external path at the top level, which reads more clearly - up to you.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2207,19 +2233,13 @@ static int fit_image_load_storage(struct bootm_headers *images, const void *fit,
> -	if (data_off < 0 || data_sz < 0)
> -		return -EINVAL;
> -
>  	fit_image_get_comp(fit, noffset, &img_comp);

Worth a sentence in the commit message that the signed-value guard
goes away too - it is dead once data_off / data_sz become u32, and the
UINT32_MAX check in the helper now covers data_off. Otherwise the hunk
looks like an unrelated removal.

Regards,
Simon
