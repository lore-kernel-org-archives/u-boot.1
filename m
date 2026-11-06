Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88570606A330
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X1SAmxxB;
	dkim=pass (2048-bit key, unprotected) header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=G5E7uuQA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4F56B4099D;
	Fri,  6 Nov 2026 18:23:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QxnRUWZQwzPF; Fri,  6 Nov 2026 18:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 67029408FD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793989385;
	b=tZXbHornJkVbrkEyz8pEKMu/tdlchzM8WLyQuWAycfjzTQlOfs425SrrSlhuzF5Il/82
	 DrDdrBs9rDjIOFklmWc3/IXnMimZB11SIlNBXAXqTg4VSAiINZUI1krXes4pF4d/CTlOs
	 SIiVptsqbBHUakPmhAYpuMtzrTSargn8vem6iPkzNsl6MTCBohzDiBuCdCJTUs62DU4EM
	 li2x5IZwhDzwbrZ1KNDtMdj3HJI3uXNOntaovXn3blhdM+5agOEjfLFJdUi05DggMvUyo
	 lr14x2ZN5iNfASicZhzwgJlnlnCnyN5M/Bcl/cQQheulyVqa/KhYIE/WIec20kyISWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793989385;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Mailman-Approved-At:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zQE2LJaKzUMcQYm/a5t2rjYB6AjgysJ8m0EjKs/wZ9c=;
	b=jVc50SxU+xqaDOMhq/jTUqbSI8kxcr2srPXr60lJNFfSwD2ZqVXbw0ihcmKW+7eC7IIq
	 36Ln73LaxMC7VMTaXL+PXrVv/GgJJS8E0h4Zqbpn4PHi6jHhir+MRJva6UOv72GkeK0Nl
	 5EXZlOfR3+vp/pxRcC+hqGRb9EjewrrQ1JjC8CD/Ah/RGHzIupzUAWDTpPM40Zw49EJIV
	 LOAPbx0klbo85LFGyzVK1X4rYKiDGnFDDMxFmXCUvUqlx4AZHshLh0kVced/ffuCbN8qC
	 vBzhw5PcmN6n8zxKDSCVNsNrkdB0gqTiPOiVdL91DNpYpdAtdLjUJr/iMvM87GEXAgQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=t0.technology;
	dkim=pass header.d=t0.technology header.i=@t0.technology header.a=rsa-sha256 header.s=google header.b=G5E7uuQA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793989385;
	bh=zQE2LJaKzUMcQYm/a5t2rjYB6AjgysJ8m0EjKs/wZ9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X1SAmxxBIlEIFY+IKXtWgNw1qNtl5U2DtYd9w+CxhylKAYrdju+W9pS1oFPKsrVk3
	 EqCFOAWadQ2EmRcaT3O9YHs97wjoX+P3w7mED0ST8roYh4Z/f6yFsIaGImckzvNhGi
	 xTJg5lAY+H0/jvMH97/SagVRWltVBCIBi1Bzalsw56szBobG44wX7Fpn9KJTd+su3p
	 lZ/YSj0aera7BVw/6vF3DKhA1RFPb+TG8WDgeG5bOdbYrYWbIY6hRjYi5twfKXGqlM
	 4QHMOSNkuFfHyaXcpIt/Boc8VCK2oxYusObq0JMQSzEjGd6v3+mOvU7UIP13XX91Xv
	 12rHdJTKZtt+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 67029408FD;
	Fri,  6 Nov 2026 18:23:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85C0F2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BC3C40802
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KpN5hpouFMDA for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9F5AF4072C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com;
 envelope-from=gsmecher@t0.technology; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=t0.technology
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=t0.technology header.i=@t0.technology
 header.a=rsa-sha256 header.s=google header.b=G5E7uuQA
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9F5AF4072C
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 17:10:14 +0000 (UTC)
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-8a089dfee18so1149758b3a.1
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 09:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=t0.technology; s=google; t=1793985013; x=1794589813;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zQE2LJaKzUMcQYm/a5t2rjYB6AjgysJ8m0EjKs/wZ9c=;
 b=G5E7uuQAv4jzYKWAGJHi7zFtBQZiV2rESRSGNF3Ru1kODwdQvtP0Iaq0HuU0Dq30fK
 i6pi67wLqyDlWW0HToaGGaysMf9SWj6XPYfMhQQNC3P6skNg99rjsEpj0mRo+ahgSpQu
 dgWSPM4XhEunDlDBerRa9OvZ/8SWBKVsuTox7mu/fP+DM4e1DbH/EqRajPr9XU28jMsX
 4YI5NQ43v4CxTeLtU6HsG6muf6WrgEJWw1pT7cdjAVaIo7N0EDRcP2KbRy3VL0uyvRE+
 UFfnR7LHtP5o0oTiAmgyup2uDB78srInrbF30Jb+ySq8iNdDG8y3xSXef35xCewuue1t
 tSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793985013; x=1794589813;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zQE2LJaKzUMcQYm/a5t2rjYB6AjgysJ8m0EjKs/wZ9c=;
 b=VM1fdZKSb38vZSVswU3y96bD6Z15SobFubBTALozihzzF4WVxkyXFLrCqhcxObvJWf
 /SNffcxp9oqKTM23Q9FJm5vPiBBvxyRwp1YRHmuBi8Tia4G2PDy3/oC5iQR9dn04pRrV
 cmaAMd/faNtCAXLCrYtbCOfmaDaC1L2PoXDfyen9RIsrd/rBPkfHOb42jyJFRz9clWUJ
 d+1m9N43VIkm9aq6/JCWHT2tUzYQN1E10KS6gCZqZjDWFuHUkXOuoX1Uf1rJWMUTXGW2
 68iK7UnGDD+V2WEtx6/e2mdZL/o2uu1DIbqcDLnTf7xbB9OVWah5JsbG4hI4yEzOrdAV
 rN6w==
