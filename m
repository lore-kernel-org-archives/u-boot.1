Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DE5CD6E7D
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 13:45:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE5284942;
	Fri,  5 Jun 2026 15:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="p1GQYkWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6297B84948; Fri,  5 Jun 2026 15:44:59 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF6684936
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:44:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.stein@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=D4FaqxC5iltUKHFGkurFhI4w9D0/A5kMrZ6Dar7bnYM=; b=p1GQYkWQjLBeeBuBttrifsHohX
 u2f5o6rAxz3zf9TNyYQVo7icVIQFupmaDpwv6oqcWkNgvahlgmqhZhNiuCQXNmWLsOJHiy2VuRmbS
 jeAdqV5ZyKA61JdAtr2eZh+r3iLzbNUthjvYKyPVt7f1a1WyfqyCDQuht/kp5JmnuWhZpaTLiUypG
 4xQuuhOecry1F3QCvziGMKTMpbbrN1syWG2hGyg/CthvIMQib1UUq95ZOZey4FXZo4xihSsuAWZi2
 Ewv7XcEoE1j/Z8bbYqnQME73wgZI5vfLDmoPHFfx2Oapdm/upGR/WmFM+nogNZs8mnVRo+nme8827
 BHryfgAg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wVUr3-00043c-0C; Fri, 05 Jun 2026 15:44:57 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy08.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.stein@ew.tq-group.com>)
 id 1wVUr1-0006bG-2o; Fri, 05 Jun 2026 15:44:56 +0200
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	u-boot@lists.denx.de
Subject: [PATCH 1/1] global_data: fix type for gd_malloc_ptr()
Date: Fri,  5 Jun 2026 15:44:46 +0200
Message-ID: <20260605134446.825678-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.54.0
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

With commit 92aa3ec321b5 ("global_data: Reduce size of early-malloc vars")
the type changes from (unsigned) long to int. But the type for default
if SYS_MALLOC_F_LEN is unset was not changed. Remove the suffix.
Fixes the warning:
 common/spl/spl.c:800:23: warning: format '%x' expects argument of type
 'unsigned int', but argument 2 has type 'long int' [-Wformat=]

Fixes: 92aa3ec321b5 ("global_data: Reduce size of early-malloc vars")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 include/asm-generic/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/global_data.h
index 745d2c3a966..9d7146746d2 100644
--- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -538,7 +538,7 @@ static_assert(sizeof(struct global_data) == GD_SIZE);
 #if CONFIG_VAL(SYS_MALLOC_F_LEN)
 #define gd_malloc_ptr()		gd->malloc_ptr
 #else
-#define gd_malloc_ptr()		0L
+#define gd_malloc_ptr()		0
 #endif
 
 #if CONFIG_IS_ENABLED(UPL)
-- 
2.54.0

