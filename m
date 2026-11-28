Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F7C606A31F
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ZFJIYQIj;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=htN9CmP/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 125FB80F0C;
	Sat, 28 Nov 2026 13:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zfG9RkJHuZs7; Sat, 28 Nov 2026 13:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ABAB180E7D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871509;
	b=AKWuFA7J1HY91Nyen/F5nK6YMzOJ7Z2n3X78nMl+OHa//jbJbszzeCGVLpIMCAZ0nBJY
	 UK3beaRs9ndL0QVEdHHV3dFHvnLPFCGyyO8qwbnN35dHgxXL9p4snEdUhksDvJYkWbdmC
	 xZlHs/+LH5WB5uSXu9lC0/XvSyCTHCnZ1sIwSD/CrY8MyJ6f0gjLLRMkkkkDkaESjyPBM
	 g80dsPauhqH8VyPtHvGgIBqqlCtLBnWB5C6dmpcpaVq5Lad8/GtsRdJy8Lk9h+nS6WB7O
	 y1lZ3Q2mNUT3BpNexVS6rvLffKlGDypnbKE9kN/txqqC53q/qPXSKnGOHqzuYOglp4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
	b=GY+WqUUM0JDnPj81k+OqiAZcIi1aGMYAvo4prcpzTyqvSn20cDYxusFoLYGqtS0/nd2W
	 ECqtdWocHkeWtfDOHne3Vx+AaNqowK+DL+8yPZRk9j4J31c1UUO+zMg0BP9UwNfHkulHT
	 ZMC9oz6phG3q4mo7mtK+N8fVX3H4/+NXgdtk2eAd6kgr3j+VUJ9LZRVx9l+OplR8HCqVo
	 WjWnSCRvUd3yRu5ShQUi+mZ1EsDxNcrRtBp2WWtzuq0uVDypPn3OpS4CH0zBOIUupZhXP
	 1xAgZaJfy29Ap4SigidN8m1MCW9VR/U7H+X1M292JVw6tk4j0P0DT6AaWaC6Lq1ETFQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="htN9CmP/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871509;
	bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZFJIYQIjO1pwCGUlG7H1eG0yLJhf63J4c7m9W+hBMXN7MZpWMu99k0MGwhZhVZunl
	 X2Oy5U7D6NmZL/Cg00xGodndobjk7cbsFpnZsjWbb0ysqau5asF2rgMY9hr1AJrrOv
	 LZRaxtj8+8OFeyYJMnnlKL3j01+Ki5ywi9teooa9Bh+5IFBgfvD811/+GQlUOIHw2o
	 o1+1fcAb+r7xpgIoP8itgycxTD9YM84fXci3B8zoOCMOxJ7beYLS3OzKrq7Kiw//yt
	 A7CJhnAj/MOuW7RPuAid9luFWfV3J29iuuxcJNmeP4BC3SM+6U9Lj4cY87e7xJiQLl
	 9+O8VJCEVc3Sg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABAB180E7D;
	Sat, 28 Nov 2026 13:11:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D4E93D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 771C680E01
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 600-ZzgmjQjk for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CE9B780BC0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=htN9CmP/
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CE9B780BC0
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:11:40 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso34338365e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871499; x=1796476299;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
 b=htN9CmP/B3dmy7NQwipp64RSJD2o/6dt+U9/23yL/Yhz1h0lHOY896PwQRXX2ZvIrm
 HPbrRdZXfzmF7uErjCZEwgFwrd4KR+l8j1WS4M2EW/tL1zkAsPPsS96+t76/qAt3MfEp
 Fkr/7/URI6tva4k40uwGqu2B1Qmhf1fDTPab0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871499; x=1796476299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
 b=BviNO1HQRuUYvbSgG4d9mAyfjqgivEXbAvs5lUz/oSMmaJkdK1qwfy49m+1JmLoLzt
 8ocxNb3M4V4V0XPNHTK4DNEgTBAHL8OGSwpPD5l7jDOqiM8H8aRZN/sJqP3KsiM7ep+2
 XX3ylLGzA3XLPQ7Gk8u5X3/34ELfYC3ysFWTG0IT8tYFwa3WzZUzL6Sk80HRCI1sI16g
 WLFwnrWWD238XD9b8OTcNDQqyJkhSloV8L0NbkNBSgxLxk1qpqkB+puHQWBz+p+PFuXC
 Bl1FzXrjPsNc+UAyC7S72NhQHlLbEnPCVGhYGzEAVREBpPGGPT0kOerwu7ajVRPQXphg
 SkQQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGoEDevEK5KQybUs1MiuTvdW+ddU7QUhpaR3k0OqOGIgDhkfo5gc4yUrJqalMcfu6POUEQQvf8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8p8Yixd6KORKHuz/HrEcKCQ7zZOSSa1mcnh4n4l4PHJsdF76ne
 zMSrLjhKHwl8FDOnLJD8qGDmQW9RdANFOEIZhx+bmLa1nzNPPMIbsJjTo6AofiUvrwU=
