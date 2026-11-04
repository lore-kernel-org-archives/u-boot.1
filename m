Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E17606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mB6TgFhH;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=AcIEXVGf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D5BC98113B;
	Wed,  4 Nov 2026 08:54:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kq6IN2U9Oecl; Wed,  4 Nov 2026 08:54:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1F32C81127
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782477;
	b=bnTANXFUT6CC1u8jHmtqidNEiAGxCkgiD6+cC7yGRxOLskCWhzIldZ3Zq1TS4irmTJYr
	 BpBI7DXvlcnqzUZGnJJoSlq0l4nKlzMWjp+Jt+6EFFgvcCsn+f2fV4clBzsjEwOBEiADM
	 t6sC3sRR68Z88lBkGLEVESrHfwMOQe8qz8I3MK9Hrmd6MDeE2kFfYTRIO91Hqf+gL8Zrg
	 V6PEMdOyb8imi1T2S9HS5lIC/G+yg7ge0CKnYi6K2Kc1aa28ffdOo/Slt2GSbQb6cYBsL
	 b18K5TB1XtwIW0P9PnYVI+hiadhNXSCVz7BbY0mYxIQ1n+NSpeK3cMjn+HqzaPHsU3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GyWGyCoKSdlqJCOPduMFNdohKCCPOHxqvGNYJO7524M=;
	b=CSJP31W/QSj/6of4XpGrJOcLLNwpoZk0BQuAIMWTK8CaGh52SD85fkUVTqHeU+wL68ao
	 lg/ednevJ1UanNeJJY0nXOoBwJ1xZ5OSo+YmgnEm45833WHIeIwkOmWuzyifcfR0vVAbQ
	 LdE37rhQp49yHJ78gBpY8Y0eOMiaUDqTiRAuTD/zsq+azjV2hLuezIQCp0Kq75jxg8TY2
	 k6xtfMmvAqBCRTHp0ztlNdAHAMkWAMKiMTd6nGYiDMD0TBfL9eG8ZLBofv9FzoBzvQTcr
	 IMBqfStCaHx9Nauz0ARmNxoGibwYy9jM42bSvgjcrqNesklNk0Y9JMIbQ0O48d3n+Mw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782477;
	bh=GyWGyCoKSdlqJCOPduMFNdohKCCPOHxqvGNYJO7524M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mB6TgFhHT5UEFFlGcmSVhqv/DdAFH4CLT3l4Ut4KgJXEy3szDX1cQ+a33n77S4HNv
	 Cetr+oyQhWYK7HksNwjSeoSrl3h5svjcKTdjMTUzRhSBkBw4wTwu3n4JK+VCXxFfJ7
	 ISZszDyY2rpNxTQyj+zvJtEnOLvnZF14wew9vQDMDFp28wJXUciJwvjg1mwpTMViJo
	 3xYh0YLtfGlQGpQG9FVZchA6QuZ/5rF64tXdgqgLrPSDj138CAGOsOa+19fE8D+E0d
	 XXkU6UheJS2e05v+VJvsrypGakTOkbciqj5wVjVE47v+al9GqJ+DpsHE7w4mj2Cw5c
	 awT6UcEF629Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F32C81127;
	Wed,  4 Nov 2026 08:54:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 621B6A10
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4801A402B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zYnTkzjrY7sy for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:54:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 615E04004D
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782474;
 b=VJXxzV+YAf8wy55F9oqJphjvHI1CsxaIS1bNYbO6OuLuNsAzqWzoT4mi84E2mkkqmI+O
 K306ZHID6p2vpRCVtrgZwabHQTW7g4wVOqukA6HPNmTzQFpgzTcIKy+BtXHTQEzz7cGFr
 C/VJRNd/8DzreJkBntPQZRT1/hKyD/xc1L7/VPzOGLCNlYTWgJ9SF4Sam87dqXPFISUmb
 fdjTTHEyf9Xwsr9DhUP1+Z/tmzQp8QIVrfUlszzlsgxxzdAEke1weoXFnmCpi4/f99ZtE
 Vyy9/rjHWx+vpOxkOUT3vIxc6vNeDxTtX18Qe597Hr86grbZFdgWU9QqgpNK50aV8+A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782474;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=GyWGyCoKSdlqJCOPduMFNdohKCCPOHxqvGNYJO7524M=;
 b=m+nrYWyeb5hpqSFo6g65SC+oclJS2RJ8sjc8dMonbzgy1N6rBI8+52RZGzOb7pscXv5l
 nL+2Yg0QsBDPul7Frsj6Ml3p2L5ydVyn7KtPQzlwG5+ZmuaBOsu1kFPPqOSJg3Y6ljuYf
 y+aIIyWTE/5R2FmGZ5ZwJCf5j00PvQ1XT39ELzWlEaEQTbp9nZHQiXmUnuGFZANj0WSTV
 YHVNcMmKy4ta2fkQjVkiU3tijoNtKA9j5F/+YyEJcmPlsjJNRCcrGAXoMbAi8aIWDu9Gc
 tLD3zWzCRQvBIV6MOBp3KCCiYuobzZSKcYjXvLboto+2J2YphPDkx5UGJ0lkPDB1e+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=AcIEXVGf; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=AcIEXVGf
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 615E04004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:54:32 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so3625125e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793782470; x=1794387270;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GyWGyCoKSdlqJCOPduMFNdohKCCPOHxqvGNYJO7524M=;
 b=AcIEXVGfapybz4zxdem9TGw+YMiSyOaedNYZ4NiVGitMKzj6yeMwwuHqATtJ/mpaGL
 AbJ+FaI4oIdXDgL8KMlVKRBBb1EcL9+b17a1Hu6fh6+cyP+8fjWltGjSDFDh4fvAv71z
 GLlmBjXrjaVdo4VTlCQl0D7pO37r4IEWDSniaKk1kV+hqPuZfnkJot+jp+0hyo4m4yH2
 Z4+BVS3inFnJNizog40ULzn8k3A1BEpY6/MB9poxs6r1HrUGq/agfEUUFSUc7oBoJ5PN
 FycGEKbAEx/6iQVl3nAwoWOLTKcr7KMYFPnPupVaZ5eU1+dQbfDEAe0e6M1BRp2n98Sd
 5A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782470; x=1794387270;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GyWGyCoKSdlqJCOPduMFNdohKCCPOHxqvGNYJO7524M=;
 b=t5w3AicRjDIzn0ARnDG0rZFC4bfblwTbbD50mqv3pjjekf6F7Zvmi74GYg9dsUwWPN
 j6ZM/ebZdfmyAAJCpNbj1aCPL+pgtUdsqwT2oJ7ln+mNx28s3ztk+4fbfEUg9khaOHlC
 0HJL1IE4jaIiD+3XKTIwHaOxqhq6vyrm7yUGxS+2oGJW0gaDmSfiiRO3/Zr+b9kfPwi7
 VnSUOjw9AlXNnYNpAc5anuu5ci8zed25GlAFIe7hVyazAyMFigoSY3h+MSfVF/drV7+w
 skz7Wv76/IqMb9BLu5iuQVuViex7mbJx/T3zE+MQ/KPhKACZOt3tS082Mnrkwlctlvtn
 UH5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwl/Ll7lfej5iEIrFpfS55sbrSqCePc5Z8DjB4afoieBlYVeR3Xx6znUB7/SJPxnXAxNgAA+6k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/oylQiWhVWvaERnfAFIvM45GrZ+D24CNGVox/DCViGY0YTR8QL
 VEvh0a7QLxkk9ECjN2v+xOeldC+x6plcyD0ozA5yWPRFJdBssIU0n1pUdkf5UkuklRg=
