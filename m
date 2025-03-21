Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BEDC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 05:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 813E4807D7;
	Fri, 21 Mar 2025 06:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvyE5OM4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B888808A2; Fri, 21 Mar 2025 06:39:41 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 867878001F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 06:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=malysagreg@gmail.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso1330724276.1
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 22:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742535577; x=1743140377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IbEmcH4cOdQWESQBXpC1CwLeCCCkZWRuCKoBfwuPHRM=;
 b=TvyE5OM4nxVIiEZSKY93T5TgsSzit7OCcHmGLOOcoNnvQDKG5So7KeM+JZ7YtiKUnJ
 QdEQQJqomat2MlP0VGdXW1zUX1yn6deQijyUImnSqDemZHH1WMXF+1lt/a/PlETwQYY3
 joiErghbEs+QaDqZO3H9l412qPGg89H74SKwW1SJ3iTz3lyVbgPz2SpHbZ5zpuqbBfHg
 63isXk/4XTgnzhr5YbRi7RpnUN7Ps5Wfa2sRqLgPkx1KDmfQq0FQkbwDnfW81HGrw9cj
 8+db13V2sGkhbdaiNeV0hz0EWHqYJ67+iWSxvdXMsY0Ztkye6RvSTJvACKWMdKC4NpG/
 QWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742535577; x=1743140377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IbEmcH4cOdQWESQBXpC1CwLeCCCkZWRuCKoBfwuPHRM=;
 b=drCF1eJb6Zu/0DHatXSz4p9pjuzyMoDfV65CfIt9YmmSNakzTtApSuh4w97gTSZA6W
 cdGujQ6qGnmXfXEGxrmqDf9dkgJYF9iIX+6zMlpHDz37xOWNp3fQrMdeH/xXseKpJe8x
 KqZICETDVxsnBJUC/42qm6RHAlhO95MuQFiBybbUSHxoLeBfltCThSORkjcKJpgjB+ZM
 av5XMVdU6sAiD5UzdGHYG1IUpL/Pvpq6sxGfHqAt/D2xG3chtFZRVMmnyiuuHPsJ4N1r
 1bEhfviZ+5sYf4zWq4vmMkQPXUmE1WckxBUB/tpOEszbzrXOk1qytsyEerC7A8WOHlIo
 ARBg==
X-Gm-Message-State: AOJu0Yxyl4iSOEDqihPOhiyTPSVvJXeoEgcRIWq0xh0Tv8/iFbS7M8Ta
 TnzkMECeUJ/dj+8mdWuN58iqrueRTlmX1BsfQHs1yXzs1OTNtT4eUAqg
X-Gm-Gg: ASbGnctsq5bg3ZgPbh1HBq8qPFf9wupSeCG3Rmi45Ar8Gk8B+d9Br/RvJPaXfePg1ui
 N/tUf71NaJgTLsZF6O0njnBU8HcAvQpdvnVC3CkOb9oEbVTWbkptOAy94r2DTWRCh/zRKZ8F9An
 fGeJB+Hg66e0jLmvZ17ftYafACe0dnjcAGF02d2SmhRGvEoWya2G2reAlN4nJmiLY61+INnvM51
 ooqM11Xygwy717T5qV5lkbMr6FSv0aUipax/L8HioNdLJL1Kp0jU4QbxQ4+2Eb0/hyth9lyej97
 AanuzHJ9O9YBaM7AYMSXog+MhZ4Rpugxqra//g95uvQaYJPQLQoeMGf1eequ
X-Google-Smtp-Source: AGHT+IF2LZfMAih1GtV+xuaielPuvofU1HQDu1gvWjB1U8aW6PRsEClN05p0KeZ2Nn+mAUh60OA2uA==
X-Received: by 2002:a05:6902:1687:b0:e60:a3c1:6ed3 with SMTP id
 3f1490d57ef6-e66a4dafe00mr2668463276.21.1742535576734; 
 Thu, 20 Mar 2025 22:39:36 -0700 (PDT)
Received: from executor.attlocal.net ([2600:1700:5eb5:1ba0:dc1f:cff:fef9:435b])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e66a4469a89sm206504276.47.2025.03.20.22.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 22:39:35 -0700 (PDT)
From: Greg Malysa <malysagreg@gmail.com>
To: u-boot@lists.denx.de
Cc: Greg Malysa <malysagreg@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH] docker: add ADI build-related tools to docker image
Date: Fri, 21 Mar 2025 01:37:42 -0400
Message-ID: <20250321053854.12959-1-malysagreg@gmail.com>
X-Mailer: git-send-email 2.45.2
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
Hi Tom, I'm not sure exactly how changes to the docker image for uboot
testing work so I wanted to get feedback on my approach here before
including it in a larger series that will include the ADI boards. I
think that maybe 10 years ago the ldr tool was available as part of some
toolchain tarballs at least, but it is gone from everywhere except the
ADI forks now. So in order to build the sc5xx boards in CI, we need to
add the ldr tool. I've built an image based on the resulting docker file
and -next and then hooked it up to my gitlab runner to test things out
and this is compatible with our upcoming patches as well for a full
clean CI run. Please let me know if I've made some mistakes or if this
isn't the right way to submit changes for the docker image.


---
 tools/docker/Dockerfile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 569912303fc..f444accf326 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -299,6 +299,15 @@ RUN wget -O - https://coreboot.org/releases/coreboot-24.08.tar.xz | tar -C /tmp
     sudo cp build/coreboot.rom build/cbfstool /opt/coreboot/ && \
     rm -rf /tmp/coreboot-24.08
 
+# Build ldr tool for ADI boards and install to match expected abi name
+RUN git clone https://github.com/analogdevicesinc/lnxdsp-arm-poky-linux-gnueabi-ldr.git /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr && \
+	cd /tmp/lnxdsp-arm-poky-linux-gnueabi-ldr/src/ldr && \
+	ls && \
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

