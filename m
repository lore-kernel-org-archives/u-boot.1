Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E25D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:35:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A88E83AA9;
	Fri, 28 Nov 2025 17:35:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="acOx9C+h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983D883AD1; Fri, 28 Nov 2025 17:35:47 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D615838FA
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-8b0f54370ecso192374585a.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764347744; x=1764952544; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bYN4w1qA5kNuyz9XImp5Mp7TK32rdY6HZ51sLP1DdnU=;
 b=acOx9C+hzTaL8CikhyrYcUoIlZ/0l3DibRMqTY09clK+ErxiM65kglJ/29JVXLuQa/
 61CUZjSOV41lg8lK5Dr4+GS/DuSmoZ13JIYRTnJsARKG/tjXpdGaVv4q8C3//H9MZQSw
 /QH6YNAKs8QQYngf3XP3E9IUL/KqN49xQqh5sjr5OGEvs6clymahx2iqzWc0iYh9EkRX
 76Tk5w2RFHnxFT/JX1RNlPah1Z35vhRpNHxIKZRAJQVQrmQMmJmJ8ojpmKaerZQZW+LH
 6uR3fPvEW/D8yPzH8/hifkur65T7g0xgwxQPibIMLYfVO4MQZndiB9B1PqBtPg/kds14
 SwlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764347744; x=1764952544;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bYN4w1qA5kNuyz9XImp5Mp7TK32rdY6HZ51sLP1DdnU=;
 b=KYoyMBHe6Fq6BHSEXQUYZ8nlzzth0AWsJ1qLvetQqRtsQeiO8MacOF8j0+gib7vl4a
 S+clnlVNTMQKfA3aW6K8ry9NCU7G+FWmI1Ro0tgQ6PpXRSrXeNkEsi+w3eeAqPSRp0Gm
 HaCDagH4YnQO2VelSRXNJ7f5wKOvXAOb2iY6xcPAl+822z1O0MQ0nfPTnjrt3u7dr4Ma
 WKtjJqzA9uv/mEIg03IOK+a54ae5BXLLoXv3BEClD6orkJ23T14eehAR8pe3mEZX6y8h
 H7PtRZfz/V20IKkjQGCjdTgAXWssjYNqR27Tnz9uaLkb3tS5bowr9/kCoYL+K3rO5JDk
 X7HA==
X-Gm-Message-State: AOJu0YzhnWwXzp+kxJoBYVDR2ec91ZuPTauozO4FWmbx8AMzNLzXuYyb
 NvbrELenKU8HIL57t45gjT2abYhl9zj1UziyxLHpryBLDhfbN1jVdzaoXBnORsoFC9c=
X-Gm-Gg: ASbGncsxj3AVRAOv88LQJp3On4Tk7gonBXxBKOGjuLuzYDvgNu+rs+EDi4bL75lsjCj
 +kf5g6iXiuEdTwTmStCxTFnjEYUS0or9jzgi7dzBfiEvJd0nJZCcdWwhvYAOyLP+btM3fKe4L2v
 1ncWvGEmBP0SzUZpyqDBOTH7aSovvhXO05X3P6DTUnj1r5vw+bDDi8kBILKZsYMLYWJG03sETHY
 XD4SjDauJ4hm5GRmn9UuBnti0k8MHciJijpeuKri9WchdBciL5aTP0s8DoEsB/SZVUrEmFYmRtT
 aenaLx+b51sER5mghWuiDDWq8HP/7/iocd3vRmC+ssZAwG6XfbF4WEHwbasphtoisR1WhHONuMP
 wMBf9HlhuHGGasjWOQj9AvAS4k3OdobIhzIDF9OwCcuNmxhGT/+rH877oZ0F6SSMepEI5rdZxCN
 OyIszFbRksucRQvi78PGNwvK6S5P9YLu8=
X-Google-Smtp-Source: AGHT+IHxLm98JeqlMH6C856gWcjRWmbOD/1hY/rcq37VyBHPGlUhadCTM+SL3M2AcOpI5ExxYQVr0A==
X-Received: by 2002:a05:620a:4496:b0:8b2:dabe:de42 with SMTP id
 af79cd13be357-8b4ebdb0549mr2082560385a.46.1764347744084; 
 Fri, 28 Nov 2025 08:35:44 -0800 (PST)
Received: from ubuntu.localdomain ([216.58.22.99])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b75a9sm331227985a.25.2025.11.28.08.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 08:35:43 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 0/6] Implement all missing SMBIOS types required by distro
 tooling
Date: Fri, 28 Nov 2025 08:35:17 -0800
Message-Id: <20251128163535.2301653-1-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This series finish the last missing puzzle of required SMBIOS types by:
1) Fixing duplicated handles when multiple instances exist in one type;
2) Implementing the rest of required types 9/16/17/19;
3) Adding version control when printing properties for all types.

Type 9/16/17/19 are generally DT-based, the idea is to write these tables
using a hybrid approach:
Explicit DT definitions under existing '/smbios/smbios' take precedence,
with fallback to scan and interpret values from the entire DT.

Moreover, all below APIs:
smbios_get_val_si()
smbios_get_u64_si()
smbios_add_prop_si()
are on top of sysinfo, thus allow vendors to get values from other
subsystems by implementing their own sysinfo driver if needed.

Raymond Mao (6):
  smbios: Fix duplicated smbios handles
  smbios: add support for dynamic generation of Type 9 system slot
    tables
  smbios: add support for dynamic generation of Type 16 table
  smbios: add support for dynamic generation of Type 17 table
  smbios: add support for dynamic generation of Type 19 table
  smbios: print the properties only when they exist in a specified
    version of spec

 arch/arm/dts/smbios_generic.dtsi |   12 +
 cmd/smbios.c                     |  365 +++++++++-
 drivers/sysinfo/smbios.c         |    5 +
 include/smbios.h                 |  151 ++++
 include/smbios_def.h             |  250 +++++++
 include/sysinfo.h                |    4 +
 lib/smbios.c                     | 1152 +++++++++++++++++++++++++++++-
 7 files changed, 1906 insertions(+), 33 deletions(-)

-- 
2.25.1

