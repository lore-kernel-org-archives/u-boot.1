Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461F4E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B471780690;
	Wed,  1 Jan 2025 23:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cELNHAxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B08680735; Wed,  1 Jan 2025 23:23:33 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D34AB80690
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so14948515a91.3
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770209; x=1736375009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wbk4dfUDN2tck22nz7yo17kZTZD196MKyAVcEuIi+Po=;
 b=cELNHAxh8NfhVH3rDivtdFT4cx7TIEOp688kCoZ+L8XX0Y06BuAzRO52oculhYsNoU
 AOYlMkK+cnv0O9PpL2csQ1EWkICUVx0RhKMjHWyxiHnmkZo0QREsDEMx10UsnRfdgSRM
 140uGrMHh3L5VxotQ9ET3pkkPFqjK97t91+kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770209; x=1736375009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wbk4dfUDN2tck22nz7yo17kZTZD196MKyAVcEuIi+Po=;
 b=mnh1trlMp7XryRXGxCRkIavCM7oBB6XYUmMwanklHvhqBnZhiorus6PX14VkEPdmqF
 8om1lvr259or4rSth9clRAw8wJH9Z0Sa9c0heWPx083OBCsnkPcGiK2ae+lYxKOZjZXo
 WdttsIL9GzerLpxyjDz+c38Mka/KBxTMWHpo1wO4GEicrmzUbBreB0zODXqYTCwwIDPm
 lHjiGaQRCSThCMw6DL+x25PN+GSHcaURKq1i37pveXa8nQhb8SVsr5Led9nN6KdC9CVb
 PJQG0fFnpTbnujN0VWHRgwo/lG1BKSq3RyDzYNQHZqrTfmp6GN0AYRO5U/08vk7h8Clw
 kQQQ==
X-Gm-Message-State: AOJu0YxGHhGMNv5cwC4V6akCDQC9g8+t8HEL3wPdxpItY7wd4Bxv8ziK
 9vn77r1VV9TVpbQnSy7fF2ayHB35vMwyg8j1l+m9bXES73xRNw4J8+9uC3TT7LN4aNesjbt6bxs
 =
X-Gm-Gg: ASbGnct2WFTjPhQkfh67HQS4NBgFgPxuS6yanFMZGZLzDMxTJTqSCN7peCKiwEUizQj
 Ye+1MuWHZ2F2kwU95Zzr7Ez095a+RwcwSR3rICZ1TO4kIb5Uh7QyCnN8C1gs3zyNE66WkScv99x
 J+0FGvdPQ0t33uXd5j7Jn90oMbckZ7J2UOCkGxnhgv+VB9JAyuJA+le9NeNSG29xaWB4jSFkXJD
 VpHGNoMxRDGzy3TE70HCHs0t4+XiLGas17j6AZLidQzV3otOSnouiM=
X-Google-Smtp-Source: AGHT+IHPk7JmT5auxhhzn03QgrNjLTFQypkS8lvTCYIHdQJ1O+aOf9t6wOK7P8wzc8cb/idWWjLMSg==
X-Received: by 2002:a05:6a00:35ce:b0:725:eb85:f7ef with SMTP id
 d2e1a72fcca58-72abddcaf2fmr61238854b3a.14.1735770208882; 
 Wed, 01 Jan 2025 14:23:28 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:23:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 65/67] scripts: Update qemu script to support specifying a UPL
Date: Thu,  2 Jan 2025 11:09:51 +1300
Message-ID: <20250101221003.1944600-66-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Add a -u option to specify a UPL to load. This is made available in a
separate virtio device. Allow this to work even if the -B flag is
provided, to allow iterating on the payload, without changing U-Boot

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 scripts/build-qemu.sh | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
index 10ea99982d2..b92623c9bc5 100755
--- a/scripts/build-qemu.sh
+++ b/scripts/build-qemu.sh
@@ -30,6 +30,7 @@ usage() {
 	echo "   -R <os>   - Select OS release (e.g. 24.04)"
 	echo "   -s        - Use serial only (no display)"
 	echo "   -S <seq>  - Select SCT sequence-file"
+	echo "   -u <file> - Run Universal Payload (UPL) file"
 	echo "   -w        - Use word version (32-bit)" ) >&2
 	exit 1
 }
@@ -69,11 +70,14 @@ serial=
 # Use kvm
 kvm=
 
+# Use UPL
+upl=
+
 # Set ubdir to the build directory where you build U-Boot out-of-tree
 # We avoid in-tree build because it gets confusing trying different builds
 ubdir=${ubdir-/tmp/b}
 
-while getopts "a:Beko:rR:sS:w" opt; do
+while getopts "a:Beko:rR:sS:u:w" opt; do
 	case "${opt}" in
 	a)
 		arch=$OPTARG
@@ -113,6 +117,9 @@ while getopts "a:Beko:rR:sS:w" opt; do
 	S)
 		seq=$OPTARG
 		;;
+	u)
+		upl=$OPTARG
+		;;
 	w)
 		bitness=32
 		;;
@@ -140,11 +147,24 @@ update_sct_seq() {
 	sudo losetup -d ${LOOP}
 }
 
+# Add a Universal Payload into the image
+add_upl() {
+	if [[ -z "${upl}" ]]; then
+		return
+	fi
+	qemu-img create upl.img 8M
+	mkfs.fat upl.img
+	mcopy -vs -i upl.img "${upl}" ::/upl.fit
+}
+
 # Run QEMU with U-Boot
 run_qemu() {
 	if [[ -n "${os_image}" ]]; then
 		extra+=" -drive if=virtio,file=${os_image},format=raw,id=hd0"
 	fi
+	if [[ -n "${upl}" ]]; then
+		extra+=" -drive if=virtio,file=upl.img,format=raw,id=hd0"
+	fi
 	if [[ -n "${serial}" ]]; then
 		extra+=" -display none -serial mon:stdio"
 	else
@@ -204,8 +224,9 @@ DIR=${ubdir}/${BOARD}
 
 if [[ -n "${build}" ]]; then
 	build_u_boot
-	update_sct_seq
 fi
+update_sct_seq
+add_upl
 
 if [[ -n "${run}" ]]; then
 	run_qemu
-- 
2.43.0

