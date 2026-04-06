Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8E6F46C5A
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CBAA84142;
	Mon,  6 Apr 2026 18:50:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FgusuEkC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3468083E36; Mon,  6 Apr 2026 17:54:08 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404698341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 17:54:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-66e6d960ff5so3311081a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 08:54:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775490846; cv=none;
 d=google.com; s=arc-20240605;
 b=iHs0SHQG/Hk+wPp/uyOcHWmo6t8KmUoFgP8qJ/rloK1eP/3K6KFmCsjgdSZXCzVt9N
 51U6ec0lDEhpWWRgQACiHSLU2ZkOWoWdCz274KLOmwWpmTrVrSNkD3iYhtN0rH2Q5YO0
 zBwSqDTnAvHktGeGK+chABGPzU9iQ3zaeaG3GR8eN1XxqX5CF2HO9ftgpZhfC95G+IhQ
 g/sis7/tclOUFLopqfFogFqDWziKkFbyEdU+ur4x3iKhWyn9/M2xXfzCl1JrR2wkNM8S
 u5LID4nEXZeuFgRp3gT15zGj6gKttFXfvHBzRxctmezTh68GMDLG34Jh05F4fyjhmId0
 vkiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fnzUcXBOM1Kco8+zP9Rz/e4BJKK9Ko0sAEw0RXMEqqE=;
 fh=lajVl/IeoACZS/6yuLfZkN/hPyImAZ81vhSDRfkAdyk=;
 b=kkbM+QwJpepxtEqsftkSomCqyAVvyLNFq3LiO8SbStuNRncUPnexK8AzrIPjUXAFy5
 fJgJo1DVffuxNZLh3cB9qB+b45v27vyJvH8x/O1mW20TEHWuWBJPDSqYDB/kYoiZ65pZ
 s7+LRMOJCWw8MYdzxB8sEtqAb6UUGCnkje4aePBFkwxLodFxE5su08UxzpA4tMJ27KA8
 0Ta6u53zZsixMUrMblcOjYr0QcjslYqRY9fUaJHYj0USwwnyzvFDZ1DlJnTLxhxSDT3t
 48HOtcOz1oxSIdKHB0zvlSPtFmNAPL8n9tBk2gwkI6DF9yqmMRHFRj5tqGDxPMN15yT/
 fVNg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775490846; x=1776095646; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fnzUcXBOM1Kco8+zP9Rz/e4BJKK9Ko0sAEw0RXMEqqE=;
 b=FgusuEkC9ebT4qY1b57Jg5V3XeKBQbFrbQOxn3SFlJCLgPFA5sghz1hfG9WcsK3i5R
 5cc6PHeqvz8bFAXP6zdiHcHZq62nzGZ1jreDU6WI52nUpFx2646qeXyS1nU0YsEgIxp1
 Ks0Dm0DMaGMkuDrLF/+dVzvTr8vCVJi3PJBwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775490846; x=1776095646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fnzUcXBOM1Kco8+zP9Rz/e4BJKK9Ko0sAEw0RXMEqqE=;
 b=cVE3PKS6ys1eCjxKHNRPaVpCfaTOKz+FWC0fqttvJNTtWs1XaCvP64xWM5QAlCz3rz
 NRqDOi6fvnSnjeBBnnfIFsY21QB+K7DA4VgRvcOUiSCabfxDc6hKpMqnRPNkt7IftI2k
 06TJNKRKB12GLcabZYNhZNVIL4Ez7TdPHHoQakStndYU93lGdVWA667fbi7LtK4R7Jn5
 lUCDY347VHVAzpYb5UEK+TyFZadLCGPdsJg7qW8a82+GYQ3TBXDnCXyQzxfWD0/u/ZnW
 gn+dO+/D/Vc2bUgHYrOsHXzPYpf5j1zxRtqupYp+J8WSWRLypF2ZAB59L+EwBsBPWzFq
 cF7g==
X-Gm-Message-State: AOJu0YyAjA3ZFP5W89wcHP/m1LiRfw+ME9aAT4IaMoznvIre+VGzO+Ng
 SQmDRmo2JiZWV2xQ/AsyYbGu2IOPqeVBIKAQVYvCYP4UNFsKIvIAV/7hAdDKClNMqrd/+ff+ldd
 53ftyssGAy4rmqQtzzfMRBwF51hC0L2mpNU5j+a8k
X-Gm-Gg: AeBDieva9Oj/OP9UfsoifIjAMXdB9SKGxOZ21t5nP3LJ6LfQ6VxeldW7IFzfMeMXhKr
 erJjjWxmvYvYEwY+T3K8b68nA3/gIqq3SjUqTzGubdr0FBGzjA7yz2fHZaDnY2TiVwOJJn1UsvE
 87pszhaos4420bRJsDgcGDSazWAPNr7nySEMLtAOjUp9YMgSEpt6gQlWbRWtbdcthSLEoVl+IAK
 a9Uui/5qSu89cwpX9ELcO7RQOOUt8wzeGqbn/QK+umhPttmT1G7PcxlHh5jJki1AcWxGCWeVFZV
 O3+D1g==
X-Received: by 2002:a17:907:3f90:b0:b98:6177:2f16 with SMTP id
 a640c23a62f3a-b9c67a049f5mr604464166b.53.1775490845576; Mon, 06 Apr 2026
 08:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-5-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-5-9e6c2ac66587@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Apr 2026 09:53:52 -0600
X-Gm-Features: AQROBzCPZ5gCwsvhir0odmu0HVIr5aoa_kWaj46Cps9ptprbdzfsV7XaKDn9vp0
Message-ID: <CAFLszTiFMrsz6ePKymAuRUP2zYaLdjTjsaeAPr97DiawVopCuQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] dts: add empty .dtsi for shift-axolotl
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, 
 Yao Zi <me@ziyao.cc>, Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 06 Apr 2026 18:50:33 +0200
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

Hi Michael,

On 2026-04-03T23:18:18, Michael Srba <michael.srba@seznam.cz> wrote:
> dts: add empty .dtsi for shift-axolotl
>
> This is necessary to select shift-axolotl as a target, in practice
> the upstream dts will be used
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>

> diff --git a/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi b/arch/arm/dts/sdm845-shift-axolotl-u-boot.dtsi
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* When there is no previous bootloader, the memory node won't get filled in.
> + */

The build system uses the first matching -u-boot.dtsi file. Since this
board-specific file exists, it takes priority over sdm845-u-boot.dtsi,
which adds bootph-all properties to gcc, usb_1_hsphy, usb_1_dwc3, and
rpmhcc needed for USB DFU in SPL.

Please can you add:

    #include "sdm845-u-boot.dtsi"

This is the standard pattern - e.g. meson-gxbb-p200-u-boot.dtsi which
includes meson-gxbb-u-boot.dtsi.

The commit message says the file is 'empty' but it contains a comment
about memory. If that comment is relevant, perhaps clarify what it
means for this board. Otherwise I suggest removing it until there is
actual content.

Regards,
Simon
