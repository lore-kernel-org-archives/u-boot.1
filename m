Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1E6C83F3D
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 388ED86590;
	Thu, 31 Aug 2023 21:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XdI/QW5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D11888659F; Thu, 31 Aug 2023 21:21:34 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4A1D8656C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:21:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmcosta944@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bc63e0d8cdso21063211fa.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693509691; x=1694114491; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g/qk3/5w5iCZPb5hAaS+b05yrGFtM++vNauoKj78TkQ=;
 b=XdI/QW5lyZUImc8rCCGpdOAqFu++5ruMH+5lA1iPq9sc27VDgLFycKr5X8W7RUfxE1
 2WrTB1/e+ndrQlVnmVkgeciB3KRkvrGou5Y/XVkPTCRVvUTQKTwRCu0j0uh26041o9DN
 6RUy4b2VEkEzZy2Pvg4vK1xPEtB69xCsi1G9ySm/hLg6NZIs01CALPyQuRhJA41UnD7G
 tX7uNayoKpi+mR3RGk9Gf+cdcVC2Ex1kvffpIq2B7i9fnMQqHuYCG/m5U1sPda1L1PMN
 LOXYkJJjjpfbnvNeF1IqceaxqC2td2ESX7joTLOfTSFl9XU5edw85oSBAzXdPSq40izJ
 OEyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693509691; x=1694114491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/qk3/5w5iCZPb5hAaS+b05yrGFtM++vNauoKj78TkQ=;
 b=ey/WdaE0jOLvY70ZABh3iocf6niwFvHjeL0I5cdR2WyGvNqnIT0m1vMLXlXPmSyGZk
 bfwZdwtEUKksJo+rFhHm2wq36uezP+9V95Q/krrTdbFb2b0sAuE8TPvXo7FIYUbh0Tdx
 A7YNARzHanmPnMEfXkf7Pbev0EeCvAjlQj/UmirN9gQtfgnwgf9EGUmOLctFpOhzmiY5
 EnwTbEXjGJdOOviQViw2asnm+ePD/9u4cKXbaSkDMIHSNccSg97VHnC6nY7fQSRCJRZw
 OskMBwv2Fv7qc7GU+GbmqM6/PgFdWK+Zj/gaZQouO8qVlH0XvVOqA5bKUguoXzpHpD5Q
 Pc9g==
X-Gm-Message-State: AOJu0YxV4jDRwYzvNo9tKjLNfHYZBL4eHDOZJRxeP350LP/eH0JmgZ2q
 Xwpy4K8p/OTgh1dWFmwTqbQ58wyEJwy3WHWKZVA=
X-Google-Smtp-Source: AGHT+IExE0Tp1bOomgvVxLojBVWgIj7m7HiWXIUOWimzKlK6yzgCpJ0025y+oQmZ3cPIxBUGAI5fTv1K9G7ogygx5pk=
X-Received: by 2002:a19:6452:0:b0:4fb:8eec:ce49 with SMTP id
 b18-20020a196452000000b004fb8eecce49mr100933lfj.31.1693509690908; Thu, 31 Aug
 2023 12:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230820190412.21266-1-jmcosta944@gmail.com>
 <CAPnjgZ1c12NPKPgrYMY69181_nKtzas6hy4Q15u8knL8b_a=Hw@mail.gmail.com>
In-Reply-To: <CAPnjgZ1c12NPKPgrYMY69181_nKtzas6hy4Q15u8knL8b_a=Hw@mail.gmail.com>
From: =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <jmcosta944@gmail.com>
Date: Thu, 31 Aug 2023 21:21:19 +0200
Message-ID: <CABfBAmB6-_+mdvL285prf6oKEFX8=EUS3ZLtyj=7Ducc0wcyKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Port gen_compile_commands.py from Linux to U-Boot
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, antoningodard@pm.me
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

Hello Simon,

Em seg., 21 de ago. de 2023 =C3=A0s 21:13, Simon Glass <sjg@chromium.org>
escreveu:

> Hi Joao,
>
> Can you also please bring over the documentation for this feature?
>

Actually, I couldn't find any documentation per se (e.g. in
linux/Documentation) besides what
is already documented in the actual code, as in the help message,
docstrings, and comments.

Would you have any suggestions?

--=20
Atenciosamente,
Jo=C3=A3o Marcos Costa

www.linkedin.com/in/jmarcoscosta/
https://github.com/jmarcoscosta
