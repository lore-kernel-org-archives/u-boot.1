Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE622D41D46
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFBC893EE;
	Tue, 12 Nov 2024 03:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CiRnbBIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5598789390; Mon, 11 Nov 2024 22:10:25 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B0B89395
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20cd76c513cso41552075ad.3
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359422; x=1731964222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0sUezcTdv8RuYcH1Q5y+Mt47SGoWhsc1w4A5NAw1eM8=;
 b=CiRnbBIQ475l35ta0sixV+cLXTVGc2V8ZATZUe87a2zyo77+YRshBfgzCjSjH3zzVq
 Fb+iRLltH3eurbJ6tYrPoSS6xHIZfGriGODQtfvvW+ir+iy25smo5BAQfc1SL+9N7awj
 keaAH3Nkr2CSBXX3298B37RtJgrDpvFGWOAldMNqTv0m4rmd7VPSYPSBvdemyx9vbIqm
 9gwnXAS35d+VvZSTyix2ZFDq09NG436gMkRJwQlfB37UrgT0DXnaa+xCe33Nh8SEhWNB
 vIS6B2rD7nXVyy1eaJP5luDKIBBjV4/M8YVwKnzkF56Qd3nA2IBs6nZAFwhhd4ap0/XD
 9RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359422; x=1731964222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0sUezcTdv8RuYcH1Q5y+Mt47SGoWhsc1w4A5NAw1eM8=;
 b=iQIfNHuyV2z4LI85OI42iUgkcmkeO80/aI5Lp/u7VjxBViIE6OlFCHZylxv0xKrwb3
 zAFZoTyYpVrbcqSqrogml4BYMzx4CslzwUp7JAE2hd4jgY3D7N8FNh9Gw5m3b8TYx1a3
 S6LF47etw0ZqJhe5tBirpZwHuXLiAQVcYiMIMIXWmn21eI63TBE68bEv3a1U2TES4Io7
 +RA9fJ5QPe22DZPo33SChrxK98B+CZytKMsvwvhxPCyImvqtbucxFFMYlZK/SeeC83cm
 ALKLL9gEJTkbvGFeByNvHzpSRG2PzujKo6ZZVTzmyRFTlgn/fDYn8ZOnH77C+ZGP/Sy8
 HNcg==
X-Gm-Message-State: AOJu0YwdKn/1NmayG62g2ijpEq6E0VpU42JZ2hpnujsryacLxgOg0in2
 FKwzfM5R2b2245VbY8429ntFhYPdIuZYcA4alet5DbUVevsHTblWmahxaenZ
X-Google-Smtp-Source: AGHT+IE+eY+ivxmJdHQiqnpp1A/AdSgsKb5ImvNklaqYldLItdvYmQUeW9sfJG4DUYy6/QaX/wGD9A==
X-Received: by 2002:a17:902:c403:b0:20c:5cdd:a91 with SMTP id
 d9443c01a7336-211ab9c4e94mr1612125ad.41.1731359421650; 
 Mon, 11 Nov 2024 13:10:21 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:21 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 08/15] efi_loader: device_path: add support for HTTP device
 path
Date: Mon, 11 Nov 2024 18:09:52 -0300
Message-ID: <20241111210959.560738-9-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

Add efi_dp_from_http to form a device path from HTTP. The
device path is the concatenation of the device path returned
by efi_dp_from_ipv4 together with an URI node and an END node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---

Changes in v3:
- Moved argument checks in efi_dp_from_http to the beginning of the function

 include/efi_loader.h             |  1 +
 lib/efi_loader/efi_device_path.c | 55 ++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 612bc42816..96b204dfc3 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -872,6 +872,7 @@ struct efi_device_path *efi_dp_part_node(struct blk_desc *desc, int part);
 struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 					 const char *path);
 struct efi_device_path *efi_dp_from_eth(void);
+struct efi_device_path *efi_dp_from_http(const char *server);
 struct efi_device_path *efi_dp_from_mem(uint32_t mem_type,
 					uint64_t start_address,
 					size_t size);
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 82a45da1fa..158f08b9e5 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1012,6 +1012,61 @@ struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	return dp2;
 }
 
+struct efi_device_path *efi_dp_from_http(const char *server)
+{
+	struct efi_device_path *dp1, *dp2;
+	struct efi_device_path_uri *uridp;
+	efi_uintn_t uridp_len;
+	char *pos;
+	char tmp[128];
+	struct efi_ipv4_address ip;
+	struct efi_ipv4_address mask;
+
+	if ((server && strlen("http://") + strlen(server) + 1  > 128) ||
+	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
+		return NULL;
+
+	efi_net_get_addr(&ip, &mask, NULL);
+
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+
+	strcpy(tmp, "http://");
+
+#if IS_ENABLED(CONFIG_NET_LWIP)
+	if (server) {
+		memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
+	}
+#else
+	if (server) {
+		memcpy(tmp + strlen("http://"), server, strlen(server) + 1);
+	} else {
+		ip_to_string(net_server_ip, tmp + strlen("http://"));
+	}
+#endif
+
+	uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
+	uridp = efi_alloc(uridp_len + sizeof(END));
+	if (!uridp) {
+		log_err("Out of memory\n");
+		return NULL;
+	}
+	uridp->dp.type = DEVICE_PATH_TYPE_MESSAGING_DEVICE;
+	uridp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_URI;
+	uridp->dp.length = uridp_len;
+	debug("device path: setting uri device path to %s\n", tmp);
+	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
+
+	pos = (char *)uridp + uridp_len;
+	memcpy(pos, &END, sizeof(END));
+
+	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
+
+	efi_free_pool(uridp);
+	efi_free_pool(dp1);
+
+	return dp2;
+}
+
 /* Construct a device-path for memory-mapped image */
 struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 					uint64_t start_address,
-- 
2.43.0

