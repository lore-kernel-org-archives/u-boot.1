Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F5BCD37B9
	for <u-boot@archiver.kernel.org>; Sun, 10 May 2026 17:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B309846D1;
	Sun, 10 May 2026 19:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XlCys4aD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J/wtMbx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF6B8470B; Sun, 10 May 2026 19:17:37 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A8E846E9
 for <u-boot@lists.denx.de>; Sun, 10 May 2026 19:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gD8gL4zdkz9t7h;
 Sun, 10 May 2026 19:17:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1hPPhCEbGVQdIj+z9lECTsTXPcJJsiFT+eNe8Tt1T8=;
 b=XlCys4aDZwFmb58A1084ZvYuuUz0w5lNzL6rudEJmABSy3haEIjx0N/d+ihdYcTVTYDdtW
 0MhGy9UF/HNYoa0VIhJCG1dfpUV1nwfQIU2tRuPQC8P84otiAxdfNpb2YK54gaLrlh2NqE
 Q4UveBydEk2eQ0gMGcM8k35iKAtdeuhSWWpUmV11eqoRqUAAxLqlI2FAROIA9hJtu8G79F
 3UIin2NSInjjuARunc31vdd0dUgMupMYyvV12LqEZDRnCYScnOhLUO9FL6x3hJVKp13A0M
 nm0QmQumIWJsoQ6OV0C8cLokqGHnOYeezq2IAOF01ULbx/ivdL12OQL9yFMXgw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778433453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1hPPhCEbGVQdIj+z9lECTsTXPcJJsiFT+eNe8Tt1T8=;
 b=J/wtMbx6sjN7TR15OlpIP9+x4fDTtpU1tp/HVYUnoFG2/VKdhPZcYKfri5hhodTg5PHlDZ
 Dmj9G0wXRmaMJ+obCaGHgq8AxjQF4TwrBiWAooJ0VuSLUKQagz2d26AeSYjOa+/EysQpM3
 o7RtqpJyWmBQn9DEgk4TzBo9NzdTfksH7oT0ZEZ8YhL/pomwcuWS7My+PJur9DcUGJ2Pys
 inNwmU9hGw+0MWBVoDxUWqSVWIrRGDp4H/Nr7KZHAI4gxE7Bhd2iQTO21SjpyiT6PQLssJ
 JxZayDKKVkySG3UgLoiVEeGlrm8JmZzHjX3srHc/yIXkZbTbP1OErOJVDI3m8w==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/11] video: bridge: ptn3460: Staticize and constify driver
 ops
Date: Sun, 10 May 2026 19:16:58 +0200
Message-ID: <20260510171723.56866-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
References: <20260510171723.56866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: abf8a81f5c6747b7df0
X-MBO-RS-META: e4f5d41czd576s3q1jg7hmfrcr6jbfug
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
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/video/bridge/ptn3460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/bridge/ptn3460.c b/drivers/video/bridge/ptn3460.c
index 5851e1ef15e..ce576c0b282 100644
--- a/drivers/video/bridge/ptn3460.c
+++ b/drivers/video/bridge/ptn3460.c
@@ -15,7 +15,7 @@ static int ptn3460_attach(struct udevice *dev)
 	return video_bridge_set_active(dev, true);
 }
 
-struct video_bridge_ops ptn3460_ops = {
+static const struct video_bridge_ops ptn3460_ops = {
 	.attach = ptn3460_attach,
 };
 
-- 
2.53.0

