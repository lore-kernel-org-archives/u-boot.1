Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2005DC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 27 Jan 2024 23:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B445880E0;
	Sun, 28 Jan 2024 00:31:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q2HNysi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20F7688093; Sat, 27 Jan 2024 23:55:07 +0100 (CET)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE0C9880A7
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 23:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raj.khem@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso1721309a12.0
 for <u-boot@lists.denx.de>; Sat, 27 Jan 2024 14:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706396103; x=1707000903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gFthddfxLg04QYvDdQOCyfM6gabE/bjKlk/Kgca75Tc=;
 b=Q2HNysi9w9tIF8ue7nX4RSw5C44pwLRirCSqgrVFEskKFypoXOucL6TMlkwUnGyeth
 5DbheFBB0Wzmoj6Zncr4T/aARc294Uofi3HcftXh7Pg9UhW9BfZrDi/OYOqtzwp4/BjT
 kCwGqujAe3PcZb5msl/fYRegezNSgO3OMxIc7imFVDwOjlvp0a6cJaDEDiEGfUo1KgYN
 YVfcidvvnG7bPm6LfbSsPbWejC8ndUzB4OkSwHWyv2hEGxCIq3Qol4niHqQPxJdfweo7
 ruEbhJWSZsoDImhvNVKdLslQz7KTahvNm9dKeTXYdyy/Fmayuu97uMYD8KYNoW8XNru5
 cUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706396103; x=1707000903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gFthddfxLg04QYvDdQOCyfM6gabE/bjKlk/Kgca75Tc=;
 b=oTQnGpPBZhPhh5w4jSQI1xYcVbsN500Bh+jn9WdN5B2mrSriiQ2rd7b9t1ZTq6HcpO
 d2NhI6m0S62PjAs+NEKnfdrrONcDag9RULjav7AnHXxJMBYrefFooWJ3ARK8zZiyLh8a
 sDR1POCYV7wPLSSKZ94QgT1EXwAu/4gFnwD6DvWHvgmdQTAy5wsl/0LQ7ipppuxihgVF
 ctPDdjEgjuIWgBBA/ytI8kb8AMgeLfIHRSMpKpfO7a10Jh6zp/IOslJBCiabadZPvyZJ
 BvsPMXnjsGxIplcPstXDW6A1x89tKCOZNvZay9shBkzC5tYbgVFjMTVg0atYJH6FaxoU
 nBTQ==
X-Gm-Message-State: AOJu0YzzS67EoBIgNCwY+Hkr26uEXLqopdv2mOwIJUtxRGXLk+FMbLNu
 w+BQKP9JCmQUqTsxmgHZSEWdr8W8X7tlSB/8235y32EMdJ1oYatLyI5iSEpThXc=
X-Google-Smtp-Source: AGHT+IFSuCJ7HLWWoEhklXTpcQZvF4GfsutLy5UnoXqa57hO57CvxRAq/QnPWM6u/GWNbxqyh0IhPw==
X-Received: by 2002:a05:6a20:43a2:b0:19c:a481:fa5b with SMTP id
 i34-20020a056a2043a200b0019ca481fa5bmr570793pzl.0.1706396102614; 
 Sat, 27 Jan 2024 14:55:02 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::b77b])
 by smtp.gmail.com with ESMTPSA id
 p3-20020aa79e83000000b006dddd3e31a8sm3242758pfq.219.2024.01.27.14.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jan 2024 14:55:02 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: u-boot@lists.denx.de
Cc: Khem Raj <raj.khem@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: dw_hdmi: Fix compiler warnings with gcc-14
Date: Sat, 27 Jan 2024 14:54:59 -0800
Message-ID: <20240127225459.3064283-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 28 Jan 2024 00:31:53 +0100
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

GCC-14 find more warnings like
"make pointer from integer without a cast"
fix them by adding a type cast.

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/video/dw_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index c4fbb18294..9294d9a82a 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -78,10 +78,10 @@ static void dw_hdmi_write(struct dw_hdmi *hdmi, u8 val, int offset)
 {
 	switch (hdmi->reg_io_width) {
 	case 1:
-		writeb(val, hdmi->ioaddr + offset);
+		writeb(val, (void *)(hdmi->ioaddr + offset));
 		break;
 	case 4:
-		writel(val, hdmi->ioaddr + (offset << 2));
+		writel(val, (void *)(hdmi->ioaddr + (offset << 2)));
 		break;
 	default:
 		debug("reg_io_width has unsupported width!\n");
@@ -93,9 +93,9 @@ static u8 dw_hdmi_read(struct dw_hdmi *hdmi, int offset)
 {
 	switch (hdmi->reg_io_width) {
 	case 1:
-		return readb(hdmi->ioaddr + offset);
+		return readb((void *)(hdmi->ioaddr + offset));
 	case 4:
-		return readl(hdmi->ioaddr + (offset << 2));
+		return readl((void *)(hdmi->ioaddr + (offset << 2)));
 	default:
 		debug("reg_io_width has unsupported width!\n");
 		break;
-- 
2.43.0

