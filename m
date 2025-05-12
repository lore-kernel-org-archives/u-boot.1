Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF42C3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 11:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92BE28091A;
	Mon, 12 May 2025 13:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="futLIgJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7765D82162; Mon, 12 May 2025 13:26:44 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C94B805D7
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 13:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22e7eff58a0so41078545ad.3
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 04:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747049201; x=1747654001; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HBwkeRNYr8vsdP46Z35Nr+OMhbdjz31Rq3D0ATiG+I=;
 b=futLIgJqSfKhrURfV3Gk9jGHUMUixysw+dAk0TyoXGXtUiIS309V0A9qlSCGEdfTzV
 sVs5ZKhwc2KjcCBDQOLLvEQ6RhdZGEx6f++brwyLQW4iZiOlGUwbn/XltcQs+qLd+k6g
 /knMj5prZ6gOTSiuuisZp7quL+b8LqTgcSx/NZDegLnQZw9jTIbyIw3oowuxmB8Y3GzF
 45DABWSoR0G+kUSUpGQIevNYFVuwSFMsVSqFT3nc+AJS99wnsa5/Ftf2Owk16FmXcR+s
 ZD9i2vH+TUkkF7G2HW5HffgA7/XDf45hgpLyC78OgYr1vphRbeOsgaL+zciTn/TSBpzB
 urjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747049201; x=1747654001;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HBwkeRNYr8vsdP46Z35Nr+OMhbdjz31Rq3D0ATiG+I=;
 b=rREi06aMVIcOtFYsrN/G+5p+zJcRjxL+3XTZUdhthzMla6UhosvCF8KugrPyiCr8ni
 ayAKbHz841ZfRR5sKxDA0fIlaJJdARS+1TA1MpCrvujDu4yDLS66jyRbiJgLwehPGDMK
 MFgKa+6DzGrpHwKv/pijZv9yWRP2pZZ3eBWt4T3cro+3fKfSc2ZoWgJ+6Skkh5wCwP/n
 Yr9XT+/vEqXWOxNAChwl3dSdT2B0fTGCXyh/VX/LkE04EWedbqDceklF7lsgBOh/ahv+
 zdPSVXTrOd5w5gGnY5/Gqx2DSlXowVnzmAisjlt1/x3sI6bCdH5w95xPZPr+RBQDUpD6
 V9iQ==
X-Gm-Message-State: AOJu0YzHCKetSsPxAmiagflewjBzWwInSIoQd+xNvO2EPVVLVAj5v5v/
 dkpJyMPcGq8A6pVTL0u/e/QjbjmDn57o14CKBaLC10M4TyxUlZi3A3w9A5h1BWBG1a5RzcNAfaw
 9UXGC/cK0yxirUi3P9AkUF9nEPDI=
X-Gm-Gg: ASbGncvt7X/HRmuTkSiSCB2hKu32GMQGnyLYIUmzQSBaj7y/GqG3Q2KrLWCRwUDVzsz
 THLX7irbyGU6K30JV9yl2ewwE0PEK3oroiSRVg+FGUdVDTBW17rXvFvJhOoVS7fCxXu32blpBqJ
 GVfqrgOoCnsUUANGWy22u5s0H9NPLvvGSFyw==
X-Google-Smtp-Source: AGHT+IHDZoLWR8sc65ztTJbXcEE1fRTOAT3yl5+1/1NDJ7t4VNGaI0aA90daGAIUfFYS9x37q0RGtLWITYGmDzMCXbw=
X-Received: by 2002:a17:902:ccd1:b0:224:a74:28c2 with SMTP id
 d9443c01a7336-22fc8b76a88mr190865015ad.29.1747049200400; Mon, 12 May 2025
 04:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250509154352.3483523-1-adriano.cordova@canonical.com>
 <20250509173854.GJ603748@bill-the-cat>
In-Reply-To: <20250509173854.GJ603748@bill-the-cat>
From: =?UTF-8?Q?Adriano_C=C3=B3rdova?= <adrianox@gmail.com>
Date: Mon, 12 May 2025 07:27:28 -0400
X-Gm-Features: AX0GCFsHDcjSzDAFcCLtmyBVtH3xF-xHm7it7XRE-dem3fGZKMOM3AM9mQcYb70
Message-ID: <CAMGU2hXWxsMdxg7h=LDZc569YBd=W1stqqkNawTukuTcZuZq0A@mail.gmail.com>
Subject: Re: [PATCH 0/3] test/py: enable HTTP testing
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, Adriano Cordova <adriano.cordova@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

The argument can be removed, yes, and the HTTP server can work as the TFTP
one. I will send a v2

El vie, 9 may 2025 a las 13:38, Tom Rini (<trini@konsulko.com>) escribi=C3=
=B3:

> On Fri, May 09, 2025 at 11:43:49AM -0400, Adriano Cordova wrote:
>
> > Enable HTTP server in CI to support HTTP tests in pytest
> >
> > QEMU does not emulate an HTTP server, unlike other services like DHCP o=
r
> TFTP.
> > To enable HTTP  tests during CI runs, start a simple Python HTTP server
> > on port 80. This allows tests that require HTTP access to run.
> >
> > The pytest framework is informed of the server's presence setting
> --httpserver
> > to a non-empty value, and pytest enables HTTP test cases. The actual
> string
> > value passed on --httpserver (e.g., "localhost:80") does not affect
> behavior,
> > it is only checked for non-emptiness. In the future, if the `wget`
> command in
> > U-Boot adds support for specifying ports, the value of --httpserver may
> become
> > meaningful and can be updated accordingly.
>
> I'm not 100% sure on this part. I've been doing this locally with the
> python http server running on the dhcp server. This should also just
> work in CI, and not need further argument passing?
>
> --
> Tom
>
