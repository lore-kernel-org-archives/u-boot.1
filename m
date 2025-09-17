Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C12CAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E94083817;
	Wed, 17 Sep 2025 18:22:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="NiuGiLlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A72980C93; Wed, 17 Sep 2025 14:48:00 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23475833ED
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b046fc9f359so1032635866b.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113277; x=1758718077; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MMKPfW4D4AwJMRgjpVpfVqHdH6NwvNYKSDKuZZkUWjw=;
 b=NiuGiLlRTCyTi1pUpsUDl/Uw4O9nXYbkM/VyAg6JYjCooDz6jRa8LZEyXS5uWCmsNW
 mQQsGbZcgOivTN0TZBcv2SPSWv5dzEs3sGAer9rw89MOg/6fGDaOfGND+Z+FVRS3OHQ+
 SBxdPOaGyMYhErrzJHP9magI1+5lY/NrNNBp4zqv4xbD+OIgb+Xof+kG4I16PzMQD2Wg
 y5ipCD5Uhf+CBgCpjz6MzC50cjb9qCDaB/PClKH6cxTWf6qUoT2xG+Kr7QYQ92LP+T1D
 RrdLrMTCJcoCTuisb6zV7CCIRDMG+kMONWOMRrBYWvwHmQjTHAuCpYa70qy5uIQSb0O5
 Erow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113277; x=1758718077;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMKPfW4D4AwJMRgjpVpfVqHdH6NwvNYKSDKuZZkUWjw=;
 b=MCRF8ISRYYIpH+2um/7NPKPAlajADwedA1dFy+mReerXHZqrczjtsZiALz2YoUHd5H
 LdkPMwum9y0fuxBdboBHg8+LSp+wVkb9gjkvc2d758UTKMuCX37TrgG4DgEIyqfab9Mc
 27aRt9fgTk/+e7Gjsq7DQQB5paM9rvYgrEDXVbLipyYuccbijg9EQLH/11QN2kdPqfBv
 nXzZVNlB8saPOSAc/MV88Ltri7pvH+5ADJkqx8fTRYjoV8MOayjD8HZA0YmR87B0xD8i
 NTh+4ILUX/7kzzwZ8F3vgJPsCZoJd4ZpLNakLbZSJHHJJvwwIJHLNjqdlMndElRKQxFI
 KEPQ==
X-Gm-Message-State: AOJu0Yz1euuWcNLWa8W0Ein23Wrd0jhhek9mswbHz0frfTm/wmXSIQRI
 pQmaAoi/MzKSCPnq408hryJitbfJ2yYKGQl01dKvKSaiZ9yUwwLPvf3IyWbpizkAO7k=
X-Gm-Gg: ASbGnctnPeQykVc6D7N5yvOc9YeOo329uwWnhXyhsRdbCvHZBeyJo20Gcp70zjao+Om
 +vpb/o7O9M+6CwsgUt4/0JbR1qaO5QM6vJ0fMf0PHDzff08xrtsPHUfHUcZAmowVzbgJO3FGGip
 1ZHXDi4ua8kBRviYgAe8RfgWMtIQujrTcf+E9tY2MCiud0P4AGg+wfprEN92wzHCFaErwvpcn+k
 hLkT2qB/o+vhnjsgl6Vj0KThqsNNsVMce57RIsZa87p71vtYvLZBMOuNgsU361kqxNjROGR1/W/
 Gkz1Ho+xbRKvt2WF+8Yo75NaYF+YmwQwdXCDeeNiEuCHJYR6wtdNq4LPmgxrZpIjFnFJMpSVCDn
 zWVRmgBB6lpiW4wz7lcRvjZ4IxShJzSSL0KX3bVztlQxF3GMDK/Ufo9n/BWMiLae6cIBo5g==
X-Google-Smtp-Source: AGHT+IFiVJ+CEfn43TQSeXW+7DJEopGTjhmM6ApvbrYHZel/4CFPqG33q2zsxV02w7KFj6hMTdrnWQ==
X-Received: by 2002:a17:907:3f25:b0:b04:6546:345a with SMTP id
 a640c23a62f3a-b1bb86d631emr230701866b.52.1758113277601; 
 Wed, 17 Sep 2025 05:47:57 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:56 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:42 +0200
Subject: [PATCH v2 9/9] board/qualcomm: add debug config fragment for
 SM6350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-9-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=695;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=qL8D4pMK3F+IY2yfP/7RJc8vvd+RP+FF9AHkXtY1P8A=;
 b=pt0H6gRzfcHFuMERXpdaRPjy3rneDzetVnrHXW5zveoir3Ww/hUDPLSANWYjxiQazr6lMDog9
 RgXONI00KfuAYLvARSym2WV+YTQYzIj+195y09kuEByJFKKeJ9W5gx1
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

Add a fragment similar to others to enable earlycon.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 board/qualcomm/debug-sm6350.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/debug-sm6350.config b/board/qualcomm/debug-sm6350.config
new file mode 100644
index 0000000000000000000000000000000000000000..1379ddeac93f1beb59bdbff4ae9a90b4f0a0af2a
--- /dev/null
+++ b/board/qualcomm/debug-sm6350.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x98c000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600

-- 
2.51.0

