Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17333CF34AC
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 19:42:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 958BF83F26;
	Wed, 19 Nov 2025 20:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WnzeczYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A10583DA6; Wed, 19 Nov 2025 18:26:26 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F71983923
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59428d2d975so7580798e87.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763573184; x=1764177984; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YJOo0wURLyJ9NiAg5ezGB8FSaSHHERhgrk+H3bBHi8A=;
 b=WnzeczYAF+m0K6SxYmfkKpFFQIDoJFVdz2wx11rctC1PyJMcXA/ZUwQhzVq5u7PFak
 wtKsjcOFhWUcPWNxtPansbhMicFV21DtJ7bS8j5JtaSD5dVvTVp9jnBo/1e2GG5g3S9X
 HZW0JCcF6WLyVKYXXsXYfs+BPea6HImSRXuuhizm/pj0tco034x7fXgnf9BIcfa4RFAc
 xaiw7rCw0Q1HwSDqLv+BDkZsaI5CYdiHx2TO154D7+QwTZBM6RnYElvy4B36qbBhar7g
 dZbgC9kpAWkgTE8kiAT6thwNpdkdHZ3JiS5cvdrlXUjoLpyENdGGC4gX4ys078yk/LUE
 ZKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573184; x=1764177984;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YJOo0wURLyJ9NiAg5ezGB8FSaSHHERhgrk+H3bBHi8A=;
 b=hzOVHjikvccamAs2yCeqJlrUhQfstQ/3aZGmlMkfa1O1TInXZOfOyKMR0qWJbz1Wso
 KbyZ+WB8gmYmwhdQIom72AuRfO/1zIJB4Gj2No90ZQRKwrYzTgWHAyA0AuVn9VtmUlCS
 LKrK3DG/00bAJCDF/KTBr86ezajhzBT15gEovLNOD80FN7rK76OiGfhSgifwTSdEzCHZ
 FJRNQAC/08mF5MuMfPUZ/CNmXdSLW7UrMCfPhvT/xMVg0PZ8W/E1fNUapqmt6hhP4WvT
 dtVx100gl5BaSQy0dwLWDYZLgOVfNEvy0Id1PS2sKG10EwPFH6H51i7ibNDzvbB8g8Qh
 fLaw==
X-Gm-Message-State: AOJu0YxkO7oNQeJIaUt3L2CpIZnj+z+s/tMN1rZjDCryoaaan1kX6/ug
 JC9jP68yb3j2cqxKWpAfDhlEj/MCSqorT2RVQfVYHgDY/8BWrc13OSD7zrfdnJYqRdvHL7ULDas
 1LybfOV6jOS1yYXXfcF2jE17LhYQMWT+IOJhibKmcvQ==
X-Gm-Gg: ASbGncv458FxoFkH/nXEnmbNdXr+YKoX0S93/7z7TbZYQzLoCIO7gzCYfwqgC/75fhM
 g5VUtxOoWMko6GiSuXo/awMsDT1Mf5LasbManQ4/Bn+V8T/JqCaYzEvUHVCzCOlfROcWssmUCsK
 cziaEBRoKHRpjm2LlqF1ODX5gj8qY5c7nRB4IdCTnyQMdkYfXjbAkQcFNAs9BDTNi2KEJglPpxP
 eh8gQLLvQvxihaJFW5uEnM2BiG/e5gFMUOQUh0QgZTPTXsl29zsdi89AvrIuhpVf+xFIjhrtabH
 KdwxgA==
X-Google-Smtp-Source: AGHT+IEVF2g7MiJ9uEfM55ERt1OYcfhfeiryS6sugrlBVqYaymESPsngQnOJkOc96yEVTZab/ZroxQ6w/c2er+tStyI=
X-Received: by 2002:a05:6512:3b0d:b0:594:314d:ac53 with SMTP id
 2adb3069b0e04-595841ba374mr7505894e87.23.1763573183766; Wed, 19 Nov 2025
 09:26:23 -0800 (PST)
MIME-Version: 1.0
References: <20251119145541.843466-1-trini@konsulko.com>
In-Reply-To: <20251119145541.843466-1-trini@konsulko.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Nov 2025 18:26:12 +0100
X-Gm-Features: AWmQ_bl_TbK-z17weYHpgMB49rGJclYnH55qFJzsMigm9Ig_Fg3-oxsvkIwNLoY
Message-ID: <CACRpkdbbnvS2A9CPEg76TZPEAMA4UK265-uHMZEBzubi_HybYw@mail.gmail.com>
Subject: Re: [PATCH] vexpress_aemv8: Stop disabling device tree relocation
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, David Feng <fenghua@phytium.com.cn>, 
 Peter Hoyes <Peter.Hoyes@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Nov 2025 20:42:17 +0100
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

On Wed, Nov 19, 2025 at 3:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> Remove setting of fdt_high to ~0, which disables device tree relocation,
> from the default environment. Doing so prevents U-Boot from correcting
> problems such as having an unaligned device tree and leads to various
> failure modes in the OS.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

(...)
> -               "    setenv fdt_high 0xffffffffffffffff;"               \

I have no idea why this is there, but Andre may know since he added
it, so paging him!

Yours,
Linus Walleij
