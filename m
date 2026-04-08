Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B51F10F995D
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C91608407E;
	Wed,  8 Apr 2026 18:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="E7kCGMLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4BD3840AB; Wed,  8 Apr 2026 18:35:29 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7FB183D8A
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775666125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=orEdM0K03k14i3CV+x+jZjQo9Q7zkpU997C0OI5BMps=;
 b=E7kCGMLqaLvn/a4JnVUeBo7macQMC0e0EYfUFjsmlrkZ4xqQXAjwe5UqPV/NuxN5kPS1MS
 0Tmm2oZwyxHh7TPGVTT5CXb+qQLl85yYuOFxD2hRQIsT07z5497AMmSPOVKrX/HFYT2fG9
 h8TJXgj4S8psPaAzTS/Qee4ES5ObcpcbkPopQXzUWNAsbrl8v/izOFzKeTSWnvWMfNUDYK
 K20ZoGxDlgHEp7DEsUv10v/jacwA39JE+8xKhEIgnV9hpYbfO8mwSd26FL4aRr5C62jRys
 ul3f20A/Sa/VwuLdrZuBKgz2GNUx3lw8JYPo0e/UKguJhnx6p2GBuklvsyZ3bA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v2 0/2] Autoboot prompt customization and bootmenu
 cosmetics
Date: Wed, 08 Apr 2026 16:34:55 +0000
Message-Id: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK+D1mkC/1XMyw6CMBCF4Vchs7amF4TEle9hWJQywMRASac2G
 tJ3t+LK5X+S8+3AGAgZrtUOARMx+bWEPlXgZrtOKGgoDVrqRhqjxJOE87xgJMfCWtSytT0OTQ/
 lsgUc6XVw9670TBx9eB96Ut/1B9Xy8g8lJaToxxGdcda1tbptnuNiwwOj57MPE3Q55w+itE/lr
 wAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=h0U5F4FlY3Hu9MZEfW/WUSvYwVxULgjbc2g7rqw26WQ=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp1oPF2S0/442iTv+1vIlSDESrtVYm7bt751Ija
 05vMaaF1WeJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCadaDxQAKCRCEr8vQ14ma
 A42eD/9CXGWK7H7o1RtQKsi4CEc1a/BxjVdp4uxGexC7Cb2ovgDVnMJUNZoc9HjpoT56YnfN5Om
 C4plO/s+wMq2ZilZoNIKyWT0deYqkzqGKehmxz7GMJ9FwXV/kfPEfs60XdjqzJOseTR5XlBF1aJ
 EBa7Dx/r2hCS8Kl4NJiRtComGiSHZ5qV4OZde+xWo6gDw7Pk/5rSasXvJmsxeXt8NgsXcdlEPlY
 jow8oCJd8akmtpMaIa99hp1PkReXz2GC4lNZVV+iav9j/xY4QyLqdL7/gsH5xY4VZWPyuaQZcMF
 TdGgJ55Dl6bNrMHYK+iPM11aroU+rZnGImJVNpbB9mhc79MaXBsRArsrYeWQMkg2tfjXir+HPXo
 pscxN0Q9kqMs90tNRUcRV3Bu77iKs5U1zvyz3iBmNpIuTsJg+sx2w/Pj7s6BsYARuao+QndLmu5
 78hWy0jE3AfvXIEKAJIplevWD4TbNj2DKiouHuRWmnlGWWGkga1qzI9LS2Z1pVzNlw16HRbMh+N
 mA6JB33TiN5IAC1qE+VYxm+4PhDE8brAc0Yr+Tl/ozlXZjt3SgWYEU+VlqcoANoinl8PVClT/0M
 yXiDH/abQ92P2WO5S7fJdNmqdDhgGfjM5IB7y/uGb+Qfm4qT27dGKukoKsrMPNDo+oQP6/xXcML
 5Hby6yz2Cl1GklQ==
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

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Changes in v2:
 - Remove #ifdef/#endif near printf in print_boot_delay: no need to
   guard the printf as CONFIG_AUTOBOOT_PROMPT must be set
 - Link to v1: https://lore.kernel.org/r/20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org

---
Ferass El Hafidi (2):
      autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
      cmd: bootmenu: ANSI_CLEAR_LINE before entry name

 boot/Kconfig      | 30 +++++++++++++++---------------
 cmd/bootmenu.c    |  2 +-
 common/autoboot.c |  2 +-
 3 files changed, 17 insertions(+), 17 deletions(-)
---
base-commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
change-id: 20260331-ui-cosmetics-aae207abed6b

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>

