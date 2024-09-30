Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501ADCF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 12:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8465988F12;
	Mon, 30 Sep 2024 14:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="x5Kmf2Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A991988E89; Mon, 30 Sep 2024 14:44:40 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE78588E63
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 14:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso25909675e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727700278; x=1728305078; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ITsepdkflPSwXBnKePx11i3APLsx3e7/kiaw75Qv7/0=;
 b=x5Kmf2WbPio8QwGWr+IXJukCzYGg3KhtpN+fPOjFFYipzpqXr8nYPc7apenB5/NRpN
 OCCrNDldSkDf8xL9AGMfniXiWUlHvRgpioGzu4eTpWmn8ZbaEeBxXYMuVNHLe9jv8sWB
 JBokDVF5V6Em59qMiQdFCLDe3KfrvSkEMLh1B09p+Sh3wWDG4T7ngF60VXVq/jnz+yS9
 3EyzA63r9dn1GxJct2qcxHkGHKZy6vSaL8EOQwvPSSc0Pt26/hwkWwYjEIxXn09S1G0k
 oiMiu2ld4NkRkK7xUtmBTl0hpg950wWt/6kEQjIrBF/6nRW+Ip2KtKErqBxYB08ciLHi
 vl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727700278; x=1728305078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ITsepdkflPSwXBnKePx11i3APLsx3e7/kiaw75Qv7/0=;
 b=qMVVltCuOLCjGJcSLW2wxGVzxTii9lw5VLDmcDzq6V2gaZ/CNX1y1/PJgcXafEYuuh
 6t/giaX86Cp9gHUHJyad9zrZ3aYlTz+O1VLHpOSWi9xtNorIdpFvk1U7t0tqVu/q11nj
 yADhdXK4lBB25Kun9Ye4d+c+9T6FEGWgviVTRYlITVcsYNRK37JQ1+a3HJBQCGbIeE9u
 6dAqSVGTtb6rczsfqTnhGGHzIUWUOMSxiWX/2AibMHZGfTw64ExmARrRmUsc8N5lCNkE
 NoCYnQ2/7Z3Bikv3mCuFYOn+5Rrl330wVWtGq1piY05nymkEB+EFCUDwJhnYAc7uwpJ2
 SfvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXczZuIw1upFhOkruKKTog6wWaQFPN9KdQKT0u7UwNRFcGiH0VHF965ivY2BpPw2JZ0bpC+4zg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2uQVAsMYmXuWttM29ujaviDuv4c09ToGWHT+RVbzpZ7v7pcpN
 WKboM4uuJwrZ5Kc8GM/TBEXbQIhkXslbhoqJ3iIhl6Ax+vBnuiz6mUeuiAkCv6E=
X-Google-Smtp-Source: AGHT+IFXXdJmU4Ea/gisqqSkDq1OZwfim0lC4PxPjXSfUPyNBO8NsOyXO9lzMPt6STBabqsdwFaURg==
X-Received: by 2002:a05:600c:4fd3:b0:42c:bd5a:9471 with SMTP id
 5b1f17b1804b1-42f5220856cmr94442955e9.16.1727700278185; 
 Mon, 30 Sep 2024 05:44:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a36597sm149362745e9.31.2024.09.30.05.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 05:44:37 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Mon, 30 Sep 2024 14:44:28 +0200
Subject: [PATCH v3 06/13] ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-topic-ufs-enhancements-v3-6-58234f84ab89@linaro.org>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
To: Tom Rini <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=979;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=U5rWDVmk+KTojaFG4mSUB4p+9RPDWzL77dGyGCosTrE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm+p0qunYE2KM4f2z8U7+HAEiKAPQhyMM09sJzWI8b
 RsOZl2GJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZvqdKgAKCRB33NvayMhJ0RK7D/
 4kdjjd+FpukSX+OJr7UtF8LbW5xefgzslChhRHIkT5K1xKAkd4kvtt5Ce+1i0jrSVEl3KOczYpWl4I
 5XCOHcF0blBCVOTHJsEj2wzgP/FNMI0Smy8duB2TitnhkYuna9KFpthIKuOP0bjq8ygfjd3hMnff99
 bRiNhltBAz7c+UM2MIpR+YlecfOKLVjcUb8bNLB2M90aq9Klideia6fE0/BqtMzo4Aw5xgpT4iA8ay
 DvEtlvTxB3w/nmvAcYsvgZ9LVZRqEaGfUjDktbvp4ImJZD6EeY60GHvQZ9qTe7oUYU1DpWtY21oUJm
 7j4SlbA15nG2PjhXF/a8Obh9PsIw+vwrywbjj8lN4FrHQl7erW7mCsZyPwL3msHVIXqhFGGjoMnIdj
 Tsh5bGBN+JtOMKd1toRRaiIjxGXqWqdh3bBJ9iCijsm5EIBRTcOz3A86gcuv319GEGLx+3EJKcQPYv
 VTaSLxkApAR8GNJdcY4J6K6HQlJ5oRn0JmX9L9O+Lw9HVWsEwL5hjGhhjJOaRrx9vmoHgGwXTZmYLf
 wvjrJld2mhLxhhBhtNInE/gLmbPadZ65DUWeGoZYjVfiZUjL88cXnQdvGyn7karYQuvnscd27OAb0M
 MQwLg/Tz3X9qAolrsTdvV5+h/e/rSJRvEdwGAXrVzJYGsIQ5exXS4uwSEPuw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

Add UFSHCD_QUIRK_HIBERN_FASTAUTO quirk for host controllers which supports
auto-hibernate the capability but only FASTAUTO mode.

Ported from Linux kernel commit
2f11bbc2c7f3 ("scsi: ufs: core: Add UFSHCD_QUIRK_HIBERN_FASTAUTO")

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/ufs/ufs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
index c92f47d82b5..b55c4a9e996 100644
--- a/drivers/ufs/ufs.h
+++ b/drivers/ufs/ufs.h
@@ -738,6 +738,12 @@ struct ufs_hba {
  */
 #define UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS		0x2
 
+/*
+ * This quirk needs to be enabled if the host controller has
+ * auto-hibernate capability but it's FASTAUTO only.
+ */
+#define UFSHCD_QUIRK_HIBERN_FASTAUTO			0x4
+
 	/* Virtual memory reference */
 	struct utp_transfer_cmd_desc *ucdl;
 	struct utp_transfer_req_desc *utrdl;

-- 
2.34.1

