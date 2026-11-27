Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D775606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=riolF8wa;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCBROe1A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED5B781299;
	Fri, 27 Nov 2026 18:29:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9T3mCRFv3vBY; Fri, 27 Nov 2026 18:29:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4373D812BE
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795804167;
	b=fU8dikqGbY5kBX6voj3vutq6qCjvRgC1G5epOUZX1Qd9Hm0T0U+Mc87Ct4Ag7EUHv0Vr
	 HobwZenWirNu8bpwmnSRx4gM2ZoywAw6JX3mNuMdUdLbXaJ2jkVv+XAQPyDCIML9vj4Tz
	 ynYEBEiZm92MDgmNLLxDWLlm8E7rJ2bT7VGFHvlxZZQ0AiZkXwRkfX/qUk0IdyvNiJDz3
	 uoyzG8E3rLk/qoSXTgGk1PNCzjYh1Ju29u3TZ2xF6VBscvp/qZL2uFmRqwJAHH3y5PIPo
	 6plD+58wpwgf31kuKZyvastYlT5EdPo9A80r5i2JxvlSgAjzdLSo0su6//5znvkM2fA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795804167;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OtlSftBI79mmNbtanmzE/f5ILyRBHsyBsXkCrucrtoQ=;
	b=dP8JZL55JvtuZz/wczu+CSywCrA06WwCfXrnCwBx/F6Rez/XJrTsU3lxXDDrPuLqAx/5
	 YEBpetBAl23yd7F4hLOgd0kWz1DfvXyYnJbNkF2DOevVZZPDlB4hFUxtawn0p3u4wKLWF
	 bGoeMVwlpebm2KGTWZM7w1Zgo6zanqVPhXO32GHXz0gg7jAcA+jw38vWXRAgsyYk2YE1J
	 ORlr2VGYc0GzI7Yh4OFbZdkrlYM/bfoRgC8aAQXsdWLk2DHVHOjJNm7VRK/fsDpdOq53G
	 J8qWTYM9Vl8O56PpIfeT/nwU1Lk4pZSTJ1ObZ8E5UYBZfOEGJDA+iWo33pOb0msY0LQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCBROe1A;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795804167;
	bh=OtlSftBI79mmNbtanmzE/f5ILyRBHsyBsXkCrucrtoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=riolF8wa+pbXcj/h51/ISJdhPZAe41lPYqBfKUgucUy8gGh6diM6VtgfAWbUXJLZn
	 xGHqQJEQZNcgjxD5PLzFTmExZKZrmVrtqqdxDIhsC0dSy8O2YciXyQKhwrahE3/oHf
	 0vmC8pcqtRGuXZHz0UXYPmTueSEgXjFnrX1zkPqYNjz1WiSjeXEISQ/zugkSe4A8lc
	 pqjFsA3v9qpouQAJKsMPGSg2TznKfoqg2KeSJK/p/TD5ydHzQKZE16jSxkm/gGpdt7
	 uoc7aPSiyKiI4gAibMK7AjhqqaeKov21z7rzqcc9nSL2rxkPEXPgzWHVbM/f6ImFkW
	 LSrwA1p/S0MFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4373D812BE;
	Fri, 27 Nov 2026 18:29:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 967893D9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 888D5812F9
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8XvG0c_yzxxJ for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 18:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F4ED812D1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=yCBROe1A
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F4ED812D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 18:29:15 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e47347279so5142919f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795804154; x=1796408954;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OtlSftBI79mmNbtanmzE/f5ILyRBHsyBsXkCrucrtoQ=;
 b=yCBROe1AynwX/bElcCHH0+Sem4+YpAlJtmQU4KkNbIWzqcvLbJJbm6WS4zvg2/y/6M
 7/jy5lvZmkKI9z2Epn0v+sb/T9GTay8fsfQgvlcNDJF0FLsQ03eSAioZ1N7LGCEurHNR
 CLdr2elVACJIHhibjKaI5dxTYSFP6pq4nHZjRE+1LX0taWz0Bxoidkm+sLiKtN3VfGHh
 VcMbiISw2yWM+4Ln8NIBsYL9BOrZTKz9S2R0E1ZuTvVb8cfqFin287+5IblGNAEJx5TH
 zJp90c5PY6y+zPLVidbGAOM7hoLNdtCwSBWMceRIcBuXInbBHnnUOszZSQpgq+YVnGmi
 nSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795804154; x=1796408954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OtlSftBI79mmNbtanmzE/f5ILyRBHsyBsXkCrucrtoQ=;
 b=DaYMfAAiYle1m8il6nAUVD6xkqoeQaFgBErIKePyB1gz7hHCC0vQvaJ88WVQbbEm8F
 muNiHjwbLoMA/TBRI95zYWM1f7EYAcOOs1umdubjZnAr8U4XizH8XN113ps0j+4znqsW
 AkJQwM6YaPWbLTfQbHDxRGWlT4VgGeovg+9a83BnTD1naN9/Dg71SPtUgDl2f5pJYrnp
 gpFwQBzpW0go7sdfqhkGSMao2HtPH2JYbG9hrtmCQw79Bbn9Fzu2RzDM1AkICltch4wd
 qdL+FMrx1nJykD6dNLVLXCukdvPVjGSHdxZwevRvuGRYzUQoTP4FyiBhetgef37KOCLh
 o0JQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEEgqaUdJMqLGORkn8X5He7eanBLIMtWF4oiOS4HaCkaW6mgvqUDogWACZwNONjJPIYzU5oboA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z92TaPhFjcOJyhp5iQTn/gDXnYnvMwaUrKHEwaLLts8E/zEbcmQ
 qEWQy1ulYrPttO5Nml69znkiVnsbgGQ+A3hcm+ZIh+LKioeLcPsvR6Eh