X-Gm-Gg: AYBFou2QmfhF8JxsS3JODuELCCT4+sLs8pj1El9BIia4ZEsuI1qcNLuqwwiT52fawla
 M6zA4lQfSCNwoU7XQYYwWlDu6hugeEbKBcnGhq2YoS/+4FSqxeam3JsIL0XX7KOKSNYTZcPq4LB
 TiPTz0+M+13hcMQ9n5vEmSRv8Q8YDQ2phVIbuxNdLbstPmIi+noMBFR/yAgl3YgF7PPuxNsZif4
 5zALUcSJ77WD1LsWykEcNOg2l8/HWhQ666FFYPCNvfUl2ykJkxfR5ZZ/X5k+Osu276m2/b2Uhii
 uzJPLQXpJwmXgdgK5aRCyNzQ+pdNTDXB4JU18quYHBmmxwuQ3s29a8Ja6p8ZxWdmdozu37cgrIk
 Mz6Fr9yY8pB8jFmWIf2jxvagC1ySskIppXtoeICIY6l+Njm3b06id0UeRda501MmeNcz4rbtE3b
 3PEGnp5fWAmZUX/45jUrkB43hyepaODFdvNg4nBBDfyIXuvxlq+mzCJVrLeH8toXVuH5CaMnXez
 fpcLYXmMbFEL1WvZ+qYZPly0AqH8yIzZf+REp3g2VeujktnG1eNcWY3MoNCBt5fvHpNlRxMFdz4
 aQh569tExH0mz4mUe8dUW/tF+cJpIKGvl6ZrYYSumSsv1D+tjpHLp84pBE6q+OiD4EdqazHiQb3
 woLJH+IlSOkiC68MIUXH4jtBr+xDm1ByHABNELHvyQIChWq/B1H+O4S8uC0f8/55z+KQ=
X-Received: by 2002:a05:600c:83c5:b0:4a1:78c5:79f5 with SMTP id
 5b1f17b1804b1-4ac1970b976mr301177365e9.33.1793782470239; 
 Wed, 04 Nov 2026 00:54:30 -0800 (PST)
Received: from macbook.homenet.telecomitalia.it
 (host-95-246-144-141.retail.telecomitalia.it. [95.246.144.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b4107b7198sm20656245e9.0.2026.11.04.00.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:54:29 -0800 (PST)
From: Carlo Caione <ccaione@baylibre.com>
Date: Wed, 04 Nov 2026 09:50:32 +0100
Subject: [PATCH v2 4/4] configs: mt8188: enable USB host support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-ccaione-upstream-mtk-g700-usb-v2-4-b8dc65b47373@baylibre.com>
References: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
In-Reply-To: <20261104-ccaione-upstream-mtk-g700-usb-v2-0-b8dc65b47373@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: b4 0.16.0
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

The Genio 510 and 700 EVKs use the same USB host controller, PHY, PMIC
and onboard hub. Enable the required drivers in their shared MT8188
configuration fragment so both boards can use the USB-C PD host port.

Enable the MediaTek xHCI/MTU3 host and T-PHY drivers together with the
PMIC, regulator and onboard-hub support. Enable the USB command and
mass-storage driver to discover and read removable media using the
existing USB stack.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index cd5e68dbca3..8355ce56f90 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -13,16 +13,30 @@ CONFIG_BOOTSTD_FULL=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_CLK=y
+CONFIG_DM_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_MMC_MTK=y
 CONFIG_PHY=y
+CONFIG_PHY_MTK_TPHY=y
 CONFIG_PINCTRL=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_MTK_PWRAP=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_MT6359=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_MTK=y
+CONFIG_USB_MTU3=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_ONBOARD_HUB=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_MEDIATEK_HDMI=y
 # CONFIG_WATCHDOG_AUTOSTART is not set

-- 
2.56.0

