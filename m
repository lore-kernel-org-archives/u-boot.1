Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15092E7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 15:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816CD89323;
	Sat,  7 Dec 2024 16:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fLYjEMaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 087318941D; Sat,  7 Dec 2024 16:57:18 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF1289376
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 16:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4668cec51afso23678911cf.3
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 07:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733587035; x=1734191835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZR8aiOFVE1+/IpoS+XezsxSCragxuaAzwaxlOdO9o2I=;
 b=fLYjEMaFeeFks7TEmu2ukQNuUaUQoznZjotlQ4FIcoU2dUiP9kWMiNVnTnITkW/0F7
 1cfxParFSXEKGDr14I94NqM8vECmiDdNAsNYHS0NLyXRgvv9gEwM+SiCBLHd9xGK0uTn
 JZRX7CWNeHsOWbUbvUeurUOUU+F/X0y5zeVZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733587035; x=1734191835;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZR8aiOFVE1+/IpoS+XezsxSCragxuaAzwaxlOdO9o2I=;
 b=Ob1r1oPzjrRrzjCgyxbtVMAi8vVtMMk9Bnh4o5GB58W242fcfmwCUi5KOEvcflwCXY
 bc63tntBgU+8jWjE56TcUhvFAjRWe73ZxwJX2cPVEG1tysUMP+/9G5ulzPjT6Oz91PiM
 8JF1E9OW3yhQcyqG3EoVcFYAjd2NlPc6AXCphMZXRGYe2u1/JVqtq03VfpyYSAv3Ve8/
 NAwKV2Gj0cOCnBTs/5KLIRjzrwRhJgT5xXrFlKC6bm7jQB0e8KUDZ/bepI0eyCn2nbj7
 qszDqXPpJkQEgMncD6vtCq9LFDP/IGInbZRYs6jbIw4fOD5zq8wx/jDs2kizccIZFKzy
 L4vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBMJ+Nyf0VZr4ZtaBPG3DjF2BMfhsSP0jIyTVEE6sZemf3UHrrqLhUeCDA+Kk5cAervaTRYUc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfx6zUj7B/nLhsfr1QbR4pctjCmRWhciDYoJhvDPQYksI0lPsW
 tlBpPR7kH1oJcbUoc8uutMUmZHUO7u6UFD4VrYcMcaQF5EpTr7WTeMCodqHTvsE=
X-Gm-Gg: ASbGncu23Z+dn1zrzya0Qq6jErCEzVbqyY8R//6Nay3y+0Idof4fxLbwjwnRUVyRhmu
 GSRZPsyqOdOBVtGErWjEvMW+x5DDWHf3dqUBE+MDpwQS9RhyvYTN7x8jFY+RwwrO/0YyxlDXa65
 Vmtha6ioITCwU4UIdN/wtxQhXZylKHoObesnhUr1u+KD8K/Bs5EH8Ng9gbK8PzpelprG7J87KST
 yt9mWTOTm7Ql8OifUaaKa6HM0tM92Fl5aHM4Gf4GR6nd07r9w==
X-Google-Smtp-Source: AGHT+IFzu/g6dQjDiG2gVtRZknhqNFmZCIKAnF8b+KzkGOmVnJmaK5fSzBN8+0yZ8gtmYydpER3/zg==
X-Received: by 2002:ac8:59ca:0:b0:458:34fb:5d59 with SMTP id
 d75a77b69052e-46734cf34admr97995401cf.29.1733587034914; 
 Sat, 07 Dec 2024 07:57:14 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296d2f15sm32998151cf.35.2024.12.07.07.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 07:57:14 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
References: <20241206105647.2548249-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] mbedtls: remove MBEDTLS_HAVE_TIME
Message-Id: <173358703286.3722028.6625552213446208924.b4-ty@konsulko.com>
Date: Sat, 07 Dec 2024 09:57:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 06 Dec 2024 12:56:45 +0200, Ilias Apalodimas wrote:

> When MbedTLS TLS features were added MBEDTLS_HAVE_TIME was defined as part
> of enabling https:// support. However that pointed to the wrong function
> which could crash if it received a NULL pointer.
> 
> Looking closer that function is not really needed, as it only seems to
> increase the RNG entropy by using 4b of the current time and date.
> The reason that was enabled is that lwIP was unconditionally requiring it,
> although it's configurable and can be turned off.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


