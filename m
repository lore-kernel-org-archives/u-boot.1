Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B820C5321E
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 13:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7F2A8895B;
	Sun, 25 Aug 2024 15:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X2gEiQJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87C2888975; Sun, 25 Aug 2024 15:07:38 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDEB288279
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 15:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6bf6755323cso20508466d6.1
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724591253; x=1725196053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vPn1trtAoRIN3Wmf7I/6yZoJjN/ziQx9yhjUvKPRkkI=;
 b=X2gEiQJyZhI4CWJspS/heRi6rBEZkinS3iRk+emhp73zibiobuSKn891aNCQmZAwBZ
 TB+pPOZPFigLbKB56rwoBMBqiKnL5IPYj8i5tG8JJR0Bw1QtuzCyu1d8mndDewZ4nmH+
 7fegMVkVfU8hEVeFL4r47QLSWoNwnU8XMupUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724591253; x=1725196053;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPn1trtAoRIN3Wmf7I/6yZoJjN/ziQx9yhjUvKPRkkI=;
 b=Md6jEe/HUPsg8IBOstiI+E47VHECMddc4BV3zDokEUaDOKcjkRG5PSNTwpGVeD8bIA
 Cq02YxSQFmRgiIB+uiJYBNIRrKjq2muKN8BmbTyW4a6Qp+wvKNLalXm1FhB1v+1Zsh4M
 hCt8mMVo1GcxEjRLNfdhdxebD4wi4e62X70ucU1H63uCtDdoY/2NKacrPlvcrFbjeRCA
 TldlR+J9bX8JFUEhlUgFHikk03Izw3/cCB7GCodc5tprkpPXJnPyNzTaJpaiUs0jzxNO
 cTpNTUrFIDhc8JLkpfXwq99AK5bn9MW/+h66FsW4ccWz/qprOg2VODzuP3GZzt60fYbV
 OFBQ==
X-Gm-Message-State: AOJu0YwRyq0nT421sU0MJC3co6c9dTbJgI4SdT+GnuiS2IW9XIDIJJDv
 7C0TLbnp7hp7pWmETZ65QcT9fZNmmCEFOvA/Mo21NnkBjwcavKSX9Dpkie7CiJ5VtbjDPBVF36Z
 elfMF2rlCgwXfhZ5NQABQ2rpTtYtZoNjGlJMZWRVmn9QVsvE=
X-Google-Smtp-Source: AGHT+IGAdqDBbcmzQvv3eOkhg3NxWQ8E8Exb6+y0EzUp+BY89wwzWOMMPKHLnc6yJnTVED9iW0V2d23FzgOYHIjvL3Y=
X-Received: by 2002:a0c:f209:0:b0:6c1:6baa:d97f with SMTP id
 6a1803df08f44-6c16dc7f2d0mr105910946d6.25.1724591253692; Sun, 25 Aug 2024
 06:07:33 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 25 Aug 2024 07:07:23 -0600
Message-ID: <CAFLszThRq1MmeAukYW+uwe5nBiku94qXALLMZ4S9ySFfbW0AkA@mail.gmail.com>
Subject: xPL terminology
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

We have the term 'SPL', which has a dual meaning. It is both a
particular phase of U-Boot (the one that loads U-Boot proper) and a
generic name for any pre-proper phase.

You can see that in a few areas, but for example CONFIG_SPL_BUILD is
enabled for TPL and VPL builds, not just SPL.

I propose to rename the generic term from SPL to xPL (meaning any PL
phase), leaving SPL to just refer to the phase before U-Boot proper.

The symbol would be CONFIG_XPL but in documentation we would talk of
xPL, with a lower-case X, so it is more obvious that it refers to any
phase.

What do you think?

Regards,
Simon
