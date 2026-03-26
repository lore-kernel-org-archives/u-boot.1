Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E499F10A3D80
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 12:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 962DE838BB;
	Thu, 26 Mar 2026 13:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TtZ8swj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85BC983CD3; Thu, 26 Mar 2026 13:18:59 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 377B981E18
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 13:18:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linusw@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7EA264425F
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD8CC2BCB5
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774527535;
 bh=HIUrLQKuXUz87aJ2RCdAPwzeOral2MaX3sd6kq80VeU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=TtZ8swj8CDGI4c9WClKIkiBGLcmfqItkpcRX9gpGj4nlzRXb37emwzteEtz8Pb9zG
 zYz2xDGsyW66fYc9T0QEzaDRhKG3vPz7YaF4DL87uqNNhgnSGjQ+vxF8wDLbz6PwmA
 K6q1q+fVbACoqm1JtYC7UlJPUUR0/5+ueEslofJ30BiidzqlQuRzi/7lNvwltd7BsP
 DmWge/rauvNuLm38Qju32mFW854k2NvqLv3UC1CHh24TswHNcRp9EU7u+X0Az39UrY
 MXLOJmul8IBHPShNfWLZhXVbe03bmWVnqLFydZww3cjHHEeOXQhPL4lULGRNW76Yo1
 2Yg4a3NV9xaDw==
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-79a8e873ca1so24718257b3.1
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 05:18:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQlHMO9IJrEj1y6RzZpBL+t55Dewo5AVP24hPsdF+hUF5UJUc8DAXkEIoxaNQeynZNd41b6o=@lists.denx.de
X-Gm-Message-State: AOJu0YxS2NvzNOpfOp2eHzFHcqQ7o7m4WRuZ01y0diY1BImZcwrgcLth
 IYcr58UCXQ4Q2ir3OmIKWKsycXy32ILhMnvO4P5defhP612gh2fpoXP8071QCBertNvVuzHqEi8
 /018phsM2+TmLF7mLn5lBk9HK5hK21q8=
X-Received: by 2002:a05:690c:260e:b0:79a:3470:3151 with SMTP id
 00721157ae682-79bd0276576mr10940717b3.31.1774527534682; Thu, 26 Mar 2026
 05:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774526652.git.dan.carpenter@linaro.org>
 <46f9b46210436e73d17a866424a00529439ce1ba.1774526652.git.dan.carpenter@linaro.org>
In-Reply-To: <46f9b46210436e73d17a866424a00529439ce1ba.1774526652.git.dan.carpenter@linaro.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Mar 2026 13:18:43 +0100
X-Gmail-Original-Message-ID: <CAD++jLmxKJ+nfOaPk-n0_9Hi82Hf6LpTAgzq+1MUN8V2or7pDg@mail.gmail.com>
X-Gm-Features: AQROBzC4CW51JFqSXDuCGtrxpNW6oAzclgU63UsS9ybuC13rPB4E9MTO2i3LDSU
Message-ID: <CAD++jLmxKJ+nfOaPk-n0_9Hi82Hf6LpTAgzq+1MUN8V2or7pDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: scmi: Use standard device tree pin muxing
 format
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Vincent Guittot <vincent.guittot@linaro.org>,
 Michal Simek <michal.simek@amd.com>, arm-scmi@vger.kernel.org
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

On Thu, Mar 26, 2026 at 1:08=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:

> In the original code, I wrote a custom pin muxing parser but the
> upstream device trees wouldn't accept something like that so it would
> have complicated mergine the device tree files.
>
> Use the standard device tree format with function and groups:
>
>         pinmux1: pinmux1 {
>                 function =3D "f_gpio1";
>                 groups =3D "grp_1", "grp_3";
>         };
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

I can't verify the code but the change I want is exactly this so:
Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
