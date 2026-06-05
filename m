Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F7CD6E75
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 04:30:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C75DE84976;
	Sat,  6 Jun 2026 06:27:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EYxK66Cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DFBB8498B; Sat,  6 Jun 2026 00:08:38 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15A6B848A1
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 00:08:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-beb44f97561so300104366b.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 15:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780697315; cv=none;
 d=google.com; s=arc-20240605;
 b=dZZbJXz1ZfKqxKLmvG9DvpCM5HRdHJZHe54E3rJNxStrKKz+TIRvxp3iHLRjuUGwvo
 WEJOgjwnm3K3t0uTyiOMzt6QX3inEeNax8qO/6+xjj76KpeONfoucvT7pdtlucP/l+19
 e8hjv0/02nq6UZk8pdjLf26y37sP99qW+eUalhHQOsv6qOdFHlm2Xf/rLNZaVhTwd7xm
 LjbKrz7LlmUA3ScTJxFa0gfshFCZlAnNzHYaxJ4hrbL1KXnmf9S7v2/+ThDgAM2Fj6UG
 P5IcK/7OT/YvtA6ulNaTYbkl7q/dl5rOcNeCKLaie8Axv5SLuKyGO2lpcEnFxBGuf/C0
 fPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0oYCdKwheCyJ7Jn8bIPSK1owRNQCa8Eww8Je7ySys4g=;
 fh=FT8gp/ZRjMC8OnWm1PFkYno0ca/BbYhGgCCoyM9TMFc=;
 b=fBodnACu4t634DCbS6263k2L5YeM2zadzOxsXt0iwM3fWV3/vZsHgaQA9LErQKzXQI
 37+3fpC0vASx1IJa3o8/1/cjuBVlas4xlNPYjDyHe22+9ug+zqTweoikpgg9UEXEicoN
 g12VgcXpZrgsniqHwxWVjyTgw4QpLQEarHW636JR7MPxsMohSBGv7qArzWxxe4JjjtT5
 wzNsnOkRJtl1AESla1BZMgIozqCixaTWx+YFhMwu5i3+brE4631Kjq7ESXKWwsw+nTK3
 2FTKm14jYxAiNqKnn3DAd2MTmHdZO3VdOBFU40s0xTvvNHp312t6OuuBdXsShSqGcGHP
 UUWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780697315; x=1781302115; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0oYCdKwheCyJ7Jn8bIPSK1owRNQCa8Eww8Je7ySys4g=;
 b=EYxK66Cjd1z2/vBXH4Zv9/c6qe5ZSzTTVg6bZn+vzkOdqp/5r6iVmW1m0jEEYOItnL
 TNxZirdmPhTXpPTIFN3fTSdONrrnHCSsboReOKLKOk8YWAgL9ux0WfmUyhmqhtJOVxY4
 AukmHDi+Q+oM6gpmafKInsQaYfPJw739pIvrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780697315; x=1781302115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oYCdKwheCyJ7Jn8bIPSK1owRNQCa8Eww8Je7ySys4g=;
 b=qruUur0ITLEzVXduHVaRlgQf4uaoeCMyrVLPWS7i457wAQkNnVzTKMWxDK8r0xwaM6
 1/+AZ8iqByDcRMushUhg5DVid4/IJHPULASR2mU+LzxW0HhFFcM5pZ9zvH2TE9zuqrKI
 L9+iXXnoG982Sy++exQyF/MoSvEVa9WCdpnvWyQL1fl3TjxFiK5F3HBIYhtmYI2LsWgp
 pU9ZfLX4aBE5fL7f/lfBgStBr2Nj8b5Y4Vn75Hu9cn1H5Av/JBYhpQPgBjGFKDzeFxTs
 xvYX5ynbMMeUKN3WNPiULyAUcbn3Yf33K0mPB8PcG5HYInOvVRZ/apRgzf6oE0HOcnz/
 XvuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ++ViSXN3FEjB/p/b0GJAEAEDKdgqksOiZ1fRe/1QmqsMPKXyJEBtH6eg+virQYLNOGWNJ5DiI=@lists.denx.de
