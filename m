Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB425E77187
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C721480296;
	Tue, 17 Dec 2024 20:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mJNOqfJG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE490801CE; Tue, 17 Dec 2024 20:47:23 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB43580107
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a0ec0a94fso892894866b.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464841; x=1735069641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mpn0/1caX4FT6drAdev9npOCrnUAZ9kQGKKoLgF9oq8=;
 b=mJNOqfJGOqCF1dEUQqJebM2nvkKTYu6jlhHojiI2ezbvLYxBY8cRoDvTkq/7QdIseq
 Q7d5coYdu5xz+hyRF3eiszrxk4qDcqr2u30rPPUGNRfMODj3LdgODvVph8XrzVfCgtCq
 bzRNcEGXs4SrP16YuTwPFUVOR8cc6gcuh4+pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464841; x=1735069641;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mpn0/1caX4FT6drAdev9npOCrnUAZ9kQGKKoLgF9oq8=;
 b=PbwhBE196Ge+c4iwfvKdyaq02Cp/tqXtJYLlRr5KjOPUF1GuOhPE/TfEdrg+CTpU+0
 BUtvzxzybDBAPk3ZfDATVIgXHUSXOwmX3kkLM9uZ6B4dNT2rtpVc1sTvu9AgTBCzzp5o
 Kd3gJT18+wV6Uk9+MiMt7uONif20cyX1PgsT0+eD4K4+K8246sAtx/3U8gJPtdtpmGq1
 WkUHlJvQ7BVYmdg/cHoritiQeHdNqSonw6kMYesXUmU9XNuE/V5EM0XZyqckk/cTA0t1
 JuBPSlIPHWAb5Rz/wnrFerumwx96EfJ/NtzhI8aYcEEItim8gwyWfw8wYbrId7zh3pnk
 7/ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVae4Jc1dcCXy4oh4vIBZizDQNP0VhY4FMkf3hCrGSRwcA7fufwzuSQVGHn2cgZEwuqlVBvQLk=@lists.denx.de
X-Gm-Message-State: AOJu0YwN/qvx4/wSGCMAc7TZffkLH3n3GAGlAstjEA3/64R51q1bTEnb
 PpgiDAp2Pyny76q+EEleeVk3UZVq+KB1bZs0TFzynT6L731NFLsgdUtWnxf4MxW1uCRm9YUKVL2
 hpB85AgIB7XrDwn1XnxcCBaaq0KkpAUDtsw1u
X-Gm-Gg: ASbGncs9AWy6SY/tV2iYlFV68oTJmY8W2/NRop/QI3Bxjy0IasdNbhWhC6uFRZ5N/H1
 FxDH6YYJcVzB97hpBLZhH51i5i1Ergdi2STf0rio=
X-Google-Smtp-Source: AGHT+IEO7P0De8k4yUXsmTQLVQ08u4VD7vZOzraFbzA+5B7Ah96mhjr8jpaofv2PYqPfxKuok9LxDzd0C+bTx8ApDO4=
X-Received: by 2002:a17:907:7290:b0:aa6:79fa:b486 with SMTP id
 a640c23a62f3a-aab77ed3a3amr1973473866b.49.1734464841364; Tue, 17 Dec 2024
 11:47:21 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:17 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-17-sjg@chromium.org>
References: <20241211135418.563803-17-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:17 -0800
X-Google-Sender-Auth: rMdKqxHeCWiy2qePPjaZgbNJOfY
Message-ID: <CAFLszTiuHyPjVgpyFHcfMMp_h+pdc=UD-esMxTioDf9WSTTTjw@mail.gmail.com>
Subject: Re: [PATCH v5 16/23] efi_loader: Use correct type in
 efi_add_runtime_mmio()
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This function is passed the address of a void * so update the argument
to match. It is better to have casts in the caller than introduce
confusion as to what is passed in.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 2 +-
 arch/arm/mach-bcm283x/reset.c           | 2 +-
 include/efi_loader.h                    | 2 +-
 lib/efi_loader/efi_runtime.c            | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
