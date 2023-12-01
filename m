Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEACC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 18:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67840876C4;
	Fri,  1 Dec 2023 19:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XVFk9aDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3754876AB; Fri,  1 Dec 2023 19:32:27 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E42586F95
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 19:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a18b0f69b33so387583566b.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701455545; x=1702060345; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8sL3PdrFpop7Whk5Dj+KBDXMOE09bjypl3XQ3JSPlko=;
 b=XVFk9aDXOkkDDhW7HZyvVP8n7Cpw/hu/WmlhlOQYpJ22l0i6FNOaVflVmBlMZY1Whj
 yeiPqEv/HgIu+oNHr5zNVH7ZVk2lK9NlCB/nd+2zvDnGtQJt8r2Xb20D6uUew2pYeh9u
 Oq87aHWQc3FgL3/Xe0bddYriGWZh4kbU97SY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701455545; x=1702060345;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8sL3PdrFpop7Whk5Dj+KBDXMOE09bjypl3XQ3JSPlko=;
 b=GMW+9HuxI1vzueAd2qT6lGniRwPxZhUczqYvM2lq2I0Sk8ZeXemUQAnxO7QpxRap5U
 /M+Tnh9a39169d8FV/CbdtwaCm9VZlNjzubxrI3G5s0Jn7GbQ6biiOKpjQ/iVSB+NUY5
 Rn6/Zw3/0YJh5WrrccA4yQS1xWhyME/H/tGRBk4D49sM5y5AQyR0o5CYeQ6w1NQPWUbk
 IIL15lUPQqK5ruOori83Edr4mhEJ3W9jDTCtunItrNj7BRDq5+B5pWFF4Qhgk0Me9psA
 e+Ro/3uTQc3psoGtbxrM+V7m5MJdYquORvX/UuAZIOzn21OfzxkqSgAW+QOkt9mwsiFC
 Gj6g==
X-Gm-Message-State: AOJu0Yz3xmOwj9x5xnXIJhP3lxCyG94Ds7qezeJ7H3v5UQcIeHYQWBFB
 5Upj7Ee8nVXn2m3ze6oF0vpdeD23Ge/3Fj59mRfHuw==
X-Google-Smtp-Source: AGHT+IGONBxYUtuKASIg/nSgLm5Tu99LQe30sLkSmZbmShOeffqVHHJqGqPtSsFxv+gl0iLVIt6IhO6cUCFbN8gdrhs=
X-Received: by 2002:a17:906:5357:b0:9a9:f0e6:904e with SMTP id
 j23-20020a170906535700b009a9f0e6904emr1732538ejo.16.1701455545318; Fri, 01
 Dec 2023 10:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20230912094731.51413-1-seanedmond@linux.microsoft.com>
 <20230912094731.51413-3-seanedmond@linux.microsoft.com>
 <ZWnzPUVAPjk4heAM@hades>
In-Reply-To: <ZWnzPUVAPjk4heAM@hades>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 1 Dec 2023 11:32:13 -0700
Message-ID: <CAPnjgZ3B3YBquTvRgsNVP8fSQFe1XypJQ9EaSaQc3dXF8dBUBA@mail.gmail.com>
Subject: Re: [PATCH 2/8] drivers: rollback: Add TPM2 implementation of
 rollback devices
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: seanedmond@linux.microsoft.com, u-boot@lists.denx.de, 
 stcarlso@linux.microsoft.com
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

On Fri, 1 Dec 2023 at 07:52, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sean,
>
> On Tue, Sep 12, 2023 at 02:47:25AM -0700, seanedmond@linux.microsoft.com wrote:
> > From: Stephen Carlson <stcarlso@linux.microsoft.com>
> >
> > This implementation of the rollback uclass driver allows existing TPM2
> > devices declared in the device tree to be referenced for storing the OS
> > anti-rollback counter, using the TPM2 non-volatile storage API.  The
> > rollback device must be a child of the TPM device.  For example:
> >
> >       tpm2 {
> >               compatible = "sandbox,tpm2";
> >
> >               rollback@1 {
> >                       compatible = "tpm,rollback";
> >                       rollback-nv-index = <0x1001007>;
> >               };
> >       };
> >
> This node is part of the DT specification right? If we accept this, we
> should figure out if we can add that to the specification.

For now I suggest adding a binding file to U-Boot and sending it upstream.

We still seem to be having extreme difficulty actually getting things
accepted upstream.

The logic of this driver needs a few changes, I believe:
- probe() should do nothing, to avoid probe failing due to bad counter, etc.
- we should have a startup() method to actually init the counter
- if that fails, we should have a setup() method to set up a new counter

That way the caller is in charge of things.

Of course you can put helper functions in the uclass.

Regards,
Simon
