Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F326C54F30
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 07:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2DCB830EA;
	Fri, 30 May 2025 09:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NPJ06dd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E5028312C; Fri, 30 May 2025 09:32:12 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D346E830D9
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 09:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e7c5d4709caso1665442276.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748590329; x=1749195129; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zyKXL9lxLAOryRtbQO37Q+Og22rUzXhZ3xhk6IhH98g=;
 b=NPJ06dd3uP2QV8gk37wDrwjpoS3exFS4Mc5YIGK8SrOq3PV3FZ5HeYguNEAkfC+JYw
 Lk6KAaXQ2cdRSbyZWWX8y3jtvTqSDKT2lYXTTGP3jv+ZmT8/Z0UKs+eFjTL84HVoKJjd
 tmvGyfgA97ZNXiCfGQ56xBSpsOWLSDInvqGEUZ1Ap/nhDfzee817PJlLG0JzbtBFLjf5
 oHD7151HUT0abJUQFvIzjg+Go5GJuw4EnTBPBdZ9QDHjxh4B2du40sepkoDeaUFEYI4p
 KWWBOn25lhbV4LUgp7CcwVa9BBur0prIR/SEHrGNFl8nNcn2kMyi0U0dox8+N2vscVNu
 BPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748590329; x=1749195129;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zyKXL9lxLAOryRtbQO37Q+Og22rUzXhZ3xhk6IhH98g=;
 b=BCfVJylpDkxhx4OEUq/zk/MoIeLvJE10/5GLF4S8KJ3NF/YVOb4GDC6xl5uIrV3GS8
 QCTzbYdUSzjXIkl8upnHb2bkhv1m7ckrDMmsOd0POhHi5LgD/ZrRdZcsz0WVITOPS3+d
 KfpdB2oq8fVHIs3jpyX+jiKLGXjcTBoEZFYlfcHh7+YTc7b3PCqFixsFtoME+TGKSpvI
 Z3kW+o0YosaXN5Syu96yFwN56KKF8YZJPYAH+XiTzSWRTXzgin/gvWTgUq3J2QqhWaME
 246+JaoB2HdamrJV4pz5Ga1Eugz/WA/C8+paxusUL8gbNQsdQTAl3S8+Y0pOuwyF2lN+
 nB3Q==
X-Gm-Message-State: AOJu0Yyrn9+F8OplIFBSlF2pjJeoJFfi/jACMF1HlesOw/AEVeFMNwfM
 Qd4zdRqIoP3mZMx2Mi3MLWEaGPg1DW8dQouOq71kuPceriz8+0N/BfzAtXbevG3xuPtO1jtweNA
 ULrRSCbBKBC6jrlkZ9sQDuIW1nCkiIb5M54e+AyVXOQ==
X-Gm-Gg: ASbGnctmO0PzAwCngGkfqIoau47fB0hI5DD3hLPXPOBoEy4cmIE1gN+lmo66MqTSy8J
 4A/TJp2JBZr+Dqdjkbq+U1O5KAvhscEjXmg0qLBZVX3jzdA9ZUOheC77VjCvBqt6Dr8gZwtaJJ3
 7Gnehenuhu88KI+wI9YN83pwse/SiDQ/To/A==
X-Google-Smtp-Source: AGHT+IESjfyLIVvSBpYiK5P6XnctG6Kujir+fkeBWIR+v0CpYeAp/ennUbCbhWAsIHNcNu7edMbnp6nWHdF/2CCDU/o=
X-Received: by 2002:a05:690c:45c6:b0:6fb:1e5a:fcdd with SMTP id
 00721157ae682-71057cceedemr15039497b3.17.1748590328722; Fri, 30 May 2025
 00:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250526091253.400802-1-sughosh.ganu@linaro.org>
 <20250526091253.400802-2-sughosh.ganu@linaro.org>
In-Reply-To: <20250526091253.400802-2-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 May 2025 10:31:32 +0300
X-Gm-Features: AX0GCFv--6uHAc-8AnzAJr0FjnSsOiaPGwyv0QplNuJEQFeCAeawSaFp1tNS_4Q
Message-ID: <CAC_iWjJ1ghSnu5YAN3965mfL_SoadioFeV36yq+8K0fM1+Y=Kw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] lmb: replace lmb_reserve() and lmb_alloc_addr()
 API's
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, Weijie Gao <weijie.gao@mediatek.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

Hi Sughosh

[...]


>         /*
>          * Handle the BOOTM_STATE_FINDOTHER state ourselves as we do not
> diff --git a/cmd/load.c b/cmd/load.c
> index 899bb4f598e..c3ef307bb68 100644
> --- a/cmd/load.c
> +++ b/cmd/load.c
> @@ -178,8 +178,11 @@ static ulong load_serial(long offset)
>  #endif
>                     {
>                         void *dst;
> +                       phys_addr_t addr;

addr is already defined as ulong in this function. You need a
different name here.
But on that why can't you use store_addr directly?

>
> -                       ret = lmb_reserve(store_addr, binlen, LMB_NONE);
> +                       addr = (phys_addr_t)store_addr;
> +                       ret = lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &addr,
> +                                           binlen, LMB_NONE);
>                         if (ret) {
>                                 printf("\nCannot overwrite reserved area (%08lx..%08lx)\n",
>                                         store_addr, store_addr + binlen);

[...]

Thanks
/Ilias
