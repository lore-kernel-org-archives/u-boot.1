Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE40C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D1C82C30;
	Tue, 10 Jun 2025 18:51:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="te6RSGjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7C282B07; Tue, 10 Jun 2025 18:51:18 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB42982B20
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442ea341570so37657005e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749574276; x=1750179076; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/ChcbGDY2c0IGn7C4U/oe3atwht945xOB+uopiC8Q8=;
 b=te6RSGjvl8CAAqsuluDGP897LFZ9IxZJYXBJqCCXgwarIa21HXSOqAJYOROfeRWTLu
 5oI3EGF7jtiSk7Ig++kYwcUhl6y+vovqu+o7tQxT2pUOA7bCaWoWxfG1NuMmTgzdV1wM
 yVEDUK9yAUu5xBdCVNlGPZLcU2yLJYyThhNk4f8iIgcYvO9Z/XTsUKz6n3SmJ3Payz3s
 Li8qaERMtMk7Rnulsko/Sny60Yga9WK/6iOdcLOdSNacWv0KdAWLudxhHu48FvUEUYMP
 n61qT31hRRNWI1wBnzyRtgeIljE2fHsHC9BayZYuBKIXpM0Yn3QkPaJJ5kML+P/WhOF9
 puqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749574276; x=1750179076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/ChcbGDY2c0IGn7C4U/oe3atwht945xOB+uopiC8Q8=;
 b=exKZBNUGj3X9b8CMNsfPolGiGxlwfRWEAAryo4R95gghK8K5faKQgbPQVH1IZ7rFPF
 WqLQ6JvMHMJ3y4hM4nzzf+1DNJinqdA6wDLEmO/LxCvBamw7+7vDOZcQ3eVUjRleiMXU
 H/444gPj+Nx27sT83mfpGhbQKKBHwlf1DWV4QNRzKf0SI0SgxW7wy2ZAn3NMhw4Mi8JD
 rKmXJeMJF+J1HhSGduTB7FA9S351zfPsp2WgwdSUQmcO4ViyoAXak2KWCjw4g+GHqgjc
 Tq5VCvdh/kZSZxhROo93hA/DQnRiIQjSArxZiCpSaKky/7lYHF/0c6Z4kwVj8cuOO06V
 hYgw==
X-Gm-Message-State: AOJu0YzbbiW9V24xzGTi6kukcUdPUuH7dsVJg7bMFnDLGlZLKrKaxndR
 2ICo9s6FbvoHrzA5JJFpB3LLNL3FP0mUzYuMt1lGt4bEkTdaJcYwYE07IG/mzBK9A8A=
X-Gm-Gg: ASbGnctjyw4FASNCsihE0OqZBM7BGi5rmlDB3uYRutnTMM2RNZAxKyJDGuuJ7pobE3W
 YL4KXWvSLVTmgVsE+GpNOON+yXj+eu2ZmY46dzHVA0DBqo/BN5//5KDdtAeQipHot8v/2Uvfb6M
 RNMdrO+X1Exhbz5w5Tb6k7YB4i4B9umP3D4BOul8Y3wkgie5vMrghrKA31Lc662Nl+jK0rA4TaZ
 phnNsv6pP+hPE/CpO58GGeW9WQVV4nfVKXMsyigZFm1TuU7Cqb2d9ESdub/q6Psee7MKSHgY4SL
 VhiaDmD5BS4FjeFk271v8gcF+c/13mcWGLUfzc3D3TL8nnsXWWNcJKRieIJoMH8rpDZDHUeL
X-Google-Smtp-Source: AGHT+IFLD2h3FFvP9XG/tZ1HHOC8//5De3LLGXlaDhCucl7JGBrOYErwDPH+qlzmkQZqsffob4/AbA==
X-Received: by 2002:a05:600c:3587:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-452013ab6b1mr180938635e9.15.1749574275908; 
 Tue, 10 Jun 2025 09:51:15 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm148665345e9.0.2025.06.10.09.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:51:15 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 10 Jun 2025 18:50:52 +0200
