Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83479CEBF93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 06:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F8EE83CD3;
	Tue, 18 Nov 2025 07:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hs2MLrwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343DF83CD2; Tue, 18 Nov 2025 07:40:47 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D65DF83C64
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-789524e6719so26421727b3.1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 22:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763448043; x=1764052843; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8J4v33sIEkXFvH6grYUHdooTjL2BsVjYDReij10pCyk=;
 b=hs2MLrwVs+43ZDJFwnMQoX21OMp7non3+e8r19Q3P8wdRfB2MWH64pXqjnF7GC/rNp
 gioUzH8O6VmAP7Xq4NUBOcl73p3mvX2ie4XaMZqkTvdMTRwJ0edXLE3oKc2bfTVXnVry
 irRI2FLHbpWoBHzvAfzt2bVnvPGyyw4xEbJ/IJ+addr7LcWu2YrK5u60M7bapa3IpC72
 1/QiIqrlifkXz0e+UaM9E3d2oE2UWvAaZmlNQg3EEzXOxUN2Wz4WiOPjFvRyjzE7e4vO
 1IpmB9mlqJ5FJ694h73Nds15qG5eL6yls94Xr+JnZdp8bRq53bajn+7MKOPFQQMOeuD+
 LGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763448043; x=1764052843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8J4v33sIEkXFvH6grYUHdooTjL2BsVjYDReij10pCyk=;
 b=ZjhonZlXO4r+3elSzdwSGD/WC9TRMDbp2zOU7u7n06wLaHJbqHU1DTvU9PxHqdm55u
 KrVF2RXTWp+E+ozUOLCFpmhMIhMvVX+tGrAoaecDfn9NYqnGWREbmPJXFGFajTtRz+TS
 f4ooHbdzVLAu7SbfFq54xOb+Z6HMYzVr+wCeSQC8CTD7NH0D96oceVGzsQCh7YB+P8sl
 ssmpGyBAZIDU2BrNRS1UQK2GHBnF6k0xQvVnaG5i19g579uWhW20+cN2Ttlr/D8y2YH2
 rBRT3IS0oWOKF0/jvWrPy6ClECEv8nyCgWc9zRF91NxqkwFQ6qZOswVNUsDxhwyiux4X
 qdjw==
X-Gm-Message-State: AOJu0YwoIRJ2hYGzsy/DjZyF4bNNcHAvGdn6frFwmkj+FkUSWnxx4mii
 2yXPdHSJmFqTT2xqhbCcGwJR093blXbw13MGFrAwP7jyFX4MHmQOAP3SBCns
X-Gm-Gg: ASbGncuGHs6tLp0ln6yeqvkwlyVSYG1HwWRaSRDThN6gkewT+pvXxqPfGtHXJQdQQcc
 LX3zThzJV/GHzQmimHv9pO1Y8giki08k+BI28gHROMqxXJWBbARCSB3WxY9VG1LFICtFOR/5WfX
 r1vnQcPW9SM3NOLCFG9D8eGAKRjtw0qYBsvn2waaoYnPpgaoIBpxuRgOop0qV3gDCnrBn8BvbyX
 VMm8Kmic66fO81CEHMkKFA87ZEMT4eWRNo7TzRx0EuudaX61In8Kt6jCoS1uPoOucsWb65TwTmi
 DezgSrV6G33tkWMAP+uNWNJ3smSqe0pZtnYW7XgaR82LVPbSEoLgzoJz6ku2CSH1twvbD2vQEX6
 73sMV3/5QOFzrOpSO5eDzx9JIHpfqDko3a0HLzP4ImAvvP80qz/Z0ufLafWdEKHDpYo+C1AxM6o
 BLFVYyLX2YbZUJo5+8uU+ksxigeQ==
X-Google-Smtp-Source: AGHT+IF+H2EC7+VpngExorQi3OcTJngbqv6iln7bzuzP+6B++yGxBaxwsD+f3UrVjTWzoLO4gmayVA==
X-Received: by 2002:a05:690c:209d:b0:786:a68f:aec7 with SMTP id
 00721157ae682-78965006618mr15972807b3.14.1763448043252; 
 Mon, 17 Nov 2025 22:40:43 -0800 (PST)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-78822128160sm49781967b3.32.2025.11.17.22.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 22:40:42 -0800 (PST)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: adsp-linux@analog.com, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/12] docker: add Analog Devices tools to docker image
Date: Tue, 18 Nov 2025 01:39:38 -0500
Message-ID: <20251118064000.14613-6-malysagreg@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20251118064000.14613-1-malysagreg@gmail.com>
References: <20251118064000.14613-1-malysagreg@gmail.com>
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

Changes in v2:
 - Clarifications in commit message
 - Update to use meson rather than autotools due to changes in ldr

 tools/docker/Dockerfile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index d2384219c06..9b266547361 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -339,6 +339,22 @@ RUN wget -O - https://coreboot.org/releases/coreboot-25.03.tar.xz | tar -C /tmp
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
     rm -rf /tmp/coreboot-25.03
 
+# Build ldr tool for Analog Devices boards and create prefixed symlinks to match
+# $(CROSS_COMPILE) as used by different supported platforms
+RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-linux-gnueabi-ldr.git /opt/lnxdsp-arm-poky-linux-gnueabi-ldr && \
+	cd /opt/lnxdsp-arm-poky-linux-gnueabi-ldr && \
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
+ENV PATH="${PATH}:/opt/lnxdsp-arm-poky-linux-gnueabi-ldr"
+
 # Create our user/group
 RUN echo uboot ALL=NOPASSWD: ALL > /etc/sudoers.d/uboot
 RUN useradd -m -U uboot
-- 
2.49.1

