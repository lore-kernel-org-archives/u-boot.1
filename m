Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB19D41D68
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 17:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE226835C6;
	Thu, 11 Dec 2025 18:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XI3nHSaQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C245F83642; Thu, 11 Dec 2025 18:36:18 +0100 (CET)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 411E083015
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 18:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-bd610f4425fso226815a12.3
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765474574; x=1766079374; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VCBN0PP3zE4c/DGJl7SO2AmgTiBckYJuyjqDKjO65sk=;
 b=XI3nHSaQea0OVCDscSh+hm816VBbG9E/Rl+LSBfCaOyht3uNMzcxzioCB3c6C3JLkG
 3fmUk3+fHiG1dS9XSWE5cA6nT+ZCdrxbEgl/ZO3ScfOYqEdN/ZC8pvtcar0ka8imm9vI
 52QHeZ9AZXhvAOZ9hZb1VL3/CaGQRERMcUIoTLuxYRFsiS+6TKP10w5WAaHHj/0mkzJV
 Mk1yrB+4RehVL6ILhn0dKod6PnPonZclA2IQ0dZLtgFQW/tyv9RBH4V/8iXuCtL10RQM
 SegNErw4JLrgPCj1ASAnudi5HUNzk1z4+Raar7NLPF1FY3wsNpiekS2lzr0inbkQv4Jy
 jReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765474574; x=1766079374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VCBN0PP3zE4c/DGJl7SO2AmgTiBckYJuyjqDKjO65sk=;
 b=pG8Y9iRZqXnmShKrnl7Cv2BUVqj8lzr2zExIt5iLpYgcu02EVUuEXYumtfEnqVSuh+
 SJu64I3biSNwhCtvrK1Ipv2wHwWjTJVAaqjC576jS65mKy2dgzBj+yj8Qp555x2OSFA7
 EVFC0zPsahv4KUzSs0Ucoe7YTchwKkgWRjunyRy+cDynIrSdOemkCbRtVr5HL7jsdJEq
 CY57ROfXyUXt0+JvPcQupKX09ptpgiKcnAS32zYkcq3i30MOhuhXfKoOzgu8yS0FeJkt
 EsNJdKAdaRQlE1v3KCal9jo501MOmwmd4VswTFeUH/rmMh1+R8YZIQqhZEtxbSF8NDLF
 27Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe9EGA6o03+zXXsZmGMCl/tK2PF4hOJDgcYb/woZZ9sfPhDWB/vS6F/TvsBCV4zx+mbj+v5yM=@lists.denx.de
X-Gm-Message-State: AOJu0YyCOthdIGTWCH4DwgGWeFDNW3pgdEc9ZDzme0VYcmMGE97Vms8K
 fRcek7tYqUKzvS/j3IVzxyEJEoY8pfUFdgkkLmyrbiHJkMizqtOt7qfUXNuAKfPGUo3hGmITx8A
 ZRc/K7c3yk0VBG8lUcvLkDNPwMg6TZUVOBQdoVysihA==
X-Gm-Gg: AY/fxX6sN8Z5pspOzI4glxKBWqGXQCN6cOQG4OcGMjVfxtleVpoxx2CKCvqM/f4GfDY
 QiGofc16b8KRTLEHpFR8h2EqfQyOEjzy9AKLom6/1N9joWeFZv8Qbwdm2rxuJ1xIf5r9J4esgYe
 j1MkFjwg5+gR65ck7yCNRPlGghZvufVjCM9ScWEQox+OIKCovs/OQxpX+6CZyaEUpw4HZtEt2xQ
 RrSS4v6ZKSSkjBdZqk1SqLA37xm/UBWNrBeGdPzTD2LFlq5mmB291M5aNxQiuKEj0TDTdNFCBfC
 1ucCkFaP
X-Google-Smtp-Source: AGHT+IE/SzdJeskJS5EOo7dpfd2kj4jfWHf+hNVDO/KeJ+Nt93iMIOntMKLwgbwEPU3D42h/DPk/nrme8ya8fb75rrY=
X-Received: by 2002:a05:7301:1623:b0:2a4:5ce8:44d0 with SMTP id
 5a478bee46e88-2ac055c6c67mr4267176eec.38.1765474574110; Thu, 11 Dec 2025
 09:36:14 -0800 (PST)
