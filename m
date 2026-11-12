Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA2606A32A
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ycjJFCCL;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oszUhs68
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D20C140DD6;
	Thu, 12 Nov 2026 11:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_Z3EAbyjjcQ; Thu, 12 Nov 2026 11:58:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39C7A40DC3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794484736;
	b=DJCPEEDGZldtGIWAnx4zf1CmXkox3yRsbk697Q55VChS7e+7aSjw78mTi8gVFXDWshr2
	 4nrCoOQvsu+Sp45pocBld6RDv8/hsqYDppAGu21+dTVnlWzkWGjhy+W8mlBqF0Yj1NlSH
	 OxX3KzlMrGEBNL2MCPHlNlh49ctH5ltLxEOT8RUMjn1/Meh4ulB49NgeowCZ9GqdqVwVU
	 jGxO966q1ka37yn/KqTLMDdSv2DfYFIYdb9osWb57iGpdQBo3MtKegUJxGpUfMd9gXv24
	 D0bxrHMWHgaQU6tRLDuDBMIUzPdTW+cabWBanEyHLzJGuwRta4KmSiy0cJyF6C1Lf0w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794484736;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=neOK8DoHB9aldSEa9fXB2cgsVcr90rc1EX/1ypoUP1U=;
	b=IQyTOGWUk28gOqZkiWkHehpFD5lT6hFMsf9hvqMyYjVk8SPFFjHrKxBeudmAFOkkoKX9
	 B4H5xKPYA3DZLpRFIK7xM4OwsFfi238ZFnYSBS0pCtq57vdUGEouTAiFuQQz4plUXTKNM
	 16nJf2TJmMxHSKrt9jsjyWOQUJkbYecsmnT4fofhwfiG3kFINPYCeUY1RDTzmTb+0cYnx
	 xVb+oMEwZ/CRp9gqv/5wnxjzsnqc2BJBO0SvvensUeVOkt6BA7NULTG4C4ieRglD2NFMg
	 X8HEkoTcFiZBgDqSY8w1+KU4Jjqn0SFHaz2jhSdKbWvVDKRClFOEEOik+c+LXiPRyyA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794484736;
	bh=neOK8DoHB9aldSEa9fXB2cgsVcr90rc1EX/1ypoUP1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ycjJFCCLyN9QU3+Lyz5hoFCajxQVWtPD3ccBbBN394MvoT65BYVtqbbvQgR9tHAyw
	 MmoosaOyGdkBdyi89S/PNVZ334TpZ6lyNUE62ZlXGYKM2BHkKimO5eybOixBs0be7k
	 o36v0Q4c1XVrwf2ZRa9TwiJfXKPSlwIbZr07J8PSezJOXOFtu1UN9xxzpCgGCT/Caf
	 I2hBOiSn2DrX/Adu8ly5Whs/4A2k84mvybNSW+Xru3lLTigw3kn5XaUDGBudTaXrSk
	 UlHTWc8JviKur0vF5uyyK8J9sHLEcUY4+aKdQs2eDUGOjVYnOEL4MUIksgjwtqEqE+
	 kpG9ms4KuE8kQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39C7A40DC3;
	Thu, 12 Nov 2026 11:58:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 92B771790
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 49EB560B67
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3PUnFb1UcNGh for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 11:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 924956067E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=oszUhs68
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 924956067E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 11:58:49 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so28839315e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 03:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794484728; x=1795089528;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=neOK8DoHB9aldSEa9fXB2cgsVcr90rc1EX/1ypoUP1U=;
 b=oszUhs68MnSj/+Tk45HbKisj0V7bDt9D04J4A++Ft4GEoZXGcKToH3kzBVK+MnOsie
 FNpyTV91sLItjLmVws9QXUlOMauSzesACFnktznx+JT1uAU0W0qCMoHy3ZrSE5fovW81
 esbOSy3ARmU1lrxd/MvpB+kMLUgB5gEA30FZMH7SyNZVvxB8CIhPOjpPoMeHwrVdklKr
 ZKst6tZrYKL334qBJT7yUmRTJGWnGMQhT3Bbs228b1tdob00nyOTFoss+2BLDysBUn5H
 +6ozzZxVgAqfli0WhLELbcsXxxdSJmm6ldL8NTPAt6JIGRciafVdiA4ensvYQ81q+ToB
 SDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794484728; x=1795089528;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=neOK8DoHB9aldSEa9fXB2cgsVcr90rc1EX/1ypoUP1U=;
 b=BxIhCXb/+hUiQt9qflgJJ64dyuZlp2HPEhiDMrcNKqsHhJq7GXqrthXt5bXWH2l0iP
 l80bIIncMuHnCxMKoVdiJluadi//aFO4byMQvVccI8DB9D/ggudfDoHLj1ErJ+dLXv9g
 gTNfGuFW7wx9DkwPhMXKChwLZEZVkPRSAqO0JPaSrLCAqw09z9HnIp93DmEWsfa/6Oia
 jqfoaKc7eoR5qmvXzyyIaOcqL9yHcwBgYh6kVSwCyAAakF5aufOi/QNRRyNKX28s+rKP
 7Kor9lfTs9sEWyz+sB00DukGMVa8WArBEMZLfXWaxLtwMZ1WUY+D0hqwheey41QH3fww
 hiXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGK6BuuUELkfu4JV6gFudqchl9gTTnmbDG4oky/7vzBeh1C3t+UDQwqmQoofHvUpxqD2oMGAzg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9At/aOeQBN0WDbCyZjspXELl1lHC+3wyRstHRFu7PwO53srkfM
 yfsPefW+Lb7fGZ8RRcyObPzGAMvBusObjSFV1lccAaf9xRTbSNEfVCMeazqLSQ==
