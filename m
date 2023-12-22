Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EF0C41535
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 15:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCCB877CD;
	Fri, 22 Dec 2023 16:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="P6+nP/zK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95F087846; Fri, 22 Dec 2023 16:02:19 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0578187831
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 16:02:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703257337; x=1703862137; i=xypron.glpk@gmx.de;
 bh=9b1bv3sdKY7JP8aLIJGJG6+cgN3CEvTWv8/ifcncweY=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=P6+nP/zKe5iI7qQ9+Cd7FkOlDyS2ec3O56vu6tQ52aX8Wyr336XCEAmIs3elkpR/
 sDVQxRgcRzYHT8DYRn8+Nwz4DQP/lOLVOrrmqNc8acVWzzqRQpkKxWG/w/fXwlckP
 91ZaYP0JZVYxVEqRuPb5jzHXjrLfsEKRL4WO1MAHt4xDb4AvrR5Vrp3IK1cGN92F0
 53t1DkF+0BBp9g+K1BkT6Nulbo8zYBmdlsPcRmVO33zOC6YCD/9MXWSn3c0u3SwBE
 P+IZ45M2+jWtpXQPO7WeoEkoVgIkfLVa4dv/QC6HaQ9LFtC0g88xgnbudvFuvGey8
 /kn4zjaVwj+SB8ijqQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbkv-1rfGQl3eJv-00P5gd; Fri, 22
 Dec 2023 16:02:16 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] bootmeth: pass size to efi_binary_run()
Date: Fri, 22 Dec 2023 16:01:56 +0100
Message-ID: <20231222150156.39783-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:avBBmwuDi190atLYH7Bjbzmn0a9jjlEoCKnF/adoiibGG+8YsQR
 2/xV6IqW6GXn8C7pX2Q22noekrPosSLOU+oUL+X8MIV37UeuJ2eNIJva3LH+GCbiwN0o1jW
 EK6LZPmzfpMLO0GjA1w5c4Vhd8dzmYb0LC9hoLrCyaED41KU6YGeYOIOjJ/C99oL1hZw6Uv
 mSVZrCxwUwyc585Ys/eWA==
UI-OutboundReport: notjunk:1;M01:P0:V24DXcLmhLI=;aMmhW1fbnTahzIxqgYU2qXF4M0Y
 O3oND0jL1JeKs3fy7nJN6xCHZ3ox1FVxGdSlgzqhVThba7lQY4V9VJLkHeSQheLSkIgw7OqW2
 dxXEkPVR+2RHtNFWFlc40mOGnKPm+pCL5gjYEcOje64BPM7BA+8wbXE99jZdq6wina4mZSL/W
 StJPeSQUDFDB7FK+PfWeIq+vLq+9vHe2vB+dI5pk9wXSXVjJznYUVjTBsDTzbQjj5bItgi7/3
 COSedOeYvvDGKv/BvtwxhDiSBr3p6fGAxTT4ZouDv4B27IHWGU61umrSV5DoJ5+Q1ABZwYvfl
 QL7Xpe6BNwJQyAUhUcIH2gLVqDWkjEugmIZX++tLRi6Kwqx6IaAJN4jeeJU4q5g70erhs8eo0
 nqbmN+1qAvaQA8jxDbwmRdSwVF89FJjtiWHCxrcMmQaRb/G/PfpEP+9dJWyQuU+zG2aQ9Dqwf
 mFxlpmQ+vDR3/rq4OvR5dE4nAQjTx8H9K6itYfec9trSkDjSRUe+ro9wge3fHHo8UdCD7pgeh
 zlTya01b5hj7zGpcxJfyrBLqMFW6ZU22iMNTeVPU+Gp+wv78pF1wtXMJknfeYBKZaqmsv8Lo/
 K9m0pmViCW/QKvtwOQtshBt9zBSe3o0DY2ulVUYsYLK1bFRYPQ57UmcljViZpBxwoHHG+gvg8
 y6705GNzOwM5X4jFVBXOPTmy8u/KLLMI+kaEhyIuEfi2hqJbMFBCR/J6ue4+gGyTIFFeWKB/j
 pkrKDyEY28ElmGmIzLm8a76miFpULt+vWafAafLaXlZTGBsCQGKvZOAeB1owLDFniGi8CeKw+
 xHRZZ2QAup0Yc1y2+KfrSS18MrTbXl40YBYm5Gkb1aqqn6eGo7y/wfQ1CdWhtkKUfpO+IFB/b
 I6z3IELYECRb9rzlZWqIuoZoryZUHcuYASUPhlZ7pP2adnsPHM/ytOnAkWFYcz/17mOg6b8jv
 YU4SvH7EJn4g8cwg1QS/o1z7GDE=
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

If we call efi_binary_run() with size parameter set to zero, we get an err=
or

     Not a PE-COFF file

Fill the missing value.

Fixes: 1373ffde52e1 ("Merge tag 'v2024.01-rc5' into next")
Fixes: 7017fc54a5bc ("bootmeth: use efi_loader interfaces instead of boote=
fi command")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 boot/bootmeth_efi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 00060f7d25..c4eb331d69 100644
=2D-- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -454,12 +454,12 @@ static int distro_efi_boot(struct udevice *dev, stru=
ct bootflow *bflow)

 	if (bflow->flags & BOOTFLOWF_USE_BUILTIN_FDT) {
 		log_debug("Booting with built-in fdt\n");
-		if (efi_binary_run(map_sysmem(kernel, 0), 0,
+		if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
 				   EFI_FDT_USE_INTERNAL))
 			return log_msg_ret("run", -EINVAL);
 	} else {
 		log_debug("Booting with external fdt\n");
-		if (efi_binary_run(map_sysmem(kernel, 0), 0,
+		if (efi_binary_run(map_sysmem(kernel, 0), bflow->size,
 				   map_sysmem(fdt, 0)))
 			return log_msg_ret("run", -EINVAL);
 	}
=2D-
2.43.0

