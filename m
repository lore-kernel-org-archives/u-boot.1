Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EE606A332
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=03YWEWSo;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=YOA1+5/N
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 335E580F49;
	Wed,  4 Nov 2026 08:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SdhHUHfNRTkY; Wed,  4 Nov 2026 08:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4864980F2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782270;
	b=mGB8bDIi6capzQLBlqaCMzc8ULAtRJyOH6ysduF69lRhq7BO018Vjjk0T83NQyXp6aHp
	 sJh/GCVQCEZTysEKYD4TCeB4j4iSaYlNM0OlXlvR/ArFUIrblazHg+37a735n/o566Ze4
	 cwXyYVX0Z7SnxAhZITz575+gOzrJ2q4UKMDYoHa75XjDRUySyjR6L/m9y9vs1HzSatf2p
	 RIeOCWQwoaHgVKWE3MbUaugXm7H3nxBVEUU6nc7JkqF5FFyuLeqy+Y37ajDAb7YJZ7PJW
	 YHwSYIbgpowT7BeIFQQi64diyhSGivmUrr8J8qTOaOQOMxn8OqdEX0oXh57WzZ2bOqQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782270;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=lop12+3UrsrHTuMpzFkXcWO5qlkFS2aS5Sk15jsnhJA=;
	b=a/d38UrocxCzyRv+Vras9COiLoRuUJVnv3IRcazjrhLJxA9ubsd5Kv9UxL4RssUqMsKo
	 HwFgmAgCKHZxGwKrg9UQke1z9pJ/ubh8Kmyyh5rjKxBMMYqFu5otD0MzLXrlgke4qpQOH
	 ipdeTgf566/kCslDmV/lX79WWmavCgKqvoQg5MkMP1Kfjp0As87zkXN/meEsBFrXMIK+T
	 ZEWsHOf3/SRi9lHQCD0cU+fOHXO5Q7Q4LOV/FLTckGi/L+zn+5dgNvah0jeROpchWrePh
	 B+7j1NM97WIM0fnV9h29eEbZrwFd/R214UBz+gQXWwya2FccKa5fTQNUzAqwllYn2mQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782270;
	bh=lop12+3UrsrHTuMpzFkXcWO5qlkFS2aS5Sk15jsnhJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=03YWEWSoal9bkj9ABDXjsfnY5JvRAnMQ6KdCcMbHrgcHnMeSm4judwP6Z6yxnviez
	 KbTJewMHb6/i5doyqN+CyKEba/eovlsuQ9mZJnSgZPp+rbaZNT0f3PNe/trfuvOLmQ
	 /+Ns5045343xue//cGAFiOCxtlRdHqQg86z2rbQ4idpw+3RBXvE3M84bUQIF1dw1IS
	 jkLlv5vDS8edoIcOIFNfpsp0ZzfLwkOnvBKTPhmVLcZa9qNYQ3gzrK67CH53Lmct82
	 leD3OYbYsbw9NEu9peRUG9EzFKEpfMEKhGoEUnRspkSfRSkyE1mdiKwaqRp1yjYdW9
	 QKKVKht1WjdHw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4864980F2B;
	Wed,  4 Nov 2026 08:51:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C17A69C4
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BE9204071F
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rnk5zp9l9J3k for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B7EF84072E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782268;
 b=qJTfxltagfh0aeDaO1MS4rOplTqIKxI2RN2eeLh/RkXJOT0+Z0jqJJfHb2SOpiRR/Gi3
 8jNSOCxia7bBVO9y3vi2RyaArGxZnG2nUlQoKHTpC18gWubYafTn8Yc4LJ4+tq6VxOTTE
 9DaRdrGFZZ2nzn6tNqPQQfAEurxh/GajJ+L3OdLjcDWNu02vVHURYIeHPsoDKsMwJDhUy
 ICZYNUk4z2/dsWCWrmESx63jelYilbhgrtdQrLQ5VtON8PqhY/B5TFvs7CHwTrxTsUs7x
 ljCj/zReBpfXgclXzxt/XeVot8/O9NJpHfw1hO6Xwqs1MxAPsmxcR/c00DP2yUwm0Lg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782268;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=lop12+3UrsrHTuMpzFkXcWO5qlkFS2aS5Sk15jsnhJA=;
 b=qjxRilAZ5mF3dGCMzqOic/xoD6idXgbAgW/WC/d8HoE8BZ2N5vXJFnZQetIPBCXtVDS2
 AAFONBX/02wSvEbtuN0uf7apRTcDxhjO+6KMtiLNOKvbPZK2F/sUYzjAAjUe3hBtGi4Uh
 i6sMtaYw/Get/JhsTQ1GDCAspIQ1i7H0smYrfzxAm7xFBMExmNG/RQ0deP7ccBPoN5KUt
 w8XG9/OBxhhIzFYzE7xL0bnfZkjcWuo7vKI5RcaG3KTAlzqlekAwLT0UZhFCdyRA33Xm2
 2PJR2caPiIFT1elUtHhZCulAhU/D1pxwHPttrXltRKmrY0WPj+3IwnCllhpVOzmfmfQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b="YOA1+5/N"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=YOA1+5/N
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7EF84072E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:07 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so3031005e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782265; x=1794387065;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lop12+3UrsrHTuMpzFkXcWO5qlkFS2aS5Sk15jsnhJA=;
 b=YOA1+5/NxquUy/SSYfce6CoSLpKC9qI4N27TlATRdT9WNO13BlvtBbQfO/A4EFV60s
 G9t+7fjIlch7fnuTHJNcMOw9AeIYnP0LRdlOIeWcYqgk8+mKtg1hs5eBGzNndXMgZLha
 vq0OWGJ9yK+ITRDkKuMbT75MgLF0vn8n9T+pI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782265; x=1794387065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lop12+3UrsrHTuMpzFkXcWO5qlkFS2aS5Sk15jsnhJA=;
 b=T9/liH8OqAOGMhnc6swZnB1wBybfYSq+UQjJUuKa9sqC03uk7A8DHXIOflnhys5w/e
 V/XDEIWs0vMdtsM8VJP1eKTLxcc4qDQidD82/5rzftgC5Qih9A4I/XbIPF0iueWBn6WB
 tU+ZLiwVRCG4BKwP+XtvPy7NObxCFU9MjIWBZuWb0rYFW2SItG4yfSnDbjpZJvdQkM9/
 CG6pZW9TyqFmJ/Vp3e/EPx/EaEupgiEd54BuPUieoxyp2/kN8URcwS5QNGHvH49eE1Me
 6fdd8kiF6b6JyTf5te0OV1jBIpoQakXqlxmCFXn7JWns+SsCMdcCx805ezGKuBUe6zbm
 CO6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvkeYJe0OirHRBBqvGGZa9qInXPeHb/UzBErP6/+NrX8yN50TVOGaCl+Dcd7WciUMN+04CcrI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ZEUIV/aLDVYzFrkOEm8HM+1+lhikazgR0dGPdaKMtWcPygA5f
 pr9Xwn7ICO7p/z7FmrNaFQ72IHPe+ZOJO8f8hticmbgKZp7YfO73fgdfHcfhq1HmcUo=
