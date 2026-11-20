Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E6606A6A5
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ql/a0FBK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhD8AFEm
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AA16460679;
	Fri, 20 Nov 2026 21:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Se6HKKcpJaVz; Fri, 20 Nov 2026 21:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95ED5605D1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795209895;
	b=gCajl0Fg2avu2Js6oJeKzmqiiKng3E1a2cWD9OVPAC4WUZSfBfXRUb577SboFCz/YvRh
	 OY43CSW+MlUVkgL7HGiDWb+LDIYCnZgBe4dY0KR7YpF1inEMpWkcipL0ZmipBTuwFoiNQ
	 K8H7VpILQ7CUenAvInjzcwNU2puFXxMNNx2g2akEpT6NiiHNIGEKC/TfU7AQTs4etwEva
	 FpJ1/XuahAoUlyuztexFg/MbV3n4tqLCvc7SIB2svLxDAsVMWAYwFg8tc0yLoAQaSKh8G
	 h3TnHb+z0rXPwAFpRqB+yrl1mZDwDL+VHFHrzYtIiMCni09CBudu5whHbYhmtsLBoBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795209895;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8+3KJFUj+cW7xC8GpIO0GEBwWbHFYp/Sf7tvlC5YP2w=;
	b=SeecqwZrMXHaztNscT1HxfxvBNzSq0R50/BLFyBBPCAuuikJRmZL0+uBKM3YGsOAr6Cb
	 0gVIuP6TiJo+QoAInkfVjw964JpkHGPpJow9s0+SSN1CnmkVaYTJp7ezrnLuyPiy80o3u
	 q9kjAMKcvOOQBMg60oA28nznL0TY4rEs9hXB+KGuGqmHfmgg/nH+wfDQydVSiZuD2q2En
	 OuEbPbI9y+LVQAMkKDYcB9lFVaSjiBwP6LKrIvgV4dwYNTlS98KbUDYtL+YYbjyopxRMm
	 9/BzsmNWvmBBU9Bb54yM5Zup5q0ne2uZJ3z31ChRWTZUcJ3f4uShiZd+uQVgYY1uUGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795209895;
	bh=8+3KJFUj+cW7xC8GpIO0GEBwWbHFYp/Sf7tvlC5YP2w=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ql/a0FBKtiA3LZEbIaEIMpUZTmFYCn9jAgIdOgVpe5gxxcxb+RL1Gg5kplXq9lper
	 IWvGKjZA9JqGNLFVDVC/eC8QHbwlQ1XPDPSoKc77RbZlgO+F2H57Sp4f5/PjH2Cr0p
	 YN9AnsGJ2RvTk2FHfd7de9umaVSwSGRjwrnWzn0pULMTNc2mZ0UGuCTzb4G3fU5ZsH
	 mg4rGvAsRt/p/6k38YUpWXoL1XUzx5cc9tQbdG2dwCA6Vny81Q1fewhE/1RUthDpV4
	 kSPKMN7xg5PXOoZoRMSnmebaG+gEH/R2mfTYWtmafqi2fv6WlNl7DTxiJRgxQodeRs
	 8T+QEqn7Pn9Ug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95ED5605D1;
	Fri, 20 Nov 2026 21:24:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 21129759
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0728F40B01
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:24:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cbz7j8y7OEjB for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:24:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1639740208
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=jhD8AFEm
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1639740208
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:24:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22398421EE;
 Fri, 20 Nov 2026 21:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C041F000EC;
 Fri, 20 Nov 2026 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795209892;
 bh=8+3KJFUj+cW7xC8GpIO0GEBwWbHFYp/Sf7tvlC5YP2w=;
 h=From:Date:Subject:To:Cc;
 b=jhD8AFEmc0SIvK9JWsCQJs+kH56hEdqWn+NH78xtBC79WSBHLBiqTDPz1CdGIfqcA
 Zy1UAtzulQyoCeuTCznM+5Q4XbHeHffOVNJ9gP6TkFj0o90ftlENTob6j/RlS/k6he
 N4wxR0FFDQ3bwqKPK7Q5ypFyz3pUPQLNlg8NBzqpVBregntBkf6iJaJtHFSzmqnc7r
 4QrtnPDDxnRQ4Y8e+w9Jhj9SPiXnbqqRa19DsJ3ULDiXESZ9uEsnWYe3XxhjCBPwLF
 47G6epsi/G7GVyOKWHDvuLFx2cgqdAu/9sOLgcAKDpR2GkukTsQs3b83SkpnI7lzAY
 sG9vWlpTXlNjw==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 20 Nov 2026 22:24:45 +0100
Subject: [PATCH] board: stemmy: Read persistent radio addresses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-ux500-efs-v1-1-58147e2eae41@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MTQqAIBAG0KsM3zrBKTLxKtGin7FmU6EUQnT3o
 HeA9yBLUskI9CDJrVmPHYG4IszbuK9idEEg1LZ2zGzNVVprjcRs5smzb7pWfHSoCGeSqOW/+uF
 9P+5p/GdbAAAA
