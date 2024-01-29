Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C47E2C47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:17:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2563587C37;
	Mon, 29 Jan 2024 13:17:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I57hpcZt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0238287C37; Mon, 29 Jan 2024 13:17:21 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D99FA876F8
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:17:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5ff9adbf216so23665337b3.1
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 04:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1706530637; x=1707135437;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsobToVkkbljQ7jlOpvRZyKl+ILr/09B2VG29VUTmzo=;
 b=I57hpcZtUIP5ozNpMh0umVZvvgTqXesesex3pohOUGe3RMHGPMKeCjJq2N47HiVhSv
 HeRL2G9PJE/ubMwAIIQfRHOMS73k9gnmgWFIOwobEYMlVF8Zm5lyyLCi2hmV8B9iJtw2
 pLNyuBAQBgaZreGGQKEtZq9VmvSMaQpBVo3v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706530637; x=1707135437;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsobToVkkbljQ7jlOpvRZyKl+ILr/09B2VG29VUTmzo=;
 b=ojueFjS4wXl5G/nkTR6vook0RkXBJmlDrJnD1M8xtKN0LfMAteh7tQb21PuJ08UY7F
 qAfHM5i1gjETS9BRLYCTkmLUdNgFq1UBEMmKh2x/Us1QlnZ3sbaePYC0SxtrxPLZfAYE
 tAamogHYxpyHviZ5UhNuTNRLFIDTvzUk8GvMhO+qjDULrXlIQZPtW3F890ShXF8VDzK9
 YO7j0NmznIDSufzW3UIhAIb7oFPAaaQ1wqaFU9weyZp232bWteoHQwRAZpXv1MC+Mkng
 yUaE8Dv3pHOyo/MuMdVwjx9NaFd1/k4E8CTFo54AhSOoKwQEtx5VubWfXhF5NUvUsCnd
 4fFw==
X-Gm-Message-State: AOJu0YxfCBWeqkYUAXxOB8EAD1jyrgtVw3nH7Pm5pxlFh19NC3AzcJAd
 BfxxHxz9PRzF6pi0/eBJBOHU6HwcEO5R0p0rADfcchLMX77Kd59D2Mck/a49yISmm5pJzKaRvHX
 yi5EarqsQpAquYzsE0EObBd41FlJ4LOt83OezuA==
X-Google-Smtp-Source: AGHT+IHsYOhLjSyc5iWUdZa2D+r2I3JcA7S1qw52/Y3Zg+k9qsM1yUjTUYUGI85ux28FI0nsBQbWiUdYZgnJH+1OQgM=
X-Received: by 2002:a05:690c:d1d:b0:5ff:9089:7d19 with SMTP id
 cn29-20020a05690c0d1d00b005ff90897d19mr6481619ywb.66.1706530637638; Mon, 29
 Jan 2024 04:17:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1703220284.git.Takahiro.Kuwano@infineon.com>
 <4a6603f5d4221788f27b21f2de9ede6728b082cc.1703220284.git.Takahiro.Kuwano@infineon.com>
In-Reply-To: <4a6603f5d4221788f27b21f2de9ede6728b082cc.1703220284.git.Takahiro.Kuwano@infineon.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 29 Jan 2024 17:47:06 +0530
Message-ID: <CAMty3ZB7zUGR7dXdih_sOqRhPe7A2GcSgHSiomhPMnXowMKowA@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] mtd: spi-nor-core: Consolidate post_bfpt_fixup()
 for Infineon(Cypress) S25 and S28
To: tkuw584924@gmail.com
Cc: u-boot@lists.denx.de, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, d-gole@ti.com, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
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

On Fri, Dec 22, 2023 at 11:16=E2=80=AFAM <tkuw584924@gmail.com> wrote:
>
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>
> s28hx_t_post_bfpt_fixup() fixes erase opcode, erase size, and page size.
> s25_post_bfpt_fixup() is doing same thing including multi-die support.
> We can consolidate s28hx_t_post_bfpt_fixup() and s25_post_bfpt_fixup()
> into one named s25_s28_post_bfpt_fixup().
>
> In s25_s28_post_bfpt_fixup(), set_4byte() is called to force the device t=
o
> be 4-byte addressing mode. In S28HS02GT datasheet, the B7 opcode is missi=
ng
> but it works actually (confirmed).
>
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> ---

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
