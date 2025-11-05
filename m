Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FD0CCF9F8
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 23:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D81AF83B0D;
	Thu,  6 Nov 2025 00:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gtTFFw79";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 573E583B1B; Thu,  6 Nov 2025 00:13:26 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3817783AC5
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 00:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c6d13986f8so337468a34.0
 for <u-boot@lists.denx.de>; Wed, 05 Nov 2025 15:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762384403; x=1762989203; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CQu8fGJ6J1zR/txKyy2U9l61oSFPhQ232xMu2/asZ+s=;
 b=gtTFFw79PncOqhzcGUi8t0zH6lU2cQJ/cK82ji/VyJZ/BnNXNtYOC5QNtBqXGM8Sj1
 73DyasDZSvVVJU7ItyDFSU5svNsDiyZsptNNo0eTio2g0u1GdNHtRic7gA9SgxWvD3df
 M8DYS2MBX7DUEZ8HKT2c6C/H4fXMvuCrKFkgHT9+8NjU9trpZ8YNldz175S4ULoDRcnU
 YMN55ERXWSD2ZMYydIQNhkdfC2JM8VrdR3Kh8xeOIPqYzHSqOPNbgiHo+zjZNOUYYXMq
 T3gsdLfVAjatWazAmoxbyDExuMWkHqYdnSWfIadDfD5UQP4BeE9ntQiibk4UkjQxx/qv
 WSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762384403; x=1762989203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQu8fGJ6J1zR/txKyy2U9l61oSFPhQ232xMu2/asZ+s=;
 b=Xr2ymzB0Q874q4ZjAKi18Gm2BHC7kYAp89MBYTuuYC69/F2Z1pDPDvFRyW3WZsjsvf
 9++lEC3V7LJaHFQfs2iMwxa+4ir2ArHGIfmD+kfTUf+lx7CUHOrIqrKPd4o7N744nVwD
 d6p1ynD4bSfKzEFOgG9sIap4HDFjYOBsh82T18x1TPj8WdnKUJvJai58Wwg9398+ClcM
 PsxTfRqUHyhD2SQOtgwskMCSxFrNkFPQ8MuTDxIb/6E/ea6+4G5JfPx2JzLtNzXytBgp
 fm6CINFY8yvcVivwSIwIM0mMc1w+AKFDjC75lxPaIe1ywvinv4w7P64ofJFPX99QGDwg
 o7ig==
X-Gm-Message-State: AOJu0YwwM8rDPDxj2ldDipU/pHKO/cIpKqernnsI7wBVR3abS/jnBlmL
 V+iWxtuib04BZVPQzGCoGM5dKwj8/usNcIHQ6M2K2ZMYSSarWdqQn0+2qyGtcfJp9Hlny5Xdf6Y
 Mcmqmy7zROaYkfPsSMEgpHk396eA1Im68Rw==
X-Gm-Gg: ASbGnctN86+dx9heK6uVZS0my0EjUOc5WAhShxr2De3Y/JBRlMQ6C08X+pF5NC9TyNf
 bHWxvNXZZKx9XOZ9uQj6VdMrRiq2tnqgm/KUINDQAtzOI2nK2JA4woBtWEUrPFRRpZEyptLPgxa
 +Vd2jGvjtvwuLC9JxpfHeRVVY+v6zC7RAuflJXAaK2bSTNXMJegcEmi9qSRIpaoh6zqJzJHPoz0
 hIENPdLXfcShAzGwIk51H1zQZ/d+JG8N098458DGthpg4ALnacUUfQ+eENg4Z8yCh4e+SY=
X-Google-Smtp-Source: AGHT+IFXZi4Crz8SfmoyVSKBQ8XWNLkA9Xkpry7l85PR4sYjO2gmLN04T9Y2VbbvnFxnuAJfmlrhMNh8ca8GBRU6TE8=
X-Received: by 2002:a05:6830:8d0:b0:7c6:cd8b:2e5c with SMTP id
 46e09a7af769-7c6e147db75mr766416a34.18.1762384402809; Wed, 05 Nov 2025
 15:13:22 -0800 (PST)
MIME-Version: 1.0
References: <20251105120613.530-1-briansune@gmail.com>
 <20251105152144.GP6688@bill-the-cat>
In-Reply-To: <20251105152144.GP6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 6 Nov 2025 07:13:11 +0800
X-Gm-Features: AWmQ_bmcou8HoayMvg3zJAc-qtHTnY6A-wh3Ggf14wVj-BvMyo3gM5QgQnn_-bM
Message-ID: <CAN7C2SB+j1MxnLRM5JSJWwkDepe2hpA=XBeNSK5dGFWcLRTy-A@mail.gmail.com>
Subject: Re: [PATCH v1] sync doc/README.socfpga with new info
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

> Right, so the first thing to do is migrate doc/README.socfpga to rST
> probably as doc/board/socfpga/index.rst (and include that in
> doc/board/index.rst). Then work in some improvements, thanks.

I can only work to this stage. Other migration should done by
Intel stuffs. As I modified to location and the execution of the
handoff tool I have obligation to tell user how and where.
But other than that the rst should pickup back by Intel-Altera.

Brian