X-Gm-Gg: AZFdTZfB+tDewwWkU0NceWa8MC2o5zlJNQVjXHVU8EnB7jdBDqGsmUiTUVgZ5RhMORp
 9h5cV5S0dLnztZAmn/hNXLWsTlw/xj0sx+jbogTsKkB/3MJNNwqSJYyLhmX1Fj72NF8s5UO15mp
 br0tvPnQbPjkMFT6AgKq3hA4gAuVd+snLl/+Vu2dg62a5UU+zkoHp7MfCd8wePWmJ+ffG1bY8tc
 OtyVSUGB2dRAht52Px2iSxVAMCYhP8JXsRnmY3NHsEA1JmBYJ2va3XZUG/OMbt2lIv6FkB4z9Ro
 cUgA9g9LQfgb48xXN5hdjHL90svSsEYOBH7hPaEME02NanVT0e41JDO4KyejmhqO4hAQsXQ3LKY
 TGX1qmil7DatB9hl2uxtLLlLrUjXAvwIUsqixyqhSE2g6cSQDykGFDCvrviAiKLok6N/lO5j8e3
 IDZy0nj8yzENiUjzIPzYHYIorMqR1nXF4y4hnWmVlK840wvShpUPZ5VHBpCi8KYN8oOH16r4Pu5
 0aMlnB1InF2kE6FiYr62ZtCLroxRjJ/nyELds+2X1UGoeSp/BlOxH/HR8LtZ0bVRHTzznir9grE
 Q11FbOp3JxKl72yE8p/dh4aKn1ttZ/B1dlWsV+mUCgUYovWPFEBEN6n/uPXBcPm96bcd/iyost/
 LuDS9+Fqw27NDTB76A0BHcA48+0ZesU5hxgmCRhuHENRZlR0/lDFZwyKpLT+MI5aNYkRjG2IzPY
 JtRhwkB9JjPEQvZorvCkPG6Xha1Q==
X-Received: by 2002:a05:600c:1548:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4bb88800013mr590787635e9.6.1795871498705; 
 Sat, 28 Nov 2026 05:11:38 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:38 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org (open list)
Subject: [PATCH v3 04/29] arm64: dts: st: add SDMMC2 support on stm32mp25
Date: Sat, 28 Nov 2026 14:10:21 +0100
Message-ID: <20261128131125.2141352-5-dario.binacchi@amarulasolutions.com>
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

The SDMMC2 controller supports SD cards, eMMC memories and SDIO devices.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-5-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 513410ae43bc77b240091eecf3cdeb6eb5b6b83d ]

(cherry picked from commit e7e96ebb4e18e0041a6674b0382730dbdc845838)
---

(no changes since v1)

 dts/upstream/src/arm64/st/stm32mp251.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp251.dtsi b/dts/upstream/src/arm64/st/stm32mp251.dtsi
index ae36d703532c..44938c036e30 100644
--- a/dts/upstream/src/arm64/st/stm32mp251.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp251.dtsi
@@ -1668,6 +1668,22 @@
 				status = "disabled";
 			};
 
+			sdmmc2: mmc@48230000 {
+				compatible = "st,stm32mp25-sdmmc2", "arm,pl18x", "arm,primecell";
+				arm,primecell-periphid = <0x00353180>;
+				reg = <0x48230000 0x400>, <0x44230800 0x8>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&rcc CK_KER_SDMMC2>;
+				clock-names = "apb_pclk";
+				resets = <&rcc SDMMC2_R>;
+				cap-sd-highspeed;
+				cap-mmc-highspeed;
+				max-frequency = <120000000>;
+				access-controllers = <&rifsc 77>;
+				power-domains = <&CLUSTER_PD>;
+				status = "disabled";
+			};
+
 			ethernet1: ethernet@482c0000 {
 				compatible = "st,stm32mp25-dwmac", "snps,dwmac-5.20";
 				reg = <0x482c0000 0x4000>;
-- 
2.43.0

