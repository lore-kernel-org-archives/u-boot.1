Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FC3C79F9E
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 17:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B493580CAB;
	Tue,  8 Sep 2026 17:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lcr0sSzk8ANR; Tue,  8 Sep 2026 17:05:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D06FF80CB8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788887110;
	b=LgWmESthbxFf/4IpfmuuqGZs4OsasyA2e6kMr0Hz9xEs+0HW0seTMSrGUAWXsO8LqSnl
	 BR0jU4HGKC2qvfo063/99SjF2zMXAyDylVCVhqHNkBzCax6UJUNfENm2WyVBS7EGC+R8C
	 Z0bllECJ6ehZIgopMhJQreBJ50nmuqahVDX3NoIJO5/hBnxBkoe6YMLZKIWqqD4ng9RvX
	 DgBz+IzuLuxJ37e9bR4K3rel4ra25g9rdp8UdXZi4Irr8diJ4ghK8jpdAjXSLSw6lKh8Z
	 sfUFueOCwdSkGVPF2orSEz8kHA2AQRdXE1sxRASH8Aiv7VVcFpuqiRKL0BraJOpjyjg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788887110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/8IHMlwrHMmP25ZjlpyqfT1Y3JBgUmFQYMZfgeJItr4=;
	b=HjVBk2elJTtAWIr3D/K9Z2n6Y3LV4eh96i0N4eheB9ZKbeC9yr70UrwafgQGzGIjGp3h
	 I4nMUY2B2ibaZtjgOrKMWk0BkGy+Q/4jh5tSxxB7+HgZKImE7KeXRQ7R2IhZP9IPTOx7O
	 IybSrYR5Hzj5RBxjb6Mug9F6YeRtcemaWfEANBOMB3YV6O6IbkS0MIXyXHvl7wM8VNWwq
	 p5dOWeO4xu2rgTzq4XwbDzidxju+5MmqU0GOyX2tXhhKjrUBwFNcnW/AkC8WrkbiR9Lls
	 sWh2pTr1HnWBgwVVY8QhYDO77r4y1ss1YoYtW1Ru194MqHHnjr8yAiA48O8J0EqqExw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xkd0eCEA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788887110;
	bh=/8IHMlwrHMmP25ZjlpyqfT1Y3JBgUmFQYMZfgeJItr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B/5UrX4OljMKg9bSIYQG+wCkh47Y58mi4cs9BysII4SXICLZz9U5FDKigZwLPlsHI
	 uW8ntk8ehfGHIknu5/k728BMiKev0h6NGUeFlgRzUN+vRJM4Pn8RT91TKV1/4jrM/y
	 6LwEhh9yf64hKR4nkd0DrA8Pawg/F5ZAdo4SYGgWUH5qAkAZsa0fcyynJocLtzq0pM
	 /2T0HOE9OzOuL7PzFzT5whoRMpfoPtKrDTKPBqurCr26A8K8yhhLccfgOiagn1acwW
	 ypV4pIYHOY9vQgwzR2XGDy0UkgSzasf229rCKrGtU9jdrjS8GVbcvz34wGNijYO4mF
	 vS9+BkNUWGJ1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D06FF80CB8;
	Tue,  8 Sep 2026 17:05:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 64000372
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55CE980C7A
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GkgO5s1iBthC for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 17:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5966580C6C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788887106;
 b=NLHKh8ZThGu8WaDd2aJb/d0jw+lleC8XUAhGm0mW5YalwB6gY2Wzj5fqIqUxmkajfink
 kdxivEw4aaMsZkQVB7bRa5JbTl9OUCnKMSPStFpS68PxvZzyVh9+9+g2C6fgRwhEiV3Gm
 jEpHWCHo9JJx/T9sX6UgwEC2PvZgmt9dUEtlflZR44zdgz6+LTiR+jiB+LNtzrJFoSy51
 6Yzah1kW4n0R1pbp+iZMzetme+M963CgMYW6mtjL0lguph416oyHiVmcN3GaExmjx0ke8
 at8mg5yp7YHbUxu2AG4jUSjlkL/ni++1wtku9RNny1gMINqsumPS4+rqfEk2Zpy6hPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788887106;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Sender:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer;
 bh=/8IHMlwrHMmP25ZjlpyqfT1Y3JBgUmFQYMZfgeJItr4=;
 b=AJZU4PuaEqg/r4x3bFX9y3rUGzyPmKSAheHXmogHG2QRfzpt62YTsxLWAmeUyJQ0Aox8
 iYMDHhUyrP4MlyuChpW5R6aU9rMkqJL32MTlQ1CNXBETd1V/NOZ774yuI9v2Ef7NZaKKY
 7EN7KrMqxorj8htSj/buDrtAz990F23E8pfIBnytSut8muvuBtTsDYAZ2bQP8RMPSHfWY
 Z7cRqR/Nyh0UZ0SV40ciOq3DuATa2MV5MyFiuleEB29bKjPaaF9dV7ow2wYL3wvBQpyDw
 j0K9qeX/mlZ9tXJyROu3dIsCwZ7XPAZzzuTDj9WmPuhVIk8yMxHseLrHY6kS9MCPQtQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Xkd0eCEA; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=massimo.pegorer+oss@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Xkd0eCEA
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5966580C6C
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 17:05:06 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49557167508so57963075e9.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 10:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788887104; x=1789491904;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/8IHMlwrHMmP25ZjlpyqfT1Y3JBgUmFQYMZfgeJItr4=;
 b=Xkd0eCEAppoRGAvPOKwbWm7UvqyxlPJHV3hvvgFJpBGinLKTYcPUXurBhTbOgCXdEh
 Mg+DO5tpwKPpTYIREuqCRszYqqMSLo7zz7dMiJpFVJYcyLi4Dl56UaU1Wvug+xn2NmiL
 yrG6N3Jy6kOZyjw0yK3MFdiYhIb2gexPfw6OrFkdYd9XH3ywXo2ZMvj49FRcUApppFS/
 5wpl1evopxr6DnrMtQWLkOIfLQ/cszRyBxLEq53oHQXjXgmOXBi4RSxlL/yChsHZ2e8J
 g2E1KkeJbnxwIFLJj3u2xl+gc5nSl+U6/R3pwVZpUgiDXVwhtXFoVkstmo4CPQG3+KJn
 ooCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788887104; x=1789491904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/8IHMlwrHMmP25ZjlpyqfT1Y3JBgUmFQYMZfgeJItr4=;
 b=RmLfeVp8bkPZXvvvcL9BshfFerPq1IGVR6krFucLNphaia1ZOKorYyMSoWNPfK+H5Q
 HI2/n70+FceNLm47aWMQmugXgZoVfr979KVKBpN2SYHtyn7M1xpNNsqOn0BX3qNmA1TG
 02tasmSMlA7RV2jR4LJvI2+DK3gu3/poYw1uRJcCMTB92GrWBHL0+iYtT8OLQuFrdVjo
 AmQ9bue9ETUljm+30m6aOn6O1FHkADMaoXd4nOLOgjrI2BwCNwqynqk8Si8RmXjqIJKv
 oBaSkxHGWIr6c3Pxt1dbBEqKen5j2JPtiHCASCDcRerezxTTRn/+zOC2MhrHZ9+bqd/i
 3eSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylValNe/IuZqvpscNt7YPeJrqPoSiBxuf7nXxPTTY87ppi+/99ek7uPUSbH8JE0JnH8nu7toU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m+EKuTpcJXbR4kD2GilX1wE79BuKQVQElp7z4rBZwGNZaCtytT
 fEoutqxX1QDMMD13gWxM+3xWo2Yc1yBMcUbdltPqRSFtE+kVBD7TCawJ
