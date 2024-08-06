Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1123C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA71C88AC4;
	Tue,  6 Aug 2024 14:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gehZh+hZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CAF88AC0; Tue,  6 Aug 2024 14:59:47 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D15688A8C
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-81f9339e541so20939239f.3
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949179; x=1723553979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J36lRpqplU8SqHlXlwuSQu6Jy6TqAsfo/XbhlY7gdm8=;
 b=gehZh+hZlC5l+MjTsfYPMdva7esathPVyIGT0vx7QvtCjrX5vFqKjN4x3RARNDC5rl
 QGWOPIJWr6I2kE1E42MeQtH9Z0hWBLQwX7UFqOnaqMCUm34dcMpjH3S4J/3yC4Bz0D1M
 QCb/1PoRuVlO+L1XfLYbUASCjqCDtP/Xs8xJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949179; x=1723553979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J36lRpqplU8SqHlXlwuSQu6Jy6TqAsfo/XbhlY7gdm8=;
 b=ZiourzTiDv8hnFMOW1PrqCYTM+JhshsNVQYtLG3EzGZ9ps5K11y2uFlTfTz7MahCoo
 Y3wssjqw9VPwlGF88epezg0UxB5DVgGQXpMBN/KgXbwBA73WwZhciQv+yp56f8DNdJiy
 fvYSFoHhNuf5Ir3KMXNZLD4xYo6EKZj6q4MnQCefASZZRqkbb7PrribeoC9nOW+iLM9P
 1y9tIBJp1mSvPPNBap71M3YUaPLCzRjT7Jh4jbdQSdVG+Gq57myxfKlZ8YfoV3HN9Qt/
 Go6lA8vQasgWMBADiaMk8HBcT7BzHtUMuMr7CtL96B5CJOyAxADKIUAr9mx8cYVhrRsY
 Ocaw==
X-Gm-Message-State: AOJu0YwlKSFwyIEsI9FkWygUOInNuiJog+Ds5kvLl2N6uCq9AS9INVox
 9hm4bu6WqYquA9E/mr28XV8gri/VdKKZ5WrXNMe2Ws8FjFH7hmgV+J81k3XIez4My3p1C1vJTJU
 =
X-Google-Smtp-Source: AGHT+IE28ALlWd8rfOh5Wf9cTlwOGohcKFuviA4TM6BOFe7UeFRtmLZlgPmBMIobw1YQdKQwpOXw6Q==
X-Received: by 2002:a92:6e01:0:b0:374:aa60:a5c3 with SMTP id
 e9e14a558f8ab-39b1fc3b201mr148951555ab.28.1722949178710; 
 Tue, 06 Aug 2024 05:59:38 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v2 23/39] test: mbr: Use RAM for the buffers
Date: Tue,  6 Aug 2024 06:58:34 -0600
Message-Id: <20240806125850.2316956-24-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

The normal approach with sandbox is to use a fixed memory address in the
RAM, to avoid needing to create a map for transient local variables.

Update this test to use this approach.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index bab92c3ba00..81ca6f15b2a 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -231,9 +231,11 @@ static unsigned build_mbr_parts(char *buf, size_t buf_size, unsigned num_parts)
 static int mbr_test_run(struct unit_test_state *uts)
 {
 	struct blk_desc *mmc_dev_desc;
-	unsigned char mbr_wbuf[BLKSZ], ebr_wbuf[BLKSZ], rbuf[BLKSZ];
+	unsigned char *mbr_wbuf, *ebr_wbuf, *rbuf;
 	char mbr_parts_buf[256];
-	ulong mbr_wa, ebr_wa, ra, ebr_blk, mbr_parts_max;
+	ulong addr = 0x1000;  /* start address for buffers */
+	ulong mbr_wa = addr, ebr_wa = addr + BLKSZ, ra = addr + BLKSZ * 2;
+	ulong ebr_blk, mbr_parts_max;
 	struct udevice *dev;
 	ofnode root, node;
 
@@ -257,9 +259,9 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertf(sizeof(mbr_parts_buf) >= mbr_parts_max, "Buffer avail: %ld; buffer req: %ld\n",
 		sizeof(mbr_parts_buf), mbr_parts_max);
 
-	mbr_wa = map_to_sysmem(mbr_wbuf);
-	ebr_wa = map_to_sysmem(ebr_wbuf);
-	ra = map_to_sysmem(rbuf);
+	mbr_wbuf = map_sysmem(mbr_wa, BLKSZ);
+	ebr_wbuf = map_sysmem(ebr_wa, BLKSZ);
+	rbuf = map_sysmem(ra, BLKSZ);
 	ebr_blk = (ulong)0xb00000 / BLKSZ;
 
 	/* Make sure mmc6 exists */
-- 
2.34.1

