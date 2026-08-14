Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A09C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:29:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A98F260A6F;
	Fri, 14 Aug 2026 18:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGMimveL6OXm; Fri, 14 Aug 2026 18:28:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A836E608FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786732138;
	bh=5EEmcynyJFgmHAhxwEh7sxZsUtKgRTlq8HxD96/6X3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OhTL16VLMxKxJ5c0uAISNq6YPa1fE8qDolWt1BiwhFo9V3/cXZJUZ3xns60nIl32R
	 Q1CUqi/f3DUji1EQsCutDRGqogEFguCrSJ7E2+ZylViDyWOn26zUf40JRuQnWMIWgm
	 trfKLtE73fpX03BS93orJHeeMmC4oC7lmWDmjMTBTgf5v9F/7j+p5zJZrHW598b88y
	 ZHLsmmURq/6hZh4kuncA/9MdsUDAYk/gam/AJl62oiYBcm8KWLtSKSKhnm5kboI3+p
	 RiTShOD5fRDt7Z1Te8xHXEP4Lgkrmx9Tid9dj0MZ7fJFb0NNtgrrnq9VeL9gUCcSjo
	 2Js0gxF0uvplw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A836E608FE;
	Fri, 14 Aug 2026 18:28:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CBB2B3DF
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BDE22608FE
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c2zpNt3Xv1gh for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:28:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::733; helo=mail-qk1-x733.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BEA46606D3
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEA46606D3
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=xT79q8Oq
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BEA46606D3
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:28:55 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-9309d4ea213so105141085a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786732134; x=1787336934;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5EEmcynyJFgmHAhxwEh7sxZsUtKgRTlq8HxD96/6X3k=;
 b=xT79q8OqRPNaiPX8PQSdFQ2CWP16ANiLP9/X3nfUqxxxuwMDeUH3oc9p4JTAcfKmBn
 Onbyy0bvXkSFGutNByv3gltzr7GPVqdur70NAwRbQoWwLJ/b7IQIrGdzI8TCYcBT/8EK
 m8FvAPc92L0zU+1LOznO3uOiRgbPXY1o7EZNgfDGw3MNbauisPqSvuFd1P9buPtPXM6h
 6cAhupUHhYABPUNVFvL+27CDDfhYVML9RSTSEfMc+WyQR2YDcDty2fQM3ZVCMeuxzKfm
 3DoAc7MS5mgUZgr5aeGd6KHp3ndA88R/usx6Kw3YCC2W/XvmnOq2XyvOX5a/Vx4R8S8+
 chHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786732134; x=1787336934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5EEmcynyJFgmHAhxwEh7sxZsUtKgRTlq8HxD96/6X3k=;
 b=Q6jcqKi0fR7S8JvmwUURFNdPKS+iKAdgzmu1n4oLQvbeSvkW8Blpt2PGO/7oWdI3AE
 /B9IwuZMgW2d0jju+jyH1ia47GlceC71Np/i7AQ6GOlbsAsQ4Uju6qmAwhWyHTAmcej/
 EeKviFtqbVOzTBx+QY9SOl0yIO0fyy4ugH23seh7XYd06CpLnqDBNqL2WAGxgNPeANYx
 R+qlO7QP/Epyrx73TZ4fT0g/+izg1vsV4QWweT6nsOLHY1sDs1ri2Nvs08RM3L7E/Xdp
 XHm8nQ8bKy/iPMaDvkA0dGRCwZqZgUolmEMcutlXvFb3zHsiUBSIgXAd2m84QceD9Sb2
 jUAg==
X-Gm-Message-State: AOJu0YxoWkz5VokNJ0ejLyc0tPGDw2tLBCfYmLTswyDPmYGRTS0EYqSa
 avmpqFaUulGRkmTYK+FFVFuGv9HuRn9XH3UIrAb3CuuI9Ixmliza4Ij7q+HsfQtPcrg=
X-Gm-Gg: AR+sD11r6D34cljbU2dGZIYMkCvJUYHAr4bBDEZG4pNHvZoskiqnemdsKQH+qGRx84R
 CEUrYkbgKKeE+F5QSSEG+6/I2lS4wxDzHQ2yEYBB1cjyRSIJfiyM4t2CyX/jn+EvywCNrktItGg
 ScygpRuKybpAl1CmyBo115yGJDBviWkYHf8CtA/M/Y7g7tGZOE9WrkY3XY8WKAEoJ2mJKWhrLG6
 06i1ZoVOI2OCPWzNLybfIF9g5m1Bw2TIrvieu0MYDYpjSSuo2gs3YQOP/BGVJaDMFkU7j3f4LPg
 X+iOHzA0KF5BixVOU2ptmyTUwLgp9ktWwrvpcwjGy3LfHaNaP7ZuBhdf9gwux5nyCEJJuojP1Zf
 QYsHAA7lmzsh1VSTr9fxCgnZ/8ljd9EeD9fwIkrFgjUSXRb5aaDyG4KNjYBWdvlQUmDy5kzKUhk
 7iJhnlqhRYY45MatowLL5PMRK/CBLnD0+fCPAQVeNO0wLXiFRlE5NUUJ3gJkuiaUZo7v93VCtAn
 BgBM/3DoT6xU3INPmAeD0bgq1WHWi2pX3AIwEhoBZZ/hgG8LYzje3zD
