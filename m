Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD6F606A332
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=G/WFNdYe;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eduTEiyq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E146D811EF;
	Thu, 22 Oct 2026 19:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FWHul5x5zMZV; Thu, 22 Oct 2026 19:02:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1639C81246
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792695755;
	b=ADzQbnTdBnqlOBiTGnJ9NXc51aYUX5pS8E7PbkNR1up4KepUjmxWkHNY9H70UMQP09l3
	 yd8UQHLdUJNGFVSYh+eCuaE5PCu+G3FS/a/4B9YvqSh74rQtZVuGTKe2AAbNhDpo3BV9N
	 0UZrBIVN5al7N9XkyXQUfQnmK4yfyC3Rbz+YsoQ7z3QqHV28PwAxfgNjbnLlVi3fykn5Y
	 c1ShTofTQ32CMfNQVAjGECokt2LFzHlZYgI3jexHu/LusVxqfPrPefMS5xN45AGnvEReC
	 ugYyJEd2+SjAqQYIP39NaqTNATV3izf9xyfvE7kxQWxH2H3PwaH/5r2iNEywe+MawmA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792695755;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jsn3k8EiDgBxKSupfAB9CallmdgQ3P4uUD//WkdFPe4=;
	b=lCVf/pfv2s0AJamL9mNV76bZ6tQ0+9aZybg3aHCTwSuK35r8R7sWOF9dWMMO/8msKcX0
	 eCNwjmJYfcJkNjE4QmK1a1FDAi3EtVnEBYZPtXNcfnRfaeZijALpiHVipswbsGcRVH7i9
	 Am8Up/J3uAkSZZ7qRvf/CMWTvwtm6FCj2xIiGqOKm7FmJ+SOwMuLvR9+TycIAyNDUrMKV
	 LDAElhCtzHEQjpbB3h2DmEMXUINkBaZg0sS7A3el8XSwNtiEdHbaFMoGiqNM6LQcbq1W3
	 Y6wYr1mBo/4vvINMgI4O0uR3rI6pVkgiA6nIZIqk9RzfZoyXShQkHDJ0Gk80mk2mesQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792695755;
	bh=jsn3k8EiDgBxKSupfAB9CallmdgQ3P4uUD//WkdFPe4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G/WFNdYe/7NODhzSMmwKckeR4WdlEYBNqWc0nSRH/9TBxHknorViCM4KyT+hbLG0/
	 eJnWHd0hwY0FnIEJ75QnL7w6c4maV2jTEtLSEZEPxRcWrUkBcW19lhr/yzjLS5+cjW
	 19RNNVdcl/q7CrgQsmx9sZjOAimSY4G2eIRg7en+O20kD4nIjJ67l/9wR4OFg+xj8G
	 z9pfyKbMoLs60Q9oGnPpimJk/NMrSyWYkXjP9c663UpuoYwcuPvZmsmGSidOnUWtjX
	 XVfZDWvjEbPUlE/xYlUxZcrz1MdgC0xQizCAo/9rB+5xTNZ9PL9/w/z3W5VL0vQXHv
	 WvrwHKsPmIwLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1639C81246;
	Thu, 22 Oct 2026 19:02:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 03E363C1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DE02F6070C
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uSaEiVL3RH7I for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 19:02:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0AE536068B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792695752;
 b=ewLa4wIhZmNsLBo3OyY9L9Opmsngat8kMgp8bqGpqYbMPHH3MD6rzB+lpkImh8+pGAtr
 7UP8OH35CDEEqVxOGV7g6HQiqfm5a2pfe64BZHIVu2nGUpQiqf1uWVyWAgaTslHmknmzu
 gQ8d4UX8JcUxwWLvKzIxnASc7g3Nb+AA3SENAYquqmf9jcRLulqokICqthEyTxcotU8pq
 Cok+uU3HfMnIaJ4wlVAhLOVkg06oTFoZI2bLDHbV25bMcP9oSCQ9Gl3vNkVkn7D6FoDCT
 ka3Z/Ut1ftoRWLCmbtEFK7O6OWHWqQ1b/+MSm1cMCOxAcGegARUxalMvxpvvur0KXdw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792695752;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=jsn3k8EiDgBxKSupfAB9CallmdgQ3P4uUD//WkdFPe4=;
 b=bnL+0QD8MrSLvkhRSmS+KunNMO6pLzGLKJ6tM7L+geN1mcQAkZbwFRR1ycwVamjbTO0E
 zx5Ps27RgNGILMO1x6ulgrhYrxzqhu8wKbQP3P+2dyhunqbPBdj16R+QrFwxzRC+UhTT3
 1GVZcBNWBr1iUSUEMn63IxBwXmTQqf9Fw4xPDOYzPy2z58FMrBMfpn9MPR5uJMrLajroc
 AEAoqSVCtnCBhOWD6mlfFzDvVY5Bw8DY9D2LjxB5MAjUgLkz4RFlmWAtRIKobvYd4eCiX
 PAU2lrIlI2jaw1R8ZXwz/ESF19eUdtqfNMp6GkjaX5UNhJG/2X4XJJKxh+XniofWE2A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eduTEiyq; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eduTEiyq
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0AE536068B
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 19:02:29 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso100041f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792695748; x=1793300548;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jsn3k8EiDgBxKSupfAB9CallmdgQ3P4uUD//WkdFPe4=;
 b=eduTEiyqBwaQtpfkQJak4OcUGHxa9JCmdOh1dVZQdFkf1aDguvO4Ajknz/QPL7xJCg
 OccENWDFTvGNY2OsRVaJSXAHILLhexjE9Hb4ZNHkZkhXjXl0ka0w1pSQM3avEn7RezvR
 AOcz3NUD1OyCkiVqQ2YZZ9VLeCuih4+bmCp+h7eANcZa+rl9+1Ca4l0A0i20lFaJnvGH
 RIROJL4PqPrro16fV3W2ZBBavUOLL4LcL402Gp7CxUY0wvouxYhD8UkszMZH+Nrs70f9
 V8J4GBM8lobAHwhDu2O7usnig7SYkmypBI9ZzCXf1pndtB11komI53Pt2AeJQ+5m9Gdl
 XwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792695748; x=1793300548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jsn3k8EiDgBxKSupfAB9CallmdgQ3P4uUD//WkdFPe4=;
 b=I29MNk4i5Wv3e0Vn4IQDhnpYE7ERZgMiVyThHsQnHfrrI2ko3MAvERVxeLy07dbFMW
 3nZMoxX59bTEV51lp6DNNQdPr2rBQY1Ve5zgxzK8rjE2zzx21JHMswi7OPfUDOWiARxn
 Pewiwpzq9d4ihlgGjcU1mxBSE0JLv2pgDYM68pNxRc08MMi0OwV+K6ThIkP3CsyY2M7k
 DkHDcvfSol9BqGLw99Y2jijV1Rc4NqtBkt17lG7dSUQwdz9lqdW/yoEv5r/bXatygV3N
 KbCSy9Szz71ZLVjzrJMXhbbLFchVwKLj5SLJ7/m6DYxDX5xQWIQN+9AJotMFHHsE/s4T
 ioeQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtANbrc/TlSxEWh41kmMgt2kZAvxyHKzq8CZDU65grr9gH89emyeaFueGCyTljyekbU/DLvPs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIpEkNcRJgyWMYEiSLXsC9+95/ClpXgnzVvvB3oAKsvMrkj+Ufl
 jMsQgrpMoQJULvswR44L4w6Yo3xz9I0KR+ap/I3s4SGsEWcm40OEtv36
