Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF622C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 08:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108FF88B9F;
	Fri,  9 Aug 2024 10:59:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="g2Db8lN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B4B888B9E; Fri,  9 Aug 2024 10:59:04 +0200 (CEST)
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com
 [203.205.221.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E78D889B8
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 10:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hanyuan-z@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723193931; bh=UiUYuioP8UeBH7S8EW5eZL9Kl8sOUq5qdJg6dDxzM5c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g2Db8lN2qJ9GWG8+g6ttF8X7vzgmwJch+yu2gvsbgwHqEPXr2Qj1q/9O+Y85olNIB
 J+A5COr6goFcd3yftWiHf+Y5WzeMM4uPquLtwlw5PhwfZ/1RPNotvx/q7M+Q2M1eGO
 lw5zLqHfEngGzENYCI2shsknZBm8LZv3Vw7ar3Fk=
Received: from hyz-wsl.www.tendawifi.com ([166.111.226.87])
 by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
 id EA28703C; Fri, 09 Aug 2024 16:58:34 +0800
X-QQ-mid: xmsmtpt1723193924txyvkn8zv
Message-ID: <tencent_6DC713409F31C517AB25D8A6CD7F5EC92506@qq.com>
X-QQ-XMAILINFO: MDlC9u6qHHGc/jx5r9dnZxAMqDkapxXGpf54YZM8t7UAU5OnveesJdfUnLmJyr
 VbH0+/bUD3w6TEIjqob+a+ZhHyDLx4ontucm/TnZVojll3EsCPNiiOYjPNd3FS5wb9kc43Qvnrvx
 +5u1kwWZvFQlXLExKtoKWHDG6oDfRDe1xOF4wByG0CLim05L+CGKXm/BX62Aex85i9io5v/2ynvP
 JRzGcAJo6yn54qe7gshTiN7nWgVqi/zUfWH6hcaeLE6JM06Vk7ez0R/HemQosWcF2rlZuBQQ5Eos
 0PrrMwUOfdU6sZz742iev9xJY59p+r8qSMZBUj6NK40HzD5QfvaJ5IuQCiAbJ3inKZT7mzws3eLk
 TOfQlotIbYpvvLqwq0GsP0vVCarSYGq3Ej7dA6ltUb31amYd7ByB5m5d22GVzfMroIGOh4Q2nCeI
 BneKMUw33FVXvl0yEXVqiqT4xLai8LMapqs1ftwptn20mshuYiH6GPzwSSqnVgdiyqNH4h0QGtDf
 kpAg32UQSXl2/Xaua7fcOvBYhV9A6XpUB/ZyeQRytuvcgEphp2P47CyCF2Z2qFHYK1+A10wRiLA6
 O07laAm+qeMfX7kufmJsI/WDGTXgYSfRQnuH7QrnWvi5fEjJJDkZBE4gWtiySnqam3RbPsqi0h3X
 YdFSSdhht6clnwk2pP3j3kuMr4Vdtkbh+h6vgK3rGj97xIaN4jfOXbDrgPYbiOSwTdrMHAeFSTvy
 Wv6xiA3eyE01iuHp41pc39ev2CuNH9+JoB6YzjvRGdgjIkYuUyKQEHs86u6K7JwJBMMo8r4+2dPt
 Ybe+0YPG1J3F1uw17bwahVoOEn0n06RgVD/m7t1mWhkLbDVXQ5j2ge32Rbg9X0+IOSQIMWQTUT15
 0+DZKtFrfD/fH4ZnmBfUY6X4n/QBGso5FbUG/AeccmOuv8gO0NjtxDPncQOzzlUQ3dBVf9RuxuVV
 UPB6lgO7+ifSxa/BPcVp5avk79GQHh5YFVVP8SFsAA30or2yz35gWJg/maMZ2JSVJVDE/YKZg=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Hanyuan Zhao <hanyuan-z@qq.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>,
 Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
Subject: [PATCH 3/8] net: dc2114x: set the card number to start at zero
Date: Fri,  9 Aug 2024 16:56:56 +0800
X-OQ-MSGID: <20240809085701.22183-3-hanyuan-z@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809085701.22183-1-hanyuan-z@qq.com>
References: <20240809085701.22183-1-hanyuan-z@qq.com>
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

Otherwise the number might get kind of weird.

Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
---
 drivers/net/dc2114x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dc2114x.c b/drivers/net/dc2114x.c
index 7f0715429f..cf9f78163a 100644
--- a/drivers/net/dc2114x.c
+++ b/drivers/net/dc2114x.c
@@ -561,7 +561,7 @@ static int dc2114x_read_rom_hwaddr(struct udevice *dev)
 
 static int dc2114x_bind(struct udevice *dev)
 {
-	static int card_number;
+	static int card_number = 0;
 	char name[16];
 
 	sprintf(name, "dc2114x#%u", card_number++);
-- 
2.39.2

