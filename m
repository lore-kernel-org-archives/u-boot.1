Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC32C5CFC1
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 23:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4424A608CD;
	Tue, 11 Aug 2026 23:05:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nee9zRL275xe; Tue, 11 Aug 2026 23:05:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1392608F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786489508;
	bh=CYg3rxeq1i5c58ykU0zZvk5kjINK4AHC/30/44xcBM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UurikbQc7gZLbmIE4f0ejBpz02iIrrPFMnwwKj13pAQpb5PTwJACp/ERWXkPr0/ED
	 2ugjd1IgwUu9RK/Q3GfP/Kl05KILpFWbtyQCEoFhKW7dn+NkZMgLjUQfjIsxW7CPo2
	 5CYq5LdYklToNb+ihpQOkypkXHJos5wCrv6qAhUNT25T8n35Ekk767QRr9JlDrR3WS
	 sYeKrdaTvVVYX6TMBXTItpKIVhIIhF4jsCDoHiXa4eE+iD5yEfav51X0Ig7Fx4QstP
	 Xl1aeUnkXZr8LYxk0FDXxRurIhmD/LoCluIT4UDdjHgwd6qR97ZqLT5Xsu2sSflOEi
	 3yNd3v+WxCEHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1392608F3;
	Tue, 11 Aug 2026 23:05:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E01B840A
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:12:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D18F840511
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuRCdG_nDyWV for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 19:12:06 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::131; helo=mail-lf1-x131.google.com;
 envelope-from=shahriyar@byteray.co.uk; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D430040430
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D430040430
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D430040430
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 19:12:05 +0000 (UTC)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5aeba09900bso121241e87.2
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 12:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786475523; x=1787080323;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CYg3rxeq1i5c58ykU0zZvk5kjINK4AHC/30/44xcBM0=;
 b=ZNnqXpfzcMbRbJritc+uOJmwFFNUR5XBcFxf5nWdb7bBnnuUsHkGTPOw5hZSzqOM+Y
 zW9slf4OavYBMuH4pu1HQyiilqwm3CBrYLUam/IwbCmBYJgY9txPxXYqT19h8hrZq4yg
 7XgaGqR3FqyPH+lnLNzcFu69ki2TJDflghRK/jLlB/a989Gv+Wfl908kOM8DZ7Mu8rhK
 oeuIJ9mLKrhswTwDlNG/01laYMdVL2zObdPk1P3nQPM7DpzbqeYvdkUjEMI1vt0jfooz
 v2TTg5Vx/AvQ1/8AU6fOG7BTNoejr14Foq4FacmRhHSQBv8wWLOcoyaCUOvr2xHtqeGr
 hjCw==
X-Gm-Message-State: AOJu0Yyk2IhzNIiRPEnR7v2Iy+oEnLaZt5a2G5531/iiJV6IvfL950Vb
 2Q/5a3mubXOiE1L1x8WmePKCAmhMpwHoFDDwfaF9hTfPsHAtkv89au1/9n0HbVBRP0OXmqTRIKE
 2mnSnQ/w=
X-Gm-Gg: AR+sD11MXrrDvtvMGwOrdN2IMw7bAE3dm3i9zMxdPEAJdqg4HLbJuN00PKoTIsay2mS
 plCNnO1YR75M3oujvIWVAscofhhO6meItRvVA2/RlQAiOBQcmNRUSSL03dM7XueQOcImJhxPBak
 hr7ka0BMWeRGXZjulANJ5TeGWVcNytFlLVbNr9/qStz9+Gk/KbQ9bKgq9veC8l2ffJnj3SDk2+O
 lYJGAlbaDX4uSBOAAqXWaLS+Rww84pi1HtkqgxYoiqVgKyYpIm6+jVctqQyaH0e/TNmMl0Pq79I
 vPt9NNhbDhme6SIFhQucB3QJ4Gqltt3pLcQYs2PooCXOtblXnwIc4s7uiVP8g8fLlxtBlJOjZ4K
 JXclLTTJqyKhr6YJRnYQ5f5ObW6Lla98xVYP4w5ppfshK3YXSTWDm/wpQLkoeGB16nCrGv1C6Pi
 ZdPKxDNf5n6NmUQy/xZILdI/2vk+1FTOkRSXUOOrccOOZZMeaSiLKDu3Lxs4Ro3OwLuZ1iXGikz
 YqYiMqTU32lT6wnljcNhlHZ+tUmqdtxKpgzS2r4HFxCOgcwDKCqCg==
