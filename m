Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A66C83038
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E762582F35;
	Wed,  2 Jul 2025 03:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FfME6G95";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEAE82F2B; Wed,  2 Jul 2025 03:04:10 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D4181E13
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73ac5680bb0so1679157a34.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418247; x=1752023047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P1Y6nFjRjiBYKQneCLWRa41OaeGerR8ZgpGf4bxzHO4=;
 b=FfME6G959hoWqMpaJ7ItHP0pNBhUF9LbMre0z+62PMO6cRBBgxHNJDziRaF6U1MYMR
 8mavHNf+lOtBDisiSVoPI/HxV2gGjXfrxnqIjTO7WehQ73tji5xUx7LE7B6juzrgqERR
 1CWx17do/7WQmFIIxGL60eJwu/QVAvl4UFduM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418247; x=1752023047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P1Y6nFjRjiBYKQneCLWRa41OaeGerR8ZgpGf4bxzHO4=;
 b=KoYmt8hIIAaplXBJr3OBKIogtdKwWNSWbiRD/NLO1qD3HP95D8WgEf9vuIsZAftAQJ
 PaVQAwfmcvSClgDsZtQW4dj3wOUN/ErPJYm6fERwsj3ymF758VKOkYbWTK5Wt/hqgiOH
 0fF/EEMdQv6dKOwmmafEwLReDOn6479S2F3omgjsECI81KZUKPXr0wMiT4bnp1RmZ1qh
 rTwhYxRCI/+QjQKfkXy2xs15GvykwkOvJuqeF5V0WUgJjAb5nPcW+1rewByW0YsppJtZ
 ILj8oZeYZZEZrQCRRU9IJDUVvTK9EJK5CsMBk6O+nhndL1UcG2PnokarTvV+kObM5I7e
 iLhQ==
X-Gm-Message-State: AOJu0YyUPXv3sI1+q9ECSAGgB0hXOTMoe76A6mytFkemGljrWgc40k12
 P4WGM1do4IpKJPpO9VKdh0uRDSVtFOAIAyC5k7K3JinWyYJG0ZJliAaMhPi5QL+aWcyEaK41mFw
 sXCQpk9Q=
X-Gm-Gg: ASbGncvRjSTgmoaw487PEFeZnk2UTCj/Cu08n/y7ePX4McgVNEA55hjEOVy6/DQhkkf
 LsNKQGrGk2BwHTcnef7GArWY0/uQhVqTnlX2XMW1o7u+t8IWwAq7wLidig+/ncwSn6OxrgBc3dG
 /vu5DNCLsppLc23ZK7yYaUOuLzg1bS9oclqqhef6MiwuTybz3hK0vZwLjD027T+YfyCmumq/Lpw
 l8/TzOo6fDV5p+IPXHZNMEh+x9WiOlbcKpkJLJz0tlxoJAwu3/VcTId4/ilWlpTDo1WQsv4Ltbq
 hDoZwEnf8M1Pe8Y2jbNupmgpF0s2uCX5IZosBqc0fVgQChGLlpzbKKZCvjoI0cFw7XhtVINe4Wb
 AH3Nv0d3EjyDw/NEX/RWSLDtAWtd1Pcu+Kg==
X-Google-Smtp-Source: AGHT+IHsJ3tybq6tQcPobUZiO4TBNLQArF+9ChjODHhH4pgCV4ACLNjvPTrn09Lv3EXK56B8843yYQ==
X-Received: by 2002:a05:6820:8c5:b0:611:e30a:f9c7 with SMTP id
 006d021491bc7-612010ace40mr768556eaf.7.1751418246852; 
 Tue, 01 Jul 2025 18:04:06 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-611b85c79e6sm1645638eaf.38.2025.07.01.18.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>
Subject: [PATCH] spi: mvebu: Correct dependencies on MVEBU_A3700_SPI
Date: Tue,  1 Jul 2025 19:04:05 -0600
Message-ID: <20250702010405.18791-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A dependency exposed by "make allyesconfig" is that the logic around
this symbol was not quite correct. It needs to depend on ARCH_MVEBU and
ARM64 and then select CLK_MVEBU.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stefan Roese <sr@denx.de>
---
 drivers/spi/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a3513f0a3ef8..1ae36b5a348b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -351,6 +351,8 @@ config MTK_SPIM
 
 config MVEBU_A3700_SPI
 	bool "Marvell Armada 3700 SPI driver"
+	depends on ARCH_MVEBU && ARM64
+	select CLK_MVEBU
 	select CLK_ARMADA_3720
 	help
 	  Enable the Marvell Armada 3700 SPI driver. This driver can be
-- 
2.43.0

