Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BAAF94CA2
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8DF83936;
	Wed, 22 Apr 2026 04:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DhG9cGoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B8E84178; Wed, 22 Apr 2026 04:27:37 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 629A78352B
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 04:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6715006f4f7so7486763a12.2
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 19:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776824855; cv=none;
 d=google.com; s=arc-20240605;
 b=A4cy3UfXSQiNb4dwqKW6SuIvXb4dGDDLdLIqDZEjKW3OJP3CHC+ZbXCrqHsyqFkZeg
 6MPO4eBdYsYLKDLTFUDGHW0Uh8Y4yW7KW+EqBr+acGUdWwHalGJXjqH1I2ABWxqWSwce
 Zl8Gl+a8LtIoIogl5thXHU2NpvLHKpSq3CpUd0sCciu1leWeHyp1mfI/I1zjRiOOinJQ
 XAGsAhfjU0d0D7T8khxq3VRSt9/a6v2+PPRj6gG0BwDTEliBA8zZmgrPWQ0+MiEkcDkZ
 P+FMNnzRfTE50Tn0vLphQxP9kQ7/49BlS1B8MjCeFQJXO6X/qBNo3vhqnMENiGFGRGp/
 4pyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z0Pd0iC3XCvI5eX1cSQpveVG4Kr6VzGeamjFfs8Paoo=;
 fh=FtggQZS5X6Y4wmUTLZUukG9OHVO6b/7WDdh1D7q/tV0=;
 b=LdexipyRZM7EH7nMkHhhq2nH/fnKxSFAIKxYBBDbbO5nk5Fht21vzIF920oRykEfmN
 U5/V4jQFa/6SmMsad010sBU3s+FPLjOYsKiNOxKDlVvXsLbLN2l8Xldtb/4ikZbgl6no
 FUp1zb7ek4sJcVNEtm8ZvGcR2bVj+SDEA+O37arV9RusY88Zs0vSjrHBvHXvE5eQFHX+
 kHoR2cvsSUquSU8+wUZ64caOz7y/qn9aUnGCgsyo7ufxZWXIr5PEeLq9OPC+gFvCzJzW
 +BxKuAy7q2GdcIGfy4gy67UEmf1gD3/Wjk71AtYEzO+lSM4ZwFMPWOWDRl24GVHpVoVr
 H7tw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776824855; x=1777429655; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0Pd0iC3XCvI5eX1cSQpveVG4Kr6VzGeamjFfs8Paoo=;
 b=DhG9cGoXoVQ3E+JvsJVuOi4P1Q7yIPhtFlwvao106sC0FAHY1BsOqm7S3Srq01i7aa
 eyhX9VNFEsUfarAVJQA5n0rd5gExYb6LdrUIMi4ox6j0hWGT5R3f3X3TJIWnhsL9ebGT
 1/asaRpSOvYm0Jb0M83KR8RaJhidN/4U30bJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776824855; x=1777429655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z0Pd0iC3XCvI5eX1cSQpveVG4Kr6VzGeamjFfs8Paoo=;
 b=MVdw9s2hUJNLgpHl4l7NuKZ0fN+p7g6jQIgW2mplfuBNkRuPGPvVylDwUNC37apNqj
 CUyaxxaIYPIUJ/wnWzsO8tToXOSU7QkTriJgy3uMgictac1/476Aopgz8ydLO7Rd1eae
 Je1lVtfI5PSx7YgSvQ+01FqwB3xuaLIGp+zOocfonNTphCnOloFNHWYD4ZR3cQ37er9u
 SVxfaVJYN7Imh1CuaFNYPFin6t9wMcvXI22r1r9o9xGQaPFjEiKhsT9lbR57fux2DJ11
 TpwsPU/VnACibYnFdLiuH1IlK9i7wi4oWFpOZ8Bz8Q+QyXmGxW35QyzWsEgKdNRfAdOg
 2EEg==
X-Gm-Message-State: AOJu0YwBEnc02MnC/Qdlg586mXjFtUWfLgFzijC24ipbu0uAXAjZcClo
 CbVKFdwH519vrka0rKSYQpSdonFM1ifwH3jM+RXaK4yueQFb1IrTp2R3vcF6VoCDTca/+ZokLZI
 AvumT9ThDlyb8/8YrQ24PJUvaQlhTSxKBKNLmiYZC
