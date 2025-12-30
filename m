Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2770EE0213
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:45:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E980083F64;
	Tue, 30 Dec 2025 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="M6XxKPS2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6EE83F66; Tue, 30 Dec 2025 16:45:47 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D175183DA9
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manjae.cho@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20251230154540epoutp030826e77a6d26b186133ee8d032a2aebf~GCMPFa6Tl3176431764epoutp03y
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:45:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20251230154540epoutp030826e77a6d26b186133ee8d032a2aebf~GCMPFa6Tl3176431764epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1767109540;
 bh=cq7zB8IZNQqUUVirsRhMFVNIRVXin00RO/zJLsuFkes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=M6XxKPS2uf7PD3tGMJFpR1ZOkaJ4v3MsJl3FPSYTWzbHXf/y8K4gQQCijYZfQ/4TA
 +JJ34ep2QM94vFcQPOd2TjCicFUYbgwIbU0w0n/xZ59PHaGtPaVw/3nIVdCyhkdOT5
 FJcxplPm8gcn6NOS90eTb64Y07LdBzM8g7oKvOQY=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
 20251230154539epcas1p420fd504eb8645d31bae641aeb1c671d2~GCMOB4UmZ0820208202epcas1p4W;
 Tue, 30 Dec 2025 15:45:39 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.191]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4dgcql2Xm7z6B9m7; Tue, 30 Dec
 2025 15:45:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20251230154538epcas1p3c81074e2d53b6536684df64fcb04dd83~GCMNUQBvk2017420174epcas1p3x;
 Tue, 30 Dec 2025 15:45:38 +0000 (GMT)
Received: from manjaecho-VirtualBox.. (unknown [10.89.15.251]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20251230154538epsmtip128ce32fda89c42f901a3f78d5d936ae6~GCMNPZtV_3037230372epsmtip1i;
 Tue, 30 Dec 2025 15:45:38 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: u-boot@lists.denx.de
Cc: heinrich.schuchardt@canonical.com, trini@konsulko.com,
 sujin.u@mobis.com, Manjae Cho <manjae.cho@samsung.com>
Subject: [PATCH v2 0/2] Improve QEMU emulation documentation
Date: Wed, 31 Dec 2025 00:45:27 +0900
Message-ID: <20251230154529.29724-1-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251227142036.10661-1-manjae.cho@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251230154538epcas1p3c81074e2d53b6536684df64fcb04dd83
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251230154538epcas1p3c81074e2d53b6536684df64fcb04dd83
References: <20251227142036.10661-1-manjae.cho@samsung.com>
 <CGME20251230154538epcas1p3c81074e2d53b6536684df64fcb04dd83@epcas1p3.samsung.com>
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

This patch series improves QEMU emulation documentation by fixing a typo
and adding network device documentation based on actual runtime testing.

Changes in v2:
- Split original single patch into two separate patches per review feedback
- Moved network testing content to dedicated doc/board/emulation/network.rst
- Simplified and verified content through actual QEMU testing
- Typo fix is now a standalone patch

The new network.rst was validated by building U-Boot for RISC-V and testing
with qemu-system-riscv64, verifying:
- VirtIO network device detection
- DHCP functionality
- TFTP file loading

All command outputs in the documentation are from actual test execution.

Manjae Cho (2):
  doc: qemu-riscv: Fix typo in pflash section
  doc: emulation: Add network testing documentation

 doc/board/emulation/index.rst      |  1 +
 doc/board/emulation/network.rst    | 58 ++++++++++++++++++++++++++++++
 doc/board/emulation/qemu-riscv.rst |  2 +-
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/emulation/network.rst

-- 
2.43.0

