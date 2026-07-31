Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778EC55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 803244118A;
	Fri, 31 Jul 2026 17:18:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tyjGMy6r_Kyn; Fri, 31 Jul 2026 17:18:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7466441190
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518338;
	bh=o0iJbcLkn+BI9F/hf7LLGw5MFIk2FZYw6duV9X73h4A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wsMVhuKM6Oebojm2ixigeONfraa6Jufo6p522Y9ocnZOcc3KyRK7r+gTC35h5BZj8
	 ZJG/WtTgVNAB5z98PMQW9Yxdb6aDS3tzV8Kwtfg5pjvvBPnqoQ60cuDzNMtcSqXrcU
	 Dgrl0yLG6ZfE7A+a5BKNRHMapJROnby5qwP0N1Td5uQZKOuaOweJJooepYJKj6Q15F
	 w0Uy9YBvUy8VptBuaLaLuFg1HZDPGWoX1CVrrVM9zQLbN3ZK9KCIlgLDbNORTc1psp
	 4/D9PWgkuN+Rj6FaGDU2Ag/6gD6uHE8OnMEyAdaM1We7Q9SFiKwQR7h/cJ8gU13DHZ
	 hbs9kZzfCuFtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7466441190;
	Fri, 31 Jul 2026 17:18:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3BC6F26E
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39B9B400AB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ookPzq52jz7X for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EFD7A40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EFD7A40025
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EFD7A40025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:36 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47f84023916so1262152f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517895; x=1786122695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o0iJbcLkn+BI9F/hf7LLGw5MFIk2FZYw6duV9X73h4A=;
 b=W0ZE29Tzdnpt0Sg0uvgJepBF+uJFk2JRN+ShEELeEM+vDwAfY1JywY4dxGB3F7kUa1
 LqoyRS3u2/G1XOMmN1DG3yPhFKXViM/uMR5S3aqO4lVhsyzbELIPa5wTTK/Fm1kI//oR
 vouJfMOHkepKeJtjuIg5wpcEMTvXnrDauBWlDTqPalTOkUN7rLUv18GffuLcS6XjhM/8
 VoyHnrW++rHEkGApiZE9IFKgqnhy5iRsT8R+cklWUyuQEjBUN5WACCsMmtI2zShoK7N5
 /0/399HSKh5oMX0dRYZhEW8aUrseDOuj/RJjafr9rncDVguw1rDByUisxZsgXW5XjgbE
 pqUw==
X-Gm-Message-State: AOJu0YyKhmDkfAT3AqXPL3Ht7Zd4uO5nVhbB89tpaLwri8t4lZiOA2NC
 S3i7BCTWJIxpEnhV28/csEkjNT61eFVnoHtzOgPlzWpGHHivV9nahoOi6fPCCpcBrc8=
X-Gm-Gg: AR+sD11P3Y5Ziwpystb91A/vRJT5C55GCPZu1DkW+RmTjHmQRo5xn6DmPhfZzNUO/of
 aX2xl7/s5T4li2JyXzGjHPKL9e4JnjDWUIgNUBlN5kHvvjRsR5qQ9eSbW6S8+sqYlcpWnDV+Jj+
 WGCvmwSIe/HA4skzpTwfQACeAlKWVxCDVqaRub9RswCGgDg5tSZ+7qf30AXv9T8A3PLG9IVlomX
 J5hAKwwcH3eG2BTfinkWRjoUfmJJbD3P8uNai3VeEg2ymEcdivFyHqlNrM/pgGGIDSmRv3vd9qZ
 5lvjGFyqdiTbVSCYlDyTeTm36K0Y5kRxTiUFVMDb4xMo8EEBP68Vrv2FNVFcYr9lhRNYb0Ds3Fe
 Z6tZGLNX76MjsSUBQCqc7ztv4JwZra7b5/GoO0dZyhF/4nxGY6JzJflZiUwhw2KzR0Y5/lHeQWp
 uFZw6Ih0NTISnP55UvixJ4e4+ssRCowQ/wa6rhRU4JGaG9bcJxxNWbY3qpQW3Q/ysC74KYKwYoh
 UN32UiJdsJKmwJXQeXlRz5Y1B6AC9eBhaXg98Tu2Q==
X-Received: by 2002:a5d:65c5:0:b0:47f:45fa:98e0 with SMTP id
 ffacd0b85a97d-47fd7331124mr717926f8f.57.1785517894798; 
 Fri, 31 Jul 2026 10:11:34 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:34 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:49 +0400
