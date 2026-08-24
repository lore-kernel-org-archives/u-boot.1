Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA628C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 19:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C9C840450;
	Mon, 24 Aug 2026 19:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cceHrSzEexv6; Mon, 24 Aug 2026 19:03:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787598237;
	bh=DsZugo+9eIfO4XqZZhImIxAZZF/iBsXhJL9QpgfXMyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TopGgTDISC4unvta1s110y+RRC//WAL+Rj/ZpFccS4tEArjRM2gzAbEnO+rnP7bCe
	 66d2CoWsUVQ/qg/dSf25GYD1R0c/Rgp7D12ILMRbj4pX8YM39BV1L+shEuA+YCG3ZY
	 +Fr0ljz3m3ukX3U84Krjm+gBjxOjFvlR9yDE2IydcUAZwD9/3srnqUjRkgtakjaVFQ
	 yBUXRJgLdlAVEcw81Cj+cxJ/W9G6QOK3yx82c62nUOyJ6WdKMJLpR6trXOJzzEVBA+
	 VNW4wAmwJVWjtksw5S06DBr801r+KA6o4Mb30SR61HSdUBUtJ4dGvZwZbi4HuMtYUn
	 1DhYnt89NIPzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB048403FF;
	Mon, 24 Aug 2026 19:03:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3651396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1330405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6RBHDfBVf8h for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 18:31:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::636; helo=mail-ej1-x636.google.com;
 envelope-from=eichest@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qS44aYhp
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D78DE4059B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 18:30:59 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15ba3a2b4bso546590466b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787596258; x=1788201058;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DsZugo+9eIfO4XqZZhImIxAZZF/iBsXhJL9QpgfXMyg=;
 b=qS44aYhpq59iMU9C86V8ny2S0Ql0PGhrg2jHiNAH4EBgB+4EIiPFV6nfDHNtrqvg0Y
 yejNcxRQzc8eIGFzizLfjujqUivzdu1gl6GLfRe4w6Pmdg3PsyondbIEfMdey7aMPsdV
 hFBYbPtUW3dqGi44hsDnJZ4pZBVC+ZyYpCMkCPBgBqSxib3KYz1N8SXG0QIiOTinUZ1g
 kxH/53BlXDaUQq9NhhqOlT2bRi8PIltrEipeiYQ/Jl0ctclvQmkh8B6CBiBNp6o6T4EM
 osC/PJqrdI8iesYLryvalZbGuaHGunlWyNN9fCT3V3St3VtNn5IWGjia1XYUA1YZNlrq
 2Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787596258; x=1788201058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DsZugo+9eIfO4XqZZhImIxAZZF/iBsXhJL9QpgfXMyg=;
 b=R57BR5jooUL8JSaacMCe1BhDblQx5oePduu4BaPRIuumCZEYUmjol9ldlNXjwBuriO
 3HV8UkXu9b7I+5ErSF5ZDxiV2OJnTEthcyuRw6zvDv2Kuh/X0KdLOqA8608hbQyy0Qgx
 hJ4qrl+Xut2YuhpIm/oE5r4jboOeKuE85rX9ziLn3BWZLK4TSyi16PCt5z2AjJjPEu8Z
 s1YgHoXY2LGKE3o/CbXe7dTmARz/JX8Je+GLbCYcGqNXIDD4cab8K58HKVh22ewqq6oy
 E9GhlBZwETEsr/YDD8ZZPTO6QV1IoONfsN9kd7SRJt5JoxCCjjQkHj2LACVDF9JC1c07
 Ghsg==
X-Gm-Message-State: AFuF++m+RiWCS75m40NrrYW1ua7GTP648JJ1xvd3OXcSTxz7JS2JDJjs
 Fs/mF8HFlo+EuPJTixlGA88GPZEgXKETGi5LY9+YPyQaut1QqyglkvI/
X-Gm-Gg: AR+sD11v88msXIqS7Xc0RRUexw8kfwVNd7q/PsJn77qxy4kWb/j4ZG9Dhh9S982TW2a
 hMbWwad28lL3yqlSWtt0y47Cc1uhQz73EggBEb6mV+IAISHl5uNxUMLMKqUX4cO+OfGt/4DblOW
 8r1xRU/EPN4GjaP3RxUm+JTCyXSAoP3ZQAw4xo5PP+7fPWL9X907AfYWhj0PFq/F0CVQ6PlaC87
 cE1gcCUjJWb0NM34p4L5pm3hvCWISC5i5zmgszICCMM98b9g8l8/4CXQ+yqLDSo8tucuCTL4sXn
 bDb+Ri0HCe0n4gSgj8yg0lHvBx8Lpr2cltFL6ggVjDJ+RW/sXr9MKyIpxLi/rfdX3SOSIYxORdC
 cNqQSo5Xso5bPIWbuJBCMuheb9AXWSDlwwUnEju62KKZv44DDwEtG9kHxkoL14CKd4bCm5XcdJY
 5q3aYDmakdoD88syzlrwJ3pjYxenI1nbTie2hWYl3J4ytcVFtLOEdAKw==
