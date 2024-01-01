Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4641AC47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 18:50:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3575F871AA;
	Mon,  1 Jan 2024 19:50:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n8VVvMol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBBC287809; Mon,  1 Jan 2024 19:50:17 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77950871AA
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 19:50:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8E3483F276; 
 Mon,  1 Jan 2024 18:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1704135014;
 bh=q+OutiUEGKLZUIC+lfXq/m5Cwx5TUBW7q7+rzeWTVko=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=n8VVvMol6dByDN3SXvpRCD/l7llYeJbJXwm9x2RDE//3mPo54L4vuavzkmGFOCf4K
 1r0LySCHwrTiS/RJ03sCLa2D8vu3TqGE3Uktw/8y4Y1xzXncpntbctvVfnS7KyvT4C
 uQg9wkKdDVyftAAk7B1WOIaCa92apqk9aKgakaspwo8SYbL0H6KiTZjm4TlBT2qLns
 YsUi18fTLGTSh1sOgwgmySRZGvBtoutg514vlRud91yIQe50tUT/wScJaXhwp4mXpx
 WqOrF/blI25BfRoh5is2Nf2zaQjYP6rsiEH0+PWU0D3TIUwd562QUM+PkgIaMOTD9a
 fZDKRs0nLWX0A==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 9/2] efi_loader: provide tool to dump SMBIOS table
Date: Mon,  1 Jan 2024 19:50:02 +0100
Message-ID: <20240101185004.268790-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

An EFI binary dmidump.efi is provided that can be used to check the SMBIOS
table for consistency and to dump it as a file.

As a prerequisite remove superfluous include from smbios.h.

v2:
	remove dm/ofnode.h from smbios.h
	fix a wrong variable usage on dmidump.efi

Heinrich Schuchardt (2):
  smbios: smbios.h should not import ofnode.h
  efi_loader: provide tool to dump SMBIOS table

 include/smbios.h            |   6 +-
 lib/efi_loader/Makefile     |   7 +
 lib/efi_loader/dmidump.c    | 595 ++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_smbios.c |   3 +
 lib/smbios-parser.c         |   3 +
 5 files changed, 609 insertions(+), 5 deletions(-)
 create mode 100644 lib/efi_loader/dmidump.c

-- 
2.43.0

