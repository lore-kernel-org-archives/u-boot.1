Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D569606A335
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MvC31Agz;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=QRk5/KH9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 733C2607D2;
	Sat,  7 Nov 2026 14:33:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HYDGpu9pis55; Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9408C607FB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794061988;
	b=fA/+0FCb1TbucuDirU2xt6rinVsTEizjvdKJNA6zqTHqqnFJ8pj9AG8kUOyYuVGemWTH
	 YqMR4uMYHQ6jKBe/9D5lu5NgN7yD5nGwucmazJlnyZmJqy6Cqfq0CnWVm+t2eiNe45CpL
	 eev+2G48e1enHXb7EwYEC6aGu0kw9wlkli+uHBZtaLglB0YJ/qpfaYCsFQFzr1+ld0uuf
	 R9O9Nc3V+Hf9yjxFSFrtF2kmdSUqxJzxN/PyFnBOwCKVz15i0SsjxEDneVrdvxpSQebLG
	 snYWrbi8mu91Hq7yPycc5fNfi2kv1iUxKY4jK8HIjsPBzpxN66kegkf1o71OnqgRU2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794061988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
	b=EwDCaqhhpmTaeeA9m3LUczNIpqI2IHFiz+BJsmBIuWafS3v484FkE3Ypa+AcLjOsO10y
	 Jj9NS/FenDHJZJEbKgi8q+LXjsvKN9JQhGn0HMHwUiOoDmZUwXe0HC1NHodOMsQNB1xdX
	 5H5xFOidnHXdHWKvZiqsE6m/tXNotXxaHWZpyc3Mij/85A/VDXI6loAEnzeILw9wc2BcF
	 pYRrU/eeXq5MxMNyj1bh3F5kYhFxCVcEOb+HVBV4i+9ty8Bejb6TWQcEvsDQEc+JSicaC
	 QR+KvxWNG+tv6Q08qG3dK8CoWUYlKy5sND3ROO1nrnhnzDFNkfhsoPVozFAmdjOkZCA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794061988;
	bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MvC31Agz1voQkm78ChVNol0pIl2PYPT9XlEvIuOGspP5cfvlhgiu6EbrZVKGqwmet
	 zhMKgZXRq5GtEguVJPgcXo8qEahoJAB3kfUt9l6JqSzOGYt681o8EiN6JP/VILVDpC
	 H0l10ehlQN+S2GlmBo80yrl04Q+kKzrDM1EVX0jJ/9N2XAJDEOGOeJH8fYrNNcfpty
	 /TSuPFAWgwnhmHMN1i61tDyJgGzAMpl+u9tPhLqLeRWi8rt8LUisixeCgHmP8Y2riV
	 fWwQL/eDQaGgfpM8opYxMUxbAxWbrloK0kk1Jk01rAMskD++zvJCI0CFtsnl4eVwxk
	 KNbeSP40WrtOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9408C607FB;
	Sat,  7 Nov 2026 14:33:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91C08211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CC7F815CF
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kr6vUTd6GnX8 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C5304815C5
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=QRk5/KH9
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5304815C5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:32:59 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso14914795e9.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061977; x=1794666777;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
 b=QRk5/KH9U1BVQu1gzQ2nFba8ug3OgA1l8zGJB8KdlefWje7VgbV6chxb/R+HRXBI0Q
 Xe+wSfA+iKIpbI5vG/sZqXB4oa0/x/vShPm8OGGhdXZaNQkarrdkgEtx9Jn2PR9u+SjB
 izG+J4Pp3vHBYGj4pt9LqXE3sxVtUMGjEthBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061977; x=1794666777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/krHuJC9ShW9NcMkzIGR+6pdP2wDUKW50lQhoU1SG0A=;
 b=BItuzos7TiykDGpJ4Hg2/3Tga/f3s/k5pXH/Y4C2lXe/0Ze47kO/CRjv3Mqp2A7dut
 WH39hWQwCDVvJ6Rx8LTV/cUvC2bvhHDsgKAorl6CTkCPXseC2hQgHu+WekDcjgRgHxCU
 DOqkkBshq0spw5FngcBI2P9e+qIBXPGoG+DP1tD90bwk3G6ekoCiOD4/uroJSEPVbkNi
 ftBIqGozZKdyK2D2fhPCbUGvtAVHC5wcPLX7suHDOSUPffXOkClMRDe6hHhH5NBPDS1t
 u4lgvNQ5iuTRC4wa/Q5B2+n81eIxEA4bCSGnq2WJtS4RsklpfwPuCmel4RHuViHiYB61
 ttxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJf8hkAN0wrdW4hQA7ydrn1r+ga8gMmN/DHbZGtjPR7xYyJHGWFeu9a0e+m6GH875qkTMcNcQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+LGQOYUWVAPRefMdT6+VavXYCs7pmV2SNfYlXIG+QmMiZkIsK9
 /Sfdmcft0XUYEWJTUebhfGUnE52l/TUSjg7uglm8/72mY7zWoKzh2/hWrOhz1dY8eUI=
