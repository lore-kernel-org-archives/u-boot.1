Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AAFC88E53
	for <u-boot@archiver.kernel.org>; Sat, 12 Sep 2026 01:07:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 90E7640815;
	Sat, 12 Sep 2026 01:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c5GhpuEc8aZY; Sat, 12 Sep 2026 01:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B17D4081D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789175271;
	b=hpPaIbZAm8bqtxs0piFfZVaCdAclDeDQknV7+0exhkEFxF/ofv/aVY4U94feSJ5dp35+
	 YWtQ+dzhtHvF0tVIuXm44wwZoakveZZRGLhdNySyKKpInOhK6r061bhDDBQzkg9CJBMfG
	 EazLWhrkoDBtAe3JADmYLfu3JqaeREc9BZzY8OZVVqsKAgF4wDuk3vE31Q/d/6HnjrpYX
	 pSA7iu5Opjtu/SPXdlblVQdC8sEFklL/FYAcPFl1vKytDlPKnW4RKrfEIRjWBhWkFXpbW
	 7L8NJNKQOotWHtXki0NnyE03Y+gagjCrXaysQtjVlP6mETiy/FMYeuNuw3tfgJqiq3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789175271;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gENzPIWyvSiudzPSFGKv8XOgT7nRICydguLNTqlhDsU=;
	b=UY8M0hifX9Q9nwAvSLCMUQTgSoHpkWQ5kVgKpEB9sis4fh0PQFjzvM4ZLOS6wS9gADn2
	 zM1fWgNG2VhkktpUoPgHw5EXCIRTJm45xVRJMFRXFETztl0nmoCaiVvBdDcVFYaiChAWq
	 9l3N6dvQGoK67CieyK+9yI5IU7+JgQqnPyBejUf8/RT+QhT5WD2WsQ8U4HqkEg3InIGK9
	 tvDjJN1+DyVhdQtCZaA1bezF4ct2KYkv6QVzCE1GySn1qs+LcrXwzXGDFwX9B+kg6C79y
	 lNOxL+M6TV2wDpA3jY/Qto6MHScvBYcfNy8MpsYvszz4rgZ7l+m4oFBFH8PF3Q4r9ww==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XNV9YGzO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789175271;
	bh=gENzPIWyvSiudzPSFGKv8XOgT7nRICydguLNTqlhDsU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NFlZI8m9vBvqmlhsYd0I2bqJkDx4mc1taV7frE76eVg0Q2fKxp+MfzdtTYEzlrtoC
	 +qTvnCEpVZP6BpGTD4ob+zpxDxhR4ad2o33QlCScqZluzkD791ruoPVUd5VzwYG0pv
	 448RfjMd4KQXRzo+zRtE/ifWuvnZXFDKaEEyzfg1NmYtN1xn+gYDpqGIeusqagB3fv
	 EBix8TZLLjovICNZqRgSWvr5z4P9U7Idd4CPi9j3koKSADj1JstGAUJy8euHGJ4Ng/
	 /Aqa3kOhH/Chiyj1LrBW9P7v0BpsWEXrIsNczUnahGlbqCyj9thPOcZaKdKDxqSahB
	 Yay5V9jcJxXGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B17D4081D;
	Sat, 12 Sep 2026 01:07:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E84753AF
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 20:32:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE08B407CD
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 20:32:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KWE54Xm7Nx7J for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 20:32:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D8D2F4064B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789158762;
 b=tWOVY+p9oFkupyQ0J/y8Q3QEsxWn++4MTTB5zFBtasyjCLVY0MQRsA7HzcXt4l6WQ9xn
 fy4kIrOaQq4nwP7rX2JQY5uUL+f0qCWSQk1XcOpc3PJ89i2i1g0BeRhnG5+DaFoslMSYb
 IOmdaKb+U5jiOHzzsJ+2hJxDF9T4x/DL25/b9UKDSEmr3v+cMfetASw2n9Ov0+dXzRRjH
 x3QOAaNsY0QYEC7YsyRaH8Jzr+HHDWomRyHKJ9Pl0oLAOh9NDg8lmnhOQZpKmWz5JuSEJ
 UTT8jKSadj0w7dfHQwxWaOGrd+PvKtCyqLZopgVmBysGQzaa8VwKb/l37gGCWharWxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789158762;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=gENzPIWyvSiudzPSFGKv8XOgT7nRICydguLNTqlhDsU=;
 b=Dcc/kST96RmBoanN3cMJ1k1zRIr39wAWweR6ITCW4t+DcHq0cWGt8J5HiclXSAFotroy
 bFFDqeWeBbZJDV3q3fJWx2vG9hWuDh2rBwA3GxGhBK7V28TpAM9ix4qSaQIhrc98YKHnp
 ZjO79TBzxXtUDzPDDxos0XQQwv0xaELbWetX64GS5u4TU45bxJ6ajGC2jE/TU+aotLb9O
 z+LwiQDNsRTM8M9kkse0pk1mRmFLU64l7TSUcqjLgJGYWbx5PjoIi4q6mECubeu6xOf6P
 ZlrdYmVzhUyAOLMiHR36pVrRaev7usiAvd7iHIJ3Ft0YaRZpESZZ9Sm0+PmICtNvZXQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=XNV9YGzO; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:30::10; helo=mail-oa2-x10.google.com;
 envelope-from=romain.beauxis@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=XNV9YGzO
