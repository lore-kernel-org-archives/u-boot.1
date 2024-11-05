Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18CAD1269F
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 12:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13EF688FCC;
	Tue,  5 Nov 2024 13:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wy0XerWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AE088C44; Tue,  5 Nov 2024 08:49:25 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2D0C88E63
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 08:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a7aa086b077so649711666b.0
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 23:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730792962; x=1731397762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YN0MxxoM2Amr+zycNp4vfsxGxdARFh/GtiSShK4gveM=;
 b=Wy0XerWTMh1C3v7fpq9tjy42SVgY97eiUWEzFvuLfhLpNi5EL+UXXV2kmKaZNQtNzR
 kSEpY9+ETOc7F9pzfhlHxyrdyAJ/gCx4R1t9c+gNBV8ePAI1u4xA6Wqw+Oa2LzYjknhS
 8snQtC96D9BpiFKzkO3p3nuXZ7cM+3xAJTzvYN5dCFeC2GaIp9ctnGYKv60hK7+Iv8kG
 Y7txGQuLSlac0kWJJPTeevaBwC+Y0KJxorw5tSKa1wo2QUpR3+ZBPqxC5gLyhjGq3IbU
 4fnsGWB0QWvSTG/FmGDMrznqCi6w/sxlpWAVmIqedKmAfnlKrcf773olXsetHOl3d9RK
 hzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730792962; x=1731397762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YN0MxxoM2Amr+zycNp4vfsxGxdARFh/GtiSShK4gveM=;
 b=GT9RyC0n7gyZc3RN2FpYz/TpOf3+rRLHel3AysNJx0FWYhJWIBOCM4B6q2ECcyVJfl
 IOTz9DpoMP0EYw7NIiMnoVND4ERQfWyl2AypFQIuKEuxAnEUo3e0jB9GTW0l7KcjkzeO
 Op98N7uCsuLNjAIFsVVh2+bU8fKdVnUOwhymb/7TVSda4Tbz+2Gc0/wBGgkWaQKgD0iL
 NTrmNHL/C5JmqR7RH1KJ7QFqDB0X5lwJUyTrWw/tlddfZlzymztasX5GPTXBCzqRVSxE
 6C9gcnACMkx/N/q9ut737/d3jHiAI5NtSHg/0lz5bMf9kWb1rl4su83+rt+OZlli+128
 A0bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ3ncFRRM53BrT/1+asJaG6VTnihtM3KwCU9QK7dWh8Efw/1SA08UuFptI7I47+pRNupN2qVs=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7WvO5yp3BkEpO92HeRPRUWRh45XaDYSBnmtCR18zmuBHDJMkD
 IczA2Zw1RwQU8oaT0ahPIouJqLUj89W96JoMhrWqYnCnqwqW81Nn
X-Google-Smtp-Source: AGHT+IFujtpHb9sRSH91Ee/FcjyxGCYw9WZvv1ag1bgtJkQHY8nlqhSQQJYsTmEQb+7h4DqC5msnXQ==
X-Received: by 2002:a17:906:dc92:b0:a99:f0f4:463d with SMTP id
 a640c23a62f3a-a9e3a5a5083mr1962951266b.26.1730792961787; 
 Mon, 04 Nov 2024 23:49:21 -0800 (PST)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:61c2:fa6e:7930:6c92])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a9eb17f4b94sm92372166b.135.2024.11.04.23.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 23:49:21 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com, michal.simek@amd.com, hs@denx.de, pro@denx.de,
 sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/1]: bootcount: zynqmp: Add bootcount API
Date: Tue,  5 Nov 2024 08:49:16 +0100
Message-ID: <20241105074917.546887-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 Nov 2024 13:47:04 +0100
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Changes in v2:

	1) Move to DM infrastructure
	2) Appropriate initialization of *val pointer
	3) Updated help message
	4) Added config to the end of the Makefile
	5) Updated the appropriate values in struct pmu_regs

---
v1: https://lore.kernel.org/u-boot/20241029185814.7937-1-vassilisamir@gmail.com/

Vasileios Amoiridis (1):
  drivers: bootcount: Add ZynqMP specific bootcount support

 MAINTAINERS                                  |  1 +
 arch/arm/mach-zynqmp/include/mach/hardware.h |  2 +
 drivers/bootcount/Kconfig                    |  6 +++
 drivers/bootcount/Makefile                   |  1 +
 drivers/bootcount/bootcount_zynqmp.c         | 47 ++++++++++++++++++++
 5 files changed, 57 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_zynqmp.c


base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
-- 
2.34.1

