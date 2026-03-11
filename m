Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4B1FD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A73008418A;
	Wed, 11 Mar 2026 15:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="OcYzirL8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B66A4840C1; Wed, 11 Mar 2026 15:20:54 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C231C84057
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-662e7450a8aso3081414a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238852; x=1773843652; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TdLSndcdzKip7+6mqqsWY29ucW3opMuYJuJSvxAjGmc=;
 b=OcYzirL8JM6xixwiZEhmJmjyjuud131w462WBKGxO2SnTYJyhbzYHP9EzNLxEbgTVx
 lsj68tugeo4QISCwvnmDkvhTxu+2/5Sdc0SaSeRhTlqnSGkYA+XRf1HSr1WGnPofM/8x
 JMdd6CDlaVV/O00Y0UhgKtF4b7uBP2DJnbKKgL6L3Gxncy9+piCEZ8b9jkdCJ3rjhfgS
 hJIGbrYZlycLA91QFzUxgISAS4wXKOEX/a7DBYE44FRs7PKYhvRyWSDdY9xX5DWSK6sc
 EOZYt1VAiPh0TK85PJN9p34zlVifbpaw5IB7+dXvWWqp1T9tm/BJCnSMcV8hhUB6CayU
 vs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238852; x=1773843652;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TdLSndcdzKip7+6mqqsWY29ucW3opMuYJuJSvxAjGmc=;
 b=ktToahheR7ZmJMcjnVAEHnHG1EMQn3+e6apd5o8fFVvPLogV3Fb22H3vVwFhVtWNub
 Ceh0vC/s3iRL/eaS23YyaBNKNn6agPPVUWKaAE3PTsg2GAvUOBjcL5kamDglKhvM+Ctu
 jL/OavqY/F1Xg445HNOY+kIiMGYK+t+wznBzPmVlYAlx/T8o9P4wXERx9m1ctHfzuTfN
 F0Wthwm2MbjvcA9OfyPFjKL1QY+Pwztw5tUfAVdi7LHCNLHb1ybd1Xb9l40betNpYywB
 kpiGRsZGwUHqHv1jnpjzcXVROG0KnRRKhJICXnha2Xq046jnVyHzWDfZMtM5CafVdN6W
 4Gdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7PKrX8Wb8s0YcLyCDTxkKeZ/oiUBhf5RFkUkUvwWVmK3mzAiTYZfFHl8m4slFQAkFKWqC/iI=@lists.denx.de
X-Gm-Message-State: AOJu0YwXvZeH0oQAVEL20tU5Ak3U66/zvHAoI0FQFOK+JmYhjaH2TocS
 9bLdFEpB65zzYHi9iiHTSrQAiON7Fv6nbPj77k6Ht2IumIwzG4+RuefZ0h60PnBQtr0=
X-Gm-Gg: ATEYQzxlDnPMDeqz+oJiItDDa6j0+EOyt4rK7uTBysSU5kHdJO/S2pD0QGc1fx/X2eP
 m33+4tbviHGhOivkNnTrDsGX0xKZ5MJ+bSGxN5YGJKl9B1iIbVFf4vjruASGGk2A651tNpCcFXg
 fitVZlxNQylpweO2lQr36tWE5GSx9W0/G6iRRyUy56YCfp/4AexkO1XAQuTiflFuLrzzDsn0EAV
 newiD2wKNMWEJQYfLHunHzPIT1uYaeWxpRnIKjievQgU8xvQnhy9AIuHHi4otV9yq0SJB9XRC1w
 XrdJbpgdAqEGf3VBjIJqa8Eyto9GtfOhvCW+HqF02610qxte4RD69eExkma6g2mThVyvQzl3f3C
 WaQvNy9+f1bOVYW10dvWPq+goCTiGrxH6lDKLIbhEzji69IpS0m+KgGXL0vFWKnLbIHkB7msMpR
 N9Ftg4955/MRnhUC89UXfZzUcq63X5InqV1sfbnRJGkwCegcJXjMLKHTCvzlu3HQd4PdXJkWfSN
 nep3Q==
X-Received: by 2002:a05:6402:f19:b0:65f:a428:dffe with SMTP id
 4fb4d7f45d1cf-663194cbdbdmr1182072a12.7.1773238851715; 
 Wed, 11 Mar 2026 07:20:51 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:46 +0100
Subject: [PATCH 6/7] qcom_defconfig: Enable Milos clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-6-eb905c467f10@fairphone.com>
References: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
In-Reply-To: <20260311-milos-bringup-v1-0-eb905c467f10@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david.wronek@mainlining.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>, 
 Lukasz Majewski <lukma@denx.de>, Aelin Reidel <aelin@mainlining.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Rui Miguel Silva <rui.silva@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Sam Day <me@samcday.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=590;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=f9Ki97zbKSxteFyoVbZG+pmAn33wjsIhERAebjd7AK4=;
 b=xAVBhkYPOA718Y6FPUl6z9NTxaMnJgHAEkRPkRMo/svCoIk202y6tzYbYXOYiw6GkDGBSE7Lz
 vHm2Kgsw3XeCcqlZH/Sum4TE/1KoveEuZYp4wPpbieK1Jb2+Rcil45O
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 11 Mar 2026 15:23:27 +0100
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

Enable the driver so that Milos devices can boot with qcom_defconfig.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..44c1cef725c 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -56,6 +56,7 @@ CONFIG_CLK=y
 CONFIG_CLK_STUB=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
+CONFIG_CLK_QCOM_MILOS=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_QCS615=y

-- 
2.53.0

