Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57F8606A336
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vHmh45m+;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q/AZ0tfc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A3E5A816EF;
	Sat,  7 Nov 2026 14:33:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DOiIBtj0tlqw; Sat,  7 Nov 2026 14:33:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 76EB38176A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062023;
	b=AGQjp5+fMR7YwZWprRAIGnb0/o8j7w4oVGuEV42dGF1KXyNnRTPbuTDRDDwffA116t99
	 +74KvkbQR56yIKEzVz22QZZCWbe9RpbIwXF505D+0DdDAYcK2m2LUbKPWgGL/yz70cNHy
	 jEj7VW7V9NAfqHkqpcMjD2diuWaogRxnWY41JpxWEMrGmqJYUIor68v8DryjyFjYLk8L8
	 SmXy8I8wm7cC/l1zrq67rtYcvUhIoznT/8SnjLduvGva9mROOQKYZiVRSaa9JLgWSMerN
	 odN+myba6iug5YbYhVydvLiGkDwjUmOLmZqb8dlkp4SKhtxwPkpjJDJUGCPpG6CIJHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=t06n3zStufRsVHk9Us0W7UEKxc5QZ473iEQ3czm/EOg=;
	b=DF3rHVvNNQGABcJNkFLFBxSxTdHWh+wQkxYh28G9Zpj0Qq5HySllpRD/xIlCeYhMlGt7
	 EI2tmH1gc75aOYvBian8l+KXudaacC0wOuty0nHLnOaK7WVUV6hnDCM19nRkj77hDZbk9
	 drYytjifrCXKwSmIlOPV3GELDksHR57VESDCxcKC3WMe80AOr8NGPleP3daG+6RxNn/ec
	 SmfEKHnIwfuwcm541TP4RxoHdoWcEP3Br4wWJAA/GqYpu+sgA/xMMJRQXs2C0MNgi5CBH
	 Xe/35m7Vw4/qgv/A9datFocw4jfKDgJff1/ENEYxXyI2G/4SVdEj5vJOn/+/wbKOlGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="q/AZ0tfc";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062023;
	bh=t06n3zStufRsVHk9Us0W7UEKxc5QZ473iEQ3czm/EOg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHmh45m+dNoJdt5l6ANjfTyU3J2mEQWWsBMBSDlxBTgWFujO9xfmyRZMguwWW/Oyo
	 BHOHkjXAN2AacRTQMEOBbs/xs5HD9rf6TBGdWZ2AeegaGT3KanGx3xgNWsBgV33eF1
	 FGVZ/pMnWHFNzWaqnH2Wz3oAB8SoR5rqbEkLobckufKqHQzCBiUDUw4B0Lulzu+Obc
	 lXioi/8pOB+7qoYm6JvTGMVpl7Qxn4mzj78+kXA1UF/RUgqrY4ukvXlkdK2LS1sWYf
	 sa5HqwiMt4WHhekH54m8LrjXdiOiTB+U0nnOa2cG7BHfYaDgtHvK3lCTRML2NOk5w+
	 r4OXPKftQm9cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76EB38176A;
	Sat,  7 Nov 2026 14:33:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D6F5211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2B1AB81335
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bRVumqJlakaS for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:25:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F1A48130B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::136; helo=mail-lf1-x136.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=q/AZ0tfc
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F1A48130B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:25:01 +0000 (UTC)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5c05727a58aso26060e87.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794061499; x=1794666299;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t06n3zStufRsVHk9Us0W7UEKxc5QZ473iEQ3czm/EOg=;
 b=q/AZ0tfc9MYTcS5BFIyHLY5MdywYdeMV+fLMYu0dEnoWSAW8dKNnz2GkrVUEBQRK7I
 lelV4kSzOVds3rrJbamNx+gofZ2Son4Bp0HbwsFjnNYec66T5L0ZvFWfkZRN974TT9rX
 FtYEbEUBZvLFn1qSm+7yeMoKzltty5EexROLvIbDlaaIpd5mkaip2NpFGOa2y1rGTXc9
 502wxdFTXestiB/2xF+HAVeJrGg9Qkp0pYC8mQjDjDIUqZmmDHxix7jWyXZMwE1hMiDp
 GE0/nRY/gUIe9xBNmp0isazxhD9r9s1zk+DhAvuP25VSSA4t6OcnbBsK3hG36NCld+Fn
 ZeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061499; x=1794666299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t06n3zStufRsVHk9Us0W7UEKxc5QZ473iEQ3czm/EOg=;
 b=cI7mhfbDlhHnvrmEhXHAV7kkro03aJrqMvHrEjT5vp9M5I3ebAvbHKXCLQv0MIstdx
 UXYJ07o0dzZ8t355rOSbjqWe2olb0f+Kk11cT+EQj1BPscuI9xn5Ok/7XYswgtc+80aL
 uUrXuYYBD7rxPGtYMPiZktKOdulMg0/cOTZSS7gRVYdVQCKYARudJ4Jd6m+N1C0DE3h5
 ZNkZeM3AK3R7Nk9bECmTUs+4j39qweJnnOXN8gIF9fwSr/NVslHtJgmK8bWKyNvKMjLd
 97/TqERSmshLJA6dFuF1wzcWfxgFvW/fSktzrwZw1WO9OyfxoegUkqqlTTcurhaYhgHC
 CHjw==
