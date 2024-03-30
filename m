Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DE2C6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 17:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760BA87E95;
	Sat, 30 Mar 2024 18:37:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MN7OxGOW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C4C87EA9; Sat, 30 Mar 2024 18:37:14 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F9CE87E4D
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 18:37:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6ea895eaaadso684106b3a.1
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711820231; x=1712425031; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B86D9MiIV/ImmuitJWX4YNj37ctUmHVUyCKbC55krGs=;
 b=MN7OxGOWws5iY7ZhUwnaqaKtsn4ytPwzBdJOrpixshqFnOjKQaBMzudpuzas9hI7LU
 CumaMSoBosB1wFhP4ijijeXD2H38cUj6iARAZ8/1ul0IwIYjQESYE6fLmIT24sbkFpRl
 WbawdPGIaUPusCZLKnIR02b2R7Puo2NzpCq2B2QeDtGU2XDZzZ86iXc5nvMemf3xPP/V
 YdECrA7L9OyIOHdfS/TWF/3YUMGiNgvMrOq4Z1Py7nsTjFczymKlTMa649t4SiR9ayBS
 ZdbE9nCy7P5Itw1NLauCWjAxG01E6ccob/oFBRLhVfGNioqvwpa8w7QI+t3E+/S42YM/
 v/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711820231; x=1712425031;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B86D9MiIV/ImmuitJWX4YNj37ctUmHVUyCKbC55krGs=;
 b=EDRjaf9XvqD7bdkqRGoJjXOcLLJfbvboFFUNM30jBeeOCM4uIRXlEElGS8+6Whg3Xe
 yB0HrCdoTW8M2dwuzXyYgQO4VyrQiljPb+7+0DlrXcOvC+VI61RSEPvALY0ajJnkH5b9
 pbMm7rO/wHnimRDlyf4loa0MVLznDViKVJcMcDirhY+znyQmP+d1EX1tQWlYAYrqaDKR
 UwqTYkyOYaQ1YZ/76A2s5LTnvorIDcTMb42bliXY4Inz03a0gGEIshkcjxyTdskQibwk
 rOv2yIabBnjdGTOYDg85QQWejUlj7BG9XTo6Az8xFGdvFeQF4Pfg77fqbUJmq/levbwb
 Z4xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMQUtBDL42QuHex6+fFVenOyl7DkTUo4MbGFYiQSkxFCs2jHT38NoQL0xrbYDMpZtPensye8OjS4QZsyUfVaHqA5751w==
X-Gm-Message-State: AOJu0YwPRWqctwF3Rwn3El6doi/tP0sa89YpdBf+SIzfFWFmRtE1yQh9
 iJXjzHaU1tjmZg9JjC79skcyH31SW7DHLunAlaHf7HaTz+F+LaNcpk8yiln+mHEp2FlCP0TBmtN
 Fxdv67VOMv6BS/Aq4lYMtl8azXlE=
X-Google-Smtp-Source: AGHT+IFAgsWdn7YlCGSGXL/LoyVyDn9m7k9gfdoNZ6YQux+LWGjRAd6UyKjYu3pfM2J60b7Hi/rbhNInY7TVRFH0HT0=
X-Received: by 2002:a05:6a20:3ca9:b0:1a7:c2e:41eb with SMTP id
 b41-20020a056a203ca900b001a70c2e41ebmr2066396pzj.2.1711820231066; Sat, 30 Mar
 2024 10:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240327114959.2084525-1-festevam@gmail.com>
In-Reply-To: <20240327114959.2084525-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 30 Mar 2024 14:37:00 -0300
Message-ID: <CAOMZO5Ceed_kCR02_504LKqZ34GYqXSAzznXeHF6PJBnpzVAVQ@mail.gmail.com>
Subject: Re: [PATCH] mx6cuboxi: Fix board revision detection
To: festevam@gmail.com
Cc: baruch@tkos.co.il, trini@konsulko.com, josua@solid-run.com, 
 u-boot@lists.denx.de, cgmeiner@igalia.com
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

On Wed, Mar 27, 2024 at 8:50=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Currently, an i.MX6 Cuboxi board is incorrectly detected
> as the HummingBoard model:
>
> U-Boot 2024.04-rc5 (Mar 26 2024 - 15:59:22 +0100)
>
> CPU:   Freescale i.MX6Q rev1.3 996 MHz (running at 792 MHz)
> CPU:   Extended Commercial temperature grade (-20C to 105C) at 26C
> Reset cause: POR
> Model: SolidRun HummingBoard2 Dual/Quad (1.5som+emmc)
> gpio@20a4000: set_dir_flags: error: gpio GPIO3_8 not reserved
> gpio@20a4000: get_value: error: gpio GPIO3_8 not reserved
> gpio@20a8000: set_dir_flags: error: gpio GPIO4_4 not reserved
> gpio@20a8000: get_value: error: gpio GPIO4_4 not reserved
> gpio@20b0000: set_dir_flags: error: gpio GPIO6_9 not reserved
> gpio@20b0000: get_value: error: gpio GPIO6_9 not reserved
> Board: MX6 HummingBoard
> DRAM:  2 GiB
> ...
>
> This error happens because request_detect_gpios() uses the GPIO DM
> API, but board_type() still uses the legacy non-DM GPIO API.
>
> Fix it by using the GPIO DM API in board_type() to read the
> board revision pins in SPL.
>
> Reported-by: Christian Gmeiner <cgmeiner@igalia.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Applied, thanks.
