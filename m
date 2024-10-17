Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C22D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:18:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F75D89189;
	Fri, 18 Oct 2024 01:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DF6GYCIu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB69289121; Fri, 18 Oct 2024 01:12:21 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D54D28917A
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbd550b648so11408456d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206738; x=1729811538; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t9WJQpv02wL/IWMc+JXC0dV/O7TVs9Xk0ipxAD4b9bY=;
 b=DF6GYCIuEkbKNKM4Or3KGkmKDG4tWBCRxVfXj80/U6p0jNbvDb2vZDWhG8uC8S6epa
 Mku8SsbLm28PFqjY3lU6c2W8B/NgkxBct4U4Aj608YNk5eU4e3WnlIhNL0VZg6btpjfF
 0krLT/vRZl/hUBVSAaOhbb3yVQq4jof9SDFLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206738; x=1729811538;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t9WJQpv02wL/IWMc+JXC0dV/O7TVs9Xk0ipxAD4b9bY=;
 b=CtFPAt/HgX8+dvGorG2oz6/ovfrW+vHn01RAOvxXi1oNXWM7qTF7SDo3PhgXyLRTyM
 ELqbghFV8ajcMnom0cTfSu9rxW3Qp0Dqvpkg7ZFYJJsRuCAzA9AssSkYKZmFL5TpVPQM
 mAAJKp84S+xvTH4ZItUxi08kBM7+UY65G6oOAZaWAVyzG+zVlDomho0nb24XBAOQBXwg
 3OM9ltqdjTeNUETXRT9d5hv9O7YyqFRR3+HToldDvJsTm5I/BwJ2+cf0S1PgLId4OgMG
 puvcLWG87QJzs0WLrt2R7mBB7I7vPKOmx4g6+Q0Jtn0B3PP6OqCnWGe7CxUrrMPw6nod
 Mcmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1hCh0p5faRMlg1F7UQuwsw+HEYM3BtNCnBQoJOoFliKinPgRGnEM2gHtJ4RDC1lERvxd1y8A=@lists.denx.de
X-Gm-Message-State: AOJu0YzoWnIk8Mxc76EpQP2NlnyrSXBwkBO8dhZ11a0oK0EE96i7s+to
 pi2TGbkzvjAo3ND2SDZ8js9cPwX2voNLfD0l1WsnwPW1SoD1u8g4uYdz9q229nLB8XyKNEDpxn3
 A3kl6INZXWQY4VT1+ZOF5ndRUkuupJDiD938J
X-Google-Smtp-Source: AGHT+IEMfyXpWPEqab++wyka85A6J64ZokbH/+UbCShhd80DJfJ3f62ywHZtl5Wd3UZxcQ8NUv9Q+jo8YmKaq53rtjo=
X-Received: by 2002:a05:6214:319c:b0:6cc:3da0:d07d with SMTP id
 6a1803df08f44-6cde14c0662mr7973976d6.4.1729206737795; Thu, 17 Oct 2024
 16:12:17 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:17 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828014429.3320011-2-sjg@chromium.org>
References: <20240828014429.3320011-2-sjg@chromium.org>
 <20240828014429.3320011-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:17 -0700
X-Google-Sender-Auth: Sq2oedAy99jBnyrgyfo8voxtmaY
Message-ID: <CAFLszTipWSc12xJ2A8VBirj5_tWH4dW_WT=PsGo1JajmRfoM_A@mail.gmail.com>
Subject: Re: [PATCH 1/6] x86: Show the CPU vendor in bdinfo
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Troy Kisky <troykiskyboundary@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Refactor the cpu code and use it to show the CPU vendor, e.g.
AuthenticAMD or GenuineIntel

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/i386/cpu.c           | 94 ++++++++++++++++++-------------
 arch/x86/include/asm/u-boot-x86.h |  8 +++
 arch/x86/lib/bdinfo.c             |  7 ++-
 3 files changed, 69 insertions(+), 40 deletions(-)

Applied to u-boot-dm, thanks!