X-Gm-Gg: AYBFou0XLc3dPnOJMuGhiD8jwIaRJuhMsq2vdUzaQHlIEZHKc39h6qq+28sFjaTYIi1
 lqqiZLHKQWq347T9NKGsikiok4g728xecl3uXwJaGv6ajhMLkFRDILptKtC3yHjW/eLXBfvzhN9
 YSBSAS5NUbP+zBluJWODnzaShCnaNhVCcsiMrvewfVX72y2ztfENQyyOZRAmzws4xfYdGXpMHwD
 SGqQcBnqxaRXJeHQyuB+hhNeyUkFC5WbtMZtgWVsTtteczG/Lzk+mEgyiI+9ghZAb96/lcTbGEQ
 R2K+DRvnGI0IZJBbRKS8WWXt2cUTcBD3koInJSNgOuoZnWpLzcJX3CWHoc5u5H9+DhyhbZSh9H+
 xMvKJ3yn2ej0o1yrCPLGoRWUHTSlfXhSXaiDRoEarnKccT/EosXErk2VsMmlZ6ZapB4+vIb9hb0
 syOnIfwsfmv2AUDkJloXYqWrG06/6GP0DtiEoLcLvcRWxlLXJcihyJzloq/lU4ZVK/kjhTkS0=
X-Received: by 2002:a05:600c:6087:b0:49c:d52e:d0ea with SMTP id
 5b1f17b1804b1-49cf81e3454mr653362555e9.4.1788887103781; 
 Tue, 08 Sep 2026 10:05:03 -0700 (PDT)
Received: from [127.0.1.1] ([151.51.150.229]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d04fe7f9dsm306863755e9.0.2026.09.08.10.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 10:05:03 -0700 (PDT)
Sender: Massimo Pegorer <massimo.pegorer@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Tue, 08 Sep 2026 19:04:59 +0200
Subject: [PATCH 1/2] arch: arm: rockchip: Skip needless CONFIG_TPL_BUILD check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-xpl-v1-1-58e9e5248c29@gmail.com>
References: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
In-Reply-To: <20260908-xpl-v1-0-58e9e5248c29@gmail.com>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 =?utf-8?q?J=C3=B6rg_Sommer?= <joerg@jo-so.de>, 
 Carlo Caione <ccaione@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Just check that CONFIG_XPL_BUILD is not set to select files for U-Boot
proper build. Indeed, CONFIG_TPL_BUILD being set implies by design that
CONFIG_XPL_BUILD is set too, therefore CONFIG_XPL_BUILD not set implies
that CONFIG_TPL_BUILD is not set either, making its check needless.

Fixes: bef9fdbed2e5 ("arch: Use CONFIG_XPL_BUILD instead of CONFIG_SPL_BUILD")
Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 arch/arm/mach-rockchip/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index d3bc0689f89..8148816c48c 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -15,7 +15,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
 
-ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 
 # Always include boot_mode.o, as we bypass it (i.e. turn it off)
 # inside of boot_mode.c when CONFIG_ROCKCHIP_BOOT_MODE_REG is 0.  This way,

-- 
2.34.1

