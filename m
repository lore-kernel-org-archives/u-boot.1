Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84827C4167B
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 22:37:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45E0E87285;
	Sun, 29 Oct 2023 23:37:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698619076;
	bh=eTJuUvVQA6FgRNfgO/wGpCUCFW1r6/na77G25+V0fIo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vT1amOEaB/e+LRAM0leyko8aPFxuRSh9mUoSn9rAq0tvk8KdxdbZQ9d63kzlQ/gq+
	 WCbkWay6SfQ+WQn8ZNYGol/TMMx4h3KvFfVQI8yCC26ELgdP5Y3FdjZoW0Qj72D88e
	 wKEns4z6KyZibyhS0IPbtirT/n98zqyvCJyGIUtvBJSOH4Tr1kJApzfH4PBLnpVCET
	 3r2JyaIdAEO1ki/aZOUOJSX6zHMVbf/GRHqMPjO/rNubgHViMip+RuitNTZieHd0PP
	 7W5VgvC26etkFuaqcy8x6wXkoKtCs2Yo5eRNcdxuxld7hEW6XZIvQWYSJpSnPkG8Kl
	 VL1R8MZYV4B1A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9BCCF870F8;
 Sun, 29 Oct 2023 23:37:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1698619074;
 bh=eTJuUvVQA6FgRNfgO/wGpCUCFW1r6/na77G25+V0fIo=;
 h=From:To:Cc:Subject:Date:From;
 b=palhZ4tq52vxCT+x16KZUKH8HLS9f81a72PUvzv/oSPL2OPIa93rLdncs+7NgFEck
 EjPlDkmZ5A6TG8hZ0GassQOvHb/Qatm5oS+/WAvwY/pfOrVXVjXTcyqPko8+mQ4q5t
 NRClu8JMYEzONXxQQBTSfOtkEPxAnHiMxkjpZnCBjvPWSWxImYuKZjVN9oED9M9lAi
 W13ILcT+wMJkFzAZYirfStW9q3jm05Pcf7PZoAOHowje56diT+/cNvi0v5sHGEISP7
 nwYXEPqcN1PhQ1WI0uf90BUp7ue50o/LWGOs8/hmrweCEF598VJuqYq2F+c1Gncduu
 iVtHzb0Y9xyvw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] dfu: mmc: Add support for exposing whole mmc device
Date: Sun, 29 Oct 2023 23:37:22 +0100
Message-ID: <20231029223740.284149-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Add support for exposing the whole mmc device by setting the 'size'
parameter to 0. This can be useful in case it is not clear what the
total device size is up front. Update the documentation accordingly.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Tom Rini <trini@konsulko.com>
---
 doc/usage/dfu.rst     |  5 +++++
 drivers/dfu/dfu_mmc.c | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index 68cacbbef66..8845a71df36 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -121,6 +121,11 @@ mmc
 
     with
 
+    offset
+        is the offset in the device (hexadecimal without "0x")
+    size
+        is the size of the access area (hexadecimal without "0x")
+        or 0 which means whole device
     partid
         being the GPT or DOS partition index,
     num
diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
index cdb3c18b01d..12c54e90ef7 100644
--- a/drivers/dfu/dfu_mmc.c
+++ b/drivers/dfu/dfu_mmc.c
@@ -386,6 +386,16 @@ int dfu_fill_entity_mmc(struct dfu_entity *dfu, char *devstr, char **argv, int a
 		dfu->data.mmc.lba_size		= third_arg;
 		dfu->data.mmc.lba_blk_size	= mmc->read_bl_len;
 
+		/*
+		 * In case the size is zero (i.e. mmc raw 0x10 0),
+		 * assume the user intends to use whole device.
+		 */
+		if (third_arg == 0) {
+			struct blk_desc *blk_dev = mmc_get_blk_desc(mmc);
+
+			dfu->data.mmc.lba_size = blk_dev->lba;
+		}
+
 		/*
 		 * Check for an extra entry at dfu_alt_info env variable
 		 * specifying the mmc HW defined partition number
-- 
2.42.0

