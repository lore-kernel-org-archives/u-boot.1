Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B140C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1471987657;
	Mon, 27 Nov 2023 14:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Criy/+Mf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F0B87617; Mon, 27 Nov 2023 14:00:49 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60B0587570
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-507cd62472dso5277213e87.0
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090046; x=1701694846; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bztCqZtuZeWJbD9MIA2Nj/8rhjf7X26SpwotbAnqAAE=;
 b=Criy/+MfeFxXTLPA7+ea9wPn3IU0J5vrJ1cVVYpkPKInbGhBmohJgp5gV5vSQVabIo
 TCJZHQ83CXSkn7+4fJ+vLZEfOSq2XwejtYocwXASOzcjcZ9QADm4RmSUA1R9MbzYDDhi
 1p0A4zBf+JBfzIOiBpS1wcQGnFfO2aS8VUP/ailtK+guemypKro3Ly25VDIW8dCDCE+e
 Ue5o2XsjHl6ERAmv6tD43d5Z8Ttc83HzNUfLlOaCSO4fwjWBlno3GhAXhdYD2rJF/QeE
 7em2Eqsn30b8nI5kGR/OqujkQdyd95seJjKF/AwfUiG/AysUZIZf0f4jeIqKYSAkNy1Y
 tHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090046; x=1701694846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bztCqZtuZeWJbD9MIA2Nj/8rhjf7X26SpwotbAnqAAE=;
 b=vHHPPdC4ZXucjbfhRRGi+fLFT72m5udio9sLqkIGccz8/hl/wSggJySS9PnOJrVQsV
 cm5GDRoBuJMXGp6tj2ry6owU2vXeQYR0dtc9+zPyARbjg79WzFc6rwXzDEFjQLLx8q9N
 GYqXe7xTK1eqcrP6ZF0B6xUii0ULHFOTKsXCURLgUVSr1Yf/JK/0zwDR7qWdoqru8YpB
 ycBFTq5UYbwerkJVXHyZRYCECuI+C9oxn7mVIpipehoRdCgKy24TV6a1/yb8553v3fmG
 uHPVNSnKkBpJtpG+qRJz/OAA1I5jSQI+rDbizMy3uhrgRWCdziQZ6kfIhG8BdmHZaHWr
 ISjw==
X-Gm-Message-State: AOJu0YxEDV+nm4wnjqLOp38u1eftZmCDsQhZfjgEGKsWKmt4gcMmZMPX
 RaOJhH+TrKQ/pKFyVVZOnWxpf6pJLh7gpde5T5gYbg==
X-Google-Smtp-Source: AGHT+IG1ZvyaZGKvt6/JdrrMS7eN4RFQwnqVKwXCz9/QCi9px9G6TmZxEbKJ1nG+gvplAQmSqxDMIQ==
X-Received: by 2002:a05:6512:3b86:b0:50a:ae89:491f with SMTP id
 g6-20020a0565123b8600b0050aae89491fmr5769705lfv.3.1701090046125; 
 Mon, 27 Nov 2023 05:00:46 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:45 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 16/43] test_net: print out net list
Date: Mon, 27 Nov 2023 18:56:59 +0600
Message-Id: <20231127125726.3735-17-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Printing net list is useful in CI log files.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 test/py/tests/test_net.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_net.py b/test/py/tests/test_net.py
index b2241ae6a4..cd5b791a6a 100644
--- a/test/py/tests/test_net.py
+++ b/test/py/tests/test_net.py
@@ -96,6 +96,8 @@ def test_net_pre_commands(u_boot_console):
     if init_pci:
         u_boot_console.run_command('pci enum')
 
+    u_boot_console.run_command('net list')
+
 @pytest.mark.buildconfigspec('cmd_dhcp')
 def test_net_dhcp(u_boot_console):
     """Test the dhcp command.
-- 
2.30.2

