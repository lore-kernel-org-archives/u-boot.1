Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4B6EE8000
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 13:55:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E2786A2B;
	Fri,  8 Sep 2023 15:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nei7sgPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CD1186A38; Fri,  8 Sep 2023 15:55:34 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF9786A2A
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 15:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2bf66a32f25so14621441fa.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694181330; x=1694786130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pxjLKjix5Ulb5JMMTkZoNazv5naUWCFmFf+MJlF0QwM=;
 b=nei7sgPnjY7N9a0LtHdbDSCkp5lD7L3hXKE5vhTNLlS6NbBjIqrv4Yg8OqndxztiCY
 siyKiK0Yr0rj/yFeaEwNwuX8BoWUFwIgfr/hT/bUawuLXwG4w9vpdyc4mEaOX5AnkzZR
 i/3JdOrKk9xX35clyWg/YFCPdlnSRgqJV0R2N1wIKhyIboqbTCsqr83Jx8MYI4q6NqZN
 T7qGoq6HeITZTu4PPcgvdpbLzn/23/KEsJz2NBv7f+P/6wR6W1J1cDAc6HUw6SbD3EVH
 y/iEqK/lGrcOTFxSlqcv8Gh5GwanT0E7coG5nq/pMSMA5OyHfPzKqrY6GvAUf/uzGjHu
 9gsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694181330; x=1694786130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxjLKjix5Ulb5JMMTkZoNazv5naUWCFmFf+MJlF0QwM=;
 b=VsVPp3Rt3lvyiyMsN1eZ5bZ2ZSZCCTDBFiAK5bI/AYfUY9v/3Q/citoro3Ex3/d58V
 qoh4/MtFSogFsfq4HjKp1SSMFfJjj5z9P3RfzXSPLgDfaJ8+CudTcfcd3yZm+Bd9nF1v
 dGAcmQI76IIA02tFz7QdfjJPJKag4Ta6Sfws0x6v9nd8M4wDhn3w/IM5xjKNYfDGS/fA
 UE7m/86Fx90Poimygqj1PUclSeFM+jLRKyrhJiqnHz+0ZyCKc0+3rWq/HiCR/62KoN40
 9k2v6d6Beqx2EJfYS0YvSYGVuFQ2p+GebSiHg0TgyeVwUeHgyTfsWLhTtB9H/AjSg9Wq
 3YHQ==
X-Gm-Message-State: AOJu0Yy1Qg+CAwGZItAkfGYk4f4iDsYeAQYAWS1d8kSEemWyZB4WWvtj
 kPrq0u4vnl+Xd+IfMI1vRIexP76FfF5jIncLzSF4tg==
X-Google-Smtp-Source: AGHT+IFdL/GJqkb8Djnm4rG490Zndlb2IRpfNmYT0SHlbIPhv5atlvwgB1XTQ/shKBDR/fd/jV3QQQ==
X-Received: by 2002:a2e:980b:0:b0:2bd:14cc:ab1b with SMTP id
 a11-20020a2e980b000000b002bd14ccab1bmr1847346ljj.44.1694181328883; 
 Fri, 08 Sep 2023 06:55:28 -0700 (PDT)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a2e9f0e000000b002bcbae4c21fsm306907ljk.50.2023.09.08.06.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 06:55:28 -0700 (PDT)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de,
 Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
Date: Fri,  8 Sep 2023 19:53:05 +0600
Message-Id: <20230908135320.7066-1-maxim.uvarov@linaro.org>
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

Before apply these patches it  is needed to create lwIP merge into U-Boot:
git subtree add --prefix net/lwip/lwip-external https://git.savannah.nongnu.org/git/lwip.git master --squash
or
create git submodule, depends how it's more easy to maintain external
library.


changelog:
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
 net/lwip/apps/dhcp/lwip-dhcp.c        |  61 ++++
 net/lwip/apps/dns/lwip-dns.c          |  63 ++++
 net/lwip/apps/http/Makefile           |   6 +
 net/lwip/apps/http/lwip-wget.c        | 126 ++++++++
 net/lwip/apps/ping/Makefile           |  12 +
 net/lwip/apps/ping/lwip_ping.c        |  40 +++
 net/lwip/apps/ping/lwip_ping.h        |  15 +
 net/lwip/apps/ping/ping.h             |  19 ++
 net/lwip/apps/tftp/Makefile           |   7 +
 net/lwip/apps/tftp/lwip-tftp.c        | 129 ++++++++
 net/lwip/lwipopts.h                   | 178 +++++++++++
 net/lwip/port/if.c                    | 332 +++++++++++++++++++
 net/lwip/port/include/arch/cc.h       |  38 +++
 net/lwip/port/include/arch/sys_arch.h |  10 +
 net/lwip/port/include/limits.h        |   0
 net/lwip/port/sys-arch.c              |  13 +
 net/net.c                             |  26 +-
 net/wget.c                            | 440 --------------------------
 38 files changed, 1933 insertions(+), 758 deletions(-)
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

