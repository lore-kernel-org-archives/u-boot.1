Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D3606A334
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kkR84BgZ;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=C+sRg6J6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D72766070E;
	Wed,  4 Nov 2026 08:51:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k8iUFoMXzwCr; Wed,  4 Nov 2026 08:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E1F1560755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782284;
	b=CFyVBTtCAAkbGB8Gy8CedXSy+0aN87cxQ/Yeova51h96i55DeK/sNJ3hx+u59+nadiNw
	 GakFZfYyiOfbp20Nop1g0W47P3WdV0Vbajqd506Yae1Cv0yeIIGuYvhD+6O9cEw3105Y9
	 v2JJPmi1jgQFaZ9BwyqM3x+WiKUv7rmZskOpxHUTQXno15Gp7h3ku3PtkES0vhC4HCZim
	 DjDRcH0e5mU9TQroNJyRjfq1+o4xmRzVW+8N6ZQYfR9oR0zFF8/58PdK8kb76KCPTHiaY
	 U+z2/oN+NlX5/X1ZOtoqy+TCoFArGfCEE24OJEw/eXi+2a9wcTH1IDlUvnfgFg2kQeA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782284;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cNroebNVgOoI4C8qRT7dwpcF6OXjIPaNF1916N3lbZ4=;
	b=J9RcjC6mIOtWvsVkAGn/CmfU1uALO0pQWZEDU7GttvzB9kJJ2Yl4ggvmBRbHZCXhEgwY
	 Sm2Vfi1M40FO77JzXOJJr+3FsgpW30inVbkVk8jMX9PyOu8HqYqJviy35g9gvfWmuJitW
	 VH+67CxszI9Wfbz7uz4gmDhnJzrUeN1Mxn4GyM3GzJtLbazVnmXHycvRlxHUyMYfZoHLq
	 eJXcYAFNsfdWAP4GXWr8xYbIkQ7ZCf7c+0PYjblB4hTsdj0yynv+tPJbzgL6F4qlYXG1f
	 T8RSxsastzjBMrNqdBTrwxBAZ0Xa7+lKuXtvEUqyqYfEV8tQmXUhAw4O/McBgpNVz7A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782284;
	bh=cNroebNVgOoI4C8qRT7dwpcF6OXjIPaNF1916N3lbZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kkR84BgZbD32VjzstBuAuh2+3lo29wBiq1c4dd8SqBosIprdWcH6Ajkzg9DJzb1pz
	 H+R506ZJXNtj3n+A/Ay2QyYOluwCuRsE9omjtwYwkCNimkwcGneBzQKMmmEZau3SVK
	 38cL4ve1fykq0F7NdWf8y2iS1sptzHFQsWNUhIOnHeNkKGymcX2DGTyQmRBj623KId
	 UN4AU31xF/0uP/mHQRbtdtoghCatSh2273AOjMQOGHr3frDtIvxfoIRkZuJnYYmdgN
	 wW19GCzU/t5sba2pEe0kpkxyE2hI+aA2bkZoYa6i0gNA5nMsIzlM75kud7alvU6YEO
	 UQDZI4hFpvbXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E1F1560755;
	Wed,  4 Nov 2026 08:51:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B1E3D2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A354040778
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B_ZT7m3PyXzt for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:51:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1BD4F40708
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782281;
 b=M6+AnqKv5ooT/zRtvYV38hfgkQWUnEXQoEzVB8n/JeQYjKVStejfX/xksj0I708eqkEX
 Xrfn8yGm7XUuUGWuysbRxhIBYQssXFjfXumMCwaAoBTUx3+oDlvBkpfamc3bIOxC4/E/T
 TgaVlWTwOZkhH3u5pbkrzzxhZrAIMVbgbIDgVp9yFpyAamaqStp71iH1kFM/coTv+38mM
 HbAoOinpsBDINylZrfVcbOTv5Kmc0KRwoJxqCRqI7NSOslFDdDvgcrpilyCg313lTFjB+
 xAVe8jNlcEqj6NGZb6eD8/MlZw21vfdYFh9VGRbwOW5OzTVhs8IyWmc29X8nIMeWeSw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=cNroebNVgOoI4C8qRT7dwpcF6OXjIPaNF1916N3lbZ4=;
 b=MDspqk9yIfCBLpA8RSrJkKhFsUYDb2yf4jKqHyip/awxB4i5Yn5y8Dz+JMwMda/SsAQn
 Ib69Gq818kfTfh2XXisv945h4/Q8cpElOiubsWNApMqlAHwvw2shKgcu0LbmHlnmdoai8
 hdtn6JsvJjC0tW/lpPmkyjsEJNp7siuvVoSITxU9XVrHmbSGGYyywn1Gn+C87l+swlr90
 iSoKqf7aiGc6Wh7ePmMs2cZeeoJ6HlH6f3Ss1kGVAOd+4S71hHQkGtFkEh5kx11EmSzxv
 rhh6cwP0F1GOJ7ukBCpeZmAGy57b807aqvGhCr048iptNEpWjugsSVTgDGbotNMZNLg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=C+sRg6J6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=C+sRg6J6
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1BD4F40708
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:51:20 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso3558705e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782279; x=1794387079;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cNroebNVgOoI4C8qRT7dwpcF6OXjIPaNF1916N3lbZ4=;
 b=C+sRg6J6AK/IrTW+s8ITIYEMU3kgqTrYOR6/hb30e3MohrGmVfVZPs/Id63EHSsuv5
 Y3eKd9jfVongeGQuXWI/x051b+GNQOl8JvmSj4DKFusVCO1C/YAqA3CHYCXuAYIg0+V1
 YblwgLiYVNTJzmhA2geQauUXAT+Jia1PJ8cDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782279; x=1794387079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cNroebNVgOoI4C8qRT7dwpcF6OXjIPaNF1916N3lbZ4=;
 b=l+vdVNBUyYYjqQOc5ZL08tKLbg8DIwwqWei6TRUm7xXxPXj4+H4GzJpO84TKlPVEiv
 lkKRW1tVubc+Or52W5TMU4r9hq+nzONU4tLZiJE5eEyXpH/taraDGIJ6JZBgeUPZCD+d
 XD1aNe4CqAaufUPMfwaq2rVI5H3B30ooHQHabf2IdZ6fMYJ17N4rk9TyoEYSYXxjQ2Du
 swRd1F5IwG00bbotr8Q2hrmMyzdSFgXxhRxqGyb+fqwP/swZSDxdU6KdvCY/lzdVCrEz
 l0vNBlkEsQV37/xqQmK7Qe7hGZKgtffp3CRoEyaUs4PYNznD7HuIJy+KC9HjOMWR0BTh
 ytDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxitPdCJewbO2bNctpm9MtEQN58I9f5YL4fEX06ywpBkReE/cO7vYwopxtScokfC1kaNF/qji0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9lSYQfWsZgd+K0hVPQlar52NGBVguopHtgIjUWSSSWceNK+s3X
 6j44qO+FfDLA7TIXSGTr95suqN9ZgkqE3DjlHagG/LxWF6jU8HgQshm7bzYlvy9emK8=
