Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7A606A332
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=posKUMQ0;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=O5JXT9r2
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECBDB60767;
	Sat,  7 Nov 2026 14:33:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xr07nYgC1Jup; Sat,  7 Nov 2026 14:33:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1B679607BA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062001;
	b=cLrOSc/JFPgahfy8QchPwoPH/xXc+6MoCl2GCA4QiBE0rb0Ck7UCGOQlEnXBORgwPv+a
	 DljqC6YnC7/J8UyEmF/pbQ/esoDuoS1pNClHI9XRT0bW2Vz0TmwHnUWb1jVmQlJnJEC26
	 puNGXytHH9xvT8fUP6k2/cjJr0eQ91IzCnO2WCaq6LcRyU63JZkFfjjbIorGyUOsMZAQ+
	 Pm8+wBEeC0RpuL6ns18TTeLo4OiYKhJxQ0rQmalREjst4WgpJdWMaGnrpuwxZWhMGCeKa
	 crRzjLFjPkfut6ZjLu0JT8hSKvnOWC49Lsk7TH1uget9XToKAw8hAK7oFO5P/1as+kQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
	b=N/1YrQk84oMxoM09v7bS8VOYnwYWafVU314IjudVrtVzi9WKzgNegYwy98NGVNC9zP0r
	 GE/VHBFVBDAqAl1vQ2F2rDmevQecT3wMB+y92q2+EzJ25cY5RdmYMqGbMznToDjedBPpQ
	 d/p4yBsBGw+7rdXvZXzow48UDBJ/Ej2nxeb1lUClvpX/Qdgu/ROKK7vEbeYDAgaQymJmm
	 3kfY5vkUkyljRcvQXxvYnkvBy8OyBd2KQw047Mck6H9ixyex/uJYFg+++IW9ya5MOwydu
	 cSaq62iaUFQ8REAPtBjN74K9Nzl3likmXRbiAmxoqg3URya22q3tj7xPZ1xQIQy6DvQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062001;
	bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=posKUMQ0EtCw6tpWSr2RWMRXqxtFJcnvIpsUB9pQda8h6vUbxPkBNEyCEnboYWIqQ
	 RLuYyw2Gujb9FIsaWgj9MkEfdum82kxVEXNF+W2hAfjxErEGRfgg4PqnWaQ3jBOUbP
	 Lo3JzVLeucYt1BgP9Be197CzyzP3igPoePN/MQJjqVah4c/rVVudjTXAGFUiUpejKu
	 2dIyXdFpB5Y45MnEA13qHQXpQVW64OFGAZ1Y/rR9T3orRtuYECpS2kIF+ceUtLUgna
	 yr1mGMLlTBmWQQuPgvt6DXQS0VNQnlWFLvsOkJ/LJ37Ts3DzRdo+JO7z4YDLmon5TN
	 VfI8epovb2iFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B679607BA;
	Sat,  7 Nov 2026 14:33:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 25947211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0BDA84075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xSWFMf9_kPOb for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F098540757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=O5JXT9r2
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F098540757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:11 +0000 (UTC)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1353926f8f.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061990; x=1794666790;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
 b=O5JXT9r2QPdWVHN98XPTe2bn7D3VZdZrz2+SD7OHffhq8DeNQGj2/yNSU7AvWKMSPt
 EN7wCbVozBFqd2CRJ0kE5F46pVwHj0TD57uI9ytqcYlJZ2pdEmIqKlYXP9eIQYgdYsUx
 0bRXrCerzzIdZ89dsRBwLH7jMWCkC33oM1PVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061990; x=1794666790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
 b=e5duKbDnRy9B9WmsATuCxUPhHTNR4vLSyIujzH3iDKvODwkoImvW+zU/iMTpE/ntES
 dTzPZ6nxctfi5VgQ/GFxpmRinJhur2q16/kUxdhLLc3tz1hYRZZt31riJr/8mJVfwOaR
 gyFurnUSCAANMxHB+tq1czFlUXTIim+aqFvvNj7a+pQjAH2ts1j9MDt8mP/q3kNW0D7C
 QcjNjAPJFrZoPdQKcl074NJTOUo+g9BYQ/Ba2hZZDEOFXE8eY1uyU1kE2MNdRk1g0HPe
 xxmJhPgIFf/HTnFLBsBRBI6uD8eyPCb6OF/7bTdPJEvRTEvDjaP+AaGqOKOSuBjyavVy
 YDcA==
