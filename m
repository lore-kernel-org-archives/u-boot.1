Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 588AFC52D7F
	for <u-boot@archiver.kernel.org>; Sat, 17 Aug 2024 15:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46115888BF;
	Sat, 17 Aug 2024 17:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="krn29Uj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4534788892; Sat, 17 Aug 2024 17:58:29 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 345228861A
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 17:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b95b710e2cso19736096d6.2
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 08:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723910306; x=1724515106; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Im/HtfSdf6i4xSRsnhHi5Ry9bLHqEN/Qh+nyUjGk6zA=;
 b=krn29Uj8lokicFVQqzwipzMK+Rmw2JYona29pGJXFjuJO8nbXbU5i+zqpTFvp9enXJ
 iqQESwvEKh/FJMUhud1m+VK64HKsegGIq1TEHtMG9VPBRQbNRaocd824H1tBhnb/XIvH
 rFlH1bWnLWw91dxJLvOjQC0Gnuku3VHElBu04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723910306; x=1724515106;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Im/HtfSdf6i4xSRsnhHi5Ry9bLHqEN/Qh+nyUjGk6zA=;
 b=ORlRAHPLv0JJTE1A1TTywSOI5idqA9SHXbQOA1Wr9r3j9EYmhzf1RzMdEc294teKD0
 slUjMo1XuT2TWy5dDc/muqJzuWGnds3cM6nabyfuF1ZAigGDcXrHnyKUHrtgBjjXgl4I
 JLdMto/D2C/flBc1+fPo926c18zYVc9CoxVeT8bxZBaAo3wGrkfoHA9SNQ79ANOWu3eK
 Pr9VCUiIJbSgjyMOVfDXupbRQ3YViCgOSTUnls926hbayKLSwxTgh2RX9Um4XAem2By7
 J+KGr7QkYJmtEEbsemrHWmmmJl6NGEZXoIz3oe3KBQikH+rHpVJ6SR667VFqz//KxAYL
 p3gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEKMKGhSXTKWqomG3ooukH9HStd8665ZWd0HZzC0nhtzxjAFJDKablJoNJw7Olxpv3g6Ha41WHSAJKuP5EWbZY/VwbRQ==
X-Gm-Message-State: AOJu0Yz0EAb/uZqrATYa4nHUjWQEEiWH0+nZmED/VnPPcolQB5EELylD
 K8wwMqssPNfDqu/lE3GxjrZ+y+j7//ilysg+/cpdqB8sQREIPHhQpf31ZLqhUZyyfVxb/eD+TEX
 koeyGjVK9Ea7ZWkrNzEGPELTnGgA+tEW0COAp
X-Google-Smtp-Source: AGHT+IEA829dE/EVz/mSIwdp+jxwdr8kscL0pq1gdVR7eGjRWHGcwSKmWOB9ydQwdA5a/I1hVyZzV73GiycMdT19QRc=
X-Received: by 2002:a05:6214:14f3:b0:6bf:7fba:c81b with SMTP id
 6a1803df08f44-6bf7fbacbc7mr48205996d6.35.1723910306033; Sat, 17 Aug 2024
 08:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240814101402.1346941-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814101402.1346941-3-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240814101402.1346941-3-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Aug 2024 09:58:15 -0600
Message-ID: <CAFLszTi8nMZ4BJts-xUqKz3rN5SPBZhmhq7hjRjdnTxf_SKgJA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/2] spi: soft_spi: Parse cs-gpios only if
 num-chipselects is not <0>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 William Zhang <william.zhang@broadcom.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de, 
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
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

On Wed, 14 Aug 2024 at 04:14, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>
> Some boards don't have chipselect lines for leds so cs-gpios is not
> specified in the dts leading to probing error. Fix it by making
> behavior similar to the one in Linux, parse num-chipselects and
> if it is zero, ignore cs-gpios.
>
> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  doc/device-tree-bindings/spi/soft-spi.txt |  5 +++--
>  drivers/spi/soft_spi.c                    | 22 +++++++++++++++++++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
