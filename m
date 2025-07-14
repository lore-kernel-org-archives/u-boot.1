Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEE2C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:23:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EC74830F6;
	Mon, 14 Jul 2025 15:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="A6I/Roid";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="LiOXK8Mj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B9228309A; Mon, 14 Jul 2025 15:22:39 +0200 (CEST)
Received: from out-ip0051.fra.mailhop.org (out-ip0051.fra.mailhop.org
 [18.193.30.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D35983055
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=Jp8Y7jbN54TmUt7TlcqHSwuCYXq0NCFh2Y0EonMrBSc=;
 b=A6I/Roida/EIJh2FaCA9g6v1tE+7bYEMkyMmqbYKNMmZWnhgxMLA6ViuUHvs8ePw+AmSolR7LhwWr
 HJXxs8XgPZ4JcmF32lxLPbwvznyfGCU8mNJ1pH8SHfbuDZN76Ni1dH539D3lK+aGxvnA+5xufpKitt
 GOccUXiSHHcOaCR4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=Jp8Y7jbN54TmUt7TlcqHSwuCYXq0NCFh2Y0EonMrBSc=;
 b=LiOXK8MjwUbnxDNCI6HaD5D++NIjPSPRlJRqQ7kLyhxqB0xef7GNCEeSiCTe+B2L5JknEvYxD89Ej
 zmz9TUhcDxjK/dwIiVbilkSOmPZ2GdBKAVGb+HtTVAj6OhQChOEasjBrIBm2qWjOX2drh+vKes34o6
 bz9CCwK9r3/uCxl+PI8wYfdNcA0pPE4waqCP6XITGu/BUce29QQZIUDWIs+thhBRCx/eUqK8zwRpih
 vkFEitWJeNTzxVvNxho9zQ2l9kHDDf3BoDaMoTPkhshufypJ8u+Aagwru22xUHJDy8qWEqW+1orRkC
 7mK373VmOVQdCf9yOcreCfVLwuD53fQ==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 99df80c4-60b5-11f0-ac89-878ee10b8a33
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 99df80c4-60b5-11f0-ac89-878ee10b8a33:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound3.eu.mailhop.org (Halon) with ESMTPSA
 id 99df80c4-60b5-11f0-ac89-878ee10b8a33;
 Mon, 14 Jul 2025 13:22:34 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with SMTP id
 4D551402534; Mon, 14 Jul 2025 13:22:32 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id AF9C86095608;
 Mon, 14 Jul 2025 15:22:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 5/6] km: pg-wcom-ls102xa: call qrio deblock cfg earlier
Date: Mon, 14 Jul 2025 15:22:20 +0200
Message-ID: <20250714132221.2471558-5-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
MIME-Version: 1.0
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

From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>

Move the call to configure the qrio i2c deblock pins earlier.
Before this, the call was happening after the first attempt to deblock
the SDP EEPROM, which resulted in a not correct sequence.

Signed-off-by: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.c=
om>
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c b/board/keym=
ile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
index 409a55ebda6..7db75f4df3e 100644
--- a/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
+++ b/board/keymile/pg-wcom-ls102xa/pg-wcom-ls102xa.c
@@ -38,7 +38,7 @@ static uchar ivm_content[CONFIG_SYS_IVM_EEPROM_MAX_LEN]=
;
 int checkboard(void)
 {
 	show_qrio();
-
+	i2c_deblock_gpio_cfg();
 	return 0;
 }
=20
@@ -96,8 +96,6 @@ int board_early_init_f(void)
 	qrio_prstcfg(KM_DBG_ETH_RST, PRSTCFG_POWUP_UNIT_CORE_RST);
 	qrio_prst(KM_DBG_ETH_RST, !qrio_get_pgy_pres_pin(), false);
=20
-	i2c_deblock_gpio_cfg();
-
 	/* enable the Unit LED (red) & Boot LED (on) */
 	qrio_set_leds();
=20
--=20
2.49.0

