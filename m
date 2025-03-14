Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1F4C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD13681B4B;
	Fri, 14 Mar 2025 15:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jHPFyEVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B58781C64; Fri, 14 Mar 2025 15:07:34 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E8A80F9C
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39127512371so1394871f8f.0
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741961251; x=1742566051; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DlQwnyZIS9sheMXwR12coXup6JbBV5MtZKyFgRnjwBE=;
 b=jHPFyEVyziKdA7PgyJ5TceqUdq/QzlKPyce+85Ok3LLuLprEnP+P7BFdq8ujA0bR1P
 8ph7D+7EH7hR/B8E2Zuk6w1kRSYGAF/lViLhcP/ECgnJgE5cQRY4lC4WYMHZlAOYCW0X
 MMSVH/GnsAVLSuB/oCqoU5c+uGLfZ72ujlLDb2UfU3ArtmBunTllz3KSbkJ8en2U965d
 CSbIOQcKbS3qyTYfOU1b2J8tttO8WJNBkfCI07xMW1erkZpEw3JCWc+iEmDi054GqCF+
 vyINosRntiPyt5EKFX2lf1frWrbIOI0JTmSkZ9y2gFA05exNj6NSsiu34JGGE+N2wLgy
 xYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741961251; x=1742566051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlQwnyZIS9sheMXwR12coXup6JbBV5MtZKyFgRnjwBE=;
 b=iApIjW1qDpEr2PlTjb5VVjPO5Fr0cK6OMgNHtIQswL1s2pClJEAiENWyfKWjtLdFNH
 kaa/rOfUnqF05oUJ4N327hLggirXIeEaBoRjSp6o90GPqGlBHdMinbPOR7TembiMPb9z
 m9WM8RqbJmukpW9xmfjZRXRMyNwG1UFcKa82U1xNEFKWRyv+dmFolvvzWNxtNYmZDaoT
 dUPHJTcsfUp1+E28c02U7q6+DgidGrL1AX2jCjnK/CZw7RBzQv3IHIEMiDdIXsijvqHt
 +ANs7cZxX14aP0EhvJF7T/Ch23ReTyxE6h3zqqNTdqsNPKcEl/8GPus8EspsRiEqcxDw
 s/pg==
X-Gm-Message-State: AOJu0Ywr23h876bfie37ms9qTOf4jUvvYtR8sGShCgdUedfE8c7ry4sr
 rPuC+zzVx6osc7F5UkVcjAp90srVeVkKo7MMzveh42FTZS6ILihKEYvGOMmBzAnvKpiaAYUSxqG
 o
X-Gm-Gg: ASbGncu9DsDP52TP/5gmHWz4cBLPMXB7XEVBx6sRHzSn/Axtj08fOadMP2wGHuwxFm7
 ca0PeZQjv8XC8Tq8a7GlVuvRtarjRiTvdwmmcROv+vA6D/f/+lXyXbMzJTc1/rhn8VgXtrlTVeP
 iRMvKPF/vUwlyGsyrNjmPygTVJZ5Eqa2q1jYzjkkdfLYfNjepA8wPeo4FmyiStjcwVvOrKGR0wq
 TXw1WF4Mn3dc2pCLPh714ibx9TWztnemuuobZdFf2FkbGcLQuL5XqnuueXsW7W6A/dsKvuLEr2Y
 Hk+NBHoIJF3kht3G+ERZ8AAZ/b7upHrjOoFNPFt7nh+rtv6tpYzjXtZVWfrbAyXa3le4ufRnNcW
 cX2tM6oqbyW4tICm789W+Zu4=
X-Google-Smtp-Source: AGHT+IE9quEJ/U+P7SsZEJZmAMFpr4ghNj3P3PtC2szWeiIbZa40q8O6z7zLDyBpFZARo7nKUBBNWw==
X-Received: by 2002:a05:6000:400d:b0:394:d0c3:da5e with SMTP id
 ffacd0b85a97d-3971f5114b2mr3425269f8f.47.1741961250896; 
 Fri, 14 Mar 2025 07:07:30 -0700 (PDT)
Received: from localhost.localdomain (ppp089210242125.access.hol.gr.
 [89.210.242.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ec14bsm5636952f8f.100.2025.03.14.07.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:07:29 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Cc: ilias.apalodimas@linaro.org, andre.przywara@arm.com,
 richard.henderson@linaro.org
Subject: Pull request for mmu-next-14032025
Date: Fri, 14 Mar 2025 16:07:26 +0200
Message-ID: <20250314140726.294800-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
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

Hi Tom,

The following changes since commit 9805321dfdeb5225fe5c5e0721abf49c0875637e:

  Kconfig: Introduce CONFIG_WERROR (2025-03-13 14:23:11 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/mmu-next-14032025

for you to fetch changes up to fb553201b67aededdc794f3a0880e386771cbd58:

  arm64: Enable RW, RX and RO mappings for the relocated binary (2025-03-14 13:37:54 +0200)

This is identical to the v4 posted here [0] but with Andre's comments addressed.
I skipped sending a v5 since the number of recipients are large and most of the
patches were already reviewed.

The CI at https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/25152
showed no issues.

Please pull!

[0] https://lore.kernel.org/u-boot/20250301164922.397441-1-ilias.apalodimas@linaro.org/

----------------------------------------------------------------
Up to now we configure the entire memory space for U-Boot as RWX.
For modern architectures and security requirements, it's better to
map the memory properly.
This pull request adds basics support for mapping the U-Boot binary with
proper (RO, RW, RW^X) memory permissions on aarch64 right after we
relocate U-Boot in the top of DRAM.
It's worrth noting that the linker script annotations are only added for
the aarch64 architecture. We can, in the future, try to unify the linker --
at least for the architectures that have enough in common and expand this

----------------------------------------------------------------
Ilias Apalodimas (6):
      meminfo: add memory details for armv8
      doc: update meminfo with arch specific information
      arm: Prepare linker scripts for memory permissions
      arm64: mmu_change_region_attr() add an option not to break PTEs
      treewide: Add a function to change page permissions
      arm64: Enable RW, RX and RO mappings for the relocated binary

 arch/arc/lib/cache.c             |  6 +++
 arch/arm/cpu/arm926ejs/cache.c   |  6 +++
 arch/arm/cpu/armv7/cache_v7.c    |  6 +++
 arch/arm/cpu/armv7m/cache.c      |  6 +++
 arch/arm/cpu/armv8/cache_v8.c    | 99 ++++++++++++++++++++++++++++++----------
 arch/arm/cpu/armv8/u-boot.lds    | 59 ++++++++++++++++--------
 arch/arm/include/asm/armv8/mmu.h |  2 +
 arch/arm/include/asm/system.h    | 18 ++++++++
 arch/arm/lib/cache.c             |  6 +++
 arch/m68k/lib/cache.c            |  6 +++
 arch/nios2/lib/cache.c           |  6 +++
 arch/powerpc/lib/cache.c         |  6 +++
 arch/riscv/lib/cache.c           |  6 +++
 arch/sh/cpu/sh4/cache.c          |  6 +++
 arch/xtensa/lib/cache.c          |  6 +++
 cmd/meminfo.c                    |  6 +++
 common/Kconfig                   | 13 ++++++
 common/board_r.c                 | 20 ++++++++
 doc/usage/cmd/meminfo.rst        | 71 ++++++++++++++++++++--------
 include/asm-generic/sections.h   |  2 +
 include/cpu_func.h               | 17 +++++++
 21 files changed, 313 insertions(+), 60 deletions(-)
