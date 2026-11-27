Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C79606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gOZom+9l;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T3XxTtTN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3735940A58;
	Fri, 27 Nov 2026 10:32:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zUXJFYJ-df_d; Fri, 27 Nov 2026 10:32:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 87B0840A59
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775534;
	b=Mz5osB1p7zPOZxVUF7Qs70uFAPmhAVkfgseAiZxPch9H61zuMdNn2YSZhUUX/O8SooOK
	 nomTCQ1pNFhsCLuGPnk9NPgYIMqbIyXhem4MrJHlwcOLMbVe0D6bnCCD7BzL5EYH0oH7A
	 j+CTzFGyW0o0qhht5NmEBWE5X5onmpiXBZuYvE8UWhVtkYT6L0wLWI77329hE/gdZXx20
	 cZ6rKcKcZid+bM7lB9mdeDdi8pVUpOP+gUCYYWU1cMCWSiFe2Lo82otC79nOAgPpD8Hdo
	 krMI7enE3MHum4O7iVJetUhEabC+SVw6I0fKtrWXznnN1zRlWJxZmp4GQUA6nL4quEQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=TJxFizVGVx4neuFxhNJnRwvcoGGGfBo645Gpos5Q55o=;
	b=Nk64qw3tmJTvLdR7nGONN0mdS4q1GmKx/Nlr/stiWG3UezAK3hoa4taR4uxURJsWJYrt
	 SJjm65i+p3XjLb0hf5T2Gh7VX4iPDi9CToRnSE/+47F+NLpcmlp+ZOzYkaHiyl8v3+rE9
	 M4ZzM6ouzL84pR5VlY8qyKt+cq9ajETwpF00hQSYL7AT2SOYWkTOto5ibwcJnWe7hY4Dl
	 MbzA8et+LDdi09cfp3ojSWGHhHlDoDELfGcpkrp/EdE0oPiEV/ahTTxz1yOE8MrH1RHre
	 0NZy3g5RYxkCfLVd2BwcxLG6dX/SWGYcLaiUV8lNIeKJZdlChg3FEg7qW6t1dJECcxA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775534;
	bh=TJxFizVGVx4neuFxhNJnRwvcoGGGfBo645Gpos5Q55o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gOZom+9lIL5GqJNk/XMSJIdrpb6i2HnSaDce5RQoLYwBajnC34aXTgRoQbLwxhh/m
	 CoPPZgy/ls4tf7JXKM2nVNFgQ7UbZBywzo4qISR35Sr6HIewbqdtUmkoWLYt7lugEU
	 N8zjFHw+52ntxF5QR+Nhs70IGbwhwv5fdgLJaz7i789KiognayEamIz1yEpPK7P3e/
	 oHaCNYsnCgUCW3x2cvkrqaYbMqbK/xPxWdiLiSZo1Xp6ASLPV7k9ktd++CenuixC5e
	 CWVLsehSyBwr6UDJnJ12V/H646E6V6elvhJNeX7SdrmX9Zgp29U+Jsah53FMWxVf7u
	 3PYAAqJEgfOhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 87B0840A59;
	Fri, 27 Nov 2026 10:32:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 257B2BEC
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0BBE160AB4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UclXHBhj_ovY for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:32:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E6DF60AAA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=T3XxTtTN
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com
 [IPv6:2607:f8b0:4864:20::1331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E6DF60AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:32:11 +0000 (UTC)
Received: by mail-dy1-x1331.google.com with SMTP id
 5a478bee46e88-38431138772so10310921eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775531; x=1796380331;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TJxFizVGVx4neuFxhNJnRwvcoGGGfBo645Gpos5Q55o=;
 b=T3XxTtTN8I/rMm5sFYfYJOizEpThsgMGP6g1TqWIEUl5PAuJJERyMD98qb+bu8Qjtl
 VTzMNyxEGKATbNIZiknoY1/vTvmJuIooU2xfjV8ElSCAf0X4phoTyWPXpGt4xHQScGZ6
 M2MY73NxCeROiFv+mfaKwJj/DSyoTqSSVHbjuB76h+R8VqQLL2mi07vSndzysZXsGcPQ
 h5+aEwyYo5GDyfbDvCmLJbWOyJ1WAYHmD1xq8XMwP2MwiO2OjLMFapvdDu8u2F+UfDY6
 yXI41fdCj1KPxUHr3eMqrf2Yn87GXexiZ+o4CakYEFPq+3D4tW0uTyslmO758Q1uHozl
 Xp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775531; x=1796380331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TJxFizVGVx4neuFxhNJnRwvcoGGGfBo645Gpos5Q55o=;
 b=Gm6FD2oSCYDV5Do2PASbJ2SAaiUAR5iV96PuDN3YW7+yzAhwHoPnLl6ELabJZMZk/3
 kvLGqcq5CQw8NUxfqqW4VApIUk9P0rZmhMqer2F1Mqv+38puEJd9fdXh45je02/eDc0F
 LeAqf7zbQ7ERE/mrqvXSyRc0ixMJTuL7ShI074xzpWHinh2NApuEsGp7GDP2mHqSWvCO
 QTDhbEta8VxD1vtK9U+pmOVNP4mTdyGWesaFx4Dn5SAqNQ49HKK41KINwVnrAR3/sC0v
 ZHeszKkgAvI39qU/bAm0HuQE8fVNgzakPVqtwekwBjydzn8OiRQGkvToLhGWpOs0vQSi
 N62w==
X-Gm-Message-State: APuU4Z8C6+F+JQCgx1N7HxZpa1JA5U8iLvwfvvkT3Rg/p5B1w+5yUYBq
 ZREQ4V+7SDO7JsqEqFHby2ySYQQzJCOT7Cl5EMP/ZKr2/9HnSk9PbhcEleYTZQ==
X-Gm-Gg: AZFdTZcj5Bn2gAbu+T/nwLX7WgWaXTXqZ/EEgDzuSnT4gj8O4s44UKb/XsH3zf2lArB
 tIoVRmA9fc1TXYGaXB56Ncn1ich6eurAUgCkD7JBZb3IuWPR+PbJoJKgxFqZ35xFIp0bPBiLP66
 n2zqpiqFcORRz0MskqhQRgh0wRJ+NxomaMnG5CkCkyiFKnLxNuDzoxqEPWqTv0SP0xJ9yFV7vYc
 y2hoM2oeDiezmBfXDATxkV5fcZlkkmbZYxjgHfDW9PPYKcgl5jH2vZoVKBiso/FFUKjibPgJnLf
 rzi8Chh4gogTwh9ehPmCnFkWrbf51xaO8WhompG0H6NWuvSeLVK/kWLeRT/Eo9fveJgcO6V5NLX
 Xkv7LMZb+q8zTiWwMzXrDabix43c9AoTNbBp+Y0ILOWExC8TJOGLWP+ejm7hIO4LTtMQ98n63mI
 Dmq5r/2IVmunouhTWVoT5FqWlv8taC+OL/oRjfyV+8g9Z4rB8mZ4foD1J6IaVOfK8r3G62Q5yTy
 tqMR7kyf2eIUZJmv4OOUI0XBdRX9ylxNQ78slakDCRM3yxifBgDsCLyizrJCJYbBv9lEHCSlrTk
 xaJGeEuG4+01kqQ0ac2Y9zHbxF2E
X-Received: by 2002:a05:7301:6908:b0:381:1926:dba3 with SMTP id
 5a478bee46e88-3856983c0ccmr20224789eec.0.1795775530939; 
 Fri, 27 Nov 2026 02:32:10 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:32:10 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 10/13] riscv: dts: spacemit: k1: Retain GPIO and pinctrl
 nodes in SPL
