Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD951606A326
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SO8Hjhux;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tdwyK0SS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89EB181497;
	Wed, 11 Nov 2026 13:14:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yJfsDfhpO-SV; Wed, 11 Nov 2026 13:14:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E83A81328
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794402875;
	b=BF5XSQTQXGNVQ08zH7J5G/3hKYa4sNOEfZR1Kx6fgLc+LxvgAzcDoDTFITZB/tscASCU
	 69/ORGhDi0Jk897cb9itD3KG1+D8PxXftv2LmxbNnvm/XHZVJPyDk5+xhNIuLcg6Dcv/i
	 0FfvaUfgM1soPYDO15UvA5Ba+2txr4HfQteP82HY5bc2lwV8ySmcU1XR7NwBnk/Z61hvc
	 tjaLxbEgjdqqYrVLYS9XLnBxo6hcy0FYc4p64/lygmHIkvX82/xe9sIBycobzoEJRBaOB
	 cWXgQrb0Li3nF8sK+TLUvBp2hV9uqFMVF7XMuClGl8sCR45vvjEPSRmn6b+JM/FLb/A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794402875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WHemzBA83ADOl88Tghjtf7gAjr8/hBG69yf83Dx22pM=;
	b=MRRWZIFPY7Qqscwn7CQUGZqjhbH4lA5iJiah/QB+QnhgwK47n5n78iI/nKPzFO14A6A4
	 P7MBAGONWMjCa5/VLIuuAri/zZtUT+Avp3v6ahVBubtG9KEAFLaRHS3SGbPxPR0h/iklu
	 DJcGr+vSDahaMKCTm4Tgq41ZLi4vB7wOXmX3rz4YAQelGhKb9f8PtqgsTlfuWStNPQiWB
	 VYfILbr7QGiuFR6gpzqkqpBtIPme0hSFKv34n9yLqcvhsvtlmPue81g8QmUUPjejWHqAy
	 3KxVcLnp9+grKbB7HJjY3zBCSDkzZXgy6jBC34kjNtPBuW30Otco6RTllt7FUN1OQFw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794402875;
	bh=WHemzBA83ADOl88Tghjtf7gAjr8/hBG69yf83Dx22pM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SO8Hjhux2X2X3r/Lwxi625xhZHjZQN6uPsxcjefg0Xc+o6+gZVIpaGVyV8FlU3s2B
	 N6hO5kdgmvFkO7fuL4rQh4SZXUxks4vK651zQLcgHXaciH9abSzAe5dFvQU/na4gwC
	 JtOx0oJaUbcboQfGWA5vaAkKwQ9WtTgN73dVIL3ewgE2IAPPXAw19wfU4W5bAC0KAT
	 +7BSftmnRtm+N2Nm0POzHD/iu5mQDcWPNqRztnRQAoMcmc63K5ifOh0rB0z7H8mrxd
	 doTCONHJarEvoAZ1EL1hB307lUDKep5FoWwA2A9MzWrgAFi25TWZWDnu0xNJHNhb8A
	 50Xp+yZI4g3IQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E83A81328;
	Wed, 11 Nov 2026 13:14:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E1F5D17CD
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D083A40318
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JkdIfznTXoq9 for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 09:13:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2D8F940070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=igor.opaniuk@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=tdwyK0SS
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2D8F940070
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 09:13:42 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b71b012e3cso1770598a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 01:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794388420; x=1794993220;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WHemzBA83ADOl88Tghjtf7gAjr8/hBG69yf83Dx22pM=;
 b=tdwyK0SSRh1/yDi4J2iK+Bhj7EA2ZtsS4uZ8EKfwD7OZdt5TMgWfvXZYXfEgGEFqcC
 GaKlqCWbOnCkTr07Gd7jlYjL/lk+Lh6jXjhz8Rb6T8zFQFISYlieuZmfBdeEo/WFXv8k
 BXkJyoLjXkiOkP4r7UCykaNQi9j7s+TMyunxGAkQSBd5cLDQfcsn9jMxGJYXhkpKPm54
 Pm4laIFkeBfBgrq7o23foO5npVhCs75UH5eGFygSXRf/QsurGMQWOF3rSdz0p7/wXIW0
 fa2LT4dylVjP3vOf7jbChWvYVMMNmrFJ6K8Crx8ecVGvohMJi9URvbZ1j1b1qDuDFu2y
 3dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388420; x=1794993220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WHemzBA83ADOl88Tghjtf7gAjr8/hBG69yf83Dx22pM=;
 b=CX28Z88dtAL9G9wAOyNdoetz92YE3USj5xh7NEdlrKgR/a3q1KUKipCuZSxUUkNz2a
 DQnq6H+rXnXNGOhfMBazBk5MB0ZQ0Hu9o6X9Q3ex5JwS+Btb7gmUZ4rFR/uvnQb6ETD6
 jZoyYoZ2NvmMU1pYHuZMhgH/TsQz470ZU+OrhzZdDIwxOae+5u6rUkqHTNoScla+jBoH
 SdtZb3Y4jztqZpQsxgqgGQlmXnMZ9hcSNUhld+92+Mj2SMGtMp9la1EWkjr+2x07RpAM
 cdY47uvF6H6tATQYMDyb/gbKpCQiT+2IYvfyYklbF9vY7COa2uLXbW45PbYtw7TDjzjy
 OVqA==
