Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58361CCF9F8
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 00:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C554B8144A;
	Tue,  4 Nov 2025 01:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JYN7tu5S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401F98004F; Tue,  4 Nov 2025 01:16:20 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B088004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 01:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7c2766675adso2764482a34.1
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762215377; x=1762820177; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mvC3IFkRMiw06mNVvZxA/hygijz9ajUgo70upWhVVM4=;
 b=JYN7tu5SIfUswUk5RxiEzbgA3mbiAeXQQrrbNTIjTo5pfmXovoGDvYUvF7RGIeRB+r
 8nH3U9rfyzmwYPX0XdfpJh4apxvE8EQjLnrkwxVo0dXKZ1Z6vroVd4gygBfqMv61SgDe
 JyErmgCU3DGzT/yfkRpwDFHA0RBJpfHMqmX4TuN2oNY1vGHuPb628uWHpKYSBCWAKs3m
 L15VnBuy0FBpJnRS3TEmGqkbBIZ8s5ULxTLPx/KC04pn7p8cO036HHgRibd5p7i1moUs
 0zqOJvuFtsjTZZ+L0cIORPVhLrdJH6f0DlpN3/B1PNbZ+QJG7J3hDLC5eUvdNe3IRBYL
 aHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762215377; x=1762820177;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvC3IFkRMiw06mNVvZxA/hygijz9ajUgo70upWhVVM4=;
 b=mTAcH37sA5RIgjUNbdC2NzMcMjzvn2O7r0yqBsQMlLEswrYJMhbQk/Gk7RaBNiJcXp
 nYlZouOQ/QEAmw3rk3A5wq387RCcGvjZ3v5MT6N1KN2OIvyrcKTzsAnc2GO+e+aUVpv5
 U5OYz6DTXjEKF94a1F+iitBgs+G3k0WvpXqnw9QvmhGUjeylqTedFn/AalOS6iHmjHPd
 HXWJkmvey7XPZV3Tcg0gwtWQcaUlNhLZB60+FeN+Vx0biJR3lJUvoKJQpKBC3mV3dotx
 VbB3FGVzZuPiDAzxgTfq03SAgFgPDbo6LVPQ3d/AEcCgUYaxbIyOkUjbckd6BBlrNcQg
 aTDw==
X-Gm-Message-State: AOJu0Yxu1z+GKfqnxDrIWK3LZn2XFm+aFa64KytwbIMLNCCKWdtiiq/D
 JGu/rBSAl8SfcIuWA6vitxBzqEiUeeq1Hc3Z7gw5l+/vvO/sfEKldQ8scwnNcW1JBzn9/19iHJ8
 kB+ldsyFukKM1paFRqPYcXQJWNG//yeYnGrGG
X-Gm-Gg: ASbGnctCBchPmGi+3EL64+ZRfblQe0W9taMKI13OWPQkCGYQwV5IDtQgZzHWv8qjGJE
 33MiFfmOMX8uvGnpAErfsudteQ1AxwxNgdxiNLTZOTc2eykcjt+5ZZLjdN+l2NPVArpF2f665WD
 LbghmM8rKO7P7/NwKPGGvefabxoiiWMEGIjU4TYcWRi44sGA+QwDm3sM/z+8Jc10YRvKx+6Aic2
 YT+iud1t9HzrbjGT+/xILYicJeYjhX8ekNUZ75LxyMFPqOzHSsP16VcgmBWzA==
X-Google-Smtp-Source: AGHT+IHxr5r1FGMoB/waqv5Pa3UVLGo7FfX6MGAh0UIxe3UXcVA6mJpj4ytTbTOfHRCP7fRjFhYUs9SKG38sX3Ha3W4=
X-Received: by 2002:a05:6830:380c:b0:7ad:d568:6e60 with SMTP id
 46e09a7af769-7c6967023eamr8364470a34.9.1762215376823; Mon, 03 Nov 2025
 16:16:16 -0800 (PST)
MIME-Version: 1.0
References: <20251103222840.458-1-briansune@gmail.com>
 <20251103223346.GU6688@bill-the-cat>
 <CAN7C2SB7qeXQB5=VHZ_DaE-ov4S7OX2hSyYNhb4SWv8-k+J_9A@mail.gmail.com>
 <20251103230540.GV6688@bill-the-cat>
 <CAN7C2SCCMKfjnfB2FnH1svrSJ1dN_chtUVmsTcaP6-8_zSiEzQ@mail.gmail.com>
 <20251103232345.GW6688@bill-the-cat>
In-Reply-To: <20251103232345.GW6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 4 Nov 2025 08:16:04 +0800
X-Gm-Features: AWmQ_blZAxbd5oenM1C6NYlr7wNfd3g8cv1O-irDl_SsA3TvEYrAERku5IUplLs
Message-ID: <CAN7C2SAW5osYBb==ZNm7qE-7zryRTrUtOQhdbqpNdfXHg6h3mA@mail.gmail.com>
Subject: Re: [PATCH v3] Add make feature support for SoCFPGA Handoff
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> > > build of all 1400 configurations. For a maybe useful example, see how
> > > the "checkgcc6" target is handled, and maybe we can move all of this to
> > > live under arch/arm/mach-socfpga/config.mk and so only get invoked at
> > > all there.

Yes this could be an issue, I had cross-check via several AIs feedbacks.
Even if the logic and syntax runs it doesn't mean it is optimized.

But same way in other locations as well.
Will check a bit on this.

Brian
