Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2632CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 20:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F04983948;
	Wed,  8 Oct 2025 22:54:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QtTKOwVb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC8E83948; Wed,  8 Oct 2025 22:54:02 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 232BD83930
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 22:54:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7ae21804971so97029a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 13:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759956839; x=1760561639; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwK3FvjfKTHG+9HGPxn6bP8LgBEawf37pbJd/pw4UBo=;
 b=QtTKOwVbJfCp2npoHCQcTrST2g5LYWL00LSeNmBhz1tCDLHWIgBnsZxbSwdI+E5ZXU
 Qwc41nMrs0rLfrLoNKhtc4x+g0e5MbnUiPqK94zCQq0G3OpaiNabW6D6fXdLVNpWRbmI
 r57oYv+HCEmKaAJHUmaNTjLQhNikf8CTsWsV/F4E4k4KqtmowepSDu/eDGS7eQtQ8j10
 7UyPbP4QgwLWPAi6Yo2uIBe7Oik1/qWvTJAvz1kdj2yc4lfGY6ITGeGUvXrcKOdckAER
 ZmA2ivbT3TsKUU0gm+8H9R4rl+QfOSwydK60cy/PDtjpH8ZbubEkmeDHJZq8I0rm6beZ
 DlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759956839; x=1760561639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwK3FvjfKTHG+9HGPxn6bP8LgBEawf37pbJd/pw4UBo=;
 b=p0czdHTe/Rig1llQKf69aA9+StW3iq3GS70sk1R+0UPxvZoCGgf3xQvJ5nesKtQQ8t
 uZlCrY7oLpeyn8MWscdMK/iZAZ8b87YO30WKZRfrIpWqcU6SRMuCqo02GM8I7WlN23h/
 mdnPu1ZzY2vug0UNrChTqadKYaQI9PTmgfVtXIwe4IARx1wlqwM1zl7Y6QRnBJ2lZRFj
 TMNKwOemcAV4dSKbUDDYeJSoj91iAatZn4cRYxmGUd6SxL7pOb38fhsLGZcebhfB54Os
 /VrNOIVGDqu/Cr9paD5K9tGONZvCI0/UDl26QOmTLGYR2KuhOmkbmzSF9aOZer7nOa/D
 HxPg==
X-Gm-Message-State: AOJu0YwphJhY9SYw99+uXN1nrv4RlNGht3hwICxkTH3WTWdFI/Hlgo8q
 +r2CSxo0NQfI9JUQUP/ISpmK9WwwLSwQ65dFZWPtJm07zgTAVSq16FgpRevwczkitCOS08zp0Of
 hoGSO1tz2wW/Igop5yDxDNy6eI6ncoxvio7lkrqfW/Q==
X-Gm-Gg: ASbGnctpBsGuuF0MHSZs+6in/f+M+1gix3iWVQK5c1MlbZPCS+pAiAjnRDyCcD/YTzA
 VF6llCaMJgN0Z4p/AK01ZsN7pGvFVTcgBT9hMM8RTvbW2SYMMIhpeimbZatgb++CrpaJ6FNr8Dv
 MzPSeeWi/JwVcP9pJHaF1zdAilwX4I4yowiEGriFcSK0p+wkKLB7IW/hRUCxjFJqnVjyPsRFCcc
 kNQzYsggtBdx2Q+DPU6ciOpNzl22hI5Z8FxP0sL4A==
X-Google-Smtp-Source: AGHT+IEhX5+qUUHK2klYaGrQN5tuJqWjTXCgjID48A5FnQrFPwaifDfTMEz+fkVVXCdWjDVoGmpK66MJ7qUgrm77w+I=
X-Received: by 2002:a05:6830:61c7:b0:759:55bd:9597 with SMTP id
 46e09a7af769-7c0df7ff940mr3123716a34.26.1759956838906; Wed, 08 Oct 2025
 13:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251008204103.1497-1-briansune@gmail.com>
 <20251008205037.GL298503@bill-the-cat>
In-Reply-To: <20251008205037.GL298503@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 9 Oct 2025 04:53:47 +0800
X-Gm-Features: AS18NWA9ESuLAtrHsGZaMT6iTzOtlA2kOOD4TJqUr8kaNTsHSoXijTiz11TwfuM
Message-ID: <CAN7C2SBPhtd3+jzmc48+4g+6bU6FO8QZmnYjWgsXQoH4YOjohg@mail.gmail.com>
Subject: Re: [PATCH v2] cmd/dma: documentation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=889=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:50=E5=AF=AB=E9=81=93=EF=BC=9A

> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom

Aaaaaa, no idea why my env no good.
But at least you checked.
Thank you.
