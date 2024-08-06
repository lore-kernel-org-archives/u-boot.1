Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA28CC52D70
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9653988A93;
	Tue,  6 Aug 2024 14:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xpn1OJ+6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72A9888A64; Tue,  6 Aug 2024 14:59:40 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E7B088A61
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-397052a7b63so1845425ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949168; x=1723553968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qrSVzAkp7naUgUE3XYQzs/Z2IurA4XQDWXjDC7baz94=;
 b=Xpn1OJ+69Yo/oj701dhVjU48cLQIOZFGzP3RY4t9F2hJwiRojWgz25APzi0RhAQWnU
 lVJQe/n+YmMpZDgGT3BlGalbuR6sShJpQ5bHXK8nVWC8mIqTQrHhDkPPkUtOTj7afkcO
 Hc4YVfvC7nb0FuVv7CPg+hNu5bLIHZfu4f7aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949168; x=1723553968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qrSVzAkp7naUgUE3XYQzs/Z2IurA4XQDWXjDC7baz94=;
 b=GI75oDYGSGzF1kvYgJyT5HHcuNdsAGeVGG1UcsLE+QCrG1/HYo3WP6b3+1eK9lWI09
 +BFQGGZc2tzRNcSrGLz05AspwMlYYXBYJBwJr5W28susS0h2zt2oYwTXuRljZkmDmfuS
 34Da8hAfqDMutfwb15CEIxozEfNND+Z632uSC+IhvKuDRJDaD3aPlLJYbnQACO9K2SSh
 9m8vD2iOEnnZlcPXZh8ord/gRmTPIFxxlMNBd+YqAslA6rZItqZVsC3i3InEj2w/hQ1e
 TPFXpHNwC9HmhsXGRtSF5AVFUR5mfiniIzGN22iUb+TXgcLwA6fzhThhfmlXUyu0K8yc
 1fBA==
X-Gm-Message-State: AOJu0YzEYHjhnz3wauVEhXVbenkt1KJ39QzzrTirXAGO6h8QnLVgxIUT
 xl4WV1cr+YlkVLOkQMMFIF6hBNiaTyXK/bBAz+af74y1FHT8D+NUB9e3RC1yOdbKOdbBdE8LaIM
 =
X-Google-Smtp-Source: AGHT+IHSxZChpeu0LzuclP02LM9Zutv7Hin9UuizKzzqaJRbjPjgIRbxq4MiAN6thL/LQ0oFEPldSQ==
X-Received: by 2002:a92:c043:0:b0:398:3f0e:8bd7 with SMTP id
 e9e14a558f8ab-39b1fb8b996mr155215685ab.9.1722949168398; 
 Tue, 06 Aug 2024 05:59:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v2 11/39] test: mbr: Adjust test to use lower-case hex
Date: Tue,  6 Aug 2024 06:58:22 -0600
Message-Id: <20240806125850.2316956-12-sjg@chromium.org>
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

Switch to lower-case hex which is more commonly used in U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 235b363290e..4c884af10c7 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -50,7 +50,7 @@ static char * mbr_parts_tail = "'";
 000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 */
-static unsigned mbr_cmp_start = 0x1B8;
+static unsigned int mbr_cmp_start = 0x1b8;
 static unsigned mbr_cmp_size = 0x48;
 static unsigned char mbr_parts_ref_p1[] = {
                                                 0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
@@ -257,7 +257,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	mbr_wa = map_to_sysmem(mbr_wbuf);
 	ebr_wa = map_to_sysmem(ebr_wbuf);
 	ra = map_to_sysmem(rbuf);
-	ebr_blk = (ulong)0xB00000 / 0x200;
+	ebr_blk = (ulong)0xb00000 / 0x200;
 
 	/* Make sure mmc6 exists */
 	ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
@@ -268,7 +268,8 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assertok(ut_check_console_end(uts));
 
 	/* Make sure mmc6 is 12+ MiB in size */
-	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra, (ulong)0xBFFE00 / 0x200));
+	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra,
+				 (ulong)0xbffe00 / 0x200));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
-- 
2.34.1

