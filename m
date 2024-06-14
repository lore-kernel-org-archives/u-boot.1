Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA47C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 11:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8602F88984;
	Fri, 14 Jun 2024 13:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oUu5LVDZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C16628867C; Fri, 14 Jun 2024 13:21:35 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83E8688984
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 13:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c2d25b5432so1637059a91.2
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364092; x=1718968892; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8b57N2WBHjS8UvdWioDaWnF2ckBCIwj9jZDjOdO12Q=;
 b=oUu5LVDZkLDYECFMcXX1cPBqs9MaKETYjDLOb+rD94vKYOJbQo7Oeo5W2Rj99jlHEF
 n7qunz+QzauluQQVMnlP7NOTTNyBH3B4BW+2uci2fwo9GVX4zWDsvitx1ZA8FFjB2daT
 qkbgh8VXXDhZH+KP1hoJEJxJSw6qHyCl+AA2Amu49rsXcCj832rqMFgZYrCoBSuYnKLM
 sWJPUtLpjtThwb8y1YY+8VGWLXDi3OZpTZFE9N6+EtKIiubSnuN9V6isE33nzpPHHRqq
 fMprLJea2dTj1Ni2MFgTjuzZQ9euNzJWZkEy+tm+gC5jYYfroUv6plAsHCBkJr2Jp6p+
 L6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364092; x=1718968892;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z8b57N2WBHjS8UvdWioDaWnF2ckBCIwj9jZDjOdO12Q=;
 b=rFArLJh9QgHIIe7011EwMxH7k2lqQvztDoKXeaK/5UmhRdupEbMSbXhZs+yewVOtEN
 m9rZf4jbiGD8paZNkmqwTmLgmoH19DxLXlDaPjCdp6rs6+66+X1rAjFYKPitPMVw7pN7
 yXConuB4Wx5JliAGaX1Jwlu79UI5kwJ1KUZuKv99FzsKz8Sj5vThQh9v+xKasxrDz7Qa
 I/nvr42Sfts26kcGm8FPfQgAkVy5mKMaMjpBjiv37eJJXSy8aUJ7Old6H77+ae4i/V+2
 C3HCDlI82/VMpuyfhl9TwtRehPytKHrnc4FNwxR3IbjSmJOJjFRygPl+nL5SzBClBAXM
 HleA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIyHiumefe7EsL764AEVyuRo14C0/86PJnZhuNL3EzfBZ0iuIBh/6rEDecq7XYtjeVUQrxNfZXuUpvtUePA4PTdh/6zQ==
X-Gm-Message-State: AOJu0Yxcx2Dccmkk2u3BCo/IpTmpFdyi768hZY9cnzV+H326dom6008q
 p1ZDGgeB7Mebu0ARb0RTNAnQWmMYGuqoS1d0czNJv88P+gvxoaoKuqXVrJVUYIhlS445Xnv2MDV
 fqTQdmhLZKFRu7WOaYa7p3CIbxh6ibdh6QixUHA==
X-Google-Smtp-Source: AGHT+IHDPuug6yM8CONhZnTFG56vP3V4+gZw3xF7Nsc9BYfMeRzT5uErjby3qE97MQ6YgLDqmkh9+QYxN4WaU0v1/7M=
X-Received: by 2002:a17:90a:d158:b0:2c3:195b:dc2e with SMTP id
 98e67ed59e1d1-2c4db129324mr2664954a91.9.1718364091966; Fri, 14 Jun 2024
 04:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240614094031.6013-1-ilias.apalodimas@linaro.org>
 <ab7c6516-8d03-4561-b4e7-f619799416ba@gmx.de>
In-Reply-To: <ab7c6516-8d03-4561-b4e7-f619799416ba@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Jun 2024 14:20:55 +0300
Message-ID: <CAC_iWjLG5tFgd+c8DQDPQprB9jEKC+KXpXCUHKCR_6kUGU1x=g@mail.gmail.com>
Subject: Re: [PATCH] doc: describe UEFI measured boot
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 heinrich.schuchardt@canonical.com
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

[...]

>
> > +
> > +UEFI requirements
> > +~~~~~~~~~~~~~~~~~
> > +* A hardware TPM 2.0 supported by the U-Boot drivers
>
> by an enabled U-Boot driver.
>
> > +* CONFIG_EFI_TCG2_PROTOCOL=y
> > +* CONFIG_EFI_TCG2_PROTOCOL_EVENTLOG_SIZE=y
> > +* optional CONFIG_EFI_TCG2_PROTOCOL_MEASURE_DTB=y will measure the loaded DTB in PCR 0
>
> Why does this setting not default to yes?
>

Forgot to answer this. Measuring a DTB is far too circumstantial to be
enabled by default. People inject all kind of stuff in there -- kaslr
seeds and random mac addresses are just prime examples. To enable it
by default, we need to do the measurements early and make sure the
random artifacts aren't enabled by a previous stage bootloader. As a
result we leave the decision to measure it per board.

Regards
/Ilias
