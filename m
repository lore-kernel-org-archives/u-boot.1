Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A747CD1284
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 07:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360008801A;
	Tue,  9 Apr 2024 09:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ROkRe/mK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9938811D; Tue,  9 Apr 2024 09:56:00 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4128D87F6F
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 09:55:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BAB7A3F16A
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712649357;
 bh=TWwWizBVzKu0R1L4zsef6HpVDW2TBIGwQbFh5KS8ggs=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=ROkRe/mKK+Wl+rX4bHCe2UOF6wcxTh2ifEDQ1ItWEt3pEvZdwH4ODKDzEbDgE6bSN
 IqIwcYWtYeImNjGKy5Fkc16L/WgtHRd4wK4MRE35IiYekdI8avjP5qWd0/UNAn4xry
 P4rmZrCmswkk2X1Nxg/1NNNrV4zzBl1bnRthfEGl6sM2NW4NBRMG8T1vfQ1U3l/+ks
 UAzG/WROB0FDnAW9WztFv1lDpr3vCwI574sOjZIr4Cn7Y41S3/C/JL+5iTuF2YG8mD
 C3H5l2p7zmByoB6ADurtUPcOA76fVIWFOlFyw/jU0yelkjwTIaeaUkizICYLVK2w8q
 6mR3GrN26if0g==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343efa26688so2124446f8f.3
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 00:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712649357; x=1713254157;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TWwWizBVzKu0R1L4zsef6HpVDW2TBIGwQbFh5KS8ggs=;
 b=KmpCl7OiSQetitmwnUuzclyNBw87AEeXk07gI5YQcXYWlFlBHXhWuBJybYe0VZBgPa
 zIv3ND8iIt0IPk2Gd/YRe59bdGgxXro+xr73aCuSv8vXISSW+ywSGKm0yF0DRHAzR0lP
 /82CjfcFyxKRGCt7R2BsT3hJT2umQZb9FyDeoaqAPTIlzlutBIN/YPhIZ/DQWlGfBJEp
 iCCWI5lfdRGcYOZK1tPUXAf4yFhVyhGWHd318WV2IAyprNkdbEEq0Sx2sNLl7MfsjCMu
 ZEt0aSQ773eZKlg3Soyr7PnvPh5bpHZz8w+v9rNEETLA9Wy6vTUL3g6ZPZ85VKGXHTRZ
 rlWg==
X-Gm-Message-State: AOJu0YwhIqzXmwf/Kokt+DTONmFyI+RxjceeEgZhlr0IFhpzFrRtJJ3U
 k3xkFg47dzbOI65HgLilhWDHyu34JfNPFrl5HY+BDqdNNXX5w9HFWQ2Dn58azUxQxbjhXq2QuWs
 jhALFPNjLuBlyvDIo5JlL8pwwQpb9g514DDLgMeeqe9noR20sDLA/4zxv9UVGUu8czM4=
X-Received: by 2002:adf:f74e:0:b0:343:68d6:5636 with SMTP id
 z14-20020adff74e000000b0034368d65636mr6829617wrp.43.1712649357326; 
 Tue, 09 Apr 2024 00:55:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt941rryGY4jrmb1F/8fc+MsaCYj+3BNvDy8CmE92eGSIO3K8CnmOS/KN4Yx/kXbEqMnBfkw==
X-Received: by 2002:adf:f74e:0:b0:343:68d6:5636 with SMTP id
 z14-20020adff74e000000b0034368d65636mr6829603wrp.43.1712649356917; 
 Tue, 09 Apr 2024 00:55:56 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s7-20020adfea87000000b0033e7de97214sm10792157wrm.40.2024.04.09.00.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 00:55:56 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: typo curren
Date: Tue,  9 Apr 2024 09:55:49 +0200
Message-ID: <20240409075549.12514-1-heinrich.schuchardt@canonical.com>
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

Fix typos in test_eficonfig.py: %s/curren/current/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_eficonfig/test_eficonfig.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/test/py/tests/test_eficonfig/test_eficonfig.py b/test/py/tests/test_eficonfig/test_eficonfig.py
index b0a6cc47df2..1d8e033f75d 100644
--- a/test/py/tests/test_eficonfig/test_eficonfig.py
+++ b/test/py/tests/test_eficonfig/test_eficonfig.py
@@ -224,7 +224,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
 
         # Change the Boot Order
         press_up_down_enter_and_wait(0, 2, True, None)
-        # Check the curren BootOrder
+        # Check the current BootOrder
         for i in ('test 2', 'test 1', 'host 0:1', 'Save', 'Quit'):
             u_boot_console.p.expect([i])
         # move 'test 2' to the second entry
@@ -269,7 +269,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
         u_boot_console.run_command('eficonfig', wait_for_prompt=False)
         # Select 'Edit Boot Option'
         press_up_down_enter_and_wait(0, 1, True, None)
-        # Check the curren BootOrder
+        # Check the current BootOrder
         for i in ('test 1', 'Quit'):
             u_boot_console.p.expect([i])
         press_up_down_enter_and_wait(0, 0, True, None)
@@ -326,7 +326,7 @@ def test_efi_eficonfig(u_boot_console, efi_eficonfig_data):
 
         # Select 'Delete Boot Option'
         press_up_down_enter_and_wait(0, 3, True, None)
-        # Check the curren BootOrder
+        # Check the current BootOrder
         for i in ('test 3', 'Quit'):
             u_boot_console.p.expect([i])
 
-- 
2.43.0

