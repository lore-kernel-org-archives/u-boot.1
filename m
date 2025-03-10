Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96088C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 09:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14625812D9;
	Mon, 10 Mar 2025 10:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="Qis3MGN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3343D8141E; Mon, 10 Mar 2025 10:01:48 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A3738129F
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 10:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e6194e9d2cso3306600a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 02:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1741597305; x=1742202105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tEqZOZAqF/RgHyk/xvmtYPrBDVBKMG0hic0evkf7pU=;
 b=Qis3MGN1rknr77z1oAo8fggsc1UQ4T1zwpqnVFU960OXk877fdv2PHf8kwg8RMUWg/
 QcfONoXik+3iE3Ym+RMLMPjC3LWHcUOcIYicZKiBSjNvY1wLorHZw+SutJ5f4owpAj/b
 eiDGg+fywKq2soKEGDXVAjuodZPBE0HrI27ZYLX0X4d3J+lU76nXAmO4lEN0Gcxh28Qa
 Lpsq3YqmNJsVbEKOpilBwbv82rJj9w1UUWgFuEY9EadUWD7xEIk0mK1+nNum7te/Ozcx
 5SAEHGMMfRGMQagIO+6ytJHPQ5uoKmmy/s9y71a+pNKYPi3fhDJTNaqJULereaqBP37A
 qBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741597305; x=1742202105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2tEqZOZAqF/RgHyk/xvmtYPrBDVBKMG0hic0evkf7pU=;
 b=NlmIkUCwxXfajIyT6MWUwqYSU9Il96INpEGy3JP0U9Mu5hITJ8cTEZJFzm9jYUKm+U
 kmU4vAIPJMGZpsg6ChaTenXOmUJ6muky7pIs12sdZgByT0+r33JS5cV9Kaw8yc17wrQR
 KKy0GcDxuhHlM/Ux0aDV7PC+W5EcFsNybdT3yH0/Ztb5qPEOvucPm9SWIE2rfQxrMNKJ
 aDDmMugIHrIbPh1eHYuM0CfO3RbEWcS9s4bL2Jbs9CpkcI8RbpU0/1JcmTLbewR5LcjT
 uuYqJAE7Cmr8aNNrxknuMV1UU5j4OC/URneTDgMvqzxgTetxjsJbuM497y1USj9FQ4Nc
 QO6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU90ZsTyHCORvWuXCH5Y60nLZ5bd9OMZrJafk1bPOpYcmOHWu+k8h/ZB+vBnzDuIfZs3eeLj5E=@lists.denx.de
X-Gm-Message-State: AOJu0YzqskluR0CstItONALoV+AqHvvKh5bvMKKJCac3Wpa8jcC2TRmH
 NAB9XS9FtSnrTEtL7Yu66agK3/CKRMJ2Z0rXKnNNtLiF4xWAo5WquKCZm6KgCxc=
X-Gm-Gg: ASbGncvH0bT5XnkzmAv9zsnVi4IfOnQIGjsRMy78TFLW6oijyqpyv/CQXHhhFSFH4bL
 8kGyyZASv0ZOmfjn/sZc63yWY1AO8LY78w0z3Q8urefR5BkCEGv6vl/7fKPIirrMb0eZLrNlQkv
 qtKqdB6IHG1sxSyi/SH2momuHkDhc3dYtKVM+CKX1Ocl4dY0B0k9qioG3ucaZzz9WwDsFEyIZ1O
 DDcTZfao+9WlfmG8XJu7TRDPhlG99KSnX23Y9CVTOFnk/RqLg1YDbgVCGB74OUyULrezUVwipUT
 DUdI21APRNs5CmEORGH8y4HA17JVe2X64LljFCZIcV0dzNoPnGL4oMxTijhuHoc2NUgMXpCEVEi
 hQFRjvzqIlA2lhDUrxicmDR84MRXssDimp3VRedZneZoSDHW1Bml9dA==
X-Google-Smtp-Source: AGHT+IHdBxPuZtrzFCxUR/fyXu0APCivgIsal8BjuEVej3OY2CSk/VJcL9RKDUkB6VXPtLteUiwxLA==
X-Received: by 2002:a05:6402:3495:b0:5e6:20de:f79b with SMTP id
 4fb4d7f45d1cf-5e620df0103mr8364800a12.31.1741597304547; 
 Mon, 10 Mar 2025 02:01:44 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e5c74a7184sm6578082a12.34.2025.03.10.02.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 02:01:43 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: Tom Rini <trini@konsulko.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	u-boot@lists.denx.de
Subject: [RESEND PATCH 2/3] emulation: qemu-sbsa: Select SYS_PCI_64BIT
Date: Mon, 10 Mar 2025 10:01:33 +0100
Message-ID: <20250310090137.1645083-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
References: <20250310090137.1645083-1-patrick.rudolph@9elements.com>
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

qemu's sbsa-ref is always using a 64bit CPU and the PCI prefetch MMIO
window is located above 4GiB, thus always enable SYS_PCI_64BIT.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 board/emulation/qemu-sbsa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/emulation/qemu-sbsa/Kconfig b/board/emulation/qemu-sbsa/Kconfig
index 72c76b351fa..f4ad63e681c 100644
--- a/board/emulation/qemu-sbsa/Kconfig
+++ b/board/emulation/qemu-sbsa/Kconfig
@@ -33,6 +33,7 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	select OF_SEPARATE
 	select PCI
 	select PCIE_ECAM_GENERIC
+	select SYS_PCI_64BIT
 	select USB
 	select GIC_V3
 	select GIC_V3_ITS
-- 
2.48.1