Received: from mail-oa2-x10.google.com (mail-oa2-x10.google.com
 [IPv6:2607:f8b0:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D8D2F4064B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 20:32:41 +0000 (UTC)
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-469fdb78b0eso290522fac.2
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789158760; x=1789763560;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gENzPIWyvSiudzPSFGKv8XOgT7nRICydguLNTqlhDsU=;
 b=XNV9YGzO++t83i2iyB3heoMupgDyxRQ/g0PQ4xYoRH+od8efITsP25p3BwLyzVYmFH
 SWcgMXWbKfSB3pW317SfQ28wIs+hGx0yjWy8KiHvxbBRW/rzznHZ03xvD42jh/GLofkP
 jTcBK2EdQpSkKI8kKKw7Nz7uui51muYafOkRfWihfbTAyD/goSvvmq3YtMVYWSHJOkFw
 r2LIeIN0CyamgNp+/XVHnQSIkgZXRCZ9+hzWtYJ1n4Ko9As0o9X1AXd7O4sqmNsFl/u+
 xfask0uFlBbalE+ev2UNv75caxWnFjNOSvvTdQS75Ocv6wp0ozgx9xNejpMQTgc6K2bo
 oGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789158760; x=1789763560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gENzPIWyvSiudzPSFGKv8XOgT7nRICydguLNTqlhDsU=;
 b=JDWEDa/pvpfCX5rqRpAHnJDHUSgWCgBdYnRweWuVkUfdaLvhbeIzp/l4pwKZoiqczk
 6IzK71map2DCpbsX3bQUowBXdAXpk7uqq6R26Edpi277XvTDPc0tHFoQqB4aGTT3ZYJn
 /fItPMNDGf0DyojPBzUVJYPL3yzbnyDpwSbCehoxtrsRyOEOWGWVHsB2z7bqREFG3til
 Ofvn6eJgutLq0GlLxQvWaihaFOCTeJHqgqNSjSI74OR1XidoCeqbbv+8n7AZi+Ml0uXq
 9MNdbKJ2pPhBwXKFXXl8hQKP5FL2bPwnbKnWbGfKClc9qx7w0mMwbU+fwGyGs7GsYYtf
 0ssw==
X-Gm-Message-State: AFuF++l7txIRcrRVHgDS0pLxHpfU6ecYiHrdDQIl7lDQVC5e0iYusDYS
 6HLFLD9iMIN3uGJZFQL1D0hODUh0Miaswl3xNQcI3F+rWn1p+R6Rd0JsouyBwQ==
X-Gm-Gg: AYBFou0ayjj9NChgr4coQ9dR1jW8PHI0Mx1oc2F0K4giwH06nv+LCmV7TN2+UMW1Ztg
 QyCOkisLOt7FCuT8lLQQeh3y6ESKY7wOJ7dmCp3HqTIjpegyynACTLmC0MOH1qzeQQRPA9HCu0J
 /rGFsH2mmOHuWgyK0lL/sq47B4GXydwbY3+Gn7nSB3DtvXtQDAoE2MP9hGM0O/0etf5XQD66S1s
 eAeAU6YE2jikS9aGe+eBeoZrdE/wt4/ZraGulE/EKSpT46nBmjY8t92Dn4xZrKX/kXQ/EXSEWIS
 KIs2tvsXlYLYaJuxgx3mQrPzeH6mdF2CyAmBV/qiMJTgimzM2QNqDGIBouyq5jpKbbya0vjkETf
 GEITti7q3tyEdgNaLanhn78m40lfYc3v8/dBI627ekzcn60+mu84kBzK2gEkAThuT36Nf0xThDU
 m8BKABtC0i1KxCmBBiB9uBzJmFOZ2dXVqI09FP5Gog/Vs2bu/Q9lyT9VXFVH5HHe/0eVT6A1UYT
 dNQOECO4DxBrSxPYfSP05kQHsv4mHTny+vIylkbmUDyw+G+6nGEc9vdq1fNvDe1rfMcnMix9lEX
 SHv8wpL0oLMtTOBvnRRZwCRZgjBkhl+/aZ8=
X-Received: by 2002:a05:6820:60b:b0:6bd:b31a:4b1f with SMTP id
 006d021491bc7-6c0bd5871b6mr7082906eaf.29.1789158759888; 
 Fri, 11 Sep 2026 13:32:39 -0700 (PDT)
Received: from kerlerec (ip98-178-205-159.no.no.cox.net. [98.178.205.159])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6c09a220714sm3796042eaf.10.2026.09.11.13.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 13:32:38 -0700 (PDT)
From: Romain Beauxis <romain.beauxis@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 Romain Beauxis <romain.beauxis@gmail.com>
Subject: [PATCH] usb: xhci-dwc3: Add DM_FLAG_OS_PREPARE flag
Date: Fri, 11 Sep 2026 16:32:29 -0400
Message-ID: <20260911203229.25414-1-romain.beauxis@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 12 Sep 2026 01:07:35 +0000
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

Neither bootm nor EFI ExitBootServices() stops USB controllers
explicitly. Both only remove devices whose driver sets
DM_FLAG_ACTIVE_DMA or DM_FLAG_OS_PREPARE. xhci-dwc3 sets neither, so a
controller brought up by "usb start", e.g. from preboot for a USB
keyboard, is handed to the OS still running.

Set DM_FLAG_OS_PREPARE so that xhci_dwc3_remove() runs at handoff. This
is the path "usb stop" already takes: the xHCI is reset, its PHYs are
shut down and its clocks and resets are released. Child devices such as
hubs, storage and keyboards are removed first, and a controller already
stopped by "usb stop" is skipped. xhci-pci has done the same since
commit e3bbc1f74e05 ("usb: xhci-pci: Add DM_FLAG_OS_PREPARE flag"), as
have ohci-da8xx and the cdns3 wrappers.

On Apple silicon machines the running controller is user visible: Linux
does not enumerate a USB device attached to a Type-C port at boot until
it is unplugged and plugged back in.

Link: https://github.com/AsahiLinux/linux/issues/554
Signed-off-by: Romain Beauxis <romain.beauxis@gmail.com>
---
Tested on an M1 Mac mini running Fedora Asahi Remix with Linux 7.1.13,
booting through EFI and GRUB, with a Samsung T7 USB 3 SSD attached to a
Type-C port. U-Boot is v2026.07 plus the Asahi downstream patches.

  U-Boot                                SSD enumerated by Linux
  stock                                 only after a replug, at 83s
  stock, bootcmd "usb stop; <default>"  10.1s, no replug
  stock plus this patch                 10.2s, no replug

In the stock boot, the replug made Linux tear down and re-create the
Type-C xHCI instance, and the SSD appeared right after. In all three
boots a disk on the USB-A ports, which sit behind xhci-pci on the same
machine, enumerated at 6s. The linked issue reports the same failure on
M1 and M2 MacBook Airs with Linux 7.0 and 7.1.

Only the EFI handoff was tested. bootm reaches the same
dm_remove_devices_active() call. No non-Apple xhci-dwc3 board was
tested.

 drivers/usb/host/xhci-dwc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
index 3504a7cf4..92b311d42 100644
--- a/drivers/usb/host/xhci-dwc3.c
+++ b/drivers/usb/host/xhci-dwc3.c
@@ -256,6 +256,6 @@ U_BOOT_DRIVER(xhci_dwc3) = {
 	.ops = &xhci_usb_ops,
 	.priv_auto	= sizeof(struct xhci_ctrl),
 	.plat_auto	= sizeof(struct xhci_dwc3_plat),
-	.flags = DM_FLAG_ALLOC_PRIV_DMA,
+	.flags = DM_FLAG_OS_PREPARE | DM_FLAG_ALLOC_PRIV_DMA,
 };
 #endif
-- 
2.55.0

