Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23B0CAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 21:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F4528309A;
	Fri, 19 Sep 2025 23:05:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sdxyvKDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF40F8329F; Fri, 19 Sep 2025 23:05:08 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADBB81D6A
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 23:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4103fb72537so20803095ab.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758315904; x=1758920704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SfE/LwvVFjkLZ9390YoY94vaGd3NWuZGv/mvy1PjAT4=;
 b=sdxyvKDu3Rya0d7X+5XblThsnzlOedSyQoed4O5ktI3euFKWOgXD4kkXVoD2vwchiz
 Btt4jvOBqXouTDUr94T8dAcxwlMezT3cJoGhYFVOrUKGa7VRmwbQZyu3El1KOKv9wp6r
 4GaQn0VZ7wZSxda/T/g/9AidBkl0JmfEc4bOycj2ZbQcC8VInzFNbRjywz9Qs+JCdk9s
 VN2O+6aHlpds7sW97Z/tD2wQTD8G8j6p7Q/BJDrxs4n4DZgStW2DS+YTzTjlRGvEZoue
 OWauXHetQRo43xPVMxxj2Eq/PzXrVgXQI6YPR6jKzTc9B0YJPqQPD8bqGYuWdeiXDKer
 XerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758315904; x=1758920704;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SfE/LwvVFjkLZ9390YoY94vaGd3NWuZGv/mvy1PjAT4=;
 b=qvoSA0yEwzGtob5XPXJ1FqsM9NhghhpJshb57HXDc4CPrIkmE4orhOFOYadV/hWuxC
 u72lAegR5UJnhV52m2HQMpvsZ+ReE1FdOKarqZlmW/9xCfkEyOpB+YmgeTQFnDIW8eDf
 3mVm+EoB43Qv0/Kq6kj/vB7lg5h93swZzD0+e8p/MdFiqBgHVSJ6bzsslmwsC6yVDoe+
 HncFA4q0FUnzdxy3Lk/Q8q7kjMnLi41tFlABIztJPGRJZxIYNR63X3tlGO24Gl00e5tz
 Qiec+Gak78L6Df1z0BNR+mWmHMYFiYF5R46+IVMMCakb8Z6IWqIYHFlfR2fXTuTlM6bp
 w2iw==
X-Gm-Message-State: AOJu0YxjmYxGZ31ROtRpmomYEpXiyhZCvEy0jUqqAHJBLA9z/oCd7BBn
 p3yHWp2+R3pI9I3WWUMfaKpIxmHtpQa0ZUWnQi4hRnbVujHsi3mzsBmsF87pTGKh2kkxb2YeJCh
 XwS+X
X-Gm-Gg: ASbGncuXkeV0bO05O3TpFt3HkYvlgO4lV7kCyUpdy4tBFXteUbvThTu6E+v58eZ0i04
 PFvtVFN9n9yW9DHr2N7IVsQgLsmBamAHF+1g0PjErH0TJzmigX+RU/QUib9ThTn4fLNP/VQ3l3t
 yxQqLGG0p5AuHtRFdGOOkI2RkH6fL8rwflwuSq3Kyk2FZu4gxh1XHcQ9UBDizbrg7kdiQZ8MeaJ
 l2S38WNIvoVsfaFexlgbulUK0S6+ZPgd0KFN5bLSBDYikHWoW4aJB1Fbm0Hv14nEoQradt4UvZ7
 jIX4K7krsIFlRn+CcNq01gUCOQF6DJ9/vwenahce/gxstJzn7vifSoFre74uI60JmZUf6XIgPRQ
 9BIVnmtY/FxCVeIYM24AY238eOyCIorYbkekbsdHRjWEOd/qnMtgHJY+sXiCl+V+rOEdvs4Rc3t
 vCT1WMfRgRUQ==
X-Google-Smtp-Source: AGHT+IGjyU4eByBc1KdOQCp2eyuTt3ZXBzT17jp4xEILLwSdfu5fnHa7wse41zMRW5qSm/j72bv8Bw==
X-Received: by 2002:a05:6e02:1a02:b0:409:d91f:a48f with SMTP id
 e9e14a558f8ab-424819af2dfmr69461025ab.22.1758315904295; 
 Fri, 19 Sep 2025 14:05:04 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-115-235.cpe.distributel.net.
 [173.206.115.235]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-53d50aa5e80sm2555795173.45.2025.09.19.14.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 14:05:03 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Simon Glass <sjg@chromium.org>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yao Zi <ziyao@disroot.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>, Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH] MAINTAINERS: Add myself into the list for MbedTLS
Date: Fri, 19 Sep 2025 14:04:51 -0700
Message-Id: <20250919210457.291632-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

Add myself into the list for MbedTLS.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fb163aa1db..cbb1d9c3e77 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1292,6 +1292,11 @@ T:	git git://github.com/ARM-software/u-boot.git
 F:	drivers/video/mali_dp.c
 F:	drivers/i2c/i2c-versatile.c
 
+MBEDTLS
+M:	Raymond Mao <raymond.mao@linaro.org>
+S:	Maintained
+F:	lib/mbedtls/
+
 MEMBUF
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.25.1

