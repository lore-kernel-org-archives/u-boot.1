Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2505C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F7587DC7;
	Mon, 17 Jun 2024 10:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WJAJlKjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CD688137; Mon, 17 Jun 2024 10:32:53 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48E3588025
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57cd26347d3so1391122a12.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718613171; x=1719217971; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qMzvVINs+Ml1vhbtsKTrYpL3/dZ9FBcxJvPoJfV6XH0=;
 b=WJAJlKjCU9Wy4KuKiOY4PcT+63hDDwmQGInfRyJkj8aXWoxq1uaX6WJLEj/rP7LQ63
 ws7AgSoI3EeVbZOyB5CCmcbyCEU6Oqqx3Hwgp1PDyQiKjAoS6cZmJC0M7Qt3bYbVRFar
 raDMfkaFzYePMxnGhpm4sdf/EsPmSmrqCVjP0XI4RKIPlBA3TBoF40rk1//JMbcRrsO7
 NgVMoZWahcz1VZtR8LgzYT05z0WBQDEOA06n1G6mIksbwopwyYDHDELzkkGk/xYW02JY
 U2PKWZGVQyu5+LjZlecyz8lNh84t88h78upnWg9avs23nEBcZV1GUpfdvZi1QEfrsBoj
 L4mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718613171; x=1719217971;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMzvVINs+Ml1vhbtsKTrYpL3/dZ9FBcxJvPoJfV6XH0=;
 b=XSPR0osHiFiBaW0jtlzPmtmxkgKV0mRXKEeagsjFf/0g/CE0slPmbMEDQ1s4BNFdiO
 OI0IaXvu87hdxGW9HO/+5eO1fNDIRjXANBu2z8vv7QSN4pXaUuXZzPGDbAa8IwGjRZzB
 ZVxESEhrWV5nnpzbo5xD7w3zvLHeyLi5ac29MyghWYB2wBl935NpGQ0/VAXL/WD/fSaA
 +zt7+b7V90GAm14JbDjg5PVzUlvUTY+83g/BHDeqxvDb6SMrJ+y58XzY9wFDCls0pKgC
 gI5TCiYOiBzIlP8UKJj60KKD5jug46xjt9FbMJFQZFckoMPkqeqnOqSW39e08Q2NN3NH
 fczw==
X-Gm-Message-State: AOJu0YxcPtUXKibV9ZWAUrXM39b3QAziEq3OMj1gMeNqY02AxSPCtYEp
 Q2YSwv1ush8RifmEWmT2xC1uMjA1okLg3Z0aFGDaL4P3qt79lL/zY7e6Wkunq48=
X-Google-Smtp-Source: AGHT+IGXr9HBSZLsyPsSmNlzi7hwRrem2HzghtiP4UWNYmlK2/2RGEN4ebUcdRXiS8UI+eydywuDLg==
X-Received: by 2002:a50:8ad0:0:b0:57c:6861:d72b with SMTP id
 4fb4d7f45d1cf-57cbd6742d5mr5388431a12.9.1718613170689; 
 Mon, 17 Jun 2024 01:32:50 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57cb72cdfd0sm6110031a12.5.2024.06.17.01.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:32:50 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 17 Jun 2024 10:32:46 +0200
Subject: [PATCH 1/3] linux/bitmap.h: add bitmap_empty helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-b4-qcom-rpmh-v1-1-bd2336923e0a@linaro.org>
References: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
In-Reply-To: <20240617-b4-qcom-rpmh-v1-0-bd2336923e0a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=882;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=H1zB70/xZeR9/o5jzaMKotSNZr1pxsG/RDzxnhxvFkU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmb/SwQWfAAKXoaF7NXtabvs2Na2gf+fsUlxSaf
 1slfruv916JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZm/0sAAKCRAFgzErGV9k
 thMpD/0ZFStbYOXOBnL1x9Fm3uaAJTbKX41Z7h1LZBgh+SPf6tXOGMFovucByYlFCs3oY7K4QpY
 nqTT4yEE2fodhBsU90O7Hfp2cqXhcVQHptMnxWNQd3AuirKPEIhqX3oztWT41z1ZEdzQlxwkCiq
 gmDHvOOh/Udcpp7L+X+yalPkwoozlrD63wPwC8+NYWh7xb1pM7zClrjyAcOq4PqWSlcjh2Anqbp
 fFVZYoXzaD4gkGNRmT3BjYoToB4tBZrRzxYbS3u4oZ3My9nbWiI1Bv0TKxjy4KVPsbL8/r8sKiT
 40RwOO8QOOkENSX7chSmKZp/wOoqk84weLc4eSjcKsEd09hFsvENOitWd558+frwG08jHZzxEhV
 5pHlhAigLC+wor7gWCYw6v0oPE1Fjjo7fgT8Hd0IlyJLWiIXtlogBZQkFbhGNO4xcPC6ItBEzbd
 i2lwUH4knN+6ppgZTqGHmAaJgDrFB6dLlJpC998ucY7yBM5XP1XZ40OIBYhHvkTH7Qr/46c0777
 ErS19WGMJn00VYjYadp3S814pT7/nFKzB4/TH0sUfkBGdkI26jl5eVyP31itavUllwP53tE4s6V
 v/fUDCQuF99YEkGuko/DK1b6p1wErAMJDWqGBXXblEKmsOt4mGc/vQ+JXJ1msQvluqEgz37WtYh
 3LLXoe+PhIcB5dw==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

Import this function from Linux.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/linux/bitmap.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 0a8503af9f14..40ca2212cb40 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -195,8 +195,16 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 		memset(dst, 0xff, len);
 	}
 }
 
+static inline bool bitmap_empty(const unsigned long *src, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return !(*src & BITMAP_LAST_WORD_MASK(nbits));
+
+	return find_first_bit(src, nbits) == nbits;
+}
+
 static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
 			     const unsigned long *src2, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))

-- 
2.45.0

