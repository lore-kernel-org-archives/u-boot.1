Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C72C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF0187ABA;
	Fri, 12 Jan 2024 22:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vSMcGtwF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B37187A99; Fri, 12 Jan 2024 22:35:00 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E580D87A99
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78313f4d149so645948085a.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705095296; x=1705700096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7xeWGRL9Yd8ICW+N27rVeIxpRdKtT/PLBeEgauwnCzI=;
 b=vSMcGtwF18EvubxVnPgcCw5wsaM0dL3t3ayYdFRs4jUmprF5R6b9kQ1IX7XqPBMoB5
 dbnUpJFwt6SbCpqneAMHyEFYzl631QiqQuAh/QTL8IiAfKhh3L67qSl2l1oPq1RsUWsi
 CCktg3FZ1Y2sQRVbx8TUA2Rdg93F8XOJSBn5fwwj6Sk2g0ENfxrG3V7XBLI8/cljeq5/
 14ytBKS5JHq8GPU0TYCRd/m5E2ROVCiNGDR+1OTNm2TaD+qWzUmMzzARtNVCpog2806V
 r3uA0DjWuBDNtNmc2n//knxscXok01Tqz3V8YhtyFgRG0FTgMOzDl6IOkx7i0zwy2+SM
 4rxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095296; x=1705700096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7xeWGRL9Yd8ICW+N27rVeIxpRdKtT/PLBeEgauwnCzI=;
 b=Y4vWcSMgf/X7ZKx1OsqfqtMahsdWsnXPkk59ChuhwwqTObIhlL5WR14T3bgxtQxHax
 kLc9yh0/6PtHRCH6ttrqouvRL5MfPZkzohfzdiMyhAjkl1DVaw8+eKypOeiXi3VB8X+i
 sgFVWIFafF8Ugy6B+AKcdX889svK7xAnMYPbaiqh8xtn+UxEV4e9R8J0TMtvdjMrnVxe
 lViovhoKBzzVux6DwNbxXQTt9ixQ7eoYg1bNiweRPjplktN3hEH1KKeeTH4SJg4/xPha
 K2fkXaLpyyXJ7VNjT0UWCfKf3AayNwQmn/PTHtFojihAL80IBOrNndhh+efuS7viKE86
 KDvw==
X-Gm-Message-State: AOJu0Yy3lf4St0FUbs37TvoPQ4AUS8jZDScmYyUJJxCbSV41uYU9lIrr
 2KfUyCW4gNMsqGVwg2YlFG5m09CApTFsIzPvVYPXQPo1dwI=
X-Google-Smtp-Source: AGHT+IFOtVcgZz832lDsNwbOkVJU2gDZtqP4/4IsSzc7Ei5XeDmtR1jW9PpWtYEHLbVPny6tZxexbg==
X-Received: by 2002:a05:620a:2286:b0:783:2851:7071 with SMTP id
 o6-20020a05620a228600b0078328517071mr2328883qkh.121.1705095296551; 
 Fri, 12 Jan 2024 13:34:56 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 wa12-20020a05620a4d0c00b0078321f3e7c7sm1325321qkn.114.2024.01.12.13.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:34:56 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 8/8] fdt: get FDT from bloblist
Date: Fri, 12 Jan 2024 13:33:34 -0800
Message-Id: <20240112213337.185460-9-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240112213337.185460-1-raymond.mao@linaro.org>
References: <20240112213337.185460-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Get device tree from a bloblist if it exists.
If not, fallback to traditional way.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Refactor of board_fdt_blob_setup().
Changes in v4
- Move the logics from board custom function to fdt library.
Changes in V5
- Rebase the changes on top of master.

 lib/fdtdec.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab381..647459c1b0 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1685,8 +1685,8 @@ int fdtdec_setup(void)
 		}
 	}
 
-	/* Otherwise, the devicetree is typically appended to U-Boot */
 	if (ret) {
+		/* Otherwise, the devicetree is typically appended to U-Boot */
 		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
 			gd->fdt_blob = fdt_find_separate();
 			gd->fdt_src = FDTSRC_SEPARATE;
@@ -1694,15 +1694,15 @@ int fdtdec_setup(void)
 			gd->fdt_blob = dtb_dt_embedded();
 			gd->fdt_src = FDTSRC_EMBED;
 		}
-	}
 
-	/* Allow the board to override the fdt address. */
-	if (IS_ENABLED(CONFIG_OF_BOARD)) {
-		gd->fdt_blob = board_fdt_blob_setup(&ret);
-		if (!ret)
-			gd->fdt_src = FDTSRC_BOARD;
-		else if (ret != -EEXIST)
-			return ret;
+		/* Allow the board to override the fdt address. */
+		if (IS_ENABLED(CONFIG_OF_BOARD)) {
+			gd->fdt_blob = board_fdt_blob_setup(&ret);
+			if (!ret)
+				gd->fdt_src = FDTSRC_BOARD;
+			else if (ret != -EEXIST)
+				return ret;
+		}
 	}
 
 	/* Allow the early environment to override the fdt address */
-- 
2.25.1

