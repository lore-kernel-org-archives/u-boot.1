Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258F6C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 22:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 555AE877BA;
	Mon, 11 Dec 2023 23:06:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jbOvBd1i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F8E877C8; Mon, 11 Dec 2023 23:06:54 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 727F9877BA
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 23:06:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54c671acd2eso6683348a12.1
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 14:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702332411; x=1702937211;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGkLEQRM3D1qTvh/uatY6K0aHk45yREvABtw7lFzQsg=;
 b=jbOvBd1iiHsAWGaBgCuVrMlEqYYQ2gD+GVH3teqsqR5+OHOxjsKvQ2t6k0YDUNa89Y
 h5Fj6vX4cRokzPbq/bPjqe7DrdQuRBAn7J0V9C/HIDbekGrcSIT+gG/03+tJtz29kvD9
 8t0V35UrmFi35LV2Z+L+JDJM3BkYx5sZttTnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702332411; x=1702937211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGkLEQRM3D1qTvh/uatY6K0aHk45yREvABtw7lFzQsg=;
 b=VOoeZNiH0EBMBCDs0eXR3pQkKVNNP03nBarlaAVFYGGYFSlBBJn9TFY/3oyRJ+KcV+
 RhyxH26Sr4LQxpNhYUkT+7mS42+ZYgh2Q3TsRryJMXcg7O57Dgea9epOrReA5a5OT3Xd
 ZjZ8wWHwMVYVqeNDLyoBAhmBxN40xNUy/eccq2BroscFD2o6Xt4dz9TvdU5iUZaisuBV
 G7zCszHlvTLfu1VqGYHbMwCIFklzTYfegemhEUnWan6GQD0aTe0zG8bRjC+We1UfI6Da
 a9ea9BEAPzXhDNnIQ5EyjgfQFMgvvw8PsQd+XJKlUPgZH5xlWib6NzBeLJluYjd0qAOu
 wpGA==
X-Gm-Message-State: AOJu0YxIaYFCNnIADfghvMb9hEt+Mv1YhTXhWlSs4hHF8YqsU2YQlArh
 L6LJFti6oSu3XyuQBBHEy3WUPvG1uyc6qqaoqcFBNw==
X-Google-Smtp-Source: AGHT+IHpw0bWQjQui1liVzd6FPJY2h+BeIS2Ygo9Nmuw6zmL8u4oOHIjfwz09Z0dyN4j9q1OmgOBgg==
X-Received: by 2002:a17:906:c258:b0:a19:a19b:c701 with SMTP id
 bl24-20020a170906c25800b00a19a19bc701mr2521435ejb.81.1702332411646; 
 Mon, 11 Dec 2023 14:06:51 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-82-54-95-129.retail.telecomitalia.it. [82.54.95.129])
 by smtp.gmail.com with ESMTPSA id
 se13-20020a170907a38d00b00a1f78048f08sm4568276ejc.146.2023.12.11.14.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 14:06:51 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v3 1/6] ARM: dts: stm32f469-disco: sync with Linux 6.5
Date: Mon, 11 Dec 2023 23:05:51 +0100
Message-ID: <20231211220643.1073606-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
References: <20231211220643.1073606-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Sync the devicetree with linux 6.5 for stm32f746-disco board.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

(no changes since v2)

Changes in v2:
- Add Patrice Chotard's Reviewed-by tag.

 arch/arm/dts/stm32f469-disco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/stm32f469-disco.dts b/arch/arm/dts/stm32f469-disco.dts
index 6e0ffc1903be..c9acabf0f530 100644
--- a/arch/arm/dts/stm32f469-disco.dts
+++ b/arch/arm/dts/stm32f469-disco.dts
@@ -119,7 +119,7 @@
 		};
 	};
 
-	panel-dsi@0 {
+	panel@0 {
 		compatible = "orisetech,otm8009a";
 		reg = <0>; /* dsi virtual channel (0..3) */
 		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
@@ -138,7 +138,7 @@
 	status = "okay";
 
 	port {
-		ltdc_out_dsi: endpoint@0 {
+		ltdc_out_dsi: endpoint {
 			remote-endpoint = <&dsi_in>;
 		};
 	};
-- 
2.43.0

