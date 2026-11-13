Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B117606A323
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NHZRTtTp;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=J7pok9y3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE118813C9;
	Fri, 13 Nov 2026 15:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HY7ez6I2_-sM; Fri, 13 Nov 2026 15:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 12C678135D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794585309;
	b=i00PpApGc04YSINKn5o7xrWRcXU8/2Su6AJPteEadQ4+L9ccFg3NPfasYdokojRspbqn
	 HKRRC93DZYegnbEW0NkvHBZXsrFjpI2gwWzGSg/sfYHSaedbzbWjMCAobflLQO1twM3kN
	 N1StqUdLmIFDBE3MCUf0NmyBm+HFf+I7HxZD9oGWZhqntKEXFI54TGz7Exhm7kKYfnXWr
	 v9qjvvcTyWhJK59TDdYikthB3uh5on2Y12fPi1dnz8tQKdQHZvyO6ZK8I2UM1HAOLeba3
	 Q+bJWFrIdxGh3KB/zIK9v/9RvUt4UyG3HIhVBx4wxNJ/REpjeZ0k0+0tS4BrzH8DH+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794585309;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Y6NZ3Tp08eFnjTiM5i3Y+Bu6iw7rUyO3d9LPpijQKzE=;
	b=PbyLicTRnelA5o3nPzlPqcRejQ/LZPzdxQb4wCDLRodMZtaX4/0U1Ko2DOP6Ikk6hK7C
	 6CJxg2r8U6vraFLt5nJHpR8HEUysSkbow9LPrQ75drKw5nU6U3ZcBjLvuhm0RAZfcm9l7
	 YkWo47rxjDhPbSV2z6+uAWjOCpDiiOKWJroxLa8Nnb7+IpyqWghDRU69EyCq6xjBwDgXg
	 2ptrfj6totG3funtKHZXD6LXwUqqi57e2mL/5IOjQwTOmFBJ+uLBpe+8ZUUKnbjywOnI6
	 eI5x2IteAb2AbNJI22hEzWa7zX4gdzhqGxcRZw4BevhtvjGXjdaHZsH/RQq+THzdwag==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=J7pok9y3;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794585309;
	bh=Y6NZ3Tp08eFnjTiM5i3Y+Bu6iw7rUyO3d9LPpijQKzE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NHZRTtTpqekMaLXs5ulR1CILa49hy0TcVW0X0PAiuTJETy6Bv4pSSYEEDJS4EuqSZ
	 XujSMSQ+70iXhtM4GvUqMEz9NexivuYLYe11ngd2Cfe7n+3Z1fhtfwCgJf/TQMnyOX
	 LtJqUqFdUBBq/Sz8XZ0xWkAW8abmst/DO0WJlpMMb8AkUucunzTm0QjnFdP494bDJg
	 fFMoQNBAS6cWQaSrjIH3sv/M6SKWsPSmkDHSvObESkih343c/cyJC0gzNp5K5aNx93
	 WrluJNpgptwSFLl/rvFdWgWo2PDt5HfK1W7/kKg9rKU55RjXgVbckNwUv2z/voz5In
	 YzaS7tQjVPi0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12C678135D;
	Fri, 13 Nov 2026 15:55:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E426F46
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 73E088135D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LpGPsBirfLpt for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 15:55:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 466A58134A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::42ae; helo=smtp-42ae.mail.infomaniak.ch;
 envelope-from=foss+uboot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=J7pok9y3
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::42ae])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 466A58134A
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 15:55:05 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jR1pW1DF7z1NM;
 Fri, 13 Nov 2026 16:46:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794584818;
 bh=Y6NZ3Tp08eFnjTiM5i3Y+Bu6iw7rUyO3d9LPpijQKzE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=J7pok9y3HC4gUS/e4KJi0UWFMzPXhG+npOWBaJqvIcGCTfjp3tD+DqjY5Klhh/k/L
 eQBu31oEq0TuO47nF6wEoNsP9q//o4cBK5OdzRc9PGA58fRPd+kIo6cSw8/7uuhyt5
 aw2wsY0v+9GEuxvfD3l+9/XUstYcCni/7+w8OV9gNSSVh+ozkLuvS4RCIIXzeVn2Qg
 ZNBWqnCxu+RogAAdvWn99OrTY7pnpO1/vEqsWerB9mgIrQxwmkannFDHro3NFRZI4f
 5fvwS9pKQ+Bx0xvehZ7a0ANO6Xv3v1H+PA7NQjDjlaLmU2ToAKQimvEfLaOcMOFGV5
 BXdyBRwp6WEpw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jR1pV1zKszKQQ; Fri, 13 Nov 2026 16:46:58 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 13 Nov 2026 16:46:44 +0100
