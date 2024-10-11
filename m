Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBD6CFD31D
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:40:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FC1A8938C;
	Fri, 11 Oct 2024 12:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="atvryHk9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8774889384; Fri, 11 Oct 2024 12:35:37 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80DBF89396
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a99543ab209so265625666b.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1728642935; x=1729247735; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyYINupvISodKxhBKiNQ0fA3TEq25G64HyoT9bMD81k=;
 b=atvryHk9Ewshh3Izzq3p+tlLqLMf6m8TstyIvd4ekdXa78WL7gjan606Wxt6z9pAxX
 gjX37PQ4NcAtvw/uYttNeP2JNybZyy3H6W6jQg6fE3ZwkSWhEQEC4ASg7NU79P2prHMY
 qLUjx44ITIh2MQ0vTB7wDdCzKSt9NRlN01qhhyZn5LSMmUVKa6Lv80p3v/mJVgrgAL/l
 w+eoRol/4lb4GKupupG4BWs7/W4YCiwcTUwvbkg1EyuG7pAuWEUn2xUSjDotnsUpGMe9
 78N68EBDQdCRowhONCpqNEIiClI850fvGdJ01/bCLtOdnJj4ttMS+dFMrDBamhMOYvxs
 niPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642935; x=1729247735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyYINupvISodKxhBKiNQ0fA3TEq25G64HyoT9bMD81k=;
 b=BzExhi9S6ssrnwKUrQVf02tmbJ2/U1fLAXiyE7pWChpMHQSmz8yxfb2kDZ9shQJBWu
 x8yXAZ85ZwYTy5AwxJHnfkMfP8dfmgM1IhClQh6sZTRbIWdx/dsXKbWEmPvheWLvp58u
 CxI2l2p+7Aw+Wc2yLpeLcZoXi7C1kFnUgsLERfTyG+v2vkIGs85QzePTFW4vL63uwaah
 SjPktMjhmzx2CKMCBcWLtwCY2tfo7bjRcV8Hba1VDh6gbFmRvepiGdlohAKhN+X1B+Pd
 OpVRsn1AY9kcVMdGW4HeZjL5zvCIYDFPOnQkF6cmifOFKBNByvf3MQJklFw3bJUvWjxJ
 vQog==
X-Gm-Message-State: AOJu0YxUfs7IGRGZ3pu025riZnxhuuhjXbhsJt4eRyoxs/2mCa1PJmwM
 Nt7z7dFFKfM3Nh2H4lRLJVhizd3KxT4jVo4k0viEdJYKj5TPhBq9OCgHJ8Bu3AY9V29w1CY92JY
 NAqI=
X-Google-Smtp-Source: AGHT+IF0NmdAsXZ1TcLDGj7TBwU2H/EVQ+hh8DMdgnHukeMowMBSCQ0p0qqhFgfappZ8gJf41bw+fg==
X-Received: by 2002:a17:907:d3e6:b0:a93:c2b0:f965 with SMTP id
 a640c23a62f3a-a99b9583ac7mr171992366b.41.1728642934962; 
 Fri, 11 Oct 2024 03:35:34 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 03:35:34 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 36/37] configs: Add RPI4 ACPI defconfig
Date: Fri, 11 Oct 2024 12:23:17 +0200
Message-ID: <20241011102419.12523-37-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
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

Allows to build the RPi4 with ACPI enabled.

TEST: - Boots on qemu-system-aarch64 -machine raspi4b
      - Boots on real hardware with arm_64bit=1 in config.txt

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
Changelog v4:
- Enable BLOBLISTS
Changelog v5:
- Enable OF_BOARD
Changelog v5:
- Use include

---
 configs/rpi_4_acpi_defconfig | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 configs/rpi_4_acpi_defconfig

diff --git a/configs/rpi_4_acpi_defconfig b/configs/rpi_4_acpi_defconfig
new file mode 100644
index 0000000000..b32dfc16a1
--- /dev/null
+++ b/configs/rpi_4_acpi_defconfig
@@ -0,0 +1,10 @@
+#include <configs/rpi_4_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_BCM283X=y
+CONFIG_TARGET_RPI_4=y
+CONFIG_BLOBLIST_ALLOC=y
+CONFIG_OF_BOARD=y
+CONFIG_ACPI=y
+CONFIG_GENERATE_ACPI_TABLE=y
+
-- 
2.46.2

