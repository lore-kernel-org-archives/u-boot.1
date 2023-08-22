Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB178EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 09:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B22786484;
	Tue, 22 Aug 2023 11:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MVBTA3M7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D52BF86487; Tue, 22 Aug 2023 11:38:25 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9FA86483
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 11:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bc63e0d8cdso41415221fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 02:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692697101; x=1693301901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pauOOzPigbLRQbjddrYQYTslWma+kJ49KyfEuFCkD14=;
 b=MVBTA3M7/tj6n8HzT/W3lYfBCRA19ozoKQEX0cQX1EZRYCY9tt51SyGGcHCSpf6Cc+
 vDUN6kjTBeU4NnQR4Gi57dLhqD1w1EkgtW0+Ps4kH+3lLZr/SAgdSVuaN9MJA2JEDFST
 ulvP5VmySBl1OVYr7DdLp8TraMMa47wkFhkdD1WQB2Em6Ll1h5F4Z0cRH5iXeZOEAZ0v
 m1Y/vxEpVsFdDPIIWRe6FAwj4ZKCYsAjHRBH20AnL1kX5AKpIYY08x3VJXlOWk456p+r
 /ESr4PdwgGo3Hhz94fV58cXg9cW/+3Gs1G3Nh/QUVL0ZNB85k2Sr8zwk3R6tspZVuZRa
 ZCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692697101; x=1693301901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pauOOzPigbLRQbjddrYQYTslWma+kJ49KyfEuFCkD14=;
 b=IIf+S+OltOrZ8O4snuUoUQPzwXnKLBXyB5/EvU6CbwmLeDK1LDqF4rFaw9VhGYMiN5
 bRI0bN9YjWYvzjWKk9omtMsmmMmKaOe3F4KfRXMFhpZtI8KcBTBg8rYKPFviLOAjlJFG
 oG0AGLK+SDn02W3H1a80rdqNMXKALXiOqevl0PaDp4CvCzWxGsRC5PriDkKgFzhAKVtr
 bsSfI6IWnTV8belSDK6op5GNOX3Tci1VbzgbM8xiOGvj9f2Htrfv7Gp9iFz8fRLRpF6e
 87KRY+XXCB/Y/oYVTC8E32csB13HnKP4EMvpnT+sTWh03ox7jUOGkk1BL/4g4xqQAncJ
 hKKw==
X-Gm-Message-State: AOJu0YwyvTQvKBGhSkvnyJf3kaulA6DCFuzNs+scVn9KhOp6xmVrXhB9
 6xy5j9lfDdafx0VIoBMQ2phxehoYx+tLyWn2Ck/+Ng==
X-Google-Smtp-Source: AGHT+IFVzOGbdIr9Qf3n4uGzffDP2t4eziqsp/gvfaocqE0qmquJDTi/VcdF6kJDKJSUpvBA6NRCMQ==
X-Received: by 2002:a2e:3016:0:b0:2b6:dc55:c3c7 with SMTP id
 w22-20020a2e3016000000b002b6dc55c3c7mr6879367ljw.20.1692697101644; 
 Tue, 22 Aug 2023 02:38:21 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a2e8089000000b002b724063010sm2649637ljg.47.2023.08.22.02.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 02:38:21 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv7 00/15] net/lwip: add lwip library for the network stack
Date: Tue, 22 Aug 2023 15:35:59 +0600
Message-Id: <20230822093614.4717-1-maxim.uvarov@linaro.org>
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

Hello,

I'm sending v7, with all v6 comments getting fixed. The only thing left is a pointer
to timeout callback which 2 applications use. I will rework this timeout
in next v8. I started take a look at it, and want to fix this together
with background applications support in v8.

changelog:
	v7: - more review fixes.
	    - support of multiply eth devices, were "ethact" selects the
	      active device.
	v6: - fixed review comments for v5 (thanks Ilias and Simon).
	    - lwip is not under /net, so prior applying patch following
	      commit is needed to create lwIP merge into U-Boot:
	      git subtree add --prefix net/lwip/lwip-external https://git.savannah.nongnu.org/git/lwip.git master --squash

	v5: - fixed Iliases comments and split big patch on the small
		ones.
	    You also need to issue command:
    	git subtree add --prefix lib/lwip/lwip-external https://git.savannah.nongnu.org/git/lwip.git master --squash
	Which will create merge commit of lwip library placing sources
	into lib/lwip/lwip-external directory. I do not send it a patch
	due to 1. merges are not friendly with git format-patch and 2.
	the source code of lwip is 78kb. 
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
  net/lwip/wget add port selection

 boot/bootmeth_efi.c                   |  18 +-
 boot/bootmeth_pxe.c                   |  21 +-
 cmd/Makefile                          |   1 +
 cmd/net-lwip.c                        | 306 ++++++++++++++++++
 cmd/net.c                             |  86 +----
 cmd/pxe.c                             |  19 +-
 doc/develop/index.rst                 |   1 +
 doc/develop/net_lwip.rst              |  76 +++++
 include/net.h                         | 197 +-----------
 include/net/arp.h                     |   7 +
 include/net/eth.h                     | 190 +++++++++++
 include/net/lwip.h                    |  73 +++++
 include/net/ulwip.h                   |  76 +++++
 include/net/wget.h                    |  22 --
 net/Kconfig                           |   3 +
 net/Makefile                          |   2 +-
 net/eth-uclass.c                      |   8 +
 net/lwip/.gitignore                   |   8 +
 net/lwip/Kconfig                      |  55 ++++
 net/lwip/Makefile                     |  72 +++++
 net/lwip/apps/dhcp/lwip-dhcp.c        |  62 ++++
 net/lwip/apps/dns/lwip-dns.c          |  46 +++
 net/lwip/apps/http/Makefile           |  13 +
 net/lwip/apps/http/lwip-wget.c        | 134 ++++++++
 net/lwip/apps/ping/Makefile           |  11 +
 net/lwip/apps/ping/lwip_ping.c        |  37 +++
 net/lwip/apps/ping/lwip_ping.h        |  15 +
 net/lwip/apps/ping/ping.h             |  19 ++
 net/lwip/apps/tftp/Makefile           |  16 +
 net/lwip/apps/tftp/lwip-tftp.c        | 124 ++++++++
 net/lwip/lwipopts.h                   | 197 ++++++++++++
 net/lwip/port/if.c                    | 343 ++++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  38 +++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 net/net.c                             |  26 +-
 net/wget.c                            | 440 --------------------------
 38 files changed, 2028 insertions(+), 757 deletions(-)
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
 create mode 100644 net/lwip/lwipopts.h
 create mode 100644 net/lwip/port/if.c
 create mode 100644 net/lwip/port/include/arch/cc.h
 create mode 100644 net/lwip/port/include/arch/sys_arch.h
 create mode 100644 net/lwip/port/include/limits.h
 create mode 100644 net/lwip/port/sys-arch.c
 delete mode 100644 net/wget.c

-- 
2.30.2

