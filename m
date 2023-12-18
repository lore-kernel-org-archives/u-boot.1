Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9592C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:54:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA0287DD0;
	Mon, 18 Dec 2023 14:54:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OesBIe6o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5A187DD0; Mon, 18 Dec 2023 14:54:49 +0100 (CET)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D9187E23
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:54:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rfried.dev@gmail.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-590bb31ccf5so2390539eaf.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702907686; x=1703512486; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHXdqXWizK2NzGBbhWfsWlxZtiOM9CipfRsYjvx/yoc=;
 b=OesBIe6o88q2MdabsIxKPJTmFhZCswkoNPLgg84HiRKxzRNOu5+q0K5dPURCVrfHb8
 +T+I+1//AZ1s3hGwoELEtYCUB16bj88GMTMk0lcbKBKbO013BzS5bF47FGksuSj/+0Dr
 4PWDF8Mro07ULhO2vFVWfMpJ5vH0TGXP2bktDKrXvgYwnik7yNSMaCeDxqw84c/LvcIS
 A4uHLA0Your4AskJ3ysxvF8X9EIcq7lmeakCO79zNk77QkD5C8PBPg6CpOpY5/n+lJBR
 XwZLKaZ0uC66s8hFuAp7WfzsVpgeiPkLqSbyJfzbMbOgKzwDZla5atxLEWqYYKQf1Fl3
 zgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702907686; x=1703512486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHXdqXWizK2NzGBbhWfsWlxZtiOM9CipfRsYjvx/yoc=;
 b=M5AF/BliHS348MR9ZNMtQXUi7dHwmZ/pznqa57HyvgsLNB9ymFHxZCR+wmNPOCKULp
 MMvSvLBnTKhLheCIAwiMfzBTm6My0U9B3MZR7Tnb1tvZaC01NxMon7errI2H0Pku/fbJ
 jylHbYmCqVBEFGbwKiK5pezw5f1iEZyHcSgplviBR9mVik71b7sAYpW0yHpq0l5LNJyd
 cdHetYbn/oYfEvB6nuflf7955FtmQkcl2YLwLpHlpjibtc4AUt4ijuW8SzL2kHXcJ/wQ
 AXun6ieHj0ebUbDnJHch20D4y9Boz5H2177yd6phjF2fVkFfG4jN+fi9qL2RJXqwszLE
 m2mA==
X-Gm-Message-State: AOJu0Ywk8EGYt1FSkg1RiWikhUWdzXCv025hlPvvI7pWmwTt1rAe94Ll
 ehPEwpgzfT0f6SOJT86Y1djLquaHuIy610VGoX8=
X-Google-Smtp-Source: AGHT+IH4bTLSq/CyTFROTCNIhenO/onhbYvo8OcSVv0pYeaP9ICPLiGMod/ZXSf2eN6oUDUoWTURETmapTCQuPoxG5A=
X-Received: by 2002:a4a:b005:0:b0:590:aaff:e4a5 with SMTP id
 f5-20020a4ab005000000b00590aaffe4a5mr11045870oon.19.1702907685931; Mon, 18
 Dec 2023 05:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20231213211125.279880-1-marex@denx.de>
 <20231213230622.GT2513409@bill-the-cat>
In-Reply-To: <20231213230622.GT2513409@bill-the-cat>
From: Ramon Fried <rfried.dev@gmail.com>
Date: Mon, 18 Dec 2023 15:54:35 +0200
Message-ID: <CAGi-RUJGLxQ2aT4rQidE=SnK4o2CrXQFHPs5ChF9aQYO0b6yrQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: wget: Support non-default HTTP port
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Duncan Hare <DuncanCHare@yahoo.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>
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

On Thu, Dec 14, 2023 at 1:06=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Wed, Dec 13, 2023 at 10:11:13PM +0100, Marek Vasut wrote:
>
> > Currently the wget command is hard wired to HTTP port 80. This is
> > inconvenient, as it is extremely easy to start trivial HTTP server
> > as an unprivileged user using e.g. python http module to serve the
> > files, but such a server has to run on one of the higher ports:
> > "
> > $ python3 -m http.server -d $(pwd) 8080
> > "
> >
> > Make it possible to configure HTTP server port the same way it is
> > possible to configure TFTP server port, using environment variable
> > 'httpdstp' (similar to 'tftpdstp'). Retain port 80 as the default
> > fallback port. This way, users can start their own trivial server
> > and conveniently download whatever files they need into U-Boot.
> >
> > Signed-off-by: Marek Vasut <marex@denx.de>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom
Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
