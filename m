Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A7BC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 20:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9874080107;
	Thu, 15 May 2025 22:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LGsTu0bA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62DB8059D; Thu, 15 May 2025 22:12:55 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12E9B80050
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 22:12:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-7fd35b301bdso1415136a12.2
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 13:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1747339968; x=1747944768;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YXk1Jfr6UK/NWnvtd4JuXoIL2T6hMWqinwuKfAYYGoU=;
 b=LGsTu0bAb1suK+IzTmMprYkNUnN316WWBpN9bBVpCDMQ11VLiCL+xfErfzO/NM5FYo
 WhBA3pa2PWgRSIwkk8PGCel/tHrUJ0MwM6KbFGt4V7LgMI19hksVdcU7v3CoaQ6hphAE
 FSWKhBlHbOltkavAJiCfNmizvZJTZVCa45s3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747339968; x=1747944768;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YXk1Jfr6UK/NWnvtd4JuXoIL2T6hMWqinwuKfAYYGoU=;
 b=o2mhC/4dUi2MDKX40Efn0FX/S+dDLsfo4VGOxEilmwho4LZ4j/+s0gEBE3N69y06xE
 TULejXbVYMF7sYRbSGc6jdcXByI/raEgtpdMEZ6iNBTYC6bjKY1+x0UVC13VsCceVFxe
 xpge1Ql1uvx/fwvQ0EMqQH4S9xUZNoRIzmjZuPd5iX4H9i0MV/5yyHjViP7w0G1vLsIY
 /8dTcUlhUTzG1wpq2o4cDVm5F6LBA3cDeCJ2Guqwv85VfbyjQ3OGnBXK7tUH51+Lu5jY
 S730T1OzGIj6D8mcTi/jXJRFlD9ypPZt30jXdM8zhSUakvWCgpZixKdP9kpIXIW7CRWP
 z+3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXADqkxwJx11p9IDYKY4209SxI9XlTr/vCHbTIi1CRwb8mKVg3VAGtJ8K96Nv6lnlVvI+KF0pY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5f9wYClPAz20cPEaNoXdvlp1ZONdxVNhDQQt6Ad/2A1hCNd8m
 rsZHjDK36vDwju1/n7/WIktWl7HMNCoa9TClW3y6jdU8KLosHqn8LTvptNJEatk5P8AgzU3RQOJ
 OMko9tqP9d+l8cxYJbwDcwr0yC+d6aZeh2QvZrBj+wA==
X-Gm-Gg: ASbGncuz+sH8x0DshBcaNlNuLjZNZfqC0uCIzLgBnaMHL5mVGhpAez4zH3RVBrGGnWh
 ZMzEUnS3BQ09UJGqj3//SUt5bHFxFbCv9Seh2wl9+rWG7C1BkXanbIRLg8ntJKzslqXGTRj4TbN
 d+tg9npFFszEwoVSo09CCTXjnX77jH4wVv
X-Google-Smtp-Source: AGHT+IFR9LTvw9+gRij7W5d9WkeciqRYzWdZd/0pxJb5gLFMj/WDPmFTGoTl9n6yhXslqA+zq8sTUazTbcIvg+rJ3gI=
X-Received: by 2002:a17:903:19e5:b0:22e:4b74:5f67 with SMTP id
 d9443c01a7336-231d43dd9bemr8676605ad.31.1747339968286; Thu, 15 May 2025
 13:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-4-dario.binacchi@amarulasolutions.com>
 <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DdjRT=qGVd+qLXraud8xC=noioduLvDObd1B-n--7CdQ@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 15 May 2025 22:12:36 +0200
X-Gm-Features: AX0GCFvh2uRroQsRCocCF6kpHVrDKUuRxgAOYSSaSOmoCKqyqL5T3voAj7VdS9I
Message-ID: <CAOf5uw=iBNKu3Qvpa1WoYPy-RoKXM7PQtcdBaXupwrtWAKNAFw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] serial: mxc: restore booting for imx8mn_bsh_smm_s2
To: Fabio Estevam <festevam@gmail.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 linux-amarula@amarulasolutions.com, Adam Ford <aford173@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Fabio

On Thu, May 15, 2025 at 9:45=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:

> On Thu, May 15, 2025 at 10:12=E2=80=AFAM Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > The commit dda454e933c6 ("serial: mxc: Support bulk enabling clocks")
> > breaks the booting of the BSH SMM S2 board.
> > Restore proper booting of the board even in case of failure of either
> > clk_get_bulk() or clk_enable_bulk().
>
> We need a better understanding of why the boot fails.
>
>
The patch keeps the same functionality for the working board and fixes the
no booting one. Agree
that we need to understand but even we need working boards


> Does the failure come from clk_get_bulk() or clk_enable_bulk()?
>

The serial is not up at that time so we need to buffer the error and print
later. Right now
we are working on other fixes

Michael


>
> Please investigate.
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
