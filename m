Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233E7FD4F04
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8A68416C;
	Tue, 10 Mar 2026 17:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CrqIqh3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8811E84154; Tue, 10 Mar 2026 17:26:26 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A34484154
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:26:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-40f1ffba6a0so4655574fac.0
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773159983; x=1773764783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BrnmGQtBv27J1U/+dj7itBTXYEJj73Y7kCzG1qUyUW4=;
 b=CrqIqh3TNv5Fqe5JyktMwFRUYTkjmmmUP914QX/x26ACesg3+c/r1P4SEWu7h6MRYm
 OFHBjsiKiUUG5yBq/ibAHN2/kzWexa0a5RE21e7WKD9qm40znNC1bURmzJblFGRg1WRI
 xPk0U8lSypiC+DcPu2xqP1MKhqukBh13W9Eqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159983; x=1773764783;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrnmGQtBv27J1U/+dj7itBTXYEJj73Y7kCzG1qUyUW4=;
 b=NDMwgOhZbTGGKLCwwBeSf8TDQYIsfyJdFk6gO8M1kHTAsmJanwaseIzANdaWqVICTd
 vq2nA4DPfCGGjRLR8azgyvdHzKnNDs1VRZZlc5bs6eie4kVY5+wh6Uf9s5tLexef/yrE
 9TFq+PjQg+rzsEIU2oKyoCAfeoVxViyjE2fix39tGCAH2RyMTr4ICs8FLWSt09s591km
 322XAgTJ0ATxTQb4l0MHg8aEMz2sUhcsgQacG0QGwGXfRGf/NKYPH2BbIUPGXq6LMHYa
 8hpnS1YQrQThv7SOuu0g9/c8NrSu6GYqWFDjCDY7GjEUnhLRrAlvkk7t7BfBY3rYV0GR
 fEVg==
X-Gm-Message-State: AOJu0Yy2cDf76Qmb9W9UHbYkoIfz97bNQBJ6/C7XJYBtQb25Zum5RDd9
 fAUi0DCzJ2duJRADlt+/5vwl6eMjnEfbQXQ1W5xPAddkZ/F2H8QahsJvUE0AeX4en7UVRFBctEE
 /gtIP
X-Gm-Gg: ATEYQzzc+KjNc450F7AMbPNbsERWY3biVG/SyKAWcTv109zdN1vmVojnS57ors33knp
 iilSYwgcGp1dxMgXNYJOlQCqE6QJ03UjVUYTvowuL2nuI/p/8QbVY9pq8gWcXNdAhbchf7/iA7b
 8W93dvjnnlvIsqw//0LWiG/miGqNfBCfD2wf9i+YpGqFX1u/N5AsqlOdXXlxD4s7O6lxXffBnRn
 yVzodX/X4t3zWSxgxgdoD6ea4Qob8vnC6bkGAJvej6fCxBGd4XWHo6251m9ZnZ7z+gBlZQgCAqR
 baNFUl62gKz/Hc2YvbmwEx2bYBSQIbA8n75L/Aa8EjtK/NMQMbI46oOqrIDHxIDLDLTJs+vv46j
 rGnMz6aXLv5Hxdug6+qc3myqfkOhJfrSBX8ng+G9LXy1G1Gk2e7asuLUmwHLl047q+xmausK8fh
 bEgi/fTZkHM90ZoudG1ivEtEiklbjCR6kvkd6PwmrFHP2fCMF7iPz5pnZ09vEN96T9x0eYCoaIt
 29S/gnH7tMcis6VC3SvqRzraXanMeCa4kf4p9o5Z+sfFczs
X-Received: by 2002:a05:6870:7081:b0:40c:10d6:7768 with SMTP id
 586e51a60fabf-416e45d44c7mr8902008fac.54.1773159982710; 
 Tue, 10 Mar 2026 09:26:22 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756d4d342sm3122693fac.12.2026.03.10.09.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:26:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] dfu: Make the DFU_WRITE_ALT symbol available outside of DFU
Date: Tue, 10 Mar 2026 10:26:21 -0600
Message-ID: <20260310162621.1163932-1-trini@konsulko.com>
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

The DFU_WRITE_ALT symbol is used both directly and indirectly (via
UPDATE_COMMON) for EFI capsule updates (FIT or raw), but does not depend
on DFU itself. Move this symbol outside of "if DFU" to remove a Kconfig
dependency problem.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/dfu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 2cf4289b4486..962bda40ad2d 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -13,10 +13,10 @@ config DFU_OVER_TFTP
 	bool
 	depends on NET
 
-if DFU
 config DFU_WRITE_ALT
 	bool
 
+if DFU
 config DFU_TFTP
 	bool "DFU via TFTP"
 	depends on NETDEVICES
-- 
2.43.0

