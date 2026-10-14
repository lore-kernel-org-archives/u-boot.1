Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755F0CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 12:25:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CC076083A;
	Wed, 14 Oct 2026 12:25:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ygW0aLA0Gf-N; Wed, 14 Oct 2026 12:25:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2F8A3607AD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791980703;
	b=ariZcQHzdLaF2v2r3/SXUTyOJhNdDHqLCObTsA2uBFCeXWIODemDEvBG0EEvJ6GCnUpT
	 OMIYdDBk5erYrSeFzyBa2EIDIqiYxXRKDpC8b4sDsD9Tvk9yCQ7GirXyxCvYQv0x/AtuB
	 bC6+f+85dkuc0fmIy0O0umQPnu0/kTqStJqAre2/RbIO8lV7mKk0uYEkVwqCwsFFksU3b
	 I6JVFZ6sjbxVFS2b0pdk0dKcAuibwdSVgkVZgiQZPavZ+YxCXa2w4xVNq8RoqAIECY9GC
	 9SIlD2ug8U3k41enWfHIjQbNM7H7LW5siH7veDr4hefc6j5gMvljDIvPhKFyvbJQ5IA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791980703;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=L0hIi0/TVYcNE89uDV281LuxWKaE3EkKI4JlGqsuZBU=;
	b=tb2x7pO8VfYF4IQYboExv3dMOyn9d2oxVSSOmTEUvuc9QVbYjlQjENevmumiLStuu5gB
	 FiFHEGQpQt5C+CtIz8W18w8jSKMsXcIRJ972M+m49X3jvvt4ldeiVrVx4Dpqch2xzcfb9
	 d2fWsK8JbYY84UHWfZnalHjA6rB87QestILPE1e1GFio3YJn55FNNLgr6+B7094hLX1ef
	 qj7tTb8FmRgNlzgWhngwxxs6IdkkaKLuLl0dVTEux9RDrIzJ2fXrZK8Nm9qSqoKZ24US+
	 FOTzaxEWLFWxvveoeq7qeT9XJ8vzznoYa0Qcr1ROq52xi9HQWb60eNcOUwPd7DaGs6A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791980703;
	bh=L0hIi0/TVYcNE89uDV281LuxWKaE3EkKI4JlGqsuZBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cd8X3PBBfJggDypaztfq/jzbo/N6TxccKP36eeXmd+tf1N6aCjQUIA/zE2VOUJ9rT
	 sEW8S5CpKmNDsdtLpImaezqnXZocXywKGYG3lbE1Uh3fLSKx05X88BTx76mD2zPAAt
	 OJrRE8T+Ujp1Yyn3UGHLx0mQYXQWX6jXLa+lWP1gpS1y7Ma7WHVHGx5w1/pXJ3mBnx
	 6nAjyKjYF+fpIa09SVjTwKvruaxgo4fQEG9dUHD5tDYnu/u811TxxdqDAZZKjhP0WM
	 4J3ZCzcjcq/ucEQG32gM6nbn8Qd1hALhHjOxsn/efxWh1gBYOWD4ZLYzqP6H8wLgm7
	 ztjvOWi3b1gGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F8A3607AD;
	Wed, 14 Oct 2026 12:25:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2F8272A8
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 21293406AF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LGBUImJoTnvu for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 12:24:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30012406C5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791980697;
 b=chktHhHkQ34sF8p9ld5/gNbbOTPr9ByjYzW+8EAx74T3QgE8TIzP9PVmr2L94DpF622g
 71vUqD9Wzyo9imXw8UM1z6qxHTbejDoFezIQHpLL6CoYjsMmvaRAC3qxMSfXlRVdNhwTr
 Fgiq+Qmv3s05P0uuOUTV8mrJGCTwnzjkoZDdYOoD/L3o/hxX5BXksTcareVcIkM7quuJZ
 jwa51nOeuA+EwmtaK/tBwpPEbLoOnK2YDs7KLuTwayehQNM+Yc2kbJ0ADiGqUjAgxI6SL
 h2NQq+bwPINfOuNegFVytbxk4AY1mJoE+P0i1jUidHIBcnI4EMqG6aQj/2yqMn5SBeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791980697;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer;
 bh=L0hIi0/TVYcNE89uDV281LuxWKaE3EkKI4JlGqsuZBU=;
 b=Tg43ots6h90LIQJGx3KtIIKI9gAIbkGwohLrKfWz0ysRu1vTVe+CEIaEZuqje55h6TSJ
 L2i9ZbhmuN/fMrx3tLx/MCcSUH1lSL935rwL0qjWS8CqDnJiqspoYcCjEcyHdv6Xj10Ja
 dNe2EFGAt2ZH9WMDuRYC6O6XMpDfqM3VkOdLJTwCJyr5RzivBYkvGS0EEIST0wJp2jPI/
 IT9tum2BcFNLAF4ilN7F4bPZ5jMROu+dl+UzghZOYGvQds73zec9v6OkVn7quZFqB26Oi
 3cKyLazBsS3HvpSQVdARNgwMvGenN/s0jI2T42rA8GQVCI3nxoqVTDYjIDEl/Q2/yeQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bdJfLHH5; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::336; helo=mail-wm1-x336.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bdJfLHH5
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30012406C5
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 12:24:56 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso29399805e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791980695; x=1792585495;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L0hIi0/TVYcNE89uDV281LuxWKaE3EkKI4JlGqsuZBU=;
 b=bdJfLHH5rhGQ6cW+s+S1MXPC23qOQZO8PhZ1B2WxQJol+lcyXpRLmECYkMSSGcp6ob
 Wgu/JarasiKP1hs0hOkFKav4AnoYl80Yl7lCvRdXBqTvznz5MapNJU9zSS7mDg2cOudK
 vfARZhoZRj3vgMNIoPjOAs+fRDNGPjk9km7Yp4+l24GTDUEROdiKT+bLDts6Or/Kcs+Q
 tQAkSLmhztQjRaYwK65d4McUnHLDR4JLqXKMpvBXuR7jXMyXSZMGPRsIf382odluIBH9
 lou6u6RNRW4FOtzYYeuNRCtVD36fqYfqIzAt7t+DLr6Ptk8dbpw4+8DlpYQ5UHBb5jHL
 uPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791980695; x=1792585495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L0hIi0/TVYcNE89uDV281LuxWKaE3EkKI4JlGqsuZBU=;
 b=1GBo0G8xmTL32r97MxSvb9Xl76InOwej3ZzeQDLbIVQdqM6vKsXrynC+yfRHAS9IFT
 UW7RErRX4Mur+f/CKHRXTK/BuZoftTWrwRETUBOIaSbDUN3xCV8Gsr5+FmW5J+DM5JQJ
 sqpjVpmAoUOvr6/pRn3WLZkM9Lw7/3Eq5dUoxRqviXHEdCBiR28uevrr7Y9E4JfpIp/7
 kHP4EMbo7Vyoh4hTkax4N5nbwLvP5yr9/XD2zQvl3F5N9hKACR02x8ZsKtSf2GYnu3XC
 PRPIEUI7TKyJ7nLam/3Isho90nsjCM+BG4anxgjQnYvg9nvSgKQqOEpfw4bIKCVccXE8
 l5BA==
