Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D95606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nTZ2eM5a;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GLVMyENW
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80C5C40A58;
	Fri, 27 Nov 2026 10:31:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8rlox_jRpUG4; Fri, 27 Nov 2026 10:31:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D8B2C40A60
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775505;
	b=V9I/9e1wda66J4zqEQ/pmcsnZSF0fvXIiACPs2D8o6BWxZzbTlJ+UTrOClELOGcvjTla
	 DfW/QgpKSg65yCsxxkQLE7uopYQf5vl4USsUjLI9wgtTspIXQTFx96sC46OCACpI1If3C
	 iC/o61P9COFB8G3VyNf0yeOjHGsBAvkjWYGnYcDcbNrLjoY9JfGSMFpas8FYe1zjkujb5
	 y9tjN1DDfgMVIyWaSrpz7nrO4HTp851bUj/sdh2JxqZZqskSwtyegqJMZrbGdHACVSp17
	 hx8VeJnSFmVaH8tykDuy77MaSMsfZ2yIrMBNDU83RTrTFmvU361SFy0IDInvU/lHPEw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775505;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=z6qlXA4r/lVnPgyfVlGJ8cYzSr8U/8Wv7p3yzcTw3Bs=;
	b=IO+IjvLcbw3poZuKT/0/MGbxOnz9nInTa8AWXJSDdOfSunKVRNnRfmNm6FKzghgl6htI
	 bNDnwSNVPnTRKuxRq8vrtRSkkbStG+m+EPowwN6G2OSypIHZmH4co9oqvu225kCSN2vJ7
	 ylzreA1+61aH3SD6CNcGVnYog8QS1Ew+Xzyi/bBy+5Futo3mGySEONcsosNNyZ6bP+VJ+
	 6prYklfN/Q4C1T2prOipR4HHkztfxBd4T+k5j+jduc+fbwMNcECPyTklMkOnsNPY+foH1
	 ZQZ96bmoJYc2eWRcKC25n3PHHodtjwicVMpa1nwt0ixAdNNcLlK0gPxgLSIqtIXiVaA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775505;
	bh=z6qlXA4r/lVnPgyfVlGJ8cYzSr8U/8Wv7p3yzcTw3Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nTZ2eM5aNRV39oFdaWYPfLm60SyXXqQI46YIqGm9YXdfyReBxco/HbEZY0UfAkQPS
	 t8GIQ7UaTXxh4aRyIMt3htG6f5k8w8BstrwwWMCm7+iM86Q0saZtXKdex+xsJsEOT3
	 JoWwz5xvERFCtRXkMdyIm3w4lVYYyu18fwRxvySVcHhgWWmxe0/vr1ew9h29mcIOqh
	 f1zEjLNT3Rwlo/s0HsoBWT1epdY7XlDEeSDhfjEceHTQp+av3gIX8gJ4TGphRFNuyx
	 kGVrCyb7szHLlNDq4hvn2Rmbgb242893KA+7mD75xS7qe7FX67hRQZ6CrH7+WANk9P
	 wCUWPxzoJzg/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D8B2C40A60;
	Fri, 27 Nov 2026 10:31:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D53FD1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F3B0260AC2
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pKc-tXwMl4ZE for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 546C660AAA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=GLVMyENW
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com
 [IPv6:2607:f8b0:4864:20::1336])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 546C660AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:41 +0000 (UTC)
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-38431138772so10310267eec.1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775501; x=1796380301;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z6qlXA4r/lVnPgyfVlGJ8cYzSr8U/8Wv7p3yzcTw3Bs=;
 b=GLVMyENWVdtmLBcS3EK1ckjDeoHExkcUvijyY0ExmWEh2yoE3iuf2D2cflZR0O8H8N
 8kz9xrqibyt+LB+GQl8tqRky/FlSA1mwtgKv2x6LrCSa2p0p46uYvPAahmzkrg/UaPLe
 I2AOL0HXXWypiKSDuadiuPFO+rITMzq79i11igknyo42U2Vd+MK+CkZ8EBilSoVXEn+i
 FdCuSgaQKtm8po7xGaWFSMyW5NV+Hx0tWvC8qxPhr3HbusExai46W9GehSxd8FML/sUP
 LG5WTdna0iZZcpE4TI+89yt6jxF4WM1AW7Wxa3Dpc1S/2joHJuNJcRPTP/FhE23SXTec
 GNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775501; x=1796380301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=z6qlXA4r/lVnPgyfVlGJ8cYzSr8U/8Wv7p3yzcTw3Bs=;
 b=NZKjAQwjLTkXqJ8gQy26n33J3h+HFw0qIuSBdg22Vt80HMtAQ/wW3qCJ5IQ3dO7VNN
 LU1U9W08txlu3KTjQRkmf1F/YsTtzqWAKkRF8pmx+QuwmIATcvuFxekUrsqcAaFWf9/b
 9EKUXBoo7qopeodBwS/10/36Fl03IdM9MVeQ24Hl93RX62Dp4/xnPXVp+cSoII1MnDUv
 melB3Eu9gNuvoU7P2MZVMP3Wgz7M+rJv/eqZ/rVjQuqm0yGYhB/ytCHfnXVDIGqYZJHv
 74wuvxrhdR77WlTVS+gX6Z/m6qnzF1PQU9MtN7Tecu3fEfwXsNswGSaYJow3yRoaAyTC
 Lg6A==
