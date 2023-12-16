Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36500C46CCD
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 10:47:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9659287661;
	Sat, 16 Dec 2023 11:47:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H69qr5Jq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DCD487661; Sat, 16 Dec 2023 11:47:45 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DC0C8764C
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 11:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-28b1478d85bso266258a91.1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 02:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702723659; x=1703328459; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FRdI7DVZWd+aUV67bns5qMZy7Jit5Jtw3VJk16a1ZA=;
 b=H69qr5JqmzMVZWQ3l/J2qEi7f3+X/2RCJtcEwl+/XrKeh4mkUNTpsF8ZFQybPXR5/h
 iwHV0U3rRKMb0X577yICp8v3ACJOdEDbeGq8HIMAKo0XV1Gca+rd6st8t7Mt5ov4pPbp
 TP8Mc06ZRNvba8M1GQEv5nYcmwG7WaVhFiVnkr1IuOGZcHrKUhugPrkCLdUmxebERYpn
 LokjbGzF/rO/RMVHO/xmwZDWu/ztSavVebpTIlmHwCKqNkhg35H0u8A2H1i/xT6XRVV9
 XZucwPS9ZKic9xK2I4t5cwZeAGcgjtuGOD5OOgZANjSR8XHgyryukYGK5NjBVVsO3A5G
 PY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702723659; x=1703328459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7FRdI7DVZWd+aUV67bns5qMZy7Jit5Jtw3VJk16a1ZA=;
 b=REaWsCMo0GxrRw3kivB+mSc6nU3WVH99Nh5sZTpkARFfaxfHlMYTCOdiA2Y9pAO9w3
 t9mk8X35K2uiT/q8IN6HmsnPcV9M75/L5o2AcBzQyFB9ssqvcG9JQ0069aMMZQFoiVL3
 MI61G1tUKIOe+1inr7TQJqgUtJZ24fgp9WrCMk9gZ0054TYc7CA+LAW5aYgmcawn1MJa
 9hmqf/d4m+hPw+3GbAv7mcYzn9xyRurpfCWdewMM9eMOJ88aflIH4ZQuYq9vkpxS+9JV
 1GZfT3dYBcSAXpm+m8ICS2njtfcXgglMQ+bmqi5BCMLfwB3/TThds1kUjbbzmHKl6+bz
 Ph6A==
X-Gm-Message-State: AOJu0YyXeqogTHUx92acOjNF0hvPHfM/9Rq27KQkYtyuGXpx2wAAT2gt
 GaCettZZp/x8HAqorIeAEox4kg3GP/QT/6ZIvph0eBKx
X-Google-Smtp-Source: AGHT+IHYXzFk2XfoHWHG99/YDhfNnVkCkLwIs2apPhhe0JGPq5sxhThjtUMPjjLLrPZti7k0QbzqiiMeQE10NzOasW8=
X-Received: by 2002:a17:90b:a4e:b0:28b:4007:a7b9 with SMTP id
 gw14-20020a17090b0a4e00b0028b4007a7b9mr2573697pjb.4.1702723659538; Sat, 16
 Dec 2023 02:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20231127193658.685119-1-tharvey@gateworks.com>
In-Reply-To: <20231127193658.685119-1-tharvey@gateworks.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 16 Dec 2023 07:47:27 -0300
Message-ID: <CAOMZO5AFLgZDYFmpymAfxSjXFZr9Yd9S6A6hkyLgdv=68kGXKQ@mail.gmail.com>
Subject: Re: [PATCH] arm: dts: imx8mm-venice-gw72xx: add TPM device
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>
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

On Mon, Nov 27, 2023 at 4:37=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Add the TPM device found on the GW72xx revision F PCB.
>
> This hangs off of SPI2, uses gpio1_10 as a CS and gpio1_11 as RST#.
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot-imx next, thanks.
