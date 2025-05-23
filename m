Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5DBC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 23:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D22D83423;
	Sat, 24 May 2025 01:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E3PCHiQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAD383409; Sat, 24 May 2025 00:59:23 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0554D8334D
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 00:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=swboyd@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so313941b3a.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748041159; x=1748645959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3zg3do6lZMukq2adld3fz8C9++BmVFQooOwz3wgl90=;
 b=E3PCHiQD/qKzFWEwb8fHk28w+xUCCFCqmSVzhNagjh6yePrAI6zpzmwdvQPh7GRX8j
 8hQigVhBJ4SFq0Wnk4Jd+VvpLcZOxv15uyfj+OFVFDLO/jthRmaz88ZYxdoepiHnBgtC
 So13TZMJL39IAvAt3KWpmofkRfPzkNZ0oKZiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748041159; x=1748645959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3zg3do6lZMukq2adld3fz8C9++BmVFQooOwz3wgl90=;
 b=Gp5nr0bBm9gVvxAKLYoIA56j6iT/I0kIXSd5+KdfEA4/lnEs7/ly8JSPAlv+OhFEzn
 A457TEcvW+OfKp7jcfyxyXMDfYRmWny7hkBskLKd3noI7lx1TGk6dX8lndXgSpsgm189
 9XSxq5Nafqdhradj214wsYTIiaL8pRcseYCupkgWOCIciQqYG/S7/5kbFB2xpYFBDDmF
 DtPHUX9oP3m/05HS74/8EBqy0VXyDHHiApHXt4MgdREzzyMqZCgYKPTFdnXHTlB2HPro
 YUyZBEhOYjg7eUT311dL+p2HpYOXVOTW6jfWkDsBvgYca0L02bV8PoXggME6kkMq7vEu
 +28w==
X-Gm-Message-State: AOJu0YzUmgaOffOwPK1YV358sQ0+TKdmARuBI7Vv6s8qst3/Z6SCU+mV
 WFLQqXLM5kokRIskYXkKo4rYxuHfcRkRu8p4beXMimlKPLFWkQGB7mdn92kysfjo8GaUSfN9CE0
 UZoQ=
X-Gm-Gg: ASbGncvbz8ZKWrZPggOTMg/Vw5W0L3n5Zs02qsIK/2ggawU8J4mqirdMYnTzpkN9UUi
 iGZ1Y4rL5TPy1ci+col9m3iqlXAXMNb6xv3DgI8B35Gn/Ju10NuyFFGu4znYx/2UHBP4mDP0/ia
 VBniTNcw2cZ52TmcYpfXSFjcBALR+goPOY1aKJ6Eh6dc7xiAeIBfvTwcrK2AvbBCtNXcmGkKXON
 3K8aS4g94ChTksO5tvQ+cYbUZ0pqsJdEJyvVuVYheGZzQiL+v56FpEGv856pzi/A2Ys14ZKZ7Nh
 pL9/3js8XCvxr7WIwijMtKIKbRp88m6ILkBDDjRz78P1KVp91OMoRAOMzEvyYjCVhcsR+Fn0eGM
 ilJItcd3eM+e6qTg=
X-Google-Smtp-Source: AGHT+IEkyZBoZyBb3wyGCEouqr8vNvM6QH+rTjArHchqF1fJf79uUujJB/4toXbQL/DdlfWqP9eq0Q==
X-Received: by 2002:a05:6a20:d70f:b0:1f5:9098:e42e with SMTP id
 adf61e73a8af0-2188c1e8dfamr1870906637.7.1748041159419; 
 Fri, 23 May 2025 15:59:19 -0700 (PDT)
