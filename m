Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D015AC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:55:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEFDA864D2;
	Mon, 28 Aug 2023 19:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Tg0Y2TLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F20E8651A; Mon, 28 Aug 2023 19:55:23 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCF2086430
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:55:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d78328bc2abso3201251276.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1693245316; x=1693850116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeqPrmF8bg1raYp5i/j8h4Cysb5rVEtXXShei8+RXlw=;
 b=Tg0Y2TLcZ/P/z1UvyqxZHov4LHR0VxmHFAtXinuwbVSNeN9HxjJ8BHqhNx1i1NRz6K
 jmS5LbTA5YAyVdNdV1cCmPYohCwiW1EEoblyrhExFgrDOVYE4glLsifteheAKKWzMTri
 rY7g5MtYLxlkXObrfFv2ABU8XQ3HehDHun8Qf5uwiP2aTzVgIOHe8e5dTBS/Vw2oaHQZ
 vY24CpjLMZ09uw+I+frU4v58KGlF8w8AhIGFkCM4fdbjrWUkPQrr2VdD3oqTjdUB1Vu/
 R0H8394STAF2Wf8E+X7XjAJ3OM9y85HYQDyZa2G6AyUS/m55ZI6jsaUB7zRFxCh5LsOX
 gKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693245316; x=1693850116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AeqPrmF8bg1raYp5i/j8h4Cysb5rVEtXXShei8+RXlw=;
 b=AojVDROHGTITUrE59yi33qlEbZiltKS0dtY+i56V9L79M5rUdpgO+Fb2zs2BMwpSIH
 zL5rkNOS7xhnR6PfQ5VP/r9NumAsS3Q1ZLXgkXdOJdAB70onE9LYS7LO9MQ6tEWTDHAs
 rTfcRaPaLM78oPztDJwu2X7r51bL/DjhcBd8DECFEBVfqbDlFcVE6IwBQxtkvuitpjbe
 5/9DMlNf0SMm5ViFMdtwGfHZi2b3Zv20NdIHBNXoRn3ZaMbmfBBa89u23PvH6GRaGslg
 ZAg6wTFDtbm7xiSAqxvyeNIq2BsCNhh2a9XVsDxrIexZceysYv6N6n3NQnUrruycxVY6
 CE7A==
X-Gm-Message-State: AOJu0Yzcb+yWYPBrie5o3KGIWPLfUaFV9Q0vzIDf1reOpE/acKqojgLO
 0bJIl1S02KsIcVauJn6z3DkkqNGvuptIbAVEXd2LgQ==
X-Google-Smtp-Source: AGHT+IHpxz+lgmO1tnBeHFSwzgIlwPk0LwBmAbfJk1AF6r02sy5RS6Y+jP7e182aYDQkBLL9t0cb0mcwbKxwm+mUIjI=
X-Received: by 2002:a25:dfcf:0:b0:d78:133e:9ab4 with SMTP id
 w198-20020a25dfcf000000b00d78133e9ab4mr12220267ybg.58.1693245316363; Mon, 28
 Aug 2023 10:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230824061040eucas1p1a8c8b4bb5cd362d73806ac8d40613a9d@eucas1p1.samsung.com>
 <20230824061025.664682-1-l.stelmach@samsung.com>
In-Reply-To: <20230824061025.664682-1-l.stelmach@samsung.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 28 Aug 2023 11:54:53 -0600
Message-ID: <CAPnjgZ2=UCyyK2QSzVzo5m0eo72Q1A=i1pYdny3OpsQ6Xak5bQ@mail.gmail.com>
Subject: Re: [PATCH] setexpr: Silence some diagnostic messages
To: =?UTF-8?Q?=C5=81ukasz_Stelmach?= <l.stelmach@samsung.com>
Cc: u-boot@lists.denx.de, Marek Szyprowski <m.szyprowski@samsung.com>
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

On Thu, 24 Aug 2023 at 06:51, =C5=81ukasz Stelmach <l.stelmach@samsung.com>=
 wrote:
>
> Neither successful match nor lack thereof should be considered an
> extraordinary situation. Thus, neither require printing a message.
>
> Signed-off-by: =C5=81ukasz Stelmach <l.stelmach@samsung.com>
> ---
>  cmd/setexpr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
