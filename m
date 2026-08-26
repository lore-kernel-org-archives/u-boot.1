Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACBDC61DC4
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EDD780B56;
	Wed, 26 Aug 2026 16:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhsVj1dSC2FD; Wed, 26 Aug 2026 16:34:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762099;
	bh=DuQMAU1SL1bBuPzrfrH62iJooBHzg339wcIw01Dx9Eo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CqmAHSzfjcLXU3Ovm2gMQvyKc+PU8nayn/SQJ7GG99YYIXgL/Xovu6JmscTh6hx9l
	 o/klmyXR2krv/pJKjslB8eD/ygjdyExs1xySpzi5difvVOMIya5VSRap2sLp9OIX9V
	 fIr/CaNYuWpUdculnOVOVzer/DTSQApi2HjwiylKRnrbqDXWnA12H3oEU9Xz9qZQAC
	 7leAeXvt2I3V23lLw1vTivBjNgH9vNPwoa4LTO3i5r9lILNqRBJ+G/cqwBnO7GXyDZ
	 88ORiLUGAlpDnzsfYdFPet/KAbmg7pfXzOvWh1rzixQ/94l5dUY2diZTbhYkKf3F15
	 B1k8p5aT+ctUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A03380B6D;
	Wed, 26 Aug 2026 16:34:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D17839E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43B5E40118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2D4sGyR3F33l for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::631; helo=mail-ej1-x631.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=dAMYSoEW
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 41CA0400DC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:55 +0000 (UTC)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so15884466b.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762094; x=1788366894;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DuQMAU1SL1bBuPzrfrH62iJooBHzg339wcIw01Dx9Eo=;
 b=dAMYSoEWwBrQ/j9cBaa0kivxWmHnyvLwySPpXaKlIshnHlR1L3Z+gQU5LbWFAQuyTM
 Azzap6i+ZRfNFZKfnnyF72cVNcUJ3Bss4bgoXk991Xx2LeCvm2catIPtW2r3PixKQFcr
 AWaIDivhK2ctOYpzCBiH4oQIjlkUs9DjTYa2ESOMLlRwPxg1y0m1s6cSy7IDDWfVfnmt
 9MYL9ffQFnqR6NIhNVglNOCPI5TjRrv/fq2oEKycfa2o0gc4Y/dbEp6sp+fJfgmjdVSC
 Ud15sQ8Jw1MAvLpzW7LU/TViCa1vRhEhXyCkiOAY1g/Fzb21JSfMCvMoKiS0Y5DDmApw
 aCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762094; x=1788366894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DuQMAU1SL1bBuPzrfrH62iJooBHzg339wcIw01Dx9Eo=;
 b=SkEQR4PsZ0B+IKQmLBlVL5WFuhdusdI4ZbEtSQRIxxYrtz0Hp/GzuYL2In7FBDJPbm
 oAKIp3GhOqnkcJoXXBpD25669ryYUchewddNbYZ8ehPhh8FhLNc2PiNrFPirJimXFt7y
 630shOihRxvo5nvrcx5VgF4MzK9MOYE+rdhYoZyUxpFRLbSZ7eSJCd9Xb1/XnzqpuurW
 iueN37MDLUCKdbiF3O3sBx1p6n17SAPwIbrrypsajJOReiIq34lPkvcAyPr39oLp/3Nn
 WqwuPe1BsNEJ/J09zdWobYdt/PPTCm2fxPjgsFGdhpYw2nYeVeri5wIbhPZ4bx3VbO6v
 sdiw==
X-Gm-Message-State: AFuF++kAoZpPkFM6VQCGPKk/tXEmPZgP3cI3toU0m8xwK6Moua7Rh7RS
 K7FISrnf4lNCGPX4juFI1h4PTQSy0IDobRo+ZyISrHLe9cvoSduGcI/bTYxiHh0mRRY=
X-Gm-Gg: AR+sD13DcSqYCtWDkDxgBhbr7d+M4jve8WVUh8Z+ibYL+Fb5gXsomFBzml+pxJxnbr5
 C9UyAZHfmLvpnjWORVyVciYYnH0zLzsdNmSHH1sGZDB8aWQV/d5bOaqeB0OtnyS+WnRzFop83PJ
 3fmzq+2tqFoV0BkJt311XVsYYNkdHKPwbjDHydpufIELPJyZ6LgfxPX0B/ce5bV9Enp16GazO29
 2B+wsz8JptvYZpyxOSnCle/hS8c3LA7RplAgvdKTT/Ie0zOkFm3mbgwuheKnoIN2eEI+h57hudD
 SW9sXm0Y0z4mjh1dmq5msCEcJ6AKHMFrWp+3CAAJ25cp1usJAdax9ScquG3cp9XAQ1Iuxp8Lyv4
 vJj3d1+t3jYPh3v14SM1UjOOVeF5YIu+YrIMpKtFQFEdLKHtpJrfdFmdaMAJ4wDcJPzhhq1GCLn
 yH/9iYE95g0X5n3S/VQoD89rYI4YpUnFtLAzShOokhJZWp8uBshg2zEderMmj1vzilW5PNYf6L0
 QDbLStPFSUOHnDGLmlufNOSmK7XhqrxSCVHt8sfow==
X-Received: by 2002:a17:907:3d12:b0:c21:5cd6:3e49 with SMTP id
 a640c23a62f3a-c25360cb00fmr42067466b.9.1787762093788; 
 Wed, 26 Aug 2026 09:34:53 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:53 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:34:02 +0400
