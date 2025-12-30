Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5C5EE0218
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 15:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3788183F6C;
	Tue, 30 Dec 2025 16:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="nblDePpq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E658483F63; Tue, 30 Dec 2025 16:45:48 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2F483F63
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 16:45:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=manjae.cho@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20251230154543epoutp019e79ad4520b5a793603c2e1adb936eb2~GCMR6vSVk1668216682epoutp01Z
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 15:45:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20251230154543epoutp019e79ad4520b5a793603c2e1adb936eb2~GCMR6vSVk1668216682epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1767109543;
 bh=wwP2oQUxgWWSBdtVqqNCVPn7W4a6/E4Xz53J40u19NE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nblDePpq01EVzjRwdSa693NYU6qPla8ypCn5sHEj1+cDwmktVL+5x2F+SIC4yO7Fv
 eqZ7z2S7mVPCT9CiKdJ3e9GI2Xn2RQK2jvyowni0+s7QPf//8NTYem3j10L4XlcsUb
 kz7ZO/PrIfdZ67Vgl8AH33b7IEslQOotoa0jQzPM=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20251230154542epcas1p1413a4a344763ed1d3516d2272c4c7dbc~GCMQ1niO_2558225582epcas1p1F;
 Tue, 30 Dec 2025 15:45:42 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.119]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4dgcqp1SyHz6B9m4; Tue, 30 Dec
 2025 15:45:42 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20251230154541epcas1p41f32f038a6bdb44a31dc9c7567e06474~GCMP5oEK90820208202epcas1p4Z;
 Tue, 30 Dec 2025 15:45:41 +0000 (GMT)
Received: from manjaecho-VirtualBox.. (unknown [10.89.15.251]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20251230154541epsmtip13acd5244566bc29eb78a45233c41edfd~GCMP3w-h63032630326epsmtip1M;
 Tue, 30 Dec 2025 15:45:41 +0000 (GMT)
From: Manjae Cho <manjae.cho@samsung.com>
To: u-boot@lists.denx.de
Cc: heinrich.schuchardt@canonical.com, trini@konsulko.com,
 sujin.u@mobis.com, Manjae Cho <manjae.cho@samsung.com>
Subject: [PATCH v2 1/2] doc: qemu-riscv: Fix typo in pflash section
Date: Wed, 31 Dec 2025 00:45:28 +0900
Message-ID: <20251230154529.29724-2-manjae.cho@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230154529.29724-1-manjae.cho@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251230154541epcas1p41f32f038a6bdb44a31dc9c7567e06474
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251230154541epcas1p41f32f038a6bdb44a31dc9c7567e06474
References: <20251227142036.10661-1-manjae.cho@samsung.com>
 <20251230154529.29724-1-manjae.cho@samsung.com>
 <CGME20251230154541epcas1p41f32f038a6bdb44a31dc9c7567e06474@epcas1p4.samsung.com>
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

Fix typo 'addtional' -> 'additional' in pflash configuration
documentation.

Signed-off-by: Manjae Cho <manjae.cho@samsung.com>
---
 doc/board/emulation/qemu-riscv.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/emulation/qemu-riscv.rst b/doc/board/emulation/qemu-riscv.rst
index b5948d9affc..229a7700ac7 100644
--- a/doc/board/emulation/qemu-riscv.rst
+++ b/doc/board/emulation/qemu-riscv.rst
@@ -43,7 +43,7 @@ qemu-riscv64_smode_defconfig instead. Note that U-Boot running in supervisor
 mode requires a supervisor binary interface (SBI), such as RISC-V OpenSBI.
 
 To create a U-Boot binary that can be utilized with a pflash device in QEMU
-apply these addtional settings to qemu-riscv64_smode_defconfig:
+apply these additional settings to qemu-riscv64_smode_defconfig:
 
 ::
 
-- 
2.43.0

