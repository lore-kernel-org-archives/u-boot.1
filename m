Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D49C7115C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 13:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE08482E8E;
	Wed, 25 Jun 2025 15:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YvwBygDc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A30AD82CBC; Wed, 25 Jun 2025 15:21:41 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B007C82E08
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 15:21:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so3898172f8f.3
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750857694; x=1751462494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zw2o6MnolNwOFvuGvEw5Nc0YvBVz9NEXlG0S6QtGMrM=;
 b=YvwBygDc3L8hKmxMIMRc9D2aG9mxqRtEc0D4nYVPa6GBPHXZ5lJqOmvzUjGOVOwelT
 i5myc4UA7obxOnDP9rxO7EaIFC1VYBwfQ7jSuw3c05V/c9Dpk+kK41TN6GbHsue2+yCj
 +P+Osr7mIVgGRLNaiqQ2v4kcPglphNHz5tShPWHgZ5BqHEtISqUqIosSHJ8xlB4vsKmD
 WuVbZXfJnW81oAKiMar7bseTXTR0vMl7u3xGpmtqYeCjspsaEaRSVL3yr53PXPEyU3S9
 O7PEaHdFQiZMnkGefPeKHZ4nw3y3+JSw9T0lzEZGYWWMfa22uewtXIGj1QaLNdgejjig
 d3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750857694; x=1751462494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zw2o6MnolNwOFvuGvEw5Nc0YvBVz9NEXlG0S6QtGMrM=;
 b=YS8gz8ywGK9p+FC4Ss97BJfiMNunZtR3jss7eGS7BPdtXmJaVctXDfiGkslCdLyik+
 Kl8gx9ocXQdYGIXM//k1w9BH74GLdexeRBCqLSxkdfhcy9LcB02JlXs46sWARtTzoLe0
 lGVQM8f19MRKjdYVK+jp4gH/XSdhYZMNFR2mqlF+SJ37O7oyMTxOTneplU4LqEnU0Nmv
 NH39u9o8o2m1qOd8KXyuDlHowbj+JOh63nkUc59qpAr0F/LjsSDpf/QtHVXlHROSEfdA
 3B1HMslsUW5sEijn4+AyO1WGxlakA+Q1WC4T58hU/zB/P3qDdZp2c1cYGOG9knt7Uu5f
 u/cQ==
X-Gm-Message-State: AOJu0YyV5iBfBf8FacNHgxoMybXlsRWsoJP+7jB8esLQNa5o3qTVjb+f
 GKZ2abjQAUBo5f14mQjwXvbuTcX/pE+ejgWTSqwDUnq1hlb9r9pa/y47192vQw8CyO2XZ8s67sC
 yyjih+Hk=
X-Gm-Gg: ASbGncu0fNB97obTmNB/+pvB+25t+/oRBwp5ceyOauMirMPpgCOvXEHgx1Wr+Bdv03V
 EcHLyOTCBkIgVV1IoLOa+04W1aWDTfJd81qRGmNPbCk4hmhORlAl96lkx/3t39F4HgqKIW42RuD
 oVBFGo89v3UyqQ/wPwZjYoPspoWoF0ivnJdTZqECJQtqDAS5JdqQb2jtbY6Leksb8Sw+lgeYRil
 MVbOxp1oMG68wEhq0WBGBcG+Niy0S675IgWO6C59S7Uo66qvMMWtc3yUwARpaH1Pyb9KSCPjbw0
 JmQp+wjhpdMHeHUKJbUIqpVGin7Ch0tYC8DjMUEWNvuN0CSjD3G8g21x/waZYEWXyV3iveM=
X-Google-Smtp-Source: AGHT+IGVpi0jByYj7ihiWshL5JOncsozZDcMpuTXAKV9ajoncN712ZxMokCytx/ABf70iCUFAhheLQ==
X-Received: by 2002:a05:6000:26c8:b0:3a4:f6ed:767a with SMTP id
 ffacd0b85a97d-3a6ed63783bmr2540299f8f.38.1750857693801; 
 Wed, 25 Jun 2025 06:21:33 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068fd0sm4760042f8f.38.2025.06.25.06.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:21:32 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 07/13] lwip: dns: do not print IP address when a variable
 is specified
Date: Wed, 25 Jun 2025 15:19:15 +0200
Message-ID: <20250625132108.3292932-8-jerome.forissier@linaro.org>
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

When calling "dns <hostname> <varname>", do not print out the IP address
of <hostname> onto the console. Print it only when no variable is
passed. The reason is to be able to call do_dns() from another command
in need of the DNS services without polluting the output.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

(no changes since v2)

Changes in v2:
- New patch

 cmd/lwip/dns.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index 4689ecce513..344f9a68bb9 100644
--- a/cmd/lwip/dns.c
+++ b/cmd/lwip/dns.c
@@ -42,8 +42,6 @@ static void dns_cb(const char *name, const ip_addr_t *ipaddr, void *arg)
 
 	if (dns_cb_arg->var)
 		env_set(dns_cb_arg->var, ipstr);
-
-	printf("%s\n", ipstr);
 }
 
 static int dns_loop(struct udevice *udev, const char *name, const char *var)
@@ -107,8 +105,11 @@ static int dns_loop(struct udevice *udev, const char *name, const char *var)
 
 	net_lwip_remove_netif(netif);
 
-	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0)
+	if (dns_cb_arg.done && dns_cb_arg.host_ipaddr.addr != 0) {
+		if (!var)
+			printf("%s\n", ipaddr_ntoa(&ipaddr));
 		return CMD_RET_SUCCESS;
+	}
 
 	return CMD_RET_FAILURE;
 }
-- 
2.43.0