X-Forwarded-Encrypted: i=1;
 AL+hErGmqaNBCvf1OV6vCAdtzrWWyLhcia5C2YmsL21OXNT85J9cWjJYM0HRd/Ix2DmYbRdyA5hSXxk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8U2CdZY7fkcnQSfEV+/SVHw+a8pR+Klwjo+T3C1blckYWSKeXy
 plwikcQPp/qvQWU/df5Sp4Lt07SqksDNqbFr4G+wKpTpI6RBC4lUhyOV
X-Gm-Gg: AYBFou0WSR0sHK45iB+7GfPRugUksp1CIPCwpiC1UnE0KNDy/uROLzN0OZIjjn3d5iz
 Kdwnk+VcwuLTKSibUDCrcbFA8QWRLkIdYlTWhXn2Js0eRbZkBRzJKTC2ziVJlghI6JUDTUwQE9w
 83I9h7fcajC5tY2osI+KjxckwhWXxjcHN01bBWCQ5PV4Bwnea+Mai95gXwBeZRKbqwBVpgWANji
 okleKC/cOTPast+SukXuxqP9Y7Qh/MsWlGQgRfyXgCfQ2WPfzzGZTAJS76xSysFZ4o8UV5KeGtK
 HOOjskz90ePyKG5IiR0PONqR5S+Z5I0cKqAVzOwbAP1F0KDurnDvHNxhSttkijLujEF1/Ddmt0W
 HCh+4CmPgyy1XeaAiG0fSfYFAgUcSPeEaZXY6iYbvTW2W6loXwnK96rHANGoarwn3DRdfy1fNwq
 I08q1yDqp1hUJh7jrx8vw/NSXV7jG5o5UHA+cOE5XgswdpV1682mOkUKDaIz4xnxNrMDydVkLpm
 lxQ/EQ6cxLW+8R1J981JZvVFHjCzKN1AcyV8NuN949i+oCV5CCyUxyKqpob+x9XmsX62Nwh40No
 OuUzbgiZBUATYXWS1FO5D+bZpTxamWiRioA1olIlc7yDwmWbHs+kXN0FgK+FcL5iXuwydutAeNX
 SePsd6m4lpMXeDps=
X-Received: by 2002:a05:6402:3225:b0:6b7:8ace:4be2 with SMTP id
 4fb4d7f45d1cf-6b78ace4d22mr521981a12.16.1794388420141; 
 Wed, 11 Nov 2026 01:13:40 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7579047c9sm2155257a12.33.2026.11.11.01.13.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:13:39 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Wed, 11 Nov 2026 10:13:34 +0100
