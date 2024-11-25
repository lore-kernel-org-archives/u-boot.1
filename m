Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF6D3B7CB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 00:59:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC2E1899E3;
	Mon, 25 Nov 2024 01:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VBYan4YP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3031899D6; Mon, 25 Nov 2024 01:58:46 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B7E89644
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 01:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-724f42c1c38so978921b3a.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 16:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732496323; x=1733101123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/M3aJDfcwIMdxbNFJnrI6q6Q0pcKoevHUfmSLBOqJs=;
 b=VBYan4YP/bPYio33xNzCazHtP11xPi2kIQvYC7nLUIUCwjpyx7k9cn9UVKAi8CVC6K
 LkdQ/98IA3BON43A0pro/+eiiwxKcrIwcQG4xLVDUwJG2EQCrn7MJqeLDMqaT/FG8rgq
 6x4ZipqZwB3cxgNwjlJYiE9KXYy8Cwfo3EdgVO2uZz6VOD9wco7tc/A+RTfmNtbIKPkb
 T1g1kVykRiy6cCzS9DY0EC0Tol+nCoZGcijJGLFqZ2JSeUuwlWcN9Eylybw936Omlzs+
 GeTE5czqBxO5IfB5R2bWDn4sJG5IYzxAepNDSNeuZlgObmGUjm2Vl/I6qOaTemij9CHg
 S7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732496323; x=1733101123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/M3aJDfcwIMdxbNFJnrI6q6Q0pcKoevHUfmSLBOqJs=;
 b=Zr1TIRE2S4e/R6rMNW+jrzMTTvlmbnXYDudodwAJvUa2FQy+1QI6Y1GwsO04SiSLtl
 +/aLC4XuMC6pvGQk/tBzoz/XrqHl+dSp+Ksucjx68G/ZyfdKLIqtKpKMfMqtYQ52rE+O
 FLx9YZfzMAEd6PGPpVAAuyiIUl/fGHQ1/92yuJ9CZQanTp4lkVXEtfSxmg74RhqzRFYj
 wVJsQNoVsyHekc06T908NqWhlZIuvsK5UZWIylQvakKyo0Hfm6XwdGyOvTkb9/SkDOJ1
 ZoRQSbMZedSaDsm31utiWEg8UpUO8xA4cPZiHUCoVTUUHxRtjFLaJ5CK/KYc3y2sUwUM
 PUgQ==
X-Gm-Message-State: AOJu0YznsqIEwQ3oP6biQzg+Bfks7C6ijXSqYQnpZYsUOCfH0kwbe8MQ
 Ai12yfP0hU8PYxsvPYfyLVXDmSNVEOo6Gf1b7jj1MS8++q0rbO1dBwNknFg61o0=
X-Gm-Gg: ASbGncur9v5QClmPO21INB20HzhmVcAz4XekRfLuqgQ/PUO8g3dhjdFYgTS3oewXTaX
 NH9B7uYTaFBvjfmTAVBTDbu7dPYBflpHCeU2V0Sriv9c39Y0U+tR9E1I0sjuSmxfFB18L0dZjru
 6n1SpRJLT+3UP2pHGSpwoNHAbdpjOOkqpIl3owY+WYTiPaYHYQKdz00frf1Xdw7V709X0Y5xZvC
 BmSzKSDvIYFaeMdhUk1nhGP+rj8JytSR9PFfFGh7y/t
X-Google-Smtp-Source: AGHT+IEoS434Yt8sWOtdsEayZ2iDr2xVgIYt1u5p95Wbp+D/F/95Qyq3Qz/jreESZw7I9pQCtYP5ag==
X-Received: by 2002:a05:6a00:23cc:b0:71d:f2e3:a878 with SMTP id
 d2e1a72fcca58-724df3c7b45mr17817718b3a.5.1732496322951; 
 Sun, 24 Nov 2024 16:58:42 -0800 (PST)
Received: from adriano.. ([186.11.57.125]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724de47955asm5377793b3a.65.2024.11.24.16.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 16:58:42 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v5 07/14] efi_loader: device_path: add support for HTTP device
 path
Date: Sun, 24 Nov 2024 21:58:07 -0300
Message-ID: <20241125005814.236669-8-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125005814.236669-1-adrianox@gmail.com>
References: <20241125005814.236669-1-adrianox@gmail.com>
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

Add efi_dp_from_http to form a device path from HTTP. The
device path is the concatenation of the device path returned
by efi_dp_from_ipv4 together with an URI node and an END node.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
Changes in v5:
- Add function description to efi_dp_from_http
- Check if dp1 is NULL in efi_dp_from_http
- Use strcat

Changes in v4:
- Reworked an if-else

Changes in v3:
- Moved argument checks in efi_dp_from_http to the beginning of the function
 include/efi_loader.h             |  1 +
 lib/efi_loader/efi_device_path.c | 63 ++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

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
index 96e72f72fc..1e512bf0ea 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -1017,6 +1017,69 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	return dp2;
 }
 
+/**
+ * efi_dp_from_http() - set device path from http
+ *
+ * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
+ * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_URI,
+ * and an END node.
+ *
+ * @server:	URI of remote server
+ */
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
+	if ((server && strlen("http://") + strlen(server) + 1  > sizeof(tmp)) ||
+	    (!server && IS_ENABLED(CONFIG_NET_LWIP)))
+		return NULL;
+
+	efi_net_get_addr(&ip, &mask, NULL);
+
+	dp1 = efi_dp_from_ipv4(&ip, &mask, NULL);
+	if (!dp1)
+		return NULL;
+
+	strcpy(tmp, "http://");
+
+	if (server) {
+		strlcat(tmp, server, sizeof(tmp));
+	}
+#if !IS_ENABLED(CONFIG_NET_LWIP)
+	else {
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

