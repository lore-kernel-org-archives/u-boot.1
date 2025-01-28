Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DDCC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 13:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FBF81DCD;
	Tue, 28 Jan 2025 14:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="KbkG+HzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 252DA81DCF; Tue, 28 Jan 2025 14:51:08 +0100 (CET)
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com
 [162.62.57.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A99C81DB4
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 14:51:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738071956; bh=cYruGSd+4NMx/WD8s0AWMp7i5EXMZWn8E2MJyzGeQs0=;
 h=From:To:Cc:Subject:Date;
 b=KbkG+HzLT73qoC1bgVEVkO8kbnJz1RRGCJugLlsf+3KZKx0r7UMAYEu3qSy032beh
 WtUWuNB3rH7tpoXpi2oBMCa6XZQu89HD04Hw5WEpOS5c60RLE/IeDdlKQLuKICFpsa
 YQDxfKqY0oYNlOKslbrisu99Os9IVQtrx5uNSt/s=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id B769A03B; Tue, 28 Jan 2025 21:45:54 +0800
X-QQ-mid: xmsmtpt1738071954tumjqld6p
Message-ID: <tencent_991CA024CC85C92C1FAD9EF4413A36AD6007@qq.com>
X-QQ-XMAILINFO: NkHKfw09D6j8/7E4bBh9ve8mzx6/mtOn1Ay0I3DNq5zhy4pU8jZuiOP3e/TRHk
 Ts8UUrRnCQtI5g4XFLrG9yEJQAVc5816diUj4rDXzvQnMleYg0bTItpHoD4lr6SPtAFolWg9JlqK
 8FEIk2DQypGEyHNKqI/Z8Oy5/KtqPHbZ8uMsaFz8WbvqFgcW7qcJC5ArmHhfAEXDTIuzJtsNKy/b
 yy98wtDPWJdWOgIO6PkiOKN/F6CCSNVKi53BqvtYCX6+yUxY68WUNgvijxncfvDFyameeCP1QY+a
 tiFFJdpkQmXEy6LVl4SZqvPHjLzWE1/ja1/A67WYuPv2EioPQWc9PtLfLmeGgjtFwplNUdfaotB2
 OpXG7CczXprJASLaSmRO/rl4O4sij0kt8kAMqsDxTrzMvw7iwQIFCn7ZnpabWW1DYsPCwtildlvq
 rcyK0O7l49U27HTJh9IAIHFR54ADU6YbsjJN7A39UvpqcLmcaTW53jtp83ZR9RlS5AIDqtsmeS1w
 OEeE9JQyNbeg8enOjr67H8+tqe5qcRmZ0HkW8jamw9W6lJWrJGqE7lUG1dRPBem6I0mKZ74BWXB8
 FpTCohbBfjPQBwsBO7qxsAE+QdwPEFRzm5kJ3ng1Ma+9Q083wqQQ67sOyYDZxxSdU4eR/CNBlS8G
 is5Wu6BKIBfRjpeoYSIUOMKkD8qr4Dq85HRr+BPGBAdP47oMOFVn6I7H1CW9x04idYq1PCmNDya5
 3Sa8U71A0/A0VkXVJ1z4rI+qSC5wQt2u5utugBgfZ3I0iwRB0bixukJxWrv6qucYndcXB+pygSUT
 fadM+yMJoqRhYSrmk4BELEsy3/QebbQyftH5JrNK2CQ1x8clxtQQRJqICwqTYFeI1R84MRTgIFXF
 OJHFQk53f4Q00EPrHtR37y+hJ1GEu3oG+LV8/M/l3Z4RulZOhv7fZBADt8bsq+c9DadKULq0q5SH
 aCKTpV+3EKn+5t5a0WbVO7VGDU8xMHjq2vYx4blH9ulM0tPda2KqXNBZ6/kEfofVoyKnpy5Jg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] arm: Other boards should not show this option in menuconfig
Date: Tue, 28 Jan 2025 21:45:52 +0800
X-OQ-MSGID: <20250128134552.197665-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

When I was using STM32 board,
this option appeared in menuconfig and caused me trouble.
I found that arch/arm/mach-imx/imx8/Kconfig
already excludes using if endif.
I don't know why other boards are displayed.
I used the following command:
    export CROSS_COMPILE=arm-none-eabi- ARCH=arm
    make stm32h750-art-pi_defconfig
    make menuconfig

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 board/siemens/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/siemens/common/Kconfig b/board/siemens/common/Kconfig
index 4ae12b1c973..800eb8dd1c1 100644
--- a/board/siemens/common/Kconfig
+++ b/board/siemens/common/Kconfig
@@ -3,4 +3,5 @@ config FACTORYSET
 
 config DDR_SI_TEST
 	bool "DDR signal integrity test implementations"
+	depends on ARCH_IMX8
 	default y
-- 
2.25.1

