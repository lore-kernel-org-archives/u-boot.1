Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD55C25B7A
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 11:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C8288676;
	Fri, 24 May 2024 13:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9250D8867B; Fri, 24 May 2024 13:47:03 +0200 (CEST)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E82E38827A
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 13:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm3DJ4tpTzldT;
 Fri, 24 May 2024 13:46:56 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm3DJ16TKzDc5; Fri, 24 May 2024 13:46:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] fix URL and mails for Theobroma now CHERRY Embedded
 Solutions
Date: Fri, 24 May 2024 13:46:34 +0200
Message-Id: <20240524-tsd-to-cherry-v1-0-3002bed55f19@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABp+UGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyMT3ZLiFN2SfN3kjNSiokpdizTLVDPLRAtLMwNzJaCegqLUtMwKsHn
 RsbW1AMPbnuxfAAAA
To: Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Klaus Goger <klaus.goger@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

To prevent some IT hiccups in the future, let's just migrate important
URLs and the mail addresses to ones people "should" be using right now.

This should be unnecessary but let's play it safe.

See
https://embedded.cherry.de/theobroma-systems-is-now-officially-part-of-cherry-se/
for the press release.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      .mailmap: redirect Philipp Tomsich Theobroma address to Vrull
      migrate Theobroma Systems mail addresses to CHERRY Embedded Solutions
      rockchip: theobroma: update URLs to point to CHERRY website

 .mailmap                                          | 5 +++++
 board/hardkernel/odroid_go2/MAINTAINERS           | 2 +-
 board/theobroma-systems/jaguar_rk3588/MAINTAINERS | 8 ++++----
 board/theobroma-systems/lion_rk3368/MAINTAINERS   | 4 ++--
 board/theobroma-systems/puma_rk3399/MAINTAINERS   | 8 ++++----
 board/theobroma-systems/ringneck_px30/MAINTAINERS | 7 ++++---
 6 files changed, 20 insertions(+), 14 deletions(-)
---
base-commit: 377e91c162ab09ec20f96f966f380cb55c590edd
change-id: 20240524-tsd-to-cherry-8f9e69a89607

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

