Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B062606A333
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wXOHD6w+;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oe0E1Qs9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49AE3607BE;
	Tue, 27 Oct 2026 12:39:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uZ8IxZuoNsGR; Tue, 27 Oct 2026 12:39:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B63B8607C6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793104784;
	b=S4wDMjQOdSF48NnwNFfjRUTG+n8BncS5Vrg2iV96daWENfp0FypGK4EirnwGvtyuITnh
	 eH1iixh4b7M0d845y+qOHivu0sHIS1kxCBFC2WvnVKLMKX5TYctix0Qm7NpmU+5rrhTrt
	 ucWrcPxniWy/IfJkqnrAW8DXwpr8Mds6bDTRsQPGF+SjdDrA6MrjryhTbk7TO+6rhEjXt
	 MQWNq3gGc2vWKj3TTEb6rifh8T3vOpp9XNPq/fMmfatDK8H8esBW+ywdEO4XDxUgqZATM
	 gHjOvu6EZTq1DuPyptOg1VMLYuiROXn/BuupGwRfrFSEWUKO68657Ae3PSM4WvtN0oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793104784;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=gRL6rdu+J/3sDwWMEayo7B5ZVX99Y+sA4mWM1c6pjJQ=;
	b=FtzPpzEjxpXmCE8AHflokMws3QPOMMdWzvjHnrvLapd0TD1z0Lqk/u4OlrHQyrSCydaO
	 SGtNOrB2G4a5Yw61FmXjrf6rRT0rh5GuIv9EbLmrbOMKQfDLuDkWq7vJEbmNq2zAueBG+
	 L1rM4boM0FxaRB3uGMOqsKssQHfY0fyiEaZOW/eKec6yhd2dD+hotY73ME/rIlbm7hcf3
	 CJXL6xGrvZIIF2EU8V3mVsZfH8B6Pefy/jCnnieVMAynJkbi2VtMWSPLrNyj/pnwjBVVI
	 k10GpYMxwpdXriTPwMht5iYiqUmtHLfvevbye1blsMyO4wbLCwuxRg6/v3spPWYvbyQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oe0E1Qs9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793104784;
	bh=gRL6rdu+J/3sDwWMEayo7B5ZVX99Y+sA4mWM1c6pjJQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wXOHD6w+t/IP4MvXBMVQHeffR893IhNna827UrlRPvVu3KvP1y90ApRUCX2Vyj5PT
	 uoyK5Xg/FY9C5nE8vXi76+e1ZSbaNalzfe4CwWnTseBq/8UEEXFVMj9MMBmGhDCVjH
	 YiZ/7g9cB0llvs8eUdaqxcxaIVDhWGOvd3rxK1IiO9oNFVsIvtU3GYqGW0f70661OT
	 KA0JLpucRjXA5IFWp9pX41vWvBuI1gD75bc5BC11fRL+JYQ+LcK0M5kuYB3C/TbKtq
	 qPgSX2IbfaKasTk17TRvLGHMkbU/cT0QjQBd2zLi/rcnMkq1Kv6Q2JPS5l96+AbwjK
	 CipOtr5Jdo4CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B63B8607C6;
	Tue, 27 Oct 2026 12:39:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DB843D9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3817160794
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZqSS2fsNSq9 for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 12:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F25D76078D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793104770;
 b=UiAKG+CmdKg2bE2D35CVQI01POKqxuDejPh8KaKWxJcoZcy5rAF1bQxuyQ3yeh1lHPat
 o6/X8jEw9kB2cIGfTeUbHMnYT8oKSpNcx/nU+BQZLnfIk21q613/hv6I2fMrOpNC7jSlf
 IJw6LaGIdwWtBv/ImHxOB0XsA1qgOniKBee3hcqh8Ifz6KrotbSTrIipDAqoix+ZV14Cv
 bwHYcL//cKFC6Ma1bJ3rwELJlxh4IPHJ+tD7NvaxLV0aAga/r4OZRRkSdYLoj7fjT2EU5
 41b+Z/gzH8JIuidUhRw9l/2GbaMS2deAPgCx98kCIxjqnLIhhemI7gNVSz6w/go29Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793104770;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=gRL6rdu+J/3sDwWMEayo7B5ZVX99Y+sA4mWM1c6pjJQ=;
 b=qer7W0pODmB6e+F1HmpxhzB0tSIGpVkXMFzLUi+wqUuA1vMiqO1qA01tiY5KK6hsMpBs
 qv8rRoGG42CiVUN2mkwk0lFcH1TOWCbNpBepXGXoptSQCvdSSim0sHO2eZDyU4u/zV+3c
 1A/AmnrJOicOlqLo92pn+FR9oa/ZAElzVSEmRuv3DxrJZaS7BmGIjeFLJpdNRCvdNCQEE
 yMA+bnoDlYY9wPfwlzp11U1QXpGRP/Ao7TVTdxKn/ffV3Vw/pwJCirXqDFst5kdbK4B6D
 AXJWd41yi9yiKM0AiA8JGmbHMxKCAOdc+X05a4Ol2Z9cB/cdCBCaVLcvAVoCufCu+iA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oe0E1Qs9; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=ansuelsmth@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=oe0E1Qs9
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F25D76078D
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 12:39:29 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso26909655e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793104767; x=1793709567;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gRL6rdu+J/3sDwWMEayo7B5ZVX99Y+sA4mWM1c6pjJQ=;
 b=oe0E1Qs9kgtxp/8+AiM9LQl9hBlZyWjEhhVFxjnPX9fTKJHx58z/9uWAF/P8FSUbiu
 UY3L/GqWkikqBjZz3jQAiodR2+5BAanez82xaFXRG0kSqKcDlwnQ+I8Sl3jRwyOLvE83
 j91+wWUPkU0ptv+OZ1NUPGV3pJ9Or4XqbXTSw6jdHzZBPDaO/1vonhGyV+JeetzC/7aD
 NvPzBGSpE61Z/DPRXNxl7Fl3Jp7PY19JbulnRWzvy3GjYBuDk0fLG2iFsJC0bpqkjA8P
 cb2+OZ3e/l422yi9eUJpgHHpvRRvlCNjF0af/7bKpZud4Ogo8vcDNDX79ltj0jMpmFOz
 yHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793104767; x=1793709567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gRL6rdu+J/3sDwWMEayo7B5ZVX99Y+sA4mWM1c6pjJQ=;
 b=GL6DSdypyUQGcjKZrlYfdDLQvhJjYyK41oKqr1raQ+13MIADvNfFVrDnnQj9Ta2rKZ
 9lzyXHTX9Zsuk4Kruqb/WrnEgXqufmo8abmOlRrPwph0NT+Ck1TB16JoyVGqWyG77iFL
 X2MTmzPzPsMXyKTGb8LBGDXIoa6eMpmUp8AwHckAIlM8+a2WrZymVisKe1k4IPo6FGym
 mZL7KEGLWkSRcilsd6lntzFyH9g/07oGo/YJ91wOrkAYr3XUDt6WTRfJebvrfrSdr5I3
 LyqYQAW+7V+AkP8BmP9CQTVirjogN2SpalxZFaTm56PTjOhSaeo9cLQjfgNaEDMf6JRq
 4uMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9+t8cwQMxrIFGiylvfTpbWpyqM/WYjqM5c3W0NGiwB1KGMFtXta8LK3FDzETxeKztgjAhkGI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJe0qUwQq85bcmfPQpGDuZAQu0JQlIpFinVKffimCC72/46xb3C
 rnVtnJdLWW14nk/UWbaRfaVjepu6i+5oO9DYSpbPp2BtEoFenrzeGo0e