X-Received: by 2002:a17:906:100a:20b0:c16:8799:fcb4 with SMTP id
 a640c23a62f3a-c246a6a93fbmr2258299466b.19.1787596258045; 
 Mon, 24 Aug 2026 11:30:58 -0700 (PDT)
Received: from eichest-laptop.lan ([2a02:168:af72::cb4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606a8edsm1355044366b.6.2026.08.24.11.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 11:30:57 -0700 (PDT)
From: Stefan Eichenberger <eichest@gmail.com>
To: francesco.dolcini@toradex.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sbabic@nabladev.com, festevam@gmail.com,
 uboot-imx@nxp.com, marek.vasut+usb@mailbox.org, alice.guo@nxp.com,
 antoine.gouby@toradex.com, stefan.eichenberger@toradex.com,
 emanuele.ghidoli@toradex.com, franz.schnyder@toradex.com,
 balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
Cc: u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/6] usb: dwc3-generic: fix ref clock lookup indexing wrong
 clk_bulk array
Date: Mon, 24 Aug 2026 20:29:10 +0200
Message-ID: <20260824183048.419198-3-eichest@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824183048.419198-1-eichest@gmail.com>
References: <20260824183048.419198-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 19:03:53 +0000
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

On Verdin iMX95, with a USB hub permanently attached to the DWC3 host
port the hub itself enumerates fine but a USB stick plugged into it
fails intermittently:

  Verdin iMX95 # usb start
  starting USB...
  USB XHCI 1.10
  Device not responding to set address.

        USB device not accepting new address (error=80000000)
  Bus usb@4c100000: 2 USB Device(s) found
         scanning usb for storage devices... 0 Storage Device(s) found
  Verdin iMX95 # usb reset
  resetting USB...
  USB XHCI 1.10
  WARN endpoint is halted
  WARN endpoint is halted
  unable to get device descriptor (error=-22)

Commit c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in
both controller DT nodes") added a fallback that searches the DWC3
child node's "clock-names" for "ref"/"ref_clk" when it isn't found on
the parent glue node, but always resolves the found index against
glue->clks, a clk_bulk populated only from the parent glue node's own
clock-names list. This is wrong since the child node's clock-names list
is not guaranteed to be in the same order as the parent's, and indeed on
Verdin iMX95 the child node has a different order than the parent node.

Fix it by resolving the index against the child node's clk and ensure to
enable the clock before using it.

Fixes: c6583354b7c1 ("usb: dwc3: Look up reference clock DT phandle in both controller DT nodes")
Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2356b3bc0aa..e16d236bd9d 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -31,6 +31,7 @@ struct dwc3_generic_priv {
 	struct dwc3 dwc3;
 	struct phy_bulk phys;
 	struct gpio_desc *ulpi_reset;
+	struct clk ref_clk;
 };
 
 struct dwc3_generic_host_priv {
@@ -76,9 +77,28 @@ static int dwc3_generic_probe(struct udevice *dev,
 		index = ofnode_stringlist_search(node, "clock-names", "ref");
 		if (index < 0)
 			index = ofnode_stringlist_search(node, "clock-names", "ref_clk");
-	}
-	if (index >= 0)
+		/*
+		 * glue->clks was populated from the parent glue node's own
+		 * clock-names list, which can differ in length/order from
+		 * this child node's list (e.g. i.MX95: glue has "hsio",
+		 * "suspend", the dwc3 child has "bus_early", "ref",
+		 * "suspend"). Reusing this index against glue->clks would
+		 * silently resolve to the wrong clock, so fetch it directly
+		 * from this node instead.
+		 */
+		if (index >= 0) {
+			if (!clk_get_by_index(dev, index, &priv->ref_clk)) {
+				clk_enable(&priv->ref_clk);
+				dwc3->ref_clk = &priv->ref_clk;
+			} else {
+				debug("%s: failed to get ref_clk from DT\n", dev->name);
+			}
+		} else {
+			debug("%s: no ref_clk found in DT\n", dev->name);
+		}
+	} else {
 		dwc3->ref_clk = &glue->clks.clks[index];
+	}
 #endif
 
 	/*
-- 
2.55.0

