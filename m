Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD0C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 18:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 407D040D10;
	Thu, 30 Jul 2026 18:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rNDkf35OkZR; Thu, 30 Jul 2026 18:41:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61A0140D04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785436884;
	bh=eV7BYD1NTBpuQm6Eyq1vtW7cp4ww6VRaJ0W6aciJ6Es=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IrOThrfjfAJrpnP6WpckMxOCLS1JBCo/o/xjN/EK+mWjDRCtIZqj/8yDeDjGq0C+y
	 8e+sAHpXv2tEg/PjOs8ugOEsYCsifclmfGX8EM/mAJdq/pytW46QylwKpgEiAmunLU
	 iZxQaCFxuC/cubEeig3L2tien2luJrAl32Zp3TZdrHBwyEQx3I2s1M621FrUL44ygY
	 y0SaM5UPHy9hQwr0b2ka9dHTjnPgDOHBwdUZ5SSamC1BWnGbd/QlbCh3QApyA5FSek
	 Zorg1SNlyOMfzjrtM1InrwyGbg2DPXldKKOjWucTRwENaxVJ+8P3ChoTfy1x9Vui8P
	 asAagRRDdxO1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61A0140D04;
	Thu, 30 Jul 2026 18:41:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E342869
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D56E140090
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ks1Q480z42eN for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 18:41:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DF53B40094
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF53B40094
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF53B40094
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:41:20 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso32020f8f.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 11:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785436879; x=1786041679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eV7BYD1NTBpuQm6Eyq1vtW7cp4ww6VRaJ0W6aciJ6Es=;
 b=AhUbHPh2boph5rQF3Pn37QD4X7Ui5SosAOmjy3sF6ZF/f0umUm/gmIKmKdNvgxPc3T
 8Lp4oBenzOg4k/vJfrBAxKwDWBVO0HUeYEt3isK1R+AQlWaa+DwLgKYY4XXu5fSn9z0z
 EB1p4EjXXEDA/eLTdvxpa+GgDEsm+1m8bJ/7Q8Ef0iTdbBNqn66R+oC0hHHBu09OTMIy
 rbObMNAwmA5dGy5vsw4S5y6mfMkERbODRlRKcnsAE5FIXXD+7qoTLeDp9ewPX6XSFXyt
 5B147bbn+3abxbjfYf7atvyOEjVEWySBtH4VC5AutQQH0IP91wekOBUdG4QXLV+QZ+4A
 4LIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpx9O41Y5BnP7ZSBiq5xF5/3XP7MuwZGpP7pCQsWvrCoY5Qhusmmw03AO0Edt2CPnBgzHRxegY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwjZWt3u+GyApBu087uW2O02jBfXnHWdIUIRTq6SOZV2lUrGiBG
 LYDgN/WXguq6GlU2eZakLPz1suiqXKDty4Lfv8Z+VikBq+61kA/+0FRs7g9sfl4cssbJZwjo2U3
 REf4IQ1PVNw==
X-Gm-Gg: AR+sD12i4MmUMf+di+WnRojNEPCif6/aKIlbPckdKTafQzfgMsAslB+jc88y2dmLLNa
 rlQ81EUY6z7zAojPu0ytnRBM0g7JZl4eHLUDg5umHcjrwCm/TbWsvRpZO5KKyNL9LBCCi4n5dro
 GIUikHMaasfRdfzrL+H7RJIdq6kTMXV1t0wiV7KZkBzRm7+qU2eQSrkSik0hI/mtdWKYN7yLAmt
 54WhjMNcQ0bjc0BDJe/B8JyjHtamjcA6q2WHp0/LAWUDeFRqu/cQNVzrvacVg6o5Rv3SL2w7AY7
 vIhZiFvD5DSbI+lU8AxFYm8JG71EFqPTReJu78gy1YGVYRP/EAZz7AYiU5rOlON4HNUata0c3lB
 hANcXxGZWGDJQaeZquSF8e0J+Oa3jWFkgU2KO5xZC94p9xJ1bt1SIJ25LnR8WoYBZfQR/u5B7kT
 DvHlsGCyD0+ING/5Z863/vs3JsaRtiKFahoDx9ypTTr7jcLkBLfd6DqOr09rg6KQ6hQVJnfjInc
 knbb1EhE2nONllTVdW6MfTAqduBLRfgECllywBK7Q==
