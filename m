Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BECE88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:05:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA1C8416F;
	Sat,  4 Apr 2026 16:04:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h0M0SZGw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBD184199; Sat,  4 Apr 2026 16:04:20 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D454283B8F
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-42306f82341so1217285fac.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311457; x=1775916257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6QRmtDfl1DlpkNDVWBCNtwtrRo05c+noizQvruuXLs=;
 b=h0M0SZGwgU545kH94mj7g2xmCfkifydWRKeENm6tfe0VWHaslHhj1ry01OUSonw/mr
 mD3JlmZSf3EQ+8Iraw/I1T1sIIaVBRMdCaGb9uiNK9Pnzc19EUxf0wfBy4nDkJQh0Ogc
 PIQzU1pxATfRd4csyLmqqONq2fe7jfr7xxYq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311457; x=1775916257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k6QRmtDfl1DlpkNDVWBCNtwtrRo05c+noizQvruuXLs=;
 b=V3NVElEX011eqPVGb95MpmP8awOQKfrZEw5EUERvdzUSA6UsR/ImFU0hi9HR2mylvi
 cLVqid5nc2eNL3w9jgg1+gtYoqgZ7GuwOAKFnUkPJXSa84OUopBefc46cydvd5s7MpAq
 E2cy0nXKb6dJVpkpdUbLVHTTRWthtpMMz2wRhpKIVgNMmgdc7gUVUrc4o7kM2H2jdqAH
 8co4ThYmbo72Ugnfb1U8/3LX2xZpiSHX/VpjwsfFXJtbLJ0h+LsKpJ7Y3UKmT/6wZ9N0
 dDXzTsQDssUfDGdSgHmg9DhyYx4KYTFCrQK2AEKncLe1edl96BQC8bzJtuYXMv14YUc/
 O5wQ==
X-Gm-Message-State: AOJu0YxvqeaeZ3tCz5LMnKtnszIU/cChlymTRLKnB5s1nPQ5+Qv02pPI
 afVR5N0Vhqg6Zb8I+u6xvyFeiy9slqiT3IK4PuOiPuazVrT29k6yL8P21BHRm/Imp7+T+C7jxAY
 tHVA=
X-Gm-Gg: AeBDiet/fbBAN/UevWTJIdPPRmvoq7hLGl90L8OA2OldjwpF3brCL7Fwjih7hQ51T1D
 6g0cJDbR0F0U0XQrF4w+DMvzbYQWdCTu7ByUgLRe7p+/q8AKO5au1/7sUvBZurieFX4sWtAxbGV
 VrxkLMk80Z+D45v14l9fAY69x0fW/T5v+PZA9m0X14xjBcds1qSr+QmJyfEbg28F9ZtG//1dtJn
 G5A3W/xv1q4BqAVo2OXrJPWWPSSiVGwCBRyBR5q9pojHOGp3ouqoh5NytXB4g+oVH5u1Nx6oip1
 QMxitJffRUYhK/uWc4vDauHZ37vYdhYw9VWMekktBUBuwaih2yG0sQeQQ53GyhmeI509R1UBvR8
 EGkrCizvqmmw9DdeM9hnWVHWYbG7Mu8h5a5QfrxAZFfYsJQfz1RMJ+LV+yH+h4bnTM/voTahbMe
 As5YE0btaMnS6ZebvtyA==
X-Received: by 2002:a05:6871:5b19:b0:41c:46c7:2e78 with SMTP id
 586e51a60fabf-4230ff86db8mr3530606fac.23.1775311456849; 
 Sat, 04 Apr 2026 07:04:16 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/14] test: Convert test_ut_dm_init() to use FsHelper
Date: Sat,  4 Apr 2026 08:03:15 -0600
Message-ID: <20260404140328.3724864-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

Use the helper here, for consistency.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index ad84fb56b85..9b7f1c6f3fc 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -542,8 +542,8 @@ def test_ut_dm_init(ubman):
         utils.run_and_log(
             ubman, f'sfdisk {fn}', stdin=b'type=83')
 
-    fs_helper.mk_fs(ubman.config, 'ext2', 0x200000, '2MB', None)
-    fs_helper.mk_fs(ubman.config, 'fat32', 0x100000, '1MB', None)
+    FsHelper(ubman.config, 'ext2', 2, '2MB').mk_fs()
+    FsHelper(ubman.config, 'fat32', 1, '1MB').mk_fs()
 
     mmc_dev = 6
     fn = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
-- 
2.43.0

