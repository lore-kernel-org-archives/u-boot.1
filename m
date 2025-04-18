Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCC4C369AB
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 11:40:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE5C983214;
	Fri, 18 Apr 2025 13:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VUzaPJrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93695831EA; Fri, 18 Apr 2025 13:40:00 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F9FD831C5
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 13:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5f624291db6so1412913a12.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 04:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744976397; x=1745581197; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eRa/gXbBxDLxY1dUcB66lIggB/GAjNCD4oIaciTHi7I=;
 b=VUzaPJrFlITPAZ8okFe2ow2/dVvYdJGCyP3phUH6T0lC80owhLaLhKpJxEwDOHKT0+
 TyylRuvk8t0pCsMswbzHmNE+Djcst8FxRh4HV+cv3pkcOCL4WhMFiUQJ2GetD1yrWMy2
 jGuYEeCG9IEPbadkjas+CXmv9J4CqNz0RnNKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744976397; x=1745581197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eRa/gXbBxDLxY1dUcB66lIggB/GAjNCD4oIaciTHi7I=;
 b=BJNtQU5wWCDHlnHQKLqBVdAORxrUdGELLEOkQ7VGCAWTAdVPc0jQKRNvUJbKiM/vbU
 2v6UWg1nwArSagjbQr0LX99rhfOGwrHbcVLiZFoYtmIyAEN+nKLQT+9ncUJik6+FkzGg
 9Ry4cIVvwihyeMTHdtAGhSWaNH2bfBuAiJW3gpyTLEafGrClLm6Pwfcn8epVqCkUgiH5
 mE7wRF2Q9wUGs+ZC5RixecZOSOTIzNl9pAZZfNevo14mC+0fXYuFnpC2TzCMnaF2mfdU
 YDR9TEUOp418LqZkkoRUr9uTEkCEtgco1I46haOHPDqL5hsbbZnkX1AZ6GmFbofDmSuO
 Ds2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlpl4ZCPC/+I4tOjfdrQAKnlR5lU36kfhOHqawnVAjv8O4axGVAZseHyE3aat+SgCYMJczyVQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxveeo/CbysI15nUqagVEPmrXeD9M3IREAtns7AWbUirHBe4JaH
 hG8mkpVEGnL4zvIUJmnwFv/YiFH2l3SkvWAtoZ+iuSrQ/4onQtX554NERTFokdZbdUk+rWgK1Yb
 P5OcOcO2JJszRvIwBIJ7fa5NONa3UQ8JwyGTP
X-Gm-Gg: ASbGncueZVabeZJkr3vmCKAnA/529EX3JlIzodZaDGHF3UwuXIpVs7qT4JdOqn6wntu
 7291+NLRFp+GPNdaPOy/ND0X7Fs4avky67EKuKfEetzRQijUcBfsrvxXENAR9+QSyc0NjKDQKtU
 JmouTkCpxkp4bxA8CRXNWkvbE=
X-Google-Smtp-Source: AGHT+IFFqjFoExq2s5uUjOL74fjY8DlmQhMWT7U/+cHbY4YwzlYSfucV9slHg/eCF8lj0sMRiyEu0cf6lSO/l0va5SY=
X-Received: by 2002:a17:906:7950:b0:ac7:b48f:4cd6 with SMTP id
 a640c23a62f3a-acb74b32648mr203388166b.24.1744976397395; Fri, 18 Apr 2025
 04:39:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250418043137.537340-1-heinrich.schuchardt@canonical.com>
 <20250418043137.537340-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250418043137.537340-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Apr 2025 05:39:37 -0600
X-Gm-Features: ATxdqUHvlAPrFUIKnOkVv0mxQHut_KTq8tAxXwuiVMnzcjjtY_fqK5Fo74iMz7o
Message-ID: <CAFLszTghfSaPibqq0PeCCoQ-N1HOrX7WdyHvWU7gmEsKA5DcaQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] buildman: unit test for configuration fragments
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Thu, 17 Apr 2025 at 22:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Check that configuration fragments provided to buildman as comma
> separated list are passed on to the make command of the builder.

common-separated

and below too


>
> In the %_defconfig: target of scripts/kconfig/Makefile the defconfig
> file and the fragments are combined via the gcc preprocessor.
> Modeling this step in the buildman testbench without invoking the actual
> Makefile would not provide better test coverage.
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         no change
> v3:
>         no change
> v2:
>         new patch
> ---
>  tools/buildman/func_test.py | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
> index b45eb95a1e6..95b51af0249 100644
> --- a/tools/buildman/func_test.py
> +++ b/tools/buildman/func_test.py
> @@ -798,6 +798,21 @@ Some images are invalid'''
>          lines = self.check_command('-L')[0]
>          self.assertIn(b'NO_LTO=1', lines[0])
>
> +    def testFragments(self):
> +        """Test passing of configuration fragments to the make command"""
> +        # Single fragment passed as argument
> +        extra_args = ['board0', '--fragments', 'f1.config']
> +        lines, cfg_data = self.check_command(*extra_args)
> +        self.assertRegex(lines[0].decode('utf-8'),
> +                         r'make O=/.*board0_defconfig\s+f1\.config',
> +                         'Test single fragment')
> +        # Multiple fragments passed as comma separated list
> +        extra_args = ['board0', '--fragments', 'f1.config,f2.config']
> +        lines, cfg_data = self.check_command(*extra_args)
> +        self.assertRegex(lines[0].decode('utf-8'),
> +                         r'make O=/.*board0_defconfig\s+f1\.config\s+f2\.config',
> +                         'Test multiple fragments')
> +
>      def testReproducible(self):
>          """Test that the -r flag works"""
>          lines, cfg_data = self.check_command('-r')
> --
> 2.48.1
>
