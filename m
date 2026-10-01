Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D3BCA5FCF
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 17:23:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9915540634;
	Thu,  1 Oct 2026 17:23:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s0rg0-brHEdt; Thu,  1 Oct 2026 17:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E47C4407EE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875425;
	b=FAmCbQ/ccTCeiXD3ty5dKU7WjBDNDgK7Px5cDVYJVIPz+61oJEDKz3YfTM1WZzFOWkxO
	 XHSfmiqSXtUKH8igOSno9FAFgqhdV7w/lCVAMYeiO0KgCMWwzLbtN8HNVy1N9C3L+jv/D
	 tDsdjMU4pVtTFAfCYaMJQ2FCLnmdPv2xtMioJMzUOH9X4oAGrUaxw2pTnI+rq7zel28ZT
	 UH/Ov2DWbmHZOIZHp6ZORtuhZLunXSjKIlpQQgjgpEHgrPkxl2iJH7AicBaAPa/uLeF9H
	 kjj015MjHXrfIlsaql83uOU9WztIC5u4TRIHQmWoTRWindswPXZVo+7+ZG0AZkqFw3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790875425;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=jcYHbQ5rDH0c7B6a/syyV5uwuhweQ194d/2cAw6hn/M=;
	b=hELZxF49ejNZQvR41rIJPtTYH+OijsoftFAFq0Wk30YRgqOJf/MVcQnWExCc6fyzveHe
	 R9UFKQDY6dnWsRTjG2S57YZOxrG1PtTKnRCmrgFwJcIRbw6z4TrN2qQHVUQMqzDfUewoo
	 ltfsltJvwvIikfF/60MChiNpAF8qLU/yOMLJpG9YG7aiVmTEt7FmZorov1Y/wRlzGGsxg
	 EuxbdnUheocUH/JAYrhwyduXrzkPT3h3XF/a/VCfzUXzof5AX73m1jGhHWylUAiQdjv+A
	 udN3EhCHrze7xhnWpQiqXDOPnLHNiidwH5CFOxepZSLRP4sd6zP4E/por6ddAe4FQtw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790875425;
	bh=jcYHbQ5rDH0c7B6a/syyV5uwuhweQ194d/2cAw6hn/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eWDmhaJS9Nb+7mXxjtvzOQYOLRrAlM+YP+flaJwgQ7KHKx6Ntu78ps50QfycQs1k0
	 4yUyjVy1WThDsUDDRrDNnv6zrBNWilbfmuoxGDrGVENFA49khQSOaKLsT6Uf91v1pT
	 8QhEO5z/cP9TYlEUgoQiOA7SSAi5frIkHh14iLgqyq/a6+X6+EI9+7saoVgNpXjRHu
	 pKDNP1PoV3uJusoymZOzz/AUT9+tDy6IEgoIZZuWQRulsO8NTCgocXVTSgaFdpAeoe
	 bPkZ4r71raztPJErXlJp97aYBa7PPPHnpLxC9HEw/OhlChhFixQ+2vaFckb4JPCpci
	 hlYdh352U05Cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E47C4407EE;
	Thu,  1 Oct 2026 17:23:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB9DC1A6
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:23:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ACD358098C
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:23:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9O6Gup6QbVY for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 17:23:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A8EA9808C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790875422;
 b=WziyTZd3urfzm8yD0PsGKylDwONQL0rC+nDEtGKcBiuRKUjuURviWyfasq7/djH/a/pG
 dyVXGtRA4MRp0zfIXDcoRDw5g3/KQb44GZzGnzFU3TE928hfgozjGgcWBBG7FNe8NgCGR
 zPabeNzveSEM4I5X5e29IFds9AlcBbw7AuYNIwi9LGTiCROWAKojri+2oMTmxKgHatf+M
 K0gQDrf5lOVbPRn/kIY/VOWi43uBXvOc+j4GlWLO7u8o3b49Qo3lYewaFs86xnS9IwPe7
 6nDgmOyYXm3cL0tEso0wgFUsECkdFDP9PdNDBSU7pN2PTi/YHXfT/rk8ka1GhflVGMg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790875422;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=jcYHbQ5rDH0c7B6a/syyV5uwuhweQ194d/2cAw6hn/M=;
 b=n8Sj2j0g3Jsd/aufpbSyCqLiqJR21eFxn7ieCN2oeaqLryYNLGCfUG0m8Lv4+HGhcJsi
 XYd4Tj5/YhrbLT77zvhyTaomrr+dXZUq+zBs5WEXpKng1iX0tpvFM4gvPlvocuJcBJ7VA
 2SSpyHjNfb4S0aHMy8WIFG/AjJahYGchu8TQwz0jh53GRdSOgkDmQI2dmiqamt+d/SN7F
 WuXotc+vSH7jhbfJdgPA7xAGTjwR5pFo3CrHWOOpd1dviigcc9II7XS25P6g3FJpoen1o
 9S84T0i9GO/AXYiW74fSTdzNvAuNIeTUjAWfJQ++XB+IrNA2DdYgCrjQrpQLWdgRsew==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="e/1Folse"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=e/1Folse
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A8EA9808C1
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 17:23:40 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so10924536a12.1
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 10:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790875419; cv=none;
 d=google.com; s=arc-20260327;
 b=JM5ftOYmpptK3khVhcxO66xXgzXwEwbKZlbjr8cV6Ftm35Gm1rqLNSoWtyDpeflYGL
 MeZK6sFrYeL1PKMG6y/o3XfY19EKKVQRYZorC/unuY7noINF3YyYh8krUHzpfC/jUm2m
 8cl0vJ5p/zCCIo7KceNYpahRZxYb2lGZ/WnFzcwTfrjEZYmh7QFRDhjzyrifmlE3GS0R
 ayDIRUionYYxiNOqcnuxCmNMX2KZqp6ZafRUIRCd0iK3ch13qog6n3ExPrX4DF6lqZwN
 PJPkGmaMvLfLKtXBaQ5QzutWwnXjJgZNVbCCJEub5fvrZa4KT0SJo4yuwCBoKdEvUVX/
 wCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=jcYHbQ5rDH0c7B6a/syyV5uwuhweQ194d/2cAw6hn/M=;
 fh=HHT6ALp4KyJ0LWRhahOOsjGQSPv85WBNxkEytcfM5r0=;
 b=MkryQmweX0/c5J4nqsv+WzDhpo1C5YBUgN3OiXAOqRM/8khvmyB5GpASwdvS945frf
 KvXc7dLI3jWEiEfQEebVQzIdgKZuD3J8arX8qs+L+6y6kuIjGCS2V0PCdNy3qK3Ws4fO
 e9UR1qi2/P8FL8FM2UM1Zc3w2bGpyBV0ioWIMrbDDw677WVv6FcjCfovTR6Vr+wRxrZX
 HWQlPUxa2c6FgaTtoMw1X7xt3H6LeLLTHneuC1F2J7HCtJN+0Ptv9lKeR2NU3cvJ1uKX
 PQO203j2b7D4Uf4IeK9xSRnUADxNNIRBdlDZ3SinQTWBcLs0mWMJiD/FRNZ78KAHxQtb
 o0wQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790875419; x=1791480219;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jcYHbQ5rDH0c7B6a/syyV5uwuhweQ194d/2cAw6hn/M=;
 b=e/1Folse7rPDsDkYqnB1Dc/qCxGT+hAcWbX/KfhaMDJJA7VOP9BjihkQwhS9oAeobC
 hB/lKqGscxK3UjBCJXmiANhdL2YGnjwnqrgNsdHkhY9JHv76y37Rsy/Cgi/hePiKMqOT
 NpnbOTRuFWCUgC3yzgDjn8EiGvB63mLDhnMR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790875419; x=1791480219;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jcYHbQ5rDH0c7B6a/syyV5uwuhweQ194d/2cAw6hn/M=;
 b=kpGffMykUF29/hHAh8F55qJ8P7RMInTUOzoGedX3MA8BXpHUdwSAIacBJjVUkj0UUT
 T5VTL06RxKKCu3pv5pZBURSzpjykCO0SY3aTwFz9VnsTqKEM9LQ4ffVfubP5K5jEg7BM
 3ZpAL7cLpvUvj+cuFfaevhbDLf8flDvVpvsN75LGBpiCzucVp0oVsxGSmGqrkws0CFNK
 20YLUBgoS1o31yRtzN2/WxhqzNX8QkPqx6N7mhoXHb2GxVYjfzXY0hVTunlFfdqk/Kjl
 3LN8d5gn3hnoKE4jMElERpcs6BjpiFA+t8we87BfyQvOQhh10rKnusBJUUiWrV1jH2IE
 A2eA==