X-Gm-Gg: AeBDietenzEDEQ0TfGlnyLTaJC+GXQM7eCzNGHB/9bWtcY4avBWTNGKZiUQRsauav+P
 OB1C9D8claJprj8qSGziEQ02Fi+TG4EhKCg7uwRIxyvZs1MOTyXulwRA9I07RChkm0swEomft7w
 QnQbEIUtXJLxPZB12f2gUpC4dSt+xEhupH1z7C4vy/8++KdidHkv3CeSF7vKpbDMLPJy5UcdSSk
 cDh1w72o0EkL+T0SAHlwTI6s36hzpkIvLanFVrBmNkOf3+S1y/wW/xDVY7FNxY8wuFotu7S7LKT
 WHmW2lwkXyBNt6o0phA3
X-Received: by 2002:a17:907:2d8f:b0:ba5:f23e:70e2 with SMTP id
 a640c23a62f3a-ba5f24dcdb0mr654868166b.44.1776824854727; Tue, 21 Apr 2026
 19:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260318132400.1856600-1-sjg@chromium.org>
 <4a2c3823-c5ae-4e97-ade1-d54ebb29751c@gmx.de>
In-Reply-To: <4a2c3823-c5ae-4e97-ade1-d54ebb29751c@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 14:27:22 +1200
X-Gm-Features: AQROBzAp1oazmFKFoGbdJLJU-LWw7g9y1PgFsPfoF2Ubz8njfFMAy4_F85l5wh0
Message-ID: <CAFLszThSoVPOjiFiuLL51pwmDOJwH+CsJuiYpG4rk1O3OGbBcQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Auto-generate binman entry and bintool documentation
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, Yannic Moog <y.moog@phytec.de>
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

Hi Heinrich,

On Fri, 17 Apr 2026 at 17:37, Heinrich Schuchardt <xypron.glpk@gmx.de> wrot=
e:
>
> On 3/18/26 14:23, Simon Glass wrote:
> > The entries.rst and bintools.rst files are currently generated manually
> > by running 'binman entry-docs' and 'binman bintool-docs', then committe=
d
> > to the repo. This means the docs drift out of date when docstrings are
> > updated but the RST files are not regenerated.
> >
> > This series provides a Sphinx extension to generate the file. This
> > approach keeps the docs in sync with the source. It also avoids
> > importing binman modules so as to remain compatible with readthedocs.io
> >
> >
> > Simon Glass (2):
> >    binman: Add Sphinx extension to auto-generate entry and bintool docs
> >    binman: Remove pre-generated entries.rst and bintools.rst
> >
> >   doc/.gitignore                   |    2 +
> >   doc/conf.py                      |    3 +-
> >   doc/develop/package/bintools.rst |    1 -
> >   doc/develop/package/entries.rst  |    1 -
> >   doc/sphinx/binman_docs.py        |  207 ++
> >   tools/binman/binman.rst          |   12 +-
> >   tools/binman/bintools.rst        |  249 ---
> >   tools/binman/entries.rst         | 3129 -----------------------------=
-
> >   8 files changed, 215 insertions(+), 3389 deletions(-)
> >   delete mode 120000 doc/develop/package/bintools.rst
> >   delete mode 120000 doc/develop/package/entries.rst
> >   create mode 100644 doc/sphinx/binman_docs.py
> >   delete mode 100644 tools/binman/bintools.rst
> >   delete mode 100644 tools/binman/entries.rst
> >
>
> Hello Simon,
>
> When applying the series I saw that generated documentation is missing fo=
r:
>
> Bintool: p11_kit: p11-kit =E2=80=93 support tool for pkcs#11 libraries
> Bintool: pkcs11_tool: pkcs11-tool =E2=80=93 support tool for managing pkc=
s#11 tokens
> Bintool: softhsm2_util: SoftHSMv2 =E2=80=93 support tool for libsofthsm2
>
> It would be great if in a future patch you could add the missing
> docstrings for these.

OK I sent a small series for this.

Regards,
Simon
