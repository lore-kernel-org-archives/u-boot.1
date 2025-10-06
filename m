Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D099DCCA470
	for <u-boot@archiver.kernel.org>; Mon,  6 Oct 2025 23:31:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D78583ABF;
	Tue,  7 Oct 2025 01:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ED6eO/lg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44AE983ACA; Tue,  7 Oct 2025 01:31:37 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3672983929
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 01:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-62fca01f0d9so11206473a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Oct 2025 16:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759793495; x=1760398295; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8uI4+Ou2oyIecL0EqCJ094uU6MjBqVGo3hsDn40mTnA=;
 b=ED6eO/lgM2DyCBynU0XL0ThoyQLffqLgrlwyzTV/5noC4H/P5/VIpsaRg37B+UIYRl
 mKFLlFlDLN/c5xlDoOFDij+I73ciBoUu0t4+3hOFy3PRu/aUtcbhUFXjwUnz/i8yizQe
 QmmgEfZx7AaENr95nK2r7T+RGDwpOZxEc1zQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759793495; x=1760398295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uI4+Ou2oyIecL0EqCJ094uU6MjBqVGo3hsDn40mTnA=;
 b=R08FX2++9D95woomORet4tFn0rcPlxlAXIJarCcK0wk1xL7q0fwEQnmJlsVMRDVxB0
 3XRdZ7cxCcIxJ8c69V1iDBDKdso3Cz9+nSQybR9VpqrVEPj8WO96vMcugV+3nufT7RKA
 I7ve9p8ZCS5a+qTOIAOeORVBAFvqUxdK1dNs17/5BjzSsUiCZbRFLnUJRqe2SRB370MF
 GnRiC9uVcXPvrycASw5kMUxxTR3VXZ5DgIj/u+ccKRG8HAIgovoSve8Qb/ADmbegjqn4
 rlJvsoW+7IqVv4j7b/tD0i7DeoLltD047YLYTkbFDRIBai37GOqKD029qjj6q64t2iz7
 4Wyw==
X-Gm-Message-State: AOJu0YyRrHVcmt/t8L683YlH41Dr3z8HRh8YG1cLTKJHh7fbnjsO3xAB
 g09s4ZKnaIB76X7zkQxI90wc4Ww5Ewh9JjMbkCCpIV3b/wWws71hUbMDvLRnJ/bS23j7Cwde6OB
 l2RRTfmXSEJin6U8zHgDGwGUH6TX0PUhY6qneYemtZzqoJ+jcIsR/fg==
X-Gm-Gg: ASbGncu6rA/4dCDphqB9HLKoG5VhmCWgy7SBzclHxDR4e5R9yidJmXkEo7BTm7g2dvj
 fO7OROp7rvplHutnztIZ2tYA1ctmXhqPo8DIvckj7IqqZeoXHiC3WQdc3B3t0Cg3tgdDYJWPHSQ
 1tmXi5DC5krnbZTS5Hvy5ZIK5dapJK5FpOkHZCZ/1ulJxDFRoSbEvojTCClBVuFxN7MF9Pmew/e
 c8+JbGaSGRRwdPJuHY82RqqXHL7IFr1
X-Google-Smtp-Source: AGHT+IGS9mX0BFlcrDpH9LnxYQmPyBKQnA3gGf5Qsmw2MQjniA9HxTTJ5bpAhTQVTmbIaICgCx3l60CC1cGFNiGQA14=
X-Received: by 2002:a05:6402:909:b0:62f:6759:3b09 with SMTP id
 4fb4d7f45d1cf-63939c27be3mr13660672a12.30.1759793494651; Mon, 06 Oct 2025
 16:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <20251001212649.3263574-1-sjg@chromium.org>
 <20251001212649.3263574-17-sjg@chromium.org>
 <20251002201546.GP6093@bill-the-cat>
In-Reply-To: <20251002201546.GP6093@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Oct 2025 17:31:23 -0600
X-Gm-Features: AS18NWAWe7FpMI30Z2kAIqVL-ttLQLUZ7S--ZIT-XpbjgqEeY6tW6_qf2jySAts
Message-ID: <CAFLszTiofxAigyXRGp3qREOd6tdjBDyZqkj9vsOu9U-TxCe3Rg@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] boot: Run the EFI bootmgr just before network
 devices
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
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

On Thu, 2 Oct 2025 at 14:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 01, 2025 at 03:26:41PM -0600, Simon Glass wrote:
>
> > At present the EFI bootmgr scans all devices in the system before
> > deciding which one to boot. Ideally it would use the bootstd iterator
> > for this, but in the meantime, give it a lower priority, so it runs
> > just before the network devices.
> >
> > Note that if there are no hunted network devices hunted, then it will
> > run at the end, after all bootdevs are exhausted. In other words, it
> > will always run.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> This does not apply cleanly to master nor next as the test portion
> fails to apply.

OK. I'm not sure what happened there but it could perhaps have been a
timing problem. I'll try again when I send the next version.

Regards,
SImon
