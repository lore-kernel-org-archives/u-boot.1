Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5AFC54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 06:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B88187DBB;
	Tue, 19 Mar 2024 07:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f6KEUdUm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D1C387E96; Tue, 19 Mar 2024 07:22:11 +0100 (CET)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A8D87D66
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 07:22:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-47670e6a204so1460103137.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710829328; x=1711434128; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qux/XOVB7SNeEMolAW9v0i3Ih4/cet87ec5BSuLQwPM=;
 b=f6KEUdUmjsuWAL0lAEBi4NyS0lOAYM1gVHlcXgCUYvR+DPRjm/OXV1FytxwhpIemW3
 sKJj7KDg7Ral7QBWMJc5sLhsdG1wkWED9VCRcFPrGo2P+eX/tefrEj2gZrDDT+w0lHG6
 DM8tfhRCk/rbMxOAQOI4Tc8hFgzHZ//5y14gVPZi4pN1yPi7ZrJGBe0xmotFZQ1XG1fV
 0N8KuEYsxdZtnY+cl59M7vYEthDVUGKk35jmgBF52HrsFZdsbeaOJ+KgaEplfBLxVbxJ
 IaMCa97hL7cd0qHAVk5+oilbIha68qqbcxmyTq/WQwLXnVHX67CoToMkJ7EdVVSucjcL
 7gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710829328; x=1711434128;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qux/XOVB7SNeEMolAW9v0i3Ih4/cet87ec5BSuLQwPM=;
 b=UIUeSgy68FBryMFzUfcEWJx3hZ/dsrrJngPOwfWYZaYs9p6wmq7j4aEQWUnjOsJsfS
 ualM1m4nYoiUrd1UJ6UR/7mDWqUJsOdQMaCnXY8oi/0t/H7LtH5Kr1uwCpHXD1mYPvZg
 cR1AG6YfbfdfkJYd7JY/K1GFIdFi6nng/zCtniAeOtggSz+Iz9wwlOXD114obhXzeJr6
 jFTX2iekapIYe1W7qP7nOHZxhXn00kSsD5PwPx+DGCyyQf4mCGztAuEQ8cAvUizoR8D7
 vHccECC/f1fr6ExAvxvgmCN3gUdMiTtUKsAKcPcBtX5MeC2jUHppM0KJIf3Wr7RcXCkU
 0PAA==
X-Gm-Message-State: AOJu0YyOcFbBXyBW5BLrpCel9qQWQ0Jvxowg06MIz6jdOxhg7HiNyADD
 ys5Rfb5jK7djYlAadEI0sr0h7o2P6TlZDxYqnf94UdfU8v4dKUhV7JI6Yvs+1H+4bGrbJUi+wXe
 bcR2vuOpchI/Vb0tjCEX+oK9XF7RPp2vBooI3yw==
X-Google-Smtp-Source: AGHT+IEpHb8CMlpBOO6Ni9kU1W9LApX6ynsPLQa5V5dp4RqfLMnteD7pR/DYEhwYVxiu79vB4bYSMxAFNMxHG48keng=
X-Received: by 2002:a67:c401:0:b0:474:c82b:9906 with SMTP id
 c1-20020a67c401000000b00474c82b9906mr1179128vsk.3.1710829328213; Mon, 18 Mar
 2024 23:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240318150318.8292-1-marek.vasut+renesas@mailbox.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 19 Mar 2024 11:51:57 +0530
Message-ID: <CAFA6WYOjswD1UkNKR1ob=Jh_Nsm=_0pi-UB1_9CQaD0NBKPmhw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Add missing OF_UPSTREAM Makefile for 32bit ARM
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>
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

+ Tony: Fyi..

On Mon, 18 Mar 2024 at 20:33, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Copy dts/upstream/src/arm64/Makefile into dts/upstream/src/arm/Makefile
> and create a commit. This makes 32bit ARM buildable with OF_UPSTREAM .
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  dts/upstream/src/arm/Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 dts/upstream/src/arm/Makefile
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/arm/Makefile b/dts/upstream/src/arm/Makefile
> new file mode 100644
> index 00000000000..9a8f6aa3584
> --- /dev/null
> +++ b/dts/upstream/src/arm/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets += $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS += -a 0x8
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files := */*.dtb */*.dtbo
> --
> 2.43.0
>
