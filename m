Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831EACEE347
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A078983EA9;
	Tue, 18 Nov 2025 19:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iKp4evBQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04DE583E92; Tue, 18 Nov 2025 19:04:01 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0A0383E57
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:03:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-3e3dac349easo3332695fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489037; x=1764093837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4IEaZ+RNSYa79C45sOQn4GeG6ksWrmhZKbwbbiPwlcQ=;
 b=iKp4evBQ0EwVS75YmL8AsUgab9qJ3eqC4b4fu2hsksn/yiy4EIHi1+r+BHPeoTSWoA
 BYqPcQ0MI56SPsU3AsdOLGSM81Rme9xEHHY7oDSP48JUVFH8XbtxOA+E5HFePqO8nLvU
 TJHJ0lMaSDkmDbKilopFBOmIVaBlig1CtueNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489037; x=1764093837;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IEaZ+RNSYa79C45sOQn4GeG6ksWrmhZKbwbbiPwlcQ=;
 b=nJfdmCyR6xwLdXEnjnh3nNSVGVVoAtXZ/k7ymATdSby6WXt5PRwPLvIT92LO20t93M
 K1RRUa/NweCIEmlJ/XWDo5s3AXHxu9DqH0MnUHf6a5lAfeJfo/z+8MBLU7CUcjTskOcC
 hBX0cJ1Lzf6DrEKCIcZpLGIHXy9gRlVWVecpvlkFJiuhw4c4craDJF19CwFZcMcrEspc
 LqtJ6X7hqYW/t6oI4oXP/Fd7M6IN8JUqFRQhzqMoJVwZmCgq+8KKYcoLV2Jz6lWeS9gm
 pJA8/qpCgp09GjIQclwYEWrD4rc6yBNbLmMx7IvrY6F/Bn9CLa6P6HAKutYkieBcaQ0t
 tKzA==
X-Gm-Message-State: AOJu0YxP+FWVxfZ5+yOMjuoJGUM2yzAy5LWUUrpFdiXarVggRJZi5u04
 cJfgb4WEXMZdokaAhJfNSkcdZcdU4D8IqdLjCTk6lhSVecB8l/IX/uGry1u1HkTH4V0zE9FqH+y
 ac5jJhpeRUw==
X-Gm-Gg: ASbGncuTSYl+2QJ4C4unaSh7Cx/qlSlxw3GKU3TRwRSuFLOgX/79HWMC0ZXQEgfgr3F
 SVc0JIwRLYoY7y3MPmms7HDqKgAPyDMtNVIskXW5E3FCXiHr72YqewBMmDxdQGWg7S0rOK6KDCA
 vaZYDPgMZTmtjLJgAcnvgh9d7Q4sbEES21zCwDZjSqXP0eWlJxq35pBTCRb8/P0tER1Z/9jToQr
 5op+DpAuCSFwCxHVMLdbev6vQHCBIROYQ7p7Dn7cC8M5BGdkMT9dV6V7g5ipAMXUXpTpwBqUUXc
 fExktYrqvLIs2smvwXEazRlYDmbTkeqRYdiyoMEDQiFhp+a1ZPO1fgcJ/cDe1AhOSodNZs97sIG
 Y/wjxrDPuz52gnF3FTk1QJIFcxVBpEphYuFdCwA3994XNJLMU0o6OQ0Y7WFLum2XH+sKeXqxkdG
 2aB3Zmi697kJCKN/veLsRuGh7OFfe4Ii73qmKmhaB/vv+tXFp2+RQH
X-Google-Smtp-Source: AGHT+IEqqUtKKpxO4qUOcqJDlKGIxnJw+wFcOYBCfR2XcG7jDtCgPCG9KtcS2NU1s5cZtdXeQgl7YQ==
X-Received: by 2002:a05:6870:9e8c:b0:3e8:9e7b:4ea4 with SMTP id
 586e51a60fabf-3e89e7b4f32mr4423438fac.6.1763489037594; 
 Tue, 18 Nov 2025 10:03:57 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522b268fsm7298890fac.18.2025.11.18.10.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:03:57 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@nabladev.com>
Subject: [PATCH] display5: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:03:56 -0600
Message-ID: <20251118180356.591016-1-trini@konsulko.com>
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
 include/configs/display5.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/display5.h b/include/configs/display5.h
index 19d71d6066f8..c311b35bb978 100644
--- a/include/configs/display5.h
+++ b/include/configs/display5.h
@@ -175,7 +175,6 @@
 	"fdtaddr=0x12800000\0" \
 	"console=ttymxc4,115200 quiet cma=256M\0" \
 	"fdtfile=imx6q-display5.dtb\0" \
-	"fdt_high=0xffffffff\0" \
 	"initrd_high=0xffffffff\0" \
 	"kernel_file=fitImage\0" \
 	"fitImg_fw_sz=0x2200\0" \
-- 
2.43.0

