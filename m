Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D08BC47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D557B87947;
	Wed, 17 Jan 2024 23:27:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g9eki5Cn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B75878A5; Wed, 17 Jan 2024 23:27:40 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 932DB87947
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=devnull+j.jannau.net@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CFDE9CE1D04;
 Wed, 17 Jan 2024 22:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 149E0C433C7;
 Wed, 17 Jan 2024 22:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705530456;
 bh=iNtPinaWgHyVu9At5yTrqokajKXm2lsblAdGfWGowZ4=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=g9eki5CnGY4y9B3qExhKYdIy39QIfniDc67Sbb2M+MUv0iicHeBSziRdQ12PpgbR/
 Fc5mdKAY/x+3ePdLfEQ9AqV/s2LBVA5S+S7qH0P6yZ8P9sjpZrvMw+7wHbogwvSmlQ
 grFqkxlYX1tethUGHV2IhoDlKyoF0gbXwqOIoWTiGmWt6o4k4BJUNf02qm7RGESoLV
 duAN+pgGnairbBfsECx8puxr0qoRyyP64Uizm4gYCsSiv33K8HAPok3N1v9yMCxBaN
 T+UptAVwLRh7cdw6OpfJJLAZ4Zn4K10HnFBrDsCFS9MsBPAE4prgeffZ9pgZuXxsYY
 N8KgqjzAWsylg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id F13E4C47258;
 Wed, 17 Jan 2024 22:27:35 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Wed, 17 Jan 2024 23:27:34 +0100
Subject: [PATCH] video: Support VIDEO_X2R10G10B10 in truetype console
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240117-console_truetype_x2r10g10b10-v1-1-25b11c6d7e40@jannau.net>
X-B4-Tracking: v=1; b=H4sIAFVUqGUC/x3MQQrCMBAF0KuUWRuYCbENXkWkaPtbByQpkyqV0
 rsbXL7N26nAFIUuzU6GjxbNqUJODQ3Pe5rhdKwmzz6wSOeGnEp+oV/tjfW7oN+8Cc/CD2E3IUa
 cYxvawFSLxTDp9u+vt+P4ATVqE5tuAAAA
To: Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=j@jannau.net;
 h=from:subject:message-id; bh=VhuaE+WdSXG5cJBj7RmqpaXvyiL4ENZrweTmabGHOF8=;
 b=kA0DAAoWoRs8240vZWYByyZiAGWoVFeh7CRFgOOWMZF1bp0isOCC1xFVlsrkI4LKnrRO7ncaX
 oh1BAAWCgAdFiEEYivpiACrfCFcfeBWoRs8240vZWYFAmWoVFcACgkQoRs8240vZWb7rAD7BqJH
 LqSLm/V/bmyDU+1tdwXbF2ktlsbUe71dmhZznR8A/jhJ+28Q1Xe8uKtgmMbPbE60vJcLh53cvs0
 sl9I3NJcM
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/default with auth_id=62
X-Original-From: Janne Grunau <j@jannau.net>
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
Reply-To: j@jannau.net
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Janne Grunau <j@jannau.net>

Without explicit support for VIDEO_X2R10G10B10 VIDEO_X8R8G8B8 white
will be rendered as cyan-ish. The conversion leaves to lowest 2 bits
unset for more compact code.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/video/console_truetype.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 14fb81e956..547e5a8d9c 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -397,7 +397,10 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 
 					if (vid_priv->colour_bg)
 						val = 255 - val;
-					out = val | val << 8 | val << 16;
+					if (vid_priv->format == VIDEO_X2R10G10B10)
+						out = val << 2 | val << 12 | val << 22;
+					else
+						out = val | val << 8 | val << 16;
 					if (vid_priv->colour_fg)
 						*dst++ |= out;
 					else
@@ -911,7 +914,10 @@ static int truetype_set_cursor_visible(struct udevice *dev, bool visible,
 				for (i = 0; i < width; i++) {
 					int out;
 
-					out = val | val << 8 | val << 16;
+					if (vid_priv->format == VIDEO_X2R10G10B10)
+						out = val << 2 | val << 12 | val << 22;
+					else
+						out = val | val << 8 | val << 16;
 					if (vid_priv->colour_fg)
 						*dst++ |= out;
 					else

---
base-commit: 866ca972d6c3cabeaf6dbac431e8e08bb30b3c8e
change-id: 20240117-console_truetype_x2r10g10b10-fe88e5864640

Best regards,
-- 
Janne Grunau <j@jannau.net>

