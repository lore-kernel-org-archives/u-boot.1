Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F80C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FE37877AC;
	Wed, 29 Nov 2023 19:14:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mujRdAiq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340598773A; Wed, 29 Nov 2023 19:14:10 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8E3D877A1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc13149621so131725ad.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281646; x=1701886446; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BDYfv8XsnvE9UAveWxfzWB8ZW5RisIUZwB19725bcI=;
 b=mujRdAiqYNsPew6I7LRxv+ZVuSqbJeFAukNvfmPw9TynHA4YomisXB0HkACLxIGDhh
 +KLs02BpU+RmCR7oQmPNWVQOm4KuUw0Lu3Ks2aj62YT6v0vOJ73Nbqb80w4vV5VOKQ3N
 AbcQXScBxT5EfOsrP5+gvM/Dwjq3joIVSKRpn8lvxQqyyZvUc3YaVNzdQdJev8L03RAV
 njinyDJMG3YfWUKoNsOgd0jK4sqfBgHHfJbn0kGxHzre6sjRz0HOE3dkRDrW5SPQ9G3n
 iEjyJrV/d8RuPFse0saov1hQQ9MjNEETSV7AqALIFD/POT6la3IjEDht8hY6vJPglkqU
 T8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281646; x=1701886446;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BDYfv8XsnvE9UAveWxfzWB8ZW5RisIUZwB19725bcI=;
 b=kJtXb6c0BT65N1VrWtkbHfEiqYcXRfKfqBTQrKCjTaj9Yn54EPv71jkgjJyhazyPoT
 xKtYk/I/sMYxt857neOpuzROjbVmdeZzQ9Xk3Mm0mpAgGcNE2ey/l9tkem3OIDR++XAl
 kQEL/P0osL5yN8N65YA1TpP8eHi11Y10UlFCxB8LWttXjNvvDb1peE3XJifw/FOXj6L/
 AQrU9pGHHsV4/mvbBRqzUgDj0B2mAggOJUTdoJarlBi7ufvQEHL5+LqGT71TjRQC0Mzx
 MpiI8vGCcJyBAcr2S094ULpQIHnarynaX4QYAMA6fmbOpanh/Spoe5+LG0oP9ZAWIudK
 lwWg==
X-Gm-Message-State: AOJu0YzUPlqppb0GtHaJUl9Yx3DjtFzYWHeDIW/1pHXqkeNxt/w5ebjg
 bIkGVRCz4VoJCbswl+RpD1RrzU+VD6EWt6jBrNQKWxF3s88=
X-Google-Smtp-Source: AGHT+IH24crhBPVpChWJCt+KRDqMeii1B1LNRj2kecppIX2WyZuZObuPSySghkzQ76pUAT4vvhFDekdK3YBP/dD/yT8=
X-Received: by 2002:a17:90b:713:b0:283:5405:9e90 with SMTP id
 s19-20020a17090b071300b0028354059e90mr19242382pjz.3.1701281646027; Wed, 29
 Nov 2023 10:14:06 -0800 (PST)
MIME-Version: 1.0
References: <20231027134127.201699-1-arnaud.ferraris@collabora.com>
In-Reply-To: <20231027134127.201699-1-arnaud.ferraris@collabora.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:13:55 -0300
Message-ID: <CAOMZO5CykviJfDFV25iv8YvVVP57eoHiA3zmXcDiQL7hdatdQQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] librem5: allow using distroboot w/ extlinux files
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc: Angus Ainslie <angus@akkea.ca>, kernel@puri.sm, u-boot@lists.denx.de
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

On Fri, Oct 27, 2023 at 10:41=E2=80=AFAM Arnaud Ferraris
<arnaud.ferraris@collabora.com> wrote:
>
> The Librem 5 currently can't boot from `extlinux.conf` files due to
> undefined environment variables:
> * `fdtfile` is missing, preventing the kernel from selecting the
>   appropriate device-tree
> * the lack of `kernel_comp_addr_r` and `kernel_comp_size` forbids using
>   compressed kernels
>
> This series ensures those environment variables are defined and have
> usable values with regard to the board revision.
>
> Arnaud Ferraris (2):
>   librem5: properly set the `fdtfile` env variable
>   librem5: Add addresses for compressed kernel load

For the series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Angus,

Are you happy with this series?
