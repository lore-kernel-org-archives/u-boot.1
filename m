Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5A6C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A32988640;
	Fri, 24 May 2024 18:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j5d7Q4R0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A87188869; Fri, 24 May 2024 18:21:05 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A83088552
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4202c1d19d5so63555815e9.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567661; x=1717172461; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aN/OGmhcHxzLji0Q9EVY/Mqvytb+m0Y4/G9d9Y3TYLI=;
 b=j5d7Q4R0q4Pzf/B12Rm94b0YS3xN4oy3Ori8kHXohROcOEZ0yxj2/l/qEPX/oHDyw1
 qcuI9ntGRKapGDWvLJKqK7ZA7BSY9WqnRA6emBQhT4JSHX7I817mXJ/S8ogi8T5T/JV9
 0CLDpkdKwirlte9V8P7yADKlAH4P2gZsgvv8yBqr+1wvE3ou7SUMer0xBBi6GQ3ZRH/J
 yUU0XWbyMzQaad+bWEKGfoHr06AjvdiEtzdwZIFZBEgJ2jwaYG5edX1LFdFnvMC3v2Ky
 JMACylhoM3NI/DHyEevtg5DcivNW6hqj+7fsZaZAONikZBx5gCVqHsH8hWHuDhVxH/TM
 cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567661; x=1717172461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aN/OGmhcHxzLji0Q9EVY/Mqvytb+m0Y4/G9d9Y3TYLI=;
 b=WV3xBil3jmZQQKbP05FCV8u6s7Qs+hfo3bj+j7V12iLf+2cp/v9OpShNE8kHrO2+UQ
 RQuVyUIWnaAi77pi8TG02BW9obmnkydRGutYMSzB/PELo8dBvgVc+fSrkUd5ybxO1dP7
 I9N/GmO7IXMNRIpqDKxKvWXItTidm//zkv4zza/BS+QQohoIBRmHr1riiZQhd7SAn1ie
 Mfl8sLbBMbRT7FWX2PFF9mA1Ib1SrbnvE6Q26NU9FdcvZ0d9XLQ/bVz4h1fvqXJzfxhm
 W+BtbTEx6fJVUDlkyhgctDrqGeJrQl5pXAoubL+7m+Bhu3qhedm74owz9MMg9sQIZkKj
 0AWw==
X-Gm-Message-State: AOJu0Yz5iJE9otAABZNUGWAi1N73PUyo24v3WQBjnX5S4oynARs4FT0T
 aN2t8GJiNbsY/2hgDddWe3yhTGMCE3hT6GbQTWUkZYZ+MANR+2pghsVhTsSF/XAgIzVjPbdu5ZJ
 W4txUyo2j
X-Google-Smtp-Source: AGHT+IHoXw+SlmUbCeRaS5jwCxkiq5II8+vBbANtPLybZaPwAb1LIcHrnbqY47gpuQ+2VIbAejLsIw==
X-Received: by 2002:a05:600c:4592:b0:41a:bdaf:8c78 with SMTP id
 5b1f17b1804b1-421089b2201mr24621355e9.8.1716567660710; 
 Fri, 24 May 2024 09:21:00 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:21:00 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH v2 00/14] Introduce the lwIP network stack
