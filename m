Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263F6C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 10:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 907E782DE7;
	Tue, 17 Jun 2025 12:07:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e6gLQJbD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCEB82C87; Tue, 17 Jun 2025 12:07:56 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9AA82D09
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 12:07:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso2095329f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750154874; x=1750759674; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SB6HMXcM0M2J7NyexF5nDOWYI0PRjQ3rM6w3FJfgp74=;
 b=e6gLQJbDkrK9PwFYrq5Jz1BmZjR7kL2V+p6j5dNuWgNrO/GBg3dqnqs3ZuTngQuChn
 J1MNguIAOE5Bw9ZfuVWHuTa0Q3FKxZohPD5V6lihQGG8tDRyjFoPHgXxKS66SDRDCz97
 2QpjkzieXzlLhGZebjwKd47zx4b4sZIwJ0eNiWOqnCyZQ0mXCgAgEUeQgQLiidRyzmmm
 X0cgfLzsLI743LyiCCPTkeTto6I+uJ7oS26M6u94FFp2KgdmTI6Rxj4PDprWXqMRvmbT
 /YptXnqYIGxVVjdr9fpQGpm3dGYiCiUVCwX+jlSRKTi2g+AdJUQUNz7RYm4X3tMSvqeR
 uT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750154874; x=1750759674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SB6HMXcM0M2J7NyexF5nDOWYI0PRjQ3rM6w3FJfgp74=;
 b=GB6wtHHc4mCuPhFgmSacS0tn4O9jOST0U9X/qiMglgQ5sxkKnWZvAr6Yv+V35gR+ON
 cA5+2t8ZkLNoEJvzMSweY2V6ItqX45Ynsvtpe5HZP1ImdbHyM+jhO4IF96kDyIaGaUTE
 F+f8k3SqS9ZjaWU+XPhMWoCLPnwWZ889E99go9f7NE62HPmqsqfjgISHrkrm1MjnUoH+
 it6sypNWU9wQ0tZKHmBtqhjmuU5Ru+ZxDanrdELymG9yCf2SkW/B1t49HylSPUntM1I0
 P0xHUkAEi0tqG4S8aPZ8G094yGjNz8DXlva6blHbLqpPSZM6ZUOefyP60wMm1gCJIT2v
 nA8A==
X-Gm-Message-State: AOJu0YyB96WNZSzA/MbyVO4HyntwOifpw6sD2IyobM+MkUC3uQqD6n4X
 uY1x/gq6hyBUkK4Kq7fx2pbgtlcHwe+OTZfEZQ8JMMWtdfn2Y0xFlcWlsAEnoJi96Td5siv2aYe
 Zxa4r
X-Gm-Gg: ASbGncujgK0hqLruqPl0it+1EFK3lyxNUoyYvuLmn0Ji5X5+9o8d2oKXFFGlvj7OEdT
 I6lAuCtn0M7FjVDWIIVdsazSfSdoxIbHQ3mC0VdPnC9EdARBvq3tao8QcTXKlz693ldaUfPh//Z
 h8HqrclPduhCwUr1F/WlM/4rp0y3+BfBuKWVZr8CjFu5vyhT66osYV1rJPe9Jo2ZbBRKn5DT9GD
 5qnNGJNWnbyf6SaXwrOvFqGMbDDoSqZJ1IR7XzRy1p8tFB5oXZFUo7wp2BnjvASNqsJsMS18o5L
 mUSiNpyNnYBw+P7ZfRIv58iQ2ojHdGVs2VA984x+RQwEJ3Rd5QbPqwl+bg4lzBkt+2nyL0DTH4N
 UPm8Xpw==
X-Google-Smtp-Source: AGHT+IFS56vi8HK7Yq/oAGu1JQt2k9A3c0hftJBmJgTiLKTJSLi9U7X7cWB8YDiYLUCixkd+9tp7Fw==
X-Received: by 2002:a05:6000:220f:b0:3a5:4b67:5a70 with SMTP id
 ffacd0b85a97d-3a5723977edmr10694069f8f.18.1750154873557; 
 Tue, 17 Jun 2025 03:07:53 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b61071sm13582412f8f.90.2025.06.17.03.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 03:07:53 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Harsha Vardhan V M <h-vm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wang Jie <dave.wang@rock-chips.com>
Subject: [PATCH v3 12/13] doc: add doc/cmd/sntp.rst and remove doc/README.SNTP
Date: Tue, 17 Jun 2025 12:04:02 +0200
Message-ID: <20250617100720.2544758-13-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617100720.2544758-1-jerome.forissier@linaro.org>
References: <20250617100720.2544758-1-jerome.forissier@linaro.org>
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

Add a proper documentation file for the cntp command in RST format and
drop doc/README.SNTP. The documentation now includes the NET_LWIP
specificities.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
- Create a new RST file and delete doc/README.SNTP
---

(no changes since v2)

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
index 00000000000..eab7c664728
--- /dev/null
+++ b/doc/usage/cmd/sntp.rst
@@ -0,0 +1,72 @@
+.. SPDX-License-Identifier: GPL-2.0+:
+
+.. index::
+   single: wget (command)
+
+wget command
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