X-Gm-Message-State: APuU4Z8yW0djYc7YjGkb/i2VKYnHHi8MkkHbfJAdVdsv1LTLYAKvOuvV
 BJTh3SWyPmvwbd/+HkDcPcfRm7Xn7NOw5hS4YPNLZb+fyHbYKMl6PpGuPu1bugQdF1OkRTiN
X-Gm-Gg: AYBFou1LRWtR0yOB1Jd6iNun85pEpNVryRBdfs9UV/3GGKKvKyDMtbjJkzqypgbY6wv
 oBlLxHWp7AtQk1NvlYk/p7dml6ea54+K8XIghnWBgVBRXPpNZomYmSFK771n0EwPKjvPJ6Ico9t
 r+R5RrYnl5t8TSJqyidBNCIavlRMNyExrhkqn0TW+KlA0nhClG+uRXLT8xGzbpHdGP78FQWac/y
 I8HVN26CE6lKb45R2DxuhG9z2gwHp1YRHoNtvmS7mwk+6NfIoun+JkfW7aD3ZWQkX9xADRPDGT3
 B4lT7deyE7fzfDH6dN4m3ChoQzfS4SQSJfelTiusE8nzRyDKWg8MW7TQwXIkw+AjN8RieGDKlVW
 8k0axl8ji+60Wlzw0EMWif3FPra6Tp9x2XmqXxKWtRrkyIVPQnsvrwz1R8RrsASOkYfQ3L23VUp
 Zq6OBAlVA+YSoHAGHv2tnk8zrNaw9+pcYUAEIYDsdeLA6m2mmt/fSzWtVwfxiqnGp91O68+TpDy
 PIRfTvjIjtDIFSIpsayba7B0NSJENgcPmrPjEhQ8TbrhDJC8XQnHqj5jqlohIz22L8BeqFL6UY/
 eZ+2bYSjahbeY2FkWbea27dIb/Gost32+GBMjGoRx4AGEketE0B/a8vUWnCm
X-Received: by 2002:a05:651c:c01b:20b0:3ac:e4af:b18e with SMTP id
 38308e7fff4ca-3acf3a04696mr10286181fa.2.1794061499276; 
 Sat, 07 Nov 2026 06:24:59 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3acf60c9cf4sm7125971fa.36.2026.11.07.06.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:24:59 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 dlechner@baylibre.com, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v1 3/3] net: mtk_eth: an8855: sync SerDes analog tuning with
 Linux driver
Date: Sat,  7 Nov 2026 17:24:40 +0300
Message-ID: <20261107142441.2104669-4-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107142441.2104669-1-csharper2005@gmail.com>
References: <20261107142441.2104669-1-csharper2005@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Nov 2026 14:33:29 +0000
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

Port the TX FIR (TX Eye) and RX CDR (RX Jitter Tolerance) analog
tuning parameters from the upstream Linux Airoha AN8855 DSA driver
(drivers/net/dsa/airoha/an8855.c).

