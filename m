Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E5606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 12:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hv1l6nfx;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jlvx5e+3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B66560AC1;
	Fri, 30 Oct 2026 12:28:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5dPtQJBqQev; Fri, 30 Oct 2026 12:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7D73D60ABA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793363332;
	b=K19i64gcz/xFzlecy6ORNVSsw0LN1dEMy1WWIiBX8AHhR/lDlAwv85ug7Brn4/NsV9Rq
	 xOlq+G32w1aGGmXOiIEICBrwYXv935BRUAP1B+85pVcA5WFlyTscsvVDnEjCZK542nupS
	 nSf6MnBcY+Vpk61NFY7rAXIz/p+m4jbenK1AvQ0pIS/CuL8+DoMqY+p77yvguL+1El9zE
	 nhGB5nrwUa8FYBmOx6TOUre5WxqEdWpith8kuDF1FC8HFdfCOdHJtBO/8QfnEY8bCiDlC
	 aWfgbwF/x9WDW6o8qtixRtvkr5tKdD0JmFHPSjecLUa0GHLm9jGKzYhSe8lia+FjtBg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793363332;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZCAeolBhqxjnlvqhdfyRIJKuQxRGdv9ID6kOTpsSGpI=;
	b=irPz34ajR7tr9vg92lHb2jY5AvWdrL1SzM9hUOscauwmbcTTEdDYUKHIiP+CbLUfoq0/
	 SM2dyljcDUu5+Tkhg0/3Q/zgAWc2UOW0j9fiC8Phk9vED6Q4/iPFMZJqYom6PxIj8t1S6
	 hFamC05+bmB+DXhBB46SJ5iS1renCSJW89QT8+JMW+0LHT/dGOU1438qMY84i6VPidNT6
	 g6Z9OfzbbT9RPqn7xdHlnEiu0rZeAvwWv3bnQG/nqPG4AB4FsXTc0Nxx108Zraqcedg2y
	 MYQzOEWcfiDh2Z6VVXhcmsZQPZbhNRGRhEX1kBVABrNTJ5mpI57v3wuW/huJpA9oEqQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793363332;
	bh=ZCAeolBhqxjnlvqhdfyRIJKuQxRGdv9ID6kOTpsSGpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hv1l6nfxflJpoRJ+5vsCqPSVLQ4mwkQ55szcETON9B/vptUwobiXw0NW9rS7yZajU
	 7NR+iOj6i2nDsrIlKkYEDMfgwzc3opk8I7V9MeYasL8zLbxyEGp/JrBeqKJUgoNaRV
	 r51aHVcpAUawe2qJF2bG8UmzZ/cUaQUsC3bYRMi256x9Q3yKW/qL1+VDvRBEkKbel1
	 lEx/u51rVcXVZZ1BWPeqWFUZvZyN6Z4fGoDCniuuUx+x8WsydidJoaZY5qnq9bP/9J
	 CXDdb0MaozsojbkbCXQqAMGZhvML4G1NQx4GsuzCM6fzB8cNiXd2uSpUU66jNT/yCM
	 B5FXtqsbDkszg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D73D60ABA;
	Fri, 30 Oct 2026 12:28:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 21F7D529
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 138B281114
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CNyqkTouY1Ti for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 12:28:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E4909807EB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793363323;
 b=PM2cAIVE8buXwbJkNM0a+5gyJSlnCw2MNSAjkfzdEHaietvX1P09FpkwRz3Tw3ihag+I
 xWIJWXD88xgOjPtDe9jzMV0Yo9Aq9W5fYxmYzf1TUuy7fDm8bwdRB6U7QbEMHbaaBMSQS
 y+R530fPuOh/1lIvx0jCKOJqXDUML5REI8qf5eKYm8YsPJ8Mm+vhFDhA8xdwAVuLsQgjl
 Rep9t36N3SDqgihzRhPbHWImLeCGBcUSZeBIw7Qo1hN5DvRtC9dWKmOwB/N4WSYIx5K/J
 fS/tENgYzb4I7HuFZzuazM5qMs/zUgLFQYBMzJQOZwaaKHm7EjR2DP25VUkCIqz+aaQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793363323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=ZCAeolBhqxjnlvqhdfyRIJKuQxRGdv9ID6kOTpsSGpI=;
 b=cbqR7JhVFCGtvOreOxUeWbr2kjSqXchz39ZtfKszdeDM0RNUV1Q26HCcSKtj/UV0A4TU
 c+8OtxQ/AlKQ4LISRdfnYaCpzB5qWlJ6eIgq8SdgGkhj8137vRYPwfL7eviK2sYJJwNGJ
 2IGOj5A49r47jNvv6bhycOf1ubs9dwKmUyXCSt3DjiHyw6jqlCS8JQrHidhkPCCrqbcYi
 z8e6PRH67BeR7oIPETMcNnHJzNGWrQ4GlsxoZrGpPsDFKk60tIeuFwmmckFdXZ88V7bbc
 TvOChsbS6Q32O8coH0DD5bnoE2Tly8vG3tIpFvoRuzEYMNfgI3CoTPoOJYufo6eYpWA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=jlvx5e+3; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=msp@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jlvx5e+3
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4909807EB
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 12:28:42 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso6629185e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793363321; x=1793968121;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZCAeolBhqxjnlvqhdfyRIJKuQxRGdv9ID6kOTpsSGpI=;
 b=jlvx5e+3M9Xt3a4KcqFKt4SO/CrAPcuTG/yhs543dokVBL7a8c4UsZQAjGW/lkF3DR
 3X2NpR9JgxFDn/Xz/3y6Je/la/tLVLt1a47TgH9FuVkaGI4LevBx3lvITQMu9hawZ+a+
 7uGwICXUkZuCA/JI6GNo89ElXaFgJ7Mb9hFU1K8RFp4FE5RSd0TpbN+po3bbfV1a5B9s
 O5lGbapPXCuTnQF2VR2KN63HRtzp8NkJ06JJa/Im8fJ8QaBvKsVDooTIE/JjLLgYYJRq
 J+PG0Sfxd3fR+0W/69U9x5gsLyyYt/dz0QL8U9QWGwC7VJ1mDsx1BdGbDszpQNWh3XaS
 o4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793363321; x=1793968121;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZCAeolBhqxjnlvqhdfyRIJKuQxRGdv9ID6kOTpsSGpI=;
 b=Tt4/LxWgSdAqWC6KlqFPC5PmmR0kvbJR/9/7oQeUE+R4hli579DKkq9IiGjzxvUlnq
 WrqGAc28Gd6VkjYzj3cgQAJwaYzBePOCDPg1H8u4cW8NJw0kTw9s1jMgeu5tk0mXQZuq
 cB+UCAA8duBTNwfuIc129LnVoMLdo6MMHz+FofF294dfq4p5OMDwWEptlXb2mz29ePgD
 MhbsJnUH+CrouHyxYUzLMNS7vOFVYrId6TrUdtBAZdTvMitlC4PmQoWoBap93diGu4oY
 +bg9pDuTiBIAjwx0btrS1mQPS17vWdeT7DTzYRA6jEIfOvTs11pNWiVErTjdVC/Citko
 2UrQ==
