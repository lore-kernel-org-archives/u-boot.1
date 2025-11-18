Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA1ECEE348
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 18:07:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA8EA83F8E;
	Tue, 18 Nov 2025 19:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nbQATMTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 866C283F5C; Tue, 18 Nov 2025 19:04:24 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B40D83F66
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 19:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c75fc222c3so758604a34.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 10:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763489061; x=1764093861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e9VNbjdPH7pkgGYD5zr1Kmsup8NcIpmUbFXjBnNiUF4=;
 b=nbQATMTZ2agn5lneHhbfxJLXJsJBDAGiBQHRsThsAgZwuPB0LJeb1Ro5DVcXFKdN3x
 hAKZoFrXnCXrGIJ4QwinVTIiSV0V8STj7bnq7xhRX6jbEGxP6U23qyKlxvoxdLX1jVwz
 JFh6LTeqSiE5Ngz7EeAfMgzH+lToCmD980dFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489061; x=1764093861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9VNbjdPH7pkgGYD5zr1Kmsup8NcIpmUbFXjBnNiUF4=;
 b=ar3mXUx4OUIMogLHbmdBuYzlq/ZmopHkUkW43/hPzveqtNVK+RJnwb6gNVCwTeci5G
 klGYDtem95YYfgV/ej1AQ13VEBzfJwZ57w2VJfPt0rCxYTQ7CviSbAV/3ZSGGkxvqoWF
 d3+54M+3RIrY+KT70XZwlMohUqy5Gx86kVrQ0nzqg+WjeaFAITW8f/ERIrKk38R/nEVu
 xXbTTIqCfQxKnQGctIZtf0xLammD0o3NI/uITLdYv76dSQHphJuwdPiOjldqijc/hxbG
 9/Fs3w92mlY254NiwLJyDhOpTuIa+x8Il8o8497TM/vPKJ+5WcQFPkKlmOdXEFA+e9kz
 A0Uw==
X-Gm-Message-State: AOJu0Yyiw4fOFsfSbELUslPTJsPt2MfdmNNCBA0umQXpHjVg7A4jVcn0
 QlZsSVRUPwEBpKjYzeGWBL7Y2qWYzintPyQEfJnLbCbUprxB2GsYnr7znnJKd4cTw5R4OfNhZBi
 5FTNZmreEsw==
X-Gm-Gg: ASbGnctRS9G4ll+9PFNeu8OSkeytFuMOdE6rkt3+KnhHu88R3ZBVGo76jBS83IaQ7Yi
 tWZHHdGJb+uPgdEIh2aLY9XftuHwqmTACwxnTj90p93gVLh0EzanRInqxW1yB9w4m73F7ulGHpD
 q7J9pvbVFicyPKS0GiAWoHVyNLhRxHC3u5jlvayKGnEaUw6+77seHEuGCfxW5NUj0XgJk6hr+3i
 8PMVc60gsGKDGTG5S3OKL+BVD4NJkbl1jKjZcmmvM5tVwJ1675+W8YeeZjbYjxwoBcGl5N+nsRJ
 r8V3PBdr5S9uvrPPtfz7zLmBKzZgFFg/J+JLw6NZXN+Zb+IABDbsXHdioV612O8pJq++x5atyL1
 vfq1+IYMnZNmvUHVsp5fivf+A7+C4FDs02U4mcJz+VM+KpJto0idKaXP0B9hMmYV1DHalUwnOsQ
 Cli5pvYhjUZtg8i8LXOQUnVsOqPghEdvzM2SJXkmsMpc1d8IXMThPBA14x7b0Nbyw=
X-Google-Smtp-Source: AGHT+IFOoFGTYZLyNA0n4v1wsiKvBdk8O2ydkOLGpz2+WsWsmw8QpOf+j6P213BiIgTkIPyfmkY0Ig==
X-Received: by 2002:a05:6830:dc8:b0:7c6:8c73:aafb with SMTP id
 46e09a7af769-7c744594aa5mr8972579a34.35.1763489061119; 
 Tue, 18 Nov 2025 10:04:21 -0800 (PST)
Received: from bill-the-cat.. (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a28428bsm6907949a34.1.2025.11.18.10.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 10:04:20 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Adrian Alonso <adrian.alonso@nxp.com>, Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mx7dsabresd: Stop disabling device tree relocation
Date: Tue, 18 Nov 2025 12:04:19 -0600
Message-ID: <20251118180419.591299-1-trini@konsulko.com>
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

Cc: Adrian Alonso <adrian.alonso@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
---
 include/configs/mx7dsabresd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/mx7dsabresd.h b/include/configs/mx7dsabresd.h
index f5ab47207504..b08bbe94667b 100644
--- a/include/configs/mx7dsabresd.h
+++ b/include/configs/mx7dsabresd.h
@@ -57,7 +57,6 @@
 	"script=boot.scr\0" \
 	"image=zImage\0" \
 	"console=ttymxc0\0" \
-	"fdt_high=0xffffffff\0" \
 	"finduuid=part uuid mmc 0:1 uuid\0" \
 	"initrd_high=0xffffffff\0" \
 	"fdtfile=imx7d-sdb.dtb\0" \
-- 
2.43.0

