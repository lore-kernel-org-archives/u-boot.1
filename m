Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B228AF43844
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:41:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5282E84207;
	Wed, 15 Apr 2026 17:40:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="jh5eN4M+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A8A84105; Wed, 15 Apr 2026 17:40:58 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B187583B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776267653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZQ/CIWwdqaVbuupSXcl78Ecm7x0SHwJtH5l3P2b2BmQ=;
 b=jh5eN4M+uIjsuIz60pYtMf3zMDc2krTyElMUTDYuD92c68vlbK2ZmaQwyaYDv0xASbR6KO
 dEr4XwjBfvoAvhSJ1C7IK3UE91/JHqNq84bulvxrzYjrAmGVJDmaMJ6IBN1zhAJbGSyQln
 3n8/C4CEZRHGtjSZ/ZxzIzOfw6/UCsrRntwhyNFCaFuwhMwFRZoGVfexE+8ROPcT9AVz+/
 q/vbWrGBti9ncMu8BCxoKbeXTkjwZj65rdtQG8wd4RPRADiJI4Lgx37Iwr/+87jFYfW6Xr
 d6FR+Qq8OfGF26V8YIOBPZUU8wNNohvnJV2ZovdXdBy/W8OudTD1lFDz2fm/aw==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH v3 0/3] Autoboot prompt customization and bootmenu
 cosmetics
Date: Wed, 15 Apr 2026 14:32:30 +0000
Message-Id: <20260415-ui-cosmetics-v3-0-aa8308a47e33@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6h32kC/23MSw6CMBSF4a2Qjq3pA4tx5D6Mg1IucGOgpLc2G
 sLeLThR4/A/yflmRhAQiJ2KmQVISOjHHHpXMNfbsQOOTW6mhDJCa8nvyJ2nASI64taCEpWtoTE
 1y5cpQIuPjbtcc/dI0Yfnpie5rm+oFIdvKEkueN224LSzrirlefIUBxtuED3tfejY6iX1aRx/D
 JWNSsnGmUZJaewfY1mWFydqoczzAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2118;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=YoV2GL4iFBOLF9KjmATl2Amer2v6v8TNJfKD9hsWBHs=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp37F8bmTc6YD2KV5BoCKy55wRijZ216F5K/4Qd
 8x+gjv5tmqJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCad+xfAAKCRCEr8vQ14ma
 A/FmD/9bkOAI2MZXRhyFIqri4TcDWDqJw/U3uz3e8wM2BIPjbpSYQweIKtmK7lDSyp99tyK9cmr
 3UV3rGB/jHQHUB/pZ8+d6+CJwGfdWK/HYCcc22jamNPnq4n+ecHYaXJE4XAQpLVlb9xAFEdX+sY
 Rs4pf60q0sWID+z4QzGxVNOaK7QjcalxihPDfmHi4SR2fHqSdtvGAWJj+PW4u4Q6WHP1cura1gp
 cZWmm8qQ3JLvCo3B4omhQIrJR6jcqC4Gi7U3BkwGLO7BzhYL0WvTA1Hgtzj45IM5yzQJJStYq24
 h2TtuBDtqa8rDt3Twg+2FhhoSKo5K14vAKKSQp0J2VSYk9pTYg59dOWsdpR0gLhMxXTUyQgx+IT
 1HE4vsT0ziImaoZy3+B+1QI7P+yUdId8KcAPAT46DH4pLkWfN7/Tk2dGJifXSJYo83xQlA5OTF0
 /IIex20QJbN4ymRDYnNyZoz8lFaYZ/5twdfuHslDUftG8nK32Eputc+z/l2qaCKIO7ZULNa5T4X
 9ta+3GLILfWazPwg/W7OgXltteB003eKNvrGCeJJoKo8kirLu8zujxuadfbZf4qSrE2kKb3v0bx
 FM1GnanDsJjAzDG6H4qtfSxr98WeJ1kJjfeUXf4xisSgRi6zk/e4BVvjKTpNFPc5eoK9CB1zVET
 8Xa90cPhHBd5ufQ==
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
Changes in v3:
 - Add Tom and Simon's R-b's
 - Convert autoboot documentation to rST
 - Link to v2: https://lore.kernel.org/r/20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org

Changes in v2:
 - Remove #ifdef/#endif near printf in print_boot_delay: no need to
   guard the printf as CONFIG_AUTOBOOT_PROMPT must be set
 - Link to v1: https://lore.kernel.org/r/20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org

---
Ferass El Hafidi (3):
      autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
      cmd: bootmenu: ANSI_CLEAR_LINE before entry name
      doc: usage: convert autoboot README to rST

 boot/Kconfig           |  30 ++++-----
 cmd/bootmenu.c         |   2 +-
 common/autoboot.c      |   2 +-
 doc/README.autoboot    | 162 -------------------------------------------------
 doc/usage/autoboot.rst | 149 +++++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |   1 +
 6 files changed, 167 insertions(+), 179 deletions(-)
---
base-commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
change-id: 20260331-ui-cosmetics-aae207abed6b

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>