X-Gm-Message-State: AFq9FYIni5nP4f8XiOS8P+uoBUhM9bq9sdx52+YTPWe4BJk+cZ/fhYvv
 Bmd8PihU9TX3Tl82it4sDg+9Z+IPt51ZRDaLY+kuC44UoFdAN7Vq/B67ZRTDSMh204M=
X-Gm-Gg: AYBFou0RgHdf0ItPIjmWIrATAd+YALnzLRuybDVYyjfz2kwBBSQMxzHKqDljPjSSciM
 mTfFRuG8ndYMD8Lef7N6b7MoonFuvoCtF/86M0v7uZuHecrhdJIIqxWpASmVLuWHBKTSKO3xa4M
 vMRR39txsW1Psik/SorZw6fKjlntTi99J4iyMJODcvQMXipDIIyVRCs1lN/zX/kAt6W2tM2kOf9
 Op0T/7G96Du97v0OLvVnkzzy+y/TN4ixO1gVsMaZ56tstLTx7ekO6vWOUkuHYaCmjVyNsF7xGVc
 sPk4qXhooGyFpCjFvwfEr9q7G1rcXnCvEFbUSO5wHQuWvUzUyimLCFbEvM7d7mluI4hsP1LPuzB
 BTVMYVnnt5kt3Be+te9IAp0hrexX9DvtBtCGQpu+/kFV9PWtTcVrsPcUXqu9OSpeThkGICZCVru
 ubLyLbZhZIvCSM/eKKDSOmPYHKsBIGTcFLei72cYRoKXojNSV4ITuc3z76SLFxJu7PeuXzBcuY1
 O/zpjerRIm9x07LLbXN/48/Jk5A+I4rELnUuurJuYJVGHc3cUg4OjoENRcDWPiX6RPx0UWgrRn8
 EH3cD513w69y4bE=