X-Gm-Gg: AYBFou1R4RbrY/hrzE5t197xWeaMMaSNBPwUMoUW4okh1SHqekOxLr1NRrTpr7gMsN+
 tIpJM5tWuClRsgblLBzlJcrjS7cmiJbkKQ/XeOuBsWLv7HM0HJWoBZqvp0UGYF5k4aENRKl4sNn
 I2/rfK1b82KsZrwJ8M53y9R85bcCbT2TpK+3aTiSmWLtrC4w5oz8q0o3z1Zo8+pVRUlPh1pX/7t
 cb8EqbA1pIUFPZIwmVN/O/Tn0Wo2E04pFUdbdav9lc5tFf0Bj2L7ZYTHAXU/lNBScRM7lzgIOJN
 foRV1jwWJCpuex2YZpGT1WJtANfRs9bCusvyfY5K+lBcSSAuhSStg5h/UfHyjJcy3fcpWuGPGD8
 X39TCnAQ2rnnSTo3Mya7DRG0XJoLYJwDU5E1VuuBx2JZ8/uCH0w6/Etu3V5eqbw1YO8ngbwV45l
 sFJMdmNyX7jbcGrDyPm5V3vacbeGZ7r5K3Y/Ii/a1TZVS3Hm6tsg3BmiQOCBbTvzp79PJwU/fyA
 4xx0nfbPoSz0NxLEHn/YDzK0lHIoQugtSqthvG5o1kkIF0EWTchV6KWs+ovwNRgj6eERPXKw411
 esFHA96As0wrg+O1qZ4+aaStPJ2xaibFIBqdpv1B7Qb/HASbKQ74+QGqJC1I
