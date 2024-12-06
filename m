Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86157E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA07F89745;
	Fri,  6 Dec 2024 03:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AvHb6orD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 193C68974E; Fri,  6 Dec 2024 03:37:47 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFFBA8918C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a813899384so882645ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452662; x=1734057462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1iSLRxEmx5EzvBCuLgq4Mu5ho7dzmKpouUz9dyWfVWU=;
 b=AvHb6orDnUdzBEs/oMe+LVQl5EIJU2ihgPji5wj62HdgBgfKg85TVyMtHPkzxTcmE0
 Yp/kINqIDZmlIjyHRw1MbMsd2RhuXF751lRTAvUWK0hy3buR5styGsnTRNfuuIXS0Q1I
 0kAZs2js8xDJZOM+u00RnUcTyxD38M0HavgrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452662; x=1734057462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1iSLRxEmx5EzvBCuLgq4Mu5ho7dzmKpouUz9dyWfVWU=;
 b=rvGcdup89ECr4rI+zoJasIsxgZqaR+pkr+lEL01uLbsW7qli7GBn1wF73Gnxy0+IjU
 HJForZyS97Ve4DGYu7zJP8qHtZGvARNtlIp7b/Vdbx3i+famomuqqXKvOs77roJNWvGZ
 kT4vosjaJDR+iCcMRH3DXxEmQfvHzyJdJvHMudSs3NY2ThlZjTUVLJDOTUCrl2SUt0/o
 WQZtM68MkaGqMJFLsFbjpPlza9dx3EPIQfKwCDeQio+z96ZM89amhzDs27BeXE0xQo9j
 ZkB6CDcW+839JQj96OzPIOj/sN1dMz6hIGdHd2ztteksTg2eVIKiTtk+SsoltWBwfARA
 rQqg==
X-Gm-Message-State: AOJu0YxE5Qpz+XE0/t80ZE86KrI5LSZVYaGtp7IdH/gmYL/mBwFMnY7i
 MhM2+vXZ3Ya5g8FQsDrejKt3VzIGLbEX+l9btMNkVqKR+HLv689RmCtgmQt+wAEW9Q2H5KQLJQM
 =
X-Gm-Gg: ASbGnct7P2DOUqEUMyuUtGLLzpKJp1IynJjFbTwXqWcHQ4tMyjSjzlMvSl9NVcz3Nf8
 ThrPFpuIOYP80sZWXBWNaMpf7KvDXc3GRuDrSxyCzh1OUHbSYpBywp6uGnhNQ0Qf9u9uz60tt2M
 XvrnOMGycqR8dirzUpNZaIKKGrW0P2VQIu4aaD/u0LmxEfNBE6cMrXU18ps7IGiK47lesURct8Q
 wuR5z2KTnFld0ChXTkQW5jlkrMrDG66kFVmcVlNWY53BpUxgRXHawrRm9J0sFcmSdIdUeYkg8Yg
 5E1+Jh6rYhQ=
X-Google-Smtp-Source: AGHT+IERgGYLMQX8DyiFu1LjTTZFIXe9qMDjtZkFNA/dDay1cCG4l0cb8q+AHwkLKKxS/+R8wYLI8g==
X-Received: by 2002:a92:c242:0:b0:3a7:d84c:f2a0 with SMTP id
 e9e14a558f8ab-3a811dc3a1amr18855095ab.7.1733452662571; 
 Thu, 05 Dec 2024 18:37:42 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:41 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v3 27/46] net: Refactor part of netboot_common() into a
 function
Date: Thu,  5 Dec 2024 19:36:06 -0700
Message-Id: <20241206023626.2456858-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Move the core code for starting an netboot operation into a separate
function, so that we can (with additional work) move towards calling it
from outside the file.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 62 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 572fa75a72f..f980448e0ef 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -382,11 +382,50 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 	return 0;
 }
 
+static int netboot_run_(enum proto_t proto, ulong addr, const char *fname,
+			ulong size, bool fname_explicit, bool ipv6)
+{
+	int ret;
+
+	bootstage_mark(BOOTSTAGE_ID_NET_START);
+
+	/*
+	 * For now we use the global variables as that is the only way to
+	 * control the network stack. At some point, perhaps, the state could be
+	 * in a struct
+	 */
+	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
+		image_save_addr = addr;
+	else
+		image_load_addr = addr;
+
+	net_boot_file_name_explicit = fname_explicit;
+	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
+	if (IS_ENABLED(CONFIG_IPV6))
+		use_ip6 = ipv6;
+	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
+		image_save_addr = addr;
+		image_save_size = size;
+	} else {
+		image_load_addr = addr;
+	}
+
+	ret = net_loop(proto);
+	if (ret < 0) {
+		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
+		return ret;
+	}
+	bootstage_mark(BOOTSTAGE_ID_NET_NETLOOP_OK);
+
+	return 0;
+}
+
 static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 			  char *const argv[])
 {
+	ulong addr, save_size;
+	bool fname_explicit;
 	const char *fname;
-	ulong addr;
 	char *s;
 	int   rcode = 0;
 	int   size;
@@ -410,22 +449,17 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	if (parse_args(proto, argc, argv, &fname, &addr, &image_save_size)) {
+	if (parse_args(proto, argc, argv, &fname, &addr, &save_size)) {
 		bootstage_error(BOOTSTAGE_ID_NET_START);
 		return CMD_RET_USAGE;
 	}
-	if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
-		image_save_addr = addr;
-	else
-		image_load_addr = addr;
 
 	if (fname) {
-		net_boot_file_name_explicit = true;
+		fname_explicit = true;
 	} else {
-		net_boot_file_name_explicit = false;
+		fname_explicit = false;
 		fname = env_get("bootfile");
 	}
-	copy_filename(net_boot_file_name, fname, sizeof(net_boot_file_name));
 
 	if (IS_ENABLED(CONFIG_IPV6) && !use_ip6) {
 		char *s, *e;
@@ -440,14 +474,10 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 		}
 	}
 
-	bootstage_mark(BOOTSTAGE_ID_NET_START);
-
-	size = net_loop(proto);
-	if (size < 0) {
-		bootstage_error(BOOTSTAGE_ID_NET_NETLOOP_OK);
+	size = netboot_run_(proto, addr, fname, save_size, fname_explicit,
+			    use_ip6);
+	if (size < 0)
 		return CMD_RET_FAILURE;
-	}
-	bootstage_mark(BOOTSTAGE_ID_NET_NETLOOP_OK);
 
 	/* net_loop ok, update environment */
 	netboot_update_env();
-- 
2.34.1

