Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2785C5B543
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 12:18:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE68280E9A;
	Tue, 10 Jun 2025 14:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HPqj/vjq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5CA082AC4; Tue, 10 Jun 2025 14:18:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93F18070C
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 14:18:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45305c280a3so9484445e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 05:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749557904; x=1750162704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kHfGVo4IekgbEs9K8jT3a+DXamvbwglVtDhPBFh2/jw=;
 b=HPqj/vjqfFKZqez9+QEE2xgsk/D9loYV7mttZxUPBmQzvOxDZFFwJGJ857H3Sb3lB0
 FZBzNfC/eyuu9VbUZgRH2Zr1f3As1BDF94TEeFW/QR9nGwD/Jl6Dn5PhcfrQO6C9/24C
 6P+HUYGG2YqNs7CvIDKF83BbcLC2OjMup47Txar82s/VejMN8B48UinbslConkAaGxGl
 bpa/JiLkN1tfmpewOQT5JD2QsHObkOZyQixpF2olmRJHEIDP79pb50AtMmwBatpaORad
 Zbga3aYlHyL3BtzWFI6zk/3IEYo/lYYPOHli6e94hWt83su2fVs/5Y/9hpoPpQreZSQi
 t7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749557904; x=1750162704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHfGVo4IekgbEs9K8jT3a+DXamvbwglVtDhPBFh2/jw=;
 b=LBH+T7xkS+TJoNdHrTgKr3eo775uG4UfKC9TiP0R1tep0lsdcZCfFW/P2im9a1Yodv
 LnqUY7P8aF/D6BO3MUvDjV7se+sCI1yh9CjJY6DJhiYciJ8cY1f8gtOFRb1aS2HpVo6f
 wDpN3oyvVEbK5hvqTAOVhJ07MrOxBxuSYiKcqS8XqMnS3ihn54CeMWr/NPdo2iIaG7mx
 NQklZHoEE5fwPQ6CDVI0cL4YLVc5C03BEpCik4OI6BLs5CSGdfMHm8ydWgDx1oLaJuVM
 RJ1+dlvut/d8EI7EXd1/TMpfUtdffTFowLE0ESANz+6NmdNqRSL4tRZJRzy+4N79yi71
 MYSw==
X-Gm-Message-State: AOJu0YxL0IXT95ZktPx63IMxZZch27DWHh/HykLsDR6IP+/G67seI3KD
 BDFy/wwZ/Azcdi5aBquWcuh6FShUsuECIl+10pJ13pZOH/hQu1OWDn5KGiPx+G9+5gHTB2u5Xv7
 xyMkJ
X-Gm-Gg: ASbGncs3Zm9C5afeIOTxCA9NP/Zxssgy0Jkgl4D7aB/g6pUpIdPV/Oh+UR/miRxa5Bs
 G0Aumiu5HYgQYVR/GO/QPanksOdUVnypSctQ7gz9D1RBcoPmH7zUPFCcK33WLB/EKu6ZBw2ji5m
 hc+2Lk/n/xnafGRh7f/o3GtWNbVdnXkbLZiS3ofwvjW6DhQ1vOwVqqVgQIRVG7+UMgS+pF0hZ8T
 iFMi3uevPo2GN5E82d0tORpnfk+M+W/DusKg1XXcJ3GWalc7rgHDRNlFhTD/O7cnj2Elr3JOdhz
 SlSdhZZHbXOHgk+cTTFQYK4eQuoNXhhYAmBNzsDi/YVT7piR6/+noPvNSNR5RAVH9pqUVmc=
X-Google-Smtp-Source: AGHT+IHT9s8JLQrdISp5uhlQEi3JQtnyWoGpDe1mg5Lk3VtpMhzwsfFpfQen7/EGfN051vNCK4d4uw==
X-Received: by 2002:a05:600c:c166:b0:43c:f895:cb4e with SMTP id
 5b1f17b1804b1-452013ab4b2mr173629025e9.17.1749557903859; 
 Tue, 10 Jun 2025 05:18:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452730d162asm137363855e9.39.2025.06.10.05.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 05:18:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Mikko Rapeli <mikko.rapeli@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1] usb: xhci: fix crash with arm64 QEMU and KVM
Date: Tue, 10 Jun 2025 14:17:57 +0200
Message-ID: <20250610121803.3111973-1-jerome.forissier@linaro.org>
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

Add a xhci_flush_cache() call to xhci_start() to fix the following
issue when running arm64 QEMU with KVM support (on a arm64 host):

 $ make qemu_arm64_defconfig
 $ sed -i 's/CONFIG_BLOBLIST=y/# CONFIG_BLOBLIST is not set/' .config
 $ make -j$(nproc)
 $ qemu-system-aarch64 -machine virt -cpu host -enable-kvm -nographic \
                       -bios u-boot.bin \
                       -device qemu-xhci -device usb-kbd
 U-Boot 2025.07-rc4 (Jun 10 2025 - 12:00:15 +0000)
 [...]
 Register 8001040 NbrPorts 8
 Starting the controller
 "Synchronous Abort" handler, esr 0x96000010, far 0x10100040
 elr: 000000000005b1c8 lr : 000000000005b1ac (reloc)
 elr: 00000000476fc1c8 lr : 00000000476fc1ac
 x0 : 0000000010100040 x1 : 0000000000000001
 x2 : 0000000000000000 x3 : 0000000000003e80
 x4 : 0000000000000000 x5 : 00000000477a5694
 x6 : 0000000000000038 x7 : 000000004666f360
 x8 : 0000000000000000 x9 : 00000000ffffffd8
 x10: 000000000000000d x11: 0000000000000006
 x12: 0000000046560a78 x13: 0000000046560dd0
 x14: 00000000ffffffff x15: 000000004666eed2
 x16: 00000000476ee2f0 x17: 0000000000000000
 x18: 0000000046660dd0 x19: 000000004666f480
 x20: 0000000000000000 x21: 0000000010100040
 x22: 0000000010100000 x23: 0000000000000000
 x24: 0000000000000000 x25: 0000000000000000
 x26: 0000000000000000 x27: 0000000000000000
 x28: 0000000000000000 x29: 000000004666f360

 Code: d5033fbf aa1503e0 5287d003 52800002 (b8004401)
 Resetting CPU ...

Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
This is sent as an RFC because I am really not sure what is happening
here. Is this the proper thing to do? xhci_flush_cache() or
xhci_inval_cache()? Where exactly? Which size?

 drivers/usb/host/xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 3ee1f67190f..7c5a898cf3d 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -159,6 +159,7 @@ static int xhci_start(struct xhci_hcor *hcor)
 	int ret;
 
 	puts("Starting the controller\n");
+	xhci_flush_cache((uintptr_t)&hcor, sizeof(hcor));
 	temp = xhci_readl(&hcor->or_usbcmd);
 	temp |= (CMD_RUN);
 	xhci_writel(&hcor->or_usbcmd, temp);
-- 
2.43.0

base-commit: d7c449c3d83a986d61e38d1762433c0607caf5c5
branch: qemu-kvm-fix
