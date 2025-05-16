Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F00AC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 17:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D776882A8B;
	Fri, 16 May 2025 19:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aC5lrtag";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA23882AE2; Fri, 16 May 2025 19:54:40 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA0C480107
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 19:54:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ant.v.moryakov@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-30effbfaf4aso25055821fa.3
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747418078; x=1748022878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7UWjcYxrVCUZMhuU4j5L9AGusI1H9THcmSs7JGZjupk=;
 b=aC5lrtagk++BcDDd2VZeiHk2iIlF5nkHiSaUe7LfMgoleFeMBBN94QYiakyai97+Ul
 TcERtaVzNvh0w1O0QU8/a+0fU0+GWANOW4ECqFCq29FsIr8+p1JP3UTYaXBBXZLZ9wGX
 vlvN/EPXBG5Dw3dR9aTIXSQ+x1P2zEU4f6vqsb0GuODFVBHv/nC5WPELWl55Z2VQKd+g
 flbPc8Ok5ZcFin0wubiXqejYnifwgTlX0SCeX6IJeuweLC1sPcEdKasJDzjmg46+s+id
 uqhzqRHv0W8RoSHZ32x0HPkmt9Vs1L6NrAgmOShqW9uFkgFoMid4s2+vaF33n7EO/TG8
 UVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747418078; x=1748022878;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UWjcYxrVCUZMhuU4j5L9AGusI1H9THcmSs7JGZjupk=;
 b=Sb7r+1Dstq66LqajHxP3CAImjyAJvQoodocHSwcSjKFTvjwxCY2i8JgsMbRVMUEqeh
 LV4NeCluby36lDco7EnO68sRyx2BH8DLCZiL7CSBvG/7z2wTvfrruH5SnVpWR+uJRBto
 bvDFGKhUT6dTEBdm9MtiyBj3zBLsxCuglJK8m0STLTFPhoUkVxIhYHKQBrKz5XUa7yM0
 hPnhI+3qp2OFEhjc8PxogJUSIWHj2/ZmWlSOz3HcOhr4ZZ0xRAYDSHHCPG6ctTnf6YRO
 XA4WRDkTiq0ZswOS2YgKpcuFidVi2lTVT8idO0qLEwbsbP/odaAYb76nmyl7FEgbnQNP
 B/eQ==
X-Gm-Message-State: AOJu0YxTtJmadDVoZOkO/OiZB/8b2+p1wp0GbQEPzU+YLicvVGeVX7PA
 4qY8oaVHU3XnKJYk+7P9dqRJUpP3BW4KVEO/2fR2z8oUc+xWXibSzuneEhJS3tJj
X-Gm-Gg: ASbGncs0Qayk41lMekd5m6Debebtxvw9+bFVAVoEV+YJufmo+ijmIFb0nupKKQEh8Cf
 XUiAf9O29tkAD9nj7Noa98FIXgig0M2Slxcs4iNvayPjGToH4rw6Q+D/tzEcEMOtAdWwK7cp24y
 eiemDGLhuZfVkxnnmVh5p8vOoWK0+bgyAMfxgSKOlydHRnHH/0N4Cbp1nJDPcqnh25JC+bjtkxw
 uDKF/66rETjQLbXzW4g60VW505dce9sgcbMo+P02Ms/G1NXlWO3tiGDebSGkdY2nw5iIgJnKU89
 Kz888Eej+Aiz+rrPMmtkjEj5iCpUN4DmdG997yTeu+Hl2aIeuZlXQ+L9BQGtmmKeTZklC8rW/kC
 49FQ0V++MJ9puKmvLr8TZUTuUPhAK
X-Google-Smtp-Source: AGHT+IH79U1Cd5SbARK3NdJ6Q5IDeh+rGU3U93rKgBCebl2VhlpOK6Ie6Jflud2PPuA39R3aFqMIOg==
X-Received: by 2002:a05:651c:3131:b0:30c:7fe:9c70 with SMTP id
 38308e7fff4ca-328096ba9c1mr12032401fa.15.1747418077407; 
 Fri, 16 May 2025 10:54:37 -0700 (PDT)
Received: from anton-desktop.. (109-252-120-31.nat.spd-mgts.ru.
 [109.252.120.31]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3280ca53e93sm3637031fa.93.2025.05.16.10.54.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 10:54:36 -0700 (PDT)
From: ant.v.moryakov@gmail.com
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] drivers: usb: host: fix prevent memory leak in interrupt
 message submission
Date: Fri, 16 May 2025 20:54:34 +0300
Message-Id: <20250516175434.124221-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Anton Moryakov <ant.v.moryakov@gmail.com>

Ensure int_queue is properly destroyed when receiving wrong buffer
by adding error handling path. Fixes memory leak that occurred
when backbuffer validation failed.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 drivers/usb/host/ehci-hcd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 7d5519c65a9..765d8b327ee 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -1557,6 +1557,7 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 		debug("got wrong buffer back (%p instead of %p)\n",
 		      backbuffer, buffer);
 		return -EINVAL;
+		goto err;
 	}
 
 	ret = _ehci_destroy_int_queue(dev, queue);
@@ -1565,6 +1566,10 @@ static int _ehci_submit_int_msg(struct usb_device *dev, unsigned long pipe,
 
 	/* everything worked out fine */
 	return result;
+	
+err:
+    _ehci_destroy_int_queue(dev, queue);
+    return result;
 }
 
 static int _ehci_lock_async(struct ehci_ctrl *ctrl, int lock)
-- 
2.30.2

