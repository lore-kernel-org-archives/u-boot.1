Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B542C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 00:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49CDB87871;
	Thu, 21 Dec 2023 01:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tlvm+0nm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA05A87875; Thu, 21 Dec 2023 01:41:16 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE8887873
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 01:41:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-42786ec994bso1393911cf.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 16:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703119272; x=1703724072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87sG9HPEQ/b8s+kyD+6SBJ8evOSjubcYEd4dkOBwJ+4=;
 b=tlvm+0nmCmhTJlgwTa9IOdDgGBBs3Vg6ywh4c/M3o9z/Ll2mGgpnyDv5IsydlEHdiK
 HDDLjMIH2kc9vk3v5y6heBbDNUM0Gp/tpWLS+V2IKsj+7o42sbR91oRGZWBZESCXxbDD
 DEPgStJs8+jV4M6W6vhKmSHh9sPG9sFp4gcBQGBc2Q82ED8H4l3u7V0J0M66XbA/mZd2
 80+TCZATWP8Qha9V7KwH9lpOECDTHBu4K3lWSrXSYmzvq5RfSGNZx3VL8S/HlTpc4UXe
 l4IZDLL+OUTIu3WKmDMelyUnIZJpgUdjaFRIh5j0GlEG973P8uUvXfh7K4NE+xfGPdjy
 +8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703119272; x=1703724072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87sG9HPEQ/b8s+kyD+6SBJ8evOSjubcYEd4dkOBwJ+4=;
 b=mXUsTtkE9zvwPvz4K59FJnFyXeRvT2CBA/RuwbeZDVomV1gSGen4ltrOIzVUEgfLfn
 VwjvuEGo4hhK0d6h5ReqxDTSYENQMRd8OkFD/qwF1mAhg9xI5D23lqusr85UlZVTGq7S
 BWksmLVySI7rApREnb2pRmuusJdo98O1gV7dJ3AY8iqoz8EP4BR5SpUqWg3AwSXNTlsw
 PnUhCD7Ll3gOmPd9Zfxp9+7m1Oauw0VDe7Qk/EtLA4PGlk7swBqHC2TTgJdC8o3vpXuD
 3RQyLobksVuomiHYBRgFqh0zd34OwIu4ByfeBizixw/Eq3QqjLsonURcNpd3dzHwCCMG
 F5Nw==
X-Gm-Message-State: AOJu0YynaSefYKc345Tlr2AMYuiwXdJS8Y9dwE5sKwj9bTHMjXCr0S/J
 buMIz7eRcJD9azMFGkU6Uwwh2ITYNL/Ov6PpGl0=
X-Google-Smtp-Source: AGHT+IH9FmAsNnzqqBWaCwnzlOEUgevxjB2YNytuxMHh6sqWStyUOB0cDh8hfDqE3DAKYSuYbbwlPQ==
X-Received: by 2002:a05:622a:306:b0:427:9b36:d80 with SMTP id
 q6-20020a05622a030600b004279b360d80mr45847qtw.126.1703119272024; 
 Wed, 20 Dec 2023 16:41:12 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 fv9-20020a05622a4a0900b00419801b1094sm354184qtb.13.2023.12.20.16.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 16:41:11 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Kevin Chen <kevin_chen@aspeedtech.com>, Bin Meng <bmeng.cn@gmail.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Shiji Yang <yangshiji66@outlook.com>, Baruch Siach <baruch@tkos.co.il>,
 Michal Simek <michal.simek@amd.com>,
 Sean Anderson <sean.anderson@seco.com>, Qu Wenruo <wqu@suse.com>,
 Stefan Roese <sr@denx.de>
Subject: [PATCH v2 5/9] arm: armv8: save boot arguments
Date: Wed, 20 Dec 2023 16:40:24 -0800
Message-Id: <20231221004030.581388-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231221004030.581388-1-raymond.mao@linaro.org>
References: <20231221004030.581388-1-raymond.mao@linaro.org>
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

Save boot arguments x[0-3] into an array for handover of bloblist from
previous boot stage.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- New patch file created for v2.

 arch/arm/cpu/armv8/start.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..8e704f590e 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,19 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_OF_BOARD) && IS_ENABLED(CONFIG_BLOBLIST))
+	adr x9, saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.xword 0
+	.endr
+END(saved_args)
-- 
2.25.1

