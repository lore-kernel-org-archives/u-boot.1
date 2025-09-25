Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C62CAC5A5
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 13:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 110DB80819;
	Thu, 25 Sep 2025 15:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TXYHMYAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB039832AD; Thu, 25 Sep 2025 15:20:42 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 420E680107
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 15:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e2562e8cbso8377415e9.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 06:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758806439; x=1759411239; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ONevhEASRFWGexrGxnZs5MN9SB4cXc5KLBhZn36RxrM=;
 b=TXYHMYAT5WYZ1pUxj5/mf81ziWrDLMy/aTucM5/l5oos/a0XPnGFJ4r2ARn/MBz2e1
 lQSl1MbpwvVr1NALgB0g29U6ATD67juzzUmeh0BE5KdiUn0cOTunOjkbiPHeGQapCUQR
 c8NerOR8Gcj+LYBQlOo9AnBYCVL59nf3T8TqV7HB7x3C4rrEsT7Z/B6oB6vhaqeoYgLY
 v604gr7tDpkgyihC3h8igpUE52ZjDfnW79Qm4rp/BEtgRUPr3zvOFiYKv44h1OAsECT5
 XHoBzw1M93g/bzmhZt0JL3kxuFM1XwYSI46qi5fZKG3XL5UTfyDOfoTVOfru/cFdDXwZ
 pfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758806439; x=1759411239;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ONevhEASRFWGexrGxnZs5MN9SB4cXc5KLBhZn36RxrM=;
 b=Sd+rw9zi1q91nqgEPigTWwzikU9SizW9cij1vYcQ1OP00+fW5t8ekZF8xufd/X5WE7
 S+9vDM7M6OV7mkbnt3UW6YnO55eS3SGwxy/owTRsTXGIwAwjoxkGRqtZ2bmsdQ9xM/H7
 p7gsB2mEIOjCTMr9ne/Mon6TxywYm0kr8snQ9Kr+O1ttN2n2gOVt7zZ/Ce8rdNoie0zS
 hih7PfoqTLu3phFL8v1WnhlwSuAbRMZ5jSRoGX44kGphN6mjRYIG7AybJKQQchXieP5W
 1vkAczDTO+phubhKKi/gtRazwThA/tqFDol+LipUSLq7aNlpznsUvxXJ39hw7DLaGjoZ
 yEdg==
X-Gm-Message-State: AOJu0Ywp+HBmuUyCDSW/ID5fJwhKGi+QYDf7ROKBa6m9kV9PGQuU8DfF
 94TwQzBTv+hbyZZJKDn2n6KKe/23vnKn/+Qx/6TdzU6sqJOJ/HKD+2hdQWdk4ToxKbJRbo/FcZJ
 Vz99e
X-Gm-Gg: ASbGnctRAPDv3eU5zwAdmpAQKQhSTwSXL7VgGGoCMjzQxWigWcl/cw+27sDa0M7eH+o
 KJRGwivVXEQSBXnArAxAStKLG8rHPiF3e0wOVXdpZdnryABLdTNrT5KO0RDc0pZFOAtlbgQ3Uml
 WSHFFkYc7d3e/1NEO1eJNBb3cwP8BF0bFdnsz29WLVzb7D5h9bGx2I+2NqLABja85tGcAl1PPH0
 gruyx6UjxyPO9GWtossYkFfeUtncn+EWFJ4XEsBddQIsNKW2xEd/8cp8/yXTAsKWQmAILnG3A6u
 3az/EkQB2ffLyiVsnAh4RPdOB4Wbmfs34sYFA5srZXIqJjD4Xlk7Wt86mxzf0xAGxO19Lo9K/Gc
 sl8PV/VS3wuCUmC4heRExT5gALsHFNZRgCBZMSgyMlU6wVUD2C/U=
X-Google-Smtp-Source: AGHT+IFTEBuQoCW9k1kFDYEOC+3b9C3lOl8cSqu9H60mHer+Yq1YG6ky+XkR3DzeSI3qK+Dh5UZL3g==
X-Received: by 2002:a05:600c:1554:b0:45d:d6fc:24f7 with SMTP id
 5b1f17b1804b1-46e32a158camr36848875e9.32.1758806439478; 
 Thu, 25 Sep 2025 06:20:39 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:5cb4:3820:cbe0:c98b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab31e97sm77509475e9.14.2025.09.25.06.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 06:20:39 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 25 Sep 2025 14:20:38 +0100
Subject: [PATCH] usb: dwc3: Remove redundant test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-dwc3_ep0-v1-1-7af60ed1e28c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKVB1WgC/x2NUQ5AMBAFryL7rckqQl1FRKpd7E9JK0gad1c+5
 2VeJkIgzxSgyyJ4Ojnw5hIUeQZm1W4hwTYxSJQ1KlkLe5lypB1F1RiliharFi0kfdKBxOS1M+t
 3cHQf37x7mvn+C/3wPC9NphQzcQAAAA==
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
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
index c656cbe25ce..680756532f0 100644
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

