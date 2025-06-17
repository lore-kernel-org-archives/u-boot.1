Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9EBC71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 05:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABBE81760;
	Tue, 17 Jun 2025 07:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FmlV5pCu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A53E81E18; Tue, 17 Jun 2025 07:55:07 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55BF80C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 07:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70e302191a3so42940327b3.2
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 22:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750139703; x=1750744503; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cLJggnjeYd0z/9vT7eH8us0p/56X114phL2XN+Yt11Q=;
 b=FmlV5pCu4RubXnhVPIGcpfqQtCQ/l/N7U6FdRok4MLr6uOkG6ZVsZCFgE+uzlrADmX
 LxcucT3YQ9VpecvFGm+Ych3L/6/xX8NZv6iq/EDms6QHZVJ3pdnP0eaNKMhfD86zuDrm
 67M3teGaeG+3f4ozuSz+mfi0SFfRE7xscaMAio697KHl+4x9lglO9w16a9+csZphjZtJ
 lF4wSF1U9PSp9HmIa4NvHWgfLH3Lt7GyIQ6goz58BApyWWU5nS+wpx1+bHKPKrK75W9d
 u33E8+KF4Om4X/vYIKZhCcl2Gcucbuz7IU7RQCTh01VPBgde2l6ml7VLyXgSMHandghg
 FylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750139703; x=1750744503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cLJggnjeYd0z/9vT7eH8us0p/56X114phL2XN+Yt11Q=;
 b=pmO+QAh0Dqdtlf4tC1LGpeo6xs/1iCVZWyo/MJRYq9eQgngq/oBSZ1JP90/m09ZwPi
 1uw1nTFXTQjbJZELmD5ucCOimJmA0QKdfNH31429YN9EanQzdWnXbm3IabluJ2RO01z9
 c3ypYtDD1Z9orCF8mnSoVargFB9uDrzl8HkWLutfUNv6w4TSlnacB62h2Fl1/2J2zIGa
 +q3GAJ1LLvDcI+I56K1YuFAV/7dPFbJzth/Sf2NYg3JsttbGmeynA4NyRCvA8URXl6ME
 0xXvelLbASsS2ZwnQEOkhQlSV8XGQ8c4M0yn+RFscmMI8AVme30q9PsiQ7B6C2+qyHkg
 pgnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvsDvzSr28B8jtETKfI8ZI8jTMpOFGRB3OP6Sv5t3dYM+KMiDpxS/xxXKEH2YSYHWI9Q0VLnY=@lists.denx.de
X-Gm-Message-State: AOJu0YzCk8HyqRBJIVthNi7cEy1rons9KBmKVEx068eF94hQXYpUdJqP
 br6VkkiC4JBkkiyQz9El28xOs2/WxThFpnJELHVau8a6hanhwwaMFSRyaQEkXWcYhKKKcdgAsSw
 2Cdbn1s5WOKawU5u4Klq0KJqptS+MocNt72r98Axmxg==
X-Gm-Gg: ASbGncs8F/twg1bWoQhRTb9GJqvroNzkpVakZFKd9RyppDGj58Vlu1KvRZ6L79VeI3Z
 WlY4f8y4krbWRZuWgbYaiHH79Uyv719NgOsAb1QNo4YF1VXx6QeDidJ+/Cw7lKxcS1A9N0V/sBb
 kl69ilyWuyHyCDK7r1FRF4+96G+ErkXCTiUMNeQ9gDRL9W
X-Google-Smtp-Source: AGHT+IEwiMHPbzTXKWRqk1zBXwc/jvayadyCz/JHC5ugBnimBtOLJXZvJVq8e8je8i1D/AFD+SPyDSvRyLjwoJrv40w=
X-Received: by 2002:a05:690c:13:b0:710:f470:154f with SMTP id
 00721157ae682-7117547c547mr160809167b3.34.1750139703495; Mon, 16 Jun 2025
 22:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250616220917.34189-1-heinrich.schuchardt@canonical.com>
 <20250616220917.34189-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250616220917.34189-2-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 17 Jun 2025 08:54:26 +0300
X-Gm-Features: AX0GCFvnkF1SilETLwcfn0-3TOfyD8RukYeufhIpEUkgkPtptl_22FctlbdpJkE
Message-ID: <CAC_iWjK6j+zNRoMS4tvdmrNunQoLeii-Ue0MCt2tLY8pgT9X-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] test: disable TCG test on sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Javier Martinez Canillas <javierm@redhat.com>, u-boot@lists.denx.de
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

Thanks Heinrich

On Tue, 17 Jun 2025 at 01:09, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The TPM emulation on the sandbox is incomplete.

I'd like to add a bit more info during the merge.
"as a result basic tcg2 functionality like get_capability() fails"

>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_efi_selftest.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/test/py/tests/test_efi_selftest.py b/test/py/tests/test_efi_selftest.py
> index 12cbe5caa9b..58dac72fd40 100644
> --- a/test/py/tests/test_efi_selftest.py
> +++ b/test/py/tests/test_efi_selftest.py
> @@ -179,6 +179,7 @@ def test_efi_selftest_text_input_ex(ubman):
>
>  @pytest.mark.buildconfigspec('cmd_bootefi_selftest')
>  @pytest.mark.buildconfigspec('efi_tcg2_protocol')
> +@pytest.mark.notbuildconfigspec('sandbox')
>  def test_efi_selftest_tcg2(ubman):
>      """Test the EFI_TCG2 PROTOCOL
>
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
