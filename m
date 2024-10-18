Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06051D30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FCEE88D61;
	Fri, 18 Oct 2024 16:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ItWsXz1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39AA988D5B; Fri, 18 Oct 2024 16:52:05 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F8A88B9E
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-83abc039b25so26271539f.0
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263122; x=1729867922; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QeZ5xZcYTJxUQU9akFH1r8wUSdRzs/OwCeyxfC8zfe0=;
 b=ItWsXz1DXy5/8vL5MPD1RLIseMYLQp8FAqPRXEVWoGCvR7jLkBCAFLz0P7FbA6C0sb
 Bw65BFfI8+afk1AzClfSdNJ+R1WX34+psRBEe6qwi/5h4dzjb+hH4lsUhscnLTL/d/me
 KThnUln/STC/tGxnGjfYlpbPinKF6VgflsRZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263122; x=1729867922;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QeZ5xZcYTJxUQU9akFH1r8wUSdRzs/OwCeyxfC8zfe0=;
 b=JSoOteXMreXhYECCkg+It+kT0CMSz86ts8PRurgY+JmuPAVqYyfSyEBzwm0FMfAnvu
 kwbS93yfkQIRAJCh9T8PddLozfn8qTEzNVH0JF8VE4PmHf63zc2jeN1Nrz3VrA2McfG+
 ew9TsUUgOSR1iSmNs838ZTAv+W+lc8VNGDcEZ288BoSIuZiKQpCl8zPaK12HrYU2JIko
 J8TyzfOjp7y8o9SL8TfYHGmyCcDbo8uxguL4xrTztH8BjYq2nrdnEQPkjp39fZA67sk+
 yXDWU//Zf1U5ysrT1VPP0kwDuRQZiN6wje9rk3H5MBZD2/RCPgL814B8x9yO+FNRUuTh
 w7mg==
X-Gm-Message-State: AOJu0YwpNVA6rJNIbIr6f2UyOiTpVhPO0aZLiVylKM4e3gPK0SrM0Hhl
 j2bjhzwAUnUIu47SVw+Q0vQ1jchQ7/jawy3d0/yRlmjapnYx8qV0o/pOfam+GBqAAjdF3q5Twc4
 =
X-Google-Smtp-Source: AGHT+IFuZeE0qeaTVwKqkyVPH+3l4f3fd/NDMSpnDvDcHXrNWy3PRVtpq2J74YVMxiHnpkkiHyk91Q==
X-Received: by 2002:a05:6602:1686:b0:82a:9cab:9be1 with SMTP id
 ca18e2360f4ac-83aba645f1emr258599439f.12.1729263121624; 
 Fri, 18 Oct 2024 07:52:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5adf1sm450573173.3.2024.10.18.07.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Oct 2024 07:52:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH 0/6] efi: Start to chip away at the EFI workaround
Date: Fri, 18 Oct 2024 08:51:51 -0600
Message-Id: <20241018145157.3918429-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

At present there is a function, efi_set_bootdev(), which is used in
various places to tell the EFI loader which device a file came from.

With bootstd, this information is available in the bootflow.

This little series provides a way for bootstd to provide the bootflow to
the EFI loader, so that it is able to select the correct paths.

For now only the EFI bootmeth is updated.


Simon Glass (6):
  efi: Refactor device and image paths into a function
  efi: Make efi_run_image() static
  efi: Update efi_run_image() to accept image and device path
  efi: Add a version of efi_binary_run() with more parameters
  efi: Move the fallback code from efi_run_image()
  efi: Pass in the require parameters from EFI bootmeth

 boot/bootmeth_efi.c          |  49 +-------
 include/efi_loader.h         |  10 ++
 lib/efi_loader/efi_bootbin.c | 210 ++++++++++++++++++++++++-----------
 3 files changed, 159 insertions(+), 110 deletions(-)

-- 
2.34.1