Subject: [PATCH v2 10/13] test: bootstd: add a BLS entry to the Fedora
 fixture image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-bls-v2-10-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4601; i=alchark@flipper.net;
 h=from:subject:message-id; bh=71YFibjTModGKLI6OwW0KfzOE5SjDdcuwguWit0xEyY=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/ZaKtlNz1y48O2zKWu3Hj974vKpjFiHbyfXO/79X
 DPvtpjHjY6JLAxiXAyWYoosc78tsZ1qxDdrl4fHV5g5rEwgQ6RFGhiAgIWBLzcxr9RIx0jPVNtQ
 z9BIx1jHiIGLUwCm+t4iRoYzVzstzXdu2+ja1VvvUvxoaz3LfwU9GUVp6b92abx7DyYx/FP5/PT
 RlJ1efnJtbIJlmScW+5nkp4eFK92bdHKCb8+N37wA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Write a BLS type 1 loader entry alongside the extlinux.conf already on the
Fedora test image, pointing at the same kernel, initrd and devicetree.

The entry is inert until the bootmeth is bound, so no test expectations
change here.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 test/py/tests/test_ut.py | 58 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a58..28f028453ea9 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -159,10 +159,13 @@ booti ${kernel_addr_r} ${ramdisk_addr_r} ${fdt_addr_r}
     fsh.cleanup()
 
 
-def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
-                         script):
+def setup_extlinux_bls_image(ubman, devnum, basename, vmlinux, initrd, dtbdir):
     """Create a 20MB disk image with a single FAT partition
 
+    The image carries both an extlinux/extlinux.conf and an equivalent BLS
+    type 1 entry under loader/entries/, so that the two bootmeths can be
+    exercised against the same kernel, initrd and devicetree.
+
     Args:
         ubman (ConsoleBase): Console to use
         devnum (int): Device number to use, e.g. 1
@@ -170,7 +173,6 @@ def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
         vmlinux (str): Kernel filename
         initrd (str): Ramdisk filename
         dtbdir (str or None): Devicetree filename
-        script (str): Script to place in the extlinux.conf file
     """
     fsh = FsHelper(ubman.config, 'vfat', 18, prefix=basename)
     fsh.setup()
@@ -178,10 +180,44 @@ def setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
     ext = os.path.join(fsh.srcdir, 'extlinux')
     mkdir_cond(ext)
 
+    script = '''# extlinux.conf generated by appliance-creator
+ui menu.c32
+menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
+menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
+menu hidden
+timeout 20
+totaltimeout 600
+
+label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+        kernel /%s
+        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
+        fdtdir /%s/
+        initrd /%s''' % (vmlinux, dtbdir, initrd)
+
     conf = os.path.join(ext, 'extlinux.conf')
     with open(conf, 'w', encoding='ascii') as fd:
         print(script, file=fd)
 
+    bls = os.path.join(fsh.srcdir, 'loader')
+    mkdir_cond(bls)
+    bls = os.path.join(bls, 'entries')
+    mkdir_cond(bls)
+
+    script = '''# BLS type 1 loader entry generated by appliance-creator
+title Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
+version 5.3.7-301.fc31.armv7hl
+machine-id 4098b3f648d74c13b1f04ccfba7798e8
+sort-key fedora
+architecture arm
+linux /%s
+options ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
+devicetree /%s/sandbox.dtb
+initrd /%s''' % (vmlinux, dtbdir, initrd)
+
+    conf = os.path.join(bls, '4098b3f648d74c13b1f04ccfba7798e8-5.3.7-301.fc31.armv7hl.conf')
+    with open(conf, 'w', encoding='ascii') as fd:
+        print(script, file=fd)
+
     inf = os.path.join(ubman.config.persistent_data_dir, 'inf')
     with open(inf, 'wb') as fd:
         fd.write(gzip.compress(b'vmlinux'))
@@ -223,21 +259,7 @@ def setup_fedora_image(ubman, devnum, basename):
     vmlinux = 'vmlinuz-5.3.7-301.fc31.armv7hl'
     initrd = 'initramfs-5.3.7-301.fc31.armv7hl.img'
     dtbdir = 'dtb-5.3.7-301.fc31.armv7hl'
-    script = '''# extlinux.conf generated by appliance-creator
-ui menu.c32
-menu autoboot Welcome to Fedora-Workstation-armhfp-31-1.9. Automatic boot in # second{,s}. Press a key for options.
-menu title Fedora-Workstation-armhfp-31-1.9 Boot Options.
-menu hidden
-timeout 20
-totaltimeout 600
-
-label Fedora-Workstation-armhfp-31-1.9 (5.3.7-301.fc31.armv7hl)
-        kernel /%s
-        append ro root=UUID=9732b35b-4cd5-458b-9b91-80f7047e0b8a rhgb quiet LANG=en_US.UTF-8 cma=192MB cma=256MB
-        fdtdir /%s/
-        initrd /%s''' % (vmlinux, dtbdir, initrd)
-    setup_extlinux_image(ubman, devnum, basename, vmlinux, initrd, dtbdir,
-                         script)
+    setup_extlinux_bls_image(ubman, devnum, basename, vmlinux, initrd, dtbdir)
 
 def setup_cros_image(ubman):
     """Create a 20MB disk image with ChromiumOS partitions"""

-- 
2.54.0

