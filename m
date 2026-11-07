Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7142606A335
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HFY2S4YH;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=pbW3CmuW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B32480E98;
	Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2axYbET_-3-I; Sat,  7 Nov 2026 14:33:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57DEF81551
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061986;
	b=nEjciw+INtEf7abChz5GuD435olvQPypTLR02OvFkgWsyqUEeJKeXGPzYLb2vK+AZg4D
	 P2p283G9Wr3fMye6+N76a5/iUqHP3TOgK9z5N2LC/qY08Ve5h2iF0cI9+5bGT7t4ZJmlb
	 TQGbtOUbqJfNTeAYoIDdXlPeFbW1sA4lZjR/UX2Ch5wMmTpsVy9627cfnQHap5r3Nwzvm
	 kC26aHRG9iO6hjv5+auMs5X9xjRbzVqjVglAedNDn8Y4iqQ+L2bjoYyVHFoVfdBFH+Vuy
	 q2hvM1nAOtnqKj1RKCw/icm3oRFC4oQyPaS+GjKgD71Ai0QLpSk8JStYFAphUD1XDkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061986;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
	b=KAOAY+rKHWlslWIKO5KSbI5610deFpoyqkHe3A6KyVG9X13HFntNM7nGFIFZaJrrcz26
	 OVV3jT+qe9VTT+a5BtGexQasiSZu6DApP0xBnVySLQxR/m4Rrw1SFIvQuWyDJYMA1kOUD
	 bDxS/2moVQbnKHnZ20DhdbvosyRi/yhXR7HNVUpaoL4HMksy+VofqefjWxuc+ykWLN5D1
	 Of7g2qdqdL3nfwFI+W5aVSrOv4IM6VZZvYAiwF8nrqDBizWxS8XOTyCIej1hzHudRk2jU
	 JTd5N0cicKgDPHiXviCyZZH5pe2YZYbZo3bhnOJ0Fdc/2ikOZB61UjT4DqK/4xoZjUA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061986;
	bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HFY2S4YHxWSVUuCfsSizDylUPUdjc6mXhRPvBlb+xuKanugzuYwQQFT743e6LV26B
	 IKh0Ps+uO/VYuJVBZavzz0lv1MJ+vw6ZK/oGFa7IE4u9Ad4UxDoMaqJEW8iee0mCBK
	 NaphNiVmnrKZt3Eh1n5OwRDaa04tquJgAIXsCORyjXCQMEQMFiYzv6bvOEbePuyRhu
	 ra55eLKWUVgLN0lQ5RSUjwFjOahVyNxF2Z9B4CUOVEf3XHSb9CcFZFe1TS+AMyotJ+
	 DC9pNyO3qJysLNxrWx1LMov38gj/UnYmOTvyPwqvActjYZM0wF/GBG892SGzJYDdf1
	 jgNO4oeJG6ajA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57DEF81551;
	Sat,  7 Nov 2026 14:33:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E4B737D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 600A1400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lTXGPj_2gv4S for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:32:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4FFFF4009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=pbW3CmuW
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FFFF4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:57 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so17188185e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061976; x=1794666776;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
 b=pbW3CmuWOoJ+zvUeEB/Pwx/WVJMfe5DgDx+KCNtxbyLiEK8KbSGYwQudm1L0TzTMa7
 FcADLRKX6J3PdlvgdYwNyU+R9OHxBTxGGYHqxoXp4xKF/Ualp4PmNyOQlY1HBglOo5aG
 LTpKZ3PIHRWMcA2uCMkFqK7SGaZOiUT8/OUp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061976; x=1794666776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+cXeToUhl/LfP+eRotsOYdEVnVl01XxkqlQg9TFAEiM=;
 b=JasuJAxatefuGe9LvolqyZN/kZicvB2mC9myw4s58ZL/6BIetpGdFV7yTuS6Q8KZA6
 dMk+ZLQa+tffO9FF/DBYyBCHqUx9ZT+HPq98cHWofCnh467nB//jargp8g0MzA1OSyWL
 BEng8KIMw0hR/4L+D+rpxnbY1/+Im/vijat7sAJWzaxCzlqGmzmBEjqbhVxAg9vKbWbY
 aANXJBrk0VTmdM4fthwma4+ZbaAZRqX1Qg0Mkdze6saR7wfekFBlWb2xEO0pD/fKzI7n
 5NQV60LEc5iozeHwa9njBdZYbDqeDKn6AZ7srIJvS57jP4hJ7n4v5Upo4z+Wj9VHnsD0
 D1YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCqqe5tsZireUeY9JRMMRP5dgLgiYGXUBYo066tVZ0RacU2ggGNd5EV8Mj0SAaLVW2G8HVbk0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+V/VhDyaMMFzaJiIFpmQU4H4vGXrHTDldfu90G6lkCc0mmqkSd
 hHW4GTldbND6ra2K2CMRK8HvIH0gwN9AzRsmJ36Eb/xft+csSfqFflQJqamPwM0HMNE=
