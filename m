Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61EEC27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5BF87CF1;
	Mon, 10 Jun 2024 11:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqWvyBaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2940E87CF1; Mon, 10 Jun 2024 11:31:30 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FCF87C40
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3579ef2d436so209240f8f.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011887; x=1718616687; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jH8sBWD9j/vrIRtPuSjhG1nsWoMXY275Qf4kO6eZuCE=;
 b=nqWvyBaK3tKUuwIjRETa1+snd3Feott3cXMz0G79QZPZuWLHzblu0bKDFffMHcz/UG
 IdkKA+fK7Ucx/nWCGFslsButKuWIdIvXpMzcGbp9ZW1DyzumsFv54POIvMMjbHOO6EwQ
 IdF7TF7r1Ps6LsLlVcTh7vpWE+Lrnka40jmM8IO7zEtZOYd5aHjpw/wJ8X0y4tbVNZo9
 CPWx7QIBEHXGKyLZFbO+tDF4MOLs9GxxtJyo2b/5DVIHyHhZfILKe86OthC0pOM8KrFQ
 uDQO4AVIDR65LKUdsrFOdbgT+tM+bornNXaZxVgGfXKyav/vspDPDd/dghA+B2ihmj/v
 LYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011887; x=1718616687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH8sBWD9j/vrIRtPuSjhG1nsWoMXY275Qf4kO6eZuCE=;
 b=WQsQIxgpJGbcYsvpXxGb6vYceI/xY9Q0R/Ep7wA2ND1yGYsi7+gg+KmH9U1Fc003ky
 d6VJi+whKVbjig6PYkBesNo7PnTTWB2NOj74K/h7St7+06P2WhkfGnNuJskqAfDA1vdc
 lke26wyWmZUmqJD6yRZG0vu9VfdbCd1aBn69eQgxYwVmycUPiRwlYHol1U0QikJXSI+O
 OicDlIMnXXiXefrk9s51O4PT7h7djP9T7kGH7CwXh4yT5Ze8lP9+yrX7Vq++fQ2s60Ov
 0AATVU8xqxbijcCOhNge2Kxdta1mGNxXwQo8tpWB/bVueioSq7DC5LG327YSGItx1+w8
 gfFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXATcGhp+weVUKfeGr0A25blJs6ZOSLdBZyKOiAafS/WSCpwKVAI3Jo+ROZvT0mZfSTtpxKGqxPy7ilzoRYy2RoWJkBTA==
X-Gm-Message-State: AOJu0YxI5SKdYVhxnCYq6vhPeHMSKKKW9uRtO1qgSCN78qGG3nU8nn+b
 kdMptlMlSpmujdSQZ1ShJCFUQUVv2JIJmrqKa4yxvQhdXlXgokVFAjKtUZT0l1iI2VtrUSI7vWZ
 pXhmjcff4ExetkkoTINhyTK8xlSU=
X-Google-Smtp-Source: AGHT+IHk+A3YZOQJH3jyq4A27hlXt+5sNtDeIfCpghZl1jOjJ8lJ0I0t6xPFZ+BqVdZesBZYo+uD7OQomSVlI/Jn1xU=
X-Received: by 2002:a5d:5f41:0:b0:358:3a1:2643 with SMTP id
 ffacd0b85a97d-35efedd9ccdmr6654870f8f.3.1718011887170; Mon, 10 Jun 2024
 02:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
 <20240606-bootmeth-android-v1-3-0c69d4457cc5@baylibre.com>
In-Reply-To: <20240606-bootmeth-android-v1-3-0c69d4457cc5@baylibre.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 10 Jun 2024 11:31:16 +0200
Message-ID: <CAByghJY9Vnp1fTT_1mXg8iCCaFBsMP0+MeYSr3by1xbVp-73qw@mail.gmail.com>
Subject: Re: [PATCH 3/6] bootstd: Add bootflow_iter_check_mmc() helper
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, u-boot@lists.denx.de
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

Hi Mattijs,

On Thu, Jun 6, 2024 at 2:24=E2=80=AFPM Mattijs Korpershoek
<mkorpershoek@baylibre.com> wrote:
>
> Some bootflows might be able to only boot from MMC devices.
>
> Add a helper function these bootflows can use.
>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  boot/bootflow.c    | 12 ++++++++++++
>  include/bootflow.h |  9 +++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 9aa3179c3881..59d77d2385f4 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -575,6 +575,18 @@ int bootflow_iter_check_blk(const struct bootflow_it=
er *iter)
>         return -ENOTSUPP;
>  }
>
> +int bootflow_iter_check_mmc(const struct bootflow_iter *iter)
> +{
> +       const struct udevice *media =3D dev_get_parent(iter->dev);
> +       enum uclass_id id =3D device_get_uclass_id(media);
> +
> +       log_debug("uclass %d: %s\n", id, uclass_get_name(id));
> +       if (id =3D=3D UCLASS_MMC)
> +               return 0;
> +
> +       return -ENOTSUPP;
> +}
> +
>  int bootflow_iter_check_sf(const struct bootflow_iter *iter)
>  {
>         const struct udevice *media =3D dev_get_parent(iter->dev);
> diff --git a/include/bootflow.h b/include/bootflow.h
> index 080ee8501225..6058ddd89b16 100644
> --- a/include/bootflow.h
> +++ b/include/bootflow.h
> @@ -407,6 +407,15 @@ void bootflow_remove(struct bootflow *bflow);
>   */
>  int bootflow_iter_check_blk(const struct bootflow_iter *iter);
>
> +/**
> + * bootflow_iter_check_mmc() - Check that a bootflow uses a MMC device
> + *
> + * This checks the bootdev in the bootflow to make sure it uses a mmc de=
vice
> + *
> + * Return: 0 if OK, -ENOTSUPP if some other device is used (e.g. etherne=
t)
> + */
> +int bootflow_iter_check_mmc(const struct bootflow_iter *iter);
> +
>  /**
>   * bootflow_iter_check_sf() - Check that a bootflow uses SPI FLASH
>   *
>
> --
> 2.45.0
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

A bit offtopic (just an idea for future refactoring), but I think all these
bootflow_iter_check_* helpers should be replaced by just one
int bootflow_iter_check_id(const struct bootflow_iter *iter, enum uclass_id=
 id)
to avoid code duplication or at least keep all these
bootmedia-specific functions as
wrappers with one-line call to bootflow_iter_check_id(iter,
UCLASS_SPI_*) inside.

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk
