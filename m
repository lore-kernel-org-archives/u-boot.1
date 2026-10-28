Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C2D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nD3bK2o0;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wjTU/zyY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B62CF81584;
	Wed, 28 Oct 2026 14:49:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pDuMA4kFDtWK; Wed, 28 Oct 2026 14:49:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 82FB681205
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793198867;
	b=oy2ok3yuBS4MDrC3s2e6AR5WktyQvEil7pezKqbjUEftmFAdzSDTzPAqkGROmwE7bif8
	 pS5LzbPQPN40mVGA3xar5dDHYVxFY46RdLRzgmKAHvOwM3qbxhUzB8vHCt4EpxPzEVef9
	 48H9gA3xDVjVod9C8I7DUrMcoTo2cQdPOMSjt6gjdzMBRoR4xp1CbQqPil7PvmGPpMWsE
	 Xvvyn5JhCgR081iD4WLZoayPw1Zpata9bK7wQcm8nZluqLYN44j//flVSNMVsck/hFZ0K
	 QQpYH6w5OyesXoPinmDJGjNKqVY30vwY+FCKGEpcm3SRciONLU8yuSk93J6v1lQKNaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793198867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
	b=g77pYXHDTdECiPHbuntCZllIes9qqD1X4TLWW7QNmDUs5lr+hmIk/FS/AI+mIiN+0sBF
	 Byhc7nARGYmIz/NrdiMKMQSj4v1RyXIrCKWxBtwDGGH39VNjKnfNwFyh0caZOmadC4hGY
	 ZYAfdVwdBW53TE6qPjRMIQfS+oYQxJC6MnXw07gPzZmbxzB+yab2Joloqhxy0aJyMIQ4Z
	 GDXslPh7gsIAd/0jJqRL5AyP6anafMaNQNmvOhmHZR1nOw1Ooebusia5TIjUgLsZJwWkV
	 zYCHh91e0+LYpz6R2EIDT2QgLSf3MbA6P8nzPYa+E0OLQXswS8WlJiNaFVhNCM/eXZg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793198867;
	bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nD3bK2o0/yZ+elTyFeR3Fcz1a8ceRhcQjgZGTKHlUF6erTakhZERpbiDrzz5Sp4CG
	 Uc6oNow65SP7/ZkO4mkKgvudR3OZih9MqtsRlrIx0wrU5KxCfIiCikGGEI3FnWTwiI
	 +tstyPvxX2gIWa9p0+jEYtklxBCtpmmNnInEpnoAeGY0DSN1fkbOtCurD+aeJJcvQB
	 9h5jwPslwRqSkz3HUrhQHFUUoy9et7lpAmx5q3AVGDL/iihp8U07ob7Wtq9Tyv2X7e
	 jxnTJAOqcrKZu98f2GLofkXHmMFUC/sdcpVqbOJhGt8b7NcZSfwgaMo6lHWeZuSRmY
	 YoB5MIqAa+44Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82FB681205;
	Wed, 28 Oct 2026 14:47:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 174FB356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1BFC6060A
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id naIz3R0oTD6S for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:14:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A1AAF605EA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793196887;
 b=faoOrXSathyDm7hHjPYinkVJmp8BIHvW30DINee9iZED3FrATAENGOUvkL3iSoV8NwJQ
 C15gUVmdMn7oTtKDDrMTauqsuKHuFW/kaORgg0jJCVCGLkLLr3SIRNXpJS9q6Df9z5IKY
 aXIWKsG5JlrzoVEYo6QffmhqZwaoizS9p4OPpec+wTYb5gYENhqOpRgylNRZH/NdCaiyv
 62+6BjXUZwzyVHnC4ZsXgLIEmUG9g5w8+IdV74woS0ittT68n/6Vt0eDYUneVWOVILINi
 ql0ifFqxcgrYOQsUEkUMiM4AHY9FMnwYk56bhvWS79/SaI1fK5zjwDNqHEWfHI+U+6w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793196887;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
 b=GjQz0zPmqk5tCFXmjG1wY7iyt4IcE3ebvXSkiJ2crOMES6pAmxfr/1c0HPNy7sIUDhjU
 6H3f2LJrw53XgiXPvJxT7GYvUMVbbfcMtQfshfdQchDqzt9QJLRMARHiD8rXgwIYVJgz1
 vGrmuRrO/mGeiDVu8dvS4C9XOQ3g4pXR5asJJ9kjPY/F2oSia0R5fyL2GiNR1y+e67SeX
 tH7BGWmJpWpGGvgBWSt8DTBOoINsd3ATKEPrLWLImPb5olvnJfhMDSPpF3auCuuiI5lMg
 mKGq64QUodQ8Gr4iJjStP1uF+5IE6nUJqtYTBPMOsy7kHIIi7chYTHGxsDsv4Nt0dAA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b="wjTU/zyY"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=wjTU/zyY
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A1AAF605EA
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:14:46 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c499e0e43a9so13408966b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793196884; x=1793801684;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
 b=wjTU/zyYGUdELG4wAtm0L+qDrsqDc9j9LkN22GinXMQSNnvDQPifvaUFZ+2mHuO60V
 B5G3nvql576yukj2zUVvvQTGfVEI76hSTTUcg3+/HMv52QLVY/OtLTNyCk0OXEMwU82t
 F2nTnVGHq8lytSoyiUklEJGNgOZEk/D3S9OlOdJp1CwLG04bS/07JEdE3apXSq8o7ItS
 ifbFlgKyNbYa/BYeA/NUFav+ysXVuBu4nxNbg+RLzYsoVj85DUjmT4cfsMv7ZTWHwvBa
 mWCcfnWMQ4+iXWXWG6iAzEkWFCxdsaiA/8NhkYt+B1QLoDSoKT1U4OKRfVlPTsCa1qMP
 Hg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793196884; x=1793801684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RlMkc44Iyrnbx2OoDcbaROuw3oDHAg7iCFsic+ZoGYE=;
 b=HH7XUQK+Mo2BlIV6WJSsqoS0OEmssINQ1y2Xnv5PzINZlkCHjFfLVVAveh4HcUr8Ef
 rJM19u/Si3Z9chlboeHPYi/Fu/Cm27pfIkYfDdPNLBaEkblXPDtEAmKTqbF4bk+E3sDu
 4AB+/JoDeLoGq83UvL0TnYtrUm0lj+MS91kgh+aMuB2uKNrpOUnp27Jg/qfIex0D8ctR
 +2OFr+Zs5W7w/MK7FEEUIrFORBea+2FgeD1ECnWDzSqSTs+rYo3VTg+6UQ31Db7mXyGU
 y1mf2UXMUf3UYcE4pDswwkCR0s+i8qOLHw6UM/peXFkLJJArx5kTFuTMDZ63/O2pfcVL
 rpQQ==
