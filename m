Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C47D37E3F
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 15:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B122383655;
	Wed, 14 Jan 2026 16:12:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XpAVK8M2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1459835B3; Wed, 14 Jan 2026 16:12:20 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADFE3830E4
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 16:12:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so83922265e9.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768403538; x=1769008338; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZT3Sa9ASlhk7HDjx1Bwk/ZOElZh8by+gNc+C5VlKT6A=;
 b=XpAVK8M2NJaTaeen8eFzq6I+bOwdKAs6JYRZDl3ofyu4jfXYx843chcPJE9/Ey/ru5
 A3HK4ehGAMkh5wtEC9gungGJgjIM3O/kz2rXO8d1ZZBN1SDFZcvlblUabHD5zM9fbaNc
 azgbBCkoHef1uGNF4rzV1D0YOrNe6V9jVW9tmAlxnjzJ74aojdYAVIh+llLmmdYHGR+1
 19FdYN4knXIjV8NW0WI03adFVQrTpIwVaLSkBXHUpU/tBSbfbx7Crb+cpj2ANiH3Zx4X
 NPNudzE16IR+WCR1t7yOCmjakWQrKCKkWytDag1lUHcXg6BLSeroxkbE+6wFujy+ejn4
 JgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768403538; x=1769008338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ZT3Sa9ASlhk7HDjx1Bwk/ZOElZh8by+gNc+C5VlKT6A=;
 b=OzxNwj9BeKTEsQxxXViNNoaUqN3eU43EDkwESREpadK6EYthqIYQSSBOWqMxZcdJT8
 zl+zQFLdlxN7t1HsHesdTFiLreHm1qstCaXs+pBC9uzZqaf4lBrnY9+ZDzSF44cL/wMA
 751M6LAwE3o5wyg340alJR0n8M5Qdt4rVDYQwHu3W+8gZEQG0hruJ1Eyh76Yu/F5h2Ft
 9BaSH8N0GOU06lgXNCy3xgBH1MPs4TlRGMQuapgH7f2KGESplhVrggGVF+6s8qFKtj1/
 Kf/KiH+FTyIKC7xmM8zmhBS749fsVGhuBBDtpNNlh//o7iyuStUTi0anEek3bQdhOKqf
 TJhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU59AR5aPIXnndW0afCQiuVt2MFVFwDRWrey74CAj8syYHxZUW1kiA719TuwrRslJ6OtTP7I+s=@lists.denx.de
X-Gm-Message-State: AOJu0Yyyz2keYjYmaV53gh3sLXDJG8LB1Eo8uT54omEpyojgizaAIWQN
 VfqZFcw4ZqBKM9Fz7tkpzDh/bozu1xY75FlvV8u04Gr4XWjQHsL+K77utADHR0fCbKY=
X-Gm-Gg: AY/fxX7Rs65S8nTYOSv8JahuDfcfxBOZNtd3511OWHb2U1z55Q/Hx7x0giNFBEen0z+
 OzAhFdW6L2HulQ0jd68iKWYcaB0YgwRtnBpsc6T5wEMItymefg/hv+9JlrCg4Rj+KtTknHFB5aI
 uaiO4VDw4lf/RZFOrJ5EDmN7rzUpcfMAUZDhTQBS82G41mokI6xdq/Fd3Khi3jO4SK4c2Ave+OX
 1OoEd/IwlCav8FebQMEnzTrUdpBIxCNkmohXwDUDwOqlXCDgTNzGCrATbomjcU1cBUM7p1LRDOV
 ZSytef4h0555E3LK8d/Ni682Af+Ryurvsv0hEff8x+Xp8vdNpAlPgW0yZqWtNtjilS+WGi2fjXN
 4XYFfPSo22TNDA0OhuloWlGbVpTyMP747IaNLcTpIlZiLSO56b7Vii1S3yZE+nHe/QQ2mErfDmM
 EPbMPYBtRj+aFaKNfKKIHwZmo63OpubdhURtvfGnc=
X-Received: by 2002:a05:600c:1f85:b0:477:9986:5e6b with SMTP id
 5b1f17b1804b1-47ee338a5e2mr33758425e9.28.1768403538048; 
 Wed, 14 Jan 2026 07:12:18 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:2d90:e4f1:d19d:4c32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0dacc5sm50455212f8f.5.2026.01.14.07.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 07:12:17 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 14 Jan 2026 15:12:10 +0000
Subject: [PATCH v2 2/2] net: lwip: dhcp: Do not write past end of buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-tftp_fix-v2-2-8de8e6ecf4e8@linaro.org>
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
In-Reply-To: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

sprintf will write a trailing \0 at the end of the string so when
writing into a buffer, that buffer must be sized to allow for that
trailing zero. In the DHCP code when the index is a number needing two
digits to express the index would use up the two \0 bytes in the buffer
and the trailing \0 from sprintf would be beyond the end of the
allocation. Fix this by adding a third \0 in the buffer.

This was found by code inspection when looking for an issue reported by
Michal Simek, but I do not have the hardware to reproduce, so cannot
confirm if this addresses that issue or not.

Fixes: 98ad145db61a ("net: lwip: add DHCP support and dhcp commmand")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 net/lwip/dhcp.c     | 6 +++---
 net/lwip/net-lwip.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
index b798014ebcb97dee688e29ccb34da916296c6772..731b57de3ba4336a22fee5957b6e2163360d78a1 100644
--- a/net/lwip/dhcp.c
+++ b/net/lwip/dhcp.c
@@ -30,9 +30,9 @@ static void call_lwip_dhcp_fine_tmr(void *ctx)
 
 static int dhcp_loop(struct udevice *udev)
 {
-	char ipstr[] = "ipaddr\0\0";
-	char maskstr[] = "netmask\0\0";
-	char gwstr[] = "gatewayip\0\0";
+	char ipstr[] = "ipaddr\0\0\0";
+	char maskstr[] = "netmask\0\0\0";
+	char gwstr[] = "gatewayip\0\0\0";
 	const ip_addr_t *ntpserverip;
 	unsigned long start;
 	struct netif *netif;
diff --git a/net/lwip/net-lwip.c b/net/lwip/net-lwip.c
index 8741f65fe12e23cc30068506453a762533f8a67f..0fa33730a636727d0718625215a69002242810d0 100644
--- a/net/lwip/net-lwip.c
+++ b/net/lwip/net-lwip.c
@@ -108,9 +108,9 @@ struct netif *net_lwip_get_netif(void)
 static int get_udev_ipv4_info(struct udevice *dev, ip4_addr_t *ip,
 			      ip4_addr_t *mask, ip4_addr_t *gw)
 {
-	char ipstr[] = "ipaddr\0\0";
-	char maskstr[] = "netmask\0\0";
-	char gwstr[] = "gatewayip\0\0";
+	char ipstr[] = "ipaddr\0\0\0";
+	char maskstr[] = "netmask\0\0\0";
+	char gwstr[] = "gatewayip\0\0\0";
 	int idx = dev_seq(dev);
 	char *env;
 

-- 
2.47.3