X-Received: by 2002:a05:600c:6215:b0:4a0:eae0:b30e with SMTP id
 5b1f17b1804b1-4a18e4ca157mr279865835e9.22.1791980694289; 
 Wed, 14 Oct 2026 05:24:54 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-82-63-151-127.business.telecomitalia.it. [82.63.151.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b2fc4724sm50351815e9.2.2026.10.14.05.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:24:53 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 14 Oct 2026 14:24:32 +0200
Subject: [PATCH 4/6] spl: support booting FIT images downloaded with fastboot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ccaione-upstream-spl-fastboot-boot-v1-4-d29df15fb9b8@baylibre.com>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
In-Reply-To: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.16.0
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

Test farms need to run successive U-Boot builds without rewriting boot
storage. Add an optional RAM boot path for FIT images, including firmware
needed to enter U-Boot.

Accept the Android v0 envelope used by the standard fastboot client so
the same fastboot boot u-boot.itb workflow can be used with SPL.

Do not boot after a failed USB acknowledgment, in SPL or U-Boot proper,
so the host can retry the command.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                     |   2 +
 common/spl/Makefile             |   1 +
 common/spl/spl_fastboot_boot.c  |  76 +++++++++++++++++
 configs/sandbox_spl_defconfig   |   1 +
 doc/android/fastboot.rst        |  45 +++++++++-
 drivers/fastboot/Kconfig        |  15 ++++
 drivers/fastboot/fb_command.c   |  29 +++++++
 drivers/usb/gadget/f_fastboot.c |   9 +-
 include/fastboot.h              |   8 ++
 include/spl.h                   |   7 ++
 test/image/Makefile             |   1 +
 test/image/spl_fastboot.c       | 183 ++++++++++++++++++++++++++++++++++++++++
 12 files changed, 374 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f464e0bd2bc..d62e04907c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1038,6 +1038,8 @@ M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
 F:	cmd/fastboot.c
+F:	common/spl/spl_fastboot_boot.c
+F:	test/image/spl_fastboot.c
 F:	doc/android/fastboot*.rst
 F:	include/fastboot.h
 F:	include/fastboot-internal.h
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 9c94e8f143e..710463f2a3b 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_$(PHASE_)DFU) += spl_dfu.o
 obj-$(CONFIG_$(PHASE_)SPI_LOAD) += spl_spi.o
 obj-$(CONFIG_$(PHASE_)RAM_SUPPORT) += spl_ram.o
 obj-$(CONFIG_$(PHASE_)USB_SDP_SUPPORT) += spl_sdp.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_BOOT) += spl_fastboot_boot.o spl_ram.o
 obj-$(CONFIG_$(PHASE_)UFS_SUPPORT) += spl_ufs.o
 endif
 
