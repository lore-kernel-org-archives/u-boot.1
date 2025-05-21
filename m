Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407A1C2D0CD
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 09:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C397082D59;
	Wed, 21 May 2025 11:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rpLjrXlm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6756A82D6C; Wed, 21 May 2025 11:08:20 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B98A982D2B
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 11:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-708d90aa8f9so62262427b3.3
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 02:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747818496; x=1748423296; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GN6EWBjKHB+AdRNObjbAaAzZ+N6sSf60u4W6U5vy5ko=;
 b=rpLjrXlmirCAiyDd4STXgHXlI5Xm4s1AB558ziZKpxBnhv0Kvwn3J+GDQZFLhRwo5R
 8M19f6H1GDFYgCRWwR50gxegwSzz6hBKx9pxX4J60WWyFKBsF04nWPI/f4cNtFvX271r
 fNAMqL8BMBdabw53z3Ozf3zO5TvpEUWmqRWcIPeUa/vgAoE6DWYxl+vfTZghWjgWw7WV
 d/gC8FnsUzbcEznn0ikxD1LGvryB1UrglsP5bOs/vU942ybyohl3EV/7J4Z6iLbtoGK5
 a/D0aehRP8ZJEXYEbRc0OBYbBBBaaFfvTKK71OBqsssxIROLZBm2N4MTpBzHtHXsQLzc
 MPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747818496; x=1748423296;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GN6EWBjKHB+AdRNObjbAaAzZ+N6sSf60u4W6U5vy5ko=;
 b=I7ikypSVNSB4QR3Az5akml/APkYBd+Y4KykXoeSO7kUIkbMkr5+yelEt69Uk8Rk3p4
 iwFtMZdGx5lYBStIX61Qj54mrmZjxWV6JlQ190e8Z7cF+gLOy1IlBbGbgp5jYJwJU5gN
 R1AF/xolw6g76wfxvZtYAv/V2orehnEJCTLVvSyT4h7AcklQ29b2xOyCcVGRAhUFXrB+
 2u4iATl/Hyfpd/LV93N6iYpK0xyM7qljEvlOWSPx1iSZCjo3QnreSbIAHaS8agHxumUy
 mGdcTR39JUfNkckKRGjb6LSGGJiy/VWrCwdUIWcSeIiRLTF6h5dADkdGDP/Pe+JTgMT9
 Jtvg==
X-Gm-Message-State: AOJu0YxV0cXJgamAikXUHOyT8hyKHE0hGlkOf4WUaLRHwdbxfzmBa9Ub
 u5o+v1+a7fDmSOG+oZw5uz58J0ObQAhcLkJ+vwuErCEXBODXXju9/IkfuHf/FqyKkH8lueuHuA1
 9KraI2BwQkbnOmxJ1ptwpEPBgUZ6s6zAmFuurL3chfgwHeZkeKanWNDk=
X-Gm-Gg: ASbGncsVy+3Cv2TQIuFQNQ1OMkUvPh3eulUPO+38BT6M7GbvRVAjdqCGrlXaQsW4F00
 nz9Sh74jNGMRhnEUSpc+P4Pb5iCVXdfvKER/zJM6xgc7iGlXdhLav95SpBt/OPcC4t4cTmuGpJi
 anGY8mpFmFXFWbUk+VkpIc3Xwx+Ke9UR5egQ==
X-Google-Smtp-Source: AGHT+IHPNx1lDQF2MV0/PCmrBTS+Wne+j6osW1n8xDyTyAMkSJirvBiEEzVKg5oZEGddZYIpXELac0cirelGUb6JEv0=
X-Received: by 2002:a05:690c:6087:b0:708:73bc:abdc with SMTP id
 00721157ae682-70ca7b74584mr278041727b3.22.1747818496451; Wed, 21 May 2025
 02:08:16 -0700 (PDT)
MIME-Version: 1.0
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 21 May 2025 12:07:40 +0300
X-Gm-Features: AX0GCFspOOI95DKWYjzANLEdiABKHIg3xS5MXRKC2mo5TeVqrev7Kka5xiarfzc
Message-ID: <CAC_iWjJirOoP49HAzMSmnK0B5fZji9+-GAg7Vku3DWOZ6DQOhw@mail.gmail.com>
Subject: QEMU & KVM broken for arm64
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, 
 Mark Kettenis <kettenis@openbsd.org>
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

Hi all,

Starting from commit 53d5a221632e  ("emulation: Use bloblist to hold
tables") I can't boot U-Boot with QEMU (version 8.2.2) & KVM anymore.
The command line to reproduce it is:
qemu-system-aarch64 -smp 2 -nographic -cpu host -m 4096 -accel kvm
-bios u-boot.bin -machine virt,secure=off

commit 24768a23a9b3 ("emulation: fdt: Relax condition for
OF_HAS_PRIOR_STAGE") boots fine.

Simon do you have an arm64 host to reproduce this?

Thanks
/Ilias
