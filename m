Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4824CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 238D0847C5;
	Fri, 15 May 2026 20:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbTCXTi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3037D847E8; Fri, 15 May 2026 20:21:59 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405DE846E6
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67bc8609a9bso339932a12.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778869317; cv=none;
 d=google.com; s=arc-20240605;
 b=fa2bXrJF5QzHGEngUXjhKbloGK3Nb1dFZrCQe5/5gwVQyHcySwUwtESrgik5jEa230
 IINjV+1eukUJVlIYQoHy1jk1YBFaaGPKXUCUOfYAz+XoDsJqBcP43O4jftadd60U1Yw3
 DICh1j4VPVxZArOx9pST+LCHMuRn8g5Ll6s3yq0nTikyvAQ1pHMJYKM8UO5cD5OP9p7i
 v62f9Z9Cw1Q/c16idK1w2OcKKKRXhUtlITDgTxDgF82tEvpI+TAwn49gXwG/zhCql30v
 TfJX+TuBS1yTgHPZ5FTmyRICvxS7c2alRawvaM40+/xoqRUWSJuF0hHcXJwZvmxrsZAV
 7d7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gNT6X+gI/EKDg5+Mqhq2Xlg5hPFiZ/IJ1wqNYwBONUg=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=LnYxzUyErfYZOR16qdG3BIGLBN61jWngYx8iqvahphE57jxm9XXg/of0BehQfhEZ7F
 CZkooxZAd1QV5QHcd9hWsuM4I9QMWDGvilKme0wX53ov19R1d33i1keltGiMP0/em3Jq
 VrKCAurRnTk9+TwCJZqkQtzSzcRnWKeLFt9CKmiVNlpjmpan9rK5qMGFHk9VTXIP70iv
 8MZoQswrySgdnYQ8KFSvCslYKIjRGUEve2sspr7St+zZ8CvrJO9aZzustuL8QphXbfhW
 0FmJ19fuJT2MihSA34eg5AhM9JsQNy368I4LAZEpYhFwCYr+iGfi5dAij8K1r4fydNcx
 z4VQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778869317; x=1779474117; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gNT6X+gI/EKDg5+Mqhq2Xlg5hPFiZ/IJ1wqNYwBONUg=;
 b=UbTCXTi14Wl+Yw3oxAsGHc2BLzjL9bzM5cVLngNR3Rgq8egLXZjgxp8Hr5ArdO1AEl
 c/ULyPRBlTzwRqnHrAYmH2ouUisBlLIIuRdu2kZ6Q7LYFQHPqa8klkAutv4ugnwqAS2x
 3mDre3tqNqfCYELqiUOlyWZ/W/Vd+U0gWajtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869317; x=1779474117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gNT6X+gI/EKDg5+Mqhq2Xlg5hPFiZ/IJ1wqNYwBONUg=;
 b=bqhHKs+HxobhQ5XwfuooOiZvkRVadilaTMrCwQRPYW08Oeqy9EY+HASK1CqiUnpzY7
 Y5zzSOeM0Xe5NMczOPI8xPv7072PAjeloXRbsXrNf8J2yyf/BlrzmP67cAUEZAyKRelg
 OMQ4iS+XFAzMrE0BH4y3IWjHsSjRIzLRoYj8q3tmcYQMfDgfV1T76/BTfGmEwtmdWdHE
 EyDtZvOBmYSaqMBemiduRwbcjhEIqAdMHQLX4wI22NAmGWFfMQ2w9Sa1tRiEmY/QK3PJ
 ZuMYPhW4ezRBCtU74Ek9Nxgo7WSdXzUF3Sjp7iQfQhSomi9f3Bi2LOuOGS/nZEs7kDwK
 vrGg==
X-Gm-Message-State: AOJu0YwESvVgUpsgtT4MS+Lq2aKscipTn83ltYA+VRn8aEeFC9NBxEaD
 a1mtLtpSxjESXGDIlEdmlKAY7mvQ15+flBm7rA99XrZgHtoOZeTjflqmfgzAYMIOn+R1X7+kgba
 fTlJbExkjszUD3EDgAUab5kSP+DbpZBvJGAK7fG+p
X-Gm-Gg: Acq92OEaDhtGmL3kBKhwjeipiPz5uLgv/U8VnkUl9isHuV5bnri3oZT4KaqmVR5mMsC
 bNAUCBds3V3g0lCedK9qyR4WO46NCdEi2PB13Hdpv2+BuatQ2xjK9dnUAdRaIoSYItkqlDlBhxT
 FVn+6vPtJnwINmCKkGEdeh7h8l/s/dhzZhKDIdeE/UR7eP0Cd/TEFZsnTkQmfLRoXqYQYpcTRgF
 Jadc/CP5hCkMCk6/OC7yBsAIC9/ZR332usZQU2U6cNH5NwkQwPW+K5kDJTkvTpRn5BzwCn/PpZ/
 dwOYIjEw7QaMqyIh
X-Received: by 2002:a17:907:c8c7:b0:bac:3bb7:268b with SMTP id
 a640c23a62f3a-bd517aa8873mr309791866b.38.1778869316680; Fri, 15 May 2026
 11:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-6-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-6-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:21:43 -0600
X-Gm-Features: AVHnY4KcmjUvqxNu4BkZAE4Y27mfvzRIXOXcCppj1_RAEoOw_ZldK4Yo4Y_eehs
Message-ID: <CAFLszTiDTOutq7w6UDwwYNd+hBTQUMRx3uAUK9SLoWh2POU6-w@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] charset: mark u16_strsize() as __efi_runtime
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> charset: mark u16_strsize() as __efi_runtime
>
> Mark u16_strsize() as __efi_runtime so it can be called from the EFI
> runtime variable paths added for FF-A/MM communication after
> ExitBootServices().
>
> Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
>
> lib/charset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