diff --git a/common/spl/spl_fastboot_boot.c b/common/spl/spl_fastboot_boot.c
new file mode 100644
index 00000000000..f52ea83b230
--- /dev/null
+++ b/common/spl/spl_fastboot_boot.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <android_image.h>
+#include <fastboot.h>
+#include <spl.h>
+#include <linux/log2.h>
+
+struct fastboot_image {
+	const void *data;
+	size_t size;
+};
+
+/* The standard fastboot client wraps a FIT in an Android v0 boot image. */
+static int spl_fastboot_unwrap(struct fastboot_image *image)
+{
+	const struct andr_boot_img_hdr_v0 *hdr = image->data;
+	u32 page_size, kernel_size;
+	size_t hdr_size = offsetof(struct andr_boot_img_hdr_v0,
+				   recovery_dtbo_size);
+
+	if (image->size < ANDR_BOOT_MAGIC_SIZE ||
+	    memcmp(image->data, ANDR_BOOT_MAGIC, ANDR_BOOT_MAGIC_SIZE))
+		return 0;
+
+	if (image->size < hdr_size)
+		return -EINVAL;
+	if (le32_to_cpu(hdr->header_version) || hdr->ramdisk_size ||
+	    hdr->second_size)
+		return -EPROTONOSUPPORT;
+
+	page_size = le32_to_cpu(hdr->page_size);
+	kernel_size = le32_to_cpu(hdr->kernel_size);
+	if (!is_power_of_2(page_size) || page_size < hdr_size ||
+	    page_size > image->size || kernel_size > image->size - page_size)
+		return -EINVAL;
+
+	image->data += page_size;
+	image->size = kernel_size;
+	return 0;
+}
+
+int spl_fastboot_load(struct spl_image_info *spl_image)
+{
+	struct fastboot_image image;
+	void *buf;
+	int ret;
+
+	image.size = fastboot_get_boot_image(&buf);
+	image.data = buf;
+	if (!image.size)
+		return -EAGAIN;
+
+	ret = spl_fastboot_unwrap(&image);
+	if (ret)
+		return ret;
+	return spl_ram_load_fit(spl_image, (void *)image.data, image.size);
+}
+
+/* Sandbox tests the loader directly, without a physical USB boot method. */
+#if !IS_ENABLED(CONFIG_SANDBOX)
+static int spl_fastboot_load_image(struct spl_image_info *spl_image,
+				   struct spl_boot_device *bootdev)
+{
+	int ret;
+
+	ret = fastboot_usb_run(CONFIG_SPL_FASTBOOT_USB_DEV, NULL, 0);
+	if (ret)
+		return ret;
+
+	return spl_fastboot_load(spl_image);
+}
+
+SPL_LOAD_IMAGE_METHOD("USB fastboot", 0, BOOT_DEVICE_BOARD,
+		      spl_fastboot_load_image);
+#endif
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index b1112fd45e7..67640c7d85d 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -217,6 +217,7 @@ CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_USB_GADGET=y
 CONFIG_SPL_USB_GADGET=y
 CONFIG_SPL_FASTBOOT=y
+CONFIG_SPL_FASTBOOT_BOOT=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 8e15f287f9b..9898348c961 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -96,7 +96,7 @@ stub. The ``continue`` command ends the session and returns control to the
 caller. The ``flash`` and ``erase`` commands are available when their SPL
 backend is enabled. A recognized command whose optional backend is disabled is
 reported as unsupported. Commands omitted from the SPL table, including
-``boot``, ``ucmd``, ``acmd`` and the OEM commands, are reported as unrecognized.
+``ucmd``, ``acmd`` and the OEM commands, are reported as unrecognized.
 
 MMC flash and erase support is enabled with
 ``CONFIG_SPL_FASTBOOT_FLASH_MMC``. The SPL partition-table parser matching the
@@ -120,6 +120,49 @@ Reboot commands require ``CONFIG_SPL_FASTBOOT_REBOOT`` and a platform
 and ``reboot-recovery`` commands also require a platform
 ``fastboot_set_reboot_flag()`` implementation.
 