X-Received: by 2002:a05:6000:2889:b0:47f:7346:89df with SMTP id
 ffacd0b85a97d-47fc81d0e6fmr5467399f8f.24.1785436878790; 
 Thu, 30 Jul 2026 11:41:18 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc88d8d37sm7919603f8f.8.2026.07.30.11.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 11:41:18 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 30 Jul 2026 22:40:39 +0400
Subject: [PATCH 2/5] lib: div64: use abs64() for the 64-bit operands of
 div64_s64()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-math64-resync-v1-2-8792d9119d49@flipper.net>
References: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
In-Reply-To: <20260730-math64-resync-v1-0-8792d9119d49@flipper.net>
To: Peng Fan <peng.fan@nxp.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1838; i=alchark@flipper.net;
 h=from:subject:message-id; bh=ls88qcx8Q/l0beQCvioI/5vU3krI7BzEk4KwwdBYx64=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRlzzpy0FLmXslP3dtbN63/w8jsHf9TVDPnM8uOHdN2X
 9hl9tRqSsdEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBTffgQw38XN0kmv3mMc3Yb772TqsilH3qOJ1jVzPbadX8mtj3zliYy/E/zFDj
 wZVd/4JOGY7/lpjc8eXPh3513s5b3NfZlPDF0fMEAAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785436879; x=1786041679;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eV7BYD1NTBpuQm6Eyq1vtW7cp4ww6VRaJ0W6aciJ6Es=;
 b=QlH8N3DQ5Q0nU62IeA27tsRtrvWRcZRDdyi+XjiO/fcRVHx+dBGG3BG+npvCPrO59Q
 63tZRotB7MA71nZ/l1nkfQR9YMjnF/oMUnng0xpnKvMUHhXnIeO2i8z8uq/0wIcqPucd
 YU5RRnA7pwiktkclVW0s3nSk1KkSPWdhHBiGlnxKuMKRrBBw3yOQtGygfM8SdeBvpKf9
 3fy+dQv+Vwj+viVbHcOcgVMy1cuOfdNwVwRQFdS23O4TonDa3wIst/2LJG5HZnVJCW7s
 7bnrXC3fzyb19W94Ao6pfScR+SfKO8CacZ3oSSDnOhahUdn7LK1qwBGUgpPCiBMjfjxP
 zkvA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=QlH8N3DQ
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

Both operands of div64_s64() are s64, but U-Boot's abs() is not 64-bit
safe. Unlike its Linux counterpart, which dispatches on the argument
type down to long long, U-Boot's abs() evaluates its argument as int
whenever sizeof(x) != sizeof(long) and yields a long.

The header even says so: "abs() should not be used for 64-bit types
(s64, u64, long long) - use abs64() for those."

So on BITS_PER_LONG == 32 both operands are silently truncated to 32
bits before the division. Simulating the macro with long narrowed to
32 bits shows what reaches div64_u64():

  x=         -4294967296  abs()=          0  abs64()=         4294967296
  x=         -5000000000  abs()=  705032704  abs64()=         5000000000
  x=-9223372036854775807  abs()=          1  abs64()= 9223372036854775807

A zero from the first case makes the subsequent division a divide by
zero rather than merely imprecise.

div64_s64() has no in-tree callers today, so this is a latent bug and
not a regression. Note that the abs() in div_s64_rem() is correct as-is
and deliberately left alone.

Fixes: 0342e335ba88 ("lib: div64: sync with Linux")
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 lib/div64.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/div64.c b/lib/div64.c
index 14d402ce4c7e..f5624279086a 100644
--- a/lib/div64.c
+++ b/lib/div64.c
@@ -171,7 +171,12 @@ s64 div64_s64(s64 dividend, s64 divisor)
 {
 	s64 quot, t;
 
-	quot = div64_u64(abs(dividend), abs(divisor));
+	/*
+	 * Unlike Linux, U-Boot's abs() is not 64-bit safe: it evaluates its
+	 * argument as int when sizeof(x) != sizeof(long), so both operands
+	 * need abs64() here.
+	 */
+	quot = div64_u64(abs64(dividend), abs64(divisor));
 	t = (dividend ^ divisor) >> 63;
 
 	return (quot ^ t) - t;

-- 
2.54.0

