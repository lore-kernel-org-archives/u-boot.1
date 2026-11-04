Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A4606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ykKGbsD8;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=CNq1vGpH
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B3AC60837;
	Wed,  4 Nov 2026 08:51:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iyi_lDdTYjNf; Wed,  4 Nov 2026 08:51:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 583D0607AE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782292;
	b=HtCpnzc4txEKnnN1YMxNJyOgq+v0RhetSUe4ASu53PHB0i/3gtlio3umtA4tRIB0JDi5
	 /CywoL4tlICCKWmS8cIiDTafdEoIjmFGVMIMxBKN+93f80gRxVWnWHqN6op3Uvv6shCS9
	 mJUxuE380gMedtg15ZvqCoQ7Nl4QlW/yB1niAB86S2l0/wtY2DSy23XLJKKLtkUrDDxIt
	 ShVY+UsLbIL5LgqZx66OpcVQSGrxRjjnEyQUcKClfAk1YthPU9yxxn7qvlFlJJwt8tsjJ
	 2YcVN5rEJIFbSp9ymsDaoSnz674k8gxgfrcTo8iHShk/W5wWkHW6gQDos88t60mBKqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782292;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=epOyI4KQToZLuQF9HyrhD5ec5WmdtuRvPwOKzsi5VTs=;
	b=JuIOoe1E06mu7SBCW7IkBWOXvR8PpnLvExt5OebZPIjaRC8V3VyIEmXYGBG1YS2jI9x7
	 iX0w7rmmBluHqsye0xd555GJLXRPRsNtXL29kSYaon4ATlP/qNnjR44m6fzPhXuBRyrw7
	 /JqICNdqqnhkWljqXJ5nsCPnwukz0RhMo1PpJQ5XrUCjgycMoJu4C7GzYi1q1y+n4BJb+
	 CdkjQQpaYQz8JX+ZsRWrMqRF3b+S+uG59a1guJV5gGtkNSYeWMtOProOB0KLf0VKcJo2o
	 Po31BXlkJ1L/KCctixfXHsTVHItif9h1+ipJ4x7Ge+VrcRmUJUf2FZuIXUH9FTtb/fA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782292;
	bh=epOyI4KQToZLuQF9HyrhD5ec5WmdtuRvPwOKzsi5VTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ykKGbsD8Jz5FXz3HJmUut4hMoTihNA0iqLf4Ah0B6hxciloNETltY4F0uUb919E7M
	 mXivDIM97dv1IHZYnFqMd1AouXzXJ5snHNZZxpVEJWEkwYZ5p1AcEG12OcVVfI8yDL
	 lLIdmq1RNQaXW53jxd2SvK6atpDaPI23Zd86+V3DojMphVpgRd6XCu7o3sgDvYEadH
	 dj1+WGOyznv0jmawzg/e90bFuUkenwKwkwbI0P/74BcTAxVw3I3mbxNrDFza67I/ME
	 HXp2+SENMssyVZpASrk/IqNCzeMO7hNxtRPqG0fF/YREJfdjTzHko+obW5QwwWW/4E
	 tEhURaeqRC93w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 583D0607AE;
	Wed,  4 Nov 2026 08:51:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BCC342AC
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE697401FD
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tM53HkBfbD1B for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AA7EA4004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782291;
 b=YbedjG6DN2Q/1BZ7NFiqvIYtYEvJmdqasMOOYZEMmmtJu5h5hYAjF3NIK2yIjwcCrn5O
 c3WKRtO7dvuCi/TtVYdaUMcRE9W57C+5i3C94MAT65xbvZT6zsB/6Oi2yQscj1CaklGOR
 JOSGqRx7vsWSwn/yyVn3vefYdZxxu0H5xiq/DnsCgh/oI2hjRaq8raB3ZmmVSxubtsOfs
 Z03fIWDNlFd5k+AtoUdEhcll2zF+i9TwifPtfNqfqK1bHPqYq/rA6YwFymFy+xxJNeGBC
 qYkid7/KGoySaRFtc3UDA3pqhi5Yf/vwJpQkpDBHkBphMe5G59v1hYaRJbYi19pYvoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782291;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=epOyI4KQToZLuQF9HyrhD5ec5WmdtuRvPwOKzsi5VTs=;
 b=p2GAsrRKFdgzsx7KFsVXypxkT+qmW9wUN0ZlSh+1Jp4Y4NbfM4reqESfAOWywlHP9Xr9
 wt5VtDn2JPcxGhxiP4EeOFvFZ0ohMi7Im62m/JnypaukZdIvGL8GTRQ9RwBCIaneENY4U
 sktMBZIYz0q2IXh62IW7EZx9eK9bz3TCyeF0olfSh+RBoAbcGu9ZI8/tWDwFbQJ7NmFf1
 K+v7G2u0GoO0RkdmpXNjst/dmKH11T3CP8kxZWcc2BpC4Vk7Pl3xUyXXX4REJ4vcJOlI4
 v0ZaCKfRJo2I8Mkl5G0MtgMzDjjJLj8tx+8tfS6H4n2yH8qwz3I0mgHSwjmBiR9uU2A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=CNq1vGpH; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=CNq1vGpH
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA7EA4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:30 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so3080855e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782288; x=1794387088;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=epOyI4KQToZLuQF9HyrhD5ec5WmdtuRvPwOKzsi5VTs=;
 b=CNq1vGpHEzLKmXoOaLCC9dhM4PD4HCzsuvUyJY+PPqFVUFfvhv3Xl/p316ff6JtpTs
 mXVHSYX3C3gjOyyFWLSBUazIjrkSg2OpOp92dp/dwGKCpPkn0C2ZM9yUm86yPCj3f/oM
 g+22Gep/G2oaLG3ZtErJXdJud2C6HeZD2ESSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782288; x=1794387088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=epOyI4KQToZLuQF9HyrhD5ec5WmdtuRvPwOKzsi5VTs=;
 b=zbGH74J60KFXRWjo+OrWVNaiEDcie1tqKUq6vtDJp/fubdmtdVTOyaNl5j6jdqcjFg
 5oeEu7kFktr7pP9LheBfLANZld6E71C+hXYonmxwNQJnT0MX+Q47XjXiLpBjoCQaNIqf
 C7mJ4I+26TXSjWpngQGUavLd6yLG4qOxUCyipTRRwsR7dlOhv9TqRtLOFneevgDBkdcP
 OgAozMgYFtB/83N6Ji24LXo8A/3M7SmsrNWO4Xvp2LBFDek8xQjK3cif9GwuWH1INbRL
 AwmRuX24m4w4klHYvgdMGtT6bQhe6h8gPFu2hOnAEIrwAJcmQlWPZ8EHEtHgscG2qsTd
 I4/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGApq1kEUSOZ/DIJh6R9Beh2AaNQdVkc2KP7pXCDzwIuu666n71BtYRfuHCeW60t5fJFsApmk=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/qEoMyrZ6O+xc8Hfg7AmaOf9u0CYPqryb6qhYhDycj1K/HWV4v
 m75+MDk3h/2ObOlofPzpcIjDLa4HrGEc4kqEHHqCApTYQ6PmRmDQJS3jbcGFA7HwSYc=