X-Gm-Gg: AYBFou2b04fuW2orml6DtuyhTTqXnzvK1t2jWYeK12p18aL+FJWNVIutPP8zo0CgLeF
 zmjkStVT2KFF98RFFoKFGQfnGMqIWW+LixH7Nh8lLbgS4865i6txPrW8n6134I3V17ckrqrFNmK
 WXsNhpfVD8ZmEOaWh2js79SpbIqwTHQYMJwSrsW49OpKjyw+e1xvv+AnwcWbMf5Grrih0nqKJS/
 EkP7Z5KKcvPUxX2+eIVL3PnY1HPqhHUdIk5mIAiUAcb2bD1cTY1QUztnsGCNniKe+6R/5C5gwaC
 IbW2fKOa+3I5BVwOc9xVnJ153Ej+vbQS4qvKEBGp4sAM969txHxfL1JpQpjGyfBZ6MEn6oXT4Ld
 nbc45twg6yeiY03jECCS1evDVU/eyb/pIUh/iLxFxdDfP60axpkkND3fNogpSIoMWwMAI9pkenX
 pnBLIzVM0b7K7Ikg6vqHpBc9XQaVASoyOmvPNfPWXXsiYLgLV8mieHZtMWmiIhoSl73UV8FDj6j
 8kALv/opRmuY2Og6dp6Uvh0S5NQUqT2E6G+VZ8IkiEHL6LlT2UsfTYubGcnSpm+B6jrbphSHtyS
 KoRs/RbERPiUYr+yPyN4HVc22niBUWzNRAyznpVPuTBIt7z50f57Ro1g8Q9p
