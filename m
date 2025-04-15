Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE95CC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 13:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40EF68209C;
	Tue, 15 Apr 2025 15:35:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DcZuGIUq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A344F82A96; Tue, 15 Apr 2025 15:35:41 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994B3810F4
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 15:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5f3f04b5dbcso4887575a12.1
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 06:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744724139; x=1745328939; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tjuEzGbY8+asJq+627u3/lXKMj+s0oRfRvfhiqW89Gs=;
 b=DcZuGIUqiTq+Wxgcmk50V7gMjRmA1G1P8WviIIuh+Ceq54R+uEVWX4aXeO8bjf0IGP
 BvIyPnbuMWkhJwM6+Pdjr2wmhS/t4MIsA87Y1pvDYz65DQM7RhlJMejFHTjhl4jgZZY8
 DRTYX4rhc7fdEw9aj8tkKzXrvXV2PRLOHboP+G8sOC7QZ5A8CjHIO8WAWSXx53DGrktm
 SNwva1ijQPGEHdbDzWC7XoiOeUdjliidRlVrMUUk1piFEKgK6fsmtPXsu+2Pa8FqVBdn
 boiTjgeeJJ9HkagF1V/YlNJnQ2EPRdZAQrLxbQq4I2U38nDmbj3YOVRG98lRo+xZPl+G
 6Ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744724139; x=1745328939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tjuEzGbY8+asJq+627u3/lXKMj+s0oRfRvfhiqW89Gs=;
 b=gcGXmIIEnD8HSTsJS82ULFhKT7+5nXxbe0MfE6ACfhJ2UpObsraldnOImL/wRpdiXZ
 nCFNf0+JALEUYVyZK7fRgEr+GfMv32MVW0C+dAowCF4dofEAEwGobPXLFTYFMWWudJca
 MHTPQqKpscEFNeEYk/sA+Qjk7V4MpCudQxAZd7hMLESiG9/ZX9iPUD79Hm2K2GBofQp8
 JwiMjPfBH7zY8obPv+L0N/S3VdPuEydgxjjXca4r5nfZBUJp8iNYgN+fXh4+jtgKzU3A
 Y3HXx9UVZVG6GRXyQNwxCmy02YXYAtHtqgRdTQX6nUOgvp9NVPaKdG4Ap0pmJ4ZXS9cA
 wBOg==
X-Gm-Message-State: AOJu0Yw+CcFbgzK1c2MRvGjC60ep1r2pP5HkxKAHkA2VfOfWkot2nieE
 y6KzUvxVTmFV5sDQ0DZeyB6hisqLpWWMZqxSg91VnLKBp1Vqms20VxW1Nw3cJrEoKpFiCclpRkI
 RUFPRY7uXOjbaKknaB+erFDVxQDc=
X-Gm-Gg: ASbGncvr9bX+YEmYhZrt4qW1L11a5RPi7XNNw+qMI8flEBEUJMJpPv9ZV0W8VsLg3iH
 GuSg57/FiUQN5k2TpEJ3Vegq1tVtvClGklKPEiSutntbNz7ysR7A34ra5XmsFqxYLiQ4PKwrVXT
 3BIDXsyVtsE0zFf2e2SMgQqpjiqIaOmnu0oD8S6d+Jo3Ap4skAXc7IOcU=
X-Google-Smtp-Source: AGHT+IFIzwqOFVa8HAU228zw0jSMFroP1KaWMivhApGA03xpCx1G/3IQUW8TUght6/T2wof9zG3UquD32mWXjetUMqY=
X-Received: by 2002:a05:6402:84d:b0:5e5:c3bc:f4e0 with SMTP id
 4fb4d7f45d1cf-5f370118051mr11817383a12.29.1744724138685; Tue, 15 Apr 2025
 06:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250415083017.3523317-1-brunosampaioleite@gmail.com>
 <20250415083017.3523317-2-brunosampaioleite@gmail.com>
In-Reply-To: <20250415083017.3523317-2-brunosampaioleite@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 15 Apr 2025 14:35:25 +0100
X-Gm-Features: ATxdqUFaRGjQd6LrNdTQPUH_EXSJaY6PsqZ5CaGz7OQU2VrTIUrS8dyqB8PUjeY
Message-ID: <CALeDE9MdZSrfNeSicy2dXdVOROLMQ8Hx7zzJv=Cnptxm_kxUDA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpi: copy over uart clock-frequency in DT
To: Bruno Leite <brunosampaioleite@gmail.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, clast@prevas.dk,
 ravi@prevas.dk, Bruno Leite <brule@prevas.dk>, Fiona Klute <fiona.klute@gmx.de>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martin Stolpe <martinstolpe@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 15 Apr 2025 at 09:30, Bruno Leite <brunosampaioleite@gmail.com>
wrote:

> From: Bruno Leite <brule@prevas.dk>
>
> rpi5 firmware sets uart_clk clock-frequency in
> the firmware and patches it to the DT, copy it
> over when loading a new DT.
>
> Signed-off-by: Bruno Leite <brule@prevas.dk>
>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>


>
> ---
>
>  board/raspberrypi/rpi/rpi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 70d3c35499b..5c84c324c71 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -602,6 +602,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>
>         /* Bluetooth device address as provided by the firmware */
>         copy_property(fdt, fw_fdt, "/soc/serial@7e201000/bluetooth",
> "local-bd-address");
> +
> +       /* copy uart clk as provided by the firmware */
> +       copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
>  }
>
>  int ft_board_setup(void *blob, struct bd_info *bd)
> --
> 2.45.2
>
>