X-Change-ID: 20261110-ux500-efs-cb818375e8f6
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Stefan Hansson <newbyte@postmarketos.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The device tree should contain the hardware addresses for Wifi
and Bluetooth.

Samsung stores Wi-Fi and Bluetooth addresses in several
locations depending on the device and firmware. The eMMC partition
numbers also differ between devices.

Locate the EFS and DATAFS partitions by name, with a filesystem-content
fallback for unlabeled partition tables. Search the Samsung Wi-Fi
address files in priority order and support both Bluetooth EFS layouts.

Accept colon-separated and compact addresses, including Codina's
bt_macaddr: record, reject known firmware placeholders.

Pass valid addresses to the operating system through the device
tree nodes from ft_board_setup().

Tested on some different phones such as Janice, Codina, Skomer,
Golden...

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 MAINTAINERS                     |   1 +
 board/ste/stemmy/Makefile       |   2 +-
 board/ste/stemmy/stemmy-radio.c | 325 ++++++++++++++++++++++++++++++++++++++++
 board/ste/stemmy/stemmy-radio.h |   8 +
 board/ste/stemmy/stemmy.c       |   4 +
 5 files changed, 339 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6edf740a9ceb..ceb474751906 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -772,6 +772,7 @@ R:	Linus Walleij <linusw@kernel.org>
 S:	Maintained
 F:	arch/arm/dts/ste-*
 F:	arch/arm/mach-u8500/
+F:	board/ste/stemmy/
 F:	drivers/gpio/nmk_gpio.c
 F:	drivers/pinctrl/pinctrl-nomadik.c
 F:	drivers/phy/phy-ab8500-usb.c
