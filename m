Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958D9C83F0C
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 02:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF2D586AB0;
	Sat, 26 Aug 2023 04:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i3CcOIqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E3886430; Sat, 26 Aug 2023 04:04:46 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A9C8693D
 for <u-boot@lists.denx.de>; Sat, 26 Aug 2023 04:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4ff933f9ca8so2297864e87.1
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693015482; x=1693620282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5LNd//DrwO91Bwjtp+P6CL2KBwuFuRW8gkTDyhpKN/4=;
 b=i3CcOIqamh0tjwghl7vl0ziWO2Pm7gAwLpAWl6knRNrMj4XW9zEKh/gEPf7mjp6y2V
 FLLEBRkG4BklF48kfimxgTsdvDFP9dVKDMTRDo0WbrTjc8b6r1Pm+I0j1bZCKQdK/Lo0
 pXPvny6NCGnFCEOxopwEdatiC+0oMJkoKIJbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693015482; x=1693620282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5LNd//DrwO91Bwjtp+P6CL2KBwuFuRW8gkTDyhpKN/4=;
 b=WMHo7oyvohcQfJzmjKe/gOrQ6RTP353KUVCDVkL8Pa0SHdXzUL+IBKDT3baGzH5cY5
 EBJdfaXTVFEv9O2fACZ+hI/yZaoOvoXwCNlHTaUBoE9tWNb+7hnInxLPKOJagYkOxEiT
 InAjKsBxZUy6/TpORlRVPidIe4qOLJQ8kaC5bzbvNK1r3jlT6HhoaRy8DuFodgSHarCa
 UFNFOmEQKVAuZydL14Df4T4wMOYfUGViZeeLJp5eoHCb+KU33PfMCygsxl0XZCKe+3dz
 CQcOgOKT7JGzvbUN+RawSr5JkDexj+B20P417HxkW0clmFMKe0B7GXM6N1379lNqehbR
 2q7g==
X-Gm-Message-State: AOJu0YzojCGUPNdk+oENwiuajhn7Z+HeyntDAWcpwRACTGYwbTg6jtLp
 MD7NFC6GFzT19eCSlAKuCrlWCQTNAQAClOizfABB3w==
X-Google-Smtp-Source: AGHT+IEc5bLAJI3ynQQeeq6IX15mWWLqPHDc7sUo1YXEZOBLPpR+TvkeofCgC3Mfqs7WsHtKpLmsuLmLoEnD2aUqdVc=
X-Received: by 2002:ac2:4e0d:0:b0:4f8:77db:1d9e with SMTP id
 e13-20020ac24e0d000000b004f877db1d9emr17923838lfr.12.1693015482307; Fri, 25
 Aug 2023 19:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230826015343.167612-1-heinrich.schuchardt@canonical.com>
 <20230826015343.167612-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20230826015343.167612-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 25 Aug 2023 20:04:30 -0600
Message-ID: <CAPnjgZ1AqaME9UqHHyfrRSh+41J3oC3+XkZ1Z3hXXzZh7Muufg@mail.gmail.com>
Subject: Re: [PATCH 1/3] cmd: fix gpt setenv
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Joshua Watt <jpewhacker@gmail.com>
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

On Fri, 25 Aug 2023 at 19:53, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Do not assume that partitions are continuously numbered starting at 1.
>
> Having a partition table with a single partition 63 is valid.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/gpt.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

I would like to have a map / list of the partition on a disk for
bootstd. At present we iterate through a lot of partitions that are
not present.

What do you think?

Regards,
Simon
