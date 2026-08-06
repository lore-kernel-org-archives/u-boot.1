Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D036AC55174
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 02:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D909540841;
	Thu,  6 Aug 2026 02:25:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 30y73cJyuPWf; Thu,  6 Aug 2026 02:25:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 19245407B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785983117;
	bh=tjI/wBzixsYIwitdM0F4Fql1D7slOSGBnywZhrxw+S0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LnuIjQyz7A8Ur0zknOCy3I5/ILyOf5LyPg34yFmuZc3mkgGHLPX/pDvlpU95AH2ob
	 bzUCFVvsC8zi2cIH2RsFeVNroIjEt9t9WXZWkq8cos6NXg3dqVBb1leaQjZ0Yg60Bs
	 2wWNyit290tWE4YyBzSP5e+wE49AG28+WA0oCaZRpPtsQMxIiSi2Zzw71iIIHBk7EV
	 N5B0FFd9aEDwUIoL87un90TVI2bJU962+aWN3QQXIa0K6dpoZILm0dqkAFhKmqe0EY
	 q6syEeOrEXG/0RAaV8ezwMxZviDSWupbaXf1OANwqRVTD85e7ULs76IYvclSsXMrz4
	 moEhMzr1cGa3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19245407B9;
	Thu,  6 Aug 2026 02:25:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 819EA392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 00:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7332380E21
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 00:58:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UFVaqKRTQSHi for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 00:58:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com;
 envelope-from=bhimesh.matsa@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D12DC80E04
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D12DC80E04
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D12DC80E04
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 00:58:15 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso1030633a12.2
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 17:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785977895; x=1786582695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tjI/wBzixsYIwitdM0F4Fql1D7slOSGBnywZhrxw+S0=;
 b=Dpt3wND+kGTPhcX/XDkf62zIY8EsJvBxedsZqUpAI98oMOE9EqeigfoWs+HE6+rXDC
 oxnjqAlhVwc32uRTBNdGnjCpoOkf4DvvyrMzde+Gj2tZZmC6o6QoZg4tSwOYm4IOxEVA
 KjD0gqmK2M1bOaqheutCglLoyDUjL21JLcSs63uwwb9m6cqH7Njb+Dq/yfshRftQEbVd
 wxyvtK4dUf9M+Zfn4JcP/2qVqqyGC6ATt1yvcMSTnbJlDAntF7AO3wL0Q4T4vRAOhEzd
 H3je7zCoybGKeC3SdRNNe8GKSnl02Q1Ja0g6z10lP73IM1WVjF7MsR2sRiHNDvr8biwU
 yL8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpRyHZXece374qDkgA7jdPxnklpVO3E3HMJZDhAO2f6hUit81423fMUrWe4tsT06s8QEIacaEQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx1MKWTrMyEqvyKSjNsEVaWgKZ8xMd7xqPaWkisxvTnAi09BI5Q
 7uVX6nyi8/GIOjLmeEYC0V2pNwU/bCHpCACDkDLr/9af6qhSOiLQx+EU
X-Gm-Gg: AR+sD12R/FUJqoFHxB/l4npKeKvBSy6Z2Z0CXRveIcWJQ9J4IFN9U7EztannncAoIjh
 1wBmLJpwdma1IBARaS2D1FILrEw9E5FSL/wRkuoFw5CqwUgTQdcTk0uqLqZ9y2dmUS7oAr3AKJv
 WeqBAEAXW6CevtMiLPdNJc/9+AR3InkMDiRVjmtojH2OjYojf48VGzNiVd3wQDMS71T/4LWJNA4
 9fOUk7sE2BEUTIMOKdc5yCTKhw4u+8dIUJUT8lo570Q8ISxKYBenlun9H1rthtRp9C1jfmM10kC
 s+ZK+z2KkvWIehEeK+2lJQa1ZHO9NFOj+8AZ9pDJSzRB5zvAlU3PMsjgoPJ67iEDUHdlqnacKIp
 rJqLWTFY/9DNAWu/iYgPlxXugSNOaQ+mQzLIXijejU83KxnzaFiiMFtgbynrBAhS12OA3Z1O/gl
 tYRShx96UlQMS0Pxr7VGgar9FSMg+IFaUJSjHqliOXbfEDTq9xd0PU1UXRP6n6n4UCfuwdqBP89
 pKYKreG5L9c8F0iI9zG6RZbjbxvZJQlRnoBNYCBvX45q8RtAWeB/2M2bNqGcJ9k5brmFg==