X-Gm-Gg: AYBFou32E72uOP5jPAkQsh02Q+2qSxXWNQRCK2WpZuPHPBP/WXF+Cyq71QEw+0a019P
 ntCA5gn+Pi9voQqmTFKX3J09C/hJUbl2qMVhcKgIHsytPG8biIPEpRnoM3576utqeNaio0Yjsmt
 23NF8Trp0X1a6Ab0DtBLUrC77pJmVb3KDniQzBQkeAB9SiAhEVsBsSRGFbzBaslW5Gea/rbeW3s
 ir1pLBYIC9YwmdRKlFHM3HcAe2Y7Z5Zu3UCGd02OrcQKu5gUuEhsBugufop5MQkup/sQ28eMUQb
 4jfzKIy3lKnzdeZ41gtMj0xM35JJ1ZwiStgM/18tniqWUsR/0ltCFA6B02xWGQmV90aA+zFKIMA
 Z5iyqnWmUyCV5v+te9oTrmZBFmezm6jhDAgn9P5a3uSbmqHX6Qs5mvKOSo4xIyRhrxhgs9I1t//
 ybhPR38lE8bXBTmLKLBv1BUfBIIwxfr0tVXOHM8rIu3uiZuKcBzL0sRJq6TOLSiZlWFFFybNqi4
 EGeDfCELbiqHMeFj8Q3V17u2tbK46p5a6QTfdlzVEBMU2S6t4hjjL3L6XKb09ht0rfjDk6uhuVL
 UfrlKPDKk6DwenYMouhpZd4FiIyRpGlGeFeX315gB6jtfS64nP/ceVkvHsYdCZjAdAF8p2zES2+
 6WluYUjA7PFSuSasfhY0s/bcPeDqe4v6FXIxnABmfRpfbp2JVmJKwT/xEqgKebXU6cN/QA9rqbk
 /e+VC7S8los++dG1PjT2/6XOhRz2rxJRAUCA==
X-Received: by 2002:a05:600c:620c:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4ba093a9e10mr96873865e9.12.1794484727675; 
 Thu, 12 Nov 2026 03:58:47 -0800 (PST)
Received: from cypher.home.roving-it.com
 ([2001:8b0:fb11:0:3889:86e0:d449:e2e1])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4ba08de826asm90878885e9.0.2026.11.12.03.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 03:58:47 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v2 1/1] Update maintainers and get_maintainer.ignore
Date: Thu, 12 Nov 2026 11:58:37 +0000
Message-ID: <20261112115842.39126-2-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261112115842.39126-1-pbrobinson@gmail.com>
References: <20261112115842.39126-1-pbrobinson@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the departure of Simon update the MAINTAINERS file
to reflect the current situation of various subsystems.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---

