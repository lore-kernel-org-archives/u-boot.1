Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908EECA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 20:33:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 40FE1607B6;
	Tue, 29 Sep 2026 20:33:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eqweVWaojEeQ; Tue, 29 Sep 2026 20:33:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 624BB607F0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790713982;
	b=gkSV2g8MhXSD7V63zKihjeqF7uR4vCfrWOwmIei7Xc0EEOzcuY5gIbz+AlqmTQDpTry8
	 2YkiAZzhapw9gon5icxvWDkafpnLigHpMCu29wEl7z0mHjDvMORi0I3YIo+5QlN1ZH/pN
	 FtANfwL3cpKN5tZFnk8CsnEC44PZ/b/tu/JJirVmkwyoGbhtvnzCU6qHylFmV/m9381Qc
	 nZ0XfO21sSuQ31keHuULBhxB6LzEiVh0RqSPIgAD+YeEi+5nW8x9JnnUIrWSi6pEwCeyr
	 xnoCgfgUnVyHLJGFCJKy8vymZ+0rPnFCTIQm6RISRn6WrUYSVn4vwCi+g29tGQElfmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790713982;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
	b=laDRbLCHGzVGrRdN6fzYxpfdqsvSB5A6s2QOjkZYLV2GXUIGB1V4CIazgbU/Z6Tl/4kP
	 98CftRuMsXiETKFsM9SOHC4f3Uk7ejsH3GQjLFTtM4+Kx6SllFniDrdWVVKGFAqGPhMd3
	 ZheJ6K6hq8O1rS0fgRYeQnfg64X0G2PkrVEhnM5mqEKcMIDLtPIXTwQANWBNJQnOBUGyq
	 pMM2TRf3mu4UzX82C6kgwphRUQM4ofwa3NfKteiztu3CwIznjqxlWIkVZ0YH/bMubq+/J
	 0ovP/s1f8mEnF798XH0F+NPJDnLv05xs8JsS/gBuYRTNCKPPeMjE2cjyoNBQymDyaLQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=brivo.com;
	dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256 header.s=google header.b=OYCzjBGN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790713982;
	bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Q1dU5oNKCkiRTAFqW54KTMxljZ3JChP/YovRQjdwcCO2asGU27iL3AlQZpo645BSg
	 ma7mtTYduiTWYBD/ukKPZwd1ZXrp2ebiOrSPZOyafwFgos8fZ98+hQZaPjafPV0M6K
	 d5r+AzSMc2usGTJl1q3nQI++iSoY8G1ujEwkBpciruUtoGg4Z8jRHmVy+CnBw90ny5
	 kG9JYZxJqg2m/E6KrV1s6EpDCYF/y6A3m6geDGEBEy6Xq/DP0muSU4si/o/z6dUPse
	 4PqMzsPGH2AqJjI1R0WbOOlxQu7vhmux0qT7CQb49qrMvXQoVuij+2SOdK2NeqEdly
	 tN8LiI7rYIPow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 624BB607F0;
	Tue, 29 Sep 2026 20:33:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FAEF2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6588360699
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3RYW7HMW-8W2 for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 18:07:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9045B6061C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:34::1a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790705250;
 b=moRQlCDeZMc8ercsU7nUoBeoq9SN0+7ExQYk8PRyGOaQqhtspJ/ghuqfehfnMnSHJI58
 TzCGDto+02TtccOF6uJJpWgCA9SHUxiZD0sXZc8KrebOB3sIIx80cgIMvv/I+9m5aRKe9
 Lk1go7ZiSmM3VzHQkHQnvASxTmp+/f0AXEbUfvrjfBR5In4Md+aIsc64CQRO7pf2UIJNM
 90RSsIxIq8ztI3wQ4ZEWqhKtzHou+P8kXqNLtH6uq/9Qo/Kq1JLoZISmR8ysNXvaBjsZB
 JqJQOwLTztLSfvO3K+DQUh6b0Tp1MtF6eVh16VKm50WfagQ1243t4Ly9/dzqJkWvxxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790705250;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
 b=CeeGtTxcaWaAJ2NJL2AlPyJVyMOaqVu8ixbHS341F2pjHPvE6TOEsM+It94C5rAPtVEu
 vjcS/W4w0ftNqr4TaJdT2PL1fNxTXDlvKN2QFYm/MAUTmf9eNchoc3ZWjYhlmtFqpTMHX
 qm5mByPlj+TJyeGgLBe6uW8E6tV71sH2Gbh9F7NYXaoQ4ZUkGM20gqoJ0HgL7r3tZ7BBk
 zqlBnGH2vZrVaLFmTKpsId5hfI5irAVMGaQqrg2Ar2d+wZ5lNUM6RInDPCys1F1Wdux9G
 4SD98HJF3jJ4jTPD+Lr54YZTDXsaEelNl+WM10y+4LNsWhMwVoWWbopxKXI1iplgieQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=brivo.com; 
 dkim=pass header.d=brivo.com header.i=@brivo.com header.a=rsa-sha256
 header.s=google header.b=OYCzjBGN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:34::1a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:34::1a; helo=mail-qk2-x1a.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=OYCzjBGN