X-Gm-Message-State: AFq9FYJW3JXcgSuBHoRVUspiB6L15VGy9YyYcBoMI+1OQqrQnWwOjX5u
 LuuxNky0wvzRWtiJaciq1b7hthyxwlHdQ2hcump9voP4UMtGwrIG2zy/s42sCcziFI7GIf1GWXF
 ryv95pz1uGIp6ILzPGWnWhJZIqyltnjxVtd4DX0Ld
X-Gm-Gg: AYBFou1DM6/dd2vac3o6t8de02TH7LFjQAsU5/d9jUW7Gp6dirXUKlNtqBO5Khif7vS
 HCIqerXiPvyBOqf9sbwrk/6aD8DMi7MxSeGJZhMghAoHOwAKOIW6V5XXtS+Q9H0ov5ruKnqQkAQ
 g01XVtGIJYmusTFBCgT7shDXdovwtMY5FGecnqajpybTAS0AxRX0/gKDJnuySL9kJJEE8eqp3f9
 IvtVmvfDLKP8BvV+5Z+qaHSWmXU/LRJZ93esJmm3eNJIRvq0HdlYuoQ9GlfM2mSyne9AKz22L3V
 aphLBBdzOzdJ8Z2xA+skFVQbPewBm0P/MOJkj1rzoerG92MTAA33fYwK
