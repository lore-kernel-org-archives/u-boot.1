Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC26DE6C5E4
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 00:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4A3895AF;
	Tue,  3 Dec 2024 01:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UxlMIt3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E52F895B1; Tue,  3 Dec 2024 01:22:59 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30CA789288
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 01:22:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa51b8c5f4dso707161966b.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 16:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733185377; x=1733790177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+OTsSeDeyrEkOs9n+nUpbUpkm2O0pjEeItKvcVHrMp4=;
 b=UxlMIt3HKVlkgStHMQrSGxZkQYWE2q/fCxH+YLnAG4V4YaLYZhbKAQkOt/h0QoEGXe
 BgZ5N0/Y7p9cRzIWd/hOzgHnVVoywGB5tlTFTD4cIGvAC28y2totwRj8Vqy70acPWb9u
 rlbvRpgwNGjBNmWoJhNOvLZHuH1MhPIUIVHSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733185377; x=1733790177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+OTsSeDeyrEkOs9n+nUpbUpkm2O0pjEeItKvcVHrMp4=;
 b=tcSn9unBohmVzULdQGOq7IcEPy5Zn/igmSV2nGaLmHDrwwxHBkA8rvXcZgJDBq1vzq
 NxWV05i98G+aMIVjKxvpcRHQAYKXBXk9ruzbsbFC+mS43ub6NQcTzrU2RuwAUkUkNe8z
 ovTPEfgmkg4gj/j3kzzd4/w27+WC43BlZIVnqeRpGMg8SMcksyAB/6vL4STJzxKAE0OT
 CcbCDWz+tyJx7uj+LNUlqt+WLpB4AKvUHEj4H5xdtiLk5a2D45l8mOi91zPUuIucafEq
 Kjh1oD+zf+Ijdz+EYw7/QEKLFOCfGQJ432TWJfYpbCKwcLgqKmCc+Z6zZu2pKDjw/Tg1
 WhQw==
X-Gm-Message-State: AOJu0YwirxBpKgaQSw+IWpAIqYlMZcjJuClIslkg4fdqT4OPUD/8XpML
 h0TmrIVWCpRhwQLprZsClsria8oSwmlfLJCZLwL5NPP1nVaINqfbJkzpHMVcs2Ij8k6PfY8f1Mp
 6aJIP3V9Dco/OCNsw6ZE4MDnl/UaymzAsponm
X-Gm-Gg: ASbGncts/tafV0XWO/QEqeVFEuq/BSO/NpEAOTRo90N7YwhA2a7Kq/uT8+V8FiHkleJ
 +jiIyHvjE5PdiMKbEDtpK/tj0H+myn/ym
X-Google-Smtp-Source: AGHT+IEpJabBxq709o1cm7dlrSQC11SjtxHL8vJxTZBkYcdplwC/bEKrcp/3HsJarBxuDTeSLA6pXCDO98moWZavdZc=
X-Received: by 2002:a17:906:3150:b0:a77:c30c:341 with SMTP id
 a640c23a62f3a-aa5f7ab6bc2mr18104766b.0.1733185376771; Mon, 02 Dec 2024
 16:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
 <20241202201832.GH2457179@bill-the-cat>
In-Reply-To: <20241202201832.GH2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 2 Dec 2024 17:22:44 -0700
Message-ID: <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Mon, 2 Dec 2024 at 13:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:
>
> > Some functions are passing addresses instead of pointers to the
> > efi_add_memory_map() function. This confusion is understandable since
> > the function arguments indicate an address.
> >
> > Make a note of the 8 places where there are problems, which would break
> > usage in sandbox tests.
> >
> > Future work will resolve these problems.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Please just resolve these rather than introducing a patch to then fix
> them later. This is something that should have been fixup'd before
> posting. Thanks.

That was deliberate, as I wanted people to see the problems. It will
save discussion on later patches where the problems are fixed, if we
can agree that these are actual problems. If people are happy to add
review tags to the later patches then I'm happy to redo it.

Regards,
Simon