X-Gm-Message-State: APuU4Z+T5MTlH9wcurzXklX3QU23Zl6D6rM0dvNxlaaZEPPQdi3hQ9iy
 3wDQI7d5nN+TXS2Alm5ONUxt4NE2K5Ac8h09ErWbK0d467/WA8iqYO/1Vz86Gg==
X-Gm-Gg: AZFdTZeV2ZSrEp6smMa00HrdSoXMdBtWH8OY3VCAJhX/WlzO55bpXpMvKjPiZZv1RKX
 Xyk3ocXYF8TWiCH403DriooSH4JJZILwrDCUexc56rbfe+k4HmA0WpIQ43XHGTIa7nJ7IUpqTAK
 vVTtF/SXV0LqD88VGMGzBvq0X5lj2gKu4MAsy9WWiV0qFvY1lKquGnN5feIgSe53yjK5j+e2LKK
 l5u692BSj3Mmgqp0notMmXlFb9iWXlh+y/nLQnDjdDd1mEedsYTQgL8iFcqAXJbdrhemXhrj2Lr
 Y7O2Yz8F96HtC+nKob+c3qs9/m0ZFd4macntp8SkU5rdbUbDSJnjWvPKH1I/kyAOMg0TKOE2d0h
 FL/lZ9NHfXnG2XNKUyNNoIXM15sBUsfnyvYGURRgHZK5BDLxUmezBQscyOJ0IVWGuPv0wO5uKsQ
 NtikBXPDPaRac9jS7MPSaXm0Ku6nBkNxOn0v1j59trnobEIKkanU8iXMYXaFYtCzkoDXph1+yf0
 31NNPx8jDFfPNiCK7nN2cqwudbKv9hxD1poobmibZwTYtdf6Qr7z9fH7TTxEPCaU5dD/lDALOmO
 hR3HYrOx5Ghri+LWqdAsdFtlKiTZ
X-Received: by 2002:a05:7301:4281:b0:386:a193:9afa with SMTP id
 5a478bee46e88-386a1939c38mr19985606eec.11.1795775501086; 
 Fri, 27 Nov 2026 02:31:41 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:40 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tom Rini <trini@konsulko.com>,
 Raymond Mao <raymond.mao@riscstar.com>, u-boot-spacemit@groups.io
Subject: [PATCH v3 05/13] pinctrl: spacemit: Add SPL support for K1/K3 pinctrl
 driver
Date: Fri, 27 Nov 2026 10:30:04 +0000
Message-ID: <20261127103030.4647-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127103030.4647-1-linux.amoon@gmail.com>
References: <20261127103030.4647-1-linux.amoon@gmail.com>
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

Add a Kconfig option to enable the SpacemiT K1/K3 pinctrl driver
in SPL, allowing pin multiplexing and pin configuration during
early board initialization.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pinctrl/spacemit/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
index 87cba336923..ad5b458480a 100644
--- a/drivers/pinctrl/spacemit/Kconfig
+++ b/drivers/pinctrl/spacemit/Kconfig
@@ -7,3 +7,11 @@ config PINCTRL_SPACEMIT_K1
 	  The driver is controlled by a device tree node which contains both
 	  the GPIO definitions and pin control functions for each available
 	  multiplex function.
+
+config SPL_PINCTRL_SPACEMIT_K1
+	bool "SpacemiT K1/K3 pinctrl driver in SPL"
+	depends on SPL_PINCTRL && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
+	select PINCTRL_SPACEMIT_K1
+	help
+	  Enable the SpacemiT K1/K3 pinctrl driver in SPL to configure
+	  pin multiplexing and pin settings during early initialization.
-- 
2.56.1

