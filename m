Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68411E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0A589568;
	Thu,  5 Dec 2024 20:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="naxWUmi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B2C18952C; Thu,  5 Dec 2024 20:56:07 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEA189532
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa5325af6a0so206956466b.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428565; x=1734033365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zm5ZU/JWIGiKpYga1Ex+KuL8dP3HqO9LcWOba4UumEM=;
 b=naxWUmi6VUPGZtqGRHxWXurSIn++w8ih9dE+FKaHicwAzIGqJWSLM+O8FaJBqWw13e
 0SuvIQP7BgKOhqWuVSAl6YXa8sZq4bucYXFgaFhOk3T87xPOMz3+wwBrAAe3trjgETUI
 AG2kR1H/Jl1Q7RPetsiygI+UyfOaO8EGwbY14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428565; x=1734033365;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zm5ZU/JWIGiKpYga1Ex+KuL8dP3HqO9LcWOba4UumEM=;
 b=s7SeIfS9i+3goIW8ju+kmdwbgNETxFLYP5k5a086rjBNI3bLtcm6jzrMd8UqD7x/06
 4dakxD73QTssf8RUIqkD1/dreM0CiwVRFUOULzM9+2KaPs2LCgEzX/WDpNhMTwheCLSz
 4dqWRGtUx8KPyIOVlfvAuFRx4vEY8DI7PZO6A5ND38oXTnbq69zWh7J6oE+2/gJAxMc6
 jUtbtq8RgVrQEAddE6h3+1t/mphRysRN2wnBDYW3Y6mmt5Rqvkmq+FkABLzag9fhyo7c
 vgEIc342g6IB5eJyfs26rB9QuobZp4CE09g17cOl0BeCVw83BWe6MYFj2JSWXPQP9gpY
 oq/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpRAocoqoS2OybGX1YTLhn1nC/g29OvzP5Bp985Xg13g/fgfIGb5bTRRlxu5jeaglbkndcmlk=@lists.denx.de
X-Gm-Message-State: AOJu0YzoSMS+hbEZ2EaufXQOR2WDN0WYaq+ko2oNLamyqVIRQ6JfPkZe
 emg9I67j8JFlAXBiX9U8ADFvD5MRRYfJeFVI2Ac0Qdxg7a7ICjwgOQImk9LWDbPfuXKIK9I4O+z
 4P8dULyCm9Yu2A/TjwlOcmc5y47wMe5xUVOl0
X-Gm-Gg: ASbGncsN/oLsBHi/NQG+GHKofdvnQo9XiwaJN8Pnf+TBy6ngYeL84Urb0kCevwdQCUy
 ELklYzpk28v6SvwbFxOm1LpkhkTSKEFVr
X-Google-Smtp-Source: AGHT+IFWJjtO6UjF5Ee2AevjowIn84V2dF+FYt2B0nAV9vGfQZ6SIhmLjZSU6gbIuOeuIMl+iVMh7nJiuh8eS8vIqls=
X-Received: by 2002:a17:906:3288:b0:aa5:402c:6aac with SMTP id
 a640c23a62f3a-aa639fee49amr13453566b.15.1733428565041; Thu, 05 Dec 2024
 11:56:05 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:56:02 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-7-sjg@chromium.org>
References: <20241115231926.211999-7-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 11:56:02 -0800
X-Google-Sender-Auth: -ExWkk6LMUWG80fRoGtSdmVEXdA
Message-ID: <CAFLszTiLs-SSt4wr_jHP8toZYeSSTaEx3m9fQufJ+yqjn=KUuA@mail.gmail.com>
Subject: Re: [PATCH v4 06/19] bootstd: Maintain a list of images
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, 
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

We want to keep track of images which are loaded, or those which could
perhaps be loaded. This will make it easier to manage memory allocation,
as well as permit removal of the EFI set_efi_bootdev() feature.

Add a list of these, attached to the bootflow. For now the list is
empty.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add an image type extension in bootflow.h
- Use the word 'feature' instead of 'hack'

 boot/bootflow.c    | 26 +++++++++++++++++++++++++
 include/bootflow.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

Applied to ci/master, thanks!
