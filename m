Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF40CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 09:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCEE3832AD;
	Mon, 29 Sep 2025 11:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p3ZcX5Rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF48F832C8; Mon, 29 Sep 2025 11:12:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D615083189
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 11:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so16005465e9.0
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 02:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759137123; x=1759741923; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BW9xhoKXHGi4v48uXGissvsGTvr/D99hEpGYS8YXecY=;
 b=p3ZcX5RlueZFzSh/ahz+MFuVEqH1/z3xO4ghkXImN7aaWopJ8R7+JaGKxgaRUWnWNY
 8tVTiPm+jQUy/Tjr1JWhjETYuvTwc0RuVW6Eq6JGWUF0tVFHhrzWEzNr9ANzAay2CCo5
 Vdsdpp89R3eP9M1KsUsp6CE+x2wh3n5YR1s3+FFNZzTczl4nxJy51py8ocpcRPAmF1mC
 eefj0kLt26Ulvv3/9Gk7yg/BEhWk/Cm8aGVP+uGfav6oHIGk+5o/1DHV/h7G46RQZwJH
 sm85/fyL1IqSKY1hWR3JsqUlcVdKPmBV/VLR9u8+WGSLJ1v708PAtcpGv0iBI1Wl4TPx
 qFLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759137123; x=1759741923;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BW9xhoKXHGi4v48uXGissvsGTvr/D99hEpGYS8YXecY=;
 b=lhSdSpgef9eXJpG+3YFT4o85f3AO2X7ainn90cCvjQaJtEp8JnZiQrUVVxT6K2dCo0
 i/LSvK+AwMkG+o5i5rq1SklFDcqh5Y7k2Gicg0tuA2cdQRzPL+pu139sqHtr1VazYJhl
 nwjEWikM8HxYr9792KsEF2Ca0lzz58rtK39GrPFaviJSHjMDdT9EQcEq/ij+e4nYuMfe
 forME3zv1zqH8e0uxkTFODuwJKvdE6x64J+EFItHF4NObnLyZsIcUz2fu07hkwhGKQiy
 Zu9pt6bce0G6nMRAwkZHAsxzqOolWmh4HrlNHv4b4UkzI9NBhLLYoLoE1umgmc9Z9qJq
 Gyhg==
X-Gm-Message-State: AOJu0YyQnNgHgw/Wr5dupfAtAKU4bMm6VwMSvel+qlaftXZ2ni2EEySi
 MgGcVMbFVxD/Z1EoPdaSsBrxiXP4TE2qJkBcvn5LdsqLDA3vFghXo3Oe3Xps0kTA7jR4LlkKx3N
 vrzk+
X-Gm-Gg: ASbGncuzJOzbGUOjtmlUzHKmOs5Ckp4Gj8SNIbOhGH/y9dqlj7z5Mj2uu03GdMOdOVV
 /7x58fCmb1O9UlFGzbEQAb7DHWRDn8Wy1zq9m5MmHkTIuKJbHIMsmU3CYWt/aeU50hg+dSU6pKc
 Ev9Lgj7OYIZMNpVuYl6qCJqctsKM4xSVEj2/qbYxrf9QryD9puxktzmMb1Bj7iHEah2wB/JpSIq
 qI4VTf5jrUIB2Kn5aSm8ZLKbcBbc6htiSVsP9fiZQbG+mOG3pNRxMARtww96iJm0DaPYIbGXHX7
 8D3DT+Av0WC9jstyweUtyjwDwRi8qj85SjuY5cwzHPUV9NHMBFeemitKuHIYhOB+uQDkfcGQDcb
 9WlVHy6JSC4/bFAZJzi1oMSc0wy+X91JqSzBRxMhLKMZG4UeHdKeUX4oweBZZ
X-Google-Smtp-Source: AGHT+IEqnX4Z7Z31YNyFvXOxbHQGXLsfBX7w1vkzL3P0jjSyL0ykSOkBdqx+E7ND52rqi+WvC+TI+Q==
X-Received: by 2002:a05:600c:c176:b0:46e:32a5:bd8d with SMTP id
 5b1f17b1804b1-46e32a5bdb6mr136146725e9.3.1759137123300; 
 Mon, 29 Sep 2025 02:12:03 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:4bc3:3107:fbfe:562])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f744b0sm4887685e9.17.2025.09.29.02.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 02:12:02 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Mon, 29 Sep 2025 10:11:57 +0100
Subject: [PATCH RESEND] usb: dwc3: Remove redundant test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-dwc3_ep0-v1-1-1d5c58933bde@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anshul Dalal <anshuld@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

In dwc3_ep0_complete_data there is a test for 'r' being null and the
code will return at that point if so. After that point 'r' is guaranteed
to not be null and testing for that is redundant. Remove the test for
'r' being non-null.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/dwc3/ep0.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c656cbe25ce6fad9ca1ef07aba131d30018db19d..680756532f0db16f7e6598df19f71bf2ab410820 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -799,10 +799,7 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING) {
 		dev_dbg(dwc->dev, "Setup Pending received");
-
-		if (r)
-			dwc3_gadget_giveback(ep0, r, -ECONNRESET);
-
+		dwc3_gadget_giveback(ep0, r, -ECONNRESET);
 		return;
 	}
 

---
base-commit: 44c4919e9dd6c162b237633ba689441eca9a149c
change-id: 20250925-dwc3_ep0-47c99180480d

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