X-Received: by 2002:a17:907:3e95:b0:c20:ab45:276e with SMTP id
 a640c23a62f3a-c20e6245c55mr271989766b.29.1786472178775; 
 Tue, 11 Aug 2026 11:16:18 -0700 (PDT)
Received: from [127.0.1.1]
 (p200300ff0f038f001cf8ed71865ce089.dip0.t-ipconnect.de.
 [2003:ff:f03:8f00:1cf8:ed71:865c:e089])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c20f0a9d52asm2288066b.33.2026.08.11.11.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 11:16:18 -0700 (PDT)
From: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Date: Tue, 11 Aug 2026 20:15:49 +0200
Subject: [PATCH 2/2] test: dm: nfs: add a regression test for an oversized
 NFS read length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-nfs-oob-fix-v1-2-5444d86d28d7@byteray.co.uk>
References: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
In-Reply-To: <20260811-nfs-oob-fix-v1-0-5444d86d28d7@byteray.co.uk>
To: u-boot@lists.u-boot-project.org, 
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, 
 Argus <argus@byteray.co.uk>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Tue, 11 Aug 2026 23:05:00 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=byteray-co-uk.20251104.gappssmtp.com; s=20251104; t=1786475523; x=1787080323;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CYg3rxeq1i5c58ykU0zZvk5kjINK4AHC/30/44xcBM0=;
 b=HrDmxgHKTuyfAFQr1Us5FRz7JSJSvtT3qz6fpgAjYT3ll1iGi9th++aXVzfepFBQhB
 Ns2G8I62Yx0y6Oh4Lq4T6I0iB2xvp9DDsL0HTrxksIuzudUa5lp57nSiog2xGUHT88oN
 t+THkqt0jj5HtIAvZgkRLgwa5HgkoZ4iG38dJeI1aDxZEljyNk+s0eFpr7PzZ2LM+FWn
 I8YQec3D/xz7VDvk2jPawxPSlVf96JAoPkbQvNFd5m6N6+n/zDX8DG/EQ8cmaKfttaoI
 qhYLL4xVjuq7LrfLMfGWFlAwMt94uX9UNeX8l0/oZ3Kjib0mbLu4299toyckx6kD6bfF
 dLsQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=byteray.co.uk
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=byteray-co-uk.20251104.gappssmtp.com
 header.i=@byteray-co-uk.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=HrDmxgHK
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

Add a DM test that feeds nfs_pkt_recv() a crafted NFSv3 READ reply whose
32-bit count has the top bit set, with a read outstanding, and checks
that nothing is stored. An out-of-range length reaches store_block() and
drives a ~2 GB memcpy() out of the reply buffer, which CONFIG_ASAN
reports as a stack-buffer-overflow.

Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
---
 test/dm/Makefile |  1 +
 test/dm/nfs.c    | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

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
index 00000000000..abfa75f1941
--- /dev/null
+++ b/test/dm/nfs.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regression test for the NFS read-length check.
+ *
+ * A crafted NFSv3 READ reply whose 32-bit count has the top bit set is fed to
+ * the real nfs_pkt_recv() with a read outstanding. The signed length reaches
+ * store_block() as a ~2 GB memcpy() out of the reply buffer, flagged under
+ * AddressSanitizer; the fix rejects it and stores nothing.
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

-- 
2.43.0

