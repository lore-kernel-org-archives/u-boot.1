Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6DACAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 09:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D681E83429;
	Mon, 22 Sep 2025 11:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ibE5STZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF18D833E8; Mon, 22 Sep 2025 11:36:54 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E172683280
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 11:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso2953533f8f.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533812; x=1759138612; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/DhXsGYeVAncwaZ9OfuvZAguKiUkU4uz221qxpx4kk=;
 b=ibE5STZUwW8e+L86I8KrQviYilnsMrlU6skEI0oSAXKAPODlT+W/L4nFcPBuR72+BF
 dKiKlqo8HSBCzhIXFVySC4CLtiRPJyEtTTE3jAGcMqcQ0DWPQnzwo1Pgq5mtkGPoSxwg
 G0QTmufm9DjXySlUzzNM3VN8k7ywqqI3bi/AfW3ehavDifvw4osL9IKcTGmvIayuDlvv
 2OAhvXjGZx4TUX8WAaKw1dx/GGgpVanfwznMgk35o4cHKWRt2Zj/Lg+rMCxai2q5WbFg
 HDPYbDoDaj+myH+SHF7dlV/u6flGvHSjQy2NzLeUforMGlB8o74GwX8PcqDskzdyvBj7
 LHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533812; x=1759138612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X/DhXsGYeVAncwaZ9OfuvZAguKiUkU4uz221qxpx4kk=;
 b=X3aj8bOwgmG8kX7x7xJwxPsUegb7HUzoOCDK8N/7dL1ATZIMNoT9HmBAf4qNs9Dmvj
 0FoG/zCkAvke5Okwxk5G/2i7xrJE3l4nKnAP3PYGgFnBrQyuB422XzmoFidUANaYDvCS
 axdUocsI6aFXbtcaXlpCZ/APy99o9LzTi1usM1YnsllVj6Auk70CuHu4jI2k2aCsavfZ
 gZHjeSsnZTKWWG9C66HCyVB9mh8QQ2h2sWZKmJ64wLbe9J2HUmBqWgb0ZsNvBVMzJ+Et
 ygEMaZoNPHk7ayrPw8hVoRmEICm4HDI02O3F27jSay1wwgK0gsveb0AWN1R8fuNGqd4a
 w8+Q==
X-Gm-Message-State: AOJu0YxMhsrzLSVqSu36vxVJipHZSdajqdDRq5uKMk5+uwpDtnClKpeW
 k8E+QU9uDibtGCGAtk5MxJujx2mMJssaNsrK9U/F3XV1i8Px/EcCB+tNfXZyvhYSJOgj2GzEegD
 UfpntbNQ=
X-Gm-Gg: ASbGncuHm9uXIEvj65PixsnDYAVc2BF3p1wy3zJKDpEl2LSEv5IWg7niCVvqQwMxMh6
 99Zhr15Bwc6O4APNQe4xZwcYaIROS8M6KKx/9dPi5mrDq36DyPvwaPEaIenjiF5rU8Vb6ZqXaIP
 llARx20+b7ApACOCoenecnTCA2uhFeb959RQM8x74vWI3UDicMTOj3zp2zK7O3eta1JXyzt1VoW
 eSh0QE5bGKL3PagLMn3Hg/16yPg5cqmX2IMgoxG2AaydjDlzbrmsE+5998XjBnE8vB6I2vY94Uu
 AtqL3C+0h/7+5xJQiq5W4S7vJCN6hVyVELsZhzavBBGnoinQLXdJFUQ6GejFrjvYV6cxXx+E9wY
 DEhHErdtiqm02RpYn37QVUiAnvOd27tk=
X-Google-Smtp-Source: AGHT+IGJwelGgdsl0j9AIDQNPV5N0ffg7nHvpLzHzYQ6WB9k+3Y6jYJN+KLXi7cQTJ5QlpQhDt3+GQ==
X-Received: by 2002:a05:6000:2888:b0:3ee:15c6:9a55 with SMTP id
 ffacd0b85a97d-3ee83da00dcmr8301011f8f.34.1758533812116; 
 Mon, 22 Sep 2025 02:36:52 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:fe8b:a136:2e69:4bd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d0asm19177840f8f.17.2025.09.22.02.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:36:51 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
Subject: [PATCH 3/3] net: lwip: dhcp: set ntpserverip environment variable
Date: Mon, 22 Sep 2025 11:35:43 +0200
Message-ID: <20250922093629.2547703-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250922093629.2547703-1-jerome.forissier@linaro.org>
References: <20250922093629.2547703-1-jerome.forissier@linaro.org>
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

Once the DHCP exchange is complete, if we have an IP address for an NTP
server, set the ntpserverip environment variable accordingly. Although
not necessary to make the sntp command use that server (since it is
known internally to the lwIP stack), this makes the behavior in line
with the legacy NET stack. This is also consistent with exporting the
DNS servers etc.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Suggested-by: Michal Simek <michal.simek@amd.com>
---

 net/lwip/dhcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index cbdfea3ba82a..531bf2c67057 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -33,6 +33,7 @@ static int dhcp_loop(struct udevice *udev)
 	char ipstr[] = "ipaddr\0\0";
 	char maskstr[] = "netmask\0\0";
 	char gwstr[] = "gatewayip\0\0";
+	const ip_addr_t *ntpserverip;
 	unsigned long start;
 	struct netif *netif;
 	struct dhcp *dhcp;
@@ -110,6 +111,11 @@ static int dhcp_loop(struct udevice *udev)
 		strncpy(boot_file_name, dhcp->boot_file_name,
 			sizeof(boot_file_name));
 #endif
+	if (CONFIG_IS_ENABLED(CMD_SNTP)) {
+		ntpserverip = sntp_getserver(1);
+		if (ntpserverip != IP_ADDR_ANY)
+			env_set("ntpserverip", ip4addr_ntoa(ntpserverip));
+	}
 
 	printf("DHCP client bound to address %pI4 (%lu ms)\n",
 	       &dhcp->offered_ip_addr, get_timer(start));
-- 
2.48.1

