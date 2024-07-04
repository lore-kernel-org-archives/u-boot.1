Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D00C30653
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 14:43:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F84888669;
	Thu,  4 Jul 2024 16:43:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="chcU44DT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E95885D7; Thu,  4 Jul 2024 16:43:23 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2AB888EC
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 16:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52e9f863c46so725750e87.1
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720104201; x=1720709001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rMXBoBsBa5mrNSPlxlX1unK3g8soUkrm3vzpEwKw36c=;
 b=chcU44DTe2wSVcCspGqSlqbX5ZK95kRkwVsjaDKxCOFifCzgKjfmxfiuR31a2We0Jk
 trDtuAicSKf2x8RkF+AS0mUw2D+JRpB4TZbewU6Z+cg5OUpjd/75sZhPYZ+AAho6Rf+r
 uCRBrYV6NPkPxkqM+Cjzb6orJvfEX2dkERM/k+jchbullM+SPvEkr7Qn9UstV0vTEbbg
 2WHoJ3yL/RmJCjZLnoK3JSMzMwHqUDsd4x9fCPuMKOFLpDlJxeXLaEYuXvR/eDwSZknH
 F4Tc4L5p/n/eBpodw6+Sj2a4fbmekNpaY4Qd5ZBF9XYQmawRXmVwFXTKsgPDNwFAXwiH
 q2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720104201; x=1720709001;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rMXBoBsBa5mrNSPlxlX1unK3g8soUkrm3vzpEwKw36c=;
 b=ipuc2IUTFvHRQ5aumoxU5r9UevHli/gbQhKOUVrs6ReytdkI3klqVzB2pqplYeaQNj
 BPOyxEbj0+IOFR1BQ2cZYHM1c9M922SYQa6hFVGIXY5LQsIlhfzH5TBw2ECkXZ82lqa4
 bxivqxtHnComiSFoboLWh6Ra3E51fVVn2k6WSdmGfka+YCZsq/Xv/Z6mRuTO8IJNApWo
 PnKszHKwZkF396/qqzLXNnjmNVZ4sVGegih4bIzVdIT3FwLGfrHZsrsVfq5FSOdgLC5L
 FsiFaPOi5pkJSZo6qEt/wU+qGb6JqjbWOQwg2jS3K0weLdmpQ0qWZpxTwsLJeOEpls3u
 ALJg==
X-Gm-Message-State: AOJu0YwXSGrpUjxFQPD/vyrUIAzF/Dnt54SGK8CKzAvlu4OX6PreDqx1
 TTlyTo+T2ygJKkO2bx6cRCFVbJDZcNwdvu52A/jorKQfjutFmSkcCDN8C25hedM=
X-Google-Smtp-Source: AGHT+IFLGqLPgtDkR/muu3T44JlwpqcHUR/JgqJwLrSeZDGXe+vZzclE5FYUE9zwzF2xmJbnj8uhhw==
X-Received: by 2002:a05:6512:3618:b0:52e:9d2c:1c81 with SMTP id
 2adb3069b0e04-52ea06185eamr1275094e87.13.1720104199659; 
 Thu, 04 Jul 2024 07:43:19 -0700 (PDT)
Received: from hades.. (ppp046103011142.access.hol.gr. [46.103.11.142])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d0bd6sm27420905e9.8.2024.07.04.07.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 07:43:19 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] test: test for ignore OsIndications
Date: Thu,  4 Jul 2024 17:43:16 +0300
Message-ID: <20240704144316.251029-1-ilias.apalodimas@linaro.org>
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

The tests we currently have expect the firmware update to fail
when OsIndications is not set properly. However, we have a Kconfig flag
that explicitly ignores that variable. Adjust the tests accordingly

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- v1 was rebased incorrectly and only sent half of the patch
 .../test_capsule_firmware_raw.py              | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index a5b5c8a3853a..f3a2dff5c2c8 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -76,7 +76,7 @@ class TestEfiCapsuleFirmwareRaw:
             self, u_boot_config, u_boot_console, efi_capsule_data):
         """ Test Case 2
         Update U-Boot and U-Boot environment on SPI Flash but with OsIndications unset
-        No update should happen
+        No update should happen unless CONFIG_EFI_IGNORE_OSINDICATIONS is set
         0x100000-0x150000: U-Boot binary (but dummy)
         0x150000-0x200000: U-Boot environment (but dummy)
         """
@@ -91,16 +91,27 @@ class TestEfiCapsuleFirmwareRaw:
         # reboot
         u_boot_console.restart_uboot()

+        ignore_os_indications = u_boot_config.buildconfig.get(
+            'config_efi_ignore_osindications')
+        need_reboot = True if ignore_os_indications else False
+
+        capsule_auth = u_boot_config.buildconfig.get(
+            'config_efi_capsule_authenticate')
+
         capsule_early = u_boot_config.buildconfig.get(
             'config_efi_capsule_on_disk_early')
         with u_boot_console.log.section('Test Case 2-b, after reboot'):
             if not capsule_early:
-                exec_manual_update(u_boot_console, disk_img, capsule_files, False)
+                exec_manual_update(u_boot_console, disk_img, capsule_files, need_reboot)

-            check_file_exist(u_boot_console, disk_img, capsule_files)
+            if not ignore_os_indications:
+                check_file_exist(u_boot_console, disk_img, capsule_files)

-            verify_content(u_boot_console, '100000', 'u-boot:Old')
-            verify_content(u_boot_console, '150000', 'u-boot-env:Old')
+            expected = 'u-boot:New' if (ignore_os_indications and not capsule_auth) else 'u-boot:Old'
+            verify_content(u_boot_console, '100000', expected)
+
+            expected = 'u-boot-env:New' if (ignore_os_indications and not capsule_auth) else 'u-boot-env:Old'
+            verify_content(u_boot_console, '150000', expected)

     def test_efi_capsule_fw3(
             self, u_boot_config, u_boot_console, efi_capsule_data):
--
2.43.0

