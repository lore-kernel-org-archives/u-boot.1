Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A16C52D7D
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 250F5886FD;
	Sat, 17 Aug 2024 17:58:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Yy4ncDiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A8B788651; Sat, 17 Aug 2024 17:58:34 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21B768881C
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6bf6606363fso16757546d6.3
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910311; x=1724515111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O7Psga/ti0qwAWfG7vR8K/BLkDRLf3v7+3Q5PTKal6c=;
 b=Yy4ncDiR5CM96PLMaxTvTFWMIaT6nQcIi1fU3DHu37fMQ1p1cgGbsxwnDmeU5mH29c
 PlWLYePWVOswGClFLQnRJSZ+PPbOgudYRiW7JmJHqn+es5HStGTnEUelR5BaMr09Shr+
 qd/VfyZfozkUvAY7rsLZ5cpdjEH0795qg8/4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910311; x=1724515111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7Psga/ti0qwAWfG7vR8K/BLkDRLf3v7+3Q5PTKal6c=;
 b=OCzwYiMJUt3Rmz+LN/ETbOZLImCcCHi05w5pdyz1T13wYrTt8XfE/4gUNTdz6FhZQX
 e0sh2UNTowOFnJA6I7zWwABHUlvNVQ+H+vKkDZ0fp+zu6/wFDkkfXBPU95s6iqqy9Xt8
 otrXalrt73kbjEX6tjVINTCV1ZrYewt3YGcnH3UmTnUxbhm6tdRtTUSOjutVh15LSF7x
 Ho/P0bbMWisljXvnTKWgmjuxwm7Fdb5+gV+q+XBVgXcao8RRK+2+DvKOQEx+vFdn7NYs
 UGIMuRhqx3WzmADAKP+rkMGNCfs1UpzkIgKOKszKPEv6DsYwk8+g5sPeKEbpmakRhsad
 yeYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8t4Z6yPWFHENmeTUzecfdRG61rDFu9SEI77wZBwdKhflV9qO7pSgr/bk9oT6yqqNZTwGR9uvt3x04S7Rw6LyI4e7EBQ==
X-Gm-Message-State: AOJu0YzebB95iXjoUyVg1gKT+a0WZJQfseziGgaskCgX6WlBwFRqvEYE
 S4VxDtulvb8giI2JISLcFmUx8zmQ7MhqFUymv2eW/65pAi6/dMygmdfVFRAoZ3zvGadKsIz38FE
 OHm+vUIebhGXg5Haow6V6VZO1JFaq931WKLFb
X-Google-Smtp-Source: AGHT+IE5db+ftw76NfFxTrjXXor3hIk9xs4bywmFB3VQcqfpMDeoQGolvVsK2fy6ZpRq04IYFbnt9L0CWqPnflUgQ+I=
X-Received: by 2002:a05:6214:5409:b0:6b5:d73d:918f with SMTP id
 6a1803df08f44-6bf7cc9911bmr58577206d6.0.1723910311030; Sat, 17 Aug 2024
 08:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-4-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814103145.1347645-4-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:19 -0600
Message-ID: <CAFLszTiLopikJDEd5PHaeNacTO=GWxVH+dzbctgBqK0L_pqQTg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 3/9] net/tcp: put connection specific data into
 a tcp_stream structure
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
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

Hi Mikhail,

On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> no functional changes
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  include/net/tcp.h |  37 +++++++-
>  net/net.c         |  11 ++-
>  net/tcp.c         | 231 +++++++++++++++++++++++-----------------------
>  net/wget.c        |   3 +-
>  4 files changed, 163 insertions(+), 119 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

BTW it doesn't make a lot of sense to have a 'u8' function argument,
since it is passed in a register. It may force the compiler to mask
the value, adding to code size.

Regards,
Simon
