Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A59C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 21:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32C182075;
	Fri, 14 Mar 2025 22:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JJA+IMqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A0F82076; Fri, 14 Mar 2025 22:56:05 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08C9A82063
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 22:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so1160985e9.1
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741989358; x=1742594158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FIp+IINUH4o2qysWT7PhU6RsES0TsmNz1MD21hoDmyo=;
 b=JJA+IMqtU90jrAknWvh8CFvnFTdHfd3ZVugBJ3nvUDRN8KiVhLu/jcXMGlEphVQFx4
 MweuPa6KXY88svWapUFYLeVJZwu1bkpSe2fZ4r3oaH0AdNrDvLVxiYVji71b1CNLygiE
 nzxva+2kUVGDPXgr7HyxmNAL/BP52muJZ4ECp0Q0X8YWVJtTeN1GYdClIYOyuDhaikvr
 91Eht8VWxSRPHHBXDh+Zz0D24zYDocVQmrDsfess6HBvTvjwhUK+68iiQ8P7DgDmT7hN
 WAlFGDu5NKSCrh5adr6AGGSkc3yKpryUi7rNg1bL0EH8bS1RC8+b73/0Qotg/6FGSt99
 Y9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741989358; x=1742594158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FIp+IINUH4o2qysWT7PhU6RsES0TsmNz1MD21hoDmyo=;
 b=r8Xw+zKhtzFNnfeTZ/a8N4LTgPFxUQNRZiME+VI0AwRk9Ft8eTkZBXigTRGYFIhV6r
 GzV63tPrCZ4fFqKgyS6odGiA0Zuky0RVU6PqIwpvLhiaXytgEwGymY24nuDuJ1E41jNv
 YXgOk0xLuiESQiGo+tHSrDFJjGpdu3UlROtzg0jZQJeNb8MkYBh6cAENkhLkEmj1cXoE
 kZazWiYZdZfbISc/BATIKUKe4pWImskPu+oyqoOMk7L247C83yOc5PvjKbEo8zgucZ0y
 9xDMpnHqdJI+ZsLxaNguKnzvumrfpoy6twNQieDd6nG4LArrYfH8+xbN7EI2jWvOUrpf
 ZXNQ==
X-Gm-Message-State: AOJu0YyNM4H7ZG0jHV9ycIg28j+ISzoirCcqma6bjk2ycqPikzK0kYb3
 uLPbHoruH0H1Y9FrJP469wS6TnIrhEJIygPaDN8lteRMok6WfwR0kuiaGv8OniBjDau/0GfsrpO
 utXY=
X-Gm-Gg: ASbGncu067xgQ2UMr4rNqHCdlzdnTNVWxwf9yfesjFZGgT/6RxVrMHfYZDzXK6PcNls
 BZc6uWO8mDs/Zqu7pxX2XRIMl3UyN6+XXLFgBu1JNd+/3Z8TQVO/cqyu72eXnQek3dPVyNQpaGT
 UJfg5mXn6MPdspI4r2sDEIWaO4KNPNYSHGm17uItNdvLod0Lah7EpX1IeSWip6Xa3TO33ZsMjxg
 JhOQ+7HDaZ48GPo/9Ys4UnZA4py4LwCuJV4AG99RW+IuqxTWRp9iOa2TvfFFyGNOXGTFs0DxW7J
 Hy1dCO/1gLQKhiKuCL4lHGb3m/JgKjBbidwHiVeUfDhqVNBdrkYjvg==
X-Google-Smtp-Source: AGHT+IH88O2vX7Bhyx1IorikE9iNmXXXmYGK8ogFzzjmKDizcmJNucWr0apeFG+5Cium43k9Ovvcqw==
X-Received: by 2002:a05:600c:470a:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43d1ec76e4emr49569075e9.8.1741989358279; 
 Fri, 14 Mar 2025 14:55:58 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:5485:bb38:c353:6b0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe05ff4sm29064395e9.10.2025.03.14.14.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 14:55:57 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/12] sandbox: provide static IP addresses for eth{2, 3, 5, 6,
 7}
Date: Fri, 14 Mar 2025 22:55:09 +0100
Message-ID: <20250314215525.579655-8-jerome.forissier@linaro.org>
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

The tests in test/dm/eth.c and test/dm/dsa.c use interfaces that have
no static IP addresses configured in the board's default environment
file. That will be a problem when NET_LWIP=y because the lwIP stack
refuses to send ICMP packets through an interface that doesn't have an
IP ("no route to host"). Therefore and in preparation for enabling the
sandbox tests with NET_LWIP, provide such addresses in
board/sandbox/sandbox.env.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 board/sandbox/sandbox.env | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/sandbox/sandbox.env b/board/sandbox/sandbox.env
index a2c19702d64..29197f56e95 100644
--- a/board/sandbox/sandbox.env
+++ b/board/sandbox/sandbox.env
@@ -8,6 +8,11 @@ stderr=serial,vidconsole
 ethaddr=02:00:11:22:33:44
 eth6addr=02:00:11:22:33:47
 ipaddr=192.0.2.1
+ipaddr2=192.0.2.3
+ipaddr3=192.0.2.4
+ipaddr5=192.0.2.6
+ipaddr6=192.0.2.7
+ipaddr7=192.0.2.8
 
 /*
  * These are used for distro boot which is not supported. But once bootmethod
-- 
2.43.0

