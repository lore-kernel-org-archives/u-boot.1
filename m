Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E913EC36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3568581D27;
	Wed, 26 Mar 2025 13:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aiaQMlCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8BD81D25; Wed, 26 Mar 2025 13:24:16 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FF4780756
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:24:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so2567273f8f.2
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742991854; x=1743596654; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cQRr6w0G6zC7ZGJWBs0blumcTdX6WaxdGqlr3sVH2V0=;
 b=aiaQMlCFOweUF1C4JyZ7ra5OyhCRurytcTTN//s7AZOj3LA2vKrxPnf//1op1N4qv1
 TMh7TfHS3yzfhLivlwGro9uAwOlkxW4pZm52BA4XCEBSmqxDI6nwzWWX/PfrsPWef+1k
 FEnHzODvONUhwnIv5tY98v+5ds1CkenWjEBwibH8cS4pfepJMZZYb+JFHWIY6nkPMyA2
 C+VZ0TCp4I2rseqq/yoLg9DfVe3Wv994+iMKQAx+1BSs5cTQyLKV7GnLAE8ZEpvb9vCy
 ldgycxiW4+EJVcDKEH0a7G/sCAUxHLNDfnTI6DCwgbuKETFKhBcDP+EHPFT4VJruvQ8J
 Vulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742991854; x=1743596654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQRr6w0G6zC7ZGJWBs0blumcTdX6WaxdGqlr3sVH2V0=;
 b=eOf2ys3FkhwY1cv7qdzx5GTUqS2MKuzzAJxcBzYy58Fvn0r4wJAVqAtk2gNhXS7pi3
 8NL+1mq1CB91ANWa1THolyczs1bY1RzB3ZJvxdwJrDc3pWENERLT90aFnGTZmitVnst7
 NiiDHLtK0MJzL7mQTP2idOtHykBjPe/QdMzYkQIy1NQQ2TMQ/yVKbD+aV+OQ6DTyC5HU
 A0R01C/kNwbeJt6+WZZXcwo2pi3KZRPyTGHD3nJR94Wi/KHVaKmL+CKRtYwDFyZranfo
 vQ56MHzDRT0xlSnAgG6sNpUDaegi7xwy1fUCvrEJE2+0K09HUsKTzQo8ZtRReEYMzn9J
 qq2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT6BSKOXUGbCOrh3uqx/HQ4pkT4+/vCg3pgIZHKvvNKQ9KI9rpG2SFyVoAyvO6CB/oL91nRcA=@lists.denx.de
X-Gm-Message-State: AOJu0YxApP01Hvx1vWbMKwmwqV6TxOS+bpPeVmIr5lOi0SQnKzQCjP13
 M71UviKQNeESk3PnBftIHJwS9BkFJWHLzubnYXOwOGmlrVgxr+4Yn7e34e2b+mU=
X-Gm-Gg: ASbGncsveGIXezdgLpNcFl9IdR3/BBzb+0b3nfIEkFDuFsrXGVAfpzoDbo9oS88ff4j
 z+pXCLJd3VkLKEZSR11QChg3habr81HuE1aHoL+JiU3NhQ7He2mjGOtBDdEybmlRSBC11Fja5m4
 fD+v3kOvHceCwaRaO2q7QDlb7eSZk7zmSSiM7HnWmrbR12dKBrOebmxNdRDbUIvzbPL3es+XTrz
 ZXjL8mmQ97hAuDgkhdRG8H8+PT+rAo8F+ucjHZ2mX+sbhgTYQF2Tmx8NVoR9bVazOSCTL0rb9Zl
 Hx9Fxmew4VOm+PvgMg9D+3Y6QGP3IhUp2RGJL/BKnCFYv8ED53d+Ji44/UK00TtIKgfI6Q5P4CH
 RlorWZHq42LcK
X-Google-Smtp-Source: AGHT+IF5L5K7rcffcbpLuAKVxqODJsXxlTWpJdfLvOZSOtdSnetZExQRJapRMvI6HhBZztsNtLhGOA==
X-Received: by 2002:a5d:6d82:0:b0:38d:d666:5457 with SMTP id
 ffacd0b85a97d-3997f9364a0mr17712414f8f.42.1742991853910; 
 Wed, 26 Mar 2025 05:24:13 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65casm16923921f8f.69.2025.03.26.05.24.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 05:24:13 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 13:24:08 +0100
Subject: [PATCH v2 1/3] scsi: fix typo in setup_read_ext()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-scsi-sync-on-write-v2-1-12ab05bd464b@linaro.org>
References: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
In-Reply-To: <20250326-scsi-sync-on-write-v2-0-12ab05bd464b@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HiJHUQ0As//uZbfHPVnNG4S8lluRU1JKy79JCOKudc0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4/Hqb05g4H3bMWr2yJPimjbvyZITV2+AGsIpC
 0dIKlzUbGiJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Px6gAKCRAFgzErGV9k
 thjnD/9xkqotWe1lqCDW84w3Z1FIVE4XDsOXmu+dFIX6f2skkfNrqCKURnx4mxQs5EzEuLFilly
 3Cs5AH0S9nKNAsMC6EL3pHUq8hS7jVfZvk0z1Sdu1N2oi8WK4UojpnBbjnAtbRFkgcbBDOhphI7
 E1RlwvUP4x7x9D4XqONoq1Rp9Pl1z5GiRY2mluYxCx6ffy+CZk68CBSr2LgNXnrglcAUJYBqS+t
 io66lyK3IytOv+uk5TCoytXwC1eBpn1dbhs0HKqtzE/j4WkRHVLF4SpBWS31klXThqO5XbTR62f
 YkWjDxsbNfVoSqWQ62TxPUh2CF4k+MTO05A7uwwb9DILR/+NqhTzXdt7mRnEJmLoNs3MVnNW8Ly
 0X6OVOUCwHbULQfbevhTEV/Z8ZYjTKT3hgJQI19uAgAfxqqEVNQ3k3XM5CXfbWG4dvAklfY2FZW
 iNqaRAWr9emNm1hnanDQwHdcoSvoHTSKIT++GP+kvBKkH9fd/LKEHob8INLL2PICe47dZCUylqV
 f8uvdjzuVQqnf1l+ygDBqlfXj2f8G10zXPDzdKKjNX+5V3ihvIGsXqTyyRNr2elWd5nz7ziipP3
 FeDIeGbHMHSTcvsXYZ+QbQZwBP6jZvBNKHBNdcDT3mvk9dB6mY04QTOEOeCRxURSYWLMUjsylEN
 0IfujQcoHYbb+6g==
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

This clears the 6th byte of cmd twice rather than setting the 9th byte
to 0. Fix it.

The only other command that sets the 9th byte is the 64-bit read, so
this likely never caused issues in practise.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index cd0b84c062252118d250b9305728e03f61736600..34ac47c03ab397ca999abf130d84ccbd3be4c419 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -89,9 +89,9 @@ static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 	pccb->cmd[5] = (unsigned char)start & 0xff;
 	pccb->cmd[6] = 0;
 	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
 	pccb->cmd[8] = (unsigned char)blocks & 0xff;
-	pccb->cmd[6] = 0;
+	pccb->cmd[9] = 0;
 	pccb->cmdlen = 10;
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 	debug("scsi_setup_read_ext: cmd: %02X %02X startblk %02X%02X%02X%02X blccnt %02X%02X\n",
 	      pccb->cmd[0], pccb->cmd[1],

-- 
2.49.0

