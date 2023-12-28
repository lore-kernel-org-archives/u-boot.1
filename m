Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1710BC47072
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:30:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECE0879A8;
	Thu, 28 Dec 2023 08:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ErDC+6Rn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C0F8798A; Thu, 28 Dec 2023 08:30:34 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4E92878FC
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02AFE3F73C
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703748630;
 bh=mQyPqLDTYu+79m785nHXXP8xI7VMaQZ5NdyhSd6xc8k=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ErDC+6RnNefz8b3uJ3+WV7VxTmOO45mU0Pwf9FuZILTbfAJSx6BeCeiu0OoUS49cN
 lbCuKgU15lSY3LbTK7AkceRA8G8tj6v+FWvzHmE8RXCIlA0EcqKMVCetWgLo3UWsBU
 fAshrmf9sltH7b3PWjDRO02E60TLxH0fDdhxUspgpCnQI/PF+mfEgNnEHcPTKfL6g8
 P1/N7aWBnQ594uesvciuuB5EfE3VPs4V9J2cLlx4NX1zKK5oIUvRu52bLxGhSHmY4l
 N+OhgTAnoiBas6O+iRR5LoIbzoXKWfWe7lRv9n6W257B8jeztQZqCdDrwBfOoNi2/+
 DXx8SGBLm2VPg==
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3369724e899so3632504f8f.1
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703748629; x=1704353429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mQyPqLDTYu+79m785nHXXP8xI7VMaQZ5NdyhSd6xc8k=;
 b=EYGN0i4pabUhOwfhxX0x6issijywvb54dhPlnx425dkqRBRm61jaFtHJtioC92JQRb
 svbBHk+nDhbCgMRM+m4Zv2/I/7R5FVPVwChwjtJTuwCpQGhYrRgQTQ0d2IDRxS0qOWJd
 w9C5LMxF6c3kRH2J0sEp1iodev+aUoYOjbMsRPmu4K7CEyUr//ZrSDW96yCyXd5QHJ4N
 1Wae4VA4dPxTocDcmJv+xcUDsV2+tPGHDgam2OE7+GupXBeO1LyB0NQrS1tF1hr5Uns8
 WRX3sUBAvsIyrnJzdUnYvthfsjZlXp/dmrPV8VM6eugf7RybAen4JardOl1NOMPGeuiB
 cFNg==
X-Gm-Message-State: AOJu0YyN19e8aACXqDdPYBPMV1brg0baStFVAtiyL5eCQT5KoyC3FuFc
 OzZxg/0laAMOU2i4EWMvfgpKwnf2vafv83ipBlRc28XjyurKAIvHJbOBoWr5sKXn6ARKKSOY3L1
 AF+9+qnVWVsMz1pP93h62BWFu0TaEaU8XyHsCmRGivKwzYg==
X-Received: by 2002:a05:600c:4450:b0:40c:1db4:3a53 with SMTP id
 v16-20020a05600c445000b0040c1db43a53mr5265894wmn.157.1703748629362; 
 Wed, 27 Dec 2023 23:30:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9b2z9hyfblHO8b1VJ8ywYR2eiPUgNC5grpRnRWcxHaRzYyB2yQ540xyp+FcVjis+p/Y9kmA==
X-Received: by 2002:a05:600c:4450:b0:40c:1db4:3a53 with SMTP id
 v16-20020a05600c445000b0040c1db43a53mr5265888wmn.157.1703748629146; 
 Wed, 27 Dec 2023 23:30:29 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040d6b91efd9sm967191wmb.44.2023.12.27.23.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 23:30:28 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] cpu: riscv: set correct SMBIOS processor family value
Date: Thu, 28 Dec 2023 08:30:24 +0100
Message-ID: <20231228073024.6508-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
References: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
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

The SMBIOS specification requires to set the processor family in the type 4
(Processor Information) table to specific values depending only on the
bitness of the system (0x200 for RV32 and 0x201 for RV64).

With this patch dmidecode shows

    Handle 0x0004, DMI type 4, 48 bytes
    Processor Information
	Socket Designation: Not Specified
	Type: Central Processor
	Family: RV64

for qemu-riscv64_smode_defconfig.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/cpu/riscv_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpu/riscv_cpu.c b/drivers/cpu/riscv_cpu.c
index d6484d7f4b..034b9b49c0 100644
--- a/drivers/cpu/riscv_cpu.c
+++ b/drivers/cpu/riscv_cpu.c
@@ -98,6 +98,10 @@ static int riscv_cpu_bind(struct udevice *dev)
 
 	/* save the hart id */
 	plat->cpu_id = dev_read_addr(dev);
+	if (IS_ENABLED(CONFIG_64BIT))
+		plat->family = 0x201;
+	else
+		plat->family = 0x200;
 	/* first examine the property in current cpu node */
 	ret = dev_read_u32(dev, "timebase-frequency", &plat->timebase_freq);
 	/* if not found, then look at the parent /cpus node */
-- 
2.43.0

