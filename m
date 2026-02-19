Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A434E9A057
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C1583D8A;
	Thu, 19 Feb 2026 18:51:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lPkdhn3r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C23283D8A; Thu, 19 Feb 2026 18:51:56 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7149583D5D
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:51:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806ce0f97bso9783105e9.0
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771523514; x=1772128314;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mA6txAjpKnV7iUaVBfj6HhQ72BfpoUuT9C0VpGIiaNQ=;
 b=lPkdhn3rXNKkuDLxA3KoDSWEEKsUvvsz0M7rVCHYaIs4IuwBROXjGHvs/OvIxYBxRJ
 6dTIGj5G4Rmx5w6ZoFlPp0RsOLUFNx+DWpeffmeZhZcjpmB/OEUZOYlV2GQwooUNjdqO
 rI7U9GJNjgpoqlORhZUqZ2jnV3D9qu09QUNY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771523514; x=1772128314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mA6txAjpKnV7iUaVBfj6HhQ72BfpoUuT9C0VpGIiaNQ=;
 b=PWG85dVLU21f3yD/HuoynOJIg1urm6LUXPgsoeNVmGX0G9xidu0M5ZdeQwKAV6ZGZ8
 stfvciHrxhjJlfrF0TZiculM85DZmat34vdzLXaeDkfwt6qUY4xMsoa32M2shtAYQApJ
 a4ewsuZjF7enjGggSAS344YY0Au0u5P0oNTeQa7t0Da9hzAHkSwosTl27iRgyYTNATU7
 Ptlxzv4wdI/3TX2y+WmWvMMRFi2sErd0zLJaN0fS+i+WqN3kGBEKdUf3JQUIFl6w+RG7
 UX6aw7w6nnVSyBnxqV2kUu4qJCf5odhTmJff9DL7rCx6pDeNanOEavGeaRy8x0HVaoAv
 Yi5Q==
X-Gm-Message-State: AOJu0YxoVGIqRK3QP9FM6T6RnQAi3udx6Cq4TWfmufHUwQ1g8H8cDbK3
 f+gu1DSDx4yXdIDXASTFRnULd3X6z4v8MeqW5xaUabpYaBlxKewaJkS0/aM5fkr4B+S9I0BmZJp
 VC1em
X-Gm-Gg: AZuq6aLDtPnzWr5tqnVphPfwQzuetBKd3FpYauSu1a/rjLsLNMdMdK5xfUhOk5+7dVA
 FrE0mG+LVZUrwtDTPXNhjpuy2fSkUnlQAkOnao4uYRLFFtiXtdYV1aXv44FUu7S6Qu07814wqTP
 4I1tUf3VsMmn3oqb/5gI14NMVvnxYwGdsYn06OB62fyd7IV34euVFDEUCy6uqfI7WzY412o3PFr
 Bz2GQTURsTVmN7hsQrZhaAenrsnFToy/j06mHJzW8YlN8Nr4hZR8dj1N6JZxCbWJwyI7IJmcl35
 5TK+/VJaAJ87S8aUJYTJlCUBD4tObdiXLIsapUZ2ZCFFrneSmdvwFh7p4DgBZkYupxzoCKfudJC
 4egKAxJnd6ZJ0cHvY4tpauZuaye+twpQzQQSDN+xelk8KXRYZ8+kc4vsfcnPRxfENbOOTDrABx1
 F9UfD/9x1VsmS1prLorqZi2o/IXQsVZnWsOzPmSIsK4Euk5k1++HtAD+yfjIbyjowmp/6GWxY4F
 qsRta1iZ+OPAmV/71qSBnmOQF9nYY8tyzB3/rAPvjKKfqb+FhOsQMwamz6K+Ga/lyqcocjPZdCh
 jHuOr4vdFUBQE4R2Xrir6sV2
X-Received: by 2002:a05:600c:6207:b0:47a:7fdd:2906 with SMTP id
 5b1f17b1804b1-48398a52eccmr97170635e9.12.1771523513726; 
 Thu, 19 Feb 2026 09:51:53 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31b0e63sm35485005e9.2.2026.02.19.09.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:51:53 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] spi: sandbox_spi: support wordlen setup
Date: Thu, 19 Feb 2026 18:51:13 +0100
Message-ID: <20260219175130.2839234-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
References: <20260219175130.2839234-1-dario.binacchi@amarulasolutions.com>
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

The driver currently ignores the word length configuration. Implement
the set_wordlen operation to store and track the current word length.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/spi/sandbox_spi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/sandbox_spi.c b/drivers/spi/sandbox_spi.c
index 4cc016138b11..8eed56140f6a 100644
--- a/drivers/spi/sandbox_spi.c
+++ b/drivers/spi/sandbox_spi.c
@@ -34,10 +34,12 @@
  *
  * @speed:	Current bus speed.
  * @mode:	Current bus mode.
+ * @wordlen:	Current wordlen.
  */
 struct sandbox_spi_priv {
 	uint speed;
 	uint mode;
+	uint wordlen;
 };
 
 __weak int sandbox_spi_get_emul(struct sandbox_state *state,
@@ -61,6 +63,16 @@ uint sandbox_spi_get_mode(struct udevice *dev)
 	return priv->mode;
 }
 
+static int sandbox_spi_set_wordlen(struct udevice *slave, unsigned int wordlen)
+{
+	struct udevice *bus = slave->parent;
+	struct sandbox_spi_priv *priv = dev_get_priv(bus);
+
+	priv->wordlen = wordlen;
+
+	return 0;
+}
+
 static int sandbox_spi_xfer(struct udevice *slave, unsigned int bitlen,
 			    const void *dout, void *din, unsigned long flags)
 {
@@ -158,6 +170,7 @@ static const struct dm_spi_ops sandbox_spi_ops = {
 	.set_mode	= sandbox_spi_set_mode,
 	.cs_info	= sandbox_cs_info,
 	.get_mmap	= sandbox_spi_get_mmap,
+	.set_wordlen	= sandbox_spi_set_wordlen,
 };
 
 static const struct udevice_id sandbox_spi_ids[] = {
-- 
2.43.0

