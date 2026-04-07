Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E3FF5104
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 15:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 122CF8404A;
	Tue,  7 Apr 2026 17:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qQ0xqf4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FBCA8405F; Tue,  7 Apr 2026 17:37:12 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1050A83F75
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 17:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-35da2d35eccso3230820a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775576228; x=1776181028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=k0lops+nRe/Odc6I+t4G7hvuzfGkqQfM/3HU5H1eI00=;
 b=qQ0xqf4cv0jNWzJ8nEhaxpuDVMMQ5fq/SrZ0SRB2glDzO/K6fxRkH+zhaortNC0Cuj
 1dB2Fzge6MINXv96LCNhP5bfztP7o75HptNxJJ2FpCvJPp7KgklE0XZfoDRTUUdI1hnV
 fmOMusxlKCbXJ87S3f5SzQkpeUy1/e/L2ckyH3N0AUCUK5fb+VFzdDkgg4FiCs9iAFTw
 qDG2mS9b02fs0rNgnTo28roez9iHv3ezCj/HaVZxJJlSP3Y6ate3sOKmpBBWTx8AcUuR
 UO9s082qhGiuxOXSJ1AwlvgE7BZe+cBy34amhpmZ56pIChjvf+MGqasKI1/GsELu9XUQ
 2RiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775576228; x=1776181028;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0lops+nRe/Odc6I+t4G7hvuzfGkqQfM/3HU5H1eI00=;
 b=h61TWQBs7CjuAm8tBKNp25GZkTAMZI7/JJRyq5+O8cvAWOKJxDmTcHFjUnINnkLA6u
 FgWvDNPsJXfhqRNzg/KkZ/ZRqgrrd0n4DN+azxOc3Eg97Y/A1q3hX8N0WfaYY38H5URs
 vEi15Hvlry0niyr+NSS++yS4YzjqPxoiqTidm1BKCA+peMzE9mRnZZUEa9b2jx72V2VJ
 VJZmwp237Pf0lkyJm1cEa8QXuODmu2GRjyxudpXLteLQL31x3GsSEcmLGZ1TSvvG4Oy+
 VDBnfRmV2MiaHTPpnRfBKtG8z1pR3pmHDMCc55dTy5cq08RToK9gRtmHcgjEJd3gcc2v
 iEeA==
X-Gm-Message-State: AOJu0YyKjB3PFSRWBBfHgtVB/xTaUNGkl4CzdVEyxfI5mmsqnMx78wMQ
 SbYX78gZSRpcKHXE90Yj+eiNhDulhL3nwfqQNpUh703sgtlWadaYPRC/AnQTiA==
X-Gm-Gg: AeBDieu1c8ZAhwC0YdOAL1SF3baNhK5xZSyU7pg+cqiAsQvjTS8zJYnJF06J6RBvG3m
 Of6Z3DworYXG1hfakzq0WkSn+pQIwK76LFu8xC0FowxWaeSg+lf1YLuISYcUBeThpx/4EWQo7Vl
 LzibR8WWonIy7+aAwDy3GSqbmGQ2w/IBWxRe8Hl1c5qOOpLO3mNLLhYFMlxXNub6PPLpyvslhIx
 nqG+SIQeIRshlda7SN4QBO+17XrOqydSXb+gb0VDByykJlAGWMwBPHZQigtgijjLoSXkscCwapC
 qdywZcHS1J6XkQxLIgBXbxhoci8PSBT1pb4LqdisfdLaQB4yi8fbQGNgRz9GoUpmbgiOCS3h9Lj
 MN/nZPCSUuZhUximZ3SHfDm5iMnNT0qslKtttGdyedQbf2ZmT5NrpoKfBP+4A4fMvx2oOhVAKZk
 N3U+XRhxBy0x9yLPm7hXSB+fyYGKTpKle98bLSkBYivW2Hp9S9JbjToas=
X-Received: by 2002:a17:90b:6cd:b0:35b:8d89:719a with SMTP id
 98e67ed59e1d1-35de6970260mr15912517a91.15.1775576228168; 
 Tue, 07 Apr 2026 08:37:08 -0700 (PDT)
Received: from intel-VirtualBox.. ([94.156.205.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe937925sm29585142a91.12.2026.04.07.08.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 08:37:07 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Brian Sune <briansune@gmail.com>
Subject: [PATCH v1] Fix old TARGET naming to ARCH for PL330
Date: Tue,  7 Apr 2026 23:36:50 +0800
Message-Id: <20260407153650.26404-1-briansune@gmail.com>
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

latest u-boot fixed the old naming from TARGET to ARCH
however, cmd Kconfig is not aligned to latest naming.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 cmd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index f47ce7f45ce..aead5c80cc6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1893,7 +1893,7 @@ menu "Shell scripting commands"
 
 config CMD_C5_PL330_DMA
 	bool "Release Reset DMA Channels for PL330 Handshake"
-	depends on TARGET_SOCFPGA_CYCLONE5
+	depends on ARCH_SOCFPGA_CYCLONE5
 	help
 	  Provides access to Reset Manager Per2ModRst. Enables DMA
 	  channels for ARM PrimeCell PL330 via reset release.
-- 
2.34.1

