Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD318F364CD
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D848416F;
	Sat, 11 Apr 2026 09:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hi1hUeyk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E0184120; Fri, 10 Apr 2026 15:58:42 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54618416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-50d63635d80so16672751cf.0
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829520; x=1776434320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjMt5FfFUjBZkNKWcKRTVKFgaNmjlBbG3pSMdJEyPck=;
 b=Hi1hUeykct0aASitpAznUorH2k5piHIv0X65NPxxMBsD+IwJcZv17M8apJ1geDB51p
 LSn+c1hy1o1uHARoKqvuv/oosBLml0A7sf/BzMrGl4wLgQqIPYRS88gQie7Er5IyevZf
 rzwLOpSfwU4dhiffBmDa37tdVYtGGSQuG0XXX6e83PmhwBjJK4t+R5CdaJ7Y6HV4lIPr
 JiD169BFWkfgEJ3+C2FbR+diM3mcYSpdiJVOpMsZ1YJ3zqMP4kAANbcngOvGtkPv5XNA
 7S+dkiH7EPodXthPcJwTPXqy1gGx+Ub0nmqOXC3OitmKxdRDEKpVrORFGbi/GJHoUjbP
 LvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829520; x=1776434320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pjMt5FfFUjBZkNKWcKRTVKFgaNmjlBbG3pSMdJEyPck=;
 b=B/Fe+1/giROIZUKDuge/u9UYjJMShbHIyJH7ZcbRMVmk2xuUtzv0bdo67eV9zBfS0+
 OvkGwI0A3fiazWEvT3/2w6uhGLfHKAO0q/WjM8mC94kLmfyZHDIpe/dXpxIEnRyhtYMu
 XcR0JO75714dhGYtVhBhmxmId/7wUbPzjlyUReDE6jBBJCbdgZjLstlYTmElMa07xdue
 eYrOzA6Bdbc+j+hGA6kFehW29VWycZjxTC1q7Zl4lLtysVqkVBbhFPoXdyunAqVTrkL2
 Fd/9NvgeaewzrFcIDhxWjvnrpQmMD+OLLi9CWLv2Ly53G2KYC1g7zvMSKZcjZCKNud4T
 z75Q==
X-Gm-Message-State: AOJu0Yyvuu+tjs1707Sz7gsm2N+G3x7OGjARddBayKa7AUrdp3L3KjLx
 Zx0Lww0vmr9hCUvdkxssl3eU5/yRKkVXTZRIyjdiKYNPlk1VnnoDqk3iyCJ/9Rhr
X-Gm-Gg: AeBDieun49I/kSclwEXShdHf5uXwsWwtw6FbXwBBJFkYkZarXTulqo0Fq8J06A692+Q
 Izaa03XQvln+baQ9uWxoMOmw52lLmWz3hGuUrekIkV8V6x2cEGeIveGCX723RNyt4WgQiszSAt/
 sxxzoLbViUQUYNtZJg0B41IZV8hg0BFrIqYbpov0PSL9+TwFaz3L3/iG8D9cZIz1BN5jT+Hcfkz
 Klwy62CuO8kHjzET/Rj2sH/KXiwAr/sNDhphtOSGdB4qXFFm6h7TtrrPA15oGV0Q8HJDsXUPvBj
 mFn71kjiw5T6UHts9hpmQv8i3ha1beyNmDvOXuqywRL4jEL6XlZbzu439Y+nYnfEt53MZmiHCmW
 7rO0gVZYCIqa3JnLh6ENLFK6BqiRErXQiPmX8iy2bRJat12+TSolQ7bCI/F1oFaMoIN3iTaT+o/
 KaelxCDK6iP3dSsq4XO3J49YFy4kO/s0vDGw==
X-Received: by 2002:ac8:5708:0:b0:509:37d5:7a41 with SMTP id
 d75a77b69052e-50dd5cd7b7bmr45609731cf.63.1775829519627; 
 Fri, 10 Apr 2026 06:58:39 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:39 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 07/14] dts: sc594: Fix gige-reset line on EZKIT
Date: Fri, 10 Apr 2026 09:58:02 -0400
Message-Id: <192087ab64d0c87215926dfc04a8d73f841877b0.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

