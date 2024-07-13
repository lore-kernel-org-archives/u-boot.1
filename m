Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E65FC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7EB88838;
	Sat, 13 Jul 2024 15:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qDR0DrR/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b+DrH8Iy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E1B88821; Sat, 13 Jul 2024 15:21:17 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27141887E3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4WLpy26bvjz9scR;
 Sat, 13 Jul 2024 15:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmD7JGr9rMGl5G5XzvCQxB7geAnYtjO7KLuc3y57xqA=;
 b=qDR0DrR/0A+jE5V9Dlv/eiUec5OL3u+BNAS8yRJEtxkQLq8GcCyl7t2JATbNpdJCnDK2ey
 73eCdN2ZqJkip30z9H1EDbFl0NDsc8nrxx/ahiVho7t60mSHnPIkl8ibA8S8duBURXN2l6
 MvJzfclJx3hV96CO5z5qsvzo++lwJyklfft83DAYxPwRtvKMt/tKBMxk6rvihJFwh/hnQY
 lSmigFWi0GU8CYQtbOK4LCj1CE4gYQ7mN1rYhZyGquz3/1QNFJBH5KvxzJaMN8VAbE8W+5
 joj+J8sWw7k+WX2YPD67yRqDCP8MSAh/3P6jCJDCRILhme6FeKFp/W1+RQK7Hg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmD7JGr9rMGl5G5XzvCQxB7geAnYtjO7KLuc3y57xqA=;
 b=b+DrH8IyTM8EKya2D5XGh1RHD+TlgWoptlc8Otzj475qAmXDUFBwLWcO06dZEqhrqNcrvH
 D//B1Ql2i8SPai/ddNPrzLOk+BYdoVwWFYpnJbhFTwZyqTyIX8BF5LIRhm6PB+Uu6C50+s
 gGyLjZn41Im3Ch0ZpsWm7od/XdcOURGrvJ6RPERwQfVVsGUx8wXsLNoeFyHwV68Ke0EIi7
 O0E5SUCmUsEBd5A6Z3TZ4XchA5t3HDLfll18v8HW85cLpehxXt41tSOcvbfS3vaSK75q5T
 1UDDm/5hmyybsrV28GtK15bomFoFLVJH54h8jgynaJzcIG41G8pqx7rLXaRdJA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/45] arm: include: amlogic: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:18:59 +0200
Message-ID: <20240713132021.57650-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cd59295c3a2a45fbc92
X-MBO-RS-META: him4dbsixxjyjqp5opowfg3ao78u7pni
X-Rspamd-Queue-Id: 4WLpy26bvjz9scR
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/include/asm/arch-meson/gpio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/gpio.h b/arch/arm/include/asm/arch-meson/gpio.h
index d0142f16ef1..9eb42211579 100644
--- a/arch/arm/include/asm/arch-meson/gpio.h
+++ b/arch/arm/include/asm/arch-meson/gpio.h
@@ -6,5 +6,4 @@
 #ifndef __ASM_ARCH_MESON_GPIO_H
 #define __ASM_ARCH_MESON_GPIO_H
 
-
 #endif	/* __ASM_ARCH_MESON_GPIO_H */
-- 
2.43.0

