Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9421C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:18:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30DBE80756;
	Sat, 15 Feb 2025 04:18:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="R0ZLgDJ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDD7180C6F; Sat, 15 Feb 2025 04:18:20 +0100 (CET)
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com
 [162.62.57.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443DA806FE
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:18:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1739589492; bh=y6wNArnq69uoOavGX6bp4/ixkdE6kBhXN5SBijRL5Gw=;
 h=From:To:Cc:Subject:Date;
 b=R0ZLgDJ0R/fF2jjwMDm1yYPCxVWDBjyl3liaJBCt2oWVY22p/3LeBCb/1McXLWvkX
 9Elpc959Mf1q0afAEk+H2Xc1pLlIIhoGKoD3IOZluZD9Q2UBq9+qjtwwSNjvQzph7y
 oq0tvz69OYQ+QiklYTAvb87DBa1qsiu9Ot0oWeSM=
Received: from ubuntu.localdomain ([218.207.190.126])
 by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
 id 2F2144F6; Sat, 15 Feb 2025 11:11:50 +0800
X-QQ-mid: xmsmtpt1739589110trshu9la1
Message-ID: <tencent_13A8C17236A66023A0114CE9C9209FAC9E07@qq.com>
X-QQ-XMAILINFO: OAowhIcaKHQtIGsuYgeDWWrC19Z5W2tAV0aM7XGlK0LO9rcbT0nj5amTmRarqW
 eiC2bKQgHvbRVguyi2pvwKiDe18njjt3+kwWWLbEJZEBke8qQ7i54q0ay7VkRuWrATwlQLUWgqLy
 /uG69ytPjdemOnmcFO6erMOykDxcbB+orlbTrmQniKPNZUA5K0P63fiw/34+oNArnDCVdEJ/Vugw
 jqnU5huC1Qj5ClKsw5WDfUVwfWBcRcRAJ+mlyZVNTakfP0js2g9w6OIvWqd63A8UzcOPoistkFp9
 0ccI1deRYYw6wEwaXaDGr/LhdsbgEwtlut2kdBCGeNWSlJUtWfPjJBEqf3cD8GMhcMKYk0O8lKDz
 IIP2sc79x1Ib7ghDBVn5VPXEw1zzW0Tbz240XiAwc7VQlY/JcPG3sVMjQsyCGkLcu68UI7cNsIQ9
 0dehWFuPLN+FqyDgn439G9z/sz6bWhQkTcXwoKfeUu30dkCbtVT73Ny9jA1lq9rmYKF+TLFyPCOk
 NBCaJEoVoEeUZP2VfZ4THOFGRSZNYitA6VnnksyM9aUIzsLZ0qhNXZNM3I+kk/YsfAneX3KCqs4d
 wpaawbEEPSHFrisdzJAH4ZtRNf6Ax4id6BubBML6wLNwUWIG7dUVScAUED1CjHCK4YYgoNajlk30
 adEzMRdXsleBQeURrJFDI2xSZ4dtKA2HPpE2yytfYdG+NGFAL3B7QTJRLSQ5uxnn2OvrsYkDc58I
 jpCFbg0jQwAPfkkRUIXngEnyNbyFCoH0lo0WcB1nsvxuzcn1gm8VVvfowcYueXRzfoJKwppuKwtr
 945tUqeXq4UN51EqPJWlDNIUpDxQlWYKvp8WpCcowgnr8sKahcpaMd21sHOVZMgD35i4qOnlCtzj
 qkXeNK2yp2tG3RBtJeiFvrzwoFQoXg7XHIIDmyFeKMTmVMyoCmYjskzF0Hbp58WZQVhoscQrWn/t
 z5iA6KAcYPzpKCSOQnOwQRMGabhk3A9tmRKctixto=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Sam Protsenko <semen.protsenko@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH] lib: lmb: conditionally include EFI loader notification
Date: Sat, 15 Feb 2025 11:11:30 +0800
X-OQ-MSGID: <20250215031130.144379-1-1425075683@qq.com>
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

Compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
without CONFIG_EFI_LOADER enabled will result in an
undefined reference to 'efi_add_memory_map_pg'.

The make command is as follows:
    export CROSS_COMPILE=arm-none-eabi- ARCH=arm
    make stm32h750-art-pi_defconfig
    -> General setup -> Optimization level -> Optimize for debugging
    make -j 12
The error message is as follows:
    arm-none-eabi-ld.bfd: lib/lmb.o: in function `lmb_map_update_notify':
    u-boot/lib/lmb.c:458: undefined reference to `efi_add_memory_map_pg'
    make: *** [Makefile:1824：u-boot] Error 1

Using the CONFIG_CC_OPTIMIZE_FOR_SIZE configuration
will not cause an error.My guess is that the compiler
recognizes that this function will not be executed and optimizes it.

As you can see from the lmb_should_notify function,
EFI_LOADER will exit without calling efi_add_memory_map_pg().
So splitting with the CONFIG_EFI_LOADER macro would be a fix.

    ```c
    static bool lmb_should_notify(u32 flags)
    {
        return !lmb.test && !(flags & LMB_NONOTIFY) &&
            CONFIG_IS_ENABLED(EFI_LOADER);
    }
    static int lmb_map_update_notify()
    {
    #if defined(CONFIG_EFI_LOADER)
        if (!lmb_should_notify(flags))
            return 0;
    #endif
    }
    ```

Signed-off-by: Liya Huang <1425075683@qq.com>
---

 lib/lmb.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 7ca44591e1d..28d31308a79 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -430,27 +430,30 @@ long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t size)
 
 static struct lmb lmb;
 
+#if defined(CONFIG_EFI_LOADER)
 static bool lmb_should_notify(u32 flags)
 {
 	return !lmb.test && !(flags & LMB_NONOTIFY) &&
 		CONFIG_IS_ENABLED(EFI_LOADER);
 }
+#endif
 
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 u32 flags)
 {
-	u64 efi_addr;
-	u64 pages;
-	efi_status_t status;
-
 	if (op != MAP_OP_RESERVE && op != MAP_OP_FREE && op != MAP_OP_ADD) {
 		log_err("Invalid map update op received (%d)\n", op);
 		return -1;
 	}
 
+#if defined(CONFIG_EFI_LOADER)
 	if (!lmb_should_notify(flags))
 		return 0;
 
+	u64 efi_addr;
+	u64 pages;
+	efi_status_t status;
+
 	efi_addr = (uintptr_t)map_sysmem(addr, 0);
 	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
 	efi_addr &= ~EFI_PAGE_MASK;
@@ -466,6 +469,7 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 		return -1;
 	}
 	unmap_sysmem((void *)(uintptr_t)efi_addr);
+#endif
 
 	return 0;
 }
-- 
2.25.1

