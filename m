Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3812BCD98F6
	for <u-boot@archiver.kernel.org>; Thu, 18 Jun 2026 15:20:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8CFE84995;
	Thu, 18 Jun 2026 17:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZNSdni4j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7B08499C; Thu, 18 Jun 2026 17:20:24 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FD03847C3
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 17:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-695defc333cso1555086a12.2
 for <u-boot@lists.denx.de>; Thu, 18 Jun 2026 08:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781796022; cv=none;
 d=google.com; s=arc-20240605;
 b=cB+08fToFM2GHEIPBitr+/I+EeXz1yLffB9yICbjhlT1L8zG2Dcc3Wp1eG2efz5Bk0
 mQJPkQx2/wDZpHCiLX9VfZTx/XkznvX/cN19ECb2Z8phMX+pVQ3fCdM8WuKXNhN6DRWF
 Kmt5j15ApFPU2ZukNF3aMNv3q+twruRv8rVfuH3RZCKBmGkgfUerJ3EvtOUhVDYvfkk6
 aagb1PxSWS0GQPr1oFYogWMZIlWBu9FBMTvOikSTyw9wKGtmmIjooQVegerst5xfDqAw
 cyehcHKeCInSA7s5P+5WTEwmiRHvYc8kWS7eIAcbjC57UA4hV/o6ijr9zmXCL5SXhDZo
 a9KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6dj6WG/4Ru6MwCZ0+iQ54Vgj1Ssok2zIJXX1HoPUSQA=;
 fh=H7RqxJfeurjghbDv+hGhJi2aDHt5Laf2/SWbGj2OYLs=;
 b=e49IP3t5nrs+p785CsfbTwDDzlx07ZEYTaYnsFUI0vtjHZdhzl5kyL1XYEw4hoqSYC
 PlOZZDe+l0m/hS7HOc705omhdsE2TzoY4FZmZODxY1qkA2VRN5FDHYfuY7DWaZOrVnie
 XEwWPRS+cymRlWo19XTKCS6wXT3F97vNQSWiEl0zomM0NW2Gv38Ubr/O8/dyvrhqbQiX
 l8QefTM8tupqZ+L6r0uCcvB2hAdJ3tjZ7O9saOW+EgBlbZrysS8qrPtaNBAhFOxCEJj2
 vr7vm3BFOPuSPcBIVar+ozON2AoFc9IR/dibTIfeGvMv/YWiyWkg7AgbxDsX1za4rkdS
 X7KA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781796022; x=1782400822; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6dj6WG/4Ru6MwCZ0+iQ54Vgj1Ssok2zIJXX1HoPUSQA=;
 b=ZNSdni4jTI8VVox7kTgK2SZpIyY18bYokVChQAEz6SfxQJhNEJw0p20zuK4knXw3wd
 P6SDPcorqDmpSh8NKrmsufyjwNmKJ1NXgYsKp4Ei4esMi6+P1+e66s5s9NAMsdVF97WN
 pQex0UEA7O89X56310Zi4bgAZ/0VXpbTIFWPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781796022; x=1782400822;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6dj6WG/4Ru6MwCZ0+iQ54Vgj1Ssok2zIJXX1HoPUSQA=;
 b=cilKTEKVTTcfU1MMX7U5KPXcFpy9GrAQpiZtra3CIkziQGxbuXhx5s1h8xMZo3rJSO
 nKLC5JzB4YchTfS0LjM0e+mtk/iv56YWtzsArQ6bMzXCB4YpPkUonvHSBbixEAph96Rx
 C0+0uM6AJH1ZD16waEUVcsOCJmHmbueOxIyLztMS+RJopWkIdSxiFeMdyz/jBHBEPoUG
 oUY7wDz1v3132x1nvnqD0lulYt7gg3g+6z6xmq7fLPgsYzKWPR3h/IS/TXWAKIlnMHmM
 gUoB3DVma1pKdYGn7LFpMB6A93SmzHNO9eM7p9lzZtBXnoLx3Eoby7w+UBJ3OQ3fMd4U
 nM6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Cia3PRQgcjS6Ij7dEfCRwnq/8nHzC4cQzhKSipmXkf7ocvYAP990zYa58Hst4vxoFmO4v7F8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywg3tOAI08sdB0ki4VQyDUyDanPOIxDe911d69idyodXAo64ZB1
 b3Nk3JKYkCMPKmj6jePDR/q1MLWSxOsqgFVh7LouwJrANOpCKulGX4+I9ZBT1xRNV6CqnY0HmG1
 GcbaAv+UFnQFzyW6NJ3lBuqEzxOCsN1J4QCPX/ktn
X-Gm-Gg: AfdE7cnUgTcUwivXTnBK267i+YyAIlYqQIfmZsc0kgwEvfNDvurkndacK5KMn8gtgDm
 u9M0weGCNzeHkn1w7cU2aCWopSuV4NEg85b/knEC2J5Lzup8Nkk36wdCPxKf90CAFhEjFk4zSBC
 smvnrppNvRenr8rDO7lVGshwGjj7mWwwGlTRMCU/BdRniLWz0evI3CSktZtTlc+2L9GfrQ8kQrj
 oaEnftsbK/ILQTI+/T5+0+EJwsZyMuweMKuotwcYuVDBPDwbyJmf/ZApFICQR7xaU9nWzqF7w==
X-Received: by 2002:a05:6402:528f:b0:696:a4fb:f222 with SMTP id
 4fb4d7f45d1cf-696a4fbf486mr276996a12.13.1781796022356; Thu, 18 Jun 2026
 08:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260525132828.3348679-1-sergio.prado@e-labworks.com>
 <CANu7NGuR3JUiV-4xZQ25sc2k2WkJxBaM_pRtKfmscTDPFDMemg@mail.gmail.com>
 <2b700412-b84e-418a-bb71-1bd003c5b37f@cherry.de>
In-Reply-To: <2b700412-b84e-418a-bb71-1bd003c5b37f@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 18 Jun 2026 16:20:09 +0100
X-Gm-Features: AVVi8CfD235LBsHW7oRxWs-VxPQthXy4q5QgGyTqeHTsru_MA38NCHB9EKu55NY
Message-ID: <CAFLszTgj60HKnh9vu2V=Y6O_Adavjv1pDHJ8L7zFiB9zGUEiFg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] binman: add PKCS#11/HSM signing support for X509
 certificates
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sergio Prado <sergio.prado@e-labworks.com>, u-boot@lists.denx.de,
 trini@konsulko.com, 
 alpernebiyasak@gmail.com, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, sughosh.ganu@arm.com, 
 wolfgang.wallner@at.abb.com, bb@ti.com, xypron.glpk@gmx.de, y.moog@phytec.de, 
 afd@ti.com, Wojciech.Dubowik@mt.com
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

Hi,

On Thu, 11 Jun 2026 at 17:26, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Sergio,
>
> On 6/11/26 11:14 AM, Sergio Prado wrote:
> > Hi Simon, Quentin,
> >
> > Do you have any feedback on the v5 series?
> >
>
> I'm sorry, I'm currently drowning at work handling CVEs and I don't have
> time to allocate to review this for now. I am hopeful I will be able to
> carve out some time the week after next, this should be hopefully still
> in good timing for the 2026.10 merge window.
>
> Thank you for your patience.

I am going to let Quentin handle the review on this one, as my
feedback is already addressed.

Regards,
Simon
