Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCA606A327
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 12:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DrOKSbYC;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=iVQrtBaa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6129C80F30;
	Mon,  2 Nov 2026 12:13:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CyeSOP_zbru4; Mon,  2 Nov 2026 12:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5514980E11
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793621608;
	b=ICmwLmW3EiumEqQtbw3MF+K5BZ+lu/fy8jsfDgS4JWOZKLEGkDr2tY4h+GoZ7eJx+3Jq
	 FS8+DsO8ZOYg+etpPLoW4F1DyKdF6Vwp5IhMQF7IWpJRcxxMeFSJujOc5F93g60G0sWZZ
	 1DVGKUNjMsv50TzORvNj9JR/g5gKWFPgWYuON9FGricRZVnOoitdnOvnDXAaL8d2iVUaP
	 Ej2T0frsGDIou7Lyn3QGEji5/9HiEnHeL+++fCdTqL9mP2ZJyoqATw2ux5B/G0upI6cyn
	 JfJCm2a6Yw0XrxKZlZ9QJ0tpjpV2nShP7MGHz05MmlJLpxPOQ47tcjfnbK9Vevws8xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793621608;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XDLTpXiBS81eFAX8sLptAnXrY24fpZsZlonysQ7MPF4=;
	b=tP5QxUoEpVnHXAYEO3vy2oxticf08fj1a1KgBFx2hMNQP2LV/yrQKRg9FW/qR4d6Afeb
	 RlBzRfcBszN6jkC27QE0j7VWgM7zrrfVAKD4ZnYJFvykvasgBre7l4M2rl6IbAdzI+lhh
	 Sp2R/FISjrnj9ubVsUE9Ub2xQcasF2TIMKfVWFwQObtGN69ZCRkj6TOoaXc9NDW0zZcmF
	 ifF+mh9jssFTKGWCX9OOgDcAE37fGRFJCttzu9CJBdyO+d8w8pC/2vqga3uActJkbG6Fo
	 16n2rBxYceENGqfk2xT+ZpNGd6NDjtwwhYQAhtNM04l0wZO7Wdbg+j66ddhH3ylqPZQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793621608;
	bh=XDLTpXiBS81eFAX8sLptAnXrY24fpZsZlonysQ7MPF4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=DrOKSbYCIf10Mny1wjzibm7sZij/E6+IwVz8aDzJ36Wv/FR26paN0BnE2iw4BGVYR
	 5SQblwROY7s3dPha+qG21Dbf9pnKYAYH70/BL+JAdcgVL9/ZiZJ4eDM5NYNEf5dtcu
	 riOjlvihoZYU+RiODB9vy3jo0uj8gT+otL1pCRQgTvSA+1cuXlH9gULApf3MTK6Q82
	 FpVLnL0yZ8NtGLgs1Llj+IoObffmdHj4UhQJmGp4jz5yXzSLuo6P66Tcvs74EsfZpu
	 Reg8yNycu419JcE5+jQVI60vfWd/1MDcdC16ZcWTiyQB6Bgd5xEW/0BWMd7siArZYe
	 GLG0Z+8rT8Mnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5514980E11;
	Mon,  2 Nov 2026 12:13:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 50C6D4BC
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 12:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42590605FA
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 12:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IoVle58dJmcu for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 12:13:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1034960661
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793621605;
 b=Y38Zk2z/bf/s8kwk5Z1at8baVYmPf3cY3ISMjMPXWUci5Ufc4MFmM5uDaO35Xlo0yOLS
 NIj2liFpuDiignbkELP3bNjxfsG+lVp1qBea+gi5NgjW84UZHb9u5gTw0rNHNEUkAgBwb
 UC7U4XzeXmiw8AkgjxOgbTxH6Cq5ZlULlw43/n7WYC4aA0F02aRrdi2HJ0THnGprXQVsC
 +k6CcGkRfnPNsYtRs5C/vXiX7qROhG9gN1DUjuhCFqFJi19Jz5aI+dnF4qGfo6KZ8if/0
 pkSYwcjOyF+ojC7zvYApA3nJ/0zMGXkzp7sDaIFK3ij6McNI3jZ0PYxzxjyH0g55oWA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793621605;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=XDLTpXiBS81eFAX8sLptAnXrY24fpZsZlonysQ7MPF4=;
 b=CsYrU84NG6GMfkaLfjCJehLuriYAR9pCfkbc88eyFGofGzLWIhMogA+tftW6HBDhAlS6
 2FbQPG+cN31LugRCeBqbbvdyBrn05JFRBanl2fV1zVGbn+U1vLhcRuppWgVq7leOK9qyP
 7QZYCRCeWph5iziLRta4j7OuiRUByDWAGg7Xiv903BW16RfNBdoY9iRE80vCiCZz5MSFq
 fN9II9NQfoWmt2q4PVAj5kIpX9Ftuq7LZNQqgLWsTj4ALIIw7hf94uNtGxqls/joPkNDk
 9Choj6qH6GISau6j6qcd6d73DQJYLHV2r5YytVbWVFwUTvjHuRI59XnmCbkx2J7bOVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=sartura.hr;
 dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256
 header.s=sartura header.b=iVQrtBaa; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=robert.marko@sartura.hr; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256
 header.s=sartura header.b=iVQrtBaa
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1034960661
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 12:13:23 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso19228465e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 02 Nov 2026 04:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1793621602; x=1794226402;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XDLTpXiBS81eFAX8sLptAnXrY24fpZsZlonysQ7MPF4=;
 b=iVQrtBaak32X5yGONAvW8gVsK4X94gTJqe2/Pjy07lIniJCyRweFQN84hP3+kKc8bx
 pCb2Ffhe2QwoEQn7VuuuPmgJYy7UGNpu9AkWP9ozu/kk/ERjfpmg8gJk+dmmhrRwCbMA
 dbP9cAwlGp5XEv8wdJVelF/WK3ETkYvatQRd8vtrAE0V00ZRY/7XEyaaN0slBT9L/IjM
 V2P+YwYwBN3p+s4uuYIu9FX10cGNhfHlcGgVL5ELkv88UexGRXst/nBGb1HpyznZBVBC
 UEoj+zQRf6XOqhiuwHqVTxAW/+Jq+bTLXgdci+tX9vtzHcHULvzQ+3afzZXzTvb1UI/V
 +9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793621602; x=1794226402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XDLTpXiBS81eFAX8sLptAnXrY24fpZsZlonysQ7MPF4=;
 b=SfYZF6LdXQ/eQSHnh7bFBYk7m9KsRinX//XqBgV2/cZsMpEeXIKwHuZf7aRcMZOVSb
 K9u38rnO16Rhl4LpEc31m/GETEJtmUd4SwU5VBI1pYoUlo2EsJS5kQqKyrKkj7qKjUuq
 8vnvyJugz4Q9mWPj2uQ9cC6P2zvCqhJk9CHNRaQG/9I+6foVs7FEaIQyXFm+qFC3JZnx
 hsLWggWI18GH+BcFgXdJz+vPSafdsE6E3BUC480L1WtK9RIQIgNfpI4rDQAE9iPagwMV
 s2I6n56JpBCmv2nhDCSCGe/+C0u7RG8BAnRvJgfzzXdYJ50Jd/L60fx6xuqaYc3ihvSc
 dJvg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6ZA/xDOIrWwpAFs1YTA3yUp5vuArrX6PnZ7s6ZbuugHmQAet+vsT+Iix9W9EOIswH5zPQJl8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKcMzOWitHGy0Uzvg/p2XQ/GE9RtLahesd3He4sxzUo+MDEbwPq
 3eWKxGRy3Dck/1ffYTy5x+Lvpsaw86oky2pKXMwh0QpMjJ/kFVMa94oxdxwYQoDY2qM=
