Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE71C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 324A18789F;
	Fri, 26 Jul 2024 14:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B+g1W0ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCCFB878ED; Fri, 26 Jul 2024 14:36:42 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 516F68851E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-399020cfbb7so6045305ab.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721997398; x=1722602198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WMKNCz19x1f4NAor4E2/K9hsfQ0G53w7Js8csxafOCw=;
 b=B+g1W0mlaeD5/fM1xTpxURYhksTeAWbXEIxjiFoOzx3CGTssFWWnanqXVvq/86r4go
 Nkb6R/xbHH/AlPFtXrAULJQjMSz+4M9Vbn9JZzH0TLLEhK1xOPCi5k5tO0bg30ebu5nP
 eth2/tn3FJFYwj6VaL/KnKMHN6xYMvJq6A1S4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721997398; x=1722602198;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WMKNCz19x1f4NAor4E2/K9hsfQ0G53w7Js8csxafOCw=;
 b=gGcUSEYIckcWQM4wyW3P2O0IvE7RrpUeBh86LVR9arx1QHsGNigzX4Nf0jFKJ+GDn2
 x5/mKR3Cnv/6QTLrEatcUF8naTNCiwc/QdaxZKVfN3QjmywzLEqKWdh1oENEG5SWJh7g
 3AmMiHjYq/zSVH6NxbrJzoOYurVpop7u5FWCCrOK7IBnRWd5pZ7/pvUSmc61srRgFoiB
 jvo67IH0JPlndCMpWFEwEDE4367hzJrZrXw3z2EohhxdLpBoYDD0mTc1j69WP5pxz1bS
 f9fELq8NAJQL48EovWCiQ7ENgx//n38yYhhmifq/P1e2n/PjTQrkyvK82PS4EsNm4vM6
 2+sg==
X-Gm-Message-State: AOJu0YxI7MZW7ISnLe+PRt9kngnXvaC2n6UsLQW/Gz9C3aWXEwrC9XgV
 EeaYDBcREiyUOqSdnY4pieIN8mbadrB+wymHkHvM8EmBK9IOCwpDFvf93U8JynzMrmTiyElfSXg
 =
X-Google-Smtp-Source: AGHT+IFy+//jL224YjXi7cJPw9NkGJk3lU5GKBIdPcBfH3GGCT307TKsBXy8CuEA7zy9hoUr5uRmfA==
X-Received: by 2002:a05:6e02:1649:b0:39a:e9ec:9470 with SMTP id
 e9e14a558f8ab-39ae9ec9732mr11543815ab.17.1721997398080; 
 Fri, 26 Jul 2024 05:36:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22f13e43sm13908275ab.63.2024.07.26.05.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 05:36:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: bootm: Drop old USB-device-removal code
Date: Fri, 26 Jul 2024 06:36:09 -0600
Message-Id: <20240726123609.57191-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

USB is stopped using driver model now, in dm_remove_devices_flags() in
announce_and_cleanup() at the top of this file.

The usb_stop() call actually unbinds devices.

When a USB device is unbound, it causes any bootflows attached to it to
be removed, via a call to bootdev_clear_bootflows() from
bootdev_pre_unbind(). This obviously makes it impossible to boot the
bootflow.

However, when booting a bootflow that relies on USB, usb_stop() is
called, which unbinds the device. At that point any information
attached to the bootflow is dropped.

This is quite risky since the contents of freed memory are not
guaranteed to remain unchanged. Depending on what other options are
done before boot, a hard-to-find bug may crop up.

Drop the call to this old function.

Leave the netconsole call there, since this needs conversion to
driver model.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Shantur Rathore <i@shantur.com>
---
The original patch was here:
https://patchwork.ozlabs.org/project/uboot/patch/
20231119121144.v5.5.If206027372f73ce32480223e5626f4b944e281b7@changeid/

 boot/bootm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 376d63aafc9..480f8e6a0e6 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -740,18 +740,6 @@ ulong bootm_disable_interrupts(void)
 	eth_halt();
 #endif
 
-#if defined(CONFIG_CMD_USB)
-	/*
-	 * turn off USB to prevent the host controller from writing to the
-	 * SDRAM while Linux is booting. This could happen (at least for OHCI
-	 * controller), because the HCCA (Host Controller Communication Area)
-	 * lies within the SDRAM and the host controller writes continously to
-	 * this area (as busmaster!). The HccaFrameNumber is for example
-	 * updated every 1 ms within the HCCA structure in SDRAM! For more
-	 * details see the OpenHCI specification.
-	 */
-	usb_stop();
-#endif
 	return iflag;
 }
 
-- 
2.34.1

