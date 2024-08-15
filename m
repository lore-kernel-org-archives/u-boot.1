Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A78DC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4D488BE4;
	Thu, 15 Aug 2024 22:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RpFbd+ez";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA62F88AF2; Thu, 15 Aug 2024 22:26:07 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5AA88B58
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-39b32f258c8so8064135ab.1
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753561; x=1724358361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HOc23348ToSBF/UJq2eLiXqptKVwBQqkzcGVbrDRT6I=;
 b=RpFbd+ezwrq57eGqYSAZAGNbDooEtjtqtsx0aGqmKD2aAFB5KM32XG9Rj70kQd10Pa
 10lLa82wz2dUeT26KNggVfrTtDOxa3ibf+pii7k4AVeSMwGeknfk/tBciCYsSaiCVDC/
 ugAjsO6nQ6tRpShTN5Fn39ZZJDX/m2ajzK7M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753561; x=1724358361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HOc23348ToSBF/UJq2eLiXqptKVwBQqkzcGVbrDRT6I=;
 b=XnJ+9Q6UPEUzAxxgNv0TL8Z7Jg12E08Q1MbCHDx0nYF+GXyrW++0HwRI9qcBpOYflh
 piL3wQDlG5RjmFI3UEE6wtX7gOF1TAofFng6OOO5sCBsoOfms+C0QUYd3/GgMMv0nK12
 1FsGCjshXarNq29BDoL94f5/1tyYYfoVpuGTNG2k2bm4rJF82AWB07JURtJbT1jrdqly
 zCwMnURpLzkhivNCvt/+Y+rVtuzT95EBan0ePcixuyiGUF2Fe16ULzQ59NciE2RWoWj7
 jNxK8MeMvIgSfvUQFVDc9L8nsI8nYw5x/0xFGVhc5/3MRuzOiWR5OltWjrCaNkI6L9i4
 bJRA==
X-Gm-Message-State: AOJu0YzXuLfTdBZmILAHj9vgrd7nkyH3nahE4B5J8QaUf7f1z4yB231g
 vrhhzfGms0q5/1LGMNWv7OoOw2aUwFt0mtLT6ymSKGiW74Ahw5I3YInTkrgOHXB32tzYVQId41w
 yOw==
X-Google-Smtp-Source: AGHT+IECFGZQZfdYokCLgC347eLWxxUOvE8+Z2H7fgiJoIA7OXauUxf4d28wyZPRxsBPhB2z6A8GUQ==
X-Received: by 2002:a05:6e02:170a:b0:374:988e:5d01 with SMTP id
 e9e14a558f8ab-39d27a82d91mr7752025ab.2.1723753561025; 
 Thu, 15 Aug 2024 13:26:01 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ed5db5bsm8014235ab.64.2024.08.15.13.26.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:26:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 24/24] test: mbr: Drop a duplicate test
Date: Thu, 15 Aug 2024 14:25:35 -0600
Message-Id: <20240815202535.767869-25-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202535.767869-1-sjg@chromium.org>
References: <20240815202535.767869-1-sjg@chromium.org>
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

The test currently runs twice as it is declared twice. Unwind this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add many new patches to resolve all the outstanding test issues

 test/cmd/mbr.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index ec19cf3793c..2beaf9a75c5 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -484,10 +484,3 @@ int do_ut_mbr(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 	return cmd_ut_category("mbr", "mbr_test_", tests, n_ents, argc, argv);
 }
-
-static int dm_test_cmd_mbr(struct unit_test_state *uts)
-{
-	return mbr_test_run(uts);
-}
-
-DM_TEST(dm_test_cmd_mbr, UT_TESTF_SCAN_FDT | UT_TESTF_CONSOLE_REC);
-- 
2.34.1

