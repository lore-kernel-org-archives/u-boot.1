Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADC9C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BDD3829E7;
	Sat, 10 May 2025 13:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T6jlwVCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0AB08210D; Sat, 10 May 2025 13:25:28 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10F5829E7
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fbda5a8561so4244151a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876326; x=1747481126; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PXQOZ7ZYJ08cCenMjqXqNgn5K5TcSqtop2OIsv01ezo=;
 b=T6jlwVCRZu0Tbq85cIBgD3wp8KUwP7Z88BYZDlC/rNsEe0ElTqbFZIfHNLSBNBYSBK
 7gFdM36jGBa/jK4V28YTXZpZOD0iONGmU3ppC5NPQxiv8Y/0/Ulj47t/uscHHU6BB2nJ
 6g6o0LwHvoPa2gIYPvyJTALB2VDfQgaOn4zu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876326; x=1747481126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PXQOZ7ZYJ08cCenMjqXqNgn5K5TcSqtop2OIsv01ezo=;
 b=Q+Qmj3ihs3OpzsEiee9Vk/o3aU1GoKrak06QOCbmYLjjgiwW36XGk6Om1tAqkebLhR
 zcDkZHCddYCXRnlZotVR5FFLv5MuQ9PodHwvt+O9dn7dZRClbsVsQjO9g9c5rk8mvTU4
 45zLDlwtDXN9Zkmv4N/P7QQ94Apt40xuwQpXh1TffUuIEngY/ejCtZR7QoaonS5rrN1C
 ni/ISQseX9hATfmE0rDemy6xxr/HTkHK7UYLXAOR+eKwwSwnmrEbv0En6GQaY1SbxYCA
 bA+XMqZvP4P48gW3nU11b/Gc+oZ4ehwR5N31oQfxXtY5MPgplGjnIGE9T+70LEeZM4gB
 WQlA==
X-Gm-Message-State: AOJu0YwxIdMmyvI0NpkjGxUKkL5NOfF1m2H0vNsD7PK+1G47qP5x+3Re
 j00Ca/CTrGTRBjCx59wOBi+DVwQn5ZlSDby+f9StdBe70meXdAUZ5HLd8dwqmsKx5h2a8ujPYwG
 jFqqURAVs8UrKq25S/XlD2Gf1zZ3UahV4mAqUFgtvaUX2lw9cMaT3J9vusw==
X-Gm-Gg: ASbGncsOpDehDp6+0XCZSQlW5StbduWzrUDxanJksw9xd1GXmAPObsyeVLgWoFRXdFi
 Q1Fr17jJeZqDovKfJD5onv7Rjx/v/t9tsQ9hvyiOGY6Q5gmYYb1acUsW8e9cceKUociymDvG3x6
 dLIBXEzDEzu4PlHnjtswmQRFl2iyEPmf9YXA==
X-Google-Smtp-Source: AGHT+IHczNffCuEWKAxh9Eh/F8eksT2WboEXeYRZrYWIhBtQ8N+FmyvCjSzwCKmYijl7ElFNP1zflTskwo/cYAU2ywg=
X-Received: by 2002:a05:6402:2355:b0:5fc:8d3f:1e5 with SMTP id
 4fb4d7f45d1cf-5fca07eb591mr5008409a12.21.1746876326468; Sat, 10 May 2025
 04:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250225205003.2640910-1-trini@konsulko.com>
 <20250507221112.518041-1-trini@konsulko.com>
 <20250507221112.518041-2-trini@konsulko.com>
In-Reply-To: <20250507221112.518041-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:12 +0200
X-Gm-Features: AX0GCFv3mcCG7nCj0_0cxLYWDoO20dlH9AXSmlSJKoW-kGfiRQceOIULmwxzjMc
Message-ID: <CAFLszTgUrQMwdChpYtgJnFmgYgc4n+s2qPVUaX9qbtavLa2OaQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] doc: Start improving our pytest documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 00:11, Tom Rini <trini@konsulko.com> wrote:
>
> Begin the work of documenting all of our pytests. To do this, we should
> have a directory under develop for it as there will be a large number of
> new files. As the current document is referenced externally in a number
> of locations, add the sphinx_reredirects module so that we can redirect
> from the old location to the new.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/conf.py                                      |  8 +++++++-
>  doc/develop/ci_testing.rst                       |  2 +-
>  doc/develop/index.rst                            |  2 +-
>  doc/develop/pytest/index.rst                     | 12 ++++++++++++
>  doc/develop/{py_testing.rst => pytest/usage.rst} |  2 +-
>  doc/develop/testing.rst                          |  4 ++--
>  doc/develop/tests_writing.rst                    |  2 +-
>  doc/sphinx/requirements.txt                      |  1 +
>  8 files changed, 26 insertions(+), 7 deletions(-)
>  create mode 100644 doc/develop/pytest/index.rst
>  rename doc/develop/{py_testing.rst => pytest/usage.rst} (99%)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
