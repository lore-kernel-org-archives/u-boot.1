Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A4606A33E
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ivGSpkFV;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jEJT6aG3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2037D60D61;
	Fri, 27 Nov 2026 06:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X_B4YaHBvZGB; Fri, 27 Nov 2026 06:36:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AB18B60B58
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795761411;
	b=emV0DSvZXgrq7TZTnD4u0KSfeC8h49gG+wTaIHDyztaWB93+gzUZmU9Plrt8hd+Tynn9
	 WibHJyItsdaNrVOoxdHyuvPFySoQRwDHaDqbnNE28l5ZeQ7b23ZjK4wFyKaWSbwAc+MaW
	 uyZnS1CO8SfnXZkBd4gZycdVsiyTKIa/SjLA500M8Gc2IJK5inPPxBPVpE2opC8cG7hz3
	 62fIx7OR3OjW6BfF9V5/9uZw3bBYPnIznDXyf15Hp1AUct+Mi0to4XNTox9WhSnYD5ugG
	 6GE+/QfqybPbQg+4TVsaznDw3R6GmT+CGsQLvGFd21neKUK3DwplvenR3vkraYnRAMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795761411;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BniAXWzKv2onuSwkXoFnTN6YXycoCdrYwohnp7LgEog=;
	b=ag5haquQfzVWVOcaOp8Hcoj3QCWLfjO1Co9qp4NB95VQy//8wFWjLi29mjCBP47FGWDp
	 dUAXoPNvFy3eWFWNyHhMs4wS/CkRgsiJEvXi2wCbBGlJOlj0Akach5WXStujFrauOqCh6
	 1H6oHHcUWdsPkp+RyJl1qzQn4UqAxkJT7zfi2JKnND8mfaiGwjvUaX3tfXrKeQ/g6HTlg
	 F9B9HhBhI7xWOzxiL4nLf7ePh6rSmi3n0IYlUnpjs4tSq2WaJ9H1KPm6coEWc72ZlMDHt
	 /fqgLF0klaZDCOMnltXU074GOeBNOGH6N1gRnj0rwXDrP7mBLV0wDlLMTb2+Vops3YQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795761411;
	bh=BniAXWzKv2onuSwkXoFnTN6YXycoCdrYwohnp7LgEog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ivGSpkFVBXG7LFeFqjX8eHmSTj1hoxyKobsFMPnjfZ4Uy3HoQfhrAQFuq/oHcp/aK
	 uebFeVl3XsLPkb4V4DxnzB0GvUTVXM53sYL7qQsiFePnXg9JEwPTjWC7TcbAzMsbfQ
	 yhTD4EiUSQkrYXCgKSsz3i1vPviCdJj0JOyQdLQ/bB71YALRtjeZlF29Jj6bq1uZ5t
	 KePo3zHCara7PgrkEkPd5HiY0eu8WF34dPDSqfue6LUUhGgRYVdxKJRCPRhWFTqQgK
	 JVyfNcwQ2DM4aI4dczGu5BAPn5XzTZg4KsZEcnLb9fCGnU88RLohawHu6cbG7l7Tps
	 tmvu2Vcltozeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AB18B60B58;
	Fri, 27 Nov 2026 06:36:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F2AD2325
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D8608811FD
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sgi28oP_6POz for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 06:36:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A0B68115E
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=jEJT6aG3
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3A0B68115E
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 06:36:46 +0000 (UTC)
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-386c4d2e2ccso5661075eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 22:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795761406; x=1796366206;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BniAXWzKv2onuSwkXoFnTN6YXycoCdrYwohnp7LgEog=;
 b=jEJT6aG3Fnc/nR3nZ63eJ58ZVQFVepBi5XB3rL3V1xezL7BezRdk53Ci9yjsgpH254
 C+dEC11EhClyDJPkZtsJBrvAYYBhewqiqORNLnp6wS9pZt+fs5rktVKYfv4UKl/ZypOd
 8CcK/2G4HBQeIb7eyIS8wuVsUhbZZeEgcWIDNzgqnaYGjOxruDmcnnbODl0gtkZ/YJWt
 3vh5EfKpc4moGFS535ZydjONwTyUT9PJSgiyIWmhwvhRWrRx2WvrD1kooSZLS2hT45/O
 x+YxvX2fFR78WvTFcRPbzAiyKNUtwvYo6gE54uw5Jgb6KwPtN8tw050ysWms1MBB0fsh
 qr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795761406; x=1796366206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BniAXWzKv2onuSwkXoFnTN6YXycoCdrYwohnp7LgEog=;
 b=Z1xw6LlbxwFdaQ1USi84ym/WeTvsYyADPKBH1K/2TKT8lI/RISLgVX7yHvT5/qcWhd
 KWBYveJvrLeiPdUj//wmTDO7Dbj2TpbR44Cd6vnMghnzjbkmlGykD2GsXN3p95RhU5Yx
 QPfjlXbscjvGl0M3HzfZR3oMzXq5gV5zZqKjzXai8YyDuGkUP108fTiDIZxlnko8HHas
 G52AbHpR9n65B9CHeNr8r1U/EZ7EaShy5rUJoUaaWDXOOjLVBBm8gZK+z/LnJA8HsODn
 AXgFqbrN6lPBCZqmHvzZuDH6fagQkDAzrK/GwY4n9AzTCYDi1RUUgjMm8nRAaLK76jbs
 Nd2Q==
