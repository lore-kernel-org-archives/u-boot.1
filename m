Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B06E909B1
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 14:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D227083AC5;
	Tue, 17 Feb 2026 15:31:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="NsjVCcQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C71183C72; Tue, 17 Feb 2026 14:59:58 +0100 (CET)
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8573280325
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 14:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christian.poetzsch@kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Subject:Cc:To:From:Date:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=RP2EjRYJsttUKOj47Zm9rX8ajl5dqoPj7mNmPltp/Kk=; b=NsjVCcQzyfbywuNVSHly0+krsZ
 QivwtJsjjW7T2KQzvKYDa4iYp4MTLm11rfNP/Fu5L25BLQ+D/ChZE4xNEkwhY2mcN5a1yJCCbkT1K
 ouA9GeqHTem1QK9N40we8LU6OhSmrL/ve06P9QbKy46HTpnUXsCPXzvDeenmPu5fXwhP1c85QTuFf
 VdKHyC+t0wc99Jl8unT8iuGLEeRT8Ckw4djcre78/f+OIYEHGPbZGLtKkdcC8xyfBrTZmcB+bNfH/
 PTaC9pohE5QMwisdNXXb6473wIWgn86tb9tWFe25VqIrMW0Af72ezp1tMxKFfHey6FQOglFLvBUtg
 H95GKnNA==;
Received: from [10.72.1.1] (helo=kernkonzept.com)
 by mx.kernkonzept.com with esmtps
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.98.2)
 id 1vsLcJ-00000007BfW-1PrK; Tue, 17 Feb 2026 14:59:55 +0100
Date: Tue, 17 Feb 2026 14:59:52 +0100
From: Christian =?iso-8859-1?Q?P=F6tzsch?= <christian.poetzsch@kernkonzept.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Adam Lackorzynski <adam@l4re.org>
Subject: [PATCH] virtio: Fix virtio initialization sequence
Message-ID: <aZR0WCHAC6KaJfH1@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Mailman-Approved-At: Tue, 17 Feb 2026 15:31:03 +0100
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

The virtio spec clearly states in "3.1.1 Driver Requirements: Device
Initialization" the sequence a client has to follow after device reset.
Because u-boot resets here again, it also needs to set the "acknowledge"
bit again even if this was done in virtio_uclass_child_post_bind already
once before.

Signed-off-by: Christian P=F6tzsch <christian.poetzsch@kernkonzept.com>
Signed-off-by: Adam Lackorzynski <adam@l4re.org>
---
 drivers/virtio/virtio-uclass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index ac563991b90..c36e9e9b3a7 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -292,6 +292,9 @@ static int virtio_uclass_child_pre_probe(struct udevice=
 *vdev)
 	if (ret)
 		goto err;
=20
+	/* After a reset we always need to start the init sequence again */
+	virtio_add_status(vdev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
 	/* We have a driver! */
 	virtio_add_status(vdev, VIRTIO_CONFIG_S_DRIVER);
=20
--=20
2.51.0
