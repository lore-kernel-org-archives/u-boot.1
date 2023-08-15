Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6879C0015E
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 21:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46669867E2;
	Tue, 15 Aug 2023 23:05:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vLj00gHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD147867E2; Tue, 15 Aug 2023 23:05:36 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A235586852
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 23:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so34872195e9.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692133532; x=1692738332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ktzTSbDpIzNoYWgyiGJTxE3eT4ODZ4r7QcReNJM/+8k=;
 b=vLj00gHEp3V9h1FSLLI1lPjsM0bVn8n3VVsKqIGRQLpsV/UbfeUyoJByixJmiwy7lR
 QFK/E3c/sZzxLuEgY+dm+Ohtw11Q0EvccruMPMkLemOoyc7qC2Wh8nn/XvM0zBb+iNMU
 L7KdhAigJzN9i3cjvkz9ALBZLzVZFAY6QhLSnkQTjVsijo9ucW9R3S6IaBzwTBwIx4u/
 j0KNXVQCc90uOwXYfcLZA/2dcdS49bQXJZq506uN6PehepjmXpfBCGHc7vZIr70V/JUz
 np9/EO/uziG+4x7hvywqGZBrNH6tBPum4aDT1TCz772FmU7J58Ss2FpQPYyh9N+YC4QX
 /UcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692133532; x=1692738332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktzTSbDpIzNoYWgyiGJTxE3eT4ODZ4r7QcReNJM/+8k=;
 b=QPA6OAftjiJ+BqCBPywb7RZeuxzv9r+zIBB12sXl/cCTVfy9zZrow6wAKN28b/MISn
 icTvIynefet4XR7Qyw9WiTIyASsLZZogyE9gB841DJ749EnNLQe7iZSY5Ldfzzh5S2oi
 SXrTt6bA45/EXIJJJALIWutvNblqqWZbNYdo5nko/6gaoBNyyQvDpbgDxFRATYsjwGw7
 2HF3PWj0yvIq6cPQ8hIXnKEFyIyYvXkqrvpTAJhWFWmvlCnFb/05zTBGF4J/3DgtNaca
 G+b3/NjlzdOq+vw9uc8Xfhv6Kh0m2NQiBBfnnm/CEO9fz8BlGbuVmEzbZ02kqn1TAegF
 apsA==
X-Gm-Message-State: AOJu0YxsV0o7O9a7OV4m6HPP2CFaXXP33dyZTmNiDXbVXdplZLEWnCow
 nVzNsyfAef13rtsb66Lziq92efMFjhOS3B/oZ8Qefg==
X-Google-Smtp-Source: AGHT+IEHiadg7YY4wIBHxFvaIzTy+F/lvT9z2QSgj+ez/s5WkywjtiqQHaQ94UiDLjzJFmwGfgXklWqvMgUMKeRmwpA=
X-Received: by 2002:a05:600c:2d93:b0:3fe:20f1:fb2 with SMTP id
 i19-20020a05600c2d9300b003fe20f10fb2mr2521897wmg.6.1692133532080; Tue, 15 Aug
 2023 14:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230813235231.591454-1-marek.vasut+renesas@mailbox.org>
 <20230813235231.591454-3-marek.vasut+renesas@mailbox.org>
 <CAH=2NtyeiRyN1pwJ8ukXXbMiD6Yv2bUgYdoVkd4D4mM2f3Dw_g@mail.gmail.com>
 <2f97ee68-65e4-fcf2-773e-411936c8227d@mailbox.org>
In-Reply-To: <2f97ee68-65e4-fcf2-773e-411936c8227d@mailbox.org>
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date: Wed, 16 Aug 2023 02:35:20 +0530
Message-ID: <CAH=2NtwTWud_8iNoMgWmOPYVoHTXEZAgcsr4Gmv9fq0SO2tfYg@mail.gmail.com>
Subject: Re: [PATCH 3/6] ufs: Handle UFS 3.0 controllers
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Faiz Abbas <faiz_abbas@ti.com>
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

On Wed, 16 Aug 2023 at 02:31, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 8/15/23 19:14, Bhupesh Sharma wrote:
> > On Mon, 14 Aug 2023 at 05:23, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> Extend the version check to handle UFS 3.0 controllers as well.
> >> Tested on R-Car S4 UFS 3.0 controller.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Faiz Abbas <faiz_abbas@ti.com>
> >> ---
> >>   drivers/ufs/ufs.c | 3 ++-
> >>   drivers/ufs/ufs.h | 1 +
> >>   2 files changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> >> index 261ae2843c2..58830c8ddca 100644
> >> --- a/drivers/ufs/ufs.c
> >> +++ b/drivers/ufs/ufs.c
> >> @@ -1903,7 +1903,8 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
> >>          if (hba->version != UFSHCI_VERSION_10 &&
> >>              hba->version != UFSHCI_VERSION_11 &&
> >>              hba->version != UFSHCI_VERSION_20 &&
> >> -           hba->version != UFSHCI_VERSION_21)
> >> +           hba->version != UFSHCI_VERSION_21 &&
> >> +           hba->version != UFSHCI_VERSION_30)
> >>                  dev_err(hba->dev, "invalid UFS version 0x%x\n",
> >>                          hba->version);
> >>
> >> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> >> index 33ca5f29812..ef7728fc39e 100644
> >> --- a/drivers/ufs/ufs.h
> >> +++ b/drivers/ufs/ufs.h
> >> @@ -781,6 +781,7 @@ enum {
> >>          UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
> >>          UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
> >>          UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
> >> +       UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
> >>   };
> >>
> >>   /* Interrupt disable masks */
> >> --
> >> 2.40.1
> >
> > SInce the Qualcomm UFS HC controllers are even newer / greater version
> > values, we can drop this patch in favour of my UFS patch here:
> > https://lists.denx.de/pipermail/u-boot/2023-August/527215.html
>
> Why not keep validating the version ?

How many versions would one want to validate when the newer versions
are 4.1 or greater?
