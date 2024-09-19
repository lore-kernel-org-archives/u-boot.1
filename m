Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461D7CF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C41E8891CF;
	Thu, 19 Sep 2024 16:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cYShX9qX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3B2891C7; Thu, 19 Sep 2024 16:10:00 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9445689178
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:09:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6c54b1f52f7so5479426d6.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726754997; x=1727359797; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/hrPY9yIk9SNq5dowTPJC/MQxyHV/pmBS7RiR312VU=;
 b=cYShX9qXxHwH6b7fZd4c2Ztr62xbVi14jJLB5aJm+RVjTBykvy2yvZ0qHtF+f0reyP
 3N7Hn1bD+Q0IImyAVyW+upMh4e/im2J4g4TM1z71YGIi7+D4AGJuJWJiBk0F0h2TrNTg
 eAHklKJ71IWBklLcK9/0oVlBr69ABSRK3ElGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726754997; x=1727359797;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/hrPY9yIk9SNq5dowTPJC/MQxyHV/pmBS7RiR312VU=;
 b=C0l5KkMKY5mSZZOPBg3Dh1vaU/ppDtJYdZy+lBOGpZJwgOsgdq/R66srvbhgy3T7hj
 5jiMuxeG0RjPgZ42nRJnjvjZDlcajztOiy7yFaJ2UV1n+NPEJrkWdIqMX+nEawNp4+wh
 m65vaDd/utGjGDOSrIkvZg0tuoIiQo8DXmXTsn09uuSacfTrT2fKxSo38iCnTz/JLcdD
 iabxubQel8o6gG/Nv5RhYJsMYLDVRlb7VKpzqwOP+Gn3fkIhRaSiLO2kRLp22x23BVH0
 w727eGpGQ+WCF3DxPJcC/AKigUs93FfKQ9NSkDX1BsXCMqPrNdHuO+w+k5cZ65XUIwNe
 05bw==
X-Gm-Message-State: AOJu0Yy8+zAkgJZwW08d1Z6WJTn4dN4Bu06QKxAwuAdBZf2+Ky4EUME5
 BJ46tydKTQwoXOFfuSZdld5rnUgW7ukqiaKiXU8a2mZMQXrQjHVErqokORv0z3YjS1aSXDoVfLZ
 XfYEjUE6xn/BKskTSJeIlaghPq5ygXEimHQw5
X-Google-Smtp-Source: AGHT+IFT5TGHBvMvezVKDdma1ISd6v8+1/bjzvA0SsPItCZ/rvXNx+l1in6TiULgkMCIfDF1sCJdDPD6+vu6dMwdleU=
X-Received: by 2002:a05:6214:5d92:b0:6c5:688a:63b4 with SMTP id
 6a1803df08f44-6c57359256emr369349236d6.50.1726754997214; Thu, 19 Sep 2024
 07:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-36-patrick.rudolph@9elements.com>
In-Reply-To: <20240918152136.3395170-36-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:09:46 +0200
Message-ID: <CAFLszTjUWHPF4jYBJDJBzyDFm7N8mQurdq=2eesayJS7yqi+6A@mail.gmail.com>
Subject: Re: [PATCH v4 35/35] configs: Add RPI4 ACPI defconfig
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 18 Sept 2024 at 17:23, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> Allows to build the RPi4 with ACPI enabled.
>
> TEST: - Boots on qemu-system-aarch64 -machine raspi4b
>       - Boots on real hardware with arm_64bit=1 in config.txt
>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> ---
> Changelog v4:
> - Enable BLOBLISTS
> ---
>  configs/rpi_4_acpi_defconfig | 70 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 configs/rpi_4_acpi_defconfig

Reviewed-by: Simon Glass <sjg@chromium.org>