diff --git a/board/ste/stemmy/Makefile b/board/ste/stemmy/Makefile
index 1245099bc918..f4e97c9d9972 100644
--- a/board/ste/stemmy/Makefile
+++ b/board/ste/stemmy/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-obj-y	:= stemmy.o
+obj-y	:= stemmy.o stemmy-radio.o
diff --git a/board/ste/stemmy/stemmy-radio.c b/board/ste/stemmy/stemmy-radio.c
new file mode 100644
index 000000000000..3394fb8ca75a
--- /dev/null
+++ b/board/ste/stemmy/stemmy-radio.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Samsung stores persistent radio addresses in several locations depending
+ * on the firmware and device. Pass them to the operating system through the
+ * device tree when they can be found on the internal eMMC.
+ *
+ * Copyright (C) 2026 Linus Walleij <linusw@kernel.org>
+ */
+
+#include <blk.h>
+#include <dm.h>
+#include <fdt_support.h>
+#include <fs.h>
+#include <log.h>
+#include <mmc.h>
+#include <net-common.h>
+#include <part.h>
+#include <dm/device-internal.h>
+#include <dm/read.h>
+#include <dm/uclass.h>
+#include <linux/ctype.h>
+
+#include "stemmy-radio.h"
+
+#define RADIO_ADDR_BUF_SIZE	512
+
+enum stemmy_radio_partition {
+	STEMMY_PART_EFS,
+	STEMMY_PART_DATAFS,
+	STEMMY_PART_COUNT,
+};
+
+struct stemmy_radio_source {
+	enum stemmy_radio_partition partition;
+	const char *path;
+};
+
+struct stemmy_radio_storage {
+	struct blk_desc *desc;
+	int part[STEMMY_PART_COUNT];
+};
+
+static const char * const stemmy_partition_names[STEMMY_PART_COUNT] = {
+	[STEMMY_PART_EFS] = "EFS",
+	[STEMMY_PART_DATAFS] = "DATAFS",
+};
+
+static const struct stemmy_radio_source stemmy_wifi_sources[] = {
+	{ STEMMY_PART_EFS, "/wifi/.mac.info" },
+	{ STEMMY_PART_EFS, "/wifi/.mac.cob" },
+	{ STEMMY_PART_EFS, "/imei/.nvmac.info" },
+	{ STEMMY_PART_DATAFS, "/.nvmac.info" },
+	{ STEMMY_PART_DATAFS, "/.mac.info" },
+	{ STEMMY_PART_DATAFS, "/misc/wifi/.mac.info" },
+};
+
+static const struct stemmy_radio_source stemmy_bt_sources[] = {
+	{ STEMMY_PART_EFS, "/bluetooth/bt_addr" },
+	{ STEMMY_PART_EFS, "/bluetooth/addr.txt" },
+};
+
+static struct blk_desc *stemmy_radio_device(void)
+{
+	struct blk_desc *desc;
+	struct udevice *dev;
+	struct uclass *uc;
+	struct mmc *mmc;
+
+	if (uclass_get(UCLASS_MMC, &uc))
+		return NULL;
+
+	uclass_foreach_dev(dev, uc) {
+		/* Look in the eMMC, nothing else */
+		if (!dev_read_bool(dev, "non-removable") || device_probe(dev))
+			continue;
+
+		mmc = mmc_get_mmc_dev(dev);
+		if (!mmc || mmc_init(mmc) || !IS_MMC(mmc))
+			continue;
+
+		/* Persistent data is in the user area, not an eMMC boot area. */
+		desc = mmc_get_blk_desc(mmc);
+		if (!desc || blk_dselect_hwpart(desc, 0))
+			continue;
+
+		return desc;
+	}
+
+	return NULL;
+}
+
+static int stemmy_find_partition(struct blk_desc *desc, const char *name)
+{
+	struct disk_partition info;
+	int part;
+
+	if (!desc)
+		return -ENODEV;
+
+	part = part_get_info_by_name(desc, name, &info);
+	if (part >= 0)
+		return part;
+
+	for (part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
+		if (part_get_info(desc, part, &info))
+			continue;
+		if (!strcasecmp(name, (const char *)info.name))
+			return part;
+	}
+
+	return -ENOENT;
+}
+
+static bool stemmy_addr_tail_valid(const char *buf, size_t len, size_t pos)
+{
+	for (; pos < len; pos++) {
+		if (buf[pos] && !isspace((unsigned char)buf[pos]))
+			return false;
+	}
+
+	return true;
+}
+
+static int stemmy_parse_radio_addr(char *buf, size_t len, u8 *addr)
+{
+	const char *prefix = "bt_macaddr:";
+	const char *str = buf;
+	size_t pos = 0;
+	bool prefixed = false;
+	int i;
+
+	str = strstr(buf, prefix);
+	if (str) {
+		str += strlen(prefix);
+		pos = str - buf;
+		prefixed = true;
+	} else {
+		str = buf;
+		while (pos < len && isspace((unsigned char)str[pos]))
+			pos++;
+		str += pos;
+	}
+
+	if (pos + 17 <= len && str[2] == ':' && str[5] == ':' &&
+	    str[8] == ':' && str[11] == ':' && str[14] == ':') {
+		for (i = 0; i < ETH_ALEN; i++) {
+			if (hex2bin(addr + i, str + 3 * i, 1))
+				return -EINVAL;
+		}
+		pos += 17;
+	} else if (pos + 12 <= len) {
+		if (hex2bin(addr, str, ETH_ALEN))
+			return -EINVAL;
+		pos += 12;
+	} else {
+		return -EINVAL;
+	}
+
+	if (!prefixed && !stemmy_addr_tail_valid(buf, len, pos))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int stemmy_read_radio_addr(struct blk_desc *desc, int part,
+				  const char *path, u8 *addr)
+{
+	char buf[RADIO_ADDR_BUF_SIZE + 1];
+	loff_t len;
+	int ret;
+
+	ret = fs_set_blk_dev_with_part(desc, part);
+	if (ret)
+		return ret;
+
+	if (fs_get_type() != FS_TYPE_EXT) {
+		fs_close();
+		return -EINVAL;
+	}
+
+	ret = fs_read(path, (ulong)buf, 0, RADIO_ADDR_BUF_SIZE, &len);
+	if (ret)
+		return ret;
+	if (!len || len > RADIO_ADDR_BUF_SIZE)
+		return -EINVAL;
+
+	buf[len] = '\0';
+
+	return stemmy_parse_radio_addr(buf, len, addr);
+}
+
+static int stemmy_try_radio_source(struct stemmy_radio_storage *storage,
+				   const struct stemmy_radio_source *source,
+				   u8 *addr)
+{
+	struct disk_partition info;
+	int part, ret;
+
+	if (!storage->desc)
+		return -ENODEV;
+
+	part = storage->part[source->partition];
+	if (part >= 0)
+		return stemmy_read_radio_addr(storage->desc, part, source->path,
+					      addr);
+
+	/* Fall back to locating an unlabeled partition by its contents. */
+	for (part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
+		if (part_get_info(storage->desc, part, &info))
+			continue;
+
+		ret = stemmy_read_radio_addr(storage->desc, part, source->path,
+					     addr);
+		if (!ret) {
+			storage->part[source->partition] = part;
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
+/* Reject known default addresses */
+static bool stemmy_radio_addr_valid(const u8 *addr, bool bluetooth)
+{
+	static const u8 wifi_placeholders[][ETH_ALEN] = {
+		{ 0x00, 0x90, 0x4c, 0xc5, 0x12, 0x38 },
+		{ 0x00, 0x12, 0x34, 0x00, 0x0d, 0xef },
+	};
+	static const u8 bluetooth_placeholder[ETH_ALEN] = {
+		0x00, 0x12, 0x47, 0x01, 0x23, 0x45,
+	};
+	size_t i;
+
+	if (is_zero_ethaddr(addr) || is_broadcast_ethaddr(addr))
+		return false;
+	if (bluetooth)
+		return !!memcmp(addr, bluetooth_placeholder, ETH_ALEN);
+	if (is_multicast_ethaddr(addr))
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(wifi_placeholders); i++) {
+		if (!memcmp(addr, wifi_placeholders[i], ETH_ALEN))
+			return false;
+	}
+
+	return true;
+}
+
+static int stemmy_find_radio_addr(struct stemmy_radio_storage *storage,
+				  const struct stemmy_radio_source *sources,
+				  size_t count, bool bluetooth, u8 *addr)
+{
+	size_t i;
+	int ret;
+
+	for (i = 0; i < count; i++) {
+		ret = stemmy_try_radio_source(storage, &sources[i], addr);
+		if (ret || !stemmy_radio_addr_valid(addr, bluetooth))
+			continue;
+
+		log_debug("Read radio address from %s:%s\n",
+			  stemmy_partition_names[sources[i].partition],
+			  sources[i].path);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static void stemmy_fixup_radio_addr(void *fdt,
+				    struct stemmy_radio_storage *storage,
+				    const struct stemmy_radio_source *sources,
+				    size_t count, const char *compatible,
+				    bool bluetooth)
+{
+	const char *property = bluetooth ? "local-bd-address" : "local-mac-address";
+	const char *name = bluetooth ? "Bluetooth BD" : "WiFi MAC";
+	u8 addr[ETH_ALEN];
+	int node, ret, i;
+
+	ret = stemmy_find_radio_addr(storage, sources, count, bluetooth, addr);
+	if (ret) {
+		printf("Persistent %s missing\n", name);
+		return;
+	}
+
+	printf("Persistent %s: %pM\n", name, addr);
+
+	node = fdt_node_offset_by_compatible(fdt, -1, compatible);
+	if (node < 0)
+		return;
+
+	/* local-bd-address uses Bluetooth (least significant byte first) order. */
+	if (bluetooth) {
+		for (i = 0; i < ETH_ALEN / 2; i++)
+			swap(addr[i], addr[ETH_ALEN - i - 1]);
+	}
+
+	ret = fdt_setprop(fdt, node, property, addr, sizeof(addr));
+	if (!ret)
+		return;
+
+	log_warning("Cannot set %s: %s\n", property, fdt_strerror(ret));
+}
+
+void stemmy_radio_fixup(void *fdt)
+{
+	struct stemmy_radio_storage storage;
+
+	storage.desc = stemmy_radio_device();
+	storage.part[STEMMY_PART_EFS] =
+		stemmy_find_partition(storage.desc,
+				      stemmy_partition_names[STEMMY_PART_EFS]);
+	storage.part[STEMMY_PART_DATAFS] =
+		stemmy_find_partition(storage.desc,
+				      stemmy_partition_names[STEMMY_PART_DATAFS]);
+
+	stemmy_fixup_radio_addr(fdt, &storage, stemmy_wifi_sources,
+				ARRAY_SIZE(stemmy_wifi_sources),
+				"brcm,bcm4329-fmac", false);
+	stemmy_fixup_radio_addr(fdt, &storage, stemmy_bt_sources,
+				ARRAY_SIZE(stemmy_bt_sources),
+				"brcm,bcm4330-bt", true);
+}
diff --git a/board/ste/stemmy/stemmy-radio.h b/board/ste/stemmy/stemmy-radio.h
new file mode 100644
index 000000000000..3c3ce03669b8
--- /dev/null
+++ b/board/ste/stemmy/stemmy-radio.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __STEMMY_RADIO_H
+#define __STEMMY_RADIO_H
+
+void stemmy_radio_fixup(void *fdt);
+
+#endif
diff --git a/board/ste/stemmy/stemmy.c b/board/ste/stemmy/stemmy.c
index 8526deeb29bc..97957e12d5b0 100644
--- a/board/ste/stemmy/stemmy.c
+++ b/board/ste/stemmy/stemmy.c
@@ -12,6 +12,8 @@
 #include <asm/setup.h>
 #include <asm/system.h>
 
+#include "stemmy-radio.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 /* Parse atags provided by Samsung bootloader to get available memory */
@@ -545,5 +547,7 @@ int ft_board_setup(void *fdt, struct bd_info *bd)
 		skomer_kyle_patch_display(fdt);
 	}
 
+	stemmy_radio_fixup(fdt);
+
 	return 0;
 }

---
base-commit: f2e99724255470a12119f696a0c579fd873cbef9
change-id: 20261110-ux500-efs-cb818375e8f6

Best regards,
--  
Linus Walleij <linusw@kernel.org>

