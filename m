Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02A2C77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 15:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01D1982D21;
	Wed, 25 Jun 2025 17:52:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XTyrTYri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C00C82D34; Wed, 25 Jun 2025 17:52:47 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53EF182CFA
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 17:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso222005f8f.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750866763; x=1751471563; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pOU+Z7Ucibn8xqerzs94iGg5jaPhNadDK8OnSGVTrNI=;
 b=XTyrTYri43miMtkbXIUkVbBBercJ5MXu3YNSZ8gXFxdj9YWftxN5HI4dV7AjRhWe7u
 CEPWnBVlmFGSJ+/6K/hIG0P+Ug/Ma10+fJdgYpAfyy1bnXAZH1fIj7g9G/eye2fy9Xm1
 BmRAXtqAskV7UFKJlsZG5AwhtY86eAP4WoDWETWTtaLHV8Fdqfy4a7YSNlcWEwbDXQmP
 PqcDZDeeQNQKv/ZsEKBiDv1d+HQ47+05LcURYtmZiUP4A2tgPz5rQsCNOr5ounV+rMBY
 cr2tC4VZleKZkDmb3UjCxnhj204g+Agml+gmlDuJvwulNHIVHbNXYV8CW78eE6meW4vt
 eR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750866763; x=1751471563;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOU+Z7Ucibn8xqerzs94iGg5jaPhNadDK8OnSGVTrNI=;
 b=BF04/TXeCFbCORsHJWQG4v9Z2b+YKDnU965gSQtUvDpufg4t7v4pfXv+gwzuS5EPD3
 HpH1wQDW7ZWjtWOtS3jZ6xmgJOiV92RTxGBADGF/71zbMKUM+IOuuVHjjV3qCRbrFSwf
 qbZIeboOvqtHNzCK9qxnXDlED3fxhOc6hUYkogIJmJWR57yotjaHDaQI6seWgl7++nbR
 Isq51BmFfXDztrYXBrBhipbZ5RQVMsQoSemi02qA/5ixNvBrEarB9Yr7mWbdYrMau+kO
 IbuUhyzPT9gWiZz53mje8qgivlkPLS+GjjG8QkAcIYJBWld+N1uIgrYv1FYCrHl2IP2q
 RGYA==
X-Gm-Message-State: AOJu0YzsQG8Aww7Q2K8BGDhzvCWElAYOvCvZh+2oOM0S1ew5DJJCVvMp
 Dx0HC9oYzft8X3CxOuQQbXx8xnOuPM3+LQovpKDY6tim10YI9TEWfUHA692ASZD+ZLrDt5cocXa
 unxJK0p0=
X-Gm-Gg: ASbGncvl2VArNeCqn9QFsn0al5JcudxK21MtP9BgJ7LEDMeua4ydd6gvtAaNsS9A7h0
 R1HEclUdLcMNblTzf75f9b7f+aIgkAV4EudpiUuF+/b92anjEyHEU+0mx/Db66F+/e2oPnivx1x
 xrQSQO+IMTYVfDbt0PmSGYpSvO4NsYbCSW/ukorKMT/YkZfQQvZiLJZjS1QAO9CzPfRze4k/goS
 aNVVEotCqtyDHiITMn8USqlPUtrPMrizB3gPJn6vjYjDGksUtIo+xvvsAWDre9GKkPAMbfldmGc
 SZuoPe6C/FqJjSDEJ5Q8mqF08dHuXZAkZO4k+nSFIj/2tmvG4VWF+wu84lRYHbbyKaBg966OJ9s
 TpNd0/SjQngISRQ==
X-Google-Smtp-Source: AGHT+IF4UOHVPKeKLypHVgqOXYUd90iT3n6Ry5RVczYznu7jyG5ZHR4O02LUAl0EcvcChfp/YarA2w==
X-Received: by 2002:a05:6000:1449:b0:3a4:f744:e01b with SMTP id
 ffacd0b85a97d-3a6ed64ba19mr3146289f8f.39.1750866762694; 
 Wed, 25 Jun 2025 08:52:42 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:8cc3:8d71:1fb:3fe5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6e9esm24301015e9.28.2025.06.25.08.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 08:52:42 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 25 Jun 2025 16:52:41 +0100
Subject: [PATCH v2] cmd: abootimg: Prevent use of unintialised variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-abootimg_fix-v2-1-0d295dc1f1e2@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEgbXGgC/3WNTQ6CMBBGr0K6tqattoIr72GIGcoIk0hrpoRoS
 O9uYe/yfT95q0jIhElcq1UwLpQohgLmUAk/QhhQUl9YGGWscsZK6GKcaRoeT/pIq51Sva9P1oE
 olw4Syo4h+HE7TZBm5K14M5b97rm3hUdKc+Tvrl30lv4xLFpq6VG7swXf1Jfm9qIAHI+RB9Hmn
 H9XMYzWwgAAAA==
To: Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Safae Ouajih <souajih@baylibre.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

vhdr can be used when not initialised so detect this condition
and exit early to prevent the problem.

This issue was found with Smatch.

Fixes: 636da2039aea (android: boot: support boot image header version 3 and 4)
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Add unmap_sysmem(hdr) in the new exit path
- Link to v1: https://lore.kernel.org/r/20250625-abootimg_fix-v1-1-ce1645ac9879@linaro.org
---
 cmd/abootimg.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/cmd/abootimg.c b/cmd/abootimg.c
index ae7a1a7c83b..31620aa3cfa 100644
--- a/cmd/abootimg.c
+++ b/cmd/abootimg.c
@@ -98,18 +98,20 @@ static int abootimg_get_dtb_load_addr(int argc, char *const argv[])
 	const struct andr_vnd_boot_img_hdr *vhdr;
 
 	hdr = map_sysmem(abootimg_addr(), sizeof(*hdr));
-	if (get_avendor_bootimg_addr() != -1)
+	if (get_avendor_bootimg_addr() != -1) {
 		vhdr = map_sysmem(get_avendor_bootimg_addr(), sizeof(*vhdr));
+	} else {
+		unmap_sysmem(hdr);
+		return CMD_RET_FAILURE;
+	}
 
 	if (!android_image_get_data(hdr, vhdr, &img_data)) {
-		if (get_avendor_bootimg_addr() != -1)
-			unmap_sysmem(vhdr);
+		unmap_sysmem(vhdr);
 		unmap_sysmem(hdr);
 		return CMD_RET_FAILURE;
 	}
 
-	if (get_avendor_bootimg_addr() != -1)
-		unmap_sysmem(vhdr);
+	unmap_sysmem(vhdr);
 	unmap_sysmem(hdr);
 
 	if (img_data.header_version < 2) {

---
base-commit: 903eb123236ccbd8ef05d43507a2a910b785bd56
change-id: 20250625-abootimg_fix-51600dc8356a

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