+Booting a downloaded FIT from SPL
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Enable ``CONFIG_SPL_FASTBOOT_BOOT`` and include ``BOOT_DEVICE_BOARD`` in the
+board's SPL boot order. This load method starts the fastboot session itself;
+select the USB controller with ``CONFIG_SPL_FASTBOOT_USB_DEV``. RAM and the
+USB controller must be ready before the load method runs.
+
+The host can then download and run a U-Boot FIT without flashing it::
+
+   fastboot boot u-boot.itb
+
+::
+
+   Host                         Target
+   +----------------+           +-----------------------+
+   | U-Boot FIT     | -- USB -->| SPL fastboot download |
+   +----------------+           +-----------+-----------+
+                                            |
+                                  acknowledge boot,
+                                  stop USB session
+                                            |
+                                +-----------v-----------+
+                                | SPL FIT loader        |
+                                +-----------+-----------+
+                                            |
+                                +-----------v-----------+
+                                | Firmware / U-Boot     |
+                                | running from RAM      |
+                                +-----------------------+
+
+Use a FIT built for the target, including any firmware required by its normal
+SPL handoff (for example BL31 or OP-TEE). FIT verification uses the board's
+existing SPL configuration. Raw U-Boot binaries are not supported. The loader
+accepts a bare FIT or the Android v0 wrapper added by the standard fastboot
+client; separate ramdisk and second-stage arguments are not supported.
+
+Keep the download buffer separate from SPL, its heap and stack, and all FIT
+load destinations. ``CONFIG_SPL_FASTBOOT_FLASH`` is optional.
+
+``continue`` leaves fastboot and lets SPL try the remaining boot methods.
+Loading errors also follow SPL's normal boot order.
+
 Fastboot environment variables
 ------------------------------
 
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 88ed42ca5b9..c2055132ccc 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -67,6 +67,21 @@ config SPL_FASTBOOT
 config SPL_USB_FUNCTION_FASTBOOT
 	bool
 
+config SPL_FASTBOOT_BOOT
+	bool "Boot FIT images downloaded with fastboot in SPL"
+	depends on ARM || MIPS || RISCV || SANDBOX
+	depends on SPL_FASTBOOT && SPL_FRAMEWORK && SPL_LOAD_FIT
+	depends on !SPL_LOAD_FIT_FULL && !SPL_USB_SDP_SUPPORT
+	help
+	  Enable fastboot boot to load a downloaded FIT image through the SPL
+	  image loader. Boards enter the USB session by selecting
+	  BOOT_DEVICE_BOARD in their SPL boot order.
+
+config SPL_FASTBOOT_USB_DEV
+	int "SPL fastboot USB controller number"
+	depends on SPL_FASTBOOT_BOOT
+	default 0
+
 config SPL_FASTBOOT_REBOOT
 	bool "Enable fastboot reboot commands in SPL"
 	depends on SPL_FASTBOOT
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 68983f5098a..cc5862d566f 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -32,9 +32,12 @@ static u32 fastboot_bytes_received;
  */
 static u32 fastboot_bytes_expected;
 
+static bool boot_requested;
+
 static void okay(char *, char *);
 static void getvar(char *, char *);
 static void download(char *, char *);
+static void boot(char *, char *);
 static void flash(char *, char *);
 static void erase(char *, char *);
 static void reboot_bootloader(char *, char *);
@@ -71,6 +74,10 @@ static const struct fastboot_command commands[FASTBOOT_COMMAND_COUNT] = {
 		.command = "erase",
 		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_FLASH, (erase), (NULL))
 	},
