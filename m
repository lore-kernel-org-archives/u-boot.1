Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD2E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 14:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C94883D0F;
	Wed, 18 Feb 2026 15:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="ibP3n9R9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E81802C1; Wed, 18 Feb 2026 15:59:41 +0100 (CET)
Received: from 4.mo584.mail-out.ovh.net (4.mo584.mail-out.ovh.net
 [178.32.98.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12DF83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 15:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.110.43.17])
 by mo584.mail-out.ovh.net (Postfix) with ESMTP id 4fGKRY0wHSz8HFq
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:59:37 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-62b48 (unknown [10.110.101.145])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id B46C3C05B2;
 Wed, 18 Feb 2026 14:59:36 +0000 (UTC)
Received: from armadeus.com ([37.59.142.110])
 by ghost-submission-7d8d68f679-62b48 with ESMTPSA
 id hnYEB9jTlWnVjAAAa7HxRw:T2
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Wed, 18 Feb 2026 14:59:36 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S004cc1c2cc6-1b27-4d45-af80-9b4b3f635183,
 BCC414E58A87BDF8F3171654DA18834A20810328)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 86.243.239.229
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Wed, 18 Feb 2026 15:59:18 +0100
Subject: [PATCH 1/2] serial: lpuart: fix RXFE filed offset for i.MX9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260218-lpuart-fix-rxfe-offset-v1-1-86a78b224f13@armadeus.com>
References: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
In-Reply-To: <20260218-lpuart-fix-rxfe-offset-v1-0-86a78b224f13@armadeus.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Julien Boibessot <julien.boibessot@armadeus.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.3
x-ovh-tracer-id: 15265232412717995721
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGcdss9VIj/m/mQGm7b1Z6eoMkur1vDkfIGe5Y4nnkgxx0BvfE5VBX1jNQMlL7rU0Vdj70IrRf6iM1l38tVWhCJpsRRULLGaFMla95dOQFPtBf8mgT9OImbd3e9nxDTWWVRke8mu7zedMcVmgoroOkzzRhgfFz4xkiyjWkuhADrBmInZg8ByJFX8dlo7TyjdupzitPbrcrbeZeC+wlfbFFKDlKYdueZaEgZH+wS9Rp9XbOsXMIobp1zG/rybsn2hSjKXdc7C87iYXe0J5NbRKA5k9lLmE/ay54DViP6pBSycUyXfcJ/H+TUtURyDzbUuROI1QH08FdNYbPb3P4GkZTdSNnajCLRs0J30iYv8Sqxjy+dlq3c4S2YdgVjLo62iahm2PhWeL5yYxpTjGk6p5Ns11RRiCK0vqcqh+Zj08Bh2EDrCLvYEBoEDXo1BqbgtnzHpBebOj0ysKxCh3wOEJzd+6W9NfeiLVYOFV7XeSrELjzKJgefOoB3tonj7Vm4aPt0CY68UgNHoonOREZrIYNt6iPqnrSD3gIyOimZX53Xo251ivQSPW61G93y7ZcyH4ZfgmuJ0letlhiHilyd+KtIoRN47bbiuB5stYRdxPFr3kCgB6x/zulOKoDCrukdZGoCf7bozO3wDDTBVNJHKPxKyOOqNJHjzK1YLnQwmaz83g
DKIM-Signature: a=rsa-sha256; bh=bG0Eub8cwPAIEBbAecRkZZ2uR4+hSKH4XzICDSFQalM=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1771426777; v=1;
 b=ibP3n9R9ZS4bV3ZIZj4BOqbbL6r/fn5bGcOL25jg7aVXk02aHLaTxnxNud733C/wKSLWtnKP
 VDhjgs5oig784h2p7s439RNHrzt6PsgpukbgP3aqWEPvCuTbicGPaRCp4N/X41tv6qq6GKt96QV
 jVmlYqhGjVwEWYf3ipwIbVG7tcDm/0TUvyBKi0B4ayPFPHVSSJ+Q7kplatJ/N37vqDMclbZVXyb
 FB4OnbHvCwZty6qVPl+rJYf0f+Pk6LT7VqAtCw/MbYRuZENMx3qoXmQwrgMykLMW/AkRM+j7Hr9
 m8a3/MRTpze/Y21cZlFTfaCK2HkexNvKe3bW0GQtG95rA==
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

Like i.MX8 and i.MXRT, on i.MX9, the Receive RX FIFO Enable (RXFE) field
in LPUART FIFO register is bit 3, so set FIFO_RXFE to 0x08 on i.MX9 too.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 drivers/serial/serial_lpuart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index 9fdb6503085d..bbce59443388 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -53,7 +53,8 @@
 #define FIFO_RXSIZE_MASK	0x7
 #define FIFO_RXSIZE_OFF	0
 #define FIFO_TXFE		0x80
-#if defined(CONFIG_ARCH_IMX8) || defined(CONFIG_ARCH_IMXRT)
+#if defined(CONFIG_ARCH_IMX8) || defined (CONFIG_ARCH_IMX9) || \
+    defined(CONFIG_ARCH_IMXRT)
 #define FIFO_RXFE		0x08
 #else
 #define FIFO_RXFE		0x40

-- 
2.52.0

