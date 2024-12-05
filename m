Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042C5E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D8A89597;
	Thu,  5 Dec 2024 20:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DHEhu/nN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C46F48952C; Thu,  5 Dec 2024 20:55:55 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D20788956C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa549f2fa32so257908066b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428553; x=1734033353; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZ8grMOyK1pnAKLip7TDohnHLSr22iYwtgt+VWgtZB4=;
 b=DHEhu/nNMIiAbhi67x+3tMN9ox3m6cYwjdYW/c8P4vsQdkshd35/GsPEU5z/Y63Iyy
 gq54vTkB/9Z0Cm6ODwk7MMf4fbrRwKrxV1bKvh5Vec5+gEsZ0H/xTOVCGl5/6tl/dEt1
 ivLBUJYCNU3htXYxKb5kbhdYkMKrK5DXGYE9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428553; x=1734033353;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZ8grMOyK1pnAKLip7TDohnHLSr22iYwtgt+VWgtZB4=;
 b=kj1TK4aD8rINCPP23ZXSAWYcPiKV23qaDAm+AFMID9SR1I5XwG2knagQFrt0UAzomC
 dMp9axxAIGe3efFAk3cEiS9p/qQYzsmdSbfNW1LKts02zGB0EezBWe9H0QhHvuqZhtyH
 Q7gGoidECeaU8FCcKqThYGlsAbxHEHsg2WQotoF373m+tl51tyAtvCUCHwCCbFiHNffn
 ZSZ3bPjXSS/RgvFDZ9w7V/K1IqYdR21+cov1AjjHW0Fzqje4l/0chD9rPRI2A+FUIQN2
 A792KMJ2j/mfXwGC4RcForqcjhWsbXjP3sTEYFCgZyfVYJz7yz0EISub+buDxSD5A1Rf
 GC4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4IFAihagTD8w8Jibpx1cgo91uOzlx7/HpOm/tBdHACpoyxhOdgs/1iWJ+6Z/78R+2WRomAg8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz94gKPYIhI/ydVTNeO3l99SE/vyvlsLDWJiVt6r+GwG0zu/ZsE
 idpMyWUPZudsVtdpLw/9SiIDFfdZ8NVi158MhXoM2PrriZh04wRGkF3LFF4JhVxCe6v/Ovo5yyD
 uD/taDRARXXgDSRF7Wn5NY8tvZ9p2pKQahOmq
X-Gm-Gg: ASbGncs8ecl4dIv5Rz83eZX2b2LB9LPX9z4bl0Yx+NrOQGPyDCyZ51H6WyGPTUJLnLn
 wSR5XlJJkaMEYC6gIPGfibHaUWAFbhr76
X-Google-Smtp-Source: AGHT+IHSSOM9RunirxKorm7VLAtKqw7Fy2dz4SMk9TTdh3bJ18RzfsTQeaFxK+U6Y3bBc0yRKRxxiQwyUgaLSGc1k4Q=
X-Received: by 2002:a17:906:1baa:b0:aa5:40b4:e9f8 with SMTP id
 a640c23a62f3a-aa639fbc2ddmr12786966b.2.1733428553299; Thu, 05 Dec 2024
 11:55:53 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:50 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-11-sjg@chromium.org>
References: <20241115231926.211999-11-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:50 -0600
X-Google-Sender-Auth: 6YHXP8MOCqz3d3ajm7p7Cro-T9M
Message-ID: <CAFLszTh=ykc370uxuDcQjPo5PJG6inPNS3M6GUJNEcMGg5WhUQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/19] bootmeth: Update the read_file() method to
 include a type
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Julien Masson <jmasson@baylibre.com>, 
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

We want to record the type of each file which is loaded. Add an new
parameter for this, to the read_file() method. Update all users.

Make bootmeth_common_read_file() store information about the image that
is read.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v3)

Changes in v3:
- Use the helper function

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth-uclass.c   | 11 ++++++++---
 boot/bootmeth_android.c  |  3 ++-
 boot/bootmeth_cros.c     |  3 ++-
 boot/bootmeth_efi.c      |  5 +++--
 boot/bootmeth_efi_mgr.c  |  3 ++-
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_pxe.c      |  6 +++---
 boot/bootmeth_qfw.c      |  3 ++-
 boot/bootmeth_sandbox.c  |  3 ++-
 boot/vbe_simple.c        |  5 +++--
 include/bootmeth.h       | 13 +++++++++----
 11 files changed, 37 insertions(+), 20 deletions(-)

Applied to ci/master, thanks!
