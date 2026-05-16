Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE7DCD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D60E84690;
	Sat, 16 May 2026 09:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="fctAlqfL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9873F8468B; Sat, 16 May 2026 09:40:53 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C448407D
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-367c26471f5so309667a91.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917250; x=1779522050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2mcQbEokf3f1JmuRE8BVjx7qhxlE+KPA9G+TcfG4z2M=;
 b=fctAlqfLvoe/IYpK/oS1/MiIqPUqaWdU2qHekURgMYXZSNe7IxONZFmo2b5V4FzMOA
 H3s/681JKtxcViMNraE5GOSxxCaEYQRHZW1W+SLkyjW+dEf8FzC98s5CnRrtoi179SUy
 AMQZ59vPjPAWUqfjnKhkt5BRMnY4FqUeMjp6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917250; x=1779522050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2mcQbEokf3f1JmuRE8BVjx7qhxlE+KPA9G+TcfG4z2M=;
 b=qaeOkP+Nz3MfrNA2BTJcGqTo0yd4hzuTgiBqaNUcIKBBcqLmAxD7SW4BlTs7SgwxPq
 3MJ4EIy9nhVraSR5DQ5p/vKGwOFIR4+slBXZ6Zc0aF9kml0hSk3UvvINsNH+o0FeN07t
 7OXil3EUg5EBhQ1+Nj8yqkz/MjHUEpQu/FLO9Bf4Wp1qmrlE0VzfkaSS9BiJ8xHRsq5E
 KrLqylAPMvmw8Nou7sHYhe2QDqcqyzzqWnL8Fn2JcseHA0x753vKjDcyDyYPY2o0zXHg
 NJPXfaiAHDNrHXRCwVgpO+NgJVVh03Gu6kZAUrj/i8fd/0so0cjWZHoZaGGcqRMYYKO8
 BYOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rlXmQPvsLzeNXROACJVFIbq9Gc1XjXCAMx7foHa97EUXyZCKfFf9xochle7Fh0ScaQHmeQJA=@lists.denx.de
X-Gm-Message-State: AOJu0YzGcE6S//ajtlanoXwFQhK8F2DtHolXvDGwkeew1tdRvm4mAlqa
 PcW2JFYhOvRoZtyOjCXiPvEu1obZ9rOyCHshc05j8TTxwJ/xssYUcurWA6iBreNnupo=
X-Gm-Gg: Acq92OHG3cpKKYB+Zf99WGMfh86fvwLyVeGWAoMDtvMzdbTG3jYCTzit0WgAdz5BjlT
 BR+Esx2M/tb++kYAwb7qOcBK2cE9BZ2b7F5OukeY2ElvPG1NQnLM/BK16uFEQV/nAElacEAeplN
 6itTFBGXKlqb/5zyhU4pOfCoqYvGBRt4bN7bpSoiy92Dk2NkeIlpgqJULOj4zf16XxKgZPdVBGd
 sopI9yL8f1ZtC3C+oND50Ct06pkvFhBd5AkFRA8PBwBIKKOtCrpFMXrVhd/OfJv3RtZ9oe4HKCd
 GrmN01xDqahXQMAmWgpIBqtOlNdvpSlmet5Jk72yKAdCEqz9GM/8Ohs+1EQ6lV2LicwbiCAc5ha
 7HEe2nmAVBVoyVxY2qMv+y32AUjk128LZH6StUbyAEwIyu87j1cNaUv6ORGnDchhQhBu0TS6rtS
 pmoPk/vnzD7y65HOluD64qKscAC5182vpg2US1FtSfyDHDa5wxfN+Be/lmUEKhoooNoy/sVhz2V
 pAUzOL15t6lMw==
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id
 98e67ed59e1d1-36951895b57mr6456500a91.3.1778917249885; 
 Sat, 16 May 2026 00:40:49 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:49 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 7/9] virtio: cmd: Depend on VIRTIO_BLK
Date: Sat, 16 May 2026 16:39:59 +0900
Message-ID: <20260516074016.885146-8-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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

The virtio command is calling virtio blk functions but currently
depends on CONFIG_VIRTIO only. This means disabling CONFIG_VIRTIO_BLK
causes the final link to fail.

Since CONFIG_VIRTIO_BLK depends on CONFIG_VIRTIO switch to depending
on just CONFIG_VIRTIO_BLK

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Daniel Palmer <daniel@thingy.jp>
---
 cmd/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a196..032e55e81276 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1871,8 +1871,8 @@ config CMD_PVBLOCK
 
 config CMD_VIRTIO
 	bool "virtio"
-	depends on VIRTIO
-	default y if VIRTIO
+	depends on VIRTIO_BLK
+	default y if VIRTIO_BLK
 	help
 	  VirtIO block device support
 
-- 
2.53.0

