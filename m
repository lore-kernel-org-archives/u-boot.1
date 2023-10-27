Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6201CC25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 00:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7228A87BB6;
	Fri, 27 Oct 2023 02:24:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nKVht+kP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C48987BC3; Fri, 27 Oct 2023 02:24:38 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 167B68071F
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 02:24:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-584a761b301so1266599a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 17:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698366273; x=1698971073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TfLIqTT0LmU7urkglwy8+XlaAX/gX2pAvtSDgZLAdwA=;
 b=nKVht+kPKsP9vNlKc/9QSIoeEaDHathkV6819kcfAX2tY2YI1RASdKW7eeX4A5MWaF
 jCKb99CulFrphryJjkzysYPnIYFgs0w0WtCW+vUEqvAcGvV9b/w9zzdq51RSOLFCu1jk
 kXVHFAx7/rcg4TqaEz4NUZ3iqtzfbwFjUDVV3LapcVlDIqgu+fH3o66M3SMN6KHYU40T
 NWfMmpqUmmf8NERBzTddeC6GQAa9+H1tOjEd+lhMSS85B+Oi620dlByaXxveahImKOAH
 s8YOdBR9keagdHzlwgZ/Ky5zbdwG0UVMOQDRA8QgHAHxL2TQe+OtBaSPT7KMHkGsfqfX
 nlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698366273; x=1698971073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfLIqTT0LmU7urkglwy8+XlaAX/gX2pAvtSDgZLAdwA=;
 b=HCQ03zXkKtrmZzDxif7R6jytPPfJvHCqnxISo8WpEoeK/5frU8v/CRgZDrLwJ0TgkO
 XZrfM2c3vZxwGKEjeJ9SWroFIZg6SvEvO7ZXK29wvTYVdKEzumx7Xk3ts1nIdL6NmZdp
 y8iO5MWhKO4dQKXt8mh8Bw91ptk/KgrsYKupjbepeitiH+NlMhL8Y7WDgEI56XVbGi03
 voBr+Qnz57m97t3Ur6pxWOlAZjeMCLctsRQM9WzY+kEdXjlueDwqOme8C1w7A1YBCV1P
 bfvH9KdpWgQpn5bg3L6Pb9O904LadcWED/GQ/R8YNAPqkKDJjAzk78SDz2QrSspYhTho
 2E+A==
X-Gm-Message-State: AOJu0YyFzkNzzC4ctelTWLp7cVPdoRCfae9dS2gSokXE8Zx5yT9a/ZuD
 MifeHUoNXkgic94w5DHbKeuVfUmwnzv3lw==
X-Google-Smtp-Source: AGHT+IEcMLdO07hG7N3sC7vX4WnELRN450dA63dPnZaJp1+jLc4blNe44dd21Ppc38VElMlLdQ7XZQ==
X-Received: by 2002:a17:90b:3449:b0:27d:6404:bffc with SMTP id
 lj9-20020a17090b344900b0027d6404bffcmr1178886pjb.1.1698366272858; 
 Thu, 26 Oct 2023 17:24:32 -0700 (PDT)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:b6a2:eace:f54:1956])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a031600b0027476c68cc3sm167606pje.22.2023.10.26.17.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 17:24:32 -0700 (PDT)
From: Chris Packham <judge.packham@gmail.com>
To: u-boot@lists.denx.de
Cc: Chris Packham <judge.packham@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marc Zyngier <maz@kernel.org>, Peng Fan <peng.fan@nxp.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Simon Glass <sjg@chromium.org>, Will Deacon <willdeacon@google.com>,
 Ye Li <ye.li@nxp.com>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 meitao <meitaogao@asrmicro.com>
Subject: [PATCH 0/3] Revert HAFDBS changes
Date: Fri, 27 Oct 2023 13:23:51 +1300
Message-ID: <20231027002409.430285-1-judge.packham@gmail.com>
X-Mailer: git-send-email 2.42.0
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

As discussed this series reverts the HAFDBS changes that caused an issue
on AC5/AC5X. I think there are some improvements that can be made to the
initial memory map for the AC5/AC5X but so far nothing I've found makes
it compatible with the HAFDBS changes.


Chris Packham (3):
  Revert "armv8: enable HAFDBS for other ELx when FEAT_HAFDBS is
    present"
  Revert "arm64: Use level-2 for largest block mappings when FEAT_HAFDBS
    is present"
  Revert "arm64: Use FEAT_HAFDBS to track dirty pages when available"

 arch/arm/cpu/armv8/cache_v8.c      | 30 +++---------------------------
 arch/arm/include/asm/armv8/mmu.h   | 20 ++++----------------
 arch/arm/include/asm/global_data.h |  2 --
 3 files changed, 7 insertions(+), 45 deletions(-)

-- 
2.42.0

