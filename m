Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E9CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D51D68814B;
	Mon, 15 Apr 2024 14:36:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KwS2oKgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27DF688137; Mon, 15 Apr 2024 14:36:05 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B4F8814B
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:36:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2a532498cc5so1170432a91.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713184561; x=1713789361; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BLLyqMj5mE6AgLtpIYUMxwbfLtGhJhHH/7L3PxptP+Q=;
 b=KwS2oKgzCAmS7Xnp+9iJRzBAhnSqkVbkyNglVUV5skj1C44geBCij/HmW/4LD3Tmc5
 CnIloEKjoCZhV7WiTHLkHowfPkz4RKRMT1UoYiu7/0hCJfQ5/PMnO3mDXnjzLrbpPuuG
 vTlHk0/1GZfm5f1ordoLovyO4+PDAZFocCzLOmPpfTqOUTfKYrzvt75KUQ8XnTfCHApc
 PjqYxtYAQeYGfa0G6m8gx3MhDR7GtlL7TOVTC/ijIhxmp0Puu1nELd3tuTqma2ih77+F
 aX2/43Lg79tpSRSuTUahMcyG3OT1IDnBf0+SPmHsBwDEcc475SWzLe+3kJVaRj3yYlRs
 e7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713184561; x=1713789361;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BLLyqMj5mE6AgLtpIYUMxwbfLtGhJhHH/7L3PxptP+Q=;
 b=InmBsE7bQ+tFsvjhCelpa5TCa8VzKZXx0cjf767Eu7XOFf8Q8P/KU6x87Tvj9A8Mit
 ipN0nq0ixuCm5kc3m4dxw8FrO4QL/bHXBh/n1tXqf94OliejR/7xFaRB+ztK2a3ScNOX
 Dj84OuY75X767YLB+ff2L07BMjifdnkWSAnplYKmUWf1C1hWwP3zoMQlm+IUVI4/FNoN
 sgEyGa/Y2qW2mLasFvU+5aiqtXeOWvjfKQK/RRQwLeTuSNKx5c5PF50T3VKuUIISXnmO
 nVcanFKTASfBeGcBRJPn4xq6489S0csOU03pNt+4zVgqUa9F0dNWtgfu8UOaWV5W+Wvi
 Q7MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOJSdVRXCpA0/4RLCYQcysRxrymSZvpYNc46IJ2k2w+lqJwbYM+lln69AZNr8D5/EkyPoPJWYB4793sHkCLeAsAtlrIw==
X-Gm-Message-State: AOJu0YypRegQ7+E4oaXyL/mKdT8SCaA6/KpaXdZy7viCoEaOWUx0Yae2
 l/KyQi+tFqxKZVaRq8aNvK17w0XKMpaVweZ30A7PLDLeHndx0CRCpTxU60jZPJ+WYzZDM36LVIm
 itPwv8bFZE7jRlMncIO4ViZpKqWA=
X-Google-Smtp-Source: AGHT+IFCyD11ltKe2k/P8HVj9wBkrPBTNiAjCDtWUtsnrAtamueiLOkIWFagpz3z/IlD0Yo4KjChAD72ilCM+qObsIo=
X-Received: by 2002:a17:90b:4b47:b0:2a6:d7ac:24dd with SMTP id
 mi7-20020a17090b4b4700b002a6d7ac24ddmr8585211pjb.1.1713184561414; Mon, 15 Apr
 2024 05:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
 <CAOMZO5B6PCqU8G5EXDG+41T7nVmJqFPgwEVfZvpYmryACRFmyg@mail.gmail.com>
In-Reply-To: <CAOMZO5B6PCqU8G5EXDG+41T7nVmJqFPgwEVfZvpYmryACRFmyg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Apr 2024 09:35:50 -0300
Message-ID: <CAOMZO5ASD3HuvUMXc6tmStE1AKRheW_NLUjRfpN5HuJ64ZF-Cg@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] imx93: Conver to OF_UPSTREAM
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Yannic Moog <y.moog@phytec.de>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Wadim Egorov <w.egorov@phytec.de>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, PHYTEC upstream <upstream@lists.phytec.de>
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

Hi Peng,

On Fri, Apr 12, 2024 at 10:40=E2=80=AFAM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> On Fri, Apr 12, 2024 at 10:24=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp=
.com> wrote:
> >
> > A few nodes were added to soc and board u-boot.dtsi(lpi2c, usbotg), tho=
se nodes
> > could be dropped after upstream linux supports them.
> >
> > To support OF_UPSTREAM, a few driver changes are included.
> > For TMU, still use U-Boot node, I will prepare a kernel update,
> > then back to U-Boot support.
> >
> >  Mathieu: please help test the boards you maintain when you have time.
>
> The series looks good.
>
> I will apply it after Mathieu or the Phytec folks confirm this series
> does not break imx93-phyboard-segin.

I applied patches 1 to 4, thanks.

I dropped the last OF_UPSTREAM patch as it is causing boot issues on
Mathieu's tests.
