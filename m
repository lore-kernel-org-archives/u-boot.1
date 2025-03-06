Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D325BC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507E5817C4;
	Thu,  6 Mar 2025 17:05:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mr2RqzJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F76805D7; Thu,  6 Mar 2025 17:05:00 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 245FA81703
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-851c4ee2a37so54180739f.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277095; x=1741881895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=mr2RqzJkdJaPaXPW2HS30ThwBCVU+RWhQiIT8FO28E+jdhhcwY/g9lSFkjcoZUzwIQ
 +0xsx+0ZroCqHxhgQVk4/aU5nikbnyW3h+26GrHYLgPmKR3cqpHogR3TzFfqkYAgAsF7
 7hEMwQgEosb2K7LgXCYGoeS3aD9ozQagQcbAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277095; x=1741881895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBXnQzSJkDrutDwfAQ4rGuJkH23aeovCFlYOdDvXid8=;
 b=MirR8cvN9NuX/6OCj/+libzbbAlX9Te1kkxEAC74PWxnvleU+k46fyShzoLiv9L7jn
 mibVQ/zlHpC7E14zncwoWq98okLL2kKJ2xXQouHy+x+wWwvilvWIYeTWIfuSAtr9r0R0
 QDekzyH71+ZuAv13SqfzaJDVd4h1Nu257KR2LJwsHZHqpIv7EVH/ZzKKqXTM+qIO6ri4
 bIOaZft/bTh4pmaSIeBADTsPFfYpefxYr51huhfCUmceS++wWuPnONJfg4yiRL1FQgyI
 yKZmNdjl2Z8I/ZAXOoudy2/88mZ3I4TIxp57U4e4ojOyOL3bbJvk3cy3/YovYrf/sL04
 Edtg==
X-Gm-Message-State: AOJu0YwG4bdRsVIXdQdZ1JuXIUQvsUKV2Kbhvml2dVW1quuWoZw+TLGM
 twnU7W29pc9mndyvDZObij5I2tK0LbdyhQbEXvdbcUCvcDnmkd6Jmd2dRR2UDVTskxDAh00wCgI
 =
X-Gm-Gg: ASbGnct4A35LcNthTPnUkQz/d9Wiu7Hd+SbfST9EsWTcqOYDqTp3kO18hH3HddQpbBx
 bDPR7zedOZJNmckOXxkQvOAibLRk4kolNX8Dzq5QrgnVhmVc5i9iLcCwnYf6RZk5xh9IXo/yupF
 eBov/rfzS7zt1jR0W5/iyeu8Y1OwVwGxdnSLz9Um9jUJ0wZ9F19sJolSBrcwNRi+1ZeoiF7ldFr
 ydAxxRtkoBn6nd6Wmx00Acd1NRtFNZeKljIcOvioUcwCWqJBthIZjo8HEo+o2RoP688mTEbie8a
 jLARgPzei2zXg0toSV5c/AC1XNubIqpuC5OsDye2ir6fkYPZjvtdMGBymKG5mbf3SzAJvSaIvfG
 /YvshvQ==
X-Google-Smtp-Source: AGHT+IFptUsVDgwryU3pACMw9DrREQ9iwYAZSwjMMULniLe8f5QvU7XKJlpZw5jtr9diDtsIm1c6bg==
X-Received: by 2002:a92:cdaf:0:b0:3d4:38a4:388e with SMTP id
 e9e14a558f8ab-3d44187c0f4mr897545ab.1.1741277095097; 
 Thu, 06 Mar 2025 08:04:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:04:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, qemu-devel@nongnu.org
Subject: [PATCH v4 05/47] x86: qemu: Enable dhrystone
Date: Thu,  6 Mar 2025 09:03:32 -0700
Message-ID: <20250306160428.3041057-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

