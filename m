Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B367606A32E
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ylV1Ni6X;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Mt0GLyW5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D701360887;
	Thu,  5 Nov 2026 17:54:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1vOoAV1Y84pH; Thu,  5 Nov 2026 17:54:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D56C660850
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793901283;
	b=aDmTN1+rdyxVyYQ879aJizALXekQUSt6Ok376WNHJJxzN+F//Kwqo22htLenHQ9ZlD7X
	 sWhmrJUToNaNDICV6lp2HSC/RAH5CdnZMMZVZzLNswOst2JRqF5nU0RI5cMVZ4x7fNSWR
	 8lEZJriDHtp3eNALK3q1mjnkq3jlNV+JAi77/+rZF9iEGSBh8HFB6YpcavN97vysdaRWC
	 5YqkorAK7XIWKssStU4Az3xAcdCBBBTdAOG/9EBZTn4p/dOaNq+tAhxtT7y2Dfr7SehNy
	 hjDXHMkAzKBFhp8hjTF4mF8m8PuoyDw4Qv7v3u44VirbhRqJR+SvokkOacJ3S+n01ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793901283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RzswfEFEUcz4v+8+3yfbzozAGTwYv/KHnxc0RCryzu4=;
	b=LUvBDWJU60KScihTEoZBrKxwhC7K5JyZh5NtfSiJ++EeQhleAHecj+tKCnGjfU01wBRC
	 FeRv+YFiUSYZF1rPjtTZOfY6qMyAR+T2O39cadzi0NHgz35Kway7TQr9adN4uIbQYMX11
	 D7yEcQGg/4QENE6WuKb24sQBFR7QZrpgd9STAtjMzdPe5tY7SMjy1Wl74xSEWYHVYj0/E
	 5HyA60qiZ2OBTLT1/AGHO3gvr3MK4V02jAK3H9eMlh8byp4xWyE0C5X2rqVFJEmSPUFZO
	 44Z2ke7FLMwhsAzIjw0WZad0i4VdZLnmJLcU78kGf9ESFUYzYwGXnMVisCSpC/1kTbw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Mt0GLyW5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793901283;
	bh=RzswfEFEUcz4v+8+3yfbzozAGTwYv/KHnxc0RCryzu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ylV1Ni6XbRmKb8vep2wyRWjFq18tF6CQpWcUsTAGob5HWG7yaNvJGjy+rWd9lrjNr
	 VyaQ+yTMfGM98fKI6xn+FuMAZGIKd+Y2hOsrSxAIEtIeXu01/wTVimw22DiL4JTvkz
	 tXKHjnuEu+K0ZVrmbPxDrF9WqUw4+JYIxhxOjeRgoLgyNPoL9qI55pt8QlZH7KlSvD
	 iMdkCGfN/Mjo0L3N5ABRJaFhi2rarW3qnDcsFo0ChIRtFuNHND3i0uZ74ACRrexAOu
	 f40KTqbkRyEEpDE9iXVUIccxKauIyOTZnCCVZT6PNeRUtK78nwEWqHYdjUd1oBc5qi
	 kbzO15ACuLRQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D56C660850;
	Thu,  5 Nov 2026 17:54:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 41D91B00
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 33947607F7
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id loU5346qyWwD for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 17:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7863660697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2c; helo=mail-oo1-xc2c.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Mt0GLyW5
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7863660697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 17:54:33 +0000 (UTC)
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-716d052dc23so654172eaf.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 09:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793901273; x=1794506073;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RzswfEFEUcz4v+8+3yfbzozAGTwYv/KHnxc0RCryzu4=;
 b=Mt0GLyW5qF4M+N0mBGe4uKTfh3KnPZ/iqfuVOc5trnPT5rtZ5e1WtdTsXkedf4CWn0
 AN50Ijn9VwrZyEKaf+Su6sYbv7vU2mqxFlff0Jo//B3Jh3qK+7ewkTsjn4VT05AhNl/J
 b8b3xD9yK7Lbuxy969asZa5gktkwv93afPGANcdmCygRA+MXeyB57P0lSvuK2sqq3E8o
 alP9y9oV16Jx7AX59ejSDsP/F3beQJiiEIRNxOqK4ZGsH44vhk2+jnlJo0Hgp02Ug4vc
 XfNhyilYsG+z73On/cCsmpjumLUh1OY7GfE2A2hzQkospTkIZOxNYeSumyzN1wW3WfOv
 +9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793901273; x=1794506073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RzswfEFEUcz4v+8+3yfbzozAGTwYv/KHnxc0RCryzu4=;
 b=cBR0qmkY7xGN7oHzaZrgBkmNHPmadOUNy2gVByHg4EIlubbs19EXa05XXczJjaQoBP
 ezeh6zfWYmsgA8cw9UkW3arMNeYm7bPhru9fOy0frwNwX3uzVWIUGj/XFih8MrQe4YP3
 vDUywYcUUxP82GCGqw7zkSKuB099h6Tg1d0mXD22/rG7ibKnwnnqxi4/NCLjTlEih1Vj
 TJnaX8+sirw2z3SSSAv5uSYk58uvTA7ddtOY6RyWvKBASgNZKfDDO+TIlWQZcVUWGAP+
 oVf0OMN9Deq2rqUYN2AR+WENhLFduSfxOzyQVX9sjxpkDk/Vds15+DzRmgtuUMPIqlEg
 CqJQ==
X-Gm-Message-State: APuU4Z93Xshw4XhXR8OhXJwRuMgFqzA6j4FOA6E7g05vpw4WJ3O5A9Ib
 sg2eaBvf00Zh5VBcSyRBpPsRwwd8z2OKDYQY4kxbpCOfQzXeiUA3GQzZKjAVqRKW2YQ=
