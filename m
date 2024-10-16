Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450BAD2A555
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 19:46:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C432B88DDC;
	Wed, 16 Oct 2024 21:46:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="au6YEzdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3949A88DB6; Wed, 16 Oct 2024 21:46:37 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6DE88DDC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 21:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2fb5fa911aaso3172731fa.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729107994; x=1729712794; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cW3xWQxYOJ3e5pVBfeNg2hDFUdCLXtwclaTNAduEE1o=;
 b=au6YEzdTjW9zvLZeauW51gPYBPgbvhsE6toPcoVhWFYdIAeQGIaOacUW+I7ANUymjZ
 g0ICrK619rG8h/FYz3bAQy6aNSIZUyPgpzTRBAYRW9l0TL6V+k9NJcBt511M+HsIvOaW
 OzqF1Q/4CucHryfahxPFjqe4k6xflrLyST/9OWbKrB6DIf29u4KqN7Ernb1g3fCbajEw
 ogLZupqBtL2ckn9/ev34mHZthcwpy3Y+YIOWyfDU4qJXhE6dUbDC4HquMYxKVueKNEkX
 I8e1PiaoGD33MuFJh9XIM6QlX4zLeAtOmYniINfL+LQPzne5U6OTsr8uLk9DhXP5k3Wt
 NXiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107994; x=1729712794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cW3xWQxYOJ3e5pVBfeNg2hDFUdCLXtwclaTNAduEE1o=;
 b=Ytsy+XHnS2OyWl/dsNh3flwCZvWZ8whWXnglejn7z6lReiNdml2Yb3SDSwpPnw1xko
 NKONgI5RtSmStGB5pwLSe16gVlxLPvKFRGqpw4S1EZT1KOad7M7RVagwcV4WK3YeKq8U
 5Z02MoamdHskly+8E9QQY/MpOlhNP2sUJR89e2W1jLd3Dbrut8GRr289RBtAo47Usik7
 Ahi/KIg18rWkX4BX+GWI/7AYTcQbi8X6GZLXOnPK+yWesAS8r0PkSgmZKoj6y0YIXxYn
 TKnoeE2H13APc0jGbMTC4VkcipJIrY8Lvb6eD18f0AWk8Pb3wP7KTMir7UMsb+sUnRFa
 iclQ==
X-Gm-Message-State: AOJu0Yx2UBqVY3G+ydPk3M2TFvdhv75T1Ep92CrtrWF8y5izC7VcxW5d
 /rm+6WJbW42LiYEAwSXF3Y59Q9S1fIatbVavTDUbkjHhb2Dd+Ky+9v2OpTv9yJK+d/rLnVfPfj5
 1MfFZWDuSnFtWkV5b43z1oQAosuk=
X-Google-Smtp-Source: AGHT+IEwEKQLbMU6NuCAhtNAO5ci34+O9lTh0Wy18xjK0gRqrB1mQ0wUdEDs9c1nCOqCaSeE2RTrdyL0u0lsIprzppw=
X-Received: by 2002:a2e:4c19:0:b0:2f7:6653:8053 with SMTP id
 38308e7fff4ca-2fb3f1adfa0mr78424251fa.18.1729107994025; Wed, 16 Oct 2024
 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241015002505.1243-1-egyszeregy@freemail.hu>
 <CAOMZO5B+EpaaP1YXNxWsk+6m4qU347cYBC-cMFYjiZTaB1s-kw@mail.gmail.com>
 <6e52a56d-ad56-4314-babb-4a290db1c8df@freemail.hu>
In-Reply-To: <6e52a56d-ad56-4314-babb-4a290db1c8df@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 16 Oct 2024 16:46:22 -0300
Message-ID: <CAOMZO5DMU9YQjKuZvgC6EzPzLtM4yviqAm9iaNFmDqXv921acQ@mail.gmail.com>
Subject: Re: [PATCH] pico-imx7d: increase ODT resistor value from 60 to 120
 ohm to improve DRAM stability
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: u-boot@lists.denx.de, sbabic@denx.de, otavio@ossystems.com.br, 
 Ray Chang <ray.chang@technexion.com>
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

On Wed, Oct 16, 2024 at 4:35=E2=80=AFPM Sz=C5=91ke Benjamin <egyszeregy@fre=
email.hu> wrote:

> I am not the author of this patch why i need to Signed-off it? It is a DD=
R calib

Because you are in the delivery path of someone else patch. This is
explained at:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/process/submitting-patches.rst?h=3Dv6.12-rc3#n459

"The Signed-off-by: tag indicates that the signer was involved in the
development of the patch, or that he/she was in the patch's delivery path."

> optimisation from u-boot-tn-imx repo for pico-imx7d by Technexion maintai=
ners. I
> can not share any more info why it is needed.
>
> https://github.com/TechNexion/u-boot-tn-imx/commit/8a00e57b697c6f7d3d3abc=
fc552550ac7d8cc96d

Like I said earlier, write a short explanation as the commit log like
the text below:

"Increase ODT resistor value from 60 to 120 ohm to improve DRAM stability.

Based on the following commit from TechNexion U-Boot:
https://github.com/TechNexion/u-boot-tn-imx/commit/8a00e57b697c6f7d3d3abcfc=
552550ac7d8cc96d
"
