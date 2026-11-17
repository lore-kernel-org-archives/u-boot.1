Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F0E606A31C
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K3evSqQ6;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QWw5AvFF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EEAC811FB;
	Tue, 17 Nov 2026 15:54:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 57tHmt_7nt7c; Tue, 17 Nov 2026 15:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44B31811F8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794930877;
	b=YT9AeQx4iFkNBVmwLaBnjIBlvHYg4nYqq4lHzx+1aOK4Eos0y//FSTqv/B2m9UavsvX/
	 MKC/iOKa0/QmsaWQZf0TqrayT9RSg2u/qfVcM23yiEfue0Rv4FihJHB0ZYbVkF2a3SYJR
	 eRgaPFriMy2OZybLha7JwSOydXL54ogVLplpNpXm2EBO8LB/7yhUuBJWooeRqTY6O8oL3
	 MNVPUOIkLFcRq/fvnl/QwonXX22gwuZaX3GAwg5IM1eVB2xKdph6Nl2WeBzukbN8+K/BV
	 wM4/LFdb3ccSHu8HR3eeNOPQMQR5bTdNME+e4Mn+HOKVcHJ7Z7O8CL72x8OifsBB7gA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794930877;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dc+W1ozucx4mfZWW+5N9AOa4i0jana4auL83/Hx02X0=;
	b=KqkTsfh1ke9kXCtaSlYL/s/2EuQUNPvD0ufkrqlRRDsAhk/wzk+NnGiVjzJ2b1Ek2lfH
	 tVcBJ2dYZaeRYRfuTXzwv5EYM0h6S0EHMklROONCh4QujvMrFTcyicDSHtn+uLaWohccJ
	 IVB9CaGY+pm0+02FruB9TRFs8HZgQuoy0q3yj3gNlqzw6JnH2ONEJQl1yVCVvhU4t+4tN
	 Mtb4fhdeDGIBDD+HBtnZoVDhOkOF7v9Sv9HO2oMaWJxaWlw8MlmubV4sT5rZmzwfdHA6h
	 Q4ZBY0ZzOxqWETg9WCyHdDc7+/M2vHK9BjXQ2uaJAKzCS0Eu+cLcxDzrox2W9F0exnQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794930877;
	bh=dc+W1ozucx4mfZWW+5N9AOa4i0jana4auL83/Hx02X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K3evSqQ6LaheMXKfs/4dTp7DXh5qnZbzdVKEM31vxJUijjhjB9nmPbX3B53nz57nM
	 5KQE96wuaZbgwkoVwavAkNUyHoNjFxyJmHEfL7GLyWwbzcuH+QscKbxVJujx1zvO3x
	 46Zp0rErEhkESKdHc2Ar3IsvbBl3e5P33hfyPIBJ0twmOwnnaFK6AKFFO1ou6EUJUg
	 FyI0JiHy3PN+ldrjWQjgjBbQT/NbZSNuq5Syf2HUOlWW6PJWUI9iy2C+99JK6xDKCg
	 4HPPNWeWOCRcJswRVQzNyoTlihM6vsTTQH2EgNWTipUCAqy7vUOCAsLOhNKvY802wl
	 aH8m/DTVjnd2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44B31811F8;
	Tue, 17 Nov 2026 15:54:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 63A114A0
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 41D794054A
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lk5s4tceKJNg for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 15:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EF18C4053C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=QWw5AvFF
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EF18C4053C
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 15:54:33 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so4435e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 07:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794930871; x=1795535671;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dc+W1ozucx4mfZWW+5N9AOa4i0jana4auL83/Hx02X0=;
 b=QWw5AvFFNCXSK8pEy7OeJiTDRjhH9U/YAzq7SDOGOoz/ekTkrWo5mFqPqlEqJFhuJo
 Gl8lWtQq75TuxBG8bYnqC8w7b5N6NtMKQnl9ZsCh1t9xhuZlJdqMFrxPYf/qYuzAohJF
 LOpmyu3WVynryqq40vAcDmLzfEgIzAPLWeK+3ExlRb8d+c7b0ZzMqVF8UXGVRYyglcmn
 jWLtAxiIw896dgYILeaK1GcbenwyJqJCRMH7ygx15UhFesrohr05tPLLxn90tk+JX2bX
 I0swpIJvhxHR4255nAoRPQihnpDBVSlORjUayQx/tfmYI1F9BbPZOS3RPmVjXJ0aGkhm
 HYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794930871; x=1795535671;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dc+W1ozucx4mfZWW+5N9AOa4i0jana4auL83/Hx02X0=;
 b=VaxaQrLVLFKd0sW0h2PazZjAZVVsV1zE3H1CuMqHSZz3WI7fg2HUEKgLL0auiW0yUM
 u7UwwXfTPDfHX/7oF9KGScjQzalWpeXqgl/51+/xc2fj1LZEOlbC5YAtq9+m6hxx9Mbc
 PUSpNayhG3bIFCgKLNgJUeIk71uPx5+WhSoedl1+PzVdFj684C5kI9H75VYD818Em9lJ
 IHNgnRsJI/WpbrXweKwvdx8vX2E8btgxHZqVreFt9kDU5OjkXyHNGlkIwr+2DXp3CVs6
 uG8SanY2aHPXGX1iapL5XqhQh3k38zLctBryKa2YMbVpv1Jj+p7YcaKv0JDFSXn+3esa
 xvmw==
