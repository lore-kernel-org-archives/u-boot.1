Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EFDFC3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 15:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B370888852;
	Mon, 29 Jul 2024 17:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cPZHycM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4198788835; Mon, 29 Jul 2024 17:28:47 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A28F88874
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 17:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-44fe28eb1bfso19329171cf.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722266922; x=1722871722; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bvq/oJOlM0Lb076DxLo9r9mclxAYZEShsfPbrjHqQEQ=;
 b=cPZHycM0G+DfI4lKvA71KORXxIN9f6wff35YHQeDcSBFB7nY/pHkAdZcot9Nm9fd93
 +tHbr2xbbIJNcRiUvSAq4ZH6WpUbFsaAZBhhx+AKV3bjUfSbUVli1FkhkRhqNdzce71H
 +1J+rvbYTIyoc1/xQ1MnxUgKYzC5IT7ANKYVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266922; x=1722871722;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvq/oJOlM0Lb076DxLo9r9mclxAYZEShsfPbrjHqQEQ=;
 b=jEweeXfvoluBKwJPQN6GNZd2LQKAsVzdEGXUUp/yp0tgOIIHRgIJiBR43sOL1VJzgp
 13adaSFZKGEFPUBC4lKVp9mhYrSR2Ohlz3E8h4re7rNtiUrO+Sn8e/lswG3ir/tSAIvH
 lrx4pXFjTS9Nl56k14Y6UZDPoGWQp2GfYSSYe+uCo+kQ+8Lm4wJDPb1HALiIznBCEVg1
 JV7MZC03VZHr+D+H9DR7QIpQIWkl01DrKsIcUUlP7a3T8E17FABtnau75b5Kc/NOaJmt
 d8fG7hygy9qzy7Dl6j0g1q3RGJEul0SIHZ7TeyCKouAOiR49CjBOZKphQt2Q1EvomMsk
 x8Rg==
X-Gm-Message-State: AOJu0Yz2SyrQAmYQzRuB0G7SgTmfqmQ6CeNCuNI9YiGco6SCCYRtCXOA
 0Hj/lqgO7jVJ1gSwvCnC5Up4JZH0yjgzQ7ZDjrz5r6H6nU1pIuPbn/MztXMMlPnoKCMzEOFBInN
 KlJxwpcOVE0xGIMLdQq8B/0/wyGfk/vjzPAY9
X-Google-Smtp-Source: AGHT+IFNv/2HPOtgEMc+MQlBQa+XOzbQN59BflN9J5vNf+L6eZaDo0ZNA2BEG7sb3aZppUtISF2+x7zj1fBYW7+K9wE=
X-Received: by 2002:a05:6214:d0b:b0:6b4:ff80:ee0e with SMTP id
 6a1803df08f44-6bb557c6a32mr86290166d6.0.1722266922291; Mon, 29 Jul 2024
 08:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
 <20240727071742.1735703-2-patrick.rudolph@9elements.com>
In-Reply-To: <20240727071742.1735703-2-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:28:31 -0600
Message-ID: <CAFLszTgxXXhguSHsFXJCpKPkaHoBe7e8rQbg7ND0H7B-oiPx9g@mail.gmail.com>
Subject: Re: [PATCH 01/17] acpi: x86: Move SPCR and DBG2 into common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, mbrugger@suse.com, pbrobinson@gmail.com, 
 trini@konsulko.com, bmeng.cn@gmail.com, 
 Maximilian Brune <maximilian.brune@9elements.com>
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

On Sat, 27 Jul 2024 at 01:20, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> This moves the SPCR and DBG2 table generation into common code, so that
> they can be used by architectures other than x86.
>
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
>  arch/x86/include/asm/acpi_table.h |  11 --
>  arch/x86/lib/acpi_table.c         | 174 ----------------------
>  include/acpi/acpi_table.h         |  54 ++++---
>  lib/acpi/acpi_table.c             | 232 +++++++++++++++++++++++++++++-
>  4 files changed, 265 insertions(+), 206 deletions(-)

This is adding new code too, so please put that in a separate patch.

Regards,
Simon
