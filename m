Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C0CC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 15:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C9F879AB;
	Wed, 27 Dec 2023 16:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mhwqaEBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F60879C0; Wed, 27 Dec 2023 16:51:04 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56D8D87956
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 16:51:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso502370b3a.0
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 07:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703692261; x=1704297061; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cn0njpAj0v3ew9GFnRaQmUYWIGGRGjMeBAFwDccb6eE=;
 b=mhwqaEBYjSUVCaW4BVMuY23Ezi22wYS5D/OcxNXXOsyaDvbbwjCgaNWXvDBHZLJAqE
 hbTxpEyn/nMijcyNgh3Zky0iaG+vE+LxsPxyZAiK23Dzn2aISe2bRddTn/0CCkj57447
 kSw4XWZKj1nJ6W1konLPc3BkT7/Uz70UoN5958F/knKQh+0CSCttXgcZ4wY1fYNbLUoS
 4N2krropgMhFPxd+IoWxor+33IwEFFDkYU8J1NipoTq5klEMKnYaQRxrU8oLEPedwN3e
 kTceqA2d6YLV3Wa+qWOHGLMBi9FF7wz7hOW3X51yASiU29Xa0zjMMxgaoQDrsKUO76P0
 ZaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703692261; x=1704297061;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cn0njpAj0v3ew9GFnRaQmUYWIGGRGjMeBAFwDccb6eE=;
 b=nGHMNZYL6NqPI6NChE6PtuKtRGwY7DGoV9HheC2Q81IDddxqG0L6OwezK4t55H03tr
 iiVtHyanLfl1/DYJj/G0It4AWFmlYPERLVIIZHcQX06L+wGg3M2lmegvNT2VosVXs50H
 YyoKIgwTqfDOxrJA97AyzInodm5nZQVGAtjwB+jiz5DRWHBIUdR1JPUIAs99wuClMmC3
 2rmKN0wRwAnUp85JYq9wC9Yu5PA2tIvKyOVmuYWGNF8E7Utnd/kml9N20UlluwDQmS7z
 FIKHwT/zVSK5MAT+Bhx4Pha/lR8HYxZszQ+wWU/sBIA1YldNKt7tp299PKhbpjQaHNK9
 SSfw==
X-Gm-Message-State: AOJu0YzbcxotqjA+4B1KlPe/LrZ/dozx69nRT2CmByJB14GmF4NMQMQN
 cdDYP/WvTRc2jhxkpSogeYHCSyulAQ3v2aZsI6i/SybFC1wEZw==
X-Google-Smtp-Source: AGHT+IGqgtNs4ry4Wd/PpOQ8XXh3MnjFypgYeQj0IOM6KGhSQ1slHKo3U0XajZ8RmIY/eKFZP01PETEdwu+Wu/Nk5HY=
X-Received: by 2002:a05:6a20:8704:b0:194:101e:bca4 with SMTP id
 e4-20020a056a20870400b00194101ebca4mr2545419pzf.108.1703692260732; Wed, 27
 Dec 2023 07:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20231222213110.660402-1-raymond.mao@linaro.org>
 <20231222213110.660402-5-raymond.mao@linaro.org>
 <CAC_iWjKcR6yC7yG7SLQz_QCbxjCC2Ai4qB8hyLq4QW8t1BN2EA@mail.gmail.com>
In-Reply-To: <CAC_iWjKcR6yC7yG7SLQz_QCbxjCC2Ai4qB8hyLq4QW8t1BN2EA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 27 Dec 2023 10:50:50 -0500
Message-ID: <CAEfUkUJwej0uYJ6nVDGD2U=b_Ne=1a8Prba9Na_E4ZrqXGanUw@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] arm: armv7: save boot arguments
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Baruch Siach <baruch@tkos.co.il>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Qu Wenruo <wqu@suse.com>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Ilias and Simon,

On Wed, 27 Dec 2023 at 03:30, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond,
>
> On Fri, 22 Dec 2023 at 23:31, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Save boot arguments r[0-3] into an array for handover of bloblist from
> > previous boot stage.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - New patch file created for v2.
> > Changes in v3
> > - Swap value of r0 with r2.
> >
> >  arch/arm/cpu/armv7/start.S | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
> > index 69e281b086..2ca63ca32c 100644
> > --- a/arch/arm/cpu/armv7/start.S
> > +++ b/arch/arm/cpu/armv7/start.S
> > @@ -152,9 +152,22 @@ ENDPROC(c_runtime_cpu_setup)
> >   *
> >
>  *************************************************************************/
> >  WEAK(save_boot_params)
> > +#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
> > +       ldr r12, =saved_args
> > +       /* Intentionally swapping r0 with r2 */
>
> That isn't very helpful. It's obvious what the code does here. Add a
> comment on *why* (to keep the c function simpler etc)
>
> Yes. I will update the comment.

[...]

Regards,
Raymond
