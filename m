Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC35DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 23:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0876F83957;
	Wed,  5 Nov 2025 00:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="HZlwbt4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C758839AC; Wed,  5 Nov 2025 00:42:37 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5522F83942
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 00:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (unknown [93.94.208.154])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 842693FAEF; 
 Tue,  4 Nov 2025 23:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762299753;
 bh=HWyLV3e44eaXexMCQ4RXIKRONEqUCmCOcxi7E1x8KIg=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=HZlwbt4x8nEvAr+lEqv8sUTt8+omtvSbT6XrTSei+d2f0l7ET0siBgkHKPFcQh50O
 bt0vNp9GSudZrzcjY0Oyw11zT9qUXqDTycUqyI/W/DOpbboFHQQEyzUhHcTsmqkAky
 MxHbEvYGPwpX0JYy/1Lge30kWJQYVmM3Ff5VmVnqVr8yLGvmP5kM4690Q183+73ZJm
 Bgn5QTQl4Be0sxxPhkjbgp7W7xKqf145FRil8CD4etEgY+Ms+uUyL0nwseIXSBd8zZ
 G0x3dlgCM8RU5mrkVOFfm+ZbQne5QvN0Nlr4Ed5H8z+q8SdXmclfyyBCITrb5XmpAO
 cjyQeKqttTXxI7pZwCheqqf1SUSIflxHIVhgXune9VHvlQodzDs4U7vq+U+jRWkcmm
 nsfgJ8/U0VYGHItIw51YzrWWvTZX1+/vLAMkSGFFtSCNt+oRruesz9c0XeujobhhtV
 prvQ/5gtyi6r0HhxUbvvfoya/RvdxlRLZdvEXXqzEAXIj/+aE7JfL9ARbh/K1w/cSJ
 PtXtUUcAQcOhYoTY4apwr9TPTgXyZKWjHSD/cHYbCYrQ+GnMrK04gNMAb84jVzG0u/
 Bo/lWoG3GZiyDESwlE048h+qHb1kOMIudJBMjoNjii8k7wfJYtF8m4g0N3RPIM8ZhW
 BKXC6JIwnkKWRXjhSUKhD1SA=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] virtio: typo 'private date'
Date: Wed,  5 Nov 2025 00:42:31 +0100
Message-ID: <20251104234231.89796-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/private date/private data/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/virtio/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index ec2e28b54f7..3dd0cf36268 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -16,7 +16,7 @@
 #include "virtio_blk.h"
 
 /**
- * struct virtio_blk_priv - private date for virtio block device
+ * struct virtio_blk_priv - private data for virtio block device
  */
 struct virtio_blk_priv {
 	/** @virtqueue - virtqueue to process */
-- 
2.51.0

