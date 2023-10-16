Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0717DC41513
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 137AD86C3F;
	Mon, 16 Oct 2023 11:26:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9752B86B1D; Mon, 16 Oct 2023 11:26:09 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id CB55986C3F
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,229,1694703600"; d="scan'208";a="179418291"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 16 Oct 2023 18:25:58 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.82])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4F78E41F9378;
 Mon, 16 Oct 2023 18:25:56 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 01/21] serial: sh: Fix compile error when lacking HSCIF
 support
Date: Mon, 16 Oct 2023 10:25:23 +0100
Message-Id: <20231016092543.3833-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If we attempt to compile serial_sh.c for a system which lacks HSCIF
support (e.g. R8A7740), we see the following compilation error:

    In file included from drivers/serial/serial_sh.c:20:
    drivers/serial/serial_sh.c: In function ‘sh_serial_init_generic’:
    drivers/serial/serial_sh.h:429:35: warning: implicit declaration of function ‘sci_HSSRR_out’; did you mean ‘sci_SCSCR_out’? [-Wimplicit-function-declaration]
      429 | #define sci_out(port, reg, value) sci_##reg##_out(port, value)
          |                                   ^~~~
    drivers/serial/serial_sh.c:62:17: note: in expansion of macro ‘sci_out’
       62 |                 sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
          |                 ^~~~~~~

To fix this, only try to support access to the HSSRR register for SoCs
where it actually exists.

Support for the RZ/G2L will be introduced in following patches, which
selects CONFIG_RCAR_64 but does not have HSCIF interfaces, so check for
CONFIG_RCAR_GEN2 || CONFIG_RCAR_GEN3 || CONFIG_RCAR_GEN4 to determine if
HSCIF is present.

Fixes: bbe36e29ca2c ('serial: sh: Add HSCIF support for R-Car SoC')
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
v2->v3: No changes.
v1->v2:
  * Improve commit message.
  * Add Marek's Reivewed-by.

 drivers/serial/serial_sh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 20cda5dbe272..5e543dbf3d58 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
 	sci_out(port, SCSPTR, 0x0003);
 #endif
 
+#if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4)
 	if (port->type == PORT_HSCIF)
 		sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
+#endif
 }
 
 static void
-- 
2.39.2

