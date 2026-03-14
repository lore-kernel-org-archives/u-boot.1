Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D39BFD88ED
	for <u-boot@archiver.kernel.org>; Sat, 14 Mar 2026 06:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D538420C;
	Sat, 14 Mar 2026 07:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b31Xebaa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5918420D; Sat, 14 Mar 2026 07:03:07 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F84841D5
 for <u-boot@lists.denx.de>; Sat, 14 Mar 2026 07:03:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d750eeaec3so1050937a34.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773468184; x=1774072984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dpe3CQffiAyL70COgT390AJ91jJAW2iamb1sMWOCkx8=;
 b=b31XebaaI4cSxycOujClay8m1BFJeH54KsxPr//ND7Yf4f+oqZez0tHCvF+da1s81u
 Gn8hp5oaDOG6uvAoHp6pjUwUXYGj69ZX4Q2a1oPcWc+SZHvNsWE3mykvbi18syDugAJ/
 lBU5h8oyniNUBpgBvu6pCIHYDzMLdig98zHxg1voqW2oWeA1wn9vin0h62QMcRxUfmb4
 1P1+Y8Bh5nP+62z2aU2U5T/A56vhkXM0qpusyCdFGE41QfMXDaOKjTCm3xyPnVX2UTvB
 aDx/806kkUhuynu6Wze4HumLv/YdGKilGvq2kg+fvdXhA57k89DISNSABYmTNI7erndJ
 XClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773468184; x=1774072984;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpe3CQffiAyL70COgT390AJ91jJAW2iamb1sMWOCkx8=;
 b=rzB4VFmbvah4DMD1X0mUiYNyM5GdqV+kMexFwLF1hFefbMkLNZiG6n05RjoI4pblQ4
 ZWP1v57HbBWNx9CvD5QNiAXEO2vb4tR5Q4LxVWJ8uacnpiIvttxQiiTlCNzlGuG77hVu
 oO6OCMm3IkUrkPb1pD5Z23qq4gEqC3/B9edhs+D3gIDmaY+0SOGZ6XWGc/VRJbVS3JDL
 6EUA/GWkCgjiXiG1P5MQwVtGTSYxF4IrKka61XRqCvP5RANlMgNv2Fbxx4NF4B97GsdX
 +NwnbQtmAYWQYCwMgk+d7l9O+Fy2TabHKLpisMaeZ7G4VfJ7yGEUiqM3iTGC84zBdR2W
 NYMQ==
X-Gm-Message-State: AOJu0YwUfWvnhU/L/zsc0+jq0lBLQBeaur/jMN11ABwk6t14+GlbCX16
 9BGv1QL+m9K+19LyJdXM0orKExhozNzoKx5hoYlPA/0W2JIdRBkOTxMk8UdwTg==
X-Gm-Gg: ATEYQzxIoKcCa10Q9lARJXEemfQLFmE0MqnMe5LHX8qRZ6AEiGL8in+f9hvblAaMgd/
 o4GvD6cSBs1yihLjMkZWInm9Z++3C4oaenM0tJ+c2X8kDPQGoTrNZgPpggmTn7GiKgadSVJoBDw
 ViTxF3X1XPxMFE8h8UhjP77JQmbVS9ZMk5hbl7+C1LawzCe5VsfkyA3Usm10uKT+4lCqODZol6y
 jsC9YSbrEdTwTfTSV/9FWjjfkvAnNKznySxClP3yOipsclGS78Qb8pkR8vt4cqmcytUOAA9xzXh
 Fu6adapybnrtH36py0b2I318yM5LQQNUf6J25LktNve4kvhAF9xdIgJHnEKLyC0Qlf9JfLfHFBY
 yQugJgNoGTJnGKdM7lFqK4FKE4MQCn7xq3HdVhpFnYyTcn4sIpq0ThHyXcSW2CYRhNu5QjsqdFz
 1r3cQ8u1LjZVIFjL0b+2TyjhH/42OxRmnhwurdP0Db7msJqIZd8QRVZLTJ2wILlbdaxRk5EPSdU
 AqNrz85Br2y8I0QwbgSM4OzcaRSAekOhVlmvLzmXmVtk64nwGT3eoUTEdOr
X-Received: by 2002:a05:6808:181b:b0:467:2dc5:f4cd with SMTP id
 5614622812f47-467570e9e73mr2837231b6e.27.1773468183777; 
 Fri, 13 Mar 2026 23:03:03 -0700 (PDT)
Received: from james-x399.localdomain (71-33-158-51.hlrn.qwest.net.
 [71.33.158.51]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46734160cebsm6051301b6e.7.2026.03.13.23.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 23:03:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Paul Kocialkowski <contact@paulk.fr>, Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Liya Huang <1425075683@qq.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Icenowy Zheng <uwu@icenowy.me>, Mikhail Kalashnikov <iuncuim@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: memory: allwinner: add sunxi DRAM type
 constants
Date: Sat, 14 Mar 2026 00:02:48 -0600
Message-ID: <20260314060256.381642-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Add constants for the Allwinner DRAM type values used by the H616 DRAM
profile binding. This allows U-Boot DRAM profile nodes to describe
allwinner,dram-type numerically instead of using string literals.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 include/dt-bindings/memory/sunxi-dram.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/memory/sunxi-dram.h

diff --git a/include/dt-bindings/memory/sunxi-dram.h b/include/dt-bindings/memory/sunxi-dram.h
new file mode 100644
index 00000000000..c0a3201123a
--- /dev/null
+++ b/include/dt-bindings/memory/sunxi-dram.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEMORY_SUNXI_DRAM_H
+#define _DT_BINDINGS_MEMORY_SUNXI_DRAM_H
+
+#define SUNXI_DRAM_TYPE_DDR3		3
+#define SUNXI_DRAM_TYPE_DDR4		4
+#define SUNXI_DRAM_TYPE_LPDDR3		7
+#define SUNXI_DRAM_TYPE_LPDDR4		8
+
+#endif
-- 
2.43.0

