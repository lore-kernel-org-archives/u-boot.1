Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAD606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=VYWgK7tm;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OR64LcQK
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04542605F7;
	Mon, 23 Nov 2026 19:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O2h-Tre5Bq0m; Mon, 23 Nov 2026 19:38:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5153A60600
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795462685;
	b=qx1M+kwh86R5Sv0c85OEdr5JF3mjIaX4e92NtM2cAxFPbd1RIpXhjzdmxxojGF20KE9M
	 nQi//20vvEBSo7t1/Rwc1ak27zYt+szJ8a/yBsyyXNuUD9RMp1CwcouTQs1of+kyEgu/1
	 jabUlpsQ226LjJBXw7oSmYZozvgCnlTE7yCO+Yua3T0SAHMETQ2ZxnH9kGzRSAnEZW66X
	 0UCaU0dM+bbDTjmgYKWuPxfktD4VHHhUnLqc6k2qRrFZ+z1p/vOCIbAOot+C3mB74VyP5
	 +bFBGzMjm0lQ2+CS+9l8Cg3839nOdIqm5i7NQcT5aKeStjqNa2Ta7A2kfvUjhG16oaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795462685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rkfCn++NzjQpzJq067zziR6F6s0bNOWK7HXPedeUJUg=;
	b=o7MlTJ+uXfsjh1jT/wGwmN8SJgzv3CAcljkQrK8mJZBVSrSsodt09Zz6PGw1iJ6Jjp4/
	 8KQtsl02I+5CSvrhgOi4bWm3lPJ6/qQCnJ7b9g5HDie81kzpfsEIq0rupptVI4ik8wDDx
	 ZLEzRBSW99abq2e9cTVbQWJSmE4vSKMmz/RVtodOfzYUbmk3tJO45PoEI5YlS9daoFanD
	 HvdL9ioImfv3TEVmL0fUnoXkI8UbLA2MRgsXhMYgUNm7QxAY4SCjD1zcdg7+YqpCfgg1V
	 Zas+gvznRIRj0RB8I8iG/rh5y1j5vbMWiBtD0Rrt1NQADiuUKFRRiCi38mkUoSmMIIA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795462685;
	bh=rkfCn++NzjQpzJq067zziR6F6s0bNOWK7HXPedeUJUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYWgK7tmQUON+0Mck/QLimed0Q4L3tcTqkyLB9d+xkl+bv+Ef+Ztvu4g3SZRnHedm
	 T3lTpxgzs+C+Ox4zh0x+qVgWiv+YmN65ihuyBtvdVsbRA/3AyCjuhNsBs+MNKkj6G5
	 BkGvY7ky7wDzURm8LNtsvzfzCgfLNFaRET5jplobvwOqjz9lxYB/Mb0Tn16eKewFh8
	 CZJvDkMVcL5Tr7YSeLuJb3VhBWZtQMWsfroiHhYnREwo6yGee63ZiiVYSgqWQ+IyJ9
	 R7fK3dDXwWTv0eNsUWZviV4MCBGYh5HoFRx7ALyMevCbi8YM86o1gwxEsg+izcZbuR
	 oLN3uYpNMEAQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5153A60600;
	Mon, 23 Nov 2026 19:38:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 72FE83A8
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 58CDE40721
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:38:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wgRgJ7x38p0a for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 19:38:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 98FA5406FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=OR64LcQK
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com
 [IPv6:2607:f8b0:4864:20::1332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98FA5406FC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-3282db206d3so351601eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 11:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795462681; x=1796067481;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rkfCn++NzjQpzJq067zziR6F6s0bNOWK7HXPedeUJUg=;
 b=OR64LcQKSmgTgPxs38DVFVowZ1LxCo7Qe/W/kn5U1EbvETRjg+AwtBtmtUIOrn6dHY
 CaAqu3YKAfOXHuXhTMpYHFJbkM/1cj/urZNq3ZvsSJ41xntevlZP/Mcubc0ODZQC0Pm9
 xKR1XrQqAsXuAqY6ZckFcdX46GVA+79/0RlDe8mS7yZssbEPFAizc0n4VMXmEQrZRTBw
 KM0wYl+UAEHint/mBvqKdUQlWGuhTxoxnRaEbW5c87M4SXMncEugXME6fDzw6hemQrya
 MnZLdPTITSdleVhBmXk9UZlO57fp7NWUEW1W18YMrBQ0pYrz3iLBevJV5p0fvzRVzJiP
 HsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462681; x=1796067481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rkfCn++NzjQpzJq067zziR6F6s0bNOWK7HXPedeUJUg=;
 b=dHRQIScSwA+pZMAE9N4AVcfd47SUz/mIUsZinGMwF+R6XBkB9uVSS3EtsLcrkhDp0I
 V87xmijqxyNt3PnFbgCFLwNXKT+s6GrjSo2IS2mNXM8gUcFB2jHadbHpg51Vz0CzB9vD
 2kyrVhcDYPIun6aZt2coLEaycyhfC3+Kyw+HMY9pqesZy0xGI9ugbBj3G/p5zL+o9wV7
 ut8h6biPJ9OUlEGYE4SB3eR4OcBCWq65OSb/MhcNnXU5zAlst3n9xlbT05sTlj/ox/f2
 LF87ra3vXHTcHegqOrCYXpnb/hIPzVwrmYgWzmkIKxz2ybEP4jgW4gt8O7IAoCc1OTSQ
 f6sQ==
X-Gm-Message-State: APuU4Z+TenvN/KBkq4aoANMurSdPChjd2+Z1NLmstf47SEiWR69DdC9o
 XdQlGz9QyuSR9YbxnCFzXzMJiD3GD9uBLf+q77cYHdVwWgn+iN5aIBmzur2YJg==
X-Gm-Gg: AZFdTZd8GFJ0Zxxqz06UtA+nbaCkx4cycxG1DOUdhBit/5yqjBt4B0Gbvn3wM9STDb6
 7hAOY2oHQLX25igWmgtB12VJbBprL4WVbvPUjDer2NFqQlhFmPmxpb2y4UIUULvzpbpA9L4AKTs
 DSRlVpswqIkhiw/7B1qgBEwuAfw6WBtkn2fKKH5jGK76YNXnRrOn2twcK9wVj2tyQG/o8oOdG6Q
 RC/3UXr4Ktep2tXkA6d0yM3NZdlBhm8chaYwbE9yBoYefkvrQPlpdSvyEKlpSuPVZGrQBYG/C8r
 A4CKYV6yaQU9BmaH/9pADaJ3EZNrLKyvM3ysOAWy2Y0p4pRC5esOxquVpWNXevHZQiRl4rTSOH9
 5WiKO8R3Uq0oW+r7zYIEecXIy/Q4p7/LbjSUk+1ZmXK2TvHkmhQMigxSeiEF/+D+aZluao04LYJ
 fuMJPNY/EqmPqY1BPS+3Yy2iuK5DkHBGjF3YIMwpGxUs6kuSs/zokq7KCjRmrMmT1cjIHMdbdUy
 au2bOOkcf4d+LrR1FGnOOG9wTKc+Sh3L5rqhaLQkEpzGJawm9UYKEk4ANUlHdmw1+qIJk1ug+E8
 KaZRcPJ4UwNaw4LRbcS/OMDDAnNzM4C90sTwFWDnWgM2QCNN2w==
X-Received: by 2002:a05:7301:4209:b0:369:fc93:eda5 with SMTP id
 5a478bee46e88-3857054b988mr13838188eec.39.1795462680818; 
 Mon, 23 Nov 2026 11:38:00 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385677c0c1dsm41796268eec.21.2026.11.23.11.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 11:38:00 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>
Subject: [PATCH v2 5/6] gpio: spacemit: Add SPL support for K1/K3 GPIO driver
Date: Mon, 23 Nov 2026 19:37:03 +0000
Message-ID: <20261123193714.5096-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123193714.5096-1-linux.amoon@gmail.com>
References: <20261123193714.5096-1-linux.amoon@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allow SPL to access GPIOs on SpacemiT K1 and K3 platforms during
early board initialization, including GPIO-based card detection
for SD controllers.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/gpio/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 7f12e39dad8..ac7bd642cf6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -457,6 +457,13 @@ config SPACEMIT_GPIO
 	  arranged into a number of banks (different for each SoC type) each
 	  with 32 GPIOs.
 
+config SPL_SPACEMIT_GPIO
+	bool "SpacemiT GPIO driver in SPL"
+	depends on SPL_DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
+	select SPACEMIT_GPIO
+	help
+	  Enable the SpacemiT GPIO driver in SPL to provide GPIO
+	  access during early board initialization.
 
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
-- 
2.56.1