X-Gm-Gg: AYBFou2iCZTOy4xaKaALaDuMdEXgNFA0v2sqL/LQRT9CJ75+/z1NHh+zHMZPLz7QkMz
 nPdxpEDpgPpPR4EZ3jRZssb90ez6IZJC9p3vkfCfTAcLaoVGJ+KsXzs6b3M4UBPeIcooRfq8Cgc
 3mOVB2T1945s4Ur4C1Xq1V2gTBVFY3F4dQba6K9/9oh6UEKu1ydiPfDKQNTSWLjI27157MZS/cX
 dBIznkGtmCJxx/sWYDn+qNCElbM2myEdKm8TKsHGp9fISUlLk+IA1ts55GK2L29SE2crTVMQXG3
 ozLtPy5nvdI5RkiyKkGvu7e5iqTJK6doTEvjfm94uv0fjCg/2uOvjN139XmuXOjGgs1iGDumNWA
 I94XxkJ/TQAQAjiDTzWHtK9j7OvTvKxq8xVjcSWUccL5D4W0KnVtWoYkVsZo44GaATfl9I/YpdZ
 U19sOzal5H5VQm2qRlU30pPNmndjNlKqCR0DaJnQgYHbgai++anv9DDjoGLEso8PVKEi8xP4OL/
 S6YK+CZZ4746YkoWjfqIFETRLfrzEf0nyJzSrEVaN4Uc18tTV2WGyzgi549oUmIJ4xR6x2gxm8y
 tRb3E+SnXYrpHueQCYWYtwpfDLPj5isZGmw31PsPdZnYSuFbIEXTa6FLHgoVF507zWBGQnqUzI5
 bvqr60wp87cZ3fkgREw7xlckXnKKHozGhASfZFrwhSQsr6tOf
X-Received: by 2002:a05:600c:540f:b0:4a3:18ca:806 with SMTP id
 5b1f17b1804b1-4ac17d1a1f1mr374185205e9.20.1793782265334; 
 Wed, 04 Nov 2026 00:51:05 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:03 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 05/33] arm64: dts: st: add CAN1 support on stm32mp25
Date: Wed,  4 Nov 2026 09:49:38 +0100
Message-ID: <20261104085036.4012238-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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

The controller is compliant with ISO 11898-1: 2015 (CAN protocol
specification version 2.0 part A, B) and CAN FD protocol specification
version 1.0.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-6-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 7e62731fba26a58f975815add1e3146eaaaaa9c2 ]

(cherry picked from commit 3de3ce4cd1862224d78cc8da29550dab9feeb43f)
---

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

