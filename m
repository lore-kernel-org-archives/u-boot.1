Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A08FC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 12:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC06D846F0;
	Fri,  8 Aug 2025 14:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MpL3c7I+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741BD84712; Fri,  8 Aug 2025 14:57:37 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AF32846E9
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 14:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-55b8248e77bso2161258e87.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 05:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754657855; x=1755262655; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJKja8fdd8Lg6EBLtJEcbhimLQndwCbBEGJQvkf5wVs=;
 b=MpL3c7I+F5MRrJGAoj550lYYciTQgA7epqYKER/BTNW38aGs4Q+eSTdq7VqFSzwcJL
 Noj4jdx0Vi3NkANpY3dU4QEZVmim9I1rnTVOjZkOOLPwMkoJTUGm2K3oG8JsA/600r0V
 1LlVatG74dHUHjZWmSJb0MstTC9njV0/h2BfGP9GVbQAUFFPi3wHgh1zP6kcD5o/+YPy
 8F7ruyW70zyNDZM73u6t5DEZIdl13ZryIXPowqiqf+3jVMcybn5JURNnw07aS/rn0JQO
 gv6KZi4QemlH+wevMohnGkjhKT6sWdo9fcHlkbL0xYjsdw8MRlUZjy0+OagSiT77qd+9
 WEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754657855; x=1755262655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJKja8fdd8Lg6EBLtJEcbhimLQndwCbBEGJQvkf5wVs=;
 b=qey3YaCYRCgUP0bPz51tuVB2FFG4upN1e3Tvt8BDA9JK4b+0kuQqAU0yITsSFDq6YZ
 5eCTRIlpS60+dSjjD4IVDDn4KMlvy3VEc9CqQ5Hlto84TajEsh3HJhvH1mfqbdyrw+5M
 jVYMFaUM7QrhtkE0a2uXVG8DOUlKSlAffCHjyrxSXFMhgie4BKv9nemrabiZajbEzoFi
 9G0OTcFcDKz9FdcIpWZPwQPSdoC2NJ+2e5t4VbsWLdKeygFoMinoytAvgw4wuAl7mFzb
 FglE+MmeX5u3SFIFlkOKy8uXhCDKzzDx0Wg9CHPU7RBxkCEhw6UTJLKxaD6k82DiJR1z
 YQGA==
X-Gm-Message-State: AOJu0Yx+anAy4AWa1U1WXZU9Uj64Gs1GnO/TUqBdh0OPb908iRzk75Vi
 n+5BvmY7JKN+zEjkxTvaX4R842GFraTwgxEcaFeQPRp7igmqizmMMGasHTnBrTV6835T1/ReBB6
 C8j77rJ1o2sgjv1+kctynp6wlNHDzu10tbw==
X-Gm-Gg: ASbGncsG4rytpMl8zCFYKYJOVYKjlzluobcdf4yA/xUtP5I0+bWIDo8NKuE6Oy9XOIP
 NRibHfXTtw+HzmQYC9gyfVLJDEOXQS6gkz3jSfnz61mB99QgfPWPI0976db1d2s+QCTcbFTpb06
 LcxfEu8vhkgUEBhmN7nMj+fCClZcK/M7uK/2zoRPPqb16YGDaxDLlmhCDSjQcgf9B2FPYYpW8Zj
 49PDcevAqhWSFLGw44/EOceApcCijxjx+IDzg==
X-Google-Smtp-Source: AGHT+IF35pJ5z5y6ej/gIwl3rEsXg1aGQPHpJU1aQs7sNfYirKFFQ4Yp0xcOZpAUQAvFG61qn58ACDQSh+atWIl2DOs=
X-Received: by 2002:a05:6512:2395:b0:55b:957e:3a86 with SMTP id
 2adb3069b0e04-55cc013879cmr919151e87.54.1754657854682; Fri, 08 Aug 2025
 05:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250728223849.87212-1-marek.vasut@mailbox.org>
In-Reply-To: <20250728223849.87212-1-marek.vasut@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 8 Aug 2025 09:57:23 -0300
X-Gm-Features: Ac12FXzEq6F0_AlG3Fp7DarPeGRHr7siTCWYEC-TZHDuMCMe-WVZvC0EF7mYkHY
Message-ID: <CAOMZO5ANQpnh=ESK=K1kGMUJ04GvgJxzrOHLQbNuaeVqx+FYnw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx6: dh-imx6: Enable USB OTG ID pin pull up in SPL
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Andreas Geisreiter <ageisreiter@dh-electronics.de>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
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

On Mon, Jul 28, 2025 at 7:39=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> Enable SoC pull up for USB OTG ID pin in SPL. There is no dedicated pull =
up
> resistor on the SoM itself, and the pull up is mandatory for correct USB =
OTG
> ID pin detection. U-Boot proper already configures the USB OTG ID pin pul=
l
> up via DT pinctrl node entry.
>
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>

Applied, thanks.
