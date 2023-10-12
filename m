Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6911ACDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:50:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0184786F27;
	Thu, 12 Oct 2023 05:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kBxUlSka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C94B686F10; Thu, 12 Oct 2023 05:45:54 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A18186E0E
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59f6492b415so4391757b3.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082330; x=1697687130; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cQFcQT/p/9JtTLgPcw0aLSUmMHRzp1021fjtOf1YC1E=;
 b=kBxUlSkalLaT2uQHZwH6Nv85qOraqm1382PtZCbTyeCZJxMESUaSMezMNzbqJatSQa
 r6ATAAE/IHxbksbrzwgp/iw7g4kdKS3D2ikptpjkcEAJr1FzAciTcR9haZP3YaEm50yq
 cFmw1EAty400oWsB7BN8aLLN9DvGc9W6ym6S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082330; x=1697687130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cQFcQT/p/9JtTLgPcw0aLSUmMHRzp1021fjtOf1YC1E=;
 b=pxueu5vagvpqkpu9lDQdJCBao0+ttsyUSVZmed1E3NsL3FHmIb6eQk4q7tCLVkW3Vz
 J8ychACBWRFIq3OJu7FOAlzKQwd2XkiRvKiLek/hL/0vT4FzNDPxVkpujJ94U9nvvsi9
 +1P6/y9P5SbVJ974CMhAcboyAghekNX0NR9cvKwBbA138BMg2kVXvh/XmaxB/Iv3/4wW
 n0F8DXV4xq2kPsmXycLRSlMLimDOYEUzesc5mw5U/hc+O4szhxNWEw+hM6GWdTfgGsrI
 jscOfHlVEzLwyQvkuzBD017q6NpJoJfOzK6Ec8oAejahDQBTStfkdtgZOUMvA+BwIUxH
 1+Qw==
X-Gm-Message-State: AOJu0YxBP1Mru9P1uv2mEhah41PSuCbeDggDo9Wf4tx2qJe9yG+/8lL8
 kfdSKsQVEDhE4yqeXbJ4skZjmvwRBDDGoZW79zXerQ==
X-Google-Smtp-Source: AGHT+IGqkp+SGg18ZMVuZcfo9Fzj59J5JmhtXYvsPckc2G25IJ0IqhXYl11CGQ1HmTWo12wlEszSmdE+4brwvjyHdvQ=
X-Received: by 2002:a81:6dd6:0:b0:5a7:d088:2c5d with SMTP id
 i205-20020a816dd6000000b005a7d0882c5dmr3165878ywc.26.1697082329785; Wed, 11
 Oct 2023 20:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-6-sughosh.ganu@linaro.org>
In-Reply-To: <20231010091059.375036-6-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:45:16 -0700
Message-ID: <CAPnjgZ1rz-QO4TVqS9_bp1uGq_wk0SXKe5U0pDMi5FUPt-Kq5w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] btool: mkeficapsule: Add support for EFI empty
 capsule generation
To: sughosh.ganu@linaro.org
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>
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

On Tue, 10 Oct 2023 at 02:12, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a method to the mkeficapsule bintool to generate empty
> capsules. These are capsules needed for the FWU A/B update feature.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Use a single boolean value to indicate the generation of either of
>   accept/revert capsule.
> * Move the parameters added to the list on the same line in a couple
>   of places.
>
>  tools/binman/btool/mkeficapsule.py | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
