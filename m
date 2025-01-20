Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DFBC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56F6A801CF;
	Mon, 20 Jan 2025 14:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lwxcsa0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49D1A80711; Mon, 20 Jan 2025 14:47:21 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B15680077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-304d760f118so37985341fa.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737380838; x=1737985638; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKZyRdRaODKVZ/QOeIvPa3On5YDgP43nWJ0DMOHzTk4=;
 b=lwxcsa0jyDOZycv0ANAc9Sn13CgIXC4TqI/8B5HfY7JL3S9y2UhxD8G887pTaViLpm
 YyKkzgkvOUVximJ11N2ezLjZQ/XLpszmktHVOye81dooCgJzN9oI4vsj0kUXjn8QajCG
 hpCVK56OLCloUkiOC+7nKwY/pTvjZkfufgW62FdoJBELZI7evsRF9zNrZHq9aJDoJ+m1
 NqXrR6vxockt94gwBw7ufpcCZtFI/flATP92iDfL2yxNnfwlV+I+aRh14hH9PsQwBinD
 j+IlwOxjLfKaQBOwZ9NBc6LrpV9pG2viyiryAtakvK5bgiTH7+oBTRY837YpmUCSjzOF
 RSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737380838; x=1737985638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RKZyRdRaODKVZ/QOeIvPa3On5YDgP43nWJ0DMOHzTk4=;
 b=oDrGJrOfqa204ktgTvBwc8Y8YxcLGIoQZ4bPTr7Pjy5bn7e/Qwbes3piXpJFIgL4vq
 MyWyywYriGS4Qy85qN3wljVkDkzSaLLZxo4dNTA58jB1qKD5Y1BTzmnn6MkcOmqd0fxf
 8PH5IQsRJGyvvDYUpSZzPcOlcc/SO+ih74a4EW1gmfwMFifDhxTSy2XTeHlr5NobbYQv
 BOg2IxQmppfMulME+Uism35M21kugR6biMBEMpPWwwuMn64DDpVj0V7Q/EZ7wH8fc45U
 NRyNrTiloJlAheIccxsvvoK7gDlCYikNP/nAL94IWlOWqxt/Tx0DVrgiO+GoDZP3Yi+F
 Ol5w==
X-Gm-Message-State: AOJu0Yzyg+FRKJN8V+THgTSQnU5Cxgu6W11naVfEpNRn3kaqwYDY7oPM
 EnpXYmxkLwwVUykyUVQUj4BhBiEKC2PtB828HPbw9MyOREYCofcASavcwh+uOqscQPyhDo268IP
 4Wp+jA8g5kVqp2AED++IWFTttOp4=
X-Gm-Gg: ASbGnct5HJExeZrjQzU1ihYLSY5eZgEE57h7nrx/dTdshb0mF118Ndh+b3Z/pKHyUAi
 O0xa/neiHUhV3MFpBg3GQZCjA6z58NQkMI0XTPwMhzo5wAgnSNHH1oEpl2QdyJzYBMYeQOejx6e
 S3X8QV+Bg=
X-Google-Smtp-Source: AGHT+IHHwoMjmPkU8gbmha5GXy4QISOq3htMECDYi27CmXnRSTG28eVY6Q9/QzOQ9jv+mVlw8tMTfRVy8gUGKXGpyuk=
X-Received: by 2002:a2e:a9a6:0:b0:300:324e:3504 with SMTP id
 38308e7fff4ca-3072cb665camr49235201fa.27.1737380838405; Mon, 20 Jan 2025
 05:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20250117030048.3874426-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20250117030048.3874426-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Jan 2025 10:47:06 -0300
X-Gm-Features: AbW1kvYDAu8rcmepWUibnszjEKe5IwjTms9aCSujBMtGJzclutdch04y_c8e3F0
Message-ID: <CAOMZO5Bc0ZXeV4aOqO-GdpBZ-o1fWNy=kHiCNEtZcZWvnM71EA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: imx: Fix NULL dereference in imx_pinctrl_probe()
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tim Harvey <tharvey@gateworks.com>
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

On Fri, Jan 17, 2025 at 12:01=E2=80=AFAM Jesse Taube <mr.bossman075@gmail.c=
om> wrote:
>
> When converting to ofnode `ofnode_read_u32` was accedentally used to
> replace `fdtdec_get_int` instead of `ofnode_read_u32_default`.
> Use `ofnode_read_u32_default` to fix this.
>
> Fixes: 59382d2 ("pinctrl: imx: Convert to use livetree API for fdt access=
")
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>

Applied, thanks.
