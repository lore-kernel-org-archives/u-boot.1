Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00150D5E366
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 12:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7783D89112;
	Sat,  9 Nov 2024 13:09:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+MzF+g7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00D458911B; Sat,  9 Nov 2024 13:09:37 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1612289110
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 13:09:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2fb4af0b6beso41662051fa.3
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 04:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731154174; x=1731758974; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZALKpne2IdQGpN0zWjG5/6dNXTDsiBJ8vP4qhAwsdY=;
 b=P+MzF+g7G2Y6gDNrRrkv4r2prAYUP5QoHBOjWqrJuQsQE1duA2C57nQf8iGe5g/CQ/
 ILhN3o+rUzAzjcu14l7MH0+8/XsxDXrlBBN+96+nXMwp0NJ7ldD4rSOYIz6dUG52sX3L
 DuNtDfPrBXgy6Wj9jeiBJTgzD3HWwEpX7ngk46gBgQ2Hughr7bMBDIX3W+mFck1iRgTj
 gxOiiAiaRNZlwR9jUIVuQwHiCUFrO3f3YSa7CQ1gsLNEEnFUenuwgmDHPBpRau/fjGVr
 BCRoriKTCbWTjR8Ij0Kb3yN3sIIG9B/OaSaOqbD6KKysbHL7uB6OuU/P+V/pijIJKjqZ
 60qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731154174; x=1731758974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ZALKpne2IdQGpN0zWjG5/6dNXTDsiBJ8vP4qhAwsdY=;
 b=k6zcPOLUTTzXEQrSJSx614ICNzGc40bpbot3axmTTrw+DsR8TRmTXIf4pSiLscuqN2
 lrPSeuiKpB9G15CFnljW+7Y/uncc5IFRfSwINjS4ta677Cz8d3v+MzkxkrlxuD6EFU2Z
 8q4PF3g0qfQMkgOM3dG1EBsD/WadMCSJCrIRKzy419CWgASkU3gOnGdc3OB5E4nh2AOb
 9P8WlSR6Rs8+PlgET3rc7ARoTjZe/XKRQeyqstkGNzzC+ULB1zJ3NBzIsmqSMZl2nkpe
 q3sTu22jTVgK6m6vT6a6443/jATk/atD+PUorlYs1XtZi+9nauANUF01zP3hm5vF8n9W
 uKfQ==
X-Gm-Message-State: AOJu0YzmFhfHuUqEstRuSOsfxjNPWpNd/2QIJ/LaPAsRkOoUr+mWDJaT
 O9+gjhxZ5YrAQs96Rm8iY+mbViSA3weGes+SgikKrrfmRFOsLj3DZBXh3lA7pkiNwVeORtApQMX
 GkHyjhf0Lyc8bv4aHQ5kewLknHRg=
X-Google-Smtp-Source: AGHT+IG2PFrfXIdbIQ7Ox69dXKRPHQu/Gi0oaxyw5+0zZOBXyvWqO6jjEfdT+2nUMMXr/q4VzYbzCs463XG1mzhK6mQ=
X-Received: by 2002:a2e:a995:0:b0:2fb:5206:1675 with SMTP id
 38308e7fff4ca-2ff2028a9a5mr48323191fa.27.1731154174009; Sat, 09 Nov 2024
 04:09:34 -0800 (PST)
MIME-Version: 1.0
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-18-hs@denx.de>
In-Reply-To: <20241108052143.26874-18-hs@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 9 Nov 2024 09:09:22 -0300
Message-ID: <CAOMZO5CaibRaKg6N+70B3BmzsN3oJcC1-4okpbV6oU1KA7WWeA@mail.gmail.com>
Subject: Re: [PATCH v1 17/22] siemens: capricorn: add HW version information
 to boot log
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Enrico Leto <enrico.leto@siemens.com>, 
 Walter Schweizer <walter.schweizer@siemens.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alessandro Zini <alessandro.zini@siemens.com>,
 Anatolij Gustschin <agust@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, Nov 8, 2024 at 2:24=E2=80=AFAM Heiko Schocher <hs@denx.de> wrote:
>
> Add the HW version read directly from EEPROM.
>
> EEPROM chip data structure is now in a .h file common to draco
> and capricorn.
>
> Therefore move out the definitions in drace board to siemens

s/drace/draco

> common place.
>
> Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
> Signed-off-by: Heiko Schocher <hs@denx.de>

It's not clear to me who the author of this patch is. If it is
Alessandro, then a From line with his name is missing.

Please clarify.