Date: Fri, 27 Nov 2026 10:30:09 +0000
Message-ID: <20261127103030.4647-11-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
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

The GPIO and pinctrl controllers are required during early boot
to configure pins and access GPIOs used by SPL devices.

Add bootph-pre-ram to the GPIO and pinctrl controller nodes and
the pin configuration groups used by UART, I2C, QSPI and SDHCI.

Retain the corresponding child nodes to prevent SPL device tree
filtering from removing the pinmux and electrical configuration
properties.

This makes the required pin configurations available during SPL
initialization on SpacemiT K1 boards.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/spacemit-k1-u-boot.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/riscv/dts/spacemit-k1-u-boot.dtsi b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
index c084e15cb94..482f1c2aae1 100644
--- a/arch/riscv/dts/spacemit-k1-u-boot.dtsi
+++ b/arch/riscv/dts/spacemit-k1-u-boot.dtsi
@@ -86,4 +86,48 @@
 	max-frequency = <204800000>;
 };
 
+&gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl {
+	bootph-pre-ram;
+};
+
+&qspi_cfg {
+	bootph-pre-ram;
+
+	qspi-pins {
+		bootph-pre-ram;
+	};
+
+	qspi-cs1-pins {
+		bootph-pre-ram;
+	};
+};
+
+&mmc1_cfg {
+	bootph-pre-ram;
+
+	mmc1-data-cmd-pins {
+		bootph-pre-ram;
+	};
+
+	mmc1-clk-pins {
+		bootph-pre-ram;
+	};
+};
+
+&mmc1_uhs_cfg {
+	bootph-pre-ram;
+
+	mmc1-data-cmd-pins {
+		bootph-pre-ram;
+	};
+
+	mmc1-clk-pins {
+		bootph-pre-ram;
+	};
+};
+
 #include "spacemit-k1-binman.dtsi"
-- 
2.56.1

