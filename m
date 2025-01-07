Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F70E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:32:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA1AB806D4;
	Tue,  7 Jan 2025 16:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i+pXcGvq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8A38069D; Tue,  7 Jan 2025 16:32:39 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B5B8036B
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so18602514a91.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263955; x=1736868755; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7Y1v+MlywGjXSCJRwlMDyvq5Y3JOElVtPTgPRw+0O8w=;
 b=i+pXcGvqan71/gR310VJkU34VWj0arVGz31WzpGnk05gsBo1kwcLuojgsr82a5FCBX
 fi1Wq+uaM1Jo8ImcaR7ELLqBDxaGB7UHuOrE2xi9wRfVVI+7OgnbwBvalLdAX1OdJS9i
 fwUJtSqPNWZsFqYrofaBLIuoeLGHFtEx28bhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263955; x=1736868755;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Y1v+MlywGjXSCJRwlMDyvq5Y3JOElVtPTgPRw+0O8w=;
 b=hQ+1f+Okoeq0Q9EVJHeyBS05+HW6LYpPpivMEens4vq6OCYz8C9NTpDsea1kE3PTd9
 rtWdr4BuLJsI4TA9BCCSHLPIIMrBpi+Iqp42/RmO9fOkWh9MoI002TnhYYy++hTZpMU2
 fmFnpysg4qrZvdnNa8ly2ejNmtjLjb+/DsiqL0lcLB/6DcO9MeNAiwRuaXGhDF7akrt0
 q4JPCiwAc21JGHMwv89A3Wb3z9s+eWUeBRI6p7j84Fb65qGEyJpaWMN0e9gDNrBtkeR0
 Qq1xYFVZ2w/NYPyKSXuayYdhnveu6E0P6QxeNK2vQiN8q2FgQJ+4kGOeKZZ1f3Yzp6Pf
 Suxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAlDBHhEnfOaoHrC/NjYOG01yEb+tuSAELh3QNvJNY47vmF878YQ3bQ1NydyUvO6qj/NosS6k=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6XVVvwBJoTy2QW6Q0j0/paHSurXtNpX03SV1K99xnVluxpm2e
 Ig2RfFeYwC5uSctF2ce9hamRHDc3qnY9j4SgjPcSdep3kB00KYfXRLzWj61vDEGhCVkZjjBqWwM
 TbkggA+9SwfpXUQ5RZJM+SyJNFCrZpyJQ/um+
X-Gm-Gg: ASbGncvRUzi300ATebzspFmEE0WIQ0E0jhRKs5M/23zYV12lmKhmcalxe+dkq/qvVN9
 VqUg+7RxeE638xyMYZaWHKmPi9Y4P1VQMXofUwUE=
X-Google-Smtp-Source: AGHT+IHuwVfD/SrIho8AxEwj011qC0X+sqG1B5JZ3tjj+UZ9WaDBIOOsv7+VGzNKiNl8LulePpW/ieIUpp5yJ/q9ROU=
X-Received: by 2002:a17:90b:2b86:b0:2ee:cd83:8fe7 with SMTP id
 98e67ed59e1d1-2f452ee9d18mr94393344a91.35.1736263955434; Tue, 07 Jan 2025
 07:32:35 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-10-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-10-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:32:16 -0700
X-Gm-Features: AbW1kvZaK_F5oGk30h9liphpBqTqtrlMldiKuYv_gM-bCt0Lsu7ECdQQoz3Idic
Message-ID: <CAFLszTjh0PrTa_wxUA47wBxfe5iBVNg2WCQ2LxMSn1XLMQzfnA@mail.gmail.com>
Subject: Re: [PATCH 10/15] soc: qcom: smem: add build infra
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Build the new SMEM driver port, and select it when ARCH_SNAPDRAGON is
> selected, since it will be a hard dependency for Qualcomm platforms.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig  | 8 ++++++++
>  drivers/soc/qcom/Makefile | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 4aa7833930c7..ee3d299eebe6 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -23,5 +23,13 @@ config QCOM_RPMH
>         help
>           Say y here to support the Qualcomm RPMh (resource peripheral manager)
>           if you need to control regulators on Qualcomm platforms, say y here.
>
> +config QCOM_SMEM
> +       bool "Qualcomm SMEM support"
> +       help
> +         Say y here to support the Qualcomm SMEM (shared memory) client driver.

It's not a driver anymore, just support code. With that fixed:

Reviewed-by: Simon Glass <sjg@chromium.org>

> +         SMEM is a shared memory region that is used to pass information about
> +         the hardware (e.g. DRAM layout, PMIC configuration, etc) between bootloader
> +         staged and the OS. If in doubt, say y.
> +
>  endif # SOC_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 78fae8bbfa16..f4102f9155a8 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0+
>
>  obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
>  obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
> +obj-$(CONFIG_QCOM_SMEM) += smem.o
>
> --
> 2.47.0
>

Regards,
Simon
