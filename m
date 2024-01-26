Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739E4C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 19:57:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ADDA87B84;
	Fri, 26 Jan 2024 20:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YWNfGjuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B3587B84; Fri, 26 Jan 2024 20:57:23 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ADE7879F6
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 20:57:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5edfcba97e3so8506487b3.2
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 11:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706299039; x=1706903839; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/2UoLYjF9OM7FQ+Tt2pSrSAf75X2teuzF/Eln58rKs=;
 b=YWNfGjuC0afGXq5syVTDG9Mjbwk/jbbYsEDmHHvxzx++m0pFPu46d5ex3opF3V8L9C
 2TK5TSr9bl2Fxxbz5da1KxYIw3x7BMwXFnxMClvpvhsHvNS7OlmWcmKURobybuiTgRXA
 Gqgz2EqpV7c9D1UZhPhLUvYZFI/RPVCWax2ouVhHdxKQLGsbOOr7vKxdXzNyy+N+aTBn
 9q/h3BniNclLYpbra4uECPygGfTLVfpLX4xp8IiA4evrvHelio2x8ooxtUx1j2fPQKiU
 jQc3J9/ORAnA35i62gRJEyZNIgdH50mJ+k3GnZyA/fdEL0kVe001TKg3NdQFEjE4uBWe
 dRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706299039; x=1706903839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/2UoLYjF9OM7FQ+Tt2pSrSAf75X2teuzF/Eln58rKs=;
 b=MDASIFMl2OfuV9HbCySsvIahDdEBghyYX6bEZih6VI6IA6tfURBcT7TOOv+10BL+zL
 /03fg4F5Jg6PQNMdMlBgTD2dINoMugF4mX4fTL13XxCWglc5VeMDq/pNdE4qX2u7ZR7F
 N9X1Cd9f5d5NMtrV7D8B0JD/2Ek8Bhrdtp+Vie8jL0GOmo4dS8x2/NUaPZHrJPjVsXq8
 PWB+yc7RvMexosm6t3Ludb2p3S2rdtOcDjUvLMPc3eJC9tJRATmijwr3XaKDnLrbIU3v
 QqDs7LK3ez/H0orur8y4EKmOQpjL0lMfvSnsd/Ao8ZDYoc0NGciOSIM9JGxkqFm6UUle
 +Zww==
X-Gm-Message-State: AOJu0YwQt2jCPfc9olvCnndJbFaOP87k5zUXrHaS0rjsSxlvsb+Q6Kll
 W1+xGUVmCPFrbMFZnqnU798zPH4CN/LmuuMKeEPohqkah1BO3KIsFL7XaMD8ZhePnNkBQ6jTp2z
 Vt/bEa1kuasXq0nk4XrSD7Un4hKxp6kenzurvPA==
X-Google-Smtp-Source: AGHT+IHTn+/mUcfiZb0FYQ+12Ys2e+tjbtyo73Ocf9TDOtwyObwmAq+KLoR55/DF2nHCMK0N1g1WIz+Pp18GBjJxWj8=
X-Received: by 2002:a0d:d68b:0:b0:5fb:5b9:65c1 with SMTP id
 y133-20020a0dd68b000000b005fb05b965c1mr400456ywd.96.1706299038900; Fri, 26
 Jan 2024 11:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
In-Reply-To: <20240126124801.1164892-1-ole.orhagen@northern.tech>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 26 Jan 2024 20:57:07 +0100
Message-ID: <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
To: "Ole P. Orhagen" <ole.orhagen@northern.tech>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Kristian Amlie <kristian.amlie@northern.tech>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis <kettenis@openbsd.org>, 
 Patryk Biel <pbiel7@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Yang Xiwen <forbidden405@outlook.com>
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

On Fri, Jan 26, 2024 at 1:48=E2=80=AFPM Ole P. Orhagen
<ole.orhagen@northern.tech> wrote:

> This commit enables support for DM_SERIAL in the vexpress_ca9x4 boards.
>
> When running the board with the DM_SERIAL driver, the board ran out of
> memory in SPL when initialising the DM serial driver.
>
> Thus this required an increase in the pre-allocated SRAM memory. I did
> increase it to 0x800, and it now works graciously.
>
> It could probably be set lower, but I do not see any reason not to use th=
e
> available SRAM at this point.
>
> Also adds stdout-path to the 'chosen' node in the device tree.
>
> Signed-off-by: Ole P. Orhagen <ole.orhagen@northern.tech>

Nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Are you using the actual hardware, or QEMU?

> -       chosen { };
> +       chosen {
> +               stdout-path =3D &v2m_serial0;
> +       };

Can you please send this patch also to the Linux codebase.

Yours,
Linus Walleij
