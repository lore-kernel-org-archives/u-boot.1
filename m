Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6FE1099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:54:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB2B28405B;
	Fri, 20 Mar 2026 21:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HliEHca6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBF283FED; Fri, 20 Mar 2026 21:53:34 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B9DE8394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d7e5e8c907so1222389a34.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040011; x=1774644811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T4hUhaf+q52FMW8lD0Xgbi1rn7II4VHTpIDAp8WAiW4=;
 b=HliEHca6tP1zrGQ1MCxv1xC0PcPZMr05mEjSYHmg3Xbeex66aWxB9SuKjKr5HnWp37
 BON+Oxb/XkygLdCHnd1qhHRvfQhfW9htD/lfd8+tcqD4Z7bTdQxGJdzV5zPMWpOfO1PJ
 GaVP4hW+QDSYhJ+jsuEeHK2doDLsa+0Q1I1bU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040011; x=1774644811;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4hUhaf+q52FMW8lD0Xgbi1rn7II4VHTpIDAp8WAiW4=;
 b=FLKYmn3twcW4EYXPvHuzHiZ186KTw8FsXUBqW5u2/ANpvt5Cn62xLYT2p6ZvFuanjF
 Go3xNfhJSo3zoZW0cP8lUnpsALsZMAgvmt/xEDXXhnK5kpLqIHWnpefDBu3LGwvLLtiO
 SDBDYnikhrfqZykxzb3hxuHVTfv3CE83hOYaz6ffaGs15Mafv4RH1pWSgQljfdpsuRXQ
 L5HIml/665fgDK0ssyafIArJTwvf4ZgTkjzE279zTi4pyJt8iiEJEEvF1ugrFZsoYYdf
 VQOQ6jdc1La0qTqo1p/89DNth+mzAJ5cqlnKql3x59wFhS8g06IUY+lc3qy0NMMY3mc1
 Bs7w==
X-Gm-Message-State: AOJu0YzaE+uKGhCxBHWZHa5Qs/iSRDTamshGisLRfQI90hZk0nGOVVyF
 AaMTNNZQcAcbgAuOMeJ5SU/m6W6jltwvCv9aQO5por/fdJvkXOE7+dPbj3mchgiBOpjdKeN0sRA
 Bc9lun1U=
X-Gm-Gg: ATEYQzx+ikZchwD0cpsspP4Fny2/suMQu9HqchG9Q5ch1AAzOWwi5Rp/6zTx72vKJ5c
 P0D6uMy8b9Y1TKSmdH6FuVu0dzc8Lj2edVp3OvaJ8giCGLxhjQ/WGyP2MVZ9GsD0nqlqLXmPxpo
 d7Uzln8AFfMgoN6cv3E6CZUObFJrQTzk5GKFdbTE7uqsX/Ld0PAvYscRxCOa/tCVd8lMLK9/7xR
 5xQk4lITe2JZ8+PQyxf+EbeQZlnqKsLkqWrEq4I2wS3BzcDfJeCOru7rqEcuXlH6CcnuHi0SarX
 0mUSwUu6jB7wbWCO4IrxMaIC5mo1CZkod7Pm4uf9gwVf9kYBdcQdbOFySNHDhfbz4m1EehwVK/0
 3qY6g72huGPqpkMp4BK/arNIuHIHX/P4EDxGM/lqrKdvISmKWaItnzGY0W/hTz5KhDew2e6/rbm
 ijeY9+UGcsTWYJol/vNWJkzD5Jho0K/XucLNYuTHC/q0sUWeYbqbcXyP/r1IAO7gNDlLugp5wJx
 vzSwf4K3x+YjvgAM2WtD4W7E73QZ5d6RSURkEDjd6HP//4RYVI=
X-Received: by 2002:a05:6830:651c:b0:7d7:d0d5:5bf6 with SMTP id
 46e09a7af769-7d7eaf4f4femr2742095a34.21.1774040010789; 
 Fri, 20 Mar 2026 13:53:30 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadcb11csm3156455a34.13.2026.03.20.13.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>
Subject: [PATCH] net: lwip: nfs: Add missing dependency
Date: Fri, 20 Mar 2026 14:53:29 -0600
Message-ID: <20260320205329.3788642-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

In order to use NFS with lwIP we need to select PROT_UDP_LWIP.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jerome Forissier <jerome.forissier@arm.com>
---
 cmd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index 667c4e0ae811..f459f6b029c2 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2221,6 +2221,7 @@ config CMD_MDIO
 
 config CMD_NFS
 	bool "nfs"
+	select PROT_UDP_LWIP if NET_LWIP
 	help
 	  Boot image via network using NFS protocol.
 
-- 
2.43.0

