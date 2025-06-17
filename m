Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A76FC71155
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 06:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B4F8070C;
	Tue, 17 Jun 2025 08:20:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="DMc1uthk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC9908070C; Tue, 17 Jun 2025 08:20:30 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 979CD8070C
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 08:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-042.46.114.pool.telefonica.de
 [46.114.105.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8B0B13F23C; 
 Tue, 17 Jun 2025 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1750141228;
 bh=5dxYIdnsk41rQOOHSCoyhV9uAu6V4ZrLrxcr+B3oD4c=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=DMc1uthkAZueDjRa7523byfpMVsF2HGhXOYkNZu6x9G58f8+YbJyho54KesedXSJc
 LFMKHtBAiBzi3oW5zLlVV4HOCLG/+mQr1pqXV00dP22Ccw+WMsJ5fF2jQ0mNJlz8w9
 LJ3jsLe3/LPlUrj2bjsAtttkfa+BpOxhHuUEGNC2W3XP0n6wT/i5ZV5hOd73iHPxOB
 +Mt8/1wlJACYptrOBs8BmqwLz02wNYpPlqO+Ozkh8VcMfI05p9NnwKZSisdzb3kpsk
 2BJFu87HMYSo4K832FsIxsHJv7315MnD89EGfcSUsFudoGoJOWbc113j2ql8k1FsJv
 gP5Le3DuL7H3g==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default
Date: Tue, 17 Jun 2025 08:19:43 +0200
Message-ID: <20250617061945.9266-1-heinrich.schuchardt@canonical.com>
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

The sandbox is used for a lot of generic development, we should run the
UEFI tests there, too.

The TPM emulation on the sandbox is incomplete. Disable the TCG test on
sandbox.

v2:
	describe TCG test failure in more detail

Heinrich Schuchardt (2):
  test: disable TCG test on sandbox
  sandbox: enable CONFIG_CMD_BOOTEFI_SELFTEST by default

 arch/Kconfig                       | 1 +
 test/py/tests/test_efi_selftest.py | 1 +
 2 files changed, 2 insertions(+)

-- 
2.48.1

