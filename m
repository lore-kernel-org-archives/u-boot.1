Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A17C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 360E18850A;
	Sun, 23 Jun 2024 19:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K9kPhlU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C618854A; Sun, 23 Jun 2024 19:55:28 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3D3885B0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7f38da3800aso120621539f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165324; x=1719770124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=55AI1Zdq2PtMQvY/0hkcvJqBd9KlBMTMR5uFE0YcI/k=;
 b=K9kPhlU/arX7vBws8f1lS4X1yQEN/oY8SMRYsqRkbyTxmOSQV6EhRXDawR1QQ7E6bo
 H3iLtfcApPuIBkZBPWFlB1Qs0v4AhL8sly0tUPjmP3TRjU7iCBOrCLRzYDyD+qOXDvY2
 HiOpDCBGbto10uUoT+fKrWt9ODuxjOTPRCsX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165324; x=1719770124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=55AI1Zdq2PtMQvY/0hkcvJqBd9KlBMTMR5uFE0YcI/k=;
 b=m6ZTExBQkLLtqhuFMy8tf4l/kr/lRoSnxBp0OXeGShlfLMvuDMTOvMt+mgxW3HmtZh
 iUw801L+INuGJI2H9DL2i5ZqiKb+qFvKqS9yXoRy438LWfC0Mss9A2hoGIfss+EK2+M6
 Y0Bt4eTP+BK9y4mECJej++SiWUzlAkDVyFUwsKLS3/ZZMCRCCq+XGvgh/D3jlIVXEg3w
 qhE7eKwgRlpdwVZ48zt2KDf7cAjObNEUEF2LnEgWxMS2QlbdUw4TpA7pbxAX+onEvzqz
 oqAH07Y0ue58MJe6CwpBHttIycUGYdQxN4/ioz2HPCUA6zS7Dbc6ySq2lo9DeBQxrGz0
 TA6w==
X-Gm-Message-State: AOJu0YzuEMEV1KrGyeFSqy29J7BjRYk436m438Jlfz47+Uvq18fkbjhh
 3eKk0iuMmlvnNe1x4d/nmfjd6nGypA/L17U+faSluHIAf3sKMvDoZxngXsyyKiFJ4iIIWHoYGXj
 kcg==
X-Google-Smtp-Source: AGHT+IFiPmtB504qAUNz4GhI1VojYHaBLyVfprpWc0kKnCqCioDLCKUjsMmjna/C34zAFXVkkM3nog==
X-Received: by 2002:a05:6602:150d:b0:7f1:3e1a:db4c with SMTP id
 ca18e2360f4ac-7f3a78044e1mr406448939f.16.1719165324663; 
 Sun, 23 Jun 2024 10:55:24 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 07/14] x86: Set up some assumed sizes for binary blobs
Date: Sun, 23 Jun 2024 11:55:08 -0600
Message-Id: <20240623175515.1466908-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

Add assumed sizes so that Binman can check that the U-Boot binaries do
not grow too large.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/dts/u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/dts/u-boot.dtsi b/arch/x86/dts/u-boot.dtsi
index e0de3318091..fdd28979e0b 100644
--- a/arch/x86/dts/u-boot.dtsi
+++ b/arch/x86/dts/u-boot.dtsi
@@ -24,9 +24,11 @@
 #ifdef CONFIG_HAVE_INTEL_ME
 	intel-descriptor {
 		filename = CONFIG_FLASH_DESCRIPTOR_FILE;
+		assume-size = <0x1000>;
 	};
 	intel-me {
 		filename = CONFIG_INTEL_ME_FILE;
+		assume-size = <0x1ff000>;
 	};
 #endif
 #ifdef CONFIG_TPL
@@ -87,6 +89,7 @@
 #ifdef CONFIG_HAVE_MRC
 	intel-mrc {
 		offset = <CFG_X86_MRC_ADDR>;
+		assume-size = <0x2fc94>;
 	};
 #endif
 #ifdef CONFIG_FSP_VERSION1
@@ -98,6 +101,7 @@
 #ifdef CONFIG_FSP_VERSION2
 	intel-descriptor {
 		filename = CONFIG_FLASH_DESCRIPTOR_FILE;
+		assume-size = <4096>;
 	};
 	intel-ifwi {
 		filename = CONFIG_IFWI_INPUT_FILE;
@@ -139,6 +143,7 @@
 	intel-vga {
 		filename = CONFIG_VGA_BIOS_FILE;
 		offset = <CONFIG_VGA_BIOS_ADDR>;
+		assume-size = <0x10000>;
 	};
 #endif
 #ifdef CONFIG_HAVE_VBT
-- 
2.34.1