X-Received: by 2002:a05:6000:43c5:10b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-48e264cd791mr10113235f8f.36.1792695747629; 
 Thu, 22 Oct 2026 12:02:27 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e37a0e841sm189495f8f.54.2026.10.22.12.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 12:02:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Zhengping Zhang <zhengping.zhang@airoha.com>,
 David Lechner <dlechner@baylibre.com>, Wayen Yan <win847@gmail.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 02/16] dt-bindings: reset: airoha: Document support for
 AN7583 reset
Date: Thu, 22 Oct 2026 21:01:44 +0200
Message-ID: <20261022190206.666950-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022190206.666950-1-ansuelsmth@gmail.com>
References: <20261022190206.666950-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document support for Airoha AN7583 reset. Add the reset bindings for each
reset line on the SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../dt-bindings/reset/airoha,an7583-reset.h   | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/dt-bindings/reset/airoha,an7583-reset.h

diff --git a/include/dt-bindings/reset/airoha,an7583-reset.h b/include/dt-bindings/reset/airoha,an7583-reset.h
new file mode 100644
index 000000000000..7ff07986f8ba
--- /dev/null
+++ b/include/dt-bindings/reset/airoha,an7583-reset.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2024 AIROHA Inc
+ * Author: Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+#define __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_
+
+/* RST_CTRL2 */
+#define AN7583_XPON_PHY_RST		 0
+#define AN7583_GPON_OLT_RST		 1
+#define AN7583_CPU_TIMER2_RST		 2
+#define AN7583_HSUART_RST		 3
+#define AN7583_UART4_RST		 4
+#define AN7583_UART5_RST		 5
+#define AN7583_I2C2_RST			 6
+#define AN7583_XSI_MAC_RST		 7
+#define AN7583_XSI_PHY_RST		 8
+#define AN7583_NPU_RST			 9
+#define AN7583_TRNG_MSTART_RST		10
+#define AN7583_DUAL_HSI0_RST		11
+#define AN7583_DUAL_HSI1_RST		12
+#define AN7583_DUAL_HSI0_MAC_RST	13
+#define AN7583_DUAL_HSI1_MAC_RST	14
+#define AN7583_XPON_XFI_RST             15
+#define AN7583_WDMA_RST			16
+#define AN7583_WOE0_RST			17
+#define AN7583_HSDMA_RST		18
+#define AN7583_TDMA_RST			19
+#define AN7583_EMMC_RST			20
+#define AN7583_SOE_RST			21
+#define AN7583_XFP_MAC_RST		22
+#define AN7583_MDIO0                    23
+#define AN7583_MDIO1                    24
+/* RST_CTRL1 */
+#define AN7583_PCM1_ZSI_ISI_RST		25
+#define AN7583_FE_PDMA_RST		26
+#define AN7583_FE_QDMA_RST		27
+#define AN7583_PCM_SPIWP_RST		28
+#define AN7583_CRYPTO_RST		29
+#define AN7583_TIMER_RST		30
+#define AN7583_PCM1_RST			31
+#define AN7583_UART_RST			32
+#define AN7583_GPIO_RST			33
+#define AN7583_GDMA_RST			34
+#define AN7583_I2C_MASTER_RST		35
+#define AN7583_PCM2_ZSI_ISI_RST		36
+#define AN7583_SFC_RST			37
+#define AN7583_UART2_RST		38
+#define AN7583_GDMP_RST			39
+#define AN7583_FE_RST			40
+#define AN7583_USB_HOST_P0_RST		41
+#define AN7583_GSW_RST			42
+#define AN7583_SFC2_PCM_RST		43
+#define AN7583_PCIE0_RST		44
+#define AN7583_PCIE1_RST		45
+#define AN7583_CPU_TIMER_RST		46
+#define AN7583_PCIE_HB_RST		47
+#define AN7583_XPON_MAC_RST		48
+
+#endif /* __DT_BINDINGS_RESET_CONTROLLER_AIROHA_AN7583_H_ */
-- 
2.55.0

