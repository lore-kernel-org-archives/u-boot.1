Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0159C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 15:19:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFEFD82B0E;
	Tue, 10 Jun 2025 17:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="gchTs5rR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD0882B70; Tue, 10 Jun 2025 17:19:10 +0200 (CEST)
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk
 [188.40.203.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BAEF82B0E
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 17:19:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=codethink.co.uk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=srv_ts003@codethink.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=La1SXtenEp8srQeIlXqtjIW/06hVkmu4T4QWyDN0bNo=; b=gchTs5rRnUZ3bfXPzOWuYDl3Dd
 HIpxveR1LyrBbCEpzHdu2Muc+RbfaEUpC8KmWwKlbNEd90MSuXBpONqCULFqKa0fgkuTSVcFkfgTM
 7WxF2I+iRVW8Z55IRnZMw18zIIA38Md00dEx65ABSFIUY7SSrFaZmUHnU2xT3pFp6Bb5ZGmxvIXmz
 mSUdE/Sd9lm6TzRVGSOx5UGwDMsHWWXiF2nI4zi6k5fPN2EnLoWDrqEmQnFPpSh7J65Y+9NdHD3iW
 3iT1jTwB4x/fWPyBaIJxRb4NtMcJ8U7RQVxN/X/Pfwvo/JCKH7qLdNYPW1BprlwwcXSiW+j7Tr1uD
 t+SHdCMA==;
Received: from [167.98.27.226] (helo=rainbowdash)
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uP0kW-00C1EM-8Y; Tue, 10 Jun 2025 16:18:52 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uP0kV-000000071IK-0z46;
 Tue, 10 Jun 2025 16:18:51 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: rick@andestech.com, ycliang@pr-suspensions-neuweb-biz.expedrion.biz,
 u-boot@lists.denx.de
Cc: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 ben.dooks@codethink.co.uk, trini@konsulko.com
Subject: [PATCH 2/2] riscv: byteorder: add test for big-endian
Date: Tue, 10 Jun 2025 16:18:50 +0100
Message-Id: <20250610151850.1673111-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
References: <20250610151850.1673111-1-ben.dooks@codethink.co.uk>
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

Test for big-endian either via __RISCVEB__ which migth be
rather old, or check the BYTE_ORDER if the compiler defines
it (which should be any modern gcc like v12)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/include/asm/byteorder.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/byteorder.h b/arch/riscv/include/asm/byteorder.h
index d26ac5688fa..3140c1f585e 100644
--- a/arch/riscv/include/asm/byteorder.h
+++ b/arch/riscv/include/asm/byteorder.h
@@ -26,7 +26,7 @@
 #  define __SWAB_64_THRU_32__
 #endif
 
-#ifdef __RISCVEB__
+#if  defined(__RISCVEB__) || (defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__)
 #include <linux/byteorder/big_endian.h>
 #else
 #include <linux/byteorder/little_endian.h>
-- 
2.37.2.352.g3c44437643

