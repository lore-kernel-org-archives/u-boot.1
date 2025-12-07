Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB61D2CE17
	for <u-boot@archiver.kernel.org>; Sun,  7 Dec 2025 21:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5BA083A8D;
	Sun,  7 Dec 2025 22:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TVqvQEkk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95A883946; Sun,  7 Dec 2025 21:09:41 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD3A68392C
 for <u-boot@lists.denx.de>; Sun,  7 Dec 2025 21:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rgallaispou@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so46009025e9.1
 for <u-boot@lists.denx.de>; Sun, 07 Dec 2025 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765138179; x=1765742979; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y4teXt50erjD9K8pdDwURc43gz5TygFDkG69E7LemS8=;
 b=TVqvQEkk8EtA/9G+onbhc6QA0zBHuD70Fa2nKMkWBCqybSwB+sDOtejpyHAGB9Cvkt
 OxSTKo3cBzeWa8hNPYCtWIwOIkJHNo15c0KVyApC6YMIi1Za3mmUWRcyRuE+19XKeBPW
 UUnnWuOwyUhIuAuPznvC0QGeHoFT7qdAEaW+5g3S+T1kM9vhCE3ylHNZW5O851zl0Ew4
 /SxvCbPqliZ2pVJ4BLVKyyGkFktykPaxT8Gy9J0cIzMt64MeGVm1QdcHhh3qroNEN5JB
 ZSJa8teXaHSlgwUUJLz5wQ5JeZENfljGyV33AyY8otiryMCA9f1kdSMtYaxqXAi89rfD
 IDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765138179; x=1765742979;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y4teXt50erjD9K8pdDwURc43gz5TygFDkG69E7LemS8=;
 b=Q+QiV2wuEGKG8Mir+YHfjqrxbKHceRzktqTu5bcE10lkldeub34B8Up+Ade5GOVg/f
 7wQLTohE6pAAd4vmBqt2KEq/72xmQ3KGOXOT2kZbklOFNAVDB8OmcFUReVJufXtdXQ0v
 RgyYNa3jCVAWGB6gvUqTkBMyuJBOplAzFulTYQ+oisk8v2QQJfZbT081iJD+VA1yLHoe
 SaJj8yvQFmGQ++sdYVhvvRcdZkrvsSP9h/YTbItOFuv8u8hJROLWRyKPh0wpomQvZiLv
 HQCj926h14hwEdIioyzLTW5qB0dYUT0x5ZJTAqsd5coiVjnmwm8u9wBSYmXWxKHdJcy3
 nmrQ==
X-Gm-Message-State: AOJu0YzSZQwZX/utr+6vK/GXKyqIueAYacO5w8gunQfaTwDZVhuYYrJG
 pA1aDZuFJP7M1pIIIi2WPPiNj+GmMYpr8GdHviTG06qC1T3vYt/jYpC5
X-Gm-Gg: ASbGncuRt3AUTbeq3mtRvZwf6KLplomDR0sqhyyonVkEsJS9dUSy98R0jHAYT54Q3RD
 N5qkOIDScKi+XSOuxrQxoOdvtlklWjrH+4kwgq/E/CfEK4S7OQNsSJzazPTWDVFrESNTeDvL0k5
 6keuPt6sHWefmPJD1VF89I8Qrfe8CqIbfJZuy2Y6kVN6aCsFjMf4pcpVs+4QIL0W1u+Q4EhNkqA
 1AExuMH8WvS7LkoxZ3WibPW/kxzuFQ26adaifi2UP/2+EvdQhSm14W2NnAGEXohLj/z4F6ah7Oo
 maxKbMYtsMJ5003V6rKa6tKdLYKuuKLr1uG26UWUqcodQgHasmEVMtEMkAwBKOi6DckNdtNfCC1
 a/9Ca/DrDUkFElX4OvavvkwOYyQH5/iNZKjWBfyik7RI3BgYYroE+tBbmjI1P+YVKSC/qsWv+DH
 QCSoJ3LfUT5mPc
