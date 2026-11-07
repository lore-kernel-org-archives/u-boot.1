Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDED606A32E
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UtvspfVR;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Kde03GZ1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C074E80E37;
	Sat,  7 Nov 2026 14:33:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Jr78GDAlw-xP; Sat,  7 Nov 2026 14:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BC2C2816F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062018;
	b=ZlaDLqxyQcueyo468Bby+Jb0bIPSuyX1fFO0hXdbK8IRiy/ojRX53k+qUIKPIN5WmKvX
	 5JuAy2X7gw0ZucgzRKl5navC6kiX4WsGM61LAzkEcB+x0Po4V91vrXikoxEh0o7PU26f7
	 k/BKEuwKpkS7o/dQEjjIHQWIUmtB+6CfUy9+HRS0dXcSN/eDQm9qgjRQu/MfcUKx53zSk
	 ns3KANQb/d8V0/Piwd/n22ttUmWjsl/HL4V6+Dv0Jeiv2Q/hqYbxWjkWF4seLrM4mDvo3
	 2s0glSfXj3iGCdTSpHouYTmCSuinuH5JRSJE/dTvj2/OZk4gFFcSgOmqMMQRmhfzDpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+VgHs0O7RDSi1JDLQNY90CboxEgPTwYA0MNGljC19EA=;
	b=bna+5EYRYaA17f7TsUsVMb8xRCNYFKQoH1XY9tTZXyQIegXaya0VzAE7BxFaCegR7RL+
	 nxW4oKiaLXjc2B7nU1DBAwdmjDco5qDxCox3Kebb3nsIecq4aZftBziMsHVX2SbO5TQdM
	 muxv17OvE/1fnKPwNaoQNJFO3RwPiPGVUphfvwcAo8qZXtB/MJuRzNO4MzvlsmV4777AA
	 xxOu6OJ2pvvYA/bMZUe/TqfB0rIRqj6TrcoZm+9W8I6AolB0gQ58BqSWLVsYZV3kd97HG
	 +V7xLKP+yGBpE6L5D7lcOQaKnvAGq+0LAVpDwPX+V7H4RY4hcZFs7RLExy620Fe5e8Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062018;
	bh=+VgHs0O7RDSi1JDLQNY90CboxEgPTwYA0MNGljC19EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UtvspfVREwldy+Uo+OFr6Z6mpG009JqaWpfgC0A1EpHjncim0l37Y3Mu8kF/5ZC+k
	 JIW3tXL7tNOs3lsDgZKB2EbjHJTWhUhsV4WPR3Lhm6xyrn8HIk8nByGt3AkzG9vG83
	 dmbjtZ+2CxgYzbhWsBLzTAm6XHOIhkFDAxOOHLUvhAQqrPMWkcF0y12jxV7291ibQy
	 5kirtg1J1R8ieL6GCaKw3hbopsHw5eLXgOxIF7IiF6JYp6AnNjvYwv4QijmIoLmXEz
	 mpq9UonBIrsan0EXquDJ/clPzcjukkhKHcSKFWlAKwBUscUdMyfU+KaCAqA61B5rJa
	 Tnhak0x6uNumw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC2C2816F1;
	Sat,  7 Nov 2026 14:33:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BDF5634D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BB5E4075F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Esy1s_JkhYk for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B46A740757
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=Kde03GZ1
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B46A740757
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:26 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so10491075e9.0
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062004; x=1794666804;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+VgHs0O7RDSi1JDLQNY90CboxEgPTwYA0MNGljC19EA=;
 b=Kde03GZ1WBb+1FCD/u/lGGYU3DX7n8j1xfaqZisbAw6fRMgSBKI27ptYDJZAEQLXEK
 p6hSfrIoYMjvtyg0gbXJH2wvGjaRWtQyNn242zMSnQZEFspy4nIU8S1wtvWwQAaeFOMW
 PIWhKm410guIrJmfLhGKb+SPHkC0akdEcMzd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062004; x=1794666804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+VgHs0O7RDSi1JDLQNY90CboxEgPTwYA0MNGljC19EA=;
 b=no+P9QVhkbkHr90QsHhvOcSBx7cZbSrJE8wMUhGtrH44AHqa2inw41ejYKBZY406F5
 GmQzb4SW4xi8776T2WrQyJR3U8y+32sWyHEWU2k5LfyxugrHER2F7YhRlZ5W3rxFbVMC
 RpVQMY9gp/W9LDJ/QrB7P6mAOcvc6OD37sfNdM29zMAW2m89niqE63YiRV/RdShYjHE+
 UQcpVmKc2X7O4rhSvpsjzgxVbsZgiwmX/HZejQ79Vu4hPU151yF7HLViDnj/G9aj9nia
 IeM8Hsqdal9VN51Jl0Dw1B9yz+rVKTB4UYymqT5psLD6TO6If3fvymB8biYvSl95nXnc
 KcJw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjrb9CzGuvX0br9I8mUjZOhyYvqxmG2WuL1HzFAWYWO5H8zIjKmpzWT5w9IafgtPX0kg0CSs0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+9pG7BO7KuYWH8Rb9EIp1OEmm9Z55OuVTv5OMxgvCd0RV8ddj/
 dCN3Et14VZnN/6gcNuNpXPlILw6pJtoqGH2GsCW2WrEBchBFf2b8McxnWFWgJwygBIc=
