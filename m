Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5191C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 19:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615F08032B;
	Mon, 20 Jan 2025 20:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oVpb1bt5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05AAA806F8; Mon, 20 Jan 2025 20:20:42 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04D76800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 20:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab633d9582aso93978066b.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 11:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737400839; x=1738005639; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OkIISAHOr3DZvwJ0coxD4gf5mKOHzo2htoKxNgRDPs=;
 b=oVpb1bt5ZhrMMgXukLxEZvN5/9G1KljaMCzjwZIOgIQPCFqubC/520xflJi080Ia+q
 SvDAH89R5bF6OIWgPeFGJjv0tu93n02f8XyP04Z4rwygnDjxgWkVJaUq2H4QawNDGP5/
 yOpO5NeR6HXM198O1RCE0ttN436y0E7XiHqZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737400839; x=1738005639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9OkIISAHOr3DZvwJ0coxD4gf5mKOHzo2htoKxNgRDPs=;
 b=Ee1RrIu85i94wrpikX9uKIeUM+jcbXuu8KqpYM66NNrRxrV0CWmyPnHzfB2RYChTEU
 JO0r8bmLLfsIQPGxnOOKkx2x3XZpiCEehfOdhLoReUdZefvX4wfemfUksDLm0+dDIo+N
 F1Z5+aYKI4xf32hkZwyRt3jDLeNCSm8VX8sA68yA9xRTccpHFsck6cWdbWbJPlEwCC1m
 gNvp/8+oQrecr+u0TMjvbr7HVzeMLalP0OCSf2g1TBsVHWMBeR/oiFkYduXHEGJeUbi1
 Qm2ewY+bMfzoCCM/Jd5gi4MGvYwcXQ97BeNvxoImBxxlYAoPUDx5Uzff+N4uo+cZz868
 C3XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpqONkUR2rUfpzD26XaaqYhzLF4U4a9ff+T6HEQz3zF4lR18FyEkQGZats6Cby8SNN2Zmtf5s=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1IsGDl29NuP9FTU3u8PnmPKuOIb6scfk1sjgqpF8WbhutNCoV
 8WCf5y4WgI5YoUIMd9haAE8xTbTnSuhoZSrHUz7E3A+osyHDnpeAZxnwrwsekaWM8iP56Hwqy1o
 jQLSYhTA1eQKrcOQ2T5eb0GdYO7ePdsTOu8TCQEqJGjcRrlI=
X-Gm-Gg: ASbGnctE1D5jsP6vpDn9Wyj1gc0+gBXpZ/yhVMkM//4Z+mm90dvJ+1B/MhBiQao0/c7
 T21KXRXg0izZksKBzAnkKY29/HNkVo9opwS9RkxEGvwXAr3ZtIgaY
X-Google-Smtp-Source: AGHT+IEbxbipiRYcg8DQ527sOhxqkqp8LkCpGZfQ1vyTeKRzolkBty5UKm/AB40wXkMNn/1F95rfKPE1RBIdt2PGP38=
X-Received: by 2002:a17:906:6a17:b0:aa6:b473:8500 with SMTP id
 a640c23a62f3a-ab38b44e059mr1213852166b.42.1737400839399; Mon, 20 Jan 2025
 11:20:39 -0800 (PST)
MIME-Version: 1.0
References: <tencent_78F00D5010A6F5A48D0F464FC0E026DB5906@qq.com>
 <20250118164038.GY3476@bill-the-cat>
In-Reply-To: <20250118164038.GY3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Jan 2025 12:20:26 -0700
X-Gm-Features: AbW1kvZE7RyGz3dLwWEdmnJUGzZE-k-CMWqIi8ux9kUdorsdOdwYMrV7U9ZNnVM
Message-ID: <CAFLszThRJ7Jxez4qW=_7ZP2100pmk-Q2W4W=tr-uV=zpQj_aCA@mail.gmail.com>
Subject: Re: [PATCH v1] arm: Remove redundant loading of image copy start offse
To: Tom Rini <trini@konsulko.com>
Cc: 1425075683@qq.com, u-boot@lists.denx.de,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

Hi Liya,

On Sat, 18 Jan 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jan 18, 2025 at 11:39:18AM +0800, 1425075683@qq.com wrote:
>
> > From: Liya Huang <1425075683@qq.com>
> >
> > Remove redundant loading of image copy start offset.
> > Because the beginning is already computed
> >
> > Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Liya Huang <1425075683@qq.com>
> > ---
> >
> > Changes in v1:
> > - Due to an error, the patch was resubmitted, leaving the code unchange=
d
> >
> >  arch/arm/lib/relocate.S | 2 --
> >  1 file changed, 2 deletions(-)
>
> I don't understand what you're doing. Please stop posting patches that
> have "Reviewed-by" tags on them without pointing to other evidence that
> the person in question supplied that tag somewhere else in public.
> Thanks.

Just to explain that a bit more, when you send a patch it normally
should just have your 'Signed-off-by:' line. Then, other people reply
to your patch with 'Reviewed-by name <email>' tags and these get
collected by patchwork.

If you then send a new version (say v2), you can collect the tags from
v1 and add them to you patch. But until then you should not add your
own 'Reviewed-by' tags since it suggests that others have already
reviewed the patch, when they haven't :-)

Regards,
Simon
