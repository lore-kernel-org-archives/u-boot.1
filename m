Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00431606A33D
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eJcNs/is;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMGzclXe
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F3CE4074C;
	Tue, 24 Nov 2026 09:42:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R49P44ihAzmM; Tue, 24 Nov 2026 09:42:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 266F5406AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795513354;
	b=MLRXFM9yC3IkqIV5hbfqecuNNfxTh4vZWH2zQ9yU1uvkU9LMg37KYFVgk6hbgXYdXy+H
	 pM+6ioBSzcHDcPO9Sic46H/ibdjLiKjJzZ96eBSQdU/J3+G9W8jGo82Ov014hUyA9ZDRK
	 bdJId7vJwEUGHOJO5/BJbwHTsvFHCHnnPlefkoIJ7tDFItpLjtBeuasiMwzO0Brv+HGKF
	 N8/YVmtekLm4tko7r45zDlR/RkINzP5EKWFkrJonoRj2AH5s6f4cEDhHz7erajx8wJGz1
	 W+Mif5OsWAHKYcH7/W4RsL/UZSOULGdXUuG2knDKW32oN8ELeePf/YRq/BaIGyVZxEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795513354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=OPygG+c44LMgs1ggUMWg2nb9F/5SrRrciDK0YCIqXlg=;
	b=GNU2zl163OdaQG513Jun3yfpMI9vSjy87RiTMa6IYghzhda6QNRePDikvgfOJ6Uqrkv+
	 TbfX+7iTyTu6Brkofej8GG3rQOF44DxP1GhlGQlu1Q1GJCNxvFDHq9eQqS/x4FkThle8y
	 ZH6L3VhwG2KeR6qdJsNUI4fp/BZ3OkSuCRH3X59Z2/2Kqdys3WgEZyw1wFANSv6nzjwVS
	 GIB00SyvfhpBjpv9BqU4/5tANNCK0zp590ZeBT7YprrAHgAw8+2YejsiB00vES2kirwMk
	 8cGYE3VASCf7w1spmKkBY3U44/EXAAEgMqZcqi5aaD0M1M9Ciwlx0CrEesY1KdF1KLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMGzclXe;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795513354;
	bh=OPygG+c44LMgs1ggUMWg2nb9F/5SrRrciDK0YCIqXlg=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eJcNs/isNZMP7J4rvtB70bsGg9rxJf+5L/Pl4Bfkdrb41Q8neY5meqJ1sVAwlE6j/
	 vSNeUwv+OAEd+EL8fGyMF2yh093zdPXz2EgJ7oynPH46e+C7ujAWFRf06zwV6nezfn
	 xVArXfhTFDdZB7SjBGVpfhTTAjW+4G1MG9ZSTsx2twlp58GufVARM6fNDq41SCf3bZ
	 6KWyvR+qxKx5j7lglfFvH3QlonPFu2Ss2/moBVPMxJx9buHg7YfwvXhjdd/6T8vnZh
	 IXYsuX1gjEpyqjL+C33AWVAIFV+lDd2+oFZ85Sqy+9q6JfkD2GcrwPgnYjv8X7YREO
	 luwOn+19izukQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 266F5406AB;
	Tue, 24 Nov 2026 09:42:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C87B715
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F14EF406AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:42:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8jyiTAI9NRlc for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 09:42:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4B0A8406A4
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=linusw@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=GMGzclXe
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B0A8406A4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 09:42:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7650960E0F;
 Tue, 24 Nov 2026 09:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1811F000C0;
 Tue, 24 Nov 2026 09:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795513348;
 bh=OPygG+c44LMgs1ggUMWg2nb9F/5SrRrciDK0YCIqXlg=;
 h=From:Date:Subject:To:Cc;
 b=GMGzclXenoBq+KG+VvTaBJW6iVRIGOycR3QarnmwoR0VZ8zJy1PW3ytlOeixyxtNT
 DnUQ2DqaENzPj72nIwMw50ZTatBubvgqmbtwoSiNjWUap6BtXrxD+ZiuNfKcxx3ojH
 M9em/ah7WNl92tjjcqwrJEC/J0zwZS0dDIdv48JBpKSGHWxSFBbycK18eJzqjoz3BZ
 8wfQaYXBTdecFS9Pb1kKYplPFjBbVkae2Ppc09mNvpv7ES1V5p0AYZlJ8nAuaw1g8l
 ocNmDJ7YyxBS6ILWYCHhkyF0KUmWFgLElnwmAw/CnBcQcfo9H84b4vqzbLPTUZO7Gy
 lJrsi05o6vMWw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 24 Nov 2026 10:42:24 +0100
