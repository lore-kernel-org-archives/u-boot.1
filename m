Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A9E7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:43:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B6B486C35;
	Tue, 26 Sep 2023 11:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J8ZG9Lmo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CE886C2D; Tue, 26 Sep 2023 11:43:41 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B849686AF7
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:43:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50307759b65so13669968e87.0
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695721419; x=1696326219; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7qX/8wp9Docd81usCSLPuwmHadorptStqUk3Ft4qnE=;
 b=J8ZG9LmodeP+K89xvYPMmGxre5dJNmTZMzPjW2c3KE/v8CIXLkHiUmJxxrFt3NHkHm
 Te9d0MlCOMybxFlw8ndxujnfZDhCWc5qgKAWrBuzORa/AseF3xIP/xam1eaVXViI/HhQ
 +nLHbWq2uCR6Hmhy+60FZutxtEwTEHdDe9QmfLk/y9hlydUplDGoUnU8aWSeRILOgGSI
 f0IkJz05pMakcSq804+PoPeJXsrtCRbDNGF1UOpYVuOT67GURLfUpp4yL7V2fIc7svN2
 2CUNp9g4kSYqm77DQu7ThrhsSSD35xfLiQLR5HNVMVg/A8O0jxh3+ng9svBkji0ATA7S
 dBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695721419; x=1696326219;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C7qX/8wp9Docd81usCSLPuwmHadorptStqUk3Ft4qnE=;
 b=mLsrde6mAAgiFlIXlhrYQNEvJ5e2xG5F+EKRMwMDfbjsDORAglX3LdFS5rCk9pJezD
 /qPIkRXGv5UlU1uBrKIbZRrdYUOSFkcHF5ixoDBe4UQejVYN5x6A0WM55fud5eUjfWYW
 srVgmteRMKH3qfl0HW+X/c3VBkj6YF4awHZ7zNrI9ArBqyrG9UVXnBnfxmH5n4WZv/vZ
 2fVI/6kneKVwzk7leHgVqOKUberymVi5T69nGIdNe92z54OJgow9L5MO8bPS1uDBUMLx
 P81bGg/+V/HkabDhcyxCLv+kC8qZWZTnE4MzrPkZM1V/5X1e/N3Z5q0zHZZ4R5LlPfdz
 /IEw==
X-Gm-Message-State: AOJu0YylwrJbgBAnyZmlWuQdyjJGh5Kplt/KTXD+g06FUtBiIMh+Hyd3
 ybewM0x2/CMHyaH1aiEOmiea24Bl6ErjqCYGbcTxsA==
X-Google-Smtp-Source: AGHT+IHSWZywivdCAk3ba72ShFQmj78zsV+77YBD0I9Dn5szfJhZv8u/Stp+hCxN/U60+zhpIWBbxQ==
X-Received: by 2002:a05:6512:3586:b0:500:c589:95fb with SMTP id
 m6-20020a056512358600b00500c58995fbmr6825864lfr.55.1695721418596; 
 Tue, 26 Sep 2023 02:43:38 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 x6-20020ac25dc6000000b004fe09e6d1e7sm2131131lfq.110.2023.09.26.02.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 02:43:38 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv10 00/15] net/lwip: add lwip library for the network stack
Date: Tue, 26 Sep 2023 15:41:09 +0600
Message-Id: <20230926094124.7024-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
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

changelog:
	v10: - fix ping with following tftp command issue with incorrect
		ping timeout clear.
	     - Makefile on make will init submodules and if needed will
	       do git clone.
	     - wget - some minor code style changes.
	v9: - added first patch describing git submodule for lwip. So
	      the build procedure is:
		git submodule init
		git submodule update
		make
	    - reworked a little bit dhcp cmd state polling
	    - fixed review comments for v8
	v8: - comments for previous review
	    - removed lwip timeout callback pointer
	    - made lwip timeouts works, that also allowed to remove
	      static vars.
	    - setenv for filesize tftp and wget has to be in hex.
	    - Makefile changes always compile it tftp,dns,wget,ping due
	      to it can be used not only by CONFIG_CMD_.
	    - Kconfig changes - simplify lwIP settings and support only
	      one configuration.
	    - tested with mini debian.iso load over http or tftp, mount
	      and boot it (qemu, arm64).
	v7: - more review fixes.
	    - support of multiply eth devices, were "ethact" selects the
	      active device.
	v6: - fixed review comments for v5 (thanks Ilias and Simon).
	v5: - fixed Iliases comments and split big patch on the small
		ones.
	v4: - tested with tests/py/ did some minor fixes (out of tree
		build, variables set after downloads).
	    - accounted review comments for documentation.
	    - implemented dns command
            - corrected wget command to not use serverip variable and use just
		url string.
	v3: - use lwip commands for ping,tftp,wget,dhcp if this patch
	      applied. Drop CONFIG_LIB_LWIP_REPLACE_<COMMAND> option.
	    - docs: use rst variant and drop references to RFC.

