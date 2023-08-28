Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9494BC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 19:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD249864A0;
	Mon, 28 Aug 2023 21:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="XRd2cs/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A176B86459; Mon, 28 Aug 2023 21:12:52 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7828A86483
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 21:12:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 065BD3F6DA; 
 Mon, 28 Aug 2023 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693249969;
 bh=ySp3LnKjNpwqzZyaUeCqINyvEJ8eFhF7o/qgxt6DveU=;
 h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=XRd2cs/Fc/gKmckrXtA7VJyQOdXCkIWZV9Lrif5No2T33giqzBQJ7JSFyg3UOS5nF
 UC4YwNLbEgFBlulF73jmpJaP1la8Le5Dc42NZh+LeB+qtueDRI+4Hvw/RTKF0ad04n
 +vx2xsBAbm3crT1KVCE76YodTJ7oSwL1xiIRyk7IfDJlzIJ7n0rGRMifiAi7QkFFDs
 Ch9xe/2GYLO27etKYlTamSoPhPyGI59fZzeXMmEzdrSO4NGldh/w7gKg+rbPfegvOw
 lb1dw17sqQ77nOxPJZ8zsFjuWgO2Iw037NlzXD8NPYBUFeBFtU+Tkb01UOB0j/4xWo
 9AsQOJyBqgULg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] dm: event: document all events
Date: Mon, 28 Aug 2023 21:13:32 +0200
Message-Id: <20230828191333.77249-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230828191333.77249-1-heinrich.schuchardt@canonical.com>
References: <20230828191333.77249-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Provide Sphinx documentation for all events.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove non-printing comments from num event_t
	correct texts according to Simon's suggestions
---
 include/event.h | 97 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 6 deletions(-)

diff --git a/include/event.h b/include/event.h
index bb38ba98e7..f5c5d30a64 100644
--- a/include/event.h
+++ b/include/event.h
@@ -19,29 +19,114 @@
  * @EVT_DM_PRE_PROBE: Device is about to be probed
  */
 enum event_t {
-	EVT_NONE,
+	/**
+	 * @EVT_NONE: This zero value is not used for events.
+	 */
+	EVT_NONE = 0,
+
+	/**
+	 * @EVT_TEST: This event is used in unit tests.
+	 */
 	EVT_TEST,
 
-	/* Events related to driver model */
+	/**
+	 * @EVT_DM_POST_INIT_F:
+	 * This event is triggered after pre-relocation initialization of the
+	 * driver model. Its parameter is NULL.
+	 * A non-zero return code from the event handler let's the boot process
+	 * fail.
+	 */
 	EVT_DM_POST_INIT_F,
+
+	/**
+	 * @EVT_DM_POST_INIT_R:
+	 * This event is triggered after post-relocation initialization of the
+	 * driver model. Its parameter is NULL.
+	 * A non-zero return code from the event handler let's the boot process
+	 * fail.
+	 */
 	EVT_DM_POST_INIT_R,
+
+	/**
+	 * @EVT_DM_PRE_PROBE:
+	 * This event is triggered before probing a device. Its parameter is the
+	 * device to be probed.
+	 * A non-zero return code from the event handler lets the device not
+	 * being probed.
+	 */
 	EVT_DM_PRE_PROBE,
+
+	/**
+	 * @EVT_DM_POST_PROBE:
+	 * This event is triggered after probing a device. Its parameter is the
+	 * device that was probed.
+	 * A non-zero return code from the event handler leaves the device in
+	 * the unprobed state and therefore not usable.
+	 */
 	EVT_DM_POST_PROBE,
+
+	/**
+	 * @EVT_DM_PRE_REMOVE:
+	 * This event is triggered after removing a device. Its parameter is
+	 * the device to be removed.
+	 * A non-zero return code from the event handler stops the removal of
+	 * the device before any changes.
+	 */
 	EVT_DM_PRE_REMOVE,
+
+	/**
+	 * @EVT_DM_POST_REMOVE:
+	 * This event is triggered before removing a device. Its parameter is
+	 * the device that was removed.
+	 * A non-zero return code stops from the event handler the removal of
+	 * the device after all removal changes. The previous state is not
+	 * restored. All children will be gone and the device may not be
+	 * functional.
+	 */
 	EVT_DM_POST_REMOVE,
 
-	/* Init hooks */
+	/**
+	 * @EVT_MISC_INIT_F:
+	 * This event is triggered during the initialization sequence before
+	 * relocation. Its parameter is NULL.
+	 * A non-zero return code from the event handler let's the boot process
+	 * fail.
+	 */
 	EVT_MISC_INIT_F,
 
-	/* Fpga load hook */
+	/**
+	 * @EVT_FPGA_LOAD:
+	 * The FPGA load hook is called after loading an FPGA with a new binary.
+	 * Its parameter is of type struct event_fpga_load and contains
+	 * information about the loaded image.
+	 */
 	EVT_FPGA_LOAD,
 
-	/* Device tree fixups before booting */
+	/**
+	 * @EVT_FT_FIXUP:
+	 * This event is triggered during device-tree fix up after all
+	 * other device-tree fixups have been executed.
+	 * Its parameter is of type struct event_ft_fixup which contains
+	 * the address of the device-tree to fix up and the list of images to be
+	 * booted.
+	 * A non-zero return code from the event handler let's booting the
+	 * images fail.
+	 */
 	EVT_FT_FIXUP,
 
-	/* To be called once, before calling main_loop() */
+	/**
+	 * @EVT_MAIN_LOOP:
+	 * This event is triggered immediately before calling main_loop() which
+	 * is the entry point of the command line. Its parameter is NULL.
+	 * A non-zero return value causes the boot to fail.
+	 */
 	EVT_MAIN_LOOP,
 
+	/**
+	 * @EVT_COUNT:
+	 * This constants holds the maximum event number + 1 and is used when
+	 * looping over all event classes.
+	 */
 	EVT_COUNT
 };
 
-- 
2.40.1