X-Gm-Gg: AZFdTZcY9jp+JBIDwar8WdciHzpkZmNRXcXyxsfwE5zurE91X05QaOpPPnCbjWji/RW
 CR7kny/TBWGLhF/cF4+wBySDLBB4ZWo1e3r3OhA9EiYmH7LZFeW/9xCEq0wtVHWKOxLLgxa5Et3
 g1AEGj/L8QzVNT6i+rVMezdJsAYPpgtJqLS8yz5H2HaAJ8qNNPIhaUt09XputM1YYwTDFvCel8O
 U9XJ6Q8nNlIojqo42ywFvib9EaTqU3e09A0qQk4oZDziq0G0gVdDpAPlLu3CQfFqRurcAxHiCIr
 U9YupbNEE7nFhloD6cpyeCOvyEae8pYu/YNeV0PcJxQ30kX1aBnuiYFGBXxWtantrNsswrw57+V
 A5VUnjpx5W4zv9RGRzzQVq/xjqf2CwmtJbJq3RevSroA60F8isTguQA5g6k3wwQz3B2+3qIK1f4
 D2oCMvdqyGKgTmzMiaZjWO2eUHh55q07XD29m9xqlF/cF/WZHhSWVOv1aeh9Z426xC9nt4dJrUo
 WnuXF4jcEIGO0E6klXGHRHOuo40KQmX+CCTBtbFF0kScemN9rXCcFBl/FuDFa+oFn51M0D7FQaq
 nJQd6lryGMQYnQyurENXQiGkkpBVYzhcwtdGmOMWCODwxOgyE2l77Mylnw==
X-Received: by 2002:a05:6000:1789:b0:491:971a:c568 with SMTP id
 ffacd0b85a97d-4abb3861356mr46852064f8f.10.1795804153940; 
 Fri, 27 Nov 2026 10:29:13 -0800 (PST)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d1bsm50584856f8f.8.2026.11.27.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 10:29:13 -0800 (PST)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, mehmet.fide@screeningeagle.com
Subject: [PATCH 7/8] usb: ehci-vf: enable the controller clock
Date: Fri, 27 Nov 2026 19:29:04 +0100
Message-ID: <20261127182905.2836449-8-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127182905.2836449-1-mehmet.fide@gmail.com>
References: <20261127182905.2836449-1-mehmet.fide@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mehmet Fide <mehmet.fide@screeningeagle.com>

The controller clock, VF610_CLK_USBC0 or VF610_CLK_USBC1 in the clocks
property of the controller node, is only enabled because the board code
ungates both in the CCM.

Get it and enable it with the clock of the PHY, before the controller
is touched.

Signed-off-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
---
 drivers/usb/host/ehci-vf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/host/ehci-vf.c b/drivers/usb/host/ehci-vf.c
index 1848690d3c8..f903cd4f670 100644
--- a/drivers/usb/host/ehci-vf.c
+++ b/drivers/usb/host/ehci-vf.c
@@ -43,6 +43,7 @@ struct ehci_vf_priv_data {
 	void __iomem *misc_addr;
 	struct udevice *dev;
 	struct udevice *vbus_supply;
+	struct clk clk;
 	struct clk phy_clk;
 };
 
@@ -95,6 +96,10 @@ static int ehci_vf_common_init(struct ehci_vf_priv_data *priv)
 {
 	int ret;
 
+	ret = clk_enable(&priv->clk);
+	if (ret)
+		return ret;
+
 	ret = clk_enable(&priv->phy_clk);
 	if (ret)
 		return ret;
@@ -148,6 +153,10 @@ static int vf_usb_of_to_plat(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	ret = clk_get_by_index(dev, 0, &priv->clk);
+	if (ret)
+		return ret;
+
 	priv->ehci = dev_read_addr_ptr(dev);
 	priv->dr_mode = usb_get_dr_mode(dev_ofnode(dev));
 	/* Handle legacy DTs without dr_mode property, fall back to host */
-- 
2.56.0

