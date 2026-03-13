Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60849105F797
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:43:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 694998427F;
	Fri, 13 Mar 2026 11:42:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HZSSWI1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9492842CC; Fri, 13 Mar 2026 11:42:51 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B476842DB
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D8B82C42705;
 Fri, 13 Mar 2026 10:43:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id BAC3A60027;
 Fri, 13 Mar 2026 10:42:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5732710369E9C; Fri, 13 Mar 2026 11:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398569; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=J2EBqnlf5lXPaxTEvQL+ZHvKQcSWkXa/IN6u6ke51dI=;
 b=HZSSWI1tXQDuylztROpPiHLEKydnV9HmoTKqWMNtlHQsDqmXqFZ563g+9Qa6AaEze/m6G8
 a9DfVGXaNgMiLWCl7NGY+6l1G33fXXt+zXhX2iyQ4JncsLNalmL4niIJNN2ASS3ZPZG4jL
 HFv3XlA1SZU+6XT7sumDJPkUfRrWtJUo0HbkJcy/E3CZzONyLxv4V3eHyaYszaMFYnGjQU
 3e+uDCNUH3VWUvfyXn40Ojd1B5IpcG8HBZ1aO55erSMVqseaPhHH/TPPAAkAGYNaITKehg
 mLlmJdM+meKcYauJBc+fnZKyEa+Dm5icA5lO6II238yCK6wQ14PqlKOj1EshHA==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 6/7] =?UTF-8?q?MAINTAINERS:=20SQUASHFS:=20update=20Jo?=
 =?UTF-8?q?=C3=A3o=20Marcos=20Costa=20email?=
Date: Fri, 13 Mar 2026 11:42:28 +0100
Message-ID: <20260313104229.1555236-7-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

João is using his Bootlin address now.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2040fee2523..73be3d545fb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1768,7 +1768,7 @@ F:	drivers/spmi/
 F:	include/spmi/
 
 SQUASHFS
-M:	Joao Marcos Costa <jmcosta944@gmail.com>
+M:	Joao Marcos Costa <joaomarcos.costa@bootlin.com>
 R:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
 R:	Miquel Raynal <miquel.raynal@bootlin.com>
 S:	Maintained
