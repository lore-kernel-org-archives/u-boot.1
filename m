Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFF7D0E6CD
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 12:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 429CF8402F;
	Tue, 25 Nov 2025 13:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LPRkvyab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC7E883FDC; Tue, 25 Nov 2025 11:25:10 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA7383FD6
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 11:25:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-37b657f6e24so4045671fa.0
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 02:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066306; x=1764671106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WT7Y5GkAAHAQhmyFdZGVgGjF3JIt5HpbVARTsD7B3eA=;
 b=LPRkvyabHcB00mrJkvACQ7/yDMFwjA+loGgCx9uyVktNFC09UwnOFhG/8ZpoisY2TC
 pCV74BXf8h8vyvVN0eAIC692FBoBzILsInxMA8C+IwL8jiLmstfgeyv2UvR4IK8L/FiD
 4K4AbYj/1yQGBq9G8brq82dDcvdpJfdMSXbIgpB9Opvrm/8KTq2q0zBw7Ed6Y0849h/u
 45DLhmJPSUZ5WrW2QU+90ObtJgp9VxGci/XR8EenWhUCd+5aCZ5QGJ3y/v8+OiU+puh+
 rPQoWVyroQ4C8lc6IajkGdzWEjZLre3Ha3GLcfCGrPaDyhJ2kxeVPf6gcVTqs5eGRD7H
 mpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066306; x=1764671106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WT7Y5GkAAHAQhmyFdZGVgGjF3JIt5HpbVARTsD7B3eA=;
 b=Fkg5IUUI4iIkY6EfZOS404yPWOv2rqMvO0g4qc2vT+gT2WAEzgTdsdpaF+Y0p/1/Ld
 CXcQ62szr9088e86LsD38/CoSuk4B+K/ycXB8eS+H8WXNBySFSbVmXT4opgqXHKmaHos
 v+/YGijliwJsAMPxeaMpj+LMvlhz0TSvtbve0lXbAHOB0i0q3JnNiAAOFjo3m9owJdvW
 GWgDAxIcH/Uts5bhWlHsvKiHQkwxH7Mt9gwsvCBvEKklLgTXxfoRmGbVechrWBqMYNHm
 GldIVrGNk6qhAJKqoskhM+zyYABXftWrjI0Qd8Y86X/20wIqEjnQkrYFkiLbv+k6Ul4+
 5t1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLdrQuXIZdTlEO0neyUDitYmoOzvnZIVSGdtnXQqbBtQL/+/PpJk4dscmOQuCo8ZvDIy+PHxE=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9hwDZlk6jKlIFE2csLwuLZPYRx+85px7bOU3Je3ab2oSZ8dxW
 2Dka3TMj2r/fxcak0/aavZu5PQvwvSAlZ3js1UcFS2Tmksw5fE3mf02h5Uabi4UoiWQ=
X-Gm-Gg: ASbGncuOVhjM9gRozkc3lySXw/0LPUvBFkwKbcgvzaMcI+9LeoYBDwtWJU86r1lltun
 J7BgbuXa2OfFk9n/EVP9rm6zPD21nZD84UPifw/BMKTuJdYzQ/MB4J9hW14CEjzZT71SA1EAFnb
 2klaREGsUAWdWE7hqjqp/UG6En5t46CTmcmSbRMASk1aWigygmx0od8Zq0fNmTvbLbCuKbFuq3x
 fAxqzKdEUw6jwIfIv5p3ZlyWPmeRG8E9QoiG37TJmqalp92ay4Y6Pdl7cLHlgkecdn+0Ig6keH3
 r9UCtQLC/mQ4JUlcToVv+PpJSKNSO9nPVfmQOo4UeFj3brLbzLwz73kaBoS6vsUfxQnqDZET0ua
 AC/PPBLGw/tCDgvF4MbQjzVyuzqqMqhO4mVeQCSA3n+ohqJiTKAc4qK1Y1GQS1d3iSo/INNGdW6
 tXuLW/nkDddqG4aYUoWYH8eGD2iajKDZtNImIL3S9oIOBn5iNk5CXSe+VPUA==
X-Google-Smtp-Source: AGHT+IEUmbk/VW14EKDS5HjizIP0WKEoEq/6E8TJ04VLwD8/UFH2Nt7oXgPnyhUtQeIxuigNseU1lA==
X-Received: by 2002:a05:651c:3053:b0:37a:9558:5bdd with SMTP id
 38308e7fff4ca-37cdc367f8fmr18132181fa.3.1764066306071; 
 Tue, 25 Nov 2025 02:25:06 -0800 (PST)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with UTF8SMTPSA id
 38308e7fff4ca-37cc6b639f2sm32620271fa.20.2025.11.25.02.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 02:25:04 -0800 (PST)
From: Anders Roxell <anders.roxell@linaro.org>
To: mbrugger@suse.com,
	pbrobinson@gmail.com,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, u-boot@lists.denx.de,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [RFC][PATCH] rpi: Fix DRAM size reporting to show total RAM
Date: Tue, 25 Nov 2025 11:23:58 +0100
Message-ID: <20251125102358.1850991-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Nov 2025 13:40:19 +0100
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

The VideoCore mailbox GET_ARM_MEMORY only reports the size of the
first accessible memory region (~947 MiB on RPi4 with 8GB), not the
total RAM. This causes U-Boot to display "DRAM: 947 MiB (total 7.9 GiB)"
instead of "DRAM: 7.9 GiB".

On Raspberry Pi 4 with 8GB RAM, the memory is split across multiple
non-contiguous banks. The dram_init() function only sets gd->ram_size
to the first bank size reported by the VideoCore firmware, while
fdtdec_setup_memory_banksize() correctly populates all memory banks
from the device tree.

Fix this by updating gd->ram_size after dram_init_banksize() has
populated all memory banks, so it reflects the actual total RAM
across all banks.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 board/raspberrypi/rpi/rpi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index 1b0b664fa2b7..0cd45104b3bc 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -332,13 +332,27 @@ int dram_init(void)
 #ifdef CONFIG_OF_BOARD
 int dram_init_banksize(void)
 {
+	phys_addr_t total_size = 0;
+	int i;
 	int ret;
 
 	ret = fdtdec_setup_memory_banksize();
 	if (ret)
 		return ret;
 
-	return fdtdec_setup_mem_size_base();
+	ret = fdtdec_setup_mem_size_base();
+	if (ret)
+		return ret;
+
+	/* Update gd->ram_size to reflect total RAM across all banks */
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (gd->bd->bi_dram[i].size == 0)
+			break;
+		total_size += gd->bd->bi_dram[i].size;
+	}
+	gd->ram_size = total_size;
+
+	return 0;
 }
 #endif
 
-- 
2.51.0

