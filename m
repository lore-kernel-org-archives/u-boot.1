Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A047FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223C188836;
	Wed, 22 May 2024 18:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E7ok8SfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDEBF8884D; Wed, 22 May 2024 18:01:09 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B4D88823
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:01:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a59b49162aeso989464366b.3
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393666; x=1716998466; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BtCWsxTKbrFoVgXxCqac1uM/yQmykG/8abjoSm1izUo=;
 b=E7ok8SfI+nkbmrn3TpXW7JHP7xGD9hFOrZKB76SBxYPz5dFr8YunoNAntdlk47KJ/r
 PuCwfPMFQ+7nTn+Dhn1N6vlQHo2UvPaWYV9y/Mm9bYfeACXWQKmxgbZIPxBrN0eIhcMh
 eynJOd11SJxwYI10dC3xVDBM+0JgroHOw6AO5Mh8UAm8O9IbPd3huEZrgE8LqgU7o68n
 o8ysKv8fanIDD/Vj93KfQ4yaoHF4Gwe7lWa4vorexVkSRUQdppZypG8cOrZqS3c4ox3D
 50jcaS4xZ3FP2SODD0D0Ws7iJ8SkXfAPhOPhJsdQLL41RK7NuxM4J+ksI65LK7su2i6J
 IgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393666; x=1716998466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BtCWsxTKbrFoVgXxCqac1uM/yQmykG/8abjoSm1izUo=;
 b=wA4Nd24COVngc3F3uGCJVaKUAAWLuLFASld19G1E6EgC/FgvdhYSLssWt0snqxMQhj
 JoPbFtqnlJmMcIJVjWNh9EK3r5pjq4XMSjk0l1EBA+WApU+QpZboIHz1RhdDLmC2MQTr
 S66vzjA5Jlotou6PQDvMabj/4TJxwhPamwfYg057yaX1iTHuNM37NuGy7cQDMbFfjhZT
 HL5meZkZdxxGJNQ/v3aTWkQZ/K2EX2BKic35CRhWS3j+ybP1RuSt19QDGCXMlkcRFuuY
 mVUli3iABQOBRlA8SECc6cRu+9j98Yeo21/CT61qJW+903GQo2p+1qV+mbMLkmOk1I+5
 iooA==
X-Gm-Message-State: AOJu0YzOKhmTIjj2sLz1579AqL6c/ldlWKppJJ5EKFRiOPr5yMqUSLze
 DG58CocGY+4wGf3GDNEIWCm+pHJu3MUlE68HIU/+qLddxOdIEkWoDUMB97nP0EHs5MT16EagkwK
 FFQF73Q==
X-Google-Smtp-Source: AGHT+IGvTZIoJFPLcWBwJ2CuDa6oHUrrtBZh6YFfppm96eeBrCtonS7EvkPCnH1yPQ9Ukg17dS5Upg==
X-Received: by 2002:a17:906:f14d:b0:a5a:1b61:d94d with SMTP id
 a640c23a62f3a-a622806b701mr173092866b.3.1716393665579; 
 Wed, 22 May 2024 09:01:05 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.01.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:01:05 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 00/15] Introduce the lwIP network stack
Date: Wed, 22 May 2024 18:00:00 +0200
Message-Id: <cover.1716300366.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
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
however that a few files are still built in net/, they are the ones related
to ethernet device management and the ethernet bootflow.

The second patch imports the lwIP code under lib/lwip. There is no change
made to the code itself so upgrading to newer versions should be trivial.
The code could be imported as a Git subtree if that's preferred.

The subsequent patches implement various network-oriented commands and
features: dhcp, dns, ping, tftpboot, wget. The commands have their own
Kconfig symbol suffixed with _LWIP. For example CMD_PING_LWIP is the
equivalent of CMD_PING but using the lwIP stack. Again this is meant to
avoid pulling any unwanted code.

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
The series passes the CI tests on GitHub [4].

Regarding the size of the U-Boot binary, I compared various builds using
the command:

 linux/scripts/bloat-o-meter A/u-boot B/u-boot | \
     grep -E "(add/remove|Total:)"

- Comparing default configs (some features that are enabled by default when
lwIP is not used but not supported with lwIP are disabled manually)
(A) master branch, qemu_arm64_defconfig BOOTP_PXE=n CMD_MII=n DFU_TFTP=n
(B) this series, qemu_arm64_lwip_defconfig 

 add/remove: 167/161 grow/shrink: 5/11 up/down: 22335/-19971 (2364)
 Total: Before=811018, After=813382, chg +0.29%

- With all the supported network commands enabled (dhcp + dns + ping +
tftpboot + wget)
(A) master branch, qemu_arm64_defconfig BOOTP_PXE=n CMD_MII=n DFU_TFTP=n
                                        CMD_DNS=y CMD_WGET=y
