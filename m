Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43494C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 16:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E71287BA0;
	Fri, 15 Dec 2023 17:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M3YFfUeD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8841187B6E; Fri, 15 Dec 2023 17:20:54 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 729B987BA0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 17:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27fe16e8e02so103087a91.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 08:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702657250; x=1703262050; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ma5Orb5s25rHkXVUZNgzqyJhVyy1wJGFif0qGjZ8hXI=;
 b=M3YFfUeD3aIp1T3TSRNTA2EhKq+I7IKJzzfb3y79gs36Q+3FUDOZHnuGzC7snt18F6
 K816NVfat8pPqQyYf5WuFngbby9n8oGSculW0z6ytm06+8Ca52QMGC5vDL00J+YGPexO
 b0aHJ7ft8pc5sXDYaaiE1FyJXOAf45Y6OtgmGRMz/AYgl8Bz8mO0xyhqBe1n2UZ6PG3R
 WQbwZMEXt4NX+SDFzPlgDecrhTRj9hTe+3H8GgPf8/eVvZ7xPaIofKE3audA6ux2poPO
 YUkyUnTRaKLQCYlzJ5g+Dr5dLKKONr+f0+bcHi+B+8KMzHHTvb9u/yfQhZpPY5Cl+5EM
 QmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702657250; x=1703262050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ma5Orb5s25rHkXVUZNgzqyJhVyy1wJGFif0qGjZ8hXI=;
 b=jUu6RvVEbzqUciFDqwzAT1CvpY/HpF6WjjI9HpLGCp+InoqHM6hWvPwCuwduPFXvCU
 BznxYR08yv3i1ImczH/r9uN3ACEEWhi7CF4ZUzM9fALtA6ke4YNOjW9VztOgvpHJ2TQ6
 aSwrDhoZA8B3phlOvpC//MUvnYNKMCzBoU7tSMHm9Ax8xh2WLtrLYrvRMqU4mHdytsoc
 k9gihNC1fnFH/j9TM+hEMltLdUU2u/yhgH1IQdZs8R7ayvN10YQM9b3CEOwhBoY80zOd
 wyMjJZVmvlMtGpEHN165TpbIewdkg9q75mXHlKom0PxqvqTPtj+2sBfCBcexHSZnSgm9
 vhPA==
X-Gm-Message-State: AOJu0Yx44s2Tq66eXP1rrSr8vKej7YBACDAXyvwq2hD+797EjeY3z2gE
 pe86XervC3lkrGsgOYA+FhLlHv9d1plhYsCQVx8=
X-Google-Smtp-Source: AGHT+IFPtHWM//LEpRSTCGMELJx0rjXn+oztbfZizNBe6M5FyI1/0wC2zzGydfwqLBwLxcbTINgyM/N0qEL/0yDHhdc=
X-Received: by 2002:a17:90a:b286:b0:286:dfae:32f6 with SMTP id
 c6-20020a17090ab28600b00286dfae32f6mr19960005pjr.1.1702657249685; Fri, 15 Dec
 2023 08:20:49 -0800 (PST)
MIME-Version: 1.0
References: <20220830174932.96360-1-alan@londelec.com>
 <CAOMZO5BJyoxUTBuygdL7tOyzJfRGJT1BQHJ_r0qAD8jYfC+CbQ@mail.gmail.com>
 <20231009094924.56042353@wsk>
 <CAFQdmxK-TdWajPzZnCGGNr_rWKbNL=6gYfmDOKBRxGd9nrHK1A@mail.gmail.com>
In-Reply-To: <CAFQdmxK-TdWajPzZnCGGNr_rWKbNL=6gYfmDOKBRxGd9nrHK1A@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 15 Dec 2023 13:20:37 -0300
Message-ID: <CAOMZO5Di2RxqmrCW-OYt+b4g-823wrP0JF6Gkb3P7=gMb3kEwQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mxs: Don't enable 4P2 reg if mx28 is powered only
 from DCDC_BATT without 5V
To: Alan Kay <alan@londelec.com>
Cc: Lukasz Majewski <lukma@denx.de>, cody@londelec.com,
 Stefano Babic <sbabic@denx.de>, 
 Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
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

Hi Alan and Cody,

On Mon, Oct 9, 2023 at 9:45=E2=80=AFAM Alan Kay <alan@londelec.com> wrote:

> The patch:
> https://source.denx.de/u-boot/u-boot/-/commit/79230640cb4fb780e2be9bb9a47=
b31976b18cac4
> does fix the issue, please feel free to discard my patch, thank you.

Ok, what about the patch below?

https://patchwork.ozlabs.org/project/uboot/patch/20230703205700.9120-1-cody=
@londelec.com/

Is this still needed?
