Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269C7C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D32F387931;
	Tue, 26 Dec 2023 10:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q/UUz9u7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB0687923; Tue, 26 Dec 2023 10:48:28 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944628792B
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-594c7443cc5so4084eaf.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584102; x=1704188902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u6g7gZSuLHFLpC/n+Km97UBYtkRjIXLjJ5/J8WxCDg4=;
 b=Q/UUz9u7LD/Gu1Hj/2A8Pmkk66sxrfY4mX5JTJ5QyEnZZe1HuNkKzKXWpk+Sya/yaZ
 kN52GucJEKIn937N83KxgGnY9Etz7xSa/cJIZrnzjow1hJkIUojVCmv6b3SoZbwI0Ina
 znh08AfcNE0l9Q1RznFFerXtm4l/5n9IMhtM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584102; x=1704188902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6g7gZSuLHFLpC/n+Km97UBYtkRjIXLjJ5/J8WxCDg4=;
 b=fyz7VicHiF6dp4nlvS5XTbxzM+AzXIGWbLckQtlYXSlE4bFNnHZB85xuGJRHtWDC7/
 H1Wg2TCFuqAWSzOl8oQ7PcJMNh2aryg/Y3c2uDBt/neNxj6mOCqxfnYKmBukTl+5BZMo
 I44J+TJSApbdJVBGKM3kgRBoZ6KMCl1jFaATIiymVI9pPQx8Jg89DGkrjZQtm/FHcIBU
 3F+ytM8bfex6sYcI5gF5szx+OTrD/gAhwo/Zi4H54UMGUCnKVnFvC+FaoWh2+cYm1jJt
 zSGMmdUBp1sjpiVT0y2UKLcMKcUAlsopuuVIY+KSMzkO7Btt0WywQuqrIXzuPLGTDD5q
 JJJQ==
X-Gm-Message-State: AOJu0YxqD7qa4KgH+Dkg7kZbknJHPqSu0TT0o85V7CGbl3d/3qaIlMz7
 y6LxcBealBndFFSq0O1mgxFEJKCVWwx54Xfd8nyYpoXsmBQv
X-Google-Smtp-Source: AGHT+IHHo9EohTa1ChrLEOsTry0oO5KlI5kR1ggC7D/BuMWIyl+Hkg2d30DxD2eJ7J0F/o8GeasBPIurjj1RagNp8Gg=
X-Received: by 2002:a05:6358:e49d:b0:172:d66a:81c3 with SMTP id
 by29-20020a056358e49d00b00172d66a81c3mr4475176rwb.22.1703584102188; Tue, 26
 Dec 2023 01:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-5-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-5-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:42 +0000
Message-ID: <CAFLszTgjj2+78qixAKQ5pK4PtLRTS4ckVLAptUZnV9+zFzaQ2A@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm: armv7: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Raymond,

On Fri, Dec 22, 2023 at 9:31=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
>
> Save boot arguments r[0-3] into an array for handover of bloblist from
> previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
> Changes in v3
> - Swap value of r0 with r2.
>
>  arch/arm/cpu/armv7/start.S | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> index 69e281b086..2ca63ca32c 100644
> --- a/arch/arm/cpu/armv7/start.S
> +++ b/arch/arm/cpu/armv7/start.S
> @@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
>   *
>   ***********************************************************************=
**/
>  WEAK(save_boot_params)
> +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
> +       ldr r12, =3Dsaved_args
> +       /* Intentionally swapping r0 with r2 */
> +       stm r12, {r2, r1, r0, r3}

I thought the instruction was a bitmap, so what does the 'swapping'
actually change?

> +#endif
>         b       save_boot_params_ret            @ back to my caller
>  ENDPROC(save_boot_params)
>
> +.section .data
> +.global saved_args
> +saved_args:
> +       .rept 4
> +       .word 0
> +       .endr
> +END(saved_args)
> +
>  #ifdef CONFIG_ARMV7_LPAE
>  WEAK(switch_to_hypervisor)
>         b       switch_to_hypervisor_ret
> --
> 2.25.1
>

Regards,
Simon
