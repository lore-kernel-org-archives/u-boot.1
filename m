Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C80DC25B78
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 02:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB2B988260;
	Wed,  5 Jun 2024 04:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jXrxeAG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 149D18833D; Wed,  5 Jun 2024 04:13:53 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA2C58812B
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 04:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6ae1059a62fso10361676d6.1
 for <u-boot@lists.denx.de>; Tue, 04 Jun 2024 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1717553629; x=1718158429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zHeesC36WWjTXVKygD9+DNdKQmI+GXix5+QjhXhWIuc=;
 b=jXrxeAG9FOa+XcpBdJ2bNWrx0QXLPs35jRYCzIuA/dgD3NAxkf5bBYf8FYzuIQEEM6
 s0ovSV5vHR+txaNaT8vtFIIpD07I/E4obQjbRiifieTKLAArx+AbGz+AcRLqBxKHBXm4
 t7PIwfvRD14skFrrLTyMLilgdDAvT3k+78qjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717553629; x=1718158429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zHeesC36WWjTXVKygD9+DNdKQmI+GXix5+QjhXhWIuc=;
 b=oizTJMQ1RcDPEXBxcCX69sI0T28CzEsByzV6RdCEmt+A2HD7LCxM9J0yOTErkE38L7
 WQJy+suhcAVxi9BQHcawiUto5vMyscfgTouBGn7LzdD9yBMr0S7vzactGyFeoI/qKlqs
 WiH1I9u6W+7+QFfmT4GXpSSB+dmZdYpIOWjuqTlHsP5MCgffaHtXtUVNhl/f+2YMmkXV
 ulai8nBk5GJFvOFaxR7Frx0CizKAW3B7Vtz38v7F04u/ncTuxDn8Bp3TnssH8t97TyKn
 iFq/eSa4uW+G/y9fh7BIj35UESHcAHxU2kqV7bLX4wPstxdqpvAAALxbHXXRc9/YHiBo
 tAUg==
X-Gm-Message-State: AOJu0YwxH8pv4+3o8D1s5uEKTM/qUadF/aVGV868f9PuJ/9JY3SU1HeM
 gHYAT6q8c5DdJRoFSvfdNI1D8mqMzPt5wvvEpgR1f+9BWsba2yjvcKhvjK6dwjTq6uxRyNgtedE
 a/rjWYkJSWD4Fwp2Z0GL1KBU0RKQ+3XZ7ii73
X-Google-Smtp-Source: AGHT+IEKfLeF9ROYmUpSPsBjMgO3SsCIE0q4KVG10Pul9pQeIcwx8+H7iG1TvBJwYTrQuCo64YctGcj4id+VlSesn6k=
X-Received: by 2002:a0c:f888:0:b0:6b0:4197:47c0 with SMTP id
 6a1803df08f44-6b041974809mr3166916d6.35.1717553629544; Tue, 04 Jun 2024
 19:13:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240604161607.1133032-1-brandon.maier@collins.com>
In-Reply-To: <20240604161607.1133032-1-brandon.maier@collins.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Jun 2024 20:13:38 -0600
Message-ID: <CAFLszTg-z4TgQ1Y9hjsOhGsKczJ_A9_0j4Cm73e69Bvnu1jZKA@mail.gmail.com>
Subject: Re: [PATCH 1/3] tools: binman: fix deprecated Python unittest methods
To: Brandon Maier <brandon.maier@collins.com>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>
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

On Tue, 4 Jun 2024 at 10:16, Brandon Maier <brandon.maier@collins.com> wrote:
>
> The methods `unittest.assertEquals()` and
> `unittest.assertRegexpMatches()` are marked deprecated[1].
>
> In Python 3.12 these aliases have been removed, so do a sed to replace
> them with their new names.
>
> [1] https://docs.python.org/3.11/library/unittest.html#deprecated-aliases
>
> Signed-off-by: Brandon Maier <brandon.maier@collins.com>
> CC: Simon Glass <sjg@chromium.org>
> CC: Alper Nebi Yasak <alpernebiyasak@gmail.com>
> ---
>  tools/binman/entry_test.py  |  6 +--
>  tools/binman/fdt_test.py    | 48 ++++++++++++------------
>  tools/binman/ftest.py       | 42 ++++++++++-----------
>  tools/buildman/func_test.py | 74 ++++++++++++++++++-------------------
>  tools/buildman/test.py      |  2 +-
>  5 files changed, 86 insertions(+), 86 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