Received: from mail-qk2-x1a.google.com (mail-qk2-x1a.google.com
 [IPv6:2607:f8b0:4864:34::1a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9045B6061C
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 18:07:30 +0000 (UTC)
Received: by mail-qk2-x1a.google.com with SMTP id
 af79cd13be357-93bef17c191so394250385a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1790705249; x=1791310049;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
 b=OYCzjBGNTr9hcFeKjegwb7svlgO91SQmMPRjlJ1PFYOTsshtnJIuyq/DJ5ZnWE2pG+
 YBRT9U6eni4dH6CQFkPpIrEbW8VDhwAwhk3D89kgzHWCACSbkcpzp11NpPIgPkSSkCbB
 h4Dsccwiyq9II8MuoM0cJmSq9K0cyrQY1zo41w8mquHnqlsTbUXbLhZt2REKaCYoiVML
 lXFNFWZ7R/TDG1tReDmpmqWf+Qm6qBw7Bq+i3EUFntBRFPiKjxpihrXOsaRsGkHh2vGo
 dq1uUKZ33dx7QEOe0gQ1On+hUct4KM2BONCbilAKvPUHSelAvq/1tJZACVSNhehosOWw
 fuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790705249; x=1791310049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hZ0aAcXPyLJOWTIOwpcMMd3zTA2SjJq4N+aIqWTXWAA=;
 b=HXCEdNUosYiXFTgGG37j/dmOYjW7jZcOyA/MLHuT1850rUYqWCaav0QSP1VsnE3pTf
 9RbOFDdezAfEjj+2gXEnHNhFXtuywUBgCJnjBvCFo19pb27Dap7OPJsYxLXncqQOODQI
 KCaY9g7henJJyeyo1E3wa8d+ACEkkqcoFg06X1Z1TWivrdU8hayyyYLVGpx6KAvbo0Hw
 DbBu+qv3vno0TWmxO4Z2uXy2ssi+fV7265aNfjF/fnprzSFHEbVLJFzlIqxA/0thRkyC
 ENAY6br6nj/mHvKeCsFsugdnFCipvGqTU/17phy2474voMohA7ig0R51bk1bSMs2CUJf
 8FLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy51Z+IgLXS/YtuDOT72UDvvcrICmN8s3G8QhxkHu6tAxHuSiegnqmZywLZcB+fwB+Zh0a8C3g=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mOeixjdQSQA4Ym1mSSb61jS9+1jby3gqZx3qq5SbG/hNaJQwDp
 Vw8otnNB8ygoA7RSUaZm9+0KnDlM81ILjSz/FoA5MqicGROO7e20Kaok2n7Db5uSGCHt16MjA2F
 NtFBMGmr8Y2eEy/LQGmqS3aaNeZ3qvUNPqrGdryLAGoBTsWXoW+7rszU4MAby1YLHm8eVWFGaGM
 pcV7Y=
X-Gm-Gg: AYBFou0Fog3OtClzsSQZgEI3U8Kqc2cVTJOBe9L+WnaeW8ok1LBuMnIX2eJUASE2ZbC
 B4KBqc6OedC72cQQNIMselCCcqkAxDFjMKmocm5mY9UFqoBFfTPuqlpE466QfmeprRQxqRwVM9b
 tl3l3h4bXAtZpibdvNf7OozH0+1XiuLolULWW3QXeqGCgnr8X/jo4cbe+sLuDap+YcaJ9A+MNbG
 2mt2uSPQOIwBONSxb6+oIjX44u24J15hwYIJD26P8qWflXojeLsI+BWrQycQlel/8WT7FLD57cp
 aU+JJpJnQhTE8WPSAlEpbIB4JqzJbvM2JYpiu9uX2Xwb3hF8qpplMi+TCwqTf0xuEnV7daNnjWX
 Xar7ieQjG9eAwv91gT/aDCJUQTESAJakPij0y4r/keSRO2RPMWZjTCKy0ohBcuUohKyVMV5yPsL
 GR9XpgkqnATkTgZlBRlrdtKaozSaHOu/lTg+ctyv4CFks1kPn1ca+7kJnWmvw6oK2l
X-Received: by 2002:a05:620a:3724:b0:93c:7211:beee with SMTP id
 af79cd13be357-93c9fb464e0mr67758785a.28.1790705248321; 
 Tue, 29 Sep 2026 11:07:28 -0700 (PDT)
Received: from strozzi ([71.163.254.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c9f462b0esm28802785a.9.2026.09.29.11.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 11:07:28 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 5/9] clk: meson: Export a1 functions to common file
Date: Tue, 29 Sep 2026 14:06:27 -0400
Message-ID: <20260929180721.3440839-6-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929180721.3440839-1-sanderson@brivo.com>
References: <20260929180721.3440839-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 20:32:39 +0000
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

Export several useful functions from a1 to a common file. These will be
used for s4 support.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

(no changes since v1)

 drivers/clk/meson/Makefile    |   1 +
 drivers/clk/meson/a1.c        | 473 ----------------------------------
 drivers/clk/meson/axg-ao.c    |   4 -
 drivers/clk/meson/axg.c       |   4 -
 drivers/clk/meson/clk_meson.c | 350 +++++++++++++++++++++++++
 drivers/clk/meson/clk_meson.h | 143 ++++++++++
 drivers/clk/meson/g12a-ao.c   |   4 -
 drivers/clk/meson/g12a.c      |   4 -
 drivers/clk/meson/gxbb.c      |   4 -
 9 files changed, 494 insertions(+), 493 deletions(-)
 create mode 100644 drivers/clk/meson/clk_meson.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index c7a446e86c4..3d1dfcdb640 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,6 +3,7 @@
 # Copyright (c) 2019 Baylibre, SAS
 # Jerome Brunet <jbrunet@baylibre.com>
 
+obj-y += clk_meson.o
 obj-$(CONFIG_CLK_MESON_GX) += gxbb.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg.o
 obj-$(CONFIG_CLK_MESON_AXG) += axg-ao.o
diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
index 422cdf5f4d1..b6d1887c98a 100644
--- a/drivers/clk/meson/a1.c
+++ b/drivers/clk/meson/a1.c
@@ -34,138 +34,6 @@
 
 #define EXTERNAL_FIXPLL_IN		(NR_PLL_CLKS + 1)
 
-#define SET_PARM_VALUE(_priv, _parm, _val)				\
-	regmap_update_bits((_priv)->map, (_parm)->reg_off,		\
-			   SETPMASK((_parm)->width, (_parm)->shift),	\
-			   (_val) << (_parm)->shift)
-
-#define GET_PARM_VALUE(_priv, _parm)					\
-({									\
-	uint _reg;							\
-	regmap_read((_priv)->map, (_parm)->reg_off, &_reg);		\
-	PARM_GET((_parm)->width, (_parm)->shift, _reg);			\
-})
-
-struct meson_clk {
-	struct regmap *map;
-};
-
-/**
- * enum meson_clk_type - The type of clock
- * @MESON_CLK_ANY: Special value that matches any clock type
- * @MESON_CLK_GATE: This clock is a gate
- * @MESON_CLK_MUX: This clock is a multiplexer
- * @MESON_CLK_DIV: This clock is a configurable divider
- * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
- * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
- * @MESON_CLK_PLL: This is a PLL
- */
-enum meson_clk_type {
-	MESON_CLK_ANY = 0,
-	MESON_CLK_GATE,
-	MESON_CLK_MUX,
-	MESON_CLK_DIV,
-	MESON_CLK_FIXED_DIV,
-	MESON_CLK_EXTERNAL,
-	MESON_CLK_PLL,
-};
-
-/**
- * struct meson_clk_info - The parameters defining a clock
- * @name: Name of the clock
- * @parm: Register bits description for muxes and dividers
- * @div: Fixed divider value
- * @parents: List of parent clock IDs
- * @type: Clock type
- */
-struct meson_clk_info {
-	const char *name;
-	union {
-		const struct parm *parm;
-		u8 div;
-	};
-	const unsigned int *parents;
-	const enum meson_clk_type type;
-};
-
-/**
- * struct meson_clk_data - Clocks supported by clock provider
- * @num_clocks: Number of clocks
- * @clocks: Array of clock descriptions
- *
- */
-struct meson_clk_data {
-	const u8 num_clocks;
-	const struct meson_clk_info **clocks;
-};
-
-/* Clock description initialization macros */
-
-/* A multiplexer */
-#define CLK_MUX(_name, _reg, _shift, _width, ...)			\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[])__VA_ARGS__,		\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = (_width),				\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_MUX,					\
-	})
-
-/* A divider with an integral divisor */
-#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = (_width),				\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_DIV,					\
-	})
-
-/* A fixed divider */
-#define CLK_DIV_FIXED(_name, _div, _parent)				\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.div = (_div),						\
-		.name = (_name),					\
-		.type = MESON_CLK_FIXED_DIV,				\
-	})
-
-/* An external clock */
-#define CLK_EXTERNAL(_name)						\
-	(&(struct meson_clk_info){					\
-		.name = (_name),					\
-		.parents = (const unsigned int[]) { -ENOENT },		\
-		.type = MESON_CLK_EXTERNAL,				\
-	})
-
-/* A clock gate */
-#define CLK_GATE(_name, _reg, _shift, _parent)				\
-	(&(struct meson_clk_info){					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = &(struct parm) {				\
-			.reg_off = (_reg),				\
-			.shift = (_shift),				\
-			.width = 1,					\
-		},							\
-		.name = (_name),					\
-		.type = MESON_CLK_GATE,					\
-	})
-
-/* A PLL clock */
-#define CLK_PLL(_name, _parent, ...)					\
-	(&(struct meson_clk_info){					\
-		.name = (_name),					\
-		.parents = (const unsigned int[]) { (_parent) },	\
-		.parm = (const struct parm[])__VA_ARGS__,		\
-		.type = MESON_CLK_PLL,					\
-	})
-
 /* A1 peripherals clocks */
 static const struct meson_clk_info *meson_clocks[] = {
 	[CLKID_SPIFC_SEL] = CLK_MUX("spifc_sel", A1_SPIFC_CLK_CTRL, 9, 2, {
@@ -302,254 +170,6 @@ static const struct meson_clk_info *meson_pll_clocks[] = {
 	),
 };
 
-static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
-						       enum meson_clk_type type)
-{
-	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
-	const struct meson_clk_info *info;
-
-	if (clk->id >= data->num_clocks)
-		return ERR_PTR(-EINVAL);
-
-	info = data->clocks[clk->id];
-	if (!info)
-		return ERR_PTR(-ENOENT);
-
-	if (type != MESON_CLK_ANY && type != info->type)
-		return ERR_PTR(-EINVAL);
-
-	return info;
-}
-
-static ulong meson_clk_get_rate(struct clk *clk);
-
-static int meson_set_gate(struct clk *clk, bool on)
-{
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	SET_PARM_VALUE(priv, info->parm, on);
-
-	return 0;
-}
-
-static int meson_clk_enable(struct clk *clk)
-{
-	return meson_set_gate(clk, true);
-}
-
-static int meson_clk_disable(struct clk *clk)
-{
-	return meson_set_gate(clk, false);
-}
-
-static ulong meson_div_get_rate(struct clk *clk)
-{
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	u16 n;
-	ulong rate;
-	const struct meson_clk_info *info;
-	struct clk parent;
-
-	info = meson_clk_get_info(clk, MESON_CLK_DIV);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	/* Actual divider value is (field value + 1), hence the increment */
-	n = GET_PARM_VALUE(priv, info->parm) + 1;
-
-	parent.dev = clk->dev;
-	parent.id = info->parents[0];
-	rate = meson_clk_get_rate(&parent);
-
-	return rate / n;
-}
-
-static int meson_clk_get_parent(struct clk *clk)
-{
-	uint reg = 0;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	/* For muxes we read currently selected parent from register,
-	 * for other types there is always only one element in parents array.
-	 */
-	if (info->type == MESON_CLK_MUX) {
-		reg = GET_PARM_VALUE(priv, info->parm);
-		if (IS_ERR_VALUE(reg))
-			return reg;
-	}
-
-	return info->parents[reg];
-}
-
-static ulong meson_pll_get_rate(struct clk *clk)
-{
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-	const struct parm *pm, *pn;
-	ulong parent_rate_mhz;
-	struct clk parent;
-	u16 n, m;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	pm = &info->parm[0];
-	pn = &info->parm[1];
-
-	n = GET_PARM_VALUE(priv, pn);
-	m = GET_PARM_VALUE(priv, pm);
-
-	if (n == 0)
-		return -EINVAL;
-
-	parent.dev = clk->dev;
-	parent.id = info->parents[0];
-	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
-
-	return parent_rate_mhz * m / n * 1000000;
-}
-
-static ulong meson_clk_get_rate(struct clk *clk)
-{
-	struct clk parent;
-	const struct meson_clk_info *info;
-
-	if (IS_ERR_VALUE(clk->id))
-		return clk->id;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	switch (info->type) {
-	case MESON_CLK_PLL:
-		return meson_pll_get_rate(clk);
-	case MESON_CLK_GATE:
-	case MESON_CLK_MUX:
-		parent.dev = clk->dev;
-		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent);
-	case MESON_CLK_DIV:
-		return meson_div_get_rate(clk);
-	case MESON_CLK_FIXED_DIV:
-		parent.dev = clk->dev;
-		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent) / info->div;
-	case MESON_CLK_EXTERNAL: {
-		int ret;
-		struct clk external_clk;
-
-		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
-		if (ret)
-			return ret;
-
-		return clk_get_rate(&external_clk);
-	}
-	default:
-		return -EINVAL;
-	}
-}
-
-/* This implements rate propagation for dividers placed after multiplexer:
- *  ---------|\
- *     ..... | |---DIV--
- *  ---------|/
- */
-static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
-{
-	unsigned int i, best_div_val;
-	unsigned long best_delta, best_parent;
-	const struct meson_clk_info *div;
-	const struct meson_clk_info *mux;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	struct clk mux_clk;
-
-	div = meson_clk_get_info(clk, MESON_CLK_DIV);
-	if (IS_ERR(div))
-		return PTR_ERR(div);
-
-	mux_clk.dev = clk->dev;
-	mux_clk.id = div->parents[0];
-	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
-	if (IS_ERR(mux))
-		return PTR_ERR(mux);
-
-	best_parent = -EINVAL;
-	best_delta = ULONG_MAX;
-	for (i = 0; i < (1 << mux->parm->width); i++) {
-		unsigned long parent_rate, delta;
-		unsigned int div_val;
-		struct clk parent = {
-			.dev = clk->dev,
-			.id =  mux->parents[i],
-		};
-
-		parent_rate = meson_clk_get_rate(&parent);
-		if (IS_ERR_VALUE(parent_rate))
-			continue;
-
-		/* If overflow, try to use max divider value */
-		div_val = min(DIV_ROUND_CLOSEST(parent_rate, rate),
-			      (1UL << div->parm->width));
-
-		delta = abs(rate - (parent_rate / div_val));
-		if (delta < best_delta) {
-			best_delta = delta;
-			best_div_val = div_val;
-			best_parent = i;
-		}
-	}
-
-	if (IS_ERR_VALUE(best_parent))
-		return best_parent;
-
-	SET_PARM_VALUE(priv, mux->parm, best_parent);
-	/* Divider is set to (field value + 1), hence the decrement */
-	SET_PARM_VALUE(priv, div->parm, best_div_val - 1);
-
-	return 0;
-}
-
-static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
-{
-	int i;
-	ulong ret = -EINVAL;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_MUX);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	for (i = 0; i < (1 << info->parm->width); i++) {
-		struct clk parent = {
-			.dev = clk->dev,
-			.id = info->parents[i],
-		};
-
-		ret = clk_set_rate(&parent, rate);
-		if (!ret) {
-			SET_PARM_VALUE(priv, info->parm, i);
-			break;
-		}
-	}
-
-	return ret;
-}
-
 /* Rate propagation is implemented for a subcection of a clock tree, that is
  * required at boot stage.
  */
