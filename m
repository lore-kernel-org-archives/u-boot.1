Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDFFE776CB
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 23:11:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 861D086D80;
	Tue,  3 Oct 2023 01:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="eC523/g9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA37A8710A; Tue,  3 Oct 2023 01:11:01 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8369986C59
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 01:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so45992666b.1
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696288259; x=1696893059; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r+YINemaxbK2N3IGh727w+/MwEk7qS2elYlOKIcBRMY=;
 b=eC523/g9AwrAOXkwMfWCK8rXYgXm27JCobQeVwb7KOWfb9LVajh3GYC/egdx849E/G
 uWrLdsQEvCcojXzFcguCjPi/OWovOSwQTsSLbfXly/xfm8F/Q9Ym3PxEXhX2VcySaut2
 lM19qJVm5XRtvBTqJ7/Al3X2t+Pyhq1NewQG7VvQfRVwqF4y4ybvZoOiwFb6Of8+YqDq
 SG8mEJOIvk0QpFFk1lL4LsMqMkWvEs33AeZaMmrn+Dk8diySxEkahoPHAhzRsNuBfObL
 mw0t/8cU5OtWNMO3bIVpbROYFzKYfqWFpAAc6ZGXKo84eafGKNegWolWOT4I4u8HljET
 sCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696288259; x=1696893059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r+YINemaxbK2N3IGh727w+/MwEk7qS2elYlOKIcBRMY=;
 b=mbmNKpZB57xFBnAZSydICgReyfP3Vdkfy5JSY5D3zN3loP3fHnZRejqoMjpujspvOW
 7jHyuJCXMB+kMvUQN3nJDRgga9oFy7uAsvxVc5FZauwuQRZ8ro98SDFAKQb+Bo1UkQJm
 mGpGssVgp6PeFqPafQh76sUsmzEvPatin+iILGEjL67mGr9AwOf2o32CvLsJyinxG5Bc
 p0Xz0Sh9Ywb/62lDJCP8ILUA4WJhwzOq0ojpx4NJ4wM5lZyD+T2JQc7NA5+nyj2bgVrB
 XmPes2+eHCSshkH7cKP5NRIucdiOCw+FRZ4o/FvY/tbXG7apJ5da+03o7kpIdS/PhNlq
 AAZA==
X-Gm-Message-State: AOJu0YwaKNrSaeQQRghhbD7X76/I7ozdlB3RWW/Wn2GQvCyYJGtoaDDU
 ki2NdY88E8TzLRXkQi1IGdO1sR6QseZ4zht1gVUrk45kDdSyBW8ZDkQ=
X-Google-Smtp-Source: AGHT+IGLJJf+uwLvR4nD/RskKJzzhSutEkGvVnKSZ2dK8WpU77+MfoQ3Tr1uvOyCHIxZG6QemEf1nhWuqcVnUu6Fy2I=
X-Received: by 2002:a17:906:19:b0:9a3:c4f4:12de with SMTP id
 25-20020a170906001900b009a3c4f412demr11868502eja.37.1696288258860; Mon, 02
 Oct 2023 16:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231002222725.25125-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 2 Oct 2023 17:10:40 -0600
Message-ID: <CAPnjgZ1KNf_ZmbVGAo1J=GfzPE78Hh=nfxvh9DMn=qYoXqt-aA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] input: avoid NULL dereference
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Mon, 2 Oct 2023 at 16:27, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Before using the result of env_get("stdin") we must check if it is NULL.
>
> Avoid #if. This resolves the -Wunused-but-set-variable issue and we don't
> need a dummy assignment in the else branch. Anyway this warning is
> disabled in the Makefile.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         Avoid #if.
> ---
>  drivers/input/input.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
