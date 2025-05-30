Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B7BC5B543
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 17:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0348C833D1;
	Fri, 30 May 2025 19:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O7nnALfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF740833D3; Fri, 30 May 2025 19:36:14 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740DC833CA
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 19:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6045b95d1feso4319783a12.1
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748626572; x=1749231372; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IW6VDCRAjQpMY5l3FYaem/aRsXjw5wcVyKpg08w09X0=;
 b=O7nnALfdIbpA+27gj12Ou+J8r8MqAbL5mqMqGIPGb3lY+/WcZET4Ir0Twox06U6+nn
 NfSMPfokgwLmkMbAPFULdsGiUTMt3JW+CRbCJm9VN8yYtNq0Wbc6a9pjfeGkqczq4SlZ
 wZv1qCxuz+s1ODvrtNbd7t6lPyWWsmtfqMoIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748626572; x=1749231372;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IW6VDCRAjQpMY5l3FYaem/aRsXjw5wcVyKpg08w09X0=;
 b=vTNWAcAVOpHZ+LeYSsYhEdpeYOenmvGmRh3Ad446op874WJ/kr0W7ujJ8Tcbsarkdq
 bpVuxa42pZV55RViovIpGB2sjNc6Vqvjru42lKx02MnY4Zoj85WlNz9SPh867ofFrXWG
 yK6qljVeTks3Fn9tvTZEyJnVmV49Ep8lX36BN32XSzwe5aVjRBUPvvNawDqXAAfbrvo8
 Q1WP/LddnbjFtlXvSyObv0jbB6gmFtYaI7mwOmMyGI/Yk/GmG5Na5tSgO6XTU4zHSg7U
 62r4ZT1hBdgBxTAj1E4tG4+GPhMR54AdBmLf+wspCJiijAF2+yCPYze6Dxm/M/pJTupX
 PBiA==
X-Gm-Message-State: AOJu0YzVo1bi6bKgTm6XBou7fZleOv23x8jMgn5ch9XnLrazSjjPYiYF
 G0EjATMHO4J5JbHhfq/RqoAICeeKk/v5Tqx9duxfoRlDsUnSiSJQvrmDKm0K/cvHggcBjkgq1XP
 wn+JCNHqnyRLaGgw3yihtCu4If0UAqYzmRDyoAIUExRyY1mECouVleg==
X-Gm-Gg: ASbGncvfmJ+Mt+vfiXCntJDwyWo+yKLK9q9VSbt9ov7uRQv+jBml6Prw4+G+PPW3CM4
 CbDWoCv9oVLd1wBmzbu76BrjX4Kuk7jDnueftSMcvzo1IDFbOfLZIf/6UAb1Tolp75SAl7HditP
 Z7b20u+uoCBGtTUMqmM6c9LWnJfUOs4DY=
X-Google-Smtp-Source: AGHT+IFUskaPn1aKaM3c2Iu5acpgB4cCNBYPoxLKRJEQDMnG9i1tgBrd9/4IKocE8aXv+EkRg+AJqUgMchzae1mIDOI=
X-Received: by 2002:a05:6402:5c8:b0:5fd:c426:9d17 with SMTP id
 4fb4d7f45d1cf-6057c63e5a9mr2780370a12.34.1748626571841; Fri, 30 May 2025
 10:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTiFLpYoJnu65CWgqKgq6=ffXpWh4kcXqSaBjAwgkoP6vw@mail.gmail.com>
 <20250530140650.GT100073@bill-the-cat>
 <CAFLszThB6uWQuAM2e3UP1_x1qRWjBU24cLYApjs8RSN7oSHHTQ@mail.gmail.com>
 <20250530165909.GU100073@bill-the-cat>
In-Reply-To: <20250530165909.GU100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 30 May 2025 18:36:00 +0100
X-Gm-Features: AX0GCFulMqCFCc04mxkda0vlV5hYvsEQvwxsIWFWAzGyAU-dJ8wdkrAJzDrCL-g
Message-ID: <CAFLszTjij_jndT1Y=UTusSXQ0ybG=tPNThwdAQZZ0cO_NT45bg@mail.gmail.com>
Subject: Re: Azure runners
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

On Fri, 30 May 2025 at 17:59, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, May 30, 2025 at 04:42:18PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 30 May 2025 at 15:06, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, May 30, 2025 at 02:31:13PM +0100, Simon Glass wrote:
> > >
> > > > Hi Tom,
> > > >
> > > > I have always found the azure pipeline to be slow, but I found that it
> > > > actually does support having your own runners / agents. I set up 8 of
> > > > them on ruru:
> > >
> > > I had not seen that before, can you please send a link to the
> > > documentation you're working from? Thanks.
> >
> > Hmm, actually I used Gemini, but here is a link I found which looks
> > like the source:
> >
> > https://learn.microsoft.com/en-us/azure/devops/pipelines/agents/linux-agent?view=azure-devops&tabs=IP-V4
>
> Oh right. I think it wasn't clear last time I looked if you could mix
> pools, and we also didn't have enough resources to replace or augment
> the Azure agents along with Gitlab agents.

OK, well ruru is mostly idle so I thought it could be good target. I'm
just not sure why it doesn't quite work.

- Simon
