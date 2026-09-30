Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77002CA5FC5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 21:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18F6740B3E;
	Wed, 30 Sep 2026 21:04:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b3E7SeC3ftR8; Wed, 30 Sep 2026 21:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F47440B43
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790802262;
	b=I1+B4h30BHeHfHpia7w7o28X33XlZ7Qh2s0IHyJISjcOUpX8qSRmOsD1h3pM7JDOCRjn
	 i3nf7JmpVFFA6zqjWxkwJ75B2J2NKrrwQHcF3/dMUoTViZUuT4aFI07pOTXS2DsV0OdVO
	 8GVDXUxpKEb+iwkuSsx38/FjhpEy3paynE/G2s31tlob4ZvTATYkmvzUKLchoyouZssBB
	 0eulDwb4EhbqMV18g4ZCmBUH4ClFo1HQzw3bIDxZYdAOXP01zLqE/dLeVKPHrqQYYKRtx
	 M3gDdb05C36YOwJp/v3GrKcZYeV0d+OKcATMQnlSFvTrm/9nxjnkY4y+BlZvo7ArABw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790802262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=ouCgva/zch0/LPo/0G3nyYwQ6X5tuU5gVDnPbUBZDFI=;
	b=Xc4NBFmxWF1WEEyotKYEZxK5XrY4fG3KUXwwwADSEPUaZMJ3qJ3vaET1nXI3USetRCjL
	 R/TeMqTJVIk8qS2aB1pYocaCn+w6aqOKke1Q5wZt7NpaMIJmwPSyL3ONvXNiG6jQE2xyF
	 ojweBd/gEYdEai6yEeLT6J4Ee7/wy5QG2wSc5Z56guuU9lYJ2SSGzhGxd7l1QpeV+PQPi
	 fxt/Ffc9y2b/cgbrERoLHcI1baBjG2XOjyKooJ6KQyGDo+z9Ej8AuGrGO/+sjCi+/OVeX
	 Q7g5I7gmSCMBl9CvTL7yKj7XztvcYIRleAksoc42nVtqyWWPJpy3MDbkKY/tsj3VfOg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790802262;
	bh=ouCgva/zch0/LPo/0G3nyYwQ6X5tuU5gVDnPbUBZDFI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Z0I2U1ASb4HMo6/v8BtTxZiTwOZdbOUboYzQgXMLtv2znxNGBCmAp/WJF7DCczB+0
	 ctq3sof28AQBgibqN5NvsW4hVLM1pSpwvTAl1/QBF5Co/yyHAcPmH0K+zMH+4/A1wq
	 7Gde7ubJS5w1592ZWDPdIOfNJ9hQ5Isujk33m5MFIiLDp43/pRr/VZyZJTYp0Kvs1Y
	 DhU4tSkIOQyOyFCvw7GPmzeVIjQDtq0enNUDwbOvoUuodywfxKrcJG9RCOoheBqNfH
	 vyufR1jrIdMpmYU5i3MXbqTPtZFUjVUAKFcs/Li10ZlODFoacbQ/FA6K2TXJgnp8GV
	 xo4f7JcYfw7aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F47440B43;
	Wed, 30 Sep 2026 21:04:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3041434E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21FC340474
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xi9ZeS_udV4l for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 18:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4451940462
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790793208;
 b=I6p4xpgllf8VMvXQ42/Y/zzdJRF2dBLWoh5IpBWdrQqBeZ/gBjt8ls4Z9PJG3ZvNCzVs
 iSsHrY7gGot1c3slYABU/FNLmyxRKmX1VCgiRmoPVEoRlAjr3IgF6rM733s4D1AQhlFnz
 X7EkTFqF4QUJpkgVUKrk44umxtsoEskkvxIfZUiM4JtF8RTBML5rsHSVppwQhVxseVXV4
 OMZ40/YPYtDcXUpwEJZu61aKhUmaGwJEm/m/sP1+cmsBKNg2LjNG6dJtr8J5J10Yo1qgs
 4CE6GBAr036ENYICqgnk2R3YU3LkkFrP+hcTrVrT5fSd0pNlep5YBRIhddHMbTl/y4A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790793208;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=ouCgva/zch0/LPo/0G3nyYwQ6X5tuU5gVDnPbUBZDFI=;
 b=Ntj4gD4yrIP9pNtY3wnNDLkk5UbWGf5QXCCn6NJbh8KtQr816/fbQVUFMXVcUHeDnuby
 3D7qwbFD/Hxe8Q24mPtMY/k6hKYncjQXmJb6yE5TGVlGJOpgd+1Avoo91jPD/U8/BTqnx
 XEZ9XpLd7RWhXkIv53lNYu08mmES6bU/syy72ZxCf7dySC6edBgHo3c3ls6xHbobqE+j6
 qq9UFqO4trXcr9Mmp9B4q/RQp8hB9y0lX8EcNIRWpGlt0OY3Gr2ydnUcuHmzZBjqpnEgO
 ad88GhmgoZWkm8fb9Pz4oGe3XJ6oMM5LpueY4VCXvKspI3U24kf/3j/g+DN87ct3kXA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rsvLjFnG; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rsvLjFnG
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4451940462
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:33:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AA74B601F1;
 Wed, 30 Sep 2026 18:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE38C4AF0B;
 Wed, 30 Sep 2026 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790793206;
 bh=slDBbU96fFHRxxMmZ2A0N39qOtTjzvaWnoGNG833eyY=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=rsvLjFnGZxbeud0f2RC9g+XkHIPIqc6rNqtUkgG3zG/hn8JATxsIGuIsHenKPoWHN
 gViT8I+wEYNSQA6tgpQzBx7Sn2M0QPnzb7RrxBuYr8ad/DXlNS6zLf8sTWNOyfHtw4
 EE2RxzmmIPIBJTKMeTl/jebn3Llb9AlWUMOHEJGr1p1paLtSeQ3aZPv0Wlvj1PnCAn
 QldbN/BKcNDlkHjllFNXlQpWDLteNfcWMagOTtbB3o48jjOo+KDt80yNnGuwUwIZZu
 tuLzVIufQdQRVuIdNGlWP42MTA+awCL2lGaH5sDLoPZpPiurgWpTADYMILoK51sj0P
 zSVxaWiADJqBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8DDCA5FC5;
 Wed, 30 Sep 2026 18:33:26 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Wed, 30 Sep 2026 18:33:24 +0000
