Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6C3FF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53D30842F2;
	Mon, 27 Apr 2026 15:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="hCRhyRGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D588842CE; Mon, 27 Apr 2026 15:59:06 +0200 (CEST)
Received: from mail.kernel-space.org (unknown
 [IPv6:2a03:4000:b:d08:14a9:1bff:fedc:75ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3130E842CE
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1777298340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swAcaXIFGXAdo6BK0AOCi6d43J8FJAwK/KbSOA+ZuRQ=;
 b=hCRhyRGiI56uqoVRQXdHIRft3Ov22cGR1ytEr4ZQ+XJuXU8N0B8RBCxfuludA5JULde5bz
 0rD4kemV2a5YIflUGdW6eBp1tBhNLzR1aipGU/aUJPgU41CWGGC2PWiZWflAX6d94Prv+K
 jl7mAKm9E4iib0jE0rK8V+KITeGw5tE=
Received: from archlinux (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
 by oreshnik (OpenSMTPD) with ESMTPSA id 95952b72
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Mon, 27 Apr 2026 13:59:00 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, u-boot@lists.denx.de, sjg@chromium.org,
 Angelo Dureghello <angelo@kernel-space.org>
Subject: [PATCH v2 4/9] board: stmark2: remove old garbage
Date: Mon, 27 Apr 2026 15:58:49 +0200
Message-ID: <20260427135854.18496-4-angelo@kernel-space.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427135854.18496-1-angelo@kernel-space.org>
References: <20260427135854.18496-1-angelo@kernel-space.org>
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

Remove old erroneous garbage.

Signed-off-by: Angelo Dureghello <angelo@kernel-space.org>
---
 include/configs/stmark2.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/configs/stmark2.h b/include/configs/stmark2.h
index a7afbb3be1f..c1096398359 100644
--- a/include/configs/stmark2.h
+++ b/include/configs/stmark2.h
@@ -18,7 +18,6 @@
 		"load mmc 0:1 ${loadaddr_ramfs} uRamfs\0"	\
 	"kern_size=0x700000\0"					\
 	"loadaddr=0x42000000\0"					\
-		"-(rootfs)\0"					\
 	"loadaddr_ramfs=0x43000000\0"				\
 	"update_uboot=loady ${loadaddr}; "			\
 		"sf probe 0:1 50000000; "			\
-- 
2.54.0

