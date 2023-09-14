Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32ED9EEAA55
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 16:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 526BE869C4;
	Thu, 14 Sep 2023 18:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ECXVOC4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3DB086672; Thu, 14 Sep 2023 18:20:38 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC9BF86A0A
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 18:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bfc14e6d03so14457491fa.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694708436; x=1695313236; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jK8KWyE77LRnMxQrpPJAkkmeOuxeHCS5VoDcAhRbbVU=;
 b=ECXVOC4DEoA2qsWeqRnkcyI8lom6AfP+BcUhwt2Ypx3xRy8bkJcN3wMnXGcslml4Dc
 PmPe/etp9tM7ksuuOQe9v79znjvAJcCHF95ZpIbdyrPRuttWKnK40h9eTMxNaXR7mYJ2
 9frQDjYHnp7sdJvY3R8LbwkWagkMxEHoQn5IedvHgYgrNm3IM0yrbSEc12YjtnyEKsIs
 B3nRGTZ4Ix1uD5DCpItWfMQ6unNZYOoGA9h/BzYGQKQwWgIamnwochaAUcXtR2z6aHml
 1CXAKpYh+LrqQ+mmjFumxH4LTDV4TyQ9i+pjv6OzclVD1X5HkkUTVcBzOAY0dKjUtRi4
 Eiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694708436; x=1695313236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jK8KWyE77LRnMxQrpPJAkkmeOuxeHCS5VoDcAhRbbVU=;
 b=qzs23Z9eboCqHA9nwA2nykLqXGYRSAIr3cmnFaBhctA7rDOFvGsJlyAdWIt8K+PJd3
 sJVlpVlUZp9b5sXcuw/4KEil9WFUKZrHEvnPYxlrDnVGZWC+04KCMhvNqa+SyLRqi418
 INgpoAQVWcMeXhH6HvgpFGYwxv3ktcYYY9IkM5gyWCzO/640esXS4Jv/edfs/m1iX+aF
 Qeq7Jm3S/DMq1nZbPTLZFjttwGb/FpDwd2SOU1DtX2lu5ENGRxfGc1yUeHv1zNi++CxS
 ec4mQSHXmjlrtFduESGdZhOKUeC/WN7juv8XEbEMZ+68E9aG3tM9Z4wsRNTbfeifjm92
 9S7Q==
X-Gm-Message-State: AOJu0YxMLhVZzJNHOvIxOSWrkehDtb5ytfXJ/QT6mYH/0tbfmxv3j+rC
 QrboblJPGRqINKX5Q8x+R+pJ4qfYZe5ItgN1/7ZJnQ==
X-Google-Smtp-Source: AGHT+IFqLaca8YNVfZbh+/iIQR7rQSSW6vcD/WsnfLHBNwakBF9e4afGLrdkx6m1GaJnr/zJ2h0nHg==
X-Received: by 2002:a2e:ba08:0:b0:2b6:9f95:8118 with SMTP id
 p8-20020a2eba08000000b002b69f958118mr879994lja.7.1694708435965; 
 Thu, 14 Sep 2023 09:20:35 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a2e8e8f000000b002ba7ae1f52asm346919ljk.0.2023.09.14.09.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 09:20:35 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 00/15] net/lwip: add lwip library for the network stack
Date: Thu, 14 Sep 2023 22:18:13 +0600
Message-Id: <20230914161828.3662-1-maxim.uvarov@linaro.org>
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
  net/lwip: drop old net/wget

 .gitmodules                           |   3 +
 boot/bootmeth_efi.c                   |  18 +-
 boot/bootmeth_pxe.c                   |  21 +-
 cmd/Makefile                          |   1 +
 cmd/net-lwip.c                        | 286 +++++++++++++++++
 cmd/net.c                             |  86 +----
 cmd/pxe.c                             |  19 +-
 doc/develop/index.rst                 |   1 +
 doc/develop/net_lwip.rst              |  75 +++++
 include/net.h                         | 197 +-----------
 include/net/arp.h                     |   7 +
 include/net/eth.h                     | 190 +++++++++++
 include/net/lwip.h                    |  73 +++++
 include/net/ulwip.h                   |  64 ++++
 include/net/wget.h                    |  22 --
 net/Kconfig                           |   3 +
 net/Makefile                          |   2 +-
 net/eth-uclass.c                      |   8 +
 net/lwip/.gitignore                   |   8 +
 net/lwip/Kconfig                      |  25 ++
 net/lwip/Makefile                     |  70 ++++
 net/lwip/apps/dhcp/lwip-dhcp.c        |  85 +++++
 net/lwip/apps/dns/lwip-dns.c          |  63 ++++
 net/lwip/apps/http/Makefile           |   6 +
 net/lwip/apps/http/lwip-wget.c        | 105 ++++++
 net/lwip/apps/ping/Makefile           |  12 +
 net/lwip/apps/ping/lwip_ping.c        |  38 +++
 net/lwip/apps/ping/lwip_ping.h        |  15 +
 net/lwip/apps/ping/ping.h             |  19 ++
 net/lwip/apps/tftp/Makefile           |   7 +
 net/lwip/apps/tftp/lwip-tftp.c        | 129 ++++++++
 net/lwip/lwip-external                |   1 +
 net/lwip/lwipopts.h                   | 178 +++++++++++
 net/lwip/port/if.c                    | 332 +++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  38 +++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 net/net.c                             |  26 +-
 net/wget.c                            | 440 --------------------------
 40 files changed, 1938 insertions(+), 758 deletions(-)
 create mode 100644 .gitmodules
 create mode 100644 cmd/net-lwip.c
 create mode 100644 doc/develop/net_lwip.rst
 create mode 100644 include/net/arp.h
 create mode 100644 include/net/eth.h
 create mode 100644 include/net/lwip.h
 create mode 100644 include/net/ulwip.h
 delete mode 100644 include/net/wget.h
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
 delete mode 100644 net/wget.c

-- 
2.30.2

