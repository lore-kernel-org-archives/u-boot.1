Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698E9CD98F2
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 19:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 300FF849BB;
	Sun, 21 Jun 2026 21:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2WZ8o2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E763484874; Sun, 21 Jun 2026 18:47:15 +0200 (CEST)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D776484119
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 18:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xerikasxx@gmail.com
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660e9fef1d4so3538456d50.1
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782060433; x=1782665233; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fjuUz6uTucmOvvrSAyx760d0HnNGCFowoPAbxV9/R2A=;
 b=H2WZ8o2Ngk5P6uhjbEaAKuc/orm9uoU8wWR28W679Szln6afAoEIdfYsrVv0s5fkMi
 kV2rWOvFGAxIBrmB0kOBY9YTfrOjZGyIon8kUhvz93M6Jkc94BAarx7VcdEJIua5FYPT
 FtDLXfDePNw41pJLj4RYrxiY8mVRlVo7fhqPnwxlXQs70n3e5yVfChQrQZr8LVa+SM+i
 ohXOHKSlBMX6WuMuFH95meDt4AH5OWWI+cLep9tegO0YUhuYpLRm2S6VHRBVS0JpW3FV
 ol6JhlmBTARA1xnZRItkhWnFlCPt1aT/eHcEWs/NtPnlZ6nlStQxs5pcoNzBQGC2uaEu
 6d3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782060433; x=1782665233;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fjuUz6uTucmOvvrSAyx760d0HnNGCFowoPAbxV9/R2A=;
 b=Yx3whWr5Cv5jKxRvq4uqG4JKJ1BaD/UB034LMyJqD1WxuijQO964G+b57OwFivT2Ed
 BVBmxy2HxFfbuWMtR6T33uhGkpO99PReaSY32BCv47p9VS32u1sCEY4KkSFUyhkDY3iV
 cVXl1lhmrPPWR/lPPhW+YqnZxHl2vFXc9OFW4LIsPgGPXqRw5bD1CLAvqcXvFnHpFmqn
 j9LU8pCMy59Hzz1zfhND7RxnEC7j4PTg7NzguQ+ZPg0QhS3vKQQmRftaJywO2GTUecKR
 ztLpHZieqXg6OxbZ+SHCroNYZI8dRzGRGO2itdG0VXyom4AWgfoIqB8SVflmKQGoyMFz
 UStg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqhi3k8P7vEwxzIRCCAWSotuvkQIRS3ck96/Otv7xfW2Pf70bX1vJcgE+1FBj2oOz03/LVIFP8=@lists.denx.de
X-Gm-Message-State: AOJu0YzX5L5qr0L4TNUPw0cpDtYFB/4wDRVoDMHr2XKrwmXMGCqJWNJm
 lEYia8LQa3XoFqGXJUzjcRNyYFG1azOxRKhp3Z+q4jh+YFzk1rJJtyg0
X-Gm-Gg: AfdE7cmVtBrQxJkiIchW8bfrk51M5P8sHu8YYv8CIOrVee/U/BrzjinCfTlIaORtwdI
 8EIC/OkO1Qot1eLTxPb2CpM5Oj7exuhxZVvRW/Imzxr86Nz8APzTqVevW0ZReK4KiSt42pqULDp
 C05E0QF0pjoBXIpVFFzpPe08wp7NcqelMi6Gtkv+CX0b0HlNm9ZWrfCb7pHrpdsu7okOpwdTts9
 WvLNoXgqhi8K8RELVSte4ETFtRaE70tJHLKcW0U8jdDjrYUm7ynjnSoGGfpaBhiplnbS5fDBdhx
 vDzIv8SEwWR32Wv8NOG3qpedTMSI3Bdm05i9b6HKu02yrzPOjj6nfs/lhFfS2HevJToFqGID9P9
 MKbVk1Ch8+KKq6GJsDRt4B/3fn0CYP6Upus8yKFrOSGfT5RkovQFlorEb16tTOnUyCmb0yIkdJE
 X+Zs+W93ObH8IVCXA=
X-Received: by 2002:a53:b3c8:0:b0:65c:477a:2ad7 with SMTP id
 956f58d0204a3-662fc7ea94dmr8866708d50.25.1782060432591; 
 Sun, 21 Jun 2026 09:47:12 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66314d8c3f1sm2498215d50.15.2026.06.21.09.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 09:47:12 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 21 Jun 2026 19:46:23 +0300
Subject: [PATCH 3/4] qcom_defconfig: Enable SC7180 GCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260621-sm7125-support-v1-3-5ad69a39781a@gmail.com>
References: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
In-Reply-To: <20260621-sm7125-support-v1-0-5ad69a39781a@gmail.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Vitalii Skorkin <nikroks@mainlining.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Paul Sajna <sajattack@postmarketos.org>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Sun, 21 Jun 2026 21:02:28 +0200
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

From: Vitalii Skorkin <nikroks@mainlining.org>

Enable Generic Clock Controller for SC7180 in qcom_defconfig.

Signed-off-by: Vitalii Skorkin <nikroks@mainlining.org>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ecd77388763..115a37f3bc3 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -73,6 +73,7 @@ CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_QCOM_SC7180=y
 CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_X1E80100=y
 CONFIG_DFU_MMC=y

-- 
2.54.0

