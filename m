Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5B5C54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 23:03:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71A28785A;
	Fri,  8 Mar 2024 00:03:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8iLc83Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B87ED87B82; Fri,  8 Mar 2024 00:03:30 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F300877AF
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 00:03:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c1a2f7e302so120702b6e.0
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 15:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709852606; x=1710457406; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ZmRqjAczgW2hdpzd5u8UGrrTL6VimYDhMzPtH/yuuo=;
 b=J8iLc83ZVEJWoaUHT0lkSTlLu+m88j5hGB4Y078y/BByjMcpBoYm6Zh6d9q3I/K6T0
 AGdPRHpRA3iIUe0e8wG0lYk1wEGa07CA0+bsM6Nx2CYqvjNEzcyE7UgVekMtAK2YBfjH
 kQV6Yk5mQakYutZtIDme4GWg9jTRGFZwYI+d6EDrFfsem2dqX79VWyQY945Bq+Pb+1WR
 R6i61mGs9BfbWEJ3XE7AFE//2vN9Hwhu4I2NiYA68+zaLFqj/6qn1Ac/492ze5kqb3kS
 udrNhrFKQLmHzQvKPb+x0V87wPAWlNjYMoeekipfX2oN7mvmt1DmqGLOaAif4WijWwD/
 6KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709852606; x=1710457406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ZmRqjAczgW2hdpzd5u8UGrrTL6VimYDhMzPtH/yuuo=;
 b=vekltbPOdHohH9VpOfdRkSdo85e4zXL9BwpJ6kunEPnL1m++ro25FuuSlJRWBcwhNs
 XhcNfXwmkA2Dp+HjHEgSLErkcVl4wDmhBjHQOo+fciWAA0pqCQn1LKthswxqz2imS1JL
 Sc23CQ7n+WdHXZsDHsiMZXtuLA2kER8rdvgqC6/pPMQ2b8zR4pCEZuJ/KDpqbhRXSP6W
 zgC7sgyoFh9BH33fiQTF9HtOUO58C4CTMMYiqgoiDkmvB/dGh9/R9c1piUbXbuaev3H8
 UaC3zNBfL5zrGPALN4P00taIAFov8tKQYj8qBS0BEe6UKdak54L01GFMCEqrlYdL7uoa
 2jZQ==
X-Gm-Message-State: AOJu0YyGEPRahQnjXBsjw5Le5+AKZJka2In9KNafnd53bNOLjQrBfSf5
 d3AYLhCDrvyVZgpQY8d0k/9S5kh5rE4pr5UpgMAXfX1/cg9fht/Dlc33uPXUJZa+41w6WNCJ2Ib
 tr2peAeExspyBmTx3tGWxN807AOM=
X-Google-Smtp-Source: AGHT+IE3IvkkEnKORp/xRPhADlIi/Q6glYJJc4alm1Fq9cxxoaE0zOPE4AKA5SbfiCLe9XPYdy8eeiV7l4rPfFT4GgQ=
X-Received: by 2002:a05:6808:2390:b0:3c2:fa1:332b with SMTP id
 bp16-20020a056808239000b003c20fa1332bmr12115193oib.14.1709852605767; Thu, 07
 Mar 2024 15:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20240303130122.29983-1-heinrich.schuchardt@canonical.com>
 <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240303130122.29983-4-heinrich.schuchardt@canonical.com>
From: E Shattow <lucent@gmail.com>
Date: Thu, 7 Mar 2024 15:03:14 -0800
Message-ID: <CANV2PTMcS800x8OTuDbv8orqUD=-frNpa+0dHu4=L__D_Rmk_g@mail.gmail.com>
Subject: Re: [RFC 3/5] board: starfive: support Milk-V Mars board
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
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

On Sun, Mar 3, 2024 at 5:02=E2=80=AFAM Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:
...

> * The EEPROM is atmel,24c02 according to the vendor U-Boot.
>
...

The same vendor (Milk-V) U-Boot change is present on their branch for Mars
CM Lite (which despite the naming has more in common with Pine64 Star64
than Mars); However on visual inspection the silkscreen markings are for
24c04. See: [Photo flatbed scans of Mars CM Lite 4GB rev 1.01](
https://github.com/geerlingguy/sbc-reviews/issues/22#issuecomment-187247860=
5).
Can this be determined at runtime, or I must trust that this is not a
wrongly marked chip?