X-Gm-Gg: AYBFou3+txGIptyMrg6ljzCuVpR7EqfJImq3SCdC5+vzn4lFiJ1GuUgwjDxvVGPEF9P
 69ChUrweU3Md73Gef1tHswFf+XUm8ZrBiubC7z9kJ1dZYrVyp8cnpSPEek1+lt+7KLl7qvV1HlE
 BNXlTbSYeiDC+9CYd1ta0GGdJN4RspMOwyQrlU6PcQr9U+zG1Ft/ictJTD26MD9Z8sziYnW97Ao
 uUQ+7dmaanSbLHAo4NsxdkySPwobuWj2AfzTmbBL7e8fpYRHirwBnQUJJnPmttuWK3+gRklOhVx
 A8q83Z+5H5hAgzmIVAHP/Xe51UvGj23q+iJCCYO7Z6I1JpwLfgteQ7fy8kQcRE2mbAuOpGkCELN
 z1WX58HqxCMVPTfV7OhxAmUn4AdBs2HHKvDCNRFquJ0GwaisCU7llz2+dSL8dwxu3ZIKiLQ3O2B
 QknpVkV7UVLqlxxveLqVILxur1KwqlzDJfUzbNgRaxfW+j1k6nT6EThZCo4oPUToCdQoZqtOgyi
 XREvdZ1vT/j3yXQN9QUiJnSyQXgxs13FsBZQkGqxZC/wOzRYnUkZNj78/4OwXTKyhlRyGH/+xXQ
 vJte1Kax0PrU0soWQ34A7psTh337vngeAOlcOzhiGQmBTFKtzbyRCRRetnZs1fl86XUXLs95g/3
 iONbU6+2YroX8MkWJ3CBwrEgepOlZWOjPPsE8zd3AtvtVdV7bBrVO5w+R
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id
 5b1f17b1804b1-4ac1793fb5emr229503705e9.15.1793621601636; 
 Mon, 02 Nov 2026 04:13:21 -0800 (PST)
