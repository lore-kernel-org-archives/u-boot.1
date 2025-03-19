Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BBDC282EC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 01:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C437081A0C;
	Wed, 19 Mar 2025 02:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQ8A1Lrk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AB57815D1; Wed, 19 Mar 2025 02:43:16 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E9581101
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 02:43:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c2303a56d6so699993885a.3
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742348592; x=1742953392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8JUNd3FRXL1TCN0L/Hd/hkyIGxmXa3GrikBPTZj5fI=;
 b=DQ8A1Lrkyi8K5161b/prWEmOP06wIg1GbG9+Rjnyj4+vQ6bBjuCM0R8Pwr/rY8wbYR
 Ox9xDt0HCZT6jq9kGqtDlV9aMPC5R7Vh5EZHtEUwInbyQ01T+BCfjEFf2DJ7rB6lVCzt
 m8OyfFIbti7loeHA6iFAHBrMZu3YjoUpgnV8oTJMxxMnVfij03L3XftpJRyfk3XNltAu
 lpxxXXrvCp/pI1i5X+JcVZW6rXn3FmRl1m3pfVLOsvd6kfqV68W7nE9CTdQWSakXMh/O
 dBg2LEFckvQPvdV7EeL0ThFYRKAkId8xrKXUV/vuauMxkGGbA2BNI6XPXbD1HL6peVPo
 /rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742348592; x=1742953392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8JUNd3FRXL1TCN0L/Hd/hkyIGxmXa3GrikBPTZj5fI=;
 b=SFcE/qBVoAto3M04xS0uVNoQgULkc0tHBfchkSX7xfQeNoxe46cV3UUyxHTeMFSNWY
 iWcLwP0X1LQovXCy4tDqkXyjH8YU4Eh5yUQX4jol6P+pzbny/f087bebpzHzqthvzXhw
 FsCImsNrhEN711aGKCclWIWfN8sRC54J+jce4Rai9NIWBh/uiepKebHguIf2Mi6Lf5aM
 FKem6EUaNI0xhwOUYajVXQAIfCZoX5mSf7Vi4I15YaUboy6XwlV5d+szsvFok8w2aZzM
 EFslQmaQJ+nLWToOjjFbdjbeOT2qLGx/+lFWU1pMuPaLBN6u5uCMeg/JVvhTHndj6Nc7
 lcLA==
X-Gm-Message-State: AOJu0Yz8OgwQbsq8nrQiKOdr9rlwo6cYZrcE0K3Q4SOBOkug+hQc+rAb
 PqNVFmVZyy4wVdrJyPoFxTHv6z/wF90Bx2WVhXe2P9QgCnVTeNntciPgfw==
X-Gm-Gg: ASbGnctoiEl4qZqKovLlnLMbW+sSsEIWaCLCSsQayLr4/ImlL6awD919E7/psxoZzsu
 DkN7HxoGHZeXicokpkhvjCaWiAFjSuXE3cNmfvjKTniSYOqvJIDEVMNcW6UJEESXeqlrGbVZtvM
 uGnkaMG6hoQIgAC+L67631Lfrv08NBUfOPqj0y8yK+VSgaqAG7hQPGmygnYQN+kscK5AbbikqpZ
 mc3MNkFn2ZPV2exhugrcFeu2ZRkqdIBooQkEtu6wb6Lkluo5tSRsosL4+bK+sEI4IZ958IIZjXN
 8IdqxRxJfO0ReWmeQ9FkiPzM+ZoVtX9T42G61aHkoE+Ftev+mzkObEcDu08PTvFMY9xCa6sYcXA
 XsA2E0xILJwsMMd90ICA=
X-Google-Smtp-Source: AGHT+IHi+7kE5tUWYldPfibs0/GPRWWdsY9veFudYmu6i85FXEokGybMV7CPXi85LUQbNXSKU369nQ==
X-Received: by 2002:a05:620a:2688:b0:7c5:9731:3c7b with SMTP id
 af79cd13be357-7c5a84a2f1cmr159576185a.36.1742348591944; 
 Tue, 18 Mar 2025 18:43:11 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c573c4e6a1sm795871185a.18.2025.03.18.18.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 18:43:11 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sumit Garg <sumit.garg@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH 2/4] arm64: imx: imx8mm-beacon: Enable CPU_IMX
Date: Tue, 18 Mar 2025 20:42:35 -0500
Message-ID: <20250319014240.592189-2-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250319014240.592189-1-aford173@gmail.com>
References: <20250319014240.592189-1-aford173@gmail.com>
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

Enable CPU_IMX to register the ARM core and identify the
speed and temperature information using the driver model.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/configs/imx8mm_beacon_defconfig b/configs/imx8mm_beacon_defconfig
index 56e18893b77..bcb60a63795 100644
--- a/configs/imx8mm_beacon_defconfig
+++ b/configs/imx8mm_beacon_defconfig
@@ -84,6 +84,8 @@ CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
 CONFIG_SPL_CLK_IMX8MM=y
 CONFIG_CLK_IMX8MM=y
+CONFIG_CPU=y
+CONFIG_CPU_IMX=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x42800000
 CONFIG_FASTBOOT_BUF_SIZE=0x20000000
-- 
2.45.2

