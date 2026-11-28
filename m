Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C4A606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R7lQZn/i;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=KJfavP+4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11BD980E36;
	Sat, 28 Nov 2026 13:12:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aN-6iEpOhFeK; Sat, 28 Nov 2026 13:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 271F280E61
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871526;
	b=SsKdVBnMCHQ6ROb9poWiMOZwlIKo6m3tJes5mmJIiUWl/dzNalJiJR2AF1Rb8CRDyCdS
	 zR3T1lCJpQWMCMi4O0buGPVoEOEcXU1dzsoR8EoDtJ6kV8RS0bBBnLhOo/Lb94C9xt3oj
	 6Zxfs3EqPB3Rr9lmVjHKj/nkmyUINXBjiAQ9ouhNKfDv/y7OCLnad08MCwiub++MBQ/mP
	 F7NKfcoXt3Y9Fw2X0uPcFhHtIopJA+Yk+KVpS7cAbRi7JOl3dVCvkv0fBVVquL4/SAHId
	 oE7h11toGHkWmAgKEcj9od8L+fcDqy109Tf+vahPJzIeNFtXuY4PJhrhU1yc/99zoPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871526;
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
	b=NDLxSs/0rU9Y3s7DV+A3SJ72xe00BydgBWlhh9S/3MdeqmFoyfe8glxugF/2p1wDI+LN
	 drNBmPEdgHwNsIlEOJJfVTNqMhNRWA0IQm21KGADKdLiADHfujdo8CKKTFLv72Y35DnAS
	 vs4hHejhc0EDykQGtxKNaKTW48k8XTNla/Aul3yt8r5CGQFb/5tuRFB/p4EtgNLOZU0PW
	 m+wDaX06yHGaf430pFHK53KrZYtoGsawmQVM6AM+g//8bVdz1U4Dsi3QSf1x7bqu9UbHy
	 N45L32QeliXzWL/Sjp1nCXk6jMSlWIpKi5T3z/u8J1+iQiNPXLayNzbzuWVhxCOW70w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871526;
	bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R7lQZn/i6jgQKMU0zx7e5BHZsOqD46/ZgFlcCYLhW1a/0dCHCo4HU5zJiLgvH7FIM
	 McH2jgLnp2sDnrHEZbR+nI02iUmpqAfDj1LcjHwck+TviaeytIrtwi8NyKZoev7ATf
	 lVszrtWknvo1lSHZZBmK6ZD95Gw5scyeDDghg4ki/pqvkJT8JZbrrzH/ZrkNpOdYa9
	 x/I1srYKusbuT2h/Wxy05if41O9fbP2Y7h+siy0X0AbrSVX1iUVXWSzeOW9trDwYlV
	 WboNFLTrGHmVjkNsWqMJLRaoZqtwwk4SmmLVq5I1RYQ/D163M6lSp25kQp00yvCKK+
	 SBNfL4BIlTxhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 271F280E61;
	Sat, 28 Nov 2026 13:12:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E763C0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 291B5400F3
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yGpy8GlI0s05 for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2AA844005D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=KJfavP+4
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2AA844005D
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:53 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so85053185e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871511; x=1796476311;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
 b=KJfavP+4J6LMA9tTk2XnVrQZDrYK0+nOnE1ZJXBwWOMpfBOremQIZsCWFtNqCkXiOk
 Kk6dvSN20az2vW80ntWC/y+7QyRjVaCTqC+AsWsG0g35cLV/opegzsGuG3e/u6OOC0B2
 cSkkbG2Wk1fpAaliKVXtdiIh6cnF1+lSFVLTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871511; x=1796476311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BXIsB4O0tF0T9HLMGeJ5ncXP0yiRX61C5rrmO5oVYz4=;
 b=LBgQ7+0tn1Sno7o9PAzXnXi/OzRDLPH1tkEP2gbBImTRB8JAciuSCXV5SXy/qdcAza
 ErAEtflzcqt4L68Q/a0lflGIKx0K9H0P6UrdEy5qJ+8aaXbZ+H4REeYmMtNLbW2ZuHgS
 esihny0MBvxerBLUgt7dUKInGGT0M2i6MR85RmfGf3d59zE30fZoTVOJiU9Pd3QsOae0
 smfKLQQcFhzHHGihwgmf0OxAAGDq+WPi0r7FGw1i6R+g446u8UNC63N08MNEYxQlwAgi
 Lf0ffQOlLSUp1nx30TRB1LkWzyWVOOYMwdyf31WcljjD1psp5CjyX8Nehm06yyBhXyVa
 qZjg==
X-Forwarded-Encrypted: i=1;
 AL+hErER6peoInyYYJGUt+TEcLprQkHonwhIbGKKMlnptRepLBRvSAmyobqOnI1tZtT+yceRAkvu/Ng=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ZLl9GWArPbsaa3BR7wK8jIrInp0wzg1sNDR8BMTYUnEaHsiJw
 kXXfOVmitqhlI/htcnfK5P6EtTIfCfT6/Txogmsn2rFN6vOUK5uF8tQoHtsAJcRK5m0=
X-Gm-Gg: AZFdTZdZtg8p3tvXY5iA6UG6YuVkZ5nydc3BmM2bYkIKSMZjT42MrS1rK7/ApxcTqaX
 jqXMATeiERCXuNQSEIHuNCZ4HVgLU0WqBwe1AHTLX6h1MmB7RMqAxqdbT+rlFTdjW9xQxZFp+mU
 DrEW1sSO4FLeAGskccu4VAp5KIHAog7vnY3Ca1lLkusPZBaqk8uahlqreiSdtjfWuN/1BtXnCbH
 MJTFFHFb9Gqwbb+FU6RmJ+WT3IXFtUkGndvkRCIVyFQTGbzscA2UOCzET5Nf4spmo+KdmWilaTT
 etpIcqGEupuXBtBH3hkk3R2z28OhEByUPvBI76mcWkOLdqHJwvK/iN/F91D7rLqs8uDMb+MFYTA
 bXzbsyVbn8irbL2ygQBNFNAo+AFstrufE9YrXeN6ZTUl9ocZOKRaWE4dFtjkV2ZMwSRcv1zmS4u
 rZIBIiGrL9G3oKDxn/gCqiuGpCr0BZjCwIx0251R4u1gILqLqTb9PHFqkvFTvodCaFSGjU3/kzK
 V2bBGoAYXX2wJeKY5LmUtZj2QIbWRELhfkSM+C2AA0pzLVk7CfEmVe+4XbFD/oYvWvx/GZzI3P0
 i1i4bZP1dpkUOvT7c3B0dIg9/4waIMqQDgB5jhnNilwHijC7KRvFEt7lO8a78/l8hFNpY76Ufcp
 F5mxsyIlTWx4vTC+WhSR89GlHSRKVsjy19k6Aj7RNT7usrriDskl273+n4yZKu66JK5h/cGNafT
 hWooCtGuBZT9FAotdsasKdywLyNA==
X-Received: by 2002:a05:600c:154f:b0:4bb:6842:66ef with SMTP id
 5b1f17b1804b1-4bb8893a963mr529786325e9.30.1795871511269; 
 Sat, 28 Nov 2026 05:11:51 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:50 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 12/29] arm64: dts: st: add spi1 pins for stm32mp25
Date: Sat, 28 Nov 2026 14:10:29 +0100
Message-ID: <20261128131125.2141352-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
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