v2:
- Update board maintainers
- Use get_maintainer ignore file

 .get_maintainer.ignore                     |  4 +-
 .mailmap                                   |  1 -
 MAINTAINERS                                | 46 +++++++---------------
 board/bluewater/gurnard/MAINTAINERS        |  3 +-
 board/coreboot/coreboot/MAINTAINERS        |  6 +--
 board/efi/efi-x86_app/MAINTAINERS          |  6 +--
 board/firefly/firefly-rk3288/MAINTAINERS   |  3 +-
 board/google/chromebook_coral/MAINTAINERS  |  3 +-
 board/google/chromebook_link/MAINTAINERS   |  6 +--
 board/google/chromebook_samus/MAINTAINERS  |  6 +--
 board/google/chromebox_panther/MAINTAINERS |  3 +-
 board/google/gru/MAINTAINERS               |  4 +-
 board/google/veyron/MAINTAINERS            | 15 +++----
 board/intel/minnowmax/MAINTAINERS          |  3 +-
 board/radxa/rock2/MAINTAINERS              |  3 +-
 board/samsung/smdk5250/MAINTAINERS         |  3 +-
 board/sandbox/MAINTAINERS                  | 16 +++-----
 17 files changed, 43 insertions(+), 88 deletions(-)

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
index 9fc6614e519..e2ec3070d14 100644
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
@@ -870,8 +866,7 @@ F:	fs/btrfs/
 F:	include/btrfs.h
 
 BUILDMAN
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	tools/buildman/
 
 CAAM
@@ -901,7 +896,6 @@ F:	drivers/clk/
 F:	drivers/clk/imx/
 
 CPU
-M:	Simon Glass <sjg@chromium.org>
 M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 S:	Maintained
 F:	cmd/cpu.c
@@ -939,15 +933,13 @@ F:	include/linux/usb/ch9.h
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
@@ -1005,8 +997,7 @@ F:	tools/env*
 F:	tools/mkenvimage.c
 
 ENVIRONMENT AS TEXT
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	doc/usage/environment.rst
 F:	scripts/env2string.awk
 
@@ -1020,8 +1011,7 @@ F:	include/erofs.h
 F:	test/py/tests/test_fs/test_erofs.py
 
 EVENTS
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	cmd/event.c
 F:	common/event.c
 F:	include/event.h
@@ -1065,8 +1055,7 @@ F:	include/fpga.h
 F:	test/dm/fpga.c
 
 FLATTENED DEVICE TREE
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
 F:	lib/fdtdec*
 F:	lib/libfdt/
@@ -1169,8 +1158,7 @@ F:	doc/kwboot.1
 F:	tools/kwb*
 
 LOGGING
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	common/log*
 F:	cmd/log.c
@@ -1207,8 +1195,7 @@ S:	Maintained
 F:	lib/mbedtls/
 
 MEMBUF
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/u-boot.git
 F:	include/membuf.h
 F:	lib/membuf.c
@@ -1398,8 +1385,7 @@ F:	configs/o4-imx6ull-nano_defconfig
 F:	include/configs/o4-imx6ull-nano.h
 
 PATMAN
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	tools/patman/
 
 PCI
