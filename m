Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825A4FEFB6D
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 16:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03F383E96;
	Fri, 27 Feb 2026 17:18:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZ9IIX0Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B3FE83EB3; Fri, 27 Feb 2026 17:18:01 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D31883D1A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 17:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-65f71ed7c6cso4047781a12.0
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 08:17:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772209078; cv=none;
 d=google.com; s=arc-20240605;
 b=KE6cquaWAQkykhd9vV/v48Skwxsgp0MHxLwlauTAr2IY9nPrRwaUwibkscOSsg2G+c
 g0ccaHZ3lAfjKXrScLLY9YybXsY4Qnqpko3LMNOf+NZNIwpkTPkcJsIDAqgdsbzeJCMZ
 2Cc+QlWpD4AO2yjbqDrvPB0p367jhaTpYBc5pmdyo561LJ5Yeuk3JBXo8bHKxzDvl1Jx
 6WLhXvEsVN1mUjBdG32FpCD9s+kxJSHFijZLdZsu/mcFqmBO1f+bAVH0gPjPeI7qeb5Y
 Es/ERbT0gvWW6tX6xriMxiUP4qP52eEM7J6xG+GPY+ObTlOsbMbVVkDKo8jNI5uTQ9uV
 n6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9E43+iAtf/At7aVSs3d4vH+h81hofeUaMUKXnXDEYSY=;
 fh=LclY4ejrLzs8JlJ1qvDXbouoyshlGcwAUgubiLx2wNY=;
 b=Zvk+ZISNKIJ0xvklc83uOcH+MVEJFvHdVoeqER3jpA6r4wp+3tYG0slpIRqCJIX3g3
 ha+NrlTQLPvWCp27p/0yxma2ql/frp7yd4MbipvITodJOUXXwEQTiEnozEXXlr1eE2Ld
 0RyUY6aIvzEo7Ps5XF4uP868hxgE+mTKT50/vM9Jx5kh+vVFsXs00M6fEm4z8+a+CWSv
 IPL5SMB0jxP64DoLm0hweZ/0mA9TDLvqKJz7zdsYMriw47146/xQnel4Fyxh7NCSITcn
 h/rxN38BNAT47H2S93RLHEeWuajbwYDm7G/3RW6ZZu/5dLC/r4yjKZePFZKGvqKIsqbf
 HMLw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772209078; x=1772813878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9E43+iAtf/At7aVSs3d4vH+h81hofeUaMUKXnXDEYSY=;
 b=gZ9IIX0YBLnWORhDDC1dpVtw0vBi3iRD9DDuj77ErJ8S5AiToQ/5FFx3BmqaEtIlOS
 bkMYWqwQcXBcgQGggvQN/hQXhKKWDL0IQY+JkCTphbBz3qEXu4RYVZ1zbbeJSzGp6oL0
 Fek6/jBVOvEXZtEVVK7QfYokDAcOFCug1PK1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772209078; x=1772813878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9E43+iAtf/At7aVSs3d4vH+h81hofeUaMUKXnXDEYSY=;
 b=WOf9NY3hW24NEwBp4fUiIGEPk6vK9JUtNIMwmVE10KYVIumQMSps2feVPV/sUlV+U/
 E5KzKwBNLpANIUPgRJxtlz8/6/dn3PYAzLvO3hU4QiYczL83juM/rtqyMQuOlpCWX5h0
 hsqVTK/H4jlwxrn9RBztE16aHIUJoYbijA8jwLSaRIxG962piwS2HFasQcg21g4ARu3j
 mYcUxwox2Ak7IGiJ7mRqLBkWeEgJ3ESpLYi2PZQVX/EbRHzga45X4qFuAEfy4OBw6rky
 p0vb6WzDE3zT/7krvxUeEqv4Ch3fsN23eI6/KOmI69TTZVAGzYOxmAvXVRNjhgQmp9d6
 b6sA==
X-Gm-Message-State: AOJu0YyEcKyCkuzsNgxXsIhWX+PCROmkSuh9mYKbbzm/Wr2r1I4SLHUr
 4apndUtIAA/gmam6qDLZAJ1CDjY3O2aZ/jxNRXVujVw+Esf9nFsUT3FjsyMqqhmA7VmdDEP5D+N
 fmOBdablwaoOx8TaKTRwyJYthyIhR4Xkw8VojkKfX
X-Gm-Gg: ATEYQzxp87T0Mn9YhN9jlaFY3DEdY7YY8UsDV7EmTvAjO3+HtbABj61J++PJQBPobd/
 kzvf0mBW63WBGd+LsxbCoiSlQSZFIKtW0JgdIRJM75EJeGIm0+H2FdANy6BOj+sbtU4n0luM7TC
 TuXGhPYkJ3f//Qi9JIg5hPVtJgw0yeYodiO++zXQ03gXkeWkavRFjUHizOfzjTt4yhB0fROi7Zd
 DyZQIGsMuRjr3Zis7oZsUPuj44cFnkABx8q0PeQliAZSvddJvr6Hj0UScV6wjb1EeVvI7zb2cAS
 bkVPQw==
X-Received: by 2002:a05:6402:f23:b0:65f:730d:8026 with SMTP id
 4fb4d7f45d1cf-65fdd6d76efmr1515577a12.9.1772209077743; Fri, 27 Feb 2026
 08:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20260226234802.345968-1-sjg@chromium.org>
 <20260226235102.GO1593142@bill-the-cat>
In-Reply-To: <20260226235102.GO1593142@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Feb 2026 09:17:46 -0700
X-Gm-Features: AaiRm53mg_HQTV1ULMQUeQ9bD0SByoE-xlNkmFmVDMefmhaB42iFnAWgr9ow8Dk
Message-ID: <CAFLszTi6HyLAh1J79suitFKTU0L7QRHjHWr4K4VmwZ9L1=PGzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] binman: test: Organise test files into
 subdirectories
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Michal Simek <michal.simek@amd.com>, Moteen Shah <m-shah@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 26 Feb 2026 at 16:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Feb 26, 2026 at 04:47:40PM -0700, Simon Glass wrote:
>
> > From: Simon Glass <simon.glass@canonical.com>
> >
> > There are about 350 numbered .dts test files in tools/binman/test/ and
> > we sometimes have trouble with numbers being reused.
> >
> > As an alternative approach, this series moves the files into thematic
> > subdirectories, without the numeric prefixes. This means it's no-longer
> > possible to simply type a three-digit number to get the right file, but
> > the names are shorter so it is still easy enough.
> >
> > The subdirectories chosen are: blob, capsule, cbfs, cros, entry, fdt,
> > fip, fit, mkimage, pack, security, symbols, vendor, x86, and xpl.
>
> This seems much more maintainable, thank you.

Yes, I hope so. I could perhaps do a series to split ftest.py along
the same lines, but let's see how this one pans out.

Regards,
Simon