Subject: [PATCH v2 05/10] binman: Add support for externally provided Linux
 initrd blob
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-5-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; i=alchark@flipper.net;
 h=from:subject:message-id; bh=yaXr9kIdxL2sTPvsPVMKYgu+zOma4bwMi2QNjI7xDpM=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFdSN9xyY/abVR7FEc9/BK5UOX9s36KXvI+7N1cdz
 cv+azedv2MiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpFgxh+MNxJafoAdeNDutzBwQTDUQDor8fY3DTW8zDe+nw+a/HS0MZGa597nl
 Tbum+3LcjPFTWvHfqetY33Ofb5BWKOV4YtNZfZgYA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517895; x=1786122695;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o0iJbcLkn+BI9F/hf7LLGw5MFIk2FZYw6duV9X73h4A=;
 b=VtyYCMQ2YFBU26AK8nx7TJlALGBniwcllivDO9lClR09xEthSuQh1ee4ahqWZYyunh
 iv8zLeEFR1ZQvobkiF5n9v4/gjLiM2aij9ypoO07DeubltbgKtGWF0gpgaBmHYPzCnIF
 sIq1JgvMAQrDk0Dr2YYi9is0VL0ONjrpj+lyMdhi/AWGvGHG86QVqdtsAauLPy8JZs+y
 E4rcQ7VXre+RUD5Xt/XBLSkGU+NhgeD3BwYxMXTSf2AgoXlamsMe1wbxoralqp5tqF/J
 4iGrHMh35z9sZ3MkfLHz1zg360JTJYkiVYiXEPuqJynntSshEwQkJKLaF5ZRLBs8qrDX
 z1zA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=VtyYCMQ2
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a simple named Linux ramdisk blob type to binman, activated by the
"LINUX_INITRD" make variable. No processing is done on the blob.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 Makefile                           |  1 +
 tools/binman/etype/linux_initrd.py | 23 +++++++++++++++++++++++
 tools/binman/missing-blob-help     |  5 +++++
 3 files changed, 29 insertions(+)

diff --git a/Makefile b/Makefile
index 246efa2c23be..81f49b791e6f 100644
--- a/Makefile
+++ b/Makefile
@@ -1693,6 +1693,7 @@ cmd_binman = $(srctree)/tools/binman/binman $(if $(BINMAN_DEBUG),-D) \
 		-a atf-bl1-path=${BL1} \
 		-a atf-bl31-path=${BL31} \
 		-a linux-kernel-path=${LINUX_KERNEL} \
+		-a linux-initrd-path=${LINUX_INITRD} \
 		-a tee-os-path=${TEE} \
 		-a ti-dm-path=${TI_DM} \
 		-a opensbi-path=${OPENSBI} \
diff --git a/tools/binman/etype/linux_initrd.py b/tools/binman/etype/linux_initrd.py
new file mode 100644
index 000000000000..9603bc279c26
--- /dev/null
+++ b/tools/binman/etype/linux_initrd.py
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2026 Flipper FZCO
+#
+# Entry-type module for a Linux initramfs/initrd binary blob
+
+from binman.etype.blob_named_by_arg import Entry_blob_named_by_arg
+
+
+class Entry_linux_initrd(Entry_blob_named_by_arg):
+    """Linux initramfs (initrd) image blob
+
+    Properties / Entry arguments:
+        - linux-initrd-path: Filename of file to read into entry. This is
+            typically a compressed cpio archive (e.g. initramfs.cpio.gz).
+
+    This entry allows binman FIT templates to consume an initramfs provided via
+    a make variable, similar to how the kernel is passed to linux-kernel. It is
+    optional: when no path is supplied the entry is simply dropped.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node, 'linux-initrd', required=False)
+        self.external = True
diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-help
index c8c56e3ad9b5..818060919399 100644
--- a/tools/binman/missing-blob-help
+++ b/tools/binman/missing-blob-help
@@ -32,6 +32,11 @@ If CONFIG_WDT_K3_RTI_LOAD_FW is enabled, a firmware image is needed for
 the R5F core(s) to trigger the system reset. One possible source is
 https://github.com/siemens/k3-rti-wdt.
 
+linux-initrd:
+An initramfs to embed in a Falcon mode FIT image, so that the OS can be
+started from SPL without a root filesystem being available yet. This is
+optional; build with LINUX_INITRD=/path/to/initramfs.cpio.gz to include one.
+
 linux-kernel:
 A Linux kernel image is required to build a Falcon mode FIT image, which
 lets SPL start the OS directly instead of U-Boot proper. Build with

-- 
2.54.0

