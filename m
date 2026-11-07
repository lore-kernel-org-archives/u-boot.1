Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02770606A333
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WAQ0ja1Z;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=T7J2dZ5R
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8BB7816D5;
	Sat,  7 Nov 2026 14:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7a4m2EKR6HeK; Sat,  7 Nov 2026 14:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C372281662
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062003;
	b=Uu1ceFycPfF0g6Q/Gi4DU/7MMeZT0S5sd6HfItB7/aZp4y+pdwQcr1wIdHPAoBS/2Cwe
	 TEtcpf5rnwKyvPNLuTEJtq7wA2zsfisRU3et5n9J+smU4Cw1fJGkPKlqe1L2ACXwBQzip
	 nel0gUjs0byBvctRZLZW9laj3XHnBkTdkPEKZF9rcwgk2Z6pyOIqUPcZp72WTsQAvbqh3
	 2nopCtD77y+7HlmXtRFd7NWfTUj5r9TUHzP26ITBLLD2LvD9FZ0vnhugEmIMKzcLiZlyR
	 LRy620hqRiFKbpCfCj7YAkvXx2lgaEYhVc5ZUV88scWHkv5sWxvB1/0ZSeZIe9R88Qg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062003;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
	b=Zjd8Fsv8Xx7Xsiden0KTyFh0iHqXQ36bk9yXAENChf0LNfJXCOjh0HJfp/AAjE89xy0S
	 V08ik7rIaO1wxYyvLcmtoLhuoeK79CfM4FS7IMkJDOS0ZvNWwM6AL+YZxt42p44fdZ5x4
	 MdjewEL7zr7FkkAe/B8IQnjjlQ9u6Uia11PHbD6jk66aqKrDWI13aDBZX5UCKJQd5YTat
	 XRlkTPn5EiNhwcd2W/FGy0LaOwy5z4fTmolenxY1RZtU4lEj3pZF7u3XYW28aAyBFBItA
	 J5J5G4qRcKE3Xu3UIyJS/Ag3t2Zi2JJ6lMMuK+yEzf1hkj+3Jkz6HRv3Feu39X2bjGw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062003;
	bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WAQ0ja1Z3wnJp3iII9aspWAdJCmTc6Zof6fj2kYpJ/KVNeSYwzMDcKajGyIyDXeXX
	 TSeTMZsRoowMuJLE7KRdhUB0ZJZf0yfLfcK0v+Rq+nsdqK3yLiKHgWHtGDPdeCWjTp
	 GcG2IVGF9YgkH0k6EQrPcnwfrCkLp/kb8GyB2/b2jNkmQd/nkn2nM0huPJlmh+nhy+
	 cGLA6pZEr2J2qY20zIegVRGSQPvEwSjGfZE0MS+FfJHCwaBxmK2wZk9NAe0Cy7nDEL
	 yzAsEfdjr+2pEGo04j9Axro5ybjof22/lllR75EKs5rD8fQybHoh+Wm1+ULLy1y+Z3
	 +PqD81kGB/bPg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C372281662;
	Sat,  7 Nov 2026 14:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B66034D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31E90400E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cST5vyk1P-_h for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 37FDE4009B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=T7J2dZ5R
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 37FDE4009B
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:13 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so16030775e9.2
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794061992; x=1794666792;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
 b=T7J2dZ5RCYD/N45r3uCbz2Kd4VPU59yL4IsjIVXfGg/yZq9S4kinnws31Jv+x4Smna
 9cp+5G6jOFSgBpstuJmDeMqppftri2nRmSrdB+VJcextIXWtuNVRsRCnd0qHIT6pjcBa
 Me0X8TLIxf2X+bxd/5JPzuC+Wmj+Sc4nICKwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794061992; x=1794666792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZyTii3rbqlgQb0Lw0g9k9IO51BXgBPEyLbRIFVsQ54k=;
 b=RuAk53uvDG/gJ9wWR7+ZV8BCmHbZQWEcDJeVQ8f3solcX7ScOKkXa4wmFqTDzI4DjJ
 Tj+9fezdslJiSo3DSQytbW9DI0vxYgk8M3gj1F4fTkso4X2JnU0JnCgkzWA7s2gOjfOZ
 /pgtCw8roHEqsMimzs2IbDhgTl/Ihfv8lZBfvuaYrYgt+c5leLyl5aTQTaE9gTHOYtU7
 BxWYbDCnfqoMZnRkapPCoPi6cB5X+x1Kd3qnQrnzpQ60LlRAbLkmHxbMrfPpOBV4WocK
 gNXqLdFl2mq5AmTYpJn6YyADSc904tAPgMj76bDdeStZpTqHyJAk0ocRLitcZ70uYJQ0
 b4pQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQ5D3kXfqT1FO1EpJCzQ47iBBdrEV/g+g90yWcrFzacfzMu1vHNoDQd8GQ1iwUDdoGodWp3ao=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/GvSA6U1txzcD96uO80j8zy46BPxJ0eZ+h09ZgzQPc+EI3ghMA
 DkgHqNjPAeeWR5YKySw4Noh+okd0THluMECznFRD04Ce1XNvSxJ7a+GOgRFM2lr0vebk2VpnWjQ
 1rZ2a