Received: from localhost (188.139.125.34.bc.googleusercontent.com.
 [34.125.139.188]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-b26eb09ffb8sm13225409a12.70.2025.05.23.15.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 15:59:19 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
Subject: [PATCH v4 21/28] fdt: Populate wifi MAC from environment
Date: Fri, 23 May 2025 15:58:36 -0700
Message-ID: <20250523225845.2311989-22-swboyd@chromium.org>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
In-Reply-To: <20250523225845.2311989-1-swboyd@chromium.org>
References: <20250523225845.2311989-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 24 May 2025 01:00:29 +0200
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

Set the MAC address of the wifi device node with an alias like 'wifi0'
or 'wifi' based on the environment variables. This allows us to populate
the wifi device's MAC address on devices like Trogdor that store the
wifi MAC in the VPD.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 boot/fdt_support.c        | 54 +++++++++++++++++++++++++++------------
 lib/coreboot/cb_sysinfo.c |  2 ++
 2 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/boot/fdt_support.c b/boot/fdt_support.c
index 92f2f534ee02..a02de4dfd9c5 100644
--- a/boot/fdt_support.c
+++ b/boot/fdt_support.c
@@ -611,13 +611,34 @@ int fdt_fixup_memory(void *blob, u64 start, u64 size)
 	return fdt_fixup_memory_banks(blob, &start, &size, 1);
 }
 
+static void fdt_fixup_net_node(void *fdt, const char *path, const char *mac)
+{
+	int j;
+	char *tmp, *end;
+	unsigned char mac_addr[ARP_HLEN];
+
+	tmp = env_get(mac);
+	if (!tmp)
+		return;
+
+	for (j = 0; j < 6; j++) {
+		mac_addr[j] = tmp ?
+			      hextoul(tmp, &end) : 0;
+		if (tmp)
+			tmp = (*end) ? end + 1 : end;
+	}
+
+	do_fixup_by_path(fdt, path, "mac-address",
+			 &mac_addr, 6, 0);
+	do_fixup_by_path(fdt, path, "local-mac-address",
+			 &mac_addr, 6, 1);
+}
+
 void fdt_fixup_ethernet(void *fdt)
 {
-	int i = 0, j, prop;
-	char *tmp, *end;
+	int i = 0, w = 0, j, prop;
 	char mac[16];
 	const char *path;
-	unsigned char mac_addr[ARP_HLEN];
 	int offset;
 #ifdef FDT_SEQ_MACADDR_FROM_ENV
 	int nodeoff;
@@ -670,21 +691,22 @@ void fdt_fixup_ethernet(void *fdt)
 				continue;
 			i++;
 #endif
-			tmp = env_get(mac);
-			if (!tmp)
+			fdt_fixup_net_node(fdt, path, mac);
+		} else if (!strncmp(name, "wifi", 4)) {
+			/* Treat plain "wifi" same as "wifi0". */
+			if (!strcmp(name, "wifi"))
+				w = 0;
+			else
+				w = trailing_strtol(name);
+			if (w != -1) {
+				if (w == 0)
+					strcpy(mac, "wifiaddr");
+				else
+					sprintf(mac, "wifi%daddr", w);
+			} else {
 				continue;
-
-			for (j = 0; j < 6; j++) {
-				mac_addr[j] = tmp ?
-					      hextoul(tmp, &end) : 0;
-				if (tmp)
-					tmp = (*end) ? end + 1 : end;
 			}
-
-			do_fixup_by_path(fdt, path, "mac-address",
-					 &mac_addr, 6, 0);
-			do_fixup_by_path(fdt, path, "local-mac-address",
-					 &mac_addr, 6, 1);
+			fdt_fixup_net_node(fdt, path, mac);
 		}
 	}
 }
diff --git a/lib/coreboot/cb_sysinfo.c b/lib/coreboot/cb_sysinfo.c
index 555abc93f1cb..959eaaab8e88 100644
--- a/lib/coreboot/cb_sysinfo.c
+++ b/lib/coreboot/cb_sysinfo.c
@@ -686,9 +686,11 @@ static unsigned int coreboot_set_one(const u8 *blob, unsigned int i)
 	const u8 *key;
 	const u8 *val;
 
+	/* We only care about strings that may contain keys we can use */
 	if (vpd_type != VPD_TYPE_INFO && vpd_type != VPD_TYPE_STRING)
 		return i;
 
+	/* Conntinue to move 'i' forward through the VPD blob */
 	i = vpd_cbmem_parse_key_value(blob, i, &key_offset, &key_len, &val_offset, &val_len);
 	if (vpd_type != VPD_TYPE_STRING)
 		return i;
-- 
Sent by a computer, using git, on the internet

