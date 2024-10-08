Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E377CEF16C
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 12:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 832CF888BE;
	Tue,  8 Oct 2024 14:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zZNNr3Eh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B10288A43; Tue,  8 Oct 2024 14:58:28 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CFD188413
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 14:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37cc84c12c2so3003403f8f.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 05:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728392298; x=1728997098; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gcWlVXet1XNhlBgukl4wg1CgmrOvAOhAbQW4Tt42w3Q=;
 b=zZNNr3EhAJaHOMSAVTICzJ1Tv1iLb8zJyY61XghUrW9yWhOmq30lcXYA3P5+/3SkAG
 AuK1jULVLRb6CihdYDSsyEUJblf2V7dDBMRF59PcBblWIc2YLzDMwwnyzlPcZM26Gi4d
 SN2/P6j3oXuSuk6WQA1/ErMLmGKMTfFaGAvePOexVfQz93Gvi7Fz1G+3OxkFS/OOmGeU
 ykrV/ZTOzEIfv/yLpxGcYHNQJ3ebJ91AJYlJe3JFfG0amzv+ZBQ637OLxoFoLzJhY5Gx
 ahkx7D7nnRViT7HOPtsbFwnsqSHMzzWZoN8sgVla1cc4Fhx4v41G0uHzZhPx86r4U7eL
 QPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728392298; x=1728997098;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gcWlVXet1XNhlBgukl4wg1CgmrOvAOhAbQW4Tt42w3Q=;
 b=rb+806Y2J9dWDZpIExlYcHwM8XcgCnexCpFnXJnea6KNbG9O+t1OB3nBeLTqUtxahG
 Z8jo5K73qoYF3bXOKbzvt2jc8onpVKRk/CHVfo7eXSZTYSdTgjZdCgGgQw10jjkFpeni
 itGENugvEnAjfqMeQC58nQcqlf5zFGo5zfAyoZ680mKYmPlWQsLfpJjTwIg9aWGc5Sn6
 N2Vgs3fgvH4IEuzejISV3Uc0ViVnlvr8kIlEQKpmaB2iSk277hda5Rr2WMB8CwzT61Ds
 W6PYPHS466OVSyaavDR2hWKCWaMCalPgcLE+x5xHWgJFEJqZAT/CR3HXFjHmj/51k5sH
 VKPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd0snXy5Yc4YXrL/40qoP6NxQItmXDKCqdVd9nbgQ+AeR6JUJNcwFE5+vL5/1D5LTvAIjXPow=@lists.denx.de
X-Gm-Message-State: AOJu0YxfKhv9PhcGjlIuotkmHVodKo1lM7e4cuyX8tPMGxloe8RLBcXm
 icFuNYekwGrZsPPtRdMydnVWifQOHLFViaDb6I062ggGs3rtLkWfxKiYN7NVqoY=
X-Google-Smtp-Source: AGHT+IGLFMCVYA9GJaKhXSMQNoogw+EYsUoTgQJpkxi2CZcMedFrgEwu4/GV2XFZ5jJEA9hmnNvsGA==
X-Received: by 2002:adf:a198:0:b0:37c:d20d:447c with SMTP id
 ffacd0b85a97d-37d0e779f64mr8866519f8f.29.1728392298571; 
 Tue, 08 Oct 2024 05:58:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d16972a69sm8062855f8f.97.2024.10.08.05.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 05:58:18 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Oct 2024 14:58:16 +0200
Subject: [PATCH] video: meson: dw-hdmi: do not fail probe if HDMI regulator
 is already enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-u-boot-video-fix-hdmi-supply-already-on-v1-1-3a12c73ff3f1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGcsBWcC/x2NzQqDMBAGX0X23A+SIP17ldLDxqx1wSYhqVIR3
 72hx4FhZqcqRaXSvdupyKpVU2xgTx0NE8eXQENjcsb11pgrFviUPlg1SMKoX0zhrahLzvMGnot
 w2JAi5Mw3Ht3FW/HUarlIs/+nx/M4foKyiIl5AAAA
To: Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=987;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=wSeYiPwevyPWKoX50LCHlizqsN1l/u61R9C7SSOu2ws=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnBSxpMEWEFlhytL+M6w+nVX8qKuQnlsHycAvWS0jT
 NKqFaouJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZwUsaQAKCRB33NvayMhJ0UkgEA
 Cjf5Zr2He5xW0PmEy8enFXBs3J5Op+CYVgLaOeB0eXt/cnXYKvbKDz9S/z4iv+mIznFrHTKjETHCte
 k7+SR1QavtkuH5DMY5dycSsERvlixjXaQLhzMUHQYSMqaBbi7TYVTgmcCVSeVFaC7vY6xcpn4vB7bH
 vv65/fmTnSNmJsV6UGY5RBsCQPHyxzho6/QPlUljzofizrlwA/SzFP9N8OqhmQmPszGW0SomXEo4WW
 DUHmqMBRNFf2XDNGVJ9a68e7A2Zzz0lNzMgRK5Tp+pLVg6qj982l2XDRHeKxYua4yxLZ3M6mJx/HZm
 g/W8CB1bpPePsW8hR8Jx7Phd29VP0d8ugTzvngsvexdBULmpRzsisNPFRsX0N0509zY/vMRWLH5iM3
 mVG40XUx3IeLhc9l83kgXP1ryDP5OqKDOxW5wKlcNdcrfwqkHa2oLleAUuHfrkB1HEs2ocVSOdk+u/
 TO4WwULBfl+9N6GFxkjMPHdCDZb2kVE+oV6Bsy/IzugfNtwwff+D9cMn3rrmjtptgYXpKFPaWjjOGn
 pF8e1VxJeMR09l8VDRea6lDDLNPD6pPP6GWJFJKR3/r/BcABvLsEteeSY8M/KzQHWHWvcUr3NBSd28
 jdHecjKzOAhn/niuupUSaONMw7F86IKuvq3LWd34l93lnc21ehIg4nVJkZMg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

If the regulator is already enabled, this happens if the regulator
is set in regulator-always-on, regulator_set_enable() return -EALREADY.

Ignore the -EALREADY return since it's not an error.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/video/meson/meson_dw_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 587df7beb9b..ee219ce6ec4 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -419,7 +419,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 
 	if (!ret) {
 		ret = regulator_set_enable(supply, true);
-		if (ret)
+		if (ret && ret != -EALREADY)
 			return ret;
 	}
 #endif

---
base-commit: 28dc47038edc4e93f32d75a357131bcf01a18d85
change-id: 20241008-u-boot-video-fix-hdmi-supply-already-on-e6a9af27b1eb

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

