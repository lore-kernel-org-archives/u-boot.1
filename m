Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5589C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:43:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F9BD82B3D;
	Fri,  6 Jun 2025 08:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XmwbYqbj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E1D8807B1; Fri,  6 Jun 2025 08:42:32 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FBB82998
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so15040945e9.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749192150; x=1749796950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CwhTKXVWqhwHFqLYHC5GbHvBwwbAmFalzwdUS9JOsXU=;
 b=XmwbYqbj6BdtPwqbI0BoWXLKXOb4Kr8SdhduScDLDgf8s32eYVWUjjy/pH0R64c7w0
 ck/ZRCRVisgR6LHR1boA1ZwxGBpDsj2NsgvdK6yOcqatA8lQ7opehCHB9dGkmOK7ZI0R
 J5IxzfXZwGzudr0WC2A/vYTPoP65iaRw7iJVhGx/gHLUIANtDFKD+x0EmPMNhZQHqJsR
 NdLlb3QAud/xmgg44qTtIn3aU/FiBM0EKLpNYxo5iHiLyVPCmrW+GRf6M262f3pjX/3C
 gkoz5ezH9cFMoq9Pn06xKMHtQ3YxpwhfnaeRyyDXmlu5JBys9jsjo/pc9XXJ/ysPZQRW
 Ti7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749192150; x=1749796950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CwhTKXVWqhwHFqLYHC5GbHvBwwbAmFalzwdUS9JOsXU=;
 b=FR+UrV+YGuRYdsrbrDqeJ3AfIRb+w0IJQCvtEveSSTxjgPFWvrW8LducrhDCPaC71n
 9BIM4aZ7aOU9fijZeo01XxHMepx0GSKwnnsxBPpxBkKIgu0iEgq3/PY0E+QJO2C6OYBG
 PJ/ntGLkL+QFHZzhxZBE+0vMjp6nJq2OaeE7MYupGHC4xV8Nk6spdIDzjuUxMqXZs/ZG
 gewKa6ylZYSmI9uUxHDnZ37e5PGP5G+GW25AUiCjJJY7RjyWxfDnty8nrxF0ILrmy/y5
 JXd3vKSmfYPWKHXJNN0feRBY0HTEwCcHyfxMlAk58wH5IVHg/ciPY2lf6GgWw/yYgGO7
 NJew==
X-Gm-Message-State: AOJu0YxdxA2q7Z2bO+qV20EbkYj6Hfs5pybEAz7u0it0J6jzF/tHFoAG
 EqvglznJT4MugwM0E6HIJzAAwm0V/mAM5oU9a3BVic+l8upNsnm/rqatKgH1h791bsSP6t5snCw
 lhlPB
X-Gm-Gg: ASbGncvV2OyxfL0QYbuQ13xf+p0EwHIkb0UO4g2xlLHxFTXkKO+GUBZseAHX5c5uvCV
 FPgBMk5s+sG/IoUzrcBMkT9s8Rn9ZZkhiTr/fvgfGzfZWJQUQChbSSxV9b9c+EodUW5NXiNMEGU
 ZWm10qGm5kdjcFYf7XXe7+OQl+4qJUwYF1Nmug52q3Gz8B2mIg3++voD2HYCSddsBGFko7AdaiH
 EVv7Kl5ydZbP+hACGXxmfeiyaoI3ocYOgbWCeirtCm1gOamRL3bnbYclGvO5ourYid7I2BmYLST
 6TZffhQp1JTPybzw+60GhgRrS1oDOOkMu7Fc0l8SG7to+DtFcRiIssjW8qvXZbN9tdxMyic=
X-Google-Smtp-Source: AGHT+IHGfGBKWz04oDJDAXnOkYAVjILus5YQlGlmshyJI1IC23amew8D6Aa/vDHQRgVHp0Uyg86bJA==
X-Received: by 2002:a05:6000:2f88:b0:3a4:c8c1:aed8 with SMTP id
 ffacd0b85a97d-3a5319a6fa1mr1913618f8f.39.1749192149780; 
 Thu, 05 Jun 2025 23:42:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:af71:dfb2:66ef:80c3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244d10asm994627f8f.67.2025.06.05.23.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 23:42:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/13] lwip: dns: do not print IP address when a variable
 is specified
Date: Fri,  6 Jun 2025 08:41:43 +0200
Message-ID: <20250606064211.3091237-8-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250606064211.3091237-1-jerome.forissier@linaro.org>
References: <20250606064211.3091237-1-jerome.forissier@linaro.org>
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

Changes in v2:
- New patch

 cmd/lwip/dns.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/cmd/lwip/dns.c b/cmd/lwip/dns.c
index b757638cd1e..0bfd8f198cf 100644
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

