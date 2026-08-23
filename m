Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24340C5DF9B
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 20:39:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C3C0880D10;
	Sun, 23 Aug 2026 20:39:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id amve30y0pQMA; Sun, 23 Aug 2026 20:39:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787517589;
	bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1ImYR2sZm/Yx9aUETsJsUvVwKh1peCECEHI/RwUZigClCwJS9ejMJNpNYHH9zVRMQ
	 GHiJIdDhwY+kooBuKk8d3GJNuGt+TcSV8TwhV5t9m+syBvdBRzu6xNRwf7F/YmTRTA
	 HxYFWvZLMGY5vN2tfdpiF4Msm7xO9i5JTQ9V6aLuwn7ZKhre9Oo/uPbrMBSIbiI+JN
	 3A1AS+tiit+0q1SB7tM1Smd18vS6ZNzPZf83cjgcY+BRa9ZqtWD4zy5I+NGN8jZy5p
	 1Palne4Bos6yV/NTWiC+lWJ3r1gkPkOpWkjo92yC6sgOwRFERfk8JmHKc8mT0B3Aez
	 IOBbKkkU8Z2vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B84C480CEC;
	Sun, 23 Aug 2026 20:39:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6649D42B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5765A6073C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOsfjCQLbOK3 for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 20:39:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Zqi2DkPe
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFEFB60615
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 20:39:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A5EEA40626;
 Sun, 23 Aug 2026 20:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAAC1F00A3A;
 Sun, 23 Aug 2026 20:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787517582;
 bh=ADVlmkf2Xvu/vbH2HzX+SeJTIbolQxvnUwuoN2DUJwc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Zqi2DkPedrHKzeCsRRydQaOAqJuPGf2hGLurXtRu+xOmrpbWe02hOvt2HwGEawisg
 0wmyFEXZhiWKKGd5yZ8ELVv4KiK1X52cFWlQsp/sMkiD3hMQGE3tBRf0ENa1RABsQI
 uk8LqKGgo1sCgvL14FWqlTETth71FDu0nS82beXpCZWszIKtB1QinSQUYcadLNYAUf
 EjzORpWudB9Cn7MQdW4AhP6O//HiveUmvOoqeCRCK7P5sTQYk7vb9dTsDPntH7Edmx
 E+64baYAGaBsSlmXXMxfHZKbsIGJDHnyhtewZUDHCGR6dQz7Ldbf43L+My9ap7PX3q
 rt8bM0vkbbbTw==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 23 Aug 2026 22:39:27 +0200
Subject: [PATCH v5 08/13] arm: u8500: Enable SD card regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260823-ux500-external-sdcard-v5-8-07ca794e2b94@kernel.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
In-Reply-To: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Have ARCH_U8500 imply the fixed regulator driver needed by level
shifters on the supported boards. The architecture already enables the
regulator core and Nomadik GPIO driver.

Reviewed-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 62aa9e8cc565..2a01ac9b7675 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1276,6 +1276,7 @@ config ARCH_U8500
 	imply CLK
 	imply DM_PMIC
 	imply DM_REGULATOR
+	imply DM_REGULATOR_FIXED
 	imply DM_RTC
 	imply NOMADIK_GPIO
 	imply NOMADIK_MTU_TIMER

-- 
2.55.0

