Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6203DC7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6503F82E27;
	Wed, 25 Jun 2025 15:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P6QDor/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E2682D83; Wed, 25 Jun 2025 15:21:42 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D236182E6A
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a531fcaa05so3125056f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857699; x=1751462499; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRUZlgyGhWY0+dIXcOcI6HdlzXv35uD5CCmSt0KrIfc=;
 b=P6QDor/1FighJQoJxufX7nO6g3NNsLlQDgXQ9gLQ1z0WsBfxsqPhtVqow1Wj0Frvpw
 BQOrwqE0dU/dnUjfr8Fmp/u527yMEiFbG+17AqqSK4BNEgGH0+11Z4t+5G+YKqG0QmK7
 RzO4js9xSmNzqic3ZGFzknWQ5b1y3PGOvamQjh9aPeuyFjz0oje5x7CYeGjO9evLzFbG
 ZcNq1bc0VW/nBTGK4F9EnUcghc9O/fK1XgsUprzJDA1n3vUnYAL7WLgNOs3yJplE/RwZ
 NE2zSaP3OlPeQaLZ8RSSnxJss1OAApCLq+oFtmH8ivWfHSljhd1ob86M4DkJmA/EuEdP
 osWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857699; x=1751462499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JRUZlgyGhWY0+dIXcOcI6HdlzXv35uD5CCmSt0KrIfc=;
 b=bkWNWFAcpT3+5YO8h93b4fqK4ct1nrtvjtLrY79Dkeee+A2kJhzP13/bBhUc9EJX5H
 KPSMH9hWaRLDSl9g7JqWaKbFYyjxEXfRh8efZx9BirtAK3N6xdQUj50EQxF3RJ4ZL81j
 w7zU8GzaKeAmE+ycdDTGrKvSZWaBN/iG6dlI8rHVg8g1XMPvKvwEiqXI8T68VxhiOruU
 muabPIyNHWwVD2JV8w2z9Lnv7t/nVkBALQoI50ox4XEaSaS2pAHDnT8EN38IslY2kKjy
 7a0KugGKwugsNSMxt8CRrx8fki8Qc15drykmqwUAZg/aWl/HVXSzkOdfwrpCf7M8/ZtV
 +mAg==
X-Gm-Message-State: AOJu0Yz/2COIntEq3Z1FXByNdtnb57U323Zkf1kcimdDrUZL5LGzFJ3w
 D6Mg5wPTFiPC6WPMrXK+0bgQEtnPBuk1GIq/2qu7SWNRrWM4I3pkVeYBgdh0544s0Mki4esP61V
 yb/s4N7c=
X-Gm-Gg: ASbGncuErS98YXijxHiJmeLdKLKmsK0D2HGLFksinefYOX/oNP8QIjiNV19YUi60gCr
 ZqaQGw3YW02jN/AkE2UgrmKch2nZ2vjMLIdwWx5xB7oxogQ4i0SnKvSDNYMARcto7lFV2dZRYr6
 FdRGF9J6zZTBa3uncXQVHztyc0Rf9pH+gyXAEjIesRYCB4XAddtwvrekDIXp1SXhO+gVyWZtu3O
 oNXYZo3Q5J60zChaewCmUclBGPigYzUAWycOgh10UdX6wDFdGpjVYHhDo3JvEGjHGXSVCMM6SsC
 9hGzLYoEvPu8zOKt8/5H6Fq2xh2MN2BrrSvRKSenkKbs7CW9CVim1G/ncAviD0C404Ymu7Y=
X-Google-Smtp-Source: AGHT+IHZZ9i1viqlFzPxDpENkGMy9/CdnFY90yqlCaINn1FnZDsBIoMjf1H8qb1iqsOrS1RqY1ztmA==
X-Received: by 2002:a05:6000:4614:b0:3a5:276b:1ec0 with SMTP id
 ffacd0b85a97d-3a6ed65b1d4mr2567505f8f.45.1750857698918; 
 Wed, 25 Jun 2025 06:21:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:38 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Harsha Vardhan V M <h-vm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Jonas Karlman <jonas@kwiboo.se>,
 Maxim Moskalets <maximmosk4@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 12/13] doc: add doc/cmd/sntp.rst and remove doc/README.SNTP
Date: Wed, 25 Jun 2025 15:19:20 +0200
Message-ID: <20250625132108.3292932-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625132108.3292932-1-jerome.forissier@linaro.org>
References: <20250625132108.3292932-1-jerome.forissier@linaro.org>
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

