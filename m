Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A0FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:50:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 853AF846F9;
	Wed, 29 Apr 2026 00:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gKM7Sfi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B51678468B; Tue, 28 Apr 2026 20:27:50 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24BA8466B
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9358bc9c50so1567213866b.1
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 11:27:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777400868; cv=none;
 d=google.com; s=arc-20240605;
 b=U/uPqQLujvkggFwF+4otp6G3pCRETDeG5fvRAZOiEPIYdiG+E9C7Oahoewch5LMxXq
 01pNZP1zlD6GCQmP4dLApPjwHekzWNxSfHhZd6pHMhaerB8Yg5klrIeqO03s7WGrRVdg
 PuSc0pRxnEMozfLb3w3D7+PkLAqR8HlkJ6ootaBeqQ+JEO6AsA9DBD8XAka9WZ6siQ5P
 x6rrrchOl49ALkXE6N14q4RlM2xyh7ZFGrQ5Hwc3xLZx2sjlPLh8egT1BvtVnTzWcKYF
 7heENegZU+fVWI1zc3uYNZdYC25Amr+1KP4gK0xJ3Pb0GzCu/Me+29ByiLewKAdgSUlW
 5dYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mtmdM8cmn1bQduMcU7jKl72VK2RfoLdqg7bH7Fcyr0I=;
 fh=CcNfW6dIjL9WUdVhhW/ZJ0mqXisjz2Ordk1F8mJ+6zw=;
 b=TMBfDayukVjf1o3ff0lcYz8guO3hZnFKQbg0vniLZsfc3nG56jZbNNdBGo8xIQwXSK
 DRPdt5sxUx/yi3COgpQyK8mKgooojE6BzNjvzubHETmJLdXUfxpxmfGeWGWsCuyLtHav
 7NSV6962UILFweENdmco32V0YytEwJvVFPuZQrqxC5+Gl1wTNORkd/3d80e8QdyftptQ
 eBwz5O4v+5mJy8IJKGwKG1MPoLHjx/UBmBZWVxJkkjZruma800WkWb476aVJvcYqbBBI
 +GyXFH59Er3g+Vb+CE/J+QatKNKTmHlW6dXKGVdfw/6w1rOm0PqvespCsc0XnppLviHa
 kq4w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777400868; x=1778005668; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mtmdM8cmn1bQduMcU7jKl72VK2RfoLdqg7bH7Fcyr0I=;
 b=gKM7Sfi0P3LrX33sNTIFiZof8Gha/MMx8sS+NW61nbrhhADs/4X26q9mVwdM1jxqTs
 kUI5xhruNAE8TidWR3jsewrwy4C8XBCYwkIIuyXtT2q6Cxjhfgw5bRzwFF/yFADWKl5v
 AlGKQH66MAR+WpmUX7dcFy2bVWlcYjj56Eoe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777400868; x=1778005668;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtmdM8cmn1bQduMcU7jKl72VK2RfoLdqg7bH7Fcyr0I=;
 b=Nik0mT/3RR+dCXphMi6fbcW3WEjhnVVMTyeoxJgPcY8s4cSpMNgqjmgaijZ+2BlvdK
 3n9RDiUYc0sI+8UAhnJ/NOXOJZs/iP9VuWuOj2TE/jijF1o9uqotCBYcyE/yqdTSFHFg
 5q57w7xwlJyYznx9Tq0E6R8QkH1JvmhB6vZrDLR97fOY3lmbGMVwncOI9EIwhwq8HcF0
 CMIzjsg/iyyhfXYEbKSEjqI95/kLJ3ixdLQgJv2mj+8g80w7HFAQC12+RtedG7tzvw9n
 u3Vr+jTs+qoqYpKel0GIq52bi993Di5kBF5qYm7reIs7Lpapf+kx8jER6oK2gAoeZcQ3
 qyBQ==
X-Gm-Message-State: AOJu0Ywf4xNcpt/uBXQ9RAh48uhui+HMfnsGZaCaQ8DjjWWvsf4V1qvq
 NfLlsbc0CycZVX5EBE9oSmxHzZYqrAjKFhOFc5Cac6ftELIwhrrSphoLGBr+KXEToC7naEWbNqV
 iR54caZvlcoIo2t3lGOMmq35A539cwEzhVz02Xtxs
