Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2F606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wHKyM8aG;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DyNvPCoD
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF450409E9;
	Fri, 27 Nov 2026 10:31:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NBDfAhKINj8Q; Fri, 27 Nov 2026 10:31:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 01FEC40A69
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795775486;
	b=iu6ovLFU3RuyCgc9dfo2tWJhgr4zrlIX7sre9T6N7aXHQmnm5YoP57lxCBvRknonGvOq
	 j71Fwy6Flzs9U9Mo14JXJhzgTjUiRrLiz7CLJv5lQJ3hb+oxLLXlUuiJrGl38xUnK4Yy1
	 jk3RNJ4fIYh4C2rFkTMU8lSJmDsQ7feF0RJVO8qG29l31GEtUN1lNDkqUbK3DvKHZxkul
	 uI//l6RplygmQiaWVdmRHxzQQx5wYHR5Vn0IB6RufWotkDtyYYo1+F7uFvByjN7V1nseJ
	 Ns8T4WG+/NmgA1h+skKtpnB3vhiiIpX6S7RHuS+1LGZP7rR2Efidq1dyuo6mWtP6e7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795775486;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
	b=iGICFBRPc2MZdfNLezyY+gMC83c8nWGGsCnuXfM2PE+iLtVrJhOcGlpQOMns00OnSI5U
	 AeUJWEUK978Byz0RBLpVfw0lm9ko7sdFXQwS9ItFCFc8KT6TpYHn2tw1xMItI01/8EftE
	 L8f/hpM5kALdNZovo+7tJZzg9wDjwzYp9uD3v0y/I/AImBj9nfUc6bhdNVfvFcz1lV/Vu
	 /HdbBBT1ann/U0ukWHE5ZicdA9KxhSxQZgNB5bIeIoGo9LysxpJyUvUHm0rvsXIFxefsS
	 eiPoOmbfHb+6zyhuGutPaJtyfS/4v011jpQ3hNKXR2KI+reNtD/BezPExU2AILIoelw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795775486;
	bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wHKyM8aGQCazTvcbTe7Wy9MwgZKmiP6rL29BYOZbdkJxoUyIh7b3xGXZgZSi9FyQI
	 oyKWpV0MoidN9wrvKsHp8WA7t/+/oRxVU87Fr/GY1rBqeER7vn0QtYK+XWaOqjxwYe
	 NzbqolXNi4se6CNFOLM4YmB/vvSeS8tAa7H5bl+kcVOUomhHswkUXDLhDawPy8fibE
	 QImPq1zYD4xd+1O/jGemWNpUeuX6Qq+a69maR0cX6XYEpBrlmUYm8ph7wsM/Sw0W/D
	 MlJOheqdmMDKHlxeiX/MY4sLHb4nT8LLBDbEG072T/3LaJ4FJtN4wgGDhjDJRibdl+
	 qns6e/9nwNRtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 01FEC40A69;
	Fri, 27 Nov 2026 10:31:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E8079D1
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CEA7260AB4
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PRF2zqcpSjF2 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 10:31:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3144560AAA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=DyNvPCoD
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3144560AAA
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 10:31:23 +0000 (UTC)
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1a2761c69fbso11335757c88.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795775483; x=1796380283;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
 b=DyNvPCoD/fiddMH0qF/CGGVlSwAZGAO1QVQ6p2yzCVPQqFbkVp/C9Ko6Lc88p4EJLA
 6hVkOo3vhqUQVJlpe5Whi75tBG3QnabpyqPptUXPYxW191FEgudA3wVZsReD9t0km/2B
 9Sotn8Dwn451tZoK+HP+RBi98QHyT81y7vL63rYa7r+6gHQbJm/YJ0TEv8iPRpsT7wDB
 tZiXhMBKYeMd3CEFpUwV3l4w80cUQfJEfO3uUHTpbPcRnqZ+LoHDxD8avZubXxjwmxbN
 VlNk4r82VIun4Ekjwk3dcF5XlBsi/q4s+J/0wltgzV2NA46i/ybgGHIKeDf+apB3zC1V
 uB6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795775483; x=1796380283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wj4O0nUDXpp7Xm2KbHgq9968tuyUIVC1RsoGDYP91bs=;
 b=Rs5xfNaK9pOXrCqmV/IyutPgh/5DNboKH6rpVq5ezn88jVEZcxzsHbExDYyxuqJzJY
 MQYkcALVQD/Iu5kklmSLTIjK4Ioi/AgTC0NaGx4/61cSTq9oHX6gtZW1F7NeskuKkJYE
 x/0EUH9TcL3VYaIkXOXg4m57nUBRlAGDIdLVBTQHGysutsMXR1DiBllYQEPqn6aBMSYS
 GJewOERBR9Shf1vu25B+1sn4duDdueMrkGF/cfw8y9tBeXTQLfVMjPA9up0tW5z91pSZ
 iYpD/ucafM1PzGr27Th/VOvl5hYqQYJVR4UrmOG+gch+OCZJ2ZzlAVUV7xZ41W+SwJQe
 0lJA==
