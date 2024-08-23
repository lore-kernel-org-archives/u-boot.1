Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE0BC531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 973D688C91;
	Fri, 23 Aug 2024 15:50:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="emKAEB4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7413B88C65; Fri, 23 Aug 2024 15:50:18 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 525F388C6A
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37196229343so1227723f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724421015; x=1725025815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wGAxngIl5/YTS5ICCFukRbGaZs+N1aXf1ApJKIVpUI=;
 b=emKAEB4+wlUmboJ4nEkWQL0qc1YIfnvRsVkGmXt+IZjNLEdRzFi6NoJp/ullas4Zpp
 toZx/3PXEtmwLDK6rpEQRJrlevsOKom1Orf/3q3SBCWwIdzI5slO5sqw+AHQVw/IK6R2
 3u3wQHnwbCNyXrRefdT+Fm5iDvVKXUPj2lxZ4FLapkzIlgjR00IECdvFHZBa710w7TMl
 NjjROaW4R+uvqrqCN4eSGz/ilCPqMIwLJmakVY+Cz1uaOIsqH8h26aymLSPe0BzLd4uP
 negmQvIohv4Oo4MX7OlSTIJzafn+oC2xo5nJX/PQ2DyMsOUODgxHWEwMQ9NuukiQ5GCP
 IDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724421015; x=1725025815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5wGAxngIl5/YTS5ICCFukRbGaZs+N1aXf1ApJKIVpUI=;
 b=uibLTatPAv9b9t69xUBM01hWZvMbbXKKH6xdLcuxdcA++ptQss3b9fvXewWnfxy9JR
 8Fv2Fn7wGZbbCXv+Ch5rgEStnpXqCglD6ZevM665GZh2avSO6EyVD0baiRK7xOPpYTY3
 hCre+HeshTsNV1B7DunikLR4G00RHwp8pgDl/fhsv6YB50PNq+8rSuVXGuSpHMkdhGEQ
 uv4wMwr4SpJ6wdkvCxqARWzzBJ40Iryu1qMDatDqz2XAfUh6MNHH2yWKHiQS3LHz0ZdD
 fXnraDmjQ2FSZ5ZV8Xy27vNB+395VNvauXQM2LXjMvNDmoasblxcRAiAjGc+UWRzLLR1
 wgcQ==
X-Gm-Message-State: AOJu0YwYA6S24/pfsMXuJ0VolCULX2iGaPm4+xxc8Q+VADYictNaGVDy
 S5ZMMQgow0sT7G9g+bmI0YmWZDoR7FxneD2qMQQC8QqrYO+SPe9L19gs1C3JQTUpNUyZTxGuuja
 EezElGthI
X-Google-Smtp-Source: AGHT+IHydc0Kjlww7+qHnuIiBJpblVUiR9VmXzujB+PpMsUDTWLfK3ON3q9f+mKE3/sWZfdeXXVVZA==
X-Received: by 2002:a5d:6211:0:b0:366:f8e7:d898 with SMTP id
 ffacd0b85a97d-373118e372amr1472407f8f.50.1724421015579; 
 Fri, 23 Aug 2024 06:50:15 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:50:15 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v9 35/37] [TESTING] Kconfig: enable NET_LWIP by default except
 for SANDBOX
Date: Fri, 23 Aug 2024 15:48:39 +0200
Message-Id: <1629f6845b448edcdead09a9350f1ae2ae7a4bb6.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

Enable NET_LWIP by default for testing purposes. SANDBOX doesn't support
NET_LWIP so default to NET in this case.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Kconfig b/Kconfig
index 6657b9e5e30..2b316afa542 100644
--- a/Kconfig
+++ b/Kconfig
@@ -749,6 +749,7 @@ menu Networking
 
 choice
 	prompt "Networking stack"
+	default NET_LWIP if !SANDBOX
 	default NET
 
 config NO_NET
-- 
2.40.1

