Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C4AC369D1
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3BB08214A;
	Fri, 25 Apr 2025 15:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gPWKSoWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0060A8213D; Fri, 25 Apr 2025 15:52:34 +0200 (CEST)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA05C8212A
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30820167b47so2364506a91.0
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745589150; x=1746193950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHVO0ITjHMDSH2rHTJAYMht0s+1PSOlE+Q5YVtOpPXE=;
 b=gPWKSoWXQ6/quL/0l9bsTZ/Feo2uFw9nw76SzkSDEnlnJmQHq47OYQbTAvxkqyQBch
 W6TPF5EIN8q5OV0dmqvP265Tgwt5QpdXVX3k6aCT+b1n7jIjdiRIi7gQfW7TKuwkaum5
 LPYg5NRQf5jYZU7GO3aBIw0LitVDsEV856n5rg6KMFXSLvNbaAXtPrGezo8U6pyrpFxo
 BXaG+3AfHNJigz6ozCRqgUKHqQGozu5tIj9M3bXMdT+d21Fq/LLqbYwNfSPmCS8JkAh8
 p2RW6MDG52xKYOeCDLUF3tJjoza7yQRpplwvv/DIvRKlAkdvUfOpwYP2u/SoAVYnPBCp
 gu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745589150; x=1746193950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uHVO0ITjHMDSH2rHTJAYMht0s+1PSOlE+Q5YVtOpPXE=;
 b=NFiwo+zjqXeYLL2TJZNbRZzLW0qJaM70i5UM/86zn4vkaZEmZ2yk4NJG3HwEkrKQ5+
 nDcu563t6epGga4ePjwtnSiSTETQukcKCAj/+wWR2qWS7xU8ws7mERY2bON5jIelBCch
 GTQiB+iuuJ4CyqUkNrU3sXSW6XzmFG1ndNVxE9Y+BFPNc2Aa5B0XFxvBIdSFagbycGl3
 G5HkX4RYAPec+OYu+IphMqYdZv+jO40Xrxq8MCcZA5KpICwuvVU9wSxiabnTN5lETA0v
 kzN7QufMtDxsz9g42T5e2egF9a0+ynMR+zcRy6UAAFhDbrGUz2LQJ2Rj0cY5dD35PIQe
 CPQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB+26jL4K84fJg1TSGLc44xO14B6wndNf/CdIzKRGYrDszpPErID+eQ6G6epUVT0Lydar9B04=@lists.denx.de
X-Gm-Message-State: AOJu0YzhRO5FEPEP7ehHlQuSqsyG8bagpLA4FFpKjVbkzhX+ymeF02n3
 yxf4fyc4f9TO0cnmmuG2YkHUGCdnrvR8KvtnCVlekXzDk2/7BsGI
X-Gm-Gg: ASbGncvQPz8k1IgzN2hBs9JY2HlqJaH6qYkGm8Wh+UJKf0naJnIQizVAbpE3bi37Is4
 wz/TAFS7X35K+I66gxiZmFE5fC743jWAjSE4dAkSL1T/axnHS6qGGzKLkKd/pC91r4yztiXnmcY
 kWYdFxeUluFk1ks90fNcpQnlQwZf/Ey65yhclNOCuFgZOyxLBY9908NHHo2ilixj+4FtioORI6j
 oYp1UYUdmhY0G5FeDS7RCknP7PebTxut8ZO5fjfsEbh7/KbrbxPLlPEHoi25s+iha3FlO1fMB43
 fSNcQHuhAjW7D7ToTEl1SrOaJVyCpLL+tF+qrIlPl2b6YkNOy0125nQ=
X-Google-Smtp-Source: AGHT+IEXFicC7Lu9mmmz4I1gcqfImkmu9PbEQDgD0YA6BOCbqWddnIeC9CNVjYyd6oxVFmbFAxbh1w==
X-Received: by 2002:a17:90b:5244:b0:306:b593:455e with SMTP id
 98e67ed59e1d1-309f895d312mr3579094a91.1.1745589150102; 
 Fri, 25 Apr 2025 06:52:30 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6fb9:f343:690b:2e7d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f77371d1sm1619864a91.2.2025.04.25.06.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 06:52:29 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 2/4] arm64: dts: imx8mn: Remove unreferenced clock-controller
 clocks in SPL DTs
Date: Fri, 25 Apr 2025 10:52:18 -0300
Message-Id: <20250425135220.1929510-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250425135220.1929510-1-festevam@gmail.com>
References: <20250425135220.1929510-1-festevam@gmail.com>
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

From: Marek Vasut <marex@denx.de>

Since 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent"),
drivers/clk/imx/clk-imx8mn.c clk_get_by_name(dev, "osc_24m", &osc_24m_clk)
fails with error -22 EINVAL in SPL. This is because clk_get_by_name() in the
end calls fdtdec_parse_phandle_with_args(), which iterates over all phandles
in clock-controller@30380000 { clocks = <&osc_32k>, <&osc_24m>, ... } node
'clocks' property in an attempt to find the "osc_24m" clock, but fails to
resolve the &osc_32k phandle and returns with -EINVAL.

Remove the clocks property phandles which cannot be resolved because their
matching nodes are removed from SPL DTs, so fdtdec_parse_phandle_with_args()
can resolve all the remaining valid nodes and successfully look up the osc_24m
clock.

Fixes: 50cdd3f74af3 ("clk: imx: clk-imx8mn Fix nand and spi clock parent")
Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 arch/arm/dts/imx8mn-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
index 96a6df94c6c..bb0e5b4e31c 100644
--- a/arch/arm/dts/imx8mn-u-boot.dtsi
+++ b/arch/arm/dts/imx8mn-u-boot.dtsi
@@ -51,6 +51,10 @@
 	/delete-property/ assigned-clocks;
 	/delete-property/ assigned-clock-parents;
 	/delete-property/ assigned-clock-rates;
+#ifdef CONFIG_SPL_BUILD
+	clocks = <&osc_24m>;
+	clock-names = "osc_24m";
+#endif
 };
 
 #ifdef CONFIG_FSL_CAAM
-- 
2.34.1

