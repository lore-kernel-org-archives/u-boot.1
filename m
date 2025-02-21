Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B19A5C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E7380F67;
	Fri, 21 Feb 2025 21:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gadC2TvH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A3478001F; Fri, 21 Feb 2025 21:43:44 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CBBB807C4
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:43:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-855b09fca35so192293039f.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740170620; x=1740775420; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUnb08PvRU+eBvlp6gbQPw2pDr34iIQoV3C0yHW4sIs=;
 b=gadC2TvH3eWWUSPO80Qx/+mjx9dJo8e3AdbSF2G+/6fp1jk6tIYY4KsekHH8LAZWcF
 FTjikLudAFr2+vdXpdlRo8suuReL8O02b+A+24t2xF0B95HdvO8u+btl94yutW0hCu/h
 Mape6QcLYZqmMOsMzEHhFQkTUX+SHh3Rx8V1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740170620; x=1740775420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUnb08PvRU+eBvlp6gbQPw2pDr34iIQoV3C0yHW4sIs=;
 b=PwwIRyf9azkzpG/8/k3SHMgRGhED2koWcUsWruiQVj7hW8DjyhNyopr03GeMSR58bH
 Z21XChDwX+ZaergHGGYuQTlgjszqYCC/QJPpFitYvcEvxYkTPWHpN3TqQw+Wid+P+w6m
 OOHaTKjw2YFuoYdjwmOMKVQnaQUJpVbyZ9EG6Px9CQGxfudfnfWmGhwCyV5epr9upbse
 /lx1ECZznFDeqQfch6fnG76iKdyzk5eeh5FufZl2ixRKvcHER5dJtKpvGSi0ZXhQ14AK
 FWP0buW8z7gaTzIVfRk2ZsWXFruZbKVTjYWxzYg4iNyGwPY5HmY4HYQ/4BzM1G2KAwsw
 s5cQ==
X-Gm-Message-State: AOJu0YyasBVTIWTTUFK0Ws8CqqtJhAQKOCaRFeC7ihvjb258HHWjkCFi
 V53C3o9yFeNU0Ari0PuWsuTY8obMcckLWHPoFl/NHSrtP63t4d95HWqPI84gPE7auEN0hExqkAM
 =
X-Gm-Gg: ASbGncsU4wwb+fBefBhK6fs3cbp2DCPzczH/oj+c38n3xb8YBRvFpWqFJe74YecImdF
 5z7x/laDZ2WtbdZFPcfT29A31CD9+U1V4zo1hF6o1RWdg5MZd3QUA4PAaDXRl/qF6j9ekkwk8Kr
 7EhApcCTtWIuanRNg1Mlpg+3dNVYD7yW8y2tJOdEt18bcyf5q18YbSXCIrlJBM4NlHxiJSk+FFl
 sI8VmwePVs+KF5pw2t0pYJp+PgazliFSvMrE3vNR9xJ47pajiOmHQ2ogXAewIWDw881q2glNwQ8
 QBKfE7wmdBRw1RLq7fMGYT46Ss8tGlGuk2jvRMe/MSXqKum6E1f1ktW/YQPa0+M=
X-Google-Smtp-Source: AGHT+IEVt5FCHzmgr2gr7POELL+HaQQ3GhhKN1cQizgmtcDfvha1Z4RUFqHI3nibDha9vlezcJmhMQ==
X-Received: by 2002:a05:6602:164b:b0:855:9c88:78a0 with SMTP id
 ca18e2360f4ac-855dac836a4mr562099539f.9.1740170620587; 
 Fri, 21 Feb 2025 12:43:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eeb6780bb4sm1663476173.131.2025.02.21.12.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:43:39 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [u-boot-test-hooks PATCH 2/2] labgrid-sjg: Add systemd scripts
Date: Fri, 21 Feb 2025 13:43:02 -0700
Message-ID: <20250221204329.677953-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250221204329.677953-1-sjg@chromium.org>
References: <20250221204329.677953-1-sjg@chromium.org>
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

Add example scripts to start the coordinator and exporter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 labgrid-sjg/labgrid-coordinator.service | 14 ++++++++++++++
 labgrid-sjg/labgrid-exporter.service    | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 labgrid-sjg/labgrid-coordinator.service
 create mode 100644 labgrid-sjg/labgrid-exporter.service

diff --git a/labgrid-sjg/labgrid-coordinator.service b/labgrid-sjg/labgrid-coordinator.service
new file mode 100644
index 0000000..baabfb3
--- /dev/null
+++ b/labgrid-sjg/labgrid-coordinator.service
@@ -0,0 +1,14 @@
+[Unit]
+Description=Labgrid Coordinator
+After=network.target
+
+[Service]
+Environment="PYTHONUNBUFFERED=1"
+ExecStart=/home/labgrid/.local/bin/labgrid-coordinator
+Restart=on-failure
+User=labgrid
+StateDirectory=labgrid-coordinator
+WorkingDirectory=/home/labgrid/labgrid-coordinator
+
+[Install]
+WantedBy=multi-user.target
diff --git a/labgrid-sjg/labgrid-exporter.service b/labgrid-sjg/labgrid-exporter.service
new file mode 100644
index 0000000..e3339e7
--- /dev/null
+++ b/labgrid-sjg/labgrid-exporter.service
@@ -0,0 +1,22 @@
+[Unit]
+Description=Labgrid Exporter
+After=network-online.target
+Wants=network-online.target
+
+[Service]
+Environment="PYTHONUNBUFFERED=1"
+Environment=HDCTOOLS=/vid/software/devel/ubtest/standalone-hdctools LG_COORDINATOR=kea:20408 PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/vid/software/devel/ubtest/standalone-hdctools
+PassEnvironment=HDCTOOLS LG_COORDINATOR PATH
+ExecStart=/home/labgrid/.local/bin/labgrid-exporter /vid/software/devel/ubtest/lab/cfg/kea_export.yaml
+
+Restart=on-failure
+RestartForceExitStatus=100
+RestartSec=30
+User=labgrid
+WorkingDirectory=/home/labgrid/labgrid-exporter
+
+# Adjust to your distribution (most often "dialout" or "tty")
+SupplementaryGroups=dialout plugdev
+
+[Install]
+WantedBy=multi-user.target
-- 
2.43.0

