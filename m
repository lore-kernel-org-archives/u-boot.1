Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E39E606A330
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TsIrajtr;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VPeP6r1j
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0441181D18;
	Sat, 14 Nov 2026 09:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J3WspVhp3wkS; Sat, 14 Nov 2026 09:11:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B459081CE1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794647509;
	b=KXb/iZOEaQIUUQJV7eZ0/9OFMql2jzikZqF/ijHtcGhLZtjRBWUcSV8RvvGskoWceX3Z
	 evnGNfP+hS0HOqlE5NnHX7oSiI9FDUA1yht9/A1QDO09tcpWtqNOFZx6JIm3M+OFPDRKg
	 nlFP1cvmOk3NEihbZHg0eoivooOut4XC4lI2Ewn0krfCKWJ+YKUzv2dJK45Bw9bXwATrb
	 +Cb2tZY9VsiwIpHSU9P/V8AKmNmiqVKKYWrYt+wmDksTVv6hGPVXf9lRfWSOPj5RRGiY5
	 UvNhe1RRFZbKtBZAhQBhN62xYC2zb+PK3sETkUxQMdKAcpI4al8qEi4TWgglPi4cr1A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794647509;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GxNfCZlQPVtO9vjNQRlFWJs4XXbhME89hh4wzpSPmIA=;
	b=R7VnZ0gyB44QwerjduneSqHYnX3HnleqbTYll8LvwAmUq9e2uzuUOlvSL8p9osJe0L7i
	 dmGUx+YbZGw6u0eBZ3C95oaRy6J18wSbegdX5lM4l5dfjP/IpKIqYD55wZFVGdugOJgsi
	 eS24SjEvbfjYqPSFOgQnS6WuTKKp672ka3wd2j6UPiSppJpLc42ENw0zm1AQshD4fFtXf
	 tJjWK1zMtm19fni6ygVo4DcBa4L87Olyb2MnSZxlSxcSq3ELL1MXm08kgCUwTMqQDyIj0
	 yg9VbbFKQ6iuFpn+oy4NbK5yvLfPk1c9+m8UTIs346YK7A5wTcu0PazhJJ5uDUooJ3Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794647509;
	bh=GxNfCZlQPVtO9vjNQRlFWJs4XXbhME89hh4wzpSPmIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TsIrajtr2gAbQBn7eIqRloXDxElm0yYDtvomqsFYAp6kmUZHoiiytFU6HKXm7Iplv
	 VI+r7nbDdLJ96Rmj9W7i+NOLme0G7fZc36+FrfMTo91MgCpP90iVrXK7w35oSaW3/f
	 PEV4euyGEMR3/RtR/cUmWgbWggreDeP9MDgF3oqeiPxQJOhRYPqZaakQ+Gujuy/cl1
	 lboI7SCTO4rX46dvtGNysHbD/I6BZ3UDj0Ay+mYQSkALlrC8dWLAnj49qMMySUMv4h
	 I6MNKUiKUg7vzAj7VUM+1julgQCVqEiU8umzxKjan77J6etF+ZfnJ2fnkgq0R0qOno
	 JmClw7hdZGJKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B459081CE1;
	Sat, 14 Nov 2026 09:11:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B479428C
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A66BC60699
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBzoF0youvol for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 09:11:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 774CF60628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::22f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22f; helo=mail-lj1-x22f.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=VPeP6r1j
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 774CF60628
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 09:11:43 +0000 (UTC)
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-3adfb744fa6so2657841fa.2
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 01:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794647501; x=1795252301;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GxNfCZlQPVtO9vjNQRlFWJs4XXbhME89hh4wzpSPmIA=;
 b=VPeP6r1jiyGYAKAAUWOpiXlG3/9SvV1NAJ2UAm5LvifXyx9kQ2DSHsdTbLJAzKxjPs
 dn28mhRcSiOv5J9XWBmaw2nLWsVHDaYT3rHXvMO6cNzGkgGhbnz+CtyN7aB1KfxGP9El
 VTFzqANk48sdD2htxGBanZtH9rQP0L32NUJ94f7vYblYrpuzRZFw+tVPSO4wBppcleLu
 iYXp52scY7++9BH2g5lsqNVrwJW5Lp3jf5ao94h9qDadaZu08TIFe4VpMjPM6Y7wm/xI
 f2RVoZvcpkGMsPO38vo07JzlIc1TA1i54Rl1tz0rcqWqeFBGHMKf4Wh7Y+/m7fG4ZgyU
 PKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794647501; x=1795252301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GxNfCZlQPVtO9vjNQRlFWJs4XXbhME89hh4wzpSPmIA=;
 b=XWoNT4RzWw2z0tK6TxHlzxE4akpKX606wmzxMRr6/kDbG0qXO9ruwl4f9PjdSZSkJB
 9Hx8D3BHnBXbZb5MaFUm4ah33vUEc6y/ICycoTmytVR4kAe0gmq0ccC6trtoRQfNjqfz
 LzWRFL5PokkwccQT7yjB+tCVJ0rce9EbeepBiRowRiMA6+za0xXuy38Y7yCO4YAhUc6y
 tgmz70h/GwUO7x7jX81Y24zwM+Nf/Nhc8kTiW/fIHEIuzmb9HIjC/hSe0ruICbDagcSp
 cfHViNwgm63q/ptr4kcz8nE9poyjGZB9pfIwa2pqlNWyNrI8DQVhSpa3qdsLdjywLeXd
 6vaA==
