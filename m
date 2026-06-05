Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FC7CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A47AE84971;
	Fri,  5 Jun 2026 14:27:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile.com header.i=@hifiphile.com header.b="G9B+EC65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA74A848DF; Fri,  5 Jun 2026 13:19:58 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC1A884879
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 13:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so22151495e9.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 04:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile.com; s=google; t=1780658396; x=1781263196; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=erpoQfYWLySLMfkO21fOJi2jsbvt0/GUXwovKZOPvIw=;
 b=G9B+EC65/xlEG4NtZUZRI2Gbsjfn9EtFRrxvVgAz/vmIQC1PgK03n0zZxaRllmJUM+
 XCfko1fEMlmXXDte0rYB6N1wyvEIHZU13eJyx25YVZUmK4mFqxBKVLyDUy/mjRtXoH74
 prbNTvEeV/fSP4SpEYQu235ED8ce+HJbdIhvGIzeyFXI/F/P9Eqh31ruXFLfJmZqdwpd
 Grkyw0DqYFYyfmIbwTkowg5gxFAiujS1hfiAzCMMmd0PSGVcO2xRUQuFjsoUWI1ugGOW
 NUIfMvnDxSAfNpig7qCedC5/Tr6rqP8+i62dKn5nbuBGKmXytBp0KDZ6pGpUHG1yYGMQ
 4dcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780658396; x=1781263196;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erpoQfYWLySLMfkO21fOJi2jsbvt0/GUXwovKZOPvIw=;
 b=sOn3WAk+LpjCrcebGwir9Hyw6qEgux+JDlTRvEMbITk/6AVBtpmDMIMaab4lk9OSon
 sJNSyyuLQ9JNSXuaPQYcdih7cF9HkNocshZnv11w+uEnKSlEo/Ae4esRAhpljtMplP3V
 OYRWr5S8NUAVDX2xaM0aSzf0TiEZ+xv8fKiMsnhCRbP63BYEJGLNft4JHocAq3pH8b5Q
 rqFfoX86lDSTUvE7z6+zm4+H09++UJ0IRZVBU0SFIRk/tGYKPRb/sNJxAejgiXYf24c/
 LT3n+/gSiNRuoi1tdpWTejnyZuv2RYivYkW79BEK3FKVQrdFsWFbXOpD3UO2n+H8vsqe
 ydnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/G1iRf0Hgxys5FNbnF5CCtgTm1y5q4FETYkQnVn0VP+7QP951LUrLp9X73kdmL5wzCTyOZ9Yg=@lists.denx.de
X-Gm-Message-State: AOJu0YxuaIR4c+SFndsdTnV6gtGRQkOEiFSslsPLXwxAMz5aThl+g5ui
 aCFHI4WlBE7Ui1cPawR4y8rLKknW9AEzk4bXIiX5zwUQyr+jxcuEeSRUpwckemFZFmw=
X-Gm-Gg: Acq92OHKsrbetBeInOHzbOubMjshra37L3H2RGbVNLa/BiE486NX72ON7w2wzS+GtLN
 qVJmZPV+z208vSbaZGLvkl3zmAsqbZbeTt8Ttxvniw2QARjXBD/WivnBmdCu1sPHYY551Zq7rzP
 jLfBBJFsLnuONbJPc6aB+i7A647l7tR8Yv1/r2Z8t0+HnbUmGl8gkVEm5SGBlwOHsVxd7oaGtOj
 1qRs44O/lN0ymzbLcT+OB0/+077+3Q+OvWRpV/r7j1Is4SKLe9ffG3O6CtHkyEaLYvmr04m+fc3
 QeIE4Q7xorTAJwz+kPl9YnYgci8OeTrZdiIzJ5inQgXldQL3DTSHxk7ms63Sxb5/WvuJitsIfD0
 J8R6c1T3JlSAQSvai8oaW4HnaoO0h6RSKiUsL6cOxkMx7owGf5ZInNl807IoeYCOfYI3ZyB4zRP
 zW1gMQXJXWaO+o+76AsxQH0jRdvGkuep0qK3bzFuKJUKA=
X-Received: by 2002:a05:600c:8285:b0:490:abef:dae6 with SMTP id
 5b1f17b1804b1-490c25b09bcmr48876625e9.19.1780658396047; 
 Fri, 05 Jun 2026 04:19:56 -0700 (PDT)
Received: from [127.0.1.1] ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-490bc3a87dasm136188385e9.7.2026.06.05.04.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 04:19:55 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 05 Jun 2026 13:19:54 +0200
Subject: [PATCH RESEND] usb: gadget: atmel: use calloc() to allocate
 endpoint list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-udc_malloc-v1-1-ffe202cd2656@hifiphile.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Zixun LI <admin@hifiphile.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
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

malloc() doesn't zero out memory, leaving ep->ep.enabled uninitiated.

Fixes: 59310d1ecb9f ("usb: gadget: introduce 'enabled' flag in struct usb_ep")
Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 drivers/usb/gadget/atmel_usba_udc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
index f7a92ded6da..a5a2252dee9 100644
--- a/drivers/usb/gadget/atmel_usba_udc.c
+++ b/drivers/usb/gadget/atmel_usba_udc.c
@@ -1219,7 +1219,7 @@ static struct usba_ep *usba_udc_pdata(struct usba_platform_data *pdata,
 	struct usba_ep *eps;
 	int i;
 
-	eps = malloc(sizeof(struct usba_ep) * pdata->num_ep);
+	eps = calloc(pdata->num_ep, sizeof(struct usba_ep));
 	if (!eps) {
 		log_err("failed to alloc eps\n");
 		return NULL;

---
base-commit: 5732bd0f457b4c671e46574d64d4acb099c0f0a5
change-id: 20260521-udc_malloc-eb8355d08afe

Best regards,
--
Zixun LI <admin@hifiphile.com>
-- 
Zixun LI <admin@hifiphile.com>