X-Gm-Gg: AYBFou1WTVz5isKqd1zFfQNaPYoorWdXtqGFSLnZHTq3qGEkTCq4X+uIE9Dtwbn2oi5
 GzjCZEzN8LkD9PgwtJRBU87EyZ1Q9wg8NjEexp0MNLwnKIRYTgK9lwiENBJ4dav6DxqgJYOVIE/
 zOL34gclUizX/JdQoco5Y/5xXH68fxB0ZFQudMIuToWTXIVv+PLOl/brKCqkSWI7CKkI/FWEn9y
 m+juFw93OMifjQmHzUWJW2SLLSXoYZlfDjexRhAWFOYk4fzrHBmNcM8L2fn1Gx7DWkSCNp77yry
 CftZ0z7WhL9uLWhy4EAEc/kNuCft5fH88TaU0ndKyolEwQhItNMJpTVouchhFEAFPCXK2dvnU9+
 jAYwHdqMKxPuBwTYcCKgQUuhaLS67AOD+RIsgjvY9frrz3ID600atV827Ak7BSfbIPNPf69KA/I
 Hb7IoEr3gXDHBWMVrz2oeUUb8nndeEM5ahba0s+EA/DxRaztmohWJl2kEVJqvT2jxnSB1+ihkPK
 5mboPNoxiGcesWq8QeQZSVzC0uAgPCpVcKfuSXuOg1inAipKut/0jxrMWtU8NKiEivi8I7kM6vC
 +8XMCiMKSLnPCqhZjiQH8x4kTnET45hfug2M2NxYGVzZj15jSo8TPt7StzM7XVHIvQJylwJXoXo
 kmdl5KGR/ZpZD9tI5i4kekx1214nhCqdAGHUfR2fnAfvgNECqpH1OQP7YJs0Dfg5jV/45gr9U6a
 x5pl9dDniK0/l7KSLnOGVy8R4Hmw==
X-Received: by 2002:a05:600c:45d4:b0:4a6:7d6:821f with SMTP id
 5b1f17b1804b1-4b6e01717dfmr95697085e9.29.1794061977553; 
 Sat, 07 Nov 2026 06:32:57 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:32:56 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 06/35] arm64: dts: st: add i2c1 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:31:56 +0100
Message-ID: <20261107143241.2236511-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the i2c1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-7-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 650d83cab19ea1acd3c1a17583d91efcd1688a7c ]

(cherry picked from commit 7cac3c4a9f9b57c8e7d4c1430991f0df3b0883b9)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 456ece7f8ebc..db485b9ed904 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -203,6 +203,25 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	i2c1_pins_a: i2c1-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 13, AF9)>, /* I2C1_SCL */
+				 <STM32_PINMUX('A', 2, AF10)>; /* I2C1_SDA */
+			bias-disable;
+			drive-open-drain;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	i2c1_sleep_pins_a: i2c1-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('G', 13, ANALOG)>, /* I2C1_SCL */
+				 <STM32_PINMUX('A', 2, ANALOG)>; /* I2C1_SDA */
+		};
+	};
+
 	/omit-if-no-ref/
 	i2c2_pins_a: i2c2-0 {
 		pins {
-- 
2.43.0