+	[FASTBOOT_COMMAND_BOOT] = {
+		.command = "boot",
+		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_BOOT, (boot), (NULL))
+	},
 	[FASTBOOT_COMMAND_CONTINUE] =  {
 		.command = "continue",
 		.dispatch = okay
@@ -277,6 +284,7 @@ void fastboot_download_reset(void)
 	image_size = 0;
 	fastboot_bytes_received = 0;
 	fastboot_bytes_expected = 0;
+	boot_requested = false;
 }
 
 /**
@@ -393,6 +401,27 @@ void fastboot_data_complete(char *response)
 	fastboot_bytes_received = 0;
 }
 
+static void __maybe_unused boot(char *cmd_parameter, char *response)
+{
+	if (!image_size || fastboot_bytes_expected)
+		fastboot_fail("No complete image downloaded", response);
+	else
+		fastboot_okay(NULL, response);
+}
+
+#if CONFIG_IS_ENABLED(FASTBOOT_BOOT)
+void fastboot_boot(void)
+{
+	boot_requested = true;
+}
+
+u32 fastboot_get_boot_image(void **buf)
+{
+	*buf = fastboot_buf_addr;
+	return boot_requested ? image_size : 0;
+}
+#endif
+
 /**
  * flash() - write the downloaded image to the indicated partition.
  *
diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
index 9a2e9850112..cdd88035eed 100644
--- a/drivers/usb/gadget/f_fastboot.c
+++ b/drivers/usb/gadget/f_fastboot.c
@@ -489,9 +489,14 @@ static void do_exit_on_complete(struct usb_ep *ep, struct usb_request *req)
 	g_dnl_trigger_detach();
 }
 
-#ifndef CONFIG_XPL_BUILD
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(FASTBOOT_BOOT)
 static void do_bootm_on_complete(struct usb_ep *ep, struct usb_request *req)
 {
+	req->complete = fastboot_complete;
+	/* Do not boot if the acknowledgment transfer failed. */
+	if (req->status)
+		return;
+
 	fastboot_boot();
 	do_exit_on_complete(ep, req);
 }
