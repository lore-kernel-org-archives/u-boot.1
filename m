Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35A1C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 12:52:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216F382B20;
	Thu, 24 Jul 2025 14:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=avm.de header.i=@avm.de header.b="XrpyH+P1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE4F83890; Thu, 24 Jul 2025 14:30:27 +0200 (CEST)
Received: from mail.avm.de (mail.avm.de [IPv6:2001:bf0:244:244::120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1AA383885
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c.speich@avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
 t=1753360224; bh=qxWu5E8Gy1RgVfGI7fztoricXSVBxIAVW+xNazMkEHA=;
 h=From:To:Cc:Subject:Date:From;
 b=XrpyH+P1aAsTLdxWAawXibWZF6lZrKa+gWpTwHSbVy4TcEXzKUS/nqAMKVsOPj4FV
 0laxH9uIeptrd5JSOUXlIP5BK3eA4l54HtCB8mEFF+t+FEecaCW4LEcQBMA++nxiMU
 6bYSoBmmjTndA4kmB8MzDNAuSzJA9iVSXJN/2/CQ=
Received: from [172.16.0.1] (helo=mail.avm.de)
 by mail.avm.de with ESMTP (eXpurgate 4.53.4)
 (envelope-from <c.speich@avm.de>)
 id 68822760-0380-7f0000032729-7f000001b3f4-1
 for <multiple-recipients>; Thu, 24 Jul 2025 14:30:24 +0200
Received: from mail-notes.avm.de (mail-notes.avm.de [172.16.0.1])
 by mail.avm.de (Postfix) with ESMTP;
 Thu, 24 Jul 2025 14:30:24 +0200 (CEST)
Received: from l-cspeich.avm.de ([172.17.89.139])
 by mail-notes.avm.de (HCL Domino Release 14.0FP4)
 with ESMTP id 2025072414302508-12680 ;
 Thu, 24 Jul 2025 14:30:25 +0200 
From: Christian Speich <c.speich@avm.de>
To: u-boot@lists.denx.de
Cc: Christian Speich <c.speich@avm.de>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH] virtio: net: Add missing virtqueue_kick in free_pkt
Date: Thu, 24 Jul 2025 14:29:59 +0200
Message-ID: <20250724123005.2527425-1-c.speich@avm.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: AVM GmbH
X-MIMETrack: Itemize by SMTP Server on ANIS1/AVM(Release 14.0FP4|March 10,
 2025) at 24.07.2025 14:30:25,
 Serialize by Router on ANIS1/AVM(Release 14.0FP4|March 10, 2025) at
 24.07.2025 14:30:25, Serialize complete at 24.07.2025 14:30:25
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1753360224-4A591E1C-42426C11/0/0
X-purgate-type: clean
X-purgate-size: 1066
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for
 further information)
X-purgate: clean
X-Mailman-Approved-At: Thu, 24 Jul 2025 14:52:45 +0200
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

Every virtqueue_add must eventually be followed by virtqueue_kick for to
properly notify the peer that new buffers have been put into the queue.

This is currently missing for virtio-net and may result in non-working
network when the host has depleted the rx buffers and waits for new
buffers. Depending on the host it may busy poll on the virtio queue or
wait for the kick. Qemu does the latter and may break.

Signed-off-by: Christian Speich <c.speich@avm.de>
---

 drivers/virtio/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_net.c b/drivers/virtio/virtio_net.c
index 0e5367a085e..71e4d251396 100644
--- a/drivers/virtio/virtio_net.c
+++ b/drivers/virtio/virtio_net.c
@@ -128,6 +128,7 @@ static int virtio_net_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 	/* Put the buffer back to the rx ring */
 	virtqueue_add(priv->rx_vq, sgs, 0, 1);
+	virtqueue_kick(priv->rx_vq);
 
 	return 0;
 }
-- 
2.43.0

base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
branch: virtio-net-kick
