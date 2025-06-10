Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D13AC677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 16:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6AB82B20;
	Tue, 10 Jun 2025 18:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H9qL5P0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B10F82B20; Tue, 10 Jun 2025 18:51:15 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5CC482B20
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 18:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so39931225e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749574273; x=1750179073; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Hy9f1fn3I5ALecq0gO7fGgrlqtFF5LhMfrdPKYET62Y=;
 b=H9qL5P0pYS2QmY3rnMBwbHCOUngkiyXDN0mgG2m/RRZaEtZx6hF+QunjABp2N6EceM
 Fqde7WcZqSKW69jlWnEZCLnZkFdTc2MyWcCS/EZ3JYmnR3tt152GLK5TCnPmvk7TpT1Z
 C/boZttqeHVvHy22nuGynWpr8lQR7/UE1o22Ead90vC7FQFFMAtPHKc1Oi3TCzxXPgv+
 1ZGXfL0Jb9rcOUtS6GCgD2G/F2T3leS08zIVwdph190/DX8dZjsfqaoWOb+s5xJo0NMW
 mgWtyP2QsmC5SLB9vHnRfJ3FCn/FExvlz1TQv/HAGL+KxXCnxeACXe6Up6qIM3sXzZ2N
 DGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749574273; x=1750179073;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hy9f1fn3I5ALecq0gO7fGgrlqtFF5LhMfrdPKYET62Y=;
 b=uGNG6D0DGnXUTs8iPLLnZiGCyyyZznZ308FcQ06EVBHh64o3ZkeL0snp1C0UP3KJ/9
 X7vkbqJGwXKcc78BUZTOX1pzAj0bAOLzwFjwJN0/7tEq1sPuf9RmVelK19Zaa8jdE98a
 cCoZX2esY1CJ/fKmMn12MxAd4Xym/cOXa1UW/rGDYIdUAiE/JRHUUkdtAXInoBewgbCy
 L9GxG2y1gWY+PHu5KxgYlwq9ZxcrvDNn8BwgobydgmqxucnvLrxqReFmFDOXrzjGMLvp
 Hj5FLyq54KXbS98ENNAO4YZZTL4pifWap6ehpooQAPwxbSZ6PKJUDlCdtWMsNobrWBbI
 /JfA==
X-Gm-Message-State: AOJu0YxKcIf7thtbFuacz3YsSB8e4VmSMTd2NYsSbjh2MZ4zwZazf8FC
 CSr8S/usarM4t8HXTU8YNTIYtPxDm2NZOzIrrganJhmOrisp2BJiwo93Jy01qkqFQJE=
X-Gm-Gg: ASbGncttxaQYJ3aplzUO1Vpp0IQH4xmIZXMx0WctLzIDLGx1gJIRUOFthKEheugMNdG
 day45GiyHVNN642fdxvxaJvSu/hqrWAQAgQuboSrXTXoW8HqW5qN3+VsstKgfCN8Y4oGM+hEVEQ
 7EMBNPrCskr30Jgrsw7xLr8Rj8qLpQUFuJvawHYUw9+MVbKf3sppsFp1LQ5N+olVvGoJ9E4+IMQ
 FqeCs67pzDbucvnuTPf1m275ShzSOfC3JmMGFy/5P++fSbI15kkYhYWvffaGw/HJFmjTP0LyZRT
 vqB619Wo+DgzRYDUPcOWAuNk2WbHPFLmxXM7H5ZJpNjFf6NJntd4dV1lBUqiRWmRZ7S+3FQ1
X-Google-Smtp-Source: AGHT+IFhIXhktGQkvB9WIiohvnWBtddfl0q/WbxiJjSIfcqNGw2+o77f/7SuiKohmQwmtRO07+I/8w==
X-Received: by 2002:a05:600c:3555:b0:43d:300f:fa1d with SMTP id
 5b1f17b1804b1-4531deaac7emr36967665e9.31.1749574273091; 
 Tue, 10 Jun 2025 09:51:13 -0700 (PDT)
Received: from toyger.local ([2a01:170:117e:fc:3626:366e:4bd3:97c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-452669ada25sm148665345e9.0.2025.06.10.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 09:51:12 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 10 Jun 2025 18:50:50 +0200
Subject: [PATCH v2 1/3] i2c: geni: fix error message wording in clk_disable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-geni-load-fw-v2-1-7cad6bc18db0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=kzBWmmFWAnrmw5DkvENtcU1+kVlPOh2dJ5Hl8gqjEzg=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoSGJ+8rSEShSxwy1SzjCCy1r7/gmtEDaqarRXN
 PRV5zAy2qSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaEhifgAKCRAFgzErGV9k
 tkkBD/4zFqIWxQJnTF6b/f17+/M7wV7i910nyL07J9A4YdKLonBC2nEzARhmkKxtbUBKVUsG/iT
 g9e1Jsty0CpjfOPJJyMh0VVKoQd978yzIUVckHD9JmosIzq6803jIZ4QERO7IWr+9WPFNTd2s4J
 3aip0M5fP4HAgQ9tPf5py6BVK82q4D92BBq5ITCkTBR3MfGYIlDBPaRomzQrjPziVIb/z79hzqx
 2Zp/R6d+FZtq77IQwOxH95frC+OsF81OlAbOJYf7xnhty7p7YiYt45Ck2gq8whXfAdrmncXfhT3
 o2zonLpx2gOBqTeHiss+JPsQKhR5vY17seX+0LNFaZGu8+jVaUWCNscd44zJB0IfVWaqgXgp7Ay
 FN6pU708TjHqt19tnaIVgYjvWhr24EalYWNYnYoV7kKXEypfdi8jIMZzno6rmSF0aFUoNzpUwSg
 P1kvx+ujkSUqMkjOBpFHH/sep4FCbGTdKzBpUhANZsPvFfmyYg4ozozIZjDLmXNTQIwGdBOHRMf
 4lGbmLpsZNSIq1UPobWaFCN2ZL+1O1ULYQOF40DpJ4AKddyzY/OCMWti8Mw5UenolP/Xxe1d1Za
 QiiHK+NDkcCuCIC4Y4//AFOFzzdwaTrAQmmMUBcO3V6Xi6b+Ulk45M2ibE2gS3eFFzTv/jYthEw
 LsJY2Oep9fXCyEQ==
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

Correct the error messages so they accurately describe that we failed to
disable the clocks, not to enable them.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/i2c/geni_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
 
 	if (geni->is_master_hub) {
 		ret = clk_disable(&geni->core);
 		if (ret) {
-			dev_err(dev, "clk_enable core failed %d\n", ret);
-			return ret;
+			dev_err(dev, "clk_disable core failed %d\n", ret);
 		}
 	}
 
 	ret = clk_disable(&geni->se);
 	if (ret) {
-		dev_err(dev, "clk_enable se failed %d\n", ret);
-		return ret;
+		dev_err(dev, "clk_disable se failed %d\n", ret);
 	}
 
 	return 0;
 }

-- 
2.49.0

