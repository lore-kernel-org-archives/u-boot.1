Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF401CD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:19:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1D584702;
	Sun, 10 May 2026 19:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JAIcOu8m";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wuMYtnh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7B184855; Sun, 10 May 2026 19:18:10 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9759C846F8
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gD8h03Fv7z9tBc;
 Sun, 10 May 2026 19:18:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9rEuQ7poW2OIEIcY7fcRnLheAPbfhwSvioYrwkuIRUY=;
 b=JAIcOu8m4gdk2ki4kV6gVwaQVG8cB5AxcYn29AFxcEdnxvkFf0Sa3kmBl39lgTmh5FMHDg
 Orh1hsGwpZauc7j/mLdqXiw2TjDXRK0Bf62qi/TfyuQDKUEvWjC/RczKpbxmp85KrmEKnV
 WJaHshQiWkTtR7Do2zCqhY5ffUb1EoB7u0Sce2ZRrcjbCgaDol0V1muW2kcmBZdAE1/WS4
 GBC5g1pTjxWBQ1igH4S3YSxjR45Plb9jLoM740cdxcm3m9XT9BiiUlOBi1pqbAV5OSNoaT
 9JWLi8O7ptmoJZy44U2O+WBeKPrBrGtGZHhOzoE0bebj6121aaPmxbkMESIMrw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9rEuQ7poW2OIEIcY7fcRnLheAPbfhwSvioYrwkuIRUY=;
 b=wuMYtnh3fGGdxH5VF2n8G+VsFVjpu1ewSSoLYgLTQpA+vS2zNVb/KAuhO6xpQjtyIXBKyy
 IFX5cap7OUNAVUMxvBkijXQjIRICrId+dsUqPaJUAhsP6GJsXagpDsCnyvOVlKLzJe9moY
 eP2CnFrGTdSEv9bsUx+60M4wx9epVmqsnVDJNrpzPtrBKpAXZferkbfxhYM6JWloIvaD5O
 RFR+7D0EfpgKajuEa/iY+wWZ3qVomXKCeQ+7CYnB7leVDJQ2R8ZkmM3iJUB/Gg3zZ0FMCE
 1m+MTaUzPeZclM3ALhnENVJlmVd5A0EhhgSQ2Jo2HcjUJd4dZJgNjSLksE4Gwg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Adam Lackorzynski <adam@l4re.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] virtio: Staticize and constify driver ops
Date: Sun, 10 May 2026 19:17:53 +0200
Message-ID: <20260510171802.56897-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1ab02804cac6de5474c
X-MBO-RS-META: kf6urdxbfzsxfairqkipthpmf81wzqt6
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

Set the ops structure as static const. The structure is not accessible
from outside of this driver and is not going to be modified at runtime.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Christian Pötzsch" <christian.poetzsch@kernkonzept.com>
Cc: Adam Lackorzynski <adam@l4re.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/virtio/virtio-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c36e9e9b3a7..6e4a3d7a7c1 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -400,7 +400,7 @@ UCLASS_DRIVER(virtio) = {
 	.per_device_auto	= sizeof(struct virtio_dev_priv),
 };
 
-struct bootdev_ops virtio_bootdev_ops = {
+static const struct bootdev_ops virtio_bootdev_ops = {
 };
 
 static const struct udevice_id virtio_bootdev_ids[] = {
-- 
2.53.0

