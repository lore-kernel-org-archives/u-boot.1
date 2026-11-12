Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JLO+PA2b;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cTQh8QXP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC0B2816DA;
	Thu, 12 Nov 2026 21:16:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 148uzY_dVAJF; Thu, 12 Nov 2026 21:16:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4E9C581699
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794518190;
	b=PkPyhycR8WlHmn38JA1t3JTLScR18ifWskkU1xtvXMWS6Z1HC4muexgcaGKcmVRtaLZx
	 2PZZXe1QIiZrAnsmS1pxw1/ETe9i0vHKc6DA7VXycXuaD56CryshtOx8si/Isdg+2JHWv
	 4zgT/jPfEsqc7x8D6d5mVK/5fA5OPJRr94R0UPwYbYWEex1Uv7Mp9Rgkx/aoCjibwuZJz
	 3IZK5JOGqSkvx1rWcH99V5EG15x12LLpwt3e+HHJmfA1bLOVDLsImL52pg4irNr1HsfIw
	 EMSlHcx3x08pPrb82Rs4PoKUqvBClB3u+dKGHuddmJy2zNFI8le3fX6Ry/JY2hST7xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794518190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uredMwCL3czR9k8+EB40SWEAVtsqYxp3O90VQ41J7rA=;
	b=Sc0VtDo91qHqDFzYQG101judrvkWAERnb9mFXZL9ozk2cRPrtW1yNxXq1/1+xPNMAHzC
	 m/aQZuvephcAumAYS+OqFbJbYooOw6h+Nnpz23zZZMF7IctLL2PB9E+WtyrQ5eSq+3mRx
	 SQSIzoqfb+XG+dkcIqzviFOoIxdB+p+gChXtL5nW3TpWdZwVbXrsUOxxnpGZdQrsAbYAp
	 7RhhsNxpbXk/KaarFtb+Ytr+b5pMgXFUQ0c1vJof7W9uT2OMfVYYab8wpxArznFMycR+c
	 gETZz7ZS+A0Cq0OBboeAmdR9hT8T3z0bggLqLbD6Z0KLxA4wDNFkYqhJZusy1ohsytg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=cTQh8QXP;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794518190;
	bh=uredMwCL3czR9k8+EB40SWEAVtsqYxp3O90VQ41J7rA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JLO+PA2bULUFVDKFkTttqWn1r8NV7u9R7wUZuRKoLp6fVB2fOgZ7Dkf6RQwViMZJ4
	 47NGSaqyNDXR4YEvfLZusSyZEllWenEfJfm+O87EKz5lMv4RD21JxyawhXaxSNjaxa
	 JJFOxz/z/ZAmN+1V2AiMBzbut9GdBEhgB/iiPGpiV3hpreHk1YRybb90GSgLNX6BaP
	 QztF/UCsnrINpJWnXpSiR7IokTy/OcaWlN73Tv/2AjD/Kw//SBcyk4mL072WEQ1DC+
	 8ck5X6qOaNsoYGGQBC52qVZB0XIvLTfCdideqwzoXLvcnZjl4F64KNY8o1hI+DtFy7
	 IYlMxWB5/1ZKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4E9C581699;
	Thu, 12 Nov 2026 21:16:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B5161370
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C5D9816D3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fP4MrBxmL1Cj for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 21:16:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D0D7181699
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cTQh8QXP
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0D7181699
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 21:16:26 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-86156cf8a7eso837689a34.1
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794518185; x=1795122985;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uredMwCL3czR9k8+EB40SWEAVtsqYxp3O90VQ41J7rA=;
 b=cTQh8QXPTCioM7aAr3Nl2EJxH7CE+uCZl8JL4GX54Qe0xi9mwfHF35jLrau3XvlW/Q
 jBbHc2ozvQwyrRO+X+DOwNd1Biuboedy5pZIlza+0skpEgN6tvjjmceZ2be3dl39cn8P
 M6IGLYlhQPkOLfEQnjuFDe7NamN5OKXeCkM1S8Sx3VeBiJThJDisPDZJ0CtalZAicVyN
 5vzyUZ8Vs7XKbJcQe+ONyixWRoYLcNgrX30GkTiT6K+8bfQkX567G142UEWVEUH5dut1
 bj3ZwDL0Xe60APJ7ooHyPy8vb5x1jyLT7y0MpN7aiftY+W7l0/oTB6TcTCQZ2Pp/c7TG
 Jcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794518185; x=1795122985;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uredMwCL3czR9k8+EB40SWEAVtsqYxp3O90VQ41J7rA=;
 b=bb+zvJ84czDO3OPvatQwtU51JzpzdXZ7lYcW4KycJpjtlQdIO3gajJDgwItmmgI62A
 uGJhYkRI7jWav+46HE1Bg5TDDSnNzqcDSz0hDObILTofikl8DZkZwrEMyNEZli4xtmxY
 4gEEVM7jqVjtpKRqjXTsVlCZRs14CpQcPo/ddqzL2i7SXW9YAr4n1awc3Z8vDKKCZ3ZQ
 HImANRBqakv5WbKgKr1dbJOq8UyntUhYbauikpkWUB4ZD2DQ0Ajvl6PoNaXs10gRmwoW
 27GL/cEzkA+I2r6mfZAXj+9cbpSF/t7HCT3Fz8+DEt573vCO+hWkGiKnTtyBArJN76SR
 wdZA==
