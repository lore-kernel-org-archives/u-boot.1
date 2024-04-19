Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0731C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 09:59:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED33886F7;
	Fri, 19 Apr 2024 11:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="UoU1niyx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560B3886F8; Fri, 19 Apr 2024 11:59:16 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EBE881BC
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A44923F118
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713520750;
 bh=crSBQ0BS2UEK03tidGJn1bZriUPMJKfOA3NqRv497ko=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=UoU1niyx8zk2vPzhcvOy2y5drgrY889gET7Qr6FagYu3C0RqV5kydSyshZIdJ9MMT
 1uBdg1QwlTO+iSyAwMVJynfOkpB/IAtTbf2rWqcCp7dEv2Cm4OGj62ULC6t6U5z3ox
 1aTKhL9TGdJ4CsPBOF4oqHDwkNj+cYJCUCmuVwT6dnHlbQKthL+uTerrD4ve1tI77M
 x/xyvVs7dASvkc0yhJFAVRSqjN/4Oou6dhvGeggfO++PiY5zWlSXIMDnvaXwO3UI5p
 1UEmp/fq8sFPAKFbgeU/QVvJs2Ih88BVBrcDct/FnAGISSDG0FWUwj6998NPIONbfX
 yd5p+Y6OC7Ekg==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d8a7bb09afso16489901fa.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 02:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713520749; x=1714125549;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=crSBQ0BS2UEK03tidGJn1bZriUPMJKfOA3NqRv497ko=;
 b=BPh88MxbU/dXYE0m/hV0vaM8v1om82SdTEwpYcDZkk//ICtpNZdBSnEqVItSJ91rIZ
 R26cxNuTdQDmWCx1M4aT/fNzO4hRHgGwAQcBxDYFAVCN0UCjOW/QrwmPqoyAhA5HVeuz
 WtIvUydPq2tUUIFCfL7MopBRy1rzJDtAjfcUL/LQW6PtQGKkAzc13NPnAZ6f1jcUhLRc
 hlJ2rlnt28jKFVTcfJ8Tx4tQErJpwtVuOHllw1tHBtMYpScM6aAgc2ZSQNXp96Sz3c5M
 XUOocYB5IJh5Ug/AJh2R/9uv0MrBxpixfiyokgWxVRj5lyKUd/yaSYJSu1g+O1S0y4TL
 Ybww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe5bUB20wBfoGv/cU9snJhnFDJ23qZSaUvdh+PVFg+E6GiubUWYqMDmAb01B7lwf9RxrRSYK8V0TeiK7PYxRuJ1yTrQA==
X-Gm-Message-State: AOJu0YxrB0JjKbI77RmIJ3DSNNGwzWH7AWKERI/2wqHcwQcTmsOKTrS7
 HlITX/kviAJNm7PF7nDKcGH/2K6sxG4nHNND3QFVperFzjvTxNciE6yPxYTTi2UP+Wp27/H12M5
 nbTqvZnby9VntMpD2BBfNdCVqe9KkvKOxqTXEEEAPtJyTuAIPctmYFRYcg49G82rf6qE=
X-Received: by 2002:a2e:9dd3:0:b0:2d8:36ee:350d with SMTP id
 x19-20020a2e9dd3000000b002d836ee350dmr990974ljj.16.1713520749129; 
 Fri, 19 Apr 2024 02:59:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxzTIuxXst59XbRSKQban3cx6yoNX3HV8HoI5BbDt2pUupGYeKMtVLKEN0vqsoxB2+EGZmsw==
X-Received: by 2002:a2e:9dd3:0:b0:2d8:36ee:350d with SMTP id
 x19-20020a2e9dd3000000b002d836ee350dmr990959ljj.16.1713520748670; 
 Fri, 19 Apr 2024 02:59:08 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a05600c190a00b00418a9961c47sm5865615wmq.47.2024.04.19.02.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 02:59:08 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: superfluous efi_restore_gd after EFI_CALL
Date: Fri, 19 Apr 2024 11:59:01 +0200
Message-ID: <20240419095901.47201-1-heinrich.schuchardt@canonical.com>
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

EFI_CALL() invokes __efi_entry_check() which executes set_gd(efi_gd).
There is no need to execute set_gd(efi_gd) again via efi_restore_gd().

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/bootefi.c               | 1 -
 cmd/efidebug.c              | 2 --
 lib/efi_loader/efi_helper.c | 2 --
 3 files changed, 5 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 578dbb19a7e..c1454ffb948 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -107,7 +107,6 @@ static int do_efi_selftest(void)
 
 	/* Execute the test */
 	ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
-	efi_restore_gd();
 	free(loaded_image_info->load_options);
 	efi_free_pool(test_device_path);
 	efi_free_pool(test_image_path);
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 32c64711b6c..30def6b6831 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -1466,8 +1466,6 @@ static __maybe_unused int do_efi_test_bootmgr(struct cmd_tbl *cmdtp, int flag,
 	if (ret && exit_data)
 		efi_free_pool(exit_data);
 
-	efi_restore_gd();
-
 	free(load_options);
 	return CMD_RET_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 58761fae784..88c3586787e 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -544,8 +544,6 @@ efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options)
 		}
 	}
 
-	efi_restore_gd();
-
 out:
 	free(load_options);
 
-- 
2.43.0

