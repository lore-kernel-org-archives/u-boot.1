Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCF3C02185
	for <u-boot@archiver.kernel.org>; Sun, 19 Jan 2025 01:05:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A347800CF;
	Sun, 19 Jan 2025 02:05:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="uV/KgDQY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D425C80141; Sun, 19 Jan 2025 02:05:10 +0100 (CET)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com
 [162.62.57.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62BAC800B6
 for <u-boot@lists.denx.de>; Sun, 19 Jan 2025 02:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1737248702; bh=dtvUIGbZxDR6wq08GMigTVNfZQPCKC6202SjqpdqzcA=;
 h=From:To:Cc:Subject:Date;
 b=uV/KgDQYqDwFvdOYvLdPsAwiicI5B+T3FJ1Liw8PwB68sA5htPOldOKrbAz0M53To
 MU/BG+L22NAGSBkS1IwandH/kW80X/fkps+NTQl/e6ltMo3U8+7xEWlZD9XMv5AL4f
 8US/ZNHN3B/hlWXj7TSSq+1bxfSEA/YcA4AAVJE4=
Received: from ubuntu.localdomain ([183.253.34.159])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id 140A12DD; Sun, 19 Jan 2025 09:05:00 +0800
X-QQ-mid: xmsmtpt1737248700tsl2deonw
Message-ID: <tencent_410F4F8FDC201D1B50F008D01066D0A4A006@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uTXRHeDs6IGameo//Eti/Hi8RtH6+e37j9ZgFSLFppUa1Ff2H50U
 3HdeaZU1SYJFuo44VpvK6lhJiuVnkqCVS3KxJWDOL9EQAvGU2iuSo1sn8nybJPBEYHezQSW5FJHW
 8zrK9cSIrkORIUpZoHCECd1lScURWWJsooyiwXXf8UjztGvZCk4w6Zy0EfNgrmCJ1rnYxD00kGxI
 43Ledk7uqeJ4g+gbUX9oGov+uVxl5/lbZ6uGyhmuxWMmujPql9yVK3B5dhxQH1KXJpvoLfF1Nj78
 NyQVRJy7e97ZIZHLv++ZQhPMu655dH0rye0rIpZVq4ABdKMk/+LTnsbL/+evKsKTvl/1XgmMG4Lf
 9dOOYsB7Hx5cO8UBj26c6WP1yVr0XuyVzWNnMX3MrHwndZ0mG2ECPKw1JkPxqsDhVlVb7eXIYY9a
 3+8VOtyvqc42jy0Ouk21nfOuj34nor4pG3ixXIuVv4tDMX2LjKnA67ZWL7buFJ/Cg+aZVvL3swRO
 VvESyTSMdLOeMQ05r9ISmeekqpRVupCJvITRQMWnbZo6sZn1Ibu7HqPgtGakA4oYbxNHm5j09mxp
 U5aVPsqoXR2r9AixfNC2eH44x/FcF3RsqpIsDgdIj+VObNj76XcNPVjtVw55AvHqoRvRwhG+fSBa
 0LDj8JfyLnQQpfs06tkUWKM0bg/hFj4QWLom6NrUIUvJBbyK+FxmAPO6zXKGbGgDWVZzUb0Yx0DN
 sPMGwU4uv14r0vQ8LVxoJToGtMOciobyiKS1Lcj8cahQdSQo1hZwpdmmcAOcukNJLbcgBLzhb+vW
 MhrptefH/zDhydoqzKYotvF35WBKNFKsv5C9JPup7sb9FyyJqXnk6Yg4IKz/WSSbHBNy/2OuYx2f
 KCmvQf4o1q8WTrda6t6zK3Nm6jzFsYDWbYt7zGH4RVJpbhnsFnovEOjMKZsWlPWr7zWdnWqC/NZy
 dC7LDAER4=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: 1425075683@qq.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Liya Huang <1425075683@qq.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] arm: Remove redundant loading of image copy start offse
Date: Sun, 19 Jan 2025 09:04:58 +0800
X-OQ-MSGID: <20250119010458.31536-1-1425075683@qq.com>
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

Because the beginning is already computed

Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v2:
- Due to an error, the patch was resubmitted, leaving the code unchanged
- Sorry for the trouble; Due to the lack of understanding of the process,
the previous patch information was Reviewed-by. Please refer to this patch

 arch/arm/lib/relocate.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
index 345e282e3e..bffadfecba 100644
--- a/arch/arm/lib/relocate.S
+++ b/arch/arm/lib/relocate.S
@@ -83,8 +83,6 @@ relocate_base:
 	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	subs	r4, r0, r1		/* r4 <- Run to copy offset      */
 	beq	relocate_done		/* skip relocation               */
-	ldr	r1, _image_copy_start_ofs
-	add	r1, r3			/* r1 <- Run &__image_copy_start */
 	ldr	r2, _image_copy_end_ofs
 	add	r2, r3			/* r2 <- Run &__image_copy_end   */
 copy_loop:
-- 
2.25.1