X-Gm-Message-State: APuU4Z8UUcHZx+lQsDEygUjoqAoY3P4RKifiOEOkoPPTyhKQ/Wc2tOFL
 Zy3wi7MsKMvAcTl5jVtR5ZRsslkvpcP0BWRu8ds2Dz+8R8w29DnBQbL7
X-Gm-Gg: AZFdTZeLqf/khJ24ew4JKQaVmUixVxk323P3Q2AOh+wta97ZGdyqh0lfoJtP2rBivhQ
 Nbp6aOi0/CTPwzAU2NwxcocpmsFrzt0jeUQGaNyA+Z4IsLn+rih/jH5RH/IK7JKQ2quFPQtZtHA
 syWv/8jCCy8eZ//Ml/E4Zd+6b81KU5In/vufiAJ4JacENhngDw7z9Zo2kY6A1RuGcbRj5KWteU0
 ql+Rja+qEUufoA3r61JzcK6OOW2HWLl9Lmf4W3Oj5jV6iKj2qJQQ1LcTPJKrp/QvGRHtndJZ/cC
 4sf3cfd2AsFui/4tcO4M6XyUliWPTK/W0WYBXB/pKcOgxr42Dpeydtdg0315ajWpXcNxY+TMTdb
 1pBivKbqRJ5JvyX24G9FvLoK/4+jq7rTX5PE/8szE5DwM74wHBKBg4IB0y4Mtk0yb86ngfkGRkI
 2P5xlUGlm6jeIwmwNj0qDCMBMXOt7/ZJPRYjaeWWVDGUt/IkKYwNGlYU5dbz39Ge0095bGW45Xj
 OBTn0Q63G8Rc067Sen4lgOXJEiFyIytSniLr1O7rG6gPT0zL7bw1sac3fDjOIDrtP0+jG+QM+XP
 v6sDqGJwumDN/peG317BEWBud+0jrxuNzHbQ5nROobdVwULRDR+/u1fJey61UnWHETTrqh4/ikY
 Bd6TMKhWigmaH87KSw2V8vtM=
X-Received: by 2002:a05:7301:1884:b0:374:ba43:ae2e with SMTP id
 5a478bee46e88-3856f65eccamr22572079eec.14.1795761406107; 
 Thu, 26 Nov 2026 22:36:46 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (55.11.81.34.bc.googleusercontent.com. [34.81.11.55])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385672c6f31sm67452444eec.15.2026.11.26.22.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 22:36:45 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com,
	ilias.apalodimas@linaro.org
Cc: u-boot@lists.u-boot-project.org, sjg@chromium.org, marscheng@google.com,
 eleanor15x@gmail.com, jserv@ccns.ncku.edu.tw, visitorckw@gmail.com
Subject: [PATCH v2 6/8] arm: dts: lga: Enable console UART in U-Boot
Date: Fri, 27 Nov 2026 06:36:18 +0000
Message-ID: <20261127063620.399391-7-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127063620.399391-1-visitorckw@gmail.com>
References: <20261127063620.399391-1-visitorckw@gmail.com>
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

The upstream lga.dtsi leaves lsion_cli16_uart disabled by default.
Add lga-u-boot.dtsi to enable the serial console for U-Boot.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS                  | 1 +
 arch/arm/dts/lga-u-boot.dtsi | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 arch/arm/dts/lga-u-boot.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index dfbd3bca8b0..9c73992ac97 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -359,6 +359,7 @@ F:	arch/arm/include/asm/arch-mx*/
 ARM GOOGLE TENSOR SOC SUPPORT
 M:	Kuan-Wei Chiu <visitorckw@gmail.com>
 S:	Maintained
+F:	arch/arm/dts/lga-u-boot.dtsi
 F:	arch/arm/mach-google/
 F:	board/google/lga/
 K:	[gG]oogle.?[tT]ensor
diff --git a/arch/arm/dts/lga-u-boot.dtsi b/arch/arm/dts/lga-u-boot.dtsi
new file mode 100644
index 00000000000..d9f36fc2c54
--- /dev/null
+++ b/arch/arm/dts/lga-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright 2026 Google LLC
+ */
+
+&lsion_cli16_uart {
+	bootph-all;
+	status = "okay";
+};
-- 
2.56.1.839.g22a8290db9-goog

