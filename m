Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A440F3ED4D
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8118084201;
	Sat, 11 Apr 2026 15:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vj+pQgpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A12F98416F; Sat, 11 Apr 2026 15:16:11 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B105B84118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:16:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-670f879f7abso368388a12.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:16:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775913368; cv=none;
 d=google.com; s=arc-20240605;
 b=SmxLEfHeqSUAncQJC6vTq+3k4hQYAPgcbp1LCa/dAKLV7Lj8IF8MHmcrzrhfV1wgI7
 +hiNvVVslBwaaKhWvqflAPTghcc+kTRZcp/DFfByo+sCGmWi1/bZF0HVouFucm8OFLOg
 gJmUsRKA5/ov6MqYuC0RLydqe0Y+U9e86InwNHL+kao299Kt30MfXajwpMPY1F3t9M9U
 msGN/c9NOOp22X/QG/2VIFdWhZyHGx5HvuZr3U80z4l6bSXbJkILb7ITBI9eJLXx2ZTO
 jNWF3DOM8oV5EmCnA0BPxacfIQ1Qaoa52N022pb6ecHKYv/h7F05V3zP6K8djiVSH6r6
 uGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=30abGhkZA4uIvLJwBKMfxpHOc3TCLe1CPftFzlluiOU=;
 fh=QYE4yYjQrkwHbBQuIVs/RzQO4Rp2dP+F64RMlUsI70U=;
 b=h9mX9YMUXC0Bpdar+BZHetIKt0ruSILDrrdy7HtJSoWJxx7wlBQrP2BIuvh90DfJ8C
 0rXef0Q1wkJfR8lEPF1vyxJQ6aODVIKvQXJ66HcGTkm3pnDRf3q6hh3XUfmmKNfALbdc
 BSdq29iHSD78MCm+fH1x61V9P1BUYvsTkQfhcJGBi56R0uUTkw2aKOLbBkDJDRlnU5IU
 jPiWDkGcas/pBH2L0+uU5HKD2OolRcXmSlmMqFqxLBiHdjnhM2tvWkE53/tsYO35WlmE
 CSHjVelAY+hU42ngV1pvV3HlUM/qFagCBGfzsGdUGnrmWqnwJHyQi6ez1lqVHmF6U4c9
 j6Aw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775913368; x=1776518168; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=30abGhkZA4uIvLJwBKMfxpHOc3TCLe1CPftFzlluiOU=;
 b=Vj+pQgpILISWFKqmIGtW7N9LCgMN8O4SpOjqBjnyrx8QhwR94BiGig5PTfzb1i0kvw
 cmv6q5EOPuxn9swXNtnSw/BJtrRpmYu4dy0lybS0oldajetGVHIuyhbIAzff7iiIVuAq
 HMYI8YBvNYokEyLIYSTIFQOdzIG+/HA3lMI+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775913368; x=1776518168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=30abGhkZA4uIvLJwBKMfxpHOc3TCLe1CPftFzlluiOU=;
 b=eZ2J2TJIIQkZXvSScf2wDSAQ93QoF/qYhdLiPWdgu2jZOvJAIqzUbvqxWZ8yaCI5Wv
 acuQQJqOQvGRnZyiC43t2qofJpQk9L7TshBva/bcWxsaXeN/aXMcjyf6GJljQlVXjuKA
 Seyew7j3CqhFCnswBc0y6hP3TtDOZs+x7/+MFEh2/GQZl6WDJ9zpNqRNleY8EeqnbrDp
 sLS0dT8ZjebQi9J+X9/TXZLyV4F1KViu3NGIDLiCfaLWj3IUktDyekN6eMclnjlmXuXs
 LwyicdkSbrk8IF8qR3j+Ci6E70X+oFKeQ00ZrtqAX37mZ0POEyJ/G+1IQM97+2lvN3Kx
 8kxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNx786pjymGGhYjyVal2GLOy8jYawXcV/B9gz5KUmQaW8JOSHcvEzD9TdMqJNkfg+pIBIG728=@lists.denx.de
