Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE848C47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:20:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169D087ABA;
	Mon,  8 Jan 2024 01:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R/Yt+QxC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8AC587A89; Mon,  8 Jan 2024 01:16:38 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5831587AB3
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-680fdf7d52fso9106996d6.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672992; x=1705277792; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e/TclRv1S9ddxfrj2hqSMzH7jRGaU4pwjoJlxDmDNtY=;
 b=R/Yt+QxCsWXspvJ1Z0Z6S1HnPv36UQu/NKjcP3bGUsVioyc+JbBALawREkuKbheO/e
 Z1Jc2SNPXLghgC/p3StwMmktdCT4x/qHzdJvX06fZojVzrynZ9LX3tLKy0OfnKm+At/m
 Yx3ebcD4jU02PYX9LdCBF7QMjXcXZaJYSWcWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672992; x=1705277792;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/TclRv1S9ddxfrj2hqSMzH7jRGaU4pwjoJlxDmDNtY=;
 b=t0wCDWFmdOHLIRvI+mc5PGeTOuy7GfrmDB9d5vm72nlRbWVio8w/t2nbHaDJz8IP0j
 gnlsePK9lWFzuINmpmkUDRlrK+LI2/uFlIxtwIum4n1KN9pLzQDnQmIwErZg1jcLwXQE
 KV/88cBGk0LMxN/FvZev10Y4YnaqXoGlD7kCJKDDuPxrtD2in6iouxkNaV4JVs6Ix3aD
 1nU8il3UvA44CE8ouII9LBiaoUTuBnwFh39nUJ994M5WXYRX4DcPKM8nNaixWr8e18RS
 P8R+wVY7OeDzqPCux1j1jwY/sm2TlG2zXIelfG0q49Lq2gumxNVwKUB9Odzo4IeQeki4
 5RtQ==
X-Gm-Message-State: AOJu0YxBXv86XGONB/1it86uNGtJohEbXPOZhXBqANbDaXEvyqmb2jMz
 W5Is8XjedUOFve9A66GkzXtX1uBtHGDozTtwa11zu720ucOJ
X-Google-Smtp-Source: AGHT+IHQ0VTqO2nqjdyjfEu1zkzLuG3oAG2Jayb98eqPfdFvEc7ttmnPXHT8ulJ3Tccp75SPADMYSTvFVWFyMQTGXP8=
X-Received: by 2002:a05:6214:4019:b0:680:cfb0:e492 with SMTP id
 kd25-20020a056214401900b00680cfb0e492mr4921551qvb.50.1704672992770; Sun, 07
 Jan 2024 16:16:32 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:32 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231219150408.10949-2-heinrich.schuchardt@canonical.com>
References: <20231219150408.10949-2-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:32 -0600
X-Google-Sender-Auth: ShliIa-iQPrxGL801hTP8HW9JHc
Message-ID: <CAFLszTj1Rw-Fo68f+TVdjLc=fGa1rLupjryien-8qyZoCZOjDg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] acpi: Kconfig symbol CONFIG_QFW_ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
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

We have two implementations of write_acpi_tables(). One for writing ACPI
tables based on ACPI_WRITER() entries another based on copying tables from
QEMU.

Create a symbol CONFIG_QFW_ACPI that signifies copying ACPI tables from
QEMU and use it consistently.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
v4:
	no change
v3:
	no change
v2:
	no change
---
 drivers/misc/Kconfig   | 7 +++++++
 drivers/misc/qfw.c     | 4 ++--
 lib/acpi/Makefile      | 2 +-
 lib/acpi/acpi_writer.c | 4 ++--
 4 files changed, 12 insertions(+), 5 deletions(-)

Applied to u-boot-dm/next, thanks!
