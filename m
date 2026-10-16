Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94369CC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:24:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22B1861052;
	Fri, 16 Oct 2026 13:24:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WLehsaMxyB0F; Fri, 16 Oct 2026 13:24:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F317D61248
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792157062;
	b=IVqO90TqoHMsoafWdVXQvxCPC3wrQ1snPZWc5VR7/rS7lZpcCFYyR0AvQ5XrvwbvPnv8
	 aHa69jeyZ/Zwyfrb6eyoBldZ2N/auYYDLJxVt2hpOkcyabzRbCCxzLzt9n+r4csy8d1Ye
	 mmJUf3HaAbvo+GHToTJncQIIVxHYt7ZluFijeBVVNcdPcPl312p1bS+aoXS0S1pTYeUy7
	 EqNlB3KZ+CwnmyYdSrk/kDlL7Eq32OGnFgCAjcJfzKIsfZqIJ+lcfw4PsAh+CSvUQxLtl
	 BLAMLcOrGy0VV7hPN+uTwnPC1FpxK3QLR0qwdm6L7MGhkLYV1twoWKIpctQB7biWeFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792157062;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=yyWQF35hcWmRxlA01MHKEa5B34AI8NL/fene+IY7BiA=;
	b=tdbv98Rud8ozwJFhdx6RMXgL7jWpdrqGkfgf7LL57TAu8dy1XnsCBuv7qfgH9pR6kSqe
	 sQ1VPSRRJd7eKSy3R0Gk45G03AgkSrcB3HQmsJa6XeYu1sJQK/cbQy/c9Tf1Xtb1InEjz
	 +xky+v5MCy4O8ZGWvdqeNWo/57JK2PgKtmrlIqMqiwVkc/6JDQvhs7yskJxu1RTfpSYwU
	 HJVEkxtTDXR0SAmfHV0SqPyGRxgtzXD6WnK+zmfpqnLLQG/5SdcWO4JN42VAgjNgcRJD/
	 s6acbTVsboZbUyvRmAT/2UKVt9CjCyQGs1rVtY8RSIYUxwvk1bqD47h5G6Xj8JI5DyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792157062;
	bh=yyWQF35hcWmRxlA01MHKEa5B34AI8NL/fene+IY7BiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZcMHHxdCdcJXFJhMxz0xDuUIb29SuOYNJx4Tjiqhvvy6wnnkRj9J1uWcmL0Chuly1
	 oaQZXAIwdjaKi/Ic1n83O/ycNNMNPthtGggpAExXL2FqOVl20kmgu68ldoMp4odpNm
	 8jBsnKUgf3ErqwHf+P1r1AbHPkW4HVEQXgcMTNqZnYVHQQZeKPomGByMjEgCYFxCPy
	 xkkS9l7LXNDGJPhxpNqL5pHh8CzRAfE9fqzuGdxm/FWinOOgnGmH2re0UGqIVuRRL+
	 23RmN/H71xO5vnRBTyI5eNZd2Rj7GBcTiUIZ04krkYeibrR9ha2f77Vj2KJqJbweev
	 HU/euM13GauKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F317D61248;
	Fri, 16 Oct 2026 13:24:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4A81263
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B15C409DF
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCqV7xIxaZIA for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:17:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7C98C409BC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792142227;
 b=F4ixCPWlV6BrZpewrNwSRA9VPnn/SSi4jx9Al4N9YqiatN+U4ZZKtYcS8+UKEAOB/+SS
 sx65yy6fMGD1cL5Z3sYaxSyfz94YpyE9CIy0lmRxEuLqkpxgPPqUSqUGOpdx0/adq5fw1
 tg1/FTcgcl0VIt9OLROpGpRdGSfGcYQPh3fnm2jiE5jaGICJqAF0UkinZadOLuZqyHC7R
 cgaCKaMK827djp8jzu9A+H/2zpI166PZfX8tUNDHg8UBn+14BrFLkOHG0O5fx09M1v9R+
 7VK4jAImfGo4QGQVwXtkCI6LwBLtGsskl+8xae3jZtdDT6MXjgffOmYeCZa9TIgDDJg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142227;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=yyWQF35hcWmRxlA01MHKEa5B34AI8NL/fene+IY7BiA=;
 b=Jwoqn2XdUKmplcHEhJ21MB9queFggllZYgOexcPO4rDtVSoOMhNiD5JftqhsqSErfnx6
 5WtsR/Dr4kVB8X1kK4dWwxH9i2J36to8McgcxexM06Mpx+lQVBgyoaamC3JyXUghYbBVL
 PMhtEJ5dPbqP4sKpypDZJwjO7k6udYLThsWAroalX3O16NVBBE9KFrilmWnA5WiB5kTqd
 +hJbRuoMb61rpf6ShvcRHhjD7NHAwImLpsnFiybLQa+oCCcCoZoYvtcoE6jhHCFdIyKAJ
 7wG9H6wR8Pwf0OEAR3FvzqysXwDW4QCjrti6GT7r5RIS91G8m6rU/uc7y/y68+Ea4qg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=pEtRjEvl; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=pmazzini@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=pEtRjEvl
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7C98C409BC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:17:07 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49e73611928so4843855e9.1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792142225; x=1792747025;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yyWQF35hcWmRxlA01MHKEa5B34AI8NL/fene+IY7BiA=;
 b=pEtRjEvlbam/Ua9jJElKrP/XE0go/hN5KaEOn1UT+otO0seiNol2djcjqzcoiwDOyD
 TPr7MVSaC8y1kL3yEbpsipDaYJYLZSIidrXIAYeMxfGz2fYNTj6i8ackJQf25RtYb5mS
 TzfdDLwpUeiBs4Bnqqr2tURAKIo9+q6nHoqkM9D5CL6Cqe99vKRg8sNhSY4RYUY+tibT
 c+/9kVNwPDiQnrclJlfDcihZzjBh30lp7nItnnX31iWZfstnpjVGG2KfpQsT+dKH7JSP
 zw8N2235qrCesnAm1e+LoBG9kFMZWBw8pdkHcd51AUSVO71220qbVZhAp3CoNn00kgda
 LZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792142225; x=1792747025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yyWQF35hcWmRxlA01MHKEa5B34AI8NL/fene+IY7BiA=;
 b=jDNRMIr0NrhqnHNEfpQw4UP8gjoDoOIJFzlI8vQ7AltzoZlMIkq2QrZcEyPrKrmsrs
 h8N+wjcV9HHyMtgyIyX0SQJ2+YU1Qk89AuvmrUrR7yIz/rK6egHV1MAm0FfM97lUazIB
 ytTaFxpNDa5OG2XB93gBdxhKKMR6e/X8ukVEYnnkNcolK6YYPEOTWsSqTAM6gtpfXQl7
 CqTgpITq6H4YkUUvNyqPWDa2ussntGzcdOT7A0bfJ92rDBx/00Obvl4eyeWl8ikAuKJt
 9Wtd7wiyH/fifS8FYp6KZCOosAWkWFl7N+pfgIVgaS+ZCPJoQn0HdEK5aU5hxT3TDGiT
 frZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJDkgrmDhZ1aV2RQuBfrVjXnKdJe4rku17Kzm7Dk77GDTGLpYk4aWWykPZBA2gLT/nmzo19sM=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIKlQYI9zc8+7AX8VUtKdKS00+9j0iAutTGbq0WhCShEDq0d6Uq
 73+q3sVujPbv1mPedhIvqaoCRoLqMcxGgmPBUPlqsA+H+pY4r4GkSMFT
