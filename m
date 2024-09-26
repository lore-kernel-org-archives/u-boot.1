Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF76CDE03A
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E673C88EBB;
	Thu, 26 Sep 2024 23:33:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QNYIjdF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4C2688EDD; Thu, 26 Sep 2024 23:33:56 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E819E88EC6
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cb2aac40faso16247096d6.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386432; x=1727991232; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v7fJJjKN1axMCIszfI4URL6fAiyX1UgyNia8W8+hhzg=;
 b=QNYIjdF/7kOxm5f0lEOf6QsJwbfa3N0xju3YpCrGfoeN7raG87ubqUkXc2BekkAI0A
 l6xmUnMV+NLxDvvE6z5+gVMSwTh/gokjiFdlhzjvOJ/om3A9nvYZajnBJiVLn7TN5zOk
 KnKK8DY6cRhstZvWkw0wQii/Ljne8yNBieLNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386432; x=1727991232;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v7fJJjKN1axMCIszfI4URL6fAiyX1UgyNia8W8+hhzg=;
 b=SgxZG0INO66w/ldCpVitS1ZvwrcMfOxTe+rrsbFK6Ll/Oa9HmEW7OQLxfpOgKlWAeZ
 GzLusD5713wG6DyZWtXTFsZB3JpYW+M4qUUiRzUysYIFxI4GpAJiknhczCcGxgXMyqGG
 UCJIH9SSvat1x6d/MpWU/QXlrLHEbayuUoKlnQFt6YvRMH/o7TCSLDxbBDtCIMyFpVvC
 bJ7a1c/PmfHrtxnNweAEAmIpuFq0CGDqKGT8d4pbqIJM2vcQynzg39pTvt+98JEdrnXg
 ZCVPx/0JvxjUN0gtQvoMH+tzE0agjYvRy7glaCUmODI7CTl7kL33XJ7prxgXGqnG5iz5
 mrtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRKr8UcO0sSWG8xMAYM61ndnuQGZvSpu4V5OHI663fI/FiUmPfkcY89YbEMkESwcqc2c+HUo4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyxp14M/UAnkX17T9/pQ2nVAbXXIgROZK3PFi3wR2zEq2YdNtST
 gLlFp00suW85MeKO4iKZ5lQefyLy5siW7icoCxpQBZHxNMdCCq477VRRwpoUQ9QijnNjAf6rsLe
 l0bmNH3nLz+Y105ovqvvBU0alnYfP0IpWrydg
X-Google-Smtp-Source: AGHT+IGFLt0QHVIT21ujGH9i/qTC2GRnIfGvx4fOWnYhWhG0l6/sfWV7zAsADYAA0xSTnj0A/KydGnQhKYceKQe/oic=
X-Received: by 2002:a05:6214:568f:b0:6c5:5095:3f02 with SMTP id
 6a1803df08f44-6cb3b32d9e8mr28307436d6.1.1727386431844; Thu, 26 Sep 2024
 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240920225101.2008-1-ansuelsmth@gmail.com>
 <20240920225101.2008-3-ansuelsmth@gmail.com>
In-Reply-To: <20240920225101.2008-3-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:33:39 +0200
Message-ID: <CAFLszThe2f-OGrxGmJMOyQ7ritUAyKgo2HUJUp87WBN53_qYLw@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] dm: core: implement ofnode_options helpers
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Yang Xiwen <forbidden405@outlook.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, 
 Martin Kurbanov <mmkurbanov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Artur Rojek <artur@conclusive.pl>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, 
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>
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

Hi Christian,

On Sat, 21 Sept 2024 at 00:51, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Implement ofnode_options helpers to read options in /options/u-boot to
> adapt to the new way to declare options as described in [0].
>
> [0] dtschema/schemas/options/u-boot.yaml
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/core/ofnode.c | 33 +++++++++++++++++++++++++++++++++
>  include/dm/ofnode.h   | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

It's fine to add the tests in the same patch, if you like
