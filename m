Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA2C606A334
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QgarZ13e;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GfqtKPcD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 792CE81601;
	Sat,  7 Nov 2026 14:33:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z7L5kwSEFhDa; Sat,  7 Nov 2026 14:33:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 14706815D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061980;
	b=C/peZ0Oh/d3+8GiNeEm2sKq870FBXgxbQbldkBwtH2to8XnAtL4q6KqrvZIZBNLebtY1
	 H4Duv/ZlczQ0zEEnIIudLE/TMz44z6oxwhoVVkAOa+4H8iQ2qy94raNrd7wQmYS6WwgQK
	 3Im6mZyaXqV4XsVvFkhDiZBiAMtrPmIo0Qdg7pkPLKTbZRPgi0WxKa8Kgg3wyOGZPcTlN
	 /KGdA1CG8m3SGQ1hiQKuPAK/vmyat0mgqkjY+BbyyPTfnQPQnrxRrs51I9MBXWxxuJPIT
	 nfHhXtMd90D/wiQMfR9d6JLWx7o+n/L8K1G9xTELVR8lRG8x2gT8q55qqBg430fxBoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061980;
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
	b=JOqZXcfVGx37jRlKs7MJIDJf1QnXp1Gucl/jsO/oCHnL0qZQMuj8KF30p7Oqi9S9fZ5D
	 YRuwpcJilCtnc82j22UUwa5DnD5KIuDfy9AIyHeHgbrs8B+3iez2Fcud/Q6BjiS+e/LcM
	 4hs17+lv653JMdmY0t8pTaa81lvxbLFWuKXAOwFi/yQwxV36cDp6fMLlnqIjADZsnpuOz
	 ijp/uqgMIXFnWiAlM3QYTYJIlj7jqtBBIFgn/c9qCF0DUvN+Vg2YBYnTgj8Z4DWGaR8w8
	 mUD0Do1e87HIT3WFIEOHY5chh69Olg3jj7tut3RQi8e5+S91SGqRmUtKR5wB2g9k8Xw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GfqtKPcD;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061980;
	bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QgarZ13ex4ymZmHdZwN/uom327O7UNeI0+7H2ZXwd0eBMeEUiH510YWAW6CueAFM/
	 ywAjrF966NBYxg8Y7ELUN5OhBOJx2tzcktG0NM1etEHUL59y/3P4lhtMenT8Amh9r9
	 rshKMXo3pzKT9qDlAgf1KR2AYYdnLWlwUdSHq4DkPUjonV/vqAyRDSksBZLhByanYk
	 po14d63yWwki72/A9RVagzvYT7pvORfq9lg7oeli1sXyRAfw5dSnZ4htC8oYY+HsXB
	 D/DOkLYCjQ6iizjSkMqJ3GcVxDOrXt5QbwsooH+Au6mD6BO/o0al1IQiVhW9oYQRad
	 DAA53xvz5+2Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14706815D8;
	Sat,  7 Nov 2026 14:33:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 75B6C37D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A91A81567
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wQXG8QhROMHJ for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:32:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 442AC81573
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=GfqtKPcD
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 442AC81573
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:55 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so17060295e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061974; x=1794666774;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
 b=GfqtKPcDfzp9KTHH+G8Zg8By3UVo8R0lYOI6T/Fbftk4NeL3SDKPHIIfWL8yqDTpn4
 hcH47rwNhKgnmmRPfxUMNOSvcaaj0bRUjknniQrwBQ5D1YOdp1OWZON5E0ZduBWD98ZE
 av1Qh06gy2cLgxleNNUDLnjnc8lMSbTp6P5fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061974; x=1794666774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntKC6dJY3Igaxaq0V+DQVsWi53QN22kCXLsx6X+S1PQ=;
 b=S8NJWwvbfQPpz8fXi0Pyjt3zaNYcKZHMMUrskRiWJ9FjL13yEPNzYgDFLZRMTEEhxE
 ZWQL0qkIiDdusj3E7V+jgFtnUZ0cgqOzSzU6iZM3WM3cUHZYWEzlrfo02ZudPx8q131B
 RLN33a0YwOYk7mrHjoiPt/PU/SDm5i51GC4kie9Jd4duN4fPlFtmy4hZY9DwDz9tRyAR
 lRbuqiK5m5KPsffWqEburWt6k6Gpl13lfAzfEg3HOyjsJTItfSAi3LaJ7RJ/Ga4cGBLu
 79QrX32J3aIbR0/sMsHIdh9sdm0tvkHqcQrdOTGvkNm6slpbiYUn9Q6uqLd5FDpBML9H
 lNqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMjy/4NWhX6gwHPlzYk5RuWCPR8zMEAqkxSnGwfFVBFeOG+55lK6T8vV1HLN49Q7bsXb2mpR8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8j3vktfp0OM3T3kVWIfs7IquWkm+dDCcsLQeN2mTNfpsQvboTI
 a0GxyeL956qBhPBW/ReLcA3jsealHcWLE7yF3HFQYo6Zxf5n/sDAlnddiitVm+kY4sE=
X-Gm-Gg: AYBFou1HKvWqjlbVediPbyuDeEM5+BX+PrEb0k2CKLcrylx/EN7GXnU1AYKvvZCFiwL
 6mFQp8FsbOKpEfWN1uuF/vRM5Yq7+WTbTjFVftG8wUxaQy/xv7sZVOatE1mzwgqnCPXDzE+7CmF
 AhH32+3euAG6DJQVHOLBwfg9ILR7EV9JVT+iUb/yqhfsL7Rj1emoS/A6EuaYtyfacbx2irR7+wV
 khznLGE6CoT16kWjWbcttrcY3NZr7smZ2pSFaCYx0rbP/Zn/zr9YPfmzBO4iXjVIdXXmjdg5q6N
 X5i4wTVBJvGXLQpYvzVMZBKiCdxp0NWG+LbTrrNe6hwHO5kEezFzEnRFlYac3ItLl3NbuKLdeMt
 0orTHBHhXNXM3VTnj9nQPPSp6NgugAg+FngIcEgT4DrAY2C7JcesR0pRsrioaD53lV6lCu7z8K+
 CvZwNaVnV8boSuFtXqjffK0rhf6P8vDOtnpbLuBonoj5qDAgaEBfItEsAzJJubFdCREKTPjfjRy
 b9JWJD4vPgvEQFu4aQMVcGzTjM058mtvZkx+ecKGorUFw7AhX42NOAbfwUkF09qd413umb3R8OH
 Xffwem18uB3akTC+l6xrXu1GgjYtYAuNGSx7khziXaVwfSvzxZOFJ6O1FwuhDlljCU0ipWCnhM+
 /wZFiZwTYiH+sI/wlw9q2FPwCVPC7Tnh7IMPVRuu6QHqshj50sKZB7ps6afABBWiNYoneSRyJzT
 3i3FHjdEBOLnGA2Wd5Qw8j8MXlPg==
X-Received: by 2002:a05:600c:3f1a:b0:4a3:5aea:21e5 with SMTP id
 5b1f17b1804b1-4b6de788f20mr88893645e9.9.1794061973702; 
 Sat, 07 Nov 2026 06:32:53 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:52 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 04/35] arm64: dts: st: add SDMMC2 support on stm32mp25
Date: Sat,  7 Nov 2026 15:31:54 +0100
Message-ID: <20261107143241.2236511-5-dario.binacchi@amarulasolutions.com>
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

