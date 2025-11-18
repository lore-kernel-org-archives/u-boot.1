Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6BACEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0627683E96;
	Tue, 18 Nov 2025 19:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AkvpHcZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1107283F15; Tue, 18 Nov 2025 19:04:10 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F9383E92
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c6dbdaced8so3874905a34.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489047; x=1764093847; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bmi0szKPNX9IreOndk652aoXDV97EjPDhDdF7NuxvVU=;
 b=AkvpHcZS8LqpJs7krJKFrK07VLFd9+N7Wm4U+2QZ9tRaDf4Jhf2FsMmBqRqdJ7VVO8
 iPv4LvDBKUVPRPUfMpl0OxLhy58NLL50EuI1nbQGjzvl5Ek4nW8aCow4AOjMJTxA0w0y
 NArTsZ2iCYtkuMMilO9Oqr3zGN+RhsNntbkqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489047; x=1764093847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bmi0szKPNX9IreOndk652aoXDV97EjPDhDdF7NuxvVU=;
 b=G/4xKVIBgMh0nHJl+8zskGgHb4ctS0/6voMhxAcePaCnGoYU+TDIE7yZfcIy31Tb+h
 3vUId+o9B+QRQkI2oxQ3rUd/gWAlyr6cSl3mVfTVMUDh//JmLFwtvVpsWUGO/S+n1VTj
 kXWMESj2CXkwCGeo6jJziizh7ACKqMlvitEVeRqahekbRWWVEXR3CPtWnCZi3GozWIDp
 onsE1BgTAvReMuZiapxxdFwz/S5dLPRELQq3UPJvKJSJfOS94BFPDH6Z0kC6B3OFqsCF
 Eh7L/Q1ZlVJXsrAAHyvkZgWdaTVic9AZv75l6+MNWpx3UhHDDtar6eBN3zq+sZ9PNaMH
 WEXg==
X-Gm-Message-State: AOJu0Ywlvvn2UCeRawMW6ZNlkYyOhaSeAKwc+SSLsYV3UmvA+odGMByw
 PdRCm0Dky/YEzPZ1zT+yB055WG8QQTV1ov8vcCkTueiin/UB9lJbBVvXPz+lyzn3vXol8RhvQuG
 /qcUWfF/cJg==
X-Gm-Gg: ASbGncutPLGxQpZvcO2Pkn7piNdoLahYEHbaUnyjo2zLqY2GYDec5RvFkS2waKbBo98
 dYAPRqYJhVfv0HnAXwI3lL6ZMlEWllPRIee7AbVbI1q98IbJa4ArXYnFk4JaRS8IhX5YdizQS4g
 i3Nk7fVZBiPzLXvxnvs5mEEVGuAjMdhImRMXFGAqv+QcY2/zL+QpjxTAiAxh1/jbXodvViJ7kgZ
 2DX+Dl3f1LJskUGtQSdtf8D5YrFxfkXoa+PivjVdHjH3cOwiFmD4nsxgCetbZQRs0IpQXI16lzL
 T7aNpWJqo69YYm5LtA31nfPDx81fhb1OmvEEh3hvNhxMHrLEyTX7PcbsQry5UDqg9ils9JDrdO0
 u5yUAXRO8JmFhgMNmIjMiPu1GNz4z9pknT7QOlPImKDNmHXKRwIre8V3VsM14YcLLFInYgy3JHT
 u2E8omDzvl5lrt4Gp/im4EJvv3hb/n0XTY3BmcTumki8FCneaL9uHWm9i47YaMMGE=
X-Google-Smtp-Source: AGHT+IGVuuJwpUtDBKweB5oLOBFBVj8djV8kFwq5rnuU0rDLWmZPanSjcSE5BXdmEe2hHQ3ddd8X3A==
X-Received: by 2002:a05:6808:17a4:b0:450:7f09:69a9 with SMTP id
 5614622812f47-45097604223mr8302631b6e.49.1763489046586; 
 Tue, 18 Nov 2025 10:04:06 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283a44sm6869055a34.2.2025.11.18.10.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH] mccmon6: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:04 -0600
Message-ID: <20251118180404.591132-1-trini@konsulko.com>
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

Cc: Lukasz Majewski <lukma@nabladev.com>

---
 include/configs/mccmon6.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mccmon6.h b/include/configs/mccmon6.h
index b64bf93bcb74..9f401718bfb4 100644
--- a/include/configs/mccmon6.h
+++ b/include/configs/mccmon6.h
@@ -35,7 +35,6 @@
 
 #define CFG_EXTRA_ENV_SETTINGS \
 	"console=ttymxc0,115200 quiet\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"boot_os=yes\0" \
 	"kernelsize=0x300000\0" \
-- 
2.43.0