Maxim Uvarov (15):
  submodule: add lwIP as git submodule
  Makefile: init submodules
  net/lwip: add doc/develop/net_lwip.rst
  net/lwip: integrate lwIP library
  net/lwip: implement dns cmd
  net/lwip: implement dhcp cmd
  net/lwip: implement tftp cmd
  net/lwip: implement wget cmd
  net/lwip: implement ping cmd
  net/lwip: add lwIP configuration
  net/lwip: implement lwIP port to U-Boot
  net/lwip: update .gitignore with lwIP
  net/lwip: connection between cmd and lwip apps
  net/lwip: replace original net commands with lwip
  net/lwip: split net.h to net.h, arp.h and eth.h

 .gitmodules                           |   3 +
 Makefile                              |   5 +-
 boot/bootmeth_efi.c                   |  18 +-
 boot/bootmeth_pxe.c                   |  21 +-
 cmd/Makefile                          |   1 +
 cmd/net-lwip.c                        | 286 ++++++++++++++++++++++
 cmd/net.c                             |  86 +------
 cmd/pxe.c                             |  19 +-
 doc/develop/index.rst                 |   1 +
 doc/develop/net_lwip.rst              |  75 ++++++
 include/net.h                         | 197 +--------------
 include/net/arp.h                     |   7 +
 include/net/eth.h                     | 190 +++++++++++++++
 include/net/lwip.h                    |  73 ++++++
 include/net/ulwip.h                   |  64 +++++
 net/Kconfig                           |   3 +
 net/Makefile                          |   1 +
 net/eth-uclass.c                      |   8 +
 net/lwip/.gitignore                   |   8 +
 net/lwip/Kconfig                      |  25 ++
 net/lwip/Makefile                     |  70 ++++++
 net/lwip/apps/dhcp/lwip-dhcp.c        |  85 +++++++
 net/lwip/apps/dns/lwip-dns.c          |  63 +++++
 net/lwip/apps/http/Makefile           |   6 +
 net/lwip/apps/http/lwip-wget.c        | 105 ++++++++
 net/lwip/apps/ping/Makefile           |  12 +
 net/lwip/apps/ping/lwip_ping.c        |  39 +++
 net/lwip/apps/ping/lwip_ping.h        |  15 ++
 net/lwip/apps/ping/ping.h             |  27 +++
 net/lwip/apps/tftp/Makefile           |   7 +
 net/lwip/apps/tftp/lwip-tftp.c        | 129 ++++++++++
 net/lwip/lwip-external                |   1 +
 net/lwip/lwipopts.h                   | 178 ++++++++++++++
 net/lwip/port/if.c                    | 332 ++++++++++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  38 +++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 net/net.c                             |  20 +-
 39 files changed, 1951 insertions(+), 290 deletions(-)
 create mode 100644 .gitmodules
 create mode 100644 cmd/net-lwip.c
 create mode 100644 doc/develop/net_lwip.rst
 create mode 100644 include/net/arp.h
 create mode 100644 include/net/eth.h
 create mode 100644 include/net/lwip.h
 create mode 100644 include/net/ulwip.h
 create mode 100644 net/lwip/.gitignore
 create mode 100644 net/lwip/Kconfig
 create mode 100644 net/lwip/Makefile
 create mode 100644 net/lwip/apps/dhcp/lwip-dhcp.c
 create mode 100644 net/lwip/apps/dns/lwip-dns.c
 create mode 100644 net/lwip/apps/http/Makefile
 create mode 100644 net/lwip/apps/http/lwip-wget.c
 create mode 100644 net/lwip/apps/ping/Makefile
 create mode 100644 net/lwip/apps/ping/lwip_ping.c
 create mode 100644 net/lwip/apps/ping/lwip_ping.h
 create mode 100644 net/lwip/apps/ping/ping.h
 create mode 100644 net/lwip/apps/tftp/Makefile
 create mode 100644 net/lwip/apps/tftp/lwip-tftp.c
 create mode 160000 net/lwip/lwip-external
 create mode 100644 net/lwip/lwipopts.h
 create mode 100644 net/lwip/port/if.c
 create mode 100644 net/lwip/port/include/arch/cc.h
 create mode 100644 net/lwip/port/include/arch/sys_arch.h
 create mode 100644 net/lwip/port/include/limits.h
 create mode 100644 net/lwip/port/sys-arch.c

-- 
2.30.2