X-Received: by 2002:a05:6a20:2447:b0:3c1:657:4c95 with SMTP id
 adf61e73a8af0-3cb85e6aff4mr12156694637.15.1785977894984; 
 Wed, 05 Aug 2026 17:58:14 -0700 (PDT)
Received: from kumara-Inspiron-15-3530..
 ([2406:7400:63:873f:be6a:3f45:d01b:cf92])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-140f744adb2sm2121888c88.2.2026.08.05.17.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 17:58:14 -0700 (PDT)
From: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
Subject: [PATCH v3] power: regulator: tps65219: Fix LDO selector boundaries
Date: Thu,  6 Aug 2026 06:28:03 +0530
Message-ID: <20260806005803.5998-1-bhimesh.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
References: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 02:25:15 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785977895; x=1786582695;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tjI/wBzixsYIwitdM0F4Fql1D7slOSGBnywZhrxw+S0=;
 b=Of64SFT9yiGXXVq8eZsTR+jvB7uh1QP2ntsdoEoXrCUFZUn+Az3MfGCsNzMzXj29Zj
 aTzqDS5yrh3LN+ZdPkhiAuGkiWwJaNtc1IZhIOX/BO2LvA9DOuMZcphMYJorBXxf1G0u
 9iQ1jzklWT1QeF08a/Da8aIOMOKKN25aUrQOrj2BmV6hZezgFMupk6faOWSERM+dihJd
 cH5shA/ADTQcDP5PCSARDvpWVkdf0UFwE22emN9+hLGOq8p/cBzR3GixjMznVIGb2FKs
 +EcdoDTraxmiFGKhcnorZfY4v1zH0rPwl1Q53BuiTocCnvz4snyyiOYdEXfdCSvTH+ro
 COdg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Of64SFT9
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

According to the TPS65219 datasheet, selectors 0x38 through 0x3f
saturate at 3.4 V for LDO1 and LDO2.

For LDO3 and LDO4, selectors 0x00 through 0x0c saturate at
1.2 V, while selectors 0x36 through 0x3f saturate at 3.3 V.

The driver currently uses 0x56, 0x12, and 0x54 as selector boundary
values. These values do not match the selector boundaries defined by
the datasheet.

Use the correct selector boundary values of 0x38, 0x0c, and 0x36
for interpolation.

Fixes: b5cfa0c7ca4f ("power: add driver for the TPS65219 PMIC")
Signed-off-by: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
---
 include/power/tps65219.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/power/tps65219.h b/include/power/tps65219.h
index e8780af2d81..c3114f26e1d 100644
--- a/include/power/tps65219.h
+++ b/include/power/tps65219.h
@@ -47,10 +47,10 @@
 #define TPS65219_LDO12_VOLT_MIN		 600000
 #define TPS65219_LDO12_VOLT_MAX		3400000
 #define TPS65219_LDO12_VOLT_REG_MIN	0
-#define TPS65219_LDO12_VOLT_REG_MAX	0x56
+#define TPS65219_LDO12_VOLT_REG_MAX	0x38
 #define TPS65219_LDO34_VOLT_MIN		1200000
 #define TPS65219_LDO34_VOLT_MAX		3300000
-#define TPS65219_LDO34_VOLT_REG_MIN	0x12
-#define TPS65219_LDO34_VOLT_REG_MAX	0x54
+#define TPS65219_LDO34_VOLT_REG_MIN	0x0c
+#define TPS65219_LDO34_VOLT_REG_MAX	0x36
 
 #endif /* TPS65219_H */

base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
-- 
2.43.0

