Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84437CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A5DE86F15;
	Wed, 18 Oct 2023 05:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m4sM/p06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E12686B05; Wed, 18 Oct 2023 05:31:20 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896B886F1A
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so496461766b.2
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599876; x=1698204676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mNpnR+QXqHwxOTyJGRz6iyJpDAOJo00m57qmfEy2kE8=;
 b=m4sM/p06FxEmfj/nfrpc3QBrFe2IvwEWJPzLSNvOeLFpxBEC5tBDqpJByVEFOYjTn0
 9X88kekzdzJ+bSZr1d25ofPsip5ru3qNRdEfWUU+KoKqh3jE+/TvXFJO9Va5VpDUyr3K
 VnG9uNNoIw8HQdO0mGwlPSZJSxeFoXfccpZZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599876; x=1698204676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mNpnR+QXqHwxOTyJGRz6iyJpDAOJo00m57qmfEy2kE8=;
 b=K8e2hSfBacNpzs33hPDat5A7TjKY7dGQGlKuHNywSZXIKK0dL0Y9J2D6PACabzfe8K
 x4SPDNLn4Vo/CRrCv8dsc8ZcspC5FNRFQFA+yctGXoMgzDRSqyNNRstH3rx0A6YdSCsu
 Z5Ue4UwCc4U1xgleq8jFyOOd3sXdruhWvoTMGkcXTdKgRpg1KwnWsTmZdkohRW8GYj4J
 jpA2VMCavX5+7RC8NPRvKtrXAWVvOne7Z+WL1dCgWSvxL2ulwscmI2Gt/HATr9d/gFwe
 iPa/aMw+8BGtJNoCBraWa71R8oCWfYh3vZXBzwWkf2mTLTTpu2ZTnQbFEMAFPZwv5ZTj
 24aQ==
X-Gm-Message-State: AOJu0YxgdL8IWOKz7/qtMPRZm5/5Uj3F0WehdhoJjjRZMnIwdm2BZgsU
 O9q2PvHsPa6sbBJ59nSeHkvY7m1bLYMdhTmsBzyeH+p363HhA2fxVIs=
X-Google-Smtp-Source: AGHT+IEZoc4azej6ufqDMl62hWQAMMuTKpZCZy5p2+PJbTPzPrZ47QYQYR3+OGn1FTmOr29EIxO/snYx1xTDuqiiRYQ=
X-Received: by 2002:a17:907:3f90:b0:9b6:5b56:bbe3 with SMTP id
 hr16-20020a1709073f9000b009b65b56bbe3mr3633758ejc.72.1697599875929; Tue, 17
 Oct 2023 20:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-15-sjg@chromium.org>
 <20231017140216.GW3119521@bill-the-cat>
In-Reply-To: <20231017140216.GW3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:04 -0600
Message-ID: <CAPnjgZ0WmpCGbV8a8Ri7+myZTMSw-3R5QjP_kY9qvU3-2JOuKg@mail.gmail.com>
Subject: Re: [PATCH v3 14/32] bootm: Allow building when cleanup functions are
 missing
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

On Tue, 17 Oct 2023 at 08:02, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:05PM -0600, Simon Glass wrote:
>
> > There are two cleanup functions needed during boot which depend on
> > CMD_BOOTM: bootm_disable_interrupts() and board_quiesce_devices()
> >
> > Provide static inline versions of these for when commands are not
> > enabled.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> NAK, these functions need to be available to boot the OS, regardless of
> command line existing or not.  Unwind things in the other direction
> please.

That won't be a successful strategy. See my other reply on this. I
have had this idea since 2016 and have looked at it every now and
then. With bootstd it makes more sense since we actually have a
framework to boot without the command line. This series enables such
work, but cannot include it.

Regards,
Simon