X-Received: by 2002:a05:620a:2b4c:b0:936:9bc3:e10f with SMTP id
 af79cd13be357-936d1fd6c4dmr929735685a.5.1786732134231; 
 Fri, 14 Aug 2026 11:28:54 -0700 (PDT)
Received: from maple.netwinder.org ([66.129.139.8])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936ce24564asm336071185a.40.2026.08.14.11.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 11:28:53 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Fri, 14 Aug 2026 14:28:49 -0400
Subject: [PATCH v2 1/3] spi: cadence_qspi: enable all clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-rzn1-2026-10-spi-v2-1-973d5fa092f2@linaro.org>
References: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
In-Reply-To: <20260814-rzn1-2026-10-spi-v2-0-973d5fa092f2@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Padmarao Begari <padmarao.begari@amd.com>, Anshul Dalal <anshuld@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Johan Jonker <jbx6244@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openssh-sha256; t=1786732131; l=2076;
 i=ralph.siemsen@linaro.org; h=from:subject:message-id;
 bh=0h21KmjmWu6gAqtSGuU54JaAhjh8/r/aZFoGpmzFuxQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgG/ALfT0jfT5dAzjFlh+rTh9j4pAiw
 vPQ/tR3mihuAFYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKXbix47Bi6AA4t6fpgpLyeGHVcdCGVIgWk3DyuXPzH20Q1Cm+JMMMZsoOAmEWNAG4gEADXRPsV
 admsNZHTIdAc=
X-Developer-Key: i=ralph.siemsen@linaro.org; a=openssh;
 fpr=SHA256:12SQdavZEBUxPbBBtqQJgZ9F8vSvwTB6kFlSNgb4IcM
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On certain devices (such as Renesas RZ/N1) it is necessary to
enable the clock(s) before accessing the QSPI controller registers.

As there can be multiple clocks, use clk_get_bulk() to obtain clock(s)
and clk_enable_bulk() to turn them on. Warn if clk_enable_bulk() fails,
but keep going so as not to break existing users.

As before, it is assumed that the first clock is the reference clock,
so the order in the devicetree matters.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- patch was split from the series "Renesas RZ/N1 additional drivers"
  https://lore.kernel.org/u-boot/20260731-rzn1-2026-07-v1-2-af2ce80db9d8@linaro.org/
- move clock enable before clk_get_rate()
- handle multiple clocks using clk_get_bulk() and clk_enable_bulk()
---
 drivers/spi/cadence_qspi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 984d4a39ded..0f70493dea4 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -208,7 +208,7 @@ static int cadence_spi_probe(struct udevice *bus)
 {
 	struct cadence_spi_plat *plat = dev_get_plat(bus);
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
-	struct clk clk;
+	struct clk_bulk clks;
 	int ret;
 
 	priv->regbase		= plat->regbase;
@@ -240,7 +240,7 @@ static int cadence_spi_probe(struct udevice *bus)
 				  ZYNQMP_PM_REQUEST_ACK_NO, 0, 0, NULL);
 
 	if (priv->ref_clk_hz == 0) {
-		ret = clk_get_by_index(bus, 0, &clk);
+		ret = clk_get_bulk(bus, &clks);
 		if (ret) {
 #ifdef CONFIG_HAS_CQSPI_REF_CLK
 			priv->ref_clk_hz = CONFIG_CQSPI_REF_CLK;
@@ -250,7 +250,11 @@ static int cadence_spi_probe(struct udevice *bus)
 			return ret;
 #endif
 		} else {
-			priv->ref_clk_hz = clk_get_rate(&clk);
+			ret = clk_enable_bulk(&clks);
+			if (ret)
+				dev_warn(bus, "failed clk_enable_bulk\n");
+
+			priv->ref_clk_hz = clk_get_rate(&clks.clks[0]);
 			if (IS_ERR_VALUE(priv->ref_clk_hz))
 				return priv->ref_clk_hz;
 		}

-- 
2.55.0

