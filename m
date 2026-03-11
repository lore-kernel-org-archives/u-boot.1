Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721E2112583A
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D30F7840DE;
	Wed, 11 Mar 2026 15:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UgmD39qg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A0E784127; Wed, 11 Mar 2026 15:53:03 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE6D840BE
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:53:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-45f053b7b90so9111289b6e.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773240779; x=1773845579;
 darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xsAtPAJO9inDC/emOeUk+0PXNvPqXnVlUH6MM/GbXQM=;
 b=UgmD39qgaj/B3kL9ao4Wbz4uEeSuIO94mcyXcQ1UahJJWeM0sBpaM3Fa+sYLOUj86I
 aTkbKlRwWZUEBpqnR8FtmjqqrbQI/fKWLl4zUBElEROwPRY2LWc96JeGHh+oPytixBdQ
 6t990go8hgQrDviiILl4QMxOZnT9Yp87pKhiUUULM/oUCQhErVvFzFh96OB44e8gQcmb
 2QFd1FKsWF9ca8vhnzCWuoHHvbyMLGl5FB1eWYVuRv3zjEQ2g4Wyu6eA8n4bJwh2Gpt0
 h7YcR/WY53oMoc5sONNZByxrH0Np1WEdWtmi9OlAsjOntF93ZRiB0s7hZEEmqOZQvHvs
 ZOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773240779; x=1773845579;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsAtPAJO9inDC/emOeUk+0PXNvPqXnVlUH6MM/GbXQM=;
 b=Fn8UEx/H7uvdViogypGt5qGUh0zOFcprugXEF9UNE0qm+xnqtqEfe9VVH5kXJGAPct
 0GNNX4iDK42zbhUv9MPSKAt3grbOTt3vTUhk6ar+P7yzfTYvkYYELdleqo7crLD1xHWg
 AZVE3dCO1+EV8S3o1zRr347SSrSblIQT52eUV68B20tXuQyyw3dztexjtVeL6U2PUypP
 EgLz7rLtyN7v5+galoVGWJKfBRyihUl0slPdqbe86Y9OpCy7ijEVaQkJTqkNnjFnFlj4
 fU75kWRGFnp3ywKnytxYXaephnPWRwwQJIP98SPF11f0WJvoCVipeg2rUoRccCa5AacX
 0XRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuhH1vxOsz4RTqQI1yL2TYTFlrIyhSwvYkVdTHlQWPPAIq1qETozpae23gSFIrSpNvrA0l+CY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+lSvUQaJpp2ITI+6z2JRCWdTWUbvY7sfoKG8C+m2x7jwq4cFe
 rY84VuvdJjazBappadmDDz+UWm9G/iimjAcbH89nf0Mqf+zdnxQztKH7pRQoz1mC5Hs=
X-Gm-Gg: ATEYQzxXXzPw8yMDKrYd3+pjOPxPz1D6hwle9P87crBhQR5HdfSwi/145cRB2FwAr6c
 H26gnyQxHs4H+Tu8CQZvhYuunNqPe6Y1LfnsN4JMNgerOYCPINnc8+fBVjdBM7sDauMqlvlIFvJ
 3P81+fVnOXat+bKwQ/ujgGTKwGerZougNlRCIaSRmh0B18OSLTOAwdRUsStDk+DLdolYG09//hL
 3McKmRKdSa7ODCOptK72nCg0WHmi15+DHELtCRk6gDl4iJktWQPLjJrZ7O/hCtQHAW0sj9tU/1h
 VVHQx2JbLtYROi+2NzJWJlgeVUKLFxmztQ+lvpupQJjdNbsZ/9AfRBJYGN01+XYDdfXp8R7EOji
 ORVyVerHdPDk2tumPCHqeLIYL4fM4ecgkV7/D3iMst7UGmEj5zk2WrXVmJrdZ+GK0w5xDpoj6fg
 2EL5R05QcbWe2OyenkQh4jN2eVdbEu
X-Received: by 2002:a05:6808:3a10:b0:460:f435:2a71 with SMTP id
 5614622812f47-46733601f03mr1488209b6e.46.1773240778926; 
 Wed, 11 Mar 2026 07:52:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4673415c264sm1361835b6e.5.2026.03.11.07.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:52:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Mar 2026 09:52:49 -0500
Subject: [PATCH] MAINTAINERS: add new MediaTek custodians
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mtk-custodians-v1-1-000f9025b54c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBTG8VfRubYyRHkVuZjt4JDRziYl7264/
 H31/S9gdIQMTXKBw4OYNhsh0wT0pOyIgkw05FleZYWUYvWL0IH9ZkhZFpWMe1kro2sD8bQ7HOj
 8gm33m0M/o/ZvBe77AV+WG01yAAAA
X-Change-ID: 20260311-mtk-custodians-6126047adc7d
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=GMJeq1tXrVR8hhNLJFA/WXIo0Jxk1Qgu40Pwprhinko=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsYHCTGOh1uM1MusEcJAT4mkMGrDtLzMiccxkQ
 ch6dSLUekqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabGBwhYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A+9QH/ieYoEP6YcSPwia+1auC2p1K0YdZTfbDBvC9Nah
 xYpsjX6uUKqPC+sMOi/GeDZM+flxc8unnZpudHnqoB9UILkDyjrjS+nUOqhZvNFvty7XodNmuA4
 2NYp/iNGVaJ9pwQ95FKk9ZMUxrKo7gKAw/Q+OnF9uVziPm8S/OY4o5CJt/oJ8SmIEt3JoR+OlQc
 QOdNkxIxTkL2AXd08U5150Z9ZRdlbJPE1vcouYiZjT1kYN0DDj15keyZ9canYQqnWexdKlrESnS
 r2hv4J5ITqnQi1xABaKhwi7uhKmZklf9bDLHzQMXL1jSXjXzxZXpV7b3GS9ILzdEW/GLy8khSJQ
 PcgY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add new MediaTek custodians and the new MediaTek custodian's git
repository to the MAINTAINERS file.

Julien and I have volunteered to act as custodians for MediaTek since
we have been actively working on upstreaming MediaTek support for some
some time now.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d2508d90c33..ade549fc47a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -414,7 +414,10 @@ M:	Ryder Lee <ryder.lee@mediatek.com>
 M:	Weijie Gao <weijie.gao@mediatek.com>
 M:	Chunfeng Yun <chunfeng.yun@mediatek.com>
 M:	Igor Belwon <igor.belwon@mentallysanemainliners.org>
+M:	David Lechner <dlechner@baylibre.com>
+M:	Julien Stephan <jstephan@baylibre.com>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
+T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/arm/dts/mt*
 F:	arch/arm/mach-mediatek/
@@ -1390,7 +1393,10 @@ F:	drivers/net/phy/ca_phy.c
 
 MIPS MEDIATEK
 M:	Weijie Gao <weijie.gao@mediatek.com>
+M:	David Lechner <dlechner@baylibre.com>
+M:	Julien Stephan <jstephan@baylibre.com>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
+T:	git https://source.denx.de/u-boot/custodians/u-boot-mediatek.git
 S:	Maintained
 F:	arch/mips/mach-mtmips/
 F:	arch/mips/dts/mt7620.dtsi

---
base-commit: 3d252b7beb1328cd6de012d2fa92afabe87806b5
change-id: 20260311-mtk-custodians-6126047adc7d

Best regards,
--  
David Lechner <dlechner@baylibre.com>

