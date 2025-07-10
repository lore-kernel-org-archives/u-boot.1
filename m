Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75C9C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 21:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3409836EE;
	Thu, 10 Jul 2025 23:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=yngvason.is
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=yngvason.is header.i=@yngvason.is header.b="j6U247kr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAD682AFC; Thu, 10 Jul 2025 19:32:04 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131D4836D1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=yngvason.is
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andri@yngvason.is
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so1053966f8f.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 10:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yngvason.is; s=google; t=1752168721; x=1752773521; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiGduqKNHlXLfOUjeSsMEOot3PvMoNwxA7bRkam1AwQ=;
 b=j6U247krrXBwbdk0AfunLqUXzcMRTPKX0hakk4jvTun+Ys8/Oy32fgDX/qzgulhET+
 bsnTlEPURtcwCRiuIEFSBzDa+QnzPzENLYjWQ0hYAEPH1BucqVM2ajgb9DW/Rzt5Pdsz
 49q1yM9R4ReiWYgQJC9N6AQc1C2kGLBhsO2jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752168721; x=1752773521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiGduqKNHlXLfOUjeSsMEOot3PvMoNwxA7bRkam1AwQ=;
 b=qf5MIdv6no+3AtIZin7nAmL9z1lLfDvgnsLb+f8fg53Wxy9P6Pys6eB3yHA1RVZv/M
 trcy+hZX9yw4+9uqwQ89FB+Xy+u42uiqrsnTGn8723rdXF2xvEBKt4bi+GrrLrJ5Vwk6
 9B8atJfaEUhoyXnFV3WfvQlRYjMD1EAiCPVmrdNrt0Yr7GAUEJ1Z3C+/9AMJC3nO8jZQ
 DvZLwFTcGVtWgIlh4U7pbPmijldLe9+fkGGE+PzrDHBoWOukU//bIJMt2OUYgb99nghz
 f3TRO+SgS6P3bydOwAilA4whzG5OYlI4TL2FTfU3Lkh5l0LS9F+BB16tdtuLWBzYhrzp
 YL4A==
X-Gm-Message-State: AOJu0Yw0JXd2tF+gYRMfbA+gVIZxADBkpplE7r472SSV7A7YkhzHx8HC
 za3n9Icz4UL8t3pNepY1uO+gmZloQh3mjrmYCMCghPoYt4Ye2TBlpwHjyEAGU49lRsn7DYi74yd
 kYiDAUSlrNQ==
X-Gm-Gg: ASbGncsUF5qmOuiA2FmvaQgVUfEqs1g8CDCQDI32HO7VbHqoYrZ2x/JyBFc8BEgpBkV
 BpzFrCQBreQq3YeMXRQ24tAiAxmTGmYx4FTG6eEl5db5SZJZDUuvOO4z8YmOWrqulUDKxiu/E7I
 7F7dgeBc9Fc5PURTIXmL2/ytIFf/sK4ckhgnMqlX5JOijQVHo6FZPV4kYp1Wa+6JaEXqtmHwGyd
 jjo9gMqILaugNXyTTHT43FollV/er5N+2EMNweS/VeRL/HvXHOcTv1K8ZFpYSIayje8a192RuYx
 f5qrXNuAC5Rf35KC++fhEyx8H/K6Iujlgt/lWu8T+ckBXZlqRLMQmCbwHF+xTnxPhY7BWTON1BY
 dP+cZ74PWnwNhpvDRvPvUtpg=
X-Google-Smtp-Source: AGHT+IE1sEEtkg1d6IetZKC1QNxplRS0xoeebfZQp/ePbU6t2mClZG9PaGJtf54mnZ1D7f9AMb2Brg==
X-Received: by 2002:adf:b644:0:b0:3a4:f038:af76 with SMTP id
 ffacd0b85a97d-3b5f18a6cf6mr329461f8f.53.1752168721333; 
 Thu, 10 Jul 2025 10:32:01 -0700 (PDT)
Received: from andri-workstation.turninn.appdynamic.com
 ([2a01:8280:aa07:ad:7285:c2ff:fef0:4baf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d732sm2442227f8f.52.2025.07.10.10.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 10:32:01 -0700 (PDT)
From: Andri Yngvason <andri@yngvason.is>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Andri Yngvason <andri@yngvason.is>
Subject: [PATCH 3/3] usb: dwc: generic: Add rk3576 to id list
Date: Thu, 10 Jul 2025 17:31:54 +0000
Message-ID: <20250710173154.1244430-3-andri@yngvason.is>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710173154.1244430-1-andri@yngvason.is>
References: <20250710173154.1244430-1-andri@yngvason.is>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Jul 2025 23:56:14 +0200
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

Signed-off-by: Andri Yngvason <andri@yngvason.is>
---
 drivers/usb/dwc3/dwc3-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 21452ad1569..15a9acec593 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -699,6 +699,7 @@ static const struct udevice_id dwc3_glue_ids[] = {
 	{ .compatible = "rockchip,rk3328-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
+	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
 	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
 	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
-- 
2.50.0