Subject: [PATCH] spi: Probe a device tree device at the requested speed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-spi-probe-speed-v1-1-ff9aebfebdf9@iav.lv>
X-B4-Tracking: v=1; b=H4sIAPRVvWoC/x2MQQqAIBQFryJ/naAmYl0lWpS+6m9SFCKI7p60m
 1nMPFRRGJVG8VDBxZXT2UR3gsKxnDskx+ZklHFq6JWsmWUuaUUjIErtjA/OWzhjqVW5YOP7P07
 z+37j3n31YQAAAA==
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut@mailbox.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3232; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=ucldvmMd2tUcQ8A+jI6CtdvI+UNcNOU6CDWXM4CU9To=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFl7Q78EbO5Zt+TArxuF9praThEH2D/6KliciGiu2mNfd
 3P3zQVPO0pZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBE3NQZGd4GKv173mN1QJrz
 1Js7TG6KW1mb2I1Wbrhv7HN5cUTq/zCGP7yffO5P/a7a35fL2+VlGdN93D7ZLDOwsPjGZ+MEZbN
 TbAA=
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-Mailman-Approved-At: Wed, 30 Sep 2026 21:04:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Igor Velkov <iav@iav.lv>

`sf probe <bus>:<cs> <speed>` ignores the speed for a flash that has a
device tree node. _spi_get_bus_and_cs() probes the device, and with it
the flash reads its JEDEC ID, at spi-max-frequency from the device tree.
The requested speed is set only after the probe, and the slave keeps
max_hz from the device tree, so the next claim of the bus goes back to
that frequency.

A device bound without a device tree node already gets the requested
speed and mode before the probe. Do the same for a device from the
device tree, for the duration of the probe.

On ROCK Pi 4A the device tree sets spi-max-frequency = <108000000> and
the flash does not answer at the resulting clock, at any requested
speed:

  => sf probe 1:0 1000000
  jedec_spi_nor flash@0: unrecognized JEDEC id bytes: ff, ff, ff

With this change:

  => sf probe 1:0 1000000
  SF: Detected xt25f32 with page size 256 Bytes, erase size 4 KiB, total 4 MiB

Add a sandbox test for it.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested in sandbox (the new test fails without the change) and on
ROCK Pi 4A with U-Boot proper chainloaded from the running one.
---
 drivers/spi/spi-uclass.c |  9 +++++++++
 test/dm/spi.c            | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 120565df149..097c1ae665e 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -517,8 +517,17 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 
 	if (!device_active(dev)) {
 		struct spi_slave *slave;
+		uint dt_max_hz = plat->max_hz;
+		uint dt_mode = plat->mode;
 
+		/* Probe at the caller's speed and mode: a flash reads its ID here */
+		if (speed && !created) {
+			plat->max_hz = speed;
+			plat->mode = mode;
+		}
 		ret = device_probe(dev);
+		plat->max_hz = dt_max_hz;
+		plat->mode = dt_mode;
 		if (ret)
 			goto err;
 		slave = dev_get_parent_priv(dev);
diff --git a/test/dm/spi.c b/test/dm/spi.c
index a89ba06274f..4ea4bcd1196 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -91,6 +91,26 @@ static int dm_test_spi_find(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_spi_find, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
+/* Test that the first probe of a device from the DT uses the caller's speed */
+static int dm_test_spi_probe_speed(struct unit_test_state *uts)
+{
+	const int busnum = 0, cs = 0, mode = 0, speed = 1000000;
+	struct spi_slave *slave;
+	struct udevice *bus;
+
+	/* spi.bin@0 has spi-max-frequency = <40000000> */
+	ut_assertok(_spi_get_bus_and_cs(busnum, cs, speed, mode, NULL, NULL,
+					&bus, &slave));
+	ut_asserteq(speed, slave->max_hz);
+
+	ut_assertok(spi_claim_bus(slave));
+	ut_asserteq(speed, sandbox_spi_get_speed(bus));
+	spi_release_bus(slave);
+
+	return 0;
+}
+DM_TEST(dm_test_spi_probe_speed, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
 /* dm_test_spi_switch_slaves - Helper function to check whether spi_claim_bus
  *                             operates correctly with two spi slaves.
  *

---
base-commit: f8eb3469e1a17c79b047b3fd38ae820e8816a115
change-id: 20260930-spi-probe-speed-1628c684e624

Best regards,
-- 
Igor Velkov <iav@iav.lv>


