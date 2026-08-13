Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7C5C5DF67
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 15:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1DC3A409E0;
	Thu, 13 Aug 2026 15:57:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sxlRYeHXFfFY; Thu, 13 Aug 2026 15:57:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3786B409DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786636634;
	bh=kQlMDLk/yzW00ljezRN/Ttww8DHDFneI1y9gQUsIjd4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hgvejZ+NyEP0Q6ZFNMGeoqd4ApvXtkRzev8YfzPF/nS7gDSdtj5eho3GK824BuitC
	 w5YZKzZ5vRP2tHjEw0mkb1OWU7D0kTaSlveyi504YyG0XRG7xb76iotxux36JM5on8
	 Q+ARHSbxK7DXeLN74x0S8GW07DS73/poyq2wDe10zsejDkLfJPqo+EwtDBUDxUQCw5
	 Mecz0qkP6e3T6VeSkGN+8xtMtgdF32n/7R7B82AVlgYQYMz2ct8ZIzGKJS+fkjjSAa
	 eL7z05HGywbLvfcGkh8aa5QuSCFNYY2KV4V0ocGT5MgLpFIKqD20zqx0s6LHGZK49A
	 ynQFs8985d3ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3786B409DB;
	Thu, 13 Aug 2026 15:57:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EC8E198
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2589D40158
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ML07b1CuuLT7 for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 15:48:56 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2F3BE40133
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2F3BE40133
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F3BE40133
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 15:48:56 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso1700769a12.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786636134; x=1787240934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kQlMDLk/yzW00ljezRN/Ttww8DHDFneI1y9gQUsIjd4=;
 b=G4Sk81LIbmHrYhe2csA8aInzRio+gPFcoi1RFCQm2RTTXRuBRYXmsbdUQAuVruLwr9
 CEOIRTUv36Eic5heBBQpYjyVzNBeGk4LhfQbR4WQgi8tu9OiLHkkc4Bu7EcdwbZaQKG2
 G/FuckOvUIdegmDTXWznsBColBVHwdRfhWwqA7CCahy9ammpQd0M0VZ6nJJuUmBwCUnB
 p+7Sfk1vXTRiVg7hv42Udy7W2zwPbz13F40ulgGT51yz41X1GzzsgcGIEBnj9Y4l1gt1
 81bW3U/VZDuiIhn1j5Aayq1m2OwD6gnyKakt8dm6jZwXZZOpXIpElF9K+OOd0abKigkC
 LsKw==
X-Gm-Message-State: AOJu0Yz8UHqwSA+uXpxASPN8VNwE9bkH4EIlystho8C/FXSE9ozwOylQ
 +SISH6h4Onhx7ve8m67YNoBfrzl51fUeuXSY3y9y9kwBE5jYrTYAH0/GlyrHEDvH7Po=
X-Gm-Gg: AR+sD13KJTArd92uoObIfHbWcryY7oXj+uh/u1HfAz8UGKRYzijDoiUnX7U0nzHrFy+
 EQc7gcqjuIfJg26fKmmQucCB1o9a78Iv44Q1+dMN0WgSTvdPGFd3NYK1X6B7y2GKXGeHN05clOw
 e0rIdjkQVUGiimFWYpTRBI+HGCrVsiNHTEMZqjHNrLzNvIYbv/nmjiR9lJjrh2PQn1ntSfarRz2
 heaZlMzNbyLEmyu0A42CMt/uXW8D0CtCyhrodr2t660mYqPNkW1Ne7akibyionn3mJorg6OmbWN
 UMb38Q3EQwVrO0UP1ZSJv/3zJXhUbvwUcZ0IsfBAZ/mTVf7Dw6/ZzPKsx8nKD818u241RF5/urc
 dDweR0+atW1tQzXvWJa71azjlkutb+hmm3SLZ4MwZ5Oh7qC7HJLWLIOP71Xw6JAClf02Cc2FmSF
 J0suw9aNCBW5j5XxxU9D3NxM+PwrB6JARJeG9C2wxwatpqm4DLM1VWCF9KErvQN6D0iBAq4pJ5J
 YHtOCW5GBrTDQlY2TWKgZrKBWX6uVHlLSJ02lY7+1A9ft90U/xo
X-Received: by 2002:a17:906:f5a8:b0:c1f:e9d3:a3f0 with SMTP id
 a640c23a62f3a-c2108ee26admr316982366b.7.1786636134181; 
 Thu, 13 Aug 2026 08:48:54 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f00b49b9d175e416b42.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:b49b:9d17:5e41:6b42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c212378d8d9sm8151066b.40.2026.08.13.08.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 08:48:52 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Thu, 13 Aug 2026 17:48:23 +0200
Subject: [PATCH v2 3/3] test: dm: nfs: add regression tests for the NFS
 reply-length checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nfs-oob-fix-v2-3-80993770518e@byteray.co.uk>
References: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
In-Reply-To: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 13 Aug 2026 15:57:08 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786636134; x=1787240934;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kQlMDLk/yzW00ljezRN/Ttww8DHDFneI1y9gQUsIjd4=;
 b=YkWNNj1dD1BpbJOFiojkj6a4n2Z3ZttIFFTLWi4oQRhhJbWQ+qp+BKNHq92kauUlSq
 lIG71yo5LoxvIKiYW1d4aMIo9xO8MQ1UhUnOwD7NH3HhDtChkmNrpMWvl1PNQnuxc5mE
 UPvIMxISzrf3ccO5SWVlOGRNvIRxXi+i31ajhb+b1dP1Zh4cfuKjB2MoI5DLV//fBB3p
 1Als8KJfaH929yaxe7yUHZzmw8GJx0f6bFKWkgAwmAD1xenIEB2OWDn3OMInwboo2Q5T
 vyKN2vOIhFqvyiPDnPCmD1bXYlmxHCKQs5UUG0R5Fs58R6592/4JBIRW9mjQTbTlv+0t
 S5ag==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=YkWNNj1d
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

Add DM tests that feed nfs_pkt_recv() crafted NFSv3 replies with a read and
a readlink request outstanding. The READ reply carries a count with the top
bit set; the READLINK reply carries a length of -1 that slips past the
destination bound as pathlen - 1. Either would drive a memcpy() out of the
reply buffer; the tests assert that nothing is stored and the path buffer is
left untouched.

Enable CONFIG_CMD_NFS in sandbox_defconfig so the NFS client and these tests
are built and run under sandbox.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 configs/sandbox_defconfig |  1 +
 test/dm/Makefile          |  1 +
 test/dm/nfs.c             | 90 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

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
index 00000000000..c7ab1e912b8
--- /dev/null
+++ b/test/dm/nfs.c
@@ -0,0 +1,90 @@
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
+	 * count with the top bit set.
+	 */
+	memset(&reply, 0, sizeof(reply));
+	reply.u.reply.id = htonl((u32)rpc_id);
+	reply.u.reply.data[0] = 0;			/* nfsstat3: OK */
+	reply.u.reply.data[1] = 0;			/* attributes_follow: no */
+	reply.u.reply.data[2] = htonl(0x80000000);	/* count */
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

