Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193F6D7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AFBA8418A;
	Sat,  4 Apr 2026 16:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HOnL39tH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C4CE8418A; Sat,  4 Apr 2026 16:04:18 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A32A584180
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d9b1c57a4cso2310960a34.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311454; x=1775916254; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ws6eqMPqThFglHo6MtG4kUGMatNM4X291X52/k3JY/U=;
 b=HOnL39tHn4+Rlv5D6I4rJlHOQJU/zmk9ehEk6sMa5/bWu0WSayZx0v9sOdnTxDcUFV
 QoFv+V9adbj9PCH0cotDtHikj/j5Rxkt65nST9fPR+TYDqJ6b4WvPzdzykRVXUtSKG5n
 PpPc3k7nEXmjMsJ6vczymyh6A5C7HkLnU+oNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311454; x=1775916254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ws6eqMPqThFglHo6MtG4kUGMatNM4X291X52/k3JY/U=;
 b=QCMiKjcETC/5fhTwYep0fLKQseGarJtPF0QK/fHPRGEU2DypXxNDmTFQoqCpvwcA4z
 rzO4+Kmc6o76x/0xt4d2tZm3cl7T8lZ4fwKcMd2Oq5EqHwp6Atrsy89t+u++EElU744T
 5J32CSgEojm/WwxkPsordDE9TPz044vCMtNXAh9qonnKtyaLYy0d2frwinFT7meF9gUB
 D86kuCGQexA49rf+Y2fwQT0gQ/sPEsmgdpD2ARwr+UHmC9DxJyAlYJq0JpbzbtxMbSQg
 /p7OUoV4K4jolrL0mHx/wLTHuwb0lv4YkgOBEuKneK42Bj7DOCYZzdfhPDnAphReP01a
 6z5Q==
X-Gm-Message-State: AOJu0YyEVeICOcRCkpx//amsycNcXP5RQNLdtlYH4WSnJj5uKKH646Om
 7kxIYH3SVGyuPpOAPPXtXxFZmLGAHdyDfXxqvB5tCOkCG793RChKBHeZ0gnjdNwgYRy5IKCTP16
 WpEE=
X-Gm-Gg: AeBDiesTriy89f8WgGJmpLdJtmKvFY/zY0snMl1ErwQ63PcoR2xh6IMMLdA4VMnqFtN
 OVogR8aPha8wTXDI4HrWgpHLADgj557IuAMDZAclA1htV/ULUXNq6vHY7UZoiLrBSHJWs990/v/
 gy61M5CP3G8VIl67PgaqZEFKKBzoC7f9fOYMZMRq11ta65Q1H2xXfR3gDa6mn65ynjT5DswOOAH
 VhLmPJ1zqNmdIGBJrG2xZmcV7v9GzxE408nJwEDzZ3BlhKWoItfTG1GvK1IS8JYSyHwUzkDC6YZ
 To/GSI3qD0VipC9mSOoCCxkDhQ+oIgTz75ENdUvjdwz7DnI9RnO/XkLBaqdh/i5Ee42hJ0/B7yb
 HAibrXCsjc9mW8EQqPvGRiAllOxPFnLbRt19827L6qi4+j6CRHSrz6zSBUuzn7sXB41lnFIk1hS
 yk1enbEAMCLRw7k7+6Xg==
X-Received: by 2002:a05:6871:3321:b0:422:ffa0:4045 with SMTP id
 586e51a60fabf-423100a422dmr3469923fac.40.1775311453774; 
 Sat, 04 Apr 2026 07:04:13 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/14] test: Convert setup_efi_image() to use FsHelper
Date: Sat,  4 Apr 2026 08:03:14 -0600
Message-ID: <20260404140328.3724864-11-sjg@chromium.org>
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

Simplify this test-setup code by using the helper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_ut.py | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 8bc915ee5e0..ad84fb56b85 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -561,11 +561,9 @@ def test_ut_dm_init(ubman):
 def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
     devnum = 1
-    basename = 'flash'
-    fname, mnt = fs_helper.setup_image(ubman, devnum, 0xc, second_part=True,
-                                       basename=basename)
-
-    efi_dir = os.path.join(mnt, 'EFI')
+    fsh = FsHelper(ubman.config, 'vfat', 18, 'flash')
+    fsh.setup()
+    efi_dir = os.path.join(fsh.srcdir, 'EFI')
     mkdir_cond(efi_dir)
     bootdir = os.path.join(efi_dir, 'BOOT')
     mkdir_cond(bootdir)
@@ -575,13 +573,14 @@ def setup_efi_image(ubman):
     with open(efi_src, 'rb') as inf:
         with open(efi_dst, 'wb') as outf:
             outf.write(inf.read())
-    fsfile = 'vfat18M.img'
-    utils.run_and_log(ubman, f'fallocate -l 18M {fsfile}')
-    utils.run_and_log(ubman, f'mkfs.vfat {fsfile}')
-    utils.run_and_log(ubman, ['sh', '-c', f'mcopy -vs -i {fsfile} {mnt}/* ::/'])
-    copy_partition(ubman, fsfile, fname)
-    utils.run_and_log(ubman, f'rm -rf {mnt}')
-    utils.run_and_log(ubman, f'rm -f {fsfile}')
+
+    fsh.mk_fs()
+
+    img = DiskHelper(ubman.config, devnum, 'flash', True)
+    img.add_fs(fsh, DiskHelper.VFAT)
+    img.create()
+    fsh.cleanup()
+
 
 def setup_rauc_image(ubman):
     """Create a 40MB disk image with an A/B RAUC system on it"""
-- 
2.43.0

