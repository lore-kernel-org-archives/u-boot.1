Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA72C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2053681D3B;
	Sat, 29 Mar 2025 00:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hvGQQhym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B633281D3B; Sat, 29 Mar 2025 00:39:42 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6629681DCC
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e686d39ba2so649073a12.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205180; x=1743809980; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4gOnA/xeexjmqtl7hKiH9adWaFIeYtrQPtKssWT+ejE=;
 b=hvGQQhymDsbLruNC5wRFHaJ7vy+kPh7gPdM6pGCzYU5QnxtKr/KHwPYekHRRmHJwac
 2rwg6htDyRA0nQvKCFIwnjt0lOHLcT8DJbicfH/yScTMASctz77ELBX9hf15euD+tozH
 2YzejsoNUludcZItqZ5feaeBCPxc+uw0DF7js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205180; x=1743809980;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4gOnA/xeexjmqtl7hKiH9adWaFIeYtrQPtKssWT+ejE=;
 b=LONDjNdUMsTGtlSR0cHGHzt/Wc4WSJcghearq//xsQjs/RG6+QonbhEcSLy+BQkHkZ
 lXm9qBrTp1FCYDM2nr2BMsMjNvx5g/5IgnVC8bpMtlYS77qKwKM2Ac0Ms5BhGE8TkbBX
 iYClJzIJlkfw3dDqkpjTPxuDpltOz2yR9YggAswFZjdbzTNRYG6sq+phTTzRsqlN88Yq
 Jyaphyey+sZHzJW5Clgr/SqXZWIt6qB/gHAZrXAkgXyG3dDJe67m4aIk+NeAyXWGaSpl
 SjMyEKboXCfS8L7harYxrTlnHFNAGG7kbvzV/bZPAxyJLn4vD2srl1KSHD0TilIUHMSC
 R3iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqF0qjedv15oE/HyXsg57Ra1Ct3IHi6PrGn1TMBkofRAwX9m4VW+4nzuwEAgUHSUGd1L0Gkp0=@lists.denx.de
X-Gm-Message-State: AOJu0YzdRKwj7PyaBx049Om5PvjMhRBFq0YODGPt2E28+DQflQWHWk/R
 PQSSudzy48+ZX3HK6IerBSE4xvqLSxPRZdZtfz+FQP7hT+F1R0/H9Ybbec/lN7i+5z9gYuZlRzs
 1uetlo4RO3c2ep0OKo6S8ZGy3Zu8ZTIgDR5Hn
X-Gm-Gg: ASbGncttHkapSjeVbeUj5jhoAMuGcQZNCyd3+CRzH8keyv2CBADsgkOSuzGE7FAgzYQ
 ZQAHmy/qyNtGc4K3DN/E/r/GAm68lxQuNMrGSCJgXqvDtlPkzuIX+V8JlR5q14ahEYixc4sEAjx
 zRi8pxF79LxpZiOZ6TT9RAGo7fXeg=
X-Google-Smtp-Source: AGHT+IE+9jmAJGWhcJcZx9he5t+LX2r9exT6C7ZSKiC6e+itWn6hXAdyh2uD1geDDssnTZTiYurP/faU6eDvOjP3QCA=
X-Received: by 2002:a17:906:c148:b0:ac6:eaea:c0e3 with SMTP id
 a640c23a62f3a-ac738c6f017mr78608966b.49.1743205179741; Fri, 28 Mar 2025
 16:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250328163115.642347-1-patrice.chotard@foss.st.com>
 <CALeDE9NHP6J97A0Zy13TDB66cpcJutT0DYvU=Ts6G4aBN+RwVg@mail.gmail.com>
 <355ebc65-18fc-4b1a-b1e0-a1d0d7b5e9cf@foss.st.com>
In-Reply-To: <355ebc65-18fc-4b1a-b1e0-a1d0d7b5e9cf@foss.st.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:39:24 +0000
X-Gm-Features: AQ5f1Jo89H-CxNXpN8AY8XPAuSY7vrt_kxSXXRnH8Di58Pci8RSEZ_cutW0PGzc
Message-ID: <CAFLszTg9PCwGD43sOD_anAhY412+J_qLgw=XrNOw2wJJPu+33Q@mail.gmail.com>
Subject: Re: [PATCH] dtc: introduce label relative path references
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Patrice,

On Fri, 28 Mar 2025 at 11:35, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 3/28/25 18:06, Peter Robinson wrote:
> > On Fri, 28 Mar 2025 at 16:52, Patrice Chotard <patrice.chotard@foss.st.com>
> > wrote:
> >
> >> Since introduction of OF_UPSTREAM flag, U-Boot's dtc must be able
> >> to compile Kernel's device tree.
> >>
> >> Since kernel commit 7de129f5389b ("ARM: dts: stm32: stm32mp151a-prtt1l:
> >> Fix QSPI configuration"), label relative path references has been
> >> introduced. These label relative path references is not supported
> >> by current U-Boot dtc version 1.5.0: (see mailing list discussion [1]).
> >>
> >> In order to support such label relative patch references
> >> adds following commit from upstream DTC tree:
> >>
> >
> > Maybe we need to rebase to the latest upstream dtc, I'm not sure pulling in
> > a random set of bits from upstream is the right way to do things as it's
> > brings things selectively which may bring along other issues.
>
> Hi Peter
>
> Initially it was expected to migrate to dtc 1.7.1 as proposed by Tom,
> but as explained here [1] it has huge impacts on several U-Boot components
> mainly due to DT header alignment on 8 bytes (even if some DT check can
> be bypassed using FDT_ASSUME_MASK, i am not sure it's a good option).
>
> I have spent time to investigate some issue raised by U-Boot CI-Build and
> it's a huge time consuming task, more than expected.

I'm fine with this change and I'm not likely to try to figure out this
mess either.

>
> Thanks
> Patrice
>
> >
> >
> >> commit 651410e54cb9 ("util: introduce xstrndup helper")
> >> commit ec7986e682cf ("dtc: introduce label relative path references")
> >>
> >> [1] https://lore.kernel.org/all/20250115144428.GZ3476@bill-the-cat/T/
> >>
> >> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> ---
> >>
> >>  scripts/dtc/dtc-lexer.l  |  2 +-
> >>  scripts/dtc/dtc-parser.y | 13 +++++++++++++
> >>  scripts/dtc/livetree.c   | 33 ++++++++++++++++++++++++++++++---
> >>  scripts/dtc/util.c       | 11 +++++++++++
> >>  scripts/dtc/util.h       |  1 +
> >>  5 files changed, 56 insertions(+), 4 deletions(-)
> >>

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
SImon