X-Forwarded-Encrypted: i=1;
 AL+hErHgjIwCvz68tsT0XryBn/rBJCLq5rYaeD1Zpvf67F4VSOdIUfHsuLIcatjkzSQ14cJh1IdCqUk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z84fS2tG72jHMN60hkhN8uQOZbjsML0euv2wpuauSQdL0gNm8eP
 6Z5YdlgxxzIBRifO/usc13ewplRm3uIVT8uLRgCoAcU3xtZvz3sEbWib
X-Gm-Gg: AYBFou0Imp/AJ/+snvbzwZKGI4WzNzZOeN2asX9PXpMIEIgT9JToDRpn338sGDlTCPT
 tvjjG2jHfJ+qxs/f+GQSCwHDuui9lKmWDu4fxFJDor4tOBS7TkV/bH5Z1dOtpAx8N4XGWgxPLxI
 qIkLOOwLtmod2gAjKjZOx2eQiYB5DbFtPA0/hvPUh+djwtaYeqTOC3Nr6LsY8ntcnCj4uVNo6an
 GHeLoIxnc0VK1pX3v9cCkBTp+JPkDhtPyJn7i/Yujn9LdVO+U45fzlu8Ia0Y7OSQBR/m+UkKreJ
 +pus7Ct3JExD8uRe2uXRWNpLdsFp+Sv4NHSCCrd5L08AWee1Oya5tF5EBqNyc2yOdyLF9VFAz2g
 VYCNfy3g0FtDOB8kTJVdmcg/SeglQ1XeD+RemCrsSvBJj8cGLphVVkt9CxGavAPBQjO+NmAKhPo
 DTzd/USlhQWUWruOPqlrCLv13imhqsWha9+EzOQFVmB6KzSy9j/Js/Me9uNesNjehlql0FfhO20
 9nzR6xXZPeyWJVwMhEwyuAqsvcz1gMP1E7VflP4KSytn7OAGlsVNjVCalaS/J/VqGIrbsEUqWeN
 OVfEql2jhDxbvb9/Gi38K0Cdj/xe6QxrYajz+tMHqQU0d4ehpr2z8424Zkn/0+eaMbaWYH8Ie22
 fmR3Px8mfskXi8606eIH3hjPkKZ1nFNkQcJ2xP6ukmbo5xOdsKdBj2CHZ7TYQOIIGdqXHQMKfew
 EafI4re3kx/nD4
X-Received: by 2002:a05:600c:628c:b0:4a1:f625:2108 with SMTP id
 5b1f17b1804b1-4bb55a7f8aamr279195205e9.33.1794930871226; 
 Tue, 17 Nov 2026 07:54:31 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4bb732a2a9csm131403045e9.3.2026.11.17.07.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 07:54:30 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 1/1] Update maintainers and get_maintainer.ignore
Date: Tue, 17 Nov 2026 15:54:19 +0000
Message-ID: <20261117155426.2069931-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261117155426.2069931-1-pbrobinson@gmail.com>
References: <20261117155426.2069931-1-pbrobinson@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the departure of Simon update the MAINTAINERS file
to reflect the current situation of various subsystems.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v3:
- Drop board maintainers change due to CI triggers
v2:
- Update board maintainers
- Use get_maintainer ignore file

 .get_maintainer.ignore |  4 +++-
 .mailmap               |  1 -
 MAINTAINERS            | 46 +++++++++++++-----------------------------
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index 899a1469b2a..76b816a4d56 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1 +1,3 @@
-"Pali Rohár" <pali@kernel.org>
+Pali Rohár <pali@kernel.org>
+Simon Glass <simon.glass@canonical.com>
+Simon Glass <sjg@chromium.org>
diff --git a/.mailmap b/.mailmap
index dffeed3238d..2a073e26767 100644
--- a/.mailmap
+++ b/.mailmap
@@ -147,7 +147,6 @@ Sean Anderson <sean.anderson@linux.dev> <sean.anderson@seco.com>
 Shaohui Xie <Shaohui.Xie@freescale.com>
 Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <shubhrajyoti.datta@xilinx.com>
