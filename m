Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD55CCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 22:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE1786FA2;
	Sat, 14 Oct 2023 00:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CChMF+bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E6A86FA2; Sat, 14 Oct 2023 00:02:23 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F5286F89
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso391325166b.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sdB32ReCqQHift6a5ID45zzxuRoBCUG95jcu+OQngxo=;
 b=CChMF+bl0QJpjSTwurjF5emZE8oEmiSlIQ/YZkj4FOKkhmZci6ll/Ec0aqXrBUt1Q1
 zMv/A5SS2+vb7py+wLzf/NV3IzgLgRXf4Q+xYfYbQWvP/ZFjvu6joIA0dyoAONk47lFe
 xheWIL4ZncDYyrCAx2WY1sBWOIhIke5oR0zpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sdB32ReCqQHift6a5ID45zzxuRoBCUG95jcu+OQngxo=;
 b=CPI8Hwt0TvxLycPxNgYMo8Zl9mj/sGaCu7GxjEhUvmX/7ZJbw77kqG+G0e3Ysg2X4M
 W6zeTB74K6eKKeTZeiDUZjc9GwUe90uAd9CnO/Mdvyc0GGk3kuqowjoyWPQZt7ndTgnX
 StIRhX8FO9GnVL8vdYs5rRLULBts51G+FkycujDv+LzJVDfH/56+RJVTn8/OH/fh83p1
 BIDsFpaEy2kGvPq2em/O8iwz4IUVBn5l21pXqVkzjoXvcUi8Y9iSV6EIpTeA8WjDutEI
 PvjIPz2NakFCEJoBRylsGxEM5aIFbFTV3cL7dx9qfVU3vN2JeP0HpEH6rU4AuuCvAFM/
 UFHw==
X-Gm-Message-State: AOJu0Yx/62p9/3/pCJSM8e22hHPxOrrkeVbS1SGHuYx1pEufYhRbgFSg
 EFDWkDKTO7XQrh05mkRKXYwiOYMJ0KUKfO6Pj/L79A==
X-Google-Smtp-Source: AGHT+IGCBismacNEZbGkrwp2XsE9ExC5EKVBypVoEvcbZUDJxWyL7IAmilXULVPShEMZ46aHfMW48ASWAVzjBzyvj4M=
X-Received: by 2002:a17:906:209a:b0:9ae:69ff:bcdb with SMTP id
 26-20020a170906209a00b009ae69ffbcdbmr25154136ejq.31.1697234440257; Fri, 13
 Oct 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:33 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1rz-QO4TVqS9_bp1uGq_wk0SXKe5U0pDMi5FUPt-Kq5w@mail.gmail.com>
References: <CAPnjgZ1rz-QO4TVqS9_bp1uGq_wk0SXKe5U0pDMi5FUPt-Kq5w@mail.gmail.com>
 <20231010091059.375036-1-sughosh.ganu@linaro.org>
 <20231010091059.375036-6-sughosh.ganu@linaro.org>
Date: Fri, 13 Oct 2023 15:00:33 -0700
X-Google-Sender-Auth: Dv1cARIU5AVg2on_7JACzoDAIiY
Message-ID: <CAPnjgZ2wVGrma0DAPHXDH7Lrq-XdEa5xmi1ZUBkFDsCvrNCENQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] btool: mkeficapsule: Add support for EFI empty
 capsule generation
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>
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

Applied to u-boot-dm, thanks!
