Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D7DC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 19:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C06082A8B;
	Fri, 16 May 2025 21:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMViU/E5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A48E78059D; Fri, 16 May 2025 21:59:41 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A46468059D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 21:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-326b683ac3aso38219451fa.0
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747425579; x=1748030379; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ButsKjzXsgDp8ClD2cAhvnjYhJDbjO0u1GIOgBJf+qY=;
 b=EMViU/E5vouUXpgk+JUtiEvyfbEFlOdC3q6j8RO4WnM/ZjZVnrT19Z+ceKuFHsDvQZ
 qBkgq4dJsNGYRdr34Gc8EKl+syoNwOT5EOdqiStZoSw8fvC4+BMmr+jUt533u+vKYm1F
 T6VRTbg2Mv2KGe8ZPrdaWY6gVu98UWaCroh+YdzB0tYgKpjM++wSHu7pTa6dZ4YoPdf5
 tf+rhQ5JdE1sVRSnuUBIslL2ZSlY7W4xTVxqhZBkiyr88MaMvxr+GCQ/5zjYEpR+Po49
 5sPgYpUJ8tejm2TC18koc8QMUWBsFIZZRq3g3vnpodnpxherm+F7JUU/7gz3JBYdpt90
 z78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747425579; x=1748030379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ButsKjzXsgDp8ClD2cAhvnjYhJDbjO0u1GIOgBJf+qY=;
 b=w8v6fqOa32bGRARzJLZrd+KyHKgyx0kaOf4SPp5woytJt2XpIF0QHNOxUqKmXRHi9j
 RLwbkYs+7MgGS/RS1ZIqtIiEG6q0q5kDM2en2wuQOAb94QF0EbsJsMiVm9PDMUcJDoUm
 LiquNSzjNMTEjD1YQoPwRdF9+5TjQ/UL4/7wKxMekLHWqslSaeCW8yXg+UK+zl72r+xb
 Cu8FQe+9XhBdZXYwdXn4/FXlzFIYJaNLGRCpPmNFPFdAQ8ZP6p+NJm1+vhnecMBuKoqU
 yhMs8C10bXkjYHf6COxR8zH1TDpgOKHz/xcstAoPOPjxRguyb8vb5rQnbxO5tZuDe5n6
 6gSA==
X-Gm-Message-State: AOJu0YzCZumO6zeDM2twGkIFsqEvtfjASzY4AVXDMD2Uahp1EXN/7ubJ
 0ohTvqy2QbnfT3W4AUUZqEIN2PJwzjkSx3uGVdSC0/SlgUs8TBgAq9Af0K/H9yB868g3lZp1qbB
 dqXvEKkXiR87xAddasV4ajKrUMQTKm7NG3w==
X-Gm-Gg: ASbGncv5pOKmLV79M3OZBrZ6AZ5CNXktZWZpTP7qf1tUdgM7v5jy+2nY4YLWGhGGc4s
 qdYdyTzbR8/VOm7GUz2YZ3Y1obTLyLayLIxsAghWY6CjV+B/qzHt9hcSLs9JvRjDumcMLS2EM52
 CSUCQPdQFGp8kALAn13I8iN6kjee0i82DsalkCwYxJxoAoGccpwQ9ZyTkIEfRvRSqN23xEjrL4f
 bE=
X-Google-Smtp-Source: AGHT+IHTp4JxbFlaJJ9eeiy77QCQjCCOmySlArV7nJkLNNzBclBNiLAoWrxAbMQRKz4/FLQ/24HjPRKENbfbCo2hncg=
X-Received: by 2002:a2e:a99f:0:b0:30c:433a:2886 with SMTP id
 38308e7fff4ca-327f845358bmr35036321fa.8.1747425578596; Fri, 16 May 2025
 12:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250516193618.153618-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250516193618.153618-1-ant.v.moryakov@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 16 May 2025 16:59:27 -0300
X-Gm-Features: AX0GCFslRZ2Ud8seOhgbFx19AcOGDP59C7J1_orI1pHXG-yWg-ZQnXUCaKhRbUE
Message-ID: <CAOMZO5CG345_+wN81ADcBXMnHj2u309=dLDR-a-frMY9asZq4Q@mail.gmail.com>
Subject: Re: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de, trini@konsulko.com
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

On Fri, May 16, 2025 at 4:43=E2=80=AFPM <ant.v.moryakov@gmail.com> wrote:

> @@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device *=
dev, unsigned long pipe,
>                 debug("got wrong buffer back (%p instead of %p)\n",
>                       backbuffer, buffer);
>                 result =3D -EINVAL;
> +               goto err;

Was this supposed to be a v2? The error Tim pointed out is still here.

     ret =3D _ehci_destroy_int_queue(dev, queue);
> @@ -1565,6 +1566,10 @@ static int _ehci_submit_int_msg(struct usb_device =
*dev, unsigned long pipe,
>
>         /* everything worked out fine */
>         return result;
> +
> +err:
> +    _ehci_destroy_int_queue(dev, queue);  // =D0=9E=D1=81=D0=B2=D0=BE=D0=
=B1=D0=BE=D0=B6=D0=B4=D0=B0=D0=B5=D0=BC =D0=BE=D1=87=D0=B5=D1=80=D0=B5=D0=
=B4=D1=8C =D0=BF=D0=B5=D1=80=D0=B5=D0=B4 =D0=B2=D1=8B=D1=85=D0=BE=D0=B4=D0=
=BE=D0=BC

Please remove the comment.
