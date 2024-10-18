Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE496D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:18:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EF0889099;
	Fri, 18 Oct 2024 03:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UeUr/x9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361688911E; Fri, 18 Oct 2024 03:18:46 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CAA088BB2
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8B3F23F1C5; 
 Fri, 18 Oct 2024 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729214322;
 bh=bbvkrmuIGoJ77LUaZ4A/cg1bKVNjUz4Hww6n/Gte7zA=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UeUr/x9InAGrfU+vqkXLOl9oWoQ24VtaIDfaGJ0O1Y1hKysJ3i7dgAe5+jYT6UF9z
 ZvQmIgSZYZrlTpx9xZDlY5PpqsofBddz7A2XybK6zt31QDYSr9RWrUxCzkWNJGuexP
 7SIPbIRnN7/ceyzVTtbB6co2h9qB5v3uxDUjiogi3+VtjpzH7JGXc5rRwL9oL2Qoby
 zrN/D+9XYf1QSxi3DPaMsfoPXpEm/PszrrjHA7gHRqEQa4dFgo/2bmWQVYHwP+mPqa
 B+4Cdz+axBnOH1wMQJ2jBo2T11FSZF6asQZXIPQMqwmXX6sYiwCCW9tEOw2vb/tReJ
 aA9T9vDEMYTbQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 0/2] sandbox: add bootmethod EFI boot-manager
Date: Fri, 18 Oct 2024 03:18:35 +0200
Message-ID: <20241018011837.126813-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The EFI boot-manager is the default method to boot EFI binaries.
We should be able to use it on the Sandbox.

* Enable EFI boot-manager bootmethod on the sandbox.
* Adjust unit tests to reflect the additional boot method.
* Reduce the noisyness of the EFI sub-system if not ESP is available.

v2:
	Reduce the number of messages if there is no ESP to persist
	variables.

Heinrich Schuchardt (2):
  efi_loader: reduce noisiness if ESP is missing
  sandbox: add bootmethod EFI boot-manager

 arch/sandbox/dts/test.dts     |  4 ++++
 lib/efi_loader/efi_var_file.c | 22 ++++++++++++++--------
 test/boot/bootmeth.c          | 28 +++++++++++++++++-----------
 3 files changed, 35 insertions(+), 19 deletions(-)

-- 
2.45.2

