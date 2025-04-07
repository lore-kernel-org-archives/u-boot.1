Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688CBC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B57E8309A;
	Mon,  7 Apr 2025 22:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a5xG96Mm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA55830AF; Mon,  7 Apr 2025 22:03:23 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 661B68309A
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5499e3ec54dso5827481e87.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 13:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744056200; x=1744661000; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NFAr+YN+yF/tFCGcm9NMHavn5okW03SqW6w98hQHS1s=;
 b=a5xG96Mm3Vd1wW0mwzakPe/O5CLuzR/kfOdZMha+e/ixy0LkXfBNb7Gfh5ygHsiZI4
 NXVNAJwskvhFuKjhRx4AxbIDS6V2taITirVQq+/9pFK9gek91oCSWhVkiH5R/sl7gzNx
 gciwJJopbmxp6w2lXRi4mIYgPvtHZrs33gb/0qNdX9Cjwa/f85a3caUyv2mSEMA5Rwib
 NShjaUZ+efGS3aic5f0ETMsT3HrkBXtTkaAKiQkUSW1csWlbHLY93QODT/5manH+yp5n
 sxeoXVCVB5WdLdkq1kubVBHLADdZV2gMWOL65oLxVCcyJ63oAgZIjt0vJS/o+IsnqPDn
 Cntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744056200; x=1744661000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NFAr+YN+yF/tFCGcm9NMHavn5okW03SqW6w98hQHS1s=;
 b=hoTVmW7BplsVcdUI7Quu0NS38U33DpAXjRU90UlIgcvttOat4DokCuExRrl1vFgu4D
 Y8/LObjTMY5rk1eaRYDDx0qbV+ErRHX2WClRCHN9UfjKaN4YivkSLi1AC1tABHgLWtCc
 K3OBddrJRgxdL1SaGbUU+wdk9UBhmL/rDVwHoh82nylm2PdAs+NLhD2WmW02ii5XSJkt
 ZpXtlXfrmNRVYOK9+WUQE4IhWRWruyDWIIJt1vljtdNbBmPIA1CkhvCCtvcfEG4kQrx0
 cuCXEy4PqyUpswHAdkGw2LWBFbdfHaf+/sjiLhir0s5kitQ4MhSyE4D9O6RRnN+nWkBa
 v9cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW3BTQaBQ6t9vi13HzHoMpBH7VYpehtt6YID84pPBQFhZRj4/LsX4LAj8OAqsFLG0DzEIznNE=@lists.denx.de
X-Gm-Message-State: AOJu0YzqkPvtBnvVMhdKJZ1Ts00fPxx5Dj7X//bMzvQiweocf4TW33gJ
 HDjGywroMPamj1VhS1dRguZebkTIgepLYCR/UxUq12DuPKP03o76leQcLs7HCZHc9n0316DpKPm
 pYDhzZjoSRUMn9DBuyI7ATP682y4=
X-Gm-Gg: ASbGncsvgKeCme/Au7YObwnqdUAk2WEE5Mm/CfbilUX7ksjkRVkzofIAtAMeu1CPrQf
 pqvx68V6BWIrSRnxaoEVC/mgYIzRyinBqgaZLOgLyV/GOMk/+T4NPblDIGSZPazmg+AThFQAZwT
 SQlsswQ3m95nG4HCoe+8+XlmULeyQLwpR8DxT8Bz6t1AFMlLJuvWepJSyKn37H1E/siqmB
X-Google-Smtp-Source: AGHT+IEZ37ouTVKJWiKKUYNzFkQzupFtxom9khz+3FtXNJjqyiXXORMTwjKq4CQlvR5TM7p5qvWJlaKNmvHHKrhGNak=
X-Received: by 2002:a05:6512:3d8f:b0:545:eef:83f1 with SMTP id
 2adb3069b0e04-54c232de762mr4227275e87.17.1744056199480; Mon, 07 Apr 2025
 13:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250315092420.793-1-ansuelsmth@gmail.com>
 <67f42db9.050a0220.16b640.abd2@mx.google.com>
 <CAOf5uwkU_hTEa_D+pEouXmsiQYMTNkHdr+z0boVO43BW7wkA7g@mail.gmail.com>
In-Reply-To: <CAOf5uwkU_hTEa_D+pEouXmsiQYMTNkHdr+z0boVO43BW7wkA7g@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Apr 2025 17:03:08 -0300
X-Gm-Features: ATxdqUFSSYSnzHlbdodk86NnUN_ytVY7Megyq62B53NPh4g2G4xUyr0VJ2mkjsQ
Message-ID: <CAOMZO5BFntJ4kFFrtrFRL77RsM18LtjJDv1kHWSZViZMW1m3XQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] clk: fix crash on clk_set_rate clean rate cache
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Tero Kristo <t-kristo@ti.com>, u-boot@lists.denx.de
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

On Mon, Apr 7, 2025 at 4:58=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:

> Can you review it and pick if needed?

This is not assigned to me in patchwork as it is not i.MX related.

Someone else needs to handle it.
