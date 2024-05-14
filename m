Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B1C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 10:18:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F30E882FA;
	Tue, 14 May 2024 12:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="GspKnRTj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22450882F6; Tue, 14 May 2024 12:18:31 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EDD4882D7
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a5a1054cf61so1445712666b.1
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715681909; x=1716286709; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rutg8+or0+MUWk83Yuu+HjJGsy5uUP/WN6TFE81Nj0k=;
 b=GspKnRTjdb+UEuftolxeWlpRltnippujc/whEXL77rcYaSGdsbu5ejUiZ8FDRulkj8
 wVaEc06xTe0hFuC5YlfZOLgsXcP/mH1S/CVGZU4V0c2gnbZzIOq+ooZdUiwcUqQ6wRno
 KkZsR5YMfVr03pvWNBcO8kCmioecC0g519RveA6IcUbQrCzlUHCrVe/ASBlPegq5384y
 QInLHaqAF0Py6IygDgefAaDyK98Sr+jm1Oo9PzR8BPQbI4HuaVsE8pB0+rN40UO7H2AO
 /zp3okuS8e321oa74npnLeHLUAj5Prxn6Ccj10laFWh2VNd0b8Z1I/sOgfIhGzrnlZAX
 hPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715681909; x=1716286709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rutg8+or0+MUWk83Yuu+HjJGsy5uUP/WN6TFE81Nj0k=;
 b=oGd3IyB9S8Nx1mqqHgQqlyRtkse8sECkm6+EvB11Kb2woj0lh2sUbkiMDPu2oJl0Ra
 iqFko0iYD+Bqq0mWwiBK7KeuY/bEaM9ALeg3CihxBLbPNy7uYjzzlCkGPg3G+YVXNcuA
 QzgWPz5tDuaG8pFiFj0cU7T4YEnDYdmHNqB7SZ4NxbNPuRhyiZf2MwJYXT4x1G2kDhOH
 RjhEnkckZZhysJxJRio8OYxiN0M2aStILTLviO5w8l/dry/nCpccrshwyai23bgMUyE/
 G19ShXO1UD0UHdy7L6RcScpeuVnV1duiFWBRqE2mFblp2RqFt11JLb/yOC6PkuRTi/ZK
 /nIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEq1cc2MPLnl47hwvNnJjPetwkfZSbtaZwa4M4IzP+nL520NHOZmlRJRV2ByNQ61qDn8J6TTW6roDBJir6Df+eITk6cQ==
X-Gm-Message-State: AOJu0YzCdezTNH9Fl/eg2VrQh98DeB46ZXiaFUBSmsYlpb7qeEbCJVXe
 Cj77UxQMA+w2IPnSviJYK6iM0o4GA/kip3uL2R42Eu+lT5GDZ8y1DheirEsStXg=
X-Google-Smtp-Source: AGHT+IGlMKSkuT/XxngjO4TmN/T5TrnsBB4+qbjW8NTzdy2rZ9V7fT0wGvbcMLEVm9qBwzbGnbqlEA==
X-Received: by 2002:a50:ccc1:0:b0:56c:1696:58a8 with SMTP id
 4fb4d7f45d1cf-5734d44fe63mr12044548a12.0.1715681908686; 
 Tue, 14 May 2024 03:18:28 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-220.dynamic.amis.hr. [188.129.44.220])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-574ea5d755bsm261802a12.51.2024.05.14.03.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 03:18:28 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 2/3] mach-ipq40xx: use OF_UPSTREAM
Date: Tue, 14 May 2024 12:17:51 +0200
Message-ID: <20240514101824.23872-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101824.23872-1-robert.marko@sartura.hr>
References: <20240514101824.23872-1-robert.marko@sartura.hr>
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

Now that drivers are compatible enough with the upstream DTS, there is no
reason to not use the upstream DTS, so imply OF_UPSTREAM by default.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 39ad03acd2..914a7552b4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -769,6 +769,7 @@ config ARCH_IPQ40XX
 	select CLK_QCOM_IPQ4019
 	select PINCTRL_QCOM_IPQ4019
 	imply CMD_DM
+	imply OF_UPSTREAM
 
 config ARCH_KEYSTONE
 	bool "TI Keystone"
-- 
2.45.0

