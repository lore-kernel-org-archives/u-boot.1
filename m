Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE79EEB58B
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 10:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1EB88E98;
	Thu, 12 Sep 2024 12:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="H/unUg0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36E8B88E04; Thu, 12 Sep 2024 12:07:24 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2D6988F53
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 12:07:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2d89229ac81so662763a91.0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1726135640; x=1726740440; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYZctlTNeC8u/5nOJk9ZAEG9fy4pgGfSokRy9EcWxZs=;
 b=H/unUg0iqG8YGZL738Jb+DPetUMHxZEgi2siYlb44pn8cv5nVGiCtvXFax887C9kcF
 j+gm+FdhoC5vXEqRNxqIbtOb5yIMso/1QAwRpfZDu6WGSjY4sjDYahFFQQv/I2axClka
 WMcZjAAOoUbxgywIe9QAtQ3Mrl4bBRtuWiJLGzHP1Gw4awp0KGC6cAyBYNjYM5hy4DrB
 vjzgp6jeOu3QHXh8W5dYIw4mh00c9VoYKKXuK0bDgKCN8UxVAGEQLl9hSKxU0NIqhuth
 bQJjyiWELwOqjD6pIl7qMo8kTr7sjXnyRgWdOpVWNi1ZKPh6q1B8W9Je83kN8TItA176
 c7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726135640; x=1726740440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yYZctlTNeC8u/5nOJk9ZAEG9fy4pgGfSokRy9EcWxZs=;
 b=ZPv2EjDERN/xXFpqlRByeH8FGlpuJtov0+4K4gq3pfGP7UUrmmbPaB0Rh+AqqdcTUb
 /v3pK7ZAZq3av0tvc5piGMaGz5KQjfuuktnEkIvNMepR/Tls+gBcl1I0Pl3RPX0DggUs
 PjwPXXTXKBDgkPCO8s0248C2QgMXkjXYH4wJsXAHFSjFXRYwM8f4d07lmvT14OSm2lE8
 7LTOG+LUYJwOZHIozgMgN32vEJ3Tdr/No24z5+zfcPHjfWo6pByr+jhguCUrsxH4X0Br
 AJR818iFuP+mSWkanic8E0i3We1MxrqDczMH1wElqkgFDnLk4GKXue6T8Zvlr/GOdq2G
 WXgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0NDxrlPmR0g3SwkUeN9sezaBOAjy7H0xNUvBKqcoWhm0IqFvnUGltH1nhC5Blk/+QtnxNOZE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw93jI4oyPImc8WzWbDe6sAz7ZeUjNL8cHsiRRrjsPlupAJ/3aT
 TKI/u0fQwGSuiURSC9+h1DlMbd0L6+5TDGp/b6KXwkrEnUEkZ1acpOIkdajGOESBxY3fbzqTWJS
 n8IQgGcKd1rX3uxD+qWblerXU9vKuGb6VhGyu3g==
X-Google-Smtp-Source: AGHT+IGw6/XilpH1umsMZvTsLmCw5g2B+DaBpYZ2ayBatMb9Qp67y/lGEanwFK1Z/vGlavu9FYgpuOlINNH4aou7fNY=
X-Received: by 2002:a17:90a:2d84:b0:2d8:ee39:465 with SMTP id
 98e67ed59e1d1-2db9ff7401amr3118052a91.1.1726135640184; Thu, 12 Sep 2024
 03:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240425143627.54648-1-robert.marko@sartura.hr>
 <c399216d-34d1-435e-96a7-6716f9f2c32c@gmail.com>
In-Reply-To: <c399216d-34d1-435e-96a7-6716f9f2c32c@gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Thu, 12 Sep 2024 12:07:09 +0200
Message-ID: <CA+HBbNGSZ3enyCF9cT8_1qJYt7TndDKJ-OYYe4EaS6_BTPnbRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor-core: allow overriding 4-byte OPCODE
 support
To: Tudor Ambarus <tudor.ambarus@gmail.com>
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, trini@konsulko.com, 
 u-boot@lists.denx.de
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

On Tue, Sep 10, 2024 at 9:55=E2=80=AFAM Tudor Ambarus <tudor.ambarus@gmail.=
com> wrote:
>
> Hiya,
>
> Please specify which linux commit this patch follows. It helps reviewers
> and gives credit to the linux author.

Hi,
There isn't a specific Linux commit for this as far as I can tell.

Regards,
Robert
>
> Thanks,
> ta



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