X-Gm-Gg: AYBFou3LFUaX3mVVUJZmi4dGJ6j9oM7Do7zMesNE3TAjn6ROFPQ1KJhC+ffEGQx95FN
 hfub2RNBi2qRRZZHO5lRy0QSWMjHNSuQcZnuXqrD+2tRFc039sMaf2pPUfdCWTdOQpbWPlzkLcC
 gaDMw57xc9UoUldSWcJ0Rz9nqQoJOJSMdcqKjRRXrf62cDrQbaz6wv6/2IFrRQnvEiu/bV1UIEQ
 DcM26fdb1uuEweASq9Uo1Oult2FdZPMS/jCFyeFlwd/ekYSGpdvgdgvukY7oxrg+NjhW4zQDS0D
 V755kIYlajKxcc3am/gCt24U6XUK2Mnx45fUPqnnBbjwD/guHYrt6yW8BgTKZrenjQAdiGlSwQD
 XoOxVpnCR1WMbGd8m50HZBzyBBTXOwzq8DJxmeEavFEUPvnvr9ablH4u786csst4rWSkV96nVWK
 5WFyAsVzWWEBpxwezGupkjojRQWGjL2Gbg/VU1CIJjIoVw0XrYTJMhLP0qpFji52QAQ94rfbMJH
 tsqtn0TVtU9YpiJrg+lweRx493n/H1HAwJPHRWOvuGrHH4VL9j9o15G9xqbszCentzsYlmvcn2S
 GWdeIW6WHPO86bvhzSyFmVa2mLVRNhpQ4GtpFU63+GXNwM5QtJR5na+B2XfhRPcXgfxjmtQucV3
 VYr2y0XFNUSdPVmdZkNzKE3ue3sajZEGgx2ELddEtQcfVn3cpnVmt0T/70vdwjdPXTytGtnhgSE
 G7LSSp8eIklLi7RGWqWcK1TZAEzw==
X-Received: by 2002:a05:600c:5297:b0:4b4:262b:88a2 with SMTP id
 5b1f17b1804b1-4b6dc30ae97mr94947005e9.1.1794061991871; 
 Sat, 07 Nov 2026 06:33:11 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:11 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 13/35] arm64: dts: st: add usart1 pins for stm32mp25
Date: Sat,  7 Nov 2026 15:32:03 +0100
Message-ID: <20261107143241.2236511-14-dario.binacchi@amarulasolutions.com>
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

Add the usart1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-14-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 2bb7d85d7a644e20b7b9097a966acec8edd5c7cf ]

(cherry picked from commit 99b28029f7153bab8e870e9510470d21f6722f76)
---

(no changes since v1)

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 4e570e2e5157..d515e44832d7 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -766,6 +766,39 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	usart1_pins_b: usart1-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 8, AF6)>; /* USART1_TX */
+			bias-disable;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	usart1_idle_pins_b: usart1-idle-1 {
+		pins1 {
+			pinmux = <STM32_PINMUX('B', 8, ANALOG)>; /* USART1_TX */
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('B', 10, AF6)>; /* USART1_RX */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	usart1_sleep_pins_b: usart1-sleep-1 {
+		pins {
+			pinmux = <STM32_PINMUX('B', 8, ANALOG)>, /* USART1_TX */
+				 <STM32_PINMUX('B', 10, ANALOG)>; /* USART1_RX */
+		};
+	};
+
 	/omit-if-no-ref/
 	usart2_pins_a: usart2-0 {
 		pins1 {
-- 
2.43.0

