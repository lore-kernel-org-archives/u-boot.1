Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66817C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 10:14:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E0E8857E;
	Wed, 22 May 2024 12:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="eQzsDSUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D874A88490; Wed, 22 May 2024 12:14:43 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8813F88307
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 12:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59a609dd3fso137402766b.0
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1716372881; x=1716977681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FiNz1IJGngEjamtujKpIKjigU/tVCdPT+/nokqIzh6c=;
 b=eQzsDSUlrfX7kwL/VN9qoMcKF5q56E3GLAwPqZ8kz5aDc3/A40EEvrZiD+fBwf8UcT
 QeaqxYyaz9KIgaB0SBLYzD3p0ThuaD7pajcZMUykSt/9Bu9vqKoO3DtXo4fuixNITpiR
 znk40hHXXUWGIEc4uty8Fmi+YnSjOas+ppcixGBbB+rbbtkxoW4WH3Gv+qwO1ZkBLvsz
 1z73MOYz57Givu3PpKur4hTqYbUTNakXzcw/aOxrKlWRuNsaDRA3wlF/y+2EpKLzLqYh
 LK84XZAwNV6FPlfz5X70PFf8NH74Txp5bgPBTc6eDZrzvBYwI2bAkHZ4Y3pzSEKMxJqt
 X5Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716372881; x=1716977681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FiNz1IJGngEjamtujKpIKjigU/tVCdPT+/nokqIzh6c=;
 b=DZD5L4487D9VmHzy08QBl5IyTSY40hKZ8CoenIWfcCcDYGdr6F+OY5lMb7aIkukX23
 2pzrb6/eQYvwmLAIx75GDL2eimKKeBc/LCQ+nc7nsWAwMMsS8vGMYMu42VQv57TNhN6o
 FGaLVxzAnRp+nHa3mpGXGye1Tg+KbTyjh7EUA/TAQeU6U34h6iiUgmEcUqTpSvjxciVp
 Kt5BXkrdwoG3tviZaCSMsSEHY0QBqDnSPePivjHx3e3d/uGB1RNZjAuflzwqjSbDGZk6
 mlg9oO8YmZJp2383WWY7g550gl2dCp/6s/JMObE39aoPZ/KXPTeneKDY5Z9ZF/1/St6E
 M+Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKtA1HRmSN90CuEHpU9/KsVFdjcVcIYe2f7SuouSS0QljAc3Isk5qPr/SjERDevb07yWu7mJbqh6o2Gh5i6HaC8IcZnw==
X-Gm-Message-State: AOJu0YzH9+l6qGBsZGa6CqSPFKi+2efSVkmPLTnbKaWF9W7+iriXjm3+
 V4N6pf/8KjHN5nNzw2867PIjRCJzjqh3lvaNYhzd4F/Ou7O216TjNgyj2vJxDXs=
X-Google-Smtp-Source: AGHT+IFdtalqkaBwjXsl21GizgG85Z1Fk8UrLcJsbf1HGYz3JHNnYOr3IIdx4FlQoglSQHn3K9rgDg==
X-Received: by 2002:a17:906:4ec1:b0:a59:c3a7:59d3 with SMTP id
 a640c23a62f3a-a62230f7b42mr146712966b.13.1716372880888; 
 Wed, 22 May 2024 03:14:40 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-65.dynamic.amis.hr. [188.129.47.65])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a5a8b634cdcsm1081502166b.93.2024.05.22.03.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 03:14:40 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, lukma@denx.de, seanga2@gmail.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com, j4g8y7@gmail.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/5] dt-bindings: clock: qcom: ipq4019: add missing networking
 resets
Date: Wed, 22 May 2024 12:13:42 +0200
Message-ID: <20240522101437.225880-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522101437.225880-1-robert.marko@sartura.hr>
References: <20240522101437.225880-1-robert.marko@sartura.hr>
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

Add bindings for the missing networking resets found in IPQ4019 GCC.
This syncs the bindigs with Linux.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 include/dt-bindings/clock/qcom,gcc-ipq4019.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq4019.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
index 7e8a7be6dc..fa05878575 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq4019.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
@@ -165,5 +165,11 @@
 #define GCC_QDSS_BCR					69
 #define GCC_MPM_BCR					70
 #define GCC_SPDM_BCR					71
+#define ESS_MAC1_ARES					72
+#define ESS_MAC2_ARES					73
+#define ESS_MAC3_ARES					74
+#define ESS_MAC4_ARES					75
+#define ESS_MAC5_ARES					76
+#define ESS_PSGMII_ARES					77
 
 #endif
-- 
2.45.1

