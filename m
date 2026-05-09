Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC96CD3445
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 15:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8550384CD5;
	Sat,  9 May 2026 17:13:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Di7jEzP3";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="DALxEUuL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6521A84D24; Sat,  9 May 2026 17:13:28 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FAE284CC7
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 17:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gCTyZ28lvz9tKq;
 Sat,  9 May 2026 17:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oV+WuXs2fH8oIv3szvYpvLyCQ83gMajRDTjS6yV/hnE=;
 b=Di7jEzP34qL6HO3dby4Fmrqw514UrKxAAbWFVY+Ig2T/DO6OBZAnp2HIEnB5jf7eu1Pexb
 Lqy84mSer/4elMUwWl9a0/4JQSkjmzxj2GrwdeFoLxdScmZFbXajLayP0rzUjCjDSUn/BV
 NUPO8oDHJDyL01Harg3XBjiuDroB2hS3ytrCuv9KqJqTaZ0EineXrV1uP5oCY0+pt2UQao
 sYf7gZ7u1FPV07ENvYUmT6KvBo+L9Z1BeoCAZ1cN0tmpqdrR8qFP6ZAdILO7fhwHtgRDRR
 2ueWGjKRxV3D7Gwqr4CfUljL7OGJS7Ohob2L6gTNUhNGbxhHH05ilbmgVWLdjA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=DALxEUuL;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778339604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oV+WuXs2fH8oIv3szvYpvLyCQ83gMajRDTjS6yV/hnE=;
 b=DALxEUuLv1E+lVXa2XEuGt/ykSnJUrgXavJb+BkS7GHhFihe9rlVGF8rZNuTo6PpP3+D/U
 KV9YaiGfzQ+iSBmBmqqgXz4YyuF8Wecpk5DAmO8aiB+CG5kq3uZ76EmiQryntXKjVaZXGm
 YACn3hCC4USLbzhYlrWbSZR6HzkwD8gdoDBDLETOcviV0XRm8CX71mhFjXM4s29g18+UWG
 Hzpkx4G55bg36j2Gx353GHC5B6Y67dbS7yxcp/sW+dDisLLZu3BbQCDD6Y7Oz0TY5Su7+d
 z2BmTZzGFmTJqLnA8sboZNYdYa8jpKhTiHDWsIVcN2YOEXQ4KijA1hptBycq5Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/14] reset: raspberrypi: Staticize and constify driver ops
Date: Sat,  9 May 2026 17:12:32 +0200
Message-ID: <20260509151308.23067-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: t9z1gqh1b9hk8n77ne9uga37natzu1hx
X-MBO-RS-ID: 463390cf9c62111562e
X-Rspamd-Queue-Id: 4gCTyZ28lvz9tKq
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
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/reset/reset-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-raspberrypi.c b/drivers/reset/reset-raspberrypi.c
index 1792f0813f7..73acd301e3d 100644
--- a/drivers/reset/reset-raspberrypi.c
+++ b/drivers/reset/reset-raspberrypi.c
@@ -28,7 +28,7 @@ static int raspberrypi_reset_assert(struct reset_ctl *reset_ctl)
 	}
 }
 
-struct reset_ops raspberrypi_reset_ops = {
+static const struct reset_ops raspberrypi_reset_ops = {
 	.request = raspberrypi_reset_request,
 	.rst_assert = raspberrypi_reset_assert,
 };
-- 
2.53.0

