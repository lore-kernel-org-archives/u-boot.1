Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD01D6EBE2
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 07:12:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C558938D;
	Fri, 29 Nov 2024 08:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PyfA39xS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C4E289383; Fri, 29 Nov 2024 08:12:33 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB6698938D
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 08:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4af58808485so397529137.3
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 23:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732864350; x=1733469150; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1iPiEUqnOQlFWseu56TchibAwQ+GQQUKZZE/wydrlZM=;
 b=PyfA39xS/vub816u/7++gp5O9Fz7KHae6o1QYCRt+0mGVYRQmnoXJzrkMuO81PQMY7
 kOC8tF6sbnuB9Bg773l6AQ7YrXqAxRzDTx/A/N1PqvgsqG2yQ/QX5SB8vr9o5YJEC+Sa
 idMmdQ3N7RHo3FPg1UoM4DILiTvAWjvKB7Ju7MRo7MZpMVyRx6YQgminnCVvyjI/uLow
 oJu+MHVJrZKkQd29DtUAfFcUtLNha1xMZp5xaRUyue1XSe/X8wqPlJYdKLXI1I40KxUl
 g6JvEvCf3IffcO+ysmrGAw79llJya7A4NkgxKkCQjHxhF+5V2B39E41qhvpLiYAzxzmY
 +FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732864350; x=1733469150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1iPiEUqnOQlFWseu56TchibAwQ+GQQUKZZE/wydrlZM=;
 b=JjCd9m7aFAvcEt+LQCfvoiBEeHNjXm166pZM5veXqo8SdPWTEKrcmQ+YIHxuu0VnYW
 BuyQnOvLlT6Lu790XvSqKX+08ksdRCCG5JlD1ke3us5GjASlnFb19QMhtYzKvxBiQDF0
 +wBPWjnkySDnzf5o0i4JPO8FTIpFsdUwzbT0oJgRrBIJua3W1W/BAiS+PyBycNp9l5q3
 yietuWPrDI7SDfO+lR9jc1GqweO3yTnsyegiKcHOQUtm9iuK3cSJsctnLKNmQVNIKwNW
 vRttiFT16ktIekExz8aivVtWZBt31UC51FiVIxrTN9nbwhD0tpjxjntpEtTme9onKh5W
 v5kA==
X-Gm-Message-State: AOJu0YzclTQOBm2lLSwHzIk8IozOlnDbMqYUYh3n7n9+OmwBS+Cci5Zq
 HdVkXZHnx88qWb+fLRvCOhiesMt7YAShZg+clQ1Q+BnpcrtcUF1Efpo4JWcIaKaK/pnrsRjXwAD
 +Dt7VLCWhkMs9NtA86ael5L/smbCxNKuULG9+fw==
X-Gm-Gg: ASbGncsXrva6fj1E2CBLRIroe9+b96in1Zp+U96lc+2caUeUG/1CjGJIYFY2+34m8sQ
 YZxAz8eOhW7T0BKg4zF2y4OvMB1WUkEdy
X-Google-Smtp-Source: AGHT+IFtFQUffdjv/sZaG3/AVcLIY0phOLJ9ePbVOS6f00Rih0njlMLpBezE60M7kJ4DlsC0D0D33PKqt6kwaGmjo6M=
X-Received: by 2002:a05:6102:c04:b0:4ad:5940:340e with SMTP id
 ada2fe7eead31-4af44a47b37mr12598459137.21.1732864349769; Thu, 28 Nov 2024
 23:12:29 -0800 (PST)
MIME-Version: 1.0
References: <20241105230724.159755-1-marex@denx.de>
In-Reply-To: <20241105230724.159755-1-marex@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 29 Nov 2024 12:42:18 +0530
Message-ID: <CAFA6WYME8D9WkC_0gDLT2LKOPk4EXULKgxtdniVKTme5j+uMag@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM
 on PDK2 carrier board
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Shawn Guo <shawnguo@kernel.org>, 
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Fabio Estevam <festevam@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

Hi Marek,

On Wed, 6 Nov 2024 at 04:37, Marek Vasut <marex@denx.de> wrote:
>
> Add support for the DH electronics i.MX6DL DHCOM SoM and a PDK2 evaluation
> board. The evaluation board features three serial ports, USB OTG, USB host
> with an USB hub, Fast or Gigabit ethernet, eMMC, uSD, SD, analog audio,
> PCIe and HDMI video output.
>
> All of the aforementioned features except for mSATA are supported, mSATA
> is not available on i.MX6DL and is only available on DHCOM populated with
> i.MX6Q SoC which is already supported upstream.
>
> Backport from linux-next commit
> c3f5d76a6e03 ("ARM: dts: imx6dl: Add support for i.MX6DL DHCOM SoM on PDK2 carrier board")
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> ---
> Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: Fabio Estevam <festevam@denx.de>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> ---
>  .../src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
>

I didn't realize earlier that this patch is directly modifying
dts/upstream subtree. Modifying the subtree is likely going to cause
conflicts with the next subtree pull. It looks like this board is
targeted for v6.13 release. Let's see if we get lucky with automerge
being successful for this one but let's try to rather use cherry pick
or wait for the board support to land in devicetree-rebasing tree. You
can maintain U-Boot DTS for the time being.

-Sumit

> diff --git a/dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts b/dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
> new file mode 100644
> index 00000000000..38235925257
> --- /dev/null
> +++ b/dts/upstream/src/arm/nxp/imx/imx6dl-dhcom-pdk2.dts
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2024 Marek Vasut <marex@denx.de>
> + *
> + * DHCOM iMX6 variant:
> + * DHCM-iMX6DL-C080-R102-F0819-E-SD-RTC-T-HS-I-01D2
> + * DHCOM PCB number: 493-400 or newer
> + * PDK2 PCB number: 516-400 or newer
> + */
> +/dts-v1/;
> +
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-dhcom-som.dtsi"
> +#include "imx6qdl-dhcom-pdk2.dtsi"
> +
> +/ {
> +       model = "DH electronics i.MX6DL DHCOM on Premium Developer Kit (2)";
> +       compatible = "dh,imx6dl-dhcom-pdk2", "dh,imx6dl-dhcom-som",
> +                    "fsl,imx6dl";
> +};
> --
> 2.45.2
>