Date: Fri, 24 May 2024 18:19:54 +0200
Message-Id: <cover.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
library for the network stack" [1]. The goal is to introduce the lwIP TCP/IP
stack [2] [3] as an alternative to the current implementation in net/,
selectable with Kconfig, and ultimately keep only lwIP if possible. Some
reasons for doing so are:
- Make the support of HTTPS in the wget command easier. Javier T. (CC'd)
has some additional lwIP and Mbed TLS patches to do so. With that it
becomes possible to fetch and launch a distro installer such as Debian
etc. directly from the U-Boot shell.
- Possibly benefit from additional features implemented in lwIP
- Less code to maintain in U-Boot

The first patch introduces a new Kconfig symbol: NET_LWIP, which selects
the lwIP implementation instead of the current one (NET). Contrary to the
approach chosen by Maxim in [1], NET_LWIP and NET cannot be enabled
simultaneously. The rationale is we want to start from a clean state and
not pull potentially duplicated functionality from both stacks. Note
however that a few files are still built in net/, they are the ones
related to ethernet device management and the ethernet bootflow.

The second patch imports the lwIP code as a Git subtree under
lib/lwip/lwip. Some glue code is added under lib/lwip/u-boot.

The third patch introduces the Makefile to build lwIP when
CONFIG_NET_LWIP=y.

The subsequent patches implement various network-oriented commands and
features: dhcp, dns, ping, tftpboot, wget.

NET_LWIP is not enabled by default because it lacks functionality compared
to NET and many CI tests would fail to run or even build.

Some tests (dm dsa/eth) are disabled when NET_LWIP is selected because
they make strong assumptions on how the network stack is implemented and
how the packet flow occurs. For example, an ARP exchange is expected
when an ICMP packet goes out, but with lwIP no exchange will occur if the
host IP is already in the the ARP cache.

Due to the above and in order to provide some level of testing, a new QEMU
configuration is introduced (qemu_arm64_lwip_defconfig) which is the same
as qemu_arm64_lwip_defconfig but with NET_LWIP and CMD_*_LWIP enabled.
Tests are added to test/py/tests/test_net.py for that configuration.

Changes in v2:

** Address comments from Ilias A.

- "net-lwip: add wget command"
Implement the wget_with_dns() function to do most of the wget work and
call it from do_wget(). This allows to simplify patch "net-lwip: add
support for EFI_HTTP_BOOT".

- "net-lwip: import net command from cmd/net.c"
Move a few functions from cmd/net.c to a new file cmd/net-common.c
rather than duplicating then in cmd/net-lwip.c.

- "net-lwip: add support for EFI_HTTP_BOOT"
Since wget_with_dns() is now implemented in "net-lwip: add wget command",
just enable the wget command when the lwIP stack is enabled and
EFI_HTTP_BOOT is requested.

** Address comments from Tom R.

- "net-lwip: add DHCP support and dhcp commmand",
  "net-lwip: add TFTP support and tftpboot command",
  "net-lwip: add ping command",
  "net-lwip: add dns command",
  "net-lwip: add wget command"
Do not introduce new CMD_XXX_LWIP symbols and use existing CMD_XXX
instead.

- "configs: add qemu_arm64_lwip_defconfig"
Use #include <configs/qemu_arm64_defconfig>.

- "net-lwip: import lwIP library under lib/lwip"
Patch removed and replaced by the introduction of a Git subtree:
"Squashed 'lib/lwip/lwip/' content from commit 0a0452b2c3".

Note that I have not yet addressed your comments on "test: dm: dsa,
eth: disable tests when CONFIG_NET_LWIP=y"). I need some more time
for that and I think running CI on this v2 will help better understand
what is needed for v3.

** Miscellaneous improvements

- "net: introduce alternative implementation as net-lwip/":

* Make DFU_OVER_TFTP not DFU_TFTP incompatible with NET_LWIP. It seems
quite natural to supplement "depends on NET" with "&& !NET_LWIP".
* Make PROT_*_LWIP not visible by removing the Kconfig prompt.


[1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro.org/
[2] https://www.nongnu.org/lwip/
[3] https://en.wikipedia.org/wiki/LwIP

CC: Javier Tia <javier.tia@linaro.org>

Jerome Forissier (14):
  net: introduce alternative implementation as net-lwip/
  Squashed 'lib/lwip/lwip/' content from commit 0a0452b2c39
  net-lwip: build lwIP
  net-lwip: add DHCP support and dhcp commmand
  net-lwip: add TFTP support and tftpboot command
  net-lwip: add ping command
  net-lwip: add dns command
  net-lwip: add wget command
  test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=y
  cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
  configs: add qemu_arm64_lwip_defconfig
  test/py: net: add _lwip variants of dhcp, ping and tftpboot tests
  MAINTAINERS: net-lwip: add myself as a maintainer
  CI: add qemu_arm64_lwip to the test matrix

-- 
2.40.1
