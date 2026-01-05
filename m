Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8DAC79F9E
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29B2183D6C;
	Mon,  5 Jan 2026 16:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="lCa8gyqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0EE683E21; Mon,  5 Jan 2026 16:42:52 +0100 (CET)
Received: from mail-yx1-xb134.google.com (mail-yx1-xb134.google.com
 [IPv6:2607:f8b0:4864:20::b134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9685183CBD
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-6467ac59e16so16825d50.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1767627769; x=1768232569;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDtbyf7MBSeKzO2xNlgCAl+ke2yve7AsaMV5NbW1uLY=;
 b=lCa8gyqhaZwLEypHSoqH260Uvhf6QzgNBvhBJ3a6lx/TzDesj3q5ivfWxY6gSW0kGM
 KRGUz0jXADfdFHzkECtBfMjX88sYaA5saTfy/gfWvG0PzW2/jYPiTwZq/fPWZ3xXtQ+c
 T68WnFttV96mbrCbFU50gWsH1gXFcJtrP24Ty/HQROPxFVpSGo32v5Lu5hrrBmB8j2Kv
 o+ZBeau/OQ1vH2ls4suPKISuNJ2pZPxE7ZVx6SIkTNGz9jjg9VlUfeQMOoH99RZZGcvF
 ofEmHjVKGWxlX9vgkJEmaa34lKoAgZtBNMjtK7xvyA3IxITc4YAYHovvdETyIC7GtVeX
 3SzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767627769; x=1768232569;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wDtbyf7MBSeKzO2xNlgCAl+ke2yve7AsaMV5NbW1uLY=;
 b=KXu70ht3v9p1ZY4JEuad9kvViGnZmD6ofLlyC7XIqC1zNKRQsJx6KFX2KBxqFgs5rD
 2IRWl+rr19UourTlxrHKYqLdt/1baxfuYClscSNrUr7m4JyvFtFuxvNhslwWBRglu8HI
 TzIUO7qp5b83s+Gi7ZQcu1vwulYPmufiUEG0XcaR+C5rJx6bXMN+xgZ6MfJBcV0VBDjB
 db/zOR9tE6OyWtlDnjxW4e+4c6m/orlf3E78TifsX3z8qPxlyIDeVBmXoLRJ3o81/lCl
 4Ud8sxzRUUdDbHepOXoEs8BH3YYHiwd4Srwe1mF1ZkbkMp4kN2z5ojlxX11691KejEOO
 +7EA==
X-Gm-Message-State: AOJu0Yyy77UTq16WaridVcVAhlm6VdN3pleSCcU6diOp/to3NslRe5Fh
 SeIqBmjLmdFynK/htSxK0/8Shj7BIVU6xzP08Balz1A/XfZf1VkMzAuH0LdbLUXCdbYwAX16Ql/
 XCXwsJpocA7LVOsf4JqncCU9Tnz4QVda0SPy6RF2h
X-Gm-Gg: AY/fxX4M8Dluy+d3UxPDY0Kbno/gXvPExwbBUVIfwVrnbL4qTIZIaMkscGMJNW6ByfJ
 /XvesuDKfDq7eftmNJyqOkEPu6rTf7heR3cs2rUMb8qs4E/Z8nr/i9oUNbyomq7hgUY5CibRg6K
 rp+EM5F31mcVDCQ6KNkHH6uFWG+AZDcsUOYm+Q9q2AXx3+w4LtHN3xJgcJJM1U8KiQsc62DTL89
 9sq0PnvZXdOkRe8s7ZIzSdkUr3R/wyrv5G82lYmDROtfd9RyjlsKjcAyO30eFAWgHZ2iq4Q
X-Google-Smtp-Source: AGHT+IHb+L660YuPT9uxqKBhXhhNQRdDFGmGsQgIT+9SZomWHAT+9/lLvmdY5N3PKs1I4SVNedVytuczCfGDJGIqkyg=
X-Received: by 2002:a53:bbcb:0:b0:644:7398:6670 with SMTP id
 956f58d0204a3-6466a834c30mr32925273d50.7.1767627769406; Mon, 05 Jan 2026
 07:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20251228151824.25667-1-dario.binacchi@amarulasolutions.com>
 <20251228151824.25667-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20251228151824.25667-6-dario.binacchi@amarulasolutions.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 5 Jan 2026 16:42:36 +0100
X-Gm-Features: AQt7F2rzWAYQyN0jCxUsrDpKcRQIijwAQeSmWJc6st-bWsEObV9Je113ziJ5kNQ
Message-ID: <CAHTX3dJ-PKO6Ckhqc0MMTY6j+d9J-SbF9gcG0axhan=FijdEYg@mail.gmail.com>
Subject: Re: [PATCH 5/5] tools: build dumpfwumdata with tools-only_defconfig
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
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

ne 28. 12. 2025 v 16:19 odes=C3=ADlatel Dario Binacchi
<dario.binacchi@amarulasolutions.com> napsal:
>
> Always build dumpfwumdata when using tools-only_defconfig.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>
> ---
>
>  configs/tools-only_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/tools-only_defconfig b/configs/tools-only_defconfig
> index bdc646e29b32..bbcb64879fac 100644
> --- a/configs/tools-only_defconfig
> +++ b/configs/tools-only_defconfig
> @@ -41,3 +41,4 @@ CONFIG_VIRTIO_SANDBOX=3Dn
>  CONFIG_GENERATE_ACPI_TABLE=3Dn
>  CONFIG_TOOLS_MKEFICAPSULE=3Dy
>  CONFIG_TOOLS_MKFWUMDATA=3Dy
> +CONFIG_TOOLS_DUMPFWUMDATA=3Dy

Order is different. This should be above CONFIG_TOOLS_MKFWUMDATA.

M
