Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18185C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:07:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97AD874D0;
	Mon,  4 Dec 2023 13:07:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uvM2hW6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC26886501; Mon,  4 Dec 2023 13:07:06 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F18874F2
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50bf8843a6fso707600e87.0
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691622; x=1702296422; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bztCqZtuZeWJbD9MIA2Nj/8rhjf7X26SpwotbAnqAAE=;
 b=uvM2hW6ts0vLgGqXsLOtbeJpLodhuKGX8Nm8d73CcCOLrHn9DZP2mHxsnjBuSGkyM7
 PZMkFFhIMup5P3z23qltmsoPMN0Ykouk5dEeNmNsuIFQBQ3Xn7aqK2suoqCoLU7OF/yx
 ETUduSkA9nL0P3pwubzbRI0UAzC2blDEVmcAd5FcHNEFS9FH+xGbPdqslWj233/I1xEw
 Is7uR6EqtNKeLDm6KhRdDGfrpIIVmUSTME6vO03tNnWFLwrVMLhhpeT02bznhpNbNlR3
 V42CqUcxyji4lnKkD/hkqaE47Rk86Cffn0KJ80RxrP4uc+H88CnXBynORf18YukqZHGF
 f/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691622; x=1702296422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bztCqZtuZeWJbD9MIA2Nj/8rhjf7X26SpwotbAnqAAE=;
 b=oFKNvTRWNO+pT1SjUn84gaZK0fkAbZSRtlrGQeYWRGx+ivQ9ZIusGMQtEP7VSXXZTo
 cUlEN8vZdpr8CnMQmkOWWi0cRXW1z1cq7UVXn3c9DizKLlTiWuLIP49iMM+uugUvf/Hp
 Ysf0aKS4/H/TfUL3LX2MyUaToP3vPobLHKNJ4Ie+FHl+pybI1whiVidkSTLF+/E/0cDf
 HclF666r2jPHH0nKAMx/mwFdhWGWY/+L6gY/6kV408D7z/x9U56/a367Ya3D78YCNPgY
 Z0Y0fS+c/SsegMZL5eSOMcY3vqqIgouIbCXwwModCnIgobtWxB94OxOs4qETTb9q0NDC
 lqxA==
X-Gm-Message-State: AOJu0YwJsl8LlNV4d/tMf0k+WeH18/9zgJgVkgmpte/qrkf/fWM/br3j
 MC+f812k49U3diPnAqBqZj22A2HIVRcigysf4pS47g==
X-Google-Smtp-Source: AGHT+IFDNCTnX0bz9a3Pk6iro0C1jYLO48LZQmxo2wDFLc4cJTicgZRzVhQPlvLKWeunqNaIu5r+lg==
X-Received: by 2002:ac2:4c07:0:b0:50b:c227:57e5 with SMTP id
 t7-20020ac24c07000000b0050bc22757e5mr2757155lfq.21.1701691622529; 
 Mon, 04 Dec 2023 04:07:02 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:02 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 1/9] test_net: print out net list
Date: Mon,  4 Dec 2023 18:04:38 +0600
Message-Id: <20231204120446.3277-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

