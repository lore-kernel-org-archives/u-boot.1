Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0CCC79F89
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A0CB80C74;
	Mon,  7 Sep 2026 13:03:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qk9w7jb-NCyV; Mon,  7 Sep 2026 13:03:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C505880C46
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788786188;
	b=SlbzZUM7GIswyFFk+l8NQMPUIxyOoXWSpcFvh5GzpqdWUKPGdtxKth81kjwv434ELwAJ
	 APS21YUlfVAf3e86ZCN8Se7cYhU5+/LrAsG7X0BJT2+ZTFzchk8TD+sjK34HfF12dnX/5
	 dcVUP7XL2HfCek5k4bTgFTufc+n7HRM/5tMW1RyLX7ub/lUweGroUbiHjibgz/fuMWcPx
	 8nVe1rFP5teEkVGOlf+ds/MiiR/urrBTedt6dQiARQnEI+tKwKRwSHHAP7CIVzm2CepDG
	 os92fpYf9MkSI+wDLWIITwYXXu+H+kbXftkMry2FH3j55pKTjXO2LISfGIfTjD3/F9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788786188;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9EUOh0UF2dRjNsNI7ioQ2MF9o9yZG2wSdbhXfe2kfVw=;
	b=pGCegU3mUXOoxbJmpzpX8UOdudOn09CV40nLmTmlHlMaTQgHLBG6qvXr4XEeRrciOfKf
	 3qAVO8AtN8RWIHLz+yyylz+Z984liS9zhZ9LD5tvLdUF7DCEwxmNilvDziH8kLU3dUIwD
	 UpJ5XnYiJNXqbvO2g33BryQKYbthEWcmc8ugsC4bbAR0tYlsvR6WLkqdT7zHQlM/t31nP
	 8E78ZFnblIC58G1IU4Rl2hva5/k3rTuxejrbD9Ugu9VBO7nrXZio+qsAHQOopeB7wMdDP
	 Ky9phuXw2uKbPX1CnGwbtC3SyN6FyuzMm5e+viENuTwIewrSNDdgUm60XDk1vtppRGg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788786187;
	bh=9EUOh0UF2dRjNsNI7ioQ2MF9o9yZG2wSdbhXfe2kfVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YOcmG8nOBxcSd7QTj+88+88WyjIU+zXZ6+VJDdFV6uDUFDceQVtvsLUJJSX6heKHz
	 TYi6BVPQZ25uG7M28zbFbK7m07vVCoB0aYDxF4ExgeeKWIGPeu5wwAQD1dCZvaRbXc
	 gN8/Gtef+ExAllCsKL/+QGPKAMgP1EF7zOsEJ214aDRA69BjMW8VhRO8InNdU9qZnB
	 rkBCdFNxYfgqhihWR5bc289c073Y8T779pdBvzvgfKoFkU/wntOS5lzOPGSYVZLso7
	 ZJRgKXuRdcqHSNsSGfuWGfuEZ/m1Rz+BagANdqUeeo7bRjPLGog8k/hY5llxOHrz3E
	 wwJ86ORViRa7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C505880C46;
	Mon,  7 Sep 2026 13:03:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 31EBD990
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 17C0540402
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOQh18YfTLAD for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 07:43:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B9F5404F6
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788766981;
 b=nbgU/UJxIMrzDjfeT2kuIapRmwsgYkfR7JUJTq1ebkbTe30AdSyZ8A/OkBgpGruNs/Dq
 0VCfg2pwdRUfcicvfN6YILcfHAL4F66dIT04+j6eWW606ofWlFF937VfeykNGK0/BIqii
 dkOZGBKAc6LiHbBxD911Qnj3YBgkf4qwCUJvIL/VJx6TdYhbEfqMm1XWGv5aHj9fkkePk
 cAVWnlULoTJj+vmcbII6zJiTp4yNpCFoo5N4Y8U2s4/fEvfrNYIlGpVsW/KKRBhc98S3O
 1gqthHyKu2OpKzO778V9KBuRFzCWajpM8I3PESyk5KDpJOe0jLkKFXCDba+uwsO299w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788766981;
 h=Received-SPF:Received:DKIM-Signature:Received:
 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
 bh=9EUOh0UF2dRjNsNI7ioQ2MF9o9yZG2wSdbhXfe2kfVw=;
 b=oz0DIG9CxlJpel06uq+wu3ZCZOeeAGicbwMY68sVrHacvzKb+DiD4jpy9gwCNLRIAD3d
 kJYkHHokSEqpuiN7np9fc4UVIQI26+rNEZXpXeHlArdjGtocvyru7IeAw8i9ln6gAVC59
 yE1SjGbXEdMZMu09WnEjIwb/XU0fM4IpH8Q+26J4tK5UezaVPa0/mw3QLbUoL2adgtQIH
 i9luE7RZRWiX7f3Dlh+hHx012yZclkaIprSclzbykq0p63cKOcsRgTjXxOVQqupR2VHTk
 2MykHS4WMxLHUiXd2TuU+54RhtzmDV5MlqWNzVafGuSVr8XVAdUBqhoUY8+SXPoUGWQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=canonical.com; 
 dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256
 header.s=20251003 header.b=aqRY+WJe; 
 arc=none smtp.remote-ip=185.125.188.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=aqRY+WJe
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1B9F5404F6
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:43:00 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 15B143F125
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 07:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788766979;
 bh=9EUOh0UF2dRjNsNI7ioQ2MF9o9yZG2wSdbhXfe2kfVw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=aqRY+WJeI4CtU8Z5e+TcbyIaPRJaD9taQFRXEPAfki2YRTkVHrDfeABIDyG2oFYpZ
 a8Geodb66Nklzok68f50cr28/tmbszZUpqHqOLEtLV4nmc3fsLlLBUiDIOBgS3oDqj
 sq9A+x6widYlNXSCLoG8HX396tmqFZscaZGArl3v9XcYZDUkndgvzvdECZmBURMteN
 TKX6pRBxu20REwvkslWsR+nzvCPFJ08jo1kE78+B0/nzRlwwFrKEmngPypDW5G6Xr5
 HuPm480Ll6L+a4yGF+L0J7Gz0nJqIwV11oWSxtmYhukiOLkGL05TE4jsj1uTFRFnF+
 h/lpK4YTHv/usa3LgCqjrA6tiEOIO5/DMKyZoHQo2mpanO97IwvDcoWMfx9OAWQjWh
 Un3+uM0Xynpvd76hp36Ovn/LX4rD0rdwSnjimTgJgBpSPX2jBt/9NpUvZnnL1A0Ot7
 mDN8JytMBf5dhlOFkXs3o4ldmwSKAQev+3xYElKWITU8Z7g8cqRrYWa7Q7OKUxNSgK
 FUERzKAheXXTytSTanCdyZJ4HprP3hkW92JSPxxoAcpsF92cI0647Zmhy5CqXioBmt
 tZRIu3EWkTap2a7bEY40wRRRjLFAVpSjNzBxLXY60iGTZbG0+YSov4kqZ8Ao1sgadz
 +5n8VNzhvb5WqXmw5XL3Q6qA=
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-855f662439aso5901568b3a.1
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 00:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766977; x=1789371777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9EUOh0UF2dRjNsNI7ioQ2MF9o9yZG2wSdbhXfe2kfVw=;
 b=NrNHVGWy1xtNLoEj55MUphUFNsUd/o3O4VEgPJhzsdtyPWYW/5irndiCyh422RlcrO
 AwirzN5vadkagHWYrghzZ9smI0XqB0gzP/Q/iofIJ8fYO/kNmhz5KSW10CnZKFdRdPqi
 sbzbOS9iLAIHJSE0SFYRcLoXNzLTMAOGNdj8QI7RevALvwNjkRQjEr1v6KQXn6u42e31
 o6BvMwZjBAxTRsS3c8/khCmNYa3hi+J3w05M7Xv7HY5hkuozIor8BrqMVk6yrf0KsnFP
 aya7AujzFv1/4nF37uq/qWMMAxrz871pdOagWuV8c40ppTlEYhCqJfDU08SvgJNxkjLp
 1OSg==
