Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B251C83F3E
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 13:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86BD086977;
	Tue,  5 Sep 2023 15:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OAwojH1Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P7z5rfkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8324186580; Tue,  5 Sep 2023 15:48:27 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C97486940
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 15:48:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Rg6KM6rGjz9sqP;
 Tue,  5 Sep 2023 15:48:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693921703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMoS1ha08ox69WNWCHiZ+3yWa4XgUeMDYRFv6jFDzSg=;
 b=OAwojH1YUHtB0gYC0XXsGVUFJTZKHfdWbKRPgy2+/PazROcOtaHa3HmTXrgLx1wiCSkbVR
 UM9wgIn1cFv3ERlStB3aYjbR7StXQ//KnNls40u1+vFAn/VZexbIoaaSX2DmPxeMDxtB7V
 UaOhHft5OYNPLkNdy8C60tQugA3C5io9ie7TXa9E6xT8MIzHC6HFXoXL1elNGHOaFPy17H
 OC8nOezHZstS8zwCcgK6O9uwfn4XJ9gw7Ezu4mlGgLzMFjjWxCu+aa4p2l5VxeVaUcLa4G
 cwZ2Q+bO83IaMvv0QeQR6y1RqSfmfCcU/ERM9Y4k1NfTAmk9REHx6flDKFjocQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693921701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMoS1ha08ox69WNWCHiZ+3yWa4XgUeMDYRFv6jFDzSg=;
 b=P7z5rfkVMMDdsr8nOi5EMgR8+mQoeQYSTUbaQS/wxIUVzud+VC7BTXRxQCjVG6/5iXI+Yn
 eYLCZqzbSc4+GurtW0lPWFH40P9F0H66rW7YehdFxxBw1A26fxtz2BRXDp3qA+Dk9ME1mx
 BkGeLtgkoPQGL4uwIaBoYAeOmpJA029XlyT2jY0IapJ+kn71S9mKyYBIjBcS0AauRm5Qcl
 TNOClVqSlIqZSvKEaAaaJl94G921FBVAPLz7cCR0VxTwVA88LCBPv7OU40SdfBnA+voplf
 7/xi6oRc0UtfyLWuRuAr3MT9+j3n6grx0YqKOAaKSQbhWg4sR1UO2BKaKwxlSA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Chanho Park <chanho61.park@samsung.com>, Leo <ycliang@andestech.com>,
 Nikita Shubin <n.shubin@yadro.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH 2/2] event: Rename rest of EVENT_SPY to EVENT_SPY_FULL or
 EVENT_SPY*
Date: Tue,  5 Sep 2023 15:48:08 +0200
Message-Id: <20230905134808.14744-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
References: <20230905134808.14744-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tjmeyuyqmokji3ifiy88ejjaiznrpqt7
X-MBO-RS-ID: 8bb3aaf2436a7641854
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

Fix up remaining occurances of EVENT_SPY with no suffix.

Fixes: 6c4cad7438 ("event: Rename EVENT_SPY to EVENT_SPY_FULL")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Chanho Park <chanho61.park@samsung.com>
Cc: Leo <ycliang@andestech.com>
Cc: Nikita Shubin <n.shubin@yadro.com>
Cc: Padmarao Begari <padmarao.begari@microchip.com>
Cc: Rick Chen <rick@andestech.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Yu Chien Peter Lin <peterlin@andestech.com>
---
 common/Kconfig  | 4 ++--
 include/event.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index d916194b942..bdc02f75620 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -620,7 +620,7 @@ config EVENT_DYNAMIC
 	bool
 	help
 	  Enable this to support adding an event spy at runtime, without adding
-	  it to the EVENT_SPY() linker list. This increases code size slightly
+	  it to the EVENT_SPY*() linker list. This increases code size slightly
 	  but provides more flexibility for boards and subsystems that need it.
 
 config EVENT_DEBUG
@@ -648,7 +648,7 @@ config SPL_EVENT_DYNAMIC
 	depends on SPL_EVENT && EVENT_DYNAMIC
 	help
 	  Enable this to support adding an event spy at runtime, without adding
-	  it to the EVENT_SPY() linker list. This increases code size slightly
+	  it to the EVENT_SPY*() linker list. This increases code size slightly
 	  but provides more flexibility for boards and subsystems that need it.
 
 endif # EVENT
diff --git a/include/event.h b/include/event.h
index 311df878c4a..5fffde960d0 100644
--- a/include/event.h
+++ b/include/event.h
@@ -282,9 +282,9 @@ static inline const char *event_spy_id(struct evspy_info *spy)
  * {
  *    return sandbox_early_getopt_check();
  * }
- * EVENT_SPY(EVT_MISC_INIT_F, sandbox_misc_init_f);
+ * EVENT_SPY_FULL(EVT_MISC_INIT_F, sandbox_misc_init_f);
  *
- * where EVENT_SPY uses ll_entry_declare()
+ * where EVENT_SPY_FULL uses ll_entry_declare()
  *
  * In this case, LTO decides to drop the sandbox_misc_init_f() function
  * (which is fine) but then drops the linker-list entry too. This means
-- 
2.40.1

