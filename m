Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD76BFF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 13:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C1784150;
	Tue, 28 Apr 2026 15:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="QACMwA1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4847D84255; Tue, 28 Apr 2026 15:36:53 +0200 (CEST)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ED7D84119
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 20260428133646f27b00de570002071a for <u-boot@lists.denx.de>;
 Tue, 28 Apr 2026 15:36:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=PrFmIxoBdPv3IfcUDSpApUyENmYYifurYcOqeQyJDbw=;
 b=QACMwA1Xo0Tb/dgiRTf+xIcszcVJSJvUERo+BKTq1OKHObajxeUnKOPhjczTDylhaxBO6n
 OYY2dypbTtjhqF6hmcMyHvzns0fSNVhmSdoec6qPPvGYgA1W5dTA8YcWT47QUoBsiUnoOw4Z
 q2XUqNUOnit9/7g1fbkIP/05QU9/gS1RWVfZY7JcaDoSQ7SzkChWo3DAQ5ozo7g0Y+1moBLq
 EdXV1J/lLR38MXOToS04my2ubUskUe0TJserUhtTaug2+R75N8TftYPabJ7Mju3AFp0rHJAK
 tg2hDHhQSCnlyMwbT14chHO0/5CGsIZB0Ao7Pmlp+pnOBkxOJJJ4pKIA==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>,
 Adam Lackorzynski <adam@l4re.org>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] virtio: ignore ENODEV for boot device hunting
Date: Tue, 28 Apr 2026 15:36:02 +0200
Message-ID: <20260428133612.669105-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
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

'Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
failures")' returns -ENODEV in some situations. That breaks boot device
discovery. Ignoring that error seems to fix the issue. Not sure it's the
correct thing to do though.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---

 drivers/virtio/virtio-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c36e9e9b3a7..48b5ef288b0 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -382,7 +382,7 @@ static int virtio_bootdev_hunt(struct bootdev_hunter *info, bool show)
 	}
 
 	ret = uclass_probe_all(UCLASS_VIRTIO);
-	if (ret && ret != -ENOENT)
+	if (ret && ret != -ENOENT && ret != -ENODEV)
 		return log_msg_ret("vir", ret);
 
 	return 0;
-- 
2.43.0

base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
branch: us-virtio