Subject: [PATCH 3/3] bootstd: android: act on the misc memtag and kcmdline
 messages
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261111-upstream-android_rollback_misc_b4-v1-3-47d17e8a5d92@gmail.com>
References: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
In-Reply-To: <20261111-upstream-android_rollback_misc_b4-v1-0-47d17e8a5d92@gmail.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:14:06 +0000
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

Android changes some kernel command line options through messages in
the misc system space, which only the bootloader can act on:

  - mtectrl writes misc_memtag_message to turn Arm MTE on or off. The
    bootloader passes arm64.nomte and kasan=on/off accordingly and
    clears the one-shot bits [1].
  - kcmdlinectrl writes misc_kcmdline_message to force the Rust or the
    C binder driver, passed as binder.impl= [2].

Read both messages and apply them to the bootflow command line.
BOOTMETH_ANDROID_MEMTAG_DEFAULT sets the MTE default when nothing was
requested. A missing message is normal on a device that never used
these features.

[1] https://source.android.com/docs/security/test/memory-safety/bootloader-support
[2] https://android.googlesource.com/platform/system/extras/+/refs/tags/android-17.0.0_r1/kcmdlinectrl/kcmdlinectrl.cc

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---
 MAINTAINERS             |   2 +
 boot/Kconfig            |  11 ++++
 boot/Makefile           |   2 +-
 boot/android_misc.c     | 145 ++++++++++++++++++++++++++++++++++++++++++++++++
 boot/bootmeth_android.c |  84 ++++++++++++++++++++++++++++
 include/android_misc.h  |  56 +++++++++++++++++++
 6 files changed, 299 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76a06fbf7ab..338c29fc841 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -858,9 +858,11 @@ M:	Mattijs Korpershoek <mkorpershoek@kernel.org>
 R:	Guillaume La Roque <glaroque@baylibre.com>
 S:	Maintained
 T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dfu.git
+F:	boot/android_misc.c
 F:	boot/bootmeth_android.c
 F:	boot/bootmeth_android.h
 F:	doc/develop/bootstd/android.rst
+F:	include/android_misc.h
 
 BTRFS
 M:	Marek Behún <kabel@kernel.org>
diff --git a/boot/Kconfig b/boot/Kconfig
index 8fcdc36c931..50cdacfca98 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -608,6 +608,17 @@ config BOOTMETH_ANDROID
 	  Note that only MMC bootdevs are supported at present. This is caused
 	  by AVB being limited to MMC devices only.
 
+config BOOTMETH_ANDROID_MEMTAG_DEFAULT
+	bool "Enable Arm MTE by default on Android"
+	depends on BOOTMETH_ANDROID && ARM64
+	help
+	  Whether the kernel is booted with the Arm Memory Tagging Extension
+	  enabled when the OS has not asked for a specific mode in the misc
+	  partition (misc_memtag_message, written by mtectrl). Select this on
+	  MTE capable devices that ship with MTE on; the OS can still turn it
+	  off with MISC_MEMTAG_MODE_MEMTAG_OFF. Without it the bootloader
+	  passes arm64.nomte unless the OS asked for MTE.
+
 config BOOTMETH_CROS
 	bool "Bootdev support for Chromium OS"
 	depends on X86 || ARM || SANDBOX
diff --git a/boot/Makefile b/boot/Makefile
index f2cbda176a0..f19bd11b132 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -73,7 +73,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE) += vbe_simple.o vbe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_FW) += vbe_simple_fw.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_VBE_SIMPLE_OS) += vbe_simple_os.o
 
-obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_ANDROID) += bootmeth_android.o android_misc.o
 
 obj-$(CONFIG_$(PHASE_)IMAGEMAP) += imagemap.o
 
