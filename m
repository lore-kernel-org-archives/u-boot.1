Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC392C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 12:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE7C28893A;
	Thu, 13 Jun 2024 14:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZtjYD84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCE35888F2; Thu, 13 Jun 2024 13:10:38 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D43F6888EB
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 13:10:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso132998566b.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718277036; x=1718881836; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+82QDQJ9Z9VT3O7jHHnU+sHkthFfaQKa9JIG/vJ+Tug=;
 b=JZtjYD84lN4And6v5ALMVWnaUjJ5VHdK9xZpPWjAkXfjm//5wbnwnUUjsAMKLCTJyN
 LQD3bIgheMo3nAEdMpEmhYFvmkqyi/SaojXsn6dfAXmDA3kY5InFU1FOFhaPfxomh4eT
 kPqRlpmp4bhmfssyxd+oSZhYn2vnuX3th+5RLpQN7ywNP7WPiwRqQV5dkMOLwHPyWFCt
 UltZzFwp80I87fNCQTLJMdYXtG8l+eOkrsT1yjdMmjw6V9oYgJMQDIq/ZQ3tcyaqU02S
 dacHfoyYH3AIqTVjYbcLX0mSEOW8iN4Xi7Q+rqqkaEYFZn5ZdQ+RBCoZqHR5IUO/5qEO
 v1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718277036; x=1718881836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+82QDQJ9Z9VT3O7jHHnU+sHkthFfaQKa9JIG/vJ+Tug=;
 b=CSb6I1D+ukSMFvGyHWixmYq4sNbZTAUe5cTl1e/ezY6vq8Gzo+wsXt/+raQkWoSTdn
 dnalVVQaWCKoQBDYF39plkbAJd9LJN0oDFTn4JDvuVbrfxYsp/sclDG9WSgFqvFdwI9x
 lrXmKba6se/QNAGtx0gvdru2EOsYCDagnp7E+tut6RNhk2FyVIEEs6WhErPW+BHxlkT6
 SmcoKiVwt2OE/zxKKhyHeD3sVWXvE0FCs4GAvhDXwgyXp5fTiuOw+zVOdaZ7Finn4Pwp
 MjW6CNsUa+JJaKIlDW3krXG04CjWJPXzCp/ad6ch+HmLk9DmanpEEtd0JcR0yQkDH1tx
 djgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3cj6pEaKR8h+eEHR0Ko7B78rNAugRE+pk5eOnm/kRU5U08KFSJ/fHmM0RVtA/VjQXLBwaSBEh81RfCA/+8UwTKRyN5g==
X-Gm-Message-State: AOJu0Yw1WKNzNWbSRR6vmcKGl1O7rGizmfT0wqQuzqZ9+B/T9mFI4Xgb
 uEfTazb+UIwSjmbkugv5SCBujFAlamHYqZKDmMpI5C0xbQxR6clq
X-Google-Smtp-Source: AGHT+IF8uX+ileWF0CF5Sr1iAdGPyX/QjF9QSo/BtlF9vCBPd3tHezWYW95iWen/rOuOQynllfT1pA==
X-Received: by 2002:a17:907:86a0:b0:a6f:4bc1:276a with SMTP id
 a640c23a62f3a-a6f4bc127c3mr337457766b.12.1718277035886; 
 Thu, 13 Jun 2024 04:10:35 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it.
 [93.34.90.105]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a6f56f416dfsm60580366b.164.2024.06.13.04.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 04:10:35 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng.cn@gmail.com>,
 Sergei Antonov <saproj@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Simon Glass <sjg@chromium.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Mark Kettenis <kettenis@openbsd.org>, Sumit Garg <sumit.garg@linaro.org>,
 John Crispin <john@phrozen.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Minda Chen <minda.chen@starfivetech.com>, Marek Vasut <marex@denx.de>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Stefan Roese <sr@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Sam Shih <sam.shih@mediatek.com>, u-boot@lists.denx.de
Subject: [PATCH v2 13/14] clk: mediatek: mt7988: support alternative
 compatible for fixed-plls
Date: Thu, 13 Jun 2024 13:09:31 +0200
Message-ID: <20240613110949.11076-14-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613110949.11076-1-ansuelsmth@gmail.com>
References: <20240613110949.11076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 13 Jun 2024 14:43:53 +0200
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

Support alternative compatible for fixed-plls clocks used upstream with
the compatible mediatek,mt7988-apmixedsys.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7988.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/mediatek/clk-mt7988.c b/drivers/clk/mediatek/clk-mt7988.c
index 34e7b2d734c..32b04511781 100644
--- a/drivers/clk/mediatek/clk-mt7988.c
+++ b/drivers/clk/mediatek/clk-mt7988.c
@@ -833,6 +833,7 @@ static const struct mtk_clk_tree mt7988_infracfg_clk_tree = {
 
 static const struct udevice_id mt7988_fixed_pll_compat[] = {
 	{ .compatible = "mediatek,mt7988-fixed-plls" },
+	{ .compatible = "mediatek,mt7988-apmixedsys" },
 	{}
 };
 
-- 
2.43.0

