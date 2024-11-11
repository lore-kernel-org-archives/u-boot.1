Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28405D12D6D
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 03:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2A88921A;
	Mon, 11 Nov 2024 04:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J20FBIL6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2308989275; Mon, 11 Nov 2024 04:57:31 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AA5E88EBB
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 04:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9a628b68a7so749285666b.2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 19:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731297448; x=1731902248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gAg0MgKppezXmcDYM+E0FcYmuZ/4TpZ8vxycCoss/Ck=;
 b=J20FBIL64pTkV2uOEkCigNyxULr0Iv+qBSALVhp+UD1RCbIgroqXtA5WJZ3rApR9S6
 Y661Ls4KelHP1fJhlffQFeNJX1KjkyF0pfy97rttPh46B+zSO8/L3z6szygUgDTxDcSQ
 dpqZTzUWLAwAX+ZX+H0s7hcZ/1tPu11arKcT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731297448; x=1731902248;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gAg0MgKppezXmcDYM+E0FcYmuZ/4TpZ8vxycCoss/Ck=;
 b=CfU2uO4Op8oEo7fxuBS0ts7p2w4FM5+WVgRWh9IB5MbWClepPsSDJp48y9sCla2mM/
 T4BkAbYe6fFEhACA6YrRcEqUj55EfamVa3ir+FBv+JPkF9kLa6Q46eJ1A7CoohsOOpor
 S/ycfz5RIYH6Mx9oNKFkrCzLGv2e5Yqij+tpvgPa0W0zP8PCh7SOSTw1dnWBwWyuUyyK
 MKznybKuiTVdKWtXrh4+SEXRSAIJNhKwOmVMWVlt57ELZeQIjGIjePB+zxSc3wQWKLZY
 5MS7c13FvJ9qFdvKTeBR0JzEzQqO2d/eILYVcVEk61+v2E/JXiTjNeugJw8AnBmuhvkU
 Q2Og==
X-Gm-Message-State: AOJu0Yysw65vSGEUVCiPgLtWVUvCNwVNnDRDq5MWXp/QE/hw2g726YvW
 od9R1DZg+dayzgoVyTmaJJYvXUuUq6iga/Y/ci6sNJuAEvDDWDthpl/pV5MkH3xLvOSkrvjYM2R
 kfxOQN0YIh3cGnfKnmovZu9sojaHl7Ja5cB63Ncv5OTvgduGfRQ==
X-Google-Smtp-Source: AGHT+IFE4hlyrLGjcvtsLZ0zd/P2013Cn4sTYH40KmYh+gVHn11rjH/T8BVeN0uaFdYx4PJKMkADkuAawaNvO1LlJaQ=
X-Received: by 2002:a17:907:9486:b0:a99:4f40:3e82 with SMTP id
 a640c23a62f3a-a9eefeb2bacmr948346766b.7.1731297446970; Sun, 10 Nov 2024
 19:57:26 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Sun, 10 Nov 2024 20:57:15 -0700
Message-ID: <CAFLszTgMuiYC=LuGiadadGMCR9AKOE58q8Cfhz2qQC7+ZMDw+A@mail.gmail.com>
Subject: EFI with bochs?
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Heinrich,

I'd like to enable qemu-x86 with Bochs & EFI_LOADER, but it doesn't
seem to boot Ubuntu - the spinning logo never appears. I don't get the
Ubuntu display. I had to revert a68c9ac5d8af to get any sign of life,
but even then, with bochs, no dice.

My tree is at dm/qemu-working but I haven't quite finished tidying it.
There is a script there which builds and runs qemu & Ubuntu.

The reason for Bochs is that with kvm, the option ROMs needed by x86
become quite a pain. It seems that QEMU doesn't emulate things
correctly.

I dug around in the EFI GOP driver, but it seems to be setting thing
up correctly. I had hoped to find a missing field...

Regards,
Simon