X-Gm-Gg: AYBFou1NEqUaOIAuOB7H/xbD7meCa5MSPDnKvGx4rtcUC0zRiAgh69egbKgcD0YuDj3
 2DkzHfPbB9BtoQgNlTxv7swzm98XlDDPi2vlcO/7bDEZQepdqayGUcyCv1Abso/MFqLvCS+dFAB
 X5BgrWuQ4IppkBvudS5z1/tNZ18MOocY4hdzzJf7N1JaQRUGrF+FGQOkiL55yyeIZod+s7UAzrA
 rmiZCJXiQ8lKqBUaO/g3rjC3GjnH85W63mfAStp62XrnlX66bSiWzvk8uv2d93p9vVPQ8/yEUeg
 pN/VLayOaxO0GzYyhDT46LaKSzHQiUZJ/tY6AS5lhz6IgwIalseCJaU/gcqQ1Oy7cUSVNpUjGSR
 4tnbNX3frtj6JJfnaMEpUd+/FlEzbWlq9fJgglJNF8xdul51J0UjYs7VtIC/Flasop1hY+OKG4r
 PgtZ1tb3B3ALvgqJ2HPnqdUMWgI588dulNV0g1fcMKAgJtRZtSa/VvGSqPTF14uzfJdrTuCO3oy
 //W0VDNLaybICYkxO4h8R8pPkQe7J3tg9NQBkKcN7FF2w+h5CbxRAevTtlWrKRmpUlSF6DFoCcA
 Cir8rfj/9YUJvW5uS5/3XmrIahd5XtnGhg==
X-Received: by 2002:a05:6820:806:b0:70a:2478:f611 with SMTP id
 006d021491bc7-716e795fe99mr184171eaf.49.1793901272960; 
 Thu, 05 Nov 2026 09:54:32 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7f36:1c5c:8ddb:3ed6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-716c12eb1b9sm4659682eaf.10.2026.11.05.09.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 09:54:32 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 05 Nov 2026 11:53:38 -0600
Subject: [PATCH v2 3/6] arm: dts: mediatek: prepare Genio 520 and 720
 devices for SPL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-mtk-genio-720-spl-v2-3-4994535a3848@baylibre.com>
References: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
In-Reply-To: <20261105-mtk-genio-720-spl-v2-0-4994535a3848@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, Carlo Caione <ccaione@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=YRgwWPFfeXa0QeSSkKWAAM5/DU/ELTNTR2hXQBmEGoc=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq7MK5LBpIYnJW5QqXGABYqzQpdLRXekz7aTnAK
 Pr4p7yJDCKJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCauzCuRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AxVsH/ArYhEttbHqijvi7DHXzSbI4qrgvJR8KQQ5Ae6q
 vKLrm29oQFbLVMVJAiz1zs8PBVTm+rqr7WJIKjESz21ifBVYD6u1PCBC8azNW5xwgze12smrkbF
 5XcSV/pPE0X90RpTQ6sI4L+Kgq3vrMYtM2KjQ9er2fg+7HCfpjc1HBhRv6tYiYqs3u90GvXn9De
 xaBSy2jWMAmn5uEIwZSIYqN51x+9wfZD95pN5XbcL8EADx60/QsdIDVH+FNC868Axfgmv+u66o/
 dojACQweuYnoHW3xBzdBuZeEopR/I5lEGD69eYp+mF5mY1vYxTeI90ydca/v7rlHG9hiY9uNz8v
 gqQk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Mark the debug UART, the eMMC controller and their clock and pinctrl
providers for SPL, so that SPL can load the firmware FIT after an
external DDR loader has initialized DRAM. Also mark the watchdog, which
SPL uses to reset the board.

The MT8189 peripheral gates in pericfg_ao are parented by topckgen, whose
muxes are in turn parented by apmixedsys, so all three clock controllers
are needed.

Reviewed-by: Carlo Caione <ccaione@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
index b7a0c0a82a7..70c538a690e 100644
--- a/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
+++ b/arch/arm/dts/mt8371-genio-common-u-boot.dtsi
@@ -26,3 +26,84 @@
 	regulator-max-microvolt = <3000000>;
 	regulator-always-on;
 };
+
+&clk26m {
+	bootph-pre-ram;
+};
+
+&gic {
+	/* Retain the eMMC interrupt parent even though SPL uses polling. */
+	bootph-pre-ram;
+};
+
+&apmixedsys_clk {
+	bootph-pre-ram;
+};
+
+&topckgen_clk {
+	bootph-pre-ram;
+};
+
+&pericfg_ao_clk {
+	bootph-pre-ram;
+};
+
+&pio {
+	bootph-pre-ram;
+};
+
+&watchdog {
+	bootph-pre-ram;
+};
+
+&uart0 {
+	bootph-pre-ram;
+};
+
+&mmc0 {
+	bootph-pre-ram;
+};
+
+&mmc0_default_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&mmc0_uhs_pins {
+	bootph-pre-ram;
+
+	pins-clk {
+		bootph-pre-ram;
+	};
+
+	pins-cmd-dat {
+		bootph-pre-ram;
+	};
+
+	pins-ds {
+		bootph-pre-ram;
+	};
+
+	pins-rst {
+		bootph-pre-ram;
+	};
+};
+
+&uart0_pins {
+	bootph-pre-ram;
+
+	pins {
+		bootph-pre-ram;
+	};
+};

-- 
2.53.0