Add a proper documentation file for the sntp command in RST format and
drop doc/README.SNTP. The documentation now includes the NET_LWIP
specificities.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

Changes in v4:
- Fix typo in commit description and s/wget/sntp/ in the doc file

Changes in v3:
- Create a new RST file and delete doc/README.SNTP

Changes in v2:
- New patch

 doc/README.SNTP        | 17 ----------
 doc/usage/cmd/sntp.rst | 72 ++++++++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst    |  1 +
 3 files changed, 73 insertions(+), 17 deletions(-)
 delete mode 100644 doc/README.SNTP
 create mode 100644 doc/usage/cmd/sntp.rst

diff --git a/doc/README.SNTP b/doc/README.SNTP
deleted file mode 100644
index da9ec459ad4..00000000000
--- a/doc/README.SNTP
+++ /dev/null
@@ -1,17 +0,0 @@
-To use SNTP support, add define CONFIG_CMD_SNTP to the
-configuration file of the board.
-
-The "sntp" command gets network time from NTP time server and
-syncronize RTC of the board. This command needs the command line
-parameter of server's IP address or environment variable
-"ntpserverip". The network time is sent as UTC. So if you want to
-set local time to RTC, set the offset in second from UTC to the
-environment variable "time offset".
-
-If the DHCP server provides time server's IP or time offset, you
-don't need to set the above environment variables yourself.
-
-Current limitations of SNTP support:
-1. The roundtrip time is ignored.
-2. Only the 1st NTP server IP, in the option ntp-servers of DHCP, will
-   be used.
diff --git a/doc/usage/cmd/sntp.rst b/doc/usage/cmd/sntp.rst
new file mode 100644
index 00000000000..d97f83053f7
--- /dev/null
+++ b/doc/usage/cmd/sntp.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: sntp (command)
+
+sntp command
+============
+
+Synopsis
+--------
+
+::
+
+    sntp [serverip]
+    sntp [servername]  # NET_LWIP=y && CMD_DNS=y only
+
+
+Description
+-----------
+
+The sntp command gets the current time from an NTP time server and
+syncronizes the Real Time Clock (RTC) of the board. This command needs
+the server's IP address to be given on the command line or via the
+`ntpserverip` environment variable.
+
+The address of the NTP server does not need to be given if the DHCP server
+provides one. The legacy network stack (`CONFIG_NET=y`) can only use the
+first NTP server provided in the `ntp-servers` DHCP option.
+
+When the network stack is lwIP (`CONFIG_NET_LWIP=y`) and the dns command
+is enabled (`CONFIG_CMD_DNS=y`), then the sntp command accepts a server
+name as an argument.
+
+The network time is sent as UTC. So, if you want to set the RTC to any local
+time different from UTC, you need to set the `timeoffset` environment variable.
+
+Round-trip delay compensation is not implemented/not enabled. In practice
+this should not matter much given that the RTC API does not have sub-second
+resolution, and round-trip times are typically 10 to 100 ms at most.
+
+Examples
+--------
+
+::
+
+    => setenv ntpserverip 109.190.177.205
+    => date
+    Date: 2025-06-16 (Monday)    Time: 15:19:35
+    => date reset
+    Reset RTC...
+    Date: 2000-01-01 (Saturday)    Time:  0:00:00
+    => date
+    Date: 2000-01-01 (Saturday)    Time:  0:00:03
+    => sntp
+    Date: 2025-06-16 Time: 15:19:43
+    => date
+    Date: 2025-06-16 (Monday)    Time: 15:19:47
+    => setenv timeoffset 7200
+    => sntp
+    Date: 2025-06-16 Time: 17:19:55
+    => date
+    Date: 2025-06-16 (Monday)    Time: 17:19:57
+
+With `CONFIG_NET_LWIP=y` and `CONFIG_CMD_DNS=y`:
+
+::
+
+    => date reset
+    Reset RTC...
+    Date: 2000-01-01 (Saturday)    Time:  0:00:00
+    => sntp 0.us.pool.ntp.org
+    Date: 2025-06-16 Time: 15:10:59
diff --git a/doc/usage/index.rst b/doc/usage/index.rst
index 372ef56c967..1f2de69b953 100644
--- a/doc/usage/index.rst
+++ b/doc/usage/index.rst
@@ -119,6 +119,7 @@ Shell commands
    cmd/sleep
    cmd/sm
    cmd/smbios
+   cmd/sntp
    cmd/sound
    cmd/source
    cmd/tcpm
-- 
2.43.0

