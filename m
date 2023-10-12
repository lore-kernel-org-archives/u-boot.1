Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC914CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D509486D3F;
	Thu, 12 Oct 2023 05:41:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="POAAM1yo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DE586DFA; Thu, 12 Oct 2023 05:41:34 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E9D86DD6
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53e16f076b3so54692a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082091; x=1697686891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mv/6TcJXGP0t2MAuYHAfmOimCzFkLsEgFaVZ6D1eVdI=;
 b=POAAM1yooTY6+JiINL0QE4vDqxFovh6Mzi6/wRTUin8E7NlgRNlQUCmXrTOfQjIeDf
 OhzUhRxmOrKXgFlfJ6vd9gzDPgaM5P0A+jwGvQHOD4jByMkdd1sqJe5KBnnHeZ5fKhDv
 PmIwl/IM+Ce1P/Gu1vDeJIIegal9hFW1eyWyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082091; x=1697686891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mv/6TcJXGP0t2MAuYHAfmOimCzFkLsEgFaVZ6D1eVdI=;
 b=djz/TM4+H8HqAa0cLJPXfuB987c9wqgzDWyqb/Vgxg+MgbQavKx5oQYA7OhoO6Se05
 OFH2v6lOCaBcV0FYDuxEIsJs+Ru9Hz9neqPC3RMl6Q/LfoM6XXgrbkGe1zDWGMpGp/k2
 TAMS6TiW5CxIaqBuocUlWZpL+IP6+M+P0PXDnppG0L+nmd6T7IW05F5ylZ84USXS2Qx5
 SwHwthELzMIDqa+q+7OcnawCmw1H8Dz01Nd1NWcR2C1ZCEImBef2+Fn0Cpv3ZbGfT20a
 0UtXV9C7QAaeekQM+RtqAXcxS/inc7Ca6IzyN15juA0BmOIskyRJHe+wW24fDLF8Zjap
 GGEQ==
X-Gm-Message-State: AOJu0YyWkmd/riI1DYOdvW68pSiRTq0d0t3f8Lb9e6B1Niaq2Gg8Jt/e
 BeV+p2g9huxpO2HcY8m0H4zB2+4MjtGjrwrBSGsu7Q==
X-Google-Smtp-Source: AGHT+IFj1uO8YpKLgN7zdh12PJUTzTpBuaGLu6gRvis0Bt8XtIfgZprADbB9J5Y7MZ5yHK/9qHr+Dg7nAL70wReisJk=
X-Received: by 2002:a17:907:72c1:b0:9a1:b85d:c952 with SMTP id
 du1-20020a17090772c100b009a1b85dc952mr22194845ejc.12.1697082090721; Wed, 11
 Oct 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-12-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-12-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:04 -0700
Message-ID: <CAPnjgZ00hx_6ZyuTLM452==Wd3smxKtguQX48a-ot3qNe3y2gA@mail.gmail.com>
Subject: Re: [PATCH 11/26] fs: ext4: Fix building ext4 in SPL if write is
 enabled
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> If EXT4_WRITE is enabled, write capabilities will be compiled into SPL, but
> not CRC16. Add an option to enable CRC16 to avoid linker errors.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  common/spl/Kconfig | 1 +
>  lib/Kconfig        | 6 ++++++
>  lib/Makefile       | 1 +
>  3 files changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
