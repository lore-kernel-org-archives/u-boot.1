Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A55C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 11:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD61487842;
	Fri, 22 Dec 2023 12:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HXDkwb/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B537C87858; Fri, 22 Dec 2023 12:19:03 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB1AB87842
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 12:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50e6bcca684so301340e87.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703243941; x=1703848741; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IzUXznVYMwPbESVHN4lPG96ZwDdfET0NtrqQAbunPu8=;
 b=HXDkwb/XFFAwB7zj8dJyydrK8mRHMRvN2ocpwaNtlWbWIZrgpXIllUWGvrjxax056C
 SLt813W6WEc+SLQqdTlsjfKTmMlB+VgY53/XeHXOpxcHYUgVTpSqxNUX6ReuoGP3Rbm1
 dqE0XqVjaJx6rv/oQu44Q2sSuRcVT07Z+SPZQQovVo3MAImCaUVRrIU6wHBXn0XeIYM9
 rziKJyHETd7aaUeigW0Rgd61eehz23+KWs7LXlV27s/rdQcy3AS3p9etffFp5lMRLCCy
 36iaxb/Tqg+80VKkFLISc1vmqtSLUpCLQtIXB90/w5gPAPaC8EJPfxVMGSYksPK70QB+
 fKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703243941; x=1703848741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzUXznVYMwPbESVHN4lPG96ZwDdfET0NtrqQAbunPu8=;
 b=qIhpGkVGbboq3TSjMPwUIdI554AbxzDKxWlU3TvvAg4u+yL20T1H7iVNIuGVgqY6Ja
 wpFxu76rJoQJ6oV/zYPYGaOkPABuGN+QTSKmt/+VPlxfMJ4OL+G3yUK7HNlpIDkbGm9p
 WzaJdCmrovHFFZBrNBZnALJDIp5cIyfDgQbwxIE6/axvzQGEXe8awt8BVxa1mD7zKlu5
 v3+bUI4AYtF5B7MiSSE7zV2Y1xiGT+h1tXPjxqia4uYRs61rBW/pwAku3z6B/JJm+uUZ
 zZ+Kbn8cWMpwyxB0C2Xy51pJrf+BOGXi6jqlgEvdndbZ5f+LH7bcaY28mVj4isJ9KWnw
 DA+Q==
X-Gm-Message-State: AOJu0Yyh3uXmsntLCdmez/iiXC0dMvQnzjFufDAXu0qVWv8xieW1QPMU
 VPtaYRjbxmZ0OkgRJpKpmfJp7K+lK7NZz/YzeUKBHgYuEJ+BKQ==
X-Google-Smtp-Source: AGHT+IFAl7uiyMuWvQPQA7z8BLcs3Db6FibXY32oiqjh1dTi3DL/l/c1LTkOPjoB5yJ7P96V7K7/465WFf6FFUnnGxo=
X-Received: by 2002:a19:2d16:0:b0:50e:307a:80fe with SMTP id
 k22-20020a192d16000000b0050e307a80femr305520lfj.188.1703243940884; Fri, 22
 Dec 2023 03:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20231221004030.581388-1-raymond.mao@linaro.org>
 <20231221004030.581388-7-raymond.mao@linaro.org>
In-Reply-To: <20231221004030.581388-7-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 22 Dec 2023 13:18:24 +0200
Message-ID: <CAC_iWjLNDo_jDUQ9gdimr+zfRtAGbJ15gP2niNcvb2V7aU_LzQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] qemu-arm: Get bloblist from boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Devarsh Thakkar <devarsht@ti.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>
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

>  #endif
>
> +/* Boot parameters saved from start.S */
> +extern unsigned long saved_args[];
> +
>  int board_init(void)
>  {
>         return 0;
> @@ -144,6 +148,35 @@ void *board_fdt_blob_setup(int *err)
>         return (void *)CFG_SYS_SDRAM_BASE;
>  }
>
> +int board_bloblist_from_boot_arg(unsigned long addr, unsigned long size)
> +{
> +       int ret = -ENOENT;
> +       unsigned long reg_fdt;
> +       unsigned long reg_zero;
> +
> +       if (!IS_ENABLED(CONFIG_OF_BOARD) || !IS_ENABLED(CONFIG_BLOBLIST))
> +               return -ENOENT;
> +
> +       ret = bloblist_check(saved_args[3], size);
> +       if (ret)
> +               return ret;
> +
> +       if (IS_ENABLED(CONFIG_ARM64)) {
> +               reg_fdt = saved_args[0];
> +               reg_zero = saved_args[2];
> +       } else {
> +               reg_fdt = saved_args[2];
> +               reg_zero = saved_args[0];

I think it's better if we fix up the order in the low-level asm code.
Store the variables in the 'correct' order there and get rid of this
if

[...]
/Ilias
