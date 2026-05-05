Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CF0CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6EE846F4;
	Tue,  5 May 2026 09:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="MzLbUnMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3126F846F9; Tue,  5 May 2026 09:50:10 +0200 (CEST)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D898470B
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2b4650d5f5cso17880915ad.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967405; x=1778572205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mcQbEokf3f1JmuRE8BVjx7qhxlE+KPA9G+TcfG4z2M=;
 b=MzLbUnMZU6/G6XCJMp0+SVqpPC2nIgEVyQosDDzkvlE+QOV6S3ehRd9hxJHfndBpLj
 /o5t4JB3J3/ouwYvksrrvOQFyE20XmdDtVtYPyz/gRSXFFVbomZp2W1+FkMVgNqCVyDe
 N4cISpc1e7jN7fEBQ303BfExkIcsJWLumb1sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967405; x=1778572205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mcQbEokf3f1JmuRE8BVjx7qhxlE+KPA9G+TcfG4z2M=;
 b=JKnylmcz9d34+AYBRyI/lKp7wec+kG9pRmC0/S6Xq32Xw41fZFi4tcsxZirytoM8y6
 XMn2xM7o97hvw/d6khacap8huGMnYi5gbx8EM8EGRUsxgOB5ShSkb3aJlBHWv5FwzGd7
 cWPA5EEBxv1hZ939a8PXO6aFSP+20c6Zorkb4XgPHaFy16USKBxNPCztdF0AmJ3oZygO
 NvhPpuzCbqDEUdH1OyUYXeGrOZj1wlqFgVnEECspcRA3x+3HyjcBp2HksD+ZAQGwCaYq
 whOJOS6QztkiGGfRlHxwGsZaxF7lJRrdnVbDPV3AWKJiATvABInAqN1enYxPKEaMzqg4
 9W5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZzJX51uEOth9RcpqxfkqER6e2Oapxf6gjzFoEDCt87H/5Q26lr01av3ouxPRxXGLrqZMR73s=@lists.denx.de
X-Gm-Message-State: AOJu0YwLKewuA/HFmrtUY7UQC2qoKU9gAiz2vKWLN8Aq9WfW3Cq3s/Ap
 Eh6bW7EbyUBB0XrybnA1wPsIamTcyPtwXgqsLAz3PX/eMHFNRSlM/3fGLANv1sFOPMc=
X-Gm-Gg: AeBDietf4paP/0R9rnFUgYgm8TrYECPkLrif+nNPOJ5ElPhQdAfhKNTHK8c0xzxcCJi
 Pxl1Buawf6iCPbS9B0e7fgXGYcMMA0sgyYHzqunHDrV5hfUcUq5RnouG7X/DlM5x7wVbPoZ1uro
 Z3ldyOAhuB54tPMXHSFUCzXIeWI5EHeqK2KBL4wyCpmwTVSb1HwyJBXTBFbe5SkCLQbXFG36Eei
 nG8KnET3edUQEmBCE0zKnI4QdM+FEUg/fWiGbqan1iurlrExD5whMEbm4R8hlYTYNDdKspjtFgM
 lpjfdaymfHXwsf3Tzz+FRsEj4xB3GjJnbR5ZEp6X5ja+NfBj7NesLxw5FU/7EQzi/J19ky60gDN
 E1NAZEnwImJJYqkfczO33bRTMiVX6VGR/nk5pNptnyvITUPa2C/VOh2HF2ZA/FfnJrtdCMOzeHS
 FbdGpuWxwpbWKycRfXbyGrbW2CVCaIyKbwk45L//u5eOFc0MftRS/qflPv01IeLH2l0o8aDUIP5
 pukYtC73258aBCBfZZu161owGI=
X-Received: by 2002:a17:903:4b03:b0:2b2:5203:acd3 with SMTP id
 d9443c01a7336-2b9f2810086mr115239135ad.26.1777967405033; 
 Tue, 05 May 2026 00:50:05 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:50:04 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 6/8] virtio: cmd: Depend on VIRTIO_BLK
Date: Tue,  5 May 2026 16:49:39 +0900
Message-ID: <20260505074948.2603870-7-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
References: <20260505074948.2603870-1-daniel@thingy.jp>
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

The virtio command is calling virtio blk functions but currently
depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
causes the final link to fail.

Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
on just CONFIG_VIRTIO_BLK

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a196..032e55e81276 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1871,8 +1871,8 @@ config CMD_PVBLOCK
 
 config CMD_VIRTIO
 	bool "virtio"
-	depends on VIRTIO
-	default y if VIRTIO
+	depends on VIRTIO_BLK
+	default y if VIRTIO_BLK
 	help
 	  VirtIO block device support
 
-- 
2.53.0

