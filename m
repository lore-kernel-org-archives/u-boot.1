Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82429C5321E
	for <u-boot@archiver.kernel.org>; Sun, 25 Aug 2024 12:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C4868877E;
	Sun, 25 Aug 2024 14:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iYqWe4tL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72455889B3; Sun, 25 Aug 2024 14:26:31 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B9CA8852A
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 14:26:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f4f2868783so28403631fa.2
 for <u-boot@lists.denx.de>; Sun, 25 Aug 2024 05:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724588788; x=1725193588;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iMK0oinWbrB6qtCxO2LJDruapOwMRD+CxR6o8GzfA/E=;
 b=iYqWe4tLZsqQt1Cv58mzMlmVamvBvOTAND0hRpsWoIM3c3JXol8uTMa2IvVZOvSFh8
 uyqzKrvyn3pQtbcGAL48pMcs40CaZ0EcMm/CQr0tbKcF95GrcI9Ltomte2A98HSiOs0b
 ZQuZoUfyKbVNvFuMzPQ6Ner8hNVFC538flObc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724588788; x=1725193588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iMK0oinWbrB6qtCxO2LJDruapOwMRD+CxR6o8GzfA/E=;
 b=r7CL+0RdSEA85DA6Daaw/qDnFWcAtv4C85Sj47Oxq62FOiorFm/A00e+vfxhR57jKY
 ojp7ECQFB3ZeDedklKXynHsKSg8obN+I/SQgb7RrbA/CpvrHssthk0CZMPxUJXa4AMeQ
 IKiMfPfdwndCP7AJ788wRm8HrWHSzNBiNku4yNvwzfKasTr2JgimhQ3s7yM9INivf9M2
 bTTKTk3hH148F+o63p7OnYoR2U1K52ssUbLm8WPFz3MaJVFj1/gLIwPDEw5jGbB6+Bwh
 H8XumGdLbTfkhDGXBaZlF0kA5pkBi4BdRB2hjkiOimv0pjx2VlRWexdcAs59OqtVnQoR
 IKZw==
X-Gm-Message-State: AOJu0YxvlGwfwPgziPSVDYqPBsaEfTNva8UVWsBO1do5ec3z9cqkhDhl
 YfAEMzOcqy5QI5/O6Jyl/z4cjXYqWtvBqLeI9Yso+XVm06ItWPjg2p1PbyXKOkaJycmAYZbnTCr
 CabE=
X-Google-Smtp-Source: AGHT+IF9O+eQTTQHoQdoLBeHT2xJXWAhOqASfYQpMWwugIoFbCh9DjGv4JPyoLoAeBiZZ2iy327XTQ==
X-Received: by 2002:a2e:6102:0:b0:2ef:2e1c:79b5 with SMTP id
 38308e7fff4ca-2f4f4902e6bmr44780371fa.14.1724588788012; 
 Sun, 25 Aug 2024 05:26:28 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-79-25-99-149.retail.telecomitalia.it. [79.25.99.149])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c04a4c4377sm4651563a12.74.2024.08.25.05.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 05:26:27 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] bootm: adjust the print format
Date: Sun, 25 Aug 2024 14:26:07 +0200
Message-ID: <20240825122617.3708982-1-dario.binacchi@amarulasolutions.com>
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

All three addresses printed are in hexadecimal format, but only the
first two have the "0x" prefix. The patch aligns the format of the
"end" address with the other two by adding the "0x" prefix.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 boot/bootm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 480f8e6a0e6e..951e549f19ff 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -703,7 +703,7 @@ static int bootm_load_os(struct bootm_headers *images, int boot_progress)
 
 		/* Handle BOOTM_STATE_LOADOS */
 		if (relocated_addr != load) {
-			printf("Moving Image from 0x%lx to 0x%lx, end=%lx\n",
+			printf("Moving Image from 0x%lx to 0x%lx, end=0x%lx\n",
 			       load, relocated_addr,
 			       relocated_addr + image_size);
 			memmove((void *)relocated_addr, load_buf, image_size);
-- 
2.43.0