X-Forwarded-Encrypted: i=1;
 AL+hErHp0I1oDtPokGnRUkH7nYD4khrNLJLDTjLhW86bG2nL9Ot1AwqOISNx7M+pr6IzghMo72CU/Mo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+inarza6qYO0JIwdjHmM4oOqQ/MF4/EbVe2rcriNzgXgpqWWYv
 O+bYTE0q5SUFim7ELHUjqKLTRSAgYUlrZn70Hk88LtOZNueHHKqsq+O7amoeOKFAAgc=
X-Gm-Gg: AYBFou1xpYdE/+sEreK9XS33za0atUU1C8YtPtgkYOHQ5KkHIBj9jZU/pN0VOxSaMm1
 BBqUdYtmq3HonLTA5FzQJxTSM6R5Gfl91f6rEm04ep/Zxf/TBhGLqnK1GmtsdpstSXvlnCYxDbw
 cYKiVPg7Gx2Qj0njuLbcttWgZHYWx6YoHTFk2bltO3ExM6B7MYVjkcRrdcnY/LuMKkFM0baJNjQ
 V+z8FFcfJI9niqbS3BnqQq0liYOSeKK5YXVKw6NEiAVGq0+4LrOn2VVlAoOAMuO6yl8bxze43/4
 WzC3xZqmprFGaXzdqSL1N7lIS3sHmDaqLzq9dZ2qVKquaNISMac7AmGuze8Yr+VyBWZ8EOHFVLa
 evhyvU3Yte6Pd5iyFopI0AgznABjXtkZhcboU/4AngoSjkn2uskPHHuW9Sd+OIEUGbuEBE/UTWB
 SWiuB7qWGGcBgxtPCVlEvxT4LHNQXeLlygw56Igym0t9xspMaWxuksynxoYE+X1El+6T1QYjy9e
 frBF44eQKNWHE5+oDXrXXtTi0Ql/xmmmSYsJbiXHyPYQpzHHK0RCbqozQUz46Vq3Ym1u9k9rUy8
 M1LLOmCgdNqfwg7vQgwMTFX7uPnkGBTFtRMXh09/aUgcb9uoifKPb4PLLON8fgGcgumk6kSZ+fZ
 so5yZfzVc9QtQPf8/qMD10yRD9QrrtE2JGfDnI6RB1vlUmocsOaeKmIaBO1x/xeNSzsvrq1u0st
 Xk8jDirv04Sy7smLxX9AQy/6Vxqw==
X-Received: by 2002:a5d:584a:0:b0:48c:4658:602b with SMTP id
 ffacd0b85a97d-492761d0109mr10359984f8f.10.1794061989599; 
 Sat, 07 Nov 2026 06:33:09 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:08 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 12/35] arm64: dts: st: add spi1 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:32:02 +0100
Message-ID: <20261107143241.2236511-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the spi1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-13-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 4759748985fe4d4c25c87edeeca4b96dfa47a280 ]

(cherry picked from commit fdfa69e2fb0f024e72ddf590f82468e63ef9bd76)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index c816a6aece47..4e570e2e5157 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -702,6 +702,30 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	spi1_pins_a: spi1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 6, AF3)>, /* SPI1_SCK */
+				 <STM32_PINMUX('I', 5, AF3)>; /* SPI1_MOSI */
+			drive-push-pull;
+			bias-disable;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 12, AF3)>; /* SPI1_MISO */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	spi1_sleep_pins_a: spi1-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 6, ANALOG)>, /* SPI1_SCK */
+				 <STM32_PINMUX('I', 5, ANALOG)>, /* SPI1_MOSI */
+				 <STM32_PINMUX('F', 12, ANALOG)>; /* SPI1_MISO */
+		};
+	};
+
 	/omit-if-no-ref/
 	spi3_pins_a: spi3-0 {
 		pins1 {
-- 
2.43.0

