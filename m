Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE51EEAA58
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93215870B2;
	Thu, 14 Sep 2023 18:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TW3ynXrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6630870B6; Thu, 14 Sep 2023 18:56:43 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C583486E5D
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:56:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so32521439f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694710600; x=1695315400; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ebazkRxqMOUWCK3TN66XeyuP4NKa7Qc2ER2V0eZb1Y=;
 b=TW3ynXrFYqSd7MJc/kB0F9fhsEo064TZM4urrxxcYCBcDCmzB1cgRWFOmfDZgxm97P
 GHxVSMXntQ8xh97CasQ/+71NIkjPSbbpx1r+W69xDKPTfHCuAXJGPRVhnSZecD8riklI
 WSLSm/PYFNdKCKzh7/vij9TjnRd8zqSejlBeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694710600; x=1695315400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ebazkRxqMOUWCK3TN66XeyuP4NKa7Qc2ER2V0eZb1Y=;
 b=LnUOQZ0ljBvJSL9kJ4ufMaudfH/NkJHmz2C3ZCyxNL8VFYuZvX0oeYDXik0n2Ayo4T
 sqMyNvuFmcFt+/xAC8XHJ6Pty/qOFXiVlkq32q4NAyCkNEDyap18z2RQ3QmKgV5ckRfD
 Xemt3hsUgYShe/BK8O+FCSXP6baxpZwaJP0VIvJUmvnWG6dHeRHPJFjkJYoCQE5+BF3a
 XXrONRiq4bWHk48pz16Bqdn5QrTbWRhZDQFVjYTUHENgqXKsTgHDYmkiNQVTuhPJRwL5
 +Qy6rbvfXwYiNIaUrlNXugxwgiC7NPn6HHCvHCv2YCe56p0wgp8er/atcddox3AbWbT4
 kD6g==
X-Gm-Message-State: AOJu0YwH4N/0r6YAbBWCNHEKxznbQlRsyNC6LduGOMQCeQekL8+WMMdC
 2wB9Xn5XynAd9bUZTv6vGS5tSfKrgcSsXk2sq7Y=
X-Google-Smtp-Source: AGHT+IFFnDhK5VRSVvclXSUxwEAdd/lbQlwTUAUPVvF8oaLGhIDdTGhSsj1E5tqbE5sK3dGtIgnimw==
X-Received: by 2002:a05:6602:3892:b0:792:96c0:f4ad with SMTP id
 br18-20020a056602389200b0079296c0f4admr2133897iob.3.1694710600400; 
 Thu, 14 Sep 2023 09:56:40 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:a8b6:76a8:ff58:a8be])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a02c514000000b00430979b6aa5sm535339jam.0.2023.09.14.09.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:56:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 10/21] boot: Rename Android-boot text
Date: Thu, 14 Sep 2023 10:55:48 -0600
Message-ID: <20230914165615.1058529-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230914165615.1058529-1-sjg@chromium.org>
References: <20230914165615.1058529-1-sjg@chromium.org>
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

Phrases like 'Enable support for' are pointless since this is an option
which enables things. Drop that part so it is easier to follow.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f8b8d608951..017f7117d57 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -3,7 +3,7 @@ menu "Boot options"
 menu "Boot images"
 
 config ANDROID_BOOT_IMAGE
-	bool "Enable support for Android Boot Images"
+	bool "Android Boot Images"
 	default y if FASTBOOT
 	help
 	  This enables support for booting images which use the Android
-- 
2.42.0.459.ge4e396fd5e-goog

