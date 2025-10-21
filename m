Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C203CCD1A7
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 18:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BA1B831D6;
	Tue, 21 Oct 2025 20:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Gp/cf5XF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D8A2833F6; Tue, 21 Oct 2025 20:17:43 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90ED880107
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 20:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-87c167c0389so93874716d6.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 11:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761070660; x=1761675460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mFWtvWtL3vzUDTQ9V9yVmtkSV+B+9IVqFLWpqVvOJUg=;
 b=Gp/cf5XFmBRhxZNYKPhd3MujilJ/qIMxGHuapUG5jSKUtLxPO0syIp0MWAM/TqrVFh
 3o5WWvJB/2U9LZrd1FS/4AyqUpgOP6oflNwnX7MWryAdRg6y36w2dgCVJarMC9uRHt7z
 biZBBVqXgzQ07Ow0GPbLKu+KlO9rrldLWYM9WTIhFPI5kb4TaQnbd4D/e01tikM+3XfB
 nGiD6A/LPaYnOKCB9lbIxBWjodhtm/4VgimUs/P3acK+FloREz9R8ZKxxgGTxGZJTUoU
 hdAZzqfPuGTPOM7r0WjrE7rgISQ4RRTA57ZV+52rYaYGqRIbcCkZTGr+rNpnwQ7hoM9T
 7EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761070660; x=1761675460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFWtvWtL3vzUDTQ9V9yVmtkSV+B+9IVqFLWpqVvOJUg=;
 b=BZAYttstBCDLNcaiJ6upkCFL7uiAuvhHmnmufM/5+tR0qZwu1OFWw+J6bH7pkxnS40
 YzsvY6qgcReydJQh5Wgsl7re1T/gMdJ92uAeLPqxUgyJJ2uHRbhoZYYIBQLNNEIHMhik
 PH11N+b4v/O7U3BBt1L/rdNkxTdwK21dTLouwfJjdpbAgakZNPsk1l3+Q7zwUJyMD7gh
 SBCvS8zaqolybO4RYNvgI0L17dA0NpL60JgqMEDpMivZ9Spmmnd62VgMMRY12is6MO51
 5wH0mgKEhI8XIkKrrTex+dQV48oDLwUx1sgdaKyWanoxD/CgW9MHOWuc3ZxnJ3hKDajM
 sujQ==
X-Gm-Message-State: AOJu0Ywtjt857a3OHgq/dSEdaVvABIiNhiVTIBUg0U73OEX/CttWO/lx
 0YLMajiAI3tOAry5T/c3GSKVk+Er1zO5NT2NQnMVb0W/cyND9oNJRQqk6lUiVH1A7q+vECzDvEe
 JuEwi
X-Gm-Gg: ASbGncuc7L302umrBfntfv0GPXcJyctr1IYF1fiLxTWlqPxjxdpSTSzrS8AG9NeQ1+k
 5QmrLnAfjiwxFMblDJNmT/kDSTxkyTlxUrw0twnCvzIfXr9CdfsaTKp65xOZ6iKdEceBWPyeDzV
 V+dtwYjQbG5prFe/zSqiNP4h13+ztvL05J1VR7M9KacbKjYCkfk4RAL8pkhnx0bJLPXP6+G2jUR
 4VSvrX+QhvsiLIDGdIIfA8GkXOSUL3nJc/9cNBzVUNd1TvSpXITYH1ssfZ1qhGNloW0QZdhKZU6
 +L0cS1Xy0cFS0i8wixtzND/2RfOirt5beMOCxr1mEOKTk6OOK8YhK6RX5TgoBNFul5rcei+EwA6
 2A9AiK0ncoskNH/MF5aYLn8ElR3KdQuQcZ975RLPAHnNmE6UeKPL2FOs+i7oEYi5VYIGX0HBVzd
 jU+/ZN1+eZnhV/5nM+woJKNCNxG18=
X-Google-Smtp-Source: AGHT+IFaOsW2oCVQWV+Vao820KahebpXstGRTKtgxaTpJwWwLcE5JcbkMbZEXPwRV91KMDinXh1Ffg==
X-Received: by 2002:a05:6214:500a:b0:87c:2797:4942 with SMTP id
 6a1803df08f44-87c27974b5dmr165450806d6.15.1761070660045; 
 Tue, 21 Oct 2025 11:17:40 -0700 (PDT)
Received: from localhost.localdomain ([209.227.150.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d02884878sm72831526d6.31.2025.10.21.11.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 11:17:39 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [RESEND PATCH v5 3/5] configs: select CMD_BLOBLIST for Firmware
 Handoff testing
Date: Tue, 21 Oct 2025 11:16:56 -0700
Message-Id: <20251021181703.598342-4-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021181703.598342-1-raymond.mao@linaro.org>
References: <20251021181703.598342-1-raymond.mao@linaro.org>
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

Firmware Handoff tests will leverage the same board type 'qemu_arm64'
with a new board ID 'fw_handoff_tfa_optee', thus select CMD_BLOBLIST
in qemu_arm64_defconfig for running the test.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- None.
Changes in v3:
- None.
Changes in V4:
- None.
Changes in V5:
- None.

 configs/qemu_arm64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
index 12ed6b61239..a09b107746d 100644
--- a/configs/qemu_arm64_defconfig
+++ b/configs/qemu_arm64_defconfig
@@ -31,6 +31,7 @@ CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_BLOBLIST=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-- 
2.25.1

