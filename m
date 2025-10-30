Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA1ECCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC25983849;
	Thu, 30 Oct 2025 17:36:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JskpxsGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8464483887; Thu, 30 Oct 2025 17:36:47 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543EE8334F
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5930f751531so1317825e87.3
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761842205; x=1762447005; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCqznJ995sOJ8adpwEgPkbSBZRAKBTBpP1RFHWQloR4=;
 b=JskpxsGdUhn5hUlUdJdVBJ7pQTHm3jlJ2pYEyPZkX0zALL20FFj0PBYMkU3+/qz96Z
 7lWaXyPBh2Kv4+BWVIsEF7Gw6NqTk/CfgxIcVuOgt/JpG6h8HGwqbpiHsRmVda14jHId
 1cxQDza1KuF2cxmoR+xdKCWAnwXjJukTIwHYAB/UormS5KO8eh+CLUsyOtIpaU1afezO
 50d6GWeazaNDtrXCWlHvb26dYZOHIsLQGdaLPPX8L1VAdm/RRVZ38gWSMdIGoS3N9Q/d
 FuuzydxUKqtm2AxPOri1msoUcXsGP6btaoTC/OtXsct25R/HxDVElMm91ywvW8Aio4rT
 9KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842205; x=1762447005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BCqznJ995sOJ8adpwEgPkbSBZRAKBTBpP1RFHWQloR4=;
 b=TuQs3YJltjjVya7oVqcCvEyuipongW8yN7CsvH+H/JNFqw48NVLspZjSnwe/mJ/Egj
 kXM5YHTrlUC+TMeWxKxeZ8qkPffXXzAsaKkzV74T+/fY190pDrddObWmMjPhPsSkM7iz
 iUztAr0JvimxdSQEjFyCWs3/IVxWS2updyWgB1WvI2zIGFDP6DclW5Q0PQhRd5hLdJTJ
 K1Qr0in4yqxvav0ybqC441zoS/iN6KGDOeGOh62HdxOoW/gKy70KGAlKtU02e7WoTJwJ
 JbN6nFgfI5PgHD5Q8tSBopXnodo4fXGbUwCDyYs3KTlKE2p1m8sNN79f5QusBN2/2q+K
 ZL2A==
X-Gm-Message-State: AOJu0YzWlaCQYQOTbhfQmWWkgBpuUsaQO+4GO7FU6hrQG4CjgiCXlGf/
 msvLUw3OevwcxX7CvJcS+5zVT7AzYZ0rkt0HJ6SbLijYdo/G2ph8Q9eeiNyE4N6zx5RWWzs3twD
 gnuwJ60H3LUwW9GNqnRsaTLITliRJ2nw=
X-Gm-Gg: ASbGncvMVL+LuqRddPnNCsz3xN/4FiL6QteUAB4Tb++/2IjJ70R9xbW47cjScaqvmLW
 ebPBPVeSiy6f0oLmh/9nwmo9clUznQQMx56/CJrjLHg8X0Ag0Y+WUN7is4s9YtbagiXoQxfp3wP
 xYwSqArig8/dUqP/oc73/LkAg6kXGPs6SmR9FRxekeOb9jrkTj7QrPDzDRonRTIWLgM5ygzE5AQ
 gvNeFo7/aoerdtWjFvJl128M8yzWQD9H3+OYi47P8SDnXGavQtikT0aT9L8JklgQGdgvD7qusNC
 yni6L86G
X-Google-Smtp-Source: AGHT+IGZrQuCGpEGPx9VLwMMZNo0IsYXF0lgJBwu83KnU9liNswzDrqwRhHdn9ULxl8yw2wVVSq2g3y77u3jUyFW/ic=
X-Received: by 2002:a05:6512:108d:b0:592:f814:3852 with SMTP id
 2adb3069b0e04-5941d52534fmr124074e87.20.1761842204215; Thu, 30 Oct 2025
 09:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5Any4akaDeRNwxqhcdy_gjxQVHC3aao6sDDxqALxNsp9Q@mail.gmail.com>
In-Reply-To: <CAOMZO5Any4akaDeRNwxqhcdy_gjxQVHC3aao6sDDxqALxNsp9Q@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 13:36:32 -0300
X-Gm-Features: AWmQ_blFYWDgQ6Qw0sprMH_AQIap5VAN0m-C_uHJutt1nz4FdB4zYCcpZHjdkjg
Message-ID: <CAOMZO5ANeCogTO+dyq9GSu7XGeW+H3OZ2CXCEsguhcrQLJwNrg@mail.gmail.com>
Subject: Re: vexpress_fvp test.py CI errors
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot-Denx <u-boot@lists.denx.de>
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

On Thu, Oct 30, 2025 at 1:35=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tom,
>
> I'm getting the following vexpress_fvp test.py CI error, which seems

Here is the error log:

https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/1279968

> unrelated to the master-next tree I'm building:
>
> https://source.denx.de/u-boot/custodians/u-boot-imx/-/commits/master-next=
?ref_type=3Dheads
>
> Please take a look.
>
> Regards,
>
> Fabio Estevam
