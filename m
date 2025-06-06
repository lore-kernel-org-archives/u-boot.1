Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60612C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:29:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67F682977;
	Fri,  6 Jun 2025 06:29:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Qbjrt9rN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45753807B1; Fri,  6 Jun 2025 06:29:34 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A4F282AAA
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:29:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 3970425F7C;
 Fri,  6 Jun 2025 06:29:32 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wloz1wC13efn; Fri,  6 Jun 2025 06:29:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749184171; bh=EGfFPVxQ0ABoxrUvqjpVcI9aAGTKPbuYGY/fe6eHQvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Qbjrt9rN5bPwPks6id1hlPT8YpRwaIAfbTocgCQOVvrGh/sTAs00OBXgPGad30pd2
 5K7ahumSdVxt/5pctx77Mlbhl4rlv3tNcboZm29jJHrmDxNeNXu3QHl08AjEfXWl0l
 YjJhYyGf7Gf7AT79pYQ3RXLjo3ksJUVQ8ox4hwX07MioX8N6lwpVt08o9rEonKdg0X
 R4Cn0XkGKoYfcnfkpIkuOlLJJ3PLMB383CG7/rwpDs/conyPKLbHuwArgUkR3I5Wl9
 ZeKFoCIWa/d7X29+YnF8OyHIGk0bkGuZ+x8Iae2WEmo4QN0HnA+oxJw23UboNF6dAX
 o0yNyC6oyxRrw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Yao Zi <ziyao@disroot.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 5/5] board: thead: licheepi4a: Bring up secondary cores in SPL
Date: Fri,  6 Jun 2025 04:28:04 +0000
Message-ID: <20250606042804.64311-6-ziyao@disroot.org>
In-Reply-To: <20250606042804.64311-1-ziyao@disroot.org>
References: <20250606042804.64311-1-ziyao@disroot.org>
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

Setup core information and bring secondary HARTs up for a functional
multi-core system.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 board/thead/th1520_lpi4a/spl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/thead/th1520_lpi4a/spl.c b/board/thead/th1520_lpi4a/spl.c
index 25dfa387c36..d75fa6f3eff 100644
--- a/board/thead/th1520_lpi4a/spl.c
+++ b/board/thead/th1520_lpi4a/spl.c
@@ -39,6 +39,9 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("failed to bind CPU: %d\n", ret);
 
+	riscv_cpu_setup();
+	th1520_kick_secondary_cores();
+
 	spl_dram_init();
 
 	icache_enable();
-- 
2.49.0

