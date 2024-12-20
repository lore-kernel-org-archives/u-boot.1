Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7559AE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3C0804B6;
	Fri, 20 Dec 2024 05:05:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gY0hdB67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B7980378; Fri, 20 Dec 2024 05:05:35 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2708680087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aabbb507998so283479066b.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667532; x=1735272332; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mx87c6Q9IrC704MggL8e/AUcgrD7ixX6kTebL8Cls0I=;
 b=gY0hdB67Z6RrmFADSdFZkSNRou1chK2+/ZSVYQIk9m6Boqd3/v6AE9CbWwT/99dCao
 pn2NzpBzLsFEyDLQ0ZTHXX9yFrMMoLgG8UDxRzBZ1g42/rG8O/EDIhokxm4k5b63mkP5
 xpOtLkL5b/hRH8MTyTRMY6/s6Y512at9+xUmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667532; x=1735272332;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mx87c6Q9IrC704MggL8e/AUcgrD7ixX6kTebL8Cls0I=;
 b=VZ8MTjUkGg0cB/ll98lK/vp0yrSDCdDLwDLVPS2gGQif3EkOxVb2LMrjS760wkk23+
 2FVNbFV8tatAE9rmjR+yiYvC7wA4cOifbNJfhfjCKYxwpuyEZCilNwb/qz8VvbkShlSS
 iWiNaneWoXwZgFg1wkykPlgfjbZVjasWT6FTkh4L58cyk1TiC6OdY47XZyOiGUCVFaHd
 FPJu5ayVzs6vSouZywqVdB+89x/Rk+L3F2XMvjQ2Z6TpbJgN4dMZefhEOVAmrKMy7vQX
 xrs8hciqunG6IL7pGZ/+GhHW4/qhI8RA4IEuj6ChnMuOrkgzTOgkm262wy9xPLydb8W4
 BuXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM804lFplDzYBI613XtMvJUySelZi0bPJCgo3ut5/rFEGCfeI/1g0iHWeF/HGbAL806aH7k2c=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6W0wmZppm7A+5kBFjrzgCzDdBd+wiI0rWQm2kTWsorSmCNUaV
 PEO5HQBkefQb5Bq0LSipjDcYHOU7yFdlMv3vtiivG9PrCpxFtUKsEq5molV4OZ7TV+0Zn2beg1A
 j+rWfTwyy0UuEd61g+G+LIJ0ijVs13iUefTzp
X-Gm-Gg: ASbGncsFW76yjHtLsSUM7GpDm5FCRpAIhVuP7/hagJsDHEffIeJSU92vvtUPdXBSpIP
 1MdxOzfqzaghzLsXRsPrbwcvVd5c42knpx4IHkOw=
X-Google-Smtp-Source: AGHT+IEQGknr5w+yH00DFgXD2jQr34LBxbHlicSoMKXfjCHj+Blg4ab8xm+U5vKxww3BI5arf80paTo9+RY64ihKhnU=
X-Received: by 2002:a17:907:3d87:b0:aa6:82e8:e89b with SMTP id
 a640c23a62f3a-aac2cf4eebfmr87769266b.28.1734667532595; Thu, 19 Dec 2024
 20:05:32 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:05:31 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-33-sjg@chromium.org>
References: <20241206023626.2456858-33-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:05:31 -0600
X-Google-Sender-Auth: hLbqdCSFUlkmo7RhjKmqbafevmI
Message-ID: <CAFLszTgyvp8ig--P9ZvxFRw_TLN3C1gV0jMLPck=eYWtrHYrPw@mail.gmail.com>
Subject: Re: [PATCH v3 32/46] pxe: Record the bootflow in the PXE context
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
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

At present the only option with PXE is to boot it and see what happens.

Provide a bootflow, when available, so that PXE will eventually be able
to add some useful information to it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 2 +-
 boot/bootmeth_pxe.c      | 2 +-
 boot/pxe_utils.c         | 3 ++-
 cmd/pxe.c                | 4 ++--
 cmd/sysboot.c            | 2 +-
 include/pxe_utils.h      | 5 ++++-
 6 files changed, 11 insertions(+), 7 deletions(-)

Applied to sjg/master, thanks!
