Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F57E606A338
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b4HHqoNK;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RvWyroZ0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A0DD406AB;
	Mon, 23 Nov 2026 14:23:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZXBPqR9bMf2K; Mon, 23 Nov 2026 14:23:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9AC37406ED
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443807;
	b=JGKpeMiVTyUnDDiabI5f8jhN70q6jjLtUzHqcFXhMysuQTTy2PzHiC/ow4cP8QyI/T0S
	 8WvhGudH1lRaZYlQwl/6xnVp0OYy3G/EY8i01AP6fCeCdOyiR3Vl+S0YMwR2mujAH1Iah
	 A66NlGWbo9wLpOvl5Tgtt+OwBwmAzyP1zWYGjR3li6QU6Nsq5Y60LjcoTZiPeJnQc0mj5
	 Tix1m3Vj/OZdtM2JtpsdhX/ulcifb+dRF9AUN0SuEIfTTUroMxFPGorb9nM+Wkiksuvhn
	 U1VB+4IAr3lNZW1IaUsJe223S0dXJcZkHv5HkxjC4YHTHlZ5gmvbnuOyufa0TvSLECw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dB2dW2gyTrgsa/HvoAiYGvp5xaKRdhn+iXxKtq7eq38=;
	b=UD+uAunx2aVVAgER5RjctvHwPQaiSBn8a8Rv3zwNjYLWMVkcLsT9m7O4fRQUYM0f8inU
	 tiBCe/BVWgKYAtbM6gTfvg7r9F0czZWrHsfYvAjwTMO4iHJa6KhXfmPLsGIziURAhLQqP
	 l/MYAmtybDMhh5dRTKQZ34N3j+qdL+HOWsUAfaD5DglpGH9xN0RdruxzrvqaeCRcFHDi7
	 I7j//asXZxS9BwFJBSi9n6/6tvD8f1uE9/3PfM6iVl+s/2Nw9+x8uT5/8+XdCEqU3sFlZ
	 VTJ3vWFnrXhuVuoTbWC43ur1gsnAvn5y8LzznJs6/nGZCtSDftoxjW9ifCw3SdIHuzA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RvWyroZ0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443807;
	bh=dB2dW2gyTrgsa/HvoAiYGvp5xaKRdhn+iXxKtq7eq38=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b4HHqoNKtTUN2pcW3v5AVG5R9njT249WEtQGQjUesIH0mckrzltM7cLwQyDh0p+TF
	 sfu6YpU+WFZLTqnvAyfflfHD4HA4IP/JO3579ulg3apFd6MxsKsptJSy4PTojMSMrt
	 Do8mzRCCw/GTRvmay4scSqHZ2WaC9IsUu4onme0r7RN1ai50Ydx89CDfEWWeBsounA
	 tp4qy3gGfsyBrf0JoLIsMKzlG65CYQGdLb6zDIKZ0gVYbtwfBIJtipa+lGodCOZNvb
	 h/DnEZl26DTfgm42ksSG/cmGn2E5TuXMg7ruPOX39R4q3KsXilL/6lRYdBA4aY8dOz
	 tVei9lPd+M5Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AC37406ED;
	Mon, 23 Nov 2026 14:23:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BEBE2260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A52BD406ED
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34XPgB31lyZl for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03773406AB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=RvWyroZ0
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03773406AB
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:23:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 23BA81A179E;
 Mon, 23 Nov 2026 14:23:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id E1219601E1;
 Mon, 23 Nov 2026 14:23:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C42A911E6A524; Mon, 23 Nov 2026 15:23:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443800; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=dB2dW2gyTrgsa/HvoAiYGvp5xaKRdhn+iXxKtq7eq38=;
 b=RvWyroZ0/jMdtfOxUfkSQQJ+9FLOhCu3B/3TBfYEU/q3NokWBjkDDbjQGBfLuYz6hL6lsz
 aUkjYSrt87LXK6M+QExlNZPXx1S2Jnj4O0OwBc9gkH6iFH0iEYmRRuX0PdGkPQhD9Ymzq0
 IyT9AtA7mWU/mjsYX0rbu3vqbrEchN5AjrLavRV0Xd0S4mrBD59lVGcc1vBCAPMyybTpRV
 YmkFn4w6FsUEnOOV21avotOh56uzWaH9rWNr8350DZQxMHweeSEP3kxeLyrh6E/NlGZrBd
 zctSpbIfv6LadyNdS5zYF7q6yoN/5BWHBb9a0wWNAdWMZxnPbPKc3dHGFA+foA==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:07 +0100
Subject: [PATCH v2 8/8] configs: sl2619: enable basic drivers and commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sl2619_base-v2-8-9e3b28c77cda@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
In-Reply-To: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable working drivers for Synaptics sl2619 RDK board:
- system controller
- clock controller
- reset controller
- pin controller
- i2c controller

And commands:
- dm
- clk
- i2c

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 configs/synaptics_sl2619_defconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/configs/synaptics_sl2619_defconfig b/configs/synaptics_sl2619_defconfig
index 63bb1de97c89..97fdd9b41de3 100644
--- a/configs/synaptics_sl2619_defconfig
+++ b/configs/synaptics_sl2619_defconfig
@@ -28,6 +28,9 @@ CONFIG_HUSH_PARSER=y
 # CONFIG_CMD_EXPORTENV is not set
 CONFIG_CMD_NVEDIT_INFO=y
 # CONFIG_CMD_LZMADEC is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADS is not set
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
@@ -41,13 +44,19 @@ CONFIG_VERSION_VARIABLE=y
 # CONFIG_NET is not set
 CONFIG_SYSCON=y
 CONFIG_BOUNCE_BUFFER=y
+CONFIG_CLK=y
+CONFIG_CLK_SL2610=y
 # CONFIG_GPIO is not set
-# CONFIG_I2C is not set
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_DW=y
 CONFIG_MISC=y
 # CONFIG_MMC is not set
+CONFIG_PINCTRL=y
+CONFIG_RESET_SL2610=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SERIAL_RX_BUFFER=y
+CONFIG_SOC_SL2610_SYSCON=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_PSCI=y
 # CONFIG_TOOLS_LIBCRYPTO is not set

-- 
2.55.0