diff --git a/boot/android_misc.c b/boot/android_misc.c
new file mode 100644
index 00000000000..b7fb5d988d2
--- /dev/null
+++ b/boot/android_misc.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Messages the Android OS leaves for the bootloader in the system space of
+ * the misc partition. Each message is a 64-byte struct at a fixed offset of
+ * struct misc_system_space_layout, which starts at
+ * SYSTEM_SPACE_OFFSET_IN_MISC, with a magic and a version.
+ */
+#include <android_bootloader_message.h>
+#include <android_misc.h>
+#include <blk.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <linux/err.h>
+
+/**
+ * misc_system_space_io() - Read or write one message of the system space
+ *
+ * @dev_desc: Device holding the misc partition
+ * @part_info: The misc partition
+ * @offset: Offset of the message in struct misc_system_space_layout
+ * @msg: Message buffer
+ * @size: Message size
+ * @write: true to write @msg, false to read into it
+ * Return: 0 on success, negative errno on error
+ */
+static int misc_system_space_io(struct blk_desc *dev_desc,
+				const struct disk_partition *part_info,
+				ulong offset, void *msg, size_t size,
+				bool write)
+{
+	ulong byte_off = SYSTEM_SPACE_OFFSET_IN_MISC + offset;
+	ulong blk, blocks, in_blk, ret;
+	void *buf;
+
+	blk = byte_off / part_info->blksz;
+	in_blk = byte_off % part_info->blksz;
+	blocks = DIV_ROUND_UP(in_blk + size, part_info->blksz);
+	if (blk + blocks > part_info->size)
+		return -ENOSPC;
+
+	buf = malloc_cache_aligned(blocks * part_info->blksz);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = blk_dread(dev_desc, part_info->start + blk, blocks, buf);
+	if (IS_ERR_VALUE(ret) || ret != blocks) {
+		free(buf);
+		return -EIO;
+	}
+
+	if (write) {
+		memcpy(buf + in_blk, msg, size);
+		ret = blk_dwrite(dev_desc, part_info->start + blk, blocks, buf);
+		if (IS_ERR_VALUE(ret) || ret != blocks) {
+			free(buf);
+			return -EIO;
+		}
+	} else {
+		memcpy(msg, buf + in_blk, size);
+	}
+	free(buf);
+
+	return 0;
+}
+
+static int read_memtag(struct blk_desc *dev_desc,
+		       const struct disk_partition *part_info,
+		       struct misc_memtag_message *msg)
+{
+	int ret;
+
+	ret = misc_system_space_io(dev_desc, part_info,
+				   offsetof(struct misc_system_space_layout,
+					    memtag_message),
+				   msg, sizeof(*msg), false);
+	if (ret)
+		return ret;
+	if (msg->magic != MISC_MEMTAG_MAGIC_HEADER ||
+	    msg->version > MISC_MEMTAG_MESSAGE_VERSION)
+		return -ENOENT;
+
+	return 0;
+}
+
+int android_misc_read_memtag(struct blk_desc *dev_desc,
+			     const struct disk_partition *part_info,
+			     u32 *modep)
+{
+	struct misc_memtag_message msg;
+	int ret;
+
+	ret = read_memtag(dev_desc, part_info, &msg);
+	if (ret)
+		return ret;
+	*modep = msg.memtag_mode;
+
+	return 0;
+}
+
+int android_misc_clear_memtag_once(struct blk_desc *dev_desc,
+				   const struct disk_partition *part_info)
+{
+	struct misc_memtag_message msg;
+	u32 once = MISC_MEMTAG_MODE_MEMTAG_ONCE |
+		   MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE;
+	int ret;
+
+	ret = read_memtag(dev_desc, part_info, &msg);
+	if (ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+	if (!(msg.memtag_mode & once))
+		return 0;
+
+	msg.memtag_mode &= ~once;
+
+	return misc_system_space_io(dev_desc, part_info,
+				    offsetof(struct misc_system_space_layout,
+					     memtag_message),
+				    &msg, sizeof(msg), true);
+}
+
+int android_misc_read_kcmdline(struct blk_desc *dev_desc,
+			       const struct disk_partition *part_info,
+			       u64 *flagsp)
+{
+	struct misc_kcmdline_message msg;
+	int ret;
+
+	ret = misc_system_space_io(dev_desc, part_info,
+				   offsetof(struct misc_system_space_layout,
+					    kcmdline_message),
+				   &msg, sizeof(msg), false);
+	if (ret)
+		return ret;
+	if (msg.magic != MISC_KCMDLINE_MAGIC_HEADER ||
+	    msg.version > MISC_KCMDLINE_MESSAGE_VERSION)
+		return -ENOENT;
+	*flagsp = msg.kcmdline_flags;
+
+	return 0;
+}
diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
index 3d1e64aa2b4..9f5563751a7 100644
--- a/boot/bootmeth_android.c
+++ b/boot/bootmeth_android.c
@@ -10,6 +10,7 @@
 #include <android_ab.h>
 #include <android_bootloader_message.h>
 #include <android_image.h>
+#include <android_misc.h>
 #if CONFIG_IS_ENABLED(AVB_VERIFY)
 #include <avb_verify.h>
 #endif
@@ -198,6 +199,88 @@ static int android_read_slot_from_bcb(struct bootflow *bflow, bool decrement)
 	return 0;
 }
 
