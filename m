Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECD1C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC5A68789A;
	Tue, 26 Dec 2023 10:48:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fswU5Adz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCD9387915; Tue, 26 Dec 2023 10:48:08 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E9D68781A
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d422c9f894so22614385ad.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584085; x=1704188885; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ98NoUNJ0N+Dpu0k7JCQGL/a5pTSJmPSbC6/Q/MxQ4=;
 b=fswU5AdztclzI1tka/Vg8zNllKSIfsKdoEWKOBUMcYpgb6FtWU1KJ26fPzJE9FEWDa
 1JH9F8iLWtrPFUTFvpNLOSOoGU7Mru7Mrvi/6HEkoXY5Aza9ccgDH+MgCJ5SryKeguOX
 Vo/pYyNbIZcvQqDnTDA0BAyYp4O5ds9E95zqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584085; x=1704188885;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQ98NoUNJ0N+Dpu0k7JCQGL/a5pTSJmPSbC6/Q/MxQ4=;
 b=gvStWbX4vPLLzQMknKDzqnsYloagMB0o/Z/THLEsu/KYhRjITAxmcONlgP0GVDLjNP
 gcb/GDnqFV6icj3gJz8DxU3BX9cWA8RE6ctANFDmvlxCAd0V7+S2mwLlykE1bFbk2HuN
 YVB0ftlRoExn04awCm1guAILXoBTL/7mbmu5dsJyi1RN6yjxp/P94VGdoTCiajRaApdG
 SHR19lURtxWKVobgsss9asodwdaLhABFAvBbucYU3LH3XkJY3GkOiWXA7oGCLCdJLvaU
 8oruvbhpIzuOMFw1Xz+dSJkzpGjHpj1B6SkfJ7Xf0aUrAYasKzu7uRYeZS14kz02++7N
 7ZNg==
X-Gm-Message-State: AOJu0YxQddrT5a/4uHBd0gEsThEpOrfO0jpOITT66O5Tht9lP/jIeu6R
 a+m9e7EnldFKHkA4nUu3f2IS8Fk1kh190f6VJmEe+9Xu/S7W
X-Google-Smtp-Source: AGHT+IE+t7Xgvg6oD6o7nM7gVeECMDj5+27H/nmkF0n67wfZ0ROzeXkntIFdW+bkbpdTRQFST2+d3tdICjcx/ojfnrk=
X-Received: by 2002:a17:903:64f:b0:1d3:f3c1:57a5 with SMTP id
 kh15-20020a170903064f00b001d3f3c157a5mr6841259plb.86.1703584084957; Tue, 26
 Dec 2023 01:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-6-raymond.mao@linaro.org>
In-Reply-To: <20231222213110.660402-6-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:43 +0000
Message-ID: <CAFLszTjikngxRYyyOmWy7VtX9u2z0TN9fQnaQbF4Ge-Cn4bYaQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] arm: armv8: save boot arguments
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, jwerner@chromium.org, 
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

On Fri, Dec 22, 2023 at 9:32=E2=80=AFPM Raymond Mao <raymond.mao@linaro.org=
> wrote:
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

Reviewed-by: Simon Glass <sjg@chromium.org>

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
> +       /* Increment the address by 16 bytes for the next pair of values =
*/

That seems obvious, but I suppose a comment here is fine.

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

Regards,
Simon
