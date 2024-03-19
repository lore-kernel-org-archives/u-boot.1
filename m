Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC33C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 13:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5BE88076;
	Tue, 19 Mar 2024 14:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RVImw8mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D563388092; Tue, 19 Mar 2024 14:55:19 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4BC888076
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 14:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4765cffb446so1683922137.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710856516; x=1711461316; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oNP3iq74g2FskE0wScGk+ynBnkLz+MfNemu/yQRGxmw=;
 b=RVImw8mtv2DQxn5ef4Fz58WL2OFsWcWytH/q3Cc/IoXDTAWFuIOaeLdBoGwe4Fdm8x
 l05SE/42cHPjyP0G0jKj9JwjDGirxs87CrryZ75Il5VqrXiHiRMHhtg182U8ZAWcVWa3
 uyIAsb+i7p8bmHRnNoxmdlvHlFSl91L5o08G7nJ3PgVuiZDKPTHJd/aAb0+ZU296lH33
 CQvVBEbyH9+jilbyeW/TntotQ52LId7/gZ61LRNFGLq/NeZtGVqkyPNKfD2gP7+vLOrB
 JBrSq7/MkwdtAdFuqb3z9l/88b4/NFQjrAMPkH8VddCyR54Wt+f1S7g3BO+jx+U0fqIf
 zAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710856516; x=1711461316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNP3iq74g2FskE0wScGk+ynBnkLz+MfNemu/yQRGxmw=;
 b=dKXPV5znChJahtih8Q3sAcO+SNLLmKO4RqSujEI6oVVY+7sUBHDQIdAKKK8hri2fpf
 WYQMV2GeVsQrX0umNkhPTifnzTNwNOsw/vcXM6/rPazjLrEf1DPTNRMkxfh/gV/+BSl/
 cGEt4j85InQZxgQ+nK1TQ/dJVcD2yeRUMTP13cadimzAtnYxU9K7Susf+4Ev95LS7ioA
 GTZWZc/ANH9BoHx9JmedK8Y2yvBS3IvwPDt4+Qkj+7zC/Lf4ca0fqlBvZuzknuKJ+h+r
 JCSGFwD6QmRZ5EismCUh2M9KLUDUQ7qN8X9LuUsOXkU3QQJCeoWjo1KgyqAbXAShxi93
 nuww==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/ncbBFIcwIEPg+FEVY3cwWkNmnujAtfohzlzMU3AeHvt5hsxK0wa1+Y5+XYwgOO7BRqCcdwnRbOhXjapssq3XC/UlYw==
X-Gm-Message-State: AOJu0YzmbeaKeMZzeZvA7VuPyQmChP5+otsLKdbwlegoRajvOusVa5e2
 A32HH5K7PSsUGejNh/hydPpgevF0Crr7zBG6aMSZP/0aO9pOJkMTCZXRfh4ECQ45z3C/jt5hjgn
 W9mOaDDyCYx3cTwM1UCV7myQsT4TVj+/E42CX6oXyEQdQc9M5
X-Google-Smtp-Source: AGHT+IG3hJAphiWZMLHmHil+Sf2jVHLpGJ/mecE1MEJ7ZrGZKjffAJTa/w1+LXOj2ppikLWBKOm/Rcz2lqqJdzKqySw=
X-Received: by 2002:a67:b403:0:b0:474:d105:a5d8 with SMTP id
 x3-20020a67b403000000b00474d105a5d8mr10976944vsl.22.1710856515720; Tue, 19
 Mar 2024 06:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-12-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-12-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2024 19:25:04 +0530
Message-ID: <CAFA6WYN3MZ0Rh-XEEggc4OUk2wUQngT3EJDcHQb0-n7jxfMd9g@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] dts: sdm845-db845c: add u-boot fixups
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The USB VBUS supply for the type-A port is enabled via a GPIO regulator.
> This is incorrectly modelled in Linux where only the PCIe dependency is
> expressed.

Can we send a fix for the Linux kernel DTS to correctly model it? We
can then later get rid of this modification once that is accepted.

-Sumit

> Add a U-Boot specific dtsi snippet so that this supply will
> get enabled when initialising USB.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/sdm845-db845c-u-boot.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> new file mode 100644
> index 000000000000..3c83e21251c4
> --- /dev/null
> +++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* This GPIO must be turned on to enable the 5v VBUS
> + * supply on the USB port.
> + */
> +&usb_2_dwc3 {
> +       vbus-supply = <&pcie0_3p3v_dual>;
> +};
>
> --
> 2.44.0
>
