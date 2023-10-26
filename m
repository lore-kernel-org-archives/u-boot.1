Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D451C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18E498764C;
	Thu, 26 Oct 2023 20:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XomyFd9t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69798762E; Thu, 26 Oct 2023 20:31:47 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92ED587631
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77891f362cfso97736585a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345102; x=1698949902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvxVRkR6NivE5Eyk59BtqOomOa8WJZlAhFpqDjJITTA=;
 b=XomyFd9taOVUUHlul1yhpdz9ZDgQE2sZzmaOB1g0oHkz3mJ6766FqyrF7kL9V4uxtA
 P3U8lX6pzDJHMpl0X74zrfq6oh5GQP/FYo62iPHNCpL7tTbc/7REuJHhNIqVV+EmR6LI
 aTOcMmV4QBHuQ1rrlhaNkeFc4FCimpYmLfEsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345102; x=1698949902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvxVRkR6NivE5Eyk59BtqOomOa8WJZlAhFpqDjJITTA=;
 b=sBRvaP+77gkYNdfhRCautBB/JNn859YSs1eBdSyjm7nFXeoG3v6YEVupP/5ukAWv66
 V3K13Qktlsb8DPzBk3Kr7ZQP5gF2nDayt8MA6l0idI5hhJCc1mSmJayDjTxMNrvX8gUF
 ZMgZWtO/vrq7ZYw8JslifPO1L25jE/v+BheRxoMbLfeSgfXS01rRg/P/woKRva9Z6naP
 GHA4r5prQ8YZhDjjNI/0yDZDFU9iRoy73G95KR2YBuJyCQoFvn+nik1gy9T9LKO2733U
 BOM44XEdhb8eWJzRZuif5L2N9CpMOCYdIH220EHzkcCJ1RHqT2492oZPxDBRpd4YvpAm
 Z/UA==
X-Gm-Message-State: AOJu0YzePItUv+IQ8c0MW1aAuUPGb9hPq/qLJ5mJfRS8N+P2UHeIauir
 YhVehfiHw5gpq9lISZdI+h50rFK9s7USlneLBk74pQ==
X-Google-Smtp-Source: AGHT+IH5U8pqzn6w+AGhJAD5P5DDYqg2ymxQtsXaweEO4jN5idhTrkcYKcMhghURhJUxcsSbMx/MBg==
X-Received: by 2002:a05:620a:2587:b0:774:2afe:97c4 with SMTP id
 x7-20020a05620a258700b007742afe97c4mr4065108qko.12.1698345102195; 
 Thu, 26 Oct 2023 11:31:42 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [v5 03/30] virtio: Make VIRTIO_NET depend on NETDEVICES
Date: Thu, 26 Oct 2023 14:31:11 -0400
Message-Id: <20231026183138.636948-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

As VIRTIO_NET is the symbol for enabling network devices, make this
depend on NETDEVICES

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 852f6735b602..1de68867d52e 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -56,7 +56,7 @@ config VIRTIO_SANDBOX
 
 config VIRTIO_NET
 	bool "virtio net driver"
-	depends on VIRTIO
+	depends on VIRTIO && NETDEVICES
 	help
 	  This is the virtual net driver for virtio. It can be used with
 	  QEMU based targets.
-- 
2.34.1

