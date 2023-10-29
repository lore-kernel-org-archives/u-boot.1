Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2713C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44E6C87090;
	Sun, 29 Oct 2023 08:36:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="bnnk1XQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67FEB870BB; Sun, 29 Oct 2023 08:36:32 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 841AE8706F
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 1E359424CD;
 Sun, 29 Oct 2023 07:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698564989; bh=J0zgcxPjp5BUqvbSyYqWUSG1B5jCLisVcnulOfZED+g=;
 h=From:Subject:Date:To:Cc;
 b=bnnk1XQQE2mkFBIjhYatXHmk8AEQ0cx2jldSK0pjyDqo0HWI4v0KwBClg6jBEUEN1
 /dza41h1Ko0b+EkMzG7c5Ap1OqYm7I5cKPfPXr0Mj2UXuE8fFAqA7EQtSWrII8Ph/h
 +6S66MJ7t/pT4S69JfCP9J0DlhAD9ljruosv4OrYvGRkDAkeGBtjsR22EuzFIdF+/h
 Nmcn7RVyeRPMzngTP8j/o/yxk3aAtxX5LlajLHn/vaera4fdaJ9ic1QDYvNhBm83jT
 BiUzuCDEZ5MtiAEom6T0+XJ2mCzSP6OzqeVRUtvdxM/fmG9qNGPrXY3qZvkHUyywZ6
 aWQL9axW8o5Jw==
From: Hector Martin <marcan@marcan.st>
Subject: [PATCH 0/2] USB fixes: (Re)implement timeouts
Date: Sun, 29 Oct 2023 16:36:15 +0900
Message-Id: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG8LPmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDAyNL3dLiJN20zIrUYl1T3eREC/OkpNSUJBODZCWgjoKiVLAUUEN0bG0
 tAHEsKxhdAAAA
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2037; i=marcan@marcan.st;
 h=from:subject:message-id; bh=J0zgcxPjp5BUqvbSyYqWUSG1B5jCLisVcnulOfZED+g=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ77gqPpVVcy2rnzT/cPEP16H5Jk9NlS+aWmbJ8Kks+3
 rpqOY9ZRykLgxgHg6yYIkvjid5T3Z7Tz6mrpkyHmcPKBDKEgYtTACYiFc3w32Euf/oR5eOf/Jzy
 by5/+8uArZZhS+/EG5zbHs3SOBb8eQ3DP6X3YtX6taVJLBYv7h54uciqlyPb7d+TxY2P084ZXiv
 qZAEA
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

A long time ago, the USB code was interrupt-driven and used top-level
timeout handling. This has long been obsolete, and that code is just
broken dead cruft. HC drivers instead hardcode timeouts today.

We need to be able to specify timeouts explicitly to handle cases like
USB hard disks spinning up, without having ridiculously long timeouts
across the board (which would cause endless waiting when things go
wrong anywhere else). So, it's time to rip out the old broken nonsense
and actually pass through timeouts to USB host controller drivers, so
they can be implemented properly.

This series adds the necessary top-level scaffolding for control/bulk
timeouts, and implements them in xHCI. I didn't bother with interrupt
transfers, since I figure those probably never need long timeouts
anyway.

The platform I deal with only has xHCI, so I'll leave implementing this
for EHCI/OHCI to someone else if anyone cares :)

This series needs to be applied after [1], since the xHCI changes depend
on changes made there.

[1] https://lore.kernel.org/u-boot/20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st/

Signed-off-by: Hector Martin <marcan@marcan.st>
---
Hector Martin (2):
      usb: Pass through timeout to drivers
      usb: xhci: Hook up timeouts

 common/usb.c                    | 21 ++-------------------
 drivers/usb/host/ehci-hcd.c     |  5 +++--
 drivers/usb/host/ohci-hcd.c     |  5 +++--
 drivers/usb/host/r8a66597-hcd.c |  5 +++--
 drivers/usb/host/usb-sandbox.c  |  6 ++++--
 drivers/usb/host/usb-uclass.c   |  9 +++++----
 drivers/usb/host/xhci-ring.c    | 32 ++++++++++++++++++++------------
 drivers/usb/host/xhci.c         | 28 ++++++++++++++++------------
 include/usb.h                   | 10 ++++++----
 include/usb/xhci.h              | 14 ++++++++++----
 10 files changed, 72 insertions(+), 63 deletions(-)
---
base-commit: 3d5d748e4d66b98109669c05d0c473fe67795801
change-id: 20231029-usb-fixes-5-ca87bbedb40c

Best regards,
-- 
Hector Martin <marcan@marcan.st>