X-Gm-Message-State: AOJu0YwIRyQ4y4OLqxI4b9RXm0Wooc/YyMVK5G5qrLfDdOAybdEO7T+y
 Ewb3CEvKc20gnrTTbqmb4AeDVoymnabq97bP0J4laX95zslD8AFCHPdwZ3Ao8KEkUfPArAUiGQ9
 kBYg8oC6jc8NJ0pgbxntn0+3zrnz4uRtbBSmvhy3I
X-Gm-Gg: AeBDiesZwLcQcSkaQ+xd7gsMd3Op3oCKpVavdYWXwfp5Yc1mycmd8NAJGEnDK/KXoKi
 ZF3uT9likXogtKEGuQlLaYF5u4MxwcRBE11GP3WpDhEcT3KN2e+seC0OWOF5jl4dTRaMMD/KSdN
 STnHeI4kevI/chJXetHXWbOhTGKggBQXJHj5bidPG1IGHBgowEQl8R8MhMmiRJXIflT3z7odc4Y
 mmjMrgk95pcAQZiszTTwoCYgYmImFUGHogrFEk2IjWzBDdnEG0ZglGEC0zlcfhe8KSdof+tTMVB
 2UgzAh8fkb5GX+Dh
X-Received: by 2002:a17:907:268b:b0:b9b:171e:baf0 with SMTP id
 a640c23a62f3a-b9d7243f594mr396202566b.7.1775913367990; Sat, 11 Apr 2026
 06:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260410091154.1001021-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260410091154.1001021-3-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:15:55 -0600
X-Gm-Features: AQROBzDnlPhAiVbikZX7FSAvn3u9qrEe00eGWLqHOfnSIncNEyiSt0Fln5AjCh4
Message-ID: <CAFLszTjj5HqMPpFiLY4gaLRNdZngRO3DWh81+1OczBL8Fh+04Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] doc: board/qualcomm: Update RDP build instructions
To: varadarajan.narayanan@oss.qualcomm.com
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 tien.fong.chee@altera.com, anshuld@ti.com, alif.zakuan.yuslaimi@altera.com, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 h-salunke@ti.com, alchark@gmail.com, dario.binacchi@amarulasolutions.com, 
 ye.li@nxp.com, andre.przywara@arm.com, afd@ti.com, dinesh.maniyam@altera.com, 
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com, 
 aswin.murugan@oss.qualcomm.com, luca.weiss@fairphone.com, 
 adrian@mainlining.org, justin@tidylabs.net, n-francis@ti.com, wens@kernel.org, 
 jamie.gibbons@microchip.com, david.wronek@mainlining.org, 
 alexeymin@postmarketos.org, james.hilliard1@gmail.com, 
 michael@amarulasolutions.com, richard.genoud@bootlin.com, 
 philip.molloy@analog.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 11 Apr 2026 15:25:15 +0200
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

Hi Varadarajan,

On 2026-04-10T09:11:45, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
> doc: board/qualcomm: Update RDP build instructions
>
> Add details about the SPL & U-Boot proper build steps, converting to
> flashable images, source URLs for the needed binaries and scripts.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>
> doc/board/qualcomm/rdp.rst | 69 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)

> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> @@ -42,6 +67 @@ on your device with::
> +Build steps for IPQ5210 based Qualcomm Dragonwing F8 & N8 Platforms:
> +====================================================================

The section heading uses "====" which in RST is the same level as the
document title. This should use "----" to be consistent with the
existing "Installation" section.

> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> @@ -42,6 +67 @@ on your device with::
> +     $ make -j8 O=${out_dir} qcom_ipq5210_mmc_defconfig

This defconfig is added in patch 9 - can you move the docs patch to
the end of the series so the tree remains bisectable.

> diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> @@ -42,6 +67 @@ on your device with::
> +             --template template.its

Where does this file come from?

Regards,
Simon
