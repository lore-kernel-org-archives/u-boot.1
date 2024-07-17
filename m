Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939DC3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 01:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A35B388464;
	Thu, 18 Jul 2024 03:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lZqXt8WX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACB688AA7; Wed, 17 Jul 2024 20:22:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4728879C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:22:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nyandarknessgirl@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4272738eb9eso53919245e9.3
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721240558; x=1721845358; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WmKfZIyO5wo+gSD/02IKYHwxxEuNMHZf8QhprYVcp8M=;
 b=lZqXt8WXcQjTqTAIQxeSAgkRS2R7HsfI1CUT1tGpHIENHADo69bPkLTvdBSmL2tbiL
 0OHSbQ1YoKOPYqOJCEvfmlhBguRST7pbk9Y/4z9ZL+iS8iO3UfquRCNUdbwCkNI9M3EQ
 5KCARYt313ydIeu4W3VXmmq23KX69li/vxI0qdMqpYqQrtmN3u6Njvi1stkyUHR8TDIy
 e6Wyp3phuFxDLfl/wTYhMCpPDdnPFRgETM87ADbnuG1srcC70PpTf3YJwU1Np1SgSGvL
 obNwXNzndHNWBhs5wqibRu9EVKANY3j8qGrWLKsXx47U5K2Bwy1Srf/P05abKiu0h4Zb
 v53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721240558; x=1721845358;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WmKfZIyO5wo+gSD/02IKYHwxxEuNMHZf8QhprYVcp8M=;
 b=RWe4sK4CzvJ4sdvpD8zIpmYLR7NVdjuOobto40R2qrRvWUfSOeS/YrLqgahGq/Nkw5
 6L7mn4hs6XWkLKr9S8JLbqrJEUBPPW0wPtMiAniCt3bt7M+bhsWC8B1GnyV4B+0ATiRV
 F1zqkXK7Do9W3g1sVwmeF07RIrZ84F6SbvsF96HkHjS3/KhP81nJCdT4UwgEwKnuekxo
 drHw4rFgCx3au3Gr2QTGNXHeQttCD2OZPBVGlG3SSYZhLQaDb0Cr07ti6UGzph/8dLEp
 rS5f9wSeBxOiW+LQ4RBuWDRYmCFlYj91OG6LEpUFUJnrqlM887CxRXMxAuQq+NP6KyYd
 vrYw==
X-Gm-Message-State: AOJu0Yy35LAeSmoybpF3adnoyowUTC2OsQqeQow3SXsIQVga757CIrBf
 NMrwFBq3BKlox4N/8nFrjdg0Af3BKczdNTrGSKZHCe+54XddWGk4ilUo3XeckuxMPjoo5gbquAc
 q5vKOqkdSuESZHyjkWehLO0crCUMXMGto/uTJTw93
X-Google-Smtp-Source: AGHT+IF8weYmGNTElMmhKWfpMdFcoomBrknOVoDbt1WMmjdZZ5vwqyYKYFjllCcxijD4xleCsWsxtse0ci99C1CE4Lc=
X-Received: by 2002:adf:e44c:0:b0:35f:20eb:cae3 with SMTP id
 ffacd0b85a97d-36831750a0emr1599959f8f.67.1721240557939; Wed, 17 Jul 2024
 11:22:37 -0700 (PDT)
MIME-Version: 1.0
From: Eva Kurchatova <nyandarknessgirl@gmail.com>
Date: Wed, 17 Jul 2024 21:22:26 +0300
Message-ID: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
Subject: [PATCH 1/3] riscv: qemu: Enable booting from NVMe
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 18 Jul 2024 03:52:34 +0200
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

From da876ced5ff607a4f21e30ab26fb1a972af56570 Mon Sep 17 00:00:00 2001
From: LekKit <50500857+LekKit@users.noreply.github.com>
Date: Wed, 17 Jul 2024 20:31:21 +0300
Subject: [PATCH 1/3] riscv: qemu: Enable booting from NVMe

QEMU supports NVMe devices, but U-Boot only tries to boot from Virtio.
This is problematic when explicitly using NVMe, so fix that.

Additionally, RVVM virtual machine is almost fully compatible with QEMU,
except it only implements NVMe drives instead of VirtIO.
---
 include/configs/qemu-riscv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
index 2f594bfc..cf4fcb90 100644
--- a/include/configs/qemu-riscv.h
+++ b/include/configs/qemu-riscv.h
@@ -22,6 +22,7 @@
  "stderr=serial,vidconsole\0"

 #define BOOT_TARGET_DEVICES(func) \
+ func(NVME, nvme, 0) \
  func(VIRTIO, virtio, 0) \
  func(VIRTIO, virtio, 1) \
  func(SCSI, scsi, 0) \
-- 
2.45.2
