Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F4DD6ACD4
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 09:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83BC583C2B;
	Thu, 18 Dec 2025 10:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YIK522ND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C35083C54; Thu, 18 Dec 2025 10:31:20 +0100 (CET)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED17483936
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6446fcddf2fso370665d50.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 01:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766050276; x=1766655076; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbuZIPBoa4IY19OhiDY4ijFUVIx6W7PGvaAsQ958CAY=;
 b=YIK522NDzryxyJMhz64Mb314zhhF61l1Ckcf9WUb/NRhkyMNGMisjV+wjGv4qPwak8
 eewAwTSTW1Phec3Lby07n8eqgALqM0uUNEfWD/lU0kue08kfGAEmtr/FB4e0WKuCozrj
 CeCKgKj8WGbaL8BNEVaHhIHIRB/SAVYuvzy3pDorXKS2IoGGO2tjyI9iokLP+dMiH4au
 Qm8br2PP6kJnU/iBndL5kO+MnAR+hOhCvJIoj4IW8bBIfyEO3sXyD9eIsnBI1LELAmDE
 0MfrnuXmg/qtyjUkuB4aRF5w95TrL7BLDZIVgaSSCwXfTNUj+3Cd0go8bUuTbnu4r3az
 mhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766050276; x=1766655076;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qbuZIPBoa4IY19OhiDY4ijFUVIx6W7PGvaAsQ958CAY=;
 b=ev3oaAFJRVHPXL0h8I37z54OgynVwfgTpjapKEUkDSmX88/Q/qiOMcAurMG8Rjc7v+
 XyTWNINwAcRaXEPnUlI/yBPJF2anwv4IDDrzZxnUVRE5lepjLbnqdM6yleV/rpxwY2RA
 Exf1XQaC8EVWOcmWg68RiqPh7+sQTMV3OGucmZzMqoAV++LmRAVlLvxcE/Oth9M2toQl
 wCrvizvKPIE+JI9PXyk9JfCVGv6m0lm6kDTyE8Votnjz6ncSNy5z+aPW5tx5Opttk++S
 YUe7rUnINtQAKRf3jT7/NSJfqCU1D9C3SfzXm4iqxWChl3CKKmbYAK+1Sqyeon3JORKk
 igfw==
X-Gm-Message-State: AOJu0Yyi6S15ZgZYHe59cyw+4vmtj1evTOHOkWXXEfE0Vs2R+oFSbeRn
 yPqV3PUZwijJWE20Yd7I6KafVm8KqFjO/AzAHEH2ROMvJaWXsRSrKFamiNtfQsxC2dWl62CrTPg
 kLnbThan98/4dNzl4Sg55wd/zmxAIoarXtJn7MoKkGA==
X-Gm-Gg: AY/fxX4YowXd2Tsf0W7NjohwyIf0gkHRrFuYXgJOq7+rksJ58EdiRt0zJJBpX9phgvI
 Obow1LNnt3k4e/wGX5Yp9l7Cdot7VxATTwA5ahkVl0oDfLNjq+9UqI/X4WbJ5td0HCDN6JOM1HW
 P2fEj28f1UYzb0WZVbz6POFjNCXU/LtKgIVbpoXDSAEQ99dutzgu2XKiSXpWZqIzpMqb4nKQp6q
 28i65q1nlikh6fhs55/ZEgBdstq5ySkQN+LeGuu8VcUs9UE+fw3Rhxo+MsaygQ/x9wvETbfK9ga
 tT7LB9VJotfoR7gFRacsUafOpVRpV5GYD12o54vcQY+GqvUg5rOk369Hvf8h7DTSX9K0uzlppyy
 bpMyDZHTgHiMzuEknisKDa2kPPplCyooJBUrVVeBXMdN3TzPoCxrSbkBIz6zl1NquOoHDGuaBlF
 ZHq0UZ1ADbamu2xU6KJd6BRzqGJBiLfEBaIsnqQzC2+qfFU9KYteTwhNJXOeCMJWl5E9PBke+nE
 3RFxqaF/OsqkbIbCWRA+WZhuA30QHxXUm/qHSWxDvk97DarGGSw9P+UZ6gc939TK6kPdAHaGx4L
 TVHwXc9UyylPmGwQhm9Db60+PFBni+8=
X-Google-Smtp-Source: AGHT+IFujo7cSq8p9/WBcrkD3T88HwelMyESE7QHh7VPgXWCQNaCBXwso/BRZo+cZYUvnvIf1XQLmUe3Vt8jgbFCPUc=
X-Received: by 2002:a05:690e:191a:b0:641:718:8a04 with SMTP id
 956f58d0204a3-64555643613mr15917988d50.56.1766050275644; Thu, 18 Dec 2025
 01:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251217195811.754518-1-marek.vasut+renesas@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 18 Dec 2025 11:30:39 +0200
X-Gm-Features: AQt7F2qeZHfnfhyzpv4h2ZEy0msf_HmUnoczTQ9-trTPK3lr0t93cRO92lZJtYM
Message-ID: <CAC_iWj+Z577Z2cXbCahAENpNnmZ+unx+fSLGuZ6yr9Zyp6a+iQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: nvedit: Validate argument count before use
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Patrick Delaunay <patrick.delaunay@st.com>, Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Wed, 17 Dec 2025 at 21:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> Avoid NULL pointer dereference in case 'env select' is invoked
> without parameters, check the arg count and make sure it is at
> least 2, otherwise print usage.
>
> The crash is easy to trigger e.g. in sandbox:
> $ ./u-boot -Tc "env select"
>
> Fixes: a97d22ebba23 ("cmd: env: add env select command")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: u-boot@lists.denx.de
> ---
>  cmd/nvedit.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/cmd/nvedit.c b/cmd/nvedit.c
> index 11c3cea882b..636bddee1be 100644
> --- a/cmd/nvedit.c
> +++ b/cmd/nvedit.c
> @@ -499,6 +499,9 @@ static int do_env_load(struct cmd_tbl *cmdtp, int fla=
g, int argc,
>  static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
>                          char *const argv[])
>  {
> +       if (argc < 2)
> +               return CMD_RET_USAGE;
> +
>         return env_select(argv[1]) ? 1 : 0;
>  }
>  #endif
> --
> 2.51.0
>