-Simon Glass <sjg@chromium.org> <simon.glass@canonical.com>
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <siva.durga.paladugu@xilinx.com>
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <sivadur@xilinx.com>
 Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 3b38ffee288..4e96287a727 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -63,8 +63,7 @@ F:	net/9p/
 F:	test/py/tests/test_9p.py
 
 ACPI
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/emulation/configs/acpi.config
 F:	cmd/acpi.c
 F:	include/acpi/
@@ -77,8 +76,7 @@ S:	Maintained
 F:	drivers/net/phy/airoha/
 
 ALIST
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	include/alist.h
 F:	lib/alist.c
 F:	test/lib/alist.c
@@ -820,7 +818,6 @@ S:	Maintained
 F:	drivers/spi/spi-aspeed-smc.c
 
 BINMAN
-M:	Simon Glass <sjg@chromium.org>
 M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	doc/develop/binman_tests.rst
@@ -836,8 +833,7 @@ F:	include/blkmap.h
 F:	test/dm/blkmap.c
 
 BOOTSTD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	boot/bootdev*.c
 F:	boot/bootflow.c
 F:	boot/bootmeth*.c
@@ -871,8 +867,7 @@ F:	fs/btrfs/
 F:	include/btrfs.h
 
 BUILDMAN
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	tools/buildman/
 
 CAAM
@@ -902,7 +897,6 @@ F:	drivers/clk/
 F:	drivers/clk/imx/
 
 CPU
-M:	Simon Glass <sjg@chromium.org>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 S:	Maintained
 F:	cmd/cpu.c
@@ -940,15 +934,13 @@ F:	include/linux/usb/ch9.h
 F:	include/linux/usb/gadget.h
 
 DRIVER MODEL
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	drivers/core/
 F:	include/dm/
 F:	test/dm/
 
 EFI CLIENT
-M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
 W:	https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html
@@ -1006,8 +998,7 @@ F:	tools/env*
 F:	tools/mkenvimage.c
 
 ENVIRONMENT AS TEXT
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	doc/usage/environment.rst
 F:	scripts/env2string.awk
 
@@ -1021,8 +1012,7 @@ F:	include/erofs.h
 F:	test/py/tests/test_fs/test_erofs.py
 
 EVENTS
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	cmd/event.c
 F:	common/event.c
 F:	include/event.h
@@ -1066,8 +1056,7 @@ F:	include/fpga.h
 F:	test/dm/fpga.c
 
 FLATTENED DEVICE TREE
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
 F:	lib/fdtdec*
 F:	lib/libfdt/
@@ -1170,8 +1159,7 @@ F:	doc/kwboot.1
 F:	tools/kwb*
 
 LOGGING
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	common/log*
 F:	cmd/log.c
@@ -1208,8 +1196,7 @@ S:	Maintained
 F:	lib/mbedtls/
 
 MEMBUF
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	include/membuf.h
 F:	lib/membuf.c
@@ -1399,8 +1386,7 @@ F:	configs/o4-imx6ull-nano_defconfig
 F:	include/configs/o4-imx6ull-nano.h
 
 PATMAN
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	tools/patman/
 
 PCI
@@ -1568,8 +1554,7 @@ F:	cmd/rockusb.c
 F:	doc/README.rockusb
 
 SANDBOX
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/sandbox/
 F:	configs/sandbox*
 F:	drivers/*/*sandbox*.c
@@ -1823,8 +1808,7 @@ F:	common/spl/spl_ufs.c
 F:	drivers/ufs/
 
 UPL
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
@@ -1872,8 +1856,7 @@ S:	Maintained
 F:	test/lib/uuid.c
 
 VBE
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	boot/vbe*
 F:	include/vbe.h
 
@@ -1902,7 +1885,6 @@ F:	drivers/watchdog/
 F:	include/watchdog*.h
 
 X86
-M:	Simon Glass <sjg@chromium.org>
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-x86.git
-- 
2.56.1