X-Gm-Message-State: APuU4Z/7yf/IOJtt2FDfr3/HZ8NVs+cQZx5yUP1Fx+NBqJgZFBEYvfnY
 R/4Juo3Neir2VqTcy2BuVH3IoXule+U3U6dAnuqboMxf3FjxHEwCmqK/k7TJGzAetls=
X-Gm-Gg: AYBFou3YV0aELqthrclh+kz8cOjWhOFlg/8Zs6tKr2lN9LoBKMjU+P1N9I/5D6QM47E
 a66PMRElh6cV9STJobKbTv69felw5nLztx0ZO4A5itNmQ4OrKLt6Z1uqS8xQUD5EdEg2Q3cGHUk
 clPWsqZUwReURIEUasTna195e0X07PIuI/ZEi329JZpYNGjEvi9KMy+OPv0dQEteQJwocB1AeDi
 95BcFsl9RDDVQZklJZZ4iQFm3qwUzeV0mvdyP7sc06jSTfjeJB+ZiMt+sAxApfecW2zKVK9wjwH
 fD92lrWtB8fTpWxrnc9fzMAYKYKDFOHNPLm5rvcQHmeuOUvlKH3v9y8BR2rJXABMY99tNEVT6mE
 DjUTzuLtfK/A1zUzVMjl/Ms1rC/pzF0N94kU5X68fzDc4TxrEk5tRzNlpd7o1hnDc3OOiVIaNkt
 GLKIjsSWJkb0bKBLn7pEkIUOgrNwWn5Zj/Zrr7SjJE1dkV/WOVaoEiPApdrs6AsuKOSvrk/tQWU
 5eP6aE4KkmC8uFi//2Q1+GaL2VYuhF9Fvgpu8EfJcUKeNF24eQAj/M7OmTTBJIVotXT5NxGJy74
 LMFNDiD0Qd7ZTXvyxl6P5/KZOPPZbdEoS2H0mNNo/jgMERGWCJA5WIjaFrDjGWcFAuTTlAxVcek
 Pqhrm9AJ614fnyRx1EUVYmg==
X-Received: by 2002:a05:6a00:1150:b0:8a0:adf:cc11 with SMTP id
 d2e1a72fcca58-8b1e6224510mr4499973b3a.41.1793985013498; 
 Fri, 06 Nov 2026 09:10:13 -0800 (PST)