X-Gm-Message-State: AOJu0YxKBqyYxcllF+Ek21ZT5o/Y8BhXCQZInN93i8MH6O24cYQ+h2WD
 XNIiKQZxqOaBT4PY1XCyrUWt3IUdYXcgyLITWlzLx1VLEZ7YYn+vG2Qam6blUa5D7L2eN5skaYl
 xyD5fe4GpsdNQ7mz67OZ9wUW2A842T+PQRx06ZFup
X-Gm-Gg: Acq92OE0eNT1N9+i3xLWVF5WJFq1QwlKTMQWfinlaBVnfK6gaFC7ROQkSKsCasOMMOP
 XEwHdXjINcwgm6zHlXruTVgtoRErPqb5aOfobt9Mm0p8uE0HjMgG+He0m9tIcJNEgyuOtfgcZeN
 PT0jhNJr7X/3cmAiNvmnTHy6kSRijdzgF1nFYLD3+rmmKctq81+fBKZQmQa4usrm6OvuT8qeukE
 1dLXGZ8kkAF7L2w/VSArR/w3wx4ONMrtdIbl8L13AcoaouZeVKqUBshwMfmoJJyQJYEk8A/zAqE
 r63jagV/aJUWMdbU
X-Received: by 2002:a17:907:28d4:b0:bee:e07:3f0e with SMTP id
 a640c23a62f3a-bf37037aef8mr230163366b.2.1780697315520; Fri, 05 Jun 2026
 15:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260604093132.757583-2-varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260604093132.757583-2-varadarajan.narayanan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 5 Jun 2026 16:08:23 -0600
X-Gm-Features: AVVi8CdBF9_BySUJO65L43G3MS2ZawEz0adZ9RVQaWko5bIwrVGZunhLEVsFrvM
Message-ID: <CAFLszTgu47OLD-FgoqCTL_i_vw=KHanEb+n424oE6ynZr8N3mQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/13] binman: Ignore noload segments for image
 numbering
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 peng.fan@nxp.com, jh80.chung@samsung.com, lukma@denx.de, 
 alpernebiyasak@gmail.com, tien.fong.chee@altera.com, anshuld@ti.com, 
 alif.zakuan.yuslaimi@altera.com, afd@ti.com, marek.vasut+renesas@mailbox.org, 
 tingting.meng@altera.com, alice.guo@nxp.com, quentin.schulz@cherry.de, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, mkorpershoek@kernel.org, 
 andre.przywara@arm.com, h-salunke@ti.com, alchark@gmail.com, 
 dinesh.maniyam@altera.com, luca.weiss@fairphone.com, 
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com, 
 danila@jiaxyga.com, n-francis@ti.com, ycliang@andestech.com, 
 mateuslima.ti@gmail.com, justin@tidylabs.net, jamie.gibbons@microchip.com, 
 david.wronek@mainlining.org, james.hilliard1@gmail.com, 
 bdklingerman@gmail.com, sughosh.ganu@arm.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 06 Jun 2026 06:27:47 +0200
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

On Thu, 4 Jun 2026 at 03:32, Varadarajan Narayanan
<varadarajan.narayanan@oss.qualcomm.com> wrote:
>
> While including the partial images of a split-elf, binman gives the
> segment number as found in the input ELF. However this results in 'gaps'
> if the NOLOAD segments appear in between LOAD segments. Hence track the
> LOAD segments separately and number the partial images accordingly.
>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  tools/binman/elf.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/binman/elf.py b/tools/binman/elf.py
> index 6ac960e0419..b43cf490b37 100644
> --- a/tools/binman/elf.py
> +++ b/tools/binman/elf.py
> @@ -551,6 +551,7 @@ def read_loadable_segments(data):
>              raise ValueError(err)
>          entry = elf.header['e_entry']
>          segments = []
> +        n = 0
>          for i in range(elf.num_segments()):
>              segment = elf.get_segment(i)
>              if segment['p_type'] != 'PT_LOAD' or not segment['p_memsz']:
> @@ -558,7 +559,8 @@ def read_loadable_segments(data):
>                  continue
>              start = segment['p_offset']
>              rend = start + segment['p_filesz']
> -            segments.append((i, segment['p_paddr'], data[start:rend]))
> +            segments.append((n, segment['p_paddr'], data[start:rend]))
> +            n = n + 1
>      return segments, entry
>
>  def is_valid(data):
> --
> 2.34.1
>

Please update elf_tests.py to cover this new behaviour.

Regards,
Simon
