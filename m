Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56510C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 19:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FD482A8B;
	Mon,  2 Jun 2025 21:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hys1aViQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CFC8212B; Mon,  2 Jun 2025 21:47:10 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7ECE81F0D
 for <u-boot@lists.denx.de>; Mon,  2 Jun 2025 21:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-70e3c6b88dbso33005287b3.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 12:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748893626; x=1749498426; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vxfgR/cfPeLSK8oKHFzkupipCo3MGxFFfqVmuIwaVcw=;
 b=hys1aViQaVBASwIC7vWgluM4LtXSVFPz6LvkTVDLFfs+Bwal7lxAyd9pi0e7v0xCc2
 5ZC2gO8DkA7ATaA76+H5AxoLQXlnawTALJBf0tKIWmLSQiZ0Ad5nfkzPsXMBxkddpWa0
 ecOo4Yu/1iHSS4Jm7Rib+gHezaQe/NflBZ0rzyC4uxxdKYwgyTQrNG7pg34g2IIxNxXF
 wJXDHNRsP3fw/d3mSsuSJFILpvAHwx94gZTOLh0eWO+wJstaatFpb4Zk6/Ah13j9nXPG
 JNpOE8FKOzmL8zeQj1IzzSHm5xIuW4m7dR1IcVJzv/1lEMUWYF0frGP2bEiM/L/ZKwDo
 vViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748893626; x=1749498426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxfgR/cfPeLSK8oKHFzkupipCo3MGxFFfqVmuIwaVcw=;
 b=q+11dFemlZeixRpn88m7wQQuPZqv8y2kBEw4754oK/KdOhQ2Ok9WUAx4Tt7Ry/EXZ3
 aFs3nuRAVN3T9mMGBDVa5gd+f/saJPiTBv8+Q0tVIpKDhicoQZ9IjS0jxp/aYif39AMF
 bSLhvPRxfi/5hHUBbjHWSrT2omVmBkdKC7Ugwpn3rU/DFoqrg/4wsEr7L7/r828bZlzX
 OWi4HLz/HmxRWyANme83ShBbuK0UL8HrR1fjBov1u9rjZAagX+uu5GY54Q3lPP6XB3ew
 sxbs1P1j1oZ5OXkZqh72Zxp1dXuGPhFZmyioRBbmTGpH1pmy+xGvbBxi5zrAswxCAEoh
 HYzw==
X-Gm-Message-State: AOJu0YyJ0gY+dnRohkdc6MtdfYi+XMzLguuZT7QuLEu2Wt6Fp1uyWqLH
 qmsjdsy+RBJl++hq3BGTt2InyjUHvjxgYlt9NtC7u74rLvDjxa4VLZODD1UV
X-Gm-Gg: ASbGncs6F59bWX9ND/J4k2k28B+lj9HYcVVx/+UaABrAhdgV0L+yJ16F8B3GeBSUM/2
 ozTVcmI+JjBoXSYet1NH2x3N55Jxoe5rclBu9OgiBrjJ3yli9RLpWhB1PBA0lBOojpUd4O2Yf1Z
 2TbdMRgYtFZ9TVIqNmI9h3/isAfIZTfLcvYchkH+MfoJxgwMnop04J52VH2KYGR/xiOPCVMs/Mc
 /9Gz1f8tNESciHceh2lVBYk40nGl5rAumeH9EArMCbv0hJY7jgKGU4xz/A/Wc/G/ohspPhZpWFQ
 jCaiVD0mILC8prlFzQq8NxvUiRPxlQTun19GEywkt2dRcoWZnBULkCZ9agkkfRT9Ai2S/CyCsZ5
 5Jg==
X-Google-Smtp-Source: AGHT+IEyN23dCyZ7hmsjVtXSLr9LMhSH27yw/pC3BNsoaJiwoRlLM1PGTVaNAYar/Rkl+VIepecNwA==
X-Received: by 2002:a05:690c:4d42:b0:70e:185b:356d with SMTP id
 00721157ae682-70f97e7c491mr210783637b3.14.1748893626065; 
 Mon, 02 Jun 2025 12:47:06 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-70f8ac0f452sm21902867b3.51.2025.06.02.12.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 12:47:05 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/10] docker: add ADI build-related tools to docker image
Date: Mon,  2 Jun 2025 15:44:41 -0400
Message-ID: <20250602194507.15159-4-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250602194507.15159-1-malysagreg@gmail.com>
References: <20250602194507.15159-1-malysagreg@gmail.com>
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

ADI processors require packaging with the ldr utility for bootrom
compatibility. Normally this is available as part of our yocto-derived
toolchain but it is not a part of any other premade toolchain, so it is
otherwise unavailable in the docker image for CI. This patch adds a
source build from the ADI maintained github repository. The same ldr
tool is used for arm and arm64 for all of our boards with names adjusted
to match the expected $(CROSS_COMPILE) for these boards.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>
---

 tools/docker/Dockerfile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index ceb7a25ad4d..1c4a169e079 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -308,6 +308,14 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
     rm -rf /tmp/coreboot-24.08
 
+# Build ldr tool for ADI boards and install to match expected abi name
+RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-linux-gnueabi-ldr.git /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr && \
+	cd /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr/src/ldr && \
+	./configure && \
+	make -j $(nproc) && \
+	cp ldr /usr/bin/arm-linux-gnueabi-ldr && \
+	cp ldr /usr/bin/aarch64-linux-ldr
+
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
 RUN useradd -m -U uboot
-- 
2.45.2