X-Gm-Gg: AYBFou198F4/PXjfND4BdAIZ8k5CMcqcR3wzLRH+9S+7mQELsDFKryGaa/9K8+CdcL2
 VPRYbP1JPLyYHdOwsFqq5imgdD8sSa13j5dWaB4V46ApmRAU0raUTpkG88+ny4Hkk1u0lQVFqrx
 LprxsVvzGrLppmN3EXuJo4dIvswNR6cdbK4lf4MTUxCxALJYaLQgPMRTXZ+3HmKBZyJOyJ7bPTt
 a2os6tbQl1MVRz/wQi4d6NOw8zHh/pbI5Ll7lSYC3IwI705oSUYKcMbfd0dmX6x6DkO6J0BKkMQ
 r9zGckiAw66+8/V9jM9Gx9F9uymwweVaMOdXXKYs2ze3p2BxQWuqe7prAUikVACyGpZOQTJRXb1
 vwKVJLS4Zj+HoO7gYwF15CK+beIifl18nQyVe0WhOQHzC6grcyYiXBGp19YyS04eWPmcq66bf9v
 XVC21Lf3ry8vZTg033k0qWrzyKe6HjU7V99vc/o7zRtmjKmipizM1f0IkmvAo=
X-Received: by 2002:a05:600c:484a:b0:4a1:bb4c:39c1 with SMTP id
 5b1f17b1804b1-4a1c66cc388mr40791295e9.16.1792142224960; 
 Fri, 16 Oct 2026 02:17:04 -0700 (PDT)
