Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A10CC369CF
	for <u-boot@archiver.kernel.org>; Sun, 20 Apr 2025 11:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C13A82139;
	Sun, 20 Apr 2025 13:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="Pd+y8+lA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B136382076; Sun, 20 Apr 2025 13:58:26 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1F1D82119
 for <u-boot@lists.denx.de>; Sun, 20 Apr 2025 13:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: e058e3ab-1dde-11f0-8ec8-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id e058e3ab-1dde-11f0-8ec8-005056994fde;
 Sun, 20 Apr 2025 13:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=J6F0L0Y9f2C708T0XrEzCWHR2WGMwEUG+F6Q7pO3cDc=;
 b=Pd+y8+lAUjgh0JtV9vZv4u4y5OmIslHndSCM8FbAUE4s1OCgCq3tKh8cD71nTENWZTzAJX3v8sb3U
 zEOlrDdct+oPG+iFm23fKT1Wl+2Rvivrns+2Kj2oDfcpLb5xaUoLVqXbAVcsS9ZUFakRmuMRaGzsRE
 qd7ggCYbLH8qFioo=
X-KPN-MID: 33|bt4MeORuSkORqjURSIcUNin+2EjBETaIYuSf/xnZYpfna7dOzob1U0vkKhxMQZs
 XJMEoTnn6r2RdgFCYZHiag4CS2P710kAgDtal9ttNG5g=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|DqQHaQhOYucOaEUuLD4Pw0kV5AuXrhd+5Fny+KFDKaMBJXeOb+efW/d3G4SB5zs
 ZIcIDuu0mlQ7BOeaN++EFGQ==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id c315cb84-1dde-11f0-97e2-00505699d6e5;
 Sun, 20 Apr 2025 13:58:24 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: kettenis@openbsd.org,
	trini@konsulko.com,
	marcan@marcan.st
Subject: [PATCH 5/6] arm: apple: rtkit: Add endpoint field to buffers
Date: Sun, 20 Apr 2025 13:58:07 +0200
Message-ID: <20250420115808.94272-6-kettenis@openbsd.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250420115808.94272-1-kettenis@openbsd.org>
References: <20250420115808.94272-1-kettenis@openbsd.org>
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

From: Hector Martin <marcan@marcan.st>

To be used for special-case oslog support in rtkit-helper.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/include/asm/arch-apple/rtkit.h | 1 +
 arch/arm/mach-apple/rtkit.c             | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-apple/rtkit.h b/arch/arm/include/asm/arch-apple/rtkit.h
index 1b6c6ccd821..4b11e2a72dc 100644
--- a/arch/arm/include/asm/arch-apple/rtkit.h
+++ b/arch/arm/include/asm/arch-apple/rtkit.h
@@ -12,6 +12,7 @@ struct apple_rtkit_buffer {
 	u64 dva;
 	size_t size;
 	bool is_mapped;
+	int endpoint;
 };
 
 typedef int (*apple_rtkit_shmem_setup)(void *cookie,
diff --git a/arch/arm/mach-apple/rtkit.c b/arch/arm/mach-apple/rtkit.c
index d294ee09350..f3561543a35 100644
--- a/arch/arm/mach-apple/rtkit.c
+++ b/arch/arm/mach-apple/rtkit.c
@@ -161,6 +161,7 @@ static int rtkit_handle_buf_req(struct apple_rtkit *rtk, int endpoint, struct ap
 
 	buf->dva = FIELD_GET(APPLE_RTKIT_BUFFER_REQUEST_IOVA, msg->msg0);
 	buf->is_mapped = !!buf->dva;
+	buf->endpoint = endpoint;
 
 	if (rtk->shmem_setup) {
 		ret = rtk->shmem_setup(rtk->cookie, buf);
-- 
2.49.0

