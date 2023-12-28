Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7617FC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:40:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8104687A98;
	Thu, 28 Dec 2023 14:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OU3F8VGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0833C87A98; Thu, 28 Dec 2023 14:38:10 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896808774E
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5ce0efd60ddso958910a12.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703770685; x=1704375485; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCI+f6xNj+O17fScPhV7sGRO6OOjosDZcd7WNRvAIWM=;
 b=OU3F8VGChtUbN+0oSV5aPlyKFPAvt1UQtFSczcnwKuey4pKc6BUEpG1pKzv/mAwl8e
 x4vAHmw7U9LnftBNzkx6jdV+mAsbUuH1YJz5KXoMvunrkdlPYv3ld7U8ssM3ygfFMwjJ
 xFlozoJWYqshDLaBbbFkKr2aC+evC8UCjwtc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703770685; x=1704375485;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCI+f6xNj+O17fScPhV7sGRO6OOjosDZcd7WNRvAIWM=;
 b=Cp8BpxUS//TPrwBRvgOy6lrVr5NS18tufejHnfPoXTUdlzU7+NyIpWTHSRtIDqDiEh
 H/0eiBlXviAGUykZIH+8DUxgA1gVSuDezr6ftLfIL9mHpAdL4GbyaqW2DkYmCh6qKcPH
 c1aNzhg/L7mlWNmey+clta+s4TH+6WgcFMlKG9CW6HOVlvxn9bh1V+4QAo62+REFLOHy
 wybv+3+zbA04fDY62za3NAltbZWczqdnVFE8XwsOh/hmWZKtA271t52Nz3Ibv7D+o6Vy
 0vW9LEd6u2g6EoVWL4sWvBsxaBWyRFmC+vB2aYtv1UFEEvNPD5hrthV5ybPmv9P6MWmb
 LFXg==
X-Gm-Message-State: AOJu0YzpFnLBbjCBBQwQDHz4fLRTDtfD8OVuzHCMwhZnI8Mx9TvxLL6o
 8M+Sku3Zdauas1zL+qK5QDnok5NS/3oPWu/vg/QIT7jR+pm/vBGG556bZC0=
X-Google-Smtp-Source: AGHT+IEycbkSEkZx2ktXyiezpUwZNd5db6ta4TPpI8D/8KOudykk8kaId9E0F/Gm9ZdfIDDLiyPSUXg1iYeVQoRS14k=
X-Received: by 2002:a05:6a20:3c8e:b0:196:6096:6a27 with SMTP id
 b14-20020a056a203c8e00b0019660966a27mr313473pzj.81.1703770684730; Thu, 28 Dec
 2023 05:38:04 -0800 (PST)
MIME-Version: 1.0
References: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
 <20231228073024.6508-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231228073024.6508-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 13:37:13 +0000
Message-ID: <CAFLszTikYxynGe3o3Sg2qTUgy-oXot=9BJ9F8vxCYF3-puDC4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] smbios: enable setting processor family > 0xff
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, Dec 28, 2023 at 7:30=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Many value of processor type exceed 0xff and have to be stored as u16
> value. In the type 4 table set processor_family =3D 0xfe signaling that
> field processor_family2 is used and write the actual value into the
> processor_family2 field.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/smbios.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/lib/smbios.c b/lib/smbios.c
> index 45480b01af..550b2471f9 100644
> --- a/lib/smbios.c
> +++ b/lib/smbios.c
> @@ -467,7 +467,8 @@ static void smbios_write_type4_dm(struct smbios_type4=
 *t,
>         }
>  #endif
>
> -       t->processor_family =3D processor_family;
> +       t->processor_family =3D 0xfe;
> +       t->processor_family2 =3D processor_family;

Why not use 'family' if it fits?

>         t->processor_manufacturer =3D smbios_add_prop(ctx, NULL, vendor);
>         t->processor_version =3D smbios_add_prop(ctx, NULL, name);
>  }
> @@ -489,7 +490,6 @@ static int smbios_write_type4(ulong *current, int han=
dle,
>         t->l1_cache_handle =3D 0xffff;
>         t->l2_cache_handle =3D 0xffff;
>         t->l3_cache_handle =3D 0xffff;
> -       t->processor_family2 =3D t->processor_family;
>
>         len =3D t->length + smbios_string_table_len(ctx);
>         *current +=3D len;
> --
> 2.43.0
>

Regards,
Simon