X-Gm-Message-State: AFuF++m6rHBaklIsZVe8EOzlK+2GMVFHbUB18mzHMxTN3a9533uRms1I
 PkKRC5ksut4E/xyWgctIzHm3sfnQqPDdCLM83rVc2kYQcjiYre9vRDY0qLTaEix+JoceOd8W/66
 L0y40UUUmXN+OST8JFzOzFBp+N0fVVKxenQwUtHBxi6qlwG1CCnz6T2Yti/nLHspyxZC3wVroqr
 mzuPwHkvNzwuIDDkkYgw==
X-Gm-Gg: AYBFou2KIJEFTMrojuwh9SRbVXxUxUDNrTlsXeHoCUWvhuLTxlkQG8bRaxWsjQMb6Ng
 NqwXejbViQsLzb9rmSG8DH6aQquQ1Y9rawGk20M8TFti2UMWZO60omJ1jIVAcGnSUGaoAQgkcMO
 wqI8F0IJizODVojAuLfQxFNVtug4tYzEhtBiP7qEOS+7wo1SB6/+qfQJDIIM5P0DFwjpB8szJWY
 StQ9w1K5SNfG5RlE6QmHv0lFeJcD1n1v2Sr6OY1i3mAI5TAnnMfSXlTEpk07mwACUGiXkRvkzDK
 /soDunbOeITsPKdyiyLfPobOAb4X/Q3O0XF7Kuu0Ye21W4H0UFVwghVSe+FvqPGP0Nl6Q5s4DwV
 pDKTnttK5R72/GOM26hXJ1Ar1KjOY00L+imLo5ldJNS0S2+4=