X-Gm-Message-State: AFq9FYKQdYzctx732UWzKMIbCLMy5+F0U3vCsjO2kyujIj1v667vWB4G
 LTWeMsy0HCHcLrIbqW9+uNoPVWORsHk9IWlfPhUDmAzt66/tU+ndRhIyRfT6uvmudNi0CFGdvkK
 ZWGFi
X-Gm-Gg: AYBFou19dNLBxC9xxEc2YMGl7GpbhpwnFeG6ODDzomfREqswD8UjPuCUb6wGaFuqlVf
 GzV2Nqe+Dbai4BN6Nd2wolxvayzA34en+J3LtvnXTAu7ctkqsavQxxEnL3LeaoXY6ev3sQKdOKY
 JRbG1hFfprWTcbLhwCTT8TJYFNWflYq94+5qXqRRioo+w9H2of+KpcLIueEpepzizg69n0eu9L4
 IoqLzT5aXKAwRr3HK911EWymgehAgjnrz5h+aNgbToEHbipgZ6QE52CsCw8VYl3W/1wo4s4sfa7
 atCNZTwSh0igWBbrr1SpvKKrX966WjNUDlteCsqHkDi/SfAvJ8qHVWPe+uuHiyXDPGo0IhxCex2
 YHyq6EadHiAqLgkBtxIUsGOciAmGTre6ATKkVfBDipo7iZBvmRwHCh/qxcqCySJZCkbElzQgfb7
 crq3wnYsykVmJvPlWBa5J5wxaxFACNcOscVEkWSe1Yuot98CZTKweqGjezyxpaOu66HrwKzLzl6
 P5VKK04rkASVtAteHUdplov+CIutTalo40sQOnqW7o1n+GmJJwp/vO4ZAELKQ9dw0+D0uRYaqkE
 Q/lVcHMlliyxpvVVE6wwEmrDjgyyRQPchdZyYwERZebRdVYpPtyetABHCKX4H/uOsZaxprfRq4o
 JZWG/IDTiuoTLdVMEZ5UO3itxPGze5ok=
