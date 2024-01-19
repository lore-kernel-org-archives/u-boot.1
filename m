Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229C6C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 15:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 981F887CDE;
	Fri, 19 Jan 2024 16:12:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uFN6VhcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4133A87CAA; Fri, 19 Jan 2024 16:12:32 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3951C87CE9
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 16:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-427a3887483so5343621cf.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705677149; x=1706281949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70O85wPhaoVf5WO6fvHnMGIduy574PKUNX619hmQC6s=;
 b=uFN6VhcNioe+EdUwf05wpGcFiTFVMuKDfgqveqUajA500BF7BxvB/FBOE382ZHqhla
 5xH0W6prmcx4F3OeQqUwyzb7UQz1c3DFb1QHrl9Lye0nH70+HieltiWQ3uWS1U/W5byD
 M2zGsD2qYQFksgXEt7LxaB6PjSyBvHwAB/hORkFAzc+XCs92bHySNQCV6vIusmoBEYBO
 /+oSJ0bRxm0xc8XdGCJJ9pPZ+V+zK2OZS8IXzLD4XWU8gkdTtyAux73yNgTLaqdg+s/Y
 tMAdQxRPdcHuf3fVGAYXYLBesYIrToNAVM2p3yxjPqk10vJvYyvZxl/lhvidRqA2KlaQ
 buGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705677149; x=1706281949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70O85wPhaoVf5WO6fvHnMGIduy574PKUNX619hmQC6s=;
 b=q5XKtEiscXSyJ6df0hfYPXn88dK/pmgJcD5P+pNtQhp/nkopZIn/U/x7emDC+r5MnT
 zixlY9Ck1wjYfq9Xsb1yycMFTla9j43eSSrr2a/cz3xxhkZ7gkCXSzEVEEgqwgkxcUX0
 BJHWgjy5hZ6gJL9fMKVxFdZxqruw2ehlk9P3APgjpnZyHKsnkT+ckUaC7RRpt9IvUdkp
 jTjNGXucaF1cO/pYqvwZ4gqXDPyxCREWqFc6qtnbpkFZ+qtuMMqY8UEpXReLIoD/35WC
 2XgK1GJ7p7gY372p/bdv6pmqi23gwU+1oedxI/hFs4nJS4pCMZZ4qrAVY+RvdcaiPcgQ
 lPpg==
X-Gm-Message-State: AOJu0YxtTXfoweow8Cwfy4sfyBigo+sE6I2MclZLyPQulaPEShzL6J+N
 eu+VK9usg/rmYaRCwVnhyu84JfT89FDXzEgkBGh4oa7cKI75LxyfdxykzPA99Yo5RPlKW9/wSdw
 f
X-Google-Smtp-Source: AGHT+IHswdpjxGHLlskncUoVgxZQ9YfiFtavPNEkkJTAJQIEitz5jfYgJG3ksWAePLPugrmaf3LCug==
X-Received: by 2002:a05:622a:1343:b0:429:f5e9:e20 with SMTP id
 w3-20020a05622a134300b00429f5e90e20mr2877760qtk.124.1705677148889; 
 Fri, 19 Jan 2024 07:12:28 -0800 (PST)
Received: from ubuntu.localdomain
 (cpe688f2e182063-cm688f2e182060.sdns.net.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a37c208000000b0078322dc4f97sm6142113qkm.26.2024.01.19.07.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 07:12:28 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 jwerner@chromium.org
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Kevin Chen <kevin_chen@aspeedtech.com>,
 Sean Anderson <sean.anderson@seco.com>, Nikhil M Jain <n-jain1@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>
Subject: [PATCH v7 5/8] arm: armv8: save boot arguments
Date: Fri, 19 Jan 2024 07:10:01 -0800
Message-Id: <20240119151007.715348-6-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119151007.715348-1-raymond.mao@linaro.org>
References: <20240119151007.715348-1-raymond.mao@linaro.org>
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
Changes in V5
- Drop the dependence on OF_BOARD.
Changes in V7
- Exclude the saved_args when BLOBLIST is disabled.

 arch/arm/cpu/armv8/start.S | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 6cc1d26e5e..2a26b1c276 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -370,5 +370,21 @@ ENTRY(c_runtime_cpu_setup)
 ENDPROC(c_runtime_cpu_setup)
 
 WEAK(save_boot_params)
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+	adr x9, saved_args
+	stp x0, x1, [x9]
+	/* Increment the address by 16 bytes for the next pair of values */
+	stp x2, x3, [x9, #16]
+#endif
 	b	save_boot_params_ret	/* back to my caller */
 ENDPROC(save_boot_params)
+
+#if (IS_ENABLED(CONFIG_BLOBLIST))
+.section .data
+.global saved_args
+saved_args:
+	.rept 4
+	.xword 0
+	.endr
+END(saved_args)
+#endif
-- 
2.25.1

