Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA40E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0924180217;
	Thu, 12 Dec 2024 11:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIuL3Urf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5491E801EB; Thu, 12 Dec 2024 11:07:21 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0858801F5
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9f60bf4so601513a12.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998038; x=1734602838; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cumbc+fUF7YJ+aTg19QgoW+pwIBW6tziSOYyoFBDSm0=;
 b=fIuL3Urf8RaAUrNntSWy+sS8k6LO9ZOhqxOZwKimOER27X4iMgePAp0vY6C56s7R/H
 R7ucoV4+zuhwi/VG3e5TVodeaz0ZzzHIBoGESQsw0IHjKwlylmsfDwfDJN1j95ztNy+h
 zsfXhbDXLnLZ6NJW3D4PmSWu4+JDewh98YRNApWm7ynWCYIYhueCdsCqYbx/H2MeHFWO
 Z5MY9gRIM/quixOreJsetuirti8h6NPYAVoNDl7vAYDCv8xxrHEZtXnOlnQzkM/qXNi/
 E7ymu3YJ90Vq/Swy/tIBc7KxP3CHR1cMbRjadSs9vDsNNwYtLlkyQyc7ITtgQxvENyiB
 WfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998038; x=1734602838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cumbc+fUF7YJ+aTg19QgoW+pwIBW6tziSOYyoFBDSm0=;
 b=qPyyVV2o2rDUkmI1mQVnzF4J5A66ht40X9iJVbpS6Q8kthhZ2gbFWEryeRc8ppbNJE
 qzbkz4Tc2m7st0ZgCV9sgGwLf3yufgZ4JSpRvE6OqSCuNt7y3jVaUmOlt/2StqKYUqwO
 87i52Y9qm6Mf5SaYZZSPEJSUhycNz3DUZDx1eHVrogcinWAVy6YrK8SyDoIfqNH98rhH
 JDIyS3/SSWPl76hKBFDovoSQw69n9S5J85jSBOk1mOwhsTLsVmVq0olSFydD6i/kXkYQ
 y1YpBp5Rntp2ShxpMkn+EdvO7T8cvYZUOxa/cOK5UAcGSXnPt9RW5x22lV91g5EZ9MDB
 SZrw==
X-Gm-Message-State: AOJu0YyTl8yYyFmikiBg8JgbNy41edW/Wokc7/dzX/YQCSHlqRxx/FMV
 d88+j8b5NVg1iMKvnuCI764PlRDEnpsgcxeT/hRbIDeoliFnOEWd
X-Gm-Gg: ASbGncvGB+iOBkRRXXH9awlGMZ54aoWplo2zo+fNLZcfwmYf3le1t/PmpSzCXHP3t9z
 OnuU4MawAIIeQiL8YS0rmdZXrafQNgvukjFTJReDCQy/W5cbK61DF/MDkUHHn68m54PTb/HXcGE
 kxIbbN9VpmLCAphx/XvJ3nWO0l36U3N6xeZkVk+52TI9cNtjejFgSVcdUc3hsNNN2pPwNlvgLj7
 R6dAYL2AYtI57tU8+wPL94tZh6GAzwUFcs4uDJVYGE19f0k
X-Google-Smtp-Source: AGHT+IGUY92RoKYN8FMKGO421HyPYBt0JcAVGYRsHjNB6ndk4O0ldE46ROBYY6dt2UY975FczBe/jQ==
X-Received: by 2002:a05:6402:528b:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5d54dda9136mr216770a12.32.1733998037950; 
 Thu, 12 Dec 2024 02:07:17 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d149b4a049sm10167200a12.35.2024.12.12.02.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:07:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 2/2] driver: clk: tegra: init basic clocks on probe
Date: Thu, 12 Dec 2024 12:06:46 +0200
Message-ID: <20241212100646.5646-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212100646.5646-1-clamor95@gmail.com>
References: <20241212100646.5646-1-clamor95@gmail.com>
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

In case DM drivers probe earlier than board clock setup is done
init of basic clocks should be done in CAR driver probe as well.
Add it to avoid possible clock related problems.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/clk/tegra/tegra-car-clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegra-car-clk.c
index dd4d7791120..a07c16c487a 100644
--- a/drivers/clk/tegra/tegra-car-clk.c
+++ b/drivers/clk/tegra/tegra-car-clk.c
@@ -112,6 +112,9 @@ static int tegra_car_clk_probe(struct udevice *dev)
 {
 	debug("%s(dev=%p)\n", __func__, dev);
 
+	clock_init();
+	clock_verify();
+
 	return 0;
 }
 
-- 
2.43.0

