Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3210C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 14:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47ACB83890;
	Thu, 24 Jul 2025 16:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rAmKB+H7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63A5D83893; Thu, 24 Jul 2025 16:46:52 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7379D83844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 16:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4563cfac19cso11809505e9.2
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 07:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753368410; x=1753973210; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FDpqcerWeHLwEaKn09OLAtgccCiVXA6eF0JEQU8NQHE=;
 b=rAmKB+H75qzUbJUcMO6gZ2983mnbegr3kYuZXaiGZ3eawVEa3S9NkvxPia6Pp2+Oxf
 N4EGitEw3aFRVJ1fZGb6FY5FAGcwSnbW/MvjuRxc0tcUkj64NtvaB/qtTNNIuQ4aqP+L
 hm9IMoi+8R7uKAcoviLt2WYHKrZHdnc/+p64N9Oys70Psp5DSrjbtECgSeqihpdsvCI/
 dxvURBX1ydkigncAoc93gBa2wesNKc+uppUnyF5r59+7PqwOR4vGLSTImgDrwOqAOyp2
 ZMbHwXmZsiMjSe0Q9wnxeiKpgJqNIlEtutpoqxRo2l2NinMl3drXIsGekawAMnnBYK/W
 wcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753368410; x=1753973210;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FDpqcerWeHLwEaKn09OLAtgccCiVXA6eF0JEQU8NQHE=;
 b=wziMzaymKc6grSjBQgLn8mEIlA6SRBvenOHMtDq5nYE0XJUrWXtYHQssldoGvsjB6/
 WFTIRZiZqQTgIAjCcmjbw+eoPL1dqd62kMXFZYruTzahRYjzDecVUBEJyTOEcErbAsWo
 e6H0k3bwQ0a8DCr99XGeQHc9wFpNqy5qfC+7GjjGU85oHAy2bnVjXi4SWNprDGgoEtpE
 L3QpIZGERyoSYWPIDE4yk+ujl9xMLykl9s4q9ld3SJKWqlrni4V5n2SN8YAlcosA92uW
 xn2jRboO1ROpHaNPcjX730mjT3LjRkuR+FC/Xxij8egMYBuqVXPZGIY3D1BQg7DPh0iS
 ZnMw==
X-Gm-Message-State: AOJu0YzDvUFRn3Vozn4PQjBvUM/FbBUkUrLxpgCIUt0+CRhejfnNqwAb
 zdsLy/6HevXZ3BhZM9mYN8q3hi5IWiEgKxP+IRY3/fj5gufCibZs8P9yO6L6K7pd9TQIWkiI2ly
 Ihk70VW0=
X-Gm-Gg: ASbGncsOCmzgtL2kQpZi3Kw2gogQGsFunAl7WapoZQBR3L0jpHLVIP+u9Tc6+SWiRns
 JFpBkVg4jSclmXlgEajeLio3epQPaknk6/GoUqkCcRcX2KTVNXPVGsnncOaMRWmmMMGcyg8znMI
 Cvi+bS+w9T0U1QsVzFIoSg8uiOic/0eFGBzBpd9H+U2KckFxTQ1NXBOKTm6sCPRU5xF0JVLVEIQ
 HWd6hpBrWOdNkCM00eJbXD/2EJpsstlq1bphfz6sVEn0wRq64L9nsoyQJqkkrHc+Dg0jscYS8nB
 7id4AbKpGJL/AuOmU7F6CKoFspQ/sb3XXpMhZOIAaNvOir7DUOwsEYFJLsM7+R8hf2ijaBeSr5g
 B5EejkY3KoDRYDZa1O0ka1g/ITChkOcqpPMNbyQ3WGlrb3oD1K4nxvtwlN5xSYg==
X-Google-Smtp-Source: AGHT+IF44Y/CGF7wdUSxWzx0niRFQZ0WoLJ6cXJRUjzyLoWMHzZcJnrj+5/Xad6T4kJVlZCiKWO1Qg==
X-Received: by 2002:a05:6000:26c9:b0:3b1:9259:3ead with SMTP id
 ffacd0b85a97d-3b768ef72b1mr5858361f8f.28.1753368409688; 
 Thu, 24 Jul 2025 07:46:49 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705bcb61sm22052795e9.20.2025.07.24.07.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 07:46:49 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 24 Jul 2025 15:46:49 +0100
Subject: [PATCH] cpu: imx8_cpu: Provide default temperatures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-imx8_cpu-v1-1-f72f2755f0bb@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFhHgmgC/x2N0QqDMBAEf0XuuYEkVmz9lVIkxlXvwSh3bRHEf
 zf2cdhZZieFMJSaYifBj5WXlMHdCopTSCMM95nJW1/Z2t8Nz9ujjevXlCV6OOuHZ+0o611QmE5
 CitN1mIN+INewCgbe/o3X+zhOHna0w3MAAAA=
To: Tom Rini <trini@konsulko.com>
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

Add setting default temperatures to the weak version of
get_cpu_temp_grade so these values will not be used uninitialised.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/cpu/imx8_cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 4836bddd93b..950630453f9 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -201,6 +201,10 @@ static int cpu_imx_get_temp(struct cpu_imx_plat *plat)
 
 __weak u32 get_cpu_temp_grade(int *minc, int *maxc)
 {
+	if (minc && maxc) {
+		*minc = 0;
+		*maxc = 95;
+	}
 	return 0;
 }
 

---
base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
change-id: 20250724-imx8_cpu-33ede102f971

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

