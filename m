Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDE6D35163
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B667E83CE3;
	Wed,  1 Apr 2026 11:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=philipmolloy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=philipmolloy.com header.i=@philipmolloy.com header.b="Y9Kpb/RU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 282CF83CF5; Wed,  1 Apr 2026 11:32:06 +0200 (CEST)
Received: from mail-244120.protonmail.ch (mail-244120.protonmail.ch
 [109.224.244.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7229480212
 for <u-boot@lists.denx.dE>; Wed,  1 Apr 2026 11:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=philipmolloy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philip@philipmolloy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
 s=protonmail; t=1775035922; x=1775295122;
 bh=pHAhjfxvR7z9ppbANRv9UsI9EHunaTzk3SLK4uFiuK0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Y9Kpb/RUKZokvkMmi1Ejmh7PqeqeVuz9d0UtKd/4+bhuvry+0NZyhTR5erhPP/9op
 eMUI99h4iNyoSBtB837Q1YWJTR2OYXtJob9LbFhhnho+zBA7lTGFq6O57yMWUsfZka
 4zJtW1nQPb8UnWm6F/JKYCTf9bRO+0ZlUMbtplWr196cgXKEpIJpfaR938w3DevIDA
 kT77dKNKANYKrR04BAKTTZlk7fXYlfLdVsp7BS/kTV3Kql2y5M0ep+zSESVLrfhIXT
 s1m82kWxj+EmTF3l/e8gfrsV7u3iXMFHufMkKfFQmyq/RlSpFL8vIui51HezDR4fFG
 iPxSOHNjIGjEw==
Date: Wed, 01 Apr 2026 09:31:56 +0000
To: u-boot@lists.denx.dE
From: Philip Molloy <philip@philipmolloy.com>
Cc: linux@analog.com, Philip Molloy <philip.molloy@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Tom Rini <trini@konsulko.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>
Subject: [PATCH] board: adi: Fix exception when using standalone SoM
Message-ID: <20260401093354.3608142-1-philip@philipmolloy.com>
Feedback-ID: 9117015:user:proton
X-Pm-Message-ID: c3a644bc1bc34d659a943e48dc4b7f36aa4098b7
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

From: Philip Molloy <philip.molloy@analog.com>

Although less common, ADSP SoM boards can be operated standalone without
a carrier board. The SoM can be powered over USB-C by moving the jumper
on JP1.

The board configuration needs to be heavily refactored to reduce the
number of defconfigs and leverage the devicetree. The TI DP83867
support, which is dependent on that configuration, needs to be removed.
Until then this change allows the same U-Boot binary to work correctly
both with carrier boards and the standalone SoM.

The carrier board initialization code in somcrr_ezkit.c and
somcrr_ezlite.c calls gpio_hog_lookup_name() to find ethernet
control GPIOs, but does not check if the lookup succeeds before
using the returned pointers.

When running on a standalone SoM without a carrier board, these
GPIO hogs do not exist in the device tree. The gpio_hog_lookup_name()
function returns -ENODEV and sets the pointer to NULL, but the code
continues to call dm_gpio_set_value() with uninitialized pointers,
causing a synchronous abort exception:

  "Synchronous Abort" handler, esr 0x96000004
  elr: 00000000960326c4 lr : 0000000096038d5c (reloc)

Signed-off-by: Philip Molloy <philip.molloy@analog.com>
---

 board/adi/carriers/somcrr_ezkit.c  | 26 ++++++++++++--------------
 board/adi/carriers/somcrr_ezlite.c |  8 ++++----
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/board/adi/carriers/somcrr_ezkit.c b/board/adi/carriers/somcrr_=
ezkit.c
index 8b4d6a96c18..3cd5a6cd10b 100644
--- a/board/adi/carriers/somcrr_ezkit.c
+++ b/board/adi/carriers/somcrr_ezkit.c
@@ -13,13 +13,12 @@ void adi_somcrr_enable_ethernet(void)
 =09struct gpio_desc *eth1_reset;
 =09struct gpio_desc *gige_reset;
=20
-=09gpio_hog_lookup_name("eth1-en", &eth1);
-=09gpio_hog_lookup_name("eth1-reset", &eth1_reset);
-=09gpio_hog_lookup_name("gige-reset", &gige_reset);
-
-=09dm_gpio_set_value(eth1, 1);
-=09dm_gpio_set_value(eth1_reset, 0);
-=09dm_gpio_set_value(gige_reset, 0);
+=09if (!gpio_hog_lookup_name("eth1-en", &eth1))
+=09=09dm_gpio_set_value(eth1, 1);
+=09if (!gpio_hog_lookup_name("eth1-reset", &eth1_reset))
+=09=09dm_gpio_set_value(eth1_reset, 0);
+=09if (!gpio_hog_lookup_name("gige-reset", &gige_reset))
+=09=09dm_gpio_set_value(gige_reset, 0);
 }
=20
 void adi_somcrr_disable_ethernet(void)
@@ -28,11 +27,10 @@ void adi_somcrr_disable_ethernet(void)
 =09struct gpio_desc *eth1_reset;
 =09struct gpio_desc *gige_reset;
=20
-=09gpio_hog_lookup_name("eth1-en", &eth1);
-=09gpio_hog_lookup_name("eth1-reset", &eth1_reset);
-=09gpio_hog_lookup_name("gige-reset", &gige_reset);
-
-=09dm_gpio_set_value(eth1, 0);
-=09dm_gpio_set_value(eth1_reset, 1);
-=09dm_gpio_set_value(gige_reset, 1);
+=09if (!gpio_hog_lookup_name("eth1-en", &eth1))
+=09=09dm_gpio_set_value(eth1, 0);
+=09if (!gpio_hog_lookup_name("eth1-reset", &eth1_reset))
+=09=09dm_gpio_set_value(eth1_reset, 1);
+=09if (!gpio_hog_lookup_name("gige-reset", &gige_reset))
+=09=09dm_gpio_set_value(gige_reset, 1);
 }
diff --git a/board/adi/carriers/somcrr_ezlite.c b/board/adi/carriers/somcrr=
_ezlite.c
index c0655574bab..1f1984cf912 100644
--- a/board/adi/carriers/somcrr_ezlite.c
+++ b/board/adi/carriers/somcrr_ezlite.c
@@ -11,14 +11,14 @@ void adi_somcrr_enable_ethernet(void)
 {
 =09struct gpio_desc *gige_reset;
=20
-=09gpio_hog_lookup_name("eth0-reset", &gige_reset);
-=09dm_gpio_set_value(gige_reset, 0);
+=09if (!gpio_hog_lookup_name("eth0-reset", &gige_reset))
+=09=09dm_gpio_set_value(gige_reset, 0);
 }
=20
 void adi_somcrr_disable_ethernet(void)
 {
 =09struct gpio_desc *gige_reset;
=20
-=09gpio_hog_lookup_name("eth0-reset", &gige_reset);
-=09dm_gpio_set_value(gige_reset, 1);
+=09if (!gpio_hog_lookup_name("eth0-reset", &gige_reset))
+=09=09dm_gpio_set_value(gige_reset, 1);
 }
--=20
2.52.0

base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
branch: som-eth-abort

