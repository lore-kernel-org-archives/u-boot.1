Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430BEC5DF70
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6EBC4088E;
	Mon, 17 Aug 2026 18:17:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JwfOVNGFPNcR; Mon, 17 Aug 2026 18:17:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AEBC34089A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990661;
	bh=mTKvYffvh/OKCJVMRt5IAEMDDvgNu0n/2vPjP9Y2kPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eykaVfy4qMbCPtg1r6vMlxJ+WKqSMtwa/4ClWqfznCs3xQiXKDeGVZGuVZUCCJwG7
	 P0bLaEchDutFWlywPE+6qa496HxL5GIz8+3UIiN3WOkT1dOeeCyMvuh5ka56RpyWWa
	 iGCOar9yWeMNDbaQCpld+6eq+ZXhfV+w4gwp5IpDOcMbyS69+Pxo9y57ierOmJiuGX
	 BON+uANSrxqMFt4xUxOrVv9kTTeo/gMilUYd04G/1iNPNRbKwfVMhsXFLrRwbKRRPy
	 /zi/h6BrJrWyms9XmBiisFBxMyiX/bz4gxCfZyC4mSs15NTdMMfihNQtPWQ6QYyBac
	 Tw+hbanKs6/yg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AEBC34089A;
	Mon, 17 Aug 2026 18:17:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 16BC5334
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 07D3580FFD
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i21NBBkZKJbq for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:16:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72f; helo=mail-qk1-x72f.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3794D80F0A
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3794D80F0A
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=X8sU5sFh
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3794D80F0A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:16:32 +0000 (UTC)
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-92e85499ffbso313342985a.0
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1786986991; x=1787591791;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mTKvYffvh/OKCJVMRt5IAEMDDvgNu0n/2vPjP9Y2kPI=;
 b=X8sU5sFhaOq712C5AZR5J1mrbyuFISANgsHBYIaEsxi5GP+N+6q6P7Ouujs2e5jRLE
 iHSZaPEPXLwRVeMXT5gA9DqLEw/O46UGU5tELQBmMiB3TgihLokqvITJADoNUUCEChfZ
 j2giadHXEb3B1K6AtwylmJyZBvuxYOFupiIgxwT+8DOUcgUc2dgE6/3KVcoKczzvlsYT
 QLtuMsR1KOvgs/MSn4X4ktkAkQFKNQw74T0D0YiB1OduM7cK+iZotN1g+AROh2HmMx4n
 YstTD44IGTKMdOI4dIaBTQQ2CxX+3q/kjCUQmTELOekRhfuViIUBOqHvvMPWRoDvFnMW
 Ud3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786986991; x=1787591791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mTKvYffvh/OKCJVMRt5IAEMDDvgNu0n/2vPjP9Y2kPI=;
 b=hq3EPHkkv4fwMxcydwrY9CM/bIFBdOz56Jkn2IS+9Dcjg4ZC1ni5J8C+loLLZzEF0Y
 HlxJodwAZm0Sme/ROzyFbas+5COemg4bmitplwzLlQiAexaIP8yfu4kFbjb6qo+TtaUl
 gKxaJdrDmET83VYAoW8IqU4qPQAeiDEbR9v9expjgdDtcAwDAC+aQJoxfhzIYwmiK72U
 dV3LrG2yPInK7Dvw14HwLq+PO9KUixHRApSsvHdXH/WjsTbwoxPmmxLJ5qDwLtedo1Bf
 HXLyCCSa6haaLnwfY0qfGl0k8ybiiTY78pXhkabaaFdfHgkWa3W6XbdahMbcQdYylHT4
 IThg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpp7Ok60owAGslGFQazdMTBVYRvHXZNRRGNF9INcxeQMHb8aSGaiOY4qQ1Ff8SIO5bElKQu+9o=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzZr/q6nOwHADKjgsLhsJYLIX81Aoa48Q0A/imzyPheG3lJGVSr
 VDG0XmSv/NwiDeJgkaYea0cnCn+DzaTzAfRXUtVExpefclr1ozpJB7JVurZR7bHUkqNqa/YJx2y
 C+tW6FpoEHkR8PN4E9MaVEIO6FnR2cqGrlTFYToZniq2kRli8c+rPUH5uT7lquMA9Bie1GN4eQr
 TEbZk=