X-Received: by 2002:a05:600c:6098:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4a35aae5dccmr186306175e9.0.1793104767288; 
 Tue, 27 Oct 2026 05:39:27 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it.
 [93.34.92.187]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd8c05sm29142078f8f.49.2026.10.27.05.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 05:39:26 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Alexey Charkov <alchark@flipper.net>,
 Rasmus Villemoes <ravi@prevas.dk>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Neha Malcom Francis <n-francis@ti.com>, Yao Zi <me@ziyao.cc>,
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH v11 7/8] misc: fw_loader: introduce FIP loader driver
Date: Tue, 27 Oct 2026 13:39:02 +0100
Message-ID: <20261027123905.839-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027123905.839-1-ansuelsmth@gmail.com>
References: <20261027123905.839-1-ansuelsmth@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Introduce a variant of the FS loader driver to extract images from FIP
image. These image can contain additional binary used to init Network
accelerator or PHY firmware blob.

The way FIP handle image type is with the usage of UUID.

This FIP loader driver implement a simple FIP image parser that check
every entry for a matching UUID.

Similar to FS loader, this driver also support both UBI and Block
devices.

Also an additional property is added to handle special case with eMMC
that doesn't have a GPT partition and require a global offset to
reference the FIP partition.

An example usage of this driver is the following:

Entry in DTS:

	fw_loader0: fip-loader {
		bootph-all;
		compatible = "u-boot,fip-loader";
		phandlepart = <&mmc0 0>;
		partoffset = <0x100>;
	};

	ethernet@1fb50000 {
		firmware-loader = <&fw_loader0>;
	}

FIP loader user:

	/* get the FW loader from the ethernet node */
	get_fw_loader_from_node(dev_ofnode(dev), &fw_loader);

	/* read the blob identified by "58704aef-389f-3e52-b475-e0bf2234a6a2" UUID */
	request_firmware_into_buf(fw_loader, "58704aef-389f-3e52-b475-e0bf2234a6a2",
				  buf, 261400, 0);
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/misc/Kconfig                |  23 ++
 drivers/misc/fw_loader/Makefile     |   1 +
 drivers/misc/fw_loader/fip_loader.c | 558 ++++++++++++++++++++++++++++
 drivers/misc/fw_loader/internal.h   |   2 +
 4 files changed, 584 insertions(+)
 create mode 100644 drivers/misc/fw_loader/fip_loader.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1cab469a3434..f1091e96775e 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -624,6 +624,17 @@ config MPC83XX_SERDES
 config FW_LOADER_UCLASS
 	bool
 
+config FIP_LOADER
+	bool "Enable loader driver from FIP partition"
+	select LIB_UUID
+	select FW_LOADER_UCLASS
+	help
+	  This is FIP partition generic loader which can be used to load
+	  the file image from the FIP image into target such as memory.
+
+	  The consumer driver would then use this loader to program whatever,
+	  ie. the FPGA device/PHY firmware.
+
 config FS_LOADER
 	bool "Enable loader driver for file system"
 	select FW_LOADER_UCLASS
@@ -637,6 +648,18 @@ config FS_LOADER
 config SPL_FW_LOADER_UCLASS
 	bool
 
+config SPL_FIP_LOADER
+	bool "Enable loader driver from FIP partition in SPL"
+	select LIB_UUID
+	select SPL_FW_LOADER_UCLASS
+	depends on SPL
+	help
+	  This is FIP partition generic loader which can be used to load
+	  the file image from the FIP image into target such as memory.
+
+	  The consumer driver would then use this loader to program whatever,
+	  ie. the FPGA device/PHY firmware.
+
 config SPL_FS_LOADER
 	bool "Enable loader driver for file system in SPL"
 	select SPL_FW_LOADER_UCLASS