X-Google-Smtp-Source: AGHT+IH41BBwqCWCIYTW6gRmMGGq2L5WaHZ9LiscPljUdut+ZZp+IzCGpPf6iJQbtn9mCfE7FJDAuA==
X-Received: by 2002:a5d:588d:0:b0:42b:3bd2:b2f8 with SMTP id
 ffacd0b85a97d-42f89f7f721mr6691552f8f.46.1765138179069; 
 Sun, 07 Dec 2025 12:09:39 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2231dfsm21757471f8f.26.2025.12.07.12.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Dec 2025 12:09:38 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Sun, 07 Dec 2025 21:09:01 +0100
Subject: [PATCH] video: simple_panel: add support for "rocktech,rk043fn48h"
 display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251207-simple_panel-v1-1-8688d221aacd@gmail.com>
X-B4-Tracking: v=1; b=H4sIANzeNWkC/x3MQQqAIBBG4avErBMcQaKuEhFSfzVgJgoRSHdPW
 n6L9wplJEGmoSmUcEuWK1Rw29ByuLBDyVpNRhvLRncqyxk95ugCvGLXswYsd3almsSETZ5/N07
 v+wGReJM/XgAAAA==
X-Change-ID: 20251207-simple_panel-1a910ee5175d
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=rgallaispou@gmail.com; 
 h=from:subject:message-id;
 bh=VaW/anBcLWrrpZQC6WzKCyX3d/22oMdsXGOu/HJCsz4=; 
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBpNd7sa4xT2N09mipp3KNqK3KcX6oVz/+pw+2TJ
 9Oq1x+Era6JAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaTXe7AAKCRDnIYpo1BLC
 tabtD/9S+HJORfRE3ErJeu9Aoa0h4IUcKwIWRQgTjVAD6CF9IbF3LPyavAfANV5w06iYqVkLkVl
 DjPqZf8GUY3G6LzvfdorRE1hIHiEqdl5ugWLcwc6E6vRJ7daqdwx//la0vXu6i/zamuctwp4+e+
 uUORE53wDc2UkBaDzK09uEWhB3LYtdAGAWNVwLY1nWMm8OXDiurPMliqz9DVYzh5ifn1WRoIFYP
 Sg2mGe9ozR6OFbQ9K/C6YjpFthjI4rJVCiaATH8C9LlFm9EaQ2B12UCt8aLrrRgH2F533w6PWv9
 RLawEmrI6OCTegsrDO4uoDTKYD7cfT+y9+r+XJvwfglPFeTPZxuntyRhNA3WhItsKTWl5UXyGoG
 4A8XoBwS6bFFeetueK6OBk5WAsO7JLpM2RBb+tcoc2nvr35JRq/O+QQP8LyaLNmu/tfHQ5jQuPb
 A41y3EZGpx4uSN+AGJ/+p9VCClKvSTaySfSR7euxb7Qvu88Zc58ROCgygKwQbitCqg25ddtevAt
 OI1jGhPnPdQb4uZxfSDgpyc5E53pUN2K6SBA4omSWACrVps3zQ1DqJ+USEdKqUc1gN7lB0rMnwb
 U0TXHbXWEog+4eGAA0MjBjFACuiRJPP+ZBljCChJKixj4C2jkSAyGJuXdPexcBfYDmMeTo1PuFN
 HgJChW16lEhasUA==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5
X-Mailman-Approved-At: Sun, 07 Dec 2025 22:12:40 +0100
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

Add the compatible "rocktech,rk043fn48h" for simple-panel driver.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
This patch has been tested on stm32mp135f-dk board.
---
 drivers/video/simple_panel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 0f23df701bc3..d3a58c883883 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -201,6 +201,8 @@ static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "boe,nv101wxmn51" },
 	{ .compatible = "panasonic,vvx10f004b00",
 	  .data = (ulong)&panasonic_vvx10f004b00 },
+	{ .compatible = "rocktech,rk043fn48h" },
+
 	{ }
 };
 

---
base-commit: c7c2c3c0101f625c01bf101d652e03a6d4aa950f
change-id: 20251207-simple_panel-1a910ee5175d

Best regards,
-- 
Raphael Gallais-Pou <rgallaispou@gmail.com>

