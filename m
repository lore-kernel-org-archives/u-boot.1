Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BE1CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 16:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B07D81D6A;
	Thu,  2 Oct 2025 18:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FFF83621; Thu,  2 Oct 2025 18:25:11 +0200 (CEST)
Received: from server.mars-solutions.it (server.mars-solutions.it
 [88.198.47.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D3F8004F
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 18:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=cn-eng.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=apr@cn-eng.de
Received: from nb-apr.fritz.box (ip-078-043-169-169.um18.pools.vodafone-ip.de
 [78.43.169.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by server.mars-solutions.it (Postfix) with ESMTPSA id BB88176A2015;
 Thu,  2 Oct 2025 18:25:06 +0200 (CEST)
From: Andreas Pretzsch <apr@cn-eng.de>
To: u-boot@lists.denx.de
Cc: Martin Schwan <m.schwan@phytec.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 0/2] bootstd: rauc: fix doc and info msg to reflect real
 flow
Date: Thu,  2 Oct 2025 18:24:57 +0200
Message-ID: <20251002162506.3908711-1-apr@cn-eng.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001232259.3599563-1-apr@cn-eng.de>
References: <20251001232259.3599563-1-apr@cn-eng.de>
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

For the RAUC bootmethod, newly introduced in U-Boot 2025.10, both code
and documentation contain some incorrect (maybe outdated) statements,
so they do not reflect the real behaviour.
This series corrects both the docs and one log_info in the code, to now
reflect the real flow. Beside being visible in the code, all of it was
tested on a real machine.

Despite the very late time in RC cycle, I suggest inclusion before release
of U-Boot 2025.10, as the current statements are simply incorrect. Also I
do not see any risk in these non-functional changes.
Thanks to Martin Schwan for the review and esp. the initial code!

Changes for v2:
  - bootmeth_rauc.c: add Reviewed-by of Martin Schwan
  - doc: rephrase and fix formatting based on feedback from Martin Schwan

Andreas Pretzsch (2):
  bootstd: rauc: no valid slot fallback: fix info msg to reflect real
    flow
  bootstd: rauc: extend and fix doc to reflect real flow

 boot/bootmeth_rauc.c         |  3 ++-
 doc/develop/bootstd/rauc.rst | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.43.0

