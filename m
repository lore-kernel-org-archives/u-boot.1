Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFCFCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:01:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13F887444;
	Thu, 19 Oct 2023 17:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sp4sr4oz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11AB8727A; Thu, 19 Oct 2023 17:01:11 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0F58707C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a877e0f0d8so7547537b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727667; x=1698332467; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvxVRkR6NivE5Eyk59BtqOomOa8WJZlAhFpqDjJITTA=;
 b=sp4sr4ozXAPJ0SHAeFenChwv6UnnzpJ/LnbhAbGNW3XRjw+1Ubp0OIee7K3nnzTExR
 cDTGFH6YuLXiE5p2vD7qh8eHWgos8l8wpHpTkUKMZrYDQieaxrWqyXPiyB+vTzKjfaJj
 aYwZHQ8epQCSNyM3gNqGlhxGoupp+GsgjJTmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727667; x=1698332467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvxVRkR6NivE5Eyk59BtqOomOa8WJZlAhFpqDjJITTA=;
 b=wy5aVO+6mg70FhTPvjkRYHVNDfR/nydJb7AqHnBA3bgODlBoA5H55Fe9cqHtXHUwwB
 +rLkDrzVBaItp/EDe/iUzhfYQbDHsURnXG6Tpy3EGRHxSR8W4LeMM0WevDYwjnvh1/Qw
 UJ+/nypDXhWYvoaj3Mp2yRsJTr+/lpxB12CqWlbU3khA9saoS13IV/V5gTGgxjGdGe1y
 ktBqF3DqJsPBWf7LaBDn7P2tsF4Z4brfCSqhshqO5zkCyGrxIUJOwuHM0ynSaz/i6A9z
 ejffbQy3s9uHfkeM8gWOAJ3aAoN2l3cFBZHzppKZu9Jr79lORykcHHaLSwT7pTC6dDBt
 gUyQ==
X-Gm-Message-State: AOJu0Yxt6dlQ3e7CDttt24ET7jafTa+SQocBCxbpU3C22QZL7/slzV1I
 BOVWdxrBcpB0bHx4YHygqz6eX8DHBIQSdsmmYDuo1A==
X-Google-Smtp-Source: AGHT+IEU+DAij2XQClQKpZSFDAhnxoWgaAUAkO5fH/t1rZwc5fA2BjJnSjbjAq5yxjKy2lG8uNkREQ==
X-Received: by 2002:a81:48c9:0:b0:5a7:af51:fa39 with SMTP id
 v192-20020a8148c9000000b005a7af51fa39mr1597573ywa.8.1697727667422; 
 Thu, 19 Oct 2023 08:01:07 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:07 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>
Subject: [v4 02/24] virtio: Make VIRTIO_NET depend on NETDEVICES
Date: Thu, 19 Oct 2023 11:00:43 -0400
Message-Id: <20231019150105.714407-2-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

