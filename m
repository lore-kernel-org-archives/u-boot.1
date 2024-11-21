Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45665D78764
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CC289765;
	Thu, 21 Nov 2024 15:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SLTzjG6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 324F3896BB; Thu, 21 Nov 2024 15:25:41 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D3998975F
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E05EF40D9D
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1732199138;
 bh=IVgvtwW5SD+cBDI+qf4hAvCf1flI5j792EOhOUqfDVc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=SLTzjG6KuI9/mBY5LYLeR1TvsTDGkp8gNRaMnRzjkZedr81puCPHHEmK2tqr0LZ2+
 ywH4SdSxfZ0VQ7Z0J/Tc7DTPR7Vuu7LD2FyYz68ghqndBg+sU2GnJES8TsCEyDTYrw
 J2azx4TR3ZgRlH4ufHbJaxgBy2Pvhmz9c0Vp6duNm7bOMzngSdZ+aPjwAA4KHGSA+w
 9jIiHpbKOY/QM9bsMTwMLpUrZYHCmIpr9zlmhiqFbnliW0YavGHI/YR751XbNyn1lF
 5hpYlp/Gva2lXxMsfHmb7pupPfSpjDiG5Ka1GXSxYafOtwDxNcBSRSwy5ngXk6XwOX
 jbh2lXZUwWvoQ==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38235e99a53so563130f8f.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 06:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732199138; x=1732803938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IVgvtwW5SD+cBDI+qf4hAvCf1flI5j792EOhOUqfDVc=;
 b=MGSL7GTtH5uoSHBBonAy9szgBkvacE5ONChyxwo0TqW65F5ipKOh/ZQn4owkQtHZwA
 ecOgA7gpwUig0wu0lFGgTGZy8VUodBt0yw7v2DDIZuqY0A7Zv0s9lxTlyDB8j9L04Yms
 dT5342BN3mg5lHOYjQ8UOTBLFjZKK/sNNwJulPxh3oHs6s/6d4UakQFndfQgDNZiFE/r
 Xvkedx/WPm/KSZ8rUo7VPGWyWwBmPx3mchKfJzYdYkpDc0jlurrw8Vn7KvO5Z1oa1yZq
 RM+g9chNSNgu7u6ZlaFaesY6vLHwJ+4HAwF3idOf+qnAeWFMxhBSXfHXE7vN8x/zdZlw
 9TcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPfbGXmwVOxMycG7bIioJMEIuRxZWeD4D2NBdbzPNF/DE1B6uobfZtVn63hjnzAu5z0Oo20QM=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2+v8W9eScYJMu9rKIUkMLcPNezn5W87dLWbWagP41nEYOyulZ
 avGVmJESeXD9ZA3WGVY8lJZj/DzcZxtC+n8adP40/wrCQEZcWQ/AKW82GAOTgnUWwJxx4d9l9UZ
 M1DL28whW1Qus74H6AB8i2eL7qthOQsaqZ4LXGZMk4YIsynG2Al9XnDHlFNHOiJfgi0Vv9p9k3x
 g=
X-Gm-Gg: ASbGncsdVm0p9TaGDZESmYniUN9rU3Ku3MCzoUn1GwqifbqKQBsxlTs6qmOwnYJkrE9
 AVKyYQMDD+ZENjqGkZhdHBIbK6oNnTm44guZl3wtsKi/kaEbrhrwXPXLw0rHh/rQnFgoTx+n/fh
 DAWVfzFKXPkiVJBj5CvODiD0uRZUS95M3+U33q2eaGJrcAhjonnRrpoXFxFaTXsgRMgLY/oIQ+Q
 krRWwt1rgq5QPJGH4glNzzAqgmwuucWc5wVjO+6PatzG3hgCLvYwEW9Ou+mKYQq1wC3LD+p/HUm
 ul8I6jF6F7S0SUR1j/W+nPiuMAelIG6kf+Wx6xU4OsERl2sW1Khj
X-Received: by 2002:a5d:64ce:0:b0:37d:34e7:6d24 with SMTP id
 ffacd0b85a97d-38259d2b848mr2804735f8f.18.1732199138201; 
 Thu, 21 Nov 2024 06:25:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8xWRqacpYO3AF6e/V3H/4SF19r9xENsy0kkO3cn2+QKzSvWWx80grXHLlJfFbCxU8488G0g==
X-Received: by 2002:a5d:64ce:0:b0:37d:34e7:6d24 with SMTP id
 ffacd0b85a97d-38259d2b848mr2804712f8f.18.1732199137913; 
 Thu, 21 Nov 2024 06:25:37 -0800 (PST)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b4616843sm57238085e9.20.2024.11.21.06.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 06:25:37 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>,
 Andreas Schwab <schwab@suse.de>, Jaehoon Chung <jh80.chung@samsung.com>,
 E Shattow <lucent@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
Date: Thu, 21 Nov 2024 15:25:22 +0100
Message-ID: <20241121142522.59059-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
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

Our MMC driver for JH7110 boards only supports reading to the low 4 GiB of
memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_BUFFER.

Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 configs/starfive_visionfive2_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 1c70d1d4b70..20f89ae6796 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMODEL_MEDANY=y
 CONFIG_RISCV_SMODE=y
 # CONFIG_OF_BOARD_FIXUP is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_EFI_LOADER_BOUNCE_BUFFER=y
 CONFIG_FIT=y
 CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
-- 
2.45.2

