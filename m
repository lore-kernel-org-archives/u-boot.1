Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6252C83F04
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 16:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12C1982ADA;
	Wed,  2 Jul 2025 18:02:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/pLhJTD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C4A82CFA; Wed,  2 Jul 2025 18:02:14 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F387582A76
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 18:02:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so59467485e9.0
 for <u-boot@lists.denx.de>; Wed, 02 Jul 2025 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751472131; x=1752076931; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aS5uhLsvcT8esWMMkyNHcv5sq/1mZWHfa6Yalw4TrEQ=;
 b=h/pLhJTDphEbynfyyI6ZvYmgo0oYFv6eVa3NeWWxwOiCyddRIGPk5cEWBDCVEct1n9
 PoFiqGjPCv18icZAj7nDI4qJE9Vp3vZHidVAUwNpXXEO2CaIYFI4yroSnb367dK0L6sp
 KApgiQ6w3RY1ckSAdFhwCXLSuERVWrzw5lXyOquWlT1hWAR3uhCZnlu/txaQ3+xlMWgy
 71RKRVrV+7xNpuBD9Mp9BBzNCruuDHRRECQoW++t0UPbjZnUYfS1BsMTYgYw8NWeEQ9R
 2MktMgztipMBRXTIRkpO59swEEwUlQ2qG3CcLiwLLwJARye0Kn/fCHIFPQyXxcxzD5F8
 6Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751472131; x=1752076931;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aS5uhLsvcT8esWMMkyNHcv5sq/1mZWHfa6Yalw4TrEQ=;
 b=EOwIJHtBvrikTJoZEMoAjih8cxHXnMS3WHb+s5/yNdPemp0P10GQbfiZ/VloqrDSYx
 rsQn7iXR/mTgRjbBbRKSxmzcM8M5Skic2CpCFMoixIDy12KL/NUZ7g2SFzx8S8opRzOs
 U4zXPaCGcKqjVA33gLRFZtErw/uS+MblU3mrPYDbBYYFBboIVSPCASp+UV/aWdfy+382
 JRXL3W8UzQpYquf3WdW7k+CmaTYq3eRWxJRDzRbEudogvA8lBgC08LdIfegoFajcW3kf
 d769LzslFTR2jIKR2hh2HX72NEmwdUTNhnH2YlL0kVAVmh/4Zwh6ec1xm1FGLUxYHjJo
 QakQ==
X-Gm-Message-State: AOJu0YyB0jia9kC6bcjS90ZJwfzATC4nz7LHJs75kjT/RrMS6sTa2kS3
 BP2I0H0O6hp4fI0pRMV/GVh4oeotI++Pxw13hhlxX7IUqleFfPFv8MaBtQ0POsEqep28NH2DvG4
 3TwIGczU=
X-Gm-Gg: ASbGncsSyf5zzG3sdfvcVVrrVhNG3kaVVfgsCUC8D0BiD8UswhsUG7efW0k/+wZko0j
 NlPxr6zbmSZicfj+y1m6/ZKfPCpKWAzjBgu7MAonA38XqTKULMQRwfA22eJZ2RsoNiN+DbyU9qJ
 EnF/rDJ1kBisyfMBCDUrKMjoxGPJoFSHuDuTronITk0/BDHQUCj381TNEC+8edsI1TDVbaygU59
 Yc4maVWalmN8kDF0MAw4tWyzc6yKTQ75PYUvA3pjs+30h4g/r0tARMwZOxH/J+FzA+G3egJaItX
 uCP3ltZbMnKbdLci4h2j5huvIt0+rwDU00QBoTtqbAlEEKQ27wHU0eo5AgSaNuGG8f5YpjhflkU
 55ejcqt9X8cJ5aw==
X-Google-Smtp-Source: AGHT+IHi+7X3p+Gy3yE1Fvs9Jq7rjU9h/COeK1vZve6QdGbrz1wGnxJYqM05bY3dAX2gTMJjruq2wQ==
X-Received: by 2002:a05:600c:4f4d:b0:44b:eb56:1d45 with SMTP id
 5b1f17b1804b1-454a4ad0a59mr32263715e9.15.1751472131121; 
 Wed, 02 Jul 2025 09:02:11 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:e07:801:2aa3:3d9f:604c:fc30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e6280bsm16676733f8f.94.2025.07.02.09.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 09:02:10 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 02 Jul 2025 17:02:10 +0100
Subject: [PATCH] nvme: Fix memory leak on error path of nvme_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-nvme_fix-v1-1-a0d023f4305b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAFYZWgC/x2NywqDMBBFf0VmbSCN9VF/RYpM4rTOwigzJQjiv
 xu7PNxzuAcoCZNCXxwglFh5jRkeZQFhxvglw1NmcNbVtrXOxLTQ+OHdhCo0L1fj02MHWfeoZLx
 gDPMdLKg/knvYhLL//xje53kBdwjHAHMAAAA=
To: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The use of log_msg_ret to log a message and return an error meant that
memory allocated earlier in the function was not freed on this error
path. Instead log the message in the same way that log_msg_ret would do
and then goto the cleanup code to free the memory.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/nvme/nvme.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 7c58ceb78f5..2b14437f69c 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -912,8 +912,10 @@ int nvme_init(struct udevice *udev)
 			goto free_id;
 
 		ret = bootdev_setup_for_sibling_blk(ns_udev, "nvme_bootdev");
-		if (ret)
-			return log_msg_ret("bootdev", ret);
+		if (ret) {
+			log_err("bootdev: returning err=%d\n", ret);
+			goto free_id;
+		}
 
 		ret = blk_probe_or_unbind(ns_udev);
 		if (ret)

---
base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
change-id: 20250702-nvme_fix-c3c6925a4ba8

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

