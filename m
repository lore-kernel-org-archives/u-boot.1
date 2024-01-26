Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 060E0C47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 07:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F347787B8F;
	Fri, 26 Jan 2024 08:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hNdznrKO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1EB87BB6; Fri, 26 Jan 2024 08:54:40 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE6A862DA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 08:54:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 753ED3F201; 
 Fri, 26 Jan 2024 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706255677;
 bh=6fyra/DYIPlVbqPSymcSB7QRKhE/aLicNKQ+Sgkd/qs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=hNdznrKO2kVtWDT5H/4PBZvxNXrPsNqJYbwuz7N1EXrHsc3abVjoUdXkNXuof9Ews
 jh84c+CgLx6siu9da9gyhy7vIqDakEApdNoDNEENzj6v0GPY5P2qGlnyDX0TKgqWNb
 ylwpfOg/HUWvj8YilZ9uiuQe2UYeckT1Hx5eXKIrJo7SCqFN/VJV215BU9c2hY6CsN
 dksfNZ7lwWaO/kchcm80k98NoPEep7k2zpC7FFFJCqz+176Gvg4qMLS5i0V6BabB8H
 jb94KLkDJ/Bzn5HSUYTbvZBdBrcxwONipokcf+IQPbQ5845uSkmHmMH5WuuwqlS58p
 PFpSRIcTcQNFQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Masahisa Kojima <masahisa.kojima@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] efi_loader: export efi_get_configuration_table
Date: Fri, 26 Jan 2024 08:54:29 +0100
Message-ID: <20240126075431.22876-1-heinrich.schuchardt@canonical.com>
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

In multiple places we need a function to find an EFI configuration table.
Rename get_config_table() to efi_get_configuration_table() and export it.

Use the new function for the 'efidebug capsule esrt' command.

Due a pending change find_smbios_table() shall be replaced separately.

Heinrich Schuchardt (2):
  efi_loader: export efi_get_configuration_table
  cmd: in do_efi_capsule_esrt use efi_get_configuration_table

 cmd/efidebug.c              | 7 ++-----
 include/efi_loader.h        | 2 ++
 lib/efi_loader/efi_helper.c | 6 +++---
 3 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.43.0

