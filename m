Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387AFFD0651
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 14:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC3D8418C;
	Wed, 11 Mar 2026 15:23:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="5n8u6AGn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 388A58407E; Wed, 11 Mar 2026 15:20:55 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 443D284067
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 15:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so1280752466b.1
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1773238853; x=1773843653; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GlkNnVN3USDRbuBa3SliLsMlIfOgLjIx+m7pOkzsg9E=;
 b=5n8u6AGnkwI3BPb4BvXftPwiw5Q+rINNSMRcHK1eRy38VcnxBIMmYfbK7ZCUwch2hx
 ku0uVfX6wTjom3JciUa2C66YAwXn/Ajwn66Jp0qU5uJ7f19RyRFc6azSxxZC25R5ARRF
 GfeWC44XhUNvMV8aHrRelRm/4W3bvk5f0L7Y0zEc7SWFjsFsuerSzpGTxwqmMEuk+Fo1
 /pI7BLFDsO0noym8Lwx+R/cGfC++K2obnHN+ZeZqPs+bQonZ0V9zxC1KfRg5u8/muidp
 Rf2PMOykHOZbJvATzs+AgFjGQxDuHryGxiDhLKwcxVF1IiIh2ihT2Uj29fdvsWXCU8El
 NLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773238853; x=1773843653;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GlkNnVN3USDRbuBa3SliLsMlIfOgLjIx+m7pOkzsg9E=;
 b=f/db1PI1JZSjpb7cJ3qJt2PueFwY+DqTUuDo5aHBcdL9LVAhLOUUUg8q2uivIZ+v6H
 8NUEqh3feENzwhSRtQx66uyQOt6iP07sb8n0GMPLAyy8zR5JQIMKOQoAuPMPD7vnJ1Hi
 0c60UboaCMNhzhDdosAjZ6ITwXNiMMhTbu1h7PUKatfGwAhCnpUjUmyi338gRTZ4jP+H
 td5P/fqwp1P8pyFA9ufVEcTd4EpRZG+nzX/nrA2+7eTfp3V+zZovN9QVHDiQwGZjsTFm
 Os0d7jPpRAYKpr2lU8d2bNGcjkNrdNCozmW/wgsbBl/zBCO0UEwIjWXSfvTUQQlzaF1w
 /jug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlJ1UJWrROM5jJwXKbVGn2OXVshJJtuQfE83TskAABep5DBh/vz14ksbt54RjpG1G7JjoiYBA=@lists.denx.de
X-Gm-Message-State: AOJu0YxHtIKbMacnqfD5Rl8xlEcu74J+fo+iF2JW1P5meHlk9e/usK/D
 9If2adhfOuZCIYaJ87oowLICK/vRYWKHOVJawDhz888VHTC9Di2Rqjz4jvo22d/jGwk=
X-Gm-Gg: ATEYQzwOh/dbKX0DmnTkEY+AxLmhziSUbqmjS6rD4+O1cojuKcFXyMMMq3VhQBdGJay
 7jMXZbXIwLK5uO2F+cS2g1PkqrNTNbCcWkCKd5GCQ+hQkZ/ioPYEW1qxHMSxV3CuKc2hHwNGMCA
 qF58x4Z2n7bjunc4kN65K3CuT7/WbEIA8I2a0TUi/CNqTkfg3sYdWevUvuRJ3chFdAqAGbyPmZu
 GH9RWfSZXh6p32GUTBinEFdfsCYI++yzUbFu3dH1pIrdhs/vUcRCGhq4VAWzIeedXdiGvvfrysO
 30NAlZGLv+iCAzAGPPX2rGLifcGqjtb1aDMmtiiuSjrvcfZdNUcQtZ2D6vwgSYvec8wNf98+RpU
 ev+hgWh6Ubj7p2+nnsuHZjTgXhKDdP9wGfzuHie+MGNyimS1RIg/alJhmxs0zOAGCbv+JFSgewd
 A3FmOAKnrcUKPeuN4P9PsIUcPtzj24leLgebN0eexcBqqmRe0vJTOVkscM55KQSuJ1gjSOJL3ZV
 j/Ji/6Dk4LpXcv2
X-Received: by 2002:a17:907:7b84:b0:b97:72d:67d with SMTP id
 a640c23a62f3a-b972e58e8c9mr159146966b.50.1773238852608; 
 Wed, 11 Mar 2026 07:20:52 -0700 (PDT)
Received: from [172.16.240.100] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6631503c903sm543467a12.20.2026.03.11.07.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 07:20:52 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 11 Mar 2026 15:20:47 +0100
Subject: [PATCH 7/7] board/qualcomm: add debug config fragment for Milos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-milos-bringup-v1-7-eb905c467f10@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773238844; l=576;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=7HORZx0vW9DqGE6+rgfWInX9SXd08Kpo98GP3at1Ej4=;
 b=c5iqQHHvaPI5txt45+YvCKf/Ndkcv3qdzULS0KhjWJag5PdttIbtouIHMD0WPS8YfqnZOTTpT
 H/OevJwlLsgDIws6u4Hkttfi4cykk8qQRi57Mjig5HFxvIfra3zzOfr
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

Add a fragment similar to others to enable earlycon.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 board/qualcomm/debug-milos.config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/qualcomm/debug-milos.config b/board/qualcomm/debug-milos.config
new file mode 100644
index 00000000000..a4cdd13f226
--- /dev/null
+++ b/board/qualcomm/debug-milos.config
@@ -0,0 +1,5 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0xa94000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600

-- 
2.53.0

