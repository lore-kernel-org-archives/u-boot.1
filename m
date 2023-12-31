Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0187C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 31 Dec 2023 12:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45D37877F4;
	Sun, 31 Dec 2023 13:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B1uRV19w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F988783B; Sun, 31 Dec 2023 13:49:01 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94B20875FC
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 13:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-427e9ba503fso26258901cf.0
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 04:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704026938; x=1704631738; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbgS2KXUPYxuJcO71mq39sPUrYKre6NLfYKNSIa0geU=;
 b=B1uRV19wRmj56XgQ3pKCR31Px+bmVEyWta0W1p3NnBvvboZi/IDsO/xV6QQTC9Qvzj
 1u69fWe5XAHln/eKSY316e+ck1QDhpiVsLd8N6Z8xQb4a7vjQP0PAP3IOYa/hbk+6O2C
 n+n8NYvuLgRckM0h98QCNc0miJUZhurS4Z/vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704026938; x=1704631738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbgS2KXUPYxuJcO71mq39sPUrYKre6NLfYKNSIa0geU=;
 b=p+wg1Gp7NFFE4t9+e960WCcGkwOUEUg0Qp9EyJmZGWK/JnR40Cgdr1CNT123iprH0e
 XH7kmGf1u+eO3VJC3pIIskVgfL+skYwk46yMUETqYoxEK5NsMxGeghuwkEK/q82sFBbR
 N3wKHOTqsyyiqhYKXyIJmpnnC9QKTNSqiAsduUchaYdQ2lzkHgMn3H7sQhZTWLmta4CI
 Gj7NR2dvYYAlKwzyftzc4R5peFUZWp7cm+9sHhY8uAW86zrLxYjLB1hiX5YxTKXJVnG7
 F11lHcBdAl8Uat3KP/4zAfJQK/ehQPUn3W2lo0Bi+w6Wd8VFUrUQ055Tjv6fP2O6NtE6
 QRHQ==
X-Gm-Message-State: AOJu0YzldZzSgrIAwmCqhDINMSP0XqwZXWq4sGbIH+vJ9KI+6R4M1vHl
 EfH4S+lLAHvmSBPpKv4Hhh0uvP1MbeGNvgF8YwelyOgwcbjz
X-Google-Smtp-Source: AGHT+IF4WbdDy86LxOigRJuoqXsWgryOccoXprjaZ3G1dY704g+X+QzVwkkcGSzfVbHSIQBcX8obZDhIb/jp0/EKo0o=
X-Received: by 2002:a05:6214:1941:b0:67a:9562:4732 with SMTP id
 q1-20020a056214194100b0067a95624732mr29214201qvk.35.1704026938426; Sun, 31
 Dec 2023 04:48:58 -0800 (PST)
MIME-Version: 1.0
References: <20231229210738.82387-1-hugo.cornelis@essensium.com>
 <20231229210738.82387-2-hugo.cornelis@essensium.com>
In-Reply-To: <20231229210738.82387-2-hugo.cornelis@essensium.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 31 Dec 2023 05:48:47 -0700
Message-ID: <CAFLszTjT_Wue_yctsvekLXbPfBR0MofvMhF1Mxsh6xvN5Nd6dw@mail.gmail.com>
Subject: Re: [PATCH 2/2] image-host: increase path length when setting up the
 cipher.
To: Hugo Cornelis <hugo.cornelis@essensium.com>
Cc: u-boot@lists.denx.de, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Fri, Dec 29, 2023 at 2:07=E2=80=AFPM Hugo Cornelis
<hugo.cornelis@essensium.com> wrote:
>
> This patch increases the maximum path length of the filename
> containing the cipher key for the kernel from 128 to 256 characters.
>
> Signed-off-by: Hugo Cornelis <hugo.cornelis@essensium.com>
> ---
>
>  tools/image-host.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

This is fine, but do you not want to use PATH_MAX ? We should not need
to worry about stack space on the host.

>
> diff --git a/tools/image-host.c b/tools/image-host.c
> index 3719f36117..b0012a714d 100644
> --- a/tools/image-host.c
> +++ b/tools/image-host.c
> @@ -376,7 +376,7 @@ static int fit_image_setup_cipher(struct image_cipher=
_info *info,
>                                   int noffset)
>  {
>         char *algo_name;
> -       char filename[128];
> +       char filename[256];
>         int ret =3D -1;
>         int snprintf_return;
>
> --
> 2.34.1
>

Regards,
Simon
