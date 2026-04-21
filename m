Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC830F327C2
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 08:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BE58439E;
	Tue, 21 Apr 2026 10:52:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9Iq0yXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1039384390; Tue, 21 Apr 2026 10:52:13 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 122348439E
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 10:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so14523225e9.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 01:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776761530; x=1777366330; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5J9Cx84OHMoV0OIrA38hfCXB6QWG0rp88QZE4Ytvaz4=;
 b=K9Iq0yXMTYK9ZdEBpDWHfVG4NY65s/Dw479U/r1el7/f/Ib8hLpuRk6nRW7fX3FHYL
 XDym28YWYzzXwv/ywLFdi5zb5YIOgt6Zym2EzKWtr5GytHc8z/AMv2UrvXj1zp6NZmxO
 2zRF6QsZa2oXC4zz+w4UbY6wfiAU0kYdFk2KucyqNe2Cb5RYWKQSKmWvG9dxtXOybyU8
 4bdksmIuk72pRq9Bx+OpO+epBF3r6ibBjZiUmJAHtElHuzjm3TT5Ax3aWLKzTY16IO8s
 0ZC1sul+8mJTnzw0YVVkFLVymxY8xwQ30IryLDkIHMaZpLJrXV/8UY+Lu3QciVIeq+eN
 EOvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776761530; x=1777366330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5J9Cx84OHMoV0OIrA38hfCXB6QWG0rp88QZE4Ytvaz4=;
 b=aJvsHquZQz8sq2FBRPz7x8XJpQxFxNdxNRttIK8XvPgT3X4BGVt3pe43Yk0LYnVydU
 PCLE7hWWYQnYLV5t7wA17XfeyMzxDk5drWOl5mbgaxFAryM3j4HD7iwXikvLIt7Tolij
 22p/235lSZmc1VSH/5CDPcF1pRwfu+Jxlm0mudhclQTvtelaFEHXdKHX+Zy43Xtib+fe
 2+hV95qcScT6U0/hO9vSX47NAk6qq2hq3n/2lVMhlSU09dlWVbd2qhFr2OML21JmX261
 rQbFXmn3I451bfiHInOaiscWSSFenapz2JgrBCD/tkzCWJsgwoOe9nNrardjfDLHVX0r
 vFRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bI9ltGQ2xcHKXANciB0aPix/1qxODbEpaN71/8HuLYUjnzZcoAYKdzR1cWCGuuZMFL4Lv5Fk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7ARRhiTgS9zVMtMhU/j2cC1weUAn4ndyFynBOct8pydqda2p0
 h0G2OMaSNNakfAy7B+iQro0XKvm8TvHRYGCrjexJxZJC7KDDRTSuEhaa
X-Gm-Gg: AeBDies8A5DjAbWNjuTVXYP4AaC62X86d85xkZY+fY8UUo8jcnHouzy3W7tHI4+aO2p
 oZeKB4715FEnaTKUhaM55jyCccQWFVevZ8/vg062vFGBkD8lKUniQH63n78aS+b0caNKf2t9Qbt
 52B0opHbh+Y3kHatpR3F7xiUvuDp+QIb3rRBoNOqpysqsrp0V8Oz74DHr8Kjz6zS1KMlYW0Covf
 Vmy02V4rsBwucdOC7EkDcVV/ueMoE+ah3fGJeagdaBtiuNAh5n1MJnhBmlQB2KXkPlk4FlvtDrY
 XTcu7jCdudBB+JB4u8fcBQrHSjD2kcC8IG8ci/5Zo2NXBpFFUbUa85dA97MkVgkuO8oc049KIL3
 ULG3VSvH0kkEokFwVo2o5OFccfVTuzWl6UJLJQBIgkT+gcHeFlMDfEK1DCF5c+jJR+brX54/XDr
 VUVbp/NxtAYDeJynO6kxBxvp4y67sYcKQvFGtfi2/gepioTZtk32g9x4L4jspkOVFIXbgpKcJw0
 Cbm3qfqev/Ku5o0RrGrrURe45BHD3ic7dE+D7awJtWh9cnpzMPCii2qcPixAeLr09wI4C1FfvYe
 zxvCrNJ1KQz3K3tyqkzEDBCA9ke/zBy8gCYflG8iPsFrdwi0kk8iadegYvjNB4QOCPqVihuQ13m
 uMJnXgAYFCrwfTbT29bPXEInVCN20wHfh
X-Received: by 2002:a05:600c:3150:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-488fb8b9deamr198670315e9.13.1776761530250; 
 Tue, 21 Apr 2026 01:52:10 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-488fc18bccfsm319754095e9.8.2026.04.21.01.52.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 01:52:09 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Matthias Brugger <mbrugger@suse.com>,
	u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] video: arm: rpi: Add brcm,bcm2712-hdmi0 compatible
Date: Tue, 21 Apr 2026 09:51:59 +0100
Message-ID: <20260421085207.273703-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.53.0
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

The 'brcm,bcm2712-hdmi0' compatible string is used on RPi5.
There appears to be no change that impacts early boot output
on the display controller so add the RPi5 compatible string.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/video/bcm2835.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
index 0c81e606622..0e0cc1979eb 100644
--- a/drivers/video/bcm2835.c
+++ b/drivers/video/bcm2835.c
@@ -66,6 +66,7 @@ static int bcm2835_video_probe(struct udevice *dev)
 static const struct udevice_id bcm2835_video_ids[] = {
 	{ .compatible = "brcm,bcm2835-hdmi" },
 	{ .compatible = "brcm,bcm2711-hdmi0" },
+	{ .compatible = "brcm,bcm2712-hdmi0" },
 	{ .compatible = "brcm,bcm2708-fb" },
 #if !IS_ENABLED(CONFIG_VIDEO_DT_SIMPLEFB)
 	{ .compatible = "simple-framebuffer" },
-- 
2.53.0