X-Gm-Gg: AYBFou3QEmP/vBDDbhEFzbrmS+ZkPLq8d/hkt9ZvQhP9OndSlJlBZdTcJ5uHbYEh1o9
 BhxPZIORsJrOIOSS6KTjFnxp+7UiTAbBt5ce1iZcSfuVmRMk3nyosJvy5cQXMMuqZybTgD6B0c3
 SzycR4bAxDcIqD0T36TJY9MQERVD/cUOWc/viL+ewT+Q0CK3T5XfLs7TwhcdpuontgGPkNaRgJU
 ww5sCwbGiI6jJFE0jdlHyqOi955nvBHRjfODPycJ7C+rzGPwgeZEv+FQ3c769ePcE/CPCrQDhGS
 eYJx8Gf0Bh9LhiHUDFgC91hzpKXVA1fcM5G/ynB+w9rtjsQsqlKv8ubaGOnE9Kn+0W4b2Gi03ry
 lAZ+gpVp31SPc8bbqNv2FFvZtnIcX76g9DesLAPzNWA+ulOBrYX029tettSg5Iq5Q9hxCSMohs0
 qWjsJCYCc7hAndD+DbAFLIwVQmOFxOfTe5l5T6lDuLE0XsSthyHnSWzBI1xJlRlK/rIOPMJ8AgH
 UDcy98hGmQqjEa5RZPksENreodilGfrSLUUVcxZUA4dsCvwVIswjVQAroqmdmfGbCPv4bAj+s/e
 qQPa6ii7ccMoOa72op1DCPRuir24hAz86OZWwZpVejr8acZaWn8lq60w2MpSzETjKJp2rdUkC1R
 Ztw9AhSXLR9UmjxtlC7ja6dX0ua0j88tHLOlV2K/mzsHqBM47HYqcJa5AmZ0GEiEkiFbezPq89j
 FTFcbdQtW/ypzfY2ghGpm+Rb6ILg==
X-Received: by 2002:a05:600c:19d1:b0:4b1:32c8:27db with SMTP id
 5b1f17b1804b1-4b6de691614mr98401365e9.22.1794062004329; 
 Sat, 07 Nov 2026 06:33:24 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:23 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>,
 u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 19/35] video: stm32: lvds: fix NULL pointer dereference on
 missing data-mapping
Date: Sat,  7 Nov 2026 15:32:09 +0100
Message-ID: <20261107143241.2236511-20-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The "data-mapping" property is only required by the panel-lvds binding,
so ofnode_read_string() may return NULL. Avoid a NULL pointer
dereference in this case by falling back to the VESA mapping, as for any
value other than "jeida-24".

Fixes: 16cfbbbe2b51 ("video: stm32: STM32 driver support for LVDS")
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/video/stm32/stm32_lvds.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/stm32/stm32_lvds.c b/drivers/video/stm32/stm32_lvds.c
index bf1393c9e872..a16331296388 100644
--- a/drivers/video/stm32/stm32_lvds.c
+++ b/drivers/video/stm32/stm32_lvds.c
@@ -614,9 +614,7 @@ static int stm32_lvds_of_to_plat(struct udevice *dev)
 	}
 
 	data_mapping = ofnode_read_string(dev_ofnode(plat->panel), "data-mapping");
-	if (!strcmp(data_mapping, "vesa-24"))
-		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
-	else if (!strcmp(data_mapping, "jeida-24"))
+	if (data_mapping && !strcmp(data_mapping, "jeida-24"))
 		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA;
 	else
 		priv->bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG;
-- 
2.43.0

