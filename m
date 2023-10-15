Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49649CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0154786F33;
	Sun, 15 Oct 2023 08:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bx4SJX1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB2FD86AB9; Sun, 15 Oct 2023 08:37:37 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7DD86DCA
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79fca042ec0so141068139f.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697351737; x=1697956537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xvPnhw8/B7EuefusWVqKLfTDwHYu83aFRJnlir6ba8c=;
 b=Bx4SJX1u8zwg+N6jckOVZciwTBJq0LS/2zxRXJEybD8NoiczivbJVSvCE8z3RohjTR
 +Zcme1rU+0BpASUFv+OnMNYB1BLMBxcd4r0AkzOKRstodDKhhAPg1bMeJBMQtP/HILPo
 VwxRSCS4VGlQVg6WDrclFDtnao+fIEOXnTZhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697351737; x=1697956537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xvPnhw8/B7EuefusWVqKLfTDwHYu83aFRJnlir6ba8c=;
 b=ALln4hf7Xj/KDhnY4ebV7cn1Ne4dN0koJSbS4oyY+NyghjVbdj4RGO9q+zsNvzWN8x
 SetUYiRXXAD22LcAWR7z5PZF9dxZ3H5csnPG1+FKiXWUhGbbBGUKAwaDkDvY3LEB2kVi
 ZY3vJIg3vswJHIX6EzvZuBGqT9sP2iyaeqtgFlu8T2X7hPWM5VkIFDastPRwJpXYwW3q
 RGtuwh4q7gRu+bu3yIWiMXNf01XyNA/1lAVJeYCs9PtdJpHguDdLXMMmZCZ6PBbndR07
 idVpyKyVRlVDCGFbfc0o2rneuQPtMWrblXyt9GWUlicoqnAsQTxXNb1QGR5hm+7SuQDG
 +etw==
X-Gm-Message-State: AOJu0Yw07Sfvw3mAs1126c+M3JCceNvORVye6xEleexxUEZx/xm/RKCM
 eDc+HMLR4rwv9ABlSyl8w5MUPZvFSZEXmnePW5Kg9w==
X-Google-Smtp-Source: AGHT+IHhhUajNN9+HtWi5rUwBflFbuTNLSr0DMhh8fV2UxEqETZgB6cEk9li45M4GHCYeO6WhIAkJw==
X-Received: by 2002:a05:6e02:1107:b0:34d:f0b9:97ff with SMTP id
 u7-20020a056e02110700b0034df0b997ffmr27315629ilk.5.1697337914412; 
 Sat, 14 Oct 2023 19:45:14 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a92cd46000000b003497ced3fa1sm2462842ilq.29.2023.10.14.19.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 19:45:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Stefan Roese <sr@denx.de>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v2 0/6] smbios: Deal with tables beyond 4GB
Date: Sat, 14 Oct 2023 20:45:02 -0600
Message-ID: <20231015024511.3995580-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
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

When the malloc() region extends beyond 4GB on ARM we may end up with
an SMBIOS table in that region.

Add support for writing an SMBIOS3 table, which supports a 64-bit
address.

Note that this problem does not happen on x86 since it requires the
tables to be placed just below 1MB in memory, unless
CONFIG_BLOBLIST_TABLES is enabled.


Changes in v2:
- Check the end of the table rather than the start.
- Add a new patch to correct gd_smbios_start()
- Add a note about why unmap_system() is called

Simon Glass (6):
  smbios: Refactor 32-bit code into an else statement
  smbios: Move the rest of the SMBIOS2 code
  smbios: Use SMBIOS 3.0 to support an address above 4GB
  smbios: Correct gd_smbios_start()
  efi: Use the correct GUID for the SMBIOS table
  smbios: Require the caller to align the SMBIOS table

 include/asm-generic/global_data.h |  2 +-
 include/efi_api.h                 |  4 ++
 include/smbios.h                  | 27 +++++++++--
 lib/efi_loader/efi_smbios.c       | 14 ++++--
 lib/smbios.c                      | 79 ++++++++++++++++++-------------
 5 files changed, 85 insertions(+), 41 deletions(-)

-- 
2.42.0.655.g421f12c284-goog

