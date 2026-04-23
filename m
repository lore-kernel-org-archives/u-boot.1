Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E97AFF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8E384564;
	Sat, 25 Apr 2026 22:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QyzgCyYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBFE8419E; Sat, 25 Apr 2026 22:01:48 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7534384154
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2eadb000b8cso4091769eec.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777147305; x=1777752105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjMt5FfFUjBZkNKWcKRTVKFgaNmjlBbG3pSMdJEyPck=;
 b=QyzgCyYM3eletKwDXR5Hv4cuO2ToN6v7MWb3xpJT0uzQMrvd6SMp5ex8NVEr5TNTrQ
 RUyY/SxfZ9fwrG9KkrWHOh6GktzN0ulWP1bbkymLCl4FX1qPipXGUpbYdpO0iPcucBqD
 zte+oKo/gzflCpYUdGsJoAbDGMWP4f7xefUhurqqjJhCPFI1VgQKxAbEidmlyJ0NWctW
 thIS7myDzX2+BAlAaLZ/h/R5dZGTcDaDjhSdlrBQzAiAjnb0q8gM+T6Hl6azmBga2XYR
 ZgKNs7hLNs8t0ry9evV9p2E8ta1KbQH74KT0+Nwpx5xKilztWr4tg4cr2naolL4fmtqt
 ylsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777147305; x=1777752105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjMt5FfFUjBZkNKWcKRTVKFgaNmjlBbG3pSMdJEyPck=;
 b=cxVuDT6SQhk77LZNFJe3mydKNcE+jpcpi11yhVToxAecVDrF/sEpBtktIG6dN4ilVF
 75EMVaqtp3GznxVvxG/UNkI8c7JjaEunpPzzCOs0slnOBP+yOYsYrO+B4o9FFD0NAY38
 DK8UO1ripPs402p+kTAErBO1tlaFQfMMtRfbAtcDTbmJDzl1fWcEcGwZiCMdY/yusVmH
 DjkHz3qAZ1UxYzySigMPhRlbjYtYQwYSeYTCchgvMmjlGekeR8CJJTkpuoLrIShoN+WS
 J66rCmkgj94QKFNaY8abExSWeZ2yR8sUypJ/lL3dFsoOnlemUhpi6rU8Fp6DK+WFurkP
 S+Lw==
X-Gm-Message-State: AOJu0Yx7HkB7nzGIEYkB+GQFHKai/KRmzMxxtdk74rb4aeDkoTSx4M4n
 qskYJCTL5e8+X7izTcA5RkjsDZsz8I2iF652WnaSWjlZPHwXy5aeB0T6Q7n/17SK
X-Gm-Gg: AeBDievn2ymb1ffqeZ1rffJ8dGmesaHOHr2ExHAGAKWMym0tmG74nQAAaoDsKpljZLe
 ErMS71TkP5aP6IrkwKNeemGKMZo6MaPyInKDBeaKsNPvyZau8nrRvx8q3Y7gGQ6bFpdkMi66Yvu
 prLEkPvSGub5lts9S3tnkic+EAEBYMU6WVtJ+dZREMbGYYOIk+veeKyZ3HuigzK0hlYozZzslxc
 z1KfRXfLFW0tK5u9ND8Iu+0llhlHsQ45Ow9WeUr2dMYwVqsavJKOpbpbaw1SvtadnfYAwQqe50X
 Mz9v9Wx+StpXd6baYOGFQU2BCxx4Aat+TIp5HueQd7gE0n8VCgj/mbzkj8HCE+foarsdBMHQW9a
 gn3K84v5CxWUY4wtpYw8SMD2CiyMF6AG8Fs3YW48shzLH5iVn2mvT9+rrRoOglusyeGfnIwBwFN
 ojKkU9lSweT8VrM0mygwId9g3+cjizY60Gif9HrIIF2hEv
X-Received: by 2002:a05:6214:8016:b0:8ac:b328:1314 with SMTP id
 6a1803df08f44-8b028012885mr354293876d6.10.1776954348281; 
 Thu, 23 Apr 2026 07:25:48 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:48 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 07/15] dts: sc594: Fix gige-reset line on EZKIT
Date: Thu, 23 Apr 2026 10:24:42 -0400
Message-Id: <4d5f42ec120979816ef2d26fa21c350efa8bf37b.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The gige-reset line on the EZKIT was updated for the
sc598 but not the sc594. This commit aligns the two .dts
files since they are describing the same hardware, the
EZKIT carrier board.

Fixes: be79378 ("board: adi: Add support for SC594")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/dts/sc594-som-ezkit.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/sc594-som-ezkit.dts b/arch/arm/dts/sc594-som-ezkit.dts
index dea9a6e27f2..396502b6745 100644
--- a/arch/arm/dts/sc594-som-ezkit.dts
+++ b/arch/arm/dts/sc594-som-ezkit.dts
@@ -130,7 +130,7 @@
 
 		gige-reset {
 			gpio-hog;
-			gpios = <15 GPIO_ACTIVE_HIGH>;
+			gpios = <15 GPIO_ACTIVE_LOW>;
 			output-high;
 			line-name = "gige-reset";
 			bootph-pre-ram;
-- 
2.34.1

