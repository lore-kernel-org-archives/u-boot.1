Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04EDE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE8F280516;
	Fri, 20 Dec 2024 05:06:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q9xS3XAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD9980516; Fri, 20 Dec 2024 05:06:26 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9085C80581
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d3d479b1e6so1920943a12.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667584; x=1735272384; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Mg55FBoqWGwPNScztBi80Bhbbi43gSCcOOyeT+PemkU=;
 b=Q9xS3XANeqt8YN86ZXyE3uN+LTGbA/PfHYX8ScbkgrGprNqWyoavi0suX0RlYwYujw
 KsQJ6JvcoJ2NCG0qFHkegj0hDoTvMUmxVIgDy+O6HVCh0buvnCVmymcLi2SdAUqdnSkl
 b0/B10MdH54yVG4Lz13+lUB9z8aafjKV/LZ5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667584; x=1735272384;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mg55FBoqWGwPNScztBi80Bhbbi43gSCcOOyeT+PemkU=;
 b=vAUJ/nbbsWCeqkYhqMzCH9U1ksteowf1dJJAFoOOWmEHicurvbXRnSS7EUjdsYQOs/
 PyU7PVtU92noWnasok0nPhUAAlK82ljlKFWxfS8c7NjYBab28iC16g53Y7frsF7Cpfke
 GWQcPD9i+rkl27m2CjT/PyDjWjTWyuwqffWWsLrKsR8mA2/Nb/uZI+Kl1KSgfmj9+tl+
 Go/BzNKO1xNSgEmV92L6kC6BPlzyYktG9nAhNry0oHR5SLGlx7aAKQilB7ioGqp++Rxx
 BTLVkgWskenH0DilGkJ01LG7wzQxFLEK2WT3nW2i27C79si3g69UNt2+ITodzt7fdzeD
 7Npw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlFDTjGHCWIcCpTEIj4i7r4IaTme5Csyhd0+Nw/azBGdB/EjkRbAwckDxJIIko3Kt24+mooes=@lists.denx.de
X-Gm-Message-State: AOJu0YzS3qyyNIz2FHytRCeMk7y88is1PoHJZDkq0xFr3W45gSRl9R/O
 Do3rm3YX5k1vFx+20yqvB1NHGcwQi6Rj4dpZnO/vL3O/6qNmVyiJVKxWM7yUp3sKojZbwo6zwN3
 HdGX5hl1gaClTLMiLGZFUXnSZk7pJprIaecGL
X-Gm-Gg: ASbGnctEwGShtLO2711cmDBios7IwTbINq050AzKsETxsrAh2SRMgm9ipPe2AyBhc6+
 WyrfUT9C/jelSlg+gnM1UGjYsHb+NkCjsAfIL8tA=
X-Google-Smtp-Source: AGHT+IHxhGbInhr7ZrSDlndq0k8qGYUYEzuyCJBN8NxV0+qXAYYyG+iEtF60YPqC4Q7KGogxl/guRFUYqDLZPMYGD58=
X-Received: by 2002:a05:6402:5245:b0:5d3:ba42:e9fa with SMTP id
 4fb4d7f45d1cf-5d81ddc01a0mr2789977a12.16.1734667584062; Thu, 19 Dec 2024
 20:06:24 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 22:06:23 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-16-sjg@chromium.org>
References: <20241206023626.2456858-16-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 22:06:23 -0600
X-Google-Sender-Auth: APc4N7uHiGLzBZGC1b_7cvMy_7c
Message-ID: <CAFLszThy8eQF_9+xN=h_hJX5osgkML7iyA5UhAiwTcDiuuZBNQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/46] boot: arm: riscv: sandbox: Add a format for the
 booti file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>, 
 Rick Chen <rick@andestech.com>, Roman Stratiienko <r.stratiienko@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Arm invented a new format for arm64 and something similar is also used
with RISC-V. Add this to the list of supported formats and provide a way
for the format to be detected on both architectures.

Update the genimg_get_format() function to support this.

Fix up switch() statements which don't currently mention this format.
Booti does not support a ramdisk, so this can be ignored.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Add new patch to add a format for the booti file

 arch/arm/lib/image.c     | 9 ++++++++-
 arch/riscv/lib/image.c   | 9 ++++++++-
 arch/sandbox/lib/bootm.c | 5 +++++
 boot/image-board.c       | 5 +++++
 include/image.h          | 9 +++++++++
 5 files changed, 35 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
