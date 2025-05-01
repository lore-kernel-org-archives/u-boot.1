Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E7DC369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 21:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6ECB8081A;
	Thu,  1 May 2025 23:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XzWuG7x+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52ED6809D4; Thu,  1 May 2025 23:21:44 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E443D8070C
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 23:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so241869366b.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 14:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746134501; x=1746739301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xDhmNHtBTqL6taITPWaQhD7pZ16YEBM+octd8/qMD/o=;
 b=XzWuG7x+5qLc/O0jVxseBkWdAumhRq4Aba4fATN8s+K6yArfcF3vjx5bZXG/uQsloD
 1dgAEnQq/nhYcNb4GLJkbAhNnhz0R9XHCiFy/ImTeDIXMUBH9aRIWe1LnKEA+KRsLyM3
 K5Zc/m4O7doYCKXm7X7Qn4RmgHCw+1WME5rmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134501; x=1746739301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xDhmNHtBTqL6taITPWaQhD7pZ16YEBM+octd8/qMD/o=;
 b=bOzcsWRMilZnTW2atTEd0jcw+juCwpsYX67yUBdMv0BQKytGdqnv+vl+KG88YHH8ct
 hnKeoabvxJeWHQZdUBf8ZHCjM4g0m9/FwEcDiqfwspg18GtQWMfBHmS890D514oSOy/+
 TJ+DRhVz3au9SJTCBqDYrxZqJhcAJNB8zrc8xlhl4vE+JBUOaehlqNpg6SrF2WcLYyBG
 sAZfsXBNJW2syuo7paqw0r5dBibbw6G8sKFRE6xdzg5QjwBJERwJSGLxaoCE4j2u/Lo4
 Iv33KTzEA6vtVGOZzooLp/IfGvNjt65bZiCuUiX7YDCS/JaP9fkBzg0XstgVV3XlOjO7
 51lw==
X-Gm-Message-State: AOJu0YzG0ZheBC7+UTmm2Huy8TYcKdxPnoNtR/a+ldNmMfo7JPfJHRWW
 iJ+hhi/MLM1v0gIiXdDkjOY0TV2wQweMfCoBRHM/5z8feusoYHk7ycdKKZRMnWW0geViWI9J+Bg
 Ksdo45AhUx7kWI3jv0IO0hwIC5eJZtw4M0dFxdD2SIQXtg8ve4w==
X-Gm-Gg: ASbGncuVSJFCJmCPmuJfPsEoCllJJcImlN+ui5kLHCtjrgTJY63WUPu4GVFBMHMUTKu
 FWyy1iA2qp3SkPBmIlfkvgewoSuLz3Fg7jzcxC7m74cuMqqwMmJdkN5Jf7iM1DOUe3CqCyQgmxs
 JmduonsfRkk21VwYCi55w/GLM=
X-Google-Smtp-Source: AGHT+IGbX2rEiPTbjVXLHl9eb7xW0OrgeftQ4M2ULpZr4CSdLVVNZo8lHInyHiFJCF0BB/PcQfeoCugCqwZuoShbqM0=
X-Received: by 2002:a17:907:3e20:b0:ac3:991:a631 with SMTP id
 a640c23a62f3a-ad17addbe15mr57440666b.34.1746134501319; Thu, 01 May 2025
 14:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThj=AEg3AMEQCLaAEnB7jU2OUSx8DWk-rqj2D5L_Aa49Q@mail.gmail.com>
 <174613314971.2090677.14356696582764281290.b4-ty@konsulko.com>
In-Reply-To: <174613314971.2090677.14356696582764281290.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 May 2025 15:21:27 -0600
X-Gm-Features: ATxdqUEel3iQXw-nsLrYQ1rVkA5WfI_syw1NkL3Vr_eXhFh1dP3RIN7sKpK1s10
Message-ID: <CAFLszTjudvxPQmP+_hSTDhFrQZrcx3OLqXR8idt40Y6ruVVY-w@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 1 May 2025 at 14:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, 01 May 2025 06:06:59 -0600, Simon Glass wrote:
>
> > https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/2a61f40d4a9f7eacce67a80ce79f916996c4196d
> >
> > https://dev.azure.com/simon0972/u-boot/_build/results?buildId=75&view=results
> >
> >
> > The following changes since commit aa96cda0a58f4d181b81a897b0b9fea3d9729478:
> >
> >   clk: fix crash on clk_set_rate clean rate cache (2025-04-30 07:50:18 -0600)
> >
> > [...]
>
> Merged into u-boot/master, thanks!

OK good. So can we now revisit this one please?

https://patchwork.ozlabs.org/project/uboot/list/?series=450861&state=*

Regards,
Simon