Received: from debian.tfbnw.net ([2620:10d:c092:400::4:7d8a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ee183sm3692331f8f.29.2026.10.16.02.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 02:17:00 -0700 (PDT)
From: Pablo Mazzini <pmazzini@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/7] sunxi: dram: support the Allwinner B288
Date: Fri, 16 Oct 2026 10:16:03 +0100
Message-ID: <20261016091608.121842-3-pmazzini@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016091608.121842-1-pmazzini@gmail.com>
References: <20261016091608.121842-1-pmazzini@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 16 Oct 2026 13:23:56 +0000
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

The B288 has the DW controller and PHY of the H3, set up as on the H5.
Gate training finds its ranks and bus width, as in the vendor code.

Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig         |  1 +
 arch/arm/mach-sunxi/dram_sunxi_dw.c | 97 +++++++++++++++++++++++++----
 2 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ed2402f71f2..0326c7a976b 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -788,6 +788,7 @@ config DRAM_ODT_EN
 	depends on !MACH_SUN50I_H616
 	depends on !MACH_SUN55I_A523
 	default y if MACH_SUN8I_A23
+	default y if MACH_SUN8I_B288
 	default y if MACH_SUNXI_H3_H5
 	default y if MACH_SUN8I_R40
 	default y if MACH_SUN50I
diff --git a/arch/arm/mach-sunxi/dram_sunxi_dw.c b/arch/arm/mach-sunxi/dram_sunxi_dw.c
index 4ed295909ce..ee96186abc6 100644
--- a/arch/arm/mach-sunxi/dram_sunxi_dw.c
+++ b/arch/arm/mach-sunxi/dram_sunxi_dw.c
@@ -21,6 +21,10 @@ static void mctl_phy_init(u32 val)
 	struct sunxi_mctl_ctl_reg * const mctl_ctl =
 			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
 
+	/* the B288 latches the configuration before triggering */
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_B288))
+		writel(val, &mctl_ctl->pir);
+
 	writel(val | PIR_INIT, &mctl_ctl->pir);
 	mctl_await_completion(&mctl_ctl->pgsr[0], PGSR_INIT_DONE, 0x1);
 }
@@ -48,6 +52,11 @@ static void mctl_set_bit_delays(struct dram_para *para)
 	for (i = 0; i < 4; i++)
 		writel(0x6 << 24, &mctl_ctl->dx[i].sdlr);
 #endif