Received: from threadripper-fedora-workstation (dh207-14-52.xnet.hr.
 [88.207.14.52]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09fadb75sm178199445e9.3.2026.11.02.04.13.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:13:21 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: jerome.forissier@arm.com, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, Manikandan.M@microchip.com
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH] net: phy: SMSC: add Microchip LAN8841 support
Date: Mon,  2 Nov 2026 13:12:29 +0100
Message-ID: <20261102121310.460070-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
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

Add support for the Microchip LAN8841 PHY.

It provides fixes for erratas, as well as support for enabling the required
RGMII delays based on the PHY mode.

It is based on the upstream Linux driver.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/smsc.c | 182 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index 0d823f5f2b1..789b8593093 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -10,6 +10,178 @@
  * Copyright (c) 2006 Herbert Valerio Riedel <hvr@gnu.org>
  */
 #include <miiphy.h>
+#include <linux/bitops.h>
+
+#define PHY_ID_MATCH_MODEL_MASK 	GENMASK(31, 4)
+#define PHY_ID_LAN8841			0x00221650
+
+#define LAN8841_MMD_COMMON_CTRL_REG	2
+#define LAN8841_RXC_DLL_CTRL		76
+#define LAN8841_TXC_DLL_CTRL		77
+#define LAN8841_DLL_ENABLE_DELAY	0
+
+#define LAN8841_MMD_TIMER_REG			0
+#define LAN8841_MMD0_REGISTER_17		17
+#define LAN8841_MMD0_REGISTER_17_DROP_OPT(x)	((x) & 0x3)
+#define LAN8841_MMD0_REGISTER_17_XMIT_TOG_TX_DIS	BIT(3)
+#define LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG	2
+#define LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG_MAGJACK	BIT(14)
+#define LAN8841_MMD_ANALOG_REG			28
+#define LAN8841_ANALOG_CONTROL_1		1
+#define LAN8841_ANALOG_CONTROL_1_PLL_TRIM(x)	(((x) & 0x3) << 5)
+#define LAN8841_ANALOG_CONTROL_10		13
+#define LAN8841_ANALOG_CONTROL_10_PLL_DIV(x)	((x) & 0x3)
+#define LAN8841_ANALOG_CONTROL_11		14
+#define LAN8841_ANALOG_CONTROL_11_LDO_REF(x)	(((x) & 0x7) << 12)
+#define LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT	69
+#define LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT_VAL 0xbffc
+#define LAN8841_BTRX_POWER_DOWN			70
+#define LAN8841_BTRX_POWER_DOWN_QBIAS_CH_A	BIT(0)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_A	BIT(1)
+#define LAN8841_BTRX_POWER_DOWN_QBIAS_CH_B	BIT(2)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_B	BIT(3)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_C	BIT(5)
+#define LAN8841_BTRX_POWER_DOWN_BTRX_CH_D	BIT(7)
+#define LAN8841_ADC_CHANNEL_MASK		198
+#define LAN8841_PTP_RX_PARSE_L2_ADDR_EN		370
+#define LAN8841_PTP_RX_PARSE_IP_ADDR_EN		371
+#define LAN8841_PTP_RX_VERSION			374
+#define LAN8841_PTP_TX_PARSE_L2_ADDR_EN		434
+#define LAN8841_PTP_TX_PARSE_IP_ADDR_EN		435
+#define LAN8841_PTP_TX_VERSION			438
+#define LAN8841_PTP_CMD_CTL			256
+#define LAN8841_PTP_CMD_CTL_PTP_ENABLE		BIT(2)
+#define LAN8841_PTP_CMD_CTL_PTP_DISABLE		BIT(1)
+#define LAN8841_PTP_CMD_CTL_PTP_RESET		BIT(0)
+#define LAN8841_PTP_RX_PARSE_CONFIG		368
+#define LAN8841_PTP_TX_PARSE_CONFIG		432
+#define LAN8841_PTP_RX_MODE			381
+#define LAN8841_PTP_INSERT_TS_EN		BIT(0)
+#define LAN8841_PTP_INSERT_TS_32BIT		BIT(1)
+
+static int lan8841_config_rgmii_delay(struct phy_device *phydev)
+{
+	u16 rxcdll_val, txcdll_val;
+	int ret;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		rxcdll_val = BIT(14);
+		txcdll_val = BIT(14);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		rxcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		txcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		rxcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		txcdll_val = BIT(14);
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		rxcdll_val = BIT(14);
+		txcdll_val = LAN8841_DLL_ENABLE_DELAY;
+		break;
+	default:
+		return 0;
+	}
+
+	ret = phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+			     LAN8841_RXC_DLL_CTRL, BIT_MASK(14),
+			     rxcdll_val);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+			      LAN8841_TXC_DLL_CTRL, BIT_MASK(14),
+			      txcdll_val);
+}
+
+static int lan8841_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phy_interface_is_rgmii(phydev)) {
+		ret = lan8841_config_rgmii_delay(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Initialize the HW by resetting everything */
+	phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		       LAN8841_PTP_CMD_CTL,
+		       LAN8841_PTP_CMD_CTL_PTP_RESET,
+		       LAN8841_PTP_CMD_CTL_PTP_RESET);
+
+	phy_modify_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		       LAN8841_PTP_CMD_CTL,
+		       LAN8841_PTP_CMD_CTL_PTP_ENABLE,
+		       LAN8841_PTP_CMD_CTL_PTP_ENABLE);
+
+	/* Don't process any frames */
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_PARSE_CONFIG, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_PARSE_CONFIG, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_PARSE_L2_ADDR_EN, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_PARSE_L2_ADDR_EN, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_PARSE_IP_ADDR_EN, 0);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_PARSE_IP_ADDR_EN, 0);
+
+	/* Disable checking for minorVersionPTP field */
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_RX_VERSION, 0xff00);
+	phy_write_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+		      LAN8841_PTP_TX_VERSION, 0xff00);
+
+	/* 100BT Clause 40 improvement errata */
+	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+		      LAN8841_ANALOG_CONTROL_1,
+		      LAN8841_ANALOG_CONTROL_1_PLL_TRIM(0x2));
+	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+		      LAN8841_ANALOG_CONTROL_10,
+		      LAN8841_ANALOG_CONTROL_10_PLL_DIV(0x1));
+
+	/* 10M/100M Ethernet Signal Tuning Errata for Shorted-Center Tap
+	 * Magnetics
+	 */
+	ret = phy_read_mmd(phydev, LAN8841_MMD_COMMON_CTRL_REG,
+			   LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG);
+	if (ret & LAN8841_OPERATION_MODE_STRAP_OVERRIDE_LOW_REG_MAGJACK) {
+		phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+			      LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT,
+			      LAN8841_TX_LOW_I_CH_C_D_POWER_MANAGMENT_VAL);
+		phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+			      LAN8841_BTRX_POWER_DOWN,
+			      LAN8841_BTRX_POWER_DOWN_QBIAS_CH_A |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_A |
+			      LAN8841_BTRX_POWER_DOWN_QBIAS_CH_B |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_B |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_C |
+			      LAN8841_BTRX_POWER_DOWN_BTRX_CH_D);
+	}
+
+	/* LDO Adjustment errata */
+	phy_write_mmd(phydev, LAN8841_MMD_ANALOG_REG,
+		      LAN8841_ANALOG_CONTROL_11,
+		      LAN8841_ANALOG_CONTROL_11_LDO_REF(1));
+
+	/* 100BT RGMII latency tuning errata */
+	phy_write_mmd(phydev, MDIO_MMD_PMAPMD,
+		      LAN8841_ADC_CHANNEL_MASK, 0x0);
+	phy_write_mmd(phydev, LAN8841_MMD_TIMER_REG,
+		      LAN8841_MMD0_REGISTER_17,
+		      LAN8841_MMD0_REGISTER_17_DROP_OPT(2) |
+		      LAN8841_MMD0_REGISTER_17_XMIT_TOG_TX_DIS);
+
+	/* Disable Power Down */
+	phy_modify(phydev, MDIO_DEVAD_NONE, MII_BMCR, BMCR_PDOWN, 0);
+
+	return 0;
+}
 
 /* This code does not check the partner abilities. */
 static int smsc_parse_status(struct phy_device *phydev)
@@ -101,3 +273,13 @@ U_BOOT_PHY_DRIVER(lan8742) = {
 	.startup = &genphy_startup,
 	.shutdown = &genphy_shutdown,
 };
+
+U_BOOT_PHY_DRIVER(lan8841) = {
+	.name = "Microchip LAN8841",
+	.uid = PHY_ID_LAN8841,
+	.mask = PHY_ID_MATCH_MODEL_MASK,
+	.features = PHY_GBIT_FEATURES,
+	.config = &lan8841_config_init,
+	.startup = &genphy_startup,
+	.shutdown = &genphy_shutdown,
+};
-- 
2.56.0

