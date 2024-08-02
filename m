Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26818C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 19:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B38588C7A;
	Fri,  2 Aug 2024 21:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mVUnK02e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E38A88C45; Fri,  2 Aug 2024 21:56:44 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6C2888C4B
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 21:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42816ca797fso52506525e9.2
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 12:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722628600; x=1723233400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l8nucA+RjLC2U3M64EokSHoJ9cJGC+dQ9sRBt82bKl4=;
 b=mVUnK02eoqF+ATECplx6VI8Qiifbd3dmQB1Xux8wndnpAgM5et+Gv8zUS5x/xvE0d7
 nP1nH+xjPB8ohDn7qIqAcFznd83H6zl6U5F1/C3qbF49VUiyqpBkhQRezc7AKysqGx1O
 dk0NsIFDrLNxoHlIPRV9ns9nvrHkiHibBVJKXi+aXNaRKGvLBgVHEOUttjVJQnXT4yy9
 oVTRxjKjGt2EB5RkmNUGh7KCY48k7vFPkxuVnhXepTj+xBJ/wqrIc5YmsskKvPnnCu+D
 EpsRvY7eQULg/jEJeCFomALvHjVhy34IKL/crJLKW6S28rfpqM3RNZ7SSWWo1Ym219AK
 THvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722628600; x=1723233400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l8nucA+RjLC2U3M64EokSHoJ9cJGC+dQ9sRBt82bKl4=;
 b=eD7qda+NTTJoIluHf+ulWQyyQJ4uYLr6TJybwoiHJ5yQXXW4yTlQzFxImwPwgr4f66
 2JUowISUoKbClDml/o19LNfbPVeFE0HV8AxVbzKf/qhUjB+vBuJxvcYEBvJpK2YaDyTn
 6o2j8WQD0aJFGEuPd9ZrLs/0z/uxwihZYgbY/qfo5TdiV1YywZMXA2Z47J1LiGoiJ079
 p+OZyCtP39fEGe7bbKMiihAz8Mu/SO26WtSD8K4VWf/kWMmaBK2CyXXyC7FjHHgFU4Tw
 9X9uzCtI8PMSlo7VHk3Pt1mJmUfrD8I5QkxtK7Tq3cPu4dksir9SAQr0xdhrcmm2wZqR
 916A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXURVVNxV4yIoCh0fH/aEW3xySVQCqjwhH6fom/CIGuh5dkdNBj36eMahgL+IbVW8+7hdk+XFK7y4F1jqf7NpTowHCBQ==
X-Gm-Message-State: AOJu0Ywo3vmteBoChh/s7lJZesAu5VpZVhNNYA1lEyJ/N/+MNHYKtFDt
 aVpU/6xgg1Xi/uhHoOqGtEZuvpVMSMlLMwYIQr6RA6oJi5TMqkei
X-Google-Smtp-Source: AGHT+IGS/u49+k/TZqjdUuzQZjcuvn3SzJAkzoxdxW14BmgCR6Ei2BU4ZecAtO+ctYnjhhORioyQ2w==
X-Received: by 2002:a05:600c:46d0:b0:428:29d:4b59 with SMTP id
 5b1f17b1804b1-428e6b09a2emr33103285e9.20.1722628600184; 
 Fri, 02 Aug 2024 12:56:40 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-6-196-30.retail.telecomitalia.it. [87.6.196.30])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-428e6e01d0asm43350485e9.16.2024.08.02.12.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 12:56:39 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Crispin John <john@phrozen.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>,
 u-boot@lists.denx.de
Subject: [PATCH 07/14] clk: mediatek: mt7981: fix wrong parent for TOP_FAUD
 clock
Date: Fri,  2 Aug 2024 15:53:08 +0200
Message-ID: <20240802135326.25303-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802135326.25303-1-ansuelsmth@gmail.com>
References: <20240802135326.25303-1-ansuelsmth@gmail.com>
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

Fix wrong parent for TOP_FAUD clock. Upstream linux sets the parent for
TOP_FAUD to TOP_AUD_SEL instead of CB_CKSQ_40M.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/clk/mediatek/clk-mt7981.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt7981.c b/drivers/clk/mediatek/clk-mt7981.c
index 6e770de99cf..0ec5c943081 100644
--- a/drivers/clk/mediatek/clk-mt7981.c
+++ b/drivers/clk/mediatek/clk-mt7981.c
@@ -89,7 +89,7 @@ static const struct mtk_fixed_factor top_fixed_divs[] = {
 	TOP_FACTOR(CK_TOP_CB_RTC_32P7K, "cb_rtc_32p7k", CK_TOP_CB_CKSQ_40M, 1,
 		   1220),
 	TOP_FACTOR(CK_TOP_USB_TX250M, "usb_tx250m", CK_TOP_CB_CKSQ_40M, 1, 1),
-	TOP_FACTOR(CK_TOP_FAUD, "faud", CK_TOP_CB_CKSQ_40M, 1, 1),
+	TOP_FACTOR(CK_TOP_FAUD, "faud", CK_TOP_AUD_SEL, 1, 1),
 	TOP_FACTOR(CK_TOP_NFI1X, "nfi1x", CK_TOP_NFI1X_SEL, 1, 1),
 	TOP_FACTOR(CK_TOP_USB_EQ_RX250M, "usb_eq_rx250m", CK_TOP_CB_CKSQ_40M, 1,
 		   1),
-- 
2.45.2

