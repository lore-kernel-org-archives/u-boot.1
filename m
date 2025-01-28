Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B95DC02188
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 01:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C992C8187B;
	Tue, 28 Jan 2025 02:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="SlbWWCS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 213FC8191C; Tue, 28 Jan 2025 02:26:47 +0100 (CET)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D0C681875
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 02:26:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738027600; bh=liph+TvqfYbZe35sV65yWOlzOc8PJnkLTUd08SQz0ew=;
 h=From:To:Cc:Subject:Date;
 b=SlbWWCS/3OZ+qOELw1f8aaTogjueX8c7Ql5BQuc8fC1+iHv4u9D1aSToG2r1GtY+d
 cbFE4ccdiXzn0GbcBydj80lsVsFW+GhoO2Dm3++MvU4gb6zs2ZYeyVG8SukVErBgBx
 rIovGjUZ5V7rBT4a39eNPdnuX8HuPLPCCFS9XeoY=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id 353892F2; Tue, 28 Jan 2025 09:13:19 +0800
X-QQ-mid: xmsmtpt1738026799t5uhdogww
Message-ID: <tencent_11A7276C90990D36D80B2816D36292D24705@qq.com>
X-QQ-XMAILINFO: OUycJhUUya+/YrUSWxwE7tXAZFIVYJ1Wl4UlaNRUZWx/9wBNcB++GktkIIEt6C
 kdrgkj2YjDzEP8vF2k98b1wFHxyigW5ykFupw+VutUoAjpgOLA2sP3IoSDBfGJcGQdwnnlUvC9PH
 BRm6rc1V8nuQYLOD8b8bJ3XuE122+JMxNNlEod1vbRDAJV+yl+y79HZDDJgqv0R8e3vpoUBKHBg/
 mH/BubcpcqOkB8VL70AhRfk6czWamdkCNEi1qh/1+s1HVXhzRogvnBr0G0kgN6MrIPcXHL7wyqsr
 Vb5Tr71j+QCc1K6a7v9q1+S2MZ6xCgkB2YUMP8xH1n8vX/2rmyUrE3pZvXMMyUg9PpEECeIeNU8Y
 2y10tfWD5nq+fMV+wlLmRKsTzHN8VATW8f+19zhk/jd6uqm5W4D+YbpCni6g5d+wm9gjMHD5NDSa
 GV21tn8BjkU3Wp4bD1anlUITRJdMu9cHARo0C7W3dj357hOG00reXfgZMQ9XiobUskkJMqReuWtC
 9+he5+F6ZNkyK+c4UqwDuqXu+UUGFBXb2DshGUIvNrCy5yt5vu0+ZbRk0e67utf7jdWUEpoKoPRt
 mNIF7pLzNK3GZL8wwEX9HdE6rm1OSUxyrkeMI2PxoavwIdKtjU2DiJrYO8cCxxtrEJG41kBqy4nu
 c10xjqan4DXUavHVxtjUeNdXDjO8oHdRfD8HFNtddFrkBF00OyD7giYej81GJpIKiQLHccJ/nhSd
 FbkgvooJ3vVx15UZiRW9g0ZRNNi72qqjCl4B1xwQwbdXqzh/KbTAXP2C690E89DMeYsSyNaYm81N
 GUlSg2pPvR7+PKxiSwpGIyNd7TACnmSxsXNGMiRsKwQTh6Xoe73AHru8Rnf8o2NbMtnbS5sepLsr
 rkNK+/9LYMvdTLKCl1fF93asB3KU98fydDGVZvn8i4HZUDxtOV8N9E7n68QtGgzURBhZMafuwSJ4
 ckRmRTR7NCrraERVk7I2mMIOtwvlmT
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Brunham, Kalen" <kalen.brunham@intel.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: [PATCH v1] examples: fix building on arm32
Date: Tue, 28 Jan 2025 09:13:16 +0800
X-OQ-MSGID: <20250128011316.126067-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Refer to the commit a3c101a61348 ("examples: fix building on arm64")
fix for arm32. crt0.S does not even build with:
    operating system and architecture:
        5.15.0-130-generic x86_64
    installed version of gcc and binutils:
        gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04.3)
    GNU ld (GNU Binutils for Ubuntu) 2.34
    used defconfig:
        stm32h750-art-pi_defconfig
    used commands for building:
        export CROSS_COMPILE=arm-none-eabi- ARCH=arm
        make stm32h750-art-pi_defconfig
        make menuconfig # to add
        make
    examples/api/crt0.S: Assembler messages:
    examples/api/crt0.S:32: Error: lo register required -- `ldr ip,=search_hint'
    examples/api/crt0.S:33: Error: lo register required -- `str sp,[ip]'
    examples/api/crt0.S:39: Error: lo register required -- `ldr ip,=syscall_ptr'
    examples/api/crt0.S:40: Error: lo register required -- `ldr pc,[ip]'
    make[2]: *** [scripts/Makefile.build:292：examples/api/crt0.o] Error 1

Use valid register names and instructions.

Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v1:
- Change to use R4 to R11 instead of parameter passing registers

 examples/api/crt0.S | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/examples/api/crt0.S b/examples/api/crt0.S
index d2a97557817..6899ebf8ac2 100644
--- a/examples/api/crt0.S
+++ b/examples/api/crt0.S
@@ -29,15 +29,17 @@ syscall:
 	.text
 	.globl _start
 _start:
-	ldr	ip, =search_hint
-	str	sp, [ip]
+	ldr	r4, =search_hint
+	mov	r5, sp
+	str	r5, [r4]
 	b	main
 
 
 	.globl syscall
 syscall:
-	ldr	ip, =syscall_ptr
-	ldr	pc, [ip]
+	ldr	r4, =syscall_ptr
+	ldr	r4, [r4]
+	bx	r4
 
 #elif defined(CONFIG_ARM64)
 
-- 
2.25.1

