Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEDBE7718B
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66A448036E;
	Thu,  2 Jan 2025 17:27:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AAD180352; Thu,  2 Jan 2025 10:23:07 +0100 (CET)
Received: from lisa.dawes.za.net (lisa.dawes.za.net [178.63.77.189])
 by phobos.denx.de (Postfix) with ESMTP id 9558980040
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 10:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dawes.za.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lists@dawes.za.net
Received: by lisa.dawes.za.net (Postfix, from userid 1000)
 id 5FC6B140158; Thu,  2 Jan 2025 11:23:05 +0200 (SAST)
Date: Thu, 2 Jan 2025 11:23:05 +0200
From: Rogan Dawes <lists@dawes.za.net>
To: u-boot@lists.denx.de
Subject: MUSB compile failure for imx28
Message-ID: <20250102092305.GA18027@lisa.dawes.za.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 02 Jan 2025 17:27:20 +0100
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

Hi folks,

I am trying to get a modern u-boot running on my Wink Hub v1 (Hi Fabio!
:-)

One of the features I am trying to enable is ultimately usbacm console,
but in the process of trying to get there, I first tried enabling MUSB.

diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index fdab7ef73e5..8185c7e0d5a 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -70,3 +70,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0525
 CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
 CONFIG_CI_UDC=y
 CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_MUSB_GADGET=y

The result was a failure to compile:

  CC      drivers/usb/musb-new/musb_gadget.o
drivers/usb/musb-new/musb_gadget.c: In function ‘map_dma_buffer’:
drivers/usb/musb-new/musb_gadget.c:108:40: warning: implicit declaration of function ‘dma_map_single’ [-Wimplicit-function-declaration]
  108 |                 request->request.dma = dma_map_single(
      |                                        ^~~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c:113:43: error: ‘DMA_TO_DEVICE’ undeclared (first use in this function)
  113 |                                         ? DMA_TO_DEVICE
      |                                           ^~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c:113:43: note: each undeclared identifier is reported only once for each function it appears in
drivers/usb/musb-new/musb_gadget.c:114:43: error: ‘DMA_FROM_DEVICE’ undeclared (first use in this function)
  114 |                                         : DMA_FROM_DEVICE);
      |                                           ^~~~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c:117:17: warning: implicit declaration of function ‘dma_sync_single_for_device’ [-Wimplicit-function-declaration]
  117 |                 dma_sync_single_for_device(musb->controller,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c: In function ‘unmap_dma_buffer’:
drivers/usb/musb-new/musb_gadget.c:140:17: warning: implicit declaration of function ‘dma_unmap_single’ [-Wimplicit-function-declaration]
  140 |                 dma_unmap_single(musb->controller,
      |                 ^~~~~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c:144:35: error: ‘DMA_TO_DEVICE’ undeclared (first use in this function)
  144 |                                 ? DMA_TO_DEVICE
      |                                   ^~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c:145:35: error: ‘DMA_FROM_DEVICE’ undeclared (first use in this function)
  145 |                                 : DMA_FROM_DEVICE);
      |                                   ^~~~~~~~~~~~~~~
drivers/usb/musb-new/musb_gadget.c:148:17: warning: implicit declaration of function ‘dma_sync_single_for_cpu’ [-Wimplicit-function-declaration]
  148 |                 dma_sync_single_for_cpu(musb->controller,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:257: drivers/usb/musb-new/musb_gadget.o] Error 1
make: *** [Makefile:1915: drivers/usb/musb-new] Error 2

This looked like it might be a result of the #include <common.h>
removal, so I tried directly including linux/dma-mapping.h, but that
seems to not be the correct approach, because the arguments to various
functions are no longer as expected.

Any ideas on how to fix this?

Thanks!

Rogan

P.S. For what it is worth, I seem to have destroyed the console UART on
my hardware, which is why I am trying to enable USB Gadget console. It
also means that I am unable to provide any console logs from an actual
running device. I do have another on the way, but right now, I'm
actually trying to use the flash chip on my Hub 1 to hold an image read
from the Hub 2, mount the various filesystems, and create a file that
will enable a console on the Hub 2, which is otherwise locked down with
HABv4!
