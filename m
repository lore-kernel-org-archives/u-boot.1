Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE24D43356
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 21:20:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A44B839A8;
	Thu, 11 Dec 2025 22:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d/hSDbFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59FC835C6; Thu, 11 Dec 2025 22:05:44 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6019B8307F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 22:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-450ac3ed719so396089b6e.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 13:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765487135; x=1766091935;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o6Lfz+pI0NPpM5tA13Wl2n/yh1PhkjY6CRAu1bo5WfI=;
 b=d/hSDbFUY7YrulAojF9l8u3eZK5rNou0JbV5ay1AcUC4ZF5dp885pEZZrtdmyvbABY
 79AKA0Xdq2GmFQ3LFS5ztYCBRQJnXdzcv9xNCK6SRGVIRekW0FRczeUmVr1aw5Q6b+Wz
 IGsPyECHRxJqcpSKpm6UgTaRtExRbSW4ELHcDNTTAQ7jaJWxMPT1SeIO5IW0kYPlwsh7
 aVNPx7XN81npDIebthHI37Gl0D0AJJgyzad1ptKn2aVjTsBR/VyPeYeXu/iIYjfNhVxc
 63+esrltzhXkx4gaQFp4goA4WqKgFAZMfk2t560ycjXQ6gL3jJHIE5a/1SYFZs9XEhpe
 cuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765487136; x=1766091936;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6Lfz+pI0NPpM5tA13Wl2n/yh1PhkjY6CRAu1bo5WfI=;
 b=JEUyrDO3IqSMw/zXwcSg6peiLtee+FdEvS487VRHV3UgqGFhTzJSiOWTsCxxXO8WyU
 cVUBM0oMN340VUGc+MH16HG5DNoSPH8WZNhf6vLU3CQzHt9O2gMb6N/DvSIAeDRrjZsH
 EfOsmyYJTVO23r4YmUbP/aOIQIzIvZICNH1cSPX5ac4G2wLWhzMNTssLJaJ0SDCrXJ6Q
 SluGDErxUgrbp3/zvo9k7MDv6kCndZ7aUAkehOkTrKK85w4mai/5xap+o8TUpDj2vGyH
 5p40NdK5ZdqyNK2OXJ3j7dP2odjxk9liISRg1uPeFrAG0o8aM4LsIqZ5bkm8cyL6jDGh
 i1Aw==
X-Gm-Message-State: AOJu0YyQSL70ntJ0ATSc9e1A1wvWFc6f11t5HB0feqhVc6gQdA/pb9fu
 pakqdiElQ0Te0lSrohfBIWZYrxi3L5advuqbRT7pWL5Kmpuw87gaHCGUyrACpWNOGDo=
X-Gm-Gg: AY/fxX6+r88fa0/0rmz3/0gmYEilZgdv380m1J236R+oLIrZBlkXfwxgafLXk9e5A9J
 8lwIk/U/cyAfWdj3ZvfEPEC6C3c2TjoxfNtdjVq26ck70++4ZaHKbFel5UZJJhCefssPaTTeu12
 zjyaZAXG+1D0q/KD/7AKnOtFD8V2438E+pNTPxkScZjdNEE2UGvRtVu0wZNO6TFLdx2oxCEpKEH
 vN93PVPgSNQsxS4xkup3+lR+ekjsGY44Adh+hDTWaDGrTD9R67+y2yW5Y+vzASJs6py8BvuQrBO
 9p6vbwRmG9QkYMeJX6aKXGYWbzpZK4Xl69QeFAiMrv2w3J+wq8sud+A2Selhx9PJCrXfKiduXpL
 R5mm5mNShF5IelnCsQo9MG7O3vwKoJdhXJqnRLxK6uRVh7hHaJPQPei1k/r5uJ3Pdg3hTzOhfqN
 W9l9uTLqv3O0E7Tcs=
X-Google-Smtp-Source: AGHT+IGx0XNIHZ754TKQfYOv1Hx0lP8fzK3+XnwaLV9F01QG/w77gUt2ypVQwSR7TStmzrZtbF8NZg==
X-Received: by 2002:a05:6808:1a19:b0:441:8f74:fbf with SMTP id
 5614622812f47-45586968828mr3915475b6e.60.1765487135647; 
 Thu, 11 Dec 2025 13:05:35 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1635:b560:bfdd:f758])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb1d0e22sm2230619a34.1.2025.12.11.13.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 13:05:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Dec 2025 15:05:27 -0600
Subject: [PATCH] clk: mediatek: remove duplicate '@parent' field doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-clk-mtk-fix-dup-parent-doc-v1-1-41816d98f857@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqEMAxA0atI1gZsUASvIi5qGjWotbTOIIh3t
 7h88Pk3JIkqCbrihih/TXr4DFMWwIv1s6C6bKCKGkPGIG8r7ueKk17ofgGDjeJPdAdj01qSdqK
 Ra4Y8CFFy9c374Xlek3UynmwAAAA=
X-Change-ID: 20251211-clk-mtk-fix-dup-parent-doc-57a2e7f2bc4c
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=cqo1QRHkEhd7YwbaUydIkpNgto4KslikQlMCZpWNCn4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpOzIYygRTz+MgBcwXA2d9wzbM8LPiSBbLoffG6
 TofwwhybDGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaTsyGBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A9m0H/3h2aeNrYIFGmV20GjlKmzLvjGb11NBNq4PyTIc
 1NV6156raJMe0KbYNWC97eOwGr/d5sP9ttn9IG/ds/hrvQCkJgbmI+pYO6wRmkZdYqjV68QFwqU
 YMUSnr7NGCouFAaQfl+gaBYebT/6f7q3FpHQi/5j6F6ZTR+n4/JDxXcHJNgQI52POwNjW5iRusH
 9R3VqxFCVhmc5A8hwF1OYoa5t7x8ZigT9qQYFJ07nYfRVNh+NzfYt+aHDEfGQt+ccpGCm1TrBSl
 jrptyckrsX9Rwmfxz9yYy+eaxHRck9NypmP4oI/7vwhUTzUnJY/LWNhs5t0tZbuZ0VzVTrakCtn
 jOzQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 11 Dec 2025 22:20:27 +0100
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

Remove duplicate '@parent' field documentation in struct mtk_composite.
There is no need to say the same thing twice.

Also fix spelling mistake in the word "parent" while we're at it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/clk/mediatek/clk-mtk.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 4ef1341aea6..89479001ba8 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -133,8 +133,7 @@ struct mtk_parent {
  * struct mtk_composite - aggregate clock of mux, divider and gate clocks
  *
  * @id:			index of clocks
- * @parent:		index of parnet clocks
- * @parent:		index of parnet clocks
+ * @parent:		index of parent clocks
  * @parent_flags:	table of parent clocks with flags
  * @mux_reg:		hardware-specific mux register
  * @gate_reg:		hardware-specific gate register

---
base-commit: ff80e95fed188ec3d4001129445e414c9c811beb
change-id: 20251211-clk-mtk-fix-dup-parent-doc-57a2e7f2bc4c

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