X-Gm-Message-State: APuU4Z+kgbxx0R2dpzjq4IT8wUOxP2cS3TX869vTv90qweGVRT/vjMSb
 KwvrL30YDbHP1VFkNQsL9lbFGbXwxH2gDDLiMxiy9pu0EnPI2MCJ2SuJJhj983An0UM=
X-Gm-Gg: AYBFou2/AqaCg/xn8yKbr6la2J1Yvyq7Yiaf1j6S29t1oXNh9n9pXHY9iWpdKsp4ffE
 yU/wx+vdlwYbzgrG4Xv5frKvJkN1yRti98ntkF8Fba1vRa8UoKgS8if6AjAwn5OngfDTdqO4Gb/
 yAzVBE9BQZdg79VErs8+ScTkIlA6HuFS7Z6T+gQlIpi4HSij66JbceUCSIw9WxTKfbzL/xtxEXd
 I4Sca8Ng9prxidv+BkfzS7oDPezIdwXzmc1Qikbnx5bOPeiU6mFkgfcDSItZgyXvjjAbcQZiQZy
 Sl60ujKOgbzR0JFRXq4dy1r8egL3UlkELNpyZfoAt5q5ogJHOtFnmrXaFAwHED9fSS8dD+7Re0f
 TWbbYf0RAdnChMjGylv3Jpe4kKQeyeaQazbU7NMV69T9ykpKDC9yz7OEcRmrjer0kEcfXLajPiT
 msyHNy+V8FjWmrEh9ASYm1Sk6NfcqyWNkbXgSNN7V6akAnk4sZaw/kBW/j+HAdU1wbpXMijsOcF
 kUXZiAsNBcpSxCP5qml5QoGMHM9fIAQQ4NT1NPiilRIchZynrvTOIgqnDmK1sGnkcz7HB5Psygc
 e39L+BeZMqTGRxxWVKiz4Lm2ioAAjgXUaA==
X-Received: by 2002:a05:6808:50a3:b0:4d6:9133:cff6 with SMTP id
 5614622812f47-56e65f50deemr391680b6e.29.1794518184817; 
 Thu, 12 Nov 2026 13:16:24 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1a61:46bf:438b:5fc0])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56e70d6572csm263804b6e.15.2026.11.12.13.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:16:21 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
Date: Thu, 12 Nov 2026 15:14:55 -0600
Message-Id: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WSbYvcIBSF/8qQz72LV43RUMr+j7IUX65T27zMR
 hNalv3vNdlhKMyUfhEuep5zPPrWZFoS5aY/vTULbSmneaoDfjo1/rudzgQp1LnhjCtEpmAsP+F
 MU5rBpWm0E4TiwDNHyqAh40NTpZeFYvp1YL++fMx5dT/Il511PbHQ61r9ysexZqSc7eHXnz5f7
 SR4b2sigvWSy0J2hHwZINpc3DwXOJaNAwMfTadRSqTQPjv7e0huoSc/j192t3s24/yePRYtDIN
 gYWsrs9VG80iIAvk981ZPf7qldcPshpQLlBpyLwAk1a3OCmO86jd8LBTHrW7ii80ZFjpnECiYj
 53SHLHf+CM1Q/HXm3ScHSxUnElUXnEu/yOsl0ZtoEQLMRQwkmshsPPKs6vyQXtodptva8ywyVq
 VQil4YI632j/POT+9rnaoTY3/rOtx7h0orVc2djpQx66VOZsJdlwq/SlgkK03XNm2w+iUR1KhQ
 9Z6rlnNrmT9ii3Z5uX9/Q9KEOdT4AIAAA==
