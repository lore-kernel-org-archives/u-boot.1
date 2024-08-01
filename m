Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E53C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 17:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19A5088B43;
	Thu,  1 Aug 2024 19:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CHJGszJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D6CC88B3A; Thu,  1 Aug 2024 19:36:56 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F296188B17
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 19:36:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8036ce66164so285564639f.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722533812; x=1723138612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EHR1vzu7qyO2HQhtNLm567j2UBivtkIIKWo+dEI1yL4=;
 b=CHJGszJdsxNUfx+PRtY4EsaS2yBv+BYHrrUkKIJcF9gKZ7GQ1kod7PFSxXTQzDLHCv
 l9+x+rXw+0C/jLm15SBEFmzncplUohrS9pZyY1hCSV62F6ZwBArS1dtIUCZt9/YPZEDI
 85/hnxt8GdNn4NZWuuckRtVYyQ6vlX5vt2WFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722533812; x=1723138612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHR1vzu7qyO2HQhtNLm567j2UBivtkIIKWo+dEI1yL4=;
 b=gbCgDWA4YBE7q9RBOBNbbgLAIhzr8kwZ2GbBjgWE/0SBC80tPUGsLyEL6zCXP1qgZA
 mxX2jlWMk5Q3MEZizqBKh5gX7YgwpnuMzxJKV4cVyWLucoSiNCYsvqnHn6QT5W6y5wG5
 Y0diu70yXq/XfjW5OFbcbBp8Mk/wIjJKcmiB1AUE5CWB0cmhLMIZQKVNnE8XcJ8rDsFB
 BLgSow3AbjoeP4IGXU4USWCzO7R+IjKBdmZ//RRUNtUBv4nIGP3OMWShCrkr4AW1sEIY
 BZBR6bBO9dyy/IPfhvbk2+m5h5hYl77iVaZ7oIZnw1v/vCkkNsGqqGT0bPq8aQMq2IxX
 rHNA==
X-Gm-Message-State: AOJu0YxGIFbqg7xIAojwxKqYETL4llNJBlaz61u1mtbanqaYLUn39OTu
 OxGDCMJc/vAgmYa/W1Yb48FiU9Sm4XavTTO9WHFjS3Bs9EtV4ay4AvydYDQ8lwqFApbji8+Nj9U
 =
X-Google-Smtp-Source: AGHT+IFZFZXMisXvgp4gKyUE7A4PlTt8FPRaHUyEZs3c535U7U8YxYNhYyMvE8jvUXGwZSIQYT9dCw==
X-Received: by 2002:a05:6602:1509:b0:7f6:8636:f89d with SMTP id
 ca18e2360f4ac-81fd4348a4dmr120818939f.3.1722533812444; 
 Thu, 01 Aug 2024 10:36:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d6987f30sm27671173.6.2024.08.01.10.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 10:36:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/3] efi: Start tidying up memory management
Date: Thu,  1 Aug 2024 11:36:34 -0600
Message-Id: <20240801173637.1071068-1-sjg@chromium.org>
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

We have been discussing the state of EFI memory management for some
years so I thought it might be best to send a short series showing some
of the issues we have talked about.

This one just deals with memory allocation. It updates EFI to use
U-Boot memory allocation for the pool where possible. Most functions use
that anyway and it is much more efficient. It also avoids allocating
things 'in space' in conflict with the loaded images.

For v2 I have dropped patches which are not germane to the main idea.

Note that this series is independent from Sugosh's lmb series[1],
although I believe it will point the way to simplifying some of the
later patches in that series.

Overall, some issues which should be resolved in future are:
- allocation inconsistency, e.g. efi_add_protocol() uses malloc() but
  efi_dp_dup() does not (this series makes a start)
- change efi_bl_init() to register events later, when the devices are
  actually used
- rather than efi_set_bootdev(), provide a bootstd way to take note of
  the device images came from and allow EFI to query that when needed
- EFI_LOADER_BOUNCE_BUFFER - can use U-Boot bounce buffers?

Minor questions on my mind:
- is unaligned access useful? Is there a performance penalty?
- API confusion about whether something is an address or a pointer

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=416441

Changes in v2:
- Drop patch 'Show more information in efi index'
- Drop patch 'Avoid pool allocation in efi_get_memory_map_alloc()'
- Add the word 'warning', use log_warning() and show the end address
- Reorder patches a little

Simon Glass (3):
  efi: Allow use of malloc() for the EFI pool
  efi: Convert device_path allocation to use malloc()
  efi: Show the location of the bounce buffer

 common/dlmalloc.c                        |   7 ++
 include/efi_loader.h                     |  18 ++++
 include/malloc.h                         |   7 ++
 lib/efi_loader/efi_bootbin.c             |  11 +++
 lib/efi_loader/efi_device_path.c         |  43 +++++----
 lib/efi_loader/efi_device_path_to_text.c |   2 +-
 lib/efi_loader/efi_memory.c              | 110 +++++++++++++++++------
 7 files changed, 148 insertions(+), 50 deletions(-)

-- 
2.34.1