diff --git a/drivers/misc/fw_loader/Makefile b/drivers/misc/fw_loader/Makefile
index f5df0db61c22..120722c4ed17 100644
--- a/drivers/misc/fw_loader/Makefile
+++ b/drivers/misc/fw_loader/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 obj-$(CONFIG_$(PHASE_)FW_LOADER_UCLASS) += fw_loader-uclass.o
+obj-$(CONFIG_$(PHASE_)FIP_LOADER) += fip_loader.o
 obj-$(CONFIG_$(PHASE_)FS_LOADER) += fs_loader.o
diff --git a/drivers/misc/fw_loader/fip_loader.c b/drivers/misc/fw_loader/fip_loader.c
new file mode 100644
index 000000000000..83c74e60d798
--- /dev/null
+++ b/drivers/misc/fw_loader/fip_loader.c
@@ -0,0 +1,558 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Christian Marangi <ansuelsmth@gmail.com>
+ *
+ */
+
+#define LOG_CATEGORY UCLASS_FIRMWARE_LOADER
+
+#include <blk.h>
+#include <dm.h>
+#include <div64.h>
+#include <env.h>
+#include <errno.h>
+#include <fs.h>
+#include <linux/kernel.h>
+#include <log.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <part.h>
+#include <u-boot/uuid.h>
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+#include <ubi_uboot.h>
+#endif
+
+#include "internal.h"
+
+#define TOC_HEADER_NAME	0xaa640001
+
+/*
+ * FIP toc and entry is always in the
+ * native byte order of the system.
+ */
+struct fip_toc_header {
+	u32 name;
+	u32 serial_number;
+	u64 flags;
+} __packed;
+
+struct fip_toc_entry {
+	struct uuid uuid;
+	u64 offset_address;
+	u64 size;
+	u64 flags;
+} __packed;
+
+enum fip_storage_interface {
+	FIP_STORAGE_INTERFACE_BLK,
+	FIP_STORAGE_INTERFACE_UBI,
+};
+
+struct fip_storage_info {
+	enum fip_storage_interface storage_interface;
+
+	/* BLK info */
+	struct disk_partition part_info;
+	struct blk_desc *desc;
+	unsigned int part_offset;
+
+	/* UBI info */
+	char *ubi_volume;
+};
+
+static bool validate_fip_toc_header(struct fip_toc_header *hdr)
+{
+	if (hdr->name != TOC_HEADER_NAME) {
+		log_err("Invalid FIP header\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int firmware_name_to_uuid(struct firmware *firmwarep,
+				 struct uuid *uuid)
+{
+	const char *uuid_str = firmwarep->name;
+	int ret;
+
+	ret = uuid_str_to_bin(uuid_str, (unsigned char *)uuid,
+			      UUID_STR_FORMAT_STD);
+	if (ret)
+		log_err("Invalid UUID str: %s\n", uuid_str);
+
+	return ret;
+}
+
+static int check_fip_toc_entry(struct fip_toc_entry *ent,
+			       struct uuid *uuid,
+			       struct fip_toc_entry *dent)
+{
+	struct uuid uuid_null = { };
+
+	/* NULL uuid. We parsed every entry */
+	if (!memcmp(&ent->uuid, &uuid_null, sizeof(uuid_null)))
+		return -ENOENT;
+
+	/* We found the related uuid */
+	if (!memcmp(&ent->uuid, uuid, sizeof(*uuid))) {
+		log_debug("Found matching FIP entry. offset: 0x%llx size: %lld\n",
+			  ent->offset_address, ent->size);
+		memcpy(dent, ent, sizeof(*ent));
+		return 0;
+	}
+
+	return -EAGAIN;
+}
+
+static int blk_read_fip_toc_header(struct blk_desc *desc, lbaint_t offset,
+				   char *buf, struct fip_toc_header *hdr)
+{
+	lbaint_t blkcnt = BLOCK_CNT(sizeof(*hdr), desc);
+	lbaint_t to_read, read = 0;
+	int i, ret;
+
+	for (i = 0; i < blkcnt && read < sizeof(*hdr); i++) {
+		to_read = min_t(lbaint_t, desc->blksz,
+				(sizeof(*hdr) - read));
+
+		ret = blk_dread(desc, offset + i, 1, buf);
+		if (ret != 1)
+			return -EINVAL;
+
+		memcpy((u8 *)hdr + read, buf, to_read);
+		read += to_read;
+	}
+
+	return read;
+}
+
+static int blk_read_fip_toc_entry(struct blk_desc *desc, lbaint_t offset,
+				  int pos, char *buf,
+				  struct fip_toc_entry *ent)
+{
+	lbaint_t left, consumed, to_read, read = 0;
+	lbaint_t blkstart, blkcnt;
+	int i, ret;
+
+	consumed = pos % desc->blksz;
+	left = desc->blksz - consumed;
+	to_read = min_t(lbaint_t, left, sizeof(*ent));
+
+	blkstart = BLOCK_CNT(pos, desc);
+	blkcnt = BLOCK_CNT(sizeof(*ent) - to_read, desc);
+
+	/* Read data from previous cached block if present */
+	if (consumed) {
+		memcpy(ent, buf + consumed, to_read);
+		read += to_read;
+	}
+
+	for (i = 0; i < blkcnt && read < sizeof(*ent); i++) {
+		to_read = min(desc->blksz,
+			      (lbaint_t)(sizeof(*ent) - read));
+
+		ret = blk_dread(desc, offset + blkstart + i, 1, buf);
+		if (ret != 1)
+			return -EINVAL;
+
+		memcpy((u8 *)ent + read, buf, to_read);
+		read += to_read;
+	}
+
+	return read;
+}
+
+static int blk_parse_fip_firmware(struct firmware *firmwarep,
+				  struct blk_desc *desc,
+				  struct disk_partition *part_info,
+				  unsigned int part_offset,
+				  struct fip_toc_entry *dent)
+{
+	lbaint_t offset = part_info->start + part_offset;
+	struct fip_toc_header hdr;
+	struct fip_toc_entry ent;
+	struct uuid uuid;
+	unsigned int pos;
+	char *read_buf;
+	int ret;
+
+	/* Allocate a Scratch Buffer for FIP parsing */
+	read_buf = malloc(desc->blksz);
+	if (!read_buf)
+		return -ENOMEM;
+
+	ret = blk_read_fip_toc_header(desc, offset, read_buf, &hdr);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	pos = ret;
+
+	if (!validate_fip_toc_header(&hdr)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = firmware_name_to_uuid(firmwarep, &uuid);
+	if (ret)
+		goto out;
+
+	/* Loop for every FIP entry searching for uuid */
+	while (true) {
+		ret = blk_read_fip_toc_entry(desc, offset, pos,
+					     read_buf, &ent);
+		if (ret < 0)
+			goto out;
+
+		pos += ret;
+
+		ret = check_fip_toc_entry(&ent, &uuid, dent);
+		if (ret != -EAGAIN)
+			break;
+	}
+
+out:
+	free(read_buf);
+	return ret;
+}
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+static int ubi_parse_fip_firmware(struct firmware *firmwarep,
+				  char *ubi_vol,
+				  struct fip_toc_entry *dent)
+{
+	struct fip_toc_header hdr;
+	struct fip_toc_entry ent;
+	struct uuid uuid;
+	unsigned int pos;
+	int ret;
+
+	ret = ubi_volume_read(ubi_vol, (char *)&hdr, 0, sizeof(hdr));
+	if (ret)
+		return ret;
+
+	pos = sizeof(hdr);
+
+	if (!validate_fip_toc_header(&hdr))
+		return -EINVAL;
+
+	ret = firmware_name_to_uuid(firmwarep, &uuid);
+	if (ret)
+		return ret;
+
+	/* Loop for every FIP entry searching for uuid */
+	while (true) {
+		ret = ubi_volume_read(ubi_vol, (char *)&ent, pos,
+				      sizeof(ent));
+		if (ret)
+			return ret;
+
+		ret = check_fip_toc_entry(&ent, &uuid, dent);
+		if (ret != -EAGAIN)
+			break;
+
+		pos += sizeof(ent);
+	}
+
+	return ret;
+}
+#endif
+
+static int parse_fip_firmware(struct firmware *firmwarep,
+			      struct fip_storage_info *info,
+			      struct fip_toc_entry *dent)
+{
+	switch (info->storage_interface) {
+	case FIP_STORAGE_INTERFACE_BLK:
+		return blk_parse_fip_firmware(firmwarep, info->desc,
+					      &info->part_info,
+					      info->part_offset,
+					      dent);
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+	case FIP_STORAGE_INTERFACE_UBI:
+		return ubi_parse_fip_firmware(firmwarep,
+					      info->ubi_volume,
+					      dent);
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
+static int blk_read_fip_firmware(struct firmware *firmwarep,
+				 struct blk_desc *desc,
+				 struct disk_partition *part_info,
+				 unsigned int part_offset,
+				 const struct fip_toc_entry *ent)
+{
+	lbaint_t offset = part_info->start + part_offset;
+	lbaint_t pos, to_read, read = 0;
+	u64 blkstart, blkcnt;
+	char *read_buf;
+	size_t size;
+	int i, ret;
+
+	read_buf = malloc(desc->blksz);
+	if (!read_buf)
+		return -ENOMEM;
+
+	size = min(firmwarep->size, (size_t)ent->size - firmwarep->offset);
+	blkcnt = BLOCK_CNT(size, desc);
+	blkstart = ent->offset_address + firmwarep->offset;
+	pos = do_div(blkstart, desc->blksz);
+
+	/* Read data in the middle of a block */
+	if (pos) {
+		to_read = min_t(lbaint_t, desc->blksz - pos, size);
+		ret = blk_dread(desc, offset + blkstart, 1, read_buf);
+		if (ret != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		memcpy((u8 *)firmwarep->data, read_buf + pos, to_read);
+		read += to_read;
+		blkstart++;
+	}
+
+	/* Consume all the remaining block */
+	for (i = 0; i < blkcnt && read < size; i++) {
+		to_read = min_t(lbaint_t, desc->blksz, size - read);
+		ret = blk_dread(desc, offset + blkstart + i, 1, read_buf);
+		if (ret != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		memcpy((u8 *)firmwarep->data + read, read_buf, to_read);
+		read += to_read;
+	}
+
+	ret = read;
+
+out:
+	free(read_buf);
+	return ret;
+}
+
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+static int ubi_read_fip_firmware(struct firmware *firmwarep,
+				 char *ubi_vol,
+				 const struct fip_toc_entry *ent)
+{
+	unsigned int offset = firmwarep->offset;
+	size_t size;
+	int ret;
+
+	size = min(firmwarep->size, (size_t)ent->size - offset);
+	if (!size)
+		return 0;
+
+	ret = ubi_volume_read(ubi_vol,
+			      (u8 *)firmwarep->data,
+			      ent->offset_address + offset,
+			      size);
+	if (ret)
+		return ret;
+
+	return size;
+}
+#endif
+
+static int read_fip_firmware(struct firmware *firmwarep,
+			     struct fip_storage_info *info,
+			     const struct fip_toc_entry *dent)
+{
+	switch (info->storage_interface) {
+	case FIP_STORAGE_INTERFACE_BLK:
+		return blk_read_fip_firmware(firmwarep, info->desc,
+					     &info->part_info,
+					     info->part_offset,
+					     dent);
+#if CONFIG_IS_ENABLED(CMD_UBIFS)
+	case FIP_STORAGE_INTERFACE_UBI:
+		return ubi_read_fip_firmware(firmwarep,
+					     info->ubi_volume,
+					     dent);
+#endif
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fw_parse_storage_info(struct udevice *dev,
+				 struct fip_storage_info *info)
+{
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	struct fw_loader_env_info env_info = { };
+	int ret;
+
+	generic_fw_loader_env_info(&env_info);
+	info->part_offset = env_get_hex("fw_partoffset", 0);
+
+	if (env_info.storage_interface && env_info.dev_part) {
+		int part;
+
+		part = part_get_info_by_dev_and_name_or_num(env_info.storage_interface,
+							    env_info.dev_part,
+							    &info->desc,
+							    &info->part_info, 1);
+		if (part < 0)
+			return part;
+
+		info->storage_interface = FIP_STORAGE_INTERFACE_BLK;
+
+		return 0;
+	}
+
+	if (env_info.storage_interface && env_info.ubi_mtdpart &&
+	    env_info.ubi_volume) {
+		if (strcmp("ubi", env_info.storage_interface))
+			return -ENODEV;
+
+		ret = generic_fw_loader_ubi_select(env_info.ubi_mtdpart);
+		if (ret)
+			return ret;
+
+		info->ubi_volume = env_info.ubi_volume;
+		info->storage_interface = FIP_STORAGE_INTERFACE_UBI;
+
+		return 0;
+	}
+
+	info->part_offset = plat->partoffset;
+
+	if (plat->phandlepart.phandle) {
+		int part;
+
+		ret = generic_fw_loader_get_phandle_desc(plat, &info->desc);
+		if (ret)
+			return ret;
+
+		part = plat->phandlepart.partition;
+		if (part >= 1)
+			ret = part_get_info(info->desc, part,
+					    &info->part_info);
+		else
+			ret = part_get_info_whole_disk(info->desc,
+						       &info->part_info);
+
+		info->storage_interface = FIP_STORAGE_INTERFACE_BLK;
+
+		return ret;
+	}
+
+	if (plat->mtdpart && plat->ubivol) {
+		ret = generic_fw_loader_ubi_select(plat->mtdpart);
+		if (ret)
+			return ret;
+
+		info->ubi_volume = plat->ubivol;
+		info->storage_interface = FIP_STORAGE_INTERFACE_UBI;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * fw_get_fip_firmware - load firmware into an allocated buffer.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of total read, negative value when error.
+ */
+static int fw_get_fip_firmware(struct udevice *dev)
+{
+	struct fip_storage_info info = { };
+	struct firmware *firmwarep;
+	struct fip_toc_entry ent;
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		return ret;
+
+	firmwarep = dev_get_uclass_priv(dev);
+	if (!firmwarep)
+		return -EINVAL;
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		return ret;
+
+	if (firmwarep->offset > ent.size) {
+		log_err("Invalid offset. Entry too small\n");
+		return -EINVAL;
+	}
+
+	ret = read_fip_firmware(firmwarep, &info, &ent);
+	if (ret < 0)
+		log_err("Failed to read %s from FIP: %d.\n",
+			firmwarep->name, ret);
+
+	return ret;
+}
+
+/**
+ * fw_get_fip_firmware_size - get firmware size.
+ * @dev: An instance of a driver.
+ *
+ * Return: Size of firmware, negative value when error.
+ */
+static int fw_get_fip_firmware_size(struct udevice *dev)
+{
+	struct fip_storage_info info = { };
+	struct firmware *firmwarep;
+	struct fip_toc_entry ent;
+	int ret;
+
+	ret = fw_parse_storage_info(dev, &info);
+	if (ret)
+		return ret;
+
+	firmwarep = dev_get_uclass_priv(dev);
+	if (!firmwarep)
+		return -EINVAL;
+
+	ret = parse_fip_firmware(firmwarep, &info, &ent);
+	if (ret)
+		return ret;
+
+	return ent.size - firmwarep->offset;
+}
+
+static const struct fw_loader_ops fip_loader_ops = {
+	.get_firmware = fw_get_fip_firmware,
+	.get_size = fw_get_fip_firmware_size,
+};
+
+static int fip_loader_of_to_plat(struct udevice *dev)
+{
+	struct fw_loader_plat *plat = dev_get_uclass_plat(dev);
+	ofnode fw_loader_node;
+
+	fw_loader_node = dev_ofnode(dev);
+	if (ofnode_valid(fw_loader_node)) {
+		ofnode_read_u32(fw_loader_node, "partoffset",
+				&plat->partoffset);
+	}
+
+	return 0;
+}
+
+static const struct udevice_id fip_loader_ids[] = {
+	{ .compatible = "u-boot,fip-loader"},
+	{ }
+};
+
+U_BOOT_DRIVER(fip_loader) = {
+	.name		= "fip-loader",
+	.id		= UCLASS_FIRMWARE_LOADER,
+	.of_match	= fip_loader_ids,
+	.of_to_plat	= fip_loader_of_to_plat,
+	.ops		= &fip_loader_ops,
+};
diff --git a/drivers/misc/fw_loader/internal.h b/drivers/misc/fw_loader/internal.h
index 1abe7504a81e..5af061321512 100644
--- a/drivers/misc/fw_loader/internal.h
+++ b/drivers/misc/fw_loader/internal.h
@@ -49,11 +49,13 @@ struct fw_loader_ops {
  * This holds information about all supported storage devices for driver use.
  *
  * @phandlepart: Attribute data for block device.
+ * @partoffset: Global offset for BLK partition.
  * @mtdpart: MTD partition for ubi partition.
  * @ubivol: UBI volume-name for ubifsmount.
  */
 struct fw_loader_plat {
 	struct phandle_part phandlepart;
+	u32 partoffset;
 	char *mtdpart;
 	char *ubivol;
 };
-- 
2.55.0