@@ -575,32 +195,6 @@ static ulong meson_clk_set_rate(struct clk *clk, ulong rate)
 	return -EINVAL;
 }
 
-static int meson_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	unsigned int i, parent_index;
-	struct meson_clk *priv = dev_get_priv(clk->dev);
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_MUX);
-	if (IS_ERR(info))
-		return PTR_ERR(info);
-
-	parent_index = -EINVAL;
-	for (i = 0; i < (1 << info->parm->width); i++) {
-		if (parent->id == info->parents[i]) {
-			parent_index = i;
-			break;
-		}
-	}
-
-	if (IS_ERR_VALUE(parent_index))
-		return parent_index;
-
-	SET_PARM_VALUE(priv, info->parm, parent_index);
-
-	return 0;
-}
-
 static int meson_clk_probe(struct udevice *dev)
 {
 	struct meson_clk *priv = dev_get_priv(dev);
@@ -630,73 +224,6 @@ static const struct udevice_id meson_clk_ids[] = {
 	{ }
 };
 
-#if IS_ENABLED(CONFIG_CMD_CLK)
-static const char *meson_clk_get_name(struct clk *clk)
-{
-	const struct meson_clk_info *info;
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-
-	return IS_ERR(info) ? "unknown" : info->name;
-}
-
-static int meson_clk_dump_single(struct clk *clk)
-{
-	const struct meson_clk_info *info;
-	struct meson_clk *priv;
-	unsigned long rate;
-	char *state, frequency[80];
-	struct clk parent;
-
-	priv = dev_get_priv(clk->dev);
-
-	info = meson_clk_get_info(clk, MESON_CLK_ANY);
-	if (IS_ERR(info) || !info->name)
-		return -EINVAL;
-
-	rate = clk_get_rate(clk);
-	if (IS_ERR_VALUE(rate))
-		sprintf(frequency, "unknown");
-	else
-		sprintf(frequency, "%lu", rate);
-
-	if (info->type == MESON_CLK_GATE)
-		state = GET_PARM_VALUE(priv, info->parm) ? "enabled" : "disabled";
-	else
-		state = "N/A";
-
-	parent.dev = clk->dev;
-	parent.id = meson_clk_get_parent(clk);
-	printf("%15s%20s%20s%15s\n",
-	       info->name,
-	       frequency,
-	       meson_clk_get_name(&parent),
-	       state);
-
-	return 0;
-}
-
-static void meson_clk_dump(struct udevice *dev)
-{
-	int i;
-	struct meson_clk_data *data;
-	const char *sep = "--------------------";
-
-	printf("%s:\n", dev->name);
-	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
-	printf("%15s%20s%20s%15s\n", "clk", "frequency", "parent", "state");
-	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
-
-	data = (struct meson_clk_data *)dev_get_driver_data(dev);
-	for (i = 0; i < data->num_clocks; i++) {
-		meson_clk_dump_single(&(struct clk){
-			.dev = dev,
-			.id = i
-		});
-	}
-}
-#endif
-
 static struct clk_ops meson_clk_ops = {
 	.disable	= meson_clk_disable,
 	.enable		= meson_clk_enable,
diff --git a/drivers/clk/meson/axg-ao.c b/drivers/clk/meson/axg-ao.c
index 3215391006e..5f897d89e9b 100644
--- a/drivers/clk/meson/axg-ao.c
+++ b/drivers/clk/meson/axg-ao.c
@@ -10,10 +10,6 @@
 
 #include "clk_meson.h"
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 #define AO_CLK_GATE0		0x40
 #define AO_SAR_CLK		0x90
 
diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index e20d3feaade..3b5f4af9f4c 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -20,10 +20,6 @@
 
 #define XTAL_RATE 24000000
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 static ulong meson_clk_get_rate_by_id(struct clk *clk, unsigned long id);
 
 static struct meson_gate gates[] = {
diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
new file mode 100644
index 00000000000..de5aa5ae3c9
--- /dev/null
+++ b/drivers/clk/meson/clk_meson.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2023 SberDevices, Inc.
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <clk-uclass.h>
+#include <dm.h>
+#include <regmap.h>
+
+#include "clk_meson.h"
+
+static const struct meson_clk_info *meson_clk_get_info(struct clk *clk,
+						       enum meson_clk_type type)
+{
+	struct meson_clk_data *data = (void *)dev_get_driver_data(clk->dev);
+	const struct meson_clk_info *info;
+
+	if (clk->id >= data->num_clocks)
+		return ERR_PTR(-EINVAL);
+
+	info = data->clocks[clk->id];
+	if (!info)
+		return ERR_PTR(-ENOENT);
+
+	if (type != MESON_CLK_ANY && type != info->type)
+		return ERR_PTR(-EINVAL);
+
+	return info;
+}
+
+static int meson_set_gate(struct clk *clk, bool on)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	debug("%s: %sabling %lu\n", __func__, on ? "en" : "dis", clk->id);
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	SET_PARM_VALUE(priv, info->parm, on);
+
+	return 0;
+}
+
+int meson_clk_enable(struct clk *clk)
+{
+	return meson_set_gate(clk, true);
+}
+
+int meson_clk_disable(struct clk *clk)
+{
+	return meson_set_gate(clk, false);
+}
+
+static ulong meson_div_get_rate(struct clk *clk)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	u16 n;
+	ulong rate;
+	const struct meson_clk_info *info;
+	struct clk parent;
+
+	info = meson_clk_get_info(clk, MESON_CLK_DIV);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* Actual divider value is (field value + 1), hence the increment */
+	n = GET_PARM_VALUE(priv, info->parm) + 1;
+
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	rate = meson_clk_get_rate(&parent);
+
+	return rate / n;
+}
+
+int meson_clk_get_parent(struct clk *clk)
+{
+	uint reg = 0;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	/* For muxes we read currently selected parent from register,
+	 * for other types there is always only one element in parents array.
+	 */
+	if (info->type == MESON_CLK_MUX) {
+		reg = GET_PARM_VALUE(priv, info->parm);
+		if (IS_ERR_VALUE(reg))
+			return reg;
+	}
+
+	return info->parents[reg];
+}
+
+static ulong meson_pll_get_rate(struct clk *clk)
+{
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+	const struct parm *pm, *pn;
+	ulong parent_rate_mhz;
+	struct clk parent;
+	u16 n, m;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	pm = &info->parm[0];
+	pn = &info->parm[1];
+
+	n = GET_PARM_VALUE(priv, pn);
+	m = GET_PARM_VALUE(priv, pm);
+
+	if (n == 0)
+		return -EINVAL;
+
+	parent.dev = clk->dev;
+	parent.id = info->parents[0];
+	parent_rate_mhz = meson_clk_get_rate(&parent) / 1000000;
+
+	return parent_rate_mhz * m / n * 1000000;
+}
+
+ulong meson_clk_get_rate(struct clk *clk)
+{
+	struct clk parent;
+	const struct meson_clk_info *info;
+
+	if (IS_ERR_VALUE(clk->id))
+		return clk->id;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	switch (info->type) {
+	case MESON_CLK_PLL:
+		return meson_pll_get_rate(clk);
+	case MESON_CLK_GATE:
+	case MESON_CLK_MUX:
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent);
+	case MESON_CLK_DIV:
+		return meson_div_get_rate(clk);
+	case MESON_CLK_FIXED_DIV:
+		parent.dev = clk->dev;
+		parent.id = meson_clk_get_parent(clk);
+		return meson_clk_get_rate(&parent) / info->div;
+	case MESON_CLK_EXTERNAL: {
+		int ret;
+		struct clk external_clk;
+
+		ret = clk_get_by_name(clk->dev, info->name, &external_clk);
+		if (ret)
+			return ret;
+
+		return clk_get_rate(&external_clk);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+/* This implements rate propagation for dividers placed after multiplexer:
+ *  ---------|\
+ *     ..... | |---DIV--
+ *  ---------|/
+ */
+ulong meson_composite_set_rate(struct clk *clk, ulong rate)
+{
+	unsigned int i, best_div_val;
+	unsigned long best_delta, best_parent;
+	const struct meson_clk_info *div;
+	const struct meson_clk_info *mux;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	struct clk mux_clk;
+
+	div = meson_clk_get_info(clk, MESON_CLK_DIV);
+	if (IS_ERR(div))
+		return PTR_ERR(div);
+
+	mux_clk.dev = clk->dev;
+	mux_clk.id = div->parents[0];
+	mux = meson_clk_get_info(&mux_clk, MESON_CLK_MUX);
+	if (IS_ERR(mux))
+		return PTR_ERR(mux);
+
+	best_parent = -EINVAL;
+	best_delta = ULONG_MAX;
+	for (i = 0; i < (1 << mux->parm->width); i++) {
+		unsigned long parent_rate, delta;
+		unsigned int div_val;
+		struct clk parent = {
+			.dev = clk->dev,
+			.id =  mux->parents[i],
+		};
+
+		parent_rate = meson_clk_get_rate(&parent);
+		if (IS_ERR_VALUE(parent_rate))
+			continue;
+
+		/* If overflow, try to use max divider value */
+		div_val = min(DIV_ROUND_CLOSEST(parent_rate, rate),
+			      (1UL << div->parm->width));
+
+		delta = abs(rate - (parent_rate / div_val));
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_div_val = div_val;
+			best_parent = i;
+		}
+	}
+
+	if (IS_ERR_VALUE(best_parent))
+		return best_parent;
+
+	SET_PARM_VALUE(priv, mux->parm, best_parent);
+	/* Divider is set to (field value + 1), hence the decrement */
+	SET_PARM_VALUE(priv, div->parm, best_div_val - 1);
+
+	return 0;
+}
+
+ulong meson_mux_set_rate(struct clk *clk, ulong rate)
+{
+	int i;
+	ulong ret = -EINVAL;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	for (i = 0; i < (1 << info->parm->width); i++) {
+		struct clk parent = {
+			.dev = clk->dev,
+			.id = info->parents[i],
+		};
+
+		ret = clk_set_rate(&parent, rate);
+		if (!ret) {
+			SET_PARM_VALUE(priv, info->parm, i);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int meson_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	unsigned int i, parent_index;
+	struct meson_clk *priv = dev_get_priv(clk->dev);
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_MUX);
+	if (IS_ERR(info))
+		return PTR_ERR(info);
+
+	parent_index = -EINVAL;
+	for (i = 0; i < (1 << info->parm->width); i++) {
+		if (parent->id == info->parents[i]) {
+			parent_index = i;
+			break;
+		}
+	}
+
+	if (IS_ERR_VALUE(parent_index))
+		return parent_index;
+
+	SET_PARM_VALUE(priv, info->parm, parent_index);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_CMD_CLK)
+static const char *meson_clk_get_name(struct clk *clk)
+{
+	const struct meson_clk_info *info;
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+
+	return IS_ERR(info) ? "unknown" : info->name;
+}
+
+static int meson_clk_dump_single(struct clk *clk)
+{
+	const struct meson_clk_info *info;
+	struct meson_clk *priv;
+	unsigned long rate;
+	char *state, frequency[80];
+	struct clk parent;
+
+	priv = dev_get_priv(clk->dev);
+
+	info = meson_clk_get_info(clk, MESON_CLK_ANY);
+	if (IS_ERR(info) || !info->name)
+		return -EINVAL;
+
+	rate = clk_get_rate(clk);
+	if (IS_ERR_VALUE(rate))
+		sprintf(frequency, "unknown");
+	else
+		sprintf(frequency, "%lu", rate);
+
+	if (info->type == MESON_CLK_GATE)
+		state = GET_PARM_VALUE(priv, info->parm) ? "enabled" : "disabled";
+	else
+		state = "N/A";
+
+	parent.dev = clk->dev;
+	parent.id = meson_clk_get_parent(clk);
+	printf("%15s%20s%20s%15s\n",
+	       info->name,
+	       frequency,
+	       meson_clk_get_name(&parent),
+	       state);
+
+	return 0;
+}
+
+void meson_clk_dump(struct udevice *dev)
+{
+	int i;
+	struct meson_clk_data *data;
+	const char *sep = "--------------------";
+
+	printf("%s:\n", dev->name);
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+	printf("%15s%20s%20s%15s\n", "clk", "frequency", "parent", "state");
+	printf("%.15s%s%s%.15s\n", sep, sep, sep, sep);
+
+	data = (struct meson_clk_data *)dev_get_driver_data(dev);
+	for (i = 0; i < data->num_clocks; i++) {
+		meson_clk_dump_single(&(struct clk){
+			.dev = dev,
+			.id = i
+		});
+	}
+}
+#endif
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index ef72a416c15..990e9434126 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -39,10 +39,153 @@ struct parm {
 #define PARM_SET(width, shift, reg, val)                                \
 	(((reg) & CLRPMASK(width, shift)) | ((val) << (shift)))
 
+#define SET_PARM_VALUE(_priv, _parm, _val)				\
+	regmap_update_bits((_priv)->map, (_parm)->reg_off,		\
+			   SETPMASK((_parm)->width, (_parm)->shift),	\
+			   (_val) << (_parm)->shift)
+
+#define GET_PARM_VALUE(_priv, _parm)					\
+({									\
+	uint _reg;							\
+	regmap_read((_priv)->map, (_parm)->reg_off, &_reg);		\
+	PARM_GET((_parm)->width, (_parm)->shift, _reg);			\
+})
+
+struct meson_clk {
+	struct regmap *map;
+};
+
+/**
+ * enum meson_clk_type - The type of clock
+ * @MESON_CLK_ANY: Special value that matches any clock type
+ * @MESON_CLK_GATE: This clock is a gate
+ * @MESON_CLK_MUX: This clock is a multiplexer
+ * @MESON_CLK_DIV: This clock is a configurable divider
+ * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
+ * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
+ * @MESON_CLK_PLL: This is a PLL
+ */
+enum meson_clk_type {
+	MESON_CLK_ANY = 0,
+	MESON_CLK_GATE,
+	MESON_CLK_MUX,
+	MESON_CLK_DIV,
+	MESON_CLK_FIXED_DIV,
+	MESON_CLK_EXTERNAL,
+	MESON_CLK_PLL,
+};
+
+/**
+ * struct meson_clk_info - The parameters defining a clock
+ * @name: Name of the clock
+ * @parm: Register bits description for muxes and dividers
+ * @div: Fixed divider value
+ * @parents: List of parent clock IDs
+ * @type: Clock type
+ */
+struct meson_clk_info {
+	const char *name;
+	union {
+		const struct parm *parm;
+		u8 div;
+	};
+	const unsigned int *parents;
+	const enum meson_clk_type type;
+};
+
+/**
+ * struct meson_clk_data - Clocks supported by clock provider
+ * @num_clocks: Number of clocks
+ * @clocks: Array of clock descriptions
+ *
+ */
+struct meson_clk_data {
+	const u8 num_clocks;
+	const struct meson_clk_info **clocks;
+};
+
+/* Clock description initialization macros */
+
+/* A multiplexer */
+#define CLK_MUX(_name, _reg, _shift, _width, ...)			\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[])__VA_ARGS__,		\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_MUX,					\
+	})
+
+/* A divider with an integral divisor */
+#define CLK_DIV(_name, _reg, _shift, _width, _parent)			\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = (_width),				\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_DIV,					\
+	})
+
+/* A fixed divider */
+#define CLK_DIV_FIXED(_name, _div, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.div = (_div),						\
+		.name = (_name),					\
+		.type = MESON_CLK_FIXED_DIV,				\
+	})
+
+/* An external clock */
+#define CLK_EXTERNAL(_name)						\
+	(&(struct meson_clk_info){					\
+		.name = (_name),					\
+		.parents = (const unsigned int[]) { -ENOENT },		\
+		.type = MESON_CLK_EXTERNAL,				\
+	})
+
+/* A clock gate */
+#define CLK_GATE(_name, _reg, _shift, _parent)				\
+	(&(struct meson_clk_info){					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = &(struct parm) {				\
+			.reg_off = (_reg),				\
+			.shift = (_shift),				\
+			.width = 1,					\
+		},							\
+		.name = (_name),					\
+		.type = MESON_CLK_GATE,					\
+	})
+
+/* A PLL clock */
+#define CLK_PLL(_name, _parent, ...)					\
+	(&(struct meson_clk_info){					\
+		.name = (_name),					\
+		.parents = (const unsigned int[]) { (_parent) },	\
+		.parm = (const struct parm[])__VA_ARGS__,		\
+		.type = MESON_CLK_PLL,					\
+	})
+
 /* MPLL Parameters */
 
 #define SDM_DEN 16384
 #define N2_MIN  4
 #define N2_MAX  511
 