X-Gm-Gg: AR+sD12FYEvYHffk5P0ryut8vxidUE2oPpm3Mzv5+XsH4Rphi2bIzvbUVcLHTuR7kiB
 d1Cu1neXgvqT0n3hd3tZnntVradm7vHyjG1bxlWZsh0ycqOgVICWU9TsBrajfgWpwdTqMtDrDrI
 Z3dE7h8KrAPcxz5Iel38XWmCpqfmW58b7qYL3QKvO7GFK1R2eZwhvn5yEoy/lQ1neN6c9Uvh/mf
 Rn5V3StE1DTC2w5u9mNWWcI430aGBtrvyJFjLal7adfUXlEuqmth8lFmh4qO89UKaJEtrH6c/pz
 3mUouH5+S4DZRVgQ/8/KBA+YLve1bl6LOTFU3UJIeEvXfifdYwSHNZpiJE2h/E5C3q9TPlIkHCD
 s3wxJVkbF6z1Ld8ZpJbHad87h8bDH6cv4hlm63NPkN6qO5zkgCcj+u4abNBbOoXCSIEaSE2GYLB
 bMbdpJra2xSFLo6EwmqLHHlum/sF4xGFvKAbMeky0ADRVF6OHs426x7GCRYBxYuitkDhbn1t+au
 TBBVW3NU4HWMAylIxdrrfA47Qs=
X-Received: by 2002:a05:620a:a48e:b0:934:81ae:6d1b with SMTP id
 af79cd13be357-936d22ce40bmr1826604385a.22.1786986990522; 
 Mon, 17 Aug 2026 10:16:30 -0700 (PDT)
Received: from strozzi (ec2-54-236-161-35.compute-1.amazonaws.com.
 [54.236.161.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c459783a9sm13637976d6.43.2026.08.17.10.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 10:16:30 -0700 (PDT)
From: Sean Anderson <sanderson@brivo.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Sean Anderson <sanderson@brivo.com>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 6/9] clk: meson: Support fractional fixed-factor clocks
Date: Mon, 17 Aug 2026 13:15:17 -0400
Message-ID: <20260817171623.1943847-7-sanderson@brivo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817171623.1943847-1-sanderson@brivo.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

One of the s4 clocks has a non-integer divisor (2.5). Add support for
this.

Signed-off-by: Sean Anderson <sanderson@brivo.com>
---

 drivers/clk/meson/clk_meson.c |  3 ++-
 drivers/clk/meson/clk_meson.h | 12 +++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/meson/clk_meson.c b/drivers/clk/meson/clk_meson.c
index de5aa5ae3c9..29615fdae77 100644
--- a/drivers/clk/meson/clk_meson.c
+++ b/drivers/clk/meson/clk_meson.c
@@ -153,7 +153,8 @@ ulong meson_clk_get_rate(struct clk *clk)
 	case MESON_CLK_FIXED_DIV:
 		parent.dev = clk->dev;
 		parent.id = meson_clk_get_parent(clk);
-		return meson_clk_get_rate(&parent) / info->div;
+		return mult_frac(meson_clk_get_rate(&parent), info->mult,
+				 info->div);
 	case MESON_CLK_EXTERNAL: {
 		int ret;
 		struct clk external_clk;
diff --git a/drivers/clk/meson/clk_meson.h b/drivers/clk/meson/clk_meson.h
index 990e9434126..86b272985ab 100644
--- a/drivers/clk/meson/clk_meson.h
+++ b/drivers/clk/meson/clk_meson.h
@@ -61,7 +61,7 @@ struct meson_clk {
  * @MESON_CLK_GATE: This clock is a gate
  * @MESON_CLK_MUX: This clock is a multiplexer
  * @MESON_CLK_DIV: This clock is a configurable divider
- * @MESON_CLK_FIXED_DIV: This clock is a configurable divider
+ * @MESON_CLK_FIXED_DIV: This clock is a (fractional) fixed-factor clock
  * @MESON_CLK_EXTERNAL: This is an external clock from different clock provider
  * @MESON_CLK_PLL: This is a PLL
  */
@@ -87,7 +87,10 @@ struct meson_clk_info {
 	const char *name;
 	union {
 		const struct parm *parm;
-		u8 div;
+		struct {
+			u8 mult;
+			u8 div;
+		};
 	};
 	const unsigned int *parents;
 	const enum meson_clk_type type;
@@ -133,13 +136,16 @@ struct meson_clk_data {
 	})
 
 /* A fixed divider */
-#define CLK_DIV_FIXED(_name, _div, _parent)				\
+#define CLK_DIV_FIXED_FULL(_name, _mult, _div, _parent)			\
 	(&(struct meson_clk_info){					\
 		.parents = (const unsigned int[]) { (_parent) },	\
+		.mult = (_mult),					\
 		.div = (_div),						\
 		.name = (_name),					\
 		.type = MESON_CLK_FIXED_DIV,				\
 	})
+#define CLK_DIV_FIXED(name, div, parent)				\
+	CLK_DIV_FIXED_FULL(name, 1, div, parent)
 
 /* An external clock */
 #define CLK_EXTERNAL(_name)						\
-- 
2.53.0

