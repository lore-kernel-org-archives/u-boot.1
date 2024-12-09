Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9169E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 23:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E68AB89706;
	Tue, 10 Dec 2024 00:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="inFTP4IJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF68A897A1; Tue, 10 Dec 2024 00:06:02 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5AE89706
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 00:06:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so5598576a12.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 15:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733785560; x=1734390360; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TBgilIhc4eFfP5gj2G4KmGy5CJgHCC+206HDHZXZdOk=;
 b=inFTP4IJhhJVkJeTZAZeADlKxPg6KLu2wTZr9xu/qf3KpoqZvDz76HWk2rBLA/agji
 xcRqVbhua6+RhZZpchcQul+yqGeRE4c4sw6tflm3+c+Iw2IebC3Z4XJQ+g8hqvKSZ1iF
 uip4UMTGZoq/dQZRKTkq+YWzDQzMap3py/4TbMYhVan1IrsDNHQqaHwv65F/ESSWKv9Y
 eK5dij126a7QjOB4+K5lB1GXydyicKxcWhc2dbPDYyy/iY2oEYqFP45NarPrlzRYghfb
 pIrLuRW/N08cl0j3MCPfvsP7dluswwEE6gF7eRMOaTWJGizBGWgDKDJHoZWhUHgJikkq
 4EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733785560; x=1734390360;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBgilIhc4eFfP5gj2G4KmGy5CJgHCC+206HDHZXZdOk=;
 b=boWQSVjWREYnANJcOjy8lywe7JqmxFCHQ1Aj/hfCjkf53t1CRYxT0ZAIZ75TT+T9B0
 LMFiPetMFFisW4hb7IedxZYeLJL4mY6t3boCkRCUnrceTmOc35P/qUNEG7yiz6hygZum
 cqm0c/q33PTnofcSWFx4a5SndBuuTnJ3pXpe/W2NQbk3WpKGauzk8Yy5FsLKWK93w3T1
 fBC1yadwYmzjEZ5y/XbYT3xCDaMtocZlcVCm+d7/NeaVz9km81QC2F58gaHKKkESMvsb
 qR2bgBAKE11EuXJYJSfJOXD6bW5EG9P2pPcOC1+kI3dPH1jpMIc0uc0n7Jtx27SGa5ug
 TIoQ==
X-Gm-Message-State: AOJu0Ywj1aW/JXrkBWewtG3kX8XXcmQYoa8+Ii0WY2zOD4tHFeiRC8Y1
 ybOX7iTDE1YY8NZsRpmsEI6sO1jSTWJFlqEAI0mfhveOLazVVN92AeoRT2jjcjenByUu9m4pWmN
 vm22w0NexjsvivvyMANET11+CU3I=
X-Gm-Gg: ASbGncvtfEs7ojdv/8y6tE1x74ljVeoSO92cPmI/COL0TrMzrKMtxvjiiCd1T5sekzN
 M1TQjJFDGn45iATULgI5O8q9nJp1vqrFmKK8=
X-Google-Smtp-Source: AGHT+IHrCtR1rNGaOuFRrYgWJNMPSn8vc4zk70CA0pQm+1db1dcaWH9TE6XAsMuJ4tEzqCvGMbiBy8o3agTpxA0Lwp4=
X-Received: by 2002:a05:6402:321a:b0:5d2:7456:9812 with SMTP id
 4fb4d7f45d1cf-5d3be7f0584mr14070423a12.22.1733785559914; Mon, 09 Dec 2024
 15:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20241209182002.671953-1-sjg@chromium.org>
In-Reply-To: <20241209182002.671953-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 9 Dec 2024 23:05:49 +0000
Message-ID: <CALeDE9O6Z448edqH4MubyB03yqip_c5qrE00_Ynx9mHvrn5dCg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] rpi: Tidy up booting
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@wwwdotorg.org>, 
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 9 Dec 2024 at 18:20, Simon Glass <sjg@chromium.org> wrote:

> This series allows rpi to boot a compressed Ubuntu kernel with ~100MB
> ramdisk, by expanding the available space.
>

What version of the RPi hardware have you tested this on?


> It also tidies up some strange behaviour with the provided FDT, where a
> separate pointer is maintained to it, even though U-Boot has copied it
> and placed it in its own space. This avoids strange bugs where it
> accidentally gets overwritten when loading a file into memory.
>
> The patch to expand the devicetree was dropped, meaning that people
> should be careful to unset fdt_addr in the environment.
>
> Changes in v2:
> - Add new patch to make myself an rpi maintainer
> - Add new patch to set bootm_size
> - Add new patch to drop fdt_high and initrd_high
> - Drop patch to allow expanding the devicetree during relocation
>
> Simon Glass (5):
>   rpi: Add myself to the list of maintainers
>   rpi: Set bootm_size to 512MB
>   rpi: Drop fdt_high and initrd_high
>   rpi: Update environment to support booti and large initrd
>   rpi: Use the U-Boot control FDT for fdt_addr
>
>  MAINTAINERS                   |  1 +
>  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
>  board/raspberrypi/rpi/rpi.env | 24 +++++++++++++-----------
>  3 files changed, 22 insertions(+), 23 deletions(-)
>
> --
> 2.34.1
>
>
