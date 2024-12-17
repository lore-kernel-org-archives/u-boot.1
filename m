Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86B1E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C04380303;
	Tue, 17 Dec 2024 15:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j7R6oLMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5921F802D5; Tue, 17 Dec 2024 15:01:00 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AEDB80291
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:00:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa69077b93fso795801666b.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734444058; x=1735048858; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cdAJi83J4jhw7DvZwwr4cdnVB5riVfLGk49mp2Shxyk=;
 b=j7R6oLMqhcUbVeU+LV4++9LqW5k6BdtEEwmCYKhg9dH31+bumFZxuReH1uNrwxZQGQ
 cgq4e6is/8tL0dKm9WjUjiNv/WCKyt3/fEJR+szqLeUVXIBESqyX/13etfWGIZdkpKzA
 I3IGHNqtnffkju+Tj6jw4EYC4UYmLk1gIeY/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444058; x=1735048858;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdAJi83J4jhw7DvZwwr4cdnVB5riVfLGk49mp2Shxyk=;
 b=w1cAQpzEV4r3EvCyGM0WgSKr1vXMsJzXFYZE3Gmrm7qWfWreY7NLoyPElPfKQcR5tj
 l7KjnzgscmVeQo6luZd1iuf9dYDNx9klsOukc09LVxTevOj443PNkrF1Njz38Yd81N4T
 aKP32je+myYJ3sHHKbwGXqHU+ClVGKcjSCgcUJtGdJOejI7OG67j366WWD+Op62Pk8HW
 Gksv/KfUafRW7kX+V7kDPSLa/tBojgtgvCNRxyma3Xw0jQN7wbTy6TLhIkDl0z1NPrD/
 aTsA8xCPT5AnrpBSvz25heRFSavH1MqIAYAEbKobUrJXSzvCTZ6grhwSdIa4WKCdBVPk
 x+TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEqs6U5TpIIwkP7/Q/k8GYv+uo0i7AuEQEy9e367zNao0w93egQwUNl/WpN8rkfAWU1lA/stw=@lists.denx.de
X-Gm-Message-State: AOJu0Yyuyz+b5qkMkNSkQ2P3k09QoaKrizyUaNmQq5mcDQBrCwM8L6Ge
 fSP8zU0mXYcjGhvrVh6R+ZN0y1OGWv1rVc/BGgYvJTAwTXVkVFMwlGRfALZhgiWAP+vwwoXBjPf
 wietDjKtdxeSb4Be5UdjNDlRp5n57K77WVfde
X-Gm-Gg: ASbGnctmnzEaBZOBgA6vtbjrxsN+mJjagkH3H2kI/63jyCsJUuEeg5jWI0OZGPMuP0c
 e5OBWQGBXZ/AVvegkEaxf8ehmXE//ozdYlTfPoh0=
X-Google-Smtp-Source: AGHT+IGdHLmuVnJYoXHuZaKIoP7T4FMTgnuAuTSyb528HJhwyEfnpUxXGaW6SK9viY6G25HIPN22+jQ2f9r0NtzvTSE=
X-Received: by 2002:a17:906:f5aa:b0:aa6:a8a9:80bb with SMTP id
 a640c23a62f3a-aab76ce2e9dmr1705032866b.0.1734444057741; Tue, 17 Dec 2024
 06:00:57 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 08:00:56 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211004503.3775922-2-sjg@chromium.org>
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 08:00:56 -0600
X-Google-Sender-Auth: v3o91jNzPgKvyc1WoEwk73iyONY
Message-ID: <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
To: Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

While we do plan to switch to OF_SEPARATE now it is supported, it seems
worth at least showing how OF_EMBED could be used instead, just for the
record.

So make the Makefile rule conditional on OF_SEPARATE and adjust fdtdec
to avoid a build error when OF_EMBED is used.

Finally. the dtb symbol has a double underscore, so update it to avoid a
build warning.

With future patches, OF_EMBED will no-longer be used with the EFI app,
so it is expected that it will eventually stop working.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app")
---

 Makefile                       | 2 +-
 include/asm-generic/sections.h | 2 +-
 lib/fdtdec.c                   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Applied to sjg/master, thanks!
