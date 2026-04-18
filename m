Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C9F99C6E
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 00:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD888425F;
	Sat, 18 Apr 2026 02:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iy2ttz/P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C432784246; Sat, 18 Apr 2026 02:47:40 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C42839D9
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 02:47:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso193811866b.3
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:47:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776473258; cv=none;
 d=google.com; s=arc-20240605;
 b=N9FfCXd92tIC2vbnlyuizT2bcJILALUE6ychiAVS4FPGqJVzv26wguRKYlPXzfd2Ty
 sxQwRiL1hrsRm0qOEWCNBX7tYy610Fk2L4V2CHGOYYzAtD/9JqwSqRwyfi8ne83ZDFp+
 ws9NeOrUquh7SKnZ6xZGlMb74gyeJcU8uRIFGxeaedahXTd3CIQ/+ifyZYGc5Topk7jH
 gYQn28PVyUNaCZSQqD9Xcq8B8/bs2gZtjZo5kYt23DVFL9P29i0fqy26ZSAo/bNBEapD
 BaG5a9+NhMuHF7CpLDoIedyR2hZkfV9KdO65i7q2Ow9TSAxpzXGycryQsoi3hVS7Tjzs
 YJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=F/R3jq7ipvNVR3A0Dr/AQ/sGYunVJnbkGbxyV4RwEjg=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=RDPztLUYDv4ns9LYAE6TvPrZl8mzgH/grhUCig+zlReUtc60kOa+rlHsdUyEYYJysF
 1E5nqiWGmXJuvXR3QGACXy6A3q0lW6QEcK1RUaFTXuIELbHjEdQ3ree5dkkx97XeU6MN
 /VGL2j4IuCEPCmBYXLnYyOe6i5l/4Zuq8q10bT3sVapZG8pxoH+az9nzSCS7SNGTCIJt
 qvR52fY3FId2k6sDZ9UhBVhUS4RNPqpD/QGiHgObieIIBd6k+P0tC7puRgHYUGDTDG30
 9i1cE+aKYm//StwAh0Q4NHmRROjDuknev1zdAJENjVCDE8FIMUrmL92PZhjyhi3u3+U7
 p0xQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776473258; x=1777078058; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F/R3jq7ipvNVR3A0Dr/AQ/sGYunVJnbkGbxyV4RwEjg=;
 b=iy2ttz/PlhqzFgB27xLjUo37016k4lLZDRKZL+rK+AsjfnTbKXj0RuUVnSNMMBNwsk
 yclBX0rdwIehJ595tD1ta2Vmwlz8RCqwqu/Ir4h4kfg9x4BIi143++6VpafIy8QC+NtW
 A2ziJMapyqbaUCYDDIWoLXQmJzeR+GbQW2Iaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776473258; x=1777078058;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/R3jq7ipvNVR3A0Dr/AQ/sGYunVJnbkGbxyV4RwEjg=;
 b=G0bOXz60PXSxdsLBs/CDg5WI6zP+c7WXB6Gy0gg0LLSkGn9RcGmxJUUX3j7OL4eh8e
 1yOIHpr3Y0N7oVuPp/fDexrVCvkgb2zaFtfxsPYDUaYNZuePjXLnPMWaxhNNN6e01xGO
 AA5fytPONtcSgxxpKn6I3kdoJ1P5M4BnIZ+eEIkmtaOwGD8iicEuuxn0bE/7j585XOsp
 wp0/1tRTRWXcxSBDkQIwdhnoW7zmh84sHGUk/qIKirIYfbBpctt0ctkV4w2ZmG6jf6tI
 Quximo6L3fZoZkXB4Ulpohm+yvnqV67oXjnkaxolCkmOWYZxkDL8SlRQyf3qhQXKc5Sm
 SiBg==
X-Gm-Message-State: AOJu0YwkXmPb96hOT8uzHWc5GzhSbyeCEJiJI2JMHfIOtnnzUOIQttN+
 uVCj5w9/FLPGIq7Tt1a6jQFQ5iWRQnnP+jwJ3UIZ0Pl4G7PSoMEmdlH25eeUlrgi6FVOftHFn9E
 IEC0V8z12AYiSjV6xqXuxO1g3OicOKbivalfDpMUh
X-Gm-Gg: AeBDievla+qQMymuyzUVVKPAAPqGQWDo347uKOQM7w+Jfp+3P/mxIZNrD9hA5E+j0bR
 UfysRLBT19jM9TDdqv0ksp5b403HTiUf8GBaFXXUDasrcxMUghejec09Kl2YH8JGxuqyQQy5yEa
 8pxImOANOJgIIzPaqCAlm8Q3/3WAK9zIE3jUEqbZKw7iW++sebIyfE839KnuA5A2IlgYBeWe8Ug
 /g8tye7ZYknofBSluOf8s3o1Kl70n7Nzx7ikyAsH0CIAGr/2enf7OEwEo4chnRW2r8ypndYgzyO
 MJnL3zjVcHsq50+70/uX
X-Received: by 2002:a17:906:59a8:b0:b9d:c34f:2a2b with SMTP id
 a640c23a62f3a-ba41b3dffb6mr195594066b.40.1776473257903; Fri, 17 Apr 2026
 17:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <17d1fc9a1ecdd0a5d54907b8816ef62793387a42.1776392312.git.weijie.gao@mediatek.com>
In-Reply-To: <17d1fc9a1ecdd0a5d54907b8816ef62793387a42.1776392312.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Apr 2026 12:47:23 +1200
X-Gm-Features: AQROBzCsCIhnOAcKcWDXyg9eHpfiPyzTuSj25HQWOiW_bEoSlSCyUpkAVDDlhXs
Message-ID: <CAFLszThHeX97x6Ebc_7TZiRs3ez2MC05Kf0ir+yo9=09NHThHg@mail.gmail.com>
Subject: Re: [PATCH 2/3] cmd: ubi: allow creating volume with all free spaces
 in ubi_create_vol
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

On 2026-04-17T02:35:14, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubi: allow creating volume with all free spaces in ubi_create_vol
>
> Although the ubi command itself supports creating volume with all
> free spaces, the api ubi_create_vol() does not.
>
> Since negative size in invalid, this patch replaces negative size

is invalid

> with all free space size in ubi_create_vol().
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubi.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

> diff --git a/cmd/ubi.c b/cmd/ubi.c
> @@ -226,7 +226,11 @@ int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
> +     if (size < 0)
> +             req.bytes = ubi->avail_pebs * ubi->leb_size;
> +     else
> +             req.bytes = size;

When size is negative, the printf() below still prints the original
negative size rather than the computed req.bytes

Regards,
Simon
