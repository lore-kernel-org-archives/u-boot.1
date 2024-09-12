Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41310EE57F9
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 00:58:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE0E88C8F;
	Thu, 12 Sep 2024 02:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Z3NJoWS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2432988CE8; Thu, 12 Sep 2024 02:58:28 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04B0B88A43
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 02:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c34c2a7dc7so2316706d6.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 17:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102705; x=1726707505; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IYfLwzB9pbpPERlMGyYvjTlmrA54ojrpO4UcrVsc9+0=;
 b=Z3NJoWS2q7mfv47iLVWn0GO2Y+3Pg+8hYeNPWJV3HQzDCCoII24fVMBOBM+N48AVZ4
 xoqtrkR0kOaHhBPbENRN3bojSYXBpOlcyXUI3MGH2D4se204M2/YYBPe1XgoDaOFd4mB
 ZiaJvbYdFYuz4qbiG23mkWeHjnIxtKJfsp2W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102705; x=1726707505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IYfLwzB9pbpPERlMGyYvjTlmrA54ojrpO4UcrVsc9+0=;
 b=Bji6yth/MfqvOqDh0X3X9rXzDEJk3bljmHsRIY7rVJ56ZYA/xck3b6ZAQti8fvqc9U
 lCr9kJhvBQXvnys0uiGirZooDd+JUxbC/chsvBmlYkSIVKlpAX+M0qpLTcKhdfQFo+Oj
 uTjlkDTIf/7Rq5jkIC6J/cWoNt3LKTztM5LMEzE43R3k/qTQsnRd/z7Kvf0GjOPLNIl5
 /l6KNMfGBXUHTyexgRrMjrzHGJTCL5LXzM7/J5dwBpuTgSa8YrXNtYY5MaZYh4TRiYVD
 VvHpWEBXqQbN9IOq8pPB85ypnmZVD/1Wuunm4bE7dO9RUs8GVpgT/GzFh1cK4mBW34/s
 phPg==
X-Gm-Message-State: AOJu0YycRU015H1cHgUQ42rfZjm5ZmzUdNG8fJegF0g/oSgxYfz/Pws6
 Uf+e6SHTsSAAl2JOJwQjtVLnmRV+IPMVtA5gTn6lRA0BJfoW/sz9VNuQ+GcR4jJxVJDbZjNXAVT
 RIHXwBqKEOmk8nZzrALed2i5MCqQ6UnbhSf/O
X-Google-Smtp-Source: AGHT+IGQp/Ban+rdHLmuoE1GIKm8Sly780cNVcFpP4Ad6YIX3uOmlTEiYJ19EoNDoFtvgF9EEWFfnCG2f5yCswDGPgc=
X-Received: by 2002:a05:6214:53c1:b0:6c3:5e2f:b43b with SMTP id
 6a1803df08f44-6c573537ea7mr20554736d6.25.1726102704873; Wed, 11 Sep 2024
 17:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-2-patrick.rudolph@9elements.com>
In-Reply-To: <20240911062511.494855-2-patrick.rudolph@9elements.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 18:58:14 -0600
Message-ID: <CAFLszThbkZ74j1CWghM+hBovhABsFvs5XJEYh_JZTNg6+RgWFQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/30] acpi: x86: Move SPCR and DBG2 into common code
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: u-boot@lists.denx.de, Maximilian Brune <maximilian.brune@9elements.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Sept 2024 at 00:25, Patrick Rudolph
<patrick.rudolph@9elements.com> wrote:
>
> From: Maximilian Brune <maximilian.brune@9elements.com>
>
> This moves the SPCR and DBG2 table generation into common code, so that
> they can be used by architectures other than x86.
>
> Signed-off-by: Maximilian Brune <maximilian.brune@9elements.com>
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> ---
> Changelog v2:
> - Do not add new features, just move code and make it compile on 64bit.
>
> ---
>  arch/x86/include/asm/acpi_table.h |  11 --
>  arch/x86/lib/acpi_table.c         | 174 ----------------------------
>  include/acpi/acpi_table.h         |  11 ++
>  lib/acpi/acpi_table.c             | 184 ++++++++++++++++++++++++++++++
>  4 files changed, 195 insertions(+), 185 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