Subject: [PATCH 2/2] rockchip: take over maintainership of Simon's Rockchip
 boards
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-take-over-rk-boards-sjg-v1-2-4278c885ecdf@cherry.de>
References: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
In-Reply-To: <20261113-take-over-rk-boards-sjg-v1-0-4278c885ecdf@cherry.de>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I don't own any of them (yet?), but I would anyway be interested in
patches for Rockchip boards as the Rockchip custodian, so add myself as
maintainer for the time being. If you read this and you own one of those
boards, please consider adding yourself as maintainer otherwise in a few
releases their support may eventually be dropped.

Signed-off-by: Quentin Schulz <foss+uboot@0leil.net>
---
 board/firefly/firefly-rk3288/MAINTAINERS |  2 +-
 board/google/gru/MAINTAINERS             |  4 ++--
 board/google/veyron/MAINTAINERS          | 10 +++++-----
 board/radxa/rock2/MAINTAINERS            |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/board/firefly/firefly-rk3288/MAINTAINERS b/board/firefly/firefly-rk3288/MAINTAINERS
index 174027e770bf..e34614ca122b 100644
--- a/board/firefly/firefly-rk3288/MAINTAINERS
+++ b/board/firefly/firefly-rk3288/MAINTAINERS
@@ -1,5 +1,5 @@
 FIREFLY
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-firefly-u-boot.dtsi
 F:	board/firefly/firefly-rk3288
diff --git a/board/google/gru/MAINTAINERS b/board/google/gru/MAINTAINERS
index 53257c52a04b..7c9ccc55c1fd 100644
--- a/board/google/gru/MAINTAINERS
+++ b/board/google/gru/MAINTAINERS
@@ -1,12 +1,12 @@
 CHROMEBOOK BOB BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	board/google/gru/
 F:	include/configs/gru.h
 F:	configs/chromebook_bob_defconfig
 
 CHROMEBOOK KEVIN BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>
 S:	Maintained
 F:	board/google/gru/
diff --git a/board/google/veyron/MAINTAINERS b/board/google/veyron/MAINTAINERS
index 382ad212569a..7dc43dbc1065 100644
--- a/board/google/veyron/MAINTAINERS
+++ b/board/google/veyron/MAINTAINERS
@@ -1,5 +1,5 @@
 CHROMEBOOK JERRY BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-veyron-jerry-u-boot.dtsi
 F:	board/google/veyron/
@@ -7,7 +7,7 @@ F:	include/configs/veyron.h
 F:	configs/chromebook_jerry_defconfig
 
 CHROMEBIT MICKEY BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-veyron-mickey-u-boot.dtsi
 F:	board/google/veyron/
@@ -15,7 +15,7 @@ F:	include/configs/veyron.h
 F:	configs/chromebit_mickey_defconfig
 
 CHROMEBOOK MINNIE BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-veyron-minnie-u-boot.dtsi
 F:	board/google/veyron/
@@ -23,7 +23,7 @@ F:	include/configs/veyron.h
 F:	configs/chromebook_minnie_defconfig
 
 CHROMEBOOK SPEEDY BOARD
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-veyron-speedy-u-boot.dtsi
 F:	board/google/veyron/
@@ -31,6 +31,6 @@ F:	include/configs/veyron.h
 F:	configs/chromebook_speedy_defconfig
 
 CHROMEBOOK VEYRON COMMON FILES
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-veyron-u-boot.dtsi
diff --git a/board/radxa/rock2/MAINTAINERS b/board/radxa/rock2/MAINTAINERS
index b789557a062f..67e4a9fe8ab7 100644
--- a/board/radxa/rock2/MAINTAINERS
+++ b/board/radxa/rock2/MAINTAINERS
@@ -1,5 +1,5 @@
 ROCK2-SQUARE
-M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <foss+uboot@0leil.net>
 S:	Maintained
 F:	arch/arm/dts/rk3288-rock2*
 F:	board/radxa/rock2

-- 
2.56.1

