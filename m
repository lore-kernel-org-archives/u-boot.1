Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED2BC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 13:46:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86F81801CF;
	Mon, 20 Jan 2025 14:46:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hnbD3NaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 753B6805C5; Mon, 20 Jan 2025 14:46:38 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6159180077
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 14:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53ff1f7caaeso4892561e87.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 05:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737380796; x=1737985596; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tu3AFiXh/b3fr+KVFiDsSkq4NwR0M4i/nuTi8XntMfU=;
 b=hnbD3NaOrqTvzP+qPvP/BA03Dv4c9TJaVjS0uLkdJbUpS31oA5dLlPLWv9ooFRBaAj
 BrhU4e5UKGqiYolsR468oj7GC4IJnnWUWdByoHV+oRbR26n0SkYpq7QHYSs+qIh+edKn
 4+1BGcgURux/NIJhh9EPQpmqbAyi/Yh6KzmZDZ/3asi9Scj1FX0NFMnqaFs0VW2uLQDF
 ipYEQAy+z0vkGhpzDmSvqdylOLQRfyS9RtCOD67/tx54+I2m8UOeNLbUIaVw5bZUOWet
 ubwcTlkvySOvDzkoNHQkJZ0KvUz/2isCAArx62fbosWzloQWsNUM6/36H58FDwVPanuD
 +4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737380796; x=1737985596;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tu3AFiXh/b3fr+KVFiDsSkq4NwR0M4i/nuTi8XntMfU=;
 b=vTIxDcdM5WrWg5D4aJr3l9F7P7ILKfGPbtnwQvT2ElihGgXPRVUJ4OXHwflfB4+HUy
 WAt5clkXsQucknm3qfaSb0pCl6rO0WQEgjz6ofb0ovZppM6fz/UYFFiv6RffmOY0y21c
 wQTV2EEE+OfGm68+oyS+9tjnBMtbOA/Jkk8TLnps3yQn49015Uq0oLMdf4Uw9EkR+Esc
 sxj8z0du34CxrePiaMCkLK0XSPcxYYuWDhZStx3sNzwK3mumnY6EVq/nQmocfJZt63MW
 vgPje6eZ2IB1kqQDTeY6sWC1X4qn+iryJgJ33MAzZ3UEmvdKbXvINXFaRReCPCXLtSIm
 8sTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3Uofp/3hloIwygFD0bZpPUbFUsBwS1eYKzFnis75OpINqFYcH+6aIt7KFbLkTT0W349EICU=@lists.denx.de
X-Gm-Message-State: AOJu0YxQE5yrD/USaMYpyi1rcekf0AA+k2425/DpeGH5n+TZ1sVNy0sQ
 CrYwegqCNcsrNe5uSXgdc4Dq3gGANjRRFiMGd9zWfRnBpAKEdNfIJHjMGO0UBlxlxrXluIx1ImM
 DYDEA7lGnyxf/tI7jWvSA2JBqclU=
X-Gm-Gg: ASbGncvwTzejz9tYOtFLfyhCmxlEE3z7XGM3+B0fE5Nxk99wHAJ96m6o+L4Z3F7+FXF
 5kvvSDcJWmgBL4h0+uPi2+R68ifN2ZyaT3E4v37Uwv8PWuUMW8VUaQR1SnXC4phESAalSkLkrSV
 Pwm5fcJPM=
X-Google-Smtp-Source: AGHT+IGiImTwNlOXZiPh0eq0SQyse3zcGV6uNshZgfQ5QGtb0JMjrsSwbNDOlvLjD+jQkr6/crbruycanewM4Ur2g3o=
X-Received: by 2002:a05:6512:3084:b0:542:2137:3a31 with SMTP id
 2adb3069b0e04-5439c24126amr3913418e87.21.1737380795305; Mon, 20 Jan 2025
 05:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20250117015642.2373824-1-festevam@gmail.com>
In-Reply-To: <20250117015642.2373824-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 20 Jan 2025 10:46:23 -0300
X-Gm-Features: AbW1kvYSCI6KtWsBZvzwGFQZ6smXx1q7yERbe0s6gUm-FPpXOFfaD46vLVjAVUg
Message-ID: <CAOMZO5Cu20HAgUsCP8Gb6MG4LtMs0z+8G16M3-oGWW4FcpEt+A@mail.gmail.com>
Subject: Re: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
To: trini@konsulko.com
Cc: uboot-imx@nxp.com, peng.fan@nxp.com, y.moog@phytec.de, 
 u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
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

On Thu, Jan 16, 2025 at 10:57=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>> Guard binman nodes with CONFIG_OPTEE to fix the following error
> when building without optee support:
>
>   BINMAN  .binman_stamp
> Image 'image' has faked external blobs and is non-functional: tee.bin
>
> Image 'image' is missing optional external blobs but is still functional:=
 tee-os
>
> /binman/section/fit/images/tee/tee-os (tee.bin):
>    See the documentation for your board. You may need to build Open Porta=
ble
>    Trusted Execution Environment (OP-TEE) and build with TEE=3D/path/to/t=
ee.bin
>
> Some images are invalid
> make: *** [Makefile:1135: .binman_stamp] Error 103
>
> While at it, only pass tee to the loadables lines when CONFIG_OPTEE is
> defined.
>
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied, thanks.
