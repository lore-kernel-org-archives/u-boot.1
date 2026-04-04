Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A24FD7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A8F084105;
	Sat,  4 Apr 2026 16:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iN66ezA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33BB084101; Sat,  4 Apr 2026 16:03:59 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1982A83642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-423306870e7so379312fac.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311435; x=1775916235; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BwynA4H7hcpSYrrNYoruc1KOTxMhpsq75lMTwo2EpKA=;
 b=iN66ezA0hmhDll26zCQJsENd/7PE2WTB9t46phHBKdZB2cmV2unL+Qx9/gHR8olwSm
 PG+qcp2HUX8b6euDpHa03Z7kKh77q9dFPwhRO9p5rLfuvJfwiYEDoOVGZXDGakkklPBn
 FenC8x8/2yHQI25hQ782ZmjujDCf76AVterNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311435; x=1775916235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BwynA4H7hcpSYrrNYoruc1KOTxMhpsq75lMTwo2EpKA=;
 b=UsKR3KDBaNMIGltPIFj9+efOtLoOPBsxMbVkcr5+P1y+LMagB0mOpWCtQzyP9XVyk8
 RLvjlb9RRKoT4Jwm2h244Mtx+rjz/F6gWAEqgwSqY/akmZTglG7E/DWQlN88/MAGSm+3
 9ZcQHeq3n5CAZ8RzEo9icKDZWa6qszshN8lbLhtHKEIUG9o9FyIdJGrUSFSzG2m/78u1
 AEsSTF669RQ1K2yanYZmyVFKD1CKfLdmi8mby/8dQjsa7K3nceB/QQeA95iWk48DMb/Z
 cOOhK0NpFdNM/Sqyw9t6SYPz24SGVVtfxBKzo24TfCw71WL5g3hzJiRE4NynxA0iNH3W
 kcWg==
X-Gm-Message-State: AOJu0Yx0vOpGQjsN13+vZlhgzKItxt2kxktSiU0qvbX7+/TBSVllYj+V
 LwdPMYUIgnqIDR7hGrlj3PaWLsTioWlDCI0qEq6MuJ82MJjDmLFFg9ax3DQWv44+PcUT9GtANrZ
 yv0c=
X-Gm-Gg: AeBDiet5YUZV6rP1NalkVAz3rg0rW55Dzp+lxHq6zQHi2i3sDbHcLwB+dXUwYiZrUvD
 lz6negHzN1mWS0cL8qHWBnFIrkKTVzyqI20Ebogqr32f6SP3ZL+ezcqdHmFJ2qGTyDZMBATx0N8
 mXfUU+z5/v1FGlsjSHMbeuArl5pmKKJgyBF9lPMJi7Fao22ax098Hb0xh0ytKEw9Uv8/PoWoiYD
 xRWsNAKiscTA+PsErN9NjAAc4hisyrGAYpSZElHUwgpyJhojW9ctQfOaQvUecffBYJ9lWQPm+3c
 aj54zprouiJmSeuZ1A3lY6Elt/CpWQe8HFeASVVobpZD6i5GEbAaykZzTON4i7ghb2X3skXUgDf
 7dxuRYmqkEQoB/Jd4n2r/jqjGZ734LdWg8RP8zOky1SfKk2VoY2fM7KjTN7qZ0uJYDm4tXgpscD
 oit2Q+HcexAMvzav6TUw==
X-Received: by 2002:a05:6870:1402:b0:40e:e7d4:970a with SMTP id
 586e51a60fabf-42310131cf0mr3546588fac.31.1775311435142; 
 Sat, 04 Apr 2026 07:03:55 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:03:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/14] test: Fix broken fs_obj_fat fixture
Date: Sat,  4 Apr 2026 08:03:07 -0600
Message-ID: <20260404140328.3724864-4-sjg@chromium.org>
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

The removal of the size_gran parameter from mk_fs() leaves a stale
positional argument (1024) that is now interpreted as the fs_img
filename. Since 1024 is an integer, os.path.join() raises TypeError,
causing the fixture to silently skip via the bare except clause.

Drop the stale argument so the fixture works again.

Fixes: d030dc34d67a ("test: fs_helper: Drop the size_gran argument")
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_fs/conftest.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 0205048e73a..cc5c0fc3756 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -706,7 +706,7 @@ def fs_obj_fat(request, u_boot_config):
 
     try:
         # the volume size depends on the filesystem
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{fs_size}', None, 1024)
+        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{fs_size}')
     except:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
-- 
2.43.0

