Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABC3E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:46:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4F1D801FB;
	Tue, 17 Dec 2024 20:46:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MgmptYKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A6B780107; Tue, 17 Dec 2024 20:46:40 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45183801FB
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:46:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa662795ca3so7168766b.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464796; x=1735069596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kQwwTjonLXf1MoLZFeGp4hSgpdUB2GKNg7tRWIYTprc=;
 b=MgmptYKVfOfyeV9oHoXUYySgntcp3Hwj1k0Nk56D0MnahS7c/ZJp7f5Zu1QLsp9bhq
 lFymmehmRDwyKJ+7QdZca3tKOP6ziEfZKp8HcnjAOpC4mBQeeq7FuRaTMc2Dz0NmBOVi
 L2nr6UG6sXVclBxf7XcyxioBEFMEZvX1gwsXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464796; x=1735069596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kQwwTjonLXf1MoLZFeGp4hSgpdUB2GKNg7tRWIYTprc=;
 b=i/VOjYR1x4dLgxQAU1MIwNhs6PFam24f6DHhYwU3BsuYCdbBCyZA9WUzTZOH8gQ7zc
 729fVmxcV/uHRI28EjETBWEQXP9UxGy2lZ1YMQAkqdLAC56lXlwxpQFtUdrRx+5uryI1
 CYKITKiRc4BnoFfxKPlvqELD+OYX0PH8zNMnRcj4jdJ8t/R4uriG/nB82wOz5KBNswq1
 IaqehE6W5MZJywZgAck/h3fGC5MvKhLvzV/0ohUyVqOPZDWXqdxl7UuDjOcxibe70I/f
 wZEqo8dE70/tK86RUQKps4bUCJsM2+LHCGJc3TG7Hfvh4L+R/L1YddHFj6W5obw87vgy
 dphw==
X-Gm-Message-State: AOJu0YxQGCfyKDEahVFQI+VlUQa9Dn7RelgO2ON+yKE9NVfq9ZrCIZkk
 7HJsPZ9b/zmK4W7ZdFT6a48mdvepchUtJzjNLnjySJM7Lk34BkUumr9893kKCojukiZjaNLRFIF
 St/a0tLywzOWuHKMtY1FuljXyHpLxp2V+aLsg
X-Gm-Gg: ASbGnctgwT2YyHY2c4stE2GKt9Ldugh1+vEJrbGwSK5Gu1CRxQ6bhFtDRWWdDi1SQkn
 mhIsQERUOVKfYczKTtYEC9totkaQFPZ42GBx4xPE=
X-Google-Smtp-Source: AGHT+IFFDCAmAqd1HyV6nilu6bl7QXFmiRZ4J9YSM0TLYcKqK9zTlhqxMx0A2j8BEW26Y4dRS5vBCPWKrSv5LQ6kmPA=
X-Received: by 2002:a17:907:9725:b0:aa6:112f:50ba with SMTP id
 a640c23a62f3a-aabdc8bd101mr506355066b.13.1734464795766; Tue, 17 Dec 2024
 11:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20241216233853.2125656-1-sjg@chromium.org>
 <20241216233853.2125656-2-sjg@chromium.org>
 <B12C4F95-DD8B-44C3-AE40-3EFFB7402914@gmx.de>
In-Reply-To: <B12C4F95-DD8B-44C3-AE40-3EFFB7402914@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 12:46:23 -0700
Message-ID: <CAFLszTh+UE6LywCtmqEUdeYSFsNjZFk-pCUTEYGV-=ptC43OeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gitlab: Add a StarFive VisionFive2 to the sjg lab
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

On Mon, 16 Dec 2024 at 17:23, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 17. Dezember 2024 00:38:53 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >I have one of these boards loaded with Ubuntu 24.10 (64-bit). Add an
> >entry for it so that it can be used for testing.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
>
> .gitlab-ci.yml supports an include statement.
> Maybe it would make sense to move the lab definitions for lab_dfn into an include.
>
> Such a file could be conditionally included:
>
> include:
>   - local: 'lab_dfn.yml'
>     rules:
>       - if: '$LAB == "dfn"'
>
> Cf. https://docs.gitlab.com/ee/ci/yaml/index.html
>

Yes, it would be a bit cleaner to have an include file, but it should
not be conditional. Tom is missing a patch.

>
> For the current patch
>
> Acked-By: Heinrich Schuchardt <xypron.glpk@gmx.de>
>

Thanks

>
>
> >---
> >
> >Changes in v2:
> >- Rename the board to vf2
> >- Add a comment about what the board is
> >
> > .gitlab-ci.yml | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >index ffcf8532944..a17c1b0a366 100644
> >--- a/.gitlab-ci.yml
> >+++ b/.gitlab-ci.yml
> >@@ -696,3 +696,9 @@ rpi:
> >   variables:
> >     ROLE: rpi
> >   <<: *lab_dfn
> >+
> >+# StarFive VisionFive 2
> >+vf2:
> >+  variables:
> >+    ROLE: vf2
> >+  <<: *lab_dfn
>

Regards,
Simon
