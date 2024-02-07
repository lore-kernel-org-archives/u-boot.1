Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B62C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 17:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0CE587C4C;
	Wed,  7 Feb 2024 18:19:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qOSydX3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF4C87CED; Wed,  7 Feb 2024 18:19:29 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC30A87CFA
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 18:19:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 8DC7CCE1A8D;
 Wed,  7 Feb 2024 17:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFB35C433F1;
 Wed,  7 Feb 2024 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707326363;
 bh=/fS0bsXE9PBV5gTFm3ibliWw9oyVb2Wx4OmS5rN/YT4=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=qOSydX3aV3ynT7t8PAtQ5N/XAJxxS9rNpdz31NnKA3zDqIf6JcFQb8JPzQGA01S3c
 rOct84IgmxnI9IhDvbeBmUzSlCa5wichfVk2lhlVuOVlJsKxIArRe+s1pwyRWSxRbT
 UqHHtdfV0ZWBRN2OxRCK0WEyCZoGhyDGZDjxK5dWPL4Zf1RTHTuEndnZR0rZfA3PyH
 Qj8pS1IeiCeySEkzG3Y448qyBpvekkHWoC+oddnU2kZbPZJkmkeqHDJqutr87c0Rq4
 wqH0MJ8H6C1NxDM2Bp2n8/t9UbbeSk8gXbZkshSf/BRvOa0WvkHvCAI69e9pc6Jqwk
 YIkQRFS33nHzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AC5FCC4828F;
 Wed,  7 Feb 2024 17:19:23 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Subject: [PATCH v2 0/3] usb: ehci-generic: setup a bulk of phy when
 possible
Date: Thu, 08 Feb 2024 01:19:19 +0800
Message-Id: <20240208-ehci-v2-0-6bf084b7ffac@outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJe7w2UC/13MSw7CIBSF4a00dyzmQitNHbkP0wGvyo1aGqhE0
 7B3sUOH/8nJt0FykVyCc7NBdJkShbmGODRgvJpvjpGtDQJFhwI5c94Qk6ZVqrdDP7QC6nWJbqL
 3zlzH2p7SGuJnVzP/rX9A5gyZ1ieURuMkO3sJr/URwv1owhPGUsoXcRjmYpoAAAA=
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707326360; l=1101;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=/fS0bsXE9PBV5gTFm3ibliWw9oyVb2Wx4OmS5rN/YT4=;
 b=vkj11UBLtpollvoGwe7fsoKrlcNdwAm/D4KHcUbUMUH7ZHdRGe68avgsiqcqH4ln+jOnZhxyv
 RA2nxF45+PqA1FUfljNsMIUSpqUyucXI5Z10Gwc16bGj4acpa2tBi4A
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

one USB controller can have multiple ports specified in dts, all of them
should be setup to make use of all possible ports.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
Changes in v2:
- Rewrite generic_phy_setup_bulk(): Actually v1 is doing things
  completely wrong. This series should work and it's tested on a real
  machine.
- Link to v1: https://lore.kernel.org/r/20240201-ehci-v1-0-bb506cb0f64d@outlook.com

---
Yang Xiwen (3):
      phy: add generic_setup(shutdown)_phy_bulk()
      test: phy: test generic_setup(shutdown)_phy_bulk()
      usb: ehci: Make usage of generic_{setup,shutdown}_phy_bulk() helpers

 drivers/phy/phy-uclass.c        | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-generic.c |  8 ++++----
 include/generic-phy.h           | 29 +++++++++++++++++++++++++++++
 test/dm/phy.c                   |  4 ++++
 4 files changed, 78 insertions(+), 4 deletions(-)
---
base-commit: b6d8969bcb94321dfed1399f2eaa8768ba42caaa
change-id: 20240201-ehci-6c3aa7d97932

Best regards,
-- 
Yang Xiwen <forbidden405@outlook.com>

