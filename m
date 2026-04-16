Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 508FEF8D757
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 14:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABEA8841C2;
	Thu, 16 Apr 2026 16:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="sKPmivjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F9E084214; Thu, 16 Apr 2026 16:58:02 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF6B840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 16:57:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776351478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Re6OallyHx8jNQb4BtWF6HijrxJHgILKt/E2FlEqwBw=;
 b=sKPmivjzTPrF8255bQ55/ZP/3ncY37dp/PR3/EpMX2UYy57vV15tfmWyzW6w/IED1M4E5g
 wuXamAcSzLmO40aUhld4VUqXEpJWH6UaIZBkLMGicanTmqh0IiYNhp0RGyxOa+57gm2zdN
 jHY/6H063j/8bM7tE58omqd/8mGmH0kj4vRQWUa+XAM4wdDffTiqB+hbxY/yaOvo6T9FYn
 FHNSsGcg8PYExqvkA/kWH4yMsGC6u6NQVJ1aVB3l8X57QORcMVc21csa6i4Iq/gX9S6MQS
 xgVgKyeDXlRSqGdQ2kSmJYwuWz+eRlEUIpxKZYfdvdBX6X3KVsaWQnQH6jdyKQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v4 0/4] Autoboot prompt customization and bootmenu
 cosmetics
Date: Thu, 16 Apr 2026 14:57:40 +0000
Message-Id: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOT44GkC/3XOTQ6CMBCG4auQrq3pn4W48h7GxdAO0BgoaZFoC
 He34AaJLt8vmSczkYjBYSTnbCIBRxed71KoQ0ZMA12N1NnURDChmZScPhw1PrY4OBMpAAqWQ4l
 WlySd9AEr91y56y114+Lgw2vVR76sH0ix0zc0cspoWVVopAGTK37pfRxaCHccfDz6UJPFG8XWK
 HaGSEYuuDXaCs41/DHkxuD7P2QyAArJClA5SvnDmOf5DaLIxws3AQAA
X-Change-ID: 20260331-ui-cosmetics-aae207abed6b
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2306;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=tBzfxnXLaK9QvFycukNRc3814Wsd142TsuPnI8L53Bs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp4PjvmM9AlEYs1loDFlEwfEHr4BqGBGrmqNQzi
 wOiaaRpjTGJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaeD47wAKCRCEr8vQ14ma
 A6YdEACje9aC7jT2UyvRGO92oI30Zrowc5xpZTKboU7z+CEFBtjVxk60IJ+0mLMSaQP7NAMoz9U
 aPBEZg1DxlK9vTJEpWDDsdhwHWlEC0vrC1/v2tR0oqD/z6YDTmByHr0W7l8XowShnW1WkHNQoMF
 bWP0cqSDXPVEpWK7Sqtj1zJ/iocH3TIshozj0I1j8u0ZSHLSUSPYi7GWWIK0HWZ4qhInMgAuYL6
 Yi9L99vbsZUV5Bhe+QEpt8omuxRjkI3fJSLD4V6kyqflWi5fSOgtvNOPaODPpmDWWHhc2vZxoed
 zivZ3diUeT6oUYg6JM7SfJc1GvPxmzWLTDusBu1lHhuBJGS3lWiKAJAo/1GliO9ZgX1mAlMU+RW
 DzlQIOpDMSC2upSPbEtpdNAjJKErnyBR6FSBQ8bdPyeA5+OsCwO7dqYIp66Nt1A8vUFIs7PsZmq
 gDRp+L1mj7RIqdh1WKfUoa9xCBAlZAW2jEn+W7Pvw26jc7yxdkKulZ1BcLDKcGhn0LYcksgiI7G
 p3yv6G0z8dl9RxyUmDpt9/ZBhaH+UnwgG6q/SPFUFC4ILA2FoyN6Nn/nS9ucKpNRBgBKZVY2jat
 5zfPLBmddiF0XZVt633Vi0P2yHibestA0ACKQKVaqkseI3uBmiFjAK1ZjEFGSBYb1inkPImYjaZ
 s6U0Z50WcskMpVA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

This is a small patch series to make the autoboot prompt configurable
regardless of if CONFIG_AUTOBOOT_KEYED is enabled, which is very useful
with a splash screen. My usecase is, with some ANSI magic, moving the
autoboot prompt to the very bottom of the screen and highlighted, with a
splash screen shown.
Something like this: https://ircb.dersco.re/uploads/funderscore/efa2a27132e56891
It feels wrong to require AUTOBOOT_KEYED only for that usecase.

Also, the bootmenu now prints ANSI_CLEAR_LINE before each entry, which
has the effect of highlighting the entire line entry on vidconsole, just
like eficonfig. I can drop that one if it's not very useful, just
thought it would look nice.

And while at it, and because this has been due for a long time, convert
autoboot documentation to rST, so it is part of the public docs, instead
of a plain text file.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v4:
 - Add patch to update autoboot documentation
 - Link to v3: https://lore.kernel.org/r/20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org

Changes in v3:
 - Add Tom and Simon's R-b's
 - Convert autoboot documentation to rST
 - Link to v2: https://lore.kernel.org/r/20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org

Changes in v2:
 - Remove #ifdef/#endif near printf in print_boot_delay: no need to
   guard the printf as CONFIG_AUTOBOOT_PROMPT must be set
 - Link to v1: https://lore.kernel.org/r/20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org

---
Ferass El Hafidi (4):
      autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
      cmd: bootmenu: ANSI_CLEAR_LINE before entry name
      doc: usage: convert autoboot README to rST
      doc: usage: autoboot: update content

 boot/Kconfig           |  30 ++++-----
 cmd/bootmenu.c         |   2 +-
 common/autoboot.c      |   2 +-
 doc/README.autoboot    | 162 -------------------------------------------------
 doc/usage/autoboot.rst | 158 +++++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |   1 +
 6 files changed, 176 insertions(+), 179 deletions(-)
---
base-commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
change-id: 20260331-ui-cosmetics-aae207abed6b

Best regards,
-- 
--
Best regards,
Ferass