Received: from frosty.t0.internal (d75-157-214-184.bchsia.telus.net.
 [75.157.214.184]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b359dd36d3sm767461b3a.37.2026.11.06.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 09:10:13 -0800 (PST)
From: Graeme Smecher <gsmecher@t0.technology>
Date: Fri, 06 Nov 2026 10:09:05 -0700
Subject: [PATCH v4 2/4] net: zynq_gem: plug resource leaks in .probe error path
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-zynq-gem-remove-leak-v4-2-1995c70f540f@t0.technology>
References: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
In-Reply-To: <20261106-zynq-gem-remove-leak-v4-0-1995c70f540f@t0.technology>
To: u-boot@lists.u-boot-project.org
Cc: Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jonas Karlman <jonas@kwiboo.se>, James Hilliard <james.hilliard1@gmail.com>, 
 Graeme Smecher <gsmecher@t0.technology>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793984944; l=5360;
 i=gsmecher@t0.technology; s=20261103; h=from:subject:message-id;
 bh=smiUtssph4Vrbir1OIf0GRF5I3PiRBPR9O4h72t1Lbg=;
 b=ljeGYOB9OLRGXD6TPd5mL2wbHXQOl0UfikpkVrBQp85RoLHoD+4idbb5c+HxwebdfsCXBjNGI
 bry0Cbie/SaDrWgtA3MIDbNbs1hASAPe7DN1vFIDxy0l3zHgC74aaiP
X-Developer-Key: i=gsmecher@t0.technology; a=ed25519;
 pk=HArD3wunb+MyhiMSP+Hd9fErsJgMgfaKpINxIisnHbk=
X-Mailman-Approved-At: Fri, 06 Nov 2026 18:22:59 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

zynq_gem_probe() acquires a generic PHY (for SGMII), receive buffers,
buffer descriptor space, (usually) an MDIO bus and a phy_device, but
leaks some or all of these on its error paths:

- the generic PHY is initialised but never exited on failure;
- a failed mdio_register_seq() leaks the bus from mdio_alloc(), whose
  return value is also not checked;
- the phy_device from zynq_phy_init() is leaked if a later step fails;
- the SGMII dynamic-config and generic_phy_power_on() failures return
  directly, leaking everything allocated before them.

Rework the error path into a single label ladder covering all of
these. As in remove(), the phy_device is only freed when the MDIO bus
is our own.

Move the generic PHY from a probe() local into priv->serdes, so that
remove() can release it too (in a following patch). priv is
zero-allocated, so generic_phy_exit() is a safe no-op when no generic
PHY was obtained.

Signed-off-by: Graeme Smecher <gsmecher@t0.technology>
---
 drivers/net/zynq_gem.c | 54 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index d28b97d01d08da50049280fe2f75277506a4b740..0224b4ba245267d0514b80b6947f8010c3e5f09e 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -258,6 +258,7 @@ struct zynq_gem_priv {
 	ofnode phy_of_node;
 	struct mii_dev *bus;
 	bool own_bus;
+	struct phy serdes;
 	struct clk rx_clk;
 	struct clk tx_clk;
 	struct clk pclk;
@@ -930,12 +931,11 @@ static int zynq_gem_probe(struct udevice *dev)
 	void *bd_space;
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
 	int ret;
-	struct phy phy;
 
 	if (priv->interface == PHY_INTERFACE_MODE_SGMII) {
-		ret = generic_phy_get_by_index(dev, 0, &phy);
+		ret = generic_phy_get_by_index(dev, 0, &priv->serdes);
 		if (!ret) {
-			ret = generic_phy_init(&phy);
+			ret = generic_phy_init(&priv->serdes);
 			if (ret)
 				return ret;
 		} else if (ret != -ENOENT) {
@@ -946,12 +946,14 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	ret = zynq_gem_reset_init(dev);
 	if (ret)
-		return ret;
+		goto err_phy_exit;
 
 	/* Align rxbuffers to ARCH_DMA_MINALIGN */
 	priv->rxbuffers = memalign(ARCH_DMA_MINALIGN, RX_BUF * PKTSIZE_ALIGN);
-	if (!priv->rxbuffers)
-		return -ENOMEM;
+	if (!priv->rxbuffers) {
+		ret = -ENOMEM;
+		goto err_phy_exit;
+	}
 
 	memset(priv->rxbuffers, 0, RX_BUF * PKTSIZE_ALIGN);
 	ulong addr = (ulong)priv->rxbuffers;
@@ -963,7 +965,7 @@ static int zynq_gem_probe(struct udevice *dev)
 	bd_space = memalign(1 << MMU_SECTION_SHIFT, BD_SPACE);
 	if (!bd_space) {
 		ret = -ENOMEM;
-		goto err1;
+		goto err_free_rx;
 	}
 
 	if (priv->cache_on)
@@ -977,21 +979,21 @@ static int zynq_gem_probe(struct udevice *dev)
 	ret = clk_get_by_name(dev, "tx_clk", &priv->tx_clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get tx_clock\n");
-		goto err2;
+		goto err_free_bd;
 	}
 
 	if (priv->clk_en_info & RXCLK_EN) {
 		ret = clk_get_by_name(dev, "rx_clk", &priv->rx_clk);
 		if (ret < 0) {
 			dev_err(dev, "failed to get rx_clock\n");
-			goto err2;
+			goto err_free_bd;
 		}
 	}
 
 	ret = clk_get_by_name(dev, "pclk", &priv->pclk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get pclk clock\n");
-		goto err2;
+		goto err_free_bd;
 	}
 
 	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
@@ -999,6 +1001,10 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	if (!priv->bus) {
 		priv->bus = mdio_alloc();
+		if (!priv->bus) {
+			ret = -ENOMEM;
+			goto err_free_bd;
+		}
 		priv->own_bus = true;
 		priv->bus->read = zynq_gem_miiphy_read;
 		priv->bus->write = zynq_gem_miiphy_write;
@@ -1006,7 +1012,7 @@ static int zynq_gem_probe(struct udevice *dev)
 
 		ret = mdio_register_seq(priv->bus, dev_seq(dev));
 		if (ret)
-			goto err2;
+			goto err_free_bus;
 	}
 
 	if (IS_ENABLED(CONFIG_DM_ETH_PHY))
@@ -1014,10 +1020,10 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	ret = zynq_phy_init(dev);
 	if (ret)
-		goto err3;
+		goto err_free_phydev;
 
 	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
-	    generic_phy_valid(&phy)) {
+	    generic_phy_valid(&priv->serdes)) {
 		if (IS_ENABLED(CONFIG_DM_ETH_PHY)) {
 			if (device_is_compatible(dev, "cdns,zynqmp-gem") ||
 			    device_is_compatible(dev, "xlnx,zynqmp-gem")) {
@@ -1026,13 +1032,13 @@ static int zynq_gem_probe(struct udevice *dev)
 					dev_err
 					(dev,
 					 "Failed to set gem dynamic config\n");
-					return ret;
+					goto err_free_phydev;
 				}
 			}
 		}
-		ret = generic_phy_power_on(&phy);
+		ret = generic_phy_power_on(&priv->serdes);
 		if (ret)
-			return ret;
+			goto err_free_phydev;
 	}
 
 	printf("\nZYNQ GEM: %lx, mdio bus %lx, phyaddr %d, interface %s\n",
@@ -1041,13 +1047,21 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	return ret;
 
-err3:
-	if (priv->own_bus)
+err_free_phydev:
+	if (priv->own_bus) {
+		if (!IS_ERR_OR_NULL(priv->phydev))
+			free(priv->phydev);
 		mdio_unregister(priv->bus);
-err2:
+	}
+err_free_bus:
+	if (priv->own_bus)
+		mdio_free(priv->bus);
+err_free_bd:
 	free(priv->tx_bd);
-err1:
+err_free_rx:
 	free(priv->rxbuffers);
+err_phy_exit:
+	generic_phy_exit(&priv->serdes);
 	return ret;
 }
 

-- 
2.47.3