+int meson_clk_enable(struct clk *clk);
+int meson_clk_disable(struct clk *clk);
+int meson_clk_get_parent(struct clk *clk);
+ulong meson_clk_get_rate(struct clk *clk);
+ulong meson_composite_set_rate(struct clk *clk, ulong rate);
+ulong meson_mux_set_rate(struct clk *clk, ulong rate);
+int meson_clk_set_parent(struct clk *clk, struct clk *parent);
+#if IS_ENABLED(CONFIG_CMD_CLK)
+void meson_clk_dump(struct udevice *dev);
+#endif
+
 #endif
diff --git a/drivers/clk/meson/g12a-ao.c b/drivers/clk/meson/g12a-ao.c
index e89638d65b5..d9425f900f3 100644
--- a/drivers/clk/meson/g12a-ao.c
+++ b/drivers/clk/meson/g12a-ao.c
@@ -10,10 +10,6 @@
 
 #include "clk_meson.h"
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 #define AO_CLK_GATE0		0x4c
 #define AO_SAR_CLK		0x90
 
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index cc7bfe9e2a2..b1ba5881904 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -91,10 +91,6 @@
 
 #define XTAL_RATE 24000000
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id);
 static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 24b5f9b5d40..62c1e0eed4f 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -70,10 +70,6 @@
 
 #define XTAL_RATE 24000000
 
-struct meson_clk {
-	struct regmap *map;
-};
-
 static ulong meson_div_get_rate(struct clk *clk, unsigned long id);
 static ulong meson_div_set_rate(struct clk *clk, unsigned long id, ulong rate,
 				ulong current_rate);
-- 
2.53.0