Subject: [PATCH v2] board: stemmy: Read persistent radio addresses
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-ux500-efs-v2-1-796a522177f9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/03MsQ7CIBAA0F+53AyGw9KSTv6H6VDr0RINGFBS0
 /DvxsbB9Q1vw8zJc8YeNkxcfPYxYA9aAE7LGGaW/oo9oFa6JSIlX6tRSrLLcrpYssfOsHUtCsB
 HYufX/ToPAnDx+RnTe68LffW36P+lkCRpLDUdax65odONU+D7IaYZh1rrB1+3dUmjAAAA
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

Samsung stores persistent Wi-Fi and Bluetooth addresses in several
locations depending on the device and firmware. The eMMC partition
numbers also differ between devices.

Locate the EFS and DATAFS partitions by name. Search the known Samsung
Wi-Fi address files in priority order and support both Bluetooth EFS
layouts. Accept colon-separated and compact addresses, including Codina's
bt_macaddr: record, while rejecting known firmware placeholders.

Pass valid addresses to the operating system through the radio device
tree nodes from ft_board_setup().

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v2:
- The code was overly cautious, use exact EFS and DATAFS names and
  drop both partition lookup fallbacks.
- Clarify that fs_read() closes the filesystem even on failure.
- Use log_warning() and log_info() for radio address messages.
- Link to v1: https://patch.msgid.link/20261120-ux500-efs-v1-1-58147e2eae41@kernel.org
---
 MAINTAINERS                     |   1 +
 board/ste/stemmy/Makefile       |   2 +-
 board/ste/stemmy/stemmy-radio.c | 287 ++++++++++++++++++++++++++++++++++++++++
 board/ste/stemmy/stemmy-radio.h |   8 ++
 board/ste/stemmy/stemmy.c       |   4 +
 5 files changed, 301 insertions(+), 1 deletion(-)

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
index 000000000000..4a09ebcfe994
--- /dev/null
+++ b/board/ste/stemmy/stemmy-radio.c
@@ -0,0 +1,287 @@
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
+		/* Android's mmcblk0 is not necessarily U-Boot's mmc 0. */
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
+	/* fs_read() closes the filesystem even when the read fails. */
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
+	int part, ret;
+
+	for (i = 0; i < count; i++) {
+		part = storage->part[sources[i].partition];
+		if (part < 0)
+			continue;
+
+		ret = stemmy_read_radio_addr(storage->desc, part,
+					     sources[i].path, addr);
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
+	const char *property = bluetooth ? "local-bd-address" :
+					       "local-mac-address";
+	const char *name = bluetooth ? "Bluetooth BD" : "WiFi MAC";
+	u8 addr[ETH_ALEN];
+	int node, ret, i;
+
+	ret = stemmy_find_radio_addr(storage, sources, count, bluetooth, addr);
+	if (ret) {
+		log_warning("Persistent %s missing\n", name);
+		return;
+	}
+
+	log_info("Persistent %s: %pM\n", name, addr);
+
+	node = fdt_node_offset_by_compatible(fdt, -1, compatible);
+	if (node < 0)
+		return;
+
+	/* local-bd-address uses Bluetooth (least significant byte first) order. */
+	if (bluetooth) {
+		for (i = 0; i < ETH_ALEN / 2; i++)
+			swap(addr[i], addr[ETH_ALEN - i - 1]);
+	} else if (fdt_getprop(fdt, node, "mac-address", NULL)) {
+		/* Linux prefers mac-address if it is already present. */
+		ret = fdt_setprop(fdt, node, "mac-address", addr, sizeof(addr));
+		if (ret)
+			goto err;
+	}
+
+	ret = fdt_setprop(fdt, node, property, addr, sizeof(addr));
+	if (!ret)
+		return;
+
+err:
+	log_warning("Cannot set %s: %s\n", property, fdt_strerror(ret));
+}
+
+void stemmy_radio_fixup(void *fdt)
+{
+	struct stemmy_radio_storage storage;
+	struct disk_partition info;
+	int i;
+
+	storage.desc = stemmy_radio_device();
+	if (!storage.desc)
+		return;
+
+	for (i = 0; i < STEMMY_PART_COUNT; i++)
+		storage.part[i] = part_get_info_by_name(storage.desc,
+							stemmy_partition_names[i],
+							&info);
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