X-Received: by 2002:a17:906:d932:b0:c43:f1ab:167c with SMTP id
 a640c23a62f3a-c49bdd9ab19mr229625166b.1.1793196883773; 
 Wed, 28 Oct 2026 07:14:43 -0700 (PDT)
Received: from monster.taild06a60.ts.net (c-85-229-7-191.bbcust.telenor.se.
 [85.229.7.191]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd524266sm630210266b.38.2026.10.28.07.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:14:43 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@nabladev.com, alchark@flipper.net,
 jerome.forissier@arm.com, mkorpershoek@kernel.org, sjg@chromium.org,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v10 60/63] usb: dwc3: import from kernel v6.15
Date: Wed, 28 Oct 2026 15:09:26 +0100
Message-ID: <20261028140930.3025368-61-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028140930.3025368-1-anders.roxell@linaro.org>
References: <20261028140930.3025368-1-anders.roxell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 14:45:46 +0000
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.14 to v6.15.

The following files are preserved across the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v6.14..v6.15
Commits imported:
2372f1caeca4 usb: dwc3: gadget: Make gadget_wakeup asynchronous
63ccd26cd1f6 usb: dwc3: gadget: check that event count does not exceed event buffer length
042c3dd1f2d3 usb: dwc3: Don't use %pK through printk
07959ad5775f USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
5425191f85fe usb: dwc3: gadget: Add support for snps,reserved-endpoints property
eafba0205426 usb: dwc3: gadget: Refactor loop to avoid NULL endpoints

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 drivers/usb/dwc3/core.h      |   4 ++
 drivers/usb/dwc3/dwc3-am62.c |  12 +---
 drivers/usb/dwc3/gadget.c    | 135 +++++++++++++++++++++++------------
 3 files changed, 96 insertions(+), 55 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index aaa39e663f60..27eae4cf223d 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1164,6 +1164,9 @@ struct dwc3_scratchpad_array {
  * @gsbuscfg0_reqinfo: store GSBUSCFG0.DATRDREQINFO, DESRDREQINFO,
  *		       DATWRREQINFO, and DESWRREQINFO value passed from
  *		       glue driver.
+ * @wakeup_pending_funcs: Indicates whether any interface has requested for
+ *			 function wakeup in bitmap format where bit position
+ *			 represents interface_id.
  */
 struct dwc3 {
 	struct work_struct	drd_work;
@@ -1394,6 +1397,7 @@ struct dwc3 {
 	int			num_ep_resized;
 	struct dentry		*debug_root;
 	u32			gsbuscfg0_reqinfo;
+	u32			wakeup_pending_funcs;
 };
 
 #define INCRX_BURST_MODE 0
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index c158364bc03e..9db8f3ca493d 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -153,11 +153,11 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 {
 	struct device *dev = am62->dev;
 	struct device_node *node = dev->of_node;
-	struct of_phandle_args args;
 	struct regmap *syscon;
 	int ret;
 
-	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-phy-pll-refclk");
+	syscon = syscon_regmap_lookup_by_phandle_args(node, "ti,syscon-phy-pll-refclk",
+						      1, &am62->offset);
 	if (IS_ERR(syscon)) {
 		dev_err(dev, "unable to get ti,syscon-phy-pll-refclk regmap\n");
 		return PTR_ERR(syscon);
@@ -165,14 +165,6 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 
 	am62->syscon = syscon;
 
-	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
-					       0, &args);
-	if (ret)
-		return ret;
-
-	of_node_put(args.np);
-	am62->offset = args.args[0];
-
 	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
 	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_CORE_VOLTAGE_MASK, 0);
 	if (ret) {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 89a4dc8ebf94..321361288935 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -276,8 +276,6 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 	return ret;
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async);
-
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
  * @dep: the endpoint to which the command is going to be issued
@@ -547,6 +545,7 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3_ep *dep)
 int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 {
 	struct dwc3_gadget_ep_cmd_params params;
+	struct dwc3_ep		*dep;
 	u32			cmd;
 	int			i;
 	int			ret;
@@ -563,8 +562,13 @@ int dwc3_gadget_start_config(struct dwc3 *dwc, unsigned int resource_index)
 		return ret;
 
 	/* Reset resource allocation flags */
-	for (i = resource_index; i < dwc->num_eps && dwc->eps[i]; i++)
-		dwc->eps[i]->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	for (i = resource_index; i < dwc->num_eps; i++) {
+		dep = dwc->eps[i];
+		if (!dep)
+			continue;
+
+		dep->flags &= ~DWC3_EP_RESOURCE_ALLOCATED;
+	}
 
 	return 0;
 }
@@ -751,9 +755,11 @@ void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc)
 
 	dwc->last_fifo_depth = fifo_depth;
 	/* Clear existing TXFIFO for all IN eps except ep0 */
