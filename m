Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A826CC46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 15:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE10C87855;
	Tue, 26 Dec 2023 16:48:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VNFAi/7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9F2F878A7; Tue, 26 Dec 2023 16:48:37 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C235987855
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 16:48:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e49a0b5caso4846319e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605715; x=1704210515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEdkUVwCAxd+gHv8cv0J+cC7KraHKhGEvjOUuULM4yg=;
 b=VNFAi/7MTHI79vAKBH/PyBSUMRIQGcatWeVmjscWqPAoyT3xa4EgAb7quAASGatnoX
 n2g0ry21riKSY1d4XBaF+baC+1lGUXOVGm5G+OlxY0dJUj6BIfwLeSEEx8mfINx/j2aE
 OW6CpitnMZdxu/4J7JbHDX47dgK1B6gb4L0QeBRQrInnzObJNfP/pgVnJRfRr/njL1gK
 E/DTlfT0KXYsk9JeiUo78tcIq3YJALRqAZmEL/5QGSSwdPXdG/UP11SNJ2cVK9hRCi0N
 W2wA2Z8HFjOcdfKhLQMnKtnFYwzwX8dU1chyxaTwn/sjYjh8EUwh63Ayi+YoLI5YGpQE
 Mx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605715; x=1704210515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEdkUVwCAxd+gHv8cv0J+cC7KraHKhGEvjOUuULM4yg=;
 b=UxZIFguafOX2nGtL7LqWuku/2daCUUZfqKL9DsSafSwuFX+lX9gAYY5NA7W6qVlkYR
 NXBbyX8ybYE5A/o9GY8xIKb4fKL15ZsxgrU6u75PuuI/UdG+kctWfEGwVX+04lfPOHHj
 UU3lA0Rl/Ho9E0a0JcjVsZLDU4OCV61tPVYP5XYmB4bKsdiPNNSNkxuTt1wb44AyrKLK
 r2++EIR4tk+gsCKw6CL/ECLqfCWADkxIja7oZFWvoLp/qFacNmV4tS5m6NJVPuj25Qyt
 4hpCvSxrkge7NAkc3QsectWhQXiMO1xPnGyS/1L+0ZBfFQ7dUC0UhqlHaUQGETZ7H9xG
 8mbQ==
X-Gm-Message-State: AOJu0Yzy5MKlS7IbweB2e6ysCtP6Oeu/keZw2U7D9GzDCeTaD4dDkWXO
 y3UDeKkxkX+R/G+6ufMyKHHOy1okBgCklEV09pP8qxMgtwo=
X-Google-Smtp-Source: AGHT+IF2p6FTAJ0y3ez8BiwC/4VeueODUOZ625ZmandBHVywoIq/TdBa+1gL9QupTgnNnvAZ7+w7YA==
X-Received: by 2002:ac2:5b03:0:b0:50e:6168:c99d with SMTP id
 v3-20020ac25b03000000b0050e6168c99dmr2752607lfn.27.1703605714931; 
 Tue, 26 Dec 2023 07:48:34 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 d25-20020a0565123d1900b0050e743b0b2csm1089336lfv.34.2023.12.26.07.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 07:48:34 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv3 1/8] test_net: print out net list
Date: Tue, 26 Dec 2023 21:46:12 +0600
Message-Id: <20231226154619.5071-2-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231226154619.5071-1-maxim.uvarov@linaro.org>
References: <20231226154619.5071-1-maxim.uvarov@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
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