X-Change-ID: 20261106-mtk-genio-binman-dtb-c0be6919e9cd
To: Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Michal Simek <michal.simek@amd.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=15217;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=Sk76HndpsBwq5wUgkdweKK/1tavHyf8WXRyT4Z9qemg=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq9ixb67/nJn5HFR8FqqSa+6GwSC2tPMNjh9xwo
 0bT2Beh8SOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavYsWxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AQakIAKIxfez4OwaRdgRgggYrmYCElRnQoJTNp8MlPW/
 WkyZErRnlZn5NrZ5bSJjWY+NOqUUVSImiT0aQnMU9EtlO7x7yt+oLH4qH1b6POx4TpkGaObf8lJ
 dAqtl9iE5a603kyV0MqeGSNgg/B6ueLqs5D7PSEwOOzicoqfnm8bqSFUsQlxTIbG1aTAb9ZyVkf
 DID5rz5sIdf530s2nYmGTaHiGH2hhQ05aemNyxMqBNXG9WA/3Ne188tIDUEuFtB780EE+oSfEGo
 3LH+1HFnIxa5SaKledYC4Jq2apLnhF/91xj8U9JHaywPhWjPldaBFUAjhggBrw5+UP/+Ms0f/xz
 ekVQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Anyone who has worked on hardware that uses a devicetree for the
hardware description should know the mantra "the devicetree describes
the hardware, not the configuration".

Binman is describing configuration and not the hardware itself,
therefore it doesn't belong in the control devicetree that describes
the hardware. So we propose encouraging the separation of these two
descriptions into separate devicetree files. In most cases, binman
info is not needed at runtime anyway, so combining it with the control
devicetree is unnecessary, takes up space, and causes DTS validation
to fail because binman is not part of any standard devicetree schema.

Currently, only Xilinx is doing this kind of separation. This series
makes it possible for more platforms to adopt this separation. The first
patches fix binman so that the image gets the U-Boot control devicetree
rather than the binman one when the two are separate binaries. And they
make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
The remaining patches update the MediaTek Genio targets to make use of
all of this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Casey Connolly (1):
      binman: support building binman dtb when OF_UPSTREAM is enabled

David Lechner (9):
      binman: allow a control devicetree separate from the image description
      Makefile: give binman the control devicetree with BINMAN_DTB
      dts: always build the binman devicetree from BINMAN_DTB
      lib: Kconfig: do not enable BINMAN_FDT by default with BINMAN_DTB
      binman: recommend a separate devicetree for the image description
      arm: dts: mediatek: drop the -u-boot suffix from the Genio binman files
      arm: mediatek: describe the Genio images in a separate binman devicetree
      board: mediatek: add a Genio boot images config fragment
      doc: board: mediatek: use the Genio boot images config fragment

 .gitignore                                         |  1 +
 Makefile                                           | 16 +++---
 arch/arm/dts/mt8188-genio-binman.dts               | 15 ++++++
 arch/arm/dts/mt8189-genio-binman.dts               | 13 +++++
 arch/arm/dts/mt8370-genio-510-evk-u-boot.dtsi      | 10 ----
 arch/arm/dts/mt8370-genio-da-u-boot.dtsi           |  6 ---
 arch/arm/dts/mt8371-genio-520-evk-u-boot.dtsi      |  9 ----
 arch/arm/dts/mt8390-genio-700-evk-u-boot.dtsi      | 10 ----
 arch/arm/dts/mt8391-genio-720-evk-u-boot.dtsi      |  9 ----
 arch/arm/dts/mtk-genio-binman-u-boot.dtsi          | 12 -----
 arch/arm/dts/mtk-genio-binman.dtsi                 | 26 ++++++++++
 ...boot.dtsi => mtk-genio-bootloaders-binman.dtsi} |  2 +
 ...binman-u-boot.dtsi => mtk-genio-da-binman.dtsi} |  2 +-
 ...an-u-boot.dtsi => mtk-genio-da-fit-binman.dtsi} |  2 +
 ...-boot.dtsi => mtk-genio-loader-spl-binman.dtsi} |  2 +
 ...-u-boot.dtsi => mtk-genio-mtk-boot-binman.dtsi} |  3 +-
 arch/arm/mach-mediatek/Kconfig                     |  5 ++
 board/mediatek/MAINTAINERS                         |  7 ++-
 board/mediatek/genio-boot-images.config            |  5 ++
 doc/board/mediatek/mt8188-genio-evk.rst            |  9 ++--
 doc/board/mediatek/mt8189-genio-evk.rst            | 14 ++----
 dts/Makefile                                       | 20 +++++++-
 lib/Kconfig                                        |  9 +++-
 tools/binman/binman.rst                            | 22 ++++++++-
 tools/binman/cmdline.py                            |  3 ++
 tools/binman/control.py                            | 14 ++++--
 tools/binman/etype/fdtmap.py                       |  3 +-
 tools/binman/ftest.py                              | 57 ++++++++++++++++++++--
 tools/binman/state.py                              | 38 ++++++++++++---
 tools/binman/test/fdt/u_boot_dtb_separate.dts      | 13 +++++
 .../test/fdt/u_boot_dtb_separate_expanded.dts      | 13 +++++
 .../binman/test/fdt/u_boot_dtb_separate_fdtmap.dts | 15 ++++++
 32 files changed, 285 insertions(+), 100 deletions(-)
