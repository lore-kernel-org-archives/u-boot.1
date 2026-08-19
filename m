Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C910C5DF88
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 17:03:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03F4560792;
	Wed, 19 Aug 2026 17:03:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dP8Gtv9bTbnT; Wed, 19 Aug 2026 17:03:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787158984;
	bh=UNmXjA5yE9ADhqsH0Q9FCefzViuee6jvCRiQrv0OFQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bYcnijjr6NBV4kVrk9NmrnTWVokKhZrHPYYiKRXFOW98AwiXGWYb7+gb8V9X19FQc
	 t3K4zRsUJ7aJWNyWAs2E0QsOmM/PUuazvcgZRk9MKaARyLehJq0hp9t0Cs3GrFbUd0
	 a9jtxJQhV4eco+EoWIZsbTOraORpor2sFIdhRChm2/4qLfLPIcFHJOL+XyrdXk1lhr
	 aiLbuahNFiVnPhFomN9IBt3Xar2ZVbZQhXruNuzCujiPnHQnIEBu3ED8BqtSvpm3pI
	 y/vsPGQeeeeE9UdXVd4EFXXIrKxys7XcVkT8zx2+NZIHIMbkcLJf7CeoYQmHLbJ+Tt
	 3t2r8Ot+bzNIA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EA4460782;
	Wed, 19 Aug 2026 17:03:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E707334
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FEDC606F4
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zpRysqqkD4gS for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 16:40:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=byteray.co.uk
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=qtUATVZw
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6428E60719
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 16:40:47 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a1a546a6bbso2150782a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1787157645; x=1787762445;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UNmXjA5yE9ADhqsH0Q9FCefzViuee6jvCRiQrv0OFQg=;
 b=qtUATVZw9nECGm8kEz24yao41GQ8yWThOwQlSPN72plSUt4xIVvVGAoG3txR02lTEZ
 SRrXIwKvNtCus2WJk+emF3GQZ0Hjy7bQLi202brfgXRMxRi6ewFov9e906OTcJvqQ7IG
 SFDxNCtMWN7qpt4xL3Eej8grGSH28TayU5bI1iwyfqxriXsoSG43DzI6qcnE5NypuxFg
 lCcEK4EH9p3+VYtCZI6NarMsiic0TOE/ZXhJM1grD1F1VLZDJQqTTqEunIHxLcHOgNr5
 jCs/zuz3CJ06t3ne4s/ONy+hkA9pAUlocrX7ys15BinE4JWpiDDtJI4pLLqo11hjRs4G
 E6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787157645; x=1787762445;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UNmXjA5yE9ADhqsH0Q9FCefzViuee6jvCRiQrv0OFQg=;
 b=ENprCWKGWg3fLwRXoftMi069r/hYOCBZEGxyMwnCIoAZHxdDndsRSVmH9rxkfF2PWQ
 3eYL5G+oQN/MmRdYnhqLVF8QJus60aePcVCYnxQUzSuj3j9CrfbHOncI9zpBbJw6/trD
 QFq+Gvk57cwMPB7M7yOSrmIup1MKOgAvwtXZyQgsYNKOl7njEJ6Gs/5xEZ/rsXNQj564
 z++SuXmcNWYaOlMBUHry3m3KK4IIMh/DPzwot0DU/SxCdiwNk3bmBSx79FHz1w2tTOS/
 SW59+K4zNuWleMCtnFaHSLhMKCrjKWo8YgG1RdftGrC6pjZtrIzSCboZccC/ilz2qVm3
 Rnbg==
X-Gm-Message-State: AFuF++mYczUfosE2D9Y1HLvK6UQ5XEgfr4t9penUmXvCBSOLKo1AJeo7
 0wdx8aGGYckES5ifTlVDiWUco/Jvsor54mI8RYFh1zbIodfbaeJ8bJ+lEPjxnMPkgVw6gMkaNfb
 2cTTnluU=
X-Gm-Gg: AR+sD13pbrlobMCRBKg6OQmXucFyk7SMZI/xTNOSDPKJrTWK14LUkza08JGF9vKSRSI
 waQSsiTUBKB44cVM4QPuVzT7347+YejWWCpioA/Dfo8nwN0fluuuumvmAl8AwxVb7aHBE/UxCOa
 At+qGMdNTSxKKZ+u/ccE7e7842E8yd1QJxvdIKtUkF6fP2uw2L7lstWLALqupPb1v96lMx79iOM
 bAqPHgHehOlNub+q0zl/fhCBCD/crhjbxYjRpztv9Iq68GXaa1R4f9jlwWn3q7DD+tiZuYhepsd
 YU4AlrR1Ehxl5HhWBJuQmucwSMV+dGzZ9aAl3GzrAi5YBXrJIJEK3UcmYTROgyWIlm8sul2CFdu
 w+bKZU2mMZhb3dQnSX6R2JRU5m+8PfZ2mMc/Dm/QpQgei8D0wYr+FgAOjjFkT9bT+GOhaZZaiVb
 JPJkOEtmm/ldxXXoTRBMqgL0tI6KHGbr+dIV9KvQNh4+jt8ZPczJDCJ3w+dF7xsRw1XIPkM22CA
 MEUi6dZug/WLPVVrof2JFnPWcFHLxk8kzN+z/d2bLT2vBsUn1A=
X-Received: by 2002:a05:6402:51cb:b0:6a3:8586:9b73 with SMTP id
 4fb4d7f45d1cf-6a4032b1252mr3685604a12.6.1787157644802; 
 Wed, 19 Aug 2026 09:40:44 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f003bf9bad107298ed5.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:3bf9:bad1:729:8ed5])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff0c327asm1219822a12.8.2026.08.19.09.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 09:40:44 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Wed, 19 Aug 2026 18:40:26 +0200
