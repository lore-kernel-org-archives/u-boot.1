Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17797C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 23:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D6FF87B82;
	Fri,  8 Mar 2024 00:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dTtx+0vo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA7B876F3; Fri,  8 Mar 2024 00:20:23 +0100 (CET)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0CAC87C83
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 00:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7dba7c2a730so217573241.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 15:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709853618; x=1710458418; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QtS76hEst/9Y8Ea6zP1+d8picOrHxEEMs9BgyJmClUs=;
 b=dTtx+0vos9o7WYQZI72ToXkBaCF+0Rot4LJ5M0BYANZD+ihlhqvaGnwQkb4jk59MUF
 0cZSVX1JijLZFV58edDKYj/PU+2uoCnRYbv6C29ltrZdTJWp7+FK1Rl6pyUW+GT7e4jW
 jA/o65bT6Q4YpFt5Onjcf0xVjiV8LCuAUpYT7X4Ryf7/jAxxSsWLFW1xN0zEj1kLlTMf
 4H/C/6MccUNqhzIuMUbI7UafJk80l3ElTfCrLoHXrIUAIOdwGjp/V+We2ofBaLcUB07B
 gBri2SW1pjrTp8jimhAMXOvEj80Ve73T8lRNCOyWjjgbQBmXsWlzqbXIFSqp4PRu/wgj
 fOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709853618; x=1710458418;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QtS76hEst/9Y8Ea6zP1+d8picOrHxEEMs9BgyJmClUs=;
 b=HUEjyBIleCP4oXfW19M6CiHi7PRqsOhfLLhPiGQS9ngkLEfj3vv4Vd4WJeR2C3fMPz
 MMtrQpGlQB9urlTsSttTObe3OOoKEwLwXPkRNIptR8QmqBsA3cHrq+1rERsfGJyLPdhW
 94Zvne/lM5GIj7JsXuCCFIb5OnPGTySFzDKTm5Otl2GMgjgz6E0t+PmckgTvY44NV2E/
 J//08Qqwxj6kdIvnL155sxS68PyDPJooraJ+aNBIP4XSNHTm6+l4Qdm9bswH0mxcQg58
 SI1NFDRvzd77wleZjRFDqzV8bz1fg/U4UGNrF6gu7NC85vZM3JYmZ7zg0YwJ4qbeTyyw
 Owzw==
X-Gm-Message-State: AOJu0YwDCP7vSAfWVk/+1EmzbdlpNdFUx/wMkaI6Rv9EIbtVwKk9B+hR
 kxCK1GFTs4PmiUUzZH+KqZ5MlP62DCPYgt4ecvxCRojXVkUuXepLBBamYZCX2TK6G98ztU8ucGg
 Umuq8PF33IrsVrkWCEL+B5StXZqqw2hMR0GY=
X-Google-Smtp-Source: AGHT+IF1V2mg+okVrdZoSfmrnfvy2UBew+mJqj9dDuJio8VviwGOwx9etbDFD72fReidT+U9uP2GxgxYTZeommSCnS0=
X-Received: by 2002:a67:ee12:0:b0:472:e6df:27a0 with SMTP id
 f18-20020a67ee12000000b00472e6df27a0mr7478432vsp.33.1709853618256; Thu, 07
 Mar 2024 15:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-6-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240303130122.29983-6-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 7 Mar 2024 15:20:05 -0800
Message-ID: <CANV2PTOCK--hOr_HbbjHcjYT40fVm5DD2GsfV3cZu2XFm7WX=Q@mail.gmail.com>
Subject: Re: [RFC 5/5] doc: describe Milk-V Mars board
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sun, Mar 3, 2024 at 5:02=E2=80=AFAM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
...

> +The board provides the DIP switches MSEL[1:0] to select the boot device
> out of
> +SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the D=
IP
> +switches MSEL[1:0] to 10.
>

This does not match the [Milk-V Mars vendor documentation](
https://milkv.io/docs/mars/getting-started/bootloader). Maybe you have a
different board revision?
