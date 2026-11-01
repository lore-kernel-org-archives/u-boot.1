Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDDD606A327
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AVT4/Rlf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=SxzGZHES
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B231280D88;
	Sun,  1 Nov 2026 17:31:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uIyz4A0h9IQs; Sun,  1 Nov 2026 17:31:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6238980D80
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793554269;
	b=Y35AAl7AJibL+I5CgDvPdLvEVOmtg0+SWmbZMdSCmIcYuHh+AZ3dSZadvB3Zmc+SipXB
	 Z1u8LnGtx+hlgShAKJt/dFeoKv5Am1QYRCk9rGRxjjHNIfhC2kL9pxi+Ux5sFbf3JCtfW
	 ApoOtFS9r3IVKaiQeQ2cvi5q59YvVv5sjid5T5PILe3hIt/OieXXhuQtFGInbCGWmmiib
	 r7gOpWowG5BUaQjQWBgkNJGvfQejjySm/OvqefllNbCLXqYWMywAkWLTefM7qAcyj9H69
	 RbfnlqqlXgkLIubzMfVq7Vi/Mk8THXpC4dWMpfYjmWLBKX+JTrTupN6Yazk70lv+FoA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793554269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BfXS7x8lhZHLo18jQCvJ9K386orDegFjuz20QERtBZw=;
	b=qJYJxe9r+xgpz6mbik5RHIITp++ChFkYDufqNGoq5xpTgcJlOXSWG4xV1Ulutc0lmJcf
	 nSBC2l27LMx/N76yZTO7t5AzFxUygs7XF7IbLj0ZRZMD/7up+OQx5YFRJGJgb6n5JMxe6
	 lJPr89xI/Csd2bknTd+n+vejJYpB3OcE8lQ+ckmz0sZKKjmLwcE1knTBYmCEGO2ZRn7K5
	 LKx+3CsTIvAu5K3ZZoMNC6i1bKSNYYh63OGWOHy01rQwlPPlFSZ5GXoD8O76F9eiBJ82c
	 1QhpJWOsAgbILrwK6PqfShV3KJwqFxFp9G5J2dBK47Cjj3x6UT9GNvsPAEDQ/SHHn9g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793554269;
	bh=BfXS7x8lhZHLo18jQCvJ9K386orDegFjuz20QERtBZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AVT4/RlfgjnsOlyfHBXoTskBhgp9QP00UiIJTRKQmDo597qynlbMiDso670RQvi5N
	 LqcX3ccY2HRb7Q6LjjrhFsyez7r+LezeGdjGWi1GrTjXzT9Rku3oqELV6WrM0WBeQP
	 hOttFUqoaHP75vJYgTnQ/sT+HF0Qqbo7RZY1e6Lkz1WcmUrUPx90G4YP362nrUzFlt
	 huARc3xwdbdsVYroYPV1ZfW7MKfTuzbiXXcdW6kQV1HFsrT9FxiBERVZil58JUpPMG
	 SNsnwjN+oEYM3X9MTxbvW/bG4NKlUiiSJnRvOdnijoPaj+n2UXqI0ovGC/c7QHkFji
	 21zT4sR9ZQ/TQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6238980D80;
	Sun,  1 Nov 2026 17:31:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E67363A7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D7D576065A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lS4m9qgab7yD for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 17:31:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1821605DE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=153.128.190.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793554266;
 b=HwQ9QS7kjV3zAfKrD+J4XugBMGTsSiJnoN54kCDzEd8TxZ4++qXc1jRdqFk1Mg8VqQx2
 goo+fJngJklN00jLAGphH8NKxutnt9Ph0965Bp4pGmdxb/4NKFT+5+tGJU24txXLGP1hz
 Fyqimqr4dZaf0E/Wv2+WYxzz0Zg+A4pOrLGCWyS5ZR2HJSkWEIb4XeSIUqTBvlU/DUNUP
 7TL0nxWa90yfbF5t2dj8WzzLGbzdkNH6sgQWoRFXDW6BEfHWscNhFqFn6aHVBw1qb/uWZ
 IqVyrHAssdM1nwIbnsO2OtnQ9E2lFPtpzOkFaXys6OR2UG/kGRzhqpFdm5TefoYg+og==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793554266;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Received:
 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding;
 bh=BfXS7x8lhZHLo18jQCvJ9K386orDegFjuz20QERtBZw=;
 b=Kd3jjqUJfyx9HL1UI2S1euhPOC0JbbV6zP5h39lbm0VtxfRkhq3MYfeYwiMaTVW+FuTR
 bhG6Usl80nnaHNaYpCK3GK6WSxW6u2P4YwBeG+sAMvW6BnYycOpxGarR+2WmPah5ZNzK8
 nFWm94SwINCatC1rPcyVK0eFidjLI8nD+SnY3jzZqBaLgVxoEP8uQRH8v+sk1OlKWFngd
 Sx1Vnab43j7dalalBjmtEQ/fmrZYvmRVPjES2jetZr8aKeDhfndN92C8JrnSDtbmr37KD
 IltH1IftWunTxYJnXYEXNdIQE/FSu63zznC+S3xPIKRl8JK5mW9FamVCB157ZbrvcOA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=docomonet.jp;
 dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=SxzGZHES; 
 arc=none smtp.remote-ip=153.128.190.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=153.128.190.131;
 helo=ocn-dfr-mts-113c2.ocn.ad.jp; envelope-from=y-asai.0816@docomonet.jp;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=SxzGZHES
