Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F781CFA459
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 715ED8405F;
	Fri, 21 Nov 2025 00:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22CAE840AE; Fri, 21 Nov 2025 00:38:59 +0100 (CET)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by phobos.denx.de (Postfix) with ESMTP id AFC3F83F80
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
Received: from unknown (HELO iyokan3-ex.css.socionext.com) ([172.31.9.54])
 by mx.socionext.com with ESMTP; 21 Nov 2025 08:38:51 +0900
Received: from mail.mfilter.local (mail-arc02.css.socionext.com [10.213.46.40])
 by iyokan3-ex.css.socionext.com (Postfix) with ESMTP id EF5292091499;
 Fri, 21 Nov 2025 08:38:50 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with
 ESMTP; Fri, 21 Nov 2025 08:38:50 +0900
Received: from ubuntu-MonarchGE.e01.socionext.com (unknown [10.213.104.37])
 by iyokan3.css.socionext.com (Postfix) with ESMTP id 65FCA10D9A3;
 Fri, 21 Nov 2025 08:38:50 +0900 (JST)
From: Masahisa Kojima <kojima.masahisa@socionext.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masashi Morimoto <morimoto.masashi@socionext.com>
Subject: [PATCH] bootm: fix boot failure from compressed image for IH_OS_EFI
Date: Fri, 21 Nov 2025 08:38:50 +0900
Message-ID: <20251120233851.2726487-1-kojima.masahisa@socionext.com>
X-Mailer: git-send-email 2.43.0
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

The bootm command can handle the compressed image, but current
code fails to boot from it.

    ## Loading kernel (any) from FIT Image at a8000000 ...
    <snip>
         Compression:  gzip compressed
         Data Start:   0xa80000d4
         Data Size:    10114520 Bytes = 9.6 MiB
         Architecture: AArch64
         OS:           EFI Firmware
         Load Address: 0x90000000

    <snip>
       Uncompressing Kernel Image to 90000000
    ## Transferring control to EFI (at address a80000d4) ...
    Booting <NULL>
    Not a PE-COFF file
    Loading image failed

To take care of the compressed image, the load address needs
to be passed instead of the original compressed image address.

Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
---
 boot/bootm_os.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 88f7c183867..ae20b555f5c 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -509,11 +509,11 @@ static int do_bootm_efi(int flag, struct bootm_info *bmi)
 	/* We expect to return */
 	images->os.type = IH_TYPE_STANDALONE;
 
-	image_buf = map_sysmem(images->os.image_start, images->os.image_len);
+	image_buf = map_sysmem(images->os.load, images->os.image_len);
 
 	/* Run EFI image */
 	printf("## Transferring control to EFI (at address %08lx) ...\n",
-	       images->os.image_start);
+	       images->os.load);
 	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
 
 	ret = efi_binary_run(image_buf, images->os.image_len,
-- 
2.43.0

