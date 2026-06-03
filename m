Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F80CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 20:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 680318467E;
	Wed,  3 Jun 2026 22:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V4rY3fSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 592388486B; Wed,  3 Jun 2026 18:25:30 +0200 (CEST)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079B38469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:25:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=compholio@gmail.com
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-963a997dea4so4438120241.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:25:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780503927; cv=none;
 d=google.com; s=arc-20240605;
 b=CVh8J0AzOEOEWun8QuA0Cj8Xv4mZMq930CAis9k6a1nyvDYV7diDI6Uv7W3qC7khYP
 g4ID9HBHfkmSs0G6APoL8smcIdiRpUCLmAbvSIv9Kqb1N/KPQ0wUs5onXyGvXwGhYCU6
 fMMn3KkAcNfPi5MJIdjq63oeSj/wBdP/tbOlPQyoz81MffUN4gmsTtTDoJMUm3/Re2m2
 niYI2+hQ5Z6lNoMV3K5B2fPx7tf4YBX6hadkIAMSOrlozTnWKouvTKPEs5LyoKNInUzI
 tbgy+e7rjhdJCqPYcx2dpODH95vPvubQybVH67wRJIzx3ert/MKgrVo27D0l0zV0gXWp
 f+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7OHo78BfFfKcRdGUopohbvY7kADr3107NzV6Fzob6j0=;
 fh=oc1K78mEQyzoqS6zkPeJ7dptk6HQ3hrenIqmrOeZVo0=;
 b=UDCoPE8FxIQPkPFEGB1yazleIc2WBGDVgiVdfFvFnwkKB8dp2Nt8NYX5sZq03sXcRz
 2uNpPbRenyf/IbVDT5G1os4Uh1SoJ0bFSZVqy0zuZHypSpZmYQ6JC1M0IPS18UScSNUs
 nujmaYOs25WagY5wPEPXiULiQGqX2jL8LnuSTP7GWN9iPT9ky1x21/u6h3q279JUcUv8
 /UDG+dZfmqHPD6e7Mxs3OXAmiKxTQqytYHik8D58Wkb0awic3i+1HwY1X/Y5YVhg0I7c
 tTo5jeBwWgOBRvE4bLnK7CW4BLAfV4pO/eK7Tez4Q6a0LxLlxxPIMyhGPHffQ6ltnbEd
 KQCQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780503927; x=1781108727; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7OHo78BfFfKcRdGUopohbvY7kADr3107NzV6Fzob6j0=;
 b=V4rY3fSFJmPN4vCZzMI+sqEWgQe4hJqQp3ud/3xRqY08vQ/VoXIpk1c9CvXMBjUl4m
 +MxTqYNiKeqAfZ2ZrxrU5lVeqeK8TUemI5JHkykfWPZD2x11U0DgM1uXocUFfMtFEyN2
 u3XxjmcSiO5FUoc0n+l2ZjMjUw07Ne6hm8RyOR2rFbiUHbjQjpLcDR/7AjkZebL1K/6P
 br/LRC9OQGDTYA9Xreo+Q/pepSTGuFL4Y+DrgAxDX9/uboae3Qjffj8SjV5X664STfxY
 JzovvYmrpyUzQ3NwJF3Rty6SQRAonsZnpaWZTi0aKh7u3rrBHpJj9aeOJN/fYHlMqeTW
 R5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503927; x=1781108727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7OHo78BfFfKcRdGUopohbvY7kADr3107NzV6Fzob6j0=;
 b=p1wtqOoozjH/BRpzgJROlI5tvWjqgeSiFRCBMXt6g3edrNzdy4dw4+8eA59Ekgh95e
 J48D7JqUuvxJK9RNP0+RAjM9tmH2NR5mNeaULeWINgwPqJmzSd1asWRWgmLScmyuOFIA
 4xHps3YCNa5sveZUo7iRJJ6eTngnzbQVXCFlTFD6GrDqpIccgdBt4ycrEOM/kLwdd8fD
 mmzuY5FdnogmA/3Yy8oBCuJAWOrA+/s5uIIm8BIq8KlxMjiLf5HppG7Lw5a1c/CIS+7T
 yU2qf7L8Xgd2blgI72lz+OP8CApbR73kOh4OBwn9iioO8Cta88GVJmQQdahwfImZv1XP
 D6Lg==
X-Gm-Message-State: AOJu0Yx8vOfcIgkZsE1qgdzL17ivjw3vY6NgtYFzOMHdG31d0PctQZZ9
 +QHhaD6iuLPruHbo7QCncYuscXh+ADP0h5dYEZacvYUtmfms9aHtk3qSH19vQYGqd+d0dcgM0FR
 Sw63wRjRJHoBI50owCOOUE1Dta9Hl8ww=
X-Gm-Gg: Acq92OG3GmJMNI0K0CdJfvYtWVDNGF8tOnX8ZnJCWJ70/FGCQe7YQrXXKA/XvLc+g7J
 kurO0BlQ6v9ILPGoGI2lr2PViR105E/blQJcaG54DZ2vHwmBFW5eS44KHeE8EnMOQtHWaIP1DpP
 cETmLbDMDIsVXm73BPol1NS+02Cku4dpFaZ2p6h/BwkmyFduUp0HIw9dbwlIL5OICFAXa3fpxLR
 QESE2hHjPmvPI/CAfWj/nWCDEoUU3MwmGBJRM3aj5t41H0/o6wIWRl/1dolAsY2P/IlpmeuE+mG
 V3CRCK09+GCYmlgQJJ4VA/ArDsWm
X-Received: by 2002:a05:6102:f0d:b0:631:7781:fe91 with SMTP id
 ada2fe7eead31-6ec2c0e304emr2348063137.9.1780503926696; Wed, 03 Jun 2026
 09:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
 <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
In-Reply-To: <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Date: Wed, 3 Jun 2026 10:25:15 -0600
X-Gm-Features: AVHnY4L52debahpbicg36_hkeUpHv736jVpLBLNbuQKryQAMyScEwpNhktAi5xE
Message-ID: <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
Subject: Re: mkimage: allow zynqmp to use a register initialization file
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>, 
 Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 03 Jun 2026 22:19:36 +0200
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

On Wed, Jun 3, 2026 at 9:55=E2=80=AFAM Sean Anderson <seanga2@gmail.com> wr=
ote:
> Please add a commit message.

My apologies to everyone.  The checkpatch.pl script caught that and,
since I changed the title a little, I accidentally uploaded the wrong
version.

> And isn't this already possible with -R ?

Yes, sort of, if you are using "zynqmpimage" instead of "zynqmpbif"
then you can add the register initialization with -R.  The patch
leverages that existing capability to add support for the "[init]"
attribute in the zynqmpbif backend:
https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/init

We are using this feature, in combination with other zynqmpbif options, lik=
e so:
=3D=3D=3D
image : {
        [init] fsbl.int
        [bootloader] fsbl.elf
        [pmufw_image] pmufw.elf
        [destination_cpu=3Dnone] fsbl.tcl
        [destination_cpu=3Da53-0, exception_level=3Del-3] bl31.elf
        [destination_cpu=3Da53-0, exception_level=3Del-2, load=3D0x08000000=
,
startup=3D0x08000000] u-boot.bin
}
=3D=3D=3D

Best,
Erich
