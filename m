Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B589BD7877A
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 15:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA64188DB1;
	Thu, 21 Nov 2024 16:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QEaSJMcV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9578788D09; Thu, 21 Nov 2024 16:03:08 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3290C88E3A
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 16:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43169902057so8495025e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 07:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732201385; x=1732806185;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WFr8BfS+zm6mIJxp92dURzViB/IbEV97O/cLH2Pd6/Y=;
 b=QEaSJMcVOFLIcurbQbAYlHlMn3O0u/YX7fdBL6VEzskTVeVP70JY9hKJ9CItQ3LAdx
 yNzVBFGF33vvmPp4+HT891QtmyELwArz/OT9IO0ZBynhDgRZLV3m8eecMIT2n1xvOTfR
 GSK3B+24XUlmKS0WThBzklRFXV0s8uisC3QtB6kHfNddfwTcrazfX1yF7T+jV+KNicro
 sk7KV2iiE5nMq9roky/Q74a7L3mrpt3HPgZi9GbGMg28z3GPQhgAgb5wnEF2AKtAFQ/d
 tgjAw9o3JVInUM5/4ehzBdHEDwGttFuRjRAvSU9bJzVBk/qj9dFqKjd/lt4me/bmOtcb
 7hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732201385; x=1732806185;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFr8BfS+zm6mIJxp92dURzViB/IbEV97O/cLH2Pd6/Y=;
 b=eP+IOnCXf8PxHn5WUqO+aUHfLdivKUHd0ZKa2spvdfBqCLUxdBGCcBgvNyefDgvtmb
 q0ReGHXO6p8mFYupBgxJP62N7eSPe6SoMGJKIfXI1o7O1kbJS89orQ5df9kBLr7Ffywb
 2swb5J+p9Y0Ulmih7bW56+VTEl/jXCcNh9MZDoX4ZuIWq1sbpz3vv2dUWXO0qov5GCh7
 9an0jAaPWScQJksNTJaR4oQt2ymTnavrf2PSY2cKFZYOe4Sr0WBPX/WdbcIoj/cBA8MK
 IoUyQLUchCoC89k5lVI9cJ/ioxv/Iqx9GpJm6lcmKcp3kbuO09/yrVL2w+qb4JmA1fTd
 gpXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ6oBa/57WuXsQtjdZLHcHn9mr3ZxaWwZzbhozP075WJLJZf5U/Y0NhgtWeiGyfRM3LI6gjSc=@lists.denx.de
X-Gm-Message-State: AOJu0YwYbDexP29cv2Wb8SczPMKZcsMvvRjBGNZ01Qzjj8njSgjo7/U1
 MA41w1PpCOh6tYZAalPWPeFvtVfdhS8VNLmq6/EbXjnx6ALvt68xfSig3B5fp4s=
X-Gm-Gg: ASbGncs8dj5Rh8YfoblgjL5yf7GrKuB3dbfm5lIh5jMilBHva98f+Wx4m+v/L/FLlY/
 IjpTLhBHC7y6IoWio7PqpyVdcmWXKU9JGEqemLhbqBPqI8SaBRq2q1meeA/sNo/DDYiokYA/3BR
 MAxF3bcKJhFFV9S3kERafmfhg4cVRoX0ZyObc2ssMKhlmiEwXk7X/UNtTb/9kf8zTbnR0OGgihc
 mdugiuBgrQXUzn04EfBlaYmpwWIat+UiMzKiikv+gJ3hzsb137mFWGBpnuPtnvqOg==
X-Google-Smtp-Source: AGHT+IEc8VRrMPsO+btviNNNutP6c8ifU4dOS7xz2vGPi2mv1pJtol/Gm0aAWZPfXESyMesEJ8MtIw==
X-Received: by 2002:a05:600c:3b24:b0:431:52b7:a485 with SMTP id
 5b1f17b1804b1-433489d671dmr57005355e9.19.1732201385271; 
 Thu, 21 Nov 2024 07:03:05 -0800 (PST)
Received: from [192.168.1.20] ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4617563sm57906375e9.25.2024.11.21.07.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 07:03:04 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date: Thu, 21 Nov 2024 16:02:59 +0100
Subject: [PATCH] test: boot: Bind bootmeth_{cros,android} only once per run
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-bootstd-test-fix-multiple-bind-v1-1-f6c06b9581b1@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAKNLP2cC/x2NQQqDQAwAvyI5N2DierBfKT103bQN2F3ZpKUg/
 t3F48Aws4FJVTG4dhtU+alpyQ3o0sH8fuSXoKbGwD0HIiaMpbh5QhdzfOofP9/FdV0Eo+aENE4
 x8chDoAAtslZp0jm43ff9ABZY42FwAAAA
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

Check if the bootstd already has a "cros" or "android" driver and only bind it
if it does not exist.

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
 test/boot/bootflow.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 9397328609d0..835d2e6e35a6 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -552,15 +552,21 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 	/* Enable the cros bootmeth if needed */
 	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros_android) {
 		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
-		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
-					"cros", 0, ofnode_null(), &dev));
+		/* Only bind the bootmeth once to avoid duplicate scan results */
+		if (device_find_child_by_name(bootstd, "cros", &dev) == -ENODEV) {
+			ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
+						"cros", 0, ofnode_null(), &dev));
+		}
 	}
 
 	/* Enable the android bootmeths if needed */
 	if (IS_ENABLED(CONFIG_BOOTMETH_ANDROID) && bind_cros_android) {
 		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
-		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
-					"android", 0, ofnode_null(), &dev));
+		/* Only bind the bootmeth once to avoid duplicate scan results */
+		if (device_find_child_by_name(bootstd, "android", &dev) == -ENODEV) {
+			ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_android),
+						"android", 0, ofnode_null(), &dev));
+		}
 	}
 
 	/* Change the order to include the device */

---
base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
change-id: 20241121-bootstd-test-fix-multiple-bind-159bd2523414

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