X-Gm-Message-State: APuU4Z9cAO8S0fKYHhmbo6ayAF1h5mUCuQPJ68K2QnNe4k5CAwIZKWIf
 W7XvkfwtI+O8pXxR3MwOukwBxAY+XvKOcBqnw3ECE1cBVPge8SCL/NXE+Ana5w==
X-Gm-Gg: AZFdTZdeVlkXLKavmK1eEh2uPlbpYB/wMq7oBAbLHxljqV8glaYOX+4C8zWULABylZ6
 lbxyWfwgw/HAsDg1JX+wNotZTdRoC8GsokpSeAwkL7rGSvZKsNbP0E5jmu+1IhmmR5LoDXl1HU0
 MIo3WDxuDwPoH5l2gCdqAHAEnIuecsTKmlKUjRe+M8wV+fNUdGeL9lzrfKG62G6OtXWfviX48tp
 UJFqF/lwcqAUcSOzvXWPzhZi5XAav5MrXxAVv5Cko8cZTgaKKOGk41dc1f0yUtsh/+GoxdyK6IW
 Wsh/ez+4XXOixbZ43WCGZ0Nb0eY7WpyWNiNiSHHIT/tBW283X0zFeRfNrmVcK0Q4PVlMLbopjmw
 ZYzxKluEt2VFZnIStbo/fo9GM0lYenf7qv9hFtlmvEKA1uzppa/2vZOAq/LkFq88xTsMKZsrHbb
 uobTVfW7ByU58qCWuNfFSHibMGf2qwjRKwtkH6hkrbrRX8/cODBnDayoB6jpVgg7d6eSpelIGzq
 oBONwJml6Zng4AwEupv8fQ4hPOLoOMBitEsCXt/rssXngyVtJvZN7vuR0++Kpf9H+yWLeoA/DQq
 S4hl9YxwTivOb87ay9E8SwOHBOJZ
X-Received: by 2002:a05:7301:e0c1:b0:380:c3d7:c263 with SMTP id
 5a478bee46e88-3856c0d076cmr27128888eec.5.1795775482904; 
 Fri, 27 Nov 2026 02:31:22 -0800 (PST)
Received: from arch-rock5b ([45.112.0.246]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385666e7fc3sm63369991eec.8.2026.11.27.02.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:31:22 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Anand Moon <linux.amoon@gmail.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Dave Klotz <DaveWK225@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Subject: [PATCH v3 02/13] riscv: dts: spacemit: k1-musepi-pro: Drop redundant
 DT overrides
Date: Fri, 27 Nov 2026 10:30:01 +0000
Message-ID: <20261127103030.4647-3-linux.amoon@gmail.com>
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

The upstream MusePi Pro device tree already defines the serial0,
mmc0 and mmc1 aliases, as well as the chosen stdout-path.

Remove the duplicate definitions from the U-Boot-specific device
tree while retaining the console alias.

No functional changes are intended.

Cc: Dave Klotz <DaveWK225@protonmail.com>
Cc: Eric Chung <eric.chung@riscstar.com>
Cc: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: E Shattow <e@freeshell.de>
Cc: Yixun Lan <dlan@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
index 03cfed10521..ddea04a8e3e 100644
--- a/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
+++ b/arch/riscv/dts/k1-musepi-pro-u-boot.dtsi
@@ -8,11 +8,6 @@
 / {
 	aliases {
 		console = &uart0;
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
 	};
 };
 
-- 
2.56.1

