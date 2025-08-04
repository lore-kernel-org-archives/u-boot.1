Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA3AC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 12:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01B283E18;
	Mon,  4 Aug 2025 14:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dhu1vIiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94FAE83F42; Mon,  4 Aug 2025 14:51:27 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1576583E04
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 14:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45994a72356so11207535e9.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754311884; x=1754916684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pba1Jle9Vkm6yQmsiD5vif51gvj4WldLhrjFF1q9Qs4=;
 b=Dhu1vIiHcHAGylGNR3gR9qQLNi6RP8PM0K2sJzl9giiOthdHFJvZv8+4UHzkWHxCq5
 07D5DV5aFLgMw8LUTd0pQ7fz0bY8PmlbWMJQteRwUtUn7HwU5wvXcJQB60Dest1ea8AH
 VPY953DOTlHzQQ8pnpps7ZYk6JWG5fessbqbHfl+A2IIoXWfbObrdibJyuE5LMmGAcdl
 0g1bLAEoCkeSqRcxV2IXAPsO62y1Agyk0qBH+9mkI7Ix//OYvUh9WAjjpYdOaGzY+Mh9
 CxxzovqOW64RFPsJ8oMAejPCceJNvfQcy0In2wYsbZT3egZgvMzxZ3opizv/RYSCbyTg
 uCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754311884; x=1754916684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pba1Jle9Vkm6yQmsiD5vif51gvj4WldLhrjFF1q9Qs4=;
 b=NvQhGTIpUjwM30Zio9YO5Af898iIqKUeW94tqk5fGdEEhYFmJ62EYpIgifCMwt/0DW
 bCnUwkT2SmAggqPxrAWLw6lljn6CthX7CgsUZ/0mf8Ig6Dx8aHf6rcXZY+xwXsslKx8P
 TuT7GZSdljvCn/QGI56X+TDjZipaGC4Ho5X6n5kuIF6eTdzZJ1W1b+2tEN/pbDTxc25Q
 WYR22fLnuHors1Sbc1uawf8u3uTiaXa7AEEY4Q8FCSfclgyEPF0J2c+CFYFvJlm4q29X
 +ZffzdshPlgldlcQmVaFKqfjSrgY1TiB6gzQGrMKW/cCUg5eIBDx20vdd/msNfUWQhJt
 rigg==
X-Gm-Message-State: AOJu0Yy2sxiGQane6ysh70YApX0PQEku2TpEYThfZEnt0BZOKWiG/zEP
 QrRPorrhWgQ7w0XmG+9pTH/sWDGZynCTuP6YgDJtpEDmEGO724Y76uUqq4jQGHFfDxtr0U3wHT0
 9yP7FFmV9GQ==
X-Gm-Gg: ASbGncu1LtRs/37SQ5kjkIVshAehJvWAJssLPZO6mmO36nNwYrjMQYjTJScAesjzqup
 2cO40uSDDaOKU6MPNj0nG/FZwhStQ+ORuCiMXNprUucJp6A5cvEHUsZEXSWbmuz7MKy1OiRArYk
 v03E/MIGkU5MDNWPnuydyNBweEUyJIfz3yOwt7wiQUG9N74xJnWpWpzgt0aSW+2q61N89Et5cq4
 CnrSwh9uZOVe4IE15cahiN3Ouw2Hkjwg/RFV5FvVguY7T1dv2WURz4JusjX2/G9VKuvwvHS7OY4
 2suObNkZvCrdZi6ohzHZCBdWDaeWmWduhzt0D8L2lb4ZHTE6k8RdN0EAyFl6kge/EVxoBKuETIy
 7wc5K6JO5G6WRDi2PyNi/d+EI6YOc3QqehDElGH2T6g==
X-Google-Smtp-Source: AGHT+IHa4GOOnDZq8JdN8MxE433mP2obpaS+aQXFgsSBJhRLeRiVKtQTDfaULnVzSTA0DT57I2wVIw==
X-Received: by 2002:a05:600c:858c:b0:456:1d06:f37d with SMTP id
 5b1f17b1804b1-458a24321femr107142335e9.16.1754311884207; 
 Mon, 04 Aug 2025 05:51:24 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d5b5:4194:ffa5:27f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3ad803sm15391058f8f.6.2025.08.04.05.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 05:51:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: lwip: ping: set net_try_count to 1
Date: Mon,  4 Aug 2025 14:51:01 +0200
Message-ID: <20250804125105.1672039-1-jerome.forissier@linaro.org>
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

The legacy network stack sets net_try_count to 1 at the beginning of the
net_loop() function. This is required for net_start_again() to work
properly. Therefore, set the variable accordingly in the do_ping()
function when NET_LWIP=y. This fixes an issue where a ping to an
unreachable destination would run twice on the same network device. For
example with qemu_arm64_lwip_defconfig:

 => dhcp
 DHCP client bound to address 10.0.2.15 (3 ms)
 => ping 10.0.0.1
 Using virtio-net#32 device
 ping failed; host 10.0.0.1 is not alive
 Using virtio-net#32 device
 ping failed; host 10.0.0.1 is not alive
 => QEMU: Terminated

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 cmd/lwip/ping.c     | 1 +
 include/net-lwip.h  | 2 ++
 net/lwip/net-lwip.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/cmd/lwip/ping.c b/cmd/lwip/ping.c
index 87f8e958e48..6d090fc530d 100644
--- a/cmd/lwip/ping.c
+++ b/cmd/lwip/ping.c
@@ -170,6 +170,7 @@ int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (net_lwip_dns_resolve(argv[1], &addr))
 		return CMD_RET_USAGE;
 
+	net_try_count = 1;
 restart:
 	if (net_lwip_eth_start() < 0 || ping_loop(eth_get_dev(), &addr) < 0) {
 		if (net_start_again() == 0)
diff --git a/include/net-lwip.h b/include/net-lwip.h
index f54f23471f1..e88e2186635 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -18,6 +18,8 @@ extern size_t cacert_size;
 extern enum auth_mode cacert_auth_mode;
 extern bool cacert_initialized;
 
+extern int net_try_count;
+
 int set_cacert_builtin(void);
 
 enum proto_t {
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 660ceb10cbe..fda14539455 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -27,7 +27,7 @@
 #if defined(CONFIG_API) || defined(CONFIG_EFI_LOADER)
 void (*push_packet)(void *, int len) = 0;
 #endif
-static int net_try_count;
+int net_try_count;
 static int net_restarted;
 int net_restart_wrap;
 static uchar net_pkt_buf[(PKTBUFSRX) * PKTSIZE_ALIGN + PKTALIGN];
-- 
2.43.0

base-commit: ae5711f881100f856ead1e76832c32b92dba93c7
branch: lwip-net_try_count
