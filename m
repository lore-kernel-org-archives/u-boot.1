Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97DFC52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5BBA888E7;
	Fri,  9 Aug 2024 01:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CSW68MEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FA9788BD2; Fri,  9 Aug 2024 01:59:51 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3873388BBD
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52ef95ec938so1648531e87.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161588; x=1723766388; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3n/U7bezp4FdaWE2SHroWzelPoINOlsWsoUiLqRfETo=;
 b=CSW68MEQMl0AOWLiTF7nhiiCCeekKiQ84wMREHWeS05USUTl+NRlydVHSWfzJ+Gqqs
 jYgNv9ku7s7TwfqLInjhgtT5cRnTNgZebe5o3YhyxKsR+F9AHHK+3OYyoLxTN+4vYIzz
 tkcuSoa3uutsdhRag8gyE9ddb95ma+AM51QlLFiQFUpsxSyGrrAe4kRSflyADxFXhoMo
 7A+TsF6TWJ/6uGEtpLQAIMmXE+9DpFjBrj34b5SURSYK+SGzwDicaqJGl8HA5i7W2aYJ
 FK3WAn2eVOs8gTIyp+Pwfx3xBWfAkyo8WjdvRHQBHkkmoW3a6J6y/y64VVl85icx+yVX
 7JlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161588; x=1723766388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3n/U7bezp4FdaWE2SHroWzelPoINOlsWsoUiLqRfETo=;
 b=jVORkFpvX5/uoqFZ1OvoYIaOG9xH/Yg0au9sPS56M3P+M8LyJ6yKmVtD6KISYdAAq8
 lVxrZkk7zPH5Jasj1xsxNnx5gy8AUspa2MZHnzebZmOkn5BJOJGTDgUZtfTywIuncP6t
 45++vMsGSrbNcD9EGIXVoqZjdc9k5idi6JYhhjSp76iWREhYtE1oy64mU3uSTv9s/uiq
 P8VATt6mPkDVmMEILlZtajJDhhLJQAbcYqlzZ7hv62B4Vfz6zuEwUUzeFiLC9DBFm1Gq
 IlTPT0YXI77ncWm9T8n6CyQus0hz7KJsgByLhP9vr1g1ABd3tFFQHhMsuWznK7zK2nmk
 897g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR0/xpAGQ6Y5uC1nsZSFR3zU6qcE1s/tNZInufASJSErrXekuttQuue+AAH2mniXaE1IVFHoe+wTapYKn8CmyKx/eAfQ==
X-Gm-Message-State: AOJu0YxtFqE5Yx7hj8LSZSma2jucp6L9mD0amdZAxnAPfLJK4UtJeqzI
 GCXPYSSNHBpuYZ04byui5Sq4o8ADsvwJotiEcKUMYWExNvDPPyIZ+lCXZl5hwZE=
X-Google-Smtp-Source: AGHT+IEoBiuApIwS14rTFTLsXfNhCNubRphxkshXY1gnJb99AkDwvejHYcQe3vde7h01IKT4fJycUA==
X-Received: by 2002:a05:6512:1149:b0:52c:e012:efad with SMTP id
 2adb3069b0e04-530e5817260mr2719648e87.12.1723161588252; 
 Thu, 08 Aug 2024 16:59:48 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:33 +0200
Subject: [PATCH 10/11] soc: qcom: cmd-db: map cmd-db region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-10-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=nxXveBh4xzdjBB4rEUL354QZZfPHUXxpqjYxKOOFrmc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvoP3/PhFUqvHIQ+Y6yIcPgWyZmhOqdmZU20
 29isu6ChVqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb6AAKCRAFgzErGV9k
 tjV2D/4i8IcoFZ+vpYACKNhtBYcgiiLg3Xc/qfFvUVBNC4n01jsZJCXcbXR9kbGmfkoRHlnUk4C
 ysiBO5le3SlmUs4uycaBe/Sv0jm0vCS+Ma03ipV3w4VhfA75hgOw08oQ+Drtk36GjbOvHrF6eNy
 YevewpiXAKPKkND/6bsTFR6T9106Zl97hJHWMJzKw5jHN/TtuxZdRHZAMj1t+hlWL93epLZ0udt
 3pY4ORiD7PTBotgzZG9kd25Dg5VjngtqzPFwhWabhMcLEsZLkKmNWWRJPZe0q7+TV31j5ikIPoa
 IMaPw2sphmBbwUmn95k2Omm7738JMno5eqx5I/a8yydQpkj1abuYG9yzWktBAXMQ9FBoD5nwKLO
 x0osbECrjeYa2P8NwKUqWx25oEkRuknkZl9FTL4vuoXOEo4aTsNGSPI/nk0NrQbpY0fgbcv/Yeg
 MQQ+rNx6sLNOZMgS/hfHbbimCNjwFQo18OOLYzTk//8nQFv1CEzJ7xGJDrqR7UIj54xxBevEeKN
 p2TZNd24Oeum3uGcQ01IQtjlfmhZWTW4SbmYn2RE6hM7bFIBsf4fTNumHyvwSCIPFY0+aqgK6I5
 jvPwo7inKyqk0sA8z41CmY1y95Nzxg6phwnPGGo9mSNV3GzAgEPnLHidM4h5+dVm/BA/7xHWoT0
 KC+3lzYrK+HosGg==
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

On at least SM8650 this region might not be included in the memory map.
Use the new mmu_map_region() helper to map it during bind().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/cmd-db.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index c7c5230983d5..67be18e89f4d 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -5,8 +5,9 @@
  */
 
 #define pr_fmt(fmt) "cmd-db: " fmt
 
+#include <asm/system.h>
 #include <dm.h>
 #include <dm/ofnode.h>
 #include <dm/device_compat.h>
 #include <linux/kernel.h>
@@ -181,11 +182,12 @@ u32 cmd_db_read_addr(const char *id)
 	return ret < 0 ? 0 : le32_to_cpu(ent->addr);
 }
 EXPORT_SYMBOL_GPL(cmd_db_read_addr);
 
-int cmd_db_bind(struct udevice *dev)
+static int cmd_db_bind(struct udevice *dev)
 {
 	void __iomem *base;
+	fdt_size_t size;
 	ofnode node;
 
 	if (cmd_db_header)
 		return 0;
@@ -193,14 +195,17 @@ int cmd_db_bind(struct udevice *dev)
 	node = dev_ofnode(dev);
 
 	debug("%s(%s)\n", __func__, ofnode_get_name(node));
 
-	base = (void __iomem *)ofnode_get_addr(node);
+	base = (void __iomem *)ofnode_get_addr_size(node, "reg", &size);
 	if ((fdt_addr_t)base == FDT_ADDR_T_NONE) {
 		log_err("%s: Failed to read base address\n", __func__);
 		return -ENOENT;
 	}
 
+	/* On SM8550/SM8650 and newer SoCs cmd-db might not be mapped */
+	mmu_map_region((phys_addr_t)base, (phys_size_t)size, false);
+
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
 		log_err("%s: Invalid Command DB Magic\n", __func__);
 		return -EINVAL;

-- 
2.46.0

