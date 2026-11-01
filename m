Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA47606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 21:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ov6sM+55;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpzYsofG
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A71E606EA;
	Sun,  1 Nov 2026 21:06:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i52rOruFMkTA; Sun,  1 Nov 2026 21:06:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4420660684
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793567177;
	b=iIIsm80rTMXSh1qpaQGIqaZTxyt9qpGZbTz1LyKKyX7jGOZXvenLNdZnHRAJ591zTZy/
	 iANMlGrrqpl9irNype5A47T5RPXBk9fMrJnsv4aZC5TqhVaOvxbFaCKm6gjmkVKBMdChz
	 IENR4nwhZ66l7YEnMmwQXa/DbSRZbRoN8m3Ss6bviRXZs+KUMWFfn5HGiiFsMh8uLKBDb
	 pXYMA5TYPBq9vORM3BQFlNzkKcUucIK2O7/rNMlwxJ4svgi2UD1QnGkM9TY3kTPO/TkzU
	 uN+/V9GorzB+f1GimRVM/3tl3IOw9hBienQJZv+imEw3uSHkJTHPYv70/HJgIV6H5mg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793567177;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bCp23MpaTUbsCmSmkL6a38NLVoY4tFd3zXwNWRlWAHA=;
	b=ePEY+sFe7/TI6QRRYS8OjqxPXVpuN6aFd0WNtoa9Btt36fy70D8gm/Si4Sqdg2KRnMXc
	 +S6+Y4PnPUqFyEkXVwcrAWzld7D7VyYyBswvZBsIBkvwtWQBJmzpWvH8/lnwaTKBzrNwR
	 sbngfaOJK/kkr3OhZ2kVYOntYRewf/KX315gwcX8nODLEzixqPMMbexiF9N5nXAla4sxo
	 Ng+engbUClACYI3m49j0UpXEZ4zukHEtoqq80zRPP6nSDiN12u43HTnY+R2+PwTUwAv3K
	 v7dI3UaqK/aG23C4rPxFSrLwkERxPo/STJQRT1EV8Jju4+QXu7FaFWWZ2wTG2hUXfCw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XpzYsofG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793567177;
	bh=bCp23MpaTUbsCmSmkL6a38NLVoY4tFd3zXwNWRlWAHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ov6sM+55ICqlUwxbz4qnA1sjDhpod1hNtnx3ZEO/mnFpeorm3Iay4Qm1+Feq+Bv5d
	 NXyOTdzSQifRM1F2if83xFeSoX9Ws7puS2UQtGpSdUlUKunggo7Ca2j1P03wJZGKoL
	 iVQ7NMGI0QGjCbEyA2AFj5Hd33PjX+JrYKLfj18rkldLRulcrOoSsE7rGolvC2Q6R0
	 dYzOFEoBo7QbQpqbp4lsoz5ALNUuuXKAm0gI5m7Azi3UQB1a2DqHND9bLZnYZVqX5i
	 IG8Br2otgTRuhBRGB0Z5VMaj9A7atMQE7sZj0VvRq0eQDLS1mAyfDXe0vFYrtdp0Rt
	 8Pmikpp87/NWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4420660684;
	Sun,  1 Nov 2026 21:06:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1726BEF5
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 08C7360616
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwH3XkRu4huM for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 18:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 459DB6060D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793559308;
 b=a79wlsnk2VhI5fXAEb+BXT0/7kDa7g4CEa+x3H5+CzZenlRxBhqU2orj/9jKrIU2JQNo
 3QsMv9yeL0/xFTEOYEVhUhHaIZEgbeVZ9PgAzfiJrb+sFFqDTCfPjV++jhMOtNFmSLsXH
 itNj9Ri+kOaLMbdWCkerDCTxTmY5+XkVeJDun4fyj5BezkAzcOgo5UvaEZL/yhbuaTVTH
 1SrmIbw4wsVET11pH49eY+quo0JRbo9GPlJHaJUD3SalMD8OGNM4MAqN7X+6hOPV4xuMG
 djqoq4eEPm7An8rPP8WfB18t/lIaAz+XegN0/ZxuBt2hlygpgJ1pkcsly5W7zZjTbsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793559308;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=bCp23MpaTUbsCmSmkL6a38NLVoY4tFd3zXwNWRlWAHA=;
 b=ZV2nl3ACEzzbmLxAMqZFdaBARhHFu4rIqFFdiS3KKQtNH49F4Cd+iK9fIEpFjSYq8pih
 iA55NtgG9pxSTr+KL71NIbvbLX208pjFrzvoLCJokGMISNIlVGxJ9baAtdVCddzChJjTb
 /SP0T1PdE66V4W1X6zufG+WIcvlJtOZyeBTFywWZd58TNOVObzId94q/Rc4wI5qE+0aMy
 BjOO+P7VjDthGfdAz41yzNpoQdMfEeYzAWAq+IrHa48IWigb3THTfqsqB1ZzqjHD38p/D
 EbsBflMFqSXn9neBiAAHa79Rn+nS/Lhj/mzSdu7bSgVCEZEi05LlCtGJr1WZC8FlwMA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XpzYsofG; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132b; helo=mail-dy1-x132b.google.com;
 envelope-from=asai.6265@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=XpzYsofG
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com
 [IPv6:2607:f8b0:4864:20::132b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 459DB6060D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 18:55:07 +0000 (UTC)
Received: by mail-dy1-x132b.google.com with SMTP id
 5a478bee46e88-35b2c599f43so3303618eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793559307; x=1794164107;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bCp23MpaTUbsCmSmkL6a38NLVoY4tFd3zXwNWRlWAHA=;
 b=XpzYsofGdHd34+Ta3kgJnboJ62tV2wz+3BFe3e4Z4Y5Spk29+gwIHpVARlYp/1XGrU
 rLx0ISuUOV1uaxMVwnz20zu8L1m5D/dBZ99Q3EnI5CFfXEfQ+bVBtEtXs23m2tW39t47
 CvWY1DFZmWhWBi3TJ5X09ieAK5CDfkF4MxNoJ0YDXYozrKqZN/ozh8v6sQOHB3xmnQ42
 Km8Ioq3h0kmFToE/76vOH4CDNxx8GpHEe7uA+q+HAAkWtCSdVld+wVUQcyRpXSwdfTt3
 XuPcqGkSSzKP0uOxrRyROWqb+pwuk4T3Ojk38On3wjUjZmPjKRtkL4yq34nn93/il5JQ
 IQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793559307; x=1794164107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bCp23MpaTUbsCmSmkL6a38NLVoY4tFd3zXwNWRlWAHA=;
 b=BJOd6BVaCauWJO90P7MtiUQLJyRmxiMX+0KBWrrhKbWyMt+FxP+/pEpcaDfup5+mSn
 glhakfxeVbSQzNTkEfBms9k0v7VxZW96fr7V3F5cQFP5hOaGBycDEWwgYkPB6UCXwj8n
 u+g/4MX1UKhZuVb6PiXyGkhotEIe+vAKZWpU/aUHSRiH3EgX7SbZSsxUwT/xMj0lIO3z
 ZWLWiL5XdiZXaykdbV1btphoXWDZi/vaAZ/fUO+TW3dt5rT86z9uX3p4ES8mTjgbo3qm
 PK4gDnmWJgyRasel1r/jgV9lc7ugHS6EWpzLPBg6cNZsW7AG4FuslzTIr0MOGPlCQr3z
 TiUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByE1luBS4EX6uOX9GvjSyh7FrZ597ifjvukw9ex/K//nZcdpUaUQRA7NXl5Z15r5Bs/KpnGrtk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9xhEPIa4bVx8RcwSNsoVvW/FwxOKcBs1bmr068UnGkZcSunog+
 kLHILLqxBRG509PDyXVdVkDlOMQpTaSexMWlL9KiLUsMhiWKC6b98gaY
X-Gm-Gg: AYBFou0jm/uHFAQ+bADoDaQDCGc0VSADR2y5hb4tvUmCEa1j2bo5ShWG0jpfeSU0WgO
 q66Guc8Mf4amxoVa6j6HgxT9woRvoe74MogBgrZelgS1Efu3NszhCbOOeLCN+6dJYp92dfyTkT7
 XYvUwvdDmRvJSoEo4AqmssqpLvrtYwxGT1JGALzbH3QoDNMQYaSUyn9rrAf3WAoQVDeDq24YZWo
 MIXHGS59rsM/6T05N/Ye02ecXBM9Oco6LkKor90yCxQ8TU9v59ScR2VXE2gvYIuwzznYfGGjzW8
 BHCGbW51U7ux4YoaFBCXAjbSZ4kO+XAE8rRfABKPyRhBL6wcj/q9M02rQtWS1TpDOrLzwbH3jmn
 fuGYl9pn3Xt58Z/LUkvrEYewRfLd5kmMXDh3H1S0yo1pz/1R7FF4XEEd+W6MIuOP7u41xgiTN8c
 zse9bbmMUQ54yJWpM0RBUuGv1w9Leh/pwqM06rTG2oXL2VX4s/y0ccCrexiOU8LnQX8fmHBv6em
 1o3/pqeE+aVI5Mj/rMTc95mDzUYx2WM10FS+tAtUX/Dv3enTM96YVJ5gvclW3JcIpiA6Cwu26GI
 y1XSx0FyDMuhapkWC8MQ55v32GpsoRbFAxWMisXPtJn86S23ZUVu0wBKIQodmA==
X-Received: by 2002:a05:7300:824b:b0:36a:1c75:8ca3 with SMTP id
 5a478bee46e88-36a4221b3b9mr11500197eec.1.1793559306669; 
 Sun, 01 Nov 2026 10:55:06 -0800 (PST)
Received: from X870E-AORUS-MASTER.kkp-group.com
 ([2400:4053:d960:1a00:6c8d:b67c:1d31:546e])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a6f7f9sm34800309eec.25.2026.11.01.10.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:55:06 -0800 (PST)
From: Shigeaki Asai <asai.6265@gmail.com>
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [RESEND PATCH 2/2] ram: rk3399: Select LPDDR4 tRFCab from MR8 density
Date: Mon,  2 Nov 2026 03:54:41 +0900
Message-ID: <20261101185441.755448-3-asai.6265@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101185441.755448-1-asai.6265@gmail.com>
References: <20261101185441.755448-1-asai.6265@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Nov 2026 21:06:10 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shigeaki Asai <y-asai.0816@docomonet.jp>

The default LPDDR4 tRFCab is 380ns, which is valid for all densities
but longer than necessary for smaller devices, and increases the time
the DRAM is unavailable during refresh.

Once the DRAM is initialized, read the density from MR8 for each
channel and reprogram tRFCab with the JEDEC value for that density,
together with tXSR and tXSNR (tRFCab + 7.5ns). This is done for all
three frequency sets in both the CTL and the PI, before switching to
the final frequency.

Tested on ROCK 4C+ (MT53E512M32D2NP) and ROCK 4SE (MT53E512M32D4NQ).
Both report MR8=0x10 and use 280ns.

This patch was written with the help of Claude (claude-opus-5-5).

Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
---
 drivers/ram/rockchip/sdram_rk3399.c | 64 +++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/sdram_rk3399.c
index 6fa8f268770..fc3c673aff9 100644
--- a/drivers/ram/rockchip/sdram_rk3399.c
+++ b/drivers/ram/rockchip/sdram_rk3399.c
@@ -2565,6 +2565,37 @@ static int lpddr4_set_rate(struct dram_info *dram,
 
 	return 0;
 }
+
+/*
+ * tRFCab (JEDEC LPDDR4) by density per channel, indexed by MR8 OP[5:2]:
+ * 2Gb, 3Gb, 4Gb, 6Gb, 8Gb, 12Gb, 16Gb per channel.
+ */
+static const u16 lpddr4_trfc_ns[] = { 130, 180, 180, 280, 280, 380, 380 };
+
+/*
+ * Program tRFCab and tXSR/tXSNR (tRFCab + 7.5ns) for the three frequency
+ * sets. mhz[] holds the rate of CTL F0, F1 and F2; the PI uses the
+ * reverse order for F0 and F2.
+ */
+static void lpddr4_set_trfc(u32 *denali_ctl, u32 *denali_pi, u32 trfc_ns,
+			    const u32 mhz[3])
+{
+	u32 f, trfc, txsr;
+
+	for (f = 0; f < 3; f++) {
+		trfc = DIV_ROUND_UP(trfc_ns * mhz[f], 1000);
+		txsr = DIV_ROUND_UP((trfc_ns * 2 + 15) * mhz[f], 2000);
+
+		/* CTL TRFC_Fx [9:0] */
+		clrsetbits_le32(&denali_ctl[48 + f], 0x3ff, trfc);
+		/* CTL TXSR_Fx [31:16] */
+		clrsetbits_le32(&denali_ctl[59 + f], 0xffff << 16, txsr << 16);
+		/* CTL TXSNR_Fx [15:0] */
+		clrsetbits_le32(&denali_ctl[60 + f], 0xffff, txsr);
+		/* PI_TRFC_Fx [9:0] */
+		clrsetbits_le32(&denali_pi[46 + 2 - f], 0x3ff, trfc);
+	}
+}
 #endif /* CONFIG_RAM_ROCKCHIP_LPDDR4 */
 
 /* CS0,n=1
@@ -2964,6 +2995,39 @@ static int sdram_init(struct dram_info *dram,
 	}
 
 #if defined(CONFIG_RAM_ROCKCHIP_LPDDR4)
+	/*
+	 * The parameters start with the longest tRFCab (380ns). Now that the
+	 * devices are initialised, read the density from MR8 and use the
+	 * tRFCab it requires.
+	 */
+	if (dramtype == LPDDR4) {
+		const u32 mhz[3] = {
+			dfs_cfgs_lpddr4[0].base.ddr_freq / MHz,
+			dfs_cfgs_lpddr4[1].base.ddr_freq / MHz,
+			ddr_freq,
+		};
+
+		for (channel = 0; channel < 2; channel++) {
+			const struct chan_info *chan = &dram->chan[channel];
+			u32 mr8 = 0, density;
+
+			if (!params->ch[channel].cap_info.rank)
+				continue;
+
+			read_mr(chan->pctl, 1, 8, &mr8);
+			density = (mr8 >> 2) & 0xf;
+			if (density >= ARRAY_SIZE(lpddr4_trfc_ns))
+				continue;
+
+			lpddr4_set_trfc(chan->pctl->denali_ctl,
+					chan->pi->denali_pi,
+					lpddr4_trfc_ns[density], mhz);
+			if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
+				printf("%s: ch%d MR8=0x%02x tRFCab %uns\n", __func__,
+				       channel, mr8, lpddr4_trfc_ns[density]);
+		}
+	}
+
 	/* LPDDR4 needs to be trained at 400MHz */
 	lpddr4_set_rate(dram, params, 0);
 	params->base.ddr_freq = dfs_cfgs_lpddr4[0].base.ddr_freq / MHz;
-- 
2.43.0