Subject: [PATCH v2 3/3] i2c: geni: load firmware if required
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-geni-load-fw-v2-3-7cad6bc18db0@linaro.org>
References: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
In-Reply-To: <20250610-geni-load-fw-v2-0-7cad6bc18db0@linaro.org>
To: Heiko Schocher <hs@denx.de>, Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=C9cV1XlqKOFnv1pfqDdwPR7Q+zPvojzlL4zUYBp01dw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSGJ+/gPO04lCUMVfI/YbOMQmOCBwihqULfecp
 m4zm8ynFU+JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhifgAKCRAFgzErGV9k
 tiehD/9Gzq+rOUd3kBH6hEQJV5faWvBa12zOKQJrCazLShWqqyD4rya/rsT6TiBZsey/jYKW48w
 DvVPtiBUeDIn63vc/dg/RWeMKeLUNP57Jqff+3vBcbi93ysAi0YxohZTZTRjzrxrsUpl2OMY11T
 an9DHQXdqKkIUCvdLlSQILpEke/lwYAt3VARa83kBXvQ1lV2Koik8aeoCSvO5ky61wEFcfdJ+qc
 knuV99pe5+vStArHyb33DmxwogHyB5TJHoyvgodz/txhYjSgU7fwUUAya+AOweiNlMA8295gn07
 zxRfOQMyBudRXPYK8Dg8L6/8hrz1a+1e/s2p63iJ9/3nRu94Zv1xTxmLPfHMDAJyKp0p3GE0T70
 dESy57cECSek+M4IV1UkONoCzGnSAqiB6Kvh21+ZBytMGqAtTPlyM+ZkjeesQ/6iiGvbd1PAI1A
 MSuTLiC6nue1lnabOnI8tAPFi+ZqhafDCcilRjfFogu2HBZ9dQjRdh3w0KcdyZwyvRIuOP9nl2I
 gRDu96zUw22HoFKT/+cpHKuhQ0gPBeEwZ90IpoWrod+eDJrYXcJLBzz4UY6mUJZ35bH2hwRNGoE
 JgoNqs/CLjU+iGetAI72eLD/EIVF0TGZelDOTvPrkEjKbT+bBTQCDBmMDcoulaOMGd5rDU264gQ
 mV/Pdcd4Kh7SF+Q==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Load firmware for the peripheral if necessary.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 4eb41ba852f7790ca646c8ba38f29fdb727fa804..d29e00fdf41df1d7a95d8d9b3b98f784f5b2a3e1 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -21,8 +21,9 @@
 #include <clk.h>
 #include <reset.h>
 #include <time.h>
 #include <soc/qcom/geni-se.h>
+#include <soc/qcom/qup-fw-load.h>
 
 #define SE_I2C_TX_TRANS_LEN		0x26c
 #define SE_I2C_RX_TRANS_LEN		0x270
 #define SE_I2C_SCL_COUNTERS		0x278
@@ -498,8 +499,15 @@ static int geni_i2c_probe(struct udevice *dev)
 	proto = readl(geni->base + GENI_FW_REVISION_RO);
 	proto &= FW_REV_PROTOCOL_MSK;
 	proto >>= FW_REV_PROTOCOL_SHFT;
 
+	if (proto == GENI_SE_INVALID_PROTO) {
+		qcom_geni_load_firmware(geni->base, dev);
+		proto = readl(geni->base + GENI_FW_REVISION_RO);
+		proto &= FW_REV_PROTOCOL_MSK;
+		proto >>= FW_REV_PROTOCOL_SHFT;
+	}
+
 	if (proto != GENI_SE_I2C) {
 		dev_err(dev, "Invalid proto %d\n", proto);
 		geni_i2c_disable_clocks(dev, geni);
 		return -ENXIO;

-- 
2.49.0

