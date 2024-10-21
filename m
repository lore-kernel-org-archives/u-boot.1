Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B04D15DB8
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 16:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1503C88ED7;
	Mon, 21 Oct 2024 18:32:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lbv7c20Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CBF48657F; Mon, 21 Oct 2024 18:32:34 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCBA88F4F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 18:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9a3dc089d8so651809766b.3
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729528351; x=1730133151; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=68cLQNLfbCHq103cxCCpcoRZDFwiQ34jShVpaksg8xs=;
 b=lbv7c20Qimo/9+UZPh/rtCkKDfmPNjwWSL4z22rITMis3YxbFii5doKzoYYCV92pk6
 20c6mvUl7gUfOtA/zPaufbQdm/4uJnVETCa4yQhig3i4677hNb5+UHsFvF3OOCzZ1hcF
 gyVZxpWgWNATX8v6MlKMT2zHylQV+8k/Wilt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729528351; x=1730133151;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68cLQNLfbCHq103cxCCpcoRZDFwiQ34jShVpaksg8xs=;
 b=TTxz1ol3Y10OgB75fzwQSq3Xm4X1pmicKwHLeEpJO9heWthQfsyX59n0rGAvkwOFeP
 fslyIoqbJ5rQv9GWiCJaMbsWZyivn2fHsB8HwpD9RdC1CtD0yPlCan2bKUB4XVkV/Dkb
 sYmLa3pHMF+EkRqysKDxaaX7Urd8xQHVNh/V/aT9u9TF9EKMJC/Q8kewHgvLsB/6UAUq
 OuloGYaDBgKOVXzxtQUf/I2piLPHInH/T5uxGQq8v9j1NWPWw+wMT/xyqSUY6sQqTS6r
 Zph2dqeV3+N5dDH3G3Y3LghJXP62iexvEKRPW3bMXRjWxx/EJlsOpJYt/WL7uPUPwKxQ
 jmqg==
X-Gm-Message-State: AOJu0YyzIAo+b3M0yyRm7Org9Fq5+iAfpkA1dJ2fN5kSBrMHKec19kTs
 okuLxl2Bus7uTec5MFrXQU98zMbuuwpG5JXakyEYv1bCwANPl4TYBsWIzvIgK3fPr3Nsnyf08SK
 xHiPumlFmbzNBHY195z2jDbugXPq08N7oC9bR
X-Google-Smtp-Source: AGHT+IHU6EArF6FBL/G54suctm0OQucqgB+J9QDxBf9aGFgzlZKt27IWWKxN4VT7JFVv59ynllqsuyokyd0SNIdqesg=
X-Received: by 2002:a17:907:7d8e:b0:a99:4f40:3e82 with SMTP id
 a640c23a62f3a-a9a69773b68mr1351934166b.7.1729528351313; Mon, 21 Oct 2024
 09:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20241021134450.22985-1-sjg@chromium.org>
 <20241021143336.GG4959@bill-the-cat>
In-Reply-To: <20241021143336.GG4959@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Oct 2024 18:32:18 +0200
Message-ID: <CAFLszTjK=uw61U_WaqLjBX1JFCC15Ee2dRBm_qGUEsnjqiqpEw@mail.gmail.com>
Subject: Re: [PATCH] CI: Add a test for building without CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
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

Hi Tom,

On Mon, Oct 21, 2024, 16:33 Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 21, 2024 at 03:44:49PM +0200, Simon Glass wrote:
>
> > Something this breaks, so add a test to keep it working. Since sandbox
> > enables a lot of options, it is a good board to use.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .azure-pipelines.yml |  8 ++++++++
> >  .gitlab-ci.yml       | 11 +++++++++++
> >  2 files changed, 19 insertions(+)
>
> I don't like this because "sandbox" is one of the longest run-time
> build options due to all of the tests it runs. And given how we break
> down the jobs this will make a further bottleneck. Can we just disable
> CMDLINE in one of the existing sandbox defconfigs instead please?
> Perhaps sandbox_spl since that only does SPL related pytests?

Actually we do boot into U-Boot proper as some tests need to check
that SPL did the right thing.

Note that this patch doesn't run any tests at all. It just tries to
build sandbox without CMDLINE

Regards,
Simon
