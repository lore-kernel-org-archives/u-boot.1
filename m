Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09300C61DDE
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 09:43:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D025483E13;
	Sat, 21 Feb 2026 10:43:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q0c/ujYl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C37F083D0F; Sat, 21 Feb 2026 10:43:02 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F1C83D3D
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 10:43:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48379a42f76so22339465e9.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 01:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1771666980; x=1772271780;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9mxAFse+1KkxrCjPFiqiDmArYA7Aup8uovARfrottY=;
 b=Q0c/ujYl1ngprgsINjLUu2QLStoxvAgxiIiC0Ed0WK2e69fkypTk3qonX+Y7FJ8JVG
 LN1a+hQdSZD91WDlEINlfAsh6yy7WraqNSNs+CM6m/ea21v1DBspmrUFIzgYMI2l/DTV
 ElgAOdf2ScXGSGk4iGalvI2MTXa9Pid6PY84k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771666980; x=1772271780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F9mxAFse+1KkxrCjPFiqiDmArYA7Aup8uovARfrottY=;
 b=m78S5wmk6ug+m+LD2NSrmDtJALAi/DuuWPPXESC0ThIK1oFzIc1fGzc8BLaMrbhaMK
 XNSNgxOb97hhOwp1q2+r6dEpNH3EDPlIC1cOU6G0oDNaikWON7Bg/g52v+dofeYb+oTz
 VFIA3Y6vzGb9j+yRLQTYoXhyfqoBE+7P7dOi0PkmSnoQ3KpCZgHn9R841b1LjUWN5nJG
 y3pqGRa8c3gb0tQizZxHynQ0beyksg+dI9bPj/bYtkxOowUcAjP7rVhKLtJPiO0FEPDw
 OFq47LXPo+r5/OMJYHGdkuWAT75hp1Fhx/K63r8qYB9wWMlnAlibLtcZGbI1ZoLvBAVE
 6PEA==
X-Gm-Message-State: AOJu0YxEyw7VCxtO75HrDGurC6Nbs9yKT34qKYFbTUvK9FOR5rmS6L0w
 w4VvI3fLQI3Da/uSleGH4BSTHUDf/09ZhYCeo9ES3SUrRdPWb7J7919J1I/NSGDUQ0RSBpN/6Nh
 7AAPl
X-Gm-Gg: AZuq6aLtdFqQbqUgPgtxMoYAwdTQ9KBShq/T72+YGsqtn0kugbwrqqRajGfb1tL75iz
 6G2KugNm2KIVdlJFQP//bND7ULBgYRfxpcA77T+imp/7SqEyo0W6sVpUEkztLEhO6fBFM4xyZNQ
 dyeH88dWl/hG5dj0uRlNyRjbN8a2R3fQM+B4FlcF8+/aB/2p2CgFoX1kRz4jIuQPPGKVegYWj8W
 7IH2uQ5sCOuPvMCc0Nh/wD56NbKDkf8ppxHzTsx1J2NaXUYKpEPMwz2zpmSM5nPm4yVNT2XEu62
 I76KdrtFPPW4Cw9JxDnyxdhSpYAhLN1+jYocYzduw3ZxdaXf+G+qTSYNeWpk/DljPqdYsQwVfFf
 SkILnjYtEzjpBLKNwKs/l6x+ROELqDC8DjeDNjrTCLLydo3HtyLPNeskVWiAAaJw+Tj6morbv9q
 cR7cOWwR8J2q6o4vInVHG/wnXfUDmJXzRca4uryrINcwkQCzHLGgKkogMEQhK5l7VO4Ph0xRRC4
 /DM4OUikgyEdXnfZFJbMOpa5U5gkyTwDx24UUcuZaL0pmPqm9Bf9Fq8JrWn96rk3QIP8AVczlEg
 Jyg+pBOcV4bshzntZoZv1zJW
X-Received: by 2002:a05:600c:8b88:b0:47d:885d:d2ff with SMTP id
 5b1f17b1804b1-483a9636340mr34250205e9.29.1771666980031; 
 Sat, 21 Feb 2026 01:43:00 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42f3968sm42694225e9.19.2026.02.21.01.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 01:42:59 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/8] spi: sandbox_spi: support wordlen setup
Date: Sat, 21 Feb 2026 10:42:16 +0100
Message-ID: <20260221094252.3103034-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
References: <20260221094252.3103034-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v1)

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

