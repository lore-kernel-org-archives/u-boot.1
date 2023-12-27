Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89008C46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 08:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19781877E5;
	Wed, 27 Dec 2023 09:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="psKjQUMd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED38F878C1; Wed, 27 Dec 2023 09:29:21 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FF287729
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 09:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50e7c6f0487so1481579e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 00:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703665759; x=1704270559; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IO5v94jmdIkjqhbUBwxUzA2FFbYRdX4phUyiVrT2CQI=;
 b=psKjQUMdXX65KJiV8W76Y8RrkSdXIPuJ2Pjh1x6+wgWLtXw0+lzaYpA0UsnlVIzgr/
 wRpjnJBtn84DfjbWz+dnXR6GbbNThhIhXzGr+qNKU3WZSoae65dXvtqInNJUS6UBNjys
 N+Xnq6XJoAK1ZOgTfFIqcdrqKYDaOk7sM1zKBjuxYvUzzMUPMv2giMlUGHlorjrJDpCr
 V7u4bzM/1aHpltljwJqIIVqFG/fL/jgL1IO3651VqvCzsMRvkiF/b/4pHpcEdkgB/7Dn
 74/rg5UUStteqtp6b2nh8y7BGyOUKLxlcw+VirPYc+IncWh+v1D2BklfkbVphvsDy+N5
 UfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703665759; x=1704270559;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IO5v94jmdIkjqhbUBwxUzA2FFbYRdX4phUyiVrT2CQI=;
 b=ksQJpAvRC+nB/pv3rFurRdo+6S58j2/2PTSKW9ILtd7SW3QAZPNl3ig3niNrZ5/hAR
 KD6aAQiDd9pqizh1KvjqeH83MV+5ysNLWaWNU+dmNMS3umWrFYfBIpmmEJULTpz4ovEG
 uq8nuQ30FqY1e/JX86JahnFLpADLuZxq3FmfBgoEoL4SmK/NnH5AcjICkqlLJDzMyxAm
 xlpKVU1X7/arIE0kYPLvMNIYFcfGXUukpayINL6DkX1QJJhu4I5duLBUp4wh9GGOkLGf
 o2MDZvrn9lepkukjbQDjW3zUNnS4afz5TLAkBLNgUsNkZt28KYmgzpXLD0s8p4HwVnst
 4k/Q==
X-Gm-Message-State: AOJu0YyVCMvZlD+49a5NCWkqVjUjhaX3Gi05oelcqtCgrM77ch9GCDVN
 TV3YbeXv+NaKMmJjKc8kK5Ag83ZP4c+tT/9jMd76tzdehCI8zA==
X-Google-Smtp-Source: AGHT+IGkGYwdOxfTbb4NLbMyvUFIUpONO4Us28vZnRnHV5OlSN4uEf6HBCPot3rIfzXRZhExzbyHrWFH2OzE/oqE5Pk=
X-Received: by 2002:a05:6512:1318:b0:50e:83eb:b89b with SMTP id
 x24-20020a056512131800b0050e83ebb89bmr602609lfu.171.1703665758773; Wed, 27
 Dec 2023 00:29:18 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-6-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 10:28:42 +0200
Message-ID: <CAC_iWj+KpBcfGr0je6LL=8qu=pGdS_ony1Uwos6O7JtGDCsktA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] arm: armv8: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Qu Wenruo <wqu@suse.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <sean.anderson@seco.com>
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

On Fri, 22 Dec 2023 at 23:32, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Save boot arguments x[0-3] into an array for handover of bloblist from
> previous boot stage.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
>
>  arch/arm/cpu/armv8/start.S | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 6cc1d26e5e..8e704f590e 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -370,5 +370,19 @@ ENTRY(c_runtime_cpu_setup)
>  ENDPROC(c_runtime_cpu_setup)
>
>  WEAK(save_boot_params)
> +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
> +       adr x9, saved_args
> +       stp x0, x1, [x9]
> +       /* Increment the address by 16 bytes for the next pair of values */
> +       stp x2, x3, [x9, #16]
> +#endif
>         b       save_boot_params_ret    /* back to my caller */
>  ENDPROC(save_boot_params)
> +
> +.section .data
> +.global saved_args
> +saved_args:
> +       .rept 4
> +       .xword 0
> +       .endr
> +END(saved_args)
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
