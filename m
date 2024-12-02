Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95A1D78322
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 13:46:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35EF3891CF;
	Mon,  2 Dec 2024 14:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="OSHYl8Fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7C1388DDA; Mon,  2 Dec 2024 14:46:08 +0100 (CET)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B073A890BC
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 14:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eabachinin@salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 76912100005;
 Mon,  2 Dec 2024 16:46:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 76912100005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1733147162;
 bh=oc+9glUsR3UzyJ8OowuT0vn0sggfXEPV144R0Ji/ces=;
 h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
 b=OSHYl8Fs9RnIuAGw0nsRT5ddULp9E2g6M7V6oc4FvNTp6ux7EXxggsZ6jJME1QAJ3
 kGSXFRwby+08J2s1iWz2QzztBi6Zm184lWUZ3wursaXLA+736rYsTysjpwfyqSoRVR
 NFA4M1ZX4airFPPnQrRXd0TUXtqijhmc1/WZS/Jq5UCdIaXeFP3TTSEYWQXeMGUC5i
 DrQDUTS3yHXiWqYNW56OAfPSihr7kHblLqCo0DBorh/cfnmWEZoWFN8HZ9zFwUrTaL
 l9v1Zd+blwcHW6yD4Moei1HzHDJsA+tzUOke4dqMJGvhkGc5w0YstEnZILMH9QUCH7
 61E28qAQlHVRg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Dec 2024 16:46:02 +0300 (MSK)
From: Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH 0/5] sandbox: repair compile and run-time for OF_EMBED case
Date: Mon, 2 Dec 2024 16:45:21 +0300
Message-ID: <20241202-sandbox_repair_of_embed-v1-0-05aff4b0ccf7@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPG5TWcC/x3MQQrDIBBG4auEWVfQIQnSq5QiWv8ks6iGEUog5
 O6RLr/Feyc1qKDRczhJ8ZMmtXS4x0CfLZYVRnI3seXRObamxZJTPYJij6KhLgHfhGzYeT/OExJ
 zol7vikWO//n1vq4b72hCPWkAAAA=
X-Change-ID: 20241120-sandbox_repair_of_embed-2188465eb22b
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Raymond Mao <raymond.mao@linaro.org>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>, "Francis
 Laniel" <francis.laniel@amarulasolutions.com>
CC: <kernel@salutedevices.com>, <evgen89bachinin@gmail.com>,
 <u-boot@lists.denx.de>, Evgeny Bachinin <EABachinin@salutedevices.com>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.28.132.49]
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189547 [Dec 02 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: eabachinin@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 44 0.3.44
 5149b91aab9eaefa5f6630aab0c7a7210c633ab6, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:7.1.1,5.0.1;
 github.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/12/02 11:56:00
X-KSMG-LinksScanning: Clean, bases: 2024/12/02 11:58:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/12/02 11:33:00 #26927957
X-KSMG-AntiVirus-Status: Clean, skipped
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

This patch-set repairs ability to use sandbox with CONFIG_OF_EMBED=y.

For now, to use OF_EMBED, the following must be done
1) sandbox64_defconfig should have:
  ```
  -CONFIG_OF_LIVE=y
  +CONFIG_OF_EMBED=y
  ```

2) On sandbox when CONFIG_OF_EMBED=y, the u-boot process can't start
due to:
  ```
  Bloblist at b000 not found (err=-2)
  initcall failed at call 000000000011829c (err=-2: No such file or \
      directory)
  ### ERROR ### Please RESET the board ###
  ```
  So, it is natural desire to disable CONFIG_BLOBLIST just to test
sandbox with OF_EMBED=y (disable it one way or another):
  ```
    config SANDBOX
  -	select BLOBLIST
  +     select BLOBLIST if SOME_NON_EXISTING_OPTION
  ```

3) As a result, having such changes (CONFIG_OF_EMBED=y &&
CONFIG_BLOBLIST=n) leads to the link & run-time errors, being fixed
by this patch series.

Signed-off-by: Evgeny Bachinin <EABachinin@salutedevices.com>
---
Tested:
* locally with aforementioned options applied
* CI - https://github.com/u-boot/u-boot/pull/704
  * No regression

---
Evgeny Bachinin (5):
      sandbox: fix bloblist_finish() linker error if BLOBLIST=n
      test: sandbox: fix invalid_use_of_IF_ENABLED_INT if BLOBLIST=n
      test: sandbox: fix link error with do_ut_bloblist if BLOBLIST=n
      test: sandbox: fix link error with do_ut_bootm if BLOBLIST=n
      sandbox: set retval early in board_fdt_blob_setup()

 arch/sandbox/cpu/cpu.c |  2 +-
 include/bloblist.h     |  7 +++++++
 test/cmd_ut.c          |  2 ++
 test/lib/kconfig.c     | 10 ++++++----
 4 files changed, 16 insertions(+), 5 deletions(-)
---
base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
change-id: 20241120-sandbox_repair_of_embed-2188465eb22b

Best regards,
-- 
Evgeny Bachinin <EABachinin@salutedevices.com>

