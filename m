Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8EDC282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FDD820EB;
	Fri, 14 Mar 2025 22:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LP34lHEr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558DB8205A; Fri, 14 Mar 2025 22:56:08 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A5282064
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so1161115e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989360; x=1742594160; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3uh9BWQXC5LG7icgnrxqAiZkLllavTtcmLG+JZPHSiI=;
 b=LP34lHEr4LEBAFyND6/433iri1K3eKo/zlZVz8pR27edHdAYp6OoAB3GzmW7OBGMfT
 Vmn3nJfrUtYyuH3vgWj83Cb1EuMORpM1e+xhf+iJjT9As8rJFLXnItpgydpo6kaoaVsL
 8ibV2CD5pQ9Bs7/2+pfktAwqOAcCNafPFLOwgKE/UHr13YAwqNdeB2vbnsuYEKI1LCOR
 /f7O3CUgBd4P/k1U9Jad5P/8lKaNH+pWR2ZFEII2Sj/qOEGpJy+5eB2aMbNELyuVwCQv
 bbc+NnxwuPRzdkoWkn83bM51QOdemP69jTlYXyNbNQUSB2/jIUn7xeRGUzDlkN5MsBSZ
 YEpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989360; x=1742594160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3uh9BWQXC5LG7icgnrxqAiZkLllavTtcmLG+JZPHSiI=;
 b=tFLhJVz8Rg2xPvJFXqvoyhcAD8NJqydyZ9La+x3BD+CNuWvB5g0oO24q5ugKlK1TrL
 xdRZfZULBwSou8bpVYycIccLwouSOnySWjeFqPixWhxvdgNaiVI3I5YHUEfx5yWFrJO6
 UHMcR1bIvb8+gZ+TBxZDL4V0rHBHc63kYpnDkk4sXomvRGmk5d0iJuOOFEMzMF0VI50s
 zGkFDOoZtu5PVFYO3oE0QZzlVsZ4KEk6l+/8nzA3vzYjN667x83nveiLcitdzt65lEDM
 X41JPS/1EJhz5/qJWvfibgTrd7QRVkx1Z3c0cnAmjeQ6fUc4sMn6TuQQS1ymyhK5ATz5
 UhRA==
X-Gm-Message-State: AOJu0YzOoD5Pk4HOHO/Gw26mrL/ycKs+ZrWsEqeQj72z9OUiZvc88FZF
 /P8d6Yqfc6zJLKapQ/XsL3W1OVJs5dowMyrr06+P8qtHW/DAS70hAfBBb0mXEUmnVmcr0nviGWV
 n99g=
X-Gm-Gg: ASbGnct0UOiggqbIZaHFahrkhljghJN20tjBZcE25cAn66Rk1JLkSaPxukWdrT5pYR7
 ESmqbC72PQTzMlw5jsSMKWmKwv4KChGG+XPH318tigSynSB9ExP/QqX0UsqFC+gZHPEz0YM7d8l
 crlMI+8XAM0A807iQkiwneCLzbAUeRmVeplf2r+OrSxE+EaqakVAMK737VWXZuA/cxARBcKFH2a
 1b1+DXYqnadjbQQHu+l7yIm2Y1p+yNoI77gRqyKg99TS0xqdO6qqu8iZ/7GvuX0wgiQRpqmw8Ku
 cKMAuXGeAQZDg/4GW+g2eAOQ4spM6fkYrh1wkVQg+VvB2YGhrWb81Q==
X-Google-Smtp-Source: AGHT+IGw5Cdx3QjlNaTuHb/DWS/1VaHq5lNvqzVpMqBUkIZKw2YAxwbKyzrZbssezuIESPD+SlL+Ow==
X-Received: by 2002:a05:600c:150a:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-43d23137bd4mr33856675e9.3.1741989359957; 
 Fri, 14 Mar 2025 14:55:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/12] net: ping: make do_ping() available via <net.h>
Date: Fri, 14 Mar 2025 22:55:10 +0100
Message-ID: <20250314215525.579655-9-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Make the do_ping() function in cmd/net.c a global one by getting rid of
the static qualifier, and move the prototype declaration from net-lwip.h
to net-common.h. This makes the function available to other parts of
U-Boot when CONFIG_NET=y, as was already the case when
CONFIG_NET_LWIP=y.

This is a peparation step to make the sandbox tests use a common API
between NET and NET_LWIP.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 cmd/net.c            |  3 +--
 include/net-common.h | 12 ++++++++++++
 include/net-lwip.h   |  1 -
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index 79525f73a51..eaa1de5295f 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -456,8 +456,7 @@ static int netboot_common(enum proto_t proto, struct cmd_tbl *cmdtp, int argc,
 }
 
 #if defined(CONFIG_CMD_PING)
-static int do_ping(struct cmd_tbl *cmdtp, int flag, int argc,
-		   char *const argv[])
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	if (argc < 2)
 		return CMD_RET_USAGE;
diff --git a/include/net-common.h b/include/net-common.h
index 52c2a6ce027..025b8a0363e 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -493,6 +493,18 @@ int net_loop(enum proto_t protocol);
  */
 int dhcp_run(ulong addr, const char *fname, bool autoload);
 
+
+/**
+ * do_ping - Run the ping command
+ *
+ * @cmdtp: Unused
+ * @flag: Command flags (CMD_FLAG_...)
+ * @argc: Number of arguments
+ * @argv: List of arguments
+ * Return: result (see enum command_ret_t)
+ */
+int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+
 /**
  * do_tftpb - Run the tftpboot command
  *
diff --git a/include/net-lwip.h b/include/net-lwip.h
index 0d3bb8a8bd8..b762956e8fd 100644
--- a/include/net-lwip.h
+++ b/include/net-lwip.h
@@ -34,7 +34,6 @@ bool wget_validate_uri(char *uri);
 
 int do_dhcp(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_dns(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
-int do_ping(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_wget(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
 
 #endif /* __NET_LWIP_H__ */
-- 
2.43.0

