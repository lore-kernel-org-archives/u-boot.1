Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6197FC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 11:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F6B4878C8;
	Thu, 11 Jan 2024 12:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="auHD9cay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2078287A77; Thu, 11 Jan 2024 12:49:29 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A15F8786C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 12:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d9b760610bso542572b3a.1
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 03:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704973764; x=1705578564; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QPddMAAnYGvzP5vvcgnv9gTWNLEtCla6FSXu4IXlZrs=;
 b=auHD9cayfFg+Ht1rYAzY0zCYi1AaiqC/YknZAc/3kQiNlIFLmSx7V+qd3eTporRbEb
 g0JPuQfyYBUuT93Htb52kw9dYQnQ44ZZrkveSFTRGLVXlYZsoYrQ5OR+piBNqg0K233Y
 8tGn7HfCdNgY057qNq6rZhPDNlvUKrvfKZBQlmeojxvDXJgdMqN2i2fHC0f4+xA4FikK
 W8Hzi1dIBchwIudikL85juRWpXqHUPaYJ2E72mqecP5BiBo8AB8oWUc3rcmJK5wR9Lda
 PQl4zvSgYAuQ3gYylkSCvKeBU/iZcPFyAJXtTjAOJDzGqBJ2wKXx1QRIs/NPscVg6b9O
 IjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704973764; x=1705578564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QPddMAAnYGvzP5vvcgnv9gTWNLEtCla6FSXu4IXlZrs=;
 b=YckGO4Eft5UZlbaEvEP7+M+Iexjvv74DvddmuChMtTsfW0HH2gjcEv/qtmFmZnX1Os
 DAiAXD9nzJFLBSTg291dnSwdlCt+fGp9Fdt7O5YNVTXu50GdXfVodDCk3rM50iGZUTRi
 UbYMH7GLxvEJL9JFNmEfCq25eEWfDw17okoLFR5j9P9ejCHI7Q/AIiV09AIXiVuPasx+
 EZuyRGV0OO308jfMdJh2GGN6EGRlWJURsQvv5TsfobC+iXWocKYAk8Y3bpPfIMEiUZUs
 PE6KtUdvAqSiDk9uDPxjkBcaiflyOz6dfRg+9ehgUayibFaNjhmBWijMjYE3uo3UWwOe
 MHnw==
X-Gm-Message-State: AOJu0YyuNCg1HgAkLz8zoKG7ioEnk07kRNXspWNTAtnByeYZd9GGT4x+
 Cq8ntOWf5vuj4XXy6aVBZpg8qCFJ279Qq0BeaFA=
X-Google-Smtp-Source: AGHT+IHL0RiB7w63jEwpvOn7JB0kkMM6kkFwLJ58DS1ruwX/ixswV9D4Ws14pUUTJdEPUheF/nsl17eTlb6HThIa0vQ=
X-Received: by 2002:a05:6a20:1444:b0:19a:40f3:e460 with SMTP id
 a4-20020a056a20144400b0019a40f3e460mr1756457pzi.2.1704973763723; Thu, 11 Jan
 2024 03:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20240111110611.2051821-1-lukma@denx.de>
 <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
In-Reply-To: <CAOMZO5CtLSkRPb-3RvS77za-y5zwkBirH4gGE_kwqLNao9bdSg@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 11 Jan 2024 08:49:12 -0300
Message-ID: <CAOMZO5BgwgWPs2mn78bAC4uVQ9Dgm4mWcS5==EnRuZtOuQ6SwQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: xea: Move XEA's environment variables from
 xea.h to xea.env
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
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

On Thu, Jan 11, 2024 at 8:16=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Lukasz,
>
> On Thu, Jan 11, 2024 at 8:06=E2=80=AFAM Lukasz Majewski <lukma@denx.de> w=
rote:
>
> > +serverip=3D10.8.217.79
> > +nfs_serverip=3D10.8.218.113
> > +gatewayip=3D10.8.209.250
>
> These IP addresses should not be hardcoded here.
>
> They were not present in xea.h originally. Please remove them.

One more thing: xea.h had:
"dtbfile=3Dimx28-xea.dtb\0"

but  I don't see dtbfile declared inside the new xea.env.
