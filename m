Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959EDC46CD4
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 07:40:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E0C487718;
	Wed, 27 Dec 2023 08:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U0JAau4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453B987823; Wed, 27 Dec 2023 08:40:48 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C67E8760D
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 08:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3367f8f8cb0so5097434f8f.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703662845; x=1704267645; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HO3kPr8FCv4wdOIJP1nU0p/eSyZfl34iKrJsGSYo4XQ=;
 b=U0JAau4R5CyvwfK0nyTLpDXlP0C9L2aNUWJCVSRtFe7A15ib2PxVqUrGXkVv2pCvpO
 jnEOqsvFQii4tnzKpTw8cBOIBtP62f4QNteFgQ/eyLkDkanCraNrU35RbNjmPik9St8o
 n/6pwGIAzmjquPaim+YNCzCDbpO2y5K0sfNi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703662845; x=1704267645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HO3kPr8FCv4wdOIJP1nU0p/eSyZfl34iKrJsGSYo4XQ=;
 b=lqIWIBvJAh+7Hww4didKCx4eWCjRvxqxdntNclx8dzZNTHSGN5TivV/81wKNagKUh2
 HXiE4/5Qt0ysW79oSbkgRxPRoA2g5Nq9mcqRowIJBMNq6ZD42iKlxwlYtkjXwpw4DiIq
 Uu9SLgEadzTyBRKppcIXH+0NzgEdtGY9ShgGEmczdiR1fJiowekIvcCvJ8WdtsjWec/o
 F/gli1K/hykrdf6cLCykv3Wx7B1wMf9khHK3nj2AWKNaWh4sl9BjLJGXm/71EVWr1aHC
 xv/BIdOu8XC2gctBM1awpAAeR7p9nRT61KKsj5/IkchmZVhj4KOAdFY+A8dUCUjW6HP4
 WDfg==
X-Gm-Message-State: AOJu0YxorzwCC6xThdjrjxnNUaKcdygXPorz9XipfcEVc/I6PezxFIF4
 RhCTIDT/7k2dz55hJ6XJZ3c1jvb2mQ5S4JD2B7bnZxlD+uZQ
X-Google-Smtp-Source: AGHT+IF5/Tr1AxTxYYuUxa1B0vOl95XvLnLclGqjd7ifazvcTYKHcl+zKsO7G8vFFKLrW8XnY2BCfQ==
X-Received: by 2002:adf:e743:0:b0:336:4fe5:6068 with SMTP id
 c3-20020adfe743000000b003364fe56068mr4951413wrn.137.1703662845222; 
 Tue, 26 Dec 2023 23:40:45 -0800 (PST)
Received: from tasman.chapterst.org (80-42-48-87.dynamic.dsl.as9105.com.
 [80.42.48.87]) by smtp.gmail.com with ESMTPSA id
 s23-20020adf9797000000b00336813bb588sm14314426wrb.111.2023.12.26.23.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:40:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Nikhil M Jain <n-jain1@ti.com>, Peter Robinson <pbrobinson@gmail.com>,
 Troy Kisky <troykiskyboundary@gmail.com>
Subject: [PATCH v4 0/7] smbios: Deal with tables beyond 4GB
Date: Wed, 27 Dec 2023 07:40:17 +0000
Message-Id: <20231227074025.2178825-1-sjg@chromium.org>
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

When the malloc() region extends beyond 4GB on ARM we may end up with
an SMBIOS table in that region.

Add support for writing an SMBIOS3 table, which supports a 64-bit
address.

Note that this problem does not happen on x86 since it requires the
tables to be placed just below 1MB in memory, unless
CONFIG_BLOBLIST_TABLES is enabled.


Changes in v4:
- Bring in this patch from Heinrich's series
- Check the start of the table rather than the end

Changes in v2:
- Check the end of the table rather than the start.
- Add a new patch to correct gd_smbios_start()
- Add a note about why unmap_system() is called

Heinrich Schuchardt (1):
  smbios: SMBIOS 3.0 (64-bit) Entry Point structure

Simon Glass (6):
  smbios: Refactor 32-bit code into an else statement
  smbios: Move the rest of the SMBIOS2 code
  smbios: Use SMBIOS 3.0 to support an address above 4GB
  smbios: Correct gd_smbios_start()
  efi: Use the correct GUID for the SMBIOS table
  smbios: Require the caller to align the SMBIOS table

 include/asm-generic/global_data.h |  2 +-
 include/efi_api.h                 |  4 ++
 include/smbios.h                  | 37 ++++++++++++--
 lib/efi_loader/efi_smbios.c       | 14 +++--
 lib/smbios.c                      | 85 +++++++++++++++++++------------
 5 files changed, 101 insertions(+), 41 deletions(-)

-- 
2.34.1

