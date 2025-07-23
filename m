Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA63C83F17
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 10:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F114E8329B;
	Wed, 23 Jul 2025 12:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mPQNld13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E11834AD; Wed, 23 Jul 2025 12:34:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E3C83297
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 12:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-454f428038eso56132755e9.2
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 03:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753266877; x=1753871677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lL89GNx5u83mHanQ6qzcFNEXa/07NOMbAM1DYdUMUc4=;
 b=mPQNld13mrb7vTzQH7Pq+GY89NWWRCL/pUzZKd9kEOxErPPE4A19ZL5eFs7F6K/kw6
 2ySJQEPKbK3xzeWSrvXIeZW9UjCOQ44spJExfY0X3d4xPGatQGSFQ8MRvw6QlRgJApLl
 gmEtvMFuB9C/g9727VsB/9Ci5p9Ma8vWjAp3aC4/1FDUsTTXA+R5Zg6v5cfWykcg6omA
 dAmAJU0rwDNGFx88n69Rze+z0cYULarezjBlP1QOdpvyyAQcyVbvFBzKE4vZrxP7tjtW
 SJmT47sbrOjPG1zy0XpFPUHWDFf0AS5axlF6o7GnLFAchQd5+QHN/SUxlGZl6AWr5XZr
 pJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753266877; x=1753871677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lL89GNx5u83mHanQ6qzcFNEXa/07NOMbAM1DYdUMUc4=;
 b=VZ9lAgIHhdj6bp7mw2KdLQcQC2CQgSBvDTg3NRXDiXIsQJdJnoimT7rHA7uBwbk89V
 api3TFBMxmKoGWSu9Cd9zCWnzKPxWTpJJhF9RKzj1jbhySFCJ6QzOs5727qblkrbCBwQ
 gLVSjiSgw3qYFGQ95q2Hd8PGtaRjAboXtJ6sT2XiCfNfYopaqnMF44Nr6T2ig3nsGLoa
 uEfbN8T3SE+3Bsl6M7+j3c9xSak2jjc8JLT8A82gzsO9NPAYU4qCaF6qhu3ihHhmzHHv
 5QcU48ZMRcy0Djy/JggiTRt9kot0Vgj88bF/F2tosUu2R2tVw3P5Qi6V3Gu1eE06uFGz
 4WbQ==
X-Gm-Message-State: AOJu0YxTxQfQuSo+861bouLhKJ95snkolm/3k1reL68UJp33x0y88pgX
 IaNmw6zHh7gPzEd1ij9KpDBJLV/3M2ze1SWYVE8WR52SqVAof3cgutMhUbRNb6/ToAQ=
X-Gm-Gg: ASbGncuPvtydtlkNIrUOBL6hrqmXuferkvzUd8+e0uWznpQt0wzYY5LqkIO1W4o8lkD
 dVZPIVrByBaJyyx1opKSfsRdvOBlplOPMy5A5Nlo70K8IL2F7NZTcuKq6d+pTnfe/hQp59sX4GS
 cJRlGkK/9V5fyiBUXIpZ8frPbpr5G1LZDj/xfFX7l3LGiQa+iLDSfiYfW0wRgf5a1p+N61rfKj5
 r40LsJ+rDHjajtD2OZHPXJsv17eXYrbTsNnU33Zus/tvORt/eQ0fkWBBIHhBrXUmyh/IxOPACux
 CY9K3MIanVtH9eoTelQXNpF/LIwWK6hl+XVo2rYBYxOXYELNHDmaZaj43rqG6H/ceSclIFsmIfS
 C7bKUhIvToLZ5yfwfMo7f2/r40WcDLMx8Rdv1/sX6VTvI/3a3NhU=
X-Google-Smtp-Source: AGHT+IFq+7aDpjo7g1tLn6McGqD/ZH64pJdMG11Vv7k/7TE/oBc46SGyMq7TdB6lnGd4sEAtW7B9PQ==
X-Received: by 2002:a05:6000:258a:b0:3a3:6e85:a529 with SMTP id
 ffacd0b85a97d-3b768f16099mr1985676f8f.51.1753266877516; 
 Wed, 23 Jul 2025 03:34:37 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:eb9:1701:5143:c98d:3163:b66b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2dfe0sm16015964f8f.36.2025.07.23.03.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 03:34:37 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 23 Jul 2025 11:34:36 +0100
Subject: [PATCH 2/2] bios_emulator: Add parens to xorl macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-bios_emulator-v1-2-78b9ef7b9b4a@linaro.org>
References: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
In-Reply-To: <20250723-bios_emulator-v1-0-78b9ef7b9b4a@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

The xorl macro lacked surrounding parens which meant that it could have
unexpected results when used in expressions. Fix this by adding the
surrounding parens to make its use predictable.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/bios_emulator/x86emu/ops2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bios_emulator/x86emu/ops2.c b/drivers/bios_emulator/x86emu/ops2.c
index 1ff27b2af95..29a166f7fe9 100644
--- a/drivers/bios_emulator/x86emu/ops2.c
+++ b/drivers/bios_emulator/x86emu/ops2.c
@@ -66,7 +66,7 @@ void x86emuOp2_illegal_op(
     END_OF_INSTR();
 }
 
-#define xorl(a,b)   ((a) && !(b)) || (!(a) && (b))
+#define xorl(a, b)   (((a) && !(b)) || (!(a) && (b)))
 
 /****************************************************************************
 REMARKS:

-- 
2.39.5

