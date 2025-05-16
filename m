Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11954C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 14:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA278006D;
	Fri, 16 May 2025 16:13:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UFv1FLtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E621080079; Fri, 16 May 2025 16:13:33 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9634980050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 16:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so14555915e9.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747404810; x=1748009610; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M9bhGZoU+syG8K7bCN/jU6Bd5VDEIqsiYyLB1QzG/pE=;
 b=UFv1FLtLyhzUbGlu7qfPmbPL8OCtnSQbDjpAdmA6nPS+yGIeYKaRMCE8K3AlE6jyZB
 JimS0tVYLIXayrJWskbSNFQtfOU9aMk6JhKwg5thDMIqcrBoUUooN9W+RJAj6r8qjiFn
 SZ2q4LBAgbPnF2e1NADLA5+6uP1iDbS61Pqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747404810; x=1748009610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9bhGZoU+syG8K7bCN/jU6Bd5VDEIqsiYyLB1QzG/pE=;
 b=RwAKzGZcqAQzhbkrGoHJd+3+yXgOrMSnSVJ9Xd28EWHrwHlfBFb+8R/BfAPSweEKOs
 JEj5NGXQ8521iqIUj3aCxPza1cFiD3+EPRSKv2snfg75lXMVEEMifwbRjDcxWbyzp9a7
 DxVeN17GSzIAFlfJMDohGslz9Y6m29UUuvNLOQdQ6UQlkgftrVT/M7HOlNjQoCmnST6i
 DpDwvbmMoNf+76BF1TwRJ9cdH9/sMAKjiJTnhxzJQXx9Er2TG0tIxIPBUk3Fc5sg9+lC
 88vDTlBy7rmDDc1JUV5BUP9tQ9NJX5JNVF8efl8qNx/TL6p9xRMIAcrIoXufhKd5VVjY
 q9Mw==
X-Gm-Message-State: AOJu0YyPFLAMWitbQ4+F9A7WhyaHzuGrA+y8zxS9q0TEVz8Ap5u6FAOJ
 OnW4CWVEOmzJ95MClSqvxhAAPDsTnerfn59IdQYVHcog+0BxtwuIhl/BJXuQ60PV8E4JE+VHKgB
 9QHj0RGaScI5VIw==
X-Gm-Gg: ASbGncvi//UNecEb1I1DOHvFBg5DAEtqYrN6RC4uKcRW2tH7WVNSvLba9iIl6MDP5vh
 8fekbsOZL2WMTCQ7584UAtWSPbDpON7rbOJa7svMcDeugXxrrPaP5H9Bgasux+ONBtuMRY2kCdA
 Zx0IRJPzcmpgceO47Bcc4HqBFjN3uHliyeuc2V5odV2we02XkjHmh0yUitzna/nrJmSweQjJQbg
 V1rE7Olu9s4Bxn511ozM+b4IbA1/2er2OrUqqZds570DwKXS6qq+x1c2/9Clw3yyHGGAML06E7M
 Y5lkFxa2WkuAqxG4LnRh3O/fwF8eki7p0u52cyhi7h9nOq4=
X-Google-Smtp-Source: AGHT+IEzy6HfcJ1gYJ/yrLCcufcv7PBfUKlmWwyLOMKS29axvpMs96hQfsQ98rNSbCUjNdHSZwYAGQ==
X-Received: by 2002:a05:600c:3e0a:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-442fd5a2c09mr44591285e9.0.1747404810265; 
 Fri, 16 May 2025 07:13:30 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8896dsm2966222f8f.73.2025.05.16.07.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 07:13:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jerry Van Baren <vanbaren@cideas.com>, Jonas Karlman <jonas@kwiboo.se>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] fdt: Allow expanding the devicetree during relocation
Date: Fri, 16 May 2025 16:12:56 +0200
Message-ID: <20250516141300.384736-1-sjg@chromium.org>
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

Some boards set fdt_high to -1 which means that the FDT is not relocated
in boot_relocate_fdt().

A comment in that function says that we assume there is space after the
existing fdt to use for padding, with the padding size set to
CONFIG_SYS_FDT_PAD

However, there is no guarantee that this space is available. If using
the control FDT, then global_data is immediately above it, so expanding
the FDT and adding FDT properties will cause U-Boot to fail.

Use the CONFIG_SYS_FDT_PAD option to expand the devicetree during
relocation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use the SYS_FDT_PAD option instead of creating a new one

 common/board_f.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index bff465d9cb2..5b7370b62bd 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -583,8 +583,10 @@ static int reserve_fdt(void)
 		 * section, then it will be relocated with other data.
 		 */
 		if (gd->fdt_blob) {
-			gd->boardf->fdt_size =
-				ALIGN(fdt_totalsize(gd->fdt_blob), 32);
+			int size = fdt_totalsize(gd->fdt_blob);
+
+			gd->boardf->fdt_size = ALIGN(size + CONFIG_SYS_FDT_PAD,
+						     32);
 
 			gd->start_addr_sp = reserve_stack_aligned(
 				gd->boardf->fdt_size);
-- 
2.43.0

base-commit: 4c26de2eea6bcf5f27b13da0372d27d767cd38e3
branch: fdtb2
