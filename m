Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D7BC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:13:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7402F8063E;
	Sat, 18 Jan 2025 07:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pZgD9eDt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UKXsEidi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38B678070C; Sat, 18 Jan 2025 07:13:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDEE580077
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZmW55DvWz9sWC;
 Sat, 18 Jan 2025 07:13:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jERMA/AgvKITjf2Vd4osswkEKujKPRwxJ/Y3DDs+5Kc=;
 b=pZgD9eDtKaCAyHRurHcxmuADbAxg/E3/ygsVlofcjBzuX0JIk36Z/xTNSkFns6AKMPqZUh
 n5Ei3u0LgWJx2Konxy8FS9PdePTPE709TewcEvifF94MknDmRIflAMOBRFAainkQBVMG7B
 5qRdmy6kAjsOVcsnqRSUfOguamVt4VHHeAUucleyjjdHOcAKxWkox1EjCKZ+3qlppYLmTm
 ZJ+heP97ez0PTrinu5Qf3uV/eT25sZfzTzhJkEnDxYjBSmTcqMg1OxqeLjFAz6LaPSzP/U
 sHkLVT/dPhoxWzDMg+4nrzuhhKcHywHhtcqRVGFAwuUDe+VOZ5o2RiTs4VO9Nw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737180799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jERMA/AgvKITjf2Vd4osswkEKujKPRwxJ/Y3DDs+5Kc=;
 b=UKXsEidi6DBOyHlGg7sFTbUBJsK7L2R6i3TiFKfWrrI2yY5j6tfxJ9f+BDZ/DnCCSe78lv
 TuTpmTQIyqyQIoVbfjm0280Y2xiZBBj1/SsisJBYrJ+72Nbc/XnsNHqEWIkp3F8RUHGTLN
 vUfnr77agsauCJu05B1kg/QTPgnub2eA0nbSNficdEVn0c7E7PwWguGW2smCL8VwkJGFqX
 2hD4OOYWxXdMcMRFCEkm8TnDv1uI5PYWE23PqRDvQeXokzRIXMTlCu6joptrhwr+YI5zYI
 pLa6TT0EAMDZKeDorvQs92/I8zSHfmb7nFuxctG4PtquRB9Y9sWLf3AkOVUiAg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: ravb: Staticize bb_miiphy functions
Date: Sat, 18 Jan 2025 07:12:47 +0100
Message-ID: <20250118061304.124807-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 97ocpau4uct5dtxohthm5pzm3uj1j3ci
X-MBO-RS-ID: ef0fcdc44aba444c295
X-Rspamd-Queue-Id: 4YZmW55DvWz9sWC
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

These functions can be static as they are referenced only in this file.
Make them static. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/ravb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 231764e60b5..7286ad19598 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -560,12 +560,12 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-int ravb_bb_init(struct bb_miiphy_bus *bus)
+static int ravb_bb_init(struct bb_miiphy_bus *bus)
 {
 	return 0;
 }
 
-int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
+static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
 {
 	struct ravb_priv *eth = bus->priv;
 
@@ -574,7 +574,7 @@ int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+static int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
 {
 	struct ravb_priv *eth = bus->priv;
 
@@ -583,7 +583,7 @@ int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
-int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
 {
 	struct ravb_priv *eth = bus->priv;
 
@@ -595,7 +595,7 @@ int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+static int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
 {
 	struct ravb_priv *eth = bus->priv;
 
@@ -604,7 +604,7 @@ int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
 	return 0;
 }
 
-int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
 {
 	struct ravb_priv *eth = bus->priv;
 
@@ -616,7 +616,7 @@ int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
 	return 0;
 }
 
-int ravb_bb_delay(struct bb_miiphy_bus *bus)
+static int ravb_bb_delay(struct bb_miiphy_bus *bus)
 {
 	udelay(10);
 
-- 
2.45.2

