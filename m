Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B43C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 15:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B1A588604;
	Mon, 10 Jun 2024 17:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gk7KS0XD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B7CA885F5; Mon, 10 Jun 2024 17:03:22 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE520885A5
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-704261a1f67so13539b3a.3
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718031797; x=1718636597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kftKIx5MfVqfeR4p+15axhOLKM6CPGgSz/TV1TLhCyk=;
 b=Gk7KS0XD7PawXja+xQTtGqm/Gnqq5bg8Wy+WoqEswwAuMJcDt7Rn56g94WvLBIEUk1
 1Qwlmk+N2HexNHVZFtMb3NcyA6bhO4usyIAfEU4yxGgDLJ4eUeJAy8Ir1thIZbSbRiY2
 SKR0CJVUeAIIMG/DixPu/YfrvPbQ7Am5oLDYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031797; x=1718636597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kftKIx5MfVqfeR4p+15axhOLKM6CPGgSz/TV1TLhCyk=;
 b=ZoKScioFFT6Dpj9pzXNFmR2Z+PZISB8fGvKkuatKPyIWKMe6+tISqEqlXLMklCAPxP
 0iFfWTbCTFrmx+FocFdmxLguDS02NinI9+ApyieQ3ZS4w6JlGypctIkY6M4daYi1aLia
 rmdLqmeel8vdhVqAwDZFcHwWIklyRinNgHNP7p/0WSllQbE8w8h5NP0DFGF+dd3Gk1eb
 ULphZuL2CDU2WM5X8OpUy+Gd8KTaNGwrILtpIfs3Z24M5UOIT8RcEABz6zSa5rxFZwNP
 AoK4R/G8n/uX7ltn83O2JKMQXmmbT7ttqWrvC8CbOSDvpxn+3yskD+mH0pWE2E1aDz5A
 biag==
X-Gm-Message-State: AOJu0YzVuqtOMIxohO00TWuUf+X6sxMKTzFdo0OSVNuqM/fMfU4eSRhi
 SXFKRg0EF9qZtNq9qdomlvHYLPdkcRaNmwwQM2P1Sgo7ZKaiDZnY0K7RTPoPZQRCdsoAYnOIBLT
 iVO/Q7h4lsu+7XsdB+8GIcCw/KQ4125gN/GMJ
X-Google-Smtp-Source: AGHT+IFKewLpsVUzt1/no6xkPYoDQwdCFl+cGPAaWdNS13CKo6+oFPgemrZmdm906SHgxIR3exOpDu1fsPzv1gdovuU=
X-Received: by 2002:a05:6a21:190:b0:1b5:d36a:5d6e with SMTP id
 adf61e73a8af0-1b5d36a5e69mr4904282637.43.1718031797312; Mon, 10 Jun 2024
 08:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1714138688.git.michal.simek@amd.com>
 <7a3722af00af013e4a76f3b086c08db50d155fa1.1714138688.git.michal.simek@amd.com>
In-Reply-To: <7a3722af00af013e4a76f3b086c08db50d155fa1.1714138688.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Jun 2024 09:03:04 -0600
Message-ID: <CAFLszTiEe9xWPqs4p1xtV1omcW05Y=ZqfNc3_Y_1Jtbw43NH3A@mail.gmail.com>
Subject: Re: [PATCH 3/3] lib: smbios: Detect system properties via SYSINFO IDs
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
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

On Fri, 26 Apr 2024 at 07:38, Michal Simek <michal.simek@amd.com> wrote:
>
> Code is pretty much supports only DT properties and completely ignore
> information coming from sysinfo driver.
> Code is calling smbios_add_prop() which calls with
> smbios_add_prop_si(SYSINFO_ID_NONE). But SYSINFO_ID_NONE can't
> differentiate different entries from sysinfo driver.
> That's why introduce separate SYSINFO macros which can be used in sysinfo
> driver and passed to smbios structure.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  include/sysinfo.h |  9 +++++++++
>  lib/smbios.c      | 34 ++++++++++++++++++++++++++--------
>  2 files changed, 35 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