X-Received: by 2002:a05:6a00:3d10:b0:85f:3d78:79cc with SMTP id
 d2e1a72fcca58-8616a76f748mr31484375b3a.9.1788766977561; 
 Mon, 07 Sep 2026 00:42:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d10:b0:85f:3d78:79cc with SMTP id
 d2e1a72fcca58-8616a76f748mr31484311b3a.9.1788766977045; 
 Mon, 07 Sep 2026 00:42:57 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8615292d875sm3974215b3a.25.2026.09.07.00.42.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:42:56 -0700 (PDT)
From: Aristo Chen <aristo.chen@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Aristo Chen <aristo.chen@canonical.com>, Denis Mukhin <dmukhin@ford.com>
Subject: [PATCH v1 2/2] test: bootstd: Cover invalid ChromiumOS keyblock and
 preamble metadata
Date: Mon,  7 Sep 2026 07:42:18 +0000
Message-ID: <20260907074221.3718-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907074221.3718-1-aristo.chen@canonical.com>
References: <20260907074221.3718-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 07 Sep 2026 13:03:00 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add four malformed kernel partitions to the ChromiumOS test disk:

- partition 6 (KERN_C): a keyblock with a valid magic but an
  out-of-range keyblock_size, placing the preamble far outside the
  probed area
- partition 13 (KERN_D): an accepted keyblock_size with a preamble_size
  that puts the kernel body offset inside the probed area
- partition 14 (KERN_E): a preamble_size that wraps the 32-bit sum
  forming the kernel body offset
- partition 15 (KERN_F): a keyblock_size smaller than the keyblock
  header itself, placing the claimed preamble inside the header