The default U-Boot configuration omits these register writes, leaving
the SerDes with inferior default drive characteristics. On hardware
iterations with minor silicon or trace variances, this marginal signal
integrity leads to severe packet loss (50-60%) during TFTP recovery
over the 2500Base-X link. Explicitly configuring AN8855_INTF_CTRL_10,
AN8855_INTF_CTRL_11, and AN8855_RG_QP_CDR_LPF_BOT_LIM ensures a
stable physical link across boards.

Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
 drivers/net/mtk_eth/an8855.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index 513f4534701..f8f004e0914 100644
--- a/drivers/net/mtk_eth/an8855.c
+++ b/drivers/net/mtk_eth/an8855.c
@@ -96,6 +96,8 @@
 #define AN8855_SS_LCPLL_TDC_PCW_1		(AN8855_QP_PMA_TOP_BASE + 0x248)
 #define AN8855_INTF_CTRL_8			(AN8855_QP_PMA_TOP_BASE + 0x320)
 #define AN8855_INTF_CTRL_9			(AN8855_QP_PMA_TOP_BASE + 0x324)
+#define AN8855_INTF_CTRL_10			(AN8855_QP_PMA_TOP_BASE + 0x328)
+#define AN8855_INTF_CTRL_11			(AN8855_QP_PMA_TOP_BASE + 0x32c)
 #define AN8855_PLL_CTRL_0			(AN8855_QP_PMA_TOP_BASE + 0x400)
 #define AN8855_PLL_CTRL_2			(AN8855_QP_PMA_TOP_BASE + 0x408)
 #define AN8855_PLL_CTRL_3			(AN8855_QP_PMA_TOP_BASE + 0x40c)
@@ -113,6 +115,7 @@
 #define AN8855_QP_ANA_CSR_BASE			0x1022f000
 #define AN8855_RG_QP_RX_DAC_EN			(AN8855_QP_ANA_CSR_BASE + 0x00)
 #define AN8855_RG_QP_RXAFE_RESERVE		(AN8855_QP_ANA_CSR_BASE + 0x04)
+#define AN8855_RG_QP_CDR_LPF_BOT_LIM		(AN8855_QP_ANA_CSR_BASE + 0x08)
 #define AN8855_RG_QP_CDR_LPF_MJV_LIM		(AN8855_QP_ANA_CSR_BASE + 0x0c)
 #define AN8855_RG_QP_CDR_LPF_SETVALUE		(AN8855_QP_ANA_CSR_BASE + 0x14)
 #define AN8855_RG_QP_CDR_PR_CKREF_DIV1		(AN8855_QP_ANA_CSR_BASE + 0x18)
@@ -678,6 +681,28 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
 	an8855_reg_write(priv, AN8855_MSG_RX_LIK_STS_0, 0x01010107);
 	an8855_reg_write(priv, AN8855_MSG_RX_LIK_STS_2, 0x00000EEF);
 
+	/* TX FIR - improve TX EYE */
+	an8855_reg_read(priv, AN8855_INTF_CTRL_10, &val);
+	val &= ~(0x1f << 24);
+	val |= (0x04 << 24);
+	val &= ~(0x1f << 16);
+	val |= (0x00 << 16);
+	val |= BIT(29) | BIT(21);
+	an8855_reg_write(priv, AN8855_INTF_CTRL_10, val);
+
+	an8855_reg_read(priv, AN8855_INTF_CTRL_11, &val);
+	val &= ~(0x3f << 0);
+	val |= BIT(6);
+	an8855_reg_write(priv, AN8855_INTF_CTRL_11, val);
+
+	/* RX CDR - improve RX Jitter Tolerance */
+	an8855_reg_read(priv, AN8855_RG_QP_CDR_LPF_BOT_LIM, &val);
+	val &= ~(0x7 << 24);
+	val |= (0x5 << 24);
+	val &= ~(0x7 << 20);
+	val |= (0x5 << 20);
+	an8855_reg_write(priv, AN8855_RG_QP_CDR_LPF_BOT_LIM, val);
+
 	return 0;
 }
 
-- 
2.53.0