MIME-Version: 1.0
References: <20251125212953.1733-1-briansune@gmail.com>
 <CAN7C2SBn=6J0c7AOM64TOKsa8waGFTtLKUVYfnY7NyAYH_N1gA@mail.gmail.com>
 <d024aad3-6ad5-471e-8290-e802bdbf7ead@cherry.de>
 <CAN7C2SDdTsJADMWDZgugMnoTO-sqGUt1wQPsKyRwP=gHNdmQ2A@mail.gmail.com>
 <CAN7C2SBPC=u7QJD7T=3NUUOjPqXo1UWqHb_QRzsOR_wtvZrk7Q@mail.gmail.com>
 <85af1053-f8c6-4983-adba-7a1e845651e4@altera.com>
 <CAN7C2SA78DM+XaXMJNA26o0EzxFkdwL26BfcH91boepT0bDPKQ@mail.gmail.com>
 <CANp-EDaU0Vw0dqWOfAXKub6Qq8FN5LvNJyttB6-EA4imAK8mvw@mail.gmail.com>
 <CAN7C2SBSYkFrkaTDg7kuE2NsqUsjshZVepCdad+5buMSpBEmDw@mail.gmail.com>
 <CANp-EDZAJr5Hvh0T=53H-DeOU5G0mZ-ohs9c29+7eyOKny6yOA@mail.gmail.com>
 <CANp-EDZa0Y4NFOD2sco1xvONeLeixFQOrGLZ+hC275wMCHuF6g@mail.gmail.com>
 <CAN7C2SBop5h9WtF2GLRkWeNmLpBcDC5dHUmmR=WzRXTpr6-7VQ@mail.gmail.com>
 <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
In-Reply-To: <CAN7C2SC7nfpDmQXjfJyZDw5m6HnfbSed+w_JNsS7+x2s190Huw@mail.gmail.com>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Thu, 11 Dec 2025 12:36:03 -0500
X-Gm-Features: AQt7F2pyPXg-BjRpCYCtJ0Y6ZMCTT4OTefGkrw8W9eBLBrBNVJsFuKmiFs2UoIc
Message-ID: <CANp-EDb+Txnrb15KuXBof6PMZp02WZ1MOy-LkrGoW-OLE8mWCA@mail.gmail.com>
Subject: Re: [PATCH v4] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Sune Brian <briansune@gmail.com>
Cc: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>,
 Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 "Chee, Tien Fong" <tienfong.chee@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Brian,

On Thu, Dec 4, 2025 at 1:09=E2=80=AFPM Sune Brian <briansune@gmail.com> wro=
te:

> If possible I would like to check if this is aligned disregarded to DRAM =
size.
> On U-Boot latest or after 2025.07.

Sorry for the delay. I am testing on 2025.10 version with a few
additional changes. It is a custom board using its own Quartus memory
parameters (which have been unchanged in many years).

> Issue 1:
> sequencer.c if turned on debug by including this at the very top.
> "#define LOG_DEBUG" and "#define DLEVEL 1 or 2"
> If will stall somehow on any brand of board my side current had.

I also encountered this, but it was solved by disable the watchdog, by
toggling L4WD0 reset. After doing this, there is no problem with using
DLEVEL 2. I even took it a step further and logged every single write
to the DDR control registers.

> Issue 2:
> For DRAM size larger than 1GB, when w/o O.C. and using as stable
> setting as possible.
> Even it passed the calibration it will not cont'd boot when
> sdram_gen5.c is turned on debug flag via "#define LOG_DEBUG"
> However this issue is not found on 1GB nor 512MB.

I was able to get access to board with 2GB, and it boots successfully.
Memory calibration completes, and subsequent test with u-boot "mtest"
basic memory test is also passing.

I'm also running memtester on my 512MB board and it hasn't found any
issues after a few hours runtime.

Regards,
Ralph
