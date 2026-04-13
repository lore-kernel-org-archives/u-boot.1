Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF96F34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D8DE8421D;
	Mon, 13 Apr 2026 15:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dG6zK2aZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08BEF839D5; Mon, 13 Apr 2026 15:01:34 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 759DA841BE
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dbd2a0211bso3198715a34.0
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085289; x=1776690089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mKKMwJEXNccMVRbjf/M/Cyhj42/TW3hLuqRloykcaGc=;
 b=dG6zK2aZAzA9hJTbOqcULVGY8FdyDKzE/kFM1S7rZXbcTYDtYhDhXfrOcSX2mRnwQE
 +0LxFpPVKsDHCri4Tjn1rjAh0bA/KoKgDsfhJLrQyspeO/ToOOVLZ4/D6MW0tIS67AHU
 Rd22f5TEbUSCAd34xxC6V9LmRIlLbbPx0koSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085289; x=1776690089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mKKMwJEXNccMVRbjf/M/Cyhj42/TW3hLuqRloykcaGc=;
 b=AuRhZHJys+Y6EQnZCToSeN87pg9okkq5+U+vRs0O7/wXfmfaUMl1XT2G2wEqdDzIDW
 z2dBd6MInfxshqMSscVTVTMS3NnB5nPAZHMLe7+An7YbaRLGPHwnbQnF6tg32bTJQ3Qh
 Pfeyw1iqc7X2VGppe/7jRrkUWkigJRIqhd8eqWLW1yP2sYcyq6dH1NaZ8+KHQ1i+lDPB
 V7Cb7yep5BkzEDhJ3Nb8/dmRMGbkNtNunV+dl/XESog5NDEvKR7uMbG0+KteOKdViYgY
 eckRwpGLFdsWipWlgYDieQqxeeHXEVuBnS+DVc7LDXvUQ17Ppni79nKX8ePDIJfpEoL8
 6GOw==
X-Gm-Message-State: AOJu0YywpazXAl8ZS4jzh5JaFF3vR1XgX9pDiG1URXhJowHQPo7du7je
 Cm2Yb1m5lTfhkg7XA6j4AbqBY33e1Kr6SWNkwTa6J+zp9mPr15Bl1jLowhVMtSCtIoichu6Wf9V
 qqZNTHA==
X-Gm-Gg: AeBDieuTfpULhWs5XXQRaIUlSKN0/mWINicU01JroG2sRnm5xS8CilXHx2E5z+EzVTc
 ruNoOczLDuBIlhlB9HOcKukOgTi4fxDw3En6YmvyXel7FIDT3iKRqMigaR7vy1KOTka8ciaRvtb
 QpR+OPf82YHLNPSD1f6jDDuAZpL6fwMnK7t6gBJFsuvbiIeKIO4TdLQ2bDmzX1alPNDhh+ESGnD
 qiNc/cleRWUoWHoaMMhKtF8ksDL+PGuq5OHHnqjBIQyGR1Hrz7nqOOUtp4Oo7l8dSmWmjviTxZj
 doem3Ob2YblLyqg7YPS6Z7N91bejtNQru8Rn+S0EsM7CKhIdLsEUuvYJBd9D8Y+cPpQBaZqR7Jd
 1ukawTeqEEkQ7XIkfk+afTD7pEefJ3C4Okn+dKo1LWl4ySRZKfZ3gMBvuPe61w1gMIo1Ne2Em4M
 9pettfsvLYf6AUkllCyQ==
X-Received: by 2002:a05:6830:2684:b0:7db:a832:b329 with SMTP id
 46e09a7af769-7dc27f02d10mr7217155a34.21.1776085289411; 
 Mon, 13 Apr 2026 06:01:29 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 3/8] test: Rename test_fit() to test_fit_base()
Date: Mon, 13 Apr 2026 06:59:54 -0600
Message-ID: <20260413130007.1987326-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
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

The current name is uses as a root name by a few other tests, such as
test_fit_ecdsa() which makes it hard to run just this test.

Rename it to test_fit_base()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fit.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 4a19bd5cb49..4c7d400bc6a 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -119,7 +119,7 @@ host save hostfs 0 %(loadables2_addr)x %(loadables2_out)s %(loadables2_size)x
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.requiredtool('dtc')
-def test_fit(ubman):
+def test_fit_base(ubman):
     def make_fname(leaf):
         """Make a temporary filename
 
-- 
2.43.0

