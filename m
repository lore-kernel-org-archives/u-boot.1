Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C24D75E53
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABBD8984B;
	Fri, 22 Nov 2024 15:11:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="azEiTWY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A194288FD2; Fri, 22 Nov 2024 15:11:41 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14778984B
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 15:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-432d9bb168cso18818665e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 06:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732284698; x=1732889498;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s6LdVqY5gwBTlrKiG0Yvdo3fMZbNxJeBGsKXvSlvgTI=;
 b=azEiTWY5hHhlQQUnHHLPBdpvf8EbctX/VoCNYFnpZqwA7SjZltaHqcZOlWlYxFhzyw
 4cqSJAWOXgrc4NeLZ2gtin+y5FVztK3Oyb+Ms674Wv8DdCcFA3QwwOQNNTRkZqr9veu4
 u4eSP1E2VUCOeUfenuqKSQddmqhFqyc3UECX5H13Cwo2Vll+dByO+B6K6EQN9dLjm/Xa
 YGsVmur5XRJbHo94nUMOox04jZZ0NZoDIHJ6YmA0/1HuRWuyF/P0Zaxq5TrovnHSoVQr
 OB3bO6mPDcJEKrj8vi02EcMjAyF7LjFfJ723ei2cwbQuMf7QaUeEOy1RjAjS+5gUzf14
 uKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732284698; x=1732889498;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s6LdVqY5gwBTlrKiG0Yvdo3fMZbNxJeBGsKXvSlvgTI=;
 b=IdQmd0iNIxrEXE36yT5569dfK8h6LH/MMWRDJlnedSdEwGnHsUzpoHzVM0o1oibFer
 QiZWH3UttkrdlDH8ZMfwBdvT9QvzWoeFvxY70zlfRA2olZCtupN0LkK8rSUBqo1mnSvk
 O+d4/GrZAp/1ZEBC+pIgBWNRuUYbJAbYMgoaMHWTN63NnkGBbA9G0hlKBhKDbLb8Mgs7
 fJxUEz4yDS+2qvnTQnXdu049rahw8ABQJR/ITkD0F/gewApMB1kEc+2vnFKAt1FieTO+
 bHeE+erOx5ZTcHT3bb9TFrF9ywmzlYYp+EVMxhY5gTNYc04hp0/s4iXoTrG11LPjBEAv
 545w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhmhSCvq9KqWOhDIecoW3jAGpf6tLjiZqW1sREJUwCWlYuKH9nTWA4trniOHsAPN7UHh1RGFM=@lists.denx.de
X-Gm-Message-State: AOJu0YzSr9fnCeMpUONp/P9KDXQYj4p04GLu/v+mPwDocaxmpDfzMG8f
 Vyq1AMdk1dyIu6xC/iCLHGBinAeVMDKZndQOxu0VF/S3PZmA3lLnPHPZJyzjKz8=
X-Gm-Gg: ASbGncuLE6F6F5Uxb2MKfx8E/Als7gDwb1PjWL4+TjJC/8PYy4IKLp9Y+/cAcEDgDnz
 s/wJywtS8ChH0hl4ZRvqUKvhi1zV8k3GJ8VPPYTV/qeF4/Wa7MbCmI01vvVsQnbGHFEIiZ4ySEK
 MXkSwgk1p9noRYGwYgEOPypyfFWcFXxMuekgXoScyiItQqft/pPvzi58YwxP8u0eTRY16raOPu4
 jKZ4R0+14IkCgZkyCL2JX0Sp1aiyeiPBOmQ9eBCLyKW8nEi3VM9tKVEi8Kr/vsnBA==
X-Google-Smtp-Source: AGHT+IGFQgB7zeX89X+8cg7pBPIJm22DbLkyTT7asm4q3yjPrcyhGsL4OVKlNOCTMNdhKquxfHBhpQ==
X-Received: by 2002:a7b:cb4e:0:b0:431:416e:2603 with SMTP id
 5b1f17b1804b1-433c5c8895amr66713475e9.3.1732284698015; 
 Fri, 22 Nov 2024 06:11:38 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433cde97cdfsm28305435e9.38.2024.11.22.06.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 06:11:37 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Fri, 22 Nov 2024 15:11:34 +0100