X-Gm-Gg: AYBFou0IyfuUspba4OZSGwNxfcwROe/BS/r+e8jLWHSx/5wBEnjNDWZMscc51gtq1C6
 Z/KLUiAc6HlkDU1chsUp1PggkoN/Nd283wIfYnqy7OQj2o7L7n355ISF+8i0P7xttrDJT9851r6
 OJiCyCD3NvCVdt7nbe1ikdR6RYdh4Hk4HgqYzkMjnFzPgHAbBzXsUFyLUEPtQT10Gz4011e7s21
 DGKZL9nrkdmOwO7B0Ble0xNsjmA2gzn/U9VIA/kIZ2/oi+w/LOsVLmeiXBWh86hiXfSA6LLeKg8
 3m/niKkA/6ETBs7seQOGre64jPVSkpQC9cvbT0o/8hapcfpwhD2A6MCmnSDOLs3y/+JAddrbm2J
 QpFBXZUuylRf/N8kc/RlTwGjyPSlGqhtMdEQKHHECxA9sSauddxlDH9kCanhOnGZO3n2de/Dm2D
 z4yzZwstT/O3uA3JcHIePxQqhznKN5Ft0bEROfRc9VK4MJpx2LgB8OjO+WUttsWoHT2BCLcc2+G
 QcDiTJpAZ/1Drd5+48fw2IMi2rtrRwPaPLuu6wX9iS1rSvJGZ/bcJw1HKoPDrC2LMSGkwug6i+J
 gdZ1690DOnj7b6QuMqXa3cf1Q12623ts4JUiedgE/YEjXbIWT7LAkUn2QIla3skbqapM5f28GUr
 nSUT7ngZMDqn9vneDk0fIHEYX5bV6oWPx7n6MEsHRAVErEqZPKhfG12NtkxSJXONrFqWp//woZL
 2QUZer8Uf39Q8BgnUPokExIL4dMvQ=
X-Received: by 2002:a05:600c:4e05:b0:4a3:59c9:a750 with SMTP id
 5b1f17b1804b1-4b6dea687fcmr89123475e9.9.1794061975899; 
 Sat, 07 Nov 2026 06:32:55 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:55 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 05/35] arm64: dts: st: add CAN1 support on stm32mp25
Date: Sat,  7 Nov 2026 15:31:55 +0100
Message-ID: <20261107143241.2236511-6-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The controller is compliant with ISO 11898-1: 2015 (CAN protocol
specification version 2.0 part A, B) and CAN FD protocol specification
version 1.0.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 7e62731fba26a58f975815add1e3146eaaaaa9c2 ]

(cherry picked from commit 3de3ce4cd1862224d78cc8da29550dab9feeb43f)
---

(no changes since v1)

 dts/upstream/src/arm64/st/stm32mp253.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp253.dtsi b/dts/upstream/src/arm64/st/stm32mp253.dtsi
index eeceb086252b..7e82f01fdc10 100644
--- a/dts/upstream/src/arm64/st/stm32mp253.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp253.dtsi
@@ -43,6 +43,22 @@
 };
 
 &rifsc {
+	m_can1: can@402d0000 {
+		compatible = "bosch,m_can";
+		reg = <0x402d0000 0x400>, <0x40310000 0xd50>;
+		reg-names = "m_can", "message_ram";
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "int0", "int1";
+		clocks = <&rcc CK_BUS_FDCAN>, <&rcc CK_KER_FDCAN>;
+		clock-names = "hclk", "cclk";
+		resets = <&rcc FDCAN_R>;
+		bosch,mram-cfg = <0x0 0 0 32 0 0 2 2>;
+		access-controllers = <&rifsc 56>;
+		power-domains = <&CLUSTER_PD>;
+		status = "disabled";
+	};
+
 	ethernet2: ethernet@482d0000 {
 		compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
 		reg = <0x482d0000 0x4000>;
-- 
2.43.0

