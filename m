Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D82E64AA6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F86188E5C;
	Tue,  3 Dec 2024 14:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tc/hXPB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A64A88E35; Tue,  3 Dec 2024 14:51:30 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4910589328
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-434ab938e37so36012715e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733233887; x=1733838687; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IBgbq1nmzaXURG5ZS5JMXqqS071G5B5S3uX1Ohb3YMg=;
 b=Tc/hXPB1J/LX1+agjklqdDq7VaNFU5luAaLaLOqvsP+hvrK/oT+swuwDrdUOcssw19
 nMUUcWL9Q95s3lzlQdsZlwCPtFqyWKBO2LmAYQg6p3G/aqRvdp1rWTMls9hlXswnECed
 CDrnTzdV0KUQC1YW/+5fCKCu9KJzeEDslJ3qVPCUl1sE3IzcyBSvH5NLM2e24ArW01Eu
 GP9meAfCSPOmOMloggJkYlYSMpXDD/IHnA64I9kOM8hxLXP775QGW1NCG4/oMaW+cYEb
 5WtCd3Se8UTe1B1ph8B51TIxHfFI6NEaptaIKYuAFAXMygF8+dMgY9t1mMJ3U49Ra4No
 CFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233887; x=1733838687;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IBgbq1nmzaXURG5ZS5JMXqqS071G5B5S3uX1Ohb3YMg=;
 b=pMeNPs/gjCOklRRU91l+pRgdPUtmUj0JmnQDBb2hMigmWaOzMbChqb5Cc+t52eq/hA
 4qJRJhn7ZUtiqxxD0DPZmVLjqBsEOLoS5p0RqWaFTMf2DEjpwURYT9NYhhiR1LMyMegX
 +Y5svJwmIrWe1p6QIZUvyQ85PiBIH7dCl+XsWDUOJEeCOh0SqQ0JwmN5gb69EFvcN82W
 C4grIYY1N4OaWSiMDu/vX2/Bq3GajU5w305DjWU+fnGpgn4D5Qsgs0VoFMj7WhjAma9d
 jjMyyfcBE1dOpNyUhaxWvmITQ6eI6ZCA/adqXaOXWoVWqdYA91SvLXuaAg8SSDWS7UZ0
 7m7g==
X-Gm-Message-State: AOJu0YxoFydY9/ZTCohNRrz9QpgfRvWsEv35nDBduxIdO0KZtr+hkb++
 6NYnOXoqnkjbi/g4DOTlza7Vwc4fBj6Zv2XbUOzvQgh0+OjWOPYZ2TcV1HDbpsJdf4KSKVtkVfr
 09+M=
X-Gm-Gg: ASbGnctCLxAMsMDLLIpHOMiyRuKT+tYWpAdMSKCpEVca9ulfCcBH00H0SCJysmgni+d
 TcEjhQvTQrVzmpWttFm4ocURbyiWOGcUh2fyrGA2sDNYNALTs5wjUiV/vR97GiqrFzvQoF2dYZK
 Vq1Y/nKKenppRewRBaREBiLnSI/NhG/j1fCvuOZ47u7tZ+iqq0SfDpYiuuWNNZ1iyXjLYAub13J
 PqksbUuX2CgrcLC3Y+0O9hF/GMHyeIg/y2KPyg3OBl/dPKcrJGkShbH/Eg=
X-Google-Smtp-Source: AGHT+IEhUy1Zwm3X3Ntp1yvYnDsn0MfosQoqxdwNZpY6wG9f8XrgsG3xneCX3zLmE5O9EMT3uq7+zw==
X-Received: by 2002:a05:600c:358e:b0:431:5187:28dd with SMTP id
 5b1f17b1804b1-434d3fe3393mr1791575e9.28.1733233887603; 
 Tue, 03 Dec 2024 05:51:27 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2f51:a1f8:d255:ef36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74ea95sm221992795e9.5.2024.12.03.05.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 05:51:27 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Janne Grunau <j@jannau.net>, Kever Yang <kever.yang@rock-chips.com>,
 Alex Shumsky <alexthreed@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH] doc: environment: NET_LWIP dhcp sets ipaddrN,
 netmaskN and gatewayipN
Date: Tue,  3 Dec 2024 14:50:51 +0100
Message-ID: <20241203135051.801349-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Document environment variables set by the dhcp command when the network
stack is lwIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 doc/usage/environment.rst | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 7bd9ffce8d8..b67aae84c58 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -499,7 +499,7 @@ Automatically updated variables
 -------------------------------
 
 The following environment variables may be used and automatically
-updated by the network boot commands ("bootp" and "rarpboot"),
+updated by the network boot commands ("bootp", "dhcp" and "rarpboot"),
 depending the information provided by your boot server:
 
 =========  ===================================================
@@ -514,6 +514,9 @@ ipaddr     See above
 netmask    Subnet Mask
 rootpath   Pathname of the root filesystem on the NFS server
 serverip   see above
+ipaddrN    IP address for interface N (>0) (NET_LWIP dhcp only)
+netmaskN   Subnet mask for interface N (>0) (NET_LWIP dhcp only)
+gatewayipN IP address of the Gateway for interface N (>0) (NET_LWIP dhcp only)
 =========  ===================================================
 
 
-- 
2.43.0

