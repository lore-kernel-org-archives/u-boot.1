Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0E6C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DB881F32;
	Fri, 14 Mar 2025 22:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bb8csBbN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF8481FC7; Fri, 14 Mar 2025 22:55:48 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FFB81F0B
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so985215e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989345; x=1742594145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zsjXFDRS2kqtQzH+Ub/djx9Un2Dl63XcWyL/JX9cgDc=;
 b=bb8csBbN2Dd4K29EELAdvYMybkyrG0m5xF1kn9g3iuxuKb0IN+sLEypOIgIpE8CvdT
 CU1VbePhOZl/0K3omXUJAZv6zzGctSfzpUnVc7T5ltW6iZgP+NLkT/KYJuC6MDyBM/06
 rIebErfp0ZIY898AsZrCd+OBLbIgZYeaUoEmSGw9ywDXvbVxbk3jukLlFIo7sOeKMW1d
 gjJ8si17ioQQqIJtsQj19maRiiUY1Wh7CX2O9I/YmDK097nXb5+9oPAdhD7JymNBwZz9
 cE5d1AxXJircqapcR7b4jMAPOM1rlyyhvZzSnt+uiQwPowZzHlFILiddd7LksN5ZRIqG
 qxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989345; x=1742594145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zsjXFDRS2kqtQzH+Ub/djx9Un2Dl63XcWyL/JX9cgDc=;
 b=MdDimuUKPx69yDnqO/BTsB0HS86JW6wmmM5ocodSnMKuGrNZca5DP3Yz1mhgfzaVFY
 piroCn6bNhQKIsSt1LVpjDPrlCSR7+MtJDCOtSElBF23YsIzieWXypep/XdotAmdVMF4
 aONlcud347EvOKZNr4CtOsA2gUkKNr/E0DUSIELSLDrWw2wBtU+PKJV3W4M8oqvc5ucw
 VWlceDnVAyJv8Q1RUNtQt9+Y+DzRerCghLyBVr+Xq2Y1DeJxidAt5ZXFQPbd16GGVPLO
 vIoeSKfoSCY2/PMxjQSbkKIq5CRaJFCs4QR9M+4tPaITMOREI1EPh66Tuxa3xohaa+xU
 17IA==
X-Gm-Message-State: AOJu0YwUyraaCjn1VW98cEN3aG7E5LEuWrdHgIXWM7uFkO6u2F25t2vi
 kh37La65vHtWxLXvMkQGqtr7w1LoT8EkCUAnhmi+sftsHGMAp7lE+UqHyFZdkwJzMc2yacmILfC
 BCig=
X-Gm-Gg: ASbGncvcD2RjD+6Trp6Mk1Ab/shKplJS4kV0KpEYx0cW1gS/SV6a3AXLpEDEaJ6/SYz
 thpYxx2niACNmVzkk6Bm1mCtl0EHrQ7f2QALXyxLNUZbmfMQ7kTwwYaz+dl9+Q9y8Qpe4Rb43Mq
 D8XmWVAC4SUI9w8jK8Rq5iMmWb60Q7DRJ1RdgAfe0LLgFsjnQQNXRdSwub7ah5Q8Tz7rmeN/h3r
 yyI3twfk4J3YRTtXU4/mqWCVHvdgteAPHpmImxTEmGmtxkW4IWs4x/w74Zdee1dLaDesDIG1Lk7
 wcltQJ3PL5/N9uKAQPKNppGPHfpQ9S93/Hm0vInTtZ7VixreMwOKgA==
X-Google-Smtp-Source: AGHT+IGn3h8bQM007Mi3+eSiAwmDETVXl2dbyFNXUXfr2d88Td8w4mNt9MV+pRRZs9P2ce9sNsEltg==
X-Received: by 2002:a05:600c:3591:b0:439:8878:5029 with SMTP id
 5b1f17b1804b1-43d1f1d26cdmr53139105e9.2.1741989345332; 
 Fri, 14 Mar 2025 14:55:45 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>
Subject: [PATCH 00/12] lwIP sandbox tests
Date: Fri, 14 Mar 2025 22:55:02 +0100
Message-ID: <20250314215525.579655-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
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

This series enables most of the driver model tests for network features
with NET_LWIP (test/dm/eth.c and test/dm/dsa.c).
- Patches 1-5 fix a few bugs (device selection) and add missing features
(sandbox timer, restart support) to NET_LWIP
- Patch 6 decouples the sandbox ethernet driver from NET
- Patch 7 adds missing static IP addresses that NET_LWIP needs
- Patches 8 and 9 update the tests to use a common interface to send
  ICMP packets (do_ping(...) instead of net_loop(PING))
- Patch 10 enables DM_DSA and the associated tests with NET_LWIP
- Patch 11 adds a sandbox64 configuration with NET_LWIP=y
- Patch 12 adds that configuration to the CI

Jerome Forissier (12):
  net: lwip: do_ping() should return CMD_RET_FAILURE when no device
  net: lwip: fix initialization sequence before a command
  net: lwip: provide net_start_again()
  net: lwip: add restart support to ping
  net: lwip: use timer_early_get_count() when CONFIG_SANDBOX_TIMER=y
  drivers: net: sandbox: add support for NET_LWIP
  sandbox: provide static IP addresses for eth{2,3,5,6,7}
  net: ping: make do_ping() available via <net.h>
  test: dm: eth, dsa: update tests for NET_LWIP
  net: lwip: allow DM_DSA=y when NET_LWIP=y
  configs: add sandbox64_lwip_defconfig
  CI: add sandbox64_lwip

 .azure-pipelines.yml             |   2 +
 .gitlab-ci.yml                   |  11 ++
 board/sandbox/sandbox.env        |   5 +
 cmd/net.c                        |   3 +-
 configs/sandbox64_lwip_defconfig |   5 +
 drivers/net/Kconfig              |  14 +-
 drivers/net/Makefile             |   1 -
 drivers/net/sandbox-lwip.c       |  85 -----------
 drivers/net/sandbox.c            | 240 ++++++++++++++++++++-----------
 include/net-common.h             |  15 ++
 include/net-legacy.h             |   3 -
 include/net-lwip.h               |  10 +-
 net/Makefile                     |   2 +-
 net/lwip/dhcp.c                  |   3 +-
 net/lwip/dns.c                   |   3 +-
 net/lwip/net-lwip.c              |  86 +++++++++--
 net/lwip/ping.c                  |  13 +-
 net/lwip/tftp.c                  |   5 +-
 net/lwip/wget.c                  |   6 +-
 test/dm/Makefile                 |   2 -
 test/dm/dsa.c                    |   8 +-
 test/dm/eth.c                    |  77 +++++-----
 22 files changed, 351 insertions(+), 248 deletions(-)
 create mode 100644 configs/sandbox64_lwip_defconfig
 delete mode 100644 drivers/net/sandbox-lwip.c

-- 
2.43.0

