Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB62E64002
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 10:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FA683CD3;
	Sun,  5 Apr 2026 12:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="rPJ2H4+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30C998394E; Sun,  5 Apr 2026 12:49:35 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36243800AE
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 12:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1775386171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SJqQ/ZA8wtL8vfWpZiR7+6D4aLhqOASLINX/y88o5Uw=;
 b=rPJ2H4+rr3vN9gP9VQV+Cm0N1ZJBc8nPQzxmR7TRbw33yf+Iz9IY0i/4fwvAFwkxEL03u5
 83CIO0poolA/qCiaKIhZ9sTDHx+FeaVQto8cydMrVpUTgkrc8EQauNQSpjL7XDTXDfO2Xz
 H9kWUWsqMgiua1k2U7gulf8v6+PIlerj5D8G5ChUt7dYE3bGxezbG22dojtK/HCKo7E1BR
 ZSPl69zFy7c1ltcWYr0Q+WNCDbFF8SRWizAMx+cee1oNJWiRQc50ry/u0Egc11oeWRSUIX
 nZc/UXacCDB0bSfpjQfhPzg04qqjlKTew6FYO/p56UvPro+nCPBXEYhr0tf/GA==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Subject: [PATCH 0/2] Autoboot prompt customization and bootmenu cosmetics
Date: Sun, 05 Apr 2026 10:49:03 +0000
Message-Id: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8+0mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY2ND3dJM3eT84tzUkszkYt3ExFQjA/PEpNQUsyQloJaCotS0zAqwcdG
 xtbUAGWT/nV4AAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1270;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=LDyJ0QEfBGSsxwertfJ22i+6z1jAtEJoBWO497mvsJ0=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBp0j4y5STN2WLE8YI3+4ICsNLKk+73AyaMTDgYw
 EhDKEEMzrSJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCadI+MgAKCRCEr8vQ14ma
 A/HRD/wIRripeZy9EZzYAsu+8/tivedEvtbdEcEt7heJ+OWsphoboHBd0HNbFRjVoNHG8BRbDmt
 cLuCdff0Ulsad2TguOIzJxkUoO0PfD4cKNdSePFvouZhp90/fc2sqlRZmzl5Z10FX9eZ1hWk/Ci
 0okk48haRChOlumFiANToA+BRLYFNAGpZj68MichLA5IB6TYfRSuKG3sPwGjzrsfT7tLOL9BNWo
 ojZPYNs1cu+Gh4Qj1tmtEmmwjYo+CliQORfw995TkLbwl3dZWYq3fnRUBlGMCIzbPEPfVIIaHyN
 oZeCzsVYFff7KmUqAJKel/xDkviReb+Jy6wOhN5bHhAqiIRINa7rBMrcG0+DfhdHcz31xYaVj6L
 CsHNewJXGzPtTvL6qeliIKiXzlJ+3j2EOlAjxtKXFk/VSlPTiLXhFztkMmZ0+1MEm+IThrBvAPX
 psHbMSXMwesQJBrzZn+Z4VDi/78ntX0+cZZPFaE2t1G+QTx55EWO7Gz958Fsj5rL78mvuDA5H6b
 7iEN7KyABqtF94k2/IsbE0tJdJR56oHPtwHGNhEue8ZFEJzKt+EgZ2uIPgeCiICCheVozrTCkfA
 fC5GZU4sL8LNI8BF1QG2LNMdyl3DT52bWIuCwiRJUARkzFKp3bPd2U8qeDA38f3U5YPg90jFB5L
 QEotMXF/XPMZi4g==
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
Ferass El Hafidi (2):
      autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
      cmd: bootmenu: ANSI_CLEAR_LINE before entry name

 boot/Kconfig      | 31 ++++++++++++++++---------------
 cmd/bootmenu.c    |  2 +-
 common/autoboot.c |  4 +++-
 3 files changed, 20 insertions(+), 17 deletions(-)
---
base-commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
change-id: 20260331-ui-cosmetics-aae207abed6b

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>