---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git mediatek-staging
change-id: 20261106-mtk-genio-binman-dtb-c0be6919e9cd
prerequisite-message-id: <20261104-ccaione-upstream-spl-fastboot-boot-v2-0-cf9781441ed5@baylibre.com>
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-message-id: <20261022-ccaione-upstream-mt8390-da-v5-0-58982fe11312@baylibre.com>
prerequisite-patch-id: 47bd1028b5d35a3cc00be6cfd2efa94a8fcbf521
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 9f0be27b51978f99dd1d301f4e346e323f057407
prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
prerequisite-change-id: 20261104-bloblist-tl-fixes-4e2617a399c6:v1
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-change-id: 20261103-spl-bloblist-pass-regs-3130cf768211:v2
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-change-id: 20261013-mtk-genio-720-spl-1620416c6224:v2
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-change-id: 20261013-mtk-mt8189-tfa-fdt-94283317c6c0:v2
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
prerequisite-patch-id: 75640c82cbccc2f173feb4bc6c912c9a321a68c9
prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
prerequisite-patch-id: b43d50f060dc034ad413c28153ea641e697e5655
prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
prerequisite-patch-id: 316728f8f3107d7e9e0b45669d947498b77469a3
prerequisite-patch-id: 6c889af47fd9df264bf4dc2758c18418c175dd3b
prerequisite-message-id: <20261019-spl_ufs-v4-0-61432d0b258c@oss.qualcomm.com>
prerequisite-patch-id: 8adf07351c5a4eb61976ceeced2d0ab0eadf235d
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-change-id: 20261013-mtk-genio-720-spl-ufs-4ac6af78de70:v1
prerequisite-patch-id: 79df99b8a797eed3bedbfcbafb7cda7e019f0445
prerequisite-patch-id: bc8ebcd6928771bcb436408a6c10ac4f00b2c265
prerequisite-patch-id: 0f5ccd0db365686315ced7255063d0404cdf5250
prerequisite-patch-id: a435fbd4cca84219d404138e2d8ee1a96d669366
prerequisite-patch-id: 4407c23f51001d4996a8e790270825fd8281d7f5
prerequisite-patch-id: 14bb13c537f635ee2589d626e0031e9a80c348d5
prerequisite-patch-id: 0b59a9f24e103a77700ca1cc99052ba318017b9d
prerequisite-patch-id: fc1dc7d141126db709479fb8477fe11536e6811c
prerequisite-patch-id: 2b22eb0b87c0c9e5c35e0b2719eedb3228503dbf
prerequisite-patch-id: 90108657775725ee881493b1af8e2ae51c8debc9
prerequisite-patch-id: ba3b4599b6ce497f7bf5bcafd2c93c89a0c7f5d4
prerequisite-patch-id: b47cebc4433bc3a0e5c3932a8cd64afea88d32a9
prerequisite-patch-id: a8a6f8e478b4888ff1c6affbcf14f1bb801f6cb9
prerequisite-patch-id: 537ec57f093f5cc68529116aabb6fec1296e9ed5
prerequisite-patch-id: bcd4644665e032714d68c49ad9afb36b25b9f418
prerequisite-patch-id: 1eda3254e8ba4f67886c788467d5cb3e706e51f7
prerequisite-patch-id: 0396e7309b235e7a577aa54549f260d6561d6cc5
prerequisite-patch-id: 3ff8b871bc763b373ac93eb095a0ac362f4fb4f9
prerequisite-patch-id: f3288ee3e395bff11655165a34c9617be55cc52a
prerequisite-patch-id: 893c19a121729050c2095888af67d5cee32c67d1
prerequisite-patch-id: 8c900b341eac7dd1b2f69a434b2fa808ac79e914
prerequisite-patch-id: 180113519aa422aef5b1d6384c8e65a943482cf5
prerequisite-patch-id: a5493d2e60617de14414c25c63d9f77f3fbc7ca9
prerequisite-patch-id: 3b798f71b18533fa36c3864daaf3b60099201097
prerequisite-patch-id: 731b2a85b293eb24b8a9ad5cbd4b2052591ec9d7
prerequisite-patch-id: f44798150ea9c5cf44a43ba0ee5561ed6d522063
prerequisite-patch-id: 01bd0fde93d212bbce964da6cc85f5aace84bddf
prerequisite-patch-id: c5662096f7f5cc7abfd5b178e145fe006737152d
prerequisite-patch-id: 74e53343d8fb0f2e7baee9848b7d81320910ed4a
prerequisite-patch-id: f018d9e03bd324a7853ab106eaaeb770f20bfb1a
prerequisite-patch-id: 95e0ae837a7ba3ca39b2a4b8421ac105234d677a
prerequisite-patch-id: 88e610436d6e9630fac7212c08251727fbe27fc3
prerequisite-patch-id: 0949dcf268f48d1fb7ee912fc57188b73fd4ae58
prerequisite-patch-id: 1474c68c12a790dc0abe513ffa5f71c5d72934eb
prerequisite-patch-id: fdc92399e83ba67d6f157e7e9fec546624226db6
prerequisite-patch-id: bb0f680620dd60fe1f55507198c1daba04d51ca0
prerequisite-patch-id: b60ed43a099f02bf9743f90a7cf474ca844d71d2
prerequisite-patch-id: f18d63e4e8c0ca8f08573f2395dd58b698e1da27
prerequisite-patch-id: ce11ab44a0332ef9682d3f6cb34a5f8648a1c619
prerequisite-patch-id: 3c5e447deebe943a6b8a98c2d017d1c0eab5da25
prerequisite-patch-id: dc6c98cdbffe9b3f19b8a0fc303f9b2902defa07
prerequisite-patch-id: 558d3536869699311008e4d6cce6a2a18a727eca
prerequisite-patch-id: 805a0898b88d8e1291e8262044d1d6bed1d45be2
prerequisite-patch-id: 8d7155ea7c0941b756129b6a490f9413b51b05ef
prerequisite-patch-id: 974eaa9cb6adf9749f6225fe1e67dd9433318625
prerequisite-patch-id: cdb2934ed5393e539f856e6f4de36140cd8ad697
prerequisite-patch-id: ab91736213909c77894d8e47594f548592f96bb4
prerequisite-patch-id: 15e30b35b9a32d98cea92287c95973bb55655b8d
prerequisite-patch-id: 74b01d9723a9eebb7a438ae6f3aa84fecbd86a2f
prerequisite-patch-id: 84ffa226fd432b97e30508988d556056f19488d8
prerequisite-patch-id: b6ef8f19bc0e45642fadc98a2a70a8a77e16cc31
prerequisite-patch-id: 6d301cbbd2d389bb156e2f9565f02c7d1eb9fed1
prerequisite-patch-id: 21aae4cff1307c55e73d737cd68552b6ea1b73f2
prerequisite-patch-id: 110fc69a696fa4dd74fb7e14a50c97e3b7238a9a
prerequisite-patch-id: 2ec906b416c75e44362332459fcd498872a22124
prerequisite-patch-id: aceec0866b3329401896512d235b7e01dc1746b1
prerequisite-patch-id: 41d8b9c212ca0950fb1ccbea92d8f62a3c42676a
prerequisite-patch-id: 94bec74d37c3b2d2b22ffc303d8f2ac567db22c4
prerequisite-patch-id: 4391fbbb5b04123f46d3eb3ec7b183be7152d338
prerequisite-patch-id: 08e009e1d4f6ef7fffaddeb82f9e35692bd593e4
prerequisite-patch-id: 14b40c9224527e76382332cf547d070f1d3a40ed
prerequisite-patch-id: eca0139a7cedf72a4e8a99324a846dea15392e4b
prerequisite-patch-id: cde323ef8d773b7dad5a278faaca89bb71405ab1
prerequisite-patch-id: 6abe9e3824531990933ada4bd58ff483637f3794
prerequisite-patch-id: 4344564d375dc6002077d382335ce759523ffa29
prerequisite-patch-id: 316b1610fc2e3953677ec152eee8cd5035723f82
prerequisite-patch-id: 55680c05d9c25c1a5fbd05e2b9f91a5bb1e4c350
prerequisite-patch-id: 2aa06c6d07b125147e3a6bcdc620e19f9c5885df
prerequisite-patch-id: eb93f71f16b3641ae6a369b1b3113656656f65e3
prerequisite-patch-id: 575d26f405980ef8a1be726c9ca0df679eb77d84
prerequisite-patch-id: 6b9e9c6e1f9cbc0ef3b716cd8615430680354877
prerequisite-patch-id: f109e3e09ffe96d42ba64923f72a2081764a0837
prerequisite-patch-id: 1b7d8c90462884a830b2c4e43bbc7b7d698d7410
prerequisite-patch-id: 8f4cb6976f7c28cf7c2acf3e81ce240e47dcb113
prerequisite-patch-id: 789a3616e548a97eb48ffd62cd59f114bda6d94b
prerequisite-patch-id: 521533b5bb8d1e145d036ea7f9f9e8a7f0856e78
prerequisite-patch-id: 7debdd01277d15f23a983475c7b7bbf05af82175
prerequisite-patch-id: ef70f6dcf4e6aea68256028734614efc067c954d
prerequisite-patch-id: 75640c82cbccc2f173feb4bc6c912c9a321a68c9
prerequisite-patch-id: 569f315372b1b8f55a5a94f1385175252dc33b9f
prerequisite-patch-id: b43d50f060dc034ad413c28153ea641e697e5655
prerequisite-patch-id: f5f6fabf8e9a55c44413a76791d3713fe6415a33
prerequisite-patch-id: f031399df28961dad8315ffa6ad1ee0ff77116ec
prerequisite-patch-id: 8064ba5bd7cf2db6d127f981b3731001c71d58f2
prerequisite-patch-id: 6c889af47fd9df264bf4dc2758c18418c175dd3b
prerequisite-patch-id: 6c44e76abdeb8319ce17dab256fb99ea6a5e77ea
prerequisite-patch-id: 4680066fad4dcbccf016541a4847c7ace62e2e06
prerequisite-patch-id: d7159d0635ba309d374f519b37fc39dfdd15d0eb
prerequisite-patch-id: 070be0db29756ccd90ee239cb9ae5c3b6748cf93
prerequisite-patch-id: 93318a4ddebf24432063549989b91d9ff998bdec
prerequisite-patch-id: 55ead548e0a7c82c4296cc9b9fa047f110c1e306
prerequisite-patch-id: 34bbdb130ae694420b954f41a536b8eb8df77791
prerequisite-patch-id: 5a62f8304a1790b31accf47af84815bffaa92b89
prerequisite-patch-id: d2e87bf5a992d19bde372fb230f4589242f12d40
prerequisite-patch-id: 0429aaac18b3a3d564662f2b93aa3af755c880db
prerequisite-patch-id: a577a9e2266f5b16dd0bf1b8b4312952f736380d
prerequisite-patch-id: 3223b00fa7e9c330054e19f256b4e601008160f2
prerequisite-patch-id: f1cf16250799f803bde22d6dae704cc5338ec76c
prerequisite-patch-id: 781986f407c7f833f3a157bcaa9b6384f964fe11
prerequisite-patch-id: bb9dcec311319f2dbac1c3795ec19fc44dc5bd20
prerequisite-patch-id: d56476ab6a3a7b32a29eea6c811e110a127dfc65
prerequisite-patch-id: 0d9bf4d3f321845f908bc96dcf0b844c14701218
prerequisite-patch-id: 24910c0e34355ac74ac3e0701e24d09e18450b90
prerequisite-patch-id: 640fa47c52c8d79ae409b7077e030cfe8d336287
prerequisite-patch-id: de19c1094bc466beef1d7d648974f925f7cbfb91
prerequisite-patch-id: d98337a0fb6f5db044fc303476f609e4d0a5bc0f

Best regards,
--  
David Lechner <dlechner@baylibre.com>