@@ -1567,8 +1553,7 @@ F:	cmd/rockusb.c
 F:	doc/README.rockusb
 
 SANDBOX
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/sandbox/
 F:	configs/sandbox*
 F:	drivers/*/*sandbox*.c
@@ -1821,8 +1806,7 @@ F:	common/spl/spl_ufs.c
 F:	drivers/ufs/
 
 UPL
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
 F:	boot/upl*
 F:	cmd/upl.c
@@ -1870,8 +1854,7 @@ S:	Maintained
 F:	test/lib/uuid.c
 
 VBE
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	boot/vbe*
 F:	include/vbe.h
 
@@ -1900,7 +1883,6 @@ F:	drivers/watchdog/
 F:	include/watchdog*.h
 
 X86
-M:	Simon Glass <sjg@chromium.org>
 M:	Bin Meng <bmeng.cn@gmail.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-x86.git
diff --git a/board/bluewater/gurnard/MAINTAINERS b/board/bluewater/gurnard/MAINTAINERS
index 5e546d43fb4..e9b4a25ea14 100644
--- a/board/bluewater/gurnard/MAINTAINERS
+++ b/board/bluewater/gurnard/MAINTAINERS
@@ -1,6 +1,5 @@
 GURNARD BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/bluewater/gurnard/
 F:	include/configs/snapper9g45.h
 F:	configs/gurnard_defconfig
diff --git a/board/coreboot/coreboot/MAINTAINERS b/board/coreboot/coreboot/MAINTAINERS
index 5166e7a762d..aee083b65f8 100644
--- a/board/coreboot/coreboot/MAINTAINERS
+++ b/board/coreboot/coreboot/MAINTAINERS
@@ -1,12 +1,10 @@
 COREBOOT BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/coreboot/
 F:	configs/coreboot_defconfig
 
 COREBOOT64 BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	configs/coreboot64_defconfig
 
 COREBOOT64 NO SPL
diff --git a/board/efi/efi-x86_app/MAINTAINERS b/board/efi/efi-x86_app/MAINTAINERS
index 693f367311b..2cb312bf830 100644
--- a/board/efi/efi-x86_app/MAINTAINERS
+++ b/board/efi/efi-x86_app/MAINTAINERS
@@ -1,13 +1,11 @@
 EFI-X86_APP32 BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/efi/Kconfig
 F:	board/efi/efi-x86_app/
 F:	configs/efi-x86_app32_defconfig
 
 EFI-X86_APP64 BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/efi/Kconfig
 F:	board/efi/efi-x86_app/
 F:	configs/efi-x86_app64_defconfig
diff --git a/board/firefly/firefly-rk3288/MAINTAINERS b/board/firefly/firefly-rk3288/MAINTAINERS
index 174027e770b..ed0f92f6496 100644
--- a/board/firefly/firefly-rk3288/MAINTAINERS
+++ b/board/firefly/firefly-rk3288/MAINTAINERS
@@ -1,6 +1,5 @@
 FIREFLY
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-firefly-u-boot.dtsi
 F:	board/firefly/firefly-rk3288
 F:	include/configs/firefly-rk3288.h
diff --git a/board/google/chromebook_coral/MAINTAINERS b/board/google/chromebook_coral/MAINTAINERS
index 904227e2e21..ec96bce1c2d 100644
--- a/board/google/chromebook_coral/MAINTAINERS
+++ b/board/google/chromebook_coral/MAINTAINERS
@@ -1,6 +1,5 @@
 CHROMEBOOK_CORAL_BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/chromebook_coral/
 F:	include/configs/chromebook_coral.h
 F:	configs/chromebook_coral_defconfig
diff --git a/board/google/chromebook_link/MAINTAINERS b/board/google/chromebook_link/MAINTAINERS
index e7aef53390c..326fa4bb9a9 100644
--- a/board/google/chromebook_link/MAINTAINERS
+++ b/board/google/chromebook_link/MAINTAINERS
@@ -1,13 +1,11 @@
 CHROMEBOOK LINK BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/chromebook_link/
 F:	include/configs/chromebook_link.h
 F:	configs/chromebook_link_defconfig
 
 CHROMEBOOK LINK 64-bit BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/chromebook_link/
 F:	include/configs/chromebook_link.h
 F:	configs/chromebook_link64_defconfig
diff --git a/board/google/chromebook_samus/MAINTAINERS b/board/google/chromebook_samus/MAINTAINERS
index ca4b16500af..0c7f3d56a01 100644
--- a/board/google/chromebook_samus/MAINTAINERS
+++ b/board/google/chromebook_samus/MAINTAINERS
@@ -1,13 +1,11 @@
 CHROMEBOOK SAMUS BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/chromebook_samus/
 F:	include/configs/chromebook_samus.h
 F:	configs/chromebook_samus_defconfig
 
 CHROMEBOOK SAMUS TPL BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/chromebook_samus/
 F:	include/configs/chromebook_samus.h
 F:	configs/chromebook_samus_tpl_defconfig
diff --git a/board/google/chromebox_panther/MAINTAINERS b/board/google/chromebox_panther/MAINTAINERS
index 4963a895bba..1e3c8274bcc 100644
--- a/board/google/chromebox_panther/MAINTAINERS
+++ b/board/google/chromebox_panther/MAINTAINERS
@@ -1,6 +1,5 @@
 CHROMEBOX PANTHER BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/chromebox_panther/
 F:	include/configs/chromebox_panther.h
 F:	configs/chromebox_panther_defconfig
diff --git a/board/google/gru/MAINTAINERS b/board/google/gru/MAINTAINERS
index 53257c52a04..ade97a7bb6d 100644
--- a/board/google/gru/MAINTAINERS
+++ b/board/google/gru/MAINTAINERS
@@ -1,12 +1,10 @@
 CHROMEBOOK BOB BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/google/gru/
 F:	include/configs/gru.h
 F:	configs/chromebook_bob_defconfig
 
 CHROMEBOOK KEVIN BOARD
-M:	Simon Glass <sjg@chromium.org>
 M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	board/google/gru/
diff --git a/board/google/veyron/MAINTAINERS b/board/google/veyron/MAINTAINERS
index 382ad212569..d648e5e0e63 100644
--- a/board/google/veyron/MAINTAINERS
+++ b/board/google/veyron/MAINTAINERS
@@ -1,36 +1,31 @@
 CHROMEBOOK JERRY BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-veyron-jerry-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
 F:	configs/chromebook_jerry_defconfig
 
 CHROMEBIT MICKEY BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-veyron-mickey-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
 F:	configs/chromebit_mickey_defconfig
 
 CHROMEBOOK MINNIE BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-veyron-minnie-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
 F:	configs/chromebook_minnie_defconfig
 
 CHROMEBOOK SPEEDY BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-veyron-speedy-u-boot.dtsi
 F:	board/google/veyron/
 F:	include/configs/veyron.h
 F:	configs/chromebook_speedy_defconfig
 
 CHROMEBOOK VEYRON COMMON FILES
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-veyron-u-boot.dtsi
diff --git a/board/intel/minnowmax/MAINTAINERS b/board/intel/minnowmax/MAINTAINERS
index 5cb94b0f36c..e40b6137465 100644
--- a/board/intel/minnowmax/MAINTAINERS
+++ b/board/intel/minnowmax/MAINTAINERS
@@ -1,5 +1,4 @@
 CircuitCo Minnowboard Max
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/intel/minnowmax
 F:	configs/minnowmax_defconfig
diff --git a/board/radxa/rock2/MAINTAINERS b/board/radxa/rock2/MAINTAINERS
index af974c98304..3251d19c798 100644
--- a/board/radxa/rock2/MAINTAINERS
+++ b/board/radxa/rock2/MAINTAINERS
@@ -1,6 +1,5 @@
 FIREFLY
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	arch/arm/dts/rk3288-rock2*
 F:	board/radxa/rock2
 F:	include/configs/rock2.h
diff --git a/board/samsung/smdk5250/MAINTAINERS b/board/samsung/smdk5250/MAINTAINERS
index c60b6f81e9b..f7bcac83769 100644
--- a/board/samsung/smdk5250/MAINTAINERS
+++ b/board/samsung/smdk5250/MAINTAINERS
@@ -12,7 +12,6 @@ F:	include/configs/snow.h
 F:	configs/snow_defconfig
 
 SPRING BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	include/configs/spring.h
 F:	configs/spring_defconfig
diff --git a/board/sandbox/MAINTAINERS b/board/sandbox/MAINTAINERS
index 9f5073bf287..fdb16e9083a 100644
--- a/board/sandbox/MAINTAINERS
+++ b/board/sandbox/MAINTAINERS
@@ -1,12 +1,10 @@
 SANDBOX BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/sandbox/
 F:	include/configs/sandbox.h
 F:	configs/sandbox_defconfig
 
 SANDBOX64 BOARD
-M:	Simon Glass <sjg@chromium.org>
 M:	Mario Six <mario.six@gdsys.cc>
 S:	Maintained
 F:	board/sandbox/
@@ -14,29 +12,25 @@ F:	include/configs/sandbox.h
 F:	configs/sandbox64_defconfig
 
 SANDBOX SPL BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/sandbox/
 F:	include/configs/sandbox_spl.h
 F:	configs/sandbox_spl_defconfig
 
 SANDBOX NOINST BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/sandbox/
 F:	include/configs/sandbox_spl.h
 F:	configs/sandbox_noinst_defconfig
 
 SANDBOX FLAT TREE BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/sandbox/
 F:	include/configs/sandbox.h
 F:	configs/sandbox_flattree_defconfig
 
 SANDBOX VPL BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
+S:	Orphan
 F:	board/sandbox/
 F:	include/configs/sandbox_spl.h
 F:	configs/sandbox_vpl_defconfig
-- 
2.56.1

