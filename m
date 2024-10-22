Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA36D2C54B
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 13:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D217C88EFB;
	Tue, 22 Oct 2024 15:06:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y+Rashyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E048888F31; Tue, 22 Oct 2024 15:06:35 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F412F881C1
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 15:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539fb49c64aso7894726e87.0
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 06:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729602392; x=1730207192; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uP9XucXOx5JqZOSjrhnWMEaqJvgx5qKja//0fhhqprw=;
 b=y+Rashyprnp0OmTQ0LgRldKD62/evr5oWxP/NmZx6F7RxvBUafhSVkfatMoESkmzr2
 nPVvNaaUarMuj+Kq9tu9db5VWyH0JqIyGEauEfpEiMkB81eb/AKL/34NLJZcMjLLZ5h/
 YSq24fWtnCnKEhGdSYqw/tg8rMdDgAEMBHiaHcuAMpmCTFLahklufqO5jjCb402+KjOk
 0kQEaWFXCSBnpZvM25JmhUSg+wTAoZEkPBiktlrCCW6z6nDVNbtQ1MgN3iduJniEErwT
 m9v5ZmLbDUNJchUyttb0HSxYba+ZwojCRfMrxs/aObEtnJ2QsffabdQ1ZxRMUy5PR/cm
 QO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729602392; x=1730207192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uP9XucXOx5JqZOSjrhnWMEaqJvgx5qKja//0fhhqprw=;
 b=ET586sLILAOLQwA6GZ3sZBBpKq1m2F0SSF8ZtBEh7ti9zwTphPccUQEZyI1LjnHCYh
 foLr+gDYOMnliYKzfJ+TGXZRALW5ihN6zi/kKWf0VOcoJWemXTRmHbOi4vrdblRzEQ4w
 CmfT9sQym6LfaiO2ngeFmLp7oTZp1iMahcTcE5gQO3UNtMVVDU7h75XHXEmfQbpWf5rR
 InqI2qL1xlGOB7ATFbfGg9wOaceVOph5D9gGQUmmkGqCbtRK2XLWZgHUVIboV9Nbaf0q
 CdHsyTlnGfua8OSi8qNdIeb+O5XhpRDzHQT6oKBmF1dYSFDrRJdC5MYMHApUZLWyVU9n
 QCCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUySqDgLxglBq0VHxYozHn2Ntnwvp+QaPTmVg10yqb+PLb1BWiK/Rrwuucu/Gm+6ZyOWK3pvG0=@lists.denx.de
X-Gm-Message-State: AOJu0YyDuM+asmk/aaLfNKPgKs0G6874+gF0vuOs8BsW1Z26IY4pwKbE
 16PJM7lq9cAEsdrkZtfe0u2/y6N/CeSwFgrtGQxpQjir/L7XaNpxmxcHgPah74jRP4HIVPlgnMy
 lHqwv1NDTFHR39360j7UCNBx4EnmMYSvMNwaz+g==
X-Google-Smtp-Source: AGHT+IFx3QLZBor8cjLoEWRtRMYie+2fD9FZTqkyZn++NANg/VRA3ppHjJSg/nTJO1m80KaDClo8OtR40YBXINy7EeI=
X-Received: by 2002:a05:6512:1294:b0:536:53e3:feae with SMTP id
 2adb3069b0e04-53a15340876mr13309542e87.11.1729602391898; Tue, 22 Oct 2024
 06:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241018142235.715571-1-ilias.apalodimas@linaro.org>
 <20241018142235.715571-6-ilias.apalodimas@linaro.org>
In-Reply-To: <20241018142235.715571-6-ilias.apalodimas@linaro.org>
From: =?UTF-8?B?SsOpcsO0bWUgRm9yaXNzaWVy?= <jerome.forissier@linaro.org>
Date: Tue, 22 Oct 2024 13:53:16 +0200
Message-ID: <CA+NB=mZLDY0yRsOBfYAucDhZ-02hx=w6iNJbRLJcUy1ZJZOirQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] configs: Enable htts for wget on qemu arm64
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Wei Ming Chen <jj251510319013@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Le ven. 18 oct. 2024, 16:23, Ilias Apalodimas <ilias.apalodimas@linaro.org>
a =C3=A9crit :

> QEMU already has an lwip variant of a defconfig. That defconfig
> is also configured with mbedTLS by default. So let's enable the
> remaining config options to enable wget for https:// as well
> and test that codepath in the CI
>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  configs/qemu_arm64_lwip_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qemu_arm64_lwip_defconfig
> b/configs/qemu_arm64_lwip_defconfig
> index d3d8ef16e668..754c770c33fc 100644
> --- a/configs/qemu_arm64_lwip_defconfig
> +++ b/configs/qemu_arm64_lwip_defconfig
> @@ -7,3 +7,4 @@ CONFIG_NET_LWIP=3Dy
>  CONFIG_CMD_DNS=3Dy
>  CONFIG_CMD_WGET=3Dy
>  CONFIG_EFI_HTTP_BOOT=3Dy
> +CONFIG_WGET_HTTPS=3Dy
> --
> 2.45.2
>

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

>