(B) this series, qemu_arm64_lwip_defconfig CMD_DNS_LWIP=y CMD_WGET_LWIP=y

 add/remove: 303/218 grow/shrink: 8/11 up/down: 48655/-26686 (21969)
 Total: Before=818017, After=839986, chg +2.69%

[1] https://lore.kernel.org/all/20231127125726.3735-1-maxim.uvarov@linaro.org/
[2] https://www.nongnu.org/lwip/
[3] https://en.wikipedia.org/wiki/LwIP
[4] https://github.com/u-boot/u-boot/pull/531

CC: Javier Tia <javier.tia@linaro.org>

Jerome Forissier (15):
  net: introduce alternative implementation as net-lwip/
  net-lwip: import lwIP library under lib/lwip
  net-lwip: add DHCP support and dhcp commmand
  net-lwip: add TFTP support and tftpboot command
  net-lwip: add ping command
  net-lwip: add dns command
  net-lwip: add wget command
  net-lwip: import net command from cmd/net.c
  net-lwip: add support for EFI_HTTP_BOOT
  test: dm: dsa, eth: disable tests when CONFIG_NET_LWIP=y
  cmd: bdinfo: enable -e when CONFIG_CMD_NET_LWIP=y
  configs: add qemu_arm64_lwip_defconfig
  test/py: net: add _lwip variants of dhcp, ping and tftpboot tests
  MAINTAINERS: net-lwip: add myself as a maintainer
  CI: add qemu_arm64_lwip to the test matrix

 .azure-pipelines.yml                          |    7 +
 Kconfig                                       |    2 +
 MAINTAINERS                                   |   11 +
 Makefile                                      |    3 +-
 boot/Kconfig                                  |    3 +
 boot/bootmeth_efi.c                           |    3 +-
 cmd/Kconfig                                   |   44 +
 cmd/Makefile                                  |    4 +
 cmd/bdinfo.c                                  |    5 +-
 cmd/efidebug.c                                |    8 +-
 cmd/net-lwip.c                                |  143 +
 common/Kconfig                                |    2 +-
 common/board_r.c                              |    4 +-
 common/spl/Kconfig                            |    1 +
 configs/qemu_arm64_lwip_defconfig             |   70 +
 drivers/dfu/Kconfig                           |    4 +-
 drivers/fastboot/Kconfig                      |    4 +-
 drivers/net/Kconfig                           |    2 +-
 drivers/net/phy/Kconfig                       |    2 +-
 drivers/usb/gadget/Kconfig                    |    2 +-
 include/config_distro_bootcmd.h               |    2 +-
 include/net-lwip.h                            |  140 +
 include/net.h                                 |    2 +-
 lib/Makefile                                  |    2 +
 lib/efi_loader/Kconfig                        |    5 +-
 lib/lwip/Makefile                             |   57 +
 lib/lwip/README                               |    6 +
 lib/lwip/api/api_lib.c                        | 1367 ++++++
 lib/lwip/api/api_msg.c                        | 2177 +++++++++
 lib/lwip/api/err.c                            |  115 +
 lib/lwip/api/if_api.c                         |  102 +
 lib/lwip/api/netbuf.c                         |  250 +
 lib/lwip/api/netdb.c                          |  422 ++
 lib/lwip/api/netifapi.c                       |  380 ++
 lib/lwip/api/sockets.c                        | 4205 +++++++++++++++++
 lib/lwip/api/tcpip.c                          |  706 +++
 lib/lwip/apps/http/http_client.c              |  911 ++++
 lib/lwip/apps/tftp/tftp.c                     |  548 +++
 lib/lwip/core/altcp.c                         |  717 +++
 lib/lwip/core/altcp_alloc.c                   |   87 +
 lib/lwip/core/altcp_tcp.c                     |  578 +++
 lib/lwip/core/def.c                           |  263 ++
 lib/lwip/core/dns.c                           | 1657 +++++++
 lib/lwip/core/inet_chksum.c                   |  608 +++
 lib/lwip/core/init.c                          |  387 ++
 lib/lwip/core/ip.c                            |  167 +
 lib/lwip/core/ipv4/acd.c                      |  557 +++
 lib/lwip/core/ipv4/autoip.c                   |  379 ++
 lib/lwip/core/ipv4/dhcp.c                     | 1999 ++++++++
 lib/lwip/core/ipv4/etharp.c                   | 1251 +++++
 lib/lwip/core/ipv4/icmp.c                     |  407 ++
 lib/lwip/core/ipv4/igmp.c                     |  801 ++++
 lib/lwip/core/ipv4/ip4.c                      | 1166 +++++
 lib/lwip/core/ipv4/ip4_addr.c                 |  323 ++
 lib/lwip/core/ipv4/ip4_frag.c                 |  894 ++++
 lib/lwip/core/ipv6/dhcp6.c                    |  821 ++++
 lib/lwip/core/ipv6/ethip6.c                   |  123 +
 lib/lwip/core/ipv6/icmp6.c                    |  425 ++
 lib/lwip/core/ipv6/inet6.c                    |   53 +
 lib/lwip/core/ipv6/ip6.c                      | 1494 ++++++
 lib/lwip/core/ipv6/ip6_addr.c                 |  355 ++
 lib/lwip/core/ipv6/ip6_frag.c                 |  862 ++++
 lib/lwip/core/ipv6/mld6.c                     |  626 +++
 lib/lwip/core/ipv6/nd6.c                      | 2474 ++++++++++
 lib/lwip/core/mem.c                           | 1017 ++++
 lib/lwip/core/memp.c                          |  447 ++
 lib/lwip/core/netif.c                         | 1855 ++++++++
 lib/lwip/core/pbuf.c                          | 1545 ++++++
 lib/lwip/core/raw.c                           |  673 +++
 lib/lwip/core/stats.c                         |  168 +
 lib/lwip/core/sys.c                           |  148 +
 lib/lwip/core/tcp.c                           | 2696 +++++++++++
 lib/lwip/core/tcp_in.c                        | 2184 +++++++++
 lib/lwip/core/tcp_out.c                       | 2257 +++++++++
 lib/lwip/core/timeouts.c                      |  451 ++
 lib/lwip/core/udp.c                           | 1321 ++++++
 lib/lwip/include/compat/posix/arpa/inet.h     |   33 +
 lib/lwip/include/compat/posix/net/if.h        |   36 +
 lib/lwip/include/compat/posix/netdb.h         |   33 +
 lib/lwip/include/compat/posix/sys/socket.h    |   33 +
 lib/lwip/include/compat/stdc/errno.h          |   33 +
 lib/lwip/include/lwip/acd.h                   |  109 +
 lib/lwip/include/lwip/altcp.h                 |  207 +
 lib/lwip/include/lwip/altcp_tcp.h             |   72 +
 lib/lwip/include/lwip/altcp_tls.h             |  196 +
 lib/lwip/include/lwip/api.h                   |  434 ++
 lib/lwip/include/lwip/apps/FILES              |    2 +
 .../include/lwip/apps/altcp_proxyconnect.h    |   79 +
 .../lwip/apps/altcp_tls_mbedtls_opts.h        |  111 +
 lib/lwip/include/lwip/apps/fs.h               |  139 +
 lib/lwip/include/lwip/apps/http_client.h      |  160 +
 lib/lwip/include/lwip/apps/httpd.h            |  256 +
 lib/lwip/include/lwip/apps/httpd_opts.h       |  416 ++
 lib/lwip/include/lwip/apps/lwiperf.h          |  109 +
 lib/lwip/include/lwip/apps/mdns.h             |  154 +
 lib/lwip/include/lwip/apps/mdns_domain.h      |   80 +
 lib/lwip/include/lwip/apps/mdns_opts.h        |  121 +
 lib/lwip/include/lwip/apps/mdns_out.h         |  138 +
 lib/lwip/include/lwip/apps/mdns_priv.h        |  237 +
 lib/lwip/include/lwip/apps/mqtt.h             |  205 +
 lib/lwip/include/lwip/apps/mqtt_opts.h        |  103 +
 lib/lwip/include/lwip/apps/mqtt_priv.h        |  104 +
 lib/lwip/include/lwip/apps/netbiosns.h        |   51 +
 lib/lwip/include/lwip/apps/netbiosns_opts.h   |   66 +
 lib/lwip/include/lwip/apps/smtp.h             |  128 +
 lib/lwip/include/lwip/apps/smtp_opts.h        |   80 +
 lib/lwip/include/lwip/apps/snmp.h             |  145 +
 lib/lwip/include/lwip/apps/snmp_core.h        |  377 ++
 lib/lwip/include/lwip/apps/snmp_mib2.h        |   78 +
 lib/lwip/include/lwip/apps/snmp_opts.h        |  297 ++
 lib/lwip/include/lwip/apps/snmp_scalar.h      |  113 +
 .../include/lwip/apps/snmp_snmpv2_framework.h |   32 +
 lib/lwip/include/lwip/apps/snmp_snmpv2_usm.h  |   24 +
 lib/lwip/include/lwip/apps/snmp_table.h       |  134 +
 lib/lwip/include/lwip/apps/snmp_threadsync.h  |  114 +
 lib/lwip/include/lwip/apps/snmpv3.h           |  114 +
 lib/lwip/include/lwip/apps/sntp.h             |   81 +
 lib/lwip/include/lwip/apps/sntp_opts.h        |  215 +
 lib/lwip/include/lwip/apps/tftp_client.h      |   50 +
 lib/lwip/include/lwip/apps/tftp_common.h      |  108 +
 lib/lwip/include/lwip/apps/tftp_opts.h        |  106 +
 lib/lwip/include/lwip/apps/tftp_server.h      |   42 +
 lib/lwip/include/lwip/arch.h                  |  402 ++
 lib/lwip/include/lwip/autoip.h                |   90 +
 lib/lwip/include/lwip/debug.h                 |  161 +
 lib/lwip/include/lwip/def.h                   |  156 +
 lib/lwip/include/lwip/dhcp.h                  |  155 +
 lib/lwip/include/lwip/dhcp6.h                 |  104 +
 lib/lwip/include/lwip/dns.h                   |  131 +
 lib/lwip/include/lwip/err.h                   |  117 +
 lib/lwip/include/lwip/errno.h                 |  198 +
 lib/lwip/include/lwip/etharp.h                |  110 +
 lib/lwip/include/lwip/ethip6.h                |   68 +
 lib/lwip/include/lwip/icmp.h                  |  110 +
 lib/lwip/include/lwip/icmp6.h                 |   72 +
 lib/lwip/include/lwip/if_api.h                |   70 +
 lib/lwip/include/lwip/igmp.h                  |  115 +
 lib/lwip/include/lwip/inet.h                  |  188 +
 lib/lwip/include/lwip/inet_chksum.h           |  104 +
 lib/lwip/include/lwip/init.h                  |  100 +
 lib/lwip/include/lwip/init.h.cmake.in         |  100 +
 lib/lwip/include/lwip/ip.h                    |  339 ++
 lib/lwip/include/lwip/ip4.h                   |  109 +
 lib/lwip/include/lwip/ip4_addr.h              |  225 +
 lib/lwip/include/lwip/ip4_frag.h              |  100 +
 lib/lwip/include/lwip/ip6.h                   |   93 +
 lib/lwip/include/lwip/ip6_addr.h              |  372 ++
 lib/lwip/include/lwip/ip6_frag.h              |  144 +
 lib/lwip/include/lwip/ip6_zone.h              |  306 ++
 lib/lwip/include/lwip/ip_addr.h               |  468 ++
 lib/lwip/include/lwip/mem.h                   |   82 +
 lib/lwip/include/lwip/memp.h                  |  155 +
 lib/lwip/include/lwip/mld6.h                  |   99 +
 lib/lwip/include/lwip/nd6.h                   |   90 +
 lib/lwip/include/lwip/netbuf.h                |  116 +
 lib/lwip/include/lwip/netdb.h                 |  150 +
 lib/lwip/include/lwip/netif.h                 |  698 +++
 lib/lwip/include/lwip/netifapi.h              |  161 +
 lib/lwip/include/lwip/opt.h                   | 3595 ++++++++++++++
 lib/lwip/include/lwip/pbuf.h                  |  326 ++
 lib/lwip/include/lwip/priv/altcp_priv.h       |  159 +
 lib/lwip/include/lwip/priv/api_msg.h          |  272 ++
 lib/lwip/include/lwip/priv/mem_priv.h         |   84 +
 lib/lwip/include/lwip/priv/memp_priv.h        |  161 +
 lib/lwip/include/lwip/priv/memp_std.h         |  153 +
 lib/lwip/include/lwip/priv/nd6_priv.h         |  143 +
 lib/lwip/include/lwip/priv/raw_priv.h         |   69 +
 lib/lwip/include/lwip/priv/sockets_priv.h     |  175 +
 lib/lwip/include/lwip/priv/tcp_priv.h         |  523 ++
 lib/lwip/include/lwip/priv/tcpip_priv.h       |  176 +
 lib/lwip/include/lwip/prot/acd.h              |   91 +
 lib/lwip/include/lwip/prot/autoip.h           |   65 +
 lib/lwip/include/lwip/prot/dhcp.h             |  178 +
 lib/lwip/include/lwip/prot/dhcp6.h            |  138 +
 lib/lwip/include/lwip/prot/dns.h              |  140 +
 lib/lwip/include/lwip/prot/etharp.h           |  114 +
 lib/lwip/include/lwip/prot/ethernet.h         |  127 +
 lib/lwip/include/lwip/prot/iana.h             |   97 +
 lib/lwip/include/lwip/prot/icmp.h             |  105 +
 lib/lwip/include/lwip/prot/icmp6.h            |  172 +
 lib/lwip/include/lwip/prot/ieee.h             |   91 +
 lib/lwip/include/lwip/prot/igmp.h             |   90 +
 lib/lwip/include/lwip/prot/ip.h               |   59 +
 lib/lwip/include/lwip/prot/ip4.h              |  131 +
 lib/lwip/include/lwip/prot/ip6.h              |  235 +
 lib/lwip/include/lwip/prot/mld6.h             |   71 +
 lib/lwip/include/lwip/prot/nd6.h              |  274 ++
 lib/lwip/include/lwip/prot/tcp.h              |  100 +
 lib/lwip/include/lwip/prot/udp.h              |   68 +
 lib/lwip/include/lwip/raw.h                   |  143 +
 lib/lwip/include/lwip/sio.h                   |  142 +
 lib/lwip/include/lwip/snmp.h                  |  213 +
 lib/lwip/include/lwip/sockets.h               |  707 +++
 lib/lwip/include/lwip/stats.h                 |  491 ++
 lib/lwip/include/lwip/sys.h                   |  575 +++
 lib/lwip/include/lwip/tcp.h                   |  500 ++
 lib/lwip/include/lwip/tcpbase.h               |   88 +
 lib/lwip/include/lwip/tcpip.h                 |  114 +
 lib/lwip/include/lwip/timeouts.h              |  128 +
 lib/lwip/include/lwip/udp.h                   |  195 +
 lib/lwip/include/netif/bridgeif.h             |  127 +
 lib/lwip/include/netif/bridgeif_opts.h        |   90 +
 lib/lwip/include/netif/etharp.h               |    3 +
 lib/lwip/include/netif/ethernet.h             |   77 +
 lib/lwip/include/netif/ieee802154.h           |  112 +
 lib/lwip/include/netif/lowpan6.h              |   89 +
 lib/lwip/include/netif/lowpan6_ble.h          |   78 +
 lib/lwip/include/netif/lowpan6_common.h       |   82 +
 lib/lwip/include/netif/lowpan6_opts.h         |  122 +
 lib/lwip/include/netif/ppp/ccp.h              |  164 +
 lib/lwip/include/netif/ppp/chap-md5.h         |   36 +
 lib/lwip/include/netif/ppp/chap-new.h         |  200 +
 lib/lwip/include/netif/ppp/chap_ms.h          |   44 +
 lib/lwip/include/netif/ppp/eap.h              |  169 +
 lib/lwip/include/netif/ppp/ecp.h              |   62 +
 lib/lwip/include/netif/ppp/eui64.h            |  102 +
 lib/lwip/include/netif/ppp/fsm.h              |  182 +
 lib/lwip/include/netif/ppp/ipcp.h             |  134 +
 lib/lwip/include/netif/ppp/ipv6cp.h           |  191 +
 lib/lwip/include/netif/ppp/lcp.h              |  179 +
 lib/lwip/include/netif/ppp/magic.h            |  130 +
 lib/lwip/include/netif/ppp/mppe.h             |  181 +
 lib/lwip/include/netif/ppp/polarssl/arc4.h    |   81 +
 lib/lwip/include/netif/ppp/polarssl/des.h     |   92 +
 lib/lwip/include/netif/ppp/polarssl/md4.h     |   97 +
 lib/lwip/include/netif/ppp/polarssl/md5.h     |   96 +
 lib/lwip/include/netif/ppp/polarssl/sha1.h    |   96 +
 lib/lwip/include/netif/ppp/ppp.h              |  698 +++
 lib/lwip/include/netif/ppp/ppp_impl.h         |  736 +++
 lib/lwip/include/netif/ppp/ppp_opts.h         |  610 +++
 lib/lwip/include/netif/ppp/pppapi.h           |  137 +
 lib/lwip/include/netif/ppp/pppcrypt.h         |  144 +
 lib/lwip/include/netif/ppp/pppdebug.h         |   88 +
 lib/lwip/include/netif/ppp/pppoe.h            |  187 +
 lib/lwip/include/netif/ppp/pppol2tp.h         |  209 +
 lib/lwip/include/netif/ppp/pppos.h            |  125 +
 lib/lwip/include/netif/ppp/upap.h             |  131 +
 lib/lwip/include/netif/ppp/vj.h               |  169 +
 lib/lwip/include/netif/slipif.h               |   86 +
 lib/lwip/include/netif/zepif.h                |   81 +
 lib/lwip/netif/ethernet.c                     |  329 ++
 lib/lwip/u-boot/arch/cc.h                     |   43 +
 lib/lwip/u-boot/arch/sys_arch.h               |    0
 lib/lwip/u-boot/limits.h                      |    0
 lib/lwip/u-boot/lwipopts.h                    |  197 +
 net-lwip/Kconfig                              |   61 +
 net-lwip/Makefile                             |   18 +
 net-lwip/dhcp.c                               |  114 +
 net-lwip/dns.c                                |  107 +
 net-lwip/eth_internal.h                       |   35 +
 net-lwip/net-lwip.c                           |  224 +
 net-lwip/ping.c                               |  171 +
 net-lwip/tftp.c                               |  213 +
 net-lwip/wget.c                               |  184 +
 net/Kconfig                                   |    1 +
 net/eth_bootdev.c                             |    2 +-
 test/dm/dsa.c                                 |    2 +
 test/dm/eth.c                                 |    4 +
 test/py/tests/test_net.py                     |   21 +-
 259 files changed, 77765 insertions(+), 26 deletions(-)
 create mode 100644 cmd/net-lwip.c
 create mode 100644 configs/qemu_arm64_lwip_defconfig
 create mode 100644 include/net-lwip.h
 create mode 100644 lib/lwip/Makefile
 create mode 100644 lib/lwip/README
 create mode 100644 lib/lwip/api/api_lib.c
 create mode 100644 lib/lwip/api/api_msg.c
 create mode 100644 lib/lwip/api/err.c
 create mode 100644 lib/lwip/api/if_api.c
 create mode 100644 lib/lwip/api/netbuf.c
 create mode 100644 lib/lwip/api/netdb.c
 create mode 100644 lib/lwip/api/netifapi.c
 create mode 100644 lib/lwip/api/sockets.c
 create mode 100644 lib/lwip/api/tcpip.c
 create mode 100644 lib/lwip/apps/http/http_client.c
 create mode 100644 lib/lwip/apps/tftp/tftp.c
 create mode 100644 lib/lwip/core/altcp.c
 create mode 100644 lib/lwip/core/altcp_alloc.c
 create mode 100644 lib/lwip/core/altcp_tcp.c
 create mode 100644 lib/lwip/core/def.c
 create mode 100644 lib/lwip/core/dns.c
 create mode 100644 lib/lwip/core/inet_chksum.c
 create mode 100644 lib/lwip/core/init.c
 create mode 100644 lib/lwip/core/ip.c
 create mode 100644 lib/lwip/core/ipv4/acd.c
 create mode 100644 lib/lwip/core/ipv4/autoip.c
 create mode 100644 lib/lwip/core/ipv4/dhcp.c
 create mode 100644 lib/lwip/core/ipv4/etharp.c
 create mode 100644 lib/lwip/core/ipv4/icmp.c
 create mode 100644 lib/lwip/core/ipv4/igmp.c
 create mode 100644 lib/lwip/core/ipv4/ip4.c
 create mode 100644 lib/lwip/core/ipv4/ip4_addr.c
 create mode 100644 lib/lwip/core/ipv4/ip4_frag.c
 create mode 100644 lib/lwip/core/ipv6/dhcp6.c
 create mode 100644 lib/lwip/core/ipv6/ethip6.c
 create mode 100644 lib/lwip/core/ipv6/icmp6.c
 create mode 100644 lib/lwip/core/ipv6/inet6.c
 create mode 100644 lib/lwip/core/ipv6/ip6.c
 create mode 100644 lib/lwip/core/ipv6/ip6_addr.c
 create mode 100644 lib/lwip/core/ipv6/ip6_frag.c
 create mode 100644 lib/lwip/core/ipv6/mld6.c
 create mode 100644 lib/lwip/core/ipv6/nd6.c
 create mode 100644 lib/lwip/core/mem.c
 create mode 100644 lib/lwip/core/memp.c
 create mode 100644 lib/lwip/core/netif.c
 create mode 100644 lib/lwip/core/pbuf.c
 create mode 100644 lib/lwip/core/raw.c
 create mode 100644 lib/lwip/core/stats.c
 create mode 100644 lib/lwip/core/sys.c
 create mode 100644 lib/lwip/core/tcp.c
 create mode 100644 lib/lwip/core/tcp_in.c
 create mode 100644 lib/lwip/core/tcp_out.c
 create mode 100644 lib/lwip/core/timeouts.c
 create mode 100644 lib/lwip/core/udp.c
 create mode 100644 lib/lwip/include/compat/posix/arpa/inet.h
 create mode 100644 lib/lwip/include/compat/posix/net/if.h
 create mode 100644 lib/lwip/include/compat/posix/netdb.h
 create mode 100644 lib/lwip/include/compat/posix/sys/socket.h
 create mode 100644 lib/lwip/include/compat/stdc/errno.h
 create mode 100644 lib/lwip/include/lwip/acd.h
 create mode 100644 lib/lwip/include/lwip/altcp.h
 create mode 100644 lib/lwip/include/lwip/altcp_tcp.h
 create mode 100644 lib/lwip/include/lwip/altcp_tls.h
 create mode 100644 lib/lwip/include/lwip/api.h
 create mode 100644 lib/lwip/include/lwip/apps/FILES
 create mode 100644 lib/lwip/include/lwip/apps/altcp_proxyconnect.h
 create mode 100644 lib/lwip/include/lwip/apps/altcp_tls_mbedtls_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/fs.h
 create mode 100644 lib/lwip/include/lwip/apps/http_client.h
 create mode 100644 lib/lwip/include/lwip/apps/httpd.h
 create mode 100644 lib/lwip/include/lwip/apps/httpd_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/lwiperf.h
 create mode 100644 lib/lwip/include/lwip/apps/mdns.h
 create mode 100644 lib/lwip/include/lwip/apps/mdns_domain.h
 create mode 100644 lib/lwip/include/lwip/apps/mdns_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/mdns_out.h
 create mode 100644 lib/lwip/include/lwip/apps/mdns_priv.h
 create mode 100644 lib/lwip/include/lwip/apps/mqtt.h
 create mode 100644 lib/lwip/include/lwip/apps/mqtt_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/mqtt_priv.h
 create mode 100644 lib/lwip/include/lwip/apps/netbiosns.h
 create mode 100644 lib/lwip/include/lwip/apps/netbiosns_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/smtp.h
 create mode 100644 lib/lwip/include/lwip/apps/smtp_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_core.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_mib2.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_scalar.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_snmpv2_framework.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_snmpv2_usm.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_table.h
 create mode 100644 lib/lwip/include/lwip/apps/snmp_threadsync.h
 create mode 100644 lib/lwip/include/lwip/apps/snmpv3.h
 create mode 100644 lib/lwip/include/lwip/apps/sntp.h
 create mode 100644 lib/lwip/include/lwip/apps/sntp_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/tftp_client.h
 create mode 100644 lib/lwip/include/lwip/apps/tftp_common.h
 create mode 100644 lib/lwip/include/lwip/apps/tftp_opts.h
 create mode 100644 lib/lwip/include/lwip/apps/tftp_server.h
 create mode 100644 lib/lwip/include/lwip/arch.h
 create mode 100644 lib/lwip/include/lwip/autoip.h
 create mode 100644 lib/lwip/include/lwip/debug.h
 create mode 100644 lib/lwip/include/lwip/def.h
 create mode 100644 lib/lwip/include/lwip/dhcp.h
 create mode 100644 lib/lwip/include/lwip/dhcp6.h
 create mode 100644 lib/lwip/include/lwip/dns.h
 create mode 100644 lib/lwip/include/lwip/err.h
 create mode 100644 lib/lwip/include/lwip/errno.h
 create mode 100644 lib/lwip/include/lwip/etharp.h
 create mode 100644 lib/lwip/include/lwip/ethip6.h
 create mode 100644 lib/lwip/include/lwip/icmp.h
 create mode 100644 lib/lwip/include/lwip/icmp6.h
 create mode 100644 lib/lwip/include/lwip/if_api.h
 create mode 100644 lib/lwip/include/lwip/igmp.h
 create mode 100644 lib/lwip/include/lwip/inet.h
 create mode 100644 lib/lwip/include/lwip/inet_chksum.h
 create mode 100644 lib/lwip/include/lwip/init.h
 create mode 100644 lib/lwip/include/lwip/init.h.cmake.in
 create mode 100644 lib/lwip/include/lwip/ip.h
 create mode 100644 lib/lwip/include/lwip/ip4.h
 create mode 100644 lib/lwip/include/lwip/ip4_addr.h
 create mode 100644 lib/lwip/include/lwip/ip4_frag.h
 create mode 100644 lib/lwip/include/lwip/ip6.h
 create mode 100644 lib/lwip/include/lwip/ip6_addr.h
 create mode 100644 lib/lwip/include/lwip/ip6_frag.h
 create mode 100644 lib/lwip/include/lwip/ip6_zone.h
 create mode 100644 lib/lwip/include/lwip/ip_addr.h
 create mode 100644 lib/lwip/include/lwip/mem.h
 create mode 100644 lib/lwip/include/lwip/memp.h
 create mode 100644 lib/lwip/include/lwip/mld6.h
 create mode 100644 lib/lwip/include/lwip/nd6.h
 create mode 100644 lib/lwip/include/lwip/netbuf.h
 create mode 100644 lib/lwip/include/lwip/netdb.h
 create mode 100644 lib/lwip/include/lwip/netif.h
 create mode 100644 lib/lwip/include/lwip/netifapi.h
 create mode 100644 lib/lwip/include/lwip/opt.h
 create mode 100644 lib/lwip/include/lwip/pbuf.h
 create mode 100644 lib/lwip/include/lwip/priv/altcp_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/api_msg.h
 create mode 100644 lib/lwip/include/lwip/priv/mem_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/memp_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/memp_std.h
 create mode 100644 lib/lwip/include/lwip/priv/nd6_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/raw_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/sockets_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/tcp_priv.h
 create mode 100644 lib/lwip/include/lwip/priv/tcpip_priv.h
 create mode 100644 lib/lwip/include/lwip/prot/acd.h
 create mode 100644 lib/lwip/include/lwip/prot/autoip.h
 create mode 100644 lib/lwip/include/lwip/prot/dhcp.h
 create mode 100644 lib/lwip/include/lwip/prot/dhcp6.h
 create mode 100644 lib/lwip/include/lwip/prot/dns.h
 create mode 100644 lib/lwip/include/lwip/prot/etharp.h
 create mode 100644 lib/lwip/include/lwip/prot/ethernet.h
 create mode 100644 lib/lwip/include/lwip/prot/iana.h
 create mode 100644 lib/lwip/include/lwip/prot/icmp.h
 create mode 100644 lib/lwip/include/lwip/prot/icmp6.h
 create mode 100644 lib/lwip/include/lwip/prot/ieee.h
 create mode 100644 lib/lwip/include/lwip/prot/igmp.h
 create mode 100644 lib/lwip/include/lwip/prot/ip.h
 create mode 100644 lib/lwip/include/lwip/prot/ip4.h
 create mode 100644 lib/lwip/include/lwip/prot/ip6.h
 create mode 100644 lib/lwip/include/lwip/prot/mld6.h
 create mode 100644 lib/lwip/include/lwip/prot/nd6.h
 create mode 100644 lib/lwip/include/lwip/prot/tcp.h
 create mode 100644 lib/lwip/include/lwip/prot/udp.h
 create mode 100644 lib/lwip/include/lwip/raw.h
 create mode 100644 lib/lwip/include/lwip/sio.h
 create mode 100644 lib/lwip/include/lwip/snmp.h
 create mode 100644 lib/lwip/include/lwip/sockets.h
 create mode 100644 lib/lwip/include/lwip/stats.h
 create mode 100644 lib/lwip/include/lwip/sys.h
 create mode 100644 lib/lwip/include/lwip/tcp.h
 create mode 100644 lib/lwip/include/lwip/tcpbase.h
 create mode 100644 lib/lwip/include/lwip/tcpip.h
 create mode 100644 lib/lwip/include/lwip/timeouts.h
 create mode 100644 lib/lwip/include/lwip/udp.h
 create mode 100644 lib/lwip/include/netif/bridgeif.h
 create mode 100644 lib/lwip/include/netif/bridgeif_opts.h
 create mode 100644 lib/lwip/include/netif/etharp.h
 create mode 100644 lib/lwip/include/netif/ethernet.h
 create mode 100644 lib/lwip/include/netif/ieee802154.h
 create mode 100644 lib/lwip/include/netif/lowpan6.h
 create mode 100644 lib/lwip/include/netif/lowpan6_ble.h
 create mode 100644 lib/lwip/include/netif/lowpan6_common.h
 create mode 100644 lib/lwip/include/netif/lowpan6_opts.h
 create mode 100644 lib/lwip/include/netif/ppp/ccp.h
 create mode 100644 lib/lwip/include/netif/ppp/chap-md5.h
 create mode 100644 lib/lwip/include/netif/ppp/chap-new.h
 create mode 100644 lib/lwip/include/netif/ppp/chap_ms.h
 create mode 100644 lib/lwip/include/netif/ppp/eap.h
 create mode 100644 lib/lwip/include/netif/ppp/ecp.h
 create mode 100644 lib/lwip/include/netif/ppp/eui64.h
 create mode 100644 lib/lwip/include/netif/ppp/fsm.h
 create mode 100644 lib/lwip/include/netif/ppp/ipcp.h
 create mode 100644 lib/lwip/include/netif/ppp/ipv6cp.h
 create mode 100644 lib/lwip/include/netif/ppp/lcp.h
 create mode 100644 lib/lwip/include/netif/ppp/magic.h
 create mode 100644 lib/lwip/include/netif/ppp/mppe.h
 create mode 100644 lib/lwip/include/netif/ppp/polarssl/arc4.h
 create mode 100644 lib/lwip/include/netif/ppp/polarssl/des.h
 create mode 100644 lib/lwip/include/netif/ppp/polarssl/md4.h
 create mode 100644 lib/lwip/include/netif/ppp/polarssl/md5.h
 create mode 100644 lib/lwip/include/netif/ppp/polarssl/sha1.h
 create mode 100644 lib/lwip/include/netif/ppp/ppp.h
 create mode 100644 lib/lwip/include/netif/ppp/ppp_impl.h
 create mode 100644 lib/lwip/include/netif/ppp/ppp_opts.h
 create mode 100644 lib/lwip/include/netif/ppp/pppapi.h
 create mode 100644 lib/lwip/include/netif/ppp/pppcrypt.h
 create mode 100644 lib/lwip/include/netif/ppp/pppdebug.h
 create mode 100644 lib/lwip/include/netif/ppp/pppoe.h
 create mode 100644 lib/lwip/include/netif/ppp/pppol2tp.h
 create mode 100644 lib/lwip/include/netif/ppp/pppos.h
 create mode 100644 lib/lwip/include/netif/ppp/upap.h
 create mode 100644 lib/lwip/include/netif/ppp/vj.h
 create mode 100644 lib/lwip/include/netif/slipif.h
 create mode 100644 lib/lwip/include/netif/zepif.h
 create mode 100644 lib/lwip/netif/ethernet.c
 create mode 100644 lib/lwip/u-boot/arch/cc.h
 create mode 100644 lib/lwip/u-boot/arch/sys_arch.h
 create mode 100644 lib/lwip/u-boot/limits.h
 create mode 100644 lib/lwip/u-boot/lwipopts.h
 create mode 100644 net-lwip/Kconfig
 create mode 100644 net-lwip/Makefile
 create mode 100644 net-lwip/dhcp.c
 create mode 100644 net-lwip/dns.c
 create mode 100644 net-lwip/eth_internal.h
 create mode 100644 net-lwip/net-lwip.c
 create mode 100644 net-lwip/ping.c
 create mode 100644 net-lwip/tftp.c
 create mode 100644 net-lwip/wget.c

-- 
2.40.1