X-Gm-Gg: AeBDievDc1V79fxuQXv5A2/rAuyQYUvCbwwT9scA/H3r4PXK+gSBVV/dWGiw6OFy6ml
 DuiJfeM3SqXsRMfGDyAwW10S1fZ/Wg77rQXaOyXVQmsasgJec5M2CmIuJS3tQfzpdeqxqCkheuO
 YJrcUwq7gYbIbwJp7DJklTCqu1KuoROaux3JVehZZGXMjYDrSy8y05NfS0CQsmaWu5onG84wCEL
 KkrjHvxaZ77M6ZqTHyh04ZOjZXd7mR8ZHtVabPm4MIjD4J2WFWkpm9ZwjvmuAx/XyXz2XQ5/DLg
 pMgokgSE+iMjiuVe
X-Received: by 2002:a17:907:cb29:b0:bad:ab6:450 with SMTP id
 a640c23a62f3a-bb93c4aaff5mr23777966b.3.1777400867886; Tue, 28 Apr 2026
 11:27:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
 <20260426-qcom_spl-v4-1-8cf4133ff883@seznam.cz>
In-Reply-To: <20260426-qcom_spl-v4-1-8cf4133ff883@seznam.cz>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 12:27:35 -0600
X-Gm-Features: AVHnY4LHs3bNqiZRrlYHg6ETUjZ-VP1RvFK5-0uAcCLCiKl4Oi7ZA_s3ND48WWU
Message-ID: <CAFLszThUC2wOi935V_8XDu4mwPy_GW8sH1nvr2kaBNRrm4eoJg@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:33 +0200
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

On 2026-04-25T23:26:13, Michael Srba <michael.srba@seznam.cz> wrote:
> Makefile: add SPL_REMAKE_ELF_LDSCRIPT feature
>
> Some platforms (e.g. least Qualcomm), use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).
>
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
>
> Makefile           | 10 ++++++++--
>  common/spl/Kconfig | 10 ++++++++++
>  2 files changed, 18 insertions(+), 2 deletions(-)

> diff --git a/Makefile b/Makefile
> @@ -2004,16 +2004,22 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
> +spl/u-boot-spl-elf.lds: $(SPL_REMAKE_ELF_LDSCRIPT) FORCE
> +     $(call if_changed_dep,cpp_lds)
> +
>  u-boot-elf.lds: arch/u-boot-elf.lds prepare FORCE
>       $(call if_changed_dep,cpp_lds)

Please keep the 'prepare' prerequisite - cpp_lds may pull in generated
headers (autoconf.h etc.), matching the u-boot.lds rule below.

> diff --git a/Makefile b/Makefile
> @@ -2004,16 +2004,22 @@ u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
>  PHONY += prepare0
> +
>  # MediaTek's ARM-based u-boot needs a header to contains its load address

Stray blank line - please drop it.

> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> @@ -247,6 +247,16 @@ config SPL_HANDOFF
> +config SPL_REMAKE_ELF_LDSCRIPT
> +     string "Linker script for SPL ELF"
> +     depends on SPL_REMAKE_ELF
> +     default 'arch/$(ARCH)/u-boot-spl-elf.lds'
> +     help
> +       This allows specifying a linker script that will act on u-boot-spl.bin.
> +       Some platforms (e.g Qualcomm) use the ELF format in creative ways,
> +       including in the bootrom. For such platforms, you can change the default
> +       linker script to a platform-specific one.

The previous hardcoded source was arch/u-boot-elf.lds, but the new
default arch/$(ARCH)/u-boot-spl-elf.lds does not exist for any in-tree
architecture, so any board enabling SPL_REMAKE_ELF without overriding
will fail to build. Either set the default to arch/u-boot-elf.lds or
add the per-arch files.

Also the help text is misleading - the script does not act on
u-boot-spl.bin, it is the linker script used when re-wrapping the SPL
binary into an ELF. Also 'e.g Qualcomm' is missing the period after
'e.g'.

> Some platforms (e.g. least Qualcomm), use the ELF format in creative
> ways, including in the bootrom. Make SPL_REMAKE_ELF use a linker script
> specified in SPL_REMAKE_ELF_LDSCRIPT (with the previously hardcoded path
> as the default).

e.g. at least Qualcomm

The stray comma after the parenthesis can go, and the 'previously
hardcoded path as the default' does not match what Kconfig actually
points at.

Regards,
Simon
