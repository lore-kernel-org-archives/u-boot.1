Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64025D15DAF
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 16:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BD7383FFF;
	Wed,  3 Dec 2025 17:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F5784005; Wed,  3 Dec 2025 17:19:42 +0100 (CET)
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::1908])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E39183F7D
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 17:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dM2sR4BzFzc0p;
 Wed,  3 Dec 2025 17:19:39 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dM2sQ4KnLzK2p; Wed,  3 Dec 2025 17:19:38 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next v2 0/4] fit: print conf node compatibles + use
 property string constants
Date: Wed, 03 Dec 2025 17:19:31 +0100
Message-Id: <20251203-fit-compat-v2-0-0fea56f23809@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NwQqDMBBEf0X23C1rUDE99T/EgyabZg9VSYIo4
 r835Nzjm2HeXBA5CEd4VRcE3iXKumRQjwqMn5YPo9jMoEi11JBGJwnN+t2mhDyzblynaaYe8mA
 L7OQosgEWPhKMOfUS0xrO8rDXpfsn22skbDvres2u6bvpbTyHcD4tw3jf9w851jNNqgAAAA==
X-Change-ID: 20250409-fit-compat-ebe94f690b08
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Shiji Yang <yangshiji66@outlook.com>, 
 Anton Moryakov <ant.v.moryakov@gmail.com>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

This does a bit of "cleanup" by reusing constants for some FIT
properties instead of having the same string in multiple places.

Additionally, this adds a new constant for the compatible property in
FIT configuration nodes[1] which is useful for FIT images with multiple
FIT configuration nodes to support multiple devices in the same blob.
U-Boot will try to figure out which node to select based on that
compatible[2].

However, if this property is missing (and the first blob in the fdt
property of the configuration node is uncompressed), the compatible from
the root node of the associated kernel FDT will be used for the
autoselection mechanism. For now, I only print the property if it
exists, but maybe it'd make sense to expose the fallback one if it's
missing. I guess we can implement that later on if desired.

[1] https://fitspec.osfw.foundation/#optional-properties compatible paragraph
[2] https://fitspec.osfw.foundation/#select-a-configuration-to-boot

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- rebased on top of next,
- removed RFC status so it gets some attention,

---
Quentin Schulz (4):
      boot/fit: use constants for property strings
      lib: rsa: use FIT_ALGO_PROP constant instead of "algo" in FIT
      boot/fit: declare (and use) new constant for conf's compatible prop
      boot/fit: print all configuration node compatibles

 boot/common_fit.c    |  4 ++--
 boot/image-fit.c     | 15 +++++++++++++--
 include/image.h      |  1 +
 lib/rsa/rsa-verify.c |  2 +-
 4 files changed, 17 insertions(+), 5 deletions(-)
---
base-commit: dca19206acf2af2d339087bb62aa0b8ee1b0e326
change-id: 20250409-fit-compat-ebe94f690b08

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

