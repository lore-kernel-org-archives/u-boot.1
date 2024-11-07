Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6401D4335E
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 13:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3167E88EEA;
	Thu,  7 Nov 2024 14:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SSJHpdqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C5889222; Thu,  7 Nov 2024 14:45:01 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 349B888581
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 14:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-720c286bcd6so813948b3a.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 05:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730987098; x=1731591898; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=axghS6fkxwCrk5m05tSW4awczlkLB9v86miXbjOZZjw=;
 b=SSJHpdquTZvtOrr3gwZMKevU59w9ehszWVKWs3W6o1zUv4ap9/X0AGQYY2FcKOZlsl
 Ki93Jzv6dWG3jLj0mS9U775O7Rq02ewD6xgb54BFvzi2V4KOJm9aXVb7b5BfTfzhm4ET
 s/5RiPhJDDMdVZJDjn4TeW2Ch7ygH+Bdm6JxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987098; x=1731591898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=axghS6fkxwCrk5m05tSW4awczlkLB9v86miXbjOZZjw=;
 b=pHHqpgd9Ir71aAYdtzOKZ2HjGct35rQrGDOI2FDm3AuyRYA8uCogNESvOGqTc9V4SN
 wLUTzn2te1VN8uWMxa7eeiSs4osDrTblUUbFs91kkaFP/tt7hjFb7tvSB5OsCSueJpuU
 5qIvPyh7yOLCK3SNKwtm1LQCTslQczzTWVcTCcciN3LmKq4CQPlb1dn9JG0EXObx+V29
 4uJELBhU3gPVDjnJPqhRE1BxjDGCa9RiJUuftpoAPmR+y9+nnl9y6BWPTDLgdUKEr4WB
 r3AU7lLXRgqtWu0Z1eFwANdZ+CfUlcBeteYh+vYMb8Wo8PJyn0fys0o9IVvSAWX1ZZzo
 HtfA==
X-Gm-Message-State: AOJu0Yxx2iQPYd5f3/nDXJ/PfcXhkcLlFJSiR7D9JEPG+eqo9lJ87OAr
 lJNVAm3HJ5w8cEWHPsEl8z4tevAnoi19zSW7TzeXs/MNu1WxqDUE8hPDNWIuGTpCfYF0LZfVQXd
 siqV2TOR0KGLMOFtG7QOG3kEmHXhJyiytL5Ck8l8Ch2JTOUI=
X-Google-Smtp-Source: AGHT+IFEYClxAnzZe8Wa8imm/p+YKeq+khODbzsqNGKHNwvc4aQtUZLMPFdwGSeBWyQ+dOVHIHoLSs1hlPTJJeum6KQ=
X-Received: by 2002:a05:6a21:338f:b0:1db:eea8:6b79 with SMTP id
 adf61e73a8af0-1dbeea86c44mr14944582637.16.1730987097681; Thu, 07 Nov 2024
 05:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20241106135017.696551-1-andrew.goodbody@linaro.org>
In-Reply-To: <20241106135017.696551-1-andrew.goodbody@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Nov 2024 06:44:22 -0700
Message-ID: <CAFLszThTPkJSc_fsFpV=ikt+J6tc3ENtOHLVCNXS90KAuuzGMw@mail.gmail.com>
Subject: Re: [PATCH] test: bootm: Ensure tests can be run twice
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Andrew,

On Wed, 6 Nov 2024 at 06:50, Andrew Goodbody <andrew.goodbody@linaro.org> wrote:
>
> Some of the bootm tests rely on state that is assumed to be
> correct but is changed by the tests. This means that running
> 'ut bootm' twice will result in failures on the second run
> as the state left by the first run is not what the tests
> expect.
> Fix this by ensuring the state is as expected by explicitly
> setting that state.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>
>  test/bootm.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

We could implement save/restore for the environment (in tests), but
for now this seems like a good solution.

>
> diff --git a/test/bootm.c b/test/bootm.c
> index 52b83f149c..9455f44884 100644
> --- a/test/bootm.c
> +++ b/test/bootm.c
> @@ -28,6 +28,7 @@ static int bootm_test_nop(struct unit_test_state *uts)
>
>         /* This tests relies on GD_FLG_SILENT not being set */
>         gd->flags &= ~GD_FLG_SILENT;
> +       env_set("silent_linux", NULL);
>
>         *buf = '\0';
>         ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_ALL));
> @@ -183,6 +184,7 @@ static int bootm_test_subst(struct unit_test_state *uts)
>         ut_asserteq(0, bootm_process_cmdline(buf, 22, BOOTM_CL_SUBST));
>
>         /* Check multiple substitutions */
> +       ut_assertok(env_set("bvar", NULL));
>         ut_assertok(env_set("var", "abc"));
>         strcpy(buf, "some${var}thing${bvar}else");
>         ut_asserteq(0, bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_SUBST));
> @@ -201,6 +203,7 @@ BOOTM_TEST(bootm_test_subst, 0);
>  /* Test silent processing in the bootargs variable */
>  static int bootm_test_silent_var(struct unit_test_state *uts)
>  {
> +       ut_assertok(env_set("var", NULL));
>         env_set("bootargs", NULL);
>         ut_assertok(bootm_process_cmdline_env(BOOTM_CL_SUBST));
>         ut_assertnull(env_get("bootargs"));
> --
> 2.39.5
>

Regards,
Simon