-	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM);
-	     num += 2) {
+	for (num = 3; num < min_t(int, dwc->num_eps, DWC3_ENDPOINTS_NUM); num += 2) {
 		dep = dwc->eps[num];
+		if (!dep)
+			continue;
+
 		/* Don't change TXFRAMNUM on usb31 version */
 		size = DWC3_IP_IS(DWC3) ? 0 :
 			dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num >> 1)) &
@@ -1971,12 +1977,12 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		return -ESHUTDOWN;
 	}
 
-	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
 				&req->request, req->dep->name))
 		return -EINVAL;
 
 	if (WARN(req->status < DWC3_REQUEST_STATUS_COMPLETED,
-				"%s: request %pK already in flight\n",
+				"%s: request %p already in flight\n",
 				dep->name, &req->request))
 		return -EINVAL;
 
@@ -2165,7 +2171,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		}
 	}
 
-	dev_err(dwc->dev, "request %pK was not queued to %s\n",
+	dev_err(dwc->dev, "request %p was not queued to %s\n",
 		request, ep->name);
 	ret = -EINVAL;
 out:
@@ -2351,10 +2357,8 @@ static int dwc3_gadget_get_frame(struct usb_gadget *g)
 	return __dwc3_gadget_get_frame(dwc);
 }
 
-static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
+static int __dwc3_gadget_wakeup(struct dwc3 *dwc)
 {
-	int			retries;
-
 	int			ret;
 	u32			reg;
 
@@ -2382,8 +2386,7 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 		return -EINVAL;
 	}
 