X-Gm-Message-State: AFq9FYLovDj72aDJ5CCbTytuwTpmnI3dvodQGISvWe7UeIIYaCa1MI3x
 EYaWEacLALQ7s6mWLRekR0QNS7WB0uC9Tn66fPls+GqbOpb89V8jrL2jjZbSfswt/GI=
X-Gm-Gg: AYBFou3zhq8Q2CIZMWc6OJosPBXEmxmvkPYtRlX4ToncEFZ2M7XYPiFLdT07DLA5BGu
 uLpRgtXfpuSaDx6cAlI8H44BNNiHOltR84F2C36/2960awovfKCkiooIaXRBaIAnb03rMWKKBKI
 EufOhtGKxpOlBQN3t0+qizCeAJW40VGd/jdE0HYE/QPZiCOiZ5NPcgzK7SDNjlzpp4kit6vvRIh
 63TyNnslWC68QfpS7hg+772FZxqJV0o0lp7TUSIWzIwdZEFXKkBdIkAAgpZ6u+M/vEGdTVwNNS/
 K+5rYYKcxQFmcpfBRG0hSnDkGsVBj3UR6fx/R7M8d6sjlr6r91xL1ZgScEuCgvXSRJuqfCbHfDU
 kv+yYc9eNzT8rM3vmra4TSky0S5/s9hnUvgLYgKCRaQO2pff8YIr7UzU9LByiA1jNGCKs4qbyNA
 fVp7QJ513EGWJf46B21YJ2utO7MJfu/JkrvnknDBlcMRdXS1doxpTdbhvYS71SmrotnB4tTiv59
 Fvhv4dIO6EWSc16eS2x7AIVDuMOrfDlPApfUOrP+IsXUkMi059dT4x8juQSBoMm7BbaiHGYYRWm
 KhEAHcO1vYaLHSvdnsZFCJeGeXt+cnnt77LGSvaKwrAcIg==
