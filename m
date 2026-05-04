Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E62CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 18:58:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 405C884699;
	Mon,  4 May 2026 20:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="shNabmi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93262846AE; Mon,  4 May 2026 20:57:45 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B31918467A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 20:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-44a786a9a35so2146675f8f.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 11:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777921062; x=1778525862; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MhYkUv8XFanjN70ziCVl5VytmwDIHaoajuLZtjkrgE4=;
 b=shNabmi9JLVNfcK2/aZw5wn9wCndqRbgGyLFjDDxmkKN2H1fIIWnkoYKEUKPpzt0wS
 KO4k6bDfJMuqRcv354/j3LgFzm1/aGBgrsWBqnpdLDz4buVzpyksEOxGEmTCUmvd/UYn
 e8JQGGb/jsht5iT74L+wcAyMfUIYX9uTbAdvSmpdEB7ZWxCvUZcbgp6l7Vn/hiVampxQ
 f+bzyh0W44Ag3K+AA7eYgpCMRwVnNf33c5QCt0f2lz9+vNcuwdLw+r5JZxd4ms0vNSvM
 uU5GCxXJm9lXszQeh/cej+gtO0ylBejnUWQ399I7jL4eJdgNAfqoY7T8mObfX8svnESh
 yDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921062; x=1778525862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MhYkUv8XFanjN70ziCVl5VytmwDIHaoajuLZtjkrgE4=;
 b=A8nHJy2b68x6oYdgcr31MhA9oV94cOvY0wKVzZPrIGCoWCYErI+/oNROQo5zZM1Foy
 1jHQe/1WpXlP9j+h5nGW05M6x4l/ep73K3I2ACrPLPAqmqkwi/4pr0oFnUNNMIGxSQbO
 TiQFdAdOotbg/+R7FJrCTkQtm/GYIU7GNg45j7FBRX+RzD8P8PA34XXBSjqzDH1JGZLy
 BVlusgrZdp9jxcvaIWDeHXr1JTNhLu7jChG42nOb6IeJ/66n4k78en5lER+e+dWOgu1F
 xppOxLoFd4SBx5bJUrt4qEMot+ajhX4Q8exozeYi9TaNlxHe6Bd9vFp8gseuCEu2qCwx
 ig9A==
X-Gm-Message-State: AOJu0YwQS5gJnT0/+sG60+hXR5Xv77neToDAJifa3HUvaw++mfjD2gPL
 OcPUrdHg8d9fVbWs3TO/OuzFTyYw1FwuILNXcahbETlu5riQX7zkD7F9ubYIwx0/aQM=
X-Gm-Gg: AeBDies+qw0LUUo48WXL5WlLHFSr/c2h2L1d+0CfUvplSYOmfRp7t+vf2PgF7Z6jOq9
 p5xBH94IMEQqr7qqZbQ2zIkBZnT1ss52ugFKKr/y9NNH+Ct1L7XsAW5pgUVnjp0KO2XZ6Zoae7t
 Ar3KDWkv4JTx0bbCCwwA4G8ULZMb6pZcYve94UUbvjDW7QyN+GVl9u3uqpM3w07+i+1qq8kURLn
 vR1ymVggp7gWSkDTncZTRTRMNPiwV5R3D2ZEAKYNdrtZSW1EJx4S9xoZbLZlx/mY1lmpD2k6nD4
 V0DllOZFpXLY7o9CRd+QIFqnI7eDsa6t/j2+auqRDkq9HoN2MhwNl74ttUDcwurV16BSqk+ff5B
 aufoBwxNxTtFL3KtJRRXeyZDcYL8ALa27ghMQIxlzCUZpY1aQCq3qmMq4/xsBcGB5PtyAJTfc/V
 3GMKhppHoYyqN9erw/c3m+vpeHtBNV7lBtTETFRXbLsibbovxvCi3kT0wFB4aj+A0Yufp0OxWxL
 s6GxLw=
X-Received: by 2002:a05:6000:2c03:b0:449:c5e2:a8ad with SMTP id
 ffacd0b85a97d-44bb34e71d8mr19234725f8f.11.1777921062160; 
 Mon, 04 May 2026 11:57:42 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4500f9c2cd5sm2861f8f.23.2026.05.04.11.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 11:57:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 04 May 2026 20:57:31 +0200
Subject: [PATCH v2 03/15] Revert "test: smem: add basic smem test"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-b4-modernise-smem-v2-3-c01ec2ff3886@linaro.org>
References: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
In-Reply-To: <20260504-b4-modernise-smem-v2-0-c01ec2ff3886@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Marek Vasut <marek.vasut@mailbox.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Heiko Schocher <hs@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=Fltkas1dj+hVr2l6oHHUiFzOY6Dau/BeoxzKXmqdxo4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhswfb+RCJW/brJj2yPM+Q0aVWvSuq3LrOyu2/3WyT1lgm
 aCh4HWoo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzEfSsjwzaebYobcjpDPbcY
 8s1oWW28X90j4vCN/doLf2XvPHd66S6Gv7Ixi09YnW/Z97ey9s/y5S85W096Blmv/dwRcrf37tW
 ErOkA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This reverts commit 20e7705764c4e5ea924f1ea54bb36ebbbeffffe7.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 test/dm/Makefile |  1 -
 test/dm/smem.c   | 26 --------------------------
 2 files changed, 27 deletions(-)

diff --git a/test/dm/Makefile b/test/dm/Makefile
index 771b703b737d..ace149d4a2b4 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -111,9 +111,8 @@ obj-$(CONFIG_SCSI) += scsi.o
 obj-$(CONFIG_DM_SERIAL) += serial.o
 obj-$(CONFIG_DM_SPI_FLASH) += sf.o
 obj-$(CONFIG_SIMPLE_BUS) += simple-bus.o
 obj-$(CONFIG_SIMPLE_PM_BUS) += simple-pm-bus.o
-obj-$(CONFIG_SMEM) += smem.o
 obj-$(CONFIG_SOC_DEVICE) += soc.o
 obj-$(CONFIG_SOUND) += sound.o
 obj-$(CONFIG_DM_SPI) += spi.o
 obj-$(CONFIG_SPMI) += spmi.o
diff --git a/test/dm/smem.c b/test/dm/smem.c
deleted file mode 100644
index 89e74cccc574..000000000000
--- a/test/dm/smem.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#include <dm.h>
-#include <smem.h>
-#include <dm/test.h>
-#include <test/test.h>
-#include <test/ut.h>
-
-/* Basic test of the smem uclass */
-static int dm_test_smem_base(struct unit_test_state *uts)
-{
-	struct udevice *dev;
-	size_t size;
-
-	ut_assertok(uclass_get_device(UCLASS_SMEM, 0, &dev));
-	ut_assertnonnull(dev);
-	ut_assertok(smem_alloc(dev, -1, 0, 16));
-	ut_asserteq(0, smem_get_free_space(dev, -1));
-	ut_assertnull(smem_get(dev, -1, 0, &size));
-
-	return 0;
-}
-DM_TEST(dm_test_smem_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.53.0