+/**
+ * configure_misc_messages() - Act on the OS messages in the misc system space
+ *
+ * Arm MTE (misc_memtag_message, written by mtectrl): the bootloader decides
+ * whether the kernel runs with MTE from the requested mode and clears the
+ * one-shot bits, see the Android "MTE bootloader support" documentation.
+ * Kernel command line flags (misc_kcmdline_message, written by kcmdlinectrl):
+ * the Rust or the C binder driver is forced with binder.impl=.
+ *
+ * Neither message being present is the normal state of a device that never
+ * used these features.
+ *
+ * @bflow: Bootflow to add the command line arguments to
+ * @desc: Device holding the misc partition
+ * @misc: The misc partition
+ * Return: 0 if OK, negative errno on failure
+ */
+static int configure_misc_messages(struct bootflow *bflow,
+				   struct blk_desc *desc,
+				   const struct disk_partition *misc)
+{
+	u32 mode;
+	u64 flags;
+	int ret;
+
+	ret = android_misc_read_memtag(desc, misc, &mode);
+	if (!ret) {
+		bool memtag, memtag_kernel;
+
+		/*
+		 * MEMTAG_OFF overrides the device default; MEMTAG and
+		 * MEMTAG_ONCE enable it for userspace, MEMTAG_KERNEL and
+		 * MEMTAG_KERNEL_ONCE for the kernel (KASAN hardware tags).
+		 */
+		memtag = (mode & (MISC_MEMTAG_MODE_MEMTAG |
+				  MISC_MEMTAG_MODE_MEMTAG_ONCE)) ||
+			 (IS_ENABLED(CONFIG_BOOTMETH_ANDROID_MEMTAG_DEFAULT) &&
+			  !(mode & MISC_MEMTAG_MODE_MEMTAG_OFF));
+		memtag_kernel = mode & (MISC_MEMTAG_MODE_MEMTAG_KERNEL |
+					MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE);
+		log_debug("memtag mode %x: memtag %d kernel %d\n", mode,
+			  memtag, memtag_kernel);
+		if (!memtag) {
+			ret = bootflow_cmdline_set_arg(bflow, "arm64.nomte",
+						       BOOTFLOWCL_EMPTY, false);
+			if (ret < 0)
+				return log_msg_ret("nomte", ret);
+		}
+		ret = bootflow_cmdline_set_arg(bflow, "kasan",
+					       memtag_kernel ? "on" : "off",
+					       false);
+		if (ret < 0)
+			return log_msg_ret("kasan", ret);
+
+		ret = android_misc_clear_memtag_once(desc, misc);
+		if (ret)
+			log_warning("cannot clear the one-shot MTE bits: %d\n", ret);
+	} else if (ret != -ENOENT) {
+		return log_msg_ret("memtag", ret);
+	}
+
+	ret = android_misc_read_kcmdline(desc, misc, &flags);
+	if (!ret) {
+		const char *binder = NULL;
+
+		if (flags & MISC_KCMDLINE_BINDER_FORCE_RUST)
+			binder = "rust";
+		else if (flags & MISC_KCMDLINE_BINDER_FORCE_C)
+			binder = "c";
+		if (binder) {
+			ret = bootflow_cmdline_set_arg(bflow, "binder.impl",
+						       binder, false);
+			if (ret < 0)
+				return log_msg_ret("binder", ret);
+		}
+	} else if (ret != -ENOENT) {
+		return log_msg_ret("kcmdline", ret);
+	}
+
+	return 0;
+}
+
 static int configure_serialno(struct bootflow *bflow)
 {
 	char *serialno = env_get("serial#");
@@ -311,6 +394,7 @@ static int android_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 	 */
 	configure_serialno(bflow);
 	configure_bootloader_version(bflow);
+	configure_misc_messages(bflow, desc, &misc);
 
 	if (priv->boot_mode == ANDROID_BOOT_MODE_NORMAL && priv->slot) {
 		ret = bootflow_cmdline_set_arg(bflow, "androidboot.force_normal_boot",
diff --git a/include/android_misc.h b/include/android_misc.h
new file mode 100644
index 00000000000..b4b9d62072d
--- /dev/null
+++ b/include/android_misc.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Messages the Android OS leaves for the bootloader in the system space of
+ * the misc partition (see android_bootloader_message.h).
+ */
+
+#ifndef __ANDROID_MISC_H
+#define __ANDROID_MISC_H
+
+#include <linux/types.h>
+
+struct blk_desc;
+struct disk_partition;
+
+/**
+ * android_misc_read_memtag() - Read the MTE mode requested by the OS
+ *
+ * @dev_desc: Device holding the misc partition
+ * @part_info: The misc partition
+ * @modep: Returns the memtag_mode flags (MISC_MEMTAG_MODE_*)
+ * Return: 0 if a valid misc_memtag_message was found, -ENOENT if there is
+ *	none, other negative errno on error
+ */
+int android_misc_read_memtag(struct blk_desc *dev_desc,
+			     const struct disk_partition *part_info,
+			     u32 *modep);
+
+/**
+ * android_misc_clear_memtag_once() - Clear the one-shot MTE mode bits
+ *
+ * Android expects the bootloader to clear MISC_MEMTAG_MODE_MEMTAG_ONCE and
+ * MISC_MEMTAG_MODE_MEMTAG_KERNEL_ONCE on every boot once it has acted on
+ * them.
+ *
+ * @dev_desc: Device holding the misc partition
+ * @part_info: The misc partition
+ * Return: 0 on success (also when there is no valid message), negative
+ *	errno on error
+ */
+int android_misc_clear_memtag_once(struct blk_desc *dev_desc,
+				   const struct disk_partition *part_info);
+
+/**
+ * android_misc_read_kcmdline() - Read the kernel command line flags
+ *
+ * @dev_desc: Device holding the misc partition
+ * @part_info: The misc partition
+ * @flagsp: Returns the kcmdline_flags (MISC_KCMDLINE_*)
+ * Return: 0 if a valid misc_kcmdline_message was found, -ENOENT if there is
+ *	none, other negative errno on error
+ */
+int android_misc_read_kcmdline(struct blk_desc *dev_desc,
+			       const struct disk_partition *part_info,
+			       u64 *flagsp);
+
+#endif /* __ANDROID_MISC_H */

-- 
2.53.0

