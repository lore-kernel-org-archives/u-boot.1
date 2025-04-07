Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF4DC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 06:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4BB182CAE;
	Mon,  7 Apr 2025 08:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HVBpnBHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A16C82CA4; Mon,  7 Apr 2025 08:44:33 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A77682C55
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 08:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-108-136.46.114.pool.telefonica.de
 [46.114.108.136])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CB7483FF29; 
 Mon,  7 Apr 2025 06:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1744008270;
 bh=Ch6ahOQ9nz/ZSVdZJGjT4OrODe79/AAGhQuvIHxZUio=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HVBpnBHmLyBrssf5zJ5FyG/K+zN7oCXlCSwS4dif4GQU+R16jn1YmmUQGT02eDz70
 cPC77kZzO8i6kSXc4rRTMUlews7/+sa+knMo0qEIQDCgDIciUDVklsrq2qv6/0Pu+z
 q22Embt3L3pixo/nIU42s1UExoSHnFyjM9hzugvEeqdUY5tw621I+2N9dWUmsGW2wZ
 hKyOaXk/GGPQN5vnyhZClB67FyU7V2sGP4YOrmaxAQ59Ok8S6kU/GRLyqn2gg1bjOF
 5yV8rPzK29rSyASe4cFUuBUAAOC2RQ5/mBp1n133NCsDlc01JfA/orK3zkHcypEklO
 6RBd36w4RprlQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] acpi,smbios: select CONFIG_BLOBLIST
Date: Mon,  7 Apr 2025 08:44:22 +0200
Message-ID: <20250407064424.71541-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
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

Since commit 53d5a221632e ("emulation: Use bloblist to hold tables")
`make qemu-riscv64_smode_defconfig acpi.config` fails.

We need to enable CONFIG_BLOBLIST.

Heinrich Schuchardt (2):
  acpi: select CONFIG_BLOBLIST
  smbios: select CONFIG_BLOBLIST

 drivers/misc/Kconfig | 1 +
 lib/Kconfig          | 1 +
 2 files changed, 2 insertions(+)

-- 
2.48.1

