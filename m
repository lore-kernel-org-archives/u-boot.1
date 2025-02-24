Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBA7C021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA7080F91;
	Tue, 25 Feb 2025 00:07:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O2B2x/Tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3C880FC8; Tue, 25 Feb 2025 00:07:05 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17F5D80F67
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d284b9734fso44169775ab.2
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740438421; x=1741043221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=O2B2x/Tv50MncTWFcA7LWGIQdFVwfYo3yN59R2jOl7melC/SaHQhziALC8wEleDcZM
 Keu0nU1FQnibYCTesf4DYZr1Ua18i3qRo1jiXlVFzzASX6W11OoUoUufKNEyCkl/QR7t
 rLlBbpdhvfaA/PKucXzxrBNRoM8dQVK3abVmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740438421; x=1741043221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=o8ZlK7LMK5tMLhHGfbOItVQqwP3CZjLU29KFdhVJkEHeqKbs6zUzK6lKJekKtqvYCL
 0iC4ivrOKTUYMsgn2TQtR99gmV/rvL/AGCjTAjWXuLcMO/I7IaNcmPRxgW+K/oh+VToP
 khuxIKYRGG4SHcIA98mcNyC3feQa+0j5lCDGLpBLor2v1ACtUS92PKKWa3GquKZNDMPn
 CAlyrxwQ+62xlLiMjaKwlA/GB9rry+gBuBhsU+r9EtLIkXPH7ObP+KSSrBeEYEBHjAu2
 7Wlkeylwf4KIA8JdekW//Dd1MvSgvnrFp3K0rt/Xb4NadroA1VgTdghxUUBaut3PChK7
 7AJQ==
X-Gm-Message-State: AOJu0Ywzl3toI/PjXURJAA2ZVAvQBU8bKCL3nc1beLMsmoBBY3iQY6a/
 NJhBB9f4KxhktuK0iKLXqntYNfnjFC+vNJD7GaDUFtufS4BGtTTu9Q6/o8YuA+vW2Ydq0OVtomk
 =
X-Gm-Gg: ASbGncugyp/kmHh9u+JaImStaGdrXR5BaTpngV55eeiWdzw2q3tuEYVWCBY8ij+LRMI
 whrq0IJKq1REkqBHo86RSkS/lGkf89k6AgrL5XdR4OrY8m16PjyO4d/gg7lKy0itFMx5FpLd1ek
 NkYACpptdK1TFEvi4MotiDI+FEJGOiNkwsT+mzX+nqfm1+9ejVaaxrghN4JV/17cu4wVd5rITyg
 438ip5IA68UlUWC6rF/O8+xrpjAPqajvNKVep9M58vk6nt2Ul7ksfq6MIKTq3wRDiBnCv6yO5dt
 lWGZRoh9mEKQeK//1cKhXOIbQP2cwzlN2dXoxb2vPUbsJSvUWtl8h3rPsu+ooAk=
X-Google-Smtp-Source: AGHT+IFSb+pEHS3x7L/kHUkbhEPATcpEm/zxcvv7hUlNWHfESUt4vsg1VOOpXmfvLtMXm5ytGWqRzw==
X-Received: by 2002:a05:6e02:23c1:b0:3cf:fb97:c313 with SMTP id
 e9e14a558f8ab-3d2caf01835mr179643675ab.18.1740438420777; 
 Mon, 24 Feb 2025 15:07:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f04752e026sm113941173.107.2025.02.24.15.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:07:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 03/44] x86: qemu: Enable dhrystone
Date: Mon, 24 Feb 2025 16:05:52 -0700
Message-ID: <20250224230640.2665206-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224230640.2665206-1-sjg@chromium.org>
References: <20250224230640.2665206-1-sjg@chromium.org>
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

Provide the 'dhry' command, which helps to check that kvm is being used
properly with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/qemu-x86_64_defconfig | 1 +
 configs/qemu-x86_defconfig    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qemu-x86_64_defconfig b/configs/qemu-x86_64_defconfig
index ff2a192ee7d..84b7dc8e99f 100644
--- a/configs/qemu-x86_64_defconfig
+++ b/configs/qemu-x86_64_defconfig
@@ -89,4 +89,5 @@ CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_SPL_VIDEO=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
diff --git a/configs/qemu-x86_defconfig b/configs/qemu-x86_defconfig
index ee5b150e062..d52afa42955 100644
--- a/configs/qemu-x86_defconfig
+++ b/configs/qemu-x86_defconfig
@@ -66,4 +66,5 @@ CONFIG_VIDEO_BOCHS=y
 # CONFIG_VIDEO_VESA is not set
 CONFIG_CONSOLE_SCROLL_LINES=5
 CONFIG_GENERATE_ACPI_TABLE=y
+CONFIG_CMD_DHRYSTONE=y
 # CONFIG_GZIP is not set
-- 
2.43.0

