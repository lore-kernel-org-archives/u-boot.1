Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04A7FB5E8B
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0788429E;
	Tue, 17 Mar 2026 02:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fQzPRwSZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 455948413A; Tue, 17 Mar 2026 02:24:44 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2898984246
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-466ebbf7ff7so1722949b6e.1
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710681; x=1774315481; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NxuW+MO+OILDPs2edPWhzGsE9G7EPqelqer+/vm1W4A=;
 b=fQzPRwSZFiIJZAP5JwM8rtld4//sqOiEryWYtAmlV4QJk1WeXjijYg5Pv/qCt39JFc
 4EfGhL1kOO0skin/c5c8ZcJ0IFdcdQ2OwGDIRormiDeiNGexCHvUWBO2x9PHiNF2FNE+
 pxvXBBSrYbAQw2aEdvkQlADx0TFt3iMnPDBZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710681; x=1774315481;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NxuW+MO+OILDPs2edPWhzGsE9G7EPqelqer+/vm1W4A=;
 b=qNUN/NzJy/lt5BKsRuRxfCwS9vwJSbF8ij+kIC3N1AcD3g5/V8tZkp2cuN8ndG+MFD
 t0YNCTIKH/0QvPy1WGN9yXH82TPUBa4ticBlXqVB6nHp5uZX5PO8SdYBpltWtfWg9CHr
 hJOUMgiwiW094ATmYr824MIOR2D4sIV+PD2C9iyyzOxakl54GEzXDX6XFZt7nmXQNhFj
 ab5FzHAvdW92OtWlLqX7S2SkTib7vFAvZuY8CblwMvFGKsHq1RiiPDBaEi0eDOa4eOWU
 jXHhl8nRgQqP5zaLgV10M9hWc+Uw8GX5CX8EnP9hthr7b+MdVt1wASg93OkkxEeux8WE
 y0Jw==
X-Gm-Message-State: AOJu0YxVsTjr+IJq1hH7uqCa3Yl50vYtifRHgrYwyulUsruu3/jYY+NE
 0lS5EmLAp0GbYxByi8ujBwVAU+hWqVnnQckad5NU9fIEEnIsWdBx4N+LO03UtRf5jYlEwiwGHgB
 bVLvJyck=
X-Gm-Gg: ATEYQzwC5fLcNJN92+RTb8KzDrlJ+lb8eT28ok+F3VoS+qnN5AEmWaKRCx5aJvt/RbA
 OnGo+mpcmE7s3Sy6dtGkP4CYiULh6AbrWw1PvKd/fuSqCGDgmP4IYtV5R2Ll5gPWpE4zva5ty6Y
 qcDBNmyMo22DGNOQiuNBmw4LOkLF5xBzJdj28zQtxqKzTPOh7xxB5V+BY6yxHP2QLRJbYU5b3jN
 fXbP8VAQrRK4KIo56XLV1A4HD4s9vfxGPSYBU+wg212ZxZ+C2harlpqzq9+zVxUe0oJ7jTKPsWa
 1d4fCmvXmBUWFAIS85W3lASR7Tz14DBzbW5OwXXzr7GLzmh9OariEuRzO21f9xnD/tzlylvQmS3
 EQsjH10S4ZdSABPW0CG9hRKH5mmQuS6a0wTBzz3EdjUTskl0i32M72rnvB/bI1/8hpHafmEhnG0
 jhDrT6ATxV7SQdnn0ZIz+XfDvuukC7tRWCcXoFi2M20Zo8s2tZNbuoLeaCd95pfCCczEz53DWtY
 e4vCsJAJx4ikoXoZ469BqLjdMC/SczQkvkDIkmpzW24NGWp1aI=
X-Received: by 2002:a05:6808:344c:b0:467:1c9e:2121 with SMTP id
 5614622812f47-46757037223mr8234054b6e.1.1773710680848; 
 Mon, 16 Mar 2026 18:24:40 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734160cebsm10440463b6e.7.2026.03.16.18.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Subject: [PATCH] misc: Correct dependencies on QCOM_GENI
Date: Mon, 16 Mar 2026 19:24:39 -0600
Message-ID: <20260317012439.4162568-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for QCOM_GENI. The symbol PARTITION_TYPE_GUID depends on EFI_PARTITION
and this driver cannot function without both being set, so select that
as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/misc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 798f1dbf26cf..b2dfc7f5b663 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -86,6 +86,7 @@ config GATEWORKS_SC
 config QCOM_GENI
 	bool "Qualcomm Generic Interface (GENI) driver"
 	depends on MISC
+	select EFI_PARTITION
 	select PARTITION_TYPE_GUID
 	help
 	  Enable support for Qualcomm GENI and it's peripherals. GENI is responseible
-- 
2.43.0