X-Gm-Gg: AYBFou1S4ZcPOHxIgutXB3Oy2F2uw51pDBk0xuFEq1QQLHnZTZ0u/WQYvFptk6T914w
 zA1B0Z+LVSjxmiiyzrV7yMaTbg0hKpzIyo4o4EIdXjU2Nv2QaWOjfnDFiPzOORenLTiGaA+P/hG
 IeEQiorQDO1ea7YrAM4X5bpdVjNrNvry3E117hZFHb33yhzt00pLM52jmSPmiRnkxI+kAJMxPUq
 R4AIY+3hYpUN/36zIR7KQxteExGCSdJ44SPfpdTEHaq6WzRGJnSWWnYf/pQ2p2ty+cH+vSb8XQW
 IFLSj+t3lqqXj3/HMWJ0NZ2VAzW1rwxzy0LrziDxjHt5JfYiJqLAI1b6nuQz5LoFB/84KqfyEP7
 RWCckMEGrol+dW1wKaTdM3K4LEQzFO9b9W1uT1F9r6vSJBooUIJIBfd2LnWrj/DCNlgrWOx+Y6i
 meWFjZUQCLmNXQ6MQ40CxAsuFepLACutKT83CcXPcLkDeHbdE+4JFcZ796OQywsHw8/ZFqjMQ80
 4jsnlpOHr+T/YYWn2kZNwzUMdOLlhtZx34NKpXoxSZfsic4r/faYslyCeKfZ5+CfWBdr23SxAo0
 SaTqAeSceoO3NCF6VbPntLKQz+Ze1iV3RsVWOUXTRtJE/yrj7lovXu0no/V3uaaZUsceO4MTnMr
 QUF21WgJb58Lx0/UqpuwwzBd5Efg=
X-Received: by 2002:a05:600c:a00d:b0:4a5:e6fd:65e5 with SMTP id
 5b1f17b1804b1-4ac19705d57mr346502535e9.31.1793782288260; 
 Wed, 04 Nov 2026 00:51:28 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:27 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 12/33] arm64: dts: st: add spi1 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:45 +0100
Message-ID: <20261104085036.4012238-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the spi1 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-13-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 4759748985fe4d4c25c87edeeca4b96dfa47a280 ]

(cherry picked from commit fdfa69e2fb0f024e72ddf590f82468e63ef9bd76)
---

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index c816a6aece47..4e570e2e5157 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -702,6 +702,30 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	spi1_pins_a: spi1-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 6, AF3)>, /* SPI1_SCK */
+				 <STM32_PINMUX('I', 5, AF3)>; /* SPI1_MOSI */
+			drive-push-pull;
+			bias-disable;
+			slew-rate = <1>;
+		};
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 12, AF3)>; /* SPI1_MISO */
+			bias-disable;
+		};
+	};
+
+	/omit-if-no-ref/
+	spi1_sleep_pins_a: spi1-sleep-0 {
+		pins1 {
+			pinmux = <STM32_PINMUX('G', 6, ANALOG)>, /* SPI1_SCK */
+				 <STM32_PINMUX('I', 5, ANALOG)>, /* SPI1_MOSI */
+				 <STM32_PINMUX('F', 12, ANALOG)>; /* SPI1_MISO */
+		};
+	};
+
 	/omit-if-no-ref/
 	spi3_pins_a: spi3-0 {
 		pins1 {
-- 
2.43.0

