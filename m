Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85468CD54A7
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 08:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A4386A09;
	Tue, 19 Sep 2023 10:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MzKv+itw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 152D08669C; Tue, 19 Sep 2023 10:20:30 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46D5986AA4
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 10:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9ae22bf33a0so194912366b.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695111628; x=1695716428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6OFoH8RPJ/kDzhjJhFtO1PxhvDqxbWaeE9eDzrdBsU=;
 b=MzKv+itwgpfRweAbIye6MyFdSeJ4xFs+kNmwBHDAxZ7eI/EF1kh6jLdcDJHKxOkFkZ
 Dt3DkU0zVxPrLQOy+fjZqqKulj8pChVVFUzQULviDUY1KSr+9ldxrRInDaUyEElpxe53
 SwsmsMavSYB5G/+bAO6wqWHnS+k6BM508XS8Tq8N3Hcwv+etNQ6NejukJjLIPgUpprqr
 0b3cIXtN7VxCe3aXvjjAkt3tZ3y795NvIxcnFPb6n8MOx8lKbjw3tmAgYj9Wkkb12/4l
 A6UVLNLY89dzbzUhOQ7Ijv1wlrFwyQ03yTc7cz4pUHsR3EQ4hpDcAhueUUHJvEYlsjoL
 WWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695111628; x=1695716428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6OFoH8RPJ/kDzhjJhFtO1PxhvDqxbWaeE9eDzrdBsU=;
 b=NSfNvTWhE0F+D9rjNXJr5uPkgQ49VL39za58CGuyZI6O3FPuWHF8J0VCW2C/x5MjZ+
 t4jEjSlOp7vn2qFFvAKCioCLHC+FnVwHwOke9qv7f76C9MFLUgzKdtkZlG4wPedoUfbe
 N0QEPv5UxSmTFem6tylAEE7JrOKGOM8C0qP/jkKeG+5QimsmJdiXRYzY13+hiKGszWK1
 LwAg9HYzASmDoaaqHoFQJFPunNT7ab5Zs6ze0BAWwEuzltR/dAPKxycPVCzAkBN+ynWD
 3IQVG8L/U+i//RGEvzbFONi32WYgD188Yjl7fzgS6liUakG2DQ0SKg7Ww9MmLt/B3UIU
 26pg==
X-Gm-Message-State: AOJu0Yyvbi+Y0Jm5kqH8mJfpcMt566yW3D5Plbby9wMIrPiA3pH6Msm/
 p4OMGTVDyF8tp+M1HdTsJbaNOjsz0+yOMKRpHQs=
X-Google-Smtp-Source: AGHT+IGzaoeJwmEAiWFiq2MDtW7Q6JoryFeVQHDVETXKl1exLXCkRyC8Qa3btdLUbybNawfzfdhrTsowGqXbez/iXb8=
X-Received: by 2002:a17:906:8a68:b0:9a2:26e4:a5e2 with SMTP id
 hy8-20020a1709068a6800b009a226e4a5e2mr2615040ejc.25.1695111627758; Tue, 19
 Sep 2023 01:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230901120822.1.Ic1e930902ae178ecee565ab48b9579482d03056c@changeid>
In-Reply-To: <20230901120822.1.Ic1e930902ae178ecee565ab48b9579482d03056c@changeid>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 16:20:16 +0800
Message-ID: <CAEUhbmWPPV5Ub5aon57nkfJ8Gyi=VY91HNuNtKf=bqDKFmRwoA@mail.gmail.com>
Subject: Re: [PATCH] x86: doc: Document the -cdrom issues I ran into
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng@tinylab.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>
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

On Sat, Sep 2, 2023 at 2:08=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Add a note about using -cdrom with QEMU.
>
> Suggested-by: Bin Meng <bmeng@tinylab.org>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  doc/board/emulation/qemu-x86.rst | 3 +++
>  1 file changed, 3 insertions(+)
>

Reviewed-by: Bin Meng <bmeng@tinylab.org>

applied to u-boot-86/next, thanks!