X-Received: by 2002:a05:600c:1f93:b0:4a5:75d2:c104 with SMTP id
 5b1f17b1804b1-4ac17ffa050mr47452775e9.22.1793363320825; 
 Fri, 30 Oct 2026 05:28:40 -0700 (PDT)
Received: from hermes.wisent-toad.ts.net
 ([2001:4090:a244:81d0:bc85:7836:468a:a1a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm40777045e9.3.2026.10.30.05.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:28:40 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 30 Oct 2026 13:27:45 +0100
Subject: [PATCH v3 6/6] arm: mach-k3: j722s: Wait for TIFS initialization
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-6-2a67384ed0ef@baylibre.com>
References: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
In-Reply-To: <20261030-v2026-10-next-topic-am62-hs-se-fix-unlock-race-v3-0-2a67384ed0ef@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schultz <d.schultz@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, Paresh Bhagat <p-bhagat@ti.com>, 
 Julien Panis <jpanis@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585; i=msp@baylibre.com;
 h=from:subject:message-id; bh=AJ/tB5g8jsD6e/tbxNhQfDs7CnKMwSX8tCeuDnzbFHk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhqwnvVkv4ho2SMrNXH7N4wG/KZOhky6bBUfNwilGKpVnp
 wnvzS3tmMjCIMbFYCmmyNKZGJr2X37nseRFyzbDzGFlAhkiLdLAAAQsDHy5iXmlRjpGeqbahnqG
 QIaOEQMXpwBM9YVbDP9DeC+6LO705E6b9P/Yq88vp5d55ZWpVKz/cW1ziKd/Roouw3/XqwvmlPm
 8qTf2mCB+8cQNVt9zkzStRMT67tVkfjZem8wAAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
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

On HS-SE platforms TIFS takes longer to initialize. TIFS only removes
the firewall on the registers at the end of initialization. On HS-SE the
U-Boot ctrl_mmr_unlock() can happen before TIFS removed the firewall
leading to a race condition. This leads to a broken watchdog since the
signal configuration doesn't succeed because the write doesn't take
effect.

Wait for TIFS to be initialized using k3_sysfw_wait_ready() before doing
ctrl_mmr_unlock(). As spl_early_init() may already probe some drivers, I
am attaching to the EVT_DM_POST_INIT_F event to wait for TIFS and call
ctrl_mmr_unlock() before anything got probed.

Link: https://lore.kernel.org/u-boot/20250815160240.3575140-1-d.schultz@phytec.de/
Link: https://lore.kernel.org/u-boot/20260225051559.416445-1-u-kumar1@ti.com/
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 arch/arm/mach-k3/Kconfig            |  1 +
 arch/arm/mach-k3/j722s/j722s_init.c | 17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 3c567f50b223..a952638fc282 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -33,6 +33,7 @@ config SOC_K3_J721S2
 
 config SOC_K3_J722S
 	bool "TI's K3 based J722S SoC Family Support"
+	select SPL_DM_EVENT if SPL
 
 config SOC_K3_J784S4
 	bool "TI's K3 based J784S4 SoC Family Support"
diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index 1180c75f551d..7b09691998c9 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <event.h>
 
 #include "../sysfw-loader.h"
 #include "../common.h"
@@ -70,6 +71,20 @@ static void ctrl_mmr_unlock(void)
 	mmr_unlock(PADCFG_MMR1_BASE, 1);
 }
 
+/*
+ * Called by spl_early_init() after all devices are bound, but before any of
+ * them are probed. TIFS has to finish its initialization before CTRL_MMR can
+ * be unlocked, and any device probe may already need the unlocked CTRL_MMR.
+ */
+static int k3_spl_dm_post_init_f(void)
+{
+	k3_sysfw_wait_ready();
+	ctrl_mmr_unlock();
+
+	return 0;
+}
+EVENT_SPY_SIMPLE(EVT_DM_POST_INIT_F, k3_spl_dm_post_init_f);
+
 static void k3_spl_init(void)
 {
 	struct udevice *dev;
@@ -84,8 +99,6 @@ static void k3_spl_init(void)
 	 */
 	store_boot_info_from_rom();
 
-	ctrl_mmr_unlock();
-
 	/* Init DM early */
 	ret = spl_early_init();
 	if (ret)

-- 
2.56.0

