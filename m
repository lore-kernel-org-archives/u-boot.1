Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F16FCCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 17:36:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC3C583FB0;
	Fri, 10 Oct 2025 19:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TnVtX+Yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4462483FF0; Fri, 10 Oct 2025 19:36:39 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 300F183FAA
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 19:36:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-36ce5686d75so1634669fac.3
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 10:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760117796; x=1760722596; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gGfJzVFAJl6H2cXzoORLx+qj3glMcBJcsxJbDfr1kp0=;
 b=TnVtX+YnB5nQB/q0C/XB2C0ZEXIujGj2Z/gxjW0t1UrFVlDSjiozwocc8Z5cgkqixu
 Tt2yL2NkyOcfnXqo+t8AolJBpUa/eRpDdnL0/HppEGRDFBp7BG93eUHVQ4UmYy1jpFHQ
 5D9Gw4D80bD+/1JpnscavTa6SOvw4sduSH9sM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760117796; x=1760722596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gGfJzVFAJl6H2cXzoORLx+qj3glMcBJcsxJbDfr1kp0=;
 b=sihVm6nylw7PHLF3xXdRfTpeFA4Iwd/oodp2HIOiSre02lxdY6Hlj5zUI8NEG5yWB6
 I38JUmOIBkRVwmucGOv13dlMSGrQmO06iRpPeEtvgHyI0nFE/fja4YXtfVWy0Z9GvDmu
 DB08TFjNbIu+xMCGxshREU3QVUUDorEmef6dOQthr6+7HPg6OsQpzkga/J1ZvDbQXKff
 lhJhd9ui82oHLMRk29k1TQ1GDkIRtKjhuBewFe/bEf6ttC2T8OnS8X0gok7gDyt0MDKx
 angzrhZwXrW/x0HtatmQbGg9qy5PxMtcPe53pBBwzjqyPBX4zfwD2neOaiWg05+Ig/e8
 U8jw==
X-Gm-Message-State: AOJu0YyBrb/xZSzvr/VP6mkFkPmJ0uwfVuD4/SX7LFQy5psG2lPf17Xm
 Q7QXDAf9bXvwVEru+k0Li9sEVUDOCuuKl+H0gdZr0Nk0jrpg0tpNCGKVSjRypJV24Z0QHdWXfqc
 G7t/TQns=
X-Gm-Gg: ASbGncsL2GfehdIS/Yk5eKPG+EFIm4a40e2L7S1zbwjgBylS7qeDP112ksEGS2Z1dP3
 /WV4pR8IikYvrY7ZAH6ou4joiyzaG/PDQ/4YJQNrCGfXuWpxH1xMwhlPkV49bgP31Rjdwyy+OXY
 m+m0sRNGhSG789N8xzmluyntTQbLkzMipZck8g6m+bff3hu/hB8Jf2D88ISW8rUM5huodlCbmKr
 JS7V1y90Qf9HNWgwv7eHn76+W+O6d9OXQSx8HAx8Mw1oCallYWKZXhWFMCyO9Z2+j+Faont0slu
 ho8pL1FvFZG0SLxXzlS2KSO5BCfFnAsmjM0ewkcTDbeTrV1adx6RuTmgqvIhLHj6PEgUudrTo5C
 DScrmYFc2W6NOoqEmD2n15Oy9Qw6RlVd9Ij3078abkPAlVPXjygsBZGRBQYoGcy8XfrFEMihlIt
 SmCjD+pAY=
X-Google-Smtp-Source: AGHT+IGw7Ckq9XIGg1y73TuPmJSWK0jWtyfnSvfaJWBLuZqGkLL2rWgkdZyoTdQ6h8SDta0fNlrFHg==
X-Received: by 2002:a05:6870:46a9:b0:332:2463:8c88 with SMTP id
 586e51a60fabf-3c0f9e7240amr6328378fac.37.1760117795704; 
 Fri, 10 Oct 2025 10:36:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8b6984bsm1045885fac.8.2025.10.10.10.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 10:36:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH] net: phy: Make driver overloading get_phy_id depend on
 !COMPILE_TEST
Date: Fri, 10 Oct 2025 11:36:33 -0600
Message-ID: <20251010173633.1170642-1-trini@konsulko.com>
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

With commit 597fe041a85f ("net/phy: enable get_phy_id redefinable") we
made get_phy_id a public but weak function, so that PHY drivers that had
required non-standard ways of getting the PHY ID could be supported.
However, overloading a weak function multiple times is (rightly) a link
error. At this point, we have two PHYs which make use of this feature,
so make both of them only available when COMPILE_TEST is unset, as part
of being able to support "allyesconfig" in the future.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I thought about this a bit, and looking around very quickly in the linux
kernel, I don't see how this is abstracted there. Given some of the
comments in the two phy drivers that use this, I'm also not sure we
could use some other abstraction here as this function is called during
probe to figure out what we have.

Cc: Jerome Forissier <jerome.forissier@linaro.org>
---
 drivers/net/phy/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 185c6a3156e2..018be98705a2 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -56,6 +56,7 @@ endif # B53_SWITCH
 
 config MV88E61XX_SWITCH
 	bool "Marvell MV88E61xx Ethernet switch PHY support."
+	depends on !COMPILE_TEST
 
 if MV88E61XX_SWITCH
 
@@ -119,6 +120,7 @@ config PHY_BROADCOM
 
 config PHY_CORTINA
 	bool "Cortina Ethernet PHYs support"
+	depends on !COMPILE_TEST
 
 config SYS_CORTINA_NO_FW_UPLOAD
 	bool "Cortina firmware loading support"
-- 
2.43.0