-	if (async)
-		dwc3_gadget_enable_linksts_evts(dwc, true);
+	dwc3_gadget_enable_linksts_evts(dwc, true);
 
 	ret = dwc3_gadget_set_link_state(dwc, DWC3_LINK_STATE_RECOV);
 	if (ret < 0) {
@@ -2402,27 +2405,8 @@ static int __dwc3_gadget_wakeup(struct dwc3 *dwc, bool async)
 
 	/*
 	 * Since link status change events are enabled we will receive
-	 * an U0 event when wakeup is successful. So bail out.
+	 * an U0 event when wakeup is successful.
 	 */
-	if (async)
-		return 0;
-
-	/* poll until Link State changes to ON */
-	retries = 20000;
-
-	while (retries--) {
-		reg = dwc3_readl(dwc->regs, DWC3_DSTS);
-
-		/* in HS, means ON */
-		if (DWC3_DSTS_USBLNKST(reg) == DWC3_LINK_STATE_U0)
-			break;
-	}
-
-	if (DWC3_DSTS_USBLNKST(reg) != DWC3_LINK_STATE_U0) {
-		dev_err(dwc->dev, "failed to send remote wakeup\n");
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
@@ -2443,7 +2427,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return -EINVAL;
 	}
-	ret = __dwc3_gadget_wakeup(dwc, true);
+	ret = __dwc3_gadget_wakeup(dwc);
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -2471,14 +2455,10 @@ static int dwc3_gadget_func_wakeup(struct usb_gadget *g, int intf_id)
 	 */
 	link_state = dwc3_gadget_get_link_state(dwc);
 	if (link_state == DWC3_LINK_STATE_U3) {
-		ret = __dwc3_gadget_wakeup(dwc, false);
-		if (ret) {
-			spin_unlock_irqrestore(&dwc->lock, flags);
-			return -EINVAL;
-		}
-		dwc3_resume_gadget(dwc);
-		dwc->suspended = false;
-		dwc->link_state = DWC3_LINK_STATE_U0;
+		dwc->wakeup_pending_funcs |= BIT(intf_id);
+		ret = __dwc3_gadget_wakeup(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return ret;
 	}
 
 	ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
@@ -3429,14 +3409,53 @@ static int dwc3_gadget_init_endpoint(struct dwc3 *dwc, u8 epnum)
 	return 0;
 }
 
+static int dwc3_gadget_get_reserved_endpoints(struct dwc3 *dwc, const char *propname,
+					      u8 *eps, u8 num)
+{
+	u8 count;
+	int ret;
+
+	if (!device_property_present(dwc->dev, propname))
+		return 0;
+
+	ret = device_property_count_u8(dwc->dev, propname);
+	if (ret < 0)
+		return ret;
+	count = ret;
+
+	ret = device_property_read_u8_array(dwc->dev, propname, eps, min(num, count));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
 static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 {
+	const char			*propname = "snps,reserved-endpoints";
 	u8				epnum;
+	u8				reserved_eps[DWC3_ENDPOINTS_NUM];
+	u8				count;
+	u8				num;
+	int				ret;
 
 	INIT_LIST_HEAD(&dwc->gadget->ep_list);
 
+	ret = dwc3_gadget_get_reserved_endpoints(dwc, propname,
+						 reserved_eps, ARRAY_SIZE(reserved_eps));
+	if (ret < 0) {
+		dev_err(dwc->dev, "failed to read %s\n", propname);
+		return ret;
+	}
+	count = ret;
+
 	for (epnum = 0; epnum < total; epnum++) {
-		int			ret;
+		for (num = 0; num < count; num++) {
+			if (epnum == reserved_eps[num])
+				break;
+		}
+		if (num < count)
+			continue;
 
 		ret = dwc3_gadget_init_endpoint(dwc, epnum);
 		if (ret)
@@ -3703,6 +3722,8 @@ out:
 
 		for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
 			dep = dwc->eps[i];
+			if (!dep)
+				continue;
 
 			if (!(dep->flags & DWC3_EP_ENABLED))
 				continue;
@@ -3852,6 +3873,10 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	u8			epnum = event->endpoint_number;
 
 	dep = dwc->eps[epnum];
+	if (!dep) {
+		dev_warn(dwc->dev, "spurious event, endpoint %u is not allocated\n", epnum);
+		return;
+	}
 
 	if (!(dep->flags & DWC3_EP_ENABLED)) {
 		if ((epnum > 1) && !(dep->flags & DWC3_EP_TRANSFER_STARTED))
@@ -4300,6 +4325,8 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 {
 	enum dwc3_link_state	next = evtinfo & DWC3_LINK_STATE_MASK;
 	unsigned int		pwropt;
+	int			ret;
+	int			intf_id;
 
 	/*
 	 * WORKAROUND: DWC3 < 2.50a have an issue when configured without
@@ -4375,7 +4402,7 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 
 	switch (next) {
 	case DWC3_LINK_STATE_U0:
-		if (dwc->gadget->wakeup_armed) {
+		if (dwc->gadget->wakeup_armed || dwc->wakeup_pending_funcs) {
 			dwc3_gadget_enable_linksts_evts(dwc, false);
 			dwc3_resume_gadget(dwc);
 			dwc->suspended = false;
@@ -4398,6 +4425,18 @@ static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
 	}
 
 	dwc->link_state = next;
+
+	/* Proceed with func wakeup if any interfaces that has requested */
+	while (dwc->wakeup_pending_funcs && (next == DWC3_LINK_STATE_U0)) {
+		intf_id = ffs(dwc->wakeup_pending_funcs) - 1;
+		ret = dwc3_send_gadget_generic_command(dwc, DWC3_DGCMD_DEV_NOTIFICATION,
+						       DWC3_DGCMDPAR_DN_FUNC_WAKE |
+						       DWC3_DGCMDPAR_INTF_SEL(intf_id));
+		if (ret)
+			dev_err(dwc->dev, "Failed to send DN wake for intf %d\n", intf_id);
+
+		dwc->wakeup_pending_funcs &= ~BIT(intf_id);
+	}
 }
 
 static void dwc3_gadget_suspend_interrupt(struct dwc3 *dwc,
@@ -4564,6 +4603,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
+			count, evt->length);
+		return IRQ_NONE;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
-- 
2.53.0