Subject: [PATCH v2] test: boot: Set DM|SCAN_FDT flags for
 bootmeth_{cros,android}
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-bootstd-test-fix-multiple-bind-v2-1-b7643b59402c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABWRQGcC/42NQQ6CMBBFr2Jm7RimAhFX3sOwYOggkwAlbSUSw
 t2tnMDl+/l5b4MgXiXA/bSBl0WDuimBOZ+g7ZvpJag2MZjM5ESGkJ2LIVqMEiJ2+sHxPUSdB0H
 WySIVFVtTmGtOOSTJ7CWdjsCzTtxriM6vR2+h3/q3eiEk7Mo2K7kqbsT04GYdlL1cWjdCve/7F
 9BqV6vPAAAA
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.2-dev-b7dec
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

We make fewer calls to dm_test_restore() since
commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")

Because of this some valid test combinations are now broken:

$ ./test/py/test.py --bd sandbox --build -k test_ut
$ ./test/py/test.py --bd sandbox --build -k "bootflow_android or bootflow_cros"

Shows:

  Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4       ',
  got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2       '

Here prep_mmc_bootdev() is called twice and it will bind bootmeth_cros twice.

Since bootmeth_cros is bound twice, 'bootflow scan' will find 2x the
expected bootflows.

Before
commit fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
this did not happen because a cleanup was called each time.

Add UTF_DM and UTF_SCAN_FDT flags to both tests to make sure that the
bootmeths are unbound after the test finishes.

Fixes: fbdac8155c89 ("test: Expand implementation of ut_list_has_dm_tests()")
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Initially, this was found when merging some Android bootflow patches
from [1].

However, this can be reproduced on 'next' as well.

Here is the test output that's broken (we have 4 cros bootmethods instead of 2)

=> ut bootstd bootflow_cros
Test: bootflow_cros: bootflow.c
Showing all bootflows
Seq  Method       State   Uclass    Part  Name                      Filename
---  -----------  ------  --------  ----  ------------------------ ----------------
0  extlinux     ready   mmc          1  mmc1.bootdev.part_1 /extlinux/extlinux.conf
1  cros         ready   mmc          2  mmc5.bootdev.part_2
2  cros         ready   mmc          2  mmc5.bootdev.part_2
3  cros         ready   mmc          4  mmc5.bootdev.part_4
4  cros         ready   mmc          4  mmc5.bootdev.part_4
---  -----------  ------  --------  ----  ------------------------ ----------------
(5 bootflows, 5 valid)
test/boot/bootflow.c:1192, bootflow_cros(): console:
Expected '  2  cros         ready   mmc          4 mmc5.bootdev.part_4       ',
got '  2  cros         ready   mmc          2 mmc5.bootdev.part_2       '
Test bootflow_cros failed 1 times

[1] https://lore.kernel.org/r/all/87mshvxhq3.fsf@baylibre.com/
---
Changes in v2:
- Use UTF_DM | UTF_SCAN_FDT instead (Simon)
- Link to v1: https://lore.kernel.org/r/20241121-bootstd-test-fix-multiple-bind-v1-1-f6c06b9581b1@baylibre.com
---
 test/boot/bootflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 9397328609d0..da713d8ed72b 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1197,7 +1197,7 @@ static int bootflow_cros(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE);
+BOOTSTD_TEST(bootflow_cros, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
 /* Test Android bootmeth  */
 static int bootflow_android(struct unit_test_state *uts)
@@ -1220,7 +1220,7 @@ static int bootflow_android(struct unit_test_state *uts)
 
 	return 0;
 }
-BOOTSTD_TEST(bootflow_android, UTF_CONSOLE);
+BOOTSTD_TEST(bootflow_android, UTF_CONSOLE | UTF_DM | UTF_SCAN_FDT);
 
 /* Test EFI bootmeth */
 static int bootflow_efi(struct unit_test_state *uts)

---
base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
change-id: 20241121-bootstd-test-fix-multiple-bind-159bd2523414

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