Subject: [PATCH v3 3/3] test: dm: nfs: add regression tests for the NFS
 reply-length checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-nfs-oob-fix-v3-3-7f8158088b80@byteray.co.uk>
References: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
In-Reply-To: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 19 Aug 2026 17:02:59 +0000
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

Add DM tests that feed nfs_pkt_recv() crafted NFSv3 replies with a read
and a readlink request outstanding. The READ reply carries a data length
with the top bit set; the READLINK reply carries a length of -1 that slips
past the destination bound as pathlen - 1. Either would drive a memcpy()
out of the reply buffer; the tests assert that nothing is stored and the
path buffer is left untouched.

Enable CONFIG_CMD_NFS in sandbox_defconfig so the NFS client and these
tests are built and run under sandbox.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 configs/sandbox_defconfig |  1 +
 test/dm/Makefile          |  1 +
 test/dm/nfs.c             | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 79f46317e45..ca73080b06d 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -123,6 +123,7 @@ CONFIG_CMD_LINK_LOCAL=y
 CONFIG_IPV6_ROUTER_DISCOVERY=y
 CONFIG_CMD_ETHSW=y
 CONFIG_CMD_DNS=y
+CONFIG_CMD_NFS=y
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_2048=y
 CONFIG_CMD_BMP=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index fb3e6a7008f..cc51fd33079 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
 obj-y += fdtdec.o
 obj-$(CONFIG_MTD_RAW_NAND) += nand.o
 obj-$(CONFIG_IP_DEFRAG) += net_defrag.o
+obj-$(CONFIG_CMD_NFS) += nfs.o
 obj-$(CONFIG_UT_DM) += nop.o
 obj-y += ofnode.o
 obj-y += ofread.o
diff --git a/test/dm/nfs.c b/test/dm/nfs.c
new file mode 100644
index 00000000000..e18e5812440
--- /dev/null
+++ b/test/dm/nfs.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regression tests for the NFS reply-length checks.
+ */
+
+#include <net.h>
+#include <string.h>
+#include <test/ut.h>
+#include <dm/test.h>
+#include "../../net/nfs-common.h"
+
+static int dm_test_nfs_read_oob(struct unit_test_state *uts)
+{
+	int saved_state = nfs_state;
+	unsigned long saved_id = rpc_id;
+	int saved_offset = nfs_offset;
+	enum nfs_version saved_version = choosen_nfs_version;
+	u32 saved_size = net_boot_file_size;
+	struct rpc_t reply;
+
+	/* Pretend a READ request is outstanding (NFSv3). */
+	choosen_nfs_version = NFS_V3;
+	nfs_state = STATE_READ_REQ;
+	nfs_offset = 0;
+	rpc_id = 0x11223344;
+	net_boot_file_size = 0;
+
+	/* Accepted reply, matching xid, READ status OK, no attributes, then a
+	 * count and data length with the top bit set.
+	 */
+	memset(&reply, 0, sizeof(reply));
+	reply.u.reply.id = htonl((u32)rpc_id);
+	reply.u.reply.data[0] = 0;			/* nfsstat3: OK */
+	reply.u.reply.data[1] = 0;			/* attributes_follow: no */
+	reply.u.reply.data[2] = htonl(0x80000000);	/* count */
+	reply.u.reply.data[4] = htonl(0x80000000);	/* data length */
+
+	nfs_pkt_recv((uchar *)&reply.u.reply, sizeof(reply.u.reply));
+
+	/* Rejected: nothing stored. */
+	ut_asserteq(0, net_boot_file_size);
+
+	nfs_state = saved_state;
+	rpc_id = saved_id;
+	nfs_offset = saved_offset;
+	choosen_nfs_version = saved_version;
+	net_boot_file_size = saved_size;
+
+	return 0;
+}
+DM_TEST(dm_test_nfs_read_oob, 0);
+
+static int dm_test_nfs_readlink_oob(struct unit_test_state *uts)
+{
+	int saved_state = nfs_state;
+	unsigned long saved_id = rpc_id;
+	enum nfs_version saved_version = choosen_nfs_version;
+	char *saved_path = nfs_path;
+	struct rpc_t reply;
+
+	/* Pretend a READLINK request is outstanding (NFSv3). */
+	choosen_nfs_version = NFS_V3;
+	nfs_state = STATE_READLINK_REQ;
+	rpc_id = 0x11223344;
+	nfs_path = nfs_path_buff;
+	strcpy(nfs_path_buff, "dir");
+
+	/* Accepted reply, matching xid, READLINK status OK, no attributes, a
+	 * length of -1 that slips past the destination bound as pathlen - 1,
+	 * then a relative (non-'/') target.
+	 */
+	memset(&reply, 0, sizeof(reply));
+	reply.u.reply.id = htonl((u32)rpc_id);
+	reply.u.reply.data[0] = 0;			/* nfsstat3: OK */
+	reply.u.reply.data[1] = 0;			/* attributes_follow: no */
+	reply.u.reply.data[2] = htonl(0xffffffff);	/* symlink length -1 */
+	reply.u.reply.data[3] = htonl(0x61616161);	/* target, not '/' */
+
+	nfs_pkt_recv((uchar *)&reply.u.reply, sizeof(reply.u.reply));
+
+	/* Rejected: the path buffer is untouched. */
+	ut_asserteq_str("dir", nfs_path_buff);
+
+	nfs_state = saved_state;
+	rpc_id = saved_id;
+	choosen_nfs_version = saved_version;
+	nfs_path = saved_path;
+
+	return 0;
+}
+DM_TEST(dm_test_nfs_readlink_oob, 0);

-- 
2.43.0

