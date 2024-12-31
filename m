Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E960EE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 16:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37BFF8037B;
	Tue, 31 Dec 2024 17:51:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D548021D; Tue, 31 Dec 2024 17:50:39 +0100 (CET)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D4D801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 17:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 53C188151A;
 Tue, 31 Dec 2024 17:50:37 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Tue, 31 Dec 2024 17:49:12 +0100
Subject: [PATCH v2 1/3] serial: ns16550: Add Intel XScale support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241231-coreprimevelte-v2-1-6a5445d92d11@skole.hr>
References: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
In-Reply-To: <20241231-coreprimevelte-v2-0-6a5445d92d11@skole.hr>
To: Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=38bjGJ0uZ8yV1QCmHVZJHI/rkUXR3CKzkJRzsQoVZJI=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOklCv1d7+RzOgI4lt16qc7R6affaBRpvWX5paW5yyxN4
 /6feSLSUcrCIMbFICumyJL73/Ea72eRrduzlxnAzGFlAhnCwMUpABOx62VkWL/qp/mTIAfL4vDk
 R4ck+N+Ln22+LhpTLffEaNehpu21+xn+6RsGLq6JM5q2af1rEe/b30vcc3b+Cv6bsKmhyVesuWw
 6DwA=
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Tue, 31 Dec 2024 17:51:37 +0100
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

Add compatible string for the Intel XScale variant of the 16550. Needed
to match upstream.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 drivers/serial/ns16550.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 3f6860f39162df74c3d1f03d3f9aa90090216646..eab193395087877d2a8da38e1b4daabf46e81f2f 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -614,6 +614,7 @@ static const struct udevice_id ns16550_serial_ids[] = {
 	{ .compatible = "ingenic,jz4780-uart",	.data = PORT_JZ4780  },
 	{ .compatible = "nvidia,tegra20-uart",	.data = PORT_NS16550 },
 	{ .compatible = "snps,dw-apb-uart",	.data = PORT_NS16550 },
+	{ .compatible = "intel,xscale-uart",	.data = PORT_NS16550 },
 	{}
 };
 #endif /* OF_REAL */

-- 
2.47.1