X-Gm-Gg: AYBFou2ldJ1jZHTCFAhoo0xDb3F62hd12p3DtoGzECbxwrERq2JlXUhabJKX0l0LR7b
 e/VulP88s10QhZjMy4Qx7rdmnhfzrnCqBjLcFvuJ+03G6QTZQGFQ0xiFEyh0ZhbHY++Lv7meW0p
 hsfe96JvN+fY0PbzKTJXxdNf4QwmpJtir38OrSf2HWwwVQJo3XNidHpqdEMEzySNNBg6x8qzYUU
 JOhpZkUqitJs4ITGYOwC6rW30P7hJJjb2KQCxwqK3AgyqNv5tP/xIPvHgC/lMqxOPjHpZlUuiIv
 N64aZNLWX9WycNfDF/xu0TFe9HOhxIupHmLQ3WTTn3uVKJ/ykj4gXt1v48LaJmpXCYzr7aKyiOX
 lp/phJE37VKv5pyRcw6mnBoWv1PEKHNn8EaUJMhEj3eQryiv8jutDH+58MRpC/Bh1v0Vvpzf23Z
 ZbARzJcvp7iyjbXd8TYKOADSwjD3iWpIXrQp3rsSHgfrbaI//kOSt0BVtuNcE4UV2VVkdDf2n6x
 LX0H/HLvDyu4IuKBaE7z1lRLyAZHEBHZdBxQt/0KBLk+PxQcQm1l93gy/2xGmKy2CCRcDJgeyU6
 P0zTlSiZr87XKx5mesu7IV3ULXRtK3Iu38GbJWYQ6tKzJOaRM4twcioJaQD1fpWN9GaRlvD3OQ6
 l0PzjndKFw+ylzSbcwqpuErKM1e4=
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4ac1793f8ddmr369198335e9.14.1793782278972; 
 Wed, 04 Nov 2026 00:51:18 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:51:18 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 09/33] arm64: dts: st: add pwm2/pwm4 pins for stm32mp25
Date: Wed,  4 Nov 2026 09:49:42 +0100
Message-ID: <20261104085036.4012238-10-dario.binacchi@amarulasolutions.com>
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

Add the pwm2 and pwm4 pins used on MicroGEA-STM32MP257D-RMM board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20260820091652.43541-10-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ upstream commit: 3c7876c003f01223e111444a93d5861d86d8022c ]

(cherry picked from commit 1d936c8ac7bcd3a7d8aa42ca88f8fbaaf3e63194)
---

 .../src/arm64/st/stm32mp25-pinctrl.dtsi       | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
index 6482dd47e977..695c9d771853 100644
--- a/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
+++ b/dts/upstream/src/arm64/st/stm32mp25-pinctrl.dtsi
@@ -433,6 +433,23 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm2_pins_a: pwm2-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 7, AF7)>; /* TIM2_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm2_sleep_pins_a: pwm2-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('I', 7, ANALOG)>; /* TIM2_CH1 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm3_pins_a: pwm3-0 {
 		pins {
@@ -450,6 +467,23 @@
 		};
 	};
 
+	/omit-if-no-ref/
+	pwm4_pins_a: pwm4-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 12, AF7)>; /* TIM4_CH1 */
+			bias-pull-down;
+			drive-push-pull;
+			slew-rate = <0>;
+		};
+	};
+
+	/omit-if-no-ref/
+	pwm4_sleep_pins_a: pwm4-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('A', 12, ANALOG)>; /* TIM4_CH1 */
+		};
+	};
+
 	/omit-if-no-ref/
 	pwm8_pins_a: pwm8-0 {
 		pins {
-- 
2.43.0

