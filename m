Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1CECCF9F0
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 01:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EB6A83893;
	Fri, 31 Oct 2025 02:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A6qz426p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1099E838AE; Fri, 31 Oct 2025 02:49:28 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D99A8331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 02:49:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59052926cf9so2094986e87.1
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761875365; x=1762480165; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFrVq9fJ5F4EWTWElF/nn3I5FKS2n1IuixumzAloWFY=;
 b=A6qz426pSWAPswgEAHU1g9UoIRn+AUxtCjeXYtMGMCFxJlvEaxyKuphgC/pr/zORjN
 SGzH6NyoxG1bXH5/1kwecFNKqRfsB5yBqVRWAVMc07Lmli5JBuT/uUx5IGdrulOSiEHR
 LvpT4a2eet+9vWVkD+t/hwgCoUhunVKjIfCHI8DSTi2sFFZuGa/lRxl/A4FnvOda0agj
 JJC037YNMOM4bxzTsLKRBXRT7A8Xe1oXl6LqQpNtG4YCCdNEZkvy4KOocnzHTYa4ZTAC
 EdPBxO6m3FqrWzBD3ACVgpNkgv1QMrJYhFGWVPpqaaXTiG/sLkbIjHgmtK5SsP96HZEV
 7s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761875365; x=1762480165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFrVq9fJ5F4EWTWElF/nn3I5FKS2n1IuixumzAloWFY=;
 b=gSU4+bVt9OHAvCldLO3K8XOqBD9HqmhmHGFsMhCgIOiU2BrYpLRMa3PxI8UAVOiyC0
 yCw3pG14k6IQVpAszjTgLX5o2F+b2JQS1Y4q11J7BtcpKboA0Ic8jXVGXqUac2y/chUO
 gIfuDt5AjHGnOWU5IFQhBg1nLAQOW/F3xA/b00W2yE1fHMJLovfKau8cpHauBgGgUdbW
 qptlQ/4NMahs0Ar5/perwJg02TCOXCT8V0+84WEpQGnuLokzNeqnQjquam33rOJjAWQC
 0bJ/+XUz38Lumx+nLCC8lAEniKdrLdixktCvEGhU7sVaKs2YMgy05b5n9MBvFhC0W+ub
 KKuw==
X-Gm-Message-State: AOJu0Yw8BlL+HvXCsuNrwkInq1dIPrFZEDr+AqwtZlcrAbqjzrTx/V9d
 UwYdM8D13BehxAUT4weg0V8yLiSJnLPDz0zF+rv9qF6L1B+ilpLxXAeg2tDSjHYfwIV/GGC9WQV
 EAhdN2etD+ZB0yvld/Gmxu8kOSpVsnoXdNhDF
X-Gm-Gg: ASbGncsxmXdKBILA6VmvnSXfTU7fQtR900SAfUyC06tEvJWyKeibTp5yFobKs0u1b9c
 QMTfnT/9eNELsXBS3p551Jq6l9Ws+g6NRJ0J9GrkBfbvdD96tEH5KIYjT8AJEKVvhK0FAGAvV4s
 FIfh5aEsZXUFpMlgyannScLCBGZ+OqpFswPl2U0z062io/KvSQ0a6ZALXx2sb3pYCAiAT4MNbGS
 W+KVyc3lqxNGTrcDjlqxpDXzEn+S7YFA1c79UWGjMj6fibnJi+Zn/uuCAvg4p5BiUmAG2FORw==
X-Google-Smtp-Source: AGHT+IFq1bM62l7u+1V9o1u3fqoMOZOn4RD1ufqvsfhp7IwODIHIUTFKBJPPqF9nR8LImgbmUdwOrRsb4H7RGI0LVxE=
X-Received: by 2002:a05:6512:39cb:b0:591:ed45:b6cf with SMTP id
 2adb3069b0e04-5941d573e27mr707077e87.51.1761875365215; Thu, 30 Oct 2025
 18:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20251023084759.2113493-1-ravi@prevas.dk>
In-Reply-To: <20251023084759.2113493-1-ravi@prevas.dk>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 30 Oct 2025 22:49:14 -0300
X-Gm-Features: AWmQ_bkaOd3av1ZwN89YYgRpQm07dyosLhHibso7VLaHZfL2nqXDBZysX7SX95I
Message-ID: <CAOMZO5De6xDPOK_njTuFggrh5kDYHmBBqLYD0NR=46Eg_M-b+w@mail.gmail.com>
Subject: Re: [PATCH] liebherr: btt: shrink spl_board_init
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, Oct 23, 2025 at 5:48=E2=80=AFAM Rasmus Villemoes <ravi@prevas.dk> w=
rote:
>
> This board is very tight on space in SPL; in fact with my compiler it
> ends up just exactly on the wrong side:
>
> spl/u-boot-spl.bin exceeds file size limit:
>   limit:  0xa000 bytes
>   actual: 0xa014 bytes
>   excess: 0x14 bytes
>
> The repeated "lookup and request" pattern in spl_board_init() suggests
> a low-hanging fruit for reducing the code size. This reduces the
> object size of spl/board/liebherr/btt/btt.o by 300 bytes.
>
> I've left the lack of error handling as-is; there isn't really
> anything to do if it fails, so I suppose the printfs are the best that
> can be done.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
> Compile-tested only. Stumbled on this while investigating why another pat=
ch failed CI.

Applied, thanks.
