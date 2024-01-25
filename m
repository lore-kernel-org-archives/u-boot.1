Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E168BC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 08:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DDD86F67;
	Thu, 25 Jan 2024 09:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="NQQLvOEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7438870D9; Thu, 25 Jan 2024 09:38:28 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCC786BFA
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 09:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from localhost.localdomain
 (ip-178-202-040-247.um47.pools.vodafone-ip.de [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D5B1E3F2FE; 
 Thu, 25 Jan 2024 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1706171906;
 bh=1eoQW151l34sRKf7wF+saJkyuE7peWwkV8QbQtwxRhg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=NQQLvOEGkJTn2srnQgfuvWGYb1lPCwCRfPCIFLGsnq9cc3VNgDDSOYfj66EMB5U+x
 qbh4IjXuG2pf1UdVOdj1jd9wypnmBkMJFvzoo5hpxsoTy4IYl0gZfGbDinHXyD2/1K
 xvwLujIOoxM3J8iLiOfZmADMppXroYcqz8aqu2CEwAHOTjoHYz17l6UO8k2dZGFG5a
 tb7cG+MVrOj/cs3rBioIfGPGf0VNJxgRmjEu58PONyHi8XXhb4RUc8aYcdcw/9QWhR
 v6T11q48YwjL/vrH0VdMsMjrhN3c+DFZyCxr/NIji2kVPogHD2HY7DDhVswTmxLQyg
 DZ9V6y7O3FOPg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/3] riscv: separate .data and .text sections of EFI
 binaries
Date: Thu, 25 Jan 2024 09:38:12 +0100
Message-ID: <20240125083815.12623-1-heinrich.schuchardt@canonical.com>
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

EFI binaries should not contain sections that are both writable and
executable. Separate the RX .text section from the RW .data section

Fix conflicting SPDX license information in linker scripts introduced by
commit 7215787c4ea4 ("SPDX: Convert single license tags to Linux Kernel
style").

Change the alignment of the relocation code in EFI binaries to match page
boundaries.

v2:
	split patches

Heinrich Schuchardt (3):
  riscv: conflicting SPDX license linker scripts
  riscv: page align EFI binary section
  riscv: separate .data and .text sections of EFI binaries

 arch/riscv/lib/crt0_riscv_efi.S    | 39 ++++++++++++++++++++++--------
 arch/riscv/lib/elf_riscv32_efi.lds | 26 ++++++++++++--------
 arch/riscv/lib/elf_riscv64_efi.lds | 26 ++++++++++++--------
 3 files changed, 61 insertions(+), 30 deletions(-)

-- 
2.43.0

