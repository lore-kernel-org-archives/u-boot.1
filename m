Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D746C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 17:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF56A871E9;
	Tue,  7 Nov 2023 18:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J3QsI7Jv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C3D486F9F; Tue,  7 Nov 2023 18:34:22 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF4D86F9F
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 18:34:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6d31f3e8ca8so3615808a34.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 09:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699378458; x=1699983258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fKkH8KoxucMcGLYOaOq1FaSa9vHcjOF0apPPKbIMCS4=;
 b=J3QsI7Jvu0T4yICBTwl5r7X4pNpan8nenIALXqJe5hllJyr2z5JA5En1uNSE163JfT
 r9rrI1rQoruk1VgbZSvJpmGGuNQ7Zqt833aAX33WlHX1WGuD4u6/oj6AJLRJ7rN1I0M5
 fZPiaDMpXDJdp0N5b6yUN3fqGHy0zpKbF9xXkYpvtwH65AqXeVYpa54Q5X/HV0QfAgld
 GcEKOp0/KrjRzOdLAcu8USGA8bs8sp07w+TxzD2JQp6rgvSCqd5PHTnx19E2NnOXKjvY
 zFpF4s7/YBrKSpzKDv8hsmMHzNUszU8TcNfNLNdrILorMJ/sTxwYKBJwoFrj7h9c2iek
 1mEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699378458; x=1699983258;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fKkH8KoxucMcGLYOaOq1FaSa9vHcjOF0apPPKbIMCS4=;
 b=M49TY6EZLacSY+IQFHTEkWJqt4FsB4PuCvRAkbniYRR3uAmYVtXunDcWG/ho581+OC
 KU9rcv7oNOCRolxLgj70KgYbXJn+28IlIR9XkYMTwctv6+HZRQvO0Hakl95yACL5wG7s
 MIWw8H/YtV17A5mRBfuIrW6ojrpkjr3Kh3tRKO6IQNVysDTXHeq6WI5HUKB4Dxphfu/I
 L7nJQ96xRV3bjmwkNa4X+Wo64X+a2BPUEo4RRn+HaiS6/X15Zse1os1vgI5Le9qmdcjt
 RUyiHnXTCc+zRnSyu1g1vT7cecJDzMMQxe7Lhmyie510/vFZtEc2kXwz9gBPCNv01dkQ
 AErA==
X-Gm-Message-State: AOJu0Yy0gz0cN8nvjz/qBPEgJf1wa4Hv1RHjfYQ5VnTD/nNQBsBOGVDP
 SwSbx5Oe0zVnYmeXrJXyRtyt/Q==
X-Google-Smtp-Source: AGHT+IEU7ckVy/1CWDk86uQT7wRaoSkjqU+QVhO5kbgjkNkI4Aiq+YSOaUqE7HpZUbpLh9JymBUzMA==
X-Received: by 2002:a05:6830:104d:b0:6c4:d7e4:94d2 with SMTP id
 b13-20020a056830104d00b006c4d7e494d2mr32527561otp.33.1699378458409; 
 Tue, 07 Nov 2023 09:34:18 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 az5-20020a056830458500b006c4727812fdsm1643297otb.15.2023.11.07.09.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 09:34:17 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>, Minkyu Kang <mk7.kang@samsung.com>,
 Thomas Abraham <thomas.ab@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH] serial: s5p: Fix clk_get_by_index() error code check
Date: Tue,  7 Nov 2023 11:34:17 -0600
Message-Id: <20231107173417.8254-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

clk_get_by_index() returns negative number on error. Assigning it to
unsigned int makes the subsequent "ret < 0" check always false, leading
in turn to possible unhandled errors. Change 'ret' variable type to
signed int so the code checks and handles clk_get_by_index() return code
properly.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: cf75cdf96ef2 ("serial: s5p: use clock api to get clock rate")
---
 drivers/serial/serial_s5p.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 7aeb8c0f8cb7..fe52580d64de 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -118,7 +118,7 @@ int s5p_serial_setbrg(struct udevice *dev, int baudrate)
 
 #if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE)
 	struct clk clk;
-	u32 ret;
+	int ret;
 
 	ret = clk_get_by_index(dev, 1, &clk);
 	if (ret < 0)
-- 
2.39.2

