Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED55D41C01
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 08:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1E2983106;
	Thu, 11 Dec 2025 09:05:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WxrDDku7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A5783CF3; Thu, 11 Dec 2025 09:05:56 +0100 (CET)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97766830E4
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 09:05:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-6446fcddf2fso567411d50.0
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 00:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765440352; x=1766045152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fvoWeXRVmpUJUClDYsZLA7Zb4r1/RO3ZxCIni+mF9M=;
 b=WxrDDku7Uiir9j3CmnziuiBT4bZI3kFMWCmULQPhKaTghr6GEi3pO4XKtBF36K3iEF
 aJRUeQwGBfotxeEF4yJwlzUn6NSPf93YGwUec9yZoUC6bn2KqM41swjbfwdpXzm+gqB0
 RJdrUfijE+AmrR50ebd/64YaL3RQMXYDfEJ/ZAA+HlN+HuAckDtyoXEiiKpa1P+q1tTT
 L/IhrVamMg+lsdBr/iDToinR1afDf9FxfPJtUJgldYKlBhTsCJjquLYAGUsZzBGCsAZ5
 eZhSlcOx+L0tFBmG46oWM7rG/L+0yLTit6e+5XXUjajUouRf7ZPg+biICflraStZ3z29
 gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765440352; x=1766045152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2fvoWeXRVmpUJUClDYsZLA7Zb4r1/RO3ZxCIni+mF9M=;
 b=i6/kPvpuc8lOdoq26WjlYywDPxgGMWfZ9dkFCWfqrAVVm2wDzlcqAkQZooMZUkCXIe
 WwMXLnr2rn4mduGKt/Qa4mlAapvqGj8S6OxOzepGBxW0TTTj6uImjOnFZJ1fKaq6+gkZ
 FBsUFoFCJ7jMi8tuC8odbUE+ySsT7e28xxCkLWnkHAMLzzKJMqWKoTQu9iMra3AwHqyT
 PVJKHJGenfvAKhR/vomUTCScdd8zun9FbobLVIZKO1d8NQz6vhIzRloxauHPW/dcn0a3
 MEWcL+yhQnzqSptASF5YxhYK//dqbZ+N6AMoecjV3SmmxaZ7stViPSbXeiHmDEMBHZGw
 5l2Q==
X-Gm-Message-State: AOJu0YyN1wuRfrXAA1KtBl0le4f8+1Zeec+IzTJuo98R03UYyxqBxr97
 9vrLdW1U2t4Ig6MaN8dRJMpH4PR2wMTaSFg5CdQd1lNk1X2EHd/DkyHTZJao
X-Gm-Gg: AY/fxX59RXnrpC0vrWHaiVqGsplj9DKW31NRDVVbxH6Z16ZQ8JLlBgeV2lAihgXPvah
 GXBMyyOn9iObEjceswPBSt3UetBxVffO2WsfJMdkErSgYT3yPWh3xSRaV0Wv3Rd8uJWyDG5nusv
 BFGLYFsl07ki/2BoEf2Y5nKVy0Cg3OQATY64mYucqh+VR0UJe0iTRkzQ7hDlgIIiUGQGalW0LMw
 jVVSELkZDsj4p56cwayjZ0021FXWnAlsqdBbfajKZaKlvABIz6Gymr+b0WUA73nNmtaNB+/VJjJ
 lLROWt0I9n+nKX4SLT88lsH8hXvPKW9NdyzulQGQ3JaijTl9StrD/d7s0/DdFUB3UeDjaWieFVT
 Jx4mvE4BYOIO5mu+18NjN7ozs18RNVL8A8Otx3GnHRRR3Ln3gEr9t8cM6fFNxAw1cm0FVbJni2n
 5IbtgGf3FPAEnsO32R7GXKZrc8xKNIjd5BLFXl
X-Google-Smtp-Source: AGHT+IEp76/Qd+lAtdlmxJP8mYWvR3SxVqz43EWtP2u1fJSQJ0ECME3JF/Ex24v9CF3vmUpS6DdmWg==
X-Received: by 2002:a05:690e:4287:10b0:640:b501:d7dc with SMTP id
 956f58d0204a3-6446e982389mr3606466d50.23.1765440352140; 
 Thu, 11 Dec 2025 00:05:52 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78d69d83a85sm7256657b3.28.2025.12.11.00.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 00:05:51 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] docker: add Analog Devices tools to docker image
Date: Thu, 11 Dec 2025 03:03:56 -0500
Message-ID: <20251211080414.5363-6-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251211080414.5363-1-malysagreg@gmail.com>
References: <20251211080414.5363-1-malysagreg@gmail.com>
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

The boot ROM on Analog Devices ADSP-SC5xx SoCs requires code packaged
in the LDR format. Normally this is available as part of
our yocto-derived toolchain but, it is not a part of any other pre-made
toolchain anymore, so it is otherwise unavailable in the docker image
for CI. This patch adds a source build from the ADI maintained github
repository. In the future, a package available for install via apt will
be available, but currently there is no arm64 build upstream, so we must
build from source for the time being to support CI on both amd64 and
arm64 runners. The same ldr tool is used for arm and arm64 for all of
our boards with names adjusted to match the expected $(CROSS_COMPILE)
for these boards.

Signed-off-by: Greg Malysa <malysagreg@gmail.com>

---

Changes in v3:
 - Update repository url to match ADI's preferred name
 - Switch to --depth=1 and check out a specific tag

Changes in v2:
 - Clarifications in commit message
 - Update to use meson rather than autotools due to changes in ldr

 tools/docker/Dockerfile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 8ab1cff5584..fb6c65c6388 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -342,6 +342,22 @@ RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
     rm -rf /tmp/coreboot-25.03
 
+# Build ldr tool for Analog Devices boards and create prefixed symlinks to match
+# $(CROSS_COMPILE) as used by different supported platforms
+RUN git clone --depth=1 -b v1.0.2 https://github.com/analogdevicesinc/adsp-ldr.git /opt/adi-adsp-ldr && \
+	cd /opt/adi-adsp-ldr && \
+	python3 -m venv venv && \
+	. venv/bin/activate && \
+	pip install meson && \
+	meson setup build && \
+	cd build && \
+	meson compile && \
+	cd .. && \
+	ln -s build/ldr arm-linux-gnueabi-ldr && \
+	ln -s build/ldr aarch64-linux-ldr && \
+	deactivate
+ENV PATH="${PATH}:/opt/adi-adsp-ldr"
+
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
 RUN useradd -m -U uboot
-- 
2.49.1

