Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51591D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4400F895DC;
	Tue, 19 Nov 2024 14:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ltebnH4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06ADE895DC; Tue, 19 Nov 2024 14:19:51 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF8A8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a76156af6bso8416965ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022387; x=1732627187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mbU1t1/Urzmgw/57DOeh0rTY3MYT8YU893G7QjGccSE=;
 b=ltebnH4xf7mnERDoTcfyS7xbX3iZaiwJeW2HO+VOZGrSQTIZZRnfvuoPL6B5q35TbD
 QlyPM1veHsrEkVmBMwfGvP9N2ZtVOItV1V4Il+JWYPqOeV14iX93td+nxlkLrxahXzZU
 Ls5SGqm9KrULyEsKK8BYe7ynNvfYRvSTPm8KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022387; x=1732627187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbU1t1/Urzmgw/57DOeh0rTY3MYT8YU893G7QjGccSE=;
 b=s1G/IfeBgVqUc7eYg6Qn5R1W12R9puZJE6k/I1eTIUq+TxtrN1250Roxket1TFxiBR
 vlp95NdxA6DsCEr1X3H15MN87nmPu0FhRr+5mKhTpLfNN6qxvUmmQb7AmoK4zsYjvm8B
 BHi75SX2Tx+KuiE2Waf7Mv39iv9WhTF0lu38l3fS9UKo6NTFqdIm/Vw+p4wjzXGbET17
 /p9Z9lObsI0b+JKXGtX2GYrHE0eQEmEJwBdYdgeAwsNcnZ+qxPiAAOte9xFj9xtMD2C1
 zHtg/YNTmTjUfpFLvAbz7IQ543c6m/pD5jpJSjt18i4HGtOXt4MbPi646qbr2j49A/kB
 /awg==
X-Gm-Message-State: AOJu0Ywl1KLGSf5btOTdYXURxx/TSFTuVt6mewKAinLDurXNTXkcz1pp
 qPa8YSSaJ7H77RuDIZeamwLDzo/t6PrJJdLJ4b97h4ETOQTnWzEDXRtLpcz2OG6RllSOor9XP3A
 =
X-Google-Smtp-Source: AGHT+IEP4C+W5Iu+jM6LhbEh5MNKcEkLh0vMk7OxsqNSTLO8L8qcGs/rF+582jiIIk3/S+Cj1NLfBw==
X-Received: by 2002:a05:6e02:b43:b0:3a7:1b96:220f with SMTP id
 e9e14a558f8ab-3a7480417e3mr140289115ab.9.1732022387017; 
 Tue, 19 Nov 2024 05:19:47 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 21/39] net: Refactor part of netboot_common() into a function
Date: Tue, 19 Nov 2024 06:18:26 -0700
Message-Id: <20241119131844.4078144-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

 cmd/net.c | 62 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 8bb8604faf6..f1b520143df 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -380,11 +380,50 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
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
@@ -408,22 +447,17 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
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
@@ -438,14 +472,10 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
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

