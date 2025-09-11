Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C0DCAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 09:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C73A832FE;
	Thu, 11 Sep 2025 11:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JqxotbtC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B41FF83303; Thu, 11 Sep 2025 11:32:51 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B82B3832F9
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3e4b5aee522so344897f8f.1
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 02:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757583169; x=1758187969; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nrN2m7vlV5zRoXNSf40BgYKg9s25hsLy13hlxZyjbD8=;
 b=JqxotbtCOBHaG4s1a1y/o42qA09BG7HHiKsb6YPiyx03pIqbCXXlpdQ/VhWNS4EIkv
 2nSRf/PvjsybNI0hfgsMVuNuJmlDWtM1b5NYH2HT9/lBejwXqNV788QZnQ1WYU/HS3So
 laVM/PDUsevNxuRJpb+q+YPtfwc1Pa+mfeYD9cLRfbmJXqFXNfDbrYTkJPd5StebBxnB
 Nd2PLeieR6EbIcOubmo2mfVX/CW9C40yO8if6P/jRjEyWjWMuKHsOofO3BYW0mgMb9jv
 tfg5BrA1mqv/d1FuDEU1I7Nt1YQ6yrWmYK2vkISzmVB6ccJNuy+ywbbvVD2JzGsxH8gB
 c/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757583169; x=1758187969;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrN2m7vlV5zRoXNSf40BgYKg9s25hsLy13hlxZyjbD8=;
 b=A3zh6ktF8NfPRR5Kjj3pe/8eHa+Z58KiyFyq/Ofy1JKUy2xrT8a7pWyJaDzOvzVWPr
 0gXJ5dhr3b24KfU5idEY31vlQSp4QPrmZ61WmtcNKvjMxFo4rWzNhzqmCn7tCG1gdy39
 +eamYuGAbIBZFDNtH+9MYOW4MmkgME5GsLc9eLo584De1rYBMnDHYKSw/erbymqEZUZh
 k3xvToeDu7hamTr2Qc/O/BmIz/h8C3mHgukRHA+aAdlOJDpvid1LJZvhzJw97Qwa7InL
 KuTnBsNfP4kBghnhoVKhnHzGrSgbIsE769S29FDlR2elUCeft+4biJSstJo5zcOhrcV8
 oM5A==
X-Gm-Message-State: AOJu0YxeH8DU7X6u2kzZ2h9YRTasSBoPa76NExEfwE/2rOtrby0ppB1T
 SbsUI0WyBV2NOZQmdf0K88WTIYUCm3DK8zFe6FzyFVRYZBF9RY5h5u9wSsMdTqa0
X-Gm-Gg: ASbGnctogMPmIjbvYsxTka3KYUhF75s7FUoI+d4SgjO8djMWw08cZXdvgxDKZh5C1nZ
 i+s894D9ZWmXJhcDEAishZf9GVPXPZ9tzi9Q33L+c0LZtv2wsIBfyA9yOgdlNi0yt129yUIKzEE
 HmoLhaznKBG8MOMZcF/ceB6e/FLr/HR7g97FlDvu3h5fiCSyLPawdnQdyONXQp1y8KnGgPmLEqK
 XM9c+MI/Lhd2sStYX/wnqaE1gsUijSY0qfAWX5NX0ik+r/CHhQ0kB5TkKdn3IuaspXKvy8FmKfw
 PLemWip3JEhIOtYAcavSpgbkwA+TCAUwLyQIdGy+WlnbvrCwKyQhuiqy3GcqAO364sMA/ViZkcH
 tvqVRX8/PeSd4knDlflVmBRLFAPP8Zh+Xtq8Uw8yeHrbUhJsZAQ==
X-Google-Smtp-Source: AGHT+IFvhwY6HxnQ/Hg6eY645C5ycc49A5Va+U1T8GnsO21oD95Ny5b+PY4n/xY+oh0KSGiw0pCQ4w==
X-Received: by 2002:a05:6000:40dc:b0:3e4:471e:3ca6 with SMTP id
 ffacd0b85a97d-3e64230a46dmr15282671f8f.23.1757583168509; 
 Thu, 11 Sep 2025 02:32:48 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607d77b2sm1783070f8f.45.2025.09.11.02.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 02:32:47 -0700 (PDT)
From: Heiko Thiery <heiko.thiery@gmail.com>
To: u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Michael Walle <mwalle@kernel.org>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Heiko Thiery <heiko.thiery@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>
Subject: [PATCH] env: fix config dependency for ENV_OFFSET_REDUND_RELATIVE_END
Date: Thu, 11 Sep 2025 11:32:24 +0200
Message-Id: <20250911093223.65323-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.39.5
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

Since commit 5fb88fa725 "env: Rename SYS_REDUNDAND_ENVIRONMENT to ENV_REDUNDANT"
the option SYS_REDUNDAND_ENVIRONMENT is no longer available and should be
renamed to ENV_REDUNDANT.

Cc: Marek Vasut <marek.vasut@mailbox.org>
Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 env/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/env/Kconfig b/env/Kconfig
index 03c189b7266..adea277470f 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -635,7 +635,7 @@ config ENV_OFFSET_REDUND
 
 config ENV_OFFSET_REDUND_RELATIVE_END
 	bool "Offset is relative to the end of the partition"
-	depends on SYS_REDUNDAND_ENVIRONMENT
+	depends on ENV_REDUNDANT
 	depends on ENV_IS_IN_MMC
 	help
 	  Treat the redundant environment offset as relative to the end of the
-- 
2.39.5