+	if (IS_ENABLED(CONFIG_MACH_SUN8I_B288)) {
+		/* boot0 uses 8 on DX0/DX1 and 6 on DX2/DX3 */
+		for (i = 0; i < 4; i++)
+			writel((i < 2 ? 0x8 : 0x6) << 24, &mctl_ctl->dx[i].sdlr);
+	}
 
 	setbits_le32(&mctl_ctl->pgcr[0], 1 << 26);
 }
@@ -248,9 +257,24 @@ static void mctl_set_master_priority_r40(void)
 	MBUS_CONF(UNKNOWN3, true,    HIGH, 0, 1280,  144,   64);
 }
 
+/*
+ * The B288 boot0 only sets the MBUS window timer: it leaves the per-port
+ * table, bwcr and mapr alone, so no master is bandwidth limited.
+ */
+static void mctl_set_master_priority_b288(void)
+{
+	struct sunxi_mctl_com_reg * const mctl_com =
+			(struct sunxi_mctl_com_reg *)SUNXI_DRAM_COM_BASE;
+
+	clrsetbits_le32(&mctl_com->tmr, 0xfff, 399);
+}
+
 static void mctl_set_master_priority(uint16_t socid)
 {
 	switch (socid) {
+	case SOCID_B288:
+		mctl_set_master_priority_b288();
+		return;
 	case SOCID_H3:
 		mctl_set_master_priority_h3();
 		return;
@@ -430,14 +454,15 @@ static void mctl_sys_init(uint16_t socid, struct dram_para *para)
 	clrbits_le32(&ccm->ahb_gate0, 1 << AHB_GATE_OFFSET_MCTL);
 	clrbits_le32(&ccm->ahb_reset0_cfg, 1 << AHB_RESET_OFFSET_MCTL);
 	clrbits_le32(&ccm->pll5_cfg, CCM_PLL5_CTRL_EN);
-	if (socid == SOCID_A64 || socid == SOCID_R40)
+	if (socid == SOCID_A64 || socid == SOCID_R40 || socid == SOCID_B288)
 		clrbits_le32(&ccm->pll11_cfg, CCM_PLL11_CTRL_EN);
 	udelay(10);
 
 	clrbits_le32(&ccm->dram_clk_cfg, CCM_DRAMCLK_CFG_RST);
 	udelay(1000);
 
-	if (socid == SOCID_A64 || socid == SOCID_R40) {
+	if (socid == SOCID_A64 || socid == SOCID_R40 || socid == SOCID_B288) {
+		/* The B288 feeds the controller from PLL_DDR1 (pll11), too */
 		clock_set_pll11(CONFIG_DRAM_CLK * 2 * 1000000, false);
 		clrsetbits_le32(&ccm->dram_clk_cfg,
 				CCM_DRAMCLK_CFG_DIV_MASK |
@@ -464,7 +489,8 @@ static void mctl_sys_init(uint16_t socid, struct dram_para *para)
 	setbits_le32(&ccm->dram_clk_cfg, CCM_DRAMCLK_CFG_RST);
 	udelay(10);
 
-	writel(socid == SOCID_H5 ? 0x8000 : 0xc00e, &mctl_ctl->clken);
+	writel((socid == SOCID_H5 || socid == SOCID_B288) ? 0x8000 : 0xc00e,
+	       &mctl_ctl->clken);
 	udelay(500);
 }
 
@@ -473,6 +499,14 @@ static void mctl_sys_init(uint16_t socid, struct dram_para *para)
 #define DX_GCR_ODT_ALWAYS_ON	(0x1 << 4)
 #define DX_GCR_ODT_OFF		(0x2 << 4)
 
+static void mctl_set_odtmap(struct dram_para *para)
+{
+	struct sunxi_mctl_ctl_reg * const mctl_ctl =
+			(struct sunxi_mctl_ctl_reg *)SUNXI_DRAM_CTL0_BASE;
+
+	writel(para->dual_rank ? 0x00000303 : 0x00000201, &mctl_ctl->odtmap);
+}
+
 static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
@@ -488,7 +522,7 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 
 	/* setting VTC, default disable all VT */
 	clrbits_le32(&mctl_ctl->pgcr[0], (1 << 30) | 0x3f);
-	if (socid == SOCID_H5)
+	if (socid == SOCID_H5 || socid == SOCID_B288)
 		setbits_le32(&mctl_ctl->pgcr[1], (1 << 24) | (1 << 26));
 	else
 		clrsetbits_le32(&mctl_ctl->pgcr[1], 1 << 24, 1 << 26);
@@ -515,8 +549,9 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 	}
 
 	/* AC PDR should always ON */
-	clrsetbits_le32(&mctl_ctl->aciocr, socid == SOCID_H5 ? (0x1 << 11) : 0,
-			0x1 << 1);
+	clrsetbits_le32(&mctl_ctl->aciocr,
+			(socid == SOCID_H5 || socid == SOCID_B288) ?
+			(0x1 << 11) : 0, 0x1 << 1);
 
 	/* set DQS auto gating PD mode */
 	setbits_le32(&mctl_ctl->pgcr[2], 0x3 << 6);
@@ -535,7 +570,8 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 		/* dphy & aphy phase select 270 degree */
 		clrsetbits_le32(&mctl_ctl->pgcr[2], (0x3 << 10) | (0x3 << 8),
 				(0x1 << 10) | (0x1 << 8));
-	} else if (socid == SOCID_A64 || socid == SOCID_H5) {
+	} else if (socid == SOCID_A64 || socid == SOCID_H5 ||
+		   socid == SOCID_B288) {
 		/* dphy & aphy phase select ? */
 		clrsetbits_le32(&mctl_ctl->pgcr[2], (0x3 << 10) | (0x3 << 8),
 				(0x0 << 10) | (0x3 << 8));
@@ -572,6 +608,19 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 
 		mctl_phy_init(PIR_PLLINIT | PIR_DCAL | PIR_PHYRST |
 			      PIR_DRAMRST | PIR_DRAMINIT | PIR_QSGATE);
+	} else if (socid == SOCID_B288) {
+		/* A 24-bit zqcr value, as on the A64; the H3 quirk hangs */
+		clrsetbits_le32(&mctl_ctl->zqcr, 0xffffff, CONFIG_DRAM_ZQ);
+		mctl_set_odtmap(para);
+
+		/* DQS gating mode 1: gate training finds the ranks and lanes */
+		clrbits_le32(&mctl_ctl->pgcr[2], 0x3 << 6);
+		clrbits_le32(&mctl_ctl->dqsgmr, 0x107);
+		/* the vendor's training configuration */
+		clrsetbits_le32(&mctl_ctl->dtcr, 0xffffff, 0x3087);
+		mctl_phy_init(PIR_ZCAL | PIR_PLLINIT | PIR_PHYRST);
+		mctl_phy_init(PIR_DCAL | PIR_DRAMRST | PIR_DRAMINIT |
+			      PIR_QSGATE);
 	} else if (socid == SOCID_H3) {
 		mctl_h3_zq_calibration_quirk(para);
 
@@ -636,7 +685,7 @@ static int mctl_channel_init(uint16_t socid, struct dram_para *para)
 	udelay(10);
 
 	/* set PGCR3, CKE polarity */
-	if (socid == SOCID_H3 || socid == SOCID_V3S)
+	if (socid == SOCID_H3 || socid == SOCID_V3S || socid == SOCID_B288)
 		writel(0x00aa0060, &mctl_ctl->pgcr[3]);
 	else if (socid == SOCID_A64 || socid == SOCID_H5 || socid == SOCID_R40)
 		writel(0xc0aa0060, &mctl_ctl->pgcr[3]);
@@ -822,6 +871,23 @@ static void mctl_auto_detect_dram_size(uint16_t socid, struct dram_para *para)
 	   3,  3,  3,  3,  3,  3,  3,  3,			\
 	   3,  3,  3,  3,  2,  0,  0      }
 
+/* As programmed by the B288 boot0 */
+#define SUN8I_B288_DX_READ_DELAYS				\
+	{{ 16, 17, 18, 19, 18, 19, 19, 19, 16,  0,  0 },	\
+	 { 26, 26, 26, 25, 25, 25, 25, 25, 20,  0,  0 },	\
+	 { 20, 22, 24, 22, 26, 25, 25, 25, 20,  0,  0 },	\
+	 { 21, 21, 21, 20, 20, 19, 19, 19, 18,  0,  0 }}
+#define SUN8I_B288_DX_WRITE_DELAYS				\
+	{{  0,  1,  3,  3,  3,  3,  3,  4,  3, 11,  0 },	\
+	 {  3,  3,  4,  4,  3,  3,  3,  3,  3, 11,  0 },	\
+	 {  0,  3,  3,  1,  6,  6,  5,  6,  3,  9,  0 },	\
+	 {  5,  5,  6,  6,  4,  5,  3,  3,  3,  9,  0 }}
+#define SUN8I_B288_AC_DELAYS					\
+	{  0,  0,  8,  3,  0,  0,  0,  0,			\
+	   0,  0,  0,  0,  0,  0,  0,  0,			\
+	   0,  0,  0,  0,  0,  0,  0,  0,			\
+	   0,  0,  0,  0,  3,  0,  0      }
+
 unsigned long sunxi_dram_init(void)
 {
 	struct sunxi_mctl_com_reg * const mctl_com =
@@ -851,6 +917,10 @@ unsigned long sunxi_dram_init(void)
 		.dx_read_delays  = SUN8I_H3_DX_READ_DELAYS,
 		.dx_write_delays = SUN8I_H3_DX_WRITE_DELAYS,
 		.ac_delays	 = SUN8I_H3_AC_DELAYS,
+#elif defined(CONFIG_MACH_SUN8I_B288)
+		.dx_read_delays  = SUN8I_B288_DX_READ_DELAYS,
+		.dx_write_delays = SUN8I_B288_DX_WRITE_DELAYS,
+		.ac_delays	 = SUN8I_B288_AC_DELAYS,
 #elif defined(CONFIG_MACH_SUN8I_V3S)
 		.dx_read_delays  = SUN8I_V3S_DX_READ_DELAYS,
 		.dx_write_delays = SUN8I_V3S_DX_WRITE_DELAYS,
@@ -878,6 +948,8 @@ unsigned long sunxi_dram_init(void)
 	uint16_t socid = SOCID_H3;
 #elif defined(CONFIG_MACH_SUN8I_R40)
 	uint16_t socid = SOCID_R40;
+#elif defined(CONFIG_MACH_SUN8I_B288)
+	uint16_t socid = SOCID_B288;
 #elif defined(CONFIG_MACH_SUN8I_V3S)
 	uint16_t socid = SOCID_V3S;
 #elif defined(CONFIG_MACH_SUN50I)
@@ -890,12 +962,13 @@ unsigned long sunxi_dram_init(void)
 	if (mctl_channel_init(socid, &para))
 		return 0;
 
-	if (para.dual_rank)
-		writel(0x00000303, &mctl_ctl->odtmap);
-	else
-		writel(0x00000201, &mctl_ctl->odtmap);
+	mctl_set_odtmap(&para);
 	udelay(1);
 
+	/* the B288 trains with static DX clocks; dynamic from now on */
+	if (socid == SOCID_B288)
+		clrbits_le32(&mctl_ctl->pgcr[0], (0x3 << 14) | (0x3 << 12));
+
 	/* odt delay */
 	if (socid == SOCID_H3)
 		writel(0x0c000400, &mctl_ctl->odtcfg);
-- 
2.52.0

