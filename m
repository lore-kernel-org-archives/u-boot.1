Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B5DCCF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 14:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53AB83F9C;
	Wed, 19 Nov 2025 15:55:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SGSdsj0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EB7D83F8E; Wed, 19 Nov 2025 15:55:22 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 499AF8004F
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c7827fd898so665012a34.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763564119; x=1764168919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kO1gMC1IOVaGgKnaI4yFPBgMRzvI1+Ra1iZ2obdg068=;
 b=SGSdsj0+CoQ5nurpXz9iTDj/E+4x+143UbqoY/lTYGj+Ef7QuQXGl6zbwl+itHPF0S
 cbLr/OEoOn4byT03Ono0vyQ/DPQMXtLluzhTJtxuZP5+J65xy69MymxapEOgxTC/ODAo
 JkNnSRfbQ6Yyw/voYEkP6gkw8FF3QOpJjcOBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763564119; x=1764168919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kO1gMC1IOVaGgKnaI4yFPBgMRzvI1+Ra1iZ2obdg068=;
 b=LVyV1pMXCaOoij6k78gE0+B0deG27KG1cEHTXoTrR75AlsagxRUAgxBshIqURaARzl
 FpEYUCtrVXQQwL4X/ahSiDB7rshAv8mS6JwUAKvJmzt5eP6YNIx5gJ7WAhzSWhMgLhrN
 /hYOxP66jlm4Hs7qR6VBAbzlGezLN/2F1ZDoJMnXobA7xsM0mAT2dAiy78Gm0YsDyKNM
 ApxLeXzjoBDKfg0ict+xM/7nLlOZkvx4Te+V4dFAZ7lmF36arinZVJgJaZvaDq4c8IE0
 gUdySDUUDSRICZf+jXzcsPxIHw8Zlyh5qgWXNu25kf2PNwSRylLIFYIBf7JBSvb3iiRY
 KV2g==
X-Gm-Message-State: AOJu0YzfrB4ukgTe6FbeV6+edz6iFEsLafd+3eF/15Q0l7J3O/UjY9dR
 YRLf5RtXx1tYdp6xvF5geSX25QAowUXxoJA2r/leMOxXL9xBAZDgsskM3Mbt7ND8ns7gjl/sbDP
 cFEnbLH1aCA==
X-Gm-Gg: ASbGncvIzx/3un7d71OcQkd0JM1AXlsN6NeKOXQPYppiQitomHW9sKMMgvGoXlzbz2k
 x7514tBtb1Db42TtWS8b8/2A6FVPGm+PR+wuA4qSsVg11+4OxxlQFtej2Sym8vGBF0Ja+r/Diw3
 Gr2HD/FSYSj+AFmPtHkvPBJ0ibe7KJwafTN7rruP4WKzNp6wVadGcC0rXlS2zhF/RVFO+hUViD/
 HrtzgmRk2WjPClxgdH5uAwDIQZPYs+ieAg6k4Z/2XH4pcqqtLwbjSM2BQkxVP7LxMBQY+WqhnCM
 QOCdLvdv71nO8ZM2QGb4SH+M47qgNbCbeuUwXFThux9bCbCRAqNY2vSiLzT82ZF93joB4r+/YGw
 ot0TKTSYRfoQfUXjPtMzDuvGrGEjMg7NCSN6nOAZm1gJlLNdorah9Yr7r7F0IxkGiWbGBsGRWpo
 b9vUZ7qaK0OUKJ38fiuu5UG3pRWMvWoTUSrQ7shKmBow0QepnpUSGl
X-Google-Smtp-Source: AGHT+IHVKBj5E/hwWPPVx44C9DdjELxRLFrt+6TL6gjW+zD7R9vkUizCPxi6k3DwFbBAJgFcwushnA==
X-Received: by 2002:a05:6830:4409:b0:7c7:dc9:40a1 with SMTP id
 46e09a7af769-7c744482811mr13414332a34.4.1763564119029; 
 Wed, 19 Nov 2025 06:55:19 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a392fa5sm7833333a34.19.2025.11.19.06.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 06:55:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH] qemu-arm-sba: Stop disabling device tree relocation
Date: Wed, 19 Nov 2025 08:55:17 -0600
Message-ID: <20251119145517.843161-1-trini@konsulko.com>
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

Remove setting of fdt_high to ~0, which disables device tree relocation,
from the default environment. Doing so prevents U-Boot from correcting
problems such as having an unaligned device tree and leads to various
failure modes in the OS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
If there is some window of memory that must be used for where the device
tree is relocated to, bootm_low + bootm_size (or often just bootm_size)
or bootm_mapsize are the correct way do this. Please see
doc/usage/environment.rst for more details.

Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
---
 board/emulation/qemu-sbsa/qemu-sbsa.env | 1 -
 1 file changed, 1 deletion(-)

diff --git a/board/emulation/qemu-sbsa/qemu-sbsa.env b/board/emulation/qemu-sbsa/qemu-sbsa.env
index 88fdb0ec1c59..85e457cd47f3 100644
--- a/board/emulation/qemu-sbsa/qemu-sbsa.env
+++ b/board/emulation/qemu-sbsa/qemu-sbsa.env
@@ -5,7 +5,6 @@
 stdin=serial,usbkbd
 stdout=serial,vidconsole
 stderr=serial,vidconsole
-fdt_high=0xffffffffffffffff
 initrd_high=0xffffffffffffffff
 scriptaddr=0x100000300000
 pxefile_addr_r=0x10000400000
-- 
2.43.0