X-Gm-Message-State: APuU4Z8S835o8/qJVzO6ZlhnHMfKF1I3IxfT3dg//gBHnpj6b7RhUabK
 RmqmpU61Izam1yw857iSYVXZioLbO06UAeciEPCsF78kvUCG+MGg2XpmrNvLa+OoJaqmKA==
X-Gm-Gg: AYBFou2Jg04AhvykgrtI/dkGf6T5ZWCwG9qzljXYGEBvluZyvnaFeYeGJRGE7t4oKiF
 pQbRXCyrhb5K2/6Xy1xgcw0rgBXSSVDnJB3bgDtJxcxu3NsebE9Swqyt6kulO7aI5mrarXLLEON
 VQnmcnFF2Z6aybLG8GDW3+ANtZ/L2eI6Acu+i2rLM1S/L5YKvsn08jO1Cv+a5PPA5eeP/QWzAdq
 RZw9YGkH9S/J2p2gDGiYMd+KvL8JVHhjXdjYDaIiMH7gJ6ORE++G1Am896cW5gOgdICOtyHKbhm
 ZGP65kskR9mDrZm9zGDA8upDbWc5dpzmcqpaZMtztaPidV4nd4nbI3lLbmHK9ly4TI3hopMTFvk
 GMI2m7Od6V3GS7xqJWMRnSZnRNSCy9Jw21ghzBEzig9ajiZR0pewXyp9Mg7J23BXmtiyMx5kJt1
 CYxrtYAVoMrJrU+hZeR0Ti24cFw0WeoBVRpLVw+wuM2CPvUypz2na/tOX7VHw8JyZZtD5pwkQxb
 9MlrPP1fVIGiRUnOUkHDZ0lR/dUId44U6F8XvOKqyCpUTKm8vDudpug7yK7rPYmtjTQ24xUKg1n
 Y/AyaXPZVKOwtgMs4LpyQwj9YsxUbnjEgZuwix0=
X-Received: by 2002:a05:651c:1028:b0:3ac:e540:987a with SMTP id
 38308e7fff4ca-3ae2b37cb98mr12795291fa.0.1794647500860; 
 Sat, 14 Nov 2026 01:11:40 -0800 (PST)
Received: from OpenwrtBuild.lan ([178.207.14.215])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b7aebd1sm17097191fa.29.2026.11.14.01.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 01:11:40 -0800 (PST)
From: Mikhail Zhilkin <csharper2005@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com, weijie.gao@mediatek.com,
 chunfeng.yun@mediatek.com, igor.belwon@mentallysanemainliners.org,
 jstephan@baylibre.com, GSS_MTK_Uboot_upstream@mediatek.com,
 trini@konsulko.com, dlechner@baylibre.com,
 Mikhail Zhilkin <csharper2005@gmail.com>
Subject: [PATCH v2 3/3] net: mtk_eth: an8855: sync SerDes tuning with Linux
Date: Sat, 14 Nov 2026 12:10:49 +0300
Message-ID: <20261114091049.2418574-4-csharper2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114091049.2418574-1-csharper2005@gmail.com>
References: <20261114091049.2418574-1-csharper2005@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Port the TX FIR (TX Eye) and RX CDR (RX Jitter Tolerance) analog
tuning parameters from the proposed Linux Airoha AN8855 DSA driver [1].

The default U-Boot configuration omits these register writes, leaving
the SerDes with inferior default drive characteristics. On hardware
iterations with minor silicon or trace variances, this marginal signal
integrity leads to severe packet loss (50-60%) during TFTP recovery
over the 2500Base-X link. Explicitly configuring AN8855_INTF_CTRL_10,
AN8855_INTF_CTRL_11, and AN8855_RG_QP_CDR_LPF_BOT_LIM ensures a
stable physical link across boards.

[1] https://lore.kernel.org/all/20261009161102.38961-11-ansuelsmth@gmail.com/

Fixes: cedafee9ff39 ("net: mediatek: add support for Airoha AN8855 ethernet switch")
Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
---
Changes in v2:
- Changed "upstream" to "proposed" and added lore link to match cover letter.
- Added Fixes tag.
- Clarified in comments that TX FIR values are specifically for 2500BASE-X.
- Removed redundant bitwise OR with 0x00.
- Moved the analog tuning parameters to the beginning of
  an8855_port_sgmii_init() to match the proposed Linux driver.
---
 drivers/net/mtk_eth/an8855.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index d06493018f0..c20da4c38bf 100644
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
@@ -434,6 +437,27 @@ static int an8855_port_sgmii_init(struct an8855_switch_priv *priv, u32 port)
 		return -EINVAL;
 	}
 
+	/* TX FIR - improve TX EYE for 2500BASE-X */
+	an8855_reg_read(priv, AN8855_INTF_CTRL_10, &val);
+	val &= ~(0x1f << 24);
+	val |= (0x04 << 24);
+	val &= ~(0x1f << 16);
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
 	/* PLL */
 	an8855_reg_read(priv, AN8855_QP_DIG_MODE_CTRL_1, &val);
 	val &= ~(0x3 << 2);
-- 
2.53.0