Received: from ocn-dfr-mts-113c2.ocn.ad.jp (ocn-dfr-mts-113c2.ocn.ad.jp
 [153.128.190.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C1821605DE
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 17:31:05 +0000 (UTC)
Received: from ocn-ckd-mts-116c40.ocn.ad.jp (ocn-ckd-mts-116c40.ocn.ad.jp
 [122.28.98.105])
 by ocn-dfr-mts-113c2.ocn.ad.jp (Postfix) with ESMTP id 64AF51C000087
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 02:31:02 +0900 (JST)
Received: from ocn-spm-mts-107c1.ocn.ad.jp (ocn-spm-mts-107c1.ocn.ad.jp
 [153.128.190.238])
 by ocn-ckd-mts-116c40.ocn.ad.jp (Postfix) with ESMTP id 22D1B64000BF4;
 Mon,  2 Nov 2026 02:30:56 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1793554256;
 bh=tVOGFXe/BXC5uRtCq8HFoYZuVcy22tILInLE71i/U4w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SxzGZHES8HvDcN77wnkoZJoxb06PM+uCMZI+lG93gwS2xwgjezb/Le3AJFWedgdr0
 PW4BAWHlQtkPah1AlpX58vHI91SViXKHZIJQf5erVeZN2faR5awWru+p3hzq70V/M8
 vW/Jd8wz8o6G6DTQNqFRIPQuZeWvmJL/JklIBQAQ=
Received: from ocn-vc-mts-111c1.ocn.ad.jp ([153.149.236.164])
 by ocn-spm-mts-107c1 with ngmta
 id 9f740bd2-18e3fc17dd5d2489; Mon, 02 Nov 2026 02:30:56 +0900
Received: from ocn-sdpx-mts-113c1.ocn.ad.jp ([153.128.117.211])
 by ocn-vc-mts-111c1 with ngmta
 id 4bc49240-18e3fc17ca03adf3; Mon, 02 Nov 2026 02:30:55 +0900
Received: from X870E-AORUS-MASTER.kkp-group.com (p3688129-ipoe.ipoe.ocn.ne.jp
 [153.238.101.128])
 by ocn-sdpx-mts-113c1.ocn.ad.jp (Postfix) with ESMTPA;
 Mon,  2 Nov 2026 02:30:55 +0900 (JST)
From: Shigeaki Asai <y-asai.0816@docomonet.jp>
To: Kever Yang <kever.yang@rock-chips.com>, Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Shigeaki Asai <y-asai.0816@docomonet.jp>
Subject: [PATCH 2/2] ram: rk3399: Select LPDDR4 tRFCab from MR8 density
Date: Mon,  2 Nov 2026 02:30:43 +0900
Message-ID: <20261101173043.755222-3-y-asai.0816@docomonet.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261101173043.755222-1-y-asai.0816@docomonet.jp>
References: <20261101173043.755222-1-y-asai.0816@docomonet.jp>
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

