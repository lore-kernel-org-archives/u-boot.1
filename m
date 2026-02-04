Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A950E8B383
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 00:23:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DAE383E81;
	Wed,  4 Feb 2026 01:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bgDFSw4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 499C283E88; Wed,  4 Feb 2026 01:23:16 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AEE783BC8
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 01:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64d1ef53cf3so7844195a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 16:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770164594; cv=none;
 d=google.com; s=arc-20240605;
 b=jwkd4A3UpHHp8IaT/yA3kJnRXgvvcPoHSttq5h1Yl+88YPUajAae2/2vN9kqkrqLxO
 bqmLH4P6CECUyZyE4auLm6VMs/xVIUDBXW/wIuSdXCQWrFJ9T6+0mGhNNO55RIbQV93N
 ARrhJlmWqK9JG8mvRwdzH0osodM89vC0vCG4oPechFYGHqC1A9P70FCdlO3U96LqarhH
 qWZfcf/HQmYy3l7kYM4X4A5vYUFaiK8Q9Iegz+w5Z8I0XeCF9+IgtaFUUvnuIhHs71B9
 bsIKvPWg/Qj+XE3kxwDegetWvDQs0dVzyPVd7WDUGL3gBeJTRRCzSoSdPLIBOLq9Hx7K
 anSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=66R07GeY/UTRvCKA3h41oefwyKricpf4DH96B/h6hro=;
 fh=wE3PiGA6PA99qWJDmLp7aNgqI0mnO2WOZTd9Pm/OHdc=;
 b=ZtrmrG/h3AlPDRWEVjrn3umQIgjg0oS2h9MmQf/YMVpurUUZFiNxvAHpSkREX816ly
 oEmttmj6lYgBssnQkq4jbPjKEoHoK3aQ9RML9NeBX+qYijDGEcEDtToQb+E5Xkc228cr
 P2QyLET/j1lxV15W51rqZ5ru1c3FqHNPRVG0SAfLp0AqIEku1Gsi6rWh4r2vuqyVCvSt
 NYZbd+uc6bcFATj8wojQOFLqnLEHIBF1nW4y6nnSXDBvnPJ4e5pHB6KUSGrX6S6FlpFl
 KGVEryH4Ol4yW2Cv7c2jQ9VrorLMQAa8YOostGjkUwUSAqePapl2fvWEuwxPZDwtlDlG
 d91g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1770164594; x=1770769394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=66R07GeY/UTRvCKA3h41oefwyKricpf4DH96B/h6hro=;
 b=bgDFSw4yzEkFM1pVHIDHljKUnuUiyN0VRdU3fMw0f+Nq5V1BD4IYxzocTab3H9z2zb
 NLqhNF1PID5nhX35tXpS9SHdm4DQRMnGtaLeAWgWEYAcLuZPYAjP9h9Kroq/vMaNIbsN
 3+HqN+WwKn8TdJem6npz2d8NiF7hRMLm+LKgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770164594; x=1770769394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66R07GeY/UTRvCKA3h41oefwyKricpf4DH96B/h6hro=;
 b=jAEaXWyqpp7FTGpU0uGrLTO2YVmRQG5mb2mJ4qfZom8djQy09u6sMSNr9ozMmcTsHF
 rVj42SGiK1EkNfMXsVbFPm5nQhEKbKz5YAnq6i1zsmH9NZXUYYAowSHn8o3oJ2WqiyZ4
 piQaNa5YaidPnsXG5vc5kLaPiNUpk4OmwgFeZ00/EzC/N3yazOr07AcP+vZavORQwg41
 RQ9ICA2Ws6Ro4TXSVTp6eWlh3xli9JlNj/feZoNuoSE/d5Ka5Apv/2DE8rH49gPD4Jnb
 vAgtlJqKsAxlibqqt7PKlbYzz9b9k9sh/tjJa5tDPG/cidOR+zl/gGD2ZBxr0o34F0WC
 19Tg==
X-Gm-Message-State: AOJu0YxlDlUi8bOXkJx1UUCv22bUplPOLndwSsD68cdApI2179OrVUEH
 Ss45YuKmuvzBhwHSEJTCj2oJTqmKjs6b1qzO8TvVfhlitSe+m1Io3ZX8vRnE7V0eUfrZLbbp6b6
 mPIfAjGPJG3RxAkmky3zK0Yps4huOj9qiGdDYgBWe
X-Gm-Gg: AZuq6aKSPMJqLOAPFdcyIizskp4S9kjf0QeWtvfKJZvY8eVImQPkjtVKdfGW+PCjrIG
 OgVG9Dve9vodo3IGZly3nN98uLQDfLGocWkUi+uRMk408juU9SaymPsgf2b+wnsswUPyLTtbOkn
 KFLO/qYfIazrBnK8loR2fFMHA8hQPmqIpbx8AszIlFYM7fJaIM/AN8nO1j77EsJkGXL7Mf4ukog
 eLqqK2XNxaYCGGKaX4bZWF1tkVu8QLx44GAHvKIR7+rCV/jdgaiakMmIGzA54Pg4YxxhwO0
X-Received: by 2002:a17:907:e158:b0:b8e:a1bb:ebdf with SMTP id
 a640c23a62f3a-b8ea1bc071dmr28649166b.1.1770164593871; Tue, 03 Feb 2026
 16:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20260127-topic-musb-probing-v2026-01-v4-0-ea3201e0f809@baylibre.com>
 <20260127-topic-musb-probing-v2026-01-v4-4-ea3201e0f809@baylibre.com>
In-Reply-To: <20260127-topic-musb-probing-v2026-01-v4-4-ea3201e0f809@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 4 Feb 2026 13:23:07 +1300
X-Gm-Features: AZwV_QhKoea06TdykrY3PpRvm-F7eFtuiMZXbHb7ysGbytKEp7PpcycPFRnsDFY
Message-ID: <CAFLszThoBmdwg_Vy=pi9YNUvdC3w0vVC-JC2kNqpV4Tc4AJWzA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dm: core: lists_bind_fdt: Indent continuation
 debug log message
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 28 Jan 2026 at 00:04, Markus Schneider-Pargmann (TI)
<msp@baylibre.com> wrote:
>
> The loop in lists_bind_fdt uses an indented style for log messages
> within the loop and normal messages for errors that lead to the exit of
> the function. Due to the change of the previous patch that adds support
> for continuation on -ENODEV returned by bind, the log message should be
> indented.
>
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---
>  drivers/core/lists.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/drivers/core/lists.c b/drivers/core/lists.c
> index 813c3de52b23d78528686a7a8d9ecbe8cab62efd..2545dc142f6bc3d01dca1e0618055a64978734f3 100644
> --- a/drivers/core/lists.c
> +++ b/drivers/core/lists.c
> @@ -266,7 +266,7 @@ int lists_bind_fdt(struct udevice *parent, ofnode node, struct udevice **devp,
>                                                            id ? id->data : 0, node,
>                                                            &dev);
>                         if (!drv && ret == -ENODEV) {
> -                               log_debug("Driver '%s' refuses to bind\n", entry->name);
> +                               log_debug("   - Driver '%s' refuses to bind\n", entry->name);
>                                 continue;
>                         }
>                         if (ret) {
>
> --
> 2.51.0
>
