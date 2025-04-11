Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 345F7C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3612F84014;
	Fri, 11 Apr 2025 14:48:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tNA1S2As";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BD6283FED; Fri, 11 Apr 2025 14:47:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C49783FED
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so12312555e9.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375676; x=1744980476; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mxIX89NM3xuPk5XZ18wAkhZkHJGxePGi4hd4adg4MpI=;
 b=tNA1S2AsyQ6m3kk8X8KbwjK0YIsSfziT+NMN35Wuc0eM0sH+Kjb9xYY87iTtbiTVSW
 YWM+s+LTXlEqWXMVBUlGlGJxzxcvO8yCeOnHY310R133NnLeCrv7jUfXE7G6To6SjQ3e
 FbwILScGMqNcvphvL+85kw0bhiuYugIXyoE+Vl0RwlPeARh7m3ljI/HbrRJn9kjh1enn
 sKu2ZO/GjMX7A47Lzw/2EHjMMUaARzwiyIdQhdbyTBhm2BTjElDgik9p2BdGLdMpLtaQ
 CpItvlH41mOcwLNU7eIAJp/Euu4C+z2XMiAFk8ucifwAdtmuB7jTFN0T9UWcvIrzRRHa
 X5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375676; x=1744980476;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mxIX89NM3xuPk5XZ18wAkhZkHJGxePGi4hd4adg4MpI=;
 b=J0DSPXW57EXkd7OF6ufFP4slCBspYjn5v1CEu/pv13NYeX/5O/4MxU8Ay+PWzgKa+m
 yKgowzZ3UvOhAppimtri6nbm5a2nGsDiUpg5hTpr5XZFAimXCRPUH8bdgZ0lRIbCkhYj
 cJcjz88Hgh1sD496UqveMWXJ2TebyRrilLFl3KADgMow1kYrQBSVaKA2GfDsCwpXoy1N
 EAAuUCpNCawW0vUSLgs3EWjE1a+x7mZ8rzW+VU+TLBdSYjakSe/uiFiBB48ttTO96zPM
 l/PtbRHLBvZgQLyop63vlxKuZANvHzOJ5D/jesmOfbjy5moS8i8bnj5EDxjg8uMsowju
 sz+g==
X-Gm-Message-State: AOJu0YwI0r/gdH9WEQRUGh6IBGGugRfCh5TMSaQ04YHm7UI6nYotPKH4
 bntD8wju0am5in4rbqzTliGiV6YR2BUxWXdlJfl3cHMmLnj/JNP4WDx3AOLCMChj/KYSAXJg2Xx
 3SfE=
X-Gm-Gg: ASbGncu40w2QnMpVb9rV17EHxPslWtAGkBwT6YQB3Q7XUHJKfU1nJdREVLY1MDrKc66
 V6DCdbXht0oasjT+6nc+jUxNkJNysWwdmOTX3surmu4Xr8SGyz2SgybKuuK1e4XXZ4yUHpf6F8z
 lEktKBvZqyVKvLebIL6UY0/eogqhSZvSKWq4gMHpREJn3CbOUXqSzqzuBWApsIAiti8gtCd8UWN
 6VNjOcxQWWWG3XaT0ayKwohMEzx8o5H2kb1YdNIQRM+3D9/OSKc5/vKlGtMxYwzXSry+YetNDaP
 ODvAIw+m7ylNQc+sPN3gWBKe6xl5sYyOCElgL8t05H96W9pw8T57YnyqfYROb0mcV+B0ymnagWg
 ghM4iDhsFgViS1PsK9A==
X-Google-Smtp-Source: AGHT+IHHoHIkQKye1gPlTqe1CyyebQX4diFSsrL40ArnFVxztgRzQvNqYWQXr94i5Qdx8RlmmiQ7kw==
X-Received: by 2002:a05:600c:1d8c:b0:439:9737:675b with SMTP id
 5b1f17b1804b1-43f39663a6emr23495505e9.7.1744375675964; 
 Fri, 11 Apr 2025 05:47:55 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:55 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:41 +0200
Subject: [PATCH v2 4/8] mach-snapdragon: of_fixup: remove confusing log message
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-4-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KdNHBh7X+OPCjALeekUNGdO/oJkKXN6mVkabax6dwP8=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q901/j+VvwVjjNE/jIknclxqqzDrYrmj3XI1
 ktytHYmFj6JAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPdAAKCRAFgzErGV9k
 tgG5D/40xHVxMosISGMOCQvL3J2S0LfmBPKFxHd+YLPCZTH3fxGn60EORod1xDzQ6qL9minM96H
 6fzqh6OIaX32xPpENuO4i/CaZD14WgLhwTRaK6RBEPH8DVNtAv2R+MdB3eRhjS1FdRZ1/rPLh68
 WnHfZgem51lxfXXZHzk3RhdAQeNoYgNw8SRWx23XgIdd53WgQDvfAqD9CwZJird2i5GJGUk+uIu
 X4gu35pncwmV+7TsBdjd4iGF1CtfCp4IU50RKLXLaX/gQ5TtXToBvlM1J7wN3Y0ud+bXaXGgAkH
 ywbswaU9evmt9Hffqxdn+qMO6uV1A8nBujVErVuNDyTiVkoLvAanj2idIPT82oyvc6Ny5Y2fg8D
 TUHIyhjPggQ76Ygnm/g1bJ+EOJi7nLWa8vdvwURxH4FBTS50HrCE/RoHR5VsGmjVNwwRrNoSVdN
 NnMHTV/pPENLPHA7wvIiDQ0yDi7M6yO0hoPYuQY0j3xJbcyimFieroDpKqcCD7c9mUIMyXNKxW+
 x+1NdRC8oCrbzCatn63RTUGsngMLksBKsngWRV2tjny9sgiaGKCkri5B2MxXVRhb2zJ0fHMZioR
 vL9ou5sus1lpZoFIfva9IVreyiCmSotuEE97rRDiG8UuR1uR/f+gzCcE7zYb5CY+on1g2BbD6aR
 VB0V2R1vgJV5wAg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

The debug log here had the logic completely backwards, even though the
code is actually correct. Remove it since it's extraneous anyway.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/of_fixup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index dcd09ee7cac3e02287647c9e6df5575651e18e85..a5515c02d3de05944dfb7c1b2a5542631b517497 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -72,13 +72,14 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
 		log_err("Failed to read second phy name: %d\n", ret);
 		return ret;
 	}
 
-	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
-		log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
-			  second_phy_name);
+	/*
+	 * Determine which phy is the superspeed phy by checking the name of the second phy
+	 * since it is typically the superspeed one.
+	 */
+	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy")))
 		hsphy_idx = 0;
-	}
 
 	/* Overwrite the "phys" property to only contain the high-speed phy */
 	ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
 	if (ret) {

-- 
2.49.0