All four must be rejected while scanning, so the existing bootflow_cros
and bootstd_images assertions (bootflow rows and counts) are unchanged.
Without the previous fix, partition 6 crashes sandbox with SIGSEGV, and
the other three scan successfully and surface as spurious ready
bootflows, so each check is covered by an observable failure.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/bootflow.c     |  6 ++++++
 test/py/tests/test_ut.py | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index ef4638ec700..b7a8df293ad 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -1255,6 +1255,12 @@ BOOTSTD_TEST(bootflow_cmdline_special, 0);
 /* Test ChromiumOS bootmeth */
 static int bootflow_cros(struct unit_test_state *uts)
 {
+	/*
+	 * mmc5 has valid kernels in partitions 2 and 4 and corrupt kernel
+	 * metadata in partitions 6, 13, 14 and 15 (oversized keyblock,
+	 * undersized body offset, wrapped body offset, undersized keyblock),
+	 * none of which may produce a bootflow
+	 */
 	ut_assertok(scan_mmc_bootdev(uts, "mmc5", true));
 	ut_assertok(run_command("bootflow list", 0));
 
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a5..605274075e0 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -10,6 +10,7 @@ test one at a time, as well setting up some files needed by the tests.
 import collections
 import gzip
 import os
+import struct
 import os.path
 import re
 import pytest
@@ -319,6 +320,10 @@ def setup_cros_image(ubman):
         {'num': 5, 'label':'ROOT_B', 'type': uuid_root, 'size': '1'},
         {'num': 3, 'label':'ROOT_A', 'type': uuid_root, 'size': '1'},
         {'num': 1, 'label':'STATE', 'type': uuid_state, 'size': '1M'},
+
+        {'num': 0xd, 'label':'KERN_D', 'type': uuid_kern, 'size': '1'},
+        {'num': 0xe, 'label':'KERN_E', 'type': uuid_kern, 'size': '1'},
+        {'num': 0xf, 'label':'KERN_F', 'type': uuid_kern, 'size': '1'},
         ]
 
     for part in required_parts:
@@ -373,6 +378,45 @@ def setup_cros_image(ubman):
     set_part_data(2, pack_kernel(ubman, 'x86', kern, dummy))
     set_part_data(4, pack_kernel(ubman, 'arm', kern, dummy))
 
+    def bad_kernel_part(keyblock_size, preamble_size):
+        """Build corrupt-kernel-partition data that U-Boot must reject
+
+        The keyblock carries a valid magic and the given keyblock_size; a
+        preamble with the given preamble_size follows it. The bootloader
+        address/size fields are chosen so that, were the partition not
+        rejected, scanning it would succeed and produce a spurious ready
+        bootflow, which the bootflow-list assertions would then catch.
+
+        Args:
+            keyblock_size (int): Value for the keyblock_size field
+            preamble_size (int): Value for the preamble_size field
+
+        Return:
+            bytes: Data to place at the start of the partition
+        """
+        kblock = b'CHROMEOS' + struct.pack('<IIII', 2, 1, keyblock_size, 0)
+        kblock = kblock.ljust(min(keyblock_size, 0x100), b'\0')
+        # preamble_size, then body_load_address / bootloader_address /
+        # bootloader_size at offsets 48 / 56 / 64, body-signature data_size
+        # at offset 88
+        pre = struct.pack('<I', preamble_size).ljust(48, b'\0')
+        pre += struct.pack('<QQI', 0x100000, 0x103000, 0x1000)
+        pre = pre.ljust(88, b'\0') + struct.pack('<I', 0x4000)
+        return kblock + pre
+
+    # add corrupt kernel partitions, all of which must be rejected:
+    # - partition 6 (KERN_C): keyblock_size placing the preamble far outside
+    #   the probed data
+    # - partition 13 (KERN_D): preamble_size placing the kernel body offset
+    #   inside the probed data
+    # - partition 14 (KERN_E): preamble_size wrapping the 32-bit body offset
+    # - partition 15 (KERN_F): keyblock_size smaller than the keyblock header,
+    #   placing the claimed preamble inside the header
+    set_part_data(6, bad_kernel_part(0xffffffff, 0x800))
+    set_part_data(0xd, bad_kernel_part(0x100, 0x800))
+    set_part_data(0xe, bad_kernel_part(0x100, 0xffffff10))
+    set_part_data(0xf, bad_kernel_part(0x18, 0x1000))
+
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
 
-- 
2.43.0

