Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DFDCD4F54
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 17:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C317E84878;
	Thu, 28 May 2026 19:11:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oBzOLeAq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E853E84671; Thu, 28 May 2026 19:11:50 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C5C84878
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 19:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4854166e1efso7009495b6e.3
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779988307; x=1780593107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9z/5xaUsd6ArDfS8NrBKcYvKGIdVU80n5QQyKGG8BMA=;
 b=oBzOLeAqy7UcK3w4bEOfrnwNzokNUku4KuWkLZDnY0pTJBljmJegWKJvdBQVWhZ37B
 VNb70ZfuFu90mXbKMW8zILn4Yb+Rqydgpn9LaQncqwPpexdlKvd1wCuNgmn6s79Ob5M6
 ZFPhf1ugDfTsCFRzpksJ6uc4deaGsRTItgSOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779988307; x=1780593107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9z/5xaUsd6ArDfS8NrBKcYvKGIdVU80n5QQyKGG8BMA=;
 b=d3mugs1ywwg1vcIaeXUG730FAAmG+rPNoPiU92HG2sln5JGxK8yAF6gh6u7L7f/XQv
 adRUk9+4sEYfLGqVC/B0E3Yv1khwF0du069FpI01+Ny2kfFj+mlkMRV7dB+1myACbSUz
 6Z6dWCO62G8ifBIsGuSm6hgNfIp/55PD2K8Us2bdYXV8cb1KCq5xZuDdiXwqyq7bLZWW
 2jpEVyBkVHCEqDHa75WpyBccIaBYNj1kPMheZDIhHiMEmumesE4TazS/I5pkPmNmI1mG
 Bvy8RRV7nfq+mIBN3C4lw+EacbqYh/hXVz0pSRPeVo9q74fQGuUn7x9x1QUL4H0H4WRj
 9RWw==
X-Gm-Message-State: AOJu0YxLzBsW46JCzAfm/pJRQegUhekd67CT6kSqygnyj8Jmi1LaFk3l
 ty5CtBikxwusoSm+aUjWh6UIcySkLBI+OEodOREtJAwfI/F/O/qeNtMD8QL+DC4/657Dh2njiSo
 DajimFQm1oAM=
X-Gm-Gg: Acq92OFeNm7tQOP+lAcV0/xfh+UxHCKE09fFIkL31EugDDMSPP61SkB17GhH5TX31NL
 AAP5a+Iv3KvPKEyJB00KS+7XKJv5Zz6I/D/dL1eOc26/4CWEpcdRMe/FiOWmql5JOO4Tr06zyCR
 zdO187deRyRbxgjjWVLPUJhctNhSvgjBZn9aixhw0tgqIufTG4EeN+TDsSjs9f/akcCq/Z5QMeU
 dP/n2ZNDxIYwMyuZWwRvnNsp9T3yYWMI6mqZ6lbQcYq4I7Q95i0bHUVnir2ihAQ8q0HMSWsJ39c
 7Rdtabed2KunkTZB6wMhk5BAymXXoSJ9QZPasdgScMj0ChQY+U6mjFzbIuBfX3YWMTddkwJVfWk
 FOhp0tipi01eJpDNTdKx8CvyVbTn49jFMC4ajjBl91uqXIHfYoru8auNJ3k0ryEHsobZw8rRS5b
 2t45gTZ8sQj8ycksN8o7iyR+yR0jLeYn4yjKEXlIY=
X-Received: by 2002:a05:6808:13c5:b0:47c:3793:c589 with SMTP id
 5614622812f47-485e3eab6c6mr43267b6e.26.1779988307364; 
 Thu, 28 May 2026 10:11:47 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm14461068a34.4.2026.05.28.10.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 10:11:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v7 22/22] rockchip: Update binman image for new skip-at-start
 setup
Date: Thu, 28 May 2026 11:10:29 -0600
Message-ID: <20260528171043.910264-23-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528171043.910264-1-sjg@chromium.org>
References: <20260528171043.910264-1-sjg@chromium.org>
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

Now that the skip-at-start feature is properly used in Binman, drop the
various workarounds in the image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Split out the fixes for skip-at-start into a new patch

 arch/arm/dts/rockchip-vpl-u-boot.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/dts/rockchip-vpl-u-boot.dtsi b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
index 66dcf36010e..63e6a5416c5 100644
--- a/arch/arm/dts/rockchip-vpl-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-vpl-u-boot.dtsi
@@ -28,7 +28,6 @@
 			bootph-verify;
 			compatible = "fwupd,vbe-abrec";
 			storage = "mmc0";
-			skip-offset = <0x8000>;
 			area-start = <0x7f8000>;
 			area-size = <0x800000>;
 			state-offset = <(0x7f8000 - 0x400)>;
@@ -133,7 +132,7 @@
 
 		vpl {
 			type = "fit";
-			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200 + 0x8000)>;
+			offset = <(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 0x200)>;
 			description = "FIT image for U-Boot TPL";
 			#address-cells = <1>;
 			fit,fdt-list = "of-list";
@@ -178,7 +177,7 @@
 # ifdef CONFIG_BOOTMETH_VBE_ABREC
 		vbe-a {
 			type = "section";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			spl-a {
 				insert-template = <&spl_template>;
 				size = <0x100000>;
@@ -215,7 +214,7 @@
 # else /* CONFIG_BOOTMETH_VBE_SIMPLE */
 		vbe {
 			type = "fit";
-			offset = <(CONFIG_SPL_PAD_TO + 0x8000)>;
+			offset = <CONFIG_SPL_PAD_TO>;
 			insert-template = <&fit_template>;
 		};
 # endif /* VBE method */
-- 
2.43.0

