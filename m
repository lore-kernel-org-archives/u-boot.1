Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833BFC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD28874E0;
	Thu, 28 Dec 2023 08:30:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="O81Hv0lD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D16D87988; Thu, 28 Dec 2023 08:30:32 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81233874DD
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 63A353F18B
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703748628;
 bh=GlFzyRd2x+OqXCgzCj0qPZPf8QuU4I6dLKs8VaX+sQ8=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=O81Hv0lDqlQLpq4pqUsDKTFpHiMBfoPVdtJd1+Le+r8SZvhhxFCeo9B7e0E91yoc7
 /q0U+d6QZM58Q1dIPhRoX0CkJdVA6Xe9xKVv9MpghXidk6hWwHYH4yQh2drF7Mdevk
 NJo0dT05TvwhwER2Hn/weBvRSzipt0wrFJx9LjfHnT59tE4G0sQNdI/ceGi2EteoL+
 6cBRF0MPWYdZSGLdRiCDiHyzC1mLmfIjiU7JTNDZ7UkhjmdokNdbGsh/NFJxm7Gqjz
 w/LQ5GL9Yj5xiVLeWr878RvWDPTXYvVvJfIKOsvG3oOrrAskOS061sCl271VDoyk/i
 qVa7XzGRbxdyg==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d5aef0b1fso15873215e9.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703748628; x=1704353428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GlFzyRd2x+OqXCgzCj0qPZPf8QuU4I6dLKs8VaX+sQ8=;
 b=eTto7m4yFh5/TXdedicsoYlYUD4b84veyQs+WPio50EhmOtEFj2LQkU135sxW4TIsX
 xAlBmFSB4KxOqB0/cfQbHdPWWkpgcqid/6c7+YKsneZDRnCMP4Xhc/Ekp6J0N75AQatj
 VW+hXED+ocTZHD8imFzB8sq4wAgO/1UozwRCtuBPlD9+PIdLCRAXzUBl/VHLJ8ZHngdp
 XzV1Q7DHHYZ760taLNmdPy95XOGrmu4t8/Ot3+bJ66wLdifXlU5p8/YUlUQ4j2agYB5y
 VOJqf0hNBbZphGt7wAEwoeaEePDB8Q+rdI/4q3i9IzXNG4zwoWaSxVhzKyIotfqUOQHn
 Tu8g==
X-Gm-Message-State: AOJu0Yxw56Bamq3boSomxIrzDfiwyy4NbjgLe6FKuNtvmanBKzkr7bWH
 XvcqQENA9/Z4yi1IaLXo1X8cBs7CXs97jVkkmlI+zaWSMh9OkrjEb9Mvln2KdoT0P4g4iT2tyv7
 rlDzRHrRjqlgkD0VRha9hq1eKhiqTFBev0++ZYA==
X-Received: by 2002:a05:600c:34ce:b0:40d:59bc:5794 with SMTP id
 d14-20020a05600c34ce00b0040d59bc5794mr1984286wmq.74.1703748627909; 
 Wed, 27 Dec 2023 23:30:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6SUvJfJHTS1HLVthnLlEi/pJF3Wc21eFYkVmLYRoza/NbCrEfO/oCCB69cWcNzpQvIMm6Eg==
X-Received: by 2002:a05:600c:34ce:b0:40d:59bc:5794 with SMTP id
 d14-20020a05600c34ce00b0040d59bc5794mr1984280wmq.74.1703748627592; 
 Wed, 27 Dec 2023 23:30:27 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b0040d6b91efd9sm967191wmb.44.2023.12.27.23.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Dec 2023 23:30:27 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] smbios: riscv: set correct SMBIOS processor family value
Date: Thu, 28 Dec 2023 08:30:22 +0100
Message-ID: <20231228073024.6508-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
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

Many value of processor type exceed 0xff and have to be stored as u16
value. In the type 4 table set processor_family = 0xfe signaling that
field processor_family2 is used and write the actual value into the
processor_family2 field.

The values for RISC-V are:

* 0x200 for 32-bit
* 0x201 for 64-bit

With this series dmidecode shows

    Handle 0x0004, DMI type 4, 48 bytes
    Processor Information
	Socket Designation: Not Specified
	Type: Central Processor
	Family: RV64

for qemu-riscv64_smode_defconfig.

Heinrich Schuchardt (2):
  smbios: enable setting processor family > 0xff
  cpu: riscv: set correct SMBIOS processor family value

 drivers/cpu/riscv_cpu.c | 4 ++++
 lib/smbios.c            | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0