X-Received: by 2002:a05:6402:190c:b0:6aa:f1d2:ddb8 with SMTP id
 4fb4d7f45d1cf-6ae198e06c3mr4335184a12.23.1790875418965; Thu, 01 Oct 2026
 10:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260919215207.3832887-1-valentin.haudiquet@canonical.com>
In-Reply-To: <20260919215207.3832887-1-valentin.haudiquet@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 18:23:27 +0100
X-Gm-Features: AclHuK8F_EGoNLsfoLwFYSvXIUTUr90JwndXUAThYCQm14sZOMuJBDWlnCBogWo
Message-ID: <CAFLszThYQjfzwO0EgnqQtsFng_NbpeBpL3UR7USvjs_ckJwKKg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: efi_console: find vidconsole when stdout is a
 list
To: valentin.haudiquet@canonical.com
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Valentin,

On 2026-09-19T21:52:07, Valentin Haudiquet
<valentin.haudiquet@canonical.com> wrote:
> efi_loader: efi_console: find vidconsole when stdout is a list
>
> query_vidconsole() matched the stdout environment value with a strncmp
> against "vidconsole", but stdout may be a comma-separated list (e.g.
> "serial,vidconsole"); match the substring instead.

Please can you start with the user-visible problem, e.g. that EFI
output ends up in an 80x25 area of a larger panel.

>
> Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
>
> lib/efi_loader/efi_console.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

> diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> @@ -344,7 +344,8 @@ static int __maybe_unused query_vidconsole(int *rows, int *cols)
> -     if (!stdout_name || strncmp(stdout_name, "vidconsole", 10))
> +     /* stdout may be a comma-separated list, e.g. "serial,vidconsole" */
> +     if (!stdout_name || !strstr(stdout_name, "vidconsole"))
>               return -ENODEV;

With "serial,vidconsole" the output goes to both devices, but with
this change query_console_serial() is never called. If the panel is
larger than the serial terminal, an EFI app such as GRUB positions the
cursor for the panel size and the serial output is garbled. So anyone
using serial as their main console swaps one problem for another. When
both devices are in the list, how about querying both and using the
smaller rows and cols? That works in either order. What do you think?

Also, strstr() matches any name containing vidconsole, e.g.
vidconsole1, but the code then looks up vidconsole by name anyway. It
would be better to split the list and look up the exact entry that
matched.

Regards,
Simon
