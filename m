Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F78FC369CA
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 19:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3CB820FE;
	Sat, 19 Apr 2025 21:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P/enCBOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB36C820FE; Sat, 19 Apr 2025 21:12:05 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0DD0820F6
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 21:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-30bf3f3539dso30024731fa.1
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 12:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745089923; x=1745694723; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQBfIA9i8g0Ppwjk9cJ6TTQaL3UH4d4fzJY/MopZKZg=;
 b=P/enCBODMccx9zoE4SGFZwzAz+JkcfMbWkugHwRh68Zt48gsGKIR533oXOKHhSDfhP
 f2qcmAlsWsL6bsiS9b3nZ0KyoktEfmaARLDk1e52iBZfG0VK+gcyzuW+5TXwCNXAmw4h
 ryxWwlcMUXhxtdItuY+yj5A+zMsxaaMw8DMy/BCcJuzJ+CDqBr6VSDEU5Ra6ALhOHUVK
 pR5jDQe5sMS1uiG2VpeGJnRaB+/QIXAG1yO5ZAeSWZjQtgyI9WnqhBStZ+RN42CC/Ipn
 jom22rX9u/ruV16ZnCPNQMeEwejYgabfx+EcURJMOjv7yy8qFmhspPTkfBHWaiOvVNqk
 h87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745089923; x=1745694723;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQBfIA9i8g0Ppwjk9cJ6TTQaL3UH4d4fzJY/MopZKZg=;
 b=cheCKsAz+GUqMYlg90GMyuJgqHaNIV1sp5IP0uAAjXrV51p34XrpDd9mDAnGWdyfEC
 M9ziWozAeqtj0cBPZ862B4oOxS/1GEMJm3lJKlh5x7NpY4/nlL/6vwsBo3aYc/3pHfpM
 IJhF8K6FciTiJ+ffBkWPd8AN9pPD+qIlDSBwyBTvU2ATz7+G6IO5c+mAt2uqQy4UqJFZ
 +Lq2VT0PThlr1QiNvsjKx9+TfCEewJT+trY8pObvktLHYv1y01onZZlG5JFqiAemsHQy
 5SubW8egkX2D1vwQISDqJ+qgaVkT0twQsmKhXMb9RUSyYrH1yMmc/RHq6isDCFbkdroY
 ZuEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoyB9Rrij5jx40EG4Bs/UUeVGbgGD2JtP/xLOiQzO9NgynQgrJHGUuDDUc5oQcgxtFauBzibY=@lists.denx.de
X-Gm-Message-State: AOJu0YyCjkX6eWYUtfPOx7dQQF/lBTWbA4YTrPIFo4W6N13TkJYDnaOR
 bGVoLC3Ak+mVSFJ2eSFppV8g3kx6UfOlUB33d6eTm0chH4wRFt9vqYfLtHtR/LaEMBKKxNygBNu
 dSP+nm/W4Dhp4zAOZX8MunSu3CYQ=
X-Gm-Gg: ASbGnctFGM1hJK0zRuZceYoW/vPa6zEFBStIELCLws5d4KjNodTitFS4Lmx98fbNwB4
 zt+mwe3W3VzQ9WP3rVWv28XyzHyFIk/t6QXJhfpuMrbqZMXd3HEuXMdMevd/g5X02fyE5UW9zW6
 /g9MeVFJ0fFHi+BPevF0wxz++NvATpwo1O2Bv6bXEWGMYt62E35YrUsg==
X-Google-Smtp-Source: AGHT+IEXIIJkJFbNOulJAh3WNg9ezhpnW7YqJIXViEPAIZRBDsp0Man6JEJ+K/ceQaFvzm0k8EY1if8geLEGA7WW5Oc=
X-Received: by 2002:a2e:f19:0:b0:30c:432c:5f36 with SMTP id
 38308e7fff4ca-3108ef06779mr23004281fa.5.1745089922574; Sat, 19 Apr 2025
 12:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250417171101.2566447-1-festevam@gmail.com>
 <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
In-Reply-To: <5eb55cce-28b0-436a-85c4-dcf86e6c6554@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 19 Apr 2025 16:11:51 -0300
X-Gm-Features: ATxdqUGtDxv6ZoyMOkaPwyQKMaoHPCvQijtd8wJvNfsmRyiP5HD10h_89m9gl1g
Message-ID: <CAOMZO5C_9yojvxO1NoNjtTHxD85ZcGd_cK2t-rofyY_Zxm1xcg@mail.gmail.com>
Subject: Re: [PATCH v2] clk: fixed-rate: Use "clock-output-names" to name
 fixed clocks
To: Marek Vasut <marex@denx.de>
Cc: trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, 
 francesco.dolcini@toradex.com, aford173@gmail.com, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

Hi Marek,

On Fri, Apr 18, 2025 at 11:53=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:

> The "clock-output-names" is NEVER used for any clock look up.

In Linux, "clock-output-names" is used to register the name of the
fixed-rate clock.

From Linux drivers/clk/clk-fixed-rate.c:

```
static struct clk_hw *_of_fixed_clk_setup(struct device_node *node)
{
....

of_property_read_string(node, "clock-output-names", &clk_name);

hw =3D clk_hw_register_fixed_rate_with_accuracy(NULL, clk_name, NULL,
    0, rate, accuracy);
```

In U-Boot, we should register a fixed-rate clock with the same name as in L=
inux.

This patch aims to make the U-Boot fixed-rate clock name conform to
Linux standards.

> I am fine with the first half of the description, but the second half is
> wrong and this actually does not fix anything. Simply remove
> clock-output-names from the osc_24m and the code will be broken again.

In Linux, if "clock-output-names" is removed from the osc_24m node,
the console becomes corrupted
on an imx8mp-evk.

> The clk_resolve_parent_clk() is meant to perform the aforementioned
> resolution(), that is what "[PATCH v2 00/24] clk: Add
> clk_resolve_parent_clk() and fix up iMX clock drivers" actually fixed.
> It seems there is something still missing and clk_resolve_parent_clk()
> does not do the resolution properly for some clock, but that is what
> needs to be understood and fixed, not worked around this way.

Please try to reproduce the problem on your end.

On an imx8mp-based board, run 'usb start' in U-Boot, and this command will =
fail.

Thanks
