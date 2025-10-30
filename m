Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20557CCF9F0
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 16:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93D03836D3;
	Thu, 30 Oct 2025 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ogOCgc9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15F6A836D1; Thu, 30 Oct 2025 17:55:50 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B81BD836F0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 17:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4710683a644so12919845e9.0
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761843347; x=1762448147; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mPWAeLUFWOEd99jEJxwPwupfsrMt9CzyyNeHR+5Prjw=;
 b=ogOCgc9pvHFJ3g02Z9ox/ujYUC27jbD+sm8LksrJcFCbhn9LzogRe3bF+8hQRNiF2b
 x1/uMN3nT6/aRsZ4XXdhn9N1my7fH8kFtFAZ/bg9+e3hdFVMLrjk6SzwJ8WIGTVqKhxm
 5z45jk4M3QCaVsrb09oOzOdluuxOg7o0P88r6TAOPGIhs3BCL7OIMRrEc2juvYkgD609
 LysEF3uUk6sF77C6PRrBVQOoYQhmzI57bNp65LVH5cP+lRGi07zAjLOqjZw0OrgMVzd4
 E4Z89/5kwcr/Ti8JSTzXNxiPmxVpKJ1IqwcF5mBp4Lyg7LhkBHjElPhFMHvFim+GX1MR
 tRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761843347; x=1762448147;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mPWAeLUFWOEd99jEJxwPwupfsrMt9CzyyNeHR+5Prjw=;
 b=bPa0pG4QZnPWcp1h7tu0yvn8ZQhyHSCb15b5vp0L426ixyIbpyjDC7MhVzqBgRIxC6
 /6HZuRJxYlXVWVG/DKMQ+CUh+kkr+fR0cq7EOlWHa/LF8dOVs1CpRh1P21YyicDG+Ugf
 tbpufMRCU8nDo3zoMROvmbPlOBqOEWdHBlvG4No+hoDy9dreNPEzCJgnduA3RtDHfSwU
 21X5dTcWJe79PTPiUCxGWCO6+METK6sqoVYtPJyn08uhqD9MlCozRi4ZRfmdFXsCGNsO
 8NI/sj421ChtciljcjTYHAiSE9KHVbsHUi8rN3oDZTj9eTVFlmIyx6xwIdoz4W6pz8GX
 yg0Q==
X-Gm-Message-State: AOJu0YzUvJnJnD7pW0COR8VrfpIh3RpKgiD2AufFOHASfI4fcqvLLK9z
 qC/kPaiVT9RcK3XKC2aOctgTlq3qulWFLWETa4jnX5uIFdq+9OsdCcVFIwNJ5acVH4o=
X-Gm-Gg: ASbGncv5+N0jGGA+HUByf1ox0jtogKxj3TFXFdvfawFL6QMCMRd5EwBAIvt5kZ9nV6S
 K4iUVS4FKeJbs+qkcWZOaAukD2gRJChKmV29SQV59njRjDFn0m9DAMFlGUm16vnqAAJOCrtkLKn
 wV4YXNRveFtnFbGDed7z5lqdrbm5QlxV8lkP6nRLlMCoQ0xKUp6JRK8LEurQtb3UmpRH5IOOy7s
 B/jjLzpvhwlLZs4mCzBm3OAWfU07q4UogrT+njk6Z1pCcfS1btrha+zc/6DhwCH/H26KqSQsBcE
 WzDTu9BSARNW7vqAJ54vRJrMwT6rGAvmk302Gz+FHlFwBCH8+qN8XW0sAwP1lXgap44bu5pgOpn
 BigK5rQwpf5sRLlsGgCA8ZepxBCySpJ/399tmUqL2bKO2W2lDSCbehKlZG9+rLGMCtKvAtBAqiN
 w2HfXgp2zj0x5+vxvzTxVj+I8N3IE=
X-Google-Smtp-Source: AGHT+IF+evLrB03aQ1s6KyJpL/R+qspJBks5pI9qhMoDEtOVkfHrhrQpuAPT9kx+ajjvW9KP2yMLdA==
X-Received: by 2002:a05:600d:435a:b0:475:d278:1ab8 with SMTP id
 5b1f17b1804b1-477262226d8mr25198985e9.2.1761843347179; 
 Thu, 30 Oct 2025 09:55:47 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:4601:ec33:cd66:338:ecc7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952b7badsm32403888f8f.7.2025.10.30.09.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 09:55:46 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 30 Oct 2025 16:55:45 +0000
Subject: [PATCH] clk: Prevent SIGSEGV on debug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-fix_debugs-v1-1-4750e9617499@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJCYA2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3bTMiviU1KTS9GLdlFSLJItkC3NzSzNLJaCGgqJUoCzYsOjY2lo
 AsGE0plwAAAA=
X-Change-ID: 20251030-fix_debugs-de8b8c877969
To: u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Christian Marangi <ansuelsmth@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

If LOG_DEBUG is defined and a NULL clk is passed to clk_enable or
clk_disable then an attempt is made to dereference NULL in the debug
statement. Guard against this.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/clk/clk-uclass.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3dbe1ce9441ca513d41be90520ff175c96b4253a..1f55dbe385b76d0d6cfbf19bc9f4f1abe619baf2 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -660,7 +660,7 @@ int clk_enable(struct clk *clk)
 	struct clk *clkp = NULL;
 	int ret;
 
-	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
+	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);
@@ -721,7 +721,7 @@ int clk_disable(struct clk *clk)
 	struct clk *clkp = NULL;
 	int ret;
 
-	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
+	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
 	if (!clk_valid(clk))
 		return 0;
 	ops = clk_dev_ops(clk->dev);

---
base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
change-id: 20251030-fix_debugs-de8b8c877969

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

