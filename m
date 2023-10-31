Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9245C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 21:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB44B874EA;
	Tue, 31 Oct 2023 22:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KQKtxZHB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7681874EA; Tue, 31 Oct 2023 22:55:27 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9D7A871FB
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 22:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5a86b6391e9so60986137b3.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698789324; x=1699394124; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yE1pVR+bbzb1Uumh5ae6z7SFxb4MWBzxC8oL2bxSQGE=;
 b=KQKtxZHBN9XVKHAEofm1dOPpjgFlW3OxmrvqwKM3I/imHEORWsDiuz5+5f40Ze/Rxt
 tePHID/SeGDomkv/RfScvLrfoOKezRsoBQrauPLFkan+toLcGTuBWRe3aO8sDFqNx3zI
 ydk0kmQp2teKjb2ZHiCZxzQlz58Zr08dD2CNF6V7dzAgb2/iAwbSGdXhoxitoaBfyn7A
 31qCvZCjgoTay1e5bCWdCfER2SPmkfc//HqjI5TnQcgcTdweRAZJXjbNEvFl7Ohkzp7b
 hXdblO8VpjstED9mXK87k9BDAy79q53wf40mZbfz5xEsTTktJCAI8bIVCeTDfTFbN7br
 d3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698789324; x=1699394124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yE1pVR+bbzb1Uumh5ae6z7SFxb4MWBzxC8oL2bxSQGE=;
 b=IM/HRv+TgDIX4fHNM0Tg/v+uUv4+XOfCo9bAOBORfI/YmM0DcjqbpZ7SLt4ItaYdmt
 M6BMXf8hSUaTXNDawm+9RF0vt3osJRincEEcMp4bwUt7AeMTzSgPezYk6WQ/5uYuqL41
 A88RBMKod4HkHBWlUQhC2VyfI+oJMxcc0AuvKjEsJJay1Zi6b6inScC1wbNVJXk1dsaY
 2TPqRnG1SlCi4BwPxvLIeN9/rt+gx7GFAKsqmaMuHxGwd8jte/4tHwbPAafj6MQmrYwo
 VjDqbIwRfaWOpP4vpum6wrhmTivJ/duLUReQiicOZyOxk66LY3ktED5mb2S9ARmWOg8L
 4jXA==
X-Gm-Message-State: AOJu0YzPz31n+PLUIO9Ip6EsLqxfgJTJV7pPzFtUSvheQY2gnSS+dIGH
 VuLdsSow+ALOx1e3XKKCFgGNIYEByu2ARGov/CqjoO0mvnxQ2q5b
X-Google-Smtp-Source: AGHT+IFq7Km+VEnBxJVljkSq9DOd7CKc280DcpBcr/erBlkQXu06t60DZA9XUg4+/WLiFeIuOzTzvCEx/E+Lsx5pxZg=
X-Received: by 2002:a81:7916:0:b0:5a7:b930:16a8 with SMTP id
 u22-20020a817916000000b005a7b93016a8mr13357722ywc.4.1698789324208; Tue, 31
 Oct 2023 14:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230926092339.2228321-1-linus.walleij@linaro.org>
In-Reply-To: <20230926092339.2228321-1-linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 31 Oct 2023 22:55:12 +0100
Message-ID: <CACRpkdYWw8MYH3ngwy7cQBCaLo7f17_VZtrd3ohS6Us_6t6MBA@mail.gmail.com>
Subject: Re: [PATCH v2] bmips: Add Inteno XG6846 board
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
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

On Tue, Sep 26, 2023 at 11:23=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:

> This adds support for the Inteno XG6846 board based on the
> Broadcom MIPS 6328 SoC.
>
> The default boot will read a uImage from flash and boot it.
>
> Reviewed-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Rebase on top of Tom's patches making Makefile optional
>   for board directories.
> - Drop the boardfile and Makefile

Is this something we can merge now?

Prerequisites in place?

Something else I need to change?

Yours,
Linus Walleij
