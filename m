Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6182BCD0425
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 23:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F1B83E0E;
	Tue,  6 Jan 2026 00:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aFwE6PKQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3997883E0E; Tue,  6 Jan 2026 00:31:23 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1911383D9F
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 00:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b7355f6ef12so92407966b.3
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 15:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767655880; x=1768260680; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OF8rjCTDmUKjVZ95w81iDw8GHVms0tflagHEGJR66ZA=;
 b=aFwE6PKQPpWFVUfFhrj/bXhLPUfT+3XKWo9nmAr1qy0NQCVNfwS6wO5XoEEf8BeOOB
 O/U8BbWLCXeGlk322yqKhuWWwAIKFn/TOs/n26ObkRjCe0KhbkF2eijtgAMIo5yBLtru
 aZXvjkUIxeVtrmo/kXzXesM96tYm+vg8+iSMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767655880; x=1768260680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OF8rjCTDmUKjVZ95w81iDw8GHVms0tflagHEGJR66ZA=;
 b=qUoczao5YPxTyXgYzMthddbiMoXGCDC3ehUfw9LrjbKUFYh0SuP+Z08wAWApK5855Q
 TTN98uuy84xFLf6lVldbXXm1/9a/mGigJDkkkpOWC0oVzbyhLKpIXgdl7JIcFcK3xpKq
 qHHf2ffpYsK3dltn1NMbzmTSjzl/IVk22jEOx0fOZP57xM+sz7a5bT/USHinG8kF+pYK
 Ij5AlAWTSFLDBwXNWahKYPkaaI2UhumRv44QPzQbcAod48BHbRdyhWC+wGdPYYoG+6I5
 JELvgRserjflzAr6U/36SokDE1bFmoajkNxIMYzOR2VQ7i6PwPbac/bH3Vk5mATfor6V
 OPCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC3zV8LOrkedXnd6IeEbKm3A2mG/2LvR4InWV72+zc6mktzGL5KJd/L1Wdmj8UhvUQQ+1AZA8=@lists.denx.de
X-Gm-Message-State: AOJu0Yzm5AjAe5/RImlmhQ5Jrom4QLBZQG6D2CkHU71NMiK9eNkdDM2N
 GLog/Kx1oLa+D+Dwy0jtesEZzq1EgSV9tpIGjAJsU+L0kkshec/H3vEkDgBv6K2bfGlcrRKpELg
 QbnkRPWB4+vR15sRGCo1fLmvcrUmk2UWdg4tcSn+P
X-Gm-Gg: AY/fxX4anwglC8cgjo6RV4jSxC6eB0UlbQt12zhPf/vpdta9yhoWKI9bXLHWu/ANbdC
 q0IMz5ur+WKl0HBLCY+7OqJcLtickvqiB8JQecNKtkUYjknfiKJL63E7Aq/zk9QHv01ZullM5Be
 eij05SfMFXJnDdNQRKjDPzfCv421tyoT9y/u5JA8LO1KGzjxRizpFDrJybL9TNHl23gPd7TDS5z
 8Iu9l7TAwMy3U9t7rHffhpnV/KCbxXmeDOOzTSts1y82L28zjYVswUp4Tp254wO2rJ8dA==
X-Google-Smtp-Source: AGHT+IGy/dxYcQ1vjaxf41mOqVXebkonseZOtntFkgHKnsTwz7Eozfc+BdW4yqFsI+hgV5fozHM0g60IZaNxeyzp1f8=
X-Received: by 2002:a17:906:9f8f:b0:b79:ecb0:db74 with SMTP id
 a640c23a62f3a-b8426c3e79emr151145666b.59.1767655879985; Mon, 05 Jan 2026
 15:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20260105165221.1816070-1-visitorckw@gmail.com>
 <20260105165221.1816070-7-visitorckw@gmail.com>
In-Reply-To: <20260105165221.1816070-7-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 5 Jan 2026 16:30:30 -0700
X-Gm-Features: AQt7F2owBoiyswqBhSP2Zas4QxQkVrB9wgPeDLef8E2HBJ8ak-hsJ3YFfa50a0s
Message-ID: <CAFLszTipBecqu2HZNNGwu_DvK5_R0vN0eY3CB-=EB7b=eAZPkA@mail.gmail.com>
Subject: Re: [PATCH v5 6/7] CI: Add test jobs for QEMU m68k virt machine
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com, 
 me@ziyao.cc, daniel@0x0f.com, heinrich.schuchardt@canonical.com, 
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
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

On Mon, 5 Jan 2026 at 11:20, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
>
> Enable CI testing for the newly introduced QEMU m68k 'virt' board on
> both GitLab CI and Azure Pipelines. This ensures the new M68040
> architecture support is built and booted correctly in the emulated
> environment.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v5:
> - Rebase on u-boot/next branch.
>
>  .azure-pipelines.yml | 3 +++
>  .gitlab-ci.yml       | 6 ++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 81a36da7114..e9fee478117 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -520,6 +520,9 @@ stages:
>            TEST_PY_ID: "--id qemu"
>            TEST_PY_TEST_SPEC: "not sleep and not efi"
>            OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
> +        qemu_m68k_virt:
> +          TEST_PY_BD: "qemu-m68k"
> +          TEST_PY_TEST_SPEC: "not sleep"
>          qemu_malta:
>            TEST_PY_BD: "malta"
>            TEST_PY_ID: "--id qemu"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 28a32f9f4d3..ff805fae054 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -417,6 +417,12 @@ qemu_m68k test.py:
>      OVERRIDE: "-a CONFIG_M68K_QEMU=y -a ~CONFIG_MCFTMR"
>    <<: *buildman_and_testpy_dfn
>
> +qemu_m68k_virt test.py:
> +  variables:
> +    TEST_PY_BD: "qemu-m68k"
> +    TEST_PY_TEST_SPEC: "not sleep"
> +  <<: *buildman_and_testpy_dfn
> +
>  qemu_malta test.py:
>    variables:
>      TEST_PY_BD: "malta"
> --
> 2.52.0.358.g0dd7633a29-goog
>