@@ -561,7 +566,7 @@ static void rx_handler_command(struct usb_ep *ep, struct usb_request *req)
 	if (!strncmp("OKAY", response, 4)) {
 		switch (cmd) {
 		case FASTBOOT_COMMAND_BOOT:
-#ifndef CONFIG_XPL_BUILD
+#if !defined(CONFIG_XPL_BUILD) || CONFIG_IS_ENABLED(FASTBOOT_BOOT)
 			fastboot_func->in_req->complete = do_bootm_on_complete;
 #endif
 			break;
diff --git a/include/fastboot.h b/include/fastboot.h
index f02d2559f2b..e132b776c7b 100644
--- a/include/fastboot.h
+++ b/include/fastboot.h
@@ -144,9 +144,17 @@ int fastboot_usb_run(int controller_index, void *buf_addr, u32 buf_size);
  *
  * Otherwise execute "bootm <fastboot_buf_addr>", if that fails, reset
  * the board.
+ * In SPL, record the request for loading after the USB session stops.
  */
 void fastboot_boot(void);
 
+/**
+ * fastboot_get_boot_image() - Get the download requested for booting in SPL
+ * @buf: Receives the download buffer address
+ * Return: Image size, or zero if no boot command has completed
+ */
+u32 fastboot_get_boot_image(void **buf);
+
 /**
  * fastboot_handle_boot() - Shared implementation of system reaction to
  * fastboot commands
diff --git a/include/spl.h b/include/spl.h
index f884c24b85e..2b12dbb7215 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -998,6 +998,13 @@ int spl_dfu_cmd(int usbctrl, char *dfu_alt_info, char *interface, char *devstr);
  */
 int spl_ram_load_fit(struct spl_image_info *spl_image, void *fit, size_t size);
 
+/**
+ * spl_fastboot_load() - Load a FIT after the fastboot USB session has stopped
+ * @spl_image: Receives the image's load address and entry point
+ * Return: 0 on success, -EAGAIN if no boot was requested, or another error
+ */
+int spl_fastboot_load(struct spl_image_info *spl_image);
+
 /**
  * spl_mmc_clear_cache() - Clear cached MMC devices
  *
diff --git a/test/image/Makefile b/test/image/Makefile
index feca0611fcf..67d9b97a2d2 100644
--- a/test/image/Makefile
+++ b/test/image/Makefile
@@ -3,6 +3,7 @@
 # Copyright 2021 Google LLC
 
 obj-y += spl_load.o
+obj-$(CONFIG_SPL_FASTBOOT_BOOT) += spl_fastboot.o
 obj-$(CONFIG_SPL_UT_LOAD_FS) += spl_load_fs.o
 obj-$(CONFIG_SPL_UT_LOAD_NAND) += spl_load_nand.o
 obj-$(CONFIG_SPL_UT_LOAD_NET) += spl_load_net.o
diff --git a/test/image/spl_fastboot.c b/test/image/spl_fastboot.c
new file mode 100644
index 00000000000..39dc784e5e6
--- /dev/null
+++ b/test/image/spl_fastboot.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2026 Carlo Caione <ccaione@baylibre.com> */
+
+#include <android_image.h>
+#include <fastboot.h>
+#include <image.h>
+#include <mapmem.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+
+static int run_fastboot_command(struct unit_test_state *uts, const char *command,
+				int expected_cmd, const char *expected_response)
+{
+	char response[FASTBOOT_RESPONSE_LEN];
+	char cmd[FASTBOOT_COMMAND_LEN];
+
+	strlcpy(cmd, command, sizeof(cmd));
+	ut_asserteq(expected_cmd, fastboot_handle_command(cmd, response));
+	ut_asserteq_str(expected_response, response);
+	return 0;
+}
+
+static int download_image(struct unit_test_state *uts, const void *data,
+			  size_t size)
+{
+	char command[FASTBOOT_COMMAND_LEN];
+	char expected[FASTBOOT_RESPONSE_LEN];
+	char response[FASTBOOT_RESPONSE_LEN];
+
+	snprintf(command, sizeof(command), "download:%08x", (uint)size);
+	snprintf(expected, sizeof(expected), "DATA%08x", (uint)size);
+	ut_assertok(run_fastboot_command(uts, command, FASTBOOT_COMMAND_DOWNLOAD, expected));
+	fastboot_data_download(data, size, response);
+	ut_asserteq_str("", response);
+	fastboot_data_complete(response);
+	ut_asserteq_str("OKAY", response);
+	return 0;
+}
+
+static int spl_test_fastboot_state(struct unit_test_state *uts)
+{
+	char buffer[64], data[32] = {}, response[FASTBOOT_RESPONSE_LEN];
+	struct spl_image_info info = {};
+	void *image;
+
+	fastboot_init(buffer, sizeof(buffer));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT,
+					 "FAILNo complete image downloaded"));
+	ut_asserteq(-EAGAIN, spl_fastboot_load(&info));
+	ut_assertok(download_image(uts, data, sizeof(data)));
+	ut_assertok(run_fastboot_command(uts, "continue", FASTBOOT_COMMAND_CONTINUE, "OKAY"));
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT, "OKAY"));
+	/* The request is only made when the USB OKAY has completed. */
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+	fastboot_boot();
+	ut_asserteq(sizeof(data), fastboot_get_boot_image(&image));
+	ut_asserteq_ptr(buffer, image);
+
+	ut_assertok(run_fastboot_command(uts, "download:00000020", FASTBOOT_COMMAND_DOWNLOAD,
+					 "DATA00000020"));
+	fastboot_data_download(data, 16, response);
+	fastboot_data_complete(response);
+	ut_asserteq_str("FAILIncomplete download", response);
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT,
+					 "FAILNo complete image downloaded"));
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+
+	ut_assertok(download_image(uts, data, sizeof(data)));
+	fastboot_boot();
+	fastboot_init(buffer, sizeof(buffer));
+	ut_asserteq(0, fastboot_get_boot_image(&image));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT,
+					 "FAILNo complete image downloaded"));
+	return 0;
+}
+
+SPL_TEST(spl_test_fastboot_state, 0);
+
+static int check_download(struct unit_test_state *uts, void *image, size_t size,
+			  struct spl_image_info *expected, const void *data)
+{
+	struct spl_image_info loaded = {};
+	int ret;
+
+	ut_assertok(download_image(uts, image, size));
+	ut_assertok(run_fastboot_command(uts, "boot", FASTBOOT_COMMAND_BOOT, "OKAY"));
+	fastboot_boot();
+	ret = spl_fastboot_load(&loaded);
+	if (!expected) {
+		ut_assert(ret < 0);
+		return 0;
+	}
+	ut_assertok(ret);
+	ut_assertok(check_image_info(uts, expected, &loaded));
+	ut_asserteq_mem(data, map_sysmem(expected->load_addr, expected->size),
+			expected->size);
+	return 0;
+}
+
+static int check_images(struct unit_test_state *uts, void *image, size_t size,
+			struct spl_image_info *info, const void *data,
+			void *wrapped, enum spl_test_image type)
+{
+	struct andr_boot_img_hdr_v0 *hdr = wrapped;
+	size_t wrapped_size = 2048 + size;
+	u32 magic;
+
+	ut_assertok(check_download(uts, image, size, info, data));
+	/* Truncated FIT metadata and external payloads must both fail. */
+	ut_assertok(check_download(uts, image, sizeof(struct fdt_header) - 1,
+				   NULL, NULL));
+	if (type == FIT_EXTERNAL)
+		ut_assertok(check_download(uts, image, fdt_totalsize(image) - 1,
+					   NULL, NULL));
+	ut_assertok(check_download(uts, image, size - 1, NULL, NULL));
+
+	magic = fdt_magic(image);
+	fdt_set_magic(image, 0);
+	ut_assertok(check_download(uts, image, size, NULL, NULL));
+	fdt_set_magic(image, magic);
+
+	/* The Android envelope is independent of the payload format. */
+	if (type != FIT_INTERNAL)
+		return 0;
+
+	memcpy(hdr->magic, ANDR_BOOT_MAGIC, ANDR_BOOT_MAGIC_SIZE);
+	hdr->page_size = cpu_to_le32(2048);
+	hdr->kernel_size = cpu_to_le32(size);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, info, data));
+	ut_assertok(check_download(uts, wrapped, sizeof(*hdr) - 100, NULL, NULL));
+	ut_assertok(check_download(uts, wrapped, wrapped_size - 1, NULL, NULL));
+	/* Android padding must not make a truncated FIT payload look complete. */
+	hdr->kernel_size = cpu_to_le32(size - 1);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	hdr->kernel_size = cpu_to_le32(size);
+	hdr->header_version = cpu_to_le32(3);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	hdr->header_version = 0;
+	hdr->page_size = cpu_to_le32(2047);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	hdr->page_size = cpu_to_le32(2048);
+	hdr->ramdisk_size = cpu_to_le32(1);
+	ut_assertok(check_download(uts, wrapped, wrapped_size, NULL, NULL));
+	return 0;
+}
+
+static int spl_test_fastboot(struct unit_test_state *uts, const char *name,
+			     enum spl_test_image type)
+{
+	struct spl_image_info info = { .name = name, .size = SPL_TEST_DATA_SIZE };
+	size_t size, offset;
+	void *image, *buffer, *wrapped;
+	int ret = -ENOMEM;
+
+	size = create_image(NULL, type, &info, &offset);
+	ut_assert(size);
+	buffer = malloc(size + 2048);
+	wrapped = calloc(1, size + 2048);
+	if (!buffer || !wrapped)
+		goto out;
+
+	image = wrapped + 2048;
+	generate_data(image + offset, info.size, name);
+	if (create_image(image, type, &info, NULL) != size) {
+		ret = -EINVAL;
+		goto out;
+	}
+	if (type == FIT_INTERNAL)
+		size = fdt_totalsize(image);
+	fastboot_init(buffer, size + 2048);
+	ret = check_images(uts, image, size, &info, image + offset, wrapped, type);
+out:
+	fastboot_init(NULL, 0);
+	free(wrapped);
+	free(buffer);
+	ut_assertok(ret);
+	return 0;
+}
+
+SPL_IMG_TEST(spl_test_fastboot, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_fastboot, FIT_EXTERNAL, 0);

-- 
2.56.0

